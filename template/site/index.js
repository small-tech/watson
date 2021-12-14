//
// Calculate the current screenshot index based on the scroll position and viewport
// width of the carousel and use it to keep the same screenshot in view if
// the window is resized and also to display the currently-selected index
// in the navigation.
//

let currentScreenshotIndex = null
let transitioning = false

let navigationIndicators = null

function updateNavigationIndicators () {
  let navigationIndicatorIndex = 0
  navigationIndicators.forEach(navigationIndicator => {
    if (navigationIndicatorIndex === currentScreenshotIndex) {
      if (transitioning) {
        navigationIndicator.className = 'transitioning'
      } else {
        navigationIndicator.className = 'selected'
      }
    } else {
      navigationIndicator.className = ''
    }
    navigationIndicatorIndex++
  })
}

function navigationClickHandler (event) {
  const screenshot = document.querySelector(event.target.getAttribute('href'))
  if (!screenshot) return

  // Make sure page doesn’t jump vertically.
  event.preventDefault()
  screenshot.scrollIntoViewIfNeeded()

  navigateToScreenshotAnchor(event.target)
}

function navigateToScreenshotAnchor (screenshotAnchor, transition = true) {
  let requestedIndex

  requestedIndex = Number(screenshotAnchor.toString().replace(/.*?screenshot/, '')) - 1

  if (screenshotAnchor === '') {
    requestedIndex = 0
    transition = false
  }

  if (!transition) {
    transitioning = false
    currentScreenshotIndex = requestedIndex
    updateNavigationIndicators()
    return
  }

  if (requestedIndex !== currentScreenshotIndex) {
    transitioning = true
    currentScreenshotIndex = requestedIndex
    updateNavigationIndicators()
  }
}

window.addEventListener('resize', () => {
  // Update the scroll position so the same Screenshot stays perfectly
  // positioned within the carousel.
  const viewport = document.getElementById('viewport')
  viewport.scrollLeft = viewport.offsetWidth * currentScreenshotIndex
})

window.addEventListener('load', () => {

  // Save references to the navigation indicators.
  navigationIndicators = document.querySelectorAll('nav ol li a')

  // Set the initial Screenshot based on the URL
  navigateToScreenshotAnchor(window.location.hash, /* transition */ false)

  // When a navigation indicator is clicked, we augment the default behaviour
  // by updating the indicators to display the requested position with a dimmed
  // indicator. When the transition is complete, our scroll event will pick it
  // up and brighten the indicator.
  navigationIndicators.forEach(navigationIndicator => {
    navigationIndicator.addEventListener('click', navigationClickHandler)
  })

  // Also add the navigation indicator triggers to the arrow buttons.
  const previousButtons = document.querySelectorAll('.screenshot .controls .previous')
  const nextButtons = document.querySelectorAll('.screenshot .controls .next')

  previousButtons.forEach(previousButton => {
    previousButton.addEventListener('click', navigationClickHandler)
  })

  nextButtons.forEach(nextButton => {
    nextButton.addEventListener('click', navigationClickHandler)
  })

  document.getElementById('viewport').addEventListener('scroll', event => {
    const currentViewportWidth = event.target.offsetWidth
    const currentViewportScrollPosition = event.target.scrollLeft

    if (currentViewportScrollPosition % currentViewportWidth === 0) {
      currentScreenshotIndex = currentViewportScrollPosition / currentViewportWidth
      transitioning = false
      updateNavigationIndicators()
    }
  })
})

// Polyfill for the non-standard yet actually useful scrollIntoViewIfNeeded method.
// (https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollIntoViewIfNeeded)
// Courtesy: https://gist.github.com/hsablonniere/2581101
if (!Element.prototype.scrollIntoViewIfNeeded) {
  Element.prototype.scrollIntoViewIfNeeded = function (centerIfNeeded) {
    centerIfNeeded = arguments.length === 0 ? true : !!centerIfNeeded;

    var parent = this.parentNode,
        parentComputedStyle = window.getComputedStyle(parent, null),
        parentBorderTopWidth = parseInt(parentComputedStyle.getPropertyValue('border-top-width')),
        parentBorderLeftWidth = parseInt(parentComputedStyle.getPropertyValue('border-left-width')),
        overTop = this.offsetTop - parent.offsetTop < parent.scrollTop,
        overBottom = (this.offsetTop - parent.offsetTop + this.clientHeight - parentBorderTopWidth) > (parent.scrollTop + parent.clientHeight),
        overLeft = this.offsetLeft - parent.offsetLeft < parent.scrollLeft,
        overRight = (this.offsetLeft - parent.offsetLeft + this.clientWidth - parentBorderLeftWidth) > (parent.scrollLeft + parent.clientWidth),
        alignWithTop = overTop && !overBottom;

    if ((overTop || overBottom) && centerIfNeeded) {
      parent.scrollTop = this.offsetTop - parent.offsetTop - parent.clientHeight / 2 - parentBorderTopWidth + this.clientHeight / 2;
    }

    if ((overLeft || overRight) && centerIfNeeded) {
      parent.scrollLeft = this.offsetLeft - parent.offsetLeft - parent.clientWidth / 2 - parentBorderLeftWidth + this.clientWidth / 2;
    }

    if ((overTop || overBottom || overLeft || overRight) && !centerIfNeeded) {
      this.scrollIntoView(alignWithTop);
    }
  };
}

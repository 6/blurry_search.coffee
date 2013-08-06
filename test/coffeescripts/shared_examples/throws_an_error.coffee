@sharedBehaviorForThrowsAnError = (go, match) =>
  it "throws an error", =>
    errorThrown = false
    errorMessage = null
    try
      go()
    catch e
      errorThrown = true
      errorMessage = e.message
    expect(errorThrown).toBe(true)
    if match?
      expect(errorMessage).toMatch(match)

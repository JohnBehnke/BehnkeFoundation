//
//  FootlineOriginTests.swift
//
//
//  Created by John Behnke on 8/27/26.
//

import Testing
@testable import BehnkeFoundation

struct FootlineOriginTests {
    @Test func human() {
        let display = Footline.Origin.human.display
        #expect(display.headline == "Made by hand")
        #expect(display.connector == "with")
        #expect(display.subline == nil)
        #expect(display.inlineAgents == nil)
        #expect(display.defaultSymbolName == "heart.fill")
    }

    @Test func assistedWithNoAgents() {
        let display = Footline.Origin.assisted(agents: []).display
        #expect(display.headline == "Made mostly by hand")
        #expect(display.connector == "with")
        #expect(display.subline == nil)
        #expect(display.inlineAgents == nil)
        #expect(display.defaultSymbolName == "heart.fill")
    }

    @Test func assistedWithOneAgent() {
        let display = Footline.Origin.assisted(agents: [.claude]).display
        #expect(display.subline == "Assisted by Claude")
        #expect(display.inlineAgents == nil)
    }

    @Test func assistedWithTwoAgents() {
        let display = Footline.Origin.assisted(agents: [.claude, .codex]).display
        #expect(display.subline == "Assisted by Claude & Codex")
    }

    @Test func assistedWithThreeOrMoreAgents() {
        let display = Footline.Origin.assisted(agents: [.claude, .codex, .gemini]).display
        #expect(display.subline == "Assisted by Claude, Codex & Gemini")
    }

    @Test func agentWithNoAgents() {
        let display = Footline.Origin.agent(agents: []).display
        #expect(display.headline == "Vibe coded")
        #expect(display.connector == "by")
        #expect(display.subline == nil)
        #expect(display.inlineAgents == nil)
        #expect(display.defaultSymbolName == nil)
    }

    @Test func agentWithOneAgent() {
        let display = Footline.Origin.agent(agents: [.claude]).display
        #expect(display.inlineAgents == "Claude")
        #expect(display.subline == nil)
    }

    @Test func agentWithTwoAgents() {
        let display = Footline.Origin.agent(agents: [.claude, .codex]).display
        #expect(display.inlineAgents == "Claude & Codex")
    }

    @Test func agentWithFourAgents() {
        let display = Footline.Origin.agent(agents: [.claude, .codex, .copilot, .gemini]).display
        #expect(display.inlineAgents == "Claude, Codex, Copilot & Gemini")
    }

    @Test func customAgent() {
        let agent = Footline.Agent(name: "Llama")
        #expect(agent.name == "Llama")

        let display = Footline.Origin.assisted(agents: [.claude, agent]).display
        #expect(display.subline == "Assisted by Claude & Llama")
    }

    @Test func connectorLineWithNoAgents() {
        #expect(Footline.Origin.human.display.connectorLine == "with")
        #expect(Footline.Origin.agent(agents: []).display.connectorLine == "by")
    }

    @Test func connectorLineWithAgents() {
        let display = Footline.Origin.agent(agents: [.claude, .codex]).display
        #expect(display.connectorLine == "by Claude & Codex")
    }
}

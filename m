From: Mikhail Gavrilov <mikhail.v.gavrilov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: LLVM 7.0 and MESA 17.4 + Wayland = broken mouse control
Date: Wed, 24 Jan 2018 15:46:16 +0500
Message-ID: <CABXGCsM9BwSyjbW2Lgim58Q5PcWysAp8CpeKH4AGsCkHorwCvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

SGkuCkFueWJvZHkgYWxyZWFkeSB0cnlpZWQgTExWTSA3IGFuZCBXYXlsYW5kPz8/CkFmdGVyIExM
Vk0gaXMgdXBkYXRlZCBpbiByZXBvCmh0dHBzOi8vY29wci5mZWRvcmFpbmZyYWNsb3VkLm9yZy9j
b3Bycy9jaGUvbWVzYS8gdG8gNy4wLjAtMC4xLnIzMjIxMzIKbW91c2UgaG92ZXIgYXJlIHN0b3Ag
d29ya2luZyBvbiBhbGwgY29udHJvbHMuIEl0IG1lYW5zIEkgdW5hYmxlCmxhdW5jaCBhcHBsaWNh
dGlvbiBieSBjbGlja2luZyBvbiBhcHBsaWNhdGlvbiBpY29uIGFsc28gSSB1bm5hYmxlIGRyYWcK
YW5kIHJlc2l6ZSB3aW5kb3dzLiBBbmQgYWxsIGNvbnRyb2xzIGFyZSB1bmNsaWNrYWJsZS4gQnV0
IGtleWJvYXJkCndvcmtzIGZpbmUuCgpUaGlzIHByb2JsZW0gb25seSBoYXBwZW5zIHdpdGggQU1E
IEdQVS4gSW50ZWwgR1BVIG5vdCBhZmZlY3RlZCBieSB0aGlzIGJ1Zy4KClRoaXMgc291bmRzIGxp
a2UgdGhlIGtub3duIGdub21lLXNoZWxsL211dHRlciBidWdzIHJlbGF0ZWQgdG8gMTAgYml0cwpw
ZXIgY29tcG9uZW50IGNvbG91ciBmb3JtYXRzLiBJLmUuIGl0J3MgcHJvYmFibHkgbm90IGRpcmVj
dGx5IHJlbGF0ZWQKdG8gTExWTSBidXQgdG8gY2hhbmdlcyBpbiBob3cgTWVzYSBleHBvc2VzIHN1
Y2ggZm9ybWF0cyB0bwphcHBsaWNhdGlvbnMuCgotLQpCZXN0IFJlZ2FyZHMsCk1pa2UgR2F2cmls
b3YuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=

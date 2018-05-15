From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 49/57] drm/amdgpu/vg20:Add IH client ID for the 2nd UVD
Date: Tue, 15 May 2018 09:59:25 -0500
Message-ID: <20180515145933.12063-50-alexander.deucher@amd.com>
References: <20180515145933.12063-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180515145933.12063-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, James Zhu <James.Zhu-5C7GfCeVMHo@public.gmane.org>

RnJvbTogSmFtZXMgWmh1IDxKYW1lcy5aaHVAYW1kLmNvbT4KCkZvciBWZWdhMjAsIHRoZXJlIGFy
ZSB0d28gVVZEIGhhcmR3YXJlLiBOZWVkIGFkZAp0aGUgMm5kIElIIGNsaWVudCBJRCBmb3IgdGhl
IDJuZCBVVkQgSGFyZHdhcmUuCgpTaWduZWQtb2ZmLWJ5OiBKYW1lcyBaaHUgPEphbWVzLlpodUBh
bWQuY29tPgpSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQu
Y29tPgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL3NvYzE1X2loX2NsaWVudGlkLmgg
fCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9zb2MxNV9paF9jbGllbnRpZC5oIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9pbmNsdWRlL3NvYzE1X2loX2NsaWVudGlkLmgKaW5kZXggYTEyZDRmMjdjZmE0Li4x
MmUxOTZjMTViYmUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9zb2Mx
NV9paF9jbGllbnRpZC5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9zb2MxNV9p
aF9jbGllbnRpZC5oCkBAIC00Myw2ICs0Myw3IEBAIGVudW0gc29jMTVfaWhfY2xpZW50aWQgewog
CVNPQzE1X0lIX0NMSUVOVElEX1NFMlNICQk9IDB4MGMsCiAJU09DMTVfSUhfQ0xJRU5USURfU0Uz
U0gJCT0gMHgwZCwKIAlTT0MxNV9JSF9DTElFTlRJRF9TWVNIVUIJPSAweDBlLAorCVNPQzE1X0lI
X0NMSUVOVElEX1VWRDEJCT0gMHgwZSwKIAlTT0MxNV9JSF9DTElFTlRJRF9USE0JCT0gMHgwZiwK
IAlTT0MxNV9JSF9DTElFTlRJRF9VVkQJCT0gMHgxMCwKIAlTT0MxNV9JSF9DTElFTlRJRF9WQ0Uw
CQk9IDB4MTEsCi0tIAoyLjEzLjYKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=

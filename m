From: Chen Gong <Curry-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: disable page queue on SDMA for Vega12
Date: Tue, 30 Oct 2018 15:37:21 +0800
Message-ID: <1540885041-14731-1-git-send-email-Curry@amd.com>
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
Cc: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, Curry.Gong-5C7GfCeVMHo@public.gmane.org

RnJvbTogSnVud2VpIFpoYW5nIDxKZXJyeS5aaGFuZ0BhbWQuY29tPgoKSXQgYmxvY2tzIG1vc3Qg
b2Ygc2FuaXR5IHRlc3RzLCBzbyBkaXNhYmxlIGl0IGZvciBub3cuCgpUZXN0ZWQtYnk6IENoZW4g
R29uZyA8Q3VycnkuR29uZ0BhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBKdW53ZWkgWmhhbmcgPEpl
cnJ5LlpoYW5nQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92
NF8wLmMgfCAzICsrLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjRfMC5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NF8wLmMKaW5kZXggODhkOTM0My4u
MzE0M2FlOCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NF8w
LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NF8wLmMKQEAgLTE0NzQs
NyArMTQ3NCw4IEBAIHN0YXRpYyBpbnQgc2RtYV92NF8wX2Vhcmx5X2luaXQodm9pZCAqaGFuZGxl
KQogCQlhZGV2LT5zZG1hLmhhc19wYWdlX3F1ZXVlID0gZmFsc2U7CiAJfSBlbHNlIHsKIAkJYWRl
di0+c2RtYS5udW1faW5zdGFuY2VzID0gMjsKLQkJaWYgKGFkZXYtPmFzaWNfdHlwZSAhPSBDSElQ
X1ZFR0EyMCkKKwkJaWYgKGFkZXYtPmFzaWNfdHlwZSAhPSBDSElQX1ZFR0EyMCAmJgorCQkJCWFk
ZXYtPmFzaWNfdHlwZSAhPSBDSElQX1ZFR0ExMikKIAkJCWFkZXYtPnNkbWEuaGFzX3BhZ2VfcXVl
dWUgPSB0cnVlOwogCX0KIAotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=

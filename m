From: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/3] drm/amdgpu: fix harvest config checking in vce3
 check_soft_reset
Date: Wed, 3 Aug 2016 15:51:27 +0800
Message-ID: <1470210689-14022-2-git-send-email-David1.Zhou@amd.com>
References: <1470210689-14022-1-git-send-email-David1.Zhou@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1470210689-14022-1-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
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
Cc: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJODNhMWNkOGIxOWNiZmZjMDljNGU5YjY3OWI4OGNkNjUxNDc0NDZkNQpTaWdu
ZWQtb2ZmLWJ5OiBDaHVubWluZyBaaG91IDxEYXZpZDEuWmhvdUBhbWQuY29tPgotLS0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZjZV92M18wLmMgfCAzIC0tLQogMSBmaWxlIGNoYW5nZWQs
IDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
dmNlX3YzXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZjZV92M18wLmMKaW5kZXgg
MWMxZjFhMS4uODhjYTRkZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
dmNlX3YzXzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y2VfdjNfMC5jCkBA
IC02NDgsOSArNjQ4LDYgQEAgc3RhdGljIGludCB2Y2VfdjNfMF9jaGVja19zb2Z0X3Jlc2V0KHZv
aWQgKmhhbmRsZSkKIAl0bXAgPSBSRUdfU0VUX0ZJRUxEKHRtcCwgR1JCTV9HRlhfSU5ERVgsIElO
U1RBTkNFX0lOREVYLCAwKTsKIAlXUkVHMzIobW1HUkJNX0dGWF9JTkRFWCwgdG1wKTsKIAotCWlm
IChhZGV2LT52Y2UuaGFydmVzdF9jb25maWcgJiAoQU1ER1BVX1ZDRV9IQVJWRVNUX1ZDRTAgfCBB
TURHUFVfVkNFX0hBUlZFU1RfVkNFMSkpCi0JCXNyYm1fc29mdF9yZXNldCA9IDA7Ci0KIAlpZiAo
c3JibV9zb2Z0X3Jlc2V0KSB7CiAJCWFkZXYtPmlwX2Jsb2NrX3N0YXR1c1tBTURfSVBfQkxPQ0tf
VFlQRV9WQ0VdLmhhbmcgPSB0cnVlOwogCQlhZGV2LT52Y2Uuc3JibV9zb2Z0X3Jlc2V0ID0gc3Ji
bV9zb2Z0X3Jlc2V0OwotLSAKMS45LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=

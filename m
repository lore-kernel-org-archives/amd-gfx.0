From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/3] drm/amdgpu: delete reduant kiq irq funcs type check in
 gfx8.
Date: Tue, 18 Apr 2017 15:02:08 +0800
Message-ID: <1492498929-19160-2-git-send-email-Rex.Zhu@amd.com>
References: <1492498929-19160-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1492498929-19160-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJYWIzNjJhZDE5NmEzZDUxNWU1YWM4ZDlhN2M5MjViMDc1MmM5NjgzMApTaWdu
ZWQtb2ZmLWJ5OiBSZXggWmh1IDxSZXguWmh1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYyB8IDQgLS0tLQogMSBmaWxlIGNoYW5nZWQsIDQgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAu
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMKaW5kZXggNTM0ODcxMC4u
NTYzOTQ0YSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAu
YworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jCkBAIC02ODI3LDgg
KzY4MjcsNiBAQCBzdGF0aWMgaW50IGdmeF92OF8wX2tpcV9zZXRfaW50ZXJydXB0X3N0YXRlKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogewogCXN0cnVjdCBhbWRncHVfcmluZyAqcmluZyA9
ICYoYWRldi0+Z2Z4LmtpcS5yaW5nKTsKIAotCUJVR19PTihyaW5nLT5mdW5jcy0+dHlwZSAhPSBB
TURHUFVfUklOR19UWVBFX0tJUSk7Ci0KIAlzd2l0Y2ggKHR5cGUpIHsKIAljYXNlIEFNREdQVV9D
UF9LSVFfSVJRX0RSSVZFUjA6CiAJCVdSRUczMl9GSUVMRChDUENfSU5UX0NOVEwsIEdFTkVSSUMy
X0lOVF9FTkFCTEUsCkBAIC02ODU4LDggKzY4NTYsNiBAQCBzdGF0aWMgaW50IGdmeF92OF8wX2tp
cV9pcnEoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJdTggbWVfaWQsIHBpcGVfaWQsIHF1
ZXVlX2lkOwogCXN0cnVjdCBhbWRncHVfcmluZyAqcmluZyA9ICYoYWRldi0+Z2Z4LmtpcS5yaW5n
KTsKIAotCUJVR19PTihyaW5nLT5mdW5jcy0+dHlwZSAhPSBBTURHUFVfUklOR19UWVBFX0tJUSk7
Ci0KIAltZV9pZCA9IChlbnRyeS0+cmluZ19pZCAmIDB4MGMpID4+IDI7CiAJcGlwZV9pZCA9IChl
bnRyeS0+cmluZ19pZCAmIDB4MDMpID4+IDA7CiAJcXVldWVfaWQgPSAoZW50cnktPnJpbmdfaWQg
JiAweDcwKSA+PiA0OwotLSAKMS45LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=

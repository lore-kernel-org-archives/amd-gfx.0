From: Jim Qu <Jim.Qu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amd/amdgpu: fix si_enable_smc_cac() failed issue
Date: Wed, 12 Jul 2017 15:55:20 +0800
Message-ID: <1499846120-5412-1-git-send-email-Jim.Qu@amd.com>
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
Cc: Jim Qu <Jim.Qu-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJMDQ3MzBlNzk0N2JhYzQ3NGVlODAzYzRlOWJiMjEyMTM4M2I5NDgyZgpTaWdu
ZWQtb2ZmLWJ5OiBKaW0gUXUgPEppbS5RdUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3NpX2RwbS5jIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaV9kcG0uYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NpX2RwbS5jCmluZGV4IDdjMWM1ZDEuLjRiMzc0MmQgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NpX2RwbS5jCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NpX2RwbS5jCkBAIC0yMDU1LDYgKzIwNTUsNyBAQCBzdGF0
aWMgdm9pZCBzaV9pbml0aWFsaXplX3Bvd2VydHVuZV9kZWZhdWx0cyhzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldikKIAkJY2FzZSAweDY4MkM6CiAJCQlzaV9waS0+Y2FjX3dlaWdodHMgPSBjYWNf
d2VpZ2h0c19jYXBlX3ZlcmRlX3BybzsKIAkJCXNpX3BpLT5kdGVfZGF0YSA9IGR0ZV9kYXRhX3N1
bl94dDsKKwkJCXVwZGF0ZV9kdGVfZnJvbV9wbDIgPSB0cnVlOwogCQkJYnJlYWs7CiAJCWNhc2Ug
MHg2ODI1OgogCQljYXNlIDB4NjgyNzoKLS0gCjEuOS4xCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK

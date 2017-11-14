From: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 01/10] drm/amdgpu:cleanup stolen vga memory finish
Date: Tue, 14 Nov 2017 17:07:39 +0800
Message-ID: <1510650468-5708-2-git-send-email-Monk.Liu@amd.com>
References: <1510650468-5708-1-git-send-email-Monk.Liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1510650468-5708-1-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJZDY0MWUxMjVmM2RhZmM1NDIyM2U0OWVlNDQ0YWI2NDI0OWU3ZTNhMQpTaWdu
ZWQtb2ZmLWJ5OiBNb25rIExpdSA8TW9uay5MaXVAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgfCAxMSArKystLS0tLS0tLQogMSBmaWxlIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdHRtLmMKaW5kZXggOTllODEyZC4uY2YyMWIzOCAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwpAQCAtMTY0MCwxNCArMTY0MCw5IEBAIHZvaWQgYW1k
Z3B1X3R0bV9maW5pKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCQlyZXR1cm47CiAJYW1k
Z3B1X3R0bV9kZWJ1Z2ZzX2ZpbmkoYWRldik7CiAKLQlpZiAoYWRldi0+c3RvbGVuX3ZnYV9tZW1v
cnkpIHsKLQkJciA9IGFtZGdwdV9ib19yZXNlcnZlKGFkZXYtPnN0b2xlbl92Z2FfbWVtb3J5LCB0
cnVlKTsKLQkJaWYgKHIgPT0gMCkgewotCQkJYW1kZ3B1X2JvX3VucGluKGFkZXYtPnN0b2xlbl92
Z2FfbWVtb3J5KTsKLQkJCWFtZGdwdV9ib191bnJlc2VydmUoYWRldi0+c3RvbGVuX3ZnYV9tZW1v
cnkpOwotCQl9Ci0JCWFtZGdwdV9ib191bnJlZigmYWRldi0+c3RvbGVuX3ZnYV9tZW1vcnkpOwot
CX0KKwlpZiAoYWRldi0+c3RvbGVuX3ZnYV9tZW1vcnkpCisJCWFtZGdwdV9ib19mcmVlX2tlcm5l
bCgmYWRldi0+c3RvbGVuX3ZnYV9tZW1vcnksIE5VTEwsIE5VTEwpOworCiAJYW1kZ3B1X3NzZ19m
aW5pKGFkZXYpOwogCWFtZGdwdV9kaXJlY3RfZ21hX2ZpbmkoYWRldik7CiAKLS0gCjIuNy40Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK

From: Trigger Huang <Trigger.Huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: fix pm_load_smu_firmware for SR-IOV
Date: Tue, 11 Jun 2019 12:08:30 +0800
Message-ID: <1560226110-10201-1-git-send-email-Trigger.Huang@amd.com>
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
Cc: Prike.Liang-5C7GfCeVMHo@public.gmane.org, Trigger.Huang-5C7GfCeVMHo@public.gmane.org

Rm9yIFNSLUlPViBWRiwgcG93ZXJwbGF5IG1heSBub3QgYmUgc3VwcG9ydGVkLCBpbiB0aGlzIGNh
c2UsCmVycm9yICctRUlOVkFMJyBzaG91bGQgbm90IGJlIHJldHVybmVkLgoKU2lnbmVkLW9mZi1i
eTogVHJpZ2dlciBIdWFuZyA8VHJpZ2dlci5IdWFuZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wbS5jIHwgMyArKysKIDEgZmlsZSBjaGFuZ2VkLCAzIGlu
c2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfcG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wbS5jCmluZGV4IDIx
YjViZTEuLjQyNzZkNjMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9wbS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wbS5jCkBA
IC0yNzA5LDcgKzI3MDksMTAgQEAgaW50IGFtZGdwdV9wbV9sb2FkX3NtdV9maXJtd2FyZShzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdWludDMyX3QgKnNtdV92ZXJzaW8KIAkJCXJldHVybiBy
OwogCQl9CiAJCSpzbXVfdmVyc2lvbiA9IGFkZXYtPnBtLmZ3X3ZlcnNpb247CisJfSBlbHNlIGlm
IChhbWRncHVfc3Jpb3ZfdmYoYWRldikpIHsKKwkJciA9IDA7CiAJfQorCiAJcmV0dXJuIHI7CiB9
CiAKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=

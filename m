From: Jack Zhang <Jack.Zhang1-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu/sriov: fix Tonga load driver failed
Date: Thu, 20 Jun 2019 14:04:48 +0800
Message-ID: <1561010688-5943-1-git-send-email-Jack.Zhang1@amd.com>
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
Cc: Jack Zhang <Jack.Zhang1-5C7GfCeVMHo@public.gmane.org>

VG9uZ2Egc3Jpb3YgbmVlZCB0byB1c2Ugc211IHRvIGxvYWQgZmlybXdhcmUuClJlbW92ZSBzcmlv
diBmbGFnIGJlY2F1c2UgdGhlIGRlZmF1bHQgcmV0dXJuIHZhbHVlIGlzIHplcm8uCgpTaWduZWQt
b2ZmLWJ5OiBKYWNrIFpoYW5nIDxKYWNrLlpoYW5nMUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wbS5jIHwgMiAtLQogMSBmaWxlIGNoYW5nZWQsIDIgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3BtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcG0uYwppbmRleCAwOTNj
ZWZkLi40NjljZGE5IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfcG0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcG0uYwpAQCAt
Mjc1NSw4ICsyNzU1LDYgQEAgaW50IGFtZGdwdV9wbV9sb2FkX3NtdV9maXJtd2FyZShzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiwgdWludDMyX3QgKnNtdV92ZXJzaW8KIHsKIAlpbnQgcjsKIAot
CWlmIChhbWRncHVfc3Jpb3ZfdmYoYWRldikpCi0JCXJldHVybiAwOwogCiAJaWYgKGFkZXYtPnBv
d2VycGxheS5wcF9mdW5jcyAmJiBhZGV2LT5wb3dlcnBsYXkucHBfZnVuY3MtPmxvYWRfZmlybXdh
cmUpIHsKIAkJciA9IGFkZXYtPnBvd2VycGxheS5wcF9mdW5jcy0+bG9hZF9maXJtd2FyZShhZGV2
LT5wb3dlcnBsYXkucHBfaGFuZGxlKTsKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZng=

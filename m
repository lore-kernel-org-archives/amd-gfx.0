From: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH libdrm] amdgpu: add error return value for finding bo by cpu
 mapping
Date: Thu, 30 Aug 2018 16:50:03 +0800
Message-ID: <1535619003-18067-1-git-send-email-Jerry.Zhang@amd.com>
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
Cc: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, christian.koenig-5C7GfCeVMHo@public.gmane.org

SWYgbm90aGluZyBpcyBmb3VuZCwgZXJyb3Igc2hvdWxkIGJlIHJldHVybmVkLgoKU2lnbmVkLW9m
Zi1ieTogSnVud2VpIFpoYW5nIDxKZXJyeS5aaGFuZ0BhbWQuY29tPgotLS0KIGFtZGdwdS9hbWRn
cHVfYm8uYyB8IDQgKysrLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQoKZGlmZiAtLWdpdCBhL2FtZGdwdS9hbWRncHVfYm8uYyBiL2FtZGdwdS9hbWRncHVf
Ym8uYwppbmRleCAyZjRmOTBmLi4zODEyYzVlIDEwMDY0NAotLS0gYS9hbWRncHUvYW1kZ3B1X2Jv
LmMKKysrIGIvYW1kZ3B1L2FtZGdwdV9iby5jCkBAIC01NTAsNiArNTUwLDcgQEAgaW50IGFtZGdw
dV9maW5kX2JvX2J5X2NwdV9tYXBwaW5nKGFtZGdwdV9kZXZpY2VfaGFuZGxlIGRldiwKIAkJCQkg
IHVpbnQ2NF90ICpvZmZzZXRfaW5fYm8pCiB7CiAJdWludDMyX3QgaTsKKwlpbnQgciA9IDA7CiAJ
c3RydWN0IGFtZGdwdV9ibyAqYm87CiAKIAlpZiAoY3B1ID09IE5VTEwgfHwgc2l6ZSA9PSAwKQpA
QCAtNTc3LDEwICs1NzgsMTEgQEAgaW50IGFtZGdwdV9maW5kX2JvX2J5X2NwdV9tYXBwaW5nKGFt
ZGdwdV9kZXZpY2VfaGFuZGxlIGRldiwKIAl9IGVsc2UgewogCQkqYnVmX2hhbmRsZSA9IE5VTEw7
CiAJCSpvZmZzZXRfaW5fYm8gPSAwOworCQlyID0gLUVJTlZBTDsKIAl9CiAJcHRocmVhZF9tdXRl
eF91bmxvY2soJmRldi0+Ym9fdGFibGVfbXV0ZXgpOwogCi0JcmV0dXJuIDA7CisJcmV0dXJuIHI7
CiB9CiAKIGludCBhbWRncHVfY3JlYXRlX2JvX2Zyb21fdXNlcl9tZW0oYW1kZ3B1X2RldmljZV9o
YW5kbGUgZGV2LAotLSAKMS45LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=

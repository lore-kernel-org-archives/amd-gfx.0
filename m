From: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] drm/amd/amdgpu: Fix memleak in cz_parse_power_table()
Date: Thu, 25 Aug 2016 13:12:38 -0400
Message-ID: <20160825171238.7390-1-tom.stdenis@amd.com>
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
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>

SWYgb25lIG9mIHRoZSBlbnRyaWVzIGZhaWxzIHRvIGJlIGFsbG9jYXRlZCB0aGVuIGZyZWUKYWxs
IG9mIHRoZSBwcmV2aW91cyBlbnRyaWVzIGJlZm9yZSBmcmVlaW5nIHRoZSBhcnJheSB3aGljaApo
b2xkcyB0aGVpciBwb2ludGVycy4KClNpZ25lZC1vZmYtYnk6IFRvbSBTdCBEZW5pcyA8dG9tLnN0
ZGVuaXNAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9jel9kcG0uYyB8
IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9jel9kcG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2N6X2RwbS5jCmluZGV4IDc5NGM1ZjM2Y2E2OC4uOWMyYWI3M2E3YWUzIDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9jel9kcG0uYworKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9jel9kcG0uYwpAQCAtMzUwLDYgKzM1MCw4IEBAIHN0YXRpYyBpbnQgY3pf
cGFyc2VfcG93ZXJfdGFibGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAKIAkJcHMgPSBr
emFsbG9jKHNpemVvZihzdHJ1Y3QgY3pfcHMpLCBHRlBfS0VSTkVMKTsKIAkJaWYgKHBzID09IE5V
TEwpIHsKKwkJCWZvciAoaiA9IDA7IGogPCBpOyBqKyspCisJCQkJa2ZyZWUoYWRldi0+cG0uZHBt
LnBzW2pdLnBzX3ByaXYpOwogCQkJa2ZyZWUoYWRldi0+cG0uZHBtLnBzKTsKIAkJCXJldHVybiAt
RU5PTUVNOwogCQl9Ci0tIAoyLjkuMgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==

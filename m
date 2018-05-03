From: <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH xf86-video-amdgpu 12/13] Update color properties on modeset
 major
Date: Thu, 3 May 2018 14:31:54 -0400
Message-ID: <1525372315-28462-13-git-send-email-sunpeng.li@amd.com>
References: <1525372315-28462-1-git-send-email-sunpeng.li@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1525372315-28462-1-git-send-email-sunpeng.li-5C7GfCeVMHo@public.gmane.org>
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
Cc: "Leo (Sunpeng) Li" <sunpeng.li-5C7GfCeVMHo@public.gmane.org>, michel-otUistvHUpPR7s880joybQ@public.gmane.org, harry.wentland-5C7GfCeVMHo@public.gmane.org

RnJvbTogIkxlbyAoU3VucGVuZykgTGkiIDxzdW5wZW5nLmxpQGFtZC5jb20+CgpUaGlzIGlzIG5l
ZWRlZCBmb3IgY2FzZXMgc3VjaCBhcyBlbmFibGluZyBhIENSVEMgb24gYW4gb3V0cHV0IHRoYXQg
ZGlkCm5vdCBwcmV2aW91c2x5IGhhdmUgYSBDUlRDIGF0dGFjaGVkLiBEb2luZyBzbyB3aWxsIHVw
ZGF0ZSB0aGUgb3V0cHV0CnByb3BlcnRpZXMgbGlzdGVkIHdpdGggdGhlIGNvcnJlY3QgY29sb3Ig
cHJvcGVydGllcy4KClNpZ25lZC1vZmYtYnk6IExlbyAoU3VucGVuZykgTGkgPHN1bnBlbmcubGlA
YW1kLmNvbT4KLS0tCiBzcmMvZHJtbW9kZV9kaXNwbGF5LmMgfCAyICsrCiAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvc3JjL2RybW1vZGVfZGlzcGxheS5jIGIv
c3JjL2RybW1vZGVfZGlzcGxheS5jCmluZGV4IGY3ZmFkMzQuLmJhOGJlMTQgMTAwNjQ0Ci0tLSBh
L3NyYy9kcm1tb2RlX2Rpc3BsYXkuYworKysgYi9zcmMvZHJtbW9kZV9kaXNwbGF5LmMKQEAgLTE0
OTgsNiArMTQ5OCw4IEBAIGRybW1vZGVfc2V0X21vZGVfbWFqb3IoeGY4NkNydGNQdHIgY3J0Yywg
RGlzcGxheU1vZGVQdHIgbW9kZSwKIAkJCWdvdG8gZG9uZTsKIAogCQlkcm1tb2RlX2NydGNfdXBk
YXRlX3RlYXJfZnJlZShjcnRjKTsKKwkJZHJtbW9kZV9jcnRjX3VwZGF0ZV9jbV9wcm9wcyhjcnRj
KTsKKwogCQlpZiAoZHJtbW9kZV9jcnRjLT50ZWFyX2ZyZWUpCiAJCQlzY2Fub3V0X2lkID0gZHJt
bW9kZV9jcnRjLT5zY2Fub3V0X2lkOwogCQllbHNlCi0tIAoyLjcuNAoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

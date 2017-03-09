From: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] drm/amd/amdgpu: Disable GFX_PG on Carrizo until compute
 issues solved
Date: Thu,  9 Mar 2017 13:22:06 -0500
Message-ID: <20170309182206.20311-1-tom.stdenis@amd.com>
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

Q3VycmVudGx5IGNvbXB1dGUgam9icyB3aWxsIHN0YWxsIGlmIEdGWF9QRyBpcyBlbmFibGVkLiAg
VW50aWwgdGhpcwppcyByZXNvbHZlZCB3ZSdsbCBkaXNhYmxlIEdGWF9QRy4KClNpZ25lZC1vZmYt
Ynk6IFRvbSBTdCBEZW5pcyA8dG9tLnN0ZGVuaXNAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS92aS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
dmkuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZpLmMKaW5kZXggMjU3N2FjYzNlMjZl
Li4zNWQ4ZjM2NDc1ZWEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zp
LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmkuYwpAQCAtMTA1OCw3ICsxMDU4
LDcgQEAgc3RhdGljIGludCB2aV9jb21tb25fZWFybHlfaW5pdCh2b2lkICpoYW5kbGUpCiAJCS8q
IHJldjAgaGFyZHdhcmUgcmVxdWlyZXMgd29ya2Fyb3VuZHMgdG8gc3VwcG9ydCBQRyAqLwogCQlh
ZGV2LT5wZ19mbGFncyA9IDA7CiAJCWlmIChhZGV2LT5yZXZfaWQgIT0gMHgwMCkgewotCQkJYWRl
di0+cGdfZmxhZ3MgfD0gQU1EX1BHX1NVUFBPUlRfR0ZYX1BHIHwKKwkJCWFkZXYtPnBnX2ZsYWdz
IHw9CiAJCQkJQU1EX1BHX1NVUFBPUlRfR0ZYX1NNRyB8CiAJCQkJQU1EX1BHX1NVUFBPUlRfR0ZY
X1BJUEVMSU5FIHwKIAkJCQlBTURfUEdfU1VQUE9SVF9DUCB8Ci0tIAoyLjExLjAKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=

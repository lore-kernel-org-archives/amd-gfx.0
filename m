From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] drm/amdgpu: disable MSI-X on APUs
Date: Thu,  3 Oct 2019 09:13:26 -0500
Message-ID: <20191003141326.7600-2-alexander.deucher@amd.com>
References: <20191003141326.7600-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191003141326.7600-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>

UmF2ZW4gY2xhaW1zIHRvIHN1cHBvcnQgdGhlbSwgYnV0IHNlZW1zIHRvIGhhdmUgcHJvYmxlbXMu
ICBTdGljawp3aXRoIE1TSXMgZm9yIG5vdyBvbiBBUFVzLgoKVGVzdGVkLWJ5OiBUb20gU3QgRGVu
aXMgPHRvbS5zdGRlbmlzQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxl
eGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfaXJxLmMgfCAzICsrLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9pcnEuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pcnEuYwppbmRleCA5
OGFhMjhlZGJhNmEuLjhmMjIzNmJkN2QwZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2lycS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9pcnEuYwpAQCAtMjQ4LDcgKzI0OCw4IEBAIGludCBhbWRncHVfaXJxX2luaXQoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJCXVuc2lnbmVkIGludCBmbGFnczsKIAkJaW50IG52ZWMg
PSBwY2lfbXNpeF92ZWNfY291bnQoYWRldi0+cGRldik7CiAKLQkJaWYgKG52ZWMgPD0gMCkgewor
CQkvKiBSYXZlbiBjbGFpbXMgdG8gc3VwcG9ydCBNU0ktWCwgYnV0IHNlZW1zIHRvIGhhdmUgcHJv
YmxlbXMgKi8KKwkJaWYgKChudmVjIDw9IDApIHx8IChhZGV2LT5mbGFncyAmIEFNRF9JU19BUFUp
KSB7CiAJCQlmbGFncyA9IFBDSV9JUlFfTVNJOwogCQkJbnZlYyA9IDE7CiAJCX0gZWxzZSB7Ci0t
IAoyLjIwLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==

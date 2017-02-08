From: =?UTF-8?q?Nicolai=20H=C3=A4hnle?= <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH libdrm 1/2] amdgpu: add AMDGPU_VM_PAGE_PRT
Date: Wed,  8 Feb 2017 13:34:29 +0100
Message-ID: <20170208123430.8853-1-nhaehnle@gmail.com>
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
Cc: =?UTF-8?q?Nicolai=20H=C3=A4hnle?= <nicolai.haehnle-5C7GfCeVMHo@public.gmane.org>

RnJvbTogTmljb2xhaSBIw6RobmxlIDxuaWNvbGFpLmhhZWhubGVAYW1kLmNvbT4KClRoaXMgaXMg
YSBuZXcga2VybmVsIGludGVyZmFjZS4KClNpZ25lZC1vZmYtYnk6IE5pY29sYWkgSMOkaG5sZSA8
bmljb2xhaS5oYWVobmxlQGFtZC5jb20+Ci0tLQogaW5jbHVkZS9kcm0vYW1kZ3B1X2RybS5oIHwg
MiArKwogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2luY2x1
ZGUvZHJtL2FtZGdwdV9kcm0uaCBiL2luY2x1ZGUvZHJtL2FtZGdwdV9kcm0uaAppbmRleCBkOGYy
NDk3Li43MDEyNTE1IDEwMDY0NAotLS0gYS9pbmNsdWRlL2RybS9hbWRncHVfZHJtLmgKKysrIGIv
aW5jbHVkZS9kcm0vYW1kZ3B1X2RybS5oCkBAIC0zMjksNiArMzI5LDggQEAgc3RydWN0IGRybV9h
bWRncHVfZ2VtX29wIHsKICNkZWZpbmUgQU1ER1BVX1ZNX1BBR0VfV1JJVEVBQkxFCSgxIDw8IDIp
CiAvKiBleGVjdXRhYmxlIG1hcHBpbmcsIG5ldyBmb3IgVkkgKi8KICNkZWZpbmUgQU1ER1BVX1ZN
X1BBR0VfRVhFQ1VUQUJMRQkoMSA8PCAzKQorLyogcGFydGlhbGx5IHJlc2lkZW50IHRleHR1cmUg
Ki8KKyNkZWZpbmUgQU1ER1BVX1ZNX1BBR0VfUFJUCQkoMSA8PCA0KQogCiBzdHJ1Y3QgZHJtX2Ft
ZGdwdV9nZW1fdmEgewogCS8qKiBHRU0gb2JqZWN0IGhhbmRsZSAqLwotLSAKMi45LjMKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=

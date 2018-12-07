From: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/amdgpu: update MC firmware image for polaris10
 variants
Date: Fri, 7 Dec 2018 15:19:52 +0800
Message-ID: <20181207071952.8095-2-Jerry.Zhang@amd.com>
References: <20181207071952.8095-1-Jerry.Zhang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181207071952.8095-1-Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
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
Cc: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>

U29tZSBuZXcgdmFyaWFudHMgcmVxdWlyZSBkaWZmZXJlbnQgZmlybXdhcmVzLgoKU2lnbmVkLW9m
Zi1ieTogSnVud2VpIFpoYW5nIDxKZXJyeS5aaGFuZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dtY192OF8wLmMgfCA1ICsrKystCiAxIGZpbGUgY2hhbmdlZCwgNCBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ21jX3Y4XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192
OF8wLmMKaW5kZXggMWFkN2U2YjhlZDFkLi4wZWRiODYyMmY2NjYgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OF8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ21jX3Y4XzAuYwpAQCAtMjQ0LDcgKzI0NCwxMCBAQCBzdGF0aWMgaW50IGdtY192
OF8wX2luaXRfbWljcm9jb2RlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCWNhc2UgQ0hJ
UF9QT0xBUklTMTA6CiAJCWlmICgoYWRldi0+cGRldi0+ZGV2aWNlID09IDB4NjdkZikgJiYKIAkJ
ICAgICgoYWRldi0+cGRldi0+cmV2aXNpb24gPT0gMHhlMSkgfHwKLQkJICAgICAoYWRldi0+cGRl
di0+cmV2aXNpb24gPT0gMHhmNykpKQorCQkgICAgIChhZGV2LT5wZGV2LT5yZXZpc2lvbiA9PSAw
eGY3KSkgfHwKKwkJICAgICgoYWRldi0+cGRldi0+ZGV2aWNlID09IDB4NmZkZikgJiYKKwkJICAg
ICAoKGFkZXYtPnBkZXYtPnJldmlzaW9uID09IDB4ZWYpIHx8CisJCSAgICAgIChhZGV2LT5wZGV2
LT5yZXZpc2lvbiA9PSAweGZmKSkpKQogCQkJY2hpcF9uYW1lID0gInBvbGFyaXMxMF9rIjsKIAkJ
ZWxzZQogCQkJY2hpcF9uYW1lID0gInBvbGFyaXMxMCI7Ci0tIAoyLjE3LjEKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=

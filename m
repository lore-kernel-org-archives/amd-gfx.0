From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 63/76] drm/amd/dal: disable break_to_debugger for bandwidth
 failures in diags
Date: Mon, 21 Nov 2016 18:01:23 -0500
Message-ID: <20161121230136.5208-64-harry.wentland@amd.com>
References: <20161121230136.5208-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20161121230136.5208-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Dmytro Laktyushkin <Dmytro.Laktyushkin-5C7GfCeVMHo@public.gmane.org>

RnJvbTogRG15dHJvIExha3R5dXNoa2luIDxEbXl0cm8uTGFrdHl1c2hraW5AYW1kLmNvbT4KClNp
Z25lZC1vZmYtYnk6IERteXRybyBMYWt0eXVzaGtpbiA8RG15dHJvLkxha3R5dXNoa2luQGFtZC5j
b20+CkFja2VkLWJ5OiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4KLS0t
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2RhbC9kYy9jb3JlL2RjLmMgfCAxIC0KIDEgZmlsZSBjaGFu
Z2VkLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kYWwv
ZGMvY29yZS9kYy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kYWwvZGMvY29yZS9kYy5jCmluZGV4
IDBjODE0Y2Y4ODZjMy4uYzk2ZTllZGFjYWYxIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2RhbC9kYy9jb3JlL2RjLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kYWwvZGMvY29y
ZS9kYy5jCkBAIC0xMjA1LDcgKzEyMDUsNiBAQCBib29sIGRjX3ByZV91cGRhdGVfc3VyZmFjZXNf
dG9fdGFyZ2V0KAogCQkJCWNvbnRleHQpOwogCQlpZiAoIXRlbXBfY29udGV4dCkgewogCQkJZG1f
ZXJyb3IoIiVzOmZhaWxlZCBhcHBseSBjbGsgY29uc3RyYWludHNcbiIsIF9fZnVuY19fKTsKLQkJ
CUJSRUFLX1RPX0RFQlVHR0VSKCk7CiAJCQlyZXQgPSBmYWxzZTsKIAkJCWdvdG8gdW5leHBlY3Rl
ZF9mYWlsOwogCQl9Ci0tIAoyLjEwLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=

From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 08/11] drm/amd/dal/dc: fix include order in dce80_resource.c
Date: Tue, 22 Nov 2016 11:57:25 -0500
Message-ID: <1479833848-14275-8-git-send-email-alexander.deucher@amd.com>
References: <1479833848-14275-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1479833848-14275-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

Rml4ZXMgcmVkZWZpbml0aW9uIHdhcm5pbmdzCgpSZXZpZXdlZC1ieTogSGFycnkgV2VudGxhbmQg
PGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxl
eGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2RhbC9kYy9k
Y2U4MC9kY2U4MF9yZXNvdXJjZS5jIHwgNSArKy0tLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2RhbC9kYy9kY2U4MC9kY2U4MF9yZXNvdXJjZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kYWwv
ZGMvZGNlODAvZGNlODBfcmVzb3VyY2UuYwppbmRleCAzZGU0MDMwLi45OWI4MTgyIDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2RhbC9kYy9kY2U4MC9kY2U4MF9yZXNvdXJjZS5jCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGFsL2RjL2RjZTgwL2RjZTgwX3Jlc291cmNlLmMKQEAg
LTIzLDYgKzIzLDggQEAKICAqCiAgKi8KIAorI2luY2x1ZGUgImRjZS9kY2VfOF8wX2QuaCIKKyNp
bmNsdWRlICJkY2UvZGNlXzhfMF9zaF9tYXNrLmgiCiAKICNpbmNsdWRlICJkbV9zZXJ2aWNlcy5o
IgogCkBAIC01MSw5ICs1Myw2IEBACiAKICNpbmNsdWRlICJyZWdfaGVscGVyLmgiCiAKLSNpbmNs
dWRlICJkY2UvZGNlXzhfMF9kLmgiCi0jaW5jbHVkZSAiZGNlL2RjZV84XzBfc2hfbWFzay5oIgot
CiAvKiBUT0RPIHJlbW92ZSB0aGlzIGluY2x1ZGUgKi8KIAogI2lmbmRlZiBtbURQX0RQSFlfSU5U
RVJOQUxfQ1RSTAotLSAKMi41LjUKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=

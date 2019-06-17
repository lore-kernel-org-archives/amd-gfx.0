From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 104/459] drm/amdgpu/discovery: update definition for struct
 die_header
Date: Mon, 17 Jun 2019 14:25:29 -0500
Message-ID: <20190617192704.18038-5-alexander.deucher@amd.com>
References: <20190617192704.18038-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190617192704.18038-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>, Xiaojie Yuan <xiaojie.yuan-5C7GfCeVMHo@public.gmane.org>

RnJvbTogWGlhb2ppZSBZdWFuIDx4aWFvamllLnl1YW5AYW1kLmNvbT4KClNpZ25lZC1vZmYtYnk6
IFhpYW9qaWUgWXVhbiA8eGlhb2ppZS55dWFuQGFtZC5jb20+ClJldmlld2VkLWJ5OiBIYXdraW5n
IFpoYW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hl
ciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2lu
Y2x1ZGUvZGlzY292ZXJ5LmggfCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNs
dWRlL2Rpc2NvdmVyeS5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2Rpc2NvdmVyeS5o
CmluZGV4IGUwMWQ0Y2Q5ZjJjYi4uNWRjYjc3NjU0OGQ4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2luY2x1ZGUvZGlzY292ZXJ5LmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9p
bmNsdWRlL2Rpc2NvdmVyeS5oCkBAIC05OSw4ICs5OSw4IEBAIHR5cGVkZWYgc3RydWN0IGlwCiAK
IHR5cGVkZWYgc3RydWN0IGRpZV9oZWFkZXIKIHsKLQl1aW50MzJfdCBkaWVfaWQ7Ci0JdWludDMy
X3QgbnVtX2lwczsKKwl1aW50MTZfdCBkaWVfaWQ7CisJdWludDE2X3QgbnVtX2lwczsKIH0gZGll
X2hlYWRlcjsKIAogdHlwZWRlZiBzdHJ1Y3QgaXBfc3RydWN0dXJlCi0tIAoyLjIwLjEKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==

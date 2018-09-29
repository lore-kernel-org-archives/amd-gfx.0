From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 5/6] drm/amd/pp: Fix memory leak on Si/CI/AI dgpu asics
Date: Sun, 30 Sep 2018 00:15:12 +0800
Message-ID: <1538237713-3293-5-git-send-email-Rex.Zhu@amd.com>
References: <1538237713-3293-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1538237713-3293-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

T24gU0kvQ0kvQUksIGRyaXZlciBzdGlsbCBuZWVkIHRvIHJlbGVhc2Ugc211J3MgZncsCml0IHdh
cyBub3QgcmVsYXRlZCB0byBvdGhlciBodyBpcCdzIGZ3IGxvYWRfdHlwZS4KClNpZ25lZC1vZmYt
Ynk6IFJleCBaaHUgPFJleC5aaHVAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bv
d2VycGxheS9hbWRfcG93ZXJwbGF5LmMgfCA4ICsrKystLS0tCiAxIGZpbGUgY2hhbmdlZCwgNCBp
bnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvcG93ZXJwbGF5L2FtZF9wb3dlcnBsYXkuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93
ZXJwbGF5L2FtZF9wb3dlcnBsYXkuYwppbmRleCA1MDA4ZDJlLi5kM2VhZjVkIDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRfcG93ZXJwbGF5LmMKKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kX3Bvd2VycGxheS5jCkBAIC0xMDksMTEgKzEw
OSwxMSBAQCBzdGF0aWMgaW50IHBwX3N3X2Zpbmkodm9pZCAqaGFuZGxlKQogCiAJaHdtZ3Jfc3df
ZmluaShod21ncik7CiAKLQlpZiAoYWRldi0+ZmlybXdhcmUubG9hZF90eXBlID09IEFNREdQVV9G
V19MT0FEX1NNVSkgewotCQlyZWxlYXNlX2Zpcm13YXJlKGFkZXYtPnBtLmZ3KTsKLQkJYWRldi0+
cG0uZncgPSBOVUxMOworCWlmIChhZGV2LT5maXJtd2FyZS5sb2FkX3R5cGUgPT0gQU1ER1BVX0ZX
X0xPQURfU01VKQogCQlhbWRncHVfdWNvZGVfZmluaV9ibyhhZGV2KTsKLQl9CisKKwlyZWxlYXNl
X2Zpcm13YXJlKGFkZXYtPnBtLmZ3KTsKKwlhZGV2LT5wbS5mdyA9IE5VTEw7CiAKIAlyZXR1cm4g
MDsKIH0KLS0gCjEuOS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK

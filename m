From: Leo Liu <leo.liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 20/21] drm/amdgpu: enable Arcturus CG for VCN and JPEG blocks
Date: Tue, 12 Nov 2019 13:03:28 -0500
Message-ID: <20191112180329.3927-21-leo.liu@amd.com>
References: <20191112180329.3927-1-leo.liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191112180329.3927-1-leo.liu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Leo Liu <leo.liu-5C7GfCeVMHo@public.gmane.org>

QXJjdHVydXMgVkNOIGFuZCBKUEVHIG9ubHkgZ290IENHIHN1cHBvcnQsIGFuZCBubyBQRyBzdXBw
b3J0CgpTaWduZWQtb2ZmLWJ5OiBMZW8gTGl1IDxsZW8ubGl1QGFtZC5jb20+Ci0tLQogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYyB8IDQgKysrLQogMSBmaWxlIGNoYW5nZWQsIDMg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3NvYzE1LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5j
CmluZGV4IGYzOTc3YWJiZDFlMi4uYjQwNGI3YTZlNTkzIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3NvYzE1LmMKQEAgLTEyMTAsNyArMTIxMCw5IEBAIHN0YXRpYyBpbnQgc29jMTVfY29tbW9uX2Vh
cmx5X2luaXQodm9pZCAqaGFuZGxlKQogCQkJQU1EX0NHX1NVUFBPUlRfU0RNQV9MUyB8CiAJCQlB
TURfQ0dfU1VQUE9SVF9NQ19NR0NHIHwKIAkJCUFNRF9DR19TVVBQT1JUX01DX0xTIHwKLQkJCUFN
RF9DR19TVVBQT1JUX0lIX0NHOworCQkJQU1EX0NHX1NVUFBPUlRfSUhfQ0cgfAorCQkJQU1EX0NH
X1NVUFBPUlRfVkNOX01HQ0cgfAorCQkJQU1EX0NHX1NVUFBPUlRfSlBFR19NR0NHOwogCQlhZGV2
LT5wZ19mbGFncyA9IDA7CiAJCWFkZXYtPmV4dGVybmFsX3Jldl9pZCA9IGFkZXYtPnJldl9pZCAr
IDB4MzI7CiAJCWJyZWFrOwotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZng=

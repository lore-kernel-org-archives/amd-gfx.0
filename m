From: Roger He <Hongbo.He-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/3] drm/amd/amdgpu: init allow_reserved_eviction and resv
 when create a new bo
Date: Wed, 13 Dec 2017 13:17:57 +0800
Message-ID: <1513142278-4294-2-git-send-email-Hongbo.He@amd.com>
References: <1513142278-4294-1-git-send-email-Hongbo.He@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1513142278-4294-1-git-send-email-Hongbo.He-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Roger He <Hongbo.He-5C7GfCeVMHo@public.gmane.org>, Christian.Koenig-5C7GfCeVMHo@public.gmane.org

Q2hhbmdlLUlkOiBJMGM2NTcxYzJhNjRlNmM1YmRhZDgwY2NiY2NjYjQwZWJhMWMyMGI0ZQpTaWdu
ZWQtb2ZmLWJ5OiBSb2dlciBIZSA8SG9uZ2JvLkhlQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X29iamVjdC5jCmluZGV4IGRjMGE4YmUuLjdjN2Y1NmY1IDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCkBAIC0zMjcsNyArMzI3LDcgQEAgc3RhdGlj
IGludCBhbWRncHVfYm9fZG9fY3JlYXRlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCQkJ
ICAgICAgIHVpbnQ2NF90IGluaXRfdmFsdWUsCiAJCQkgICAgICAgc3RydWN0IGFtZGdwdV9ibyAq
KmJvX3B0cikKIHsKLQlzdHJ1Y3QgdHRtX29wZXJhdGlvbl9jdHggY3R4ID0geyAha2VybmVsLCBm
YWxzZSB9OworCXN0cnVjdCB0dG1fb3BlcmF0aW9uX2N0eCBjdHggPSB7ICFrZXJuZWwsIGZhbHNl
LCB0cnVlLCByZXN2IH07CiAJc3RydWN0IGFtZGdwdV9ibyAqYm87CiAJZW51bSB0dG1fYm9fdHlw
ZSB0eXBlOwogCXVuc2lnbmVkIGxvbmcgcGFnZV9hbGlnbjsKLS0gCjIuNy40CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK

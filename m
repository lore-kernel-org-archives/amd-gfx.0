From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH 13/14] amdgpu: amdgpu_dpm: Remove unused field
Date: Mon, 24 Jul 2017 15:35:39 +0200
Message-ID: <20170724133540.32200-14-ricardo.ribalda@gmail.com>
References: <20170724133540.32200-1-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170724133540.32200-1-ricardo.ribalda@gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>, Rex Zhu <Rex.Zhu@amd.com>, Tom St Denis <tom.stdenis@amd.com>, Eric Huang <JinHuiEric.Huang@amd.com>, Huang Rui <ray.huang@amd.com>, Dan Carpenter <dan.carpenter@oracle.com>, Edward O'Callaghan <funfunctor@folklore1984.net>, Kees Cook <keescook@chromium.org>, "Andrew F. Davis" <afd@ti.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Baoyou Xie <baoyou.xie@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Colin Ian King <colin.king@canonical.com>, =?UTF-8?q?Nils=20Wallm=C3=A9nius?= <nils.wallmenius@gmail.com>, Joe Perches <joe@perches.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

UmVtb3ZlIHVudXNlZCBmaWVsZCBwbV9kaXNwbGF5X2NmZwoKU2lnbmVkLW9mZi1ieTogUmljYXJk
byBSaWJhbGRhIERlbGdhZG8gPHJpY2FyZG8ucmliYWxkYUBnbWFpbC5jb20+Ci0tLQogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RwbS5oIHwgMSAtCiAxIGZpbGUgY2hhbmdlZCwg
MSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9kcG0uaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcG0uaAppbmRl
eCA4Yzk2YTRjYWE3MTUuLjVjNzQwODE0ZGJhNCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RwbS5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kcG0uaApAQCAtNDg4LDcgKzQ4OCw2IEBAIHN0cnVjdCBhbWRncHVfcG0gewogCWNv
bnN0IHN0cnVjdCBhbWRncHVfZHBtX2Z1bmNzICpmdW5jczsKIAl1aW50MzJfdCAgICAgICAgICAg
ICAgICBwY2llX2dlbl9tYXNrOwogCXVpbnQzMl90ICAgICAgICAgICAgICAgIHBjaWVfbWx3X21h
c2s7Ci0Jc3RydWN0IGFtZF9wcF9kaXNwbGF5X2NvbmZpZ3VyYXRpb24gcG1fZGlzcGxheV9jZmc7
Lyogc2V0IGJ5IERBTCAqLwogfTsKIAogI2RlZmluZSBSNjAwX1NTVFVfREZMVCAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAwCi0tIAoyLjEzLjIKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVs
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=

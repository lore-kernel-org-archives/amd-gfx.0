From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH 09/14] amdgpu: powerplay: rv_hwmgr: Assume display_config is
 zero
Date: Mon, 24 Jul 2017 15:35:35 +0200
Message-ID: <20170724133540.32200-10-ricardo.ribalda@gmail.com>
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

ZGlzcGxheV9jb25maWcgaXMgbmV2ZXIgc2V0LCBzbyB3ZSBjYW4gYXNzdW1lIHRoYXQgaXQgaXMg
emVyby4KClNpZ25lZC1vZmYtYnk6IFJpY2FyZG8gUmliYWxkYSBEZWxnYWRvIDxyaWNhcmRvLnJp
YmFsZGFAZ21haWwuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdy
L3J2X2h3bWdyLmMgfCAyIC0tCiAxIGZpbGUgY2hhbmdlZCwgMiBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9ydl9od21nci5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3IvcnZfaHdtZ3IuYwppbmRleCA0Yzdm
NDMwYjM2ZWIuLjY0YTNjYjY2YTNhMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9w
b3dlcnBsYXkvaHdtZ3IvcnZfaHdtZ3IuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2Vy
cGxheS9od21nci9ydl9od21nci5jCkBAIC0yNDEsOCArMjQxLDYgQEAgc3RhdGljIGludCBydl90
Zl9zZXRfY2xvY2tfbGltaXQoc3RydWN0IHBwX2h3bWdyICpod21nciwgdm9pZCAqaW5wdXQsCiAJ
c3RydWN0IFBQX0Nsb2NrcyBjbG9ja3MgPSB7MH07CiAJc3RydWN0IHBwX2Rpc3BsYXlfY2xvY2tf
cmVxdWVzdCBjbG9ja19yZXE7CiAKLQljbG9ja3MuZGNlZkNsb2NrID0gaHdtZ3ItPmRpc3BsYXlf
Y29uZmlnLm1pbl9kY2VmX3NldF9jbGs7Ci0JY2xvY2tzLmRjZWZDbG9ja0luU1IgPSBod21nci0+
ZGlzcGxheV9jb25maWcubWluX2RjZWZfZGVlcF9zbGVlcF9zZXRfY2xrOwogCWNsb2NrX3JlcS5j
bG9ja190eXBlID0gYW1kX3BwX2RjZl9jbG9jazsKIAljbG9ja19yZXEuY2xvY2tfZnJlcV9pbl9r
aHogPSBjbG9ja3MuZGNlZkNsb2NrICogMTA7CiAKLS0gCjIuMTMuMgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApk
cmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

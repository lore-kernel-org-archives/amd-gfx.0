From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] drm/amd/display: checking for NULL instead of IS_ERR()
Date: Mon, 6 Nov 2017 14:43:41 +0300
Message-ID: <20171106114340.w6li3f4iltg24bdp@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
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
To: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>, Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, "Leo (Sunpeng) Li" <sunpeng.li-5C7GfCeVMHo@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Tony Cheng <Tony.Cheng-5C7GfCeVMHo@public.gmane.org>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

YmFja2xpZ2h0X2RldmljZV9yZWdpc3RlcigpIG5ldmVyIHJldHVybnMgTlVMTCwgaXQgcmV0dXJu
cyBlcnJvcgpwb2ludGVycyBvbiBlcnJvciBzbyB0aGUgY2hlY2sgaGVyZSBpcyB3cm9uZy4KClNp
Z25lZC1vZmYtYnk6IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAb3JhY2xlLmNvbT4KCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9k
bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwpp
bmRleCAzM2ExNWExZDgxOGMuLjc1ZjkzODNmNWI5YiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYworKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCkBAIC0xMjk2LDcgKzEyOTYsNyBA
QCBhbWRncHVfZG1fcmVnaXN0ZXJfYmFja2xpZ2h0X2RldmljZShzdHJ1Y3QgYW1kZ3B1X2Rpc3Bs
YXlfbWFuYWdlciAqZG0pCiAJCQkmYW1kZ3B1X2RtX2JhY2tsaWdodF9vcHMsCiAJCQkmcHJvcHMp
OwogCi0JaWYgKE5VTEwgPT0gZG0tPmJhY2tsaWdodF9kZXYpCisJaWYgKElTX0VSUihkbS0+YmFj
a2xpZ2h0X2RldikpCiAJCURSTV9FUlJPUigiRE06IEJhY2tsaWdodCByZWdpc3RyYXRpb24gZmFp
bGVkIVxuIik7CiAJZWxzZQogCQlEUk1fREVCVUdfRFJJVkVSKCJETTogUmVnaXN0ZXJlZCBCYWNr
bGlnaHQgZGV2aWNlOiAlc1xuIiwgYmxfbmFtZSk7Cl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=

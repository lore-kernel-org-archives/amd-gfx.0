From: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 11/14] amdgpu: ci_dpm: Assume pm_display_cfg is zero
Date: Mon, 24 Jul 2017 15:35:37 +0200
Message-ID: <20170724133540.32200-12-ricardo.ribalda@gmail.com>
References: <20170724133540.32200-1-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170724133540.32200-1-ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>, Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>, Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>, Baoyou Xie <baoyou.xie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, =?UTF-8?q?Nils=20Wallm=C3=A9nius?= <nils.wallmenius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

cG1fZGlzcGxheV9jZmcgaXMgbmV2ZXIgc2V0LCBzbyB3ZSBjYW4gYXNzdW1lIHRoYXQgaXQgaXMg
emVybwoKU2lnbmVkLW9mZi1ieTogUmljYXJkbyBSaWJhbGRhIERlbGdhZG8gPHJpY2FyZG8ucmli
YWxkYUBnbWFpbC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvY2lfZHBtLmMg
fCA2IC0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvY2lfZHBtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9jaV9kcG0uYwppbmRleCBjYjUwOGEyMTFiMmYuLjgzMTliY2EzZGM1MiAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvY2lfZHBtLmMKKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvY2lfZHBtLmMKQEAgLTk3MiwxMiArOTcyLDYgQEAgc3RhdGljIHZv
aWQgY2lfYXBwbHlfc3RhdGVfYWRqdXN0X3J1bGVzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LAogCQlzY2xrID0gcHMtPnBlcmZvcm1hbmNlX2xldmVsc1swXS5zY2xrOwogCX0KIAotCWlmIChh
ZGV2LT5wbS5wbV9kaXNwbGF5X2NmZy5taW5fY29yZV9zZXRfY2xvY2sgPiBzY2xrKQotCQlzY2xr
ID0gYWRldi0+cG0ucG1fZGlzcGxheV9jZmcubWluX2NvcmVfc2V0X2Nsb2NrOwotCi0JaWYgKGFk
ZXYtPnBtLnBtX2Rpc3BsYXlfY2ZnLm1pbl9tZW1fc2V0X2Nsb2NrID4gbWNsaykKLQkJbWNsayA9
IGFkZXYtPnBtLnBtX2Rpc3BsYXlfY2ZnLm1pbl9tZW1fc2V0X2Nsb2NrOwotCiAJaWYgKHJwcy0+
dmNlX2FjdGl2ZSkgewogCQlpZiAoc2NsayA8IGFkZXYtPnBtLmRwbS52Y2Vfc3RhdGVzW2FkZXYt
PnBtLmRwbS52Y2VfbGV2ZWxdLnNjbGspCiAJCQlzY2xrID0gYWRldi0+cG0uZHBtLnZjZV9zdGF0
ZXNbYWRldi0+cG0uZHBtLnZjZV9sZXZlbF0uc2NsazsKLS0gCjIuMTMuMgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

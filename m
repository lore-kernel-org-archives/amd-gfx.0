From: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 08/14] amdgpu: powerplay: tonga_smc: Assume display_config is
 zero
Date: Mon, 24 Jul 2017 15:35:34 +0200
Message-ID: <20170724133540.32200-9-ricardo.ribalda@gmail.com>
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

ZGlzcGxheV9jb25maWcgaXMgbmV2ZXIgc2V0LCB3ZSBjYW4gYXNzdW1lIGl0IGlzIHplcm8uCgpT
aWduZWQtb2ZmLWJ5OiBSaWNhcmRvIFJpYmFsZGEgRGVsZ2FkbyA8cmljYXJkby5yaWJhbGRhQGdt
YWlsLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVtZ3IvdG9uZ2Ff
c21jLmMgfCAzICstLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdW1nci90
b25nYV9zbWMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdW1nci90b25nYV9z
bWMuYwppbmRleCA2NWQzYTQ4OTM5NTguLjM0MWMzMWM2M2U1ZSAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211bWdyL3RvbmdhX3NtYy5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdW1nci90b25nYV9zbWMuYwpAQCAtNTYyLDggKzU2Miw3
IEBAIHN0YXRpYyBpbnQgdG9uZ2FfcG9wdWxhdGVfc2luZ2xlX2dyYXBoaWNfbGV2ZWwoc3RydWN0
IHBwX2h3bWdyICpod21nciwKIAlncmFwaGljX2xldmVsLT5Wb2x0YWdlRG93bkh5c3QgPSAwOwog
CWdyYXBoaWNfbGV2ZWwtPlBvd2VyVGhyb3R0bGUgPSAwOwogCi0JZGF0YS0+ZGlzcGxheV90aW1p
bmcubWluX2Nsb2NrX2luX3NyID0KLQkJCWh3bWdyLT5kaXNwbGF5X2NvbmZpZy5taW5fY29yZV9z
ZXRfY2xvY2tfaW5fc3I7CisJZGF0YS0+ZGlzcGxheV90aW1pbmcubWluX2Nsb2NrX2luX3NyID0g
MDsKIAogCWlmIChwaG1fY2FwX2VuYWJsZWQoaHdtZ3ItPnBsYXRmb3JtX2Rlc2NyaXB0b3IucGxh
dGZvcm1DYXBzLAogCQkJUEhNX1BsYXRmb3JtQ2Fwc19TY2xrRGVlcFNsZWVwKSkKLS0gCjIuMTMu
MgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

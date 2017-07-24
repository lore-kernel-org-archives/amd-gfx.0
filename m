From: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 07/14] amdgpu: powerplay: polaris10_smc: Assume display_config
 is zero
Date: Mon, 24 Jul 2017 15:35:33 +0200
Message-ID: <20170724133540.32200-8-ricardo.ribalda@gmail.com>
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
YWlsLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVtZ3IvcG9sYXJp
czEwX3NtYy5jIHwgOSArKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyks
IDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBs
YXkvc211bWdyL3BvbGFyaXMxMF9zbWMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5
L3NtdW1nci9wb2xhcmlzMTBfc21jLmMKaW5kZXggZjY4ZTc1OWU4YmUyLi5jODg5ZmM5MzBjZmMg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdW1nci9wb2xhcmlz
MTBfc21jLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211bWdyL3BvbGFy
aXMxMF9zbWMuYwpAQCAtNzExLDExICs3MTEsMTIgQEAgc3RhdGljIGludCBwb2xhcmlzMTBfcG9w
dWxhdGVfc2luZ2xlX2dyYXBoaWNfbGV2ZWwoc3RydWN0IHBwX2h3bWdyICpod21nciwKIAlsZXZl
bC0+RG93bkh5c3QgPSAwOwogCWxldmVsLT5Wb2x0YWdlRG93bkh5c3QgPSAwOwogCWxldmVsLT5Q
b3dlclRocm90dGxlID0gMDsKLQlkYXRhLT5kaXNwbGF5X3RpbWluZy5taW5fY2xvY2tfaW5fc3Ig
PSBod21nci0+ZGlzcGxheV9jb25maWcubWluX2NvcmVfc2V0X2Nsb2NrX2luX3NyOworCWRhdGEt
PmRpc3BsYXlfdGltaW5nLm1pbl9jbG9ja19pbl9zciA9IDA7CiAKLQlpZiAocGhtX2NhcF9lbmFi
bGVkKGh3bWdyLT5wbGF0Zm9ybV9kZXNjcmlwdG9yLnBsYXRmb3JtQ2FwcywgUEhNX1BsYXRmb3Jt
Q2Fwc19TY2xrRGVlcFNsZWVwKSkKLQkJbGV2ZWwtPkRlZXBTbGVlcERpdklkID0gc211N19nZXRf
c2xlZXBfZGl2aWRlcl9pZF9mcm9tX2Nsb2NrKGNsb2NrLAotCQkJCQkJCQlod21nci0+ZGlzcGxh
eV9jb25maWcubWluX2NvcmVfc2V0X2Nsb2NrX2luX3NyKTsKKwlpZiAocGhtX2NhcF9lbmFibGVk
KGh3bWdyLT5wbGF0Zm9ybV9kZXNjcmlwdG9yLnBsYXRmb3JtQ2FwcywKKwkJCSAgICBQSE1fUGxh
dGZvcm1DYXBzX1NjbGtEZWVwU2xlZXApKQorCQlsZXZlbC0+RGVlcFNsZWVwRGl2SWQgPQorCQkJ
c211N19nZXRfc2xlZXBfZGl2aWRlcl9pZF9mcm9tX2Nsb2NrKGNsb2NrLCAwKTsKIAogCS8qIERl
ZmF1bHQgdG8gc2xvdywgaGlnaGVzdCBEUE0gbGV2ZWwgd2lsbCBiZQogCSAqIHNldCB0byBQUFNN
Q19ESVNQTEFZX1dBVEVSTUFSS19MT1cgbGF0ZXIuCi0tIAoyLjEzLjIKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=

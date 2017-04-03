From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/2] drm/amd/powerplay: fix pp_dpm_get_current_power_state()
Date: Mon, 3 Apr 2017 21:41:47 +0300
Message-ID: <20170403184147.GA22462@mwanda>
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
To: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>, Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

VGhpcyBzd2l0Y2ggc3RhdGVtZW50IGlzIG1pc3NpbmcgYnJlYWtzLgoKRml4ZXM6IDJhNTA3MTA1
NmU2YSAoImRybS9hbWQvcG93ZXJwbGF5OiBhZGQgZ2xvYmFsIFBvd2VyUGxheSBtdXRleC4iKQpT
aWduZWQtb2ZmLWJ5OiBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVyQG9yYWNsZS5jb20+Cgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kX3Bvd2VycGxheS5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kX3Bvd2VycGxheS5jCmluZGV4IGRm
ZDRmZTZmMDU3OC4uMjYwYjczMmJlN2MzIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L3Bvd2VycGxheS9hbWRfcG93ZXJwbGF5LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dl
cnBsYXkvYW1kX3Bvd2VycGxheS5jCkBAIC01MzksMTAgKzUzOSwxMyBAQCBzdGF0aWMgZW51bSBh
bWRfcG1fc3RhdGVfdHlwZSBwcF9kcG1fZ2V0X2N1cnJlbnRfcG93ZXJfc3RhdGUodm9pZCAqaGFu
ZGxlKQogCXN3aXRjaCAoc3RhdGUtPmNsYXNzaWZpY2F0aW9uLnVpX2xhYmVsKSB7CiAJY2FzZSBQ
UF9TdGF0ZVVJTGFiZWxfQmF0dGVyeToKIAkJcG1fdHlwZSA9IFBPV0VSX1NUQVRFX1RZUEVfQkFU
VEVSWTsKKwkJYnJlYWs7CiAJY2FzZSBQUF9TdGF0ZVVJTGFiZWxfQmFsYW5jZWQ6CiAJCXBtX3R5
cGUgPSBQT1dFUl9TVEFURV9UWVBFX0JBTEFOQ0VEOworCQlicmVhazsKIAljYXNlIFBQX1N0YXRl
VUlMYWJlbF9QZXJmb3JtYW5jZToKIAkJcG1fdHlwZSA9IFBPV0VSX1NUQVRFX1RZUEVfUEVSRk9S
TUFOQ0U7CisJCWJyZWFrOwogCWRlZmF1bHQ6CiAJCWlmIChzdGF0ZS0+Y2xhc3NpZmljYXRpb24u
ZmxhZ3MgJiBQUF9TdGF0ZUNsYXNzaWZpY2F0aW9uRmxhZ19Cb290KQogCQkJcG1fdHlwZSA9IFBP
V0VSX1NUQVRFX1RZUEVfSU5URVJOQUxfQk9PVDsKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==

From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 26/42] drm/amdgpu/gfx9: add support for vega12
Date: Wed, 21 Mar 2018 08:46:23 -0500
Message-ID: <20180321134639.18782-26-alexander.deucher@amd.com>
References: <20180321134639.18782-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180321134639.18782-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

U2FtZSBhcyB2ZWdhMTAgYW5kIHJhdmVuLgoKU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxh
bGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpSZXZpZXdlZC1ieTogRmVpZmVpIFh1IDxGZWlmZWku
WHVAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jIHwg
MiArKwogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nZnhfdjlfMC5jCmluZGV4IDVmNjExM2ViZmMzZi4uNjczYjgxODQxNTAwIDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMKQEAgLTEyNzEsNiArMTI3MSw3IEBAIHN0YXRp
YyBpbnQgZ2Z4X3Y5XzBfc3dfaW5pdCh2b2lkICpoYW5kbGUpCiAKIAlzd2l0Y2ggKGFkZXYtPmFz
aWNfdHlwZSkgewogCWNhc2UgQ0hJUF9WRUdBMTA6CisJY2FzZSBDSElQX1ZFR0ExMjoKIAljYXNl
IENISVBfUkFWRU46CiAJCWFkZXYtPmdmeC5tZWMubnVtX21lYyA9IDI7CiAJCWJyZWFrOwpAQCAt
NDQ3NSw2ICs0NDc2LDcgQEAgc3RhdGljIHZvaWQgZ2Z4X3Y5XzBfc2V0X3JsY19mdW5jcyhzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIHsKIAlzd2l0Y2ggKGFkZXYtPmFzaWNfdHlwZSkgewog
CWNhc2UgQ0hJUF9WRUdBMTA6CisJY2FzZSBDSElQX1ZFR0ExMjoKIAljYXNlIENISVBfUkFWRU46
CiAJCWFkZXYtPmdmeC5ybGMuZnVuY3MgPSAmZ2Z4X3Y5XzBfcmxjX2Z1bmNzOwogCQlicmVhazsK
LS0gCjIuMTMuNgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

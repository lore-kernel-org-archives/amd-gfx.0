From: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 05/10] drm/amdgpu: drop mmRLC_PG_CNTL clear
Date: Thu, 5 Jul 2018 17:09:30 +0800
Message-ID: <20180705090935.9638-5-evan.quan@amd.com>
References: <20180705090935.9638-1-evan.quan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180705090935.9638-1-evan.quan-5C7GfCeVMHo@public.gmane.org>
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
Cc: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>

VGhpcyBtYXkgYnJlYWsgZ2Z4b2ZmIHN1cHBvcnQgc2luY2UgdGhpcyByZWdpc3RlciB3aWxsCmJl
IHNldCBieSBzbWMgZncoZm9yIHZlZ2ExMiwgdGhhdCdzIHRoZSBjYXNlKS4KCkNoYW5nZS1JZDog
SWQzMTA4YzYzNjM0YTJmOTQxMjg5MDIxYmZiZDc4NTg4YzBmNmM0ZDYKU2lnbmVkLW9mZi1ieTog
RXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nZnhfdjlfMC5jIHwgMyAtLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCmluZGV4IDhkODcwZDRmODQxNC4uM2E3
NTY0MWEwNzFkIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlf
MC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMKQEAgLTIyOTAs
OSArMjI5MCw2IEBAIHN0YXRpYyBpbnQgZ2Z4X3Y5XzBfcmxjX3Jlc3VtZShzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldikKIAkvKiBkaXNhYmxlIENHICovCiAJV1JFRzMyX1NPQzE1KEdDLCAwLCBt
bVJMQ19DR0NHX0NHTFNfQ1RSTCwgMCk7CiAKLQkvKiBkaXNhYmxlIFBHICovCi0JV1JFRzMyX1NP
QzE1KEdDLCAwLCBtbVJMQ19QR19DTlRMLCAwKTsKLQogCWdmeF92OV8wX3JsY19yZXNldChhZGV2
KTsKIAogCWdmeF92OV8wX2luaXRfcGcoYWRldik7Ci0tIAoyLjE4LjAKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=

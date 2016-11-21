From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 56/76] drm/amd/dal: Remove unnecessary increment in scaler
 ratio calculation
Date: Mon, 21 Nov 2016 18:01:16 -0500
Message-ID: <20161121230136.5208-57-harry.wentland@amd.com>
References: <20161121230136.5208-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20161121230136.5208-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Jordan Lazare <Jordan.Lazare-5C7GfCeVMHo@public.gmane.org>

RnJvbTogSm9yZGFuIExhemFyZSA8Sm9yZGFuLkxhemFyZUBhbWQuY29tPgoKU2lnbmVkLW9mZi1i
eTogSm9yZGFuIExhemFyZSA8Sm9yZGFuLkxhemFyZUBhbWQuY29tPgpBY2tlZC1ieTogSGFycnkg
V2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kYWwvZGMvY29yZS9kY19yZXNvdXJjZS5jIHwgMyAtLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGFsL2RjL2NvcmUv
ZGNfcmVzb3VyY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGFsL2RjL2NvcmUvZGNfcmVzb3Vy
Y2UuYwppbmRleCA0ZTc2ZDVkYmJhYzAuLjA1NzgwNTI4NTllMyAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kYWwvZGMvY29yZS9kY19yZXNvdXJjZS5jCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGFsL2RjL2NvcmUvZGNfcmVzb3VyY2UuYwpAQCAtNDkzLDkgKzQ5Myw2IEBAIHN0
YXRpYyB2b2lkIGNhbGN1bGF0ZV9zY2FsaW5nX3JhdGlvcygKIAlwaXBlX2N0eC0+c2NsX2RhdGEu
cmF0aW9zLmhvcnoudmFsdWUgPSBkaXY2NF9zNjQoCiAJCXBpcGVfY3R4LT5zY2xfZGF0YS5yYXRp
b3MuaG9yei52YWx1ZSAqIGluX3csIG91dF93KTsKIAotCXBpcGVfY3R4LT5zY2xfZGF0YS5yYXRp
b3MuaG9yei52YWx1ZSsrOwotCXBpcGVfY3R4LT5zY2xfZGF0YS5yYXRpb3MudmVydC52YWx1ZSsr
OwotCiAJcGlwZV9jdHgtPnNjbF9kYXRhLnJhdGlvcy5ob3J6X2MgPSBwaXBlX2N0eC0+c2NsX2Rh
dGEucmF0aW9zLmhvcno7CiAJcGlwZV9jdHgtPnNjbF9kYXRhLnJhdGlvcy52ZXJ0X2MgPSBwaXBl
X2N0eC0+c2NsX2RhdGEucmF0aW9zLnZlcnQ7CiAKLS0gCjIuMTAuMQoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

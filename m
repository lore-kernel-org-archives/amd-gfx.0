From: Rex Zhu <rex.zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/amdgpu: fix a reversed condition
Date: Wed, 25 Jul 2018 13:03:13 +0800
Message-ID: <1532494993-23009-2-git-send-email-rex.zhu@amd.com>
References: <1532494993-23009-1-git-send-email-rex.zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1532494993-23009-1-git-send-email-rex.zhu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

VGhpcyB0ZXN0IHdhcyByZXZlcnNlZCBzbyBpdCB3b3VsZCBlbmQgdXAgbGVhZGluZyB0byB2ZGRu
YiB2YWx1ZQpjYW4ndCBiZSByZWFkIG9uIEFQVS4KClNpZ25lZC1vZmYtYnk6IFJleCBaaHUgPFJl
eC5aaHVAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcG0u
YyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wbS5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BtLmMKaW5kZXggMTVhMTE5Mi4uMjNmYzFk
MyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BtLmMKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BtLmMKQEAgLTExODUsNyArMTE4
NSw3IEBAIHN0YXRpYyBzc2l6ZV90IGFtZGdwdV9od21vbl9zaG93X3ZkZG5iKHN0cnVjdCBkZXZp
Y2UgKmRldiwKIAlpbnQgciwgc2l6ZSA9IHNpemVvZih2ZGRuYik7CiAKIAkvKiBvbmx5IEFQVXMg
aGF2ZSB2ZGRuYiAqLwotCWlmICAoYWRldi0+ZmxhZ3MgJiBBTURfSVNfQVBVKQorCWlmICAoIShh
ZGV2LT5mbGFncyAmIEFNRF9JU19BUFUpKQogCQlyZXR1cm4gLUVJTlZBTDsKIAogCS8qIENhbid0
IGdldCB2b2x0YWdlIHdoZW4gdGhlIGNhcmQgaXMgb2ZmICovCi0tIAoxLjkuMQoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

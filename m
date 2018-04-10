From: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 17/21] drm/amdkfd: Remove limit on number of GPUs (follow-up)
Date: Tue, 10 Apr 2018 17:33:14 -0400
Message-ID: <1523395998-31314-18-git-send-email-Felix.Kuehling@amd.com>
References: <1523395998-31314-1-git-send-email-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1523395998-31314-1-git-send-email-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>

VGhpcyBjb25kaXRpb24gd2FzIG1pc3NlZCBpbiBhIHByZXZpb3VzIGNvbW1pdCB3aXRoIHRoZSBz
YW1lIHRpdGxlLgoKU2lnbmVkLW9mZi1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5n
QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2ZsYXRfbWVtb3J5
LmMgfCA0ICstLS0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMyBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZmxhdF9tZW1v
cnkuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9mbGF0X21lbW9yeS5jCmluZGV4
IDY2ODUyZGUuLmYxNmFjMmIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2Zk
L2tmZF9mbGF0X21lbW9yeS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9m
bGF0X21lbW9yeS5jCkBAIC0zMDcsOSArMzA3LDcgQEAgaW50IGtmZF9pbml0X2FwZXJ0dXJlcyhz
dHJ1Y3Qga2ZkX3Byb2Nlc3MgKnByb2Nlc3MpCiAJc3RydWN0IGtmZF9wcm9jZXNzX2RldmljZSAq
cGRkOwogCiAJLypJdGVyYXRpbmcgb3ZlciBhbGwgZGV2aWNlcyovCi0Jd2hpbGUgKGtmZF90b3Bv
bG9neV9lbnVtX2tmZF9kZXZpY2VzKGlkLCAmZGV2KSA9PSAwICYmCi0JCWlkIDwgTlVNX09GX1NV
UFBPUlRFRF9HUFVTKSB7Ci0KKwl3aGlsZSAoa2ZkX3RvcG9sb2d5X2VudW1fa2ZkX2RldmljZXMo
aWQsICZkZXYpID09IDApIHsKIAkJaWYgKCFkZXYpIHsKIAkJCWlkKys7IC8qIFNraXAgbm9uIEdQ
VSBkZXZpY2VzICovCiAJCQljb250aW51ZTsKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK

From: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/4] drm/amdgpu/sriov:alloc KIQ MQD in VRAM
Date: Thu, 21 Sep 2017 15:12:22 +0800
Message-ID: <1505977944-9466-2-git-send-email-Monk.Liu@amd.com>
References: <1505977944-9466-1-git-send-email-Monk.Liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1505977944-9466-1-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

dGhpcyB3YXkgYWZ0ZXIgS0lRIE1RRCByZWxlYXNlZCBpbiBkcnYgdW5sb2FkaW5nLCBDUEMKY2Fu
IHN0aWxsIGxldCBLSVEgYWNjZXNzIHRoaXMgTVFEIHRodXMgUkxDViBTQVZFX1ZGCndpbGwgbm90
IGZhaWwKCkNoYW5nZS1JZDogSWNjZWYzN2E3MGMxOTNjODNhZjgwOTYxZGFlMmM2N2VkODU5ZjFh
MTMKU2lnbmVkLW9mZi1ieTogTW9uayBMaXUgPE1vbmsuTGl1QGFtZC5jb20+Ci0tLQogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2dmeC5jCmluZGV4IDRmNmM2OGYuLmQ4NTk2MmIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZnguYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZ2Z4LmMKQEAgLTI2MSw3ICsyNjEsNyBAQCBpbnQgYW1kZ3B1X2dmeF9j
b21wdXRlX21xZF9zd19pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCXJpbmcgPSAm
YWRldi0+Z2Z4LmtpcS5yaW5nOwogCWlmICghcmluZy0+bXFkX29iaikgewogCQlyID0gYW1kZ3B1
X2JvX2NyZWF0ZV9rZXJuZWwoYWRldiwgbXFkX3NpemUsIFBBR0VfU0laRSwKLQkJCQkJICAgIEFN
REdQVV9HRU1fRE9NQUlOX0dUVCwgJnJpbmctPm1xZF9vYmosCisJCQkJCSAgICAoYW1kZ3B1X3Ny
aW92X3ZmKGFkZXYpID8gQU1ER1BVX0dFTV9ET01BSU5fVlJBTSA6IEFNREdQVV9HRU1fRE9NQUlO
X0dUVCksICZyaW5nLT5tcWRfb2JqLAogCQkJCQkgICAgJnJpbmctPm1xZF9ncHVfYWRkciwgJnJp
bmctPm1xZF9wdHIpOwogCQlpZiAocikgewogCQkJZGV2X3dhcm4oYWRldi0+ZGV2LCAiZmFpbGVk
IHRvIGNyZWF0ZSByaW5nIG1xZCBvYiAoJWQpIiwgcik7Ci0tIAoyLjcuNAoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

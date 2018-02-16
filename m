From: Vijendar Mukunda <Vijendar.Mukunda-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 4/4] drm/amd/amdgpu: Fixes resource conflict issue on BT
 instance
Date: Fri, 16 Feb 2018 14:14:06 +0530
Message-ID: <1518770646-8538-5-git-send-email-Vijendar.Mukunda@amd.com>
References: <1518770646-8538-1-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1518770646-8538-1-git-send-email-Vijendar.Mukunda-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, Vijendar Mukunda <Vijendar.Mukunda-5C7GfCeVMHo@public.gmane.org>, Akshu Agrawal <akshu.agrawal-5C7GfCeVMHo@public.gmane.org>

RnJvbTogQWtzaHUgQWdyYXdhbCA8YWtzaHUuYWdyYXdhbEBhbWQuY29tPgoKVGhlIHBhdGNoIHVz
ZXMgc2hhcmVkIHJlc291cmNlcyB0byBtYXAgc2FtZSByZWdpc3RlciBhZGRyZXNzCnNwYWNlIG9u
IDIgY3B1IGRhaXMuCgpTaWduZWQtb2ZmLWJ5OiBBa3NodSBBZ3Jhd2FsIDxha3NodS5hZ3Jhd2Fs
QGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IFZpamVuZGFyIE11a3VuZGEgPFZpamVuZGFyLk11a3Vu
ZGFAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJA
YW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYWNwLmMgfCAx
ICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hY3AuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9hY3AuYwppbmRleCAxYmM0NjNhLi41OTg5MjFiIDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYWNwLmMKKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2FjcC5jCkBAIC0zOTgsNiArMzk4LDcgQEAgc3RhdGljIGludCBh
Y3BfaHdfaW5pdCh2b2lkICpoYW5kbGUpCiAJaTJzX3BkYXRhWzNdLnNuZF9yYXRlcyA9IFNORFJW
X1BDTV9SQVRFXzgwMDBfOTYwMDA7CiAJaTJzX3BkYXRhWzNdLmkyc19yZWdfY29tcDEgPSBBQ1Bf
QlRfQ09NUDFfUkVHX09GRlNFVDsKIAlpMnNfcGRhdGFbM10uaTJzX3JlZ19jb21wMiA9IEFDUF9C
VF9DT01QMl9SRUdfT0ZGU0VUOworCWkyc19wZGF0YVszXS5zaGFyZWQgPSB0cnVlOwogCiAJYWRl
di0+YWNwLmFjcF9yZXNbMF0ubmFtZSA9ICJhY3AyeF9kbWEiOwogCWFkZXYtPmFjcC5hY3BfcmVz
WzBdLmZsYWdzID0gSU9SRVNPVVJDRV9NRU07Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

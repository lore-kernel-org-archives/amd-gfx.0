From: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 04/25] drm/amdkfd: Fix error codes in kfd_get_process
Date: Wed, 11 Jul 2018 22:32:47 -0400
Message-ID: <1531362788-14470-5-git-send-email-Felix.Kuehling@amd.com>
References: <1531362788-14470-1-git-send-email-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1531362788-14470-1-git-send-email-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
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
Cc: Wei Lu <wei.lu2-5C7GfCeVMHo@public.gmane.org>, Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>

RnJvbTogV2VpIEx1IDx3ZWkubHUyQGFtZC5jb20+CgpSZXR1cm4gRVJSX1BUUigtRUlOVkFMKSBp
ZiBrZmRfZ2V0X3Byb2Nlc3MgZmFpbHMgdG8gZmluZCB0aGUgcHJvY2Vzcy4KVGhpcyBmaXhlcyBr
ZXJuZWwgb29wc2VzIHdoZW4gYSBjaGlsZCBwcm9jZXNzIGNhbGxzIEtGRCBpb2N0bHMgd2l0aAph
IGZpbGUgZGVzY3JpcHRvciBpbmhlcml0ZWQgZnJvbSB0aGUgcGFyZW50IHByb2Nlc3MuCgpTaWdu
ZWQtb2ZmLWJ5OiBXZWkgTHUgPHdlaS5sdTJAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IEZlbGl4IEt1
ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBGZWxpeCBLdWVo
bGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGtmZC9rZmRfcHJvY2Vzcy5jIHwgMiArKwogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jCmluZGV4IDFkODBiNGYu
LjQ2OTQzODYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9j
ZXNzLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYwpAQCAt
MjQ0LDYgKzI0NCw4IEBAIHN0cnVjdCBrZmRfcHJvY2VzcyAqa2ZkX2dldF9wcm9jZXNzKGNvbnN0
IHN0cnVjdCB0YXNrX3N0cnVjdCAqdGhyZWFkKQogCQlyZXR1cm4gRVJSX1BUUigtRUlOVkFMKTsK
IAogCXByb2Nlc3MgPSBmaW5kX3Byb2Nlc3ModGhyZWFkKTsKKwlpZiAoIXByb2Nlc3MpCisJCXJl
dHVybiBFUlJfUFRSKC1FSU5WQUwpOwogCiAJcmV0dXJuIHByb2Nlc3M7CiB9Ci0tIAoyLjcuNAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

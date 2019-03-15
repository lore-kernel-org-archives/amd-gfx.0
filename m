From: Bhawanpreet Lakha <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 09/26] drm/amd/display: extend EDID support to 1kb
Date: Fri, 15 Mar 2019 11:53:11 -0400
Message-ID: <20190315155328.10263-10-Bhawanpreet.Lakha@amd.com>
References: <20190315155328.10263-1-Bhawanpreet.Lakha@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190315155328.10263-1-Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>
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
Cc: Jun Lei <Jun.Lei-5C7GfCeVMHo@public.gmane.org>

RnJvbTogSnVuIExlaSA8SnVuLkxlaUBhbWQuY29tPgoKW3doeV0KVGhlcmUgZXhpc3QgZGlzcGxh
eXMgd2l0aCBFRElEcyA+IDUxMiBieXRlcywgZXhpc3RpbmcgY29kZQp3aWxsIGNhdXNlIHVzIHRv
IGlnbm9yZSBhbGwgZXh0ZW5zaW9uIGJsb2Nrcy4KCkNoYW5nZS1JZDogSTA0NThiYWY3ZjhjYzQx
ZjA0NDA1ZTI1ZjZlZmU4NDU2YzBiMDVhNTcKU2lnbmVkLW9mZi1ieTogSnVuIExlaSA8SnVuLkxl
aUBhbWQuY29tPgpSZXZpZXdlZC1ieTogV2VuamluZyBMaXUgPFdlbmppbmcuTGl1QGFtZC5jb20+
CkFja2VkLWJ5OiBCaGF3YW5wcmVldCBMYWtoYSA8Qmhhd2FucHJlZXQuTGFraGFAYW1kLmNvbT4K
LS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNfdHlwZXMuaCB8IDIgKy0KIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY190eXBlcy5oIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2RjX3R5cGVzLmgKaW5kZXggMmVkMzY4N2FiODUzLi4xMzBkMDM5
YWUxMzcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY190eXBl
cy5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY190eXBlcy5oCkBAIC0x
MTIsNyArMTEyLDcgQEAgc3RydWN0IGRjX2NvbnRleHQgewogfTsKIAogCi0jZGVmaW5lIERDX01B
WF9FRElEX0JVRkZFUl9TSVpFIDUxMgorI2RlZmluZSBEQ19NQVhfRURJRF9CVUZGRVJfU0laRSAx
MDI0CiAjZGVmaW5lIEVESURfQkxPQ0tfU0laRSAxMjgKICNkZWZpbmUgTUFYX1NVUkZBQ0VfTlVN
IDQKICNkZWZpbmUgTlVNX1BJWEVMX0ZPUk1BVFMgMTAKLS0gCjIuMTcuMQoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

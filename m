From: <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 25/45] drm/amd/display: Remove stream_status->link
Date: Tue, 11 Dec 2018 17:57:31 -0500
Message-ID: <1544569071-7114-26-git-send-email-sunpeng.li@amd.com>
References: <1544569071-7114-1-git-send-email-sunpeng.li@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1544569071-7114-1-git-send-email-sunpeng.li-5C7GfCeVMHo@public.gmane.org>
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
Cc: sunpeng.li-5C7GfCeVMHo@public.gmane.org

RnJvbTogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+CgpbV2h5XQpJdCdzIG5vdCBiZWluZyB1
c2VkIGFueXdoZXJlLgoKW0hvd10KUmVtb3ZlIGl0LgoKU2lnbmVkLW9mZi1ieTogTGVvIExpIDxz
dW5wZW5nLmxpQGFtZC5jb20+ClJldmlld2VkLWJ5OiBEYXZpZCBGcmFuY2lzIDxEYXZpZC5GcmFu
Y2lzQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjX3N0cmVh
bS5oIHwgNSAtLS0tLQogMSBmaWxlIGNoYW5nZWQsIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjX3N0cmVhbS5oIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjX3N0cmVhbS5oCmluZGV4IDBkZmFkNzMuLjFlMWU4OWUg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY19zdHJlYW0uaAor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNfc3RyZWFtLmgKQEAgLTM4LDEx
ICszOCw2IEBAIHN0cnVjdCBkY19zdHJlYW1fc3RhdHVzIHsKIAlpbnQgc3RyZWFtX2VuY19pbnN0
OwogCWludCBwbGFuZV9jb3VudDsKIAlzdHJ1Y3QgZGNfcGxhbmVfc3RhdGUgKnBsYW5lX3N0YXRl
c1tNQVhfU1VSRkFDRV9OVU1dOwotCi0JLyoKLQkgKiBsaW5rIHRoaXMgc3RyZWFtIHBhc3NlcyB0
aHJvdWdoCi0JICovCi0Jc3RydWN0IGRjX2xpbmsgKmxpbms7CiB9OwogCiAvLyBUT0RPOiBSZWZl
cmVuY2VzIHRvIHRoaXMgbmVlZHMgdG8gYmUgcmVtb3ZlZC4uCi0tIAoyLjcuNAoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

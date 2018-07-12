From: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 05/25] drm/amdkfd: When we get KFD_EVENT_TYPE_MEMORY we send
 the process SIGSEGV
Date: Wed, 11 Jul 2018 22:32:48 -0400
Message-ID: <1531362788-14470-6-git-send-email-Felix.Kuehling@amd.com>
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
Cc: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, Moses Reuben <moses.reuben-5C7GfCeVMHo@public.gmane.org>

RnJvbTogTW9zZXMgUmV1YmVuIDxtb3Nlcy5yZXViZW5AYW1kLmNvbT4KClNpZ25lZC1vZmYtYnk6
IE1vc2VzIFJldWJlbiA8bW9zZXMucmV1YmVuQGFtZC5jb20+ClJldmlld2VkLWJ5OiBGZWxpeCBL
dWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogRmVsaXggS3Vl
aGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX2V2ZW50cy5jIHwgNyArKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2V2ZW50
cy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2V2ZW50cy5jCmluZGV4IDU1NjJl
OTQuLjNkNWE4MzMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9l
dmVudHMuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZXZlbnRzLmMKQEAg
LTg1MCw2ICs4NTAsMTMgQEAgc3RhdGljIHZvaWQgbG9va3VwX2V2ZW50c19ieV90eXBlX2FuZF9z
aWduYWwoc3RydWN0IGtmZF9wcm9jZXNzICpwLAogCQkJCWV2LT5tZW1vcnlfZXhjZXB0aW9uX2Rh
dGEgPSAqZXZfZGF0YTsKIAkJfQogCisJaWYgKHR5cGUgPT0gS0ZEX0VWRU5UX1RZUEVfTUVNT1JZ
KSB7CisJCWRldl93YXJuKGtmZF9kZXZpY2UsCisJCQkiU2VuZGluZyBTSUdTRUdWIHRvIEhTQSBQ
cm9jZXNzIHdpdGggUElEICVkICIsCisJCQkJcC0+bGVhZF90aHJlYWQtPnBpZCk7CisJCXNlbmRf
c2lnKFNJR1NFR1YsIHAtPmxlYWRfdGhyZWFkLCAwKTsKKwl9CisKIAkvKiBTZW5kIFNJR1RFUk0g
bm8gZXZlbnQgb2YgdHlwZSAidHlwZSIgaGFzIGJlZW4gZm91bmQqLwogCWlmIChzZW5kX3NpZ25h
bCkgewogCQlpZiAoc2VuZF9zaWd0ZXJtKSB7Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

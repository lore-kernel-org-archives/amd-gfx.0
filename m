From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] drm/ttm: don't use compound pages for now
Date: Mon,  9 Oct 2017 17:55:03 +0200
Message-ID: <1507564503-8494-1-git-send-email-deathsimple@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

RnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKV2UgbmVl
ZCB0byBmaWd1cmUgb3V0IGZpcnN0IGhvdyB0byBjb3JyZWN0bHkgbWFwIHRoZW0gaW50byB0aGUg
Q1BVIHBhZ2UgdGFibGVzLgoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0
aWFuLmtvZW5pZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3BhZ2VfYWxs
b2NfZG1hLmMgfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3BhZ2VfYWxsb2NfZG1hLmMgYi9kcml2ZXJzL2dw
dS9kcm0vdHRtL3R0bV9wYWdlX2FsbG9jX2RtYS5jCmluZGV4IGU1ZWYxMGQuLjk2YWQxMjkgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3BhZ2VfYWxsb2NfZG1hLmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fcGFnZV9hbGxvY19kbWEuYwpAQCAtOTEzLDYgKzkxMyw3
IEBAIHN0YXRpYyBnZnBfdCB0dG1fZG1hX3Bvb2xfZ2ZwX2ZsYWdzKHN0cnVjdCB0dG1fZG1hX3R0
ICp0dG1fZG1hLCBib29sIGh1Z2UpCiAJaWYgKGh1Z2UpIHsKIAkJZ2ZwX2ZsYWdzIHw9IEdGUF9U
UkFOU0hVR0U7CiAJCWdmcF9mbGFncyAmPSB+X19HRlBfTU9WQUJMRTsKKwkJZ2ZwX2ZsYWdzICY9
IH5fX0dGUF9DT01QOwogCX0KIAogCXJldHVybiBnZnBfZmxhZ3M7Ci0tIAoyLjcuNAoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

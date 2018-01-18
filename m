From: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/ttm: Don't unreserve swapped BOs that were previously
 reserved
Date: Thu, 18 Jan 2018 11:56:17 -0500
Message-ID: <1516294577-29078-2-git-send-email-Felix.Kuehling@amd.com>
References: <1516294577-29078-1-git-send-email-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1516294577-29078-1-git-send-email-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org, Hongbo.He-5C7GfCeVMHo@public.gmane.org
Cc: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>

SWYgdHRtX2JvX3N3YXBvdXQgZG9lc24ndCBvd24gdGhlIGxvY2ssIGRvbid0IHJlbGVhc2UgaXQu
IFNvbWVvbmUKZWxzZSBwcm9iYWJseSBkZXBlbmRzIG9uIGl0IHN0aWxsIGJlaW5nIGxvY2tlZC4K
ClNpZ25lZC1vZmYtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgot
LS0KIGRyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvLmMgfCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL3R0bS90dG1fYm8uYyBiL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvLmMKaW5kZXgg
NjI1MThiNi4uODkzMDAzZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm8u
YworKysgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9iby5jCkBAIC0xNzgwLDggKzE3ODAsOCBA
QCBpbnQgdHRtX2JvX3N3YXBvdXQoc3RydWN0IHR0bV9ib19nbG9iYWwgKmdsb2IsIHN0cnVjdCB0
dG1fb3BlcmF0aW9uX2N0eCAqY3R4KQogCSAqIFVucmVzZXJ2ZSB3aXRob3V0IHB1dHRpbmcgb24g
TFJVIHRvIGF2b2lkIHN3YXBwaW5nIG91dCBhbgogCSAqIGFscmVhZHkgc3dhcHBlZCBidWZmZXIu
CiAJICovCi0KLQlyZXNlcnZhdGlvbl9vYmplY3RfdW5sb2NrKGJvLT5yZXN2KTsKKwlpZiAobG9j
a2VkKQorCQlyZXNlcnZhdGlvbl9vYmplY3RfdW5sb2NrKGJvLT5yZXN2KTsKIAlrcmVmX3B1dCgm
Ym8tPmxpc3Rfa3JlZiwgdHRtX2JvX3JlbGVhc2VfbGlzdCk7CiAJcmV0dXJuIHJldDsKIH0KLS0g
CjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK

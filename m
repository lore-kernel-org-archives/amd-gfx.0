From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v2 4/6] drm/amd/powerplay: update all printk to pr_* on
 eventmgr
Date: Mon, 26 Dec 2016 15:56:29 +0800
Message-ID: <1482738991-25373-5-git-send-email-ray.huang@amd.com>
References: <1482738991-25373-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1482738991-25373-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

U2lnbmVkLW9mZi1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL3Bvd2VycGxheS9ldmVudG1nci9ldmVudGluaXQuYyB8IDIgKy0KIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2V2ZW50bWdyL2V2ZW50aW5pdC5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvZXZlbnRtZ3IvZXZlbnRpbml0LmMKaW5kZXggZDVlYzhj
Yy4uYTNjZDIzMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvZXZl
bnRtZ3IvZXZlbnRpbml0LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvZXZl
bnRtZ3IvZXZlbnRpbml0LmMKQEAgLTE1MSw3ICsxNTEsNyBAQCBzdGF0aWMgaW50IHRoZXJtYWxf
aW50ZXJydXB0X2NhbGxiYWNrKHZvaWQgKnByaXZhdGVfZGF0YSwKIAkJCQkgICAgICB1bnNpZ25l
ZCBzcmNfaWQsIGNvbnN0IHVpbnQzMl90ICppdl9lbnRyeSkKIHsKIAkvKiBUTyBETyBoYW5sZSBQ
RU1fRXZlbnRfVGhlcm1hbE5vdGlmaWNhdGlvbiAoc3RydWN0IHBwX2V2ZW50bWdyICopcHJpdmF0
ZV9kYXRhKi8KLQlwcmludGsoImN1cnJlbnQgdGhlcm1hbCBpcyBvdXQgb2YgcmFuZ2UgXG4iKTsK
Kwlwcl9pbmZvKCJjdXJyZW50IHRoZXJtYWwgaXMgb3V0IG9mIHJhbmdlIFxuIik7CiAJcmV0dXJu
IDA7CiB9CiAKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK

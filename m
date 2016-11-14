From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/amdgpu: cleanup unused iterator members for sdma v2.4
Date: Mon, 14 Nov 2016 20:46:59 +0800
Message-ID: <1479127619-23643-2-git-send-email-ray.huang@amd.com>
References: <1479127619-23643-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1479127619-23643-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3YyXzQuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3NkbWFfdjJfNC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2Rt
YV92Ml80LmMKaW5kZXggMWYzZGNhYi4uNWE4MDgzNyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvc2RtYV92Ml80LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvc2RtYV92Ml80LmMKQEAgLTc4Myw3ICs3ODMsNyBAQCBzdGF0aWMgdm9pZCBzZG1hX3YyXzRf
dm1fd3JpdGVfcHRlKHN0cnVjdCBhbWRncHVfaWIgKmliLCB1aW50NjRfdCBwZSwKIAlpYi0+cHRy
W2liLT5sZW5ndGhfZHcrK10gPSBwZTsKIAlpYi0+cHRyW2liLT5sZW5ndGhfZHcrK10gPSB1cHBl
cl8zMl9iaXRzKHBlKTsKIAlpYi0+cHRyW2liLT5sZW5ndGhfZHcrK10gPSBuZHc7Ci0JZm9yICg7
IG5kdyA+IDA7IG5kdyAtPSAyLCAtLWNvdW50LCBwZSArPSA4KSB7CisJZm9yICg7IG5kdyA+IDA7
IG5kdyAtPSAyKSB7CiAJCWliLT5wdHJbaWItPmxlbmd0aF9kdysrXSA9IGxvd2VyXzMyX2JpdHMo
dmFsdWUpOwogCQlpYi0+cHRyW2liLT5sZW5ndGhfZHcrK10gPSB1cHBlcl8zMl9iaXRzKHZhbHVl
KTsKIAkJdmFsdWUgKz0gaW5jcjsKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK

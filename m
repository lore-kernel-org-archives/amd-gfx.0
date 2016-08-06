From: Lyude <cpaul-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/7] drm/radeon: Don't print error on aux transaction timeouts
Date: Fri,  5 Aug 2016 20:30:34 -0400
Message-ID: <1470443443-27252-3-git-send-email-cpaul@redhat.com>
References: <1470443443-27252-1-git-send-email-cpaul@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xorg-driver-ati-bounces-go0+a7rfsptAfugRpC6u6w@public.gmane.org>
In-Reply-To: <1470443443-27252-1-git-send-email-cpaul-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.x.org/mailman/options/xorg-driver-ati>,
 <mailto:xorg-driver-ati-request-go0+a7rfsptAfugRpC6u6w@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.x.org/archives/xorg-driver-ati>
List-Post: <mailto:xorg-driver-ati-go0+a7rfsptAfugRpC6u6w@public.gmane.org>
List-Help: <mailto:xorg-driver-ati-request-go0+a7rfsptAfugRpC6u6w@public.gmane.org?subject=help>
List-Subscribe: <https://lists.x.org/mailman/listinfo/xorg-driver-ati>,
 <mailto:xorg-driver-ati-request-go0+a7rfsptAfugRpC6u6w@public.gmane.org?subject=subscribe>
Errors-To: xorg-driver-ati-bounces-go0+a7rfsptAfugRpC6u6w@public.gmane.org
Sender: "xorg-driver-ati" <xorg-driver-ati-bounces-go0+a7rfsptAfugRpC6u6w@public.gmane.org>
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, xorg-driver-ati-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: amd-gfx.lists.freedesktop.org

U2luY2UgaXQncyBub3JtYWwgZm9yIERSTSB0byByZXRyeSBvdXIgYXV4IHRyYW5zYWN0aW9uIGhl
bHBlcnMgbXVsdGlwbGUKdGltZXMgaW4gYSByb3csIHVwIHRvIDMyIHRpbWVzIGZvciBlYWNoIGF0
dGVtcHRlZCB0cmFuc2FjdGlvbiwgd2UncmUKbWFraW5nIGEgbG90IG9mIG5vaXNlIHRoYXQgaXMg
bm8gbG9uZ2VyIG5lY2Vzc2FyeSBub3cgdGhhdCBEUk0gd2lsbCBqdXN0CnByaW50IHRoZSByZXR1
cm4gY29kZSB3ZSBnaXZlIGl0LgoKU2lnbmVkLW9mZi1ieTogTHl1ZGUgPGNwYXVsQHJlZGhhdC5j
b20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZHBfYXV4Y2guYyB8IDEgLQog
MSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vcmFkZW9uL3JhZGVvbl9kcF9hdXhjaC5jIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRl
b25fZHBfYXV4Y2guYwppbmRleCBkYjY0ZTAwLi4yZDQ2NTY0IDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kcF9hdXhjaC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9y
YWRlb24vcmFkZW9uX2RwX2F1eGNoLmMKQEAgLTE2NCw3ICsxNjQsNiBAQCByYWRlb25fZHBfYXV4
X3RyYW5zZmVyX25hdGl2ZShzdHJ1Y3QgZHJtX2RwX2F1eCAqYXV4LCBzdHJ1Y3QgZHJtX2RwX2F1
eF9tc2cgKm1zZwogCX0KIAogCWlmICh0bXAgJiBBVVhfU1dfUlhfVElNRU9VVCkgewotCQlEUk1f
REVCVUdfS01TKCJkcF9hdXhfY2ggdGltZWQgb3V0XG4iKTsKIAkJcmV0ID0gLUVUSU1FRE9VVDsK
IAkJZ290byBkb25lOwogCX0KLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwp4b3JnLWRyaXZlci1hdGkgbWFpbGluZyBsaXN0CnhvcmctZHJp
dmVyLWF0aUBsaXN0cy54Lm9yZwpodHRwczovL2xpc3RzLngub3JnL21haWxtYW4vbGlzdGluZm8v
eG9yZy1kcml2ZXItYXRpCg==

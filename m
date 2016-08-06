From: Lyude <cpaul-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/7] drm/dp_helper: Print first error received on failure in
 drm_dp_dpcd_access()
Date: Fri,  5 Aug 2016 20:30:33 -0400
Message-ID: <1470443443-27252-2-git-send-email-cpaul@redhat.com>
References: <1470443443-27252-1-git-send-email-cpaul@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1470443443-27252-1-git-send-email-cpaul-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, xorg-driver-ati-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Lyude <cpaul-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

U2luY2Ugd2UgYWx3YXlzIHJldHJ5IGluIGRybV9kcF9kcGNkX2FjY2VzcygpIHJlZ2FyZGxlc3Mg
b2YgdGhlIGVycm9yLAp3ZSdyZSBnb2luZyB0byBtYWtlIGEgbG90IG9mIG5vaXNlIGlmIHRoZSBh
dXgtPnRyYW5zZmVyIGZ1bmN0aW9uIHByaW50cwppdCdzIG93biBlcnJvcnMgKGFzIGlzIHRoZSBj
YXNlIHdpdGggcmFkZW9uKS4gSWYgd2UgY2FuIHByaW50IHRoZSBlcnJvcgpjb2RlIGhlcmUsIHRo
aXMgcmVkdWNlcyB0aGUgbmVlZCBmb3IgZHJpdmVycyB0byBkbyB0aGlzLiBTbyBpbnN0ZWFkIG9m
CmhhdmluZyB0byBwcmludCAiZHBfYXV4X2NoIHRpbWVkIG91dCIgb3ZlciAzMiB0aW1lcyB3ZSBj
YW4ganVzdCBwcmludApvbmNlLgoKU2lnbmVkLW9mZi1ieTogTHl1ZGUgPGNwYXVsQHJlZGhhdC5j
b20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2RybV9kcF9oZWxwZXIuYyB8IDIgKy0KIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9kcm1fZHBfaGVscGVyLmMgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX2RwX2hlbHBl
ci5jCmluZGV4IDhmMTFiODcuLjQzYmUxODkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9k
cm1fZHBfaGVscGVyLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2RybV9kcF9oZWxwZXIuYwpAQCAt
MjIzLDcgKzIyMyw3IEBAIHN0YXRpYyBpbnQgZHJtX2RwX2RwY2RfYWNjZXNzKHN0cnVjdCBkcm1f
ZHBfYXV4ICphdXgsIHU4IHJlcXVlc3QsCiAJCQllcnIgPSByZXQ7CiAJfQogCi0JRFJNX0RFQlVH
X0tNUygidG9vIG1hbnkgcmV0cmllcywgZ2l2aW5nIHVwXG4iKTsKKwlEUk1fREVCVUdfS01TKCJU
b28gbWFueSByZXRyaWVzLCBnaXZpbmcgdXAuIEZpcnN0IGVycm9yOiAlZFxuIiwgZXJyKTsKIAly
ZXQgPSBlcnI7CiAKIHVubG9jazoKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK

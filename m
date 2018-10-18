From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Subject: [PATCH 2/3] drm/sched: Expose drm_sched_entity_select_rq to use in
 drivers.
Date: Thu, 18 Oct 2018 14:44:20 -0400
Message-ID: <1539888261-331-2-git-send-email-andrey.grodzovsky@amd.com>
References: <1539888261-331-1-git-send-email-andrey.grodzovsky@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1539888261-331-1-git-send-email-andrey.grodzovsky@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, christian.koenig@amd.com
List-Id: amd-gfx.lists.freedesktop.org

U2lnbmVkLW9mZi1ieTogQW5kcmV5IEdyb2R6b3Zza3kgPGFuZHJleS5ncm9kem92c2t5QGFtZC5j
b20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYyB8IDEgKwog
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYyBiL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIv
c2NoZWRfZW50aXR5LmMKaW5kZXggMzIwYzc3YS4uNDI2NjA2YyAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYworKysgYi9kcml2ZXJzL2dwdS9kcm0v
c2NoZWR1bGVyL3NjaGVkX2VudGl0eS5jCkBAIC00OTIsNiArNDkyLDcgQEAgdm9pZCBkcm1fc2No
ZWRfZW50aXR5X3NlbGVjdF9ycShzdHJ1Y3QgZHJtX3NjaGVkX2VudGl0eSAqZW50aXR5KQogCWVu
dGl0eS0+cnEgPSBycTsKIAlzcGluX3VubG9jaygmZW50aXR5LT5ycV9sb2NrKTsKIH0KK0VYUE9S
VF9TWU1CT0woZHJtX3NjaGVkX2VudGl0eV9zZWxlY3RfcnEpOwogCiAvKioKICAqIGRybV9zY2hl
ZF9lbnRpdHlfcHVzaF9qb2IgLSBTdWJtaXQgYSBqb2IgdG8gdGhlIGVudGl0eSdzIGpvYiBxdWV1
ZQotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZl
bAo=

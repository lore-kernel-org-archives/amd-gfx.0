From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
Subject: [PATCH 1/4] drm/scheduler: trivial error handling fix
Date: Tue, 14 Aug 2018 10:12:23 +0200
Message-ID: <20180814081226.76086-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

UmV0dXJuIC1FTk9NRU0gd2hlbiBhbGxvY2F0aW5nIHRoZSBycV9saXN0IGZhaWxzLgoKU2lnbmVk
LW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgotLS0K
IGRyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvZ3B1X3NjaGVkdWxlci5jIHwgMyArKysKIDEgZmls
ZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
c2NoZWR1bGVyL2dwdV9zY2hlZHVsZXIuYyBiL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvZ3B1
X3NjaGVkdWxlci5jCmluZGV4IGY1NjY0MDVmNDllMy4uODVjMWY5NTc1MmNjIDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL2dwdV9zY2hlZHVsZXIuYworKysgYi9kcml2ZXJz
L2dwdS9kcm0vc2NoZWR1bGVyL2dwdV9zY2hlZHVsZXIuYwpAQCAtMTkxLDYgKzE5MSw5IEBAIGlu
dCBkcm1fc2NoZWRfZW50aXR5X2luaXQoc3RydWN0IGRybV9zY2hlZF9lbnRpdHkgKmVudGl0eSwK
IAllbnRpdHktPm51bV9ycV9saXN0ID0gbnVtX3JxX2xpc3Q7CiAJZW50aXR5LT5ycV9saXN0ID0g
a2NhbGxvYyhudW1fcnFfbGlzdCwgc2l6ZW9mKHN0cnVjdCBkcm1fc2NoZWRfcnEgKiksCiAJCQkJ
R0ZQX0tFUk5FTCk7CisJaWYgKCFlbnRpdHktPnJxX2xpc3QpCisJCXJldHVybiAtRU5PTUVNOwor
CiAJZm9yIChpID0gMDsgaSA8IG51bV9ycV9saXN0OyArK2kpCiAJCWVudGl0eS0+cnFfbGlzdFtp
XSA9IHJxX2xpc3RbaV07CiAJZW50aXR5LT5sYXN0X3NjaGVkdWxlZCA9IE5VTEw7Ci0tIAoyLjE0
LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1k
ZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=

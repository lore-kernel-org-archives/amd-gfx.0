From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH 4/6] drm/ttm: init locked again to prevent incorrect unlock
Date: Tue, 12 Dec 2017 11:37:01 +0100
Message-ID: <34aed9d4-dff3-7398-05bb-bc20f58a0f36@gmail.com>
References: <1513071228-29551-1-git-send-email-Hongbo.He@amd.com>
 <1513071228-29551-4-git-send-email-Hongbo.He@amd.com>
Reply-To: christian.koenig@amd.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1513071228-29551-4-git-send-email-Hongbo.He@amd.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Roger He <Hongbo.He@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

QW0gMTIuMTIuMjAxNyB1bSAxMDozMyBzY2hyaWViIFJvZ2VyIEhlOgo+IENoYW5nZS1JZDogSThk
YjUxZDg0Mzk1NWY1ZGIxNGJiNGJiZmY4OTJlYWVkYmQ5ZjBhYmUKPiBTaWduZWQtb2ZmLWJ5OiBS
b2dlciBIZSA8SG9uZ2JvLkhlQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5p
ZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKVGhhdCBpcyBhIGJ1ZyBmaXgsIGlzbid0IGl0
PyBJZiB5ZXMgbWF5YmUgYWRkIENDOnN0YWJsZSBhbmQgY29tbWl0IGl0IApmaXJzdCBiZWZvcmUg
YWxsIG90aGVyIHBhdGNoZXMuCgpDaHJpc3RpYW4uCgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJt
L3R0bS90dG1fYm8uYyB8IDEgKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm8uYyBiL2RyaXZlcnMvZ3B1
L2RybS90dG0vdHRtX2JvLmMKPiBpbmRleCAxN2ZlOGJlLi5lYjhjNTY4IDEwMDY0NAo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vdHRt
L3R0bV9iby5jCj4gQEAgLTczNSw2ICs3MzUsNyBAQCBzdGF0aWMgaW50IHR0bV9tZW1fZXZpY3Rf
Zmlyc3Qoc3RydWN0IHR0bV9ib19kZXZpY2UgKmJkZXYsCj4gICAJCQkJCQkJCSAgICAgIHBsYWNl
KSkgewo+ICAgCQkJCWlmIChsb2NrZWQpCj4gICAJCQkJCXJlc2VydmF0aW9uX29iamVjdF91bmxv
Y2soYm8tPnJlc3YpOwo+ICsJCQkJbG9ja2VkID0gZmFsc2U7Cj4gICAJCQkJY29udGludWU7Cj4g
ICAJCQl9Cj4gICAJCQlicmVhazsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2RyaS1kZXZlbAo=

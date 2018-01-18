From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH 1/2] drm/ttm: Don't add swapped BOs to swap-LRU list
Date: Thu, 18 Jan 2018 19:09:18 +0100
Message-ID: <8d81b35d-dd7c-3d9c-cb91-4978b59f95c8@gmail.com>
References: <1516294577-29078-1-git-send-email-Felix.Kuehling@amd.com>
Reply-To: christian.koenig@amd.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1516294577-29078-1-git-send-email-Felix.Kuehling@amd.com>
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
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, christian.koenig@amd.com, Hongbo.He@amd.com
List-Id: amd-gfx.lists.freedesktop.org

QW0gMTguMDEuMjAxOCB1bSAxNzo1NiBzY2hyaWViIEZlbGl4IEt1ZWhsaW5nOgo+IEEgQk8gdGhh
dCdzIGFscmVhZHkgc3dhcHBlZCB3b3VsZCBiZSBhZGRlZCBiYWNrIHRvIHRoZSBzd2FwLUxSVSBs
aXN0Cj4gZm9yIGV4YW1wbGUgaWYgaXRzIHZhbGlkYXRpb24gZmFpbGVkIHVuZGVyIGhpZ2ggbWVt
b3J5IHByZXNzdXJlLiBUaGlzCj4gY291bGQgbGF0ZXIgbGVhZCB0byBzd2FwcGluZyBpdCBvdXQg
YWdhaW4gYW5kIGxlYWtpbmcgcHJldmlvdXMgc3dhcAo+IHN0b3JhZ2UuCj4KPiBUaGlzIGNvbW1p
dCBhZGRzIGEgY29uZGl0aW9uIHRvIHByZXZlbnQgdGhhdCBmcm9tIGhhcHBlbmluZy4KPgo+IHYy
OiBDaGVjayBwYWdlX2ZsYWdzIGluc3RlYWQgb2Ygc3dhcF9zdG9yYWdlCj4KPiBTaWduZWQtb2Zm
LWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KClJldmlld2VkLWJ5
OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+IGZvciBib3RoLgoK
PiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvLmMgfCAzICsrLQo+ICAgMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvLmMgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9i
by5jCj4gaW5kZXggMmViNzFmZi4uNjI1MThiNiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vdHRtL3R0bV9iby5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm8uYwo+IEBA
IC0xNzAsNyArMTcwLDggQEAgdm9pZCB0dG1fYm9fYWRkX3RvX2xydShzdHJ1Y3QgdHRtX2J1ZmZl
cl9vYmplY3QgKmJvKQo+ICAgCQlsaXN0X2FkZF90YWlsKCZiby0+bHJ1LCAmbWFuLT5scnVbYm8t
PnByaW9yaXR5XSk7Cj4gICAJCWtyZWZfZ2V0KCZiby0+bGlzdF9rcmVmKTsKPiAgIAo+IC0JCWlm
IChiby0+dHRtICYmICEoYm8tPnR0bS0+cGFnZV9mbGFncyAmIFRUTV9QQUdFX0ZMQUdfU0cpKSB7
Cj4gKwkJaWYgKGJvLT50dG0gJiYgIShiby0+dHRtLT5wYWdlX2ZsYWdzICYKPiArCQkJCSAoVFRN
X1BBR0VfRkxBR19TRyB8IFRUTV9QQUdFX0ZMQUdfU1dBUFBFRCkpKSB7Cj4gICAJCQlsaXN0X2Fk
ZF90YWlsKCZiby0+c3dhcCwKPiAgIAkJCQkgICAgICAmYm8tPmdsb2ItPnN3YXBfbHJ1W2JvLT5w
cmlvcml0eV0pOwo+ICAgCQkJa3JlZl9nZXQoJmJvLT5saXN0X2tyZWYpOwoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlz
dApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH 1/3] drm/ttm: add set_pages_wb for handling page order
 more than zero
Date: Wed, 22 Nov 2017 12:53:05 +0100
Message-ID: <bff48364-cd41-322b-b0d8-2100cb08626c@gmail.com>
References: <1511351069-4757-1-git-send-email-Hongbo.He@amd.com>
Reply-To: christian.koenig@amd.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1511351069-4757-1-git-send-email-Hongbo.He@amd.com>
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

QW0gMjIuMTEuMjAxNyB1bSAxMjo0NCBzY2hyaWViIFJvZ2VyIEhlOgo+IENoYW5nZS1JZDogSWRm
NWNjYjU3OWQyNjRiMzQzMTk5ZDhiODM0NGJkZGVlYzJjMDAxOWYKPiBTaWduZWQtb2ZmLWJ5OiBS
b2dlciBIZSA8SG9uZ2JvLkhlQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5p
ZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPiBmb3IgdGhlIHdob2xlIApzZXJpZXMuCgo+IC0t
LQo+ICAgZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fcGFnZV9hbGxvYy5jIHwgMTEgKysrKysrKysr
KysKPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fcGFnZV9hbGxvYy5jIGIvZHJpdmVycy9ncHUvZHJtL3R0
bS90dG1fcGFnZV9hbGxvYy5jCj4gaW5kZXggYThiMmJmYS4uY2RiYjczMSAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9wYWdlX2FsbG9jLmMKPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vdHRtL3R0bV9wYWdlX2FsbG9jLmMKPiBAQCAtMjIzLDYgKzIyMywxNyBAQCBzdGF0aWMg
c3RydWN0IGtvYmpfdHlwZSB0dG1fcG9vbF9rb2JqX3R5cGUgPSB7Cj4gICBzdGF0aWMgc3RydWN0
IHR0bV9wb29sX21hbmFnZXIgKl9tYW5hZ2VyOwo+ICAgCj4gICAjaWZuZGVmIENPTkZJR19YODYK
PiArc3RhdGljIGludCBzZXRfcGFnZXNfd2Ioc3RydWN0IHBhZ2UgKnBhZ2UsIGludCBudW1wYWdl
cykKPiArewo+ICsjaWYgSVNfRU5BQkxFRChDT05GSUdfQUdQKQo+ICsJaW50IGk7Cj4gKwo+ICsJ
Zm9yIChpID0gMDsgaSA8IG51bXBhZ2VzOyBpKyspCj4gKwkJdW5tYXBfcGFnZV9mcm9tX2FncChw
YWdlKyspOwo+ICsjZW5kaWYKPiArCXJldHVybiAwOwo+ICt9Cj4gKwo+ICAgc3RhdGljIGludCBz
ZXRfcGFnZXNfYXJyYXlfd2Ioc3RydWN0IHBhZ2UgKipwYWdlcywgaW50IGFkZHJpbmFycmF5KQo+
ICAgewo+ICAgI2lmIElTX0VOQUJMRUQoQ09ORklHX0FHUCkKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1k
ZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK

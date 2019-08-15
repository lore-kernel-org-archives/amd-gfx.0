From: Jerome Glisse <jglisse@redhat.com>
Subject: Re: [PATCH] mm/hmm: hmm_range_fault handle pages swapped out
Date: Thu, 15 Aug 2019 17:02:53 -0400
Message-ID: <20190815210253.GD25517@redhat.com>
References: <20190815205227.7949-1-Philip.Yang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20190815205227.7949-1-Philip.Yang@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: "Yang, Philip" <Philip.Yang@amd.com>
Cc: "alex.deucher@amd.com" <alex.deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "jgg@mellanox.com" <jgg@mellanox.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gVGh1LCBBdWcgMTUsIDIwMTkgYXQgMDg6NTI6NTZQTSArMDAwMCwgWWFuZywgUGhpbGlwIHdy
b3RlOgo+IGhtbV9yYW5nZV9mYXVsdCBtYXkgcmV0dXJuIE5VTEwgcGFnZXMgYmVjYXVzZSBzb21l
IG9mIHBmbnMgYXJlIGVxdWFsIHRvCj4gSE1NX1BGTl9OT05FLiBUaGlzIGhhcHBlbnMgcmFuZG9t
bHkgdW5kZXIgbWVtb3J5IHByZXNzdXJlLiBUaGUgcmVhc29uIGlzCj4gZm9yIHN3YXBwZWQgb3V0
IHBhZ2UgcHRlIHBhdGgsIGhtbV92bWFfaGFuZGxlX3B0ZSBkb2Vzbid0IHVwZGF0ZSBmYXVsdAo+
IHZhcmlhYmxlIGZyb20gY3B1X2ZsYWdzLCBzbyBpdCBmYWlsZWQgdG8gY2FsbCBobW1fdmFtX2Rv
X2ZhdWx0IHRvIHN3YXAKPiB0aGUgcGFnZSBpbi4KPiAKPiBUaGUgZml4IGlzIHRvIGNhbGwgaG1t
X3B0ZV9uZWVkX2ZhdWx0IHRvIHVwZGF0ZSBmYXVsdCB2YXJpYWJsZS4KPiAKPiBDaGFuZ2UtSWQ6
IEkyZTg2MTE0ODU1NjNkMTFkOTM4ODgxYzE4Yjc5MzVmYTFlN2M5MWVlCj4gU2lnbmVkLW9mZi1i
eTogUGhpbGlwIFlhbmcgPFBoaWxpcC5ZYW5nQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogSsOpcsO0
bWUgR2xpc3NlIDxqZ2xpc3NlQHJlZGhhdC5jb20+Cgo+IC0tLQo+ICBtbS9obW0uYyB8IDMgKysr
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvbW0v
aG1tLmMgYi9tbS9obW0uYwo+IGluZGV4IDlmMjI1NjJlMmM0My4uN2NhNGZiMzlkM2Q4IDEwMDY0
NAo+IC0tLSBhL21tL2htbS5jCj4gKysrIGIvbW0vaG1tLmMKPiBAQCAtNTQ0LDYgKzU0NCw5IEBA
IHN0YXRpYyBpbnQgaG1tX3ZtYV9oYW5kbGVfcHRlKHN0cnVjdCBtbV93YWxrICp3YWxrLCB1bnNp
Z25lZCBsb25nIGFkZHIsCj4gIAkJc3dwX2VudHJ5X3QgZW50cnkgPSBwdGVfdG9fc3dwX2VudHJ5
KHB0ZSk7Cj4gIAo+ICAJCWlmICghbm9uX3N3YXBfZW50cnkoZW50cnkpKSB7Cj4gKwkJCWNwdV9m
bGFncyA9IHB0ZV90b19obW1fcGZuX2ZsYWdzKHJhbmdlLCBwdGUpOwo+ICsJCQlobW1fcHRlX25l
ZWRfZmF1bHQoaG1tX3ZtYV93YWxrLCBvcmlnX3BmbiwgY3B1X2ZsYWdzLAo+ICsJCQkJCSAgICZm
YXVsdCwgJndyaXRlX2ZhdWx0KTsKPiAgCQkJaWYgKGZhdWx0IHx8IHdyaXRlX2ZhdWx0KQo+ICAJ
CQkJZ290byBmYXVsdDsKPiAgCQkJcmV0dXJuIDA7Cj4gLS0gCj4gMi4xNy4xCj4gCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5n
IGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbA==

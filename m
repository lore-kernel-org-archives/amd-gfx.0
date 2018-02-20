From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/3] locking/ww_mutex: cleanup lock->ctx usage in amdgpu
Date: Tue, 20 Feb 2018 13:35:32 +0100
Message-ID: <20180220123532.GD25314@hirez.programming.kicks-ass.net>
References: <20180215141944.4332-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20180215141944.4332-1-christian.koenig@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

ClRoaXMgcmVhbGx5IHNob3VsZCd2ZSBiZWVuIENjJ2VkIHRvIG1lLgoKT24gVGh1LCBGZWIgMTUs
IDIwMTggYXQgMDM6MTk6NDJQTSArMDEwMCwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9saW51eC93d19tdXRleC5oIGIvaW5jbHVkZS9saW51eC93d19tdXRl
eC5oCj4gaW5kZXggMzlmZGExOTViZjc4Li5kZDU4MGRiMjg5ZTggMTAwNjQ0Cj4gLS0tIGEvaW5j
bHVkZS9saW51eC93d19tdXRleC5oCj4gKysrIGIvaW5jbHVkZS9saW51eC93d19tdXRleC5oCj4g
QEAgLTM1OCw0ICszNTgsMjEgQEAgc3RhdGljIGlubGluZSBib29sIHd3X211dGV4X2lzX2xvY2tl
ZChzdHJ1Y3Qgd3dfbXV0ZXggKmxvY2spCj4gIAlyZXR1cm4gbXV0ZXhfaXNfbG9ja2VkKCZsb2Nr
LT5iYXNlKTsKPiAgfQo+ICAKPiArLyoqCj4gKyAqIHd3X211dGV4X2lzX293bmVkX2J5IC0gaXMg
dGhlIHcvdyBtdXRleCBsb2NrZWQgYnkgdGhpcyB0YXNrIGluIHRoYXQgY29udGV4dAo+ICsgKiBA
bG9jazogdGhlIG11dGV4IHRvIGJlIHF1ZXJpZWQKPiArICogQHRhc2s6IHRoZSB0YXNrIHN0cnVj
dHVyZSB0byBjaGVjawo+ICsgKiBAY3R4OiB0aGUgdy93IGFjcXVpcmUgY29udGV4dCB0byB0ZXN0
Cj4gKyAqCj4gKyAqIFJldHVybnMgdHJ1ZSBpZiB0aGUgbXV0ZXggaXMgbG9ja2VkIGluIHRoZSBj
b250ZXh0IGJ5IHRoZSBnaXZlbiB0YXNrLCBmYWxzZQo+ICsgKiBvdGhlcndpc2UuCj4gKyAqLwo+
ICtzdGF0aWMgaW5saW5lIGJvb2wgd3dfbXV0ZXhfaXNfb3duZWRfYnkoc3RydWN0IHd3X211dGV4
ICpsb2NrLAo+ICsJCQkJCXN0cnVjdCB0YXNrX3N0cnVjdCAqdGFzaywKPiArCQkJCQlzdHJ1Y3Qg
d3dfYWNxdWlyZV9jdHggKmN0eCkKPiArewo+ICsJcmV0dXJuIGxpa2VseShfX211dGV4X293bmVy
KCZsb2NrLT5iYXNlKSA9PSB0YXNrKSAmJgo+ICsJCVJFQURfT05DRShsb2NrLT5jdHgpID09IGN0
eDsKPiArfQoKTmFrIG9uIHRoYXQgaW50ZXJmYWNlLCB0aGF0J3MgcmFjeSBhbmQgYnJva2VuIGJ5
IGRlc2lnbi4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=

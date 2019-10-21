From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH hmm 02/15] mm/mmu_notifier: add an interval tree notifier
Date: Mon, 21 Oct 2019 19:24:53 +0000
Message-ID: <20191021192448.GK6285@mellanox.com>
References: <20191015181242.8343-1-jgg@ziepe.ca>
 <20191015181242.8343-3-jgg@ziepe.ca> <20191021183056.GA3177@redhat.com>
 <20191021185421.GG6285@mellanox.com> <20191021191157.GA5208@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20191021191157.GA5208@redhat.com>
Content-Language: en-US
Content-ID: <0EDBBF2131C9044CB11AA3ED64A52B60@eurprd05.prod.outlook.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Jerome Glisse <jglisse@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, John Hubbard <jhubbard@nvidia.com>, "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Michal Hocko <mhocko@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Ben Skeggs <bskeggs@redhat.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gTW9uLCBPY3QgMjEsIDIwMTkgYXQgMDM6MTE6NTdQTSAtMDQwMCwgSmVyb21lIEdsaXNzZSB3
cm90ZToKPiA+IFNpbmNlIHRoYXQgcmVhZGVyIGlzIG5vdCBsb2NrZWQgd2UgbmVlZCByZWxlYXNl
IHNlbWFudGljcyBoZXJlIHRvCj4gPiBlbnN1cmUgdGhlIHVubG9ja2VkIHJlYWRlciBzZWVzIGEg
ZnVsbHkgaW5pdGluYWxpemVkIG1tdV9ub3RpZmllcl9tbQo+ID4gc3RydWN0dXJlIHdoZW4gaXQg
b2JzZXJ2ZXMgdGhlIHBvaW50ZXIuCj4gCj4gSSB0aG91Z2h0IHRoZSBtbV90YWtlX2FsbF9sb2Nr
cygpIHdvdWxkIGhhdmUgaGFkIGEgYmFycmllciBhbmQgdGh1cwo+IHRoYXQgeW91IGNvdWxkIG5v
dCBzZWUgbW11X25vdGlmaWVyIHN0cnVjdCBwYXJ0aWFseSBpbml0aWFsaXplZC4gCgpOb3Qgc3Vy
ZSwgdXN1YWxseSBhIGxvY2sgYWNxdWlyZSBkb2Vzbid0IGhhdmUgYSBzdG9yZSBiYXJyaWVyPwoK
RXZlbiBpZiBpdCBkaWQsIHdlIHdvdWxkIHN0aWxsIG5lZWQgc29tZSBwYWlyaW5nIHJlYWQgYmFy
cmllci4uCgo+IGhhdmluZyB0aGUgYWNxdWlyZS9yZWxlYXNlIGFzIHNhZmV0eSBuZXQgZG9lcyBu
b3QgaHVydC4gTWF5YmUgYWRkIGEKPiBjb21tZW50IGFib3V0IHRoZSBzdHJ1Y3QgaW5pdGlhbGl6
YXRpb24gbmVlZGluZyB0byBiZSB2aXNpYmxlIGJlZm9yZQo+IHBvaW50ZXIgaXMgc2V0LgoKSXMg
dGhpcyBjbGVhcj8KCiAgICAgICAgICogcmVsZWFzZSBzZW1hbnRpY3Mgb24gdGhlIGluaXRpYWxp
emF0aW9uIG9mIHRoZQogICAgICAgICAqIG1tdV9ub3RpZmllcl9tbSdzIGNvbnRlbnRzIGFyZSBw
cm92aWRlZCBmb3IgdW5sb2NrZWQgcmVhZGVycy4KCSAqIGFjcXVpcmUgY2FuIG9ubHkgYmUgdXNl
ZCB3aGlsZSBob2xkaW5nIHRoZQogICAgICAgICAqIG1tZ3JhYiBvciBtbWdldCwgYW5kIGlzIHNh
ZmUgYmVjYXVzZSBvbmNlIGNyZWF0ZWQgdGhlCiAgICAgICAgICogbW11X25vdGlmaWZlcl9tbSBp
cyBub3QgZnJlZWQgdW50aWwgdGhlIG1tIGlzIGRlc3Ryb3llZC4KICAgICAgICAgKiBVc2VycyBo
b2xkaW5nIHRoZSBtbWFwX3NlbSBvciBvbmUgb2YgdGhlCgkgKiBtbV90YWtlX2FsbF9sb2Nrcygp
IGRvIG5vdCBuZWVkIHRvIHVzZSBhY3F1aXJlIHNlbWFudGljcy4KCkl0IGFsc28gaGVscHMgZXhw
bGFpbiB3aHkgdGhlcmUgaXMgbm8gbG9ja2luZyBhcm91bmQgdGhlIG90aGVyCnJlYWRlcnMsIHdo
aWNoIGhhcyBwdXp6bGVkIG1lIGluIHRoZSBwYXN0IGF0IGxlYXN0LgoKSmFzb24KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcg
bGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs

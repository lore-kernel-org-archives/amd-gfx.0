From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH v2 09/15] xen/gntdev: use
 mmu_range_notifier_insert
Date: Fri, 1 Nov 2019 19:17:27 +0000
Message-ID: <20191101191723.GT22766@mellanox.com>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-10-jgg@ziepe.ca>
 <0355257f-6a3a-cdcd-d206-aec3df97dded@oracle.com>
 <20191101174824.GP22766@mellanox.com>
 <14f96c2e-ee04-5b1a-fc32-2db1487df399@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xenproject.org>
In-Reply-To: <14f96c2e-ee04-5b1a-fc32-2db1487df399@oracle.com>
Content-Language: en-US
Content-ID: <18553814D461244CA039C5C384EE49D3@eurprd05.prod.outlook.com>
List-Unsubscribe: <https://lists.xenproject.org/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xenproject.org>
List-Help: <mailto:xen-devel-request@lists.xenproject.org?subject=help>
List-Subscribe: <https://lists.xenproject.org/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xenproject.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xenproject.org>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>, David Zhou <David1.Zhou@amd.com>, Ralph Campbell <rcampbell@nvidia.com>, Stefano Stabellini <sstabellini@kernel.org>, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, John Hubbard <jhubbard@nvidia.com>, "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>, Mike Marciniszyn <mike.marciniszyn@intel.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Christoph Hellwig <hch@infradead.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Jerome Glisse <jglisse@redhat.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Dennis Dalessandro <dennis.dalessandro@intel.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gRnJpLCBOb3YgMDEsIDIwMTkgYXQgMDI6NTE6NDZQTSAtMDQwMCwgQm9yaXMgT3N0cm92c2t5
IHdyb3RlOgo+IE9uIDExLzEvMTkgMTo0OCBQTSwgSmFzb24gR3VudGhvcnBlIHdyb3RlOgo+ID4g
T24gV2VkLCBPY3QgMzAsIDIwMTkgYXQgMTI6NTU6MzdQTSAtMDQwMCwgQm9yaXMgT3N0cm92c2t5
IHdyb3RlOgo+ID4+IE9uIDEwLzI4LzE5IDQ6MTAgUE0sIEphc29uIEd1bnRob3JwZSB3cm90ZToK
PiA+Pj4gRnJvbTogSmFzb24gR3VudGhvcnBlIDxqZ2dAbWVsbGFub3guY29tPgo+ID4+Pgo+ID4+
PiBnbnRkZXYgc2ltcGx5IHdhbnRzIHRvIG1vbml0b3IgYSBzcGVjaWZpYyBWTUEgZm9yIGFueSBu
b3RpZmllciBldmVudHMsCj4gPj4+IHRoaXMgY2FuIGJlIGRvbmUgc3RyYWlnaHRmb3J3YXJkbHkg
dXNpbmcgbW11X3JhbmdlX25vdGlmaWVyX2luc2VydCgpIG92ZXIKPiA+Pj4gdGhlIFZNQSdzIFZB
IHJhbmdlLgo+ID4+Pgo+ID4+PiBUaGUgbm90aWZpZXIgc2hvdWxkIGJlIGF0dGFjaGVkIHVudGls
IHRoZSBvcmlnaW5hbCBWTUEgaXMgZGVzdHJveWVkLgo+ID4+Pgo+ID4+PiBJdCBpcyB1bmNsZWFy
IGlmIGFueSBvZiB0aGlzIGlzIGV2ZW4gc2FuZSwgYnV0IGF0IGxlYXN0IGEgbG90IG9mIGR1cGxp
Y2F0ZQo+ID4+PiBjb2RlIGlzIHJlbW92ZWQuCj4gPj4gSSBkaWRuJ3QgaGF2ZSBhIGNoYW5jZSB0
byBsb29rIGF0IHRoZSBwYXRjaCBpdHNlbGYgeWV0IGJ1dCBhcyBhIGhlYWRzLXVwCj4gPiBUaGFu
a3MgQm9yaXMuIEkgc3BlbnQgYSBiaXQgb2YgdGltZSBhbmQgZ290IGEgVk0gcnVubmluZyB3aXRo
IGEgeGVuCj4gPiA0LjkgaHlwZXJ2aXNvciBhbmQgYSBrZXJuZWwgd2l0aCB0aGlzIHBhdGNoIHNl
cmllcy4gSXQgYSB1YnVudHUgYmlvbmljCj4gPiBWTSB3aXRoIHRoZSBkaXN0cm8ncyB4ZW4gc3R1
ZmYuCj4gPgo+ID4gQ2FuIHlvdSBnaXZlIHNvbWUgZ3VpZGFuY2UgaG93IHlvdSBtYWRlIGl0IGNy
YXNoPyAKPiAKPiBJdCBjcmFzaGVzIHRyeWluZyB0byBkZXJlZmVyZW5jZSBtcm4tPm9wcy0+aW52
YWxpZGF0ZSBpbgo+IG1uX2l0cmVlX2ludmFsaWRhdGUoKSB3aGVuIGEgZ3Vlc3QgZXhpdHMuCj4g
Cj4gSSBkb24ndCB0aGluayB5b3UndmUgaW5pdGlhbGl6ZWQgbm90aWZpZXIgb3BzLiBJIGRvbid0
IHNlZSB5b3UgdXNpbmcKPiBnbnRkZXZfbW11X29wcyBhbnl3aGVyZS4KClNvIHdlaXJkIHRoZSBj
b21waWxlciBkaWRuJ3QgY29tcGxhaW4gYWJvdXQgYW4gdW51c2VkIHN0YXRpYy4uLgoKQnV0IHll
cywgdGhpcyBpcyBhIG1pc3Rha2UsIGl0IHNob3VsZCBiZToKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L3hlbi9nbnRkZXYuYyBiL2RyaXZlcnMveGVuL2dudGRldi5jCmluZGV4IDM3YjI3ODg1N2FkODA3
Li4wY2EzNTQ4NWZkMzg2NSAxMDA2NDQKLS0tIGEvZHJpdmVycy94ZW4vZ250ZGV2LmMKKysrIGIv
ZHJpdmVycy94ZW4vZ250ZGV2LmMKQEAgLTEwMTEsNiArMTAxMSw3IEBAIHN0YXRpYyBpbnQgZ250
ZGV2X21tYXAoc3RydWN0IGZpbGUgKmZsaXAsIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hKQog
CiAJaWYgKHVzZV9wdGVtb2QpIHsKIAkJbWFwLT52bWEgPSB2bWE7CisJCW1hcC0+bm90aWZpZXIu
b3BzID0gJmdudGRldl9tbXVfb3BzOwogCQllcnIgPSBtbXVfcmFuZ2Vfbm90aWZpZXJfaW5zZXJ0
X2xvY2tlZCgKIAkJCSZtYXAtPm5vdGlmaWVyLCB2bWEtPnZtX3N0YXJ0LAogCQkJdm1hLT52bV9l
bmQgLSB2bWEtPnZtX3N0YXJ0LCB2bWEtPnZtX21tKTsKClRoYW5rcywKSmFzb24KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClhlbi1kZXZlbCBtYWlsaW5n
IGxpc3QKWGVuLWRldmVsQGxpc3RzLnhlbnByb2plY3Qub3JnCmh0dHBzOi8vbGlzdHMueGVucHJv
amVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby94ZW4tZGV2ZWw=

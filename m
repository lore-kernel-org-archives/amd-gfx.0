From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 09/15] xen/gntdev: use
 mmu_range_notifier_insert
Date: Fri, 8 Nov 2019 10:53:01 -0400
Message-ID: <20191108145301.GD10956@ziepe.ca>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-10-jgg@ziepe.ca>
 <3938b588-c6c5-3bd1-8ea9-47e4d5b2045c@oracle.com>
 <20191105023108.GN22766@mellanox.com>
 <a62e58f6-d98b-1feb-d0ca-fb8210f3e831@oracle.com>
 <20191107203629.GF6730@ziepe.ca>
 <4a68acc6-3ce7-e26b-2c98-774867288410@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xenproject.org>
Content-Disposition: inline
In-Reply-To: <4a68acc6-3ce7-e26b-2c98-774867288410@oracle.com>
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

T24gVGh1LCBOb3YgMDcsIDIwMTkgYXQgMDU6NTQ6NTJQTSAtMDUwMCwgQm9yaXMgT3N0cm92c2t5
IHdyb3RlOgo+IE9uIDExLzcvMTkgMzozNiBQTSwgSmFzb24gR3VudGhvcnBlIHdyb3RlOgo+ID4g
T24gVHVlLCBOb3YgMDUsIDIwMTkgYXQgMTA6MTY6NDZBTSAtMDUwMCwgQm9yaXMgT3N0cm92c2t5
IHdyb3RlOgo+ID4KPiA+Pj4gU28sIEkgc3VwcG9zZSBpdCBjYW4gYmUgcmVsYXhlZCB0byBhIG51
bGwgdGVzdCBhbmQgYSBXQVJOX09OIHRoYXQgaXQKPiA+Pj4gaGFzbid0IGNoYW5nZWQ/Cj4gPj4g
WW91IG1lYW4KPiA+Pgo+ID4+IGlmICh1c2VfcHRlbW9kKSB7Cj4gPj4gwqDCoMKgwqDCoMKgwqAg
V0FSTl9PTihtYXAtPnZtYSAhPSB2bWEpOwo+ID4+IMKgwqDCoMKgwqDCoMKgIC4uLgo+ID4+Cj4g
Pj4KPiA+PiBZZXMsIHRoYXQgc291bmRzIGdvb2QuCj4gPiBJIGFtZW5kZWQgbXkgY29weSBvZiB0
aGUgcGF0Y2ggd2l0aCB0aGUgYWJvdmUsIGhhcyB0aGlzIHJld29yayBzaG93bgo+ID4gc2lnbnMg
b2Ygd29ya2luZz8KPiAKPiBZZXMsIGl0IHdvcmtzIGZpbmUuCj4gCj4gQnV0IHBsZWFzZSBkb24n
dCBmb3JnZXQgbm90aWZpZXIgb3BzIGluaXRpYWxpemF0aW9uLgo+IAo+IFdpdGggdGhvc2UgdHdv
IGNoYW5nZXMsCj4gCj4gUmV2aWV3ZWQtYnk6IEJvcmlzIE9zdHJvdnNreSA8Ym9yaXMub3N0cm92
c2t5QG9yYWNsZS5jb20+CgpUaGFua3MsIEkgZ290IGJvdGggdGhpbmdzLiBJJ2xsIGZvcndhcmQg
dGhpcyB0b3dhcmQgbGludXgtbmV4dCBhbmQKcmVwb3N0IGEgdjMgCgpKYXNvbgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KWGVuLWRldmVsIG1haWxpbmcg
bGlzdApYZW4tZGV2ZWxAbGlzdHMueGVucHJvamVjdC5vcmcKaHR0cHM6Ly9saXN0cy54ZW5wcm9q
ZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3hlbi1kZXZlbA==

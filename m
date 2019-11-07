From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH v2 09/15] xen/gntdev: use mmu_range_notifier_insert
Date: Thu, 7 Nov 2019 17:54:52 -0500
Message-ID: <4a68acc6-3ce7-e26b-2c98-774867288410@oracle.com>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-10-jgg@ziepe.ca>
 <3938b588-c6c5-3bd1-8ea9-47e4d5b2045c@oracle.com>
 <20191105023108.GN22766@mellanox.com>
 <a62e58f6-d98b-1feb-d0ca-fb8210f3e831@oracle.com>
 <20191107203629.GF6730@ziepe.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20191107203629.GF6730@ziepe.ca>
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
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Juergen Gross <jgross@suse.com>, Ralph Campbell <rcampbell@nvidia.com>, Stefano Stabellini <sstabellini@kernel.org>, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, John Hubbard <jhubbard@nvidia.com>, "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>, Mike Marciniszyn <mike.marciniszyn@intel.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Christoph Hellwig <hch@infradead.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Jerome Glisse <jglisse@redhat.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Dennis Dalessandro <dennis.dalessandro@intel.com>, Petr Cvek <petrcvekcz@gmail.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gMTEvNy8xOSAzOjM2IFBNLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6Cj4gT24gVHVlLCBOb3Yg
MDUsIDIwMTkgYXQgMTA6MTY6NDZBTSAtMDUwMCwgQm9yaXMgT3N0cm92c2t5IHdyb3RlOgo+Cj4+
PiBTbywgSSBzdXBwb3NlIGl0IGNhbiBiZSByZWxheGVkIHRvIGEgbnVsbCB0ZXN0IGFuZCBhIFdB
Uk5fT04gdGhhdCBpdAo+Pj4gaGFzbid0IGNoYW5nZWQ/Cj4+IFlvdSBtZWFuCj4+Cj4+IGlmICh1
c2VfcHRlbW9kKSB7Cj4+IMKgwqDCoMKgwqDCoMKgIFdBUk5fT04obWFwLT52bWEgIT0gdm1hKTsK
Pj4gwqDCoMKgwqDCoMKgwqAgLi4uCj4+Cj4+Cj4+IFllcywgdGhhdCBzb3VuZHMgZ29vZC4KPiBJ
IGFtZW5kZWQgbXkgY29weSBvZiB0aGUgcGF0Y2ggd2l0aCB0aGUgYWJvdmUsIGhhcyB0aGlzIHJl
d29yayBzaG93bgo+IHNpZ25zIG9mIHdvcmtpbmc/CgpZZXMsIGl0IHdvcmtzIGZpbmUuCgpCdXQg
cGxlYXNlIGRvbid0IGZvcmdldCBub3RpZmllciBvcHMgaW5pdGlhbGl6YXRpb24uCgpXaXRoIHRo
b3NlIHR3byBjaGFuZ2VzLAoKUmV2aWV3ZWQtYnk6IEJvcmlzIE9zdHJvdnNreSA8Ym9yaXMub3N0
cm92c2t5QG9yYWNsZS5jb20+Cgo+Cj4gQEAgLTQzNiw3ICs0MzYsOCBAQCBzdGF0aWMgdm9pZCBn
bnRkZXZfdm1hX2Nsb3NlKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hKQo+ICAgICAgICAgc3Ry
dWN0IGdudGRldl9wcml2ICpwcml2ID0gZmlsZS0+cHJpdmF0ZV9kYXRhOwo+ICAKPiAgICAgICAg
IHByX2RlYnVnKCJnbnRkZXZfdm1hX2Nsb3NlICVwXG4iLCB2bWEpOwo+IC0gICAgICAgaWYgKHVz
ZV9wdGVtb2QgJiYgbWFwLT52bWEgPT0gdm1hKSB7Cj4gKyAgICAgICBpZiAodXNlX3B0ZW1vZCkg
ewo+ICsgICAgICAgICAgICAgICBXQVJOX09OKG1hcC0+dm1hICE9IHZtYSk7Cj4gICAgICAgICAg
ICAgICAgIG1tdV9yYW5nZV9ub3RpZmllcl9yZW1vdmUoJm1hcC0+bm90aWZpZXIpOwo+ICAgICAg
ICAgICAgICAgICBtYXAtPnZtYSA9IE5VTEw7Cj4gICAgICAgICB9Cj4KPiBKYXNvbgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxp
bmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs

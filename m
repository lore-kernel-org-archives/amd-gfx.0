From: Jerome Glisse <jglisse@redhat.com>
Subject: Re: [PATCH v2 02/15] mm/mmu_notifier: add an interval tree notifier
Date: Fri, 8 Nov 2019 08:43:28 -0500
Message-ID: <20191108134328.GA4456@redhat.com>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-3-jgg@ziepe.ca>
 <35c2b322-004e-0e18-87e4-1920dc71bfd5@nvidia.com>
 <20191107200604.GB21728@mellanox.com>
 <20191108063302.GA18778@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20191108063302.GA18778@infradead.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Michal Hocko <mhocko@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Andrea Arcangeli <aarcange@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Ralph Campbell <rcampbell@nvidia.com>, John Hubbard <jhubbard@nvidia.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Petr Cvek <petrcvekcz@gmail.com>, Juergen Gross <jgross@suse.com>, Mike Marciniszyn <mike.marciniszyn@intel.com>, "Felix.Kuehling@amd.com" <Felix.>
List-Id: amd-gfx.lists.freedesktop.org

T24gVGh1LCBOb3YgMDcsIDIwMTkgYXQgMTA6MzM6MDJQTSAtMDgwMCwgQ2hyaXN0b3BoIEhlbGx3
aWcgd3JvdGU6Cj4gT24gVGh1LCBOb3YgMDcsIDIwMTkgYXQgMDg6MDY6MDhQTSArMDAwMCwgSmFz
b24gR3VudGhvcnBlIHdyb3RlOgo+ID4gPiAKPiA+ID4gZW51bSBtbXVfcmFuZ2Vfbm90aWZpZXJf
ZXZlbnQgewo+ID4gPiAJTU1VX05PVElGWV9SRUxFQVNFLAo+ID4gPiB9Owo+ID4gPiAKPiA+ID4g
Li4uYXNzdW1pbmcgdGhhdCB3ZSBzdGF5IHdpdGggIm1tdV9yYW5nZV9ub3RpZmllciIgYXMgYSBj
b3JlIG5hbWUgZm9yIHRoaXMgCj4gPiA+IHdob2xlIHRoaW5nLgo+ID4gPiAKPiA+ID4gQWxzbywg
aXQgaXMgYmVzdCBtb3ZlZCBkb3duIHRvIGJlIG5leHQgdG8gdGhlIG5ldyBNTlIgc3RydWN0cywg
c28gdGhhdCBhbGwgdGhlCj4gPiA+IE1OUiBzdHVmZiBpcyBpbiBvbmUgZ3JvdXAuCj4gPiAKPiA+
IEkgYWdyZWUgd2l0aCBKZXJvbWUsIHRoaXMgZW51bSBpcyBwYXJ0IG9mIHRoZSAnc3RydWN0Cj4g
PiBtbXVfbm90aWZpZXJfcmFuZ2UnIChpZSB0aGUgZGVzY3JpcHRpb24gb2YgdGhlIGludmFsaWRh
dGlvbikgYW5kIGl0Cj4gPiBkb2Vzbid0IHJlYWxseSBtYXR0ZXIgdGhhdCBvbmx5IHRoZXNlIG5l
dyBub3RpZmllcnMgY2FuIGJlIGNhbGxlZCB3aXRoCj4gPiB0aGlzIHR5cGUsIGl0IGlzIHN0aWxs
IHBhcnQgb2YgdGhlIG1tdV9ub3RpZmllcl9yYW5nZS4KPiA+IAo+ID4gVGhlIGNvbW1lbnQgYWxy
ZWFkeSBzYXlzIGl0IG9ubHkgYXBwbGllcyB0byB0aGUgbW11X3JhbmdlX25vdGlmaWVyCj4gPiBz
Y2hlbWUuLgo+IAo+IEluIGZhY3QgdGhlIGVudW0gaXMgZW50aXJlbHkgdW51c2VkLiAgV2UgbWln
aHQgYXMgd2VsbCBqdXN0IGtpbGwgaXQgb2ZmCj4gZW50aXJlbHkuCgpJIGhhZCBwYXRjaGVzIHRv
IHVzZSBpdCwgaSBuZWVkIHRvIHJlLXBvc3QgdGhlbS4gSSBwb3N0ZWQgdGhlbSBsb25nIGFnbwph
bmQgaSBkcm9wZWQgdGhlIGJhbGwuIEkgd2lsbCByZS1zcGluIGFmdGVyIHRoaXMuCgpDaGVlcnMs
CkrDqXLDtG1lCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWw=

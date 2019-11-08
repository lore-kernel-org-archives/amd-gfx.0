From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH v2 02/15] mm/mmu_notifier: add an interval
 tree notifier
Date: Fri, 8 Nov 2019 00:32:25 +0000
Message-ID: <20191108003219.GD21728@mellanox.com>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-3-jgg@ziepe.ca>
 <35c2b322-004e-0e18-87e4-1920dc71bfd5@nvidia.com>
 <20191107020807.GA747656@redhat.com> <20191107201102.GC21728@mellanox.com>
 <20191107210408.GA4716@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xenproject.org>
In-Reply-To: <20191107210408.GA4716@redhat.com>
Content-Language: en-US
Content-ID: <CAE59E75CD4E2749812E69DF0E0B124B@eurprd05.prod.outlook.com>
List-Unsubscribe: <https://lists.xenproject.org/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xenproject.org>
List-Help: <mailto:xen-devel-request@lists.xenproject.org?subject=help>
List-Subscribe: <https://lists.xenproject.org/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xenproject.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xenproject.org>
To: Jerome Glisse <jglisse@redhat.com>
Cc: "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Michal Hocko <mhocko@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Andrea Arcangeli <aarcange@redhat.com>, David Zhou <David1.Zhou@amd.com>, Stefano Stabellini <sstabellini@kernel.org>, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Christoph Hellwig <hch@infradead.org>, Ben Skeggs <bskeggs@redhat.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Ralph Campbell <rcampbell@nvidia.com>, John Hubbard <jhubbard@nvidia.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Petr Cvek <petrcvekcz@gmail.com>, Juergen Gross <jgross@suse.com>, Mike Marciniszyn <mike.marciniszyn@intel.co>
List-Id: amd-gfx.lists.freedesktop.org

T24gVGh1LCBOb3YgMDcsIDIwMTkgYXQgMDQ6MDQ6MDhQTSAtMDUwMCwgSmVyb21lIEdsaXNzZSB3
cm90ZToKPiBPbiBUaHUsIE5vdiAwNywgMjAxOSBhdCAwODoxMTowNlBNICswMDAwLCBKYXNvbiBH
dW50aG9ycGUgd3JvdGU6Cj4gPiBPbiBXZWQsIE5vdiAwNiwgMjAxOSBhdCAwOTowODowN1BNIC0w
NTAwLCBKZXJvbWUgR2xpc3NlIHdyb3RlOgo+ID4gCj4gPiA+ID4gCj4gPiA+ID4gRXh0cmEgY3Jl
ZGl0OiBJTUhPLCB0aGlzIGNsZWFybHkgZGVzZXJ2ZXMgdG8gYWxsIGJlIGluIGEgbmV3IG1tdV9y
YW5nZV9ub3RpZmllci5oCj4gPiA+ID4gaGVhZGVyIGZpbGUsIGJ1dCBJIGtub3cgdGhhdCdzIGV4
dHJhIHdvcmsuIE1heWJlIGxhdGVyIGFzIGEgZm9sbG93LXVwIHBhdGNoLAo+ID4gPiA+IGlmIGFu
eW9uZSBoYXMgdGhlIHRpbWUuCj4gPiA+IAo+ID4gPiBUaGUgcmFuZ2Ugbm90aWZpZXIgc2hvdWxk
IGdldCB0aGUgZXZlbnQgdG9vLCBpdCB3b3VsZCBiZSBhIHdhc3RlLCBpIHRoaW5rIGl0IGlzCj4g
PiA+IGFuIG92ZXJzaWdodCBoZXJlLiBUaGUgcmVsZWFzZSBldmVudCBpcyBmaW5lIHNvIE5BSyB0
byB5b3Ugc2VwYXJhdGUgZXZlbnQuIEV2ZW50Cj4gPiA+IGlzIHJlYWxseSBhbiBoZWxwZXIgZm9y
IG5vdGlmaWVyIGkgaGFkIGEgc2V0IG9mIHBhdGNoIGZvciBub3V2ZWF1IHRvIGxldmVyYWdlCj4g
PiA+IHRoaXMgaSBuZWVkIHRvIHJlc3VjaXRlIHRoZW0uIFNvIG5vIG5lZWQgdG8gc3BsaXQgdGhp
bmcsIGkgd291bGQganVzdCBmb3J3YXJkCj4gPiA+IHRoZSBldmVudCBpZSBhZGQgZXZlbnQgdG8g
bW11X3JhbmdlX25vdGlmaWVyX29wcy5pbnZhbGlkYXRlKCkgaSBmYWlsZWQgdG8gY2F0Y2gKPiA+
ID4gdGhhdCBpbiB2MSBzb3JyeS4KPiA+IAo+ID4gSSB0aGluayB3aGF0IHlvdSBtZWFuIGlzIGFs
cmVhZHkgZG9uZT8KPiA+IAo+ID4gc3RydWN0IG1tdV9yYW5nZV9ub3RpZmllcl9vcHMgewo+ID4g
CWJvb2wgKCppbnZhbGlkYXRlKShzdHJ1Y3QgbW11X3JhbmdlX25vdGlmaWVyICptcm4sCj4gPiAJ
CQkgICBjb25zdCBzdHJ1Y3QgbW11X25vdGlmaWVyX3JhbmdlICpyYW5nZSwKPiA+IAkJCSAgIHVu
c2lnbmVkIGxvbmcgY3VyX3NlcSk7Cj4gCj4gWWVzIGl0IGlzIHNvcnJ5LCBpIGdvdCBjb25mdXNl
IHdpdGggbW11X3JhbmdlX25vdGlmaWVyIGFuZCBtbXVfbm90aWZpZXJfcmFuZ2UgOikKPiBJdCBp
cyBhbG1vc3QgYSBwYWx5bmRyb21lIHN0cnVjdHVyZSA7KQoKTGV0cyBjaGFuZ2UgdGhlIG5hbWUg
dGhlbiwgdGhpcyBpcyBjbGVhcmx5IG5vdCB3b3JraW5nLiBJJ2xsIHJlZmxvdwpldmVyeXRoaW5n
IHRvbW9ycm93CgpKYXNvbgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KWGVuLWRldmVsIG1haWxpbmcgbGlzdApYZW4tZGV2ZWxAbGlzdHMueGVucHJvamVj
dC5vcmcKaHR0cHM6Ly9saXN0cy54ZW5wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3hlbi1k
ZXZlbA==

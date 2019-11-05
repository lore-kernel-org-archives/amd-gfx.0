From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH v2 09/15] xen/gntdev: use
 mmu_range_notifier_insert
Date: Tue, 5 Nov 2019 10:16:46 -0500
Message-ID: <a62e58f6-d98b-1feb-d0ca-fb8210f3e831@oracle.com>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-10-jgg@ziepe.ca>
 <3938b588-c6c5-3bd1-8ea9-47e4d5b2045c@oracle.com>
 <20191105023108.GN22766@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xenproject.org>
In-Reply-To: <20191105023108.GN22766@mellanox.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.xenproject.org/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xenproject.org>
List-Help: <mailto:xen-devel-request@lists.xenproject.org?subject=help>
List-Subscribe: <https://lists.xenproject.org/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xenproject.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xenproject.org>
To: Jason Gunthorpe <jgg@mellanox.com>
Cc: Juergen Gross <jgross@suse.com>, David Zhou <David1.Zhou@amd.com>, Ralph Campbell <rcampbell@nvidia.com>, Stefano Stabellini <sstabellini@kernel.org>, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, John Hubbard <jhubbard@nvidia.com>, "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>, Mike Marciniszyn <mike.marciniszyn@intel.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Christoph Hellwig <hch@infradead.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Jerome Glisse <jglisse@redhat.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Dennis Dalessandro <dennis.dalessandro@intel.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gMTEvNC8xOSA5OjMxIFBNLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6Cj4gT24gTW9uLCBOb3Yg
MDQsIDIwMTkgYXQgMDU6MDM6MzFQTSAtMDUwMCwgQm9yaXMgT3N0cm92c2t5IHdyb3RlOgo+PiBP
biAxMC8yOC8xOSA0OjEwIFBNLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6Cj4+PiBAQCAtNDQ1LDE3
ICs0MzgsOSBAQCBzdGF0aWMgdm9pZCBnbnRkZXZfdm1hX2Nsb3NlKHN0cnVjdCB2bV9hcmVhX3N0
cnVjdCAqdm1hKQo+Pj4gIAlzdHJ1Y3QgZ250ZGV2X3ByaXYgKnByaXYgPSBmaWxlLT5wcml2YXRl
X2RhdGE7Cj4+PiAgCj4+PiAgCXByX2RlYnVnKCJnbnRkZXZfdm1hX2Nsb3NlICVwXG4iLCB2bWEp
Owo+Pj4gLQlpZiAodXNlX3B0ZW1vZCkgewo+Pj4gLQkJLyogSXQgaXMgcG9zc2libGUgdGhhdCBh
biBtbXUgbm90aWZpZXIgY291bGQgYmUgcnVubmluZwo+Pj4gLQkJICogY29uY3VycmVudGx5LCBz
byB0YWtlIHByaXYtPmxvY2sgdG8gZW5zdXJlIHRoYXQgdGhlIHZtYSB3b24ndAo+Pj4gLQkJICog
dmFuaXNoaW5nIGR1cmluZyB0aGUgdW5tYXBfZ3JhbnRfcGFnZXMgY2FsbCwgc2luY2Ugd2Ugd2ls
bAo+Pj4gLQkJICogc3BpbiBoZXJlIHVudGlsIHRoYXQgY29tcGxldGVzLiBTdWNoIGEgY29uY3Vy
cmVudCBjYWxsIHdpbGwKPj4+IC0JCSAqIG5vdCBkbyBhbnkgdW5tYXBwaW5nLCBzaW5jZSB0aGF0
IGhhcyBiZWVuIGRvbmUgcHJpb3IgdG8KPj4+IC0JCSAqIGNsb3NpbmcgdGhlIHZtYSwgYnV0IGl0
IG1heSBzdGlsbCBpdGVyYXRlIHRoZSB1bm1hcF9vcHMgbGlzdC4KPj4+IC0JCSAqLwo+Pj4gLQkJ
bXV0ZXhfbG9jaygmcHJpdi0+bG9jayk7Cj4+PiArCWlmICh1c2VfcHRlbW9kICYmIG1hcC0+dm1h
ID09IHZtYSkgewo+Pgo+PiBJcyBpdCBwb3NzaWJsZSBmb3IgbWFwLT52bWEgbm90IHRvIGJlIGVx
dWFsIHRvIHZtYT8KPiBJdCBjb3VsZCBiZSBOVUxMIGF0IGxlYXN0IGlmIHVzZV9wdGVtb2QgaXMg
bm90IHNldC4KPgo+IE90aGVyd2lzZSwgSSdtIG5vdCBzdXJlLCB0aGUgY29uZnVzaW5nIGJpdCBp
cyB0aGF0IHRoZSBtYXAgY29tZXMgZnJvbQo+IGhlcmU6Cj4KPiAgICAgICAgIG1hcCA9IGdudGRl
dl9maW5kX21hcF9pbmRleChwcml2LCBpbmRleCwgY291bnQpOwo+Cj4gSXQgbG9va3MgbGlrZSB0
aGUgaW50ZW50IGlzIHRoYXQgdGhlIG1hcC0+dm1hIGlzIGFsd2F5cyBzZXQgdG8gdGhlCj4gb25s
eSB2bWEgdGhhdCBoYXMgdGhlIG1hcCBhcyBwcml2YXRlX2RhdGEuCgpJIGFtIG5vdCBzdXJlIGhv
dyB0aGlzIGNhbiB3b3JrIG90aGVyd2lzZS4gV2Ugc3Rhc2ggbWFwIHBvaW50ZXIgaW4gdm0ncwp2
bV9wcml2YXRlX2RhdGEgYW5kIHZpY2UgdmVyc2EgKGZvciB1c2VfcHRlbW9kKSBnbnRkZXZfbW1h
cCgpIHNvIGlmIHRoZXkKaGF2ZSB0byBtYXRjaC4KClRoYXQncyB3aHkgSSB3YXMgYXNraW5nIHlv
dSB0byBzZWUgaWYgeW91IGhhZCBzb21ldGhpbmcgcGFydGljdWxhciBpbgptaW5kIHdoZW4geW91
IGFkZGVkIHRoaXMgdGVzdC4KCj4gU28sIEkgc3VwcG9zZSBpdCBjYW4gYmUgcmVsYXhlZCB0byBh
IG51bGwgdGVzdCBhbmQgYSBXQVJOX09OIHRoYXQgaXQKPiBoYXNuJ3QgY2hhbmdlZD8KCllvdSBt
ZWFuCgppZiAodXNlX3B0ZW1vZCkgewrCoMKgwqDCoMKgwqDCoCBXQVJOX09OKG1hcC0+dm1hICE9
IHZtYSk7CsKgwqDCoMKgwqDCoMKgIC4uLgoKClllcywgdGhhdCBzb3VuZHMgZ29vZC4KCgotYm9y
aXMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClhlbi1k
ZXZlbCBtYWlsaW5nIGxpc3QKWGVuLWRldmVsQGxpc3RzLnhlbnByb2plY3Qub3JnCmh0dHBzOi8v
bGlzdHMueGVucHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby94ZW4tZGV2ZWw=

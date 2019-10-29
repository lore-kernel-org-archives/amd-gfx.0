From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH v2 02/15] mm/mmu_notifier: add an interval
 tree notifier
Date: Tue, 29 Oct 2019 22:56:29 +0000
Message-ID: <20191029225623.GV22766@mellanox.com>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-3-jgg@ziepe.ca>
 <786ee79d-00a6-9147-f410-d8856da35511@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xenproject.org>
In-Reply-To: <786ee79d-00a6-9147-f410-d8856da35511@amd.com>
Content-Language: en-US
Content-ID: <0D908830E600514D9CA283269F446301@eurprd05.prod.outlook.com>
List-Unsubscribe: <https://lists.xenproject.org/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xenproject.org>
List-Help: <mailto:xen-devel-request@lists.xenproject.org?subject=help>
List-Subscribe: <https://lists.xenproject.org/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xenproject.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xenproject.org>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Cc: "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Michal Hocko <mhocko@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Andrea Arcangeli <aarcange@redhat.com>, "Zhou,
 David(ChunMing)" <David1.Zhou@amd.com>, Stefano Stabellini <sstabellini@kernel.org>, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Christoph Hellwig <hch@infradead.org>, Ben Skeggs <bskeggs@redhat.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Ralph Campbell <rcampbell@nvidia.com>, John Hubbard <jhubbard@nvidia.com>, Jerome Glisse <jglisse@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Petr Cvek <petrcvekcz@gmail.com>, Juergen Gross <jgross@s>
List-Id: amd-gfx.lists.freedesktop.org

T24gVHVlLCBPY3QgMjksIDIwMTkgYXQgMTA6MDQ6NDVQTSArMDAwMCwgS3VlaGxpbmcsIEZlbGl4
IHdyb3RlOgoKPiA+ICAgICogYmVjYXVzZSBtbS0+bW1fdXNlcnMgPiAwIGR1cmluZyBtbXVfbm90
aWZpZXJfcmVnaXN0ZXIgYW5kIGV4aXRfbW1hcAo+ID4gQEAgLTUyLDE3ICsyODYsMjQgQEAgc3Ry
dWN0IG1tdV9ub3RpZmllcl9tbSB7Cj4gPiAgICAqIGNhbid0IGdvIGF3YXkgZnJvbSB1bmRlciB1
cyBhcyBleGl0X21tYXAgaG9sZHMgYW4gbW1fY291bnQgcGluCj4gPiAgICAqIGl0c2VsZi4KPiA+
ICAgICovCj4gPiAtdm9pZCBfX21tdV9ub3RpZmllcl9yZWxlYXNlKHN0cnVjdCBtbV9zdHJ1Y3Qg
Km1tKQo+ID4gK3N0YXRpYyB2b2lkIG1uX2hsaXN0X3JlbGVhc2Uoc3RydWN0IG1tdV9ub3RpZmll
cl9tbSAqbW1uX21tLAo+ID4gKwkJCSAgICAgc3RydWN0IG1tX3N0cnVjdCAqbW0pCj4gPiAgIHsK
PiA+ICAgCXN0cnVjdCBtbXVfbm90aWZpZXIgKm1uOwo+ID4gICAJaW50IGlkOwo+ID4gICAKPiA+
ICsJaWYgKG1tbl9tbS0+aGFzX2ludGVydmFsKQo+ID4gKwkJbW5faXRyZWVfcmVsZWFzZShtbW5f
bW0sIG1tKTsKPiA+ICsKPiA+ICsJaWYgKGhsaXN0X2VtcHR5KCZtbW5fbW0tPmxpc3QpKQo+ID4g
KwkJcmV0dXJuOwo+IAo+IFRoaXMgc2VlbXMgdG8gZHVwbGljYXRlIHRoZSBjb25kaXRpb25zIGlu
IF9fbW11X25vdGlmaWVyX3JlbGVhc2UuIFNlZSBteSAKPiBjb21tZW50cyBiZWxvdywgSSB0aGlu
ayBvbmUgb2YgdGhlbSBpcyB3cm9uZy4gSSBzdXNwZWN0IHRoaXMgb25lLCAKPiBiZWNhdXNlIF9f
bW11X25vdGlmaWVyX3JlbGVhc2UgZm9sbG93cyB0aGUgc2FtZSBwYXR0ZXJuIGFzIHRoZSBvdGhl
ciAKPiBub3RpZmllcnMuCgpZZXAsIHRoaXMgaXMgYSByZWJhc2luZyBlcnJvciBmcm9tIGEgZWFy
bGllciB2ZXJzaW9uLCB0aGUgYWJvdmUgdHdvCmxpbmVzIHNob3VsZCBiZSBkZWxldGVkLgoKSSB0
aGluayBpdCBpcyBoYXJtbGVzcyBzbyBpdCBzaG91bGQgbm90IGltcGFjdCBhbnkgdGVzdGluZy4K
ClRoYW5rcywKSmFzb24KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClhlbi1kZXZlbCBtYWlsaW5nIGxpc3QKWGVuLWRldmVsQGxpc3RzLnhlbnByb2plY3Qu
b3JnCmh0dHBzOi8vbGlzdHMueGVucHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby94ZW4tZGV2
ZWw=

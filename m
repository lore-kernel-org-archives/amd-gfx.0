From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 00/15] Consolidate the mmu notifier
 interval_tree and locking
Date: Fri, 1 Nov 2019 16:54:06 -0300
Message-ID: <20191101195406.GA6732@ziepe.ca>
References: <20191028201032.6352-1-jgg@ziepe.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xenproject.org>
Content-Disposition: inline
In-Reply-To: <20191028201032.6352-1-jgg@ziepe.ca>
List-Unsubscribe: <https://lists.xenproject.org/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xenproject.org>
List-Help: <mailto:xen-devel-request@lists.xenproject.org?subject=help>
List-Subscribe: <https://lists.xenproject.org/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xenproject.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xenproject.org>
To: linux-mm@kvack.org, Jerome Glisse <jglisse@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>, John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc: Juergen Gross <jgross@suse.com>, David Zhou <David1.Zhou@amd.com>, Mike Marciniszyn <mike.marciniszyn@intel.com>, Stefano Stabellini <sstabellini@kernel.org>, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, linux-rdma@vger.kernel.org, nouveau@lists.freedesktop.org, Dennis Dalessandro <dennis.dalessandro@intel.com>, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Petr Cvek <petrcvekcz@gmail.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, Ben Skeggs <bskeggs@redhat.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gTW9uLCBPY3QgMjgsIDIwMTkgYXQgMDU6MTA6MTdQTSAtMDMwMCwgSmFzb24gR3VudGhvcnBl
IHdyb3RlOgo+IEZyb206IEphc29uIEd1bnRob3JwZSA8amdnQG1lbGxhbm94LmNvbT4KPiAKPiA4
IG9mIHRoZSBtbXVfbm90aWZpZXIgdXNpbmcgZHJpdmVycyAoaTkxNV9nZW0sIHJhZGVvbl9tbiwg
dW1lbV9vZHAsIGhmaTEsCj4gc2NpZl9kbWEsIHZob3N0LCBnbnRkZXYsIGhtbSkgZHJpdmVycyBh
cmUgdXNpbmcgYSBjb21tb24gcGF0dGVybiB3aGVyZQo+IHRoZXkgb25seSB1c2UgaW52YWxpZGF0
ZV9yYW5nZV9zdGFydC9lbmQgYW5kIGltbWVkaWF0ZWx5IGNoZWNrIHRoZQo+IGludmFsaWRhdGlu
ZyByYW5nZSBhZ2FpbnN0IHNvbWUgZHJpdmVyIGRhdGEgc3RydWN0dXJlIHRvIHRlbGwgaWYgdGhl
Cj4gZHJpdmVyIGlzIGludGVyZXN0ZWQuIEhhbGYgb2YgdGhlbSB1c2UgYW4gaW50ZXJ2YWxfdHJl
ZSwgdGhlIG90aGVycyBhcmUKPiBzaW1wbGUgbGluZWFyIHNlYXJjaCBsaXN0cy4KCk5vdyB0aGF0
IHdlIGhhdmUgdGhlIG1vc3Qgb2YgdGhlIGRyaXZlciBjaGFuZ2VzIHRlc3RlZCBhbmQgcmV2aWV3
ZWQKSSdtIGdvaW5nIHRvIG1vdmUgdGhpcyBzZXJpZXMgaW50byBsaW51eC1uZXh0IHZpYSB0aGUg
aG1tIHRyZWUsIG1pbnVzCnRoZSB4ZW4gZ250ZGV2IHBhdGNoZXMgYXMgdGhleSBhcmUgbm90IHdv
cmtpbmcgeWV0LgoKSSB3aWxsIGtlZXAgY29sbGVjdGluZyBhY2tzIGFuZCBhbnkgYWRkaXRpb25h
bCBjaGFuZ2VzLgoKVGhhbmtzLApKYXNvbgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KWGVuLWRldmVsIG1haWxpbmcgbGlzdApYZW4tZGV2ZWxAbGlzdHMu
eGVucHJvamVjdC5vcmcKaHR0cHM6Ly9saXN0cy54ZW5wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3hlbi1kZXZlbA==

From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 06/15] RDMA/hfi1: Use
 mmu_range_notifier_inset for user_exp_rcv
Date: Tue, 29 Oct 2019 09:51:31 -0300
Message-ID: <20191029125131.GC6128@ziepe.ca>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-7-jgg@ziepe.ca>
 <a8644875-9133-9667-c04b-b40c296d68eb@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xenproject.org>
Content-Disposition: inline
In-Reply-To: <a8644875-9133-9667-c04b-b40c296d68eb@intel.com>
List-Unsubscribe: <https://lists.xenproject.org/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xenproject.org>
List-Help: <mailto:xen-devel-request@lists.xenproject.org?subject=help>
List-Subscribe: <https://lists.xenproject.org/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xenproject.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xenproject.org>
To: Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc: Juergen Gross <jgross@suse.com>, David Zhou <David1.Zhou@amd.com>, Ralph Campbell <rcampbell@nvidia.com>, Stefano Stabellini <sstabellini@kernel.org>, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, linux-rdma@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com, Mike Marciniszyn <mike.marciniszyn@intel.com>, dri-devel@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org, Jerome Glisse <jglisse@redhat.com>, amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Petr Cvek <petrcvekcz@gmail.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, Ben Skeggs <bskeggs@redhat.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gVHVlLCBPY3QgMjksIDIwMTkgYXQgMDg6MTk6MjBBTSAtMDQwMCwgRGVubmlzIERhbGVzc2Fu
ZHJvIHdyb3RlOgo+IE9uIDEwLzI4LzIwMTkgNDoxMCBQTSwgSmFzb24gR3VudGhvcnBlIHdyb3Rl
Ogo+ID4gRnJvbTogSmFzb24gR3VudGhvcnBlIDxqZ2dAbWVsbGFub3guY29tPgo+ID4gCj4gPiBU
aGlzIGNvbnZlcnRzIG9uZSBvZiB0aGUgdHdvIHVzZXJzIG9mIG1tdV9ub3RpZmllcnMgdG8gdXNl
IHRoZSBuZXcgQVBJLgo+ID4gVGhlIGNvbnZlcnNpb24gaXMgZmFpcmx5IHN0cmFpZ2h0Zm9yd2Fy
ZCwgaG93ZXZlciB0aGUgZXhpc3RpbmcgdXNlIG9mCj4gPiBub3RpZmllcnMgaGVyZSBzZWVtcyB0
byBiZSByYWNleS4KPiA+IAo+ID4gQ2M6IE1pa2UgTWFyY2luaXN6eW4gPG1pa2UubWFyY2luaXN6
eW5AaW50ZWwuY29tPgo+ID4gQ2M6IERlbm5pcyBEYWxlc3NhbmRybyA8ZGVubmlzLmRhbGVzc2Fu
ZHJvQGludGVsLmNvbT4KPiA+IFNpZ25lZC1vZmYtYnk6IEphc29uIEd1bnRob3JwZSA8amdnQG1l
bGxhbm94LmNvbT4KPiAKPiBJIHRlc3RlZCB2MSwgYW5kIHJlcGxpZWQgdG8gaXQgWzFdLiBJIGNh
biByZS10ZXN0IHdpdGggdGhpcyB2ZXJzaW9uIGlmIHlvdQo+IGxpa2UgYXMgd2VsbC4KPiAKPiBb
MV0gaHR0cHM6Ly9tYXJjLmluZm8vP2w9bGludXgtcmRtYSZtPTE1NzIzNTEzMDYwNjQxMiZ3PTIK
CkkgdGhpbmsgaXQgaXMgZmluZSwgbm90aGluZyByZWFsbHkgY2hhbmdlZCBpbiB2MiwgdGhhbmtz
CgpKYXNvbgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
WGVuLWRldmVsIG1haWxpbmcgbGlzdApYZW4tZGV2ZWxAbGlzdHMueGVucHJvamVjdC5vcmcKaHR0
cHM6Ly9saXN0cy54ZW5wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3hlbi1kZXZlbA==

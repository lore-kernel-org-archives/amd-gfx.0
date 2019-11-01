From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 14/15] drm/amdgpu: Use mmu_range_notifier instead of
 hmm_mirror
Date: Fri, 1 Nov 2019 16:19:59 -0300
Message-ID: <20191101191959.GC30938@ziepe.ca>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-15-jgg@ziepe.ca>
 <a456ebd0-28cf-997b-31ff-72d9077a9b8e@amd.com>
 <20191029192544.GU22766@mellanox.com>
 <30b2f569-bf7a-5166-c98d-4a4a13d1351f@amd.com>
 <20191101151222.GN22766@mellanox.com>
 <8280fb65-a897-3d71-79f9-9f80d9e474e9@amd.com>
 <20191101174221.GO22766@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20191101174221.GO22766@mellanox.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: "Yang, Philip" <Philip.Yang@amd.com>
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gRnJpLCBOb3YgMDEsIDIwMTkgYXQgMDI6NDI6MjFQTSAtMDMwMCwgSmFzb24gR3VudGhvcnBl
IHdyb3RlOgo+IE9uIEZyaSwgTm92IDAxLCAyMDE5IGF0IDAzOjU5OjI2UE0gKzAwMDAsIFlhbmcs
IFBoaWxpcCB3cm90ZToKPiA+ID4gVGhpcyB0ZXN0IGZvciByYW5nZV9ibG9ja2FibGUgc2hvdWxk
IGJlIGJlZm9yZSBtdXRleF9sb2NrLCBJIGNhbiBtb3ZlCj4gPiA+IGl0IHVwCj4gPiA+IAo+ID4g
eWVzLCB0aGFua3MuCj4gCj4gT2theSwgSSB3cm90ZSBpdCBsaWtlIHRoaXM6Cj4gCj4gCWlmICht
bXVfbm90aWZpZXJfcmFuZ2VfYmxvY2thYmxlKHJhbmdlKSkKPiAJCW11dGV4X2xvY2soJmFkZXYt
Pm5vdGlmaWVyX2xvY2spOwo+IAllbHNlIGlmICghbXV0ZXhfdHJ5bG9jaygmYWRldi0+bm90aWZp
ZXJfbG9jaykpCj4gCQlyZXR1cm4gZmFsc2U7CgpOZXZlciBtaW5kLCB0aGlzIHJvdXRpbmUgc2xl
ZXBzIGZvciBvdGhlciByZWFzb25zIGl0IHNob3VsZCBqdXN0IGJlIGFzCml0IHdhczoKCglpZiAo
IW1tdV9ub3RpZmllcl9yYW5nZV9ibG9ja2FibGUocmFuZ2UpKQoJCXJldHVybiBmYWxzZTsKCglt
dXRleF9sb2NrKCZhZGV2LT5ub3RpZmllcl9sb2NrKTsKCkphc29uCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJp
LWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbA==

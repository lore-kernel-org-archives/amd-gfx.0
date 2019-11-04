From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH v2 09/15] xen/gntdev: use
 mmu_range_notifier_insert
Date: Mon, 4 Nov 2019 17:03:31 -0500
Message-ID: <3938b588-c6c5-3bd1-8ea9-47e4d5b2045c@oracle.com>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-10-jgg@ziepe.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xenproject.org>
In-Reply-To: <20191028201032.6352-10-jgg@ziepe.ca>
Content-Language: en-US
List-Unsubscribe: <https://lists.xenproject.org/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xenproject.org>
List-Help: <mailto:xen-devel-request@lists.xenproject.org?subject=help>
List-Subscribe: <https://lists.xenproject.org/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xenproject.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xenproject.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, Jerome Glisse <jglisse@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>, John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc: Juergen Gross <jgross@suse.com>, David Zhou <David1.Zhou@amd.com>, Mike Marciniszyn <mike.marciniszyn@intel.com>, Stefano Stabellini <sstabellini@kernel.org>, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, linux-rdma@vger.kernel.org, nouveau@lists.freedesktop.org, Dennis Dalessandro <dennis.dalessandro@intel.com>, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@mellanox.com>, dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, xen-devel@lists.xenproject.org, Petr Cvek <petrcvekcz@gmail.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Ben Skeggs <bskeggs@redhat.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gMTAvMjgvMTkgNDoxMCBQTSwgSmFzb24gR3VudGhvcnBlIHdyb3RlOgo+IEBAIC00NDUsMTcg
KzQzOCw5IEBAIHN0YXRpYyB2b2lkIGdudGRldl92bWFfY2xvc2Uoc3RydWN0IHZtX2FyZWFfc3Ry
dWN0ICp2bWEpCj4gIAlzdHJ1Y3QgZ250ZGV2X3ByaXYgKnByaXYgPSBmaWxlLT5wcml2YXRlX2Rh
dGE7Cj4gIAo+ICAJcHJfZGVidWcoImdudGRldl92bWFfY2xvc2UgJXBcbiIsIHZtYSk7Cj4gLQlp
ZiAodXNlX3B0ZW1vZCkgewo+IC0JCS8qIEl0IGlzIHBvc3NpYmxlIHRoYXQgYW4gbW11IG5vdGlm
aWVyIGNvdWxkIGJlIHJ1bm5pbmcKPiAtCQkgKiBjb25jdXJyZW50bHksIHNvIHRha2UgcHJpdi0+
bG9jayB0byBlbnN1cmUgdGhhdCB0aGUgdm1hIHdvbid0Cj4gLQkJICogdmFuaXNoaW5nIGR1cmlu
ZyB0aGUgdW5tYXBfZ3JhbnRfcGFnZXMgY2FsbCwgc2luY2Ugd2Ugd2lsbAo+IC0JCSAqIHNwaW4g
aGVyZSB1bnRpbCB0aGF0IGNvbXBsZXRlcy4gU3VjaCBhIGNvbmN1cnJlbnQgY2FsbCB3aWxsCj4g
LQkJICogbm90IGRvIGFueSB1bm1hcHBpbmcsIHNpbmNlIHRoYXQgaGFzIGJlZW4gZG9uZSBwcmlv
ciB0bwo+IC0JCSAqIGNsb3NpbmcgdGhlIHZtYSwgYnV0IGl0IG1heSBzdGlsbCBpdGVyYXRlIHRo
ZSB1bm1hcF9vcHMgbGlzdC4KPiAtCQkgKi8KPiAtCQltdXRleF9sb2NrKCZwcml2LT5sb2NrKTsK
PiArCWlmICh1c2VfcHRlbW9kICYmIG1hcC0+dm1hID09IHZtYSkgewoKCklzIGl0IHBvc3NpYmxl
IGZvciBtYXAtPnZtYSBub3QgdG8gYmUgZXF1YWwgdG8gdm1hPwoKLWJvcmlzCgoKPiArCQltbXVf
cmFuZ2Vfbm90aWZpZXJfcmVtb3ZlKCZtYXAtPm5vdGlmaWVyKTsKPiAgCQltYXAtPnZtYSA9IE5V
TEw7Cj4gLQkJbXV0ZXhfdW5sb2NrKCZwcml2LT5sb2NrKTsKPiAgCX0KPiAgCXZtYS0+dm1fcHJp
dmF0ZV9kYXRhID0gTlVMTDsKPiAgCWdudGRldl9wdXRfbWFwKHByaXYsIG1hcCk7Cj4KCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpYZW4tZGV2ZWwgbWFp
bGluZyBsaXN0Clhlbi1kZXZlbEBsaXN0cy54ZW5wcm9qZWN0Lm9yZwpodHRwczovL2xpc3RzLnhl
bnByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8veGVuLWRldmVs

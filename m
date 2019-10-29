From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH v2 13/15] drm/amdgpu: Use mmu_range_insert
 instead of hmm_mirror
Date: Tue, 29 Oct 2019 23:09:46 +0000
Message-ID: <20191029230942.GW22766@mellanox.com>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-14-jgg@ziepe.ca>
 <6c511ee9-4cbf-bd33-e720-f2d2b5c3c28b@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xenproject.org>
In-Reply-To: <6c511ee9-4cbf-bd33-e720-f2d2b5c3c28b@amd.com>
Content-Language: en-US
Content-ID: <D37E357C3EB6BE4CBBDAB15F1A671056@eurprd05.prod.outlook.com>
List-Unsubscribe: <https://lists.xenproject.org/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xenproject.org>
List-Help: <mailto:xen-devel-request@lists.xenproject.org?subject=help>
List-Subscribe: <https://lists.xenproject.org/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xenproject.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xenproject.org>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Cc: Juergen Gross <jgross@suse.com>, "Zhou,
 David(ChunMing)" <David1.Zhou@amd.com>, Ralph Campbell <rcampbell@nvidia.com>, Stefano Stabellini <sstabellini@kernel.org>, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, John Hubbard <jhubbard@nvidia.com>, Dennis Dalessandro <dennis.dalessandro@intel.com>, Mike Marciniszyn <mike.marciniszyn@intel.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Christoph Hellwig <hch@infradead.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Jerome Glisse <jglisse@redhat.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Boris Ostrovsky <boris.ostr>
List-Id: amd-gfx.lists.freedesktop.org

T24gVHVlLCBPY3QgMjksIDIwMTkgYXQgMTA6MTQ6MjlQTSArMDAwMCwgS3VlaGxpbmcsIEZlbGl4
IHdyb3RlOgoKPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG1tdV9yYW5nZV9ub3RpZmllcl9vcHMg
YW1kZ3B1X21uX2hzYV9vcHMgPSB7Cj4gPiArCS5pbnZhbGlkYXRlID0gYW1kZ3B1X21uX2ludmFs
aWRhdGVfaHNhLAo+ID4gK307Cj4gPiArCj4gPiArc3RhdGljIGludCBhbWRncHVfbW5fc3luY19w
YWdldGFibGVzKHN0cnVjdCBobW1fbWlycm9yICptaXJyb3IsCj4gPiArCQkJCSAgICAgY29uc3Qg
c3RydWN0IG1tdV9ub3RpZmllcl9yYW5nZSAqdXBkYXRlKQo+ID4gICB7Cj4gPiAgIAlzdHJ1Y3Qg
YW1kZ3B1X21uICphbW4gPSBjb250YWluZXJfb2YobWlycm9yLCBzdHJ1Y3QgYW1kZ3B1X21uLCBt
aXJyb3IpOwo+ID4gLQl1bnNpZ25lZCBsb25nIHN0YXJ0ID0gdXBkYXRlLT5zdGFydDsKPiA+IC0J
dW5zaWduZWQgbG9uZyBlbmQgPSB1cGRhdGUtPmVuZDsKPiA+IC0JYm9vbCBibG9ja2FibGUgPSBt
bXVfbm90aWZpZXJfcmFuZ2VfYmxvY2thYmxlKHVwZGF0ZSk7Cj4gPiAtCXN0cnVjdCBpbnRlcnZh
bF90cmVlX25vZGUgKml0Owo+ID4gICAKPiA+IC0JLyogbm90aWZpY2F0aW9uIGlzIGV4Y2x1c2l2
ZSwgYnV0IGludGVydmFsIGlzIGluY2x1c2l2ZSAqLwo+ID4gLQllbmQgLT0gMTsKPiA+IC0KPiA+
IC0JaWYgKGFtZGdwdV9tbl9yZWFkX2xvY2soYW1uLCBibG9ja2FibGUpKQo+ID4gLQkJcmV0dXJu
IC1FQUdBSU47Cj4gPiAtCj4gPiAtCWl0ID0gaW50ZXJ2YWxfdHJlZV9pdGVyX2ZpcnN0KCZhbW4t
Pm9iamVjdHMsIHN0YXJ0LCBlbmQpOwo+ID4gLQl3aGlsZSAoaXQpIHsKPiA+IC0JCXN0cnVjdCBh
bWRncHVfbW5fbm9kZSAqbm9kZTsKPiA+IC0JCXN0cnVjdCBhbWRncHVfYm8gKmJvOwo+ID4gLQo+
ID4gLQkJaWYgKCFibG9ja2FibGUpIHsKPiA+IC0JCQlhbWRncHVfbW5fcmVhZF91bmxvY2soYW1u
KTsKPiA+IC0JCQlyZXR1cm4gLUVBR0FJTjsKPiA+IC0JCX0KPiA+IC0KPiA+IC0JCW5vZGUgPSBj
b250YWluZXJfb2YoaXQsIHN0cnVjdCBhbWRncHVfbW5fbm9kZSwgaXQpOwo+ID4gLQkJaXQgPSBp
bnRlcnZhbF90cmVlX2l0ZXJfbmV4dChpdCwgc3RhcnQsIGVuZCk7Cj4gPiAtCj4gPiAtCQlsaXN0
X2Zvcl9lYWNoX2VudHJ5KGJvLCAmbm9kZS0+Ym9zLCBtbl9saXN0KSB7Cj4gPiAtCQkJc3RydWN0
IGtnZF9tZW0gKm1lbSA9IGJvLT5rZmRfYm87Cj4gPiAtCj4gPiAtCQkJaWYgKGFtZGdwdV90dG1f
dHRfYWZmZWN0X3VzZXJwdHIoYm8tPnRiby50dG0sCj4gPiAtCQkJCQkJCSBzdGFydCwgZW5kKSkK
PiA+IC0JCQkJYW1kZ3B1X2FtZGtmZF9ldmljdF91c2VycHRyKG1lbSwgYW1uLT5tbSk7Cj4gPiAt
CQl9Cj4gPiAtCX0KPiA+IC0KPiA+IC0JYW1kZ3B1X21uX3JlYWRfdW5sb2NrKGFtbik7Cj4gPiAr
CWlmICghbW11X25vdGlmaWVyX3JhbmdlX2Jsb2NrYWJsZSh1cGRhdGUpKQo+ID4gKwkJcmV0dXJu
IGZhbHNlOwo+IAo+IFRoaXMgc2hvdWxkIHJldHVybiAtRUFHQUlOLiBOb3Qgc3VyZSBpdCBtYXR0
ZXJzIG11Y2gsIGJlY2F1c2UgdGhpcyB3aG9sZSAKPiBmdW5jdGlvbiBkaXNhcHBlYXJzIGluIHRo
ZSBuZXh0IGNvbW1pdCBpbiB0aGUgc2VyaWVzLiBJdCBzZWVtcyB0byBiZSAKPiBvbmx5IHZlc3Rp
Z2lhbCBhdCB0aGlzIHBvaW50LgoKUmlnaHQsIHRoZSBvbmx5IHJlYXNvbiBpdCBpcyBzdGlsbCBo
ZXJlIGlzIHRoYXQgSSBjb3VsZG4ndCByZWFsbHkgdGVsbAppZiB0aGlzOgoKPiA+ICsJZG93bl9y
ZWFkKCZhbW4tPmxvY2spOwo+ID4gKwl1cF9yZWFkKCZhbW4tPmxvY2spOwo+ID4gICAJcmV0dXJu
IDA7Cj4gPiAgIH0KCldhcyBzZXJ2aW5nIGFzIHRoZSAnZHJpdmVyIGxvY2snIGluIHRoZSBobW0g
c2NoZW1lLi4uIElmIG5vdCB0aGVuIHRoZQp3aG9sZSB0aGluZyBzaG91bGQganVzdCBiZSBkZWxl
dGVkIGF0IHRoaXMgcG9pbnQuCgpJIGZpeGVkIHRoZSBFQUdBSU4gdGhvdWdoCgpKYXNvbgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KWGVuLWRldmVsIG1h
aWxpbmcgbGlzdApYZW4tZGV2ZWxAbGlzdHMueGVucHJvamVjdC5vcmcKaHR0cHM6Ly9saXN0cy54
ZW5wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3hlbi1kZXZlbA==

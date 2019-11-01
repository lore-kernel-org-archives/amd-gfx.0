From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH v2 14/15] drm/amdgpu: Use mmu_range_notifier
 instead of hmm_mirror
Date: Fri, 1 Nov 2019 19:51:28 +0000
Message-ID: <20191101195124.GU22766@mellanox.com>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-15-jgg@ziepe.ca>
 <a456ebd0-28cf-997b-31ff-72d9077a9b8e@amd.com>
 <20191029192544.GU22766@mellanox.com>
 <30b2f569-bf7a-5166-c98d-4a4a13d1351f@amd.com>
 <20191101151222.GN22766@mellanox.com>
 <8280fb65-a897-3d71-79f9-9f80d9e474e9@amd.com>
 <20191101174221.GO22766@mellanox.com>
 <fc6ded68-287b-5257-db79-42c92458a5f6@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xenproject.org>
In-Reply-To: <fc6ded68-287b-5257-db79-42c92458a5f6@amd.com>
Content-Language: en-US
Content-ID: <B1E7655020E6F545A1E395E5B3C9D53A@eurprd05.prod.outlook.com>
List-Unsubscribe: <https://lists.xenproject.org/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xenproject.org>
List-Help: <mailto:xen-devel-request@lists.xenproject.org?subject=help>
List-Subscribe: <https://lists.xenproject.org/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xenproject.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xenproject.org>
To: "Yang, Philip" <Philip.Yang@amd.com>
Cc: "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "Zhou,
 David(ChunMing)" <David1.Zhou@amd.com>, Stefano Stabellini <sstabellini@kernel.org>, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Christoph Hellwig <hch@infradead.org>, Ben Skeggs <bskeggs@redhat.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Ralph Campbell <rcampbell@nvidia.com>, John Hubbard <jhubbard@nvidia.com>, Jerome Glisse <jglisse@redhat.com>, Dennis Dalessandro <dennis.dalessandro@intel.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Petr Cvek <petrcvekcz@gmail.com>, Juergen Gross <jgross@suse.com>, Mike
List-Id: amd-gfx.lists.freedesktop.org

T24gRnJpLCBOb3YgMDEsIDIwMTkgYXQgMDc6NDU6MjJQTSArMDAwMCwgWWFuZywgUGhpbGlwIHdy
b3RlOgoKPiA+IFRoaXMgbXVzdCBiZSBkb25lIGluc2lkZSB0aGUgbm90aWZpZXJfbG9jaywgYWZ0
ZXIgY2hlY2tpbmcKPiA+IG1tdV9yYW5nZV9yZWFkX3JldHJ5KCksIGFsbCBoYW5kbGluZyBvZiB0
aGUgc3RydWN0IHBhZ2UgbXVzdCBiZQo+ID4gc3RydWN0dXJlZCBsaWtlIHRoYXQuCj4gPiAKPiBC
ZWxvdyBjaGFuZ2Ugd2lsbCBmaXggdGhpcywgdGhlbiBkcml2ZXIgd2lsbCBjYWxsIG1tdV9yYW5n
ZV9yZWFkX3JldHJ5IAo+IHNlY29uZCB0aW1lIHVzaW5nIHNhbWUgcmFuZ2UtPm5vdGlmaWVyX3Nl
cSB0byBjaGVjayBpZiByYW5nZSBpcyAKPiBpbnZhbGlkYXRlZCBpbnNpZGUgYW1kZ3B1X2NzX3N1
Ym1pdCwgdGhpcyBsb29rcyBvayBmb3IgbWUuCgpMZXRzIGRlZmVyIHRoaXMgdG8gc29tZSBwYXRj
aCB0cnlpbmcgdG8gZml4IGl0LCBJIGZpbmQgaXQgaGFyZCB0bwpmb2xsb3cuLgoKPiBAQCAtODY4
LDYgKzg2OSwxMyBAQCBpbnQgYW1kZ3B1X3R0bV90dF9nZXRfdXNlcl9wYWdlcyhzdHJ1Y3QgYW1k
Z3B1X2JvIAo+ICpibywgc3RydWN0IHBhZ2UgKipwYWdlcykKPiAgICAgICAgICAgICAgICAgIGdv
dG8gb3V0X2ZyZWVfcGZuczsKPiAgICAgICAgICB9Cj4gCj4gKyAgICAgICBtdXRleF9sb2NrKCZh
ZGV2LT5ub3RpZmllcl9sb2NrKTsKPiArCj4gKyAgICAgICBpZiAobW11X3JhbmdlX3JlYWRfcmV0
cnkoJmJvLT5ub3RpZmllciwgcmFuZ2UtPm5vdGlmaWVyX3NlcSkpIHsKPiArICAgICAgICAgICAg
ICAgbXV0ZXhfdW5sb2NrKCZhZGV2LT5ub3RpZmllcl9sb2NrKTsKPiArICAgICAgICAgICAgICAg
Z290byByZXRyeTsKPiArICAgICAgIH0KPiArCj4gICAgICAgICAgZm9yIChpID0gMDsgaSA8IHR0
bS0+bnVtX3BhZ2VzOyBpKyspIHsKPiAgICAgICAgICAgICAgICAgIHBhZ2VzW2ldID0gaG1tX2Rl
dmljZV9lbnRyeV90b19wYWdlKHJhbmdlLCByYW5nZS0+cGZuc1tpXSk7Cj4gICAgICAgICAgICAg
ICAgICBpZiAodW5saWtlbHkoIXBhZ2VzW2ldKSkgewo+IEBAIC04NzUsMTAgKzg4MywxMiBAQCBp
bnQgYW1kZ3B1X3R0bV90dF9nZXRfdXNlcl9wYWdlcyhzdHJ1Y3QgYW1kZ3B1X2JvIAo+ICpibywg
c3RydWN0IHBhZ2UgKipwYWdlcykKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGks
IHJhbmdlLT5wZm5zW2ldKTsKPiAgICAgICAgICAgICAgICAgICAgICAgICAgciA9IC1FTk9NRU07
Cj4gCj4gKyAgICAgICAgICAgICAgICAgICAgICAgbXV0ZXhfdW5sb2NrKCZhZGV2LT5ub3RpZmll
cl9sb2NrKTsKPiAgICAgICAgICAgICAgICAgICAgICAgICAgZ290byBvdXRfZnJlZV9wZm5zOwo+
ICAgICAgICAgICAgICAgICAgfQo+ICAgICAgICAgIH0KCldlbGwsIG1heWJlPyAKClRoZSBxdWVz
dGlvbiBub3cgaXMgd2hhdCBoYXBwZW5zIHRvICdwYWdlcycgPyBXaXRoIHRoaXMgYXJyYW5nbWVu
dCB0aGUKZHJpdmVyIGNhbm5vdCB0b3VjaCAncGFnZXMnIHdpdGhvdXQgYWxzbyBhZ2FpbiBnb2lu
ZyB1bmRlciB0aGUgbG9jawphbmQgY2hlY2tpbmcgcmV0cnkuIAoKSWYgaXQgZG9lc24ndCB0b3Vj
aCBpdCwgdGhlbiBsZXRzIGp1c3QgbW92ZSB0aGlzIGRldmljZV9lbnRyeV90b19wYWdlCnRvIGEg
bW9yZSBhcHByb3ByaWF0ZSBwbGFjZT8KCkknZCBwcmVmZXIgaXQgaWYgdGhlIGRyaXZlciBjb3Vs
ZCBiZSBzdHJ1Y3R1cmVkIGluIHRoZSBub3JtYWwgd2F5LAp3aXRoIGEgY2xlYXIgbG9ja2VkIHJl
Z2lvbiB3aGVyZSB0aGUgcGFnZSBsaXN0IGlzIGhhbmRsZWQuLgoKSmFzb24KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClhlbi1kZXZlbCBtYWlsaW5nIGxp
c3QKWGVuLWRldmVsQGxpc3RzLnhlbnByb2plY3Qub3JnCmh0dHBzOi8vbGlzdHMueGVucHJvamVj
dC5vcmcvbWFpbG1hbi9saXN0aW5mby94ZW4tZGV2ZWw=

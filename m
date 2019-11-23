From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH v3 02/14] mm/mmu_notifier: add an interval
 tree notifier
Date: Sat, 23 Nov 2019 23:59:53 +0000
Message-ID: <20191123235949.GE7481@mellanox.com>
References: <20191112202231.3856-1-jgg@ziepe.ca>
 <20191112202231.3856-3-jgg@ziepe.ca> <20191113135952.GB20531@infradead.org>
 <20191113164620.GG21728@mellanox.com>
 <cc5d4d76-df30-af7f-931c-eed8a7ada122@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xenproject.org>
In-Reply-To: <cc5d4d76-df30-af7f-931c-eed8a7ada122@nvidia.com>
Content-Language: en-US
Content-ID: <2C9272320C17A343A8D1A92DF2D430C9@eurprd05.prod.outlook.com>
List-Unsubscribe: <https://lists.xenproject.org/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xenproject.org>
List-Help: <mailto:xen-devel-request@lists.xenproject.org?subject=help>
List-Subscribe: <https://lists.xenproject.org/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xenproject.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xenproject.org>
To: Ralph Campbell <rcampbell@nvidia.com>
Cc: "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, David Zhou <David1.Zhou@amd.com>, Stefano Stabellini <sstabellini@kernel.org>, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Christoph Hellwig <hch@infradead.org>, Ben Skeggs <bskeggs@redhat.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Philip Yang <Philip.Yang@amd.com>, John Hubbard <jhubbard@nvidia.com>, Jerome Glisse <jglisse@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Petr Cvek <petrcvekcz@gmail.com>, Juergen Gross <jgross@suse.com>, Mike Marciniszyn <mike.marciniszyn@intel.com>, "Felix.Kuehling@amd.com" <Felix.Kuehl>
List-Id: amd-gfx.lists.freedesktop.org

T24gRnJpLCBOb3YgMjIsIDIwMTkgYXQgMDQ6NTQ6MDhQTSAtMDgwMCwgUmFscGggQ2FtcGJlbGwg
d3JvdGU6Cgo+IEFjdHVhbGx5LCBJIHRoaW5rIHlvdSBjYW4gcmVtb3ZlIHRoZSAibmVlZF93YWtl
IiB2YXJpYWJsZSBzaW5jZSBpdCBpcwo+IHVuY29uZGl0aW9uYWxseSBzZXQgdG8gInRydWUiLgoK
T2gsIHllcywgdGhhbmsgeW91LiBBbiBlYXJsaWVyIHJldmlzaW9uIGhhZCBhIGRpZmZlcmVudCBj
b250cm9sIGZsb3cKIAo+IEFsc28sIHRoZSBjb21tZW50IGluX19tbXVfaW50ZXJ2YWxfbm90aWZp
ZXJfaW5zZXJ0KCkgc2F5cwo+ICJtbmktPm1yX2ludmFsaWRhdGVfc2VxIiBhbmQgSSB0aGluayB0
aGF0IHNob3VsZCBiZQo+ICJtbmktPmludmFsaWRhdGVfc2VxIi4KCkdvdCBpdC4KCkkgc3F1YXNo
ZWQgdGhpcyBpbjoKCmRpZmYgLS1naXQgYS9tbS9tbXVfbm90aWZpZXIuYyBiL21tL21tdV9ub3Rp
Zmllci5jCmluZGV4IGIzYTA2NGIzYjMxODA3Li4zMGFiYmZkYzI1YmU1NSAxMDA2NDQKLS0tIGEv
bW0vbW11X25vdGlmaWVyLmMKKysrIGIvbW0vbW11X25vdGlmaWVyLmMKQEAgLTEyOSw3ICsxMjks
NiBAQCBzdGF0aWMgdm9pZCBtbl9pdHJlZV9pbnZfZW5kKHN0cnVjdCBtbXVfbm90aWZpZXJfbW0g
Km1tbl9tbSkKIHsKIAlzdHJ1Y3QgbW11X2ludGVydmFsX25vdGlmaWVyICptbmk7CiAJc3RydWN0
IGhsaXN0X25vZGUgKm5leHQ7Ci0JYm9vbCBuZWVkX3dha2UgPSBmYWxzZTsKIAogCXNwaW5fbG9j
aygmbW1uX21tLT5sb2NrKTsKIAlpZiAoLS1tbW5fbW0tPmFjdGl2ZV9pbnZhbGlkYXRlX3Jhbmdl
cyB8fApAQCAtMTQwLDcgKzEzOSw2IEBAIHN0YXRpYyB2b2lkIG1uX2l0cmVlX2ludl9lbmQoc3Ry
dWN0IG1tdV9ub3RpZmllcl9tbSAqbW1uX21tKQogCiAJLyogTWFrZSBpbnZhbGlkYXRlX3NlcSBl
dmVuICovCiAJbW1uX21tLT5pbnZhbGlkYXRlX3NlcSsrOwotCW5lZWRfd2FrZSA9IHRydWU7CiAK
IAkvKgogCSAqIFRoZSBpbnZfZW5kIGluY29ycG9yYXRlcyBhIGRlZmVycmVkIG1lY2hhbmlzbSBs
aWtlIHJ0bmxfdW5sb2NrKCkuCkBAIC0xNjAsOCArMTU4LDcgQEAgc3RhdGljIHZvaWQgbW5faXRy
ZWVfaW52X2VuZChzdHJ1Y3QgbW11X25vdGlmaWVyX21tICptbW5fbW0pCiAJfQogCXNwaW5fdW5s
b2NrKCZtbW5fbW0tPmxvY2spOwogCi0JaWYgKG5lZWRfd2FrZSkKLQkJd2FrZV91cF9hbGwoJm1t
bl9tbS0+d3EpOworCXdha2VfdXBfYWxsKCZtbW5fbW0tPndxKTsKIH0KIAogLyoqCkBAIC04ODQs
NyArODgxLDcgQEAgc3RhdGljIGludCBfX21tdV9pbnRlcnZhbF9ub3RpZmllcl9pbnNlcnQoCiAJ
ICogcG9zc2liaWxpdHkgZm9yIGxpdmUgbG9jaywgaW5zdGVhZCBkZWZlciB0aGUgYWRkIHRvCiAJ
ICogbW5faXRyZWVfaW52X2VuZCgpIHNvIHRoaXMgYWxnb3JpdGhtIGlzIGRldGVybWluaXN0aWMu
CiAJICoKLQkgKiBJbiBhbGwgY2FzZXMgdGhlIHZhbHVlIGZvciB0aGUgbW5pLT5tcl9pbnZhbGlk
YXRlX3NlcSBzaG91bGQgYmUKKwkgKiBJbiBhbGwgY2FzZXMgdGhlIHZhbHVlIGZvciB0aGUgbW5p
LT5pbnZhbGlkYXRlX3NlcSBzaG91bGQgYmUKIAkgKiBvZGQsIHNlZSBtbXVfaW50ZXJ2YWxfcmVh
ZF9iZWdpbigpCiAJICovCiAJc3Bpbl9sb2NrKCZtbW5fbW0tPmxvY2spOwoKSmFzb24KCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClhlbi1kZXZlbCBtYWls
aW5nIGxpc3QKWGVuLWRldmVsQGxpc3RzLnhlbnByb2plY3Qub3JnCmh0dHBzOi8vbGlzdHMueGVu
cHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby94ZW4tZGV2ZWw=

From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH v2 09/15] xen/gntdev: use
 mmu_range_notifier_insert
Date: Tue, 5 Nov 2019 02:31:12 +0000
Message-ID: <20191105023108.GN22766@mellanox.com>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-10-jgg@ziepe.ca>
 <3938b588-c6c5-3bd1-8ea9-47e4d5b2045c@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xenproject.org>
In-Reply-To: <3938b588-c6c5-3bd1-8ea9-47e4d5b2045c@oracle.com>
Content-Language: en-US
Content-ID: <27A5E315F0FBE349AC48D47C02A20B09@eurprd05.prod.outlook.com>
List-Unsubscribe: <https://lists.xenproject.org/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xenproject.org>
List-Help: <mailto:xen-devel-request@lists.xenproject.org?subject=help>
List-Subscribe: <https://lists.xenproject.org/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xenproject.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xenproject.org>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>, David Zhou <David1.Zhou@amd.com>, Ralph Campbell <rcampbell@nvidia.com>, Stefano Stabellini <sstabellini@kernel.org>, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, John Hubbard <jhubbard@nvidia.com>, "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>, Mike Marciniszyn <mike.marciniszyn@intel.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Christoph Hellwig <hch@infradead.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Jerome Glisse <jglisse@redhat.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Dennis Dalessandro <dennis.dalessandro@intel.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gTW9uLCBOb3YgMDQsIDIwMTkgYXQgMDU6MDM6MzFQTSAtMDUwMCwgQm9yaXMgT3N0cm92c2t5
IHdyb3RlOgo+IE9uIDEwLzI4LzE5IDQ6MTAgUE0sIEphc29uIEd1bnRob3JwZSB3cm90ZToKPiA+
IEBAIC00NDUsMTcgKzQzOCw5IEBAIHN0YXRpYyB2b2lkIGdudGRldl92bWFfY2xvc2Uoc3RydWN0
IHZtX2FyZWFfc3RydWN0ICp2bWEpCj4gPiAgCXN0cnVjdCBnbnRkZXZfcHJpdiAqcHJpdiA9IGZp
bGUtPnByaXZhdGVfZGF0YTsKPiA+ICAKPiA+ICAJcHJfZGVidWcoImdudGRldl92bWFfY2xvc2Ug
JXBcbiIsIHZtYSk7Cj4gPiAtCWlmICh1c2VfcHRlbW9kKSB7Cj4gPiAtCQkvKiBJdCBpcyBwb3Nz
aWJsZSB0aGF0IGFuIG1tdSBub3RpZmllciBjb3VsZCBiZSBydW5uaW5nCj4gPiAtCQkgKiBjb25j
dXJyZW50bHksIHNvIHRha2UgcHJpdi0+bG9jayB0byBlbnN1cmUgdGhhdCB0aGUgdm1hIHdvbid0
Cj4gPiAtCQkgKiB2YW5pc2hpbmcgZHVyaW5nIHRoZSB1bm1hcF9ncmFudF9wYWdlcyBjYWxsLCBz
aW5jZSB3ZSB3aWxsCj4gPiAtCQkgKiBzcGluIGhlcmUgdW50aWwgdGhhdCBjb21wbGV0ZXMuIFN1
Y2ggYSBjb25jdXJyZW50IGNhbGwgd2lsbAo+ID4gLQkJICogbm90IGRvIGFueSB1bm1hcHBpbmcs
IHNpbmNlIHRoYXQgaGFzIGJlZW4gZG9uZSBwcmlvciB0bwo+ID4gLQkJICogY2xvc2luZyB0aGUg
dm1hLCBidXQgaXQgbWF5IHN0aWxsIGl0ZXJhdGUgdGhlIHVubWFwX29wcyBsaXN0Lgo+ID4gLQkJ
ICovCj4gPiAtCQltdXRleF9sb2NrKCZwcml2LT5sb2NrKTsKPiA+ICsJaWYgKHVzZV9wdGVtb2Qg
JiYgbWFwLT52bWEgPT0gdm1hKSB7Cj4gCj4gCj4gSXMgaXQgcG9zc2libGUgZm9yIG1hcC0+dm1h
IG5vdCB0byBiZSBlcXVhbCB0byB2bWE/CgpJdCBjb3VsZCBiZSBOVUxMIGF0IGxlYXN0IGlmIHVz
ZV9wdGVtb2QgaXMgbm90IHNldC4KCk90aGVyd2lzZSwgSSdtIG5vdCBzdXJlLCB0aGUgY29uZnVz
aW5nIGJpdCBpcyB0aGF0IHRoZSBtYXAgY29tZXMgZnJvbQpoZXJlOgoKICAgICAgICBtYXAgPSBn
bnRkZXZfZmluZF9tYXBfaW5kZXgocHJpdiwgaW5kZXgsIGNvdW50KTsKCkl0IGxvb2tzIGxpa2Ug
dGhlIGludGVudCBpcyB0aGF0IHRoZSBtYXAtPnZtYSBpcyBhbHdheXMgc2V0IHRvIHRoZQpvbmx5
IHZtYSB0aGF0IGhhcyB0aGUgbWFwIGFzIHByaXZhdGVfZGF0YS4KClNvLCBJIHN1cHBvc2UgaXQg
Y2FuIGJlIHJlbGF4ZWQgdG8gYSBudWxsIHRlc3QgYW5kIGEgV0FSTl9PTiB0aGF0IGl0Cmhhc24n
dCBjaGFuZ2VkPwoKSmFzb24KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClhlbi1kZXZlbCBtYWlsaW5nIGxpc3QKWGVuLWRldmVsQGxpc3RzLnhlbnByb2pl
Y3Qub3JnCmh0dHBzOi8vbGlzdHMueGVucHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby94ZW4t
ZGV2ZWw=

From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH v2 14/15] drm/amdgpu: Use mmu_range_notifier
 instead of hmm_mirror
Date: Tue, 29 Oct 2019 19:25:48 +0000
Message-ID: <20191029192544.GU22766@mellanox.com>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-15-jgg@ziepe.ca>
 <a456ebd0-28cf-997b-31ff-72d9077a9b8e@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xenproject.org>
In-Reply-To: <a456ebd0-28cf-997b-31ff-72d9077a9b8e@amd.com>
Content-Language: en-US
Content-ID: <F8CA839373A7664D9975C1FAC4028043@eurprd05.prod.outlook.com>
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

T24gVHVlLCBPY3QgMjksIDIwMTkgYXQgMDc6MjI6MzdQTSArMDAwMCwgWWFuZywgUGhpbGlwIHdy
b3RlOgo+IEhpIEphc29uLAo+IAo+IEkgZGlkIHF1aWNrIHRlc3QgYWZ0ZXIgbWVyZ2luZyBhbWQt
c3RhZ2luZy1kcm0tbmV4dCB3aXRoIHRoZSAKPiBtbXVfbm90aWZpZXIgYnJhbmNoLCB3aGljaCBp
bmNsdWRlcyB0aGlzIHNldCBjaGFuZ2VzLiBUaGUgdGVzdCByZXN1bHQgCj4gaGFzIGRpZmZlcmVu
dCBmYWlsdXJlcywgYXBwIHN0dWNrIGludGVybWl0dGVudGx5LCBHVUkgbm8gZGlzcGxheSBldGMu
IEkgCj4gYW0gdW5kZXJzdGFuZGluZyB0aGUgY2hhbmdlcyBhbmQgd2lsbCB0cnkgdG8gZmlndXJl
IG91dCB0aGUgY2F1c2UuCgpUaGFua3MhIEknbSBub3Qgc3VycHJpc2VkIGJ5IHRoaXMgZ2l2ZW4g
aG93IGRpZmZpY3VsdCB0aGlzIHBhdGNoIHdhcwp0byBtYWtlLiBMZXQgbWUga25vdyBpZiBJIGNh
biBhc3Npc3QgaW4gYW55IHdheQoKUGxlYXNlIGVuc3VyZSB0byBydW4gd2l0aCBsb2NrZGVwIGVu
YWJsZWQuLiBZb3VyIHN5bXB0b3BzIHNvdW5kcyBzb3J0Cm9mIGxpa2UgZGVhZGxvY2tpbmc/CgpS
ZWdhcmRzLApKYXNvbgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KWGVuLWRldmVsIG1haWxpbmcgbGlzdApYZW4tZGV2ZWxAbGlzdHMueGVucHJvamVjdC5v
cmcKaHR0cHM6Ly9saXN0cy54ZW5wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3hlbi1kZXZl
bA==

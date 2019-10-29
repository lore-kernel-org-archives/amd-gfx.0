From: Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: Re: [PATCH hmm 06/15] RDMA/hfi1: Use mmu_range_notifier_inset for
 user_exp_rcv
Date: Tue, 29 Oct 2019 08:15:00 -0400
Message-ID: <fbe0ba5a-916b-c631-3faa-74f18909643c@intel.com>
References: <20191015181242.8343-1-jgg@ziepe.ca>
 <20191015181242.8343-7-jgg@ziepe.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20191015181242.8343-7-jgg@ziepe.ca>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Jerome Glisse <jglisse@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>, John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc: Andrea Arcangeli <aarcange@redhat.com>, Mike Marciniszyn <mike.marciniszyn@intel.com>, linux-rdma@vger.kernel.org, amd-gfx@lists.freedesktop.org, linux-mm@kvack.org, Jason Gunthorpe <jgg@mellanox.com>, dri-devel@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gMTAvMTUvMjAxOSAyOjEyIFBNLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6Cj4gRnJvbTogSmFz
b24gR3VudGhvcnBlIDxqZ2dAbWVsbGFub3guY29tPgo+IAo+IFRoaXMgY29udmVydHMgb25lIG9m
IHRoZSB0d28gdXNlcnMgb2YgbW11X25vdGlmaWVycyB0byB1c2UgdGhlIG5ldyBBUEkuCj4gVGhl
IGNvbnZlcnNpb24gaXMgZmFpcmx5IHN0cmFpZ2h0Zm9yd2FyZCwgaG93ZXZlciB0aGUgZXhpc3Rp
bmcgdXNlIG9mCj4gbm90aWZpZXJzIGhlcmUgc2VlbXMgdG8gYmUgcmFjZXkuCj4gCj4gQ2M6IE1p
a2UgTWFyY2luaXN6eW4gPG1pa2UubWFyY2luaXN6eW5AaW50ZWwuY29tPgo+IENjOiBEZW5uaXMg
RGFsZXNzYW5kcm8gPGRlbm5pcy5kYWxlc3NhbmRyb0BpbnRlbC5jb20+Cj4gU2lnbmVkLW9mZi1i
eTogSmFzb24gR3VudGhvcnBlIDxqZ2dAbWVsbGFub3guY29tPgoKVHlwbyBpbiBzdWJqZWN0IHMv
aW5zZXQvaW5zZXJ0LgoKVGVzdGVkLWJ5OiBEZW5uaXMgRGFsZXNzYW5kcm8gPGRlbm5pcy5kYWxl
c3NhbmRyb0BpbnRlbC5jb20+CgpUaGFua3MKCi1EZW5ueQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZl
bEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9kcmktZGV2ZWw=

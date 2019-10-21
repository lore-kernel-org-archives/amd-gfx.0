From: Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: Re: [PATCH hmm 00/15] Consolidate the mmu notifier interval_tree and
 locking
Date: Mon, 21 Oct 2019 11:55:51 -0400
Message-ID: <5fdbcda8-c6ec-70aa-3f89-147fe67152f2@intel.com>
References: <20191015181242.8343-1-jgg@ziepe.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20191015181242.8343-1-jgg@ziepe.ca>
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
Cc: Andrea Arcangeli <aarcange@redhat.com>, linux-rdma@vger.kernel.org, amd-gfx@lists.freedesktop.org, linux-mm@kvack.org, Jason Gunthorpe <jgg@mellanox.com>, dri-devel@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gMTAvMTUvMjAxOSAyOjEyIFBNLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6Cj4gVGhpcyBpcyBz
dGlsbCBiZWluZyB0ZXN0ZWQsIGJ1dCBJIGZpZ3VyZWQgdG8gc2VuZCBpdCB0byBzdGFydCBnZXR0
aW5nIGhlbHAKPiBmcm9tIHRoZSB4ZW4sIGFtZCBhbmQgaGZpIGRyaXZlcnMgd2hpY2ggSSBjYW5u
b3QgdGVzdCBoZXJlLgoKU29ycnkgZm9yIHRoZSBkZWxheSwgSSBuZXZlciBzZWVuIHRoaXMuIFdh
cyBub3Qgb24gQ2MgbGlzdCBhbmQgZGlkbid0IApyZWdpc3RlciB0byBtZSBpdCBpbXBhY3RlZCBo
ZmkuIEknbGwgdGFrZSBhIGxvb2sgYW5kIHJ1biBpdCB0aHJvdWdoIHNvbWUgCmhmaTEgdGVzdHMu
CgotRGVubnkKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
ZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs

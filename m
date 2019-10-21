From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH hmm 00/15] Consolidate the mmu notifier interval_tree and
 locking
Date: Mon, 21 Oct 2019 16:58:31 +0000
Message-ID: <20191021165828.GA6285@mellanox.com>
References: <20191015181242.8343-1-jgg@ziepe.ca>
 <5fdbcda8-c6ec-70aa-3f89-147fe67152f2@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <5fdbcda8-c6ec-70aa-3f89-147fe67152f2@intel.com>
Content-Language: en-US
Content-ID: <0BEC4912CF056E498EEC73DAB37D8D9B@eurprd05.prod.outlook.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, John Hubbard <jhubbard@nvidia.com>, "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Jerome Glisse <jglisse@redhat.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Ben Skeggs <bskeggs@redhat.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gTW9uLCBPY3QgMjEsIDIwMTkgYXQgMTE6NTU6NTFBTSAtMDQwMCwgRGVubmlzIERhbGVzc2Fu
ZHJvIHdyb3RlOgo+IE9uIDEwLzE1LzIwMTkgMjoxMiBQTSwgSmFzb24gR3VudGhvcnBlIHdyb3Rl
Ogo+ID4gVGhpcyBpcyBzdGlsbCBiZWluZyB0ZXN0ZWQsIGJ1dCBJIGZpZ3VyZWQgdG8gc2VuZCBp
dCB0byBzdGFydCBnZXR0aW5nIGhlbHAKPiA+IGZyb20gdGhlIHhlbiwgYW1kIGFuZCBoZmkgZHJp
dmVycyB3aGljaCBJIGNhbm5vdCB0ZXN0IGhlcmUuCj4gCj4gU29ycnkgZm9yIHRoZSBkZWxheSwg
SSBuZXZlciBzZWVuIHRoaXMuIFdhcyBub3Qgb24gQ2MgbGlzdCBhbmQgZGlkbid0Cj4gcmVnaXN0
ZXIgdG8gbWUgaXQgaW1wYWN0ZWQgaGZpLiBJJ2xsIHRha2UgYSBsb29rIGFuZCBydW4gaXQgdGhy
b3VnaCBzb21lCj4gaGZpMSB0ZXN0cy4KCkhtLCB5b3Ugd2VyZSBjYydkIG9uIHRoZSBoZmkxIHBh
dGNoIG9mIHRoZSBzZXJpZXM6CgpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzEx
MTkxMzk1LwoKU28geW91IHNhdyB0aGF0LCByaWdodD8KCkJ1dCBpdCBzZWVtcyB0aGF0IGdpdCBz
ZW5kLWVtYWlsIGRpZG4ndCBwdWxsIGFsbCB0aGUgY2MncyB0b2dldGhlcj8KCkphc29uCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWls
aW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbA==

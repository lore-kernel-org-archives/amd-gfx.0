From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH hmm 00/15] Consolidate the mmu notifier interval_tree and
 locking
Date: Tue, 22 Oct 2019 14:37:28 +0000
Message-ID: <20191022143724.GD22766@mellanox.com>
References: <20191015181242.8343-1-jgg@ziepe.ca>
 <5fdbcda8-c6ec-70aa-3f89-147fe67152f2@intel.com>
 <20191021165828.GA6285@mellanox.com>
 <35d803f3-a24a-8a5f-745b-52c2f9876b7c@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <35d803f3-a24a-8a5f-745b-52c2f9876b7c@intel.com>
Content-Language: en-US
Content-ID: <89B2B12146ECCE40A22BE95FBC8684FE@eurprd05.prod.outlook.com>
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

T24gVHVlLCBPY3QgMjIsIDIwMTkgYXQgMDc6NTY6MTJBTSAtMDQwMCwgRGVubmlzIERhbGVzc2Fu
ZHJvIHdyb3RlOgo+IE9uIDEwLzIxLzIwMTkgMTI6NTggUE0sIEphc29uIEd1bnRob3JwZSB3cm90
ZToKPiA+IE9uIE1vbiwgT2N0IDIxLCAyMDE5IGF0IDExOjU1OjUxQU0gLTA0MDAsIERlbm5pcyBE
YWxlc3NhbmRybyB3cm90ZToKPiA+ID4gT24gMTAvMTUvMjAxOSAyOjEyIFBNLCBKYXNvbiBHdW50
aG9ycGUgd3JvdGU6Cj4gPiA+ID4gVGhpcyBpcyBzdGlsbCBiZWluZyB0ZXN0ZWQsIGJ1dCBJIGZp
Z3VyZWQgdG8gc2VuZCBpdCB0byBzdGFydCBnZXR0aW5nIGhlbHAKPiA+ID4gPiBmcm9tIHRoZSB4
ZW4sIGFtZCBhbmQgaGZpIGRyaXZlcnMgd2hpY2ggSSBjYW5ub3QgdGVzdCBoZXJlLgo+ID4gPiAK
PiA+ID4gU29ycnkgZm9yIHRoZSBkZWxheSwgSSBuZXZlciBzZWVuIHRoaXMuIFdhcyBub3Qgb24g
Q2MgbGlzdCBhbmQgZGlkbid0Cj4gPiA+IHJlZ2lzdGVyIHRvIG1lIGl0IGltcGFjdGVkIGhmaS4g
SSdsbCB0YWtlIGEgbG9vayBhbmQgcnVuIGl0IHRocm91Z2ggc29tZQo+ID4gPiBoZmkxIHRlc3Rz
Lgo+ID4gCj4gPiBIbSwgeW91IHdlcmUgY2MnZCBvbiB0aGUgaGZpMSBwYXRjaCBvZiB0aGUgc2Vy
aWVzOgo+ID4gCj4gPiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzExMTkxMzk1
Lwo+ID4gCj4gPiBTbyB5b3Ugc2F3IHRoYXQsIHJpZ2h0Pwo+IAo+IEkgZG8gbm93Lgo+IAo+ID4g
QnV0IGl0IHNlZW1zIHRoYXQgZ2l0IHNlbmQtZW1haWwgZGlkbid0IHB1bGwgYWxsIHRoZSBjYydz
IHRvZ2V0aGVyPwo+IAo+IEkgZG9uJ3Qga25vdy4gSSB0aG91Z2h0IGl0IGRpZCwgYXQgb25lIHRp
bWUgSSByZWNhbGwgdHJ5aW5nIHRvIGdldCBpdCAqbm90Kgo+IHRvIGRvIHRoYXQsIHdoZW4gcHJl
cGFyaW5nIHNvbWUgaW50ZXJuYWwgcmV2aWV3cy4gSGF2ZW4ndCB1c2VkIGl0IGZvciBhIGxvbmcK
PiB0aW1lIHRob3VnaCwgSSd2ZSBiZWVuIHVzaW5nIHN0Z2l0Lgo+IAo+IEF0IGFueSByYXRlIGNh
biB5b3UgZ2l2ZSBtZSBhIFNIQSBvciBicmFuY2ggdGhpcyBhcHBsaWVzIG9uIHRvcCBvZj8gSSBo
YXZlCj4gcHVsbGVkIHJkbWEvaG1tLCByZG1hL3dpcC9qZ2csIGxpbnVzL21hc3RlciBidXQgc2Vl
bSB0byBoYXZlIGNvbmZsaWN0cy4KCkhlcmUgaXMgYSBmdWxsIHRyZWU6CgpodHRwczovL2dpdGh1
Yi5jb20vamd1bnRob3JwZS9saW51eC9jb21taXRzL21tdV9ub3RpZmllcgoKSXQgbmVlZHMgdGhl
IE9EUCBzZXJpZXMgb24gdGhlIG1haWxpbmcgbGlzdCB0byBhcHBseQoKVGhhbmtzLApKYXNvbgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwg
bWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWw=

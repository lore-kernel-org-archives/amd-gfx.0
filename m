From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH hmm 15/15] mm/hmm: remove hmm_mirror and related
Date: Mon, 21 Oct 2019 18:57:42 +0000
Message-ID: <20191021185738.GH6285@mellanox.com>
References: <20191015181242.8343-1-jgg@ziepe.ca>
 <20191015181242.8343-16-jgg@ziepe.ca> <20191021183824.GE3177@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20191021183824.GE3177@redhat.com>
Content-Language: en-US
Content-ID: <08002827BBC4AD498462229A8A58EBB7@eurprd05.prod.outlook.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Jerome Glisse <jglisse@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, John Hubbard <jhubbard@nvidia.com>, "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Ben Skeggs <bskeggs@redhat.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gTW9uLCBPY3QgMjEsIDIwMTkgYXQgMDI6Mzg6MjRQTSAtMDQwMCwgSmVyb21lIEdsaXNzZSB3
cm90ZToKPiBPbiBUdWUsIE9jdCAxNSwgMjAxOSBhdCAwMzoxMjo0MlBNIC0wMzAwLCBKYXNvbiBH
dW50aG9ycGUgd3JvdGU6Cj4gPiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BtZWxsYW5veC5j
b20+Cj4gPiAKPiA+IFRoZSBvbmx5IHR3byB1c2VycyBvZiB0aGlzIGFyZSBub3cgY29udmVydGVk
IHRvIHVzZSBtbXVfcmFuZ2Vfbm90aWZpZXIsCj4gPiBkZWxldGUgYWxsIHRoZSBjb2RlIGFuZCB1
cGRhdGUgaG1tLnJzdC4KPiAKPiBJIGd1ZXNzIGkgc2hvdWxkIHBvaW50IG91dCB0aGF0IHRoZSBy
ZWFzb25zIGZvciBobW1fbWlycm9yIGFuZCBobW0KPiB3YXMgZm9yOgo+ICAgICAxKSBNYXliZSBk
ZWZpbmUgYSBjb21tb24gQVBJIGZvciB1c2Vyc3BhY2UgdG8gcHJvdmlkZSBtZW1vcnkKPiAgICAg
ICAgcGxhY2VtZW50IGhpbnRzIChOVU1BIGZvciBHUFUpCgpEbyB5b3UgdGhpbmsgdGhpcyBuZWVk
cyBzcGVjaWFsIGNvZGUgaW4gdGhlIG5vdGlmaWVycz8KCj4gICAgIDIpIG11bHRpLWRldmljZXMg
c2hhcmluZyBzYW1lIG1pcnJvciBwYWdlIHRhYmxlCgpPaCBuZWF0LCBidXQgSSB0aGluayB0aGlz
IGp1c3QgbWVhbnMgdGhlIEdQVSBkcml2ZXIgaGFzIHRvIHJlZ2lzdGVyIGEKc2luZ2xlIG5vdGlm
aWVyIGZvciBtdWx0aXBsZSBHUFVzPz8KCj4gQnV0IHN1cHBvcnQgZm9yIG11bHRpLUdQVSBpbiBu
b3V2ZWF1IGlzIHdheSBiZWhpbmQgYW5kIGkgZ3Vlc3Mgc3VjaAo+IG9wdGltaXphdGlvbiB3aWxs
IGhhdmUgdG8gcmUtbWF0ZXJpYWxpemUgd2hhdCBpcyBuZWNlc3Nhcnkgb25jZSB0aGF0Cj4gaGFw
cGVucy4KClN1cmUsIGl0IHdpbGwgYmUgZWFzaWVyIHRvIHVuZGVyc3RhbmQgd2hhdCBpcyBuZWVk
ZWQgd2l0aCBhIGJpdCBvZgpjb2RlIQoKPiBOb3RlIHRoaXMgcGF0Y2ggc2hvdWxkIGFsc28gdXBk
YXRlIGtlcm5lbC9mb3JrLmMgYW5kIHRoZSBtbV9zdHJ1Y3QKPiBkZWZpbml0aW9uIEFGQUlDVC4g
V2l0aCB0aG9zZSBjaGFuZ2VzIHlvdSBjYW4gYWRkIG15OgoKQ2FuIHlvdSBwbGVhc2UgZWxhYm9y
YXRlIHdoYXQgdXBkYXRlcyB5b3UgbWVhbj8gSSdtIG5vdCBzdXJlLiAKCk1heWJlIEkgYWxyZWFk
eSBnb3QgdGhlIHRoaW5ncyB5b3UgYXJlIHRoaW5raW5nIG9mIHdpdGggdGhlIGdldC9wdXQKY2hh
bmdlcz8KClRoYW5rcywKSmFzb24KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
ZHJpLWRldmVs

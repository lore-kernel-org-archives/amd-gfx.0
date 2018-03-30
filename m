From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/8] PCI: Add pci_find_common_upstream_dev()
Date: Thu, 29 Mar 2018 23:33:34 -0700
Message-ID: <20180330063334.GA8634@infradead.org>
References: <16c7bef8-5f03-9e89-1f50-b62fb139a36f@deltatee.com>
 <6a5c9a10-50fe-b03d-dfc1-791d62d79f8e@amd.com>
 <e751cd28-f115-569f-5248-d24f30dee3cb@deltatee.com>
 <73578b4e-664b-141c-3e1f-e1fae1e4db07@amd.com>
 <1b08c13e-b4a2-08f2-6194-93e6c21b7965@deltatee.com>
 <70adc2cc-f7aa-d4b9-7d7a-71f3ae99f16c@gmail.com>
 <98ce6cfd-bcf3-811e-a0f1-757b60da467a@deltatee.com>
 <8d050848-8970-b8c4-a657-429fefd31769@amd.com>
 <d2de0c2e-4c2d-9e46-1c26-bfa40ca662ff@deltatee.com>
 <20180330015854.GA3572@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20180330015854.GA3572@redhat.com>
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
Cc: linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, dri-devel@lists.freedesktop.org, Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, linux-media@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

T24gVGh1LCBNYXIgMjksIDIwMTggYXQgMDk6NTg6NTRQTSAtMDQwMCwgSmVyb21lIEdsaXNzZSB3
cm90ZToKPiBkbWFfbWFwX3Jlc291cmNlKCkgaXMgdGhlIHJpZ2h0IEFQSSAodGhvdWdodCBpdHMg
Y3VycmVudCBpbXBsZW1lbnRhdGlvbgo+IGlzIGZpbGwgd2l0aCB4ODYgYXNzdW1wdGlvbnMpLiBT
byBpIHdvdWxkIGFyZ3VlIHRoYXQgYXJjaCBjYW4gZGVjaWRlIHRvCj4gaW1wbGVtZW50IGl0IG9y
IHNpbXBseSByZXR1cm4gZG1hIGVycm9yIGFkZHJlc3Mgd2hpY2ggdHJpZ2dlciBmYWxsYmFjawo+
IHBhdGggaW50byB0aGUgY2FsbGVyIChhdCBsZWFzdCBmb3IgR1BVIGRyaXZlcnMpLiBTRyB2YXJp
YW50IGNhbiBiZSBhZGRlZAo+IG9uIHRvcC4KCkl0IGlzbid0IGluIGdlbmVyYWwuICBJdCBkb2Vz
bid0IGludGVncmF0ZSB3aXRoIHNjYXR0ZXJsaXN0cyAoc2VlIG15CmNvbW1lbnQgdG8gcGFnZSBv
bmUpLCBhbmQgaXQgZG9lc24ndCBpbnRlZ3JhdGUgd2l0aCBhbGwgdGhlIHN1YnN5c3RlbXMKdGhh
dCBhbHNvIG5lZWQgYSBrZXJuZWwgdmlydHVhbCBhZGRyZXNzLgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1k
ZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK

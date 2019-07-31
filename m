From: Jason Gunthorpe <jgg-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 02/13] amdgpu: don't initialize range->list in
 amdgpu_hmm_init_range
Date: Wed, 31 Jul 2019 17:02:24 +0000
Message-ID: <20190731170219.GG22677@mellanox.com>
References: <20190730055203.28467-1-hch@lst.de>
 <20190730055203.28467-3-hch@lst.de>
 <a4586f5c-0ae4-8cbd-65ff-dfe70d34f99b@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <a4586f5c-0ae4-8cbd-65ff-dfe70d34f99b-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <FAC49FFA8B421F49B49EF44701A00263-wNKe6lTLrGecE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/nouveau>,
 <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/nouveau>
List-Post: <mailto:nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/nouveau>,
 <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "Nouveau" <nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: Ralph Campbell <rcampbell-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, Ben Skeggs <bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gV2VkLCBKdWwgMzEsIDIwMTkgYXQgMDE6MjU6MDZQTSArMDAwMCwgS3VlaGxpbmcsIEZlbGl4
IHdyb3RlOgo+IE9uIDIwMTktMDctMzAgMTo1MSBhLm0uLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToKPiA+IFRoZSBsaXN0IGlzIHVzZWQgdG8gYWRkIHRoZSByYW5nZSB0byBhbm90aGVyIGxpc3Qg
YXMgYW4gZW50cnkgaW4gdGhlCj4gPiBjb3JlIGhtbSBjb2RlLCBzbyB0aGVyZSBpcyBubyBuZWVk
IHRvIGluaXRpYWxpemUgaXQgaW4gYSBkcml2ZXIuCj4gCj4gSSd2ZSBzZWVuIGNvZGUgdGhhdCB1
c2VzIGxpc3RfZW1wdHkgdG8gY2hlY2sgd2hldGhlciBhIGxpc3QgaGVhZCBoYXMgCj4gYmVlbiBh
ZGRlZCB0byBhIGxpc3Qgb3Igbm90LiBGb3IgdGhhdCB0byB3b3JrLCB0aGUgbGlzdCBoZWFkIG5l
ZWRzIHRvIGJlIAo+IGluaXRpYWxpemVkLCBhbmQgaXQgaGFzIHRvIGJlIHJlbW92ZWQgd2l0aCBs
aXN0X2RlbF9pbml0LiAKCkkgdGhpbmsgdGhlIGlkYSBpcyB0aGF0ICdsaXN0JyBpcyBhIHByaXZh
dGUgbWVtYmVyIG9mIHJhbmdlIGFuZApkcml2ZXJzIHNob3VsZG4ndCB0b3VjaCBpdCBhdCBhbGwu
Cgo+IGV2ZXIgZG8gdGhhdCB3aXRoIHJhbmdlLT5saXN0LCB0aGVuIHRoaXMgcGF0Y2ggaXMgUmV2
aWV3ZWQtYnk6IEZlbGl4IAo+IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgoKUGxl
YXNlIHB1dCB0YWdzIG9uIHRoZWlyIG93biBlbXB0eSBsaW5lIHNvIHRoYXQgcGF0Y2h3b3JrcyB3
aWxsCmNvbGxlY3QgdGhlbSBhdXRvbWF0aWNhbGx5Li4KCkphc29uCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCk5vdXZlYXUgbWFpbGluZyBsaXN0Ck5vdXZl
YXVAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vbm91dmVhdQ==

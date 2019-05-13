From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] mm/hmm: support automatic NUMA balancing
Date: Mon, 13 May 2019 14:27:20 -0700
Message-ID: <20190513142720.3334a98cbabaae67b4ffbb5a@linux-foundation.org>
References: <20190510195258.9930-1-Felix.Kuehling@amd.com>
 <20190510195258.9930-2-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190510195258.9930-2-Felix.Kuehling@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Cc: "Yang, Philip" <Philip.Yang@amd.com>, "alex.deucher@amd.com" <alex.deucher@amd.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "jglisse@redhat.com" <jglisse@redhat.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gRnJpLCAxMCBNYXkgMjAxOSAxOTo1MzoyMyArMDAwMCAiS3VlaGxpbmcsIEZlbGl4IiA8RmVs
aXguS3VlaGxpbmdAYW1kLmNvbT4gd3JvdGU6Cgo+IEZyb206IFBoaWxpcCBZYW5nIDxQaGlsaXAu
WWFuZ0BhbWQuY29tPgo+IAo+IFdoaWxlIHRoZSBwYWdlIGlzIG1pZ3JhdGluZyBieSBOVU1BIGJh
bGFuY2luZywgSE1NIGZhaWxlZCB0byBkZXRlY3QgdGhpcwo+IGNvbmRpdGlvbiBhbmQgc3RpbGwg
cmV0dXJuIHRoZSBvbGQgcGFnZS4gQXBwbGljYXRpb24gd2lsbCB1c2UgdGhlIG5ldwo+IHBhZ2Ug
bWlncmF0ZWQsIGJ1dCBkcml2ZXIgcGFzcyB0aGUgb2xkIHBhZ2UgcGh5c2ljYWwgYWRkcmVzcyB0
byBHUFUsCj4gdGhpcyBjcmFzaCB0aGUgYXBwbGljYXRpb24gbGF0ZXIuCj4gCj4gVXNlIHB0ZV9w
cm90bm9uZShwdGUpIHRvIHJldHVybiB0aGlzIGNvbmRpdGlvbiBhbmQgdGhlbiBobW1fdm1hX2Rv
X2ZhdWx0Cj4gd2lsbCBhbGxvY2F0ZSBuZXcgcGFnZS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBQaGls
aXAgWWFuZyA8UGhpbGlwLllhbmdAYW1kLmNvbT4KClRoaXMgc2hvdWxkIGhhdmUgaW5jbHVkZWQg
eW91ciBzaWduZWQtb2ZmLWJ5Oiwgc2luY2UgeW91IHdlcmUgb24gdGhlCnBhdGNoIGRlbGl2ZXJ5
IHBhdGguICBJJ2xsIG1ha2UgdGhhdCBjaGFuZ2UgdG8gbXkgY29weSBvZiB0aGUgcGF0Y2gsCk9L
PwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2
ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWw=

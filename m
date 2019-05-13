From: Jerome Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] mm/hmm: support automatic NUMA balancing
Date: Mon, 13 May 2019 18:37:01 -0400
Message-ID: <20190513223700.GA673@redhat.com>
References: <20190510195258.9930-1-Felix.Kuehling@amd.com>
 <20190510195258.9930-2-Felix.Kuehling@amd.com>
 <20190513142720.3334a98cbabaae67b4ffbb5a@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20190513142720.3334a98cbabaae67b4ffbb5a-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: "Yang, Philip" <Philip.Yang-5C7GfCeVMHo@public.gmane.org>, "alex.deucher-5C7GfCeVMHo@public.gmane.org" <alex.deucher-5C7GfCeVMHo@public.gmane.org>, "Kuehling,
 Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

T24gTW9uLCBNYXkgMTMsIDIwMTkgYXQgMDI6Mjc6MjBQTSAtMDcwMCwgQW5kcmV3IE1vcnRvbiB3
cm90ZToKPiBPbiBGcmksIDEwIE1heSAyMDE5IDE5OjUzOjIzICswMDAwICJLdWVobGluZywgRmVs
aXgiIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPiB3cm90ZToKPiAKPiA+IEZyb206IFBoaWxpcCBZ
YW5nIDxQaGlsaXAuWWFuZ0BhbWQuY29tPgo+ID4gCj4gPiBXaGlsZSB0aGUgcGFnZSBpcyBtaWdy
YXRpbmcgYnkgTlVNQSBiYWxhbmNpbmcsIEhNTSBmYWlsZWQgdG8gZGV0ZWN0IHRoaXMKPiA+IGNv
bmRpdGlvbiBhbmQgc3RpbGwgcmV0dXJuIHRoZSBvbGQgcGFnZS4gQXBwbGljYXRpb24gd2lsbCB1
c2UgdGhlIG5ldwo+ID4gcGFnZSBtaWdyYXRlZCwgYnV0IGRyaXZlciBwYXNzIHRoZSBvbGQgcGFn
ZSBwaHlzaWNhbCBhZGRyZXNzIHRvIEdQVSwKPiA+IHRoaXMgY3Jhc2ggdGhlIGFwcGxpY2F0aW9u
IGxhdGVyLgo+ID4gCj4gPiBVc2UgcHRlX3Byb3Rub25lKHB0ZSkgdG8gcmV0dXJuIHRoaXMgY29u
ZGl0aW9uIGFuZCB0aGVuIGhtbV92bWFfZG9fZmF1bHQKPiA+IHdpbGwgYWxsb2NhdGUgbmV3IHBh
Z2UuCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcCBZYW5nIDxQaGlsaXAuWWFuZ0BhbWQu
Y29tPgo+IAo+IFRoaXMgc2hvdWxkIGhhdmUgaW5jbHVkZWQgeW91ciBzaWduZWQtb2ZmLWJ5Oiwg
c2luY2UgeW91IHdlcmUgb24gdGhlCj4gcGF0Y2ggZGVsaXZlcnkgcGF0aC4gIEknbGwgbWFrZSB0
aGF0IGNoYW5nZSB0byBteSBjb3B5IG9mIHRoZSBwYXRjaCwKPiBPSz8KClllcyBpdCBzaG91bGQg
aGF2ZSBpbmNsdWRlZCB0aGF0LgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
Zng=

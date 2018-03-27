From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [Linaro-mm-sig] [PATCH 1/5] dma-buf: add optional
 invalidate_mappings callback v2
Date: Tue, 27 Mar 2018 10:06:04 +0200
Message-ID: <71f3f0cc-263d-bf60-aff8-6f2277884aaf@gmail.com>
References: <19ed21a5-805d-271f-9120-49e0c00f510f@amd.com>
 <20180320140810.GU14155@phenom.ffwll.local>
 <37ba7394-2a5c-a0bc-cc51-c8a0edc2991d@gmail.com>
 <20180321082839.GA14155@phenom.ffwll.local>
 <327c4bc1-5813-16e8-62fc-4301b19a1a22@gmail.com>
 <20180322071804.GH14155@phenom.ffwll.local>
 <ef9fa9a2-c368-1fca-a8ac-8ee8d522b6ab@gmail.com>
 <20180326080121.GO14155@phenom.ffwll.local>
 <20180326154224.GA11930@gmail.com>
 <f8ff3993-6605-4f8e-5ac2-c40f0450c1c6@gmail.com>
 <20180327075334.GK14155@phenom.ffwll.local>
Reply-To: christian.koenig@amd.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180327075334.GK14155@phenom.ffwll.local>
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
To: Daniel Vetter <daniel@ffwll.ch>, christian.koenig@amd.com
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

QW0gMjcuMDMuMjAxOCB1bSAwOTo1MyBzY2hyaWViIERhbmllbCBWZXR0ZXI6Cj4gW1NOSVBdCj4+
PiBbU05JUF0KPj4+IEEgc2xpZ2h0bHkgYmV0dGVyIHNvbHV0aW9uIGlzIHVzaW5nIGF0b21pYyBj
b3VudGVyOgo+Pj4gICAgIGRyaXZlcl9yYW5nZV9zdGFydCgpIHsKPj4+ICAgICAgIGF0b21pY19p
bmMoJm15ZGV2LT5ub3RpZmllcl9jb3VudCk7Cj4+IC4uLgo+Pgo+PiBZZWFoLCB0aGF0IGlzIGV4
YWN0bHkgd2hhdCBhbWRncHUgaXMgZG9pbmcgbm93LiBTb3JyeSBpZiBteSBkZXNjcmlwdGlvbgo+
PiBkaWRuJ3QgbWFkZSB0aGF0IGNsZWFyLgo+Pgo+Pj4gSSB3b3VsZCBsaWtlIHRvIHNlZSBkcml2
ZXIgdXNpbmcgc2FtZSBjb2RlLCBhcyBpdCBtZWFucyBvbmUgcGxhY2UgdG8gZml4Cj4+PiBpc3N1
ZXMuIEkgaGFkIGZvciBhIGxvbmcgdGltZSBvbiBteSBUT0RPIGxpc3QgZG9pbmcgdGhlIGFib3Zl
IGNvbnZlcnNpb24KPj4+IHRvIGFtZCBvciByYWRlb24ga2VybmVsIGRyaXZlci4gSSBhbSBwdXNo
aW5nIHVwIG15IHRvZG8gbGlzdCBob3BlZnVsbHkgaW4KPj4+IG5leHQgZmV3IHdlZWtzIGkgY2Fu
IHNlbmQgYW4gcmZjIHNvIHBlb3BsZSBjYW4gaGF2ZSBhIHJlYWwgc2Vuc2Ugb2YgaG93Cj4+PiBp
dCBjYW4gbG9vay4KPj4gQ2VydGFpbmx5IGEgZ29vZCBpZGVhLCBidXQgSSB0aGluayB3ZSBtaWdo
dCBoYXZlIHRoYXQgc2VwYXJhdGUgdG8gSE1NLgo+Pgo+PiBUVE0gc3VmZmVyZWQgcmVhbGx5IGZy
b20gZmVhdHVyZSBvdmVybG9hZCwgZS5nLiB0cnlpbmcgdG8gZG8gZXZlcnl0aGluZyBpbiBhCj4+
IHNpbmdsZSBzdWJzeXN0ZW0uIEFuZCBpdCB3b3VsZCBiZSByYXRoZXIgbmljZSB0byBoYXZlIGNv
aGVyZW50IHVzZXJwdHIKPj4gaGFuZGxpbmcgZm9yIEdQVXMgYXMgc2VwYXJhdGUgZmVhdHVyZS4K
PiBUVE0gc3VmZmVyZWQgZnJvbSBiZWluZyBhIG1pZGxheWVyIGltbywgbm90IGZyb20gZG9pbmcg
dG9vIG11Y2guCgpZZWFoLCBjb21wbGV0ZWx5IGFncmVlLgoKbWlkbGF5ZXJzIHdvcmsgYXMgbG9u
ZyBhcyB5b3UgY29uY2VudHJhdGUgb24gZG9pbmcgZXhhY3RseSBvbmUgdGhpbmdzIGluIAp5b3Vy
IG1pZGxheWVyLiBFLmcuIGluIHRoZSBjYXNlIG9mIFRUTSB0aGUgY2FsbGJhY2sgZm9yIEJPIG1v
dmUgaGFuZGxpbmcgCmlzIHdlbGwganVzdGlmaWVkLgoKT25seSBhbGwgdGhlIHN0dWZmIGFyb3Vu
ZCBpdCBsaWtlIGFkZHJlc3Mgc3BhY2UgaGFuZGxpbmcgZXRjLi4uIGlzIApyZWFsbHkgd3Jvbmcg
ZGVzaWduZWQgYW5kIHNob3VsZCBiZSBzZXBhcmF0ZWQgKHdoaWNoIGlzIGV4YWN0bHkgd2hhdCBE
Uk0gCk1NIGRpZCwgYnV0IFRUTSBzdGlsbCB1c2VzIHRoaXMgaW4gdGhlIHdyb25nIHdheSkuCgo+
IEhNTSBpcyBhcHBhcmVudGx5IHN0cnVjdHVyZWQgbGlrZSBhIHRvb2xib3ggKGRlc3BpdGUgaXRz
IGRvY3VtZW50YXRpb24gY2xhaW1pbmcKPiBvdGhlcndpc2UpLCBzbyB5b3UgY2FuIHBpY2smY2hv
b3NlIGZyZWVseS4KClRoYXQgc291bmRzIGdvb2QsIGJ1dCBJIHdvdWxkIHN0aWxsIGhhdmUgYSBi
ZXR0ZXIgZmVlbGluZyBpZiB1c2VycHRyIApoYW5kbGluZyB3b3VsZCBiZSBzZXBhcmF0ZWQuIFRo
YXQgYXZvaWRzIG1hbmdsaW5nIHRoaW5ncyB0b2dldGhlciBhZ2Fpbi4KCkNocmlzdGlhbi4KCj4g
LURhbmllbAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
ZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

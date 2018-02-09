From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: replace iova debugfs file with iomem (v2)
Date: Fri, 9 Feb 2018 19:44:49 +0100
Message-ID: <50cdbb8f-3b64-bed3-322c-bcce05b39370@gmail.com>
References: <20180209172750.15675-1-tom.stdenis@amd.com>
 <4708aad9-9ff0-d09f-9bb6-453c01c848a4@amd.com>
 <50edcafc-23dd-3c44-021f-cf5989d06dc2@gmail.com>
 <761fbdc6-bf8d-b8f4-350f-515418921b30@amd.com>
Reply-To: christian.koenig@amd.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <761fbdc6-bf8d-b8f4-350f-515418921b30@amd.com>
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
To: Tom St Denis <tom.stdenis@amd.com>, christian.koenig@amd.com, amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

QW0gMDkuMDIuMjAxOCB1bSAxOToxOSBzY2hyaWViIFRvbSBTdCBEZW5pczoKPiBPbiAwOS8wMi8x
OCAwMToxNyBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gQW0gMDkuMDIuMjAxOCB1bSAx
ODoyOCBzY2hyaWViIFRvbSBTdCBEZW5pczoKPj4+IE9uIDA5LzAyLzE4IDEyOjI3IFBNLCBUb20g
U3QgRGVuaXMgd3JvdGU6Cj4+Pj4gRnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWlj
aHR6dW1lcmtlbkBnbWFpbC5jb20+Cj4+Pgo+Pj4gT29wcywgSSdsbCByZW1vdmUgdGhpcyBmcm9t
IHRoZSBjb21taXQgbWVzc2FnZSBiZWZvcmUgcHVzaGluZyA6LSkKPj4+Cj4+PiBJIGRpZCBnaXZl
IHlvdSBjcmVkaXQgYmVsb3cgdGhvdWdoLgo+Pgo+PiBUaGUgcGF0Y2ggYmVmb3JlIHRoaXMgb25l
IGlzbid0IG1lcmdlZCB5ZXQgYmVjYXVzZSBJJ20gc3RpbGwgbm90IHN1cmUgCj4+IGlmIHRoYXQg
d29ya3MgdW5kZXIgYWxsIGNpcmN1bXN0YW5jZXMgb3Igbm90Lgo+Pgo+PiBDb3VsZCB5b3UgZ2l2
ZSBpdCBzb21lIGV4dGVuZGVkIHRlc3Rpbmc/IEVzcGVjaWFsbHkgaWYgaXQgd29yayB3aXRoIAo+
PiBldmljdGlvbi4KPgo+IEkgc3VwcG9zZWQgdGhlcmUgaXMgYSByYWNlIG9uIHRoZSBrbWFwJ2Vk
IG1lbW9yeSB3aGljaCBpcyB3aHkgSSBhZGRlZCAKPiBhIHB0ciBjaGVjay7CoCBOb3QgcGVyZmVj
dCBidXQgc2luY2UgaXQncyBhIGRlYnVnZnMgZW50cnkgcHJvYmFibHkgCj4gYmV0dGVyIHRoYW4g
aXQgbmVlZHMgdG8gYmUuCgpJIHRoaW5rIHlvdSBjYW4gZHJvcCB0aGF0LCBrbWFwIGNhbiBvbmx5
IHJldHVybiBOVUxMIG9uIDMyYml0IHN5c3RlbXMgCndoZW4gd2UgcmFuIG91dCBvZiB2bWFwIGFy
ZWEgYW5kIHRoZW4geW91IGNhbiBiYXNpY2FsbHkgY2FsbCBwYW5pYygpIGFzIAp3ZWxsLgoKVGhl
IHF1ZXN0aW9uIGlzIGlmIHNldHRpbmcgcGFnZS0+bWFwcGluZyBkdXJpbmcgYWxsb2NhdGlvbiBo
YXMgc29tZSAKdW5kZXNpcmVkIHNpZGUgZWZmZWN0LgoKQ2hyaXN0aWFuLgoKPgo+IEknbGwgZ2l2
ZSBpdCBhIHRyeSBvbiBzb21lIGxpdmUgdHJhZmZpYyBuZXh0Lgo+Cj4gQ2hlZXJzLAo+IFRvbQo+
IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdm
eCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcg
bGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

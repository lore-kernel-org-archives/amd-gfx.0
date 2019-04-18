From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm: increase drm mmap_range size to 1TB
Date: Thu, 18 Apr 2019 10:30:15 +0200
Message-ID: <e4f5ded1-cbad-6bc5-d6e1-45ca18023f33@gmail.com>
References: <20190417221507.933-1-Philip.Yang@amd.com>
 <c8d289ef-75dc-163e-bea5-cd0d429d8614@amd.com>
 <ce68d6f5-317b-ae11-187c-4468dd6f2bc3@suse.de>
 <155557275854.4314.17223080641448067981@skylake-alporthouse-com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <155557275854.4314.17223080641448067981@skylake-alporthouse-com>
Content-Language: en-US
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
To: Chris Wilson <chris-Y6uKTt2uX1cEflXRtASbqLVCufUGDwFn@public.gmane.org>, "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "Yang, Philip" <Philip.Yang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>

QW0gMTguMDQuMTkgdW0gMDk6MzIgc2NocmllYiBDaHJpcyBXaWxzb246Cj4gUXVvdGluZyBUaG9t
YXMgWmltbWVybWFubiAoMjAxOS0wNC0xOCAwODoyOTozOSkKPj4gSGkKPj4KPj4gQW0gMTguMDQu
MTkgdW0gMDA6MTYgc2NocmllYiBLdWVobGluZywgRmVsaXg6Cj4+PiBBZGRpbmcgZHJpLWRldmVs
Cj4+Pgo+Pj4gT24gMjAxOS0wNC0xNyA2OjE1IHAubS4sIFlhbmcsIFBoaWxpcCB3cm90ZToKPj4+
PiBBZnRlciBwYXRjaCAiZHJtOiBVc2UgdGhlIHNhbWUgbW1hcC1yYW5nZSBvZmZzZXQgYW5kIHNp
emUgZm9yIEdFTSBhbmQKPj4+PiBUVE0iLCBhcHBsaWNhdGlvbiBmYWlsZWQgdG8gY3JlYXRlIGJv
IG9mIHN5c3RlbSBtZW1vcnkgYmVjYXVzZSBkcm0KPj4+PiBtbWFwX3JhbmdlIHNpemUgZGVjcmVh
c2UgdG8gNjRHQiBmcm9tIG9yaWdpbmFsIDFUQi4gVGhpcyBpcyBub3QgYmlnCj4+Pj4gZW5vdWdo
IGZvciBhcHBsaWNhdGlvbnMuIEluY3JlYXNlIHRoZSBkcm0gbW1hcF9yYW5nZSBzaXplIHRvIDFU
Qi4KPj4gVGhhdCBjaGFuZ2UgaW4gc2l6ZSB3YXMgYWNjaWRlbnRhbC4gVGhhbmtzIGZvciByZXN0
b3JpbmcgdGhlIG9yaWdpbmFsCj4+IHZhbHVlLiBUaGUgZml4IHdpbGwgYWZmZWN0IEdFTSBhcyB3
ZWxsLiBJZiB0aGF0IGlzIG5vdCBhIHByb2JsZW0gdGhlbgo+Pgo+IFdoeSBldmVuIGhhdmUgYW4g
YXJ0aWZpY2lhbCByZXN0cmljdGlvbj8KCldlbGwgb25lIHBvc3NpYmxlIGV4cGxhbmF0aW9uIGlz
IHRoYXQgd2Ugc29tZXdoZXJlIG5lZWQgdG8gYWxsb2NhdGUgCm1lbW9yeSB0byBoYW5kbGUgYWxs
IHRoYXQgYWRkcmVzcyBzcGFjZS4gRS5nLiB3aGVuIGl0IGlzIG1hbmFnZWQgd2l0aCBhIApyYWRp
eCBvciBzaW1pbGFyLgoKQnV0IGFzIGZhciBhcyBJIHJlbWVtYmVyIHRoZXJlIGFyZSBvbmx5IGxp
c3RzIGFuZCByL2IgdHJlZXMgaW52b2x2ZWQgCmhlcmUsIHNvIHllYWggZG9lc24ndCBtYWtlIHRv
IG11Y2ggc2Vuc2UuCgpBbnl3YXkgdGhhdCBpcyBub3QgdGhlIHRvcGljIG9mIHRoaXMgcGF0Y2gg
YW5kIGl0IGlzIFJldmlld2VkLWJ5OiAKQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5p
Z0BhbWQuY29tPiBmb3Igbm93LgoKUmVnYXJkcywKQ2hyaXN0aWFuLgoKPiAtQ2hyaXMKPiBfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGRyaS1kZXZlbCBt
YWlsaW5nIGxpc3QKPiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==

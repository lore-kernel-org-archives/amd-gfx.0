From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] dma-buf: return index of the first signaled fence (v2)
Date: Mon, 7 Nov 2016 12:44:42 -0500
Message-ID: <CADnq5_Nv+wgCorQ88wQ1Kc-f+nJPFzLoBMBV591zFiw-NMy3Sg@mail.gmail.com>
References: <1478290570-30982-1-git-send-email-alexander.deucher@amd.com>
 <CAO_48GGiBXFFqxWg1fUKMVUR13QvwaH5a8eiGrOgeCbUyY0WnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAO_48GGiBXFFqxWg1fUKMVUR13QvwaH5a8eiGrOgeCbUyY0WnA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Sumit Semwal <sumit.semwal-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "monk.liu" <monk.liu-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, DRI mailing list <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gRnJpLCBOb3YgNCwgMjAxNiBhdCA2OjAzIFBNLCBTdW1pdCBTZW13YWwgPHN1bWl0LnNlbXdh
bEBsaW5hcm8ub3JnPiB3cm90ZToKPiBIaSBBbGV4LAo+Cj4gVGhhbmtzIGZvciB0aGUgcGF0Y2hl
cy4KPgo+IE9uIDQgTm92ZW1iZXIgMjAxNiBhdCAxNDoxNiwgQWxleCBEZXVjaGVyIDxhbGV4ZGV1
Y2hlckBnbWFpbC5jb20+IHdyb3RlOgo+PiBGcm9tOiAibW9uay5saXUiIDxtb25rLmxpdUBhbWQu
Y29tPgo+Pgo+PiBSZXR1cm4gdGhlIGluZGV4IG9mIHRoZSBmaXJzdCBzaWduYWxlZCBmZW5jZS4g
IFRoaXMgaW5mb3JtYXRpb24KPj4gaXMgdXNlZnVsIGluIHNvbWUgQVBJcyBsaWtlIFZ1bGthbi4K
Pj4KPj4gdjI6IHJlYmFzZSBvbiBkcm0tbmV4dCAoZmVuY2UgLT4gZG1hX2ZlbmNlKQo+Pgo+PiBT
aWduZWQtb2ZmLWJ5OiBtb25rLmxpdSA8bW9uay5saXVAYW1kLmNvbT4KPj4gU2lnbmVkLW9mZi1i
eTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+PiBDYzogU3VtaXQg
U2Vtd2FsIDxzdW1pdC5zZW13YWxAbGluYXJvLm9yZz4KPj4gLS0tCj4+Cj4+IFRoaXMgaXMgdGhl
IHNhbWUgcGF0Y2ggc2V0IEkgc2VuZCBvdXQgeWVzdGVyZGF5LCBJIGp1c3QKPj4gc3F1YXNoZWQg
dGhlIGFtZGdwdSBwYXRjaGVzIHRvZ2V0aGVyIGFuZCByZWJhc2VkIGV2ZXJ5dGhpbmcgb24KPj4g
dGhlIGZlbmNlIC0+IGRtYV9mZW5jZSByZW5hbWluZy4gIFRoaXMgaXMgdXNlZCBieSBvdXIgVksg
ZHJpdmVyCj4+IGFuZCB3ZSBhcmUgcGxhbm5pbmcgdG8gdXNlIGl0IGluIG1lc2EgYXMgd2VsbC4K
Pj4KPgo+IFdvdWxkIHlvdSBiZSBvayBpZiBJIGFwcGx5IHRoaXMgYW5kIHRoZSBhbWRncHUgcGF0
Y2ggYm90aCB0b2dldGhlciB2aWEKPiBkcm0tbWlzYywgb3Igd291bGQgeW91IGxpa2UgbWUgdG8g
bm90aWZ5IHlvdSBvbmNlIEkgbWVyZ2UgdGhpcyBmb3IgeW91Cj4gdG8gdGFrZSB0aGUgYW1kZ3B1
IHBhdGNoIHZpYSB5b3VyIHRyZWU/IEknbSBmaW5lIGVpdGhlciB3YXlzLCBidXQKPiBwZXJoYXBz
IGRybS1taXNjIHdvdWxkIGJlIGEgYml0IG5lYXRlci4KPgoKRWl0aGVyIHdheSB3b3JrcyBmb3Ig
bWUuICBXaGF0ZXZlciBpcyBlYXNpZXIgZm9yIHlvdS4KCkFsZXgKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

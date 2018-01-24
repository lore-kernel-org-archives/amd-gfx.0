From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: use ttm pool first
Date: Wed, 24 Jan 2018 10:49:48 +0100
Message-ID: <ce0c7a1f-3c94-c450-a6ab-7b5a65ca1c09@daenzer.net>
References: <20180124091707.32059-1-david1.zhou@amd.com>
 <36db7c3c-aa12-d11f-ef5d-63fc40c395ba@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <36db7c3c-aa12-d11f-ef5d-63fc40c395ba-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-CA
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Cc: alexander.deucher-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxOC0wMS0yNCAxMDo0MyBBTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAyNC4w
MS4yMDE4IHVtIDEwOjE3IHNjaHJpZWIgQ2h1bm1pbmcgWmhvdToKPj4gZG1hIHBhdGggaXMgbG93
IHRoYW4gdHRtIHBvb2wuCj4gCj4gVGhhdCB3b24ndCB3b3JrIGNvcnJlY3RseSBpbiBzb21lIGNh
c2VzLgo+IAo+PiBRdWVzdGlvbjoKPj4gQnV0IHdoeSBuZWVkIHR3byBwYXRoPyBXaGF0IHNwaWNp
ZmljIHByb2JsZW0gY2FuIGJlIHNvbHZlZCBieSBkbWEgcGF0aD8KPiAKPiBUaGF0IGlzIG1vc3Rs
eSBmb3IgQVJNIGFuZCBzb21lIChyYXJlKSB4ODYgcGxhdGZvcm1zIHdpdGhvdXQgSU9NTVUgd2hl
cmUKPiBzb21lIG1lbW9yeSBpcyBhYm92ZSB0aGUgNDBiaXQgbGltaXQgaW4gdGhlIFBDSWUgYWRk
cmVzcyBzcGFjZS4KPiAKPiBPdXIgR1BVcyBjYW4gdW5mb3J0dW5hdGVseSBvbmx5IGRlYWwgd2l0
aCA0MGJpdHMgb2YgYWRkcmVzcyBzcGFjZSwgc28gb24KPiB0aG9zZSBzeXN0ZW1zIHdlIG5lZWQg
dG8gZ28gdGhlIHNsb3cgcGF0aCBhbmQgbWFrZSBzdXJlIHRoYXQgd2UgZG9uJ3QKPiB0cnkgdG8g
dG91Y2ggdGhhdCBoaWdoIG1lbW9yeS4KPiAKPiBXaGF0IHdlIGNvdWxkIHJlYWxseSBpbXByb3Zl
IGlzIHRoZSBkZXRlY3Rpb24gdXNpbmcgc3dpb3RsYl9ucl90YmwoKSwKPiBjYXVzZSB0aGF0IGlz
IGFjdHVhbGx5IGNvbXBsZXRlbHkgd3JvbmcuCgpGV0lXLCB0aGVyZSBhcmUgb3RoZXIgY2FzZXMg
d2hlcmUgU1dJT1RMQiBpcyBuZWVkZWQsIGUuZy4gU2VjdXJlIE1lbW9yeQpFbmNyeXB0aW9uOiBo
dHRwczovL2J1Z3MuZnJlZWRlc2t0b3Aub3JnL3Nob3dfYnVnLmNnaT9pZD0xMDQ0MzcKCgotLSAK
RWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0
dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwg
ICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==

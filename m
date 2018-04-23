From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix the ib test hang when gfx is in "idle"
 state
Date: Mon, 23 Apr 2018 18:02:06 +0800
Message-ID: <20180423100205.GB23608@hr-amur2>
References: <1524217255-25968-1-git-send-email-ray.huang@amd.com>
 <aaaffd0c-96be-29b2-9bd4-df6fa6ea7e8a@amd.com>
 <20180423095228.GA23608@hr-amur2>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180423095228.GA23608@hr-amur2>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "S,
 Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>

T24gTW9uLCBBcHIgMjMsIDIwMTggYXQgMDU6NTI6MjhQTSArMDgwMCwgSHVhbmcgUnVpIHdyb3Rl
Ogo+IE9uIEZyaSwgQXByIDIwLCAyMDE4IGF0IDA1OjU5OjE2UE0gKzA4MDAsIEtvZW5pZywgQ2hy
aXN0aWFuIHdyb3RlOgo+ID4gQW0gMjAuMDQuMjAxOCB1bSAxMTo0MCBzY2hyaWViIEh1YW5nIFJ1
aToKPiA+ID4gImFhYWJhZjQgICBkcm0vYW1kZ3B1OiBkZWZlciB0ZXN0IElCcyBvbiB0aGUgcmlu
Z3MgYXQgYm9vdCAoVjMpIgo+ID4gPiBBYm92ZSBwYXRjaCBkZWZlcnMgdGhlIGV4ZWN1dGlvbiBv
ZiBnZngvY29tcHV0ZSBpYiB0ZXN0cy4gSG93ZXZlciwgYXQgdGhhdCB0aW1lLAo+ID4gPiB0aGUg
Z2Z4IG1heSBhbHJlYWR5IGdvIGludG8gaWRsZSBzdGF0ZS4gSWYgImlkbGUiIGdmeCByZWNlaXZl
cyBjb21tYW5kCj4gPiA+IHN1Ym1pc3Npb24sIGl0IHdpbGwgZ2V0IGhhbmcgaW4gdGhlIHN5c3Rl
bS4gU28gd2UgbXVzdCBhZGQgaXNfZ2Z4X29uIGNoZWNraW5nIGF0Cj4gPiA+IHN0YXJ0IG9mIGli
IHRlc3RzLgo+ID4gCj4gPiBEbyBJIHNlZSB0aGF0IHJpZ2h0IHRoYXQgeW91IGp1c3Qgc2tpcCB0
aGUgSUIgdGVzdCB3aGVuIHRoZSBHRlggYmxvY2sgaXMgCj4gPiBhbHJlYWR5IHR1cm5lZCBvZj8g
SW4gdGhpcyBjYXNlIHRoYXQgd291bGQgYmUgYSBjbGVhciBOQUsuCj4gPiAKPiA+IEJUVzogSG93
IGRvIHlvdSBkZXRlY3QgdGhhdCB3ZSBuZWVkIHRvIHR1cm4gR0ZYIG9uIGFnYWluPwo+IAo+IENo
cmlzdGlhbiwgSSBrbm93IHBvaW50LiBCdXQgdGhlcmUgaXMgYSBoYW5nIGlzc3VlIGlmIHdlIHdv
dWxkIGxpa2UgdHJ5IHRvCj4gZGlzYWJsZS9lbmFibGUgZ2Z4b2ZmIHdpdGggU01DIG1lc3NhZ2Ug
YXQgcnVudGltZS4gQWN0dWFsbHksIEkgYW0gdHJ5aW5nIHRvCj4gZmluZCBhIGdvb2Qgc2VxdWVu
Y2UgdG8gZml4IGl0LiBBZnRlciB0aGF0LCBJIGNhbiBldmVuIGV4cG9zZSBhbiBkZWJ1Z2ZzCj4g
aW50ZXJmYWNlIHRvIGNvbmZpZ3VyZSB0aGF0LiBTbyBJIGhhdmUgdG8gc2tpcCB0aGUgdGVzdCBm
b3IgdGhlIG1vbWVudCB3aGVuCj4gZ2Z4IGlzIGluICJpZGxlIi4KPiAKCkFuZCBpbiBub3JtYWwg
Y2FzZSwgZHJpdmVyIHdvbid0IGV4cGxpY2l0bHkgdHVybiBvbi9vZmYgdGhlIGdmeC4gUkxDCmZp
cm13YXJlIHdpbGwgaGFuZGxlIGl0LgoKVGhhbmtzLApSYXkKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==

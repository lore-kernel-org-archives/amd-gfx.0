From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH libdrm] amdgpu: update amdgpu_drm.h
Date: Wed, 16 Jan 2019 18:24:02 +0100
Message-ID: <a31b0bcf-0ba7-f276-e1b4-de862aa35959@daenzer.net>
References: <20190115192527.11581-1-maraeo@gmail.com>
 <92ca5d38-50d3-f00a-3750-b00fd11b6851@gmail.com>
 <CAAxE2A4Xz3DC7C7YV+GRSqznrRGBk7TCvpVk7pS+z+w80++XLA@mail.gmail.com>
 <7b174535-ed89-9137-b204-dc21ca4ce896@amd.com>
 <CAAxE2A5-q2hc6QugbtLU4n564263S6bemvmY_+VvapXeYmRcLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A5-q2hc6QugbtLU4n564263S6bemvmY_+VvapXeYmRcLg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxOS0wMS0xNiA1OjU2IHAubS4sIE1hcmVrIE9sxaHDoWsgd3JvdGU6Cj4gT24gV2VkLCBK
YW4gMTYsIDIwMTkgYXQgMTE6MjUgQU0gS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2Vu
aWdAYW1kLmNvbT4KPiB3cm90ZToKPj4gQW0gMTYuMDEuMTkgdW0gMTc6MTUgc2NocmllYiBNYXJl
ayBPbMWhw6FrOgo+PiBPbiBXZWQsIEphbiAxNiwgMjAxOSBhdCAyOjM3IEFNIENocmlzdGlhbiBL
w7ZuaWcgPAo+PiBja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4gd3JvdGU6Cj4+Cj4+
PiBBbSAxNS4wMS4xOSB1bSAyMDoyNSBzY2hyaWViIE1hcmVrIE9sxaHDoWs6Cj4+Pj4gRnJvbTog
TWFyZWsgT2zFocOhayA8bWFyZWsub2xzYWtAYW1kLmNvbT4KPj4+Cj4+PiBNYXliZSBub3RlIGlu
IHRoZSBjb21taXQgbWVzc2FnZSBmcm9tIHdoaWNoIHVwc3RyZWFtIGtlcm5lbC4KPj4+Cj4+Cj4+
IE5vIHVwc3RyZWFtIGtlcm5lbC4gSXQncyBmcm9tIGFtZC1zdGFnaW5nLWRybS1uZXh0Lgo+Pgo+
Pgo+PiBUaGF0J3MgYSBwcm9ibGVtLCBzZWUgdGhlIHJ1bGVzIGZvciB1cGRhdGluZyB0aGlzLgo+
Pgo+PiBJSVJDIHRoZSBjb2RlIG11c3QgbGFuZCBpbiBhbiB1cHN0cmVhbSBrZXJuZWwgYmVmb3Jl
IGl0IGNhbiBiZSBjb21taXR0ZWQKPj4gdG8gbGliZHJtLgo+Pgo+PiBDaHJpc3RpYW4uCj4+Cj4g
Cj4gSXQgbG9va3MgbGlrZSBpdCdzIGFsbCBpbiB0aGUgbWFzdGVyIGJyYW5jaC4KClRoYXQncyBn
b29kLCBidXQgcGxlYXNlIGZvbGxvdyB0aGUgcHJvY2VkdXJlIGRvY3VtZW50ZWQgaW4KaW5jbHVk
ZS9kcm0vUkVBRE1FIG5leHQgdGltZS4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAg
ICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0
d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZl
bG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

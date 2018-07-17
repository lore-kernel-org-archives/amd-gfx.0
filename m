From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH libdrm] amdgpu: add amdgpu_bo_handle_type_kms_noimport
Date: Tue, 17 Jul 2018 09:46:32 +0200
Message-ID: <0f28de35-1928-2af3-8b8d-13c61b25e285@daenzer.net>
References: <20180712004750.2024-1-maraeo@gmail.com>
 <9a8d8f7f-a468-fd5b-dec5-472ce9c88483@daenzer.net>
 <CAAxE2A6Vz08sWXiaB6B-F4_P7Fy6uDuJ7aF2gHLXZ4N3zj9sXw@mail.gmail.com>
 <a291b3b5-25bc-385a-5242-9bd75ec423e9@daenzer.net>
 <CAAxE2A7ffmO=Tv_DSWhPciF+y5q_wbaBYgcqHvxQVkeVfhBhdg@mail.gmail.com>
 <31980a46-1d16-8ead-cc2b-5a5b9eb4d530@daenzer.net>
 <5374dffa-45c9-1bd6-79b9-cc4450a96aeb@gmail.com>
 <126a68a9-43f4-c747-89d1-114dc29ea4e9@daenzer.net>
 <3cc456c1-929d-4aee-2e8b-7d4edb023382@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <3cc456c1-929d-4aee-2e8b-7d4edb023382-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxOC0wNy0xNyAwOTozMyBBTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAxNy4w
Ny4yMDE4IHVtIDA5OjI2IHNjaHJpZWIgTWljaGVsIETDpG56ZXI6Cj4+IE9uIDIwMTgtMDctMTcg
MDg6NTAgQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+PiBBbSAxNi4wNy4yMDE4IHVtIDE4
OjA1IHNjaHJpZWIgTWljaGVsIETDpG56ZXI6Cj4+Pj4gT24gMjAxOC0wNy0xMyAwODo0NyBQTSwg
TWFyZWsgT2zFocOhayB3cm90ZToKPj4+PiBbU05JUF0KPj4+PiBPdGhlciBvcGluaW9ucz8KPj4+
IEkgdW5kZXJzdGFuZCB0aGUgcmVhc29uIHdoeSBNYXJlayB3YW50cyB0byBkbyB0aGlzLCBidXQg
SSBhZ3JlZSB0aGF0Cj4+PiB0aGlzIGlzIGEgbGl0dGxlIGJpdCBkYW5nZXJvdXMgaWYgdXNlZCBp
bmNvcnJlY3RseS4KPj4+Cj4+PiBPbiB0aGUgb3RoZXIgaGFuZCBJIGRvbid0IHNlZSBhbnkgb3Ro
ZXIgd2F5IHRvIHNhbmVseSBoYW5kbGUgaXQgZWl0aGVyLgo+PiBTYW5lbHkgaGFuZGxlIHdoYXQg
ZXhhY3RseT8gOikgSSBzdGlsbCBoYXZlbid0IHNlZW4gYW55IGRlc2NyaXB0aW9uIG9mCj4+IGFu
IGFjdHVhbCBwcm9ibGVtLCBvdGhlciB0aGFuICJ0aGUgaGFuZGxlIGlzIHN0b3JlZCBpbiB0aGUg
aGFzaCB0YWJsZSIuCj4gCj4gV2VsbCB0aGUgcHJvYmxlbSBpcyB0aGF0IGl0J3Mgbm90ICJ0aGUg
aGFuZGxlIiBidXQgcmF0aGVyICJhbGwgaGFuZGxlcyIKPiB3aGljaCBhcmUgbm93IHN0b3JlZCBp
biB0aGUgaGFzaCB0YWJsZS4KPiAKPiBUbyBiZWdpbiB3aXRoIHRoYXQgaXMgcXVpdGUgYSBidW5j
aCBvZiB3YXN0ZWQgbWVtb3J5LCBub3QgdGFsa2luZyBhYm91dAo+IHRoZSBleHRyYSBDUFUgY3lj
bGVzLgoKQWxsIHRoYXQgc2hvdWxkIGJlIG5lZWRlZCBpcyBvbmUgc3RydWN0IGxpc3RfaGVhZCBw
ZXIgQk8sIDE2IGJ5dGVzIG9uCjY0LWJpdC4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVy
ICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBz
b2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBk
ZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

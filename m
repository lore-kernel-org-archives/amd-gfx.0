From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH libdrm] libdrm_amdgpu: add kernel semaphore support
Date: Mon, 4 Sep 2017 21:23:51 +0200
Message-ID: <CAAxE2A7njM=Xjeibh0O=eciz0gNhdOUM60brqhrGa5Fw+TufdA@mail.gmail.com>
References: <20170706011749.4217-1-airlied@gmail.com>
 <CAAxE2A6Fco40WfJy9kt5usntnv2GP92PjRiw9mcUfPrs+jr+Xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A6Fco40WfJy9kt5usntnv2GP92PjRiw9mcUfPrs+jr+Xw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gRnJpLCBTZXAgMSwgMjAxNyBhdCA1OjM2IFBNLCBNYXJlayBPbMWhw6FrIDxtYXJhZW9AZ21h
aWwuY29tPiB3cm90ZToKPiBPbiBUaHUsIEp1bCA2LCAyMDE3IGF0IDM6MTcgQU0sIERhdmUgQWly
bGllIDxhaXJsaWVkQGdtYWlsLmNvbT4gd3JvdGU6Cj4+IEZyb206IERhdmUgQWlybGllIDxhaXJs
aWVkQHJlZGhhdC5jb20+Cj4+Cj4+IFRoaXMgYWRkcyBrZXJuZWwgc2VtYXBob3JlIHN1cHBvcnQg
dG8gdGhlIGNvbW1hbmQgc3VibWlzc2lvbgo+PiBpbnRlcmZhY2UgaW4gd2hhdCBzaG91bGQgYmUg
YSBiYWNrd2FyZHMgY29tcGF0aWJsZSBtYW5uZXIsCj4+IGl0IGFkZHMgYSBuZXcgY29tbWFuZCBz
dWJtaXNzaW9uIEFQSS4KPj4KPj4gU2lnbmVkLW9mZi1ieTogRGF2ZSBBaXJsaWUgPGFpcmxpZWRA
cmVkaGF0LmNvbT4KPj4gLS0tCj4+ICBhbWRncHUvYW1kZ3B1LmggICAgfCAgMjkgKysrKysrKysr
KysrLQo+PiAgYW1kZ3B1L2FtZGdwdV9jcy5jIHwgMTE4ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKystLS0tCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDEzOCBp
bnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvYW1kZ3B1L2Ft
ZGdwdS5oIGIvYW1kZ3B1L2FtZGdwdS5oCj4+IGluZGV4IDE5MDFmYTguLjY0OWI2NmUgMTAwNjQ0
Cj4+IC0tLSBhL2FtZGdwdS9hbWRncHUuaAo+PiArKysgYi9hbWRncHUvYW1kZ3B1LmgKPj4gQEAg
LTM2OSw2ICszNjksMTYgQEAgc3RydWN0IGFtZGdwdV9jc19yZXF1ZXN0IHsKPj4gICAgICAgICBz
dHJ1Y3QgYW1kZ3B1X2NzX2ZlbmNlX2luZm8gZmVuY2VfaW5mbzsKPj4gIH07Cj4+Cj4+ICtzdHJ1
Y3QgYW1kZ3B1X2NzX3JlcXVlc3Rfc3luY29iaiB7Cj4+ICsgICAgICAgLyoKPj4gKyAgICAgICAg
Kgo+PiArICAgICAgICAqLwo+Cj4gRGlkIHlvdSBtZWFuIHRvIGZpbGwgaW4gdGhlIGNvbW1lbnQg
aGVyZT8KPgo+IEFsc28sIGlzIHRoaXMgaW50ZXJmYWNlIHJlbGV2YW50IHdpdGggdGhlIHJhdyBD
UyBBUEk/CgpBZGRpdGlvbmFsbHksIHdoZXJlIGNhbiBJIGZpbmQgdGhlIGtlcm5lbCBwYXRjaCBm
b3IgdGhpcz8KClRoYW5rcywKTWFyZWsKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==

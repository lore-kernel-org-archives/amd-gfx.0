From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH libdrm 1/2] amdgpu: prevent an integer wraparound of
 cpu_map_count
Date: Tue, 30 Oct 2018 16:59:04 +0100
Message-ID: <79fe6959-6f43-5c3b-8fa1-69d43498cdd4@daenzer.net>
References: <20181023190733.15251-1-maraeo@gmail.com>
 <7690cf4c-5eff-85e4-885c-2ecc9dc01c25@gmail.com>
 <CAAxE2A50X-XGvyx7GcZnnAC4p-bRnXrQpjQZ1D-8pD5ir3QdMQ@mail.gmail.com>
 <e8cf4264-f211-70b3-01ec-34d0eb5e7edb@daenzer.net>
 <CAAxE2A59+J7-jdYobFMMFDhS0oPLS8MgJXzV-Z=N7jhMr9rcdg@mail.gmail.com>
 <CAAxE2A7kA_W3xeK01F7jthfMyEij3TFy_G7=A5_vsduNVrKpbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A7kA_W3xeK01F7jthfMyEij3TFy_G7=A5_vsduNVrKpbQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxOC0xMC0zMCA0OjUyIHAubS4sIE1hcmVrIE9sxaHDoWsgd3JvdGU6Cj4gT24gVHVlLCBP
Y3QgMzAsIDIwMTgsIDExOjQ5IEFNIE1hcmVrIE9sxaHDoWsgPG1hcmFlb0BnbWFpbC5jb20+IHdy
b3RlOgo+PiBPbiBUdWUsIE9jdCAzMCwgMjAxOCwgNDoyMCBBTSBNaWNoZWwgRMOkbnplciA8bWlj
aGVsQGRhZW56ZXIubmV0PiB3cm90ZToKPj4KPj4+IE9uIDIwMTgtMTAtMjkgMTA6MTUgcC5tLiwg
TWFyZWsgT2zFocOhayB3cm90ZToKPj4+PiBZb3UgYW5kIEkgZGlzY3Vzc2VkIHRoaXMgZXh0ZW5z
aXZlbHkgaW50ZXJuYWxseSBhIHdoaWxlIGFnby4gSXQncwo+Pj4gZXhwZWN0ZWQKPj4+PiBhbmQg
Y29ycmVjdCBiZWhhdmlvci4gTWVzYSBkb2Vzbid0IHVubWFwIHNvbWUgYnVmZmVycyBhbmQgbmV2
ZXIgd2lsbC4KPj4+Cj4+PiBJdCBkb2Vzbid0IG5lZWQgdG8ga2VlcCBtYXBwaW5nIHRoZSBzYW1l
IGJ1ZmZlciBvdmVyIGFuZCBvdmVyIGFnYWluCj4+PiB0aG91Z2gsIGRvZXMgaXQ/Cj4+Pgo+Pgo+
PiBJdCBkb2VzbnQgbWFwIGl0IGFnYWluLiBJdCBqdXN0IGRvZXNudCB1bm1hcC4gU28gdGhlIG5l
eHQgbWFwIGNhbGwganVzdAo+PiByZXR1cm5zIHRoZSBwb2ludGVyLiBJdCdzIGNvcnJlY3QgdG8g
c3RvcCB0aGUgY291bnRlciB3cmFwYXJvdW5kLgo+Pgo+IAo+IE1lc2EgZG9lc24ndCB0cmFjayB3
aGV0aGVyIGEgYnVmZmVyIGlzIGFscmVhZHkgbWFwcGVkLiBMaWJkcm0gdHJhY2tzIHRoYXQuCj4g
SXQncyBhIGZlYXR1cmUgb2YgbGliZHJtIHRvIHJldHVybiB0aGUgc2FtZSBwb2ludGVyIGFuZCBl
eHBlY3QgaW5maW5pdGUKPiBudW1iZXIgb2YgbWFwIGNhbGxzLgoKVGhhdCdzIG5vdCB3aGF0IHRo
ZSByZWZlcmVuY2UgY291bnRpbmcgaW4gbGliZHJtIGlzIGludGVuZGVkIGZvci4gSXQncwpmb3Ig
a2VlcGluZyB0cmFjayBvZiBob3cgbWFueSBpbmRlcGVuZGVudCBjYWxsZXJzIGhhdmUgbWFwcGVk
IHRoZQpidWZmZXIuIE1lc2Egc2hvdWxkIHJlbWVtYmVyIHRoYXQgaXQgbWFwcGVkIGEgYnVmZmVy
IGFuZCBub3QgbWFwIGl0IGFnYWluLgoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAg
ICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3
YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVs
b3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK

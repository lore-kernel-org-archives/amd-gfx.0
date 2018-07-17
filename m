From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH libdrm] amdgpu: add amdgpu_bo_handle_type_kms_noimport
Date: Tue, 17 Jul 2018 10:30:33 +0200
Message-ID: <9a3c0fb3-c6a8-d59f-89cf-ec32ff6ed630@daenzer.net>
References: <20180712004750.2024-1-maraeo@gmail.com>
 <9a8d8f7f-a468-fd5b-dec5-472ce9c88483@daenzer.net>
 <CAAxE2A6Vz08sWXiaB6B-F4_P7Fy6uDuJ7aF2gHLXZ4N3zj9sXw@mail.gmail.com>
 <a291b3b5-25bc-385a-5242-9bd75ec423e9@daenzer.net>
 <CAAxE2A7ffmO=Tv_DSWhPciF+y5q_wbaBYgcqHvxQVkeVfhBhdg@mail.gmail.com>
 <31980a46-1d16-8ead-cc2b-5a5b9eb4d530@daenzer.net>
 <5374dffa-45c9-1bd6-79b9-cc4450a96aeb@gmail.com>
 <126a68a9-43f4-c747-89d1-114dc29ea4e9@daenzer.net>
 <3cc456c1-929d-4aee-2e8b-7d4edb023382@amd.com>
 <0f28de35-1928-2af3-8b8d-13c61b25e285@daenzer.net>
 <45bab640-d574-b822-e5c8-69fe67626a9a@amd.com>
 <988daf71-51ef-65e7-48ed-9dc2f3acb3a1@daenzer.net>
 <a5be38fa-4da6-642f-b297-21261820a908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <a5be38fa-4da6-642f-b297-21261820a908-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: christian.koenig-5C7GfCeVMHo@public.gmane.org, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxOC0wNy0xNyAxMDoxOSBBTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAxNy4w
Ny4yMDE4IHVtIDEwOjAzIHNjaHJpZWIgTWljaGVsIETDpG56ZXI6Cj4+IE9uIDIwMTgtMDctMTcg
MDk6NTkgQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+PiBBbSAxNy4wNy4yMDE4IHVtIDA5
OjQ2IHNjaHJpZWIgTWljaGVsIETDpG56ZXI6Cj4+Pj4gT24gMjAxOC0wNy0xNyAwOTozMyBBTSwg
Q2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+Pj4gQW0gMTcuMDcuMjAxOCB1bSAwOToyNiBzY2hy
aWViIE1pY2hlbCBEw6RuemVyOgo+Pj4+PiBbU05JUF0KPj4+PiBBbGwgdGhhdCBzaG91bGQgYmUg
bmVlZGVkIGlzIG9uZSBzdHJ1Y3QgbGlzdF9oZWFkIHBlciBCTywgMTYgYnl0ZXMgb24KPj4+PiA2
NC1iaXQuCj4+PiArbWFsbG9jIG92ZXJoZWFkIGFuZCB0aGF0IGZvciAqZXZlcnkqIEJPIHRoZSBh
cHBsaWNhdGlvbi9kcml2ZXIKPj4+IGFsbG9jYXRlZC4KPj4gVGhlIHN0cnVjdCBsaXN0X2hlYWQg
Y2FuIGJlIHN0b3JlZCBpbiBzdHJ1Y3QgYW1kZ3B1X2JvLCBubyBhZGRpdGlvbmFsCj4+IG1hbGxv
YyBuZWNlc3NhcnkuCj4gCj4gV2VsbCB0aGF0IHNvdW5kcyB3ZSBhcmUgbm90IHRhbGtpbmcgYWJv
dXQgdGhlIHNhbWUgY29kZSwgZG8gd2U/Cj4gCj4gSUlSQyB0aGUgaGFzaHRhYmxlIGltcGxlbWVu
dGF0aW9uIGluIGxpYmRybSBpcyB1c2luZyBhbiBldmVyIGdyb3dpbmcKPiBhcnJheSBmb3IgdGhl
IEJPcyBhbmQgKk5PVCogYSBsaW5rZWQgbGlzdC4KClNvIGxldCdzIHVzZSBzb21ldGhpbmcgbW9y
ZSBzdWl0YWJsZSwgZS5nLjoKCkFuIGFycmF5IG9mIDJebiBzdHJ1Y3QgbGlzdF9oZWFkIGluIHN0
cnVjdCBhbWRncHVfZGV2aWNlIGZvciB0aGUgaGFzaApidWNrZXRzLiBUaGUgQk8ncyBoYW5kbGUg
aXMgaGFzaGVkIHRvIHRoZSBidWNrZXQgbnVtYmVyCgogaGFuZGxlICYgKDJebiAtIDEpCgphbmQg
bGlua2VkIGluIHRoZXJlIHZpYSBzdHJ1Y3QgbGlzdF9oZWFkIGluIHN0cnVjdCBhbWRncHVfYm8u
CmFtZGdwdV9ib19hbGxvYyBhbmQgYW1kZ3B1X2NyZWF0ZV9ib19mcm9tX3VzZXJfbWVtIGFkZCB0
aGUgaGFuZGxlIGF0IHRoZQplbmQgb2YgdGhlIGxpc3QsIGFtZGdwdV9ib19pbXBvcnQgYWRkcyBp
dCBhdCBvciBtb3ZlcyBpdCB0byB0aGUgYmVnaW5uaW5nLgoKCi0tIApFYXJ0aGxpbmcgTWljaGVs
IETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29t
CkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNh
IGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK

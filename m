From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: System with kernel 4.21 hang immediately after start (invalid
 opcode: 0000 [#1] SMP NOPTI)
Date: Fri, 4 Jan 2019 16:33:12 +0100
Message-ID: <50769cc1-98f7-b844-c7e7-7a4ce965645c@daenzer.net>
References: <CABXGCsPtSt4iiJetTGx8N_YoQuNCGOYDJYFztsCfgJuM6L0BeQ@mail.gmail.com>
 <CADnq5_NsGN-J6Q8oHG_kuGG90GuBEBgM5km2N8AzOCf5F=nDgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_NsGN-J6Q8oHG_kuGG90GuBEBgM5km2N8AzOCf5F=nDgg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mikhail Gavrilov <mikhail.v.gavrilov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxOS0wMS0wNCA0OjI0IHAubS4sIEFsZXggRGV1Y2hlciB3cm90ZToKPiBPbiBGcmksIEph
biA0LCAyMDE5IGF0IDk6NTIgQU0gTWlraGFpbCBHYXZyaWxvdgo+IDxtaWtoYWlsLnYuZ2F2cmls
b3ZAZ21haWwuY29tPiB3cm90ZToKPj4KPj4gSGkgZm9sa3MgSSBmb3VuZCB0aGF0IGtlcm5lbCA0
LjIxIHVud29ya2FibGUgd2l0aCBBTUQgaGFyZHdhcmUuCj4+IEFsc28gSSBhbSBtYWtlIGtlcm5l
bCBiaXNlY3QgYW5kIGZvdW5kZWQgdGhlIGJsYW1lIGNvbW1pdC4KPj4gRmlyc3QgYmFkIGNvbW1p
dDogWzY3NGU3OGFjYWUwZGZiNGJlYjU2MTMyZTQxY2JhZTViNjBmN2Q2NjJdCj4+IGRybS9hbWQv
ZGlzcGxheTogQWRkIGZhc3QgcGF0aCBmb3IgY3Vyc29yIHBsYW5lIHVwZGF0ZXMKPiAKPiBJSVJD
LCB0aGUgaXNzdWUgb25seSBzaG93cyB1cCB3aXRoIG5ld2VyIHZlcnNpb25zIG9mIHRoZSBkZHgu
CgpXYXlsYW5kIGNvbXBvc2l0b3JzIHNlZW0gdG8gaGl0IGl0IGFzIHdlbGwsIEkgdGhpbmsgTWlr
aGFpbCBpcyB1c2luZwpHTk9NRSBvbiBXYXlsYW5kLgoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETD
pG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tCkxp
YnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFu
ZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK

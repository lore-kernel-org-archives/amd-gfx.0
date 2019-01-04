From: Mikhail Gavrilov <mikhail.v.gavrilov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: System with kernel 4.21 hang immediately after start (invalid
 opcode: 0000 [#1] SMP NOPTI)
Date: Sat, 5 Jan 2019 01:13:17 +0500
Message-ID: <CABXGCsP4SJvPASjYb7u62qiJRzZWaLAEcBr_kti4kjJWfXfSYg@mail.gmail.com>
References: <CABXGCsPtSt4iiJetTGx8N_YoQuNCGOYDJYFztsCfgJuM6L0BeQ@mail.gmail.com>
 <CADnq5_NsGN-J6Q8oHG_kuGG90GuBEBgM5km2N8AzOCf5F=nDgg@mail.gmail.com>
 <50769cc1-98f7-b844-c7e7-7a4ce965645c@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <50769cc1-98f7-b844-c7e7-7a4ce965645c-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gRnJpLCA0IEphbiAyMDE5IGF0IDIzOjAyLCBNaWNoZWwgRMOkbnplciA8bWljaGVsQGRhZW56
ZXIubmV0PiB3cm90ZToKPgo+IE9uIDIwMTktMDEtMDQgNDoyNCBwLm0uLCBBbGV4IERldWNoZXIg
d3JvdGU6Cj4gPiBPbiBGcmksIEphbiA0LCAyMDE5IGF0IDk6NTIgQU0gTWlraGFpbCBHYXZyaWxv
dgo+ID4gPG1pa2hhaWwudi5nYXZyaWxvdkBnbWFpbC5jb20+IHdyb3RlOgo+ID4+Cj4gPj4gSGkg
Zm9sa3MgSSBmb3VuZCB0aGF0IGtlcm5lbCA0LjIxIHVud29ya2FibGUgd2l0aCBBTUQgaGFyZHdh
cmUuCj4gPj4gQWxzbyBJIGFtIG1ha2Uga2VybmVsIGJpc2VjdCBhbmQgZm91bmRlZCB0aGUgYmxh
bWUgY29tbWl0Lgo+ID4+IEZpcnN0IGJhZCBjb21taXQ6IFs2NzRlNzhhY2FlMGRmYjRiZWI1NjEz
MmU0MWNiYWU1YjYwZjdkNjYyXQo+ID4+IGRybS9hbWQvZGlzcGxheTogQWRkIGZhc3QgcGF0aCBm
b3IgY3Vyc29yIHBsYW5lIHVwZGF0ZXMKPiA+Cj4gPiBJSVJDLCB0aGUgaXNzdWUgb25seSBzaG93
cyB1cCB3aXRoIG5ld2VyIHZlcnNpb25zIG9mIHRoZSBkZHguCj4KPiBXYXlsYW5kIGNvbXBvc2l0
b3JzIHNlZW0gdG8gaGl0IGl0IGFzIHdlbGwsIEkgdGhpbmsgTWlraGFpbCBpcyB1c2luZwo+IEdO
T01FIG9uIFdheWxhbmQuCgpFeGFjdGx5IQoKLS0KQmVzdCBSZWdhcmRzLApNaWtlIEdhdnJpbG92
LgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK

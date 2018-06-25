From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Add AMDGPU_GPU_PAGES_IN_CPU_PAGE define
Date: Mon, 25 Jun 2018 10:41:40 -0400
Message-ID: <CADnq5_O5kAsZZRdyacuOP7CcN5Ey-Rz+-grW29WOLbR4SL88ng@mail.gmail.com>
References: <20180622165433.4263-1-michel@daenzer.net>
 <CADnq5_NLmNtSH35TG5i3_WJdLGu_ujbkTW-Z-G5CodCDRZj0Xg@mail.gmail.com>
 <9a352ebd-3dea-e8ef-4151-022be90d45c0@amd.com>
 <b61f92a6-2d90-257d-8aa5-25b88b98459c@daenzer.net>
 <5b30f068.1c69fb81.45984.62a8SMTPIN_ADDED_BROKEN@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <5b30f068.1c69fb81.45984.62a8SMTPIN_ADDED_BROKEN-ATjtLOhZ0NVl57MIdRCFDg@public.gmane.org>
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
To: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Cc: =?UTF-8?B?TWljaGVsIETpi5h6ZXI=?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gTW9uLCBKdW4gMjUsIDIwMTggYXQgOTozMyBBTSwgWmhvdSwgRGF2aWQoQ2h1bk1pbmcpCjxE
YXZpZDEuWmhvdUBhbWQuY29tPiB3cm90ZToKPiBjdXJyZW50IGFtZGdwdSBkcml2ZXIgaW5kZWVk
IGFsd2F5cyBzZXQgR1BVIFBBR0UgU0laRSBpcyA0MDk2Lgo+IEluIGZhY3QsIG91ciBncHUgc3Vw
cG9ydHMgYmlnZ2VyIHBhZ2Ugc2l6ZSBsaWtlIDY0S0IsIGp1c3Qgd2UgZG9uJ3QgdXNlIGl0Lgo+
IEkgcmVtZWJlciBwcmV2aW91cyBhbWRzb2Mob2xkIGFuZHJvaWQga2VybmVsIGRyaXZlcikgdXNl
ZCA2NEtCLgo+Cj4gY29ycmVjdCBtZSBpZiBJJ20gd3JvbmcuCgpJdCdzIHN0aWxsIDRrIHBhZ2Vz
LCBidXQgeW91IGNhbiB0d2VhayB0aGUgZnJhZ21lbnQgc2l6ZSB0byBtYWtlIGEgVExCCmVudHJ5
IGNvdmVyIG11bHRpcGxlIHBhZ2VzLgoKQWxleAoKPgo+IHNlbmQgZnJvbSBTbWFydGlzYW4gUHJv
Cj4KPiBNaWNoZWwgROmLmHplciA8bWljaGVsQGRhZW56ZXIubmV0PiDkuo4gMjAxOOW5tDbmnIgy
NeaXpSDkuIvljYg1OjEw5YaZ6YGT77yaCj4KPiBPbiAyMDE4LTA2LTI1IDAzOjU2IEFNLCB6aG91
Y20xIHdyb3RlOgo+PiBvbmUgcXVlc3Rpb24gdG8geW91Ogo+Pgo+PiBEaWQgeW91IGNvbnNpZGVy
IHRoZSBjYXNlIHRoYXQgR1BVX1BBR0VfU0laRSA+IENQVV9QQUdFX1NJWkU/Cj4KPiBUaGF0IGlz
IG5ldmVyIHRoZSBjYXNlOiBBTURHUFVfR1BVX1BBR0VfU0laRSBpcyBhbHdheXMgNDA5NiwgYW5k
Cj4gUEFHRV9TSVpFIGlzIGFsd2F5cyA+PSA0MDk2IChhbiBpbnRlZ2VyIG11bHRpcGxlIG9mIGl0
KS4KPgo+Cj4gLS0KPiBFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAg
ICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tCj4gTGlicmUgc29mdHdhcmUgZW50aHVzaWFz
dCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCj4KPiBfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFp
bGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKPgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK

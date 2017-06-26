From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 6/9] drm/amdgpu: Set/clear CPU_ACCESS_REQUIRED flag on
 page fault and CS
Date: Tue, 27 Jun 2017 01:25:42 +0200
Message-ID: <CAAxE2A7qo_qzN5oqjqrp1jO9cNt5BoOqa43xHDYw-866_8BG4g@mail.gmail.com>
References: <1498239580-17360-1-git-send-email-john@fastquake.com>
 <1498239580-17360-7-git-send-email-john@fastquake.com>
 <55ea5e84-0791-5a70-6278-ade83c343a3b@vodafone.de>
 <6c6fca21-df95-a413-d5eb-c05f1913787b@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <6c6fca21-df95-a413-d5eb-c05f1913787b-otUistvHUpPR7s880joybQ@public.gmane.org>
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
Cc: David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, John Brooks <john-xq/Ko7C6e2Bl57MIdRCFDg@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gTW9uLCBKdW4gMjYsIDIwMTcgYXQgMTE6MjcgQU0sIE1pY2hlbCBEw6RuemVyIDxtaWNoZWxA
ZGFlbnplci5uZXQ+IHdyb3RlOgo+IE9uIDI1LzA2LzE3IDAzOjAwIEFNLCBDaHJpc3RpYW4gS8O2
bmlnIHdyb3RlOgo+PiBBbSAyMy4wNi4yMDE3IHVtIDE5OjM5IHNjaHJpZWIgSm9obiBCcm9va3M6
Cj4+PiBXaGVuIHRoZSBBTURHUFVfR0VNX0NSRUFURV9DUFVfQUNDRVNTX1JFUVVJUkVEIGZsYWcg
aXMgZ2l2ZW4gYnkKPj4+IHVzZXJzcGFjZSwKPj4+IGl0IHNob3VsZCBvbmx5IGJlIHRyZWF0ZWQg
YXMgYSBoaW50IHRvIGluaXRpYWxseSBwbGFjZSBhIEJPIHNvbWV3aGVyZSBDUFUKPj4+IGFjY2Vz
c2libGUsIHJhdGhlciB0aGFuIGhhdmluZyBhIHBlcm1hbmVudCBlZmZlY3Qgb24gQk8gcGxhY2Vt
ZW50Lgo+Pgo+PiBBbmQgdGhhdCBpcyBhIGNsZWFyIE5BSyBmcm9tIG15IHNpZGUuCj4+Cj4+IENQ
VV9BQ0NFU1NfUkVRVUlSRUQgaXMgYSBwZXJtYW5lbnQgbGltaXRhdGlvbiB0byB3aGVyZSB0aGUg
YnVmZmVyIHNob3VsZAo+PiBiZSBwbGFjZWQuCj4KPiBJdCByZWFsbHkgY2FuJ3QgYmUgbW9yZSB0
aGFuIGEgaGludC4gVGhlIHVzZXJzcGFjZSBkcml2ZXIgY2Fubm90Cj4gcmVsaWFibHkga25vdyBh
aGVhZCBvZiB0aW1lIHdoZXRoZXIgYSBCTyB3aWxsIGJlIGFjY2Vzc2VkIGJ5IHRoZSBDUFUgYXQK
PiBhbGwsIGxldCBhbG9uZSBob3cgb2Z0ZW4uIEEgQk8gd2hpY2ggaW5jb3JyZWN0bHkgaGFzIHRo
aXMgZmxhZyBzZXQKPiBjcmVhdGVzIGFydGlmaWNpYWwgcHJlc3N1cmUgb24gQ1BVIHZpc2libGUg
VlJBTS4KCkkgYWxzbyB0aGluayB0aGUgZmxhZyBpcyBvbmx5IGEgaGludCBhbmQgc2hvdWxkbid0
IGJlIHRha2VuIHRvbyBzZXJpb3VzbHkuCgpPbmx5IEFNREdQVV9HRU1fQ1JFQVRFX05PX0NQVV9B
Q0NFU1MgaGFzIGEgc3RyaWN0IGJlaGF2aW9yLgoKTWFyZWsKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==

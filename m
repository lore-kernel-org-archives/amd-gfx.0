From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
Date: Thu, 24 Jan 2019 10:31:06 +0100
Message-ID: <ee261b46-1a83-6af2-31fe-fb9f30894c1e@daenzer.net>
References: <ccc775d3-3053-ab79-dac8-4feb28e8e690@daenzer.net>
 <CAKv+Gu-9VKL5RjScbKss4YfH1Cb8WbXmzU_0UsStnoXJcML7Rg@mail.gmail.com>
 <850b6aee-0040-c333-b125-45211c18ada5@daenzer.net>
 <CAKv+Gu99zHqcQtj6TiOXAr3Qa6WWhKem+DHVA_mAQ0-Bc0Vbqw@mail.gmail.com>
 <047667fd-17be-1c37-5d2a-26768cfd6ab8@daenzer.net>
 <CAKv+Gu_VBd8agHASc5RS0eCgyXP64Lt_i4yPuBjKwGQ+5Lpd5Q@mail.gmail.com>
 <CADnq5_O1uxCrSksfF127AZTfbmdukxmqGdh2Ee0zM6CqgG_Mhg@mail.gmail.com>
 <CAKv+Gu-4uYh_HD_5Ry_L80Nf5zpRhT4oJYhhG5_8g3gSzBs2tg@mail.gmail.com>
 <20190123071521.GB20526@infradead.org>
 <CAKv+Gu8+77uZHJ6ZYjGNcKQL8C3cT5Ree+TcTVmkQXAHV-ADyg@mail.gmail.com>
 <20190123164428.GA9367@infradead.org>
 <CAKv+Gu-9vEKu8mG-o+-4M1ZcgZmTTJVfEdNS9R27AFX8P5sqyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAKv+Gu-9vEKu8mG-o+-4M1ZcgZmTTJVfEdNS9R27AFX8P5sqyQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Ard Biesheuvel <ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Sean Paul <sean-p7yTbzM4H96eqtR555YLDQ@public.gmane.org>, Christian Koenig <christian.koenig-5C7GfCeVMHo@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>

T24gMjAxOS0wMS0yMyA1OjUyIHAubS4sIEFyZCBCaWVzaGV1dmVsIHdyb3RlOgo+IE9uIFdlZCwg
MjMgSmFuIDIwMTkgYXQgMTc6NDQsIENocmlzdG9waCBIZWxsd2lnIDxoY2hAaW5mcmFkZWFkLm9y
Zz4gd3JvdGU6Cj4+Cj4+IEkgdGhpbmsgd2UganVzdCB3YW50IGEgZHJpdmVyLWxvY2FsIGNoZWNr
IGZvciB0aG9zZSBjb21iaW5hdGlvbnMKPj4gd2hlcmUgd2Uga25vdyB0aGlzIGhhY2sgYWN0dWFs
bHkgd29ya3MsIHdoaWNoIHJlYWxseSBqdXN0IHNlZW1zCj4+IHRvIGJlIHg4Ni02NCB3aXRoIFBB
VC4gU29tZXRoaW5nIGxpa2UgdGhlIHBhdGNoIGJlbG93LCBidXQgbWF5YmUgd2l0aAo+PiBldmVu
IG1vcmUgc3Ryb25nIHdhcm5pbmdzIHRvIG5vdCBkbyBzb21ldGhpbmcgbGlrZSB0aGlzIGVsc2V3
aGVyZToKPiAKPiBJIGFncmVlIHRoYXQgeW91ciBwYXRjaCBzZWVtcyBsaWtlIHRoZSByaWdodCB3
YXkgdG8gZW5zdXJlIHRoYXQgdGhlIFdDCj4gb3B0aW1pemF0aW9uIGhhY2sgaXMgb25seSB1c2Vk
IHdoZXJlIHdlIGtub3cgaXQgd29ya3MuCj4gCj4gQnV0IG15IGNvbmNlcm4gaXMgdGhhdCBpdCBz
ZWVtcyBsaWtlbHkgdGhhdCBub24tY2FjaGUgY29oZXJlbnQKPiBpbXBsZW1lbnRhdGlvbnMgYXJl
IHJlbHlpbmcgb24gdGhpcyBoYWNrIGFzIHdlbGwuCgpJJ3ZlIGJlZW4gdHJ5aW5nIHRvIHRlbGwg
eW91IHRoZXkgY2FuJ3QgcmVseSBvbiB0aGF0LCBiZWNhdXNlIHRoZSBhbWRncHUKZHJpdmVyIGRv
ZXNuJ3QgdXNlIHRoaXMgZnVuY3Rpb25hbGl0eSBmb3IgZnVuZGFtZW50YWxzIHN1Y2ggYXMgcmlu
ZwpidWZmZXJzIHVzZWQgZm9yIGZlZWRpbmcgdGhlIGhhcmR3YXJlIHdpdGggY29tbWFuZHMuIElu
c3RlYWQsIGZvciB0aG9zZQppdCByZWxpZXMgb24gc25vb3BlZCBQQ0llIHRyYW5zZmVycyBiZWlu
ZyBjb2hlcmVudCB3aXRoIHRoZSBDUFUgY2FjaGVzLgoKCj4+IC0jZWxpZiBkZWZpbmVkKENPTkZJ
R19YODYpICYmICFkZWZpbmVkKENPTkZJR19YODZfUEFUKQo+PiAtICAgICAgIC8qIERvbid0IHRy
eSB0byBlbmFibGUgd3JpdGUtY29tYmluaW5nIHdoZW4gaXQgY2FuJ3Qgd29yaywgb3IgdGhpbmdz
Cj4+IC0gICAgICAgICogbWF5IGJlIHNsb3cKPj4gLSAgICAgICAgKiBTZWUgaHR0cHM6Ly9idWdz
LmZyZWVkZXNrdG9wLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9ODg3NTgKPj4gLSAgICAgICAgKi8KPj4g
LQo+PiAtI2lmbmRlZiBDT05GSUdfQ09NUElMRV9URVNUCj4+IC0jd2FybmluZyBQbGVhc2UgZW5h
YmxlIENPTkZJR19NVFJSIGFuZCBDT05GSUdfWDg2X1BBVCBmb3IgYmV0dGVyIHBlcmZvcm1hbmNl
IFwKPj4gLSAgICAgICAgdGhhbmtzIHRvIHdyaXRlLWNvbWJpbmluZwo+PiAtI2VuZGlmCj4+IC0K
Pj4gLSAgICAgICBpZiAoYm8tPmZsYWdzICYgQU1ER1BVX0dFTV9DUkVBVEVfQ1BVX0dUVF9VU1dD
KQo+PiAtICAgICAgICAgICAgICAgRFJNX0lORk9fT05DRSgiUGxlYXNlIGVuYWJsZSBDT05GSUdf
TVRSUiBhbmQgQ09ORklHX1g4Nl9QQVQgZm9yICIKPj4gLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgImJldHRlciBwZXJmb3JtYW5jZSB0aGFua3MgdG8gd3JpdGUtY29tYmluaW5nXG4iKTsK
CkZXSVcsIHBsZWFzZSBkb24ndCBkcm9wIHRoZXNlIGNvbXBpbGUgYW5kIGJ1aWxkIHRpbWUgd2Fy
bmluZ3Mgd2hlcmUgd2UKY29udGludWUgdG8gdGFrZSBhZHZhbnRhZ2Ugb2YgUEFULgoKCi0tIApF
YXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0
cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAg
ICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK

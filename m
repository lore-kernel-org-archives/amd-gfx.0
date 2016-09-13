From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: improve GTT BO alloc speed in OGL
Date: Mon, 12 Sep 2016 22:53:44 -0400
Message-ID: <CADnq5_PEWhn=OfrjoMO+vJEkpRnJA0LocJfmVXEoayeVFPDnkA@mail.gmail.com>
References: <1473698681-28637-1-git-send-email-alexander.deucher@amd.com>
 <ad77d18c-b74b-a73e-b412-2ce1bc06f9ff@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <ad77d18c-b74b-a73e-b412-2ce1bc06f9ff-otUistvHUpPR7s880joybQ@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, "monk.liu" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gTW9uLCBTZXAgMTIsIDIwMTYgYXQgOToxNyBQTSwgTWljaGVsIETDpG56ZXIgPG1pY2hlbEBk
YWVuemVyLm5ldD4gd3JvdGU6Cj4gT24gMTMvMDkvMTYgMDE6NDQgQU0sIEFsZXggRGV1Y2hlciB3
cm90ZToKPj4gRnJvbTogIm1vbmsubGl1IiA8bW9uay5saXVAYW1kLmNvbT4KPj4KPj4gb3JpZ2lu
YWwgd2UgdXNlIHR0bV9kbWEgcGF0aCB0byBhbGxvY2F0ZSBHVFQgYm8sIHdoaWNoIGlzIHRvbyBt
dWNoCj4+IHNsb3dlciB0aGFuIHRoZSBwYXRoIG9mIHR0bV9wb29sLCBpbiBtb3N0IGNhc2VzLgo+
Pgo+PiBUaGUgc3dpb3RsYiBjaGVja3MgZG9uJ3Qgc2VlbSB0byB3b3JrIGFuZCB3ZSBhbHdheXMg
ZW5kIHVwIGluIHRoZQo+PiBzbG93IHBhdGggZXZlbiB3aGVuIGFuIElPTU1VIGlzIGF2YWlsYWJs
ZS4KPgo+IFRoaXMgY2hhbmdlIHdpbGwgYnJlYWsgYW55IGNhc2VzIHdoZXJlIFNXSU9UTEIgaXMg
YWN0dWFsbHkgbmVjZXNzYXJ5Cj4gdGhvdWdoLCB3b24ndCBpdD8KClllcywgdGhlb3JldGljYWxs
eS4KCkFsZXgKCj4KPgo+IC0tCj4gRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAg
ICAgfCAgICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNvbQo+IExpYnJlIHNvZnR3YXJlIGVu
dGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3Blcgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK

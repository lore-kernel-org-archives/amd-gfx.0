From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH libdrm] amdgpu: fix "add AMDGPU_VA_RANGE_HIGH"
Date: Wed, 28 Feb 2018 16:40:11 +0100
Message-ID: <b0b39019-e085-ea73-703b-fd41705d9c01@daenzer.net>
References: <20180228144111.1651-1-christian.koenig@amd.com>
 <2450a93d-fbf0-0a6c-e0b8-2432a401d531@daenzer.net>
 <42d3a34d-2df5-2f9f-95b7-525957297cab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <42d3a34d-2df5-2f9f-95b7-525957297cab-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

T24gMjAxOC0wMi0yOCAwNDoyNSBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAyOC4w
Mi4yMDE4IHVtIDE2OjIxIHNjaHJpZWIgTWljaGVsIETDpG56ZXI6Cj4+IE9uIDIwMTgtMDItMjgg
MDM6NDEgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+PiBUaGUgMzJiaXQgYWRkcmVzcyBy
YW5nZSBlbmQgaXMgZXhjbHVzaXZlLCBub3QgaW5jbHVzaXZlLgo+PiBUaGUgb3RoZXIgd2F5IGFy
b3VuZC4gOikgSW5jbHVzaXZlIG1lYW5zIFthLGJdLCBpLmUuIGFuIGludGVydmFsCj4+IGluY2x1
ZGluZyB0aGUgZW5kcG9pbnRzLCB3aGVyZWFzIGV4Y2x1c2l2ZSBtZWFucyBdYSxiWywgaS5lLiBh
biBpbnRlcnZhbAo+PiBub3QgaW5jbHVkaW5nIHRoZSBlbmRwb2ludHMuIFRoZSBwYXRjaCBjaGFu
Z2VzIHRoZSAzMi1iaXQgYWRkcmVzcyByYW5nZQo+PiBlbmRwb2ludCBmcm9tIGV4Y2x1c2l2ZSB0
byBpbmNsdXNpdmUuCj4gCj4gQWN0dWFsbHkgdGhhdCdzIG5vdCB3aGF0IEkgbWVhbnQuIEhvdyBh
Ym91dCB0aGlzOgo+IAo+ICJUaGUgcmFuZ2UgaXMgc3RvcmVkIGFzIGV4Y2x1c2l2ZSwgbm90IGlu
Y2x1c2l2ZS4gU3VidHJhY3RzIG9uZSB0byBnZXQKPiB0aGUgaW5jbHVzaXZlIGludGVydmFsIGZv
ciB0aGUgY2FsY3VsYXRpb24uIgoKU291bmRzIGdvb2QgdG8gbWUsIGJ1dCBJJ2xsIGRlZmVyIHRv
IG5hdGl2ZSBFbmdsaXNoIHNwZWFrZXJzIGZvciB0aGUKZmluYWwgdmVyZGljdC4KCgotLSAKRWFy
dGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHA6
Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAg
ICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==

From: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/5] pci: export pcie_get_speed_cap and pcie_get_width_cap
Date: Thu, 28 Jun 2018 11:53:41 -0500
Message-ID: <20180628165341.GA120578@bhelgaas-glaptop.roam.corp.google.com>
References: <20180625210606.2736-1-alexander.deucher@amd.com>
 <20180625210606.2736-2-alexander.deucher@amd.com>
 <20180628134221.GC90450@bhelgaas-glaptop.roam.corp.google.com>
 <CADnq5_OMmcbKsWQ3QfuMKYOxhrZZxOCs4YTN+Pyf7zuy43ypyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CADnq5_OMmcbKsWQ3QfuMKYOxhrZZxOCs4YTN+Pyf7zuy43ypyA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linux PCI <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

T24gVGh1LCBKdW4gMjgsIDIwMTggYXQgMTA6MTk6NDFBTSAtMDQwMCwgQWxleCBEZXVjaGVyIHdy
b3RlOgo+IE9uIFRodSwgSnVuIDI4LCAyMDE4IGF0IDk6NDIgQU0sIEJqb3JuIEhlbGdhYXMgPGhl
bGdhYXNAa2VybmVsLm9yZz4gd3JvdGU6Cj4gPiBPbiBNb24sIEp1biAyNSwgMjAxOCBhdCAwNDow
NjowMlBNIC0wNTAwLCBBbGV4IERldWNoZXIgd3JvdGU6Cj4gPj4gU28gZHJpdmVycyBjYW4gdXNl
IHRoZW0uICBUaGlzIGNhbiBiZSB1c2VkIHRvIHJlcGxhY2UKPiA+PiBkdXBsaWNhdGUgY29kZSBp
biB0aGUgZHJtIHN1YnN5c3RlbS4KPiA+Pgo+ID4+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hl
ciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiA+Cj4gPiBBY2tlZC1ieTogQmpvcm4gSGVs
Z2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4KPiA+Cj4gPiBUaGFua3MgYSBsb3QgZm9yIGRvaW5n
IHRoaXMhCj4gPgo+ID4gSWYgeW91IGhhdmVuJ3QgYXBwbGllZCB0aGVzZSB5ZXQsIHBsZWFzZQo+
ID4KPiA+ICAgcy9wY2k6IGV4cG9ydC9QQ0k6IEV4cG9ydC8KPiA+Cj4gPiBpbiB0aGUgc3ViamVj
dC4KPiAKPiAKPiBXaWxsIGZpeC4gIEFueSBvYmplY3Rpb25zIHRvIHRha2luZyB0aGlzIHZpYSB0
aGUgZHJtIHRyZWU/CgpOb3BlLCBJIGFja2VkIGl0IGJlY2F1c2UgSSBhc3N1bWVkIHlvdSB3b3Vs
ZCBtZXJnZSBpdCBhbG9uZyB3aXRoIHRoZSByZXN0Cm9mIHRoZSBzZXJpZXMgdmlhIHNvbWUgbm9u
LVBDSSB0cmVlLCBzbyB0aGUgZHJtIHRyZWUgd291bGQgYmUgZ3JlYXQuCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=

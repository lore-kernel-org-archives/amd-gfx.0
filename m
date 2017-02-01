From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/4] drm/amdgpu: extend profiling mode.
Date: Wed, 1 Feb 2017 09:42:44 -0500
Message-ID: <CADnq5_N27CHyxLZQMypKUsBGO3tfGcbW3+aO-vQM+=7NShghCQ@mail.gmail.com>
References: <1483944700-3842-1-git-send-email-Rex.Zhu@amd.com>
 <1483944700-3842-4-git-send-email-Rex.Zhu@amd.com>
 <5876B5C8.1010401@gmail.com> <58911B91.50008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <58911B91.50008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Andy Furniss <adf.lists-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gVHVlLCBKYW4gMzEsIDIwMTcgYXQgNjoxOSBQTSwgQW5keSBGdXJuaXNzIDxhZGYubGlzdHNA
Z21haWwuY29tPiB3cm90ZToKPiBBbmR5IEZ1cm5pc3Mgd3JvdGU6Cj4+Cj4+IFJleCBaaHUgd3Jv
dGU6Cj4+Pgo+Pj4gaW4gcHJvZmlsaW5nIG1vZGUsIHBvd2VycGxheSB3aWxsIGZpeCBwb3dlciBz
dGF0ZQo+Pj4gYXMgc3RhYmxlIGFzIHBvc3NpYmxlLmFuZCBkaXNhYmxlIGdmeCBjZyBhbmQgTEJQ
VyBmZWF0dXJlLgo+Pj4KPj4+IHByb2ZpbGVfc3RhbmRhcmQ6IGFzIGEgcHJlcmVxdWlzaXRlLCBl
bnN1cmUgcG93ZXIgYW5kIHRoZXJtYWwKPj4+IHN1c3RhaW5hYmxlLCBzZXQgY2xvY2tzIHJhdGlv
IGFzIGNsb3NlIHRvIHRoZSBoaWdoZXN0IGNsb2NrCj4+PiByYXRpbyBhcyBwb3NzaWJsZS4KPj4+
IHByb2ZpbGVfbWluX3NjbGs6IGZpeCBtY2xrIGFzIHByb2ZpbGVfbm9ybWFsLCBzZXQgbG93ZXN0
IHNjbGsKPj4+IHByb2ZpbGVfbWluX21jbGs6IGZpeCBzY2xrIGFzIHByb2ZpbGVfbm9ybWFsLCBz
ZXQgbG93ZXN0IG1jbGsKPj4+IHByb2ZpbGVfcGVhazogc2V0IGhpZ2hlc3Qgc2NsayBhbmQgbWNs
aywgcG93ZXIgYW5kIHRoZXJtYWwgbm90Cj4+PiBzdXN0YWluYWJsZQo+Pj4gcHJvZmlsZV9leGl0
OiBleGl0IHByb2ZpbGUgbW9kZS4gZW5hYmxlIGdmeCBjZy9sYnB3IGZlYXR1cmUuCj4+Cj4+Cj4+
IFRlc3RpbmcgUjkgMjg1IFRvbmdhIG9uIGRybS1uZXh0LTQuMTEtd2lwCj4+Cj4+IFRoaXMgY29t
bWl0IGhhcyB0aGUgZWZmZWN0IHRoYXQgZG9pbmcKPj4KPj4gZWNobyBoaWdoID4gL3N5cy9jbGFz
cy9kcm0vY2FyZDAvZGV2aWNlL3Bvd2VyX2RwbV9mb3JjZV9wZXJmb3JtYW5jZV9sZXZlbAo+Pgo+
PiBpbnN0YW50bHkgZm9yY2VzIGZhbiB0byAoSSBndWVzcykgbWF4LCB3aGVyZSBub3JtYWxseSBp
dCBkb2Vzbid0Cj4+IG5lZWQgYW55dGhpbmcgbGlrZSBhcyBmYXN0IHdpdGggdGhlIGNsb2NrcyBo
aWdoIHdoZW4gZG9pbmcgbm90aGluZyBlbHNlLgo+Cj4KPiBQaW5nIC0ganVzdCBpbiBjYXNlIHRo
aXMgZ290IG1pc3NlZCwgc3RpbGwgdGhlIHNhbWUgb24gY3VycmVudAo+IGRybS1uZXh0LTQuMTEt
d2lwCgpKdXN0IGEgaGVhZHMgdXAsIFJleCB3YXMgbG9va2luZyBhdCB0aGlzLCBidXQgaXQncyBD
aGluZXNlIE5ldyBZZWFyIHRoaXMgd2Vlay4KCkFsZXgKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==

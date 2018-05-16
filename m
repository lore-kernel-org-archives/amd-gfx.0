From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/scheduler: Remove obsolete spinlock.
Date: Wed, 16 May 2018 15:10:39 +0200
Message-ID: <96b4e712-5e80-0053-301e-3f89940be8f0@amd.com>
References: <1526412674-15913-1-git-send-email-andrey.grodzovsky@amd.com>
 <1526412674-15913-2-git-send-email-andrey.grodzovsky@amd.com>
 <dda4fb88-e228-e10b-46a5-27ba9888b78d@amd.com>
 <MWHPR12MB14530840CD7DB545DD286827EA920@MWHPR12MB1453.namprd12.prod.outlook.com>
 <3a54ce0c-6821-9c94-a67f-2b1a3c74959d@amd.com>
 <8f358856-f16d-3622-d28b-32fed49ba4aa@amd.com>
 <0d936838-8a88-9bd7-d4ff-053cd73f41cc@gmail.com>
 <72266649-c75c-15d3-41b6-59f2dd10235d@amd.com>
 <0be3bb9a-004a-7390-469c-3f974ed44055@amd.com>
 <1526473713.10230.1.camel@pengutronix.de>
 <755d0607-4191-55d2-a21a-9a87305499ad@gmail.com>
 <1526475600.10230.3.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1526475600.10230.3.camel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Language: en-US
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
To: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMTYuMDUuMjAxOCB1bSAxNTowMCBzY2hyaWViIEx1Y2FzIFN0YWNoOgo+IEFtIE1pdHR3b2No
LCBkZW4gMTYuMDUuMjAxOCwgMTQ6MzIgKzAyMDAgc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+
PiBBbSAxNi4wNS4yMDE4IHVtIDE0OjI4IHNjaHJpZWIgTHVjYXMgU3RhY2g6Cj4+PiBBbSBNaXR0
d29jaCwgZGVuIDE2LjA1LjIwMTgsIDE0OjA4ICswMjAwIHNjaHJpZWIgQ2hyaXN0aWFuIEvDtm5p
ZzoKPj4+PiBZZXMsIGV4YWN0bHkuCj4+Pj4KPj4+PiBGb3Igbm9ybWFsIHVzZXIgc3BhY2UgY29t
bWFuZCBzdWJtaXNzaW9uIHdlIHNob3VsZCBoYXZlIHRvbnMgb2YKPj4+PiBsb2Nrcwo+Pj4+IGd1
YXJhbnRlZWluZyB0aGF0IChlLmcuIGp1c3QgdGhlIFZNIGxvY2sgc2hvdWxkIGRvKS4KPj4+Pgo+
Pj4+IEZvciBrZXJuZWwgbW92ZXMgd2UgaGF2ZSB0aGUgbXV0ZXggZm9yIHRoZSBHVFQgd2luZG93
cyB3aGljaAo+Pj4+IHByb3RlY3RzCj4+Pj4gaXQuCj4+Pj4KPj4+PiBUaGUgY291bGQgYmUgcHJv
YmxlbXMgd2l0aCB0aGUgVVZEL1ZDRSBxdWV1ZXMgdG8gY2xlYW51cCB0aGUKPj4+PiBoYW5kbGVz
Cj4+Pj4gd2hlbiBhbiBhcHBsaWNhdGlvbiBjcmFzaGVzLgo+Pj4gRldJVywgZXRuYXZpdiBpcyBj
dXJyZW50bHkgY29tcGxldGVseSB1bmxvY2tlZCBpbiB0aGlzIHBhdGgsIGJ1dCBJCj4+PiBiZWxp
ZXZlIHRoYXQgdGhpcyBpc24ndCBhbiBpc3N1ZSBhcyB0aGUgc2NoZWQgZmVuY2Ugc2VxIG51bWJl
cnMgYXJlCj4+PiBwZXIKPj4+IGVudGl0eS4gU28gdG8gYWN0dWFsbHkgZW5kIHVwIHdpdGggcmV2
ZXJzZWQgc2Vxbm9zIG9uZSBjb250ZXh0IGhhcwo+Pj4gdG8KPj4+IHByZWVtcHQgaXRzZWxmIHRv
IGRvIGFub3RoZXIgc3VibWl0LCB3aGlsZSB0aGUgY3VycmVudCBvbmUgaGFzbid0Cj4+PiByZXR1
cm5lZCBmcm9tIGtlcm5lbCBzcGFjZSwgd2hpY2ggSSBiZWxpZXZlIGlzIGEgZmFpcmx5IHRoZW9y
ZXRpY2FsCj4+PiBpc3N1ZS4gSXMgbXkgdW5kZXJzdGFuZGluZyBjb3JyZWN0Pwo+PiBZZXMuIFRo
ZSBwcm9ibGVtIGlzIHdpdGggdGhlIHJpZ2h0IHRpbWluZyB0aGlzIGNhbiBiZSB1c2VkIHRvIGFj
Y2Vzcwo+PiBmcmVlZCB1cCBtZW1vcnkuCj4+Cj4+IElmIHlvdSB0aGVuIG1hbmFnZSB0byBwbGFj
ZSBhIHBhZ2UgdGFibGUgaW4gdGhhdCBmcmVlZCB1cCBtZW1vcnkKPj4gdGFraW5nCj4+IG92ZXIg
dGhlIHN5c3RlbSBpcyBqdXN0IGEgdHlwaW5nIGV4ZXJjaXNlLgo+IFRoYW5rcy4gSSBiZWxpZXZl
IHdlIGRvbid0IGhhdmUgdGhpcyBwcm9ibGVtIGluIGV0bmF2aXYsIGFzIG1lbW9yeQo+IHJlZmVy
ZW5jaW5nIGlzIHRpZWQgdG8gdGhlIGpvYiBhbmQgd2lsbCBvbmx5IGJlIHVucmVmZXJlbmNlZCBv
bgo+IGZyZWVfam9iLCBidXQgSSdsbCByZS1jaGVjayB0aGlzIHdoZW4gSSd2ZSBnb3Qgc29tZSB0
aW1lLgoKV2VsbCB0aGF0IGRlcGVuZHMgb24gaG93IHlvdSB1c2UgdGhlIHNlcXVlbmNlIG51bWJl
cnMuCgpJZiB5b3UgdXNlIHRoZW0gZm9yIGpvYiBjb21wbGV0aW9uIGNoZWNrIHNvbWV3aGVyZSB0
aGVuIHlvdSBjZXJ0YWlubHkgCmhhdmUgYSBwcm9ibGVtIGlmIGpvYiBBIGdldHMgdGhlIDEgYW5k
IEIgdGhlIDIsIGJ1dCBCIGNvbXBsZXRlcyBiZWZvcmUgQS4KCkF0IGJhcmUgbWluaW11bSB0aGF0
J3Mgc3RpbGwgYSBidWcgd2UgbmVlZCB0byBmaXggYmVjYXVzZSBpdCBjb25mdXNlcyAKZnVuY3Rp
b25zIGxpa2UgZG1hX2ZlbmNlX2lzX2xhdGVyKCkgYW5kIGRtYV9mZW5jZV9sYXRlcigpLgoKQ2hy
aXN0aWFuLgoKPgo+IFJlZ2FyZHMsCj4gTHVjYXMKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=

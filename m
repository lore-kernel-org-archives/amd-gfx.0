From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC] drm/amdgpu: Add macros and documentation for format
 modifiers.
Date: Fri, 7 Sep 2018 18:33:24 -0400
Message-ID: <CAAxE2A4wFN3FfahB9+bsxRV50AdYZZdRw_kdtjq=ttH=xRN67w@mail.gmail.com>
References: <20180904010033.67611-1-bas@basnieuwenhuizen.nl>
 <CAAxE2A4eO4pevcHQKhbRbZXFTUVbFuBzOrFf8dgfVR4n5fvX1g@mail.gmail.com>
 <CAP+8YyEQKu7xACK3O=tp=MqvvumcjYouwate3_+uhTCDho-v5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAP+8YyEQKu7xACK3O=tp=MqvvumcjYouwate3_+uhTCDho-v5w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Bas Nieuwenhuizen <bas-dldO88ZXqoXqqjsSq9zF6IRWq/SkRNHw@public.gmane.org>
Cc: =?UTF-8?Q?Nicolai_H=C3=A4hnle?= <nicolai.haehnle-5C7GfCeVMHo@public.gmane.org>, Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>, Chad Versace <chadversary-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, ML dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak-5C7GfCeVMHo@public.gmane.org>

T24gRnJpLCBTZXAgNywgMjAxOCBhdCA1OjU1IEFNLCBCYXMgTmlldXdlbmh1aXplbgo8YmFzQGJh
c25pZXV3ZW5odWl6ZW4ubmw+IHdyb3RlOgo+IE9uIEZyaSwgU2VwIDcsIDIwMTggYXQgNjo1MSBB
TSBNYXJlayBPbMWhw6FrIDxtYXJhZW9AZ21haWwuY29tPiB3cm90ZToKPj4KPj4gSG9wZWZ1bGx5
IHRoaXMgYW5zd2VycyBzb21lIHF1ZXN0aW9ucy4KPj4KPj4gT3RoZXIgcGFyYW1ldGVycyB0aGF0
IGFmZmVjdCB0aWxpbmcgbGF5b3V0cyBhcmUgR0JfQUREUl9DT05GSUcgKGFsbAo+PiBjaGlwcykg
YW5kIE1DX0FSQl9SQU1DRkcgKEdGWDYtOCBvbmx5KSwgYW5kIHRob3NlIHZhcnkgd2l0aCBlYWNo
IGNoaXAuCj4KPiBGb3IgR0ZYNi1HRlg4Ogo+IEZyb20gR0JfQUREUl9DT05GSUcgYWRkcmxpYiBv
bmx5IHVzZXMgdGhlIHBpcGUgaW50ZXJsZWF2ZSBieXRlcyB3aGljaAo+IGFyZSAwICg9MjU2IGJ5
dGVzKSBmb3IgYWxsIEFNREdQVSBIVyAoYW5kIG9uIEdGWDkgYWRkcmxpYiBldmVuIGFzc2VydHMK
PiBvbiB0aGF0KS4gIEZyb20gTUNfQVJCX1JBTUNGRyBhZGRybGliIHJlYWRzIHRoZSBudW1iZXIg
b2YgYmFua3MgYW5kCj4gcmFua3MsIGNhbGN1bGF0ZXMgdGhlIG51bWJlciBvZiBsb2dpY2FsIGJh
bmtzIGZyb20gaXQsIGJ1dCB0aGVuIGRvZXMKPiBub3QgdXNlIGl0LiAoUHJlc3VtYWJseSBiZWNh
dXNlIGl0IGlzIHRoZSBzYW1lIG51bWJlciBhcyB0aGUgbnVtYmVyIG9mCj4gYmFua3MgaW4gdGhl
IHRpbGluZyB0YWJsZSBlbnRyeT8pIFNvbWUgYml0cyBnZXRzIHVzZWQgYnkgdGhlIGtlcm5lbAo+
IChtZW1vcnkgcm93IHNpemUpLCBidXQgdGhvc2UgZ2V0IGVuY29kZWQgaW4gdGhlIHRpbGUgc3Bs
aXQgb2YgdGhlCj4gdGlsaW5nIHRhYmxlLCBpLmUuIHdlIGRvIG5vdCBuZWVkIHRoZSBzZXBhcmF0
ZSBiaXRzLgo+Cj4gZm9yIEdGWDksIG9ubHkgdGhlIERDQyBtZXRhIHN1cmZhY2Ugc2VlbXMgdG8g
ZGVwZW5kIG9uIEdCX0FERFJfQ09ORklHCj4gKGV4Y2VwdCB0aGUgYWZvcmVtZW50aW9uZWQgcGlw
ZSBpbnRlcmxlYXZlIGJ5dGVzKSB3aGljaCBhcmUgY29uc3RhbnQuCgpPbiBHRlg5LCBhZGRybGli
IGluIE1lc2EgdXNlcyBtb3N0IGZpZWxkcyBmcm9tIEdCX0FERFJfQ09ORklHLgpHQl9BRERSX0NP
TkZJRyBkZWZpbmVzIHRoZSB0aWxpbmcgZm9ybWF0cy4KCk9uIG9sZGVyIGNoaXBzLCBhZGRybGli
IHJlYWRzIHNvbWUgZmllbGRzIGZyb20gR0JfQUREUl9DT05GSUcgYW5kIHVzZXMKdGhlIGNoaXAg
aWRlbnRpZmljYXRpb24gZm9yIG90aGVycyBsaWtlIHRoZSBudW1iZXIgb2YgcGlwZXMsIGV2ZW4K
dGhvdWdoIEdCX0FERFJfQ09ORklHIGhhcyB0aGUgaW5mb3JtYXRpb24gdG9vLgoKTWFyZWsKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

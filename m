From: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] amdgpu: get maximum and used UVD handles
Date: Wed, 14 Dec 2016 19:55:14 +0000
Message-ID: <CACvgo5316rSUKBdymKBZ+7Jaqw2scbDTA3bG9yUhGZRO9piUhA@mail.gmail.com>
References: <1481568690-3718-1-git-send-email-arindam.nath@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1481568690-3718-1-git-send-email-arindam.nath-5C7GfCeVMHo@public.gmane.org>
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
To: Arindam Nath <arindam.nath-5C7GfCeVMHo@public.gmane.org>
Cc: David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, ML dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

T24gMTIgRGVjZW1iZXIgMjAxNiBhdCAxODo1MSwgIDxhcmluZGFtLm5hdGhAYW1kLmNvbT4gd3Jv
dGU6Cj4gRnJvbTogQXJpbmRhbSBOYXRoIDxhcmluZGFtLm5hdGhAYW1kLmNvbT4KPgo+IFVzZXIg
bWlnaHQgd2FudCB0byBxdWVyeSB0aGUgbWF4aW11bSBudW1iZXIgb2YgVVZECj4gaW5zdGFuY2Vz
IHN1cHBvcnRlZCBieSBmaXJtd2FyZS4gSW4gYWRkaXRpb24gdG8gdGhhdCwKPiBpZiB0aGVyZSBh
cmUgbXVsdGlwbGUgYXBwbGljYXRpb25zIHVzaW5nIFVWRCBoYW5kbGVzCj4gYXQgdGhlIHNhbWUg
dGltZSwgaGUgbWlnaHQgYWxzbyB3YW50IHRvIHF1ZXJ5IHRoZQo+IGN1cnJlbnRseSB1c2VkIG51
bWJlciBvZiBoYW5kbGVzLgo+Cj4gRm9yIHRoaXMgd2UgYWRkIGEgbmV3IHF1ZXJ5IEFNREdQVV9J
TkZPX05VTV9IQU5ETEVTCj4gYW5kIGEgbmV3IHN0cnVjdCBkcm1fYW1kZ3B1X2luZm9fbnVtX2hh
bmRsZXMgdG8KPiBnZXQgdGhlc2UgdmFsdWVzLgo+Cj4gU2lnbmVkLW9mZi1ieTogQXJpbmRhbSBO
YXRoIDxhcmluZGFtLm5hdGhAYW1kLmNvbT4KPiBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5p
ZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IC0tLQo+ICBpbmNsdWRlL2RybS9hbWRncHVf
ZHJtLmggfCA5ICsrKysrKysrKwo+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspCj4K
Rm9sbG93IHRoZSBkb2N1bWVudGVkIHdheSB0byB1cGRhdGUgdGhlIGxpYmRybSBoZWFkZXJzIFsx
XS4KWW91IHdpbGwgd2FudCB0byB0YWNrbGUgdGhpcyBbMl0gc21hbGwgdGFzayBmaXJzdC4KCklm
IHRoZSBkb2N1bWVudGF0aW9uIGlzIHVuY2xlYXIgYW5kL29yIGNhbiBiZSBpbXByb3ZlZCBmZWVs
IGZyZWUgdG8Kc2VuZCBhIHBhdGNoLgoKVGhhbmtzCkVtaWwKClsxXSBodHRwczovL2NnaXQuZnJl
ZWRlc2t0b3Aub3JnL21lc2EvZHJtL3RyZWUvaW5jbHVkZS9kcm0vUkVBRE1FI242OApbMl0gaHR0
cHM6Ly9jZ2l0LmZyZWVkZXNrdG9wLm9yZy9tZXNhL2RybS90cmVlL2luY2x1ZGUvZHJtL1JFQURN
RSNuOTcKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

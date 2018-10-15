From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH v5 2/4] drm: Add vrr_enabled property to drm CRTC
Date: Mon, 15 Oct 2018 11:40:48 +0200
Message-ID: <9811fdab-3efe-4701-92e1-0f53b323959d@daenzer.net>
References: <20181012164458.12864-1-nicholas.kazlauskas@amd.com>
 <20181012164458.12864-3-nicholas.kazlauskas@amd.com>
 <e1feafbe-2c37-d1ff-8a45-4672b4da1264@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <e1feafbe-2c37-d1ff-8a45-4672b4da1264-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: christian.koenig-5C7GfCeVMHo@public.gmane.org, Nicholas Kazlauskas <nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org>
Cc: daniel.vetter-/w4YWyX8dFk@public.gmane.org, Marek.Olsak-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, manasi.d.navare-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alexander.Deucher-5C7GfCeVMHo@public.gmane.org

T24gMjAxOC0xMC0xMyA3OjM4IHAubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMTIu
MTAuMjAxOCB1bSAxODo0NCBzY2hyaWViIE5pY2hvbGFzIEthemxhdXNrYXM6Cj4+IFRoaXMgcGF0
Y2ggaW50cm9kdWNlcyB0aGUgJ3Zycl9lbmFibGVkJyBDUlRDIHByb3BlcnR5IHRvIGFsbG93Cj4+
IGR5bmFtaWMgY29udHJvbCBvdmVyIHZhcmlhYmxlIHJlZnJlc2ggcmF0ZSBzdXBwb3J0IGZvciBh
IENSVEMuCj4+Cj4+IFRoaXMgcHJvcGVydHkgc2hvdWxkIGJlIHRyZWF0ZWQgbGlrZSBhIGNvbnRl
bnQgaGludCB0byB0aGUgZHJpdmVyIC0KPj4gaWYgdGhlIGhhcmR3YXJlIG9yIGRyaXZlciBpcyBu
b3QgY2FwYWJsZSBvZiBkcml2aW5nIHZhcmlhYmxlIHJlZnJlc2gKPj4gdGltaW5ncyB0aGVuIHRo
aXMgaXMgbm90IGNvbnNpZGVyZWQgYW4gZXJyb3IuCj4+Cj4+IENhcGFiaWxpdHkgZm9yIHZhcmlh
YmxlIHJlZnJlc2ggcmF0ZSBzdXBwb3J0IHNob3VsZCBiZSBkZXRlcm1pbmVkCj4+IGJ5IHF1ZXJ5
aW5nIHRoZSB2cnJfY2FwYWJsZSBkcm0gY29ubmVjdG9yIHByb3BlcnR5Lgo+Pgo+PiBJdCBpcyB3
b3J0aCBub3RpbmcgdGhhdCB3aGlsZSB0aGUgcHJvcGVydHkgaXMgaW50ZW5kZWQgZm9yIGF0b21p
YyB1c2UKPj4gaXQgaXNuJ3QgZmlsdGVyZWQgZnJvbSBsZWdhY3kgdXNlcnNwYWNlIHF1ZXJpZXMu
IFRoaXMgYWxsb3dzIGZvciBYb3JnCj4+IHVzZXJzcGFjZSBkcml2ZXJzIHRvIGltcGxlbWVudCBz
dXBwb3J0Lgo+IAo+IEknbSBob25lc3RseSBzdGlsbCBub3QgY29udmluY2VkIHRoYXQgYSBwZXIg
Q1JUQyBwcm9wZXJ0eSBpcyBhY3R1YWxseQo+IHRoZSByaWdodCBhcHByb2FjaC4KPiAKPiBXaGF0
IHdlIHNob3VsZCByYXRoZXIgZG8gaW5zdGVhZCBpcyB0byBpbXBsZW1lbnQgYSB0YXJnZXQgdGlt
ZXN0YW1wIGZvcgo+IHRoZSBwYWdlIGZsaXAuCgpZb3UnZCBoYXZlIHRvIGJlIG1vcmUgc3BlY2lm
aWMgYWJvdXQgaG93IHRoZSBsYXR0ZXIgY291bGQgY29tcGxldGVseQpyZXBsYWNlIHRoZSBmb3Jt
ZXIuIEkgZG9uJ3Qgc2VlIGhvdyBpdCBjb3VsZC4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6Ru
emVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpMaWJy
ZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQg
WCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

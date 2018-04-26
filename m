From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/sriov: reject kms open if TDR not finished or
 failed
Date: Thu, 26 Apr 2018 11:01:00 +0200
Message-ID: <9d56b1c3-1e51-f3f1-17d6-c1615dea0a05@daenzer.net>
References: <1524638384-31977-1-git-send-email-Emily.Deng@amd.com>
 <5bede6f6-24b2-8a3a-d3d8-9a37ac6d13c8@daenzer.net>
 <CY4PR12MB11254FFDBB4FCCF91CBDE9758F8E0@CY4PR12MB1125.namprd12.prod.outlook.com>
 <e7756d73-aa65-b351-2b1a-81ceea1e013f@daenzer.net>
 <CY4PR12MB112547536CD27B7FE2C330F38F8E0@CY4PR12MB1125.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB112547536CD27B7FE2C330F38F8E0-rpdhrqHFk07v2MZdTKcfDgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deng, Emily" <Emily.Deng-5C7GfCeVMHo@public.gmane.org>, "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxOC0wNC0yNiAwOTo1NyBBTSwgRGVuZywgRW1pbHkgd3JvdGU6Cj4+Pj4gVGhpcyBzZWVt
cyBsaWtlIGEgYmFkIGlkZWEsIGFzIGl0IHdvdWxkIGNhdXNlIGJhc2ljYWxseSBhbnkKPj4+PiB1
c2Vyc3BhY2Ugd2hpY2ggd2FudHMgdG8gdXNlIHRoZSBHUFUgdG8gZmFpbCB0byBzdGFydCBkdXJp
bmcgYQo+Pj4+IEdQVSByZXNldC4KPj4+IFtFbWlseV0gWWVzLCB0aGlzIGlzIHdoYXQgdGhlIGNo
YW5nZSB3YW50IHRvIGRvLCB3aGVuIGRyaXZlciBpcwo+Pj4gZG9pbmcgZ3B1IHJlY292ZXIgb3Ig
aGFyZHdhcmUgaXMgZG9pbmcgcmVzZXQsIGl0IGRvZXNuJ3Qgd2FudCB0bwo+Pj4gYmUgaW50ZXJy
dXB0ZWQsIGFuZCBkdXJpbmcgdGhlIHJlc2V0IGFueSBkcml2ZXIgb3BlbiBrbXMgaXMKPj4+IG1l
YW5pbmdsZXNzLgo+PiAKPj4gQXBwbGljYXRpb25zIHJhbmRvbWx5IGZhaWxpbmcgdG8gc3RhcnQg
dXAgZHVyaW5nIGEgR1BVIHJlc2V0IHdvdWxkCj4+IGJlIHN1cnByaXNpbmcgYW5kIGNvbmZ1c2lu
ZyBmb3IgdGhlIHVzZXIuIFRoZSBkcml2ZXIgbmVlZHMgdG8KPj4gaGFuZGxlIHRoaXMgdHJhbnNw
YXJlbnRseS4KPiBbRW1pbHldIFllcywgeW91IGFyZSByaWdodCwgaG93IGFib3V0IHRvIHNsZWVw
IGZvciBzb21lIHRpbWUgaW4gaGVyZQo+IHRvIHdhaXQgdGhlIEdQVSByZXNldCBzdWNjZXNzZnVs
bHkuIEFmdGVyIHNsZWVwLCBpZiBpdCBzdGlsbCBpbiBncHUKPiByZXNldCwgdGhlbiByZXR1cm4g
ZXJyb3IgdG8gQVBQPwoKSSB0aGluayB0aGUgb25seSBjYXNlIHdoZXJlIHJldHVybmluZyBhbiBl
cnJvciBoZXJlICptaWdodCogYmUKYXBwcm9wcmlhdGUgaXMgd2hlbiB0aGUgZHJpdmVyIGhhcyB0
cmllZCByZXNldHRpbmcgdGhlIEdQVSwgYnV0IGl0IGhhcwpkZWZpbml0ZWx5IGFuZCBpcnJlY292
ZXJhYmx5IGZhaWxlZC4gQnV0IGV2ZW4gaW4gdGhhdCBjYXNlLCBpdCBtaWdodCBiZQpiZXR0ZXIg
dG8gbGV0IHRoZSBvcGVuIHN1Y2NlZWQsIGFuZCBsZXQgdXNlcnNwYWNlIGZpZ3VyZSBvdXQgd2hh
dApoYXBwZW5lZCBieSBvdGhlciBtZWFucy4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVy
ICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBz
b2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBk
ZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

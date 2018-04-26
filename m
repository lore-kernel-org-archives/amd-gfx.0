From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/sriov: reject kms open if TDR not finished or
 failed
Date: Thu, 26 Apr 2018 09:33:24 +0200
Message-ID: <e7756d73-aa65-b351-2b1a-81ceea1e013f@daenzer.net>
References: <1524638384-31977-1-git-send-email-Emily.Deng@amd.com>
 <5bede6f6-24b2-8a3a-d3d8-9a37ac6d13c8@daenzer.net>
 <CY4PR12MB11254FFDBB4FCCF91CBDE9758F8E0@CY4PR12MB1125.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB11254FFDBB4FCCF91CBDE9758F8E0-rpdhrqHFk07v2MZdTKcfDgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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

T24gMjAxOC0wNC0yNiAwNDowMyBBTSwgRGVuZywgRW1pbHkgd3JvdGU6Cj4gSGkgTWljaGVsLAo+
PiBUaGlzIHNlZW1zIGxpa2UgYSBiYWQgaWRlYSwgYXMgaXQgd291bGQgY2F1c2UgYmFzaWNhbGx5
IGFueQo+PiB1c2Vyc3BhY2Ugd2hpY2ggd2FudHMgdG8gdXNlIHRoZSBHUFUgdG8gZmFpbCB0byBz
dGFydCBkdXJpbmcgYSBHUFUKPj4gcmVzZXQuCj4gW0VtaWx5XSBZZXMsIHRoaXMgaXMgd2hhdCB0
aGUgY2hhbmdlIHdhbnQgdG8gZG8sIHdoZW4gZHJpdmVyIGlzIGRvaW5nCj4gZ3B1IHJlY292ZXIg
b3IgaGFyZHdhcmUgaXMgZG9pbmcgcmVzZXQsIGl0IGRvZXNuJ3Qgd2FudCB0byBiZQo+IGludGVy
cnVwdGVkLCBhbmQgZHVyaW5nIHRoZSByZXNldCBhbnkgZHJpdmVyIG9wZW4ga21zIGlzIG1lYW5p
bmdsZXNzLgoKQXBwbGljYXRpb25zIHJhbmRvbWx5IGZhaWxpbmcgdG8gc3RhcnQgdXAgZHVyaW5n
IGEgR1BVIHJlc2V0IHdvdWxkIGJlCnN1cnByaXNpbmcgYW5kIGNvbmZ1c2luZyBmb3IgdGhlIHVz
ZXIuIFRoZSBkcml2ZXIgbmVlZHMgdG8gaGFuZGxlIHRoaXMKdHJhbnNwYXJlbnRseS4KCgotLSAK
RWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0
dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwg
ICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==

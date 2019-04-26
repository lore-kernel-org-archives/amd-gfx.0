From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: support gpu recovery tests on compute rings
Date: Fri, 26 Apr 2019 10:35:24 +0200
Message-ID: <cd13fa95-1a65-1c0f-01d4-0f8819da5a60@daenzer.net>
References: <20190426072414.21184-1-evan.quan@amd.com>
 <f9efc27c-6e0c-6a6b-e760-cba349adc63a@gmail.com>
 <MN2PR12MB334425F855709F0662BB8952E43E0@MN2PR12MB3344.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MN2PR12MB334425F855709F0662BB8952E43E0-rweVpJHSKToDMgCC8P//OwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "Xu, Feifei" <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>, "Cui, Flora" <Flora.Cui-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxOS0wNC0yNiAxMDoyMCBhLm0uLCBRdWFuLCBFdmFuIHdyb3RlOgo+IE15IGNvbmNlcm4g
aXMgdGhlcmUgaXMgYWxyZWFkeSBvbmUgbW9kdWxlIHBhcmFtZXRlciAibG9ja3VwX3RpbWVvdXQi
Lgo+IHBhcm06ICAgICAgICAgICBsb2NrdXBfdGltZW91dDpHUFUgbG9ja3VwIHRpbWVvdXQgaW4g
bXMgPiAwIChkZWZhdWx0IDEwMDAwKSAoaW50KQo+IAo+IEFkZGluZyBvbmUgbW9yZSAidGltZW91
dCIgc2VlbXMgcmVkdW5kYW50LiAKPiBBbmQgdGhhdCB3aWxsIG1ha2VzIHRoZSBkZXNjcmlwdGlv
biBvZiAibG9ja3VwX3RpbWVvdXQiKHNlZW1zIHdvcmtpbmcgZm9yIGFsbCBqb2JzKSBkb2VzIG5v
dCBtYXRjaCBpdHMgcmVhbCBlZmZlY3QoYWZmZWN0IG9ubHkgbm9uLWNvbXB1dGUgam9icykuCj4g
Cj4gQSBiZXR0ZXIgd2F5IGlzIHRvIHJlbmFtZSAibG9ja3VwX3RpbWVvdXQiIHRvICJub24tY29t
cHV0ZSBsb2NrdXBfdGltZW91dCIuIEJ1dCBJIGRvIG5vdCB0aGluayB3ZSBjYW4gY2hhbmdlIGV4
aXN0aW5nIG1vZHVsZSBwYXJhbWV0ZXIuIFJpZ2h0PwoKUmlnaHQuIEFsc28sIHRoZXJlIGFyZSBh
bHJlYWR5IHRvbyBtYW55IGFtZGdwdSBtb2R1bGUgcGFyYW1ldGVycywgd2UKc2hvdWxkIHRyeSB0
byByZW1vdmUgc29tZSByYXRoZXIgdGhhbiBhZGRpbmcgbmV3IG9uZXMgZm9yIGV2ZXJ5IGxpdHRs
ZQp0aGluZyB0aGF0IGNvdWxkIGJlIHR3ZWFrZWQuIDopCgpPbmUgcG9zc2liaWxpdHkgbWlnaHQg
YmUgdG8gb3B0aW9uYWxseSBhbGxvdyBwYXNzaW5nIG11bHRpcGxlIHZhbHVlcyB0bwpsb2NrdXBf
dGltZW91dCwgZS5nLgoKIGFtZGdwdS5sb2NrdXBfdGltZW91dD0xMDAwMCwwCgpUaGUgZmlyc3Qg
dmFsdWUgd291bGQgbmVlZCB0byBoYXZlIHRoZSBzYW1lIG1lYW5pbmcgYXMgbm93IGZvciBiYWNr
d2FyZHMKY29tcGF0aWJpbGl0eS4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAg
ICAgICAgICAgfCAgICAgICAgICAgICAgaHR0cHM6Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2Fy
ZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9w
ZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

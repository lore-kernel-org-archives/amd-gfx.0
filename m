From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH libdrm 1/2] tests/amdgpu: fix for dispatch/draw test
Date: Fri, 19 Jul 2019 10:40:53 +0200
Message-ID: <88a6d12c-a5b7-a4b6-b3c4-357ea0efa166@daenzer.net>
References: <1563437433-4157-1-git-send-email-flora.cui@amd.com>
 <1c9de651-bbb2-6802-e729-182cab5ca427@gmail.com>
 <febeaec7-db65-e18d-d073-d7e19f972edb@amd.com>
 <39c1c37e-89d8-bb00-2cc6-aa048aed77c8@daenzer.net>
 <0a3b4a91-b679-6de3-f02c-5f5a6dfcb82d@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <0a3b4a91-b679-6de3-f02c-5f5a6dfcb82d-5C7GfCeVMHo@public.gmane.org>
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
To: "Cui, Flora" <fcui-5C7GfCeVMHo@public.gmane.org>, "Cui, Flora" <Flora.Cui-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxOS0wNy0xOSAxMDozNCBhLm0uLCBDdWksIEZsb3JhIHdyb3RlOgo+IHRoZSBDaGFuZ2Ut
SWQgdGFncyBhcmUgYWRkZWQgYXV0b21hdGljYWxseS4gZG8geW91IGtub3cgaG93IHRvIGdldCBy
aWQgb2YgaXQ/CgpUaGV5J3JlIG9ubHkgbWFnaWMgdG8gR2Vycml0LCBub3QgdG8gR2l0IGl0c2Vs
Zi4gWW91IGNhbiByZW1vdmUgdGhlbQp3aXRoIGFueSBHaXQgY29tbWl0IGxvZyBlZGl0aW5nIHRv
b2wsIGUuZy4KCiBnaXQgY29tbWl0IC0tYW1lbmQKCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6Ru
emVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgaHR0cHM6Ly93d3cuYW1kLmNvbQpMaWJy
ZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQg
WCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

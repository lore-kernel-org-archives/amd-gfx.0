From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 09/12] drm/amdgpu/sriov:return -ENODEV if gpu reseted
Date: Tue, 10 Oct 2017 09:47:09 +0200
Message-ID: <0c91bb14-a874-9ee6-8756-2a31eb41d5b2@daenzer.net>
References: <1506751432-21789-1-git-send-email-Monk.Liu@amd.com>
 <1506751432-21789-10-git-send-email-Monk.Liu@amd.com>
 <6e81d8b0-267a-1ea8-b228-93286fc6a954@gmail.com>
 <BLUPR12MB0449531313F50BE080F7746D84740@BLUPR12MB0449.namprd12.prod.outlook.com>
 <71b411c8-21a6-fe9b-ed33-7928571a88da@gmail.com>
 <BLUPR12MB04492B28DF57EACE2149562D84750@BLUPR12MB0449.namprd12.prod.outlook.com>
 <85c67ae9-bfe2-390a-79d0-6e5872b9be62@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <85c67ae9-bfe2-390a-79d0-6e5872b9be62-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Nicolai_H=c3=a4hnle?= <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMTAvMTAvMTcgMDg6NTggQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQXMgTmljb2xh
aSBleHBsYWluZWQgdGhhdCBhcHByb2FjaCBzaW1wbHkgd29uJ3Qgd29yay4KPiAKPiBUaGUgZmQg
aXMgdXNlZCBieSBtb3JlIHRoYW4ganVzdCB0aGUgY2xvc2VkIHNvdXJjZSBWdWxrYW4gZHJpdmVy
IGFuZCBJCj4gdGhpbmsgZXZlbiBieSBzb21lIGNvbXBvbmVudHMgbm90IGRldmVsb3BlZCBieSBB
TUQgKGNvbW1vbiBYIGNvZGU/Cj4gTWljaGVsIHBsZWFzZSBjb21tZW50IGFzIHdlbGwpLgoKVGhl
IG9ubHkgdGhpbmcgdGhhdCBjb21lcyB0byBtaW5kIHBvc3NpYmx5IG1hdGNoaW5nIHlvdXIgZGVz
Y3JpcHRpb24gaXMKdGhlIGdlbmVyaWMgbW9kZXNldHRpbmcgWG9yZyBkcml2ZXIsIGJ1dCB0aGF0
IG9ubHkgY2FsbHMgS01TIEFQSSBpb2N0bHMuCkNvbW1hbmQgc3VibWlzc2lvbiBhbmQgbWVtb3J5
IG1hbmFnZW1lbnQgaW9jdGxzIHNob3VsZCBvbmx5IGJlIGNhbGxlZCBieQpoYXJkd2FyZSBzcGVj
aWZpYyB1c2Vyc3BhY2UgY29kZS4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAg
ICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2Fy
ZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9w
ZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

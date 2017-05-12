From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 1/1] amdgpu: move asic id table to a separate file
Date: Fri, 12 May 2017 09:49:51 +0900
Message-ID: <1bdcfa4a-6840-796e-1623-2949358a0364@daenzer.net>
References: <1494449815-10162-1-git-send-email-Samuel.Li@amd.com>
 <DM3PR1201MB10392013EC4407011C4F9B84F5EC0@DM3PR1201MB1039.namprd12.prod.outlook.com>
 <fcbc7ab9-f5f7-c529-9526-d78772c0d830@daenzer.net>
 <CY1PR1201MB1033C872BA2CF7916ED3A369F5ED0@CY1PR1201MB1033.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY1PR1201MB1033C872BA2CF7916ED3A369F5ED0-JBJ/M6OpXY+2VhmsawAdvGrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
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
To: "Li, Samuel" <Samuel.Li-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Yuan,
 Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>

T24gMTIvMDUvMTcgMDY6MTMgQU0sIExpLCBTYW11ZWwgd3JvdGU6Cj4gU3VibWl0dGVkIGEgcmVx
dWVzdCB0byBjcmVhdGUgYSBuZXcgcmVwbyBvbiBmcmVlZGVza3RvcC4KCldoYXQncyB0aGUgcG9p
bnQgb2YgaGF2aW5nIGEgc2VwYXJhdGUgcmVwb3NpdG9yeSB1cHN0cmVhbT8gQ2FuJ3Qgd2UganVz
dAprZWVwIGl0IGluIHRoZSBsaWJkcm0gcmVwb3NpdG9yeT8KCgotLSAKRWFydGhsaW5nIE1pY2hl
bCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNv
bQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVz
YSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==

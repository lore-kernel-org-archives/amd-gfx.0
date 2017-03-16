From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 0/4] [libdrm] support PRT and replace interface
Date: Thu, 16 Mar 2017 18:42:53 +0900
Message-ID: <f24666c5-ee24-7b72-1706-16da59260379@daenzer.net>
References: <1489636601-31486-1-git-send-email-Jerry.Zhang@amd.com>
 <2a70a1b2-dbe9-a3ee-99ea-2d0af4c3baf7@vodafone.de>
 <DM5PR12MB1818645A40DE984A08DD20B2FF260@DM5PR12MB1818.namprd12.prod.outlook.com>
 <84eaf027-5fb3-4fa8-c0fc-88281f7e61d7@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <84eaf027-5fb3-4fa8-c0fc-88281f7e61d7-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "Zhang, Jerry" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMTYvMDMvMTcgMDY6MjggUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMTYuMDMu
MjAxNyB1bSAxMDoxNCBzY2hyaWViIFpoYW5nLCBKZXJyeToKPj4KPj4gU28gSSBwcmVwYXJlIHRo
ZSBwYXRjaCAyIHRvIHVzZSB0aGUgaW5wdXQgZmxhZ3M6Cj4+ICAgICAgKiBbUEFUQ0ggMi80XSBh
bWRncHU6IHNldCB2YSBmbGFnIHdpdGggaW5wdXQgcGFyYW1ldGVyCj4gCj4gTmljb2xhaSBoYW5k
bGVkIGJvdGggaXNzdWVzIGJ5IGNyZWF0aW5nIGEgbmV3IGZ1bmN0aW9uIHdoZXJlIHRoZSBCTyBp
cwo+IG9wdGlvbmFsIGFuZCB0aGUgZmxhZ3MgdGFrZW4gaW50byBhY2NvdW50Lgo+IAo+IFBsZWFz
ZSB0YWtlIGEgbG9vayBhdCBoaXMgcGF0Y2hlcywgdGhleSBhcmUgb24gdGhlIG1haWxpbmcgbGlz
dC4KCk9yIG9uIFBhdGNod29yazoKCmh0dHBzOi8vcGF0Y2h3b3JrLmZyZWVkZXNrdG9wLm9yZy9w
cm9qZWN0L2FtZC14b3JnLWRkeC9wYXRjaGVzLz9zdWJtaXR0ZXI9MTU2NzMKCgpTcGVha2luZyBv
ZiBQYXRjaHdvcmssIGl0J3MgYWNjdW11bGF0aW5nIGEgbG90IG9mIHN0YWxlIHBhdGNoZXMuCkV2
ZXJ5Ym9keSBzdWJtaXR0aW5nIHBhdGNoZXMsIHBsZWFzZSBhdCBsZWFzdCBwZXJpb2RpY2FsbHkg
Z28gdGhyb3VnaAp5b3VyIHBhdGNoZXMgYW5kIGNoYW5nZSB0aGVpciBzdGF0ZSBhcyBhcHByb3By
aWF0ZS4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAg
ICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAg
ICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

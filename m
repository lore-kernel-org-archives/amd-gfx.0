From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [V3 04/11] drm/amdgpu/virt: use kiq to access registers
Date: Thu, 12 Jan 2017 14:45:27 +0900
Message-ID: <65f6eb07-f350-bd46-d8c8-df6cb9387efa@daenzer.net>
References: <1484140698-10548-1-git-send-email-Xiangliang.Yu@amd.com>
 <1484140698-10548-5-git-send-email-Xiangliang.Yu@amd.com>
 <c6c7dbf9-03db-2528-78cd-b1390dcab10d@vodafone.de>
 <BY2PR1201MB11104C83B83FB2CEA6B26A2884660@BY2PR1201MB1110.namprd12.prod.outlook.com>
 <d4e006ef-a0a2-bbc3-3582-d259d1e6a75b@vodafone.de>
 <BY2PR1201MB11107C560860494991E6D6F884660@BY2PR1201MB1110.namprd12.prod.outlook.com>
 <f79c252c-369b-235e-2160-231b4ac32235@vodafone.de>
 <BY2PR1201MB11106D68693C869D3E7D431884660@BY2PR1201MB1110.namprd12.prod.outlook.com>
 <BY2PR1201MB11108F4CBFB28D71407DE56184790@BY2PR1201MB1110.namprd12.prod.outlook.com>
 <BY2PR1201MB11102241041CA3C7C37D25D984790@BY2PR1201MB1110.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BY2PR1201MB11102241041CA3C7C37D25D984790-O28G1zQ8oGliQkyLPkmea2rFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
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
To: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "Yu, Xiangliang" <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMTIvMDEvMTcgMTI6MjEgUE0sIExpdSwgTW9uayB3cm90ZToKPiAKPiAgICBpZiAoaW5faW50
ZXJydXB0KCkpCj4gICAgICAgICBCVUcoKTsKCkN1cnJlbnQgY29kaW5nIHN0eWxlIGlzCgogICAg
QlVHX09OKGluX2ludGVycnVwdCgpKTsKCmFjY29yZGluZyB0byBodHRwczovL2tlcm5lbG5ld2Jp
ZXMub3JnL0ZBUS9CVUcgLgoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAg
ICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVu
dGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3Blcgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK

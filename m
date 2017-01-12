From: "Yu, Xiangliang" <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [V3 04/11] drm/amdgpu/virt: use kiq to access registers
Date: Thu, 12 Jan 2017 05:51:44 +0000
Message-ID: <CY4PR12MB1701ED4143B237E128C27854EB790@CY4PR12MB1701.namprd12.prod.outlook.com>
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
 <65f6eb07-f350-bd46-d8c8-df6cb9387efa@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <65f6eb07-f350-bd46-d8c8-df6cb9387efa-otUistvHUpPR7s880joybQ@public.gmane.org>
Content-Language: en-US
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
To: =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaWNoZWwgRMOkbnplciBbbWFp
bHRvOm1pY2hlbEBkYWVuemVyLm5ldF0NCj4gU2VudDogVGh1cnNkYXksIEphbnVhcnkgMTIsIDIw
MTcgMTo0NSBQTQ0KPiBUbzogTGl1LCBNb25rIDxNb25rLkxpdUBhbWQuY29tPjsgQ2hyaXN0aWFu
IEvDtm5pZw0KPiA8ZGVhdGhzaW1wbGVAdm9kYWZvbmUuZGU+OyBZdSwgWGlhbmdsaWFuZyA8WGlh
bmdsaWFuZy5ZdUBhbWQuY29tPg0KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcN
Cj4gU3ViamVjdDogUmU6IFtWMyAwNC8xMV0gZHJtL2FtZGdwdS92aXJ0OiB1c2Uga2lxIHRvIGFj
Y2VzcyByZWdpc3RlcnMNCj4gDQo+IE9uIDEyLzAxLzE3IDEyOjIxIFBNLCBMaXUsIE1vbmsgd3Jv
dGU6DQo+ID4NCj4gPiAgICBpZiAoaW5faW50ZXJydXB0KCkpDQo+ID4gICAgICAgICBCVUcoKTsN
Cj4gDQo+IEN1cnJlbnQgY29kaW5nIHN0eWxlIGlzDQo+IA0KPiAgICAgQlVHX09OKGluX2ludGVy
cnVwdCgpKTsNCj4gDQo+IGFjY29yZGluZyB0byBodHRwczovL2tlcm5lbG5ld2JpZXMub3JnL0ZB
US9CVUcgLg0KDQpHb3QgaXQuIFRoYW5rcyENCg0KPiANCj4gDQo+IC0tDQo+IEVhcnRobGluZyBN
aWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICBodHRwOi8vd3d3LmFt
ZC5jb20NCj4gTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAg
ICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK

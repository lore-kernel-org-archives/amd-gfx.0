From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: fix gpu reset crash
Date: Tue, 25 Apr 2017 13:34:41 +0000
Message-ID: <BN6PR12MB1652CAFE2B4D576733D2EBA3F71E0@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <1493026850-29604-1-git-send-email-David1.Zhou@amd.com>
 <a43a71f9-b8b1-4ff3-3532-d13bdd539761@vodafone.de> <58FEB257.2010002@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <58FEB257.2010002-5C7GfCeVMHo@public.gmane.org>
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
To: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBhbWQtZ2Z4IFttYWlsdG86YW1k
LWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZ10gT24gQmVoYWxmDQo+IE9mIHpob3Vj
bTENCj4gU2VudDogTW9uZGF5LCBBcHJpbCAyNCwgMjAxNyAxMDoyMCBQTQ0KPiBUbzogQ2hyaXN0
aWFuIEvDtm5pZzsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gU3ViamVjdDogUmU6
IFtQQVRDSCAxLzJdIGRybS9hbWRncHU6IGZpeCBncHUgcmVzZXQgY3Jhc2gNCj4gDQo+IA0KPiAN
Cj4gT24gMjAxN+W5tDA05pyIMjTml6UgMTc6NDcsIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6DQo+
ID4+IFRoZSByb290IGNhdXNlIGlzIHNvbWUgcmluZyBkb2Vzbid0IGhhdmUgc2NoZWR1bGVyLCBs
aWtlIEtJUSByaW5nDQo+ID4+DQo+ID4+IENoYW5nZS1JZDogSTQyMGU4NGFkZDljZGQ5YTdmZDFm
OTkyMWI4YTVkMGFmYTNkZDIwNTgNCj4gPj4gU2lnbmVkLW9mZi1ieTogQ2h1bm1pbmcgWmhvdSA8
RGF2aWQxLlpob3VAYW1kLmNvbT4NCj4gPg0KPiA+IFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2
bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+IGZvciBib3RoLg0KPiBJIGZvcmdvdCB0byBh
ZGQgUkIgd2hlbiBwdXNoaW5nIHBhdGNoZXMsIEhvdyBjYW4gSSBhZGQgaXQgYWdhaW4/DQoNCkkn
bGwgYWRkIGl0IGJlZm9yZSBzZW5kaW5nIHVwc3RyZWFtLg0KDQpBbGV4DQoNCj4gDQo+IFNvcnJ5
IGZvciB0aGF0Lg0KPiBEYXZpZCBaaG91DQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fDQo+IGFtZC1nZnggbWFpbGluZyBsaXN0DQo+IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnDQo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==

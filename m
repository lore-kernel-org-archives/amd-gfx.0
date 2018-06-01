From: "Li, Samuel" <Samuel.Li-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amdgpu: add kernel DOC for ioctls in amdgpu_cs.c file
Date: Fri, 1 Jun 2018 21:16:19 +0000
Message-ID: <BY1PR12MB050430EF8ED0DF8E6465D997F5620@BY1PR12MB0504.namprd12.prod.outlook.com>
References: <20180530184251.6314-1-leo.liu@amd.com>
 <4df023fd-bac7-8369-43d7-db329ecb980a@daenzer.net>
 <4d5dac06-d400-af89-f224-9b5920407460@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <4d5dac06-d400-af89-f224-9b5920407460-5C7GfCeVMHo@public.gmane.org>
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
To: "Li, Samuel" <Samuel.Li-5C7GfCeVMHo@public.gmane.org>, =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "Liu, Leo" <Leo.Liu-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

SSBjYW4gc2VlIHRoZW0gbm93Lg0KDQpTYW0NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiBGcm9tOiBhbWQtZ2Z4IFttYWlsdG86YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNr
dG9wLm9yZ10gT24gQmVoYWxmDQo+IE9mIFNhbXVlbCBMaQ0KPiBTZW50OiBGcmlkYXksIEp1bmUg
MDEsIDIwMTggNToxMCBQTQ0KPiBUbzogTWljaGVsIETDpG56ZXIgPG1pY2hlbEBkYWVuemVyLm5l
dD47IExpdSwgTGVvIDxMZW8uTGl1QGFtZC5jb20+DQo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBhZGQga2VybmVs
IERPQyBmb3IgaW9jdGxzIGluIGFtZGdwdV9jcy5jDQo+IGZpbGUNCj4gDQo+IA0KPiANCj4gT24g
MjAxOC0wNS0zMSAxMjozMCBQTSwgTWljaGVsIETDpG56ZXIgd3JvdGU6DQo+ID4gT24gMjAxOC0w
NS0zMCAwODo0MiBQTSwgTGVvIExpdSB3cm90ZToNCj4gPj4gVGhlcmUgYXJlIGZvdXIgaW9jdGxz
IGluIHRoaXMgZmlsZXMsIGFuZCBET0MgZ2l2ZXMgZGV0YWlscyBvZiBkYXRhDQo+ID4+IHN0cnVj
dHVyZXMgZm9yIGVhY2ggb2YgaW9jdGxzLCBhbmQgdGhlaXIgZnVuY3Rpb25hbGl0aWVzLg0KPiA+
Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBMZW8gTGl1IDxsZW8ubGl1QGFtZC5jb20+DQo+ID4NCj4g
PiBUaGlzIGlzbid0IGVub3VnaCB0byBhY3R1YWxseSBtYWtlIHRoaXMgcGFydCBvZiB0aGUgZ2Vu
ZXJhdGVkDQo+ID4gZG9jdW1lbnRhdGlvbi4gSXQgbmVlZHMgdG8gYmUgaG9va2VkIHVwIHRvIGEg
Ki5yc3QgZmlsZSBmb3IgdGhhdC4NCj4gPg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==

From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 2/2] drm/amd/amdgpu: decrease ttm bo priority number
Date: Tue, 28 Mar 2017 14:47:28 +0000
Message-ID: <BN6PR12MB1652EBCE3CB98AB2A7D7BF96F7320@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <1490665930-19814-1-git-send-email-Hongbo.He@amd.com>
 <1490665930-19814-2-git-send-email-Hongbo.He@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1490665930-19814-2-git-send-email-Hongbo.He-5C7GfCeVMHo@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "He, Hongbo" <Hongbo.He-5C7GfCeVMHo@public.gmane.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSb2dlci5IZSBbbWFpbHRvOkhv
bmdiby5IZUBhbWQuY29tXQ0KPiBTZW50OiBNb25kYXksIE1hcmNoIDI3LCAyMDE3IDk6NTIgUE0N
Cj4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBEZXVjaGVyLCBBbGV4
YW5kZXI7IEhlLCBIb25nYm8NCj4gU3ViamVjdDogW1BBVENIIDIvMl0gZHJtL2FtZC9hbWRncHU6
IGRlY3JlYXNlIHR0bSBibyBwcmlvcml0eSBudW1iZXINCg0KUGF0Y2ggdGl0bGUgc2hvdWxkIGJl
Og0KZHJtL3R0bTogZGVjcmVhc2UgdHRtIGJvIHByaW9yaXR5IG51bWJlcg0KV2l0aCB0aGF0IGZp
eGVkOg0KUmV2aWV3ZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNv
bT4NCg0KPiANCj4gZGVjcmVhc2UgYW5kIGFsc28gcmVzZXJ2ZSBwcmlvcml0eSBudW1iZXIgZm9y
IEtGRCB1c2luZw0KPiANCj4gQ2hhbmdlLUlkOiBJOWUzNmQyOTJjOTIwYzAzNGRkY2E1M2QwZWMy
ODJjMTdiN2EzY2YxNg0KPiBTaWduZWQtb2ZmLWJ5OiBSb2dlci5IZSA8SG9uZ2JvLkhlQGFtZC5j
b20+DQo+IFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+DQo+IC0tLQ0KPiAgaW5jbHVkZS9kcm0vdHRtL3R0bV9ib19kcml2ZXIuaCB8IDIgKy0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHJtL3R0bS90dG1fYm9fZHJpdmVyLmgNCj4gYi9pbmNsdWRl
L2RybS90dG0vdHRtX2JvX2RyaXZlci5oDQo+IGluZGV4IGMzZDc0YmUuLjc3NzdkMTQgMTAwNjQ0
DQo+IC0tLSBhL2luY2x1ZGUvZHJtL3R0bS90dG1fYm9fZHJpdmVyLmgNCj4gKysrIGIvaW5jbHVk
ZS9kcm0vdHRtL3R0bV9ib19kcml2ZXIuaA0KPiBAQCAtNDIsNyArNDIsNyBAQA0KPiAgI2luY2x1
ZGUgPGxpbnV4L3NwaW5sb2NrLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvcmVzZXJ2YXRpb24uaD4N
Cj4gDQo+IC0jZGVmaW5lIFRUTV9NQVhfQk9fUFJJT1JJVFkJMTZVDQo+ICsjZGVmaW5lIFRUTV9N
QVhfQk9fUFJJT1JJVFkJNFUNCj4gDQo+ICBzdHJ1Y3QgdHRtX2JhY2tlbmRfZnVuYyB7DQo+ICAJ
LyoqDQo+IC0tDQo+IDIuNy40DQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=

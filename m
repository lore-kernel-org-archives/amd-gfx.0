From: "Yang, Philip" <Philip.Yang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: KASAN caught amdgpu / HMM use-after-free
Date: Thu, 28 Feb 2019 15:29:16 +0000
Message-ID: <0e34dd07-8246-d159-aedc-ba0f5aa27b46@amd.com>
References: <e8466985-a66b-468b-5fff-6e743180da67@daenzer.net>
 <83fde7eb-abab-e770-efd5-89bc9c39fdff@amd.com>
 <c26fa310-38d1-acba-cf82-bc6dc2f782c0@daenzer.net>
 <35d7e134-6eef-9732-8ebf-83256e40eb65@amd.com>
 <BN6PR12MB18090BDFE1DD800785C5ED76F7740@BN6PR12MB1809.namprd12.prod.outlook.com>
 <b81bd33a-0041-392e-2c85-19036fc1c91d@amd.com>
 <f26e40c8-d981-03ca-839a-6f2340a29b97@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <f26e40c8-d981-03ca-839a-6f2340a29b97-otUistvHUpPR7s880joybQ@public.gmane.org>
Content-Language: en-US
Content-ID: <CA718AF658957641AC2B7CFBABBBD651-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

SGkgQWxleCwNCg0KTWF5IHlvdSBoZWxwIHRha2UgYSBsb29rPyBJdCBpcyBub3QgbWVyZ2VkIGlu
dG8gYW1kLXN0YWdpbmctZHJtLW5leHQgDQp5ZXQsIG1heWJlIG1pc3NpbmcgY29kZS1yZXZpZXcr
MiwgaXQgd2FzIGRvbmUgYXV0b21hdGljYWxseSBhZnRlciBjb2RlIA0KcmV2aWV3IGZvciBvdGhl
ciBwYXRjaC4NCg0KaHR0cDovL2dpdC5hbWQuY29tOjgwODAvYy9icmFobWEvZWMvbGludXgvKy8y
MDY3MTENCg0KUmVnYXJkcywNClBoaWxpcA0KDQpPbiAyMDE5LTAyLTI4IDY6NTEgYS5tLiwgTWlj
aGVsIETDpG56ZXIgd3JvdGU6DQo+IA0KPiBbIERyb3BwaW5nIErDqXLDtG1lIGFuZCB0aGUgbGlu
dXgtbW0gbGlzdCBdDQo+IA0KPiBPbiAyMDE5LTAyLTI3IDc6NDggcC5tLiwgWWFuZywgUGhpbGlw
IHdyb3RlOg0KPj4gSGkgQWxleCwNCj4+DQo+PiBQdXNoZWQsIHRoYW5rcy4NCj4+DQo+PiBtbS9o
bW06IHVzZSByZWZlcmVuY2UgY291bnRpbmcgZm9yIEhNTSBzdHJ1Y3QNCj4gDQo+IFRoYW5rcywg
YnV0IEknbSBub3Qgc2VlaW5nIGl0IHlldC4gTWF5YmUgaXQgbmVlZHMgc29tZSBzcGVjaWFsDQo+
IHRyZWF0bWVudCwgYmVjYXVzZSBpdCdzIG5vdCBhIERSTSBjb2RlIGNoYW5nZT8NCj4gDQo+IA0K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

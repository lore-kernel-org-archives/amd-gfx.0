From: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: kernel BUG at drivers/gpu/drm//ttm/ttm_bo.c:196!
Date: Tue, 12 Mar 2019 14:26:20 +0000
Message-ID: <623293e4-9643-ccde-00fc-b22282510f45@amd.com>
References: <b1448d56-5dc4-d3f4-db04-e7993533240b@daenzer.net>
 <95cef707-4d19-cbd4-c913-523f4b22c89a@gmail.com>
 <b5a55494-356d-31a3-fe5a-491d337f6a66@daenzer.net>
 <29737644-875c-20f5-b44d-3a4ca4f70b33@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <29737644-875c-20f5-b44d-3a4ca4f70b33-otUistvHUpPR7s880joybQ@public.gmane.org>
Content-Language: en-US
Content-ID: <4B714A5FBD6B9E488DB2112F502E1653-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMTIuMDMuMTkgdW0gMTQ6NDcgc2NocmllYiBNaWNoZWwgRMOkbnplcjoNCj4gT24gMjAxOS0w
Mi0wNSA2OjQwIHAubS4sIE1pY2hlbCBEw6RuemVyIHdyb3RlOg0KPj4gRldJVywgSSd2ZSBoaXQg
dGhpcyB0d2ljZSBub3cgdG9kYXksIHdoZXJlYXMgSSBkb24ndCByZW1lbWJlciBldmVyDQo+PiBo
aXR0aW5nIGl0IGJlZm9yZSAobm90IDEwMCUgc3VyZSB0aG91Z2gpLg0KPj4NCj4+IEkgcmV2ZXJ0
ZWQgdGhlIHJlbWFpbmluZyBodW5rIG9mIHRoZSAiY2xlYW51cCBzZXR0aW5nIGJ1bGtfbW92YWJs
ZSINCj4+IGNoYW5nZSwgYW5kIGl0IHN1cnZpdmVkIGEgcGlnbGl0IHJ1bi4gQ291bGQganVzdCBi
ZSBsdWNrLCB0aG91Z2guLi4NCj4gSSdkIGJlZW4gcnVubmluZyB3aXRoIHRoYXQgcmV2ZXJ0IGZv
ciB0aGUgbGFzdCBtb250aCB3aXRob3V0IGhpdHRpbmcgdGhlDQo+IHByb2JsZW0uIFRvZGF5IEkg
dHJpZWQgd2l0aG91dCB0aGUgcmV2ZXJ0LCBhbmQgcHJvbXB0bHkgaGl0IGl0IGFnYWluLg0KPiBT
ZWVtcyBtb3JlIHRoYW4ganVzdCBsdWNrLg0KDQpNaG0sIGFuZCB0aGUgb25seSB0aGluZyB5b3Ug
cmV2ZXJ0ZWQgd2FzIHRoZSAiY2xlYW51cCBzZXR0aW5nIA0KYnVsa21vdmFibGUiIGNoYW5nZT8N
Cg0KQ2hyaXN0aWFuLg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

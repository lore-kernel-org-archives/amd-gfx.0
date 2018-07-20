From: "S, Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amdgpu: lock and unlock console only for
 amdgpu_fbdev_set_suspend [V2]
Date: Fri, 20 Jul 2018 07:58:49 +0000
Message-ID: <BLUPR12MB0452C43DC65A9023EF3231B2F2510@BLUPR12MB0452.namprd12.prod.outlook.com>
References: <1531909474-9661-1-git-send-email-shirish.s@amd.com>
 <ad4b3eec-d4d8-ceb5-dd11-e1562a82cc61@daenzer.net>
 <2362eda1-1e47-fd99-fdbd-c02c208d18bf@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <2362eda1-1e47-fd99-fdbd-c02c208d18bf-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

U3VyZSBNaWNoZWwsIGJ1dCBub3QgaW1tZWRpYXRlbHkuDQpJcyB0aGF0IGZpbmU/DQpSZWdhcmRz
LA0KU2hpcmlzaCBTDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBNaWNoZWwg
RMOkbnplciBbbWFpbHRvOm1pY2hlbEBkYWVuemVyLm5ldF0gDQpTZW50OiBGcmlkYXksIEp1bHkg
MjAsIDIwMTggMTowNCBQTQ0KVG86IFMsIFNoaXJpc2ggPFNoaXJpc2guU0BhbWQuY29tPg0KQ2M6
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0v
YW1kZ3B1OiBsb2NrIGFuZCB1bmxvY2sgY29uc29sZSBvbmx5IGZvciBhbWRncHVfZmJkZXZfc2V0
X3N1c3BlbmQgW1YyXQ0KDQpPbiAyMDE4LTA3LTE5IDExOjIwIEFNLCBNaWNoZWwgRMOkbnplciB3
cm90ZToNCj4gDQo+IFBvc3NpYmxlIGZvbGxvdy11cCB3b3JrOg0KPiANCj4gKiBNb3ZlIHRoZSBj
b25zb2xlXyh1bilsb2NrIGNhbGxzIGludG8gYW1kZ3B1X2ZiZGV2X3NldF9zdXNwZW5kLCBvciAN
Cj4gbWF5YmUgdXNlIGRybV9mYl9oZWxwZXJfc2V0X3N1c3BlbmRfdW5sb2NrZWQgaW5zdGVhZCBv
ZiBsb2NraW5nIA0KPiBvdXJzZWx2ZXMNCj4gDQo+ICogTW92ZSB0aGUgYW1kZ3B1X2ZiZGV2X3Nl
dF9zdXNwZW5kIGNhbGwgaW4gYW1kZ3B1X2RldmljZV9zdXNwZW5kIA0KPiBmdXJ0aGVyIHVwLCBh
dCBsZWFzdCBiZWZvcmUgdGhlIHBjaV9zZXRfcG93ZXJfc3RhdGUgY2FsbC4NCg0KU2hpcmlzaCwg
d291bGQgeW91IGxpa2UgdG8gbG9vayBpbnRvIHRoZXNlPw0KDQoNCi0tIA0KRWFydGhsaW5nIE1p
Y2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1k
LmNvbQ0KTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAg
IE1lc2EgYW5kIFggZGV2ZWxvcGVyDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK

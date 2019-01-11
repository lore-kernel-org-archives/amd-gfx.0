From: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v5 1/2] drm/sched: Refactor ring mirror list handling.
Date: Fri, 11 Jan 2019 09:42:49 +0000
Message-ID: <37ad8228-355e-1d53-593f-b0cb736eadff@amd.com>
References: <1545333815-29870-1-git-send-email-andrey.grodzovsky@amd.com>
 <c62cf367-1485-b1f4-04c2-a11dd8f35416@gmail.com>
 <fc3e12f7-55e1-bf04-b190-7393e84d22a8@amd.com>
 <109f33b9-0a24-08e3-053d-57923b4d7e7f@amd.com>
 <642bdffd-afe9-1a58-4f32-9ef7a4cb22b7@amd.com>
 <c087d565-05d6-aa24-f3ac-9a6378d9ca1b@amd.com>
 <5e256bb1-d4aa-f965-2799-d68c9f925b66@gmail.com>
 <d5a3470a-21a1-adf7-6f85-4d22fae7bb81@amd.com>
 <6a2b45d7-0fa3-38fe-98b2-a538b663c6cc@gmail.com>
 <ea37c55f-ee56-cce7-a4e1-1a599642c54c@amd.com>
 <cbd07551-4f5e-fb80-a4ef-376b19bb3655@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <cbd07551-4f5e-fb80-a4ef-376b19bb3655-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <8D0D5F326FAC48428A9EDF663F27BE82-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org" <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, "etnaviv-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <etnaviv-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

QW0gMTAuMDEuMTkgdW0gMTY6NTYgc2NocmllYiBHcm9kem92c2t5LCBBbmRyZXk6DQo+IFtTTklQ
XQ0KPj4+PiBCdXQgd2Ugd2lsbCBub3QgYmUgYWRkaW5nIHRoZSBjYiBiYWNrIGluIGRybV9zY2hl
ZF9zdG9wIGFueW1vcmUsIG5vdyB3ZQ0KPj4+PiBhcmUgb25seSBnb2luZyB0byBhZGQgYmFjayB0
aGUgY2IgaW4gZHJtX3NjaGVkX3N0YXJ0ciBhZnRlciByZXJ1bm5pbmcNCj4+Pj4gdGhvc2Ugam9i
cyBpbiBkcm1fc2NoZWRfcmVzdWJtaXRfam9icyBhbmQgYXNzaWduIHRoZW0gYSBuZXcgcGFyZW50
DQo+Pj4+IHRoZXJlDQo+Pj4+IGFueXdheS4NCj4+PiBZZWFoLCBidXQgd2hlbiB3ZSBmaW5kIHRo
YXQgd2UgZG9uJ3QgbmVlZCB0byByZXNldCBhbnl0aGluZyBhbnltb3JlDQo+Pj4gdGhlbiBhZGRp
bmcgdGhlIGNhbGxiYWNrcyBhZ2FpbiB3b24ndCBiZSBwb3NzaWJsZSBhbnkgbW9yZS4NCj4+Pg0K
Pj4+IENocmlzdGlhbi4NCj4+IEkgYW0gbm90IHN1cmUgSSB1bmRlcnN0YW5kIGl0LCBjYW4gdSBw
b2ludCBtZSB0byBleGFtcGxlIG9mIGhvdyB0aGlzDQo+PiB3aWxsIGhhcHBlbiA/IEkgYW0gYXR0
YWNoaW5nIG15IGxhdGVzdCBwYXRjaGVzIHdpdGggd2FpdGluZyBvbmx5IGZvcg0KPj4gdGhlIGxh
c3Qgam9iJ3MgZmVuY2UgaGVyZSBqdXN0IHNvIHdlIGFyZSBvbiBzYW1lIHBhZ2UgcmVnYXJkaW5n
IHRoZSBjb2RlLg0KDQpXZWxsIHRoZSB3aG9sZSBpZGVhIGlzIHRvIHByZXBhcmUgYWxsIHNjaGVk
dWxlcnMsIHRoZW4gY2hlY2sgb25jZSBtb3JlIA0KaWYgdGhlIG9mZmVuZGluZyBqb2IgaGFzbid0
IGNvbXBsZXRlZCBpbiB0aGUgbWVhbnRpbWUuDQoNCklmIHRoZSBqb2IgY29tcGxldGVkIHdlIG5l
ZWQgdG8gYmUgYWJsZSB0byByb2xsYmFjayBldmVyeXRoaW5nIGFuZCANCmNvbnRpbnVlIGFzIGlm
IG5vdGhpbmcgaGFkIGhhcHBlbmVkLg0KDQpDaHJpc3RpYW4uDQoNCj4+DQo+PiBBbmRyZXkNCj4+
DQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=

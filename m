From: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] dmr/amdgpu: Avoid HW GPU reset for RAS.
Date: Thu, 29 Aug 2019 16:18:13 +0000
Message-ID: <3a39a720-ae2d-0019-aecc-422f0e3f27bb@amd.com>
References: <1567022426-6612-1-git-send-email-andrey.grodzovsky@amd.com>
 <85798da5-a4f1-28d3-c80f-9f262743cac9@gmail.com>
 <9a46188b-b528-0d1f-8c3f-b6ce5b73649f@amd.com>
 <8c2b0bf3-47ff-ea3b-a682-7ec76240be4d@amd.com>
 <1444ae5f-0997-d1ce-3e1e-23fea8822c88@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1444ae5f-0997-d1ce-3e1e-23fea8822c88-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <3AE7E444C0782243A98360C4EB515655-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Zhang,
 Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

T24gMjAxOS0wOC0yOSAxMDowOCBhLm0uLCBHcm9kem92c2t5LCBBbmRyZXkgd3JvdGU6DQo+DQo+
IEFncmVlLCB0aGUgcGxhY2VtZW50IG9mIGFtZGdwdV9hbWRrZmRfcHJlL3Bvc3QgX3Jlc2V0IGlu
IA0KPiBhbWRncHVfZGV2aWNlX2xvY2svdW5sb2NrX2FkZXYgaXMgYSBiaXQgd2llcmQuDQo+DQph
bWRncHVfZGV2aWNlX3Jlc2V0X3NyaW92IGFscmVhZHkgY2FsbHMgYW1kZ3B1X2FtZGtmZF9wcmUv
cG9zdF9yZXNldCANCml0c2VsZiB3aGlsZSBpdCBoYXMgZXhjbHVzaXZlIGFjY2VzcyB0byB0aGUg
R1BVLiBJdCB3b3VsZCBtYWtlIHNlbnNlIHRvIA0KbW92ZSB0aGUgc2FtZSBjYWxscyBpbnRvIGFt
ZGdwdV9kb19hc2ljX3Jlc2V0IGZvciB0aGUgYmFyZS1tZXRhbCBjYXNlLg0KDQpSZWdhcmRzLA0K
IMKgIEZlbGl4DQoNCg0KPiBBbmRyZXkNCj4NCj4gT24gOC8yOS8xOSAxMDowNiBBTSwgS29lbmln
LCBDaHJpc3RpYW4gd3JvdGU6DQo+Pj4gRmVsaXggYWR2aXNlZCB0aGF0IHRoZSB3YXkgdG8gc3Rv
cCBhbGwgS0ZEIGFjdGl2aXR5IGlzIHNpbXBseSB0byBOT1QNCj4+PiBjYWxsIGFtZGdwdV9hbWRr
ZmRfcG9zdF9yZXNldCBzbyB0aGF0IHdoeSBJIGFkZGVkIHRoaXMuIERvIHlvdSBtZWFuIHlvdQ0K
Pj4+IHByZWZlciBhbWRncHVfYW1ka2ZkX3Bvc3RfcmVzZXQgdG8gYmUgb3V0c2lkZSBvZiBhbWRn
cHVfZGV2aWNlX3VubG9ja19hZGV2ID8NCj4+IFllcywgZXhhY3RseS4gSXQgZG9lc24ndCBzZWVt
cyB0byBiZSByZWxhdGVkIHRvIHRoZSB1bmxvY2sgb3BlcmF0aW9uIGluDQo+PiB0aGUgZmlyc3Qg
cGxhY2UsIGJ1dCByYXRoZXIgb25seSBzaWduYWxzIHRoZSBLRkQgdGhhdCB0aGUgcmVzZXQgaXMN
Cj4+IGNvbXBsZXRlZC4NCj4+DQo+PiBDaHJpc3RpYW4uDQo+Pg0KPg0KPiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBhbWQtZ2Z4IG1haWxpbmcgbGlz
dA0KPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngNCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeA==

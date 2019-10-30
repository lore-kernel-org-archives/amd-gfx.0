From: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: guard ib scheduling while in reset
Date: Wed, 30 Oct 2019 15:05:27 +0000
Message-ID: <4664369b-65bb-fb43-3d52-bdb03fc47478@amd.com>
References: <1571914692-9430-1-git-send-email-shirish.s@amd.com>
 <23ea615d-5ef4-d0b3-a0ec-6fae67b102f2@gmail.com>
 <f3be329d-d350-c821-00b7-d94858335796@amd.com>
 <d573688c-0997-1928-0c56-b60a29ff7fde@gmail.com>
 <b5e99dc3-5658-7e48-63f7-bf9533f582f8@amd.com>
 <2505c476-9e10-f70e-355c-33765a37d607@amd.com>
 <a1c31f37-128f-51b1-f747-fe75d78d4214@amd.com>
 <a9789f76-3ba5-ad71-1507-5eac6f589b82@amd.com>
 <971115b1-6208-1dd5-d99f-c9377663a80b@amd.com>
 <2e2ebf73-9a25-5ad2-78e7-07c8b1db1b37@amd.com>
 <08e3c44f-5d08-d5f5-bc76-ea9b77032e5a@amd.com>
 <1e1d0b06-75ab-160c-a6c7-baede02f1e7d@amd.com>
 <f5b7aeff-c4ce-fa2f-1390-e8892fa7a964@amd.com>
 <d73c46e2-ed85-f56e-3a2a-cbf2919d0a3f@gmail.com>
 <d881fbbe-5fb1-ea68-6490-d08d81c865dd@amd.com>
 <90eb8377-82c4-968a-82f0-1409f69c17e5@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <90eb8377-82c4-968a-82f0-1409f69c17e5-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <F23CEA585ADD2542B2EC43B0E467EF7E-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "S, Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

SSBzZWUuDQoNCk9LLCBJIHdpbGwgYWRkIHRvIG15c2VsZiBhIFRPRE8gYWJvdXQgc3RydWN0IGNv
bXBsZXRpb24gYXBwcm9hY2guDQoNCkFuZHJleQ0KDQpPbiAxMC8zMC8xOSAxMTowMCBBTSwgS29l
bmlnLCBDaHJpc3RpYW4gd3JvdGU6DQo+IFllYWgsIGFuZCBleGFjdGx5IHRoYXQncyB0aGUgcHJv
YmxlbSA6KSBZb3UgbmVlZCBhIGdsb2JhbCBsb2NrIGNvdmVyaW5nDQo+IGFsbCBzY2hlZHVsZXJz
Lg0KPg0KPiBPdGhlcndpc2UgeW91IGVuZCB1cCBpbiBoZWxsJ3Mga2l0Y2hlbiBhZ2FpbiB3aXRo
IHRha2luZyBhbGwgdGhvc2UgbG9ja3MNCj4gaW4gdGhlIHJpZ2h0IG9yZGVyLg0KPg0KPiBDaHJp
c3RpYW4uDQo+DQo+IEFtIDMwLjEwLjE5IHVtIDE1OjU2IHNjaHJpZWIgR3JvZHpvdnNreSwgQW5k
cmV5Og0KPj4gQ2FuIHlvdSBlbGFib3JhdGUgb24gd2hhdCBpcyB0aGUgdHJpY2t5IHBhcnQgd2l0
aCB0aGUgbG9jayA/IEkgYXNzdW1lZA0KPj4gd2UganVzdCB1c2UgcGVyIHNjaGVkdWxlciBsb2Nr
Lg0KPj4NCj4+IEFuZHJleQ0KPj4NCj4+IE9uIDEwLzMwLzE5IDEwOjUwIEFNLCBDaHJpc3RpYW4g
S8O2bmlnIHdyb3RlOg0KPj4+IEEgbG9jayBpbnNpZGUgdGhlIHNjaGVkdWxlciBpcyByYXRoZXIg
dHJpY2t5IHRvIGltcGxlbWVudC4NCj4+Pg0KPj4+IFdoYXQgeW91IG5lZWQgdG8gZG8gaXMgdG8g
Z2V0IHJpZCBvZiB0aGUgcGFyaygpL3VucGFyaygpIGhhY2sgaW4NCj4+PiBkcm1fc2NoZWRfZW50
aXR5X2ZpbmkoKS4NCj4+Pg0KPj4+IFdlIGNvdWxkIGRvIHRoaXMgd2l0aCBhIHN0cnVjdCBjb21w
bGV0aW9uIG9yIGNvbnZlcnQgdGhlIHNjaGVkdWxlcg0KPj4+IGZyb20gYSB0aHJlYWQgdG8gYSB3
b3JrIGl0ZW0uDQo+Pj4NCj4+PiBSZWdhcmRzLA0KPj4+IENocmlzdGlhbi4NCj4+Pg0KPj4+IEFt
IDMwLjEwLjE5IHVtIDE1OjQ0IHNjaHJpZWIgR3JvZHpvdnNreSwgQW5kcmV5Og0KPj4+PiBUaGF0
IGdvb2TCoCBhcyBwcm9vZiBvZiBSQ0EgYnV0IEkgc3RpbGwgdGhpbmsgd2Ugc2hvdWxkIGdyYWIg
YSBkZWRpY2F0ZWQNCj4+Pj4gbG9jayBpbnNpZGUgc2NoZWR1bGVyIHNpbmNlIHRoZSByYWNlIGlz
IGludGVybmFsIHRvIHNjaGVkdWxlciBjb2RlIHNvDQo+Pj4+IHRoaXMgYmV0dGVyIHRvIGhhbmRs
ZSBpdCBpbnNpZGUgdGhlIHNjaGVkdWxlciBjb2RlIHRvIG1ha2UgdGhlIGZpeCBhcHBseQ0KPj4+
PiBmb3IgYWxsIGRyaXZlcnMgdXNpbmcgaXQuDQo+Pj4+DQo+Pj4+IEFuZHJleQ0KPj4+Pg0KPj4+
PiBPbiAxMC8zMC8xOSA0OjQ0IEFNLCBTLCBTaGlyaXNoIHdyb3RlOg0KPj4+Pj4+Pj4gV2Ugc3Rp
bGwgaGF2ZSBpdCBhbmQgaXNuJ3QgZG9pbmcga3RocmVhZF9wYXJrKCkvdW5wYXJrKCkgZnJvbQ0K
Pj4+Pj4+Pj4gZHJtX3NjaGVkX2VudGl0eV9maW5pIHdoaWxlIEdQVSByZXNldCBpbiBwcm9ncmVz
cyBkZWZlYXRzIGFsbCB0aGUNCj4+Pj4+Pj4+IHB1cnBvc2Ugb2YgZHJtX3NjaGVkX3N0b3AtPmt0
aHJlYWRfcGFyayA/IElmDQo+Pj4+Pj4+PiBkcm1fc2NoZWRfZW50aXR5X2ZpbmktPiBrdGhyZWFk
X3VucGFyayBoYXBwZW5zIEFGVEVSDQo+Pj4+Pj4+PiBkcm1fc2NoZWRfc3RvcC0+a3RocmVhZF9w
YXJrIG5vdGhpbmcgcHJldmVudHMgZnJvbSBhbm90aGVyICh0aGlyZCkNCj4+Pj4+Pj4+IHRocmVh
ZCBrZWVwIHN1Ym1pdHRpbmcgam9iIHRvIEhXIHdoaWNoIHdpbGwgYmUgcGlja2VkIHVwIGJ5IHRo
ZQ0KPj4+Pj4+Pj4gdW5wYXJrZWQgc2NoZWR1bGVyIHRocmVhZCB0cnkgdG8gc3VibWl0IHRvIEhX
IGJ1dCBmYWlsIGJlY2F1c2UgdGhlDQo+Pj4+Pj4+PiBIVyByaW5nIGlzIGRlYWN0aXZhdGVkLg0K
Pj4+Pj4+Pj4NCj4+Pj4+Pj4+IElmIHNvIG1heWJlIHdlIHNob3VsZCBzZXJpYWxpemUgY2FsbHMg
dG8NCj4+Pj4+Pj4+IGt0aHJlYWRfcGFyay91bnBhcmsoc2NoZWQtPnRocmVhZCkgPw0KPj4+Pj4+
Pj4NCj4+Pj4+Pj4gWWVhaCwgdGhhdCB3YXMgbXkgdGhpbmtpbmcgYXMgd2VsbC4gUHJvYmFibHkg
YmVzdCB0byBqdXN0IGdyYWIgdGhlDQo+Pj4+Pj4+IHJlc2V0IGxvY2sgYmVmb3JlIGNhbGxpbmcg
ZHJtX3NjaGVkX2VudGl0eV9maW5pKCkuDQo+Pj4+Pj4gU2hpcmlzaCAtIHBsZWFzZSB0cnkgbG9j
a2luZyAmYWRldi0+bG9ja19yZXNldCBhcm91bmQgY2FsbHMgdG8NCj4+Pj4+PiBkcm1fc2NoZWRf
ZW50aXR5X2ZpbmkgYXMgQ2hyaXN0aWFuIHN1Z2dlc3RzIGFuZCBzZWUgaWYgdGhpcyBhY3R1YWxs
eQ0KPj4+Pj4+IGhlbHBzIHRoZSBpc3N1ZS4NCj4+Pj4+Pg0KPj4+Pj4gWWVzIHRoYXQgYWxzbyB3
b3Jrcy4NCj4+Pj4+DQo+Pj4+PiBSZWdhcmRzLA0KPj4+Pj4NCj4+Pj4gX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4+Pj4gYW1kLWdmeCBtYWlsaW5nIGxp
c3QNCj4+Pj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4+Pj4gaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4DQpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=

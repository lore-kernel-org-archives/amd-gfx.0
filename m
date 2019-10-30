From: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: guard ib scheduling while in reset
Date: Wed, 30 Oct 2019 14:56:46 +0000
Message-ID: <d881fbbe-5fb1-ea68-6490-d08d81c865dd@amd.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <d73c46e2-ed85-f56e-3a2a-cbf2919d0a3f-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Content-ID: <9BE4A3191A2E944DAD79E16C4D213B83-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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

Q2FuIHlvdSBlbGFib3JhdGUgb24gd2hhdCBpcyB0aGUgdHJpY2t5IHBhcnQgd2l0aCB0aGUgbG9j
ayA/IEkgYXNzdW1lZCANCndlIGp1c3QgdXNlIHBlciBzY2hlZHVsZXIgbG9jay4NCg0KQW5kcmV5
DQoNCk9uIDEwLzMwLzE5IDEwOjUwIEFNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOg0KPiBBIGxv
Y2sgaW5zaWRlIHRoZSBzY2hlZHVsZXIgaXMgcmF0aGVyIHRyaWNreSB0byBpbXBsZW1lbnQuDQo+
DQo+IFdoYXQgeW91IG5lZWQgdG8gZG8gaXMgdG8gZ2V0IHJpZCBvZiB0aGUgcGFyaygpL3VucGFy
aygpIGhhY2sgaW4gDQo+IGRybV9zY2hlZF9lbnRpdHlfZmluaSgpLg0KPg0KPiBXZSBjb3VsZCBk
byB0aGlzIHdpdGggYSBzdHJ1Y3QgY29tcGxldGlvbiBvciBjb252ZXJ0IHRoZSBzY2hlZHVsZXIg
DQo+IGZyb20gYSB0aHJlYWQgdG8gYSB3b3JrIGl0ZW0uDQo+DQo+IFJlZ2FyZHMsDQo+IENocmlz
dGlhbi4NCj4NCj4gQW0gMzAuMTAuMTkgdW0gMTU6NDQgc2NocmllYiBHcm9kem92c2t5LCBBbmRy
ZXk6DQo+PiBUaGF0IGdvb2TCoCBhcyBwcm9vZiBvZiBSQ0EgYnV0IEkgc3RpbGwgdGhpbmsgd2Ug
c2hvdWxkIGdyYWIgYSBkZWRpY2F0ZWQNCj4+IGxvY2sgaW5zaWRlIHNjaGVkdWxlciBzaW5jZSB0
aGUgcmFjZSBpcyBpbnRlcm5hbCB0byBzY2hlZHVsZXIgY29kZSBzbw0KPj4gdGhpcyBiZXR0ZXIg
dG8gaGFuZGxlIGl0IGluc2lkZSB0aGUgc2NoZWR1bGVyIGNvZGUgdG8gbWFrZSB0aGUgZml4IGFw
cGx5DQo+PiBmb3IgYWxsIGRyaXZlcnMgdXNpbmcgaXQuDQo+Pg0KPj4gQW5kcmV5DQo+Pg0KPj4g
T24gMTAvMzAvMTkgNDo0NCBBTSwgUywgU2hpcmlzaCB3cm90ZToNCj4+Pj4+PiBXZSBzdGlsbCBo
YXZlIGl0IGFuZCBpc24ndCBkb2luZyBrdGhyZWFkX3BhcmsoKS91bnBhcmsoKSBmcm9tDQo+Pj4+
Pj4gZHJtX3NjaGVkX2VudGl0eV9maW5pIHdoaWxlIEdQVSByZXNldCBpbiBwcm9ncmVzcyBkZWZl
YXRzIGFsbCB0aGUNCj4+Pj4+PiBwdXJwb3NlIG9mIGRybV9zY2hlZF9zdG9wLT5rdGhyZWFkX3Bh
cmsgPyBJZg0KPj4+Pj4+IGRybV9zY2hlZF9lbnRpdHlfZmluaS0+IGt0aHJlYWRfdW5wYXJrIGhh
cHBlbnMgQUZURVINCj4+Pj4+PiBkcm1fc2NoZWRfc3RvcC0+a3RocmVhZF9wYXJrIG5vdGhpbmcg
cHJldmVudHMgZnJvbSBhbm90aGVyICh0aGlyZCkNCj4+Pj4+PiB0aHJlYWQga2VlcCBzdWJtaXR0
aW5nIGpvYiB0byBIVyB3aGljaCB3aWxsIGJlIHBpY2tlZCB1cCBieSB0aGUNCj4+Pj4+PiB1bnBh
cmtlZCBzY2hlZHVsZXIgdGhyZWFkIHRyeSB0byBzdWJtaXQgdG8gSFcgYnV0IGZhaWwgYmVjYXVz
ZSB0aGUNCj4+Pj4+PiBIVyByaW5nIGlzIGRlYWN0aXZhdGVkLg0KPj4+Pj4+DQo+Pj4+Pj4gSWYg
c28gbWF5YmUgd2Ugc2hvdWxkIHNlcmlhbGl6ZSBjYWxscyB0bw0KPj4+Pj4+IGt0aHJlYWRfcGFy
ay91bnBhcmsoc2NoZWQtPnRocmVhZCkgPw0KPj4+Pj4+DQo+Pj4+PiBZZWFoLCB0aGF0IHdhcyBt
eSB0aGlua2luZyBhcyB3ZWxsLiBQcm9iYWJseSBiZXN0IHRvIGp1c3QgZ3JhYiB0aGUNCj4+Pj4+
IHJlc2V0IGxvY2sgYmVmb3JlIGNhbGxpbmcgZHJtX3NjaGVkX2VudGl0eV9maW5pKCkuDQo+Pj4+
DQo+Pj4+IFNoaXJpc2ggLSBwbGVhc2UgdHJ5IGxvY2tpbmcgJmFkZXYtPmxvY2tfcmVzZXQgYXJv
dW5kIGNhbGxzIHRvDQo+Pj4+IGRybV9zY2hlZF9lbnRpdHlfZmluaSBhcyBDaHJpc3RpYW4gc3Vn
Z2VzdHMgYW5kIHNlZSBpZiB0aGlzIGFjdHVhbGx5DQo+Pj4+IGhlbHBzIHRoZSBpc3N1ZS4NCj4+
Pj4NCj4+PiBZZXMgdGhhdCBhbHNvIHdvcmtzLg0KPj4+DQo+Pj4gUmVnYXJkcywNCj4+Pg0KPj4g
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4+IGFtZC1n
ZnggbWFpbGluZyBsaXN0DQo+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPj4gaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4DQo+DQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=

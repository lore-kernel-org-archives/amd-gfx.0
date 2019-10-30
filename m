From: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: guard ib scheduling while in reset
Date: Wed, 30 Oct 2019 14:44:00 +0000
Message-ID: <f5b7aeff-c4ce-fa2f-1390-e8892fa7a964@amd.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1e1d0b06-75ab-160c-a6c7-baede02f1e7d-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <D70DDD5809F97E46B6595D21BA0F4C1F-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "S, Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

VGhhdCBnb29kwqAgYXMgcHJvb2Ygb2YgUkNBIGJ1dCBJIHN0aWxsIHRoaW5rIHdlIHNob3VsZCBn
cmFiIGEgZGVkaWNhdGVkIA0KbG9jayBpbnNpZGUgc2NoZWR1bGVyIHNpbmNlIHRoZSByYWNlIGlz
IGludGVybmFsIHRvIHNjaGVkdWxlciBjb2RlIHNvIA0KdGhpcyBiZXR0ZXIgdG8gaGFuZGxlIGl0
IGluc2lkZSB0aGUgc2NoZWR1bGVyIGNvZGUgdG8gbWFrZSB0aGUgZml4IGFwcGx5IA0KZm9yIGFs
bCBkcml2ZXJzIHVzaW5nIGl0Lg0KDQpBbmRyZXkNCg0KT24gMTAvMzAvMTkgNDo0NCBBTSwgUywg
U2hpcmlzaCB3cm90ZToNCj4+Pj4NCj4+Pj4gV2Ugc3RpbGwgaGF2ZSBpdCBhbmQgaXNuJ3QgZG9p
bmcga3RocmVhZF9wYXJrKCkvdW5wYXJrKCkgZnJvbSANCj4+Pj4gZHJtX3NjaGVkX2VudGl0eV9m
aW5pIHdoaWxlIEdQVSByZXNldCBpbiBwcm9ncmVzcyBkZWZlYXRzIGFsbCB0aGUgDQo+Pj4+IHB1
cnBvc2Ugb2YgZHJtX3NjaGVkX3N0b3AtPmt0aHJlYWRfcGFyayA/IElmIA0KPj4+PiBkcm1fc2No
ZWRfZW50aXR5X2ZpbmktPiBrdGhyZWFkX3VucGFyayBoYXBwZW5zIEFGVEVSIA0KPj4+PiBkcm1f
c2NoZWRfc3RvcC0+a3RocmVhZF9wYXJrIG5vdGhpbmcgcHJldmVudHMgZnJvbSBhbm90aGVyICh0
aGlyZCkgDQo+Pj4+IHRocmVhZCBrZWVwIHN1Ym1pdHRpbmcgam9iIHRvIEhXIHdoaWNoIHdpbGwg
YmUgcGlja2VkIHVwIGJ5IHRoZSANCj4+Pj4gdW5wYXJrZWQgc2NoZWR1bGVyIHRocmVhZCB0cnkg
dG8gc3VibWl0IHRvIEhXIGJ1dCBmYWlsIGJlY2F1c2UgdGhlIA0KPj4+PiBIVyByaW5nIGlzIGRl
YWN0aXZhdGVkLg0KPj4+Pg0KPj4+PiBJZiBzbyBtYXliZSB3ZSBzaG91bGQgc2VyaWFsaXplIGNh
bGxzIHRvIA0KPj4+PiBrdGhyZWFkX3BhcmsvdW5wYXJrKHNjaGVkLT50aHJlYWQpID8NCj4+Pj4N
Cj4+Pg0KPj4+IFllYWgsIHRoYXQgd2FzIG15IHRoaW5raW5nIGFzIHdlbGwuIFByb2JhYmx5IGJl
c3QgdG8ganVzdCBncmFiIHRoZSANCj4+PiByZXNldCBsb2NrIGJlZm9yZSBjYWxsaW5nIGRybV9z
Y2hlZF9lbnRpdHlfZmluaSgpLg0KPj4NCj4+DQo+PiBTaGlyaXNoIC0gcGxlYXNlIHRyeSBsb2Nr
aW5nICZhZGV2LT5sb2NrX3Jlc2V0IGFyb3VuZCBjYWxscyB0byANCj4+IGRybV9zY2hlZF9lbnRp
dHlfZmluaSBhcyBDaHJpc3RpYW4gc3VnZ2VzdHMgYW5kIHNlZSBpZiB0aGlzIGFjdHVhbGx5IA0K
Pj4gaGVscHMgdGhlIGlzc3VlLg0KPj4NCj4gWWVzIHRoYXQgYWxzbyB3b3Jrcy4NCj4NCj4gUmVn
YXJkcywNCj4NCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==

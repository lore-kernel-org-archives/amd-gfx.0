From: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: guard ib scheduling while in reset
Date: Wed, 30 Oct 2019 15:00:42 +0000
Message-ID: <90eb8377-82c4-968a-82f0-1409f69c17e5@amd.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <d881fbbe-5fb1-ea68-6490-d08d81c865dd-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <2831D6F3F737A5479A5F8CEFC96C05B8-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, "S, Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

WWVhaCwgYW5kIGV4YWN0bHkgdGhhdCdzIHRoZSBwcm9ibGVtIDopIFlvdSBuZWVkIGEgZ2xvYmFs
IGxvY2sgY292ZXJpbmcgDQphbGwgc2NoZWR1bGVycy4NCg0KT3RoZXJ3aXNlIHlvdSBlbmQgdXAg
aW4gaGVsbCdzIGtpdGNoZW4gYWdhaW4gd2l0aCB0YWtpbmcgYWxsIHRob3NlIGxvY2tzIA0KaW4g
dGhlIHJpZ2h0IG9yZGVyLg0KDQpDaHJpc3RpYW4uDQoNCkFtIDMwLjEwLjE5IHVtIDE1OjU2IHNj
aHJpZWIgR3JvZHpvdnNreSwgQW5kcmV5Og0KPiBDYW4geW91IGVsYWJvcmF0ZSBvbiB3aGF0IGlz
IHRoZSB0cmlja3kgcGFydCB3aXRoIHRoZSBsb2NrID8gSSBhc3N1bWVkDQo+IHdlIGp1c3QgdXNl
IHBlciBzY2hlZHVsZXIgbG9jay4NCj4NCj4gQW5kcmV5DQo+DQo+IE9uIDEwLzMwLzE5IDEwOjUw
IEFNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOg0KPj4gQSBsb2NrIGluc2lkZSB0aGUgc2NoZWR1
bGVyIGlzIHJhdGhlciB0cmlja3kgdG8gaW1wbGVtZW50Lg0KPj4NCj4+IFdoYXQgeW91IG5lZWQg
dG8gZG8gaXMgdG8gZ2V0IHJpZCBvZiB0aGUgcGFyaygpL3VucGFyaygpIGhhY2sgaW4NCj4+IGRy
bV9zY2hlZF9lbnRpdHlfZmluaSgpLg0KPj4NCj4+IFdlIGNvdWxkIGRvIHRoaXMgd2l0aCBhIHN0
cnVjdCBjb21wbGV0aW9uIG9yIGNvbnZlcnQgdGhlIHNjaGVkdWxlcg0KPj4gZnJvbSBhIHRocmVh
ZCB0byBhIHdvcmsgaXRlbS4NCj4+DQo+PiBSZWdhcmRzLA0KPj4gQ2hyaXN0aWFuLg0KPj4NCj4+
IEFtIDMwLjEwLjE5IHVtIDE1OjQ0IHNjaHJpZWIgR3JvZHpvdnNreSwgQW5kcmV5Og0KPj4+IFRo
YXQgZ29vZMKgIGFzIHByb29mIG9mIFJDQSBidXQgSSBzdGlsbCB0aGluayB3ZSBzaG91bGQgZ3Jh
YiBhIGRlZGljYXRlZA0KPj4+IGxvY2sgaW5zaWRlIHNjaGVkdWxlciBzaW5jZSB0aGUgcmFjZSBp
cyBpbnRlcm5hbCB0byBzY2hlZHVsZXIgY29kZSBzbw0KPj4+IHRoaXMgYmV0dGVyIHRvIGhhbmRs
ZSBpdCBpbnNpZGUgdGhlIHNjaGVkdWxlciBjb2RlIHRvIG1ha2UgdGhlIGZpeCBhcHBseQ0KPj4+
IGZvciBhbGwgZHJpdmVycyB1c2luZyBpdC4NCj4+Pg0KPj4+IEFuZHJleQ0KPj4+DQo+Pj4gT24g
MTAvMzAvMTkgNDo0NCBBTSwgUywgU2hpcmlzaCB3cm90ZToNCj4+Pj4+Pj4gV2Ugc3RpbGwgaGF2
ZSBpdCBhbmQgaXNuJ3QgZG9pbmcga3RocmVhZF9wYXJrKCkvdW5wYXJrKCkgZnJvbQ0KPj4+Pj4+
PiBkcm1fc2NoZWRfZW50aXR5X2Zpbmkgd2hpbGUgR1BVIHJlc2V0IGluIHByb2dyZXNzIGRlZmVh
dHMgYWxsIHRoZQ0KPj4+Pj4+PiBwdXJwb3NlIG9mIGRybV9zY2hlZF9zdG9wLT5rdGhyZWFkX3Bh
cmsgPyBJZg0KPj4+Pj4+PiBkcm1fc2NoZWRfZW50aXR5X2ZpbmktPiBrdGhyZWFkX3VucGFyayBo
YXBwZW5zIEFGVEVSDQo+Pj4+Pj4+IGRybV9zY2hlZF9zdG9wLT5rdGhyZWFkX3Bhcmsgbm90aGlu
ZyBwcmV2ZW50cyBmcm9tIGFub3RoZXIgKHRoaXJkKQ0KPj4+Pj4+PiB0aHJlYWQga2VlcCBzdWJt
aXR0aW5nIGpvYiB0byBIVyB3aGljaCB3aWxsIGJlIHBpY2tlZCB1cCBieSB0aGUNCj4+Pj4+Pj4g
dW5wYXJrZWQgc2NoZWR1bGVyIHRocmVhZCB0cnkgdG8gc3VibWl0IHRvIEhXIGJ1dCBmYWlsIGJl
Y2F1c2UgdGhlDQo+Pj4+Pj4+IEhXIHJpbmcgaXMgZGVhY3RpdmF0ZWQuDQo+Pj4+Pj4+DQo+Pj4+
Pj4+IElmIHNvIG1heWJlIHdlIHNob3VsZCBzZXJpYWxpemUgY2FsbHMgdG8NCj4+Pj4+Pj4ga3Ro
cmVhZF9wYXJrL3VucGFyayhzY2hlZC0+dGhyZWFkKSA/DQo+Pj4+Pj4+DQo+Pj4+Pj4gWWVhaCwg
dGhhdCB3YXMgbXkgdGhpbmtpbmcgYXMgd2VsbC4gUHJvYmFibHkgYmVzdCB0byBqdXN0IGdyYWIg
dGhlDQo+Pj4+Pj4gcmVzZXQgbG9jayBiZWZvcmUgY2FsbGluZyBkcm1fc2NoZWRfZW50aXR5X2Zp
bmkoKS4NCj4+Pj4+IFNoaXJpc2ggLSBwbGVhc2UgdHJ5IGxvY2tpbmcgJmFkZXYtPmxvY2tfcmVz
ZXQgYXJvdW5kIGNhbGxzIHRvDQo+Pj4+PiBkcm1fc2NoZWRfZW50aXR5X2ZpbmkgYXMgQ2hyaXN0
aWFuIHN1Z2dlc3RzIGFuZCBzZWUgaWYgdGhpcyBhY3R1YWxseQ0KPj4+Pj4gaGVscHMgdGhlIGlz
c3VlLg0KPj4+Pj4NCj4+Pj4gWWVzIHRoYXQgYWxzbyB3b3Jrcy4NCj4+Pj4NCj4+Pj4gUmVnYXJk
cywNCj4+Pj4NCj4+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXw0KPj4+IGFtZC1nZnggbWFpbGluZyBsaXN0DQo+Pj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcNCj4+PiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

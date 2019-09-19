From: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2] drm/amdgpu: fix multiple memory leaks
Date: Thu, 19 Sep 2019 16:48:47 +0000
Message-ID: <7450dab5-3c3f-0b91-4656-6c5a7cf4d49d@amd.com>
References: <7bab24ff-ded7-9f76-ba25-efd07cdd30dd@amd.com>
 <20190918190529.17298-1-navid.emamdoost@gmail.com>
 <88fc639a-32ed-b6c6-f930-552083d5887d@amd.com>
 <CAGngYiWHe1mw0+Ay6HO7kG5y8HMriUX3BO8VUcTvGayEK-4JOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAGngYiWHe1mw0+Ay6HO7kG5y8HMriUX3BO8VUcTvGayEK-4JOw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Content-ID: <7A52BBEE9F5AE24B8D2F7A702282DBD5-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: Sven Van Asbroeck <thesven73-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Zhou,
 David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>, "kjlu-OJFnDUYgAso@public.gmane.org" <kjlu-OJFnDUYgAso@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "emamd001-OJFnDUYgAso@public.gmane.org" <emamd001-OJFnDUYgAso@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, "smccaman-OJFnDUYgAso@public.gmane.org" <smccaman-OJFnDUYgAso@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, Navid Emamdoost <navid.emamdoost-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

QW0gMTkuMDkuMTkgdW0gMTY6Mjggc2NocmllYiBTdmVuIFZhbiBBc2Jyb2VjazoNCj4gSGkgQ2hy
aXN0aWFuLA0KPg0KPiBPbiBUaHUsIFNlcCAxOSwgMjAxOSBhdCA0OjA1IEFNIEtvZW5pZywgQ2hy
aXN0aWFuDQo+IDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+IHdyb3RlOg0KPj4+ICtvdXQ0Og0K
Pj4+ICsgICAgIGtmcmVlKGkyc19wZGF0YSk7DQo+Pj4gK291dDM6DQo+Pj4gKyAgICAga2ZyZWUo
YWRldi0+YWNwLmFjcF9yZXMpOw0KPj4+ICtvdXQyOg0KPj4+ICsgICAgIGtmcmVlKGFkZXYtPmFj
cC5hY3BfY2VsbCk7DQo+Pj4gK291dDE6DQo+Pj4gKyAgICAga2ZyZWUoYWRldi0+YWNwLmFjcF9n
ZW5wZCk7DQo+PiBrZnJlZSBvbiBhIE5VTEwgcG9pbnRlciBpcyBoYXJtbGVzcywgc28gYSBzaW5n
bGUgZXJyb3IgbGFiZWwgc2hvdWxkIGJlDQo+PiBzdWZmaWNpZW50Lg0KPiBUaGF0IGlzIHRydWUs
IGJ1dCBJIG5vdGljZSB0aGF0IHRoZSBhZGV2IHN0cnVjdHVyZSBjb21lcyBmcm9tIG91dHNpZGUg
dGhpcw0KPiBkcml2ZXI6DQoNCmFkZXYgaXMgYSB2ZXJ5IGludGVncmFsIHBhcnQgb2YgdGhlIGRy
aXZlciBhbmQgYWx3YXlzIHplcm8gaW5pdGlhbGl6ZWQ6DQoNCmFkZXYgPSBremFsbG9jKHNpemVv
ZihzdHJ1Y3QgYW1kZ3B1X2RldmljZSksIEdGUF9LRVJORUwpOw0KDQpSZWdhcmRzLA0KQ2hyaXN0
aWFuLg0KDQo+DQo+IHN0YXRpYyBpbnQgYWNwX2h3X2luaXQodm9pZCAqaGFuZGxlKQ0KPiB7DQo+
IC4uLg0KPiBzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IChzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqKWhhbmRsZTsNCj4gLi4uDQo+IH0NCj4NCj4gQXMgZmFyIGFzIEkgY2FuIHRlbGwsIHRoZSBp
bml0KCkgZG9lcyBub3QgZXhwbGljaXRseSBzZXQgdGhlc2UgdG8gTlVMTDoNCj4gYWRldi0+YWNw
LmFjcF9yZXMNCj4gYWRldi0+YWNwLmFjcF9jZWxsDQo+IGFkZXYtPmFjcC5hY3BfZ2VucGQNCj4N
Cj4gSSBhbSBhc3N1bWluZyB0aGF0IGNvcmUgY29kZSBzZXRzIHRoZXNlIHRvIE5VTEwsIGJlZm9y
ZSBjYWxsaW5nDQo+IGFjcF9od19pbml0KCkuIEJ1dCBpcyB0aGF0IGd1YXJhbnRlZWQgb3Igc2lt
cGx5IGEgaGFwcHkgYWNjaWRlbnQ/DQo+IEllLiBpZiB0aGV5IGFyZSBOVUxMIHRvZGF5LCBhcmUg
dGhleSBsaWtlbHkgdG8gcmVtYWluIE5VTEwgdG9tb3Jyb3c/DQo+DQo+IEJlY2F1c2UgY2FsbGlu
ZyBrZnJlZSgpIG9uIGEgc3RhbGUgcG9pbnRlciB3b3VsZCBiZSwgd2VsbA0KPiBub3QgZ29vZC4g
RXNwZWNpYWxseSBub3Qgb24gYW4gZXJyb3IgcGF0aCwgd2hpY2ggdHlwaWNhbGx5DQo+IGRvZXMg
bm90IHJlY2VpdmUgbXVjaCB0ZXN0aW5nLCBpZiBhbnkuDQo+DQo+IE15IGFwb2xvZ2llcyBpZiBJ
IGhhdmUgbWlzaW50ZXJwcmV0ZWQgdGhpcywgSSBhbSBub3QgZmFtaWxpYXIgd2l0aA0KPiB0aGlz
IGNvZGUgYmFzZS4NCj4NCj4gU3Zlbg0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZng=

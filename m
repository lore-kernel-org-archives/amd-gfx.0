From: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] dmr/amdgpu: Avoid HW GPU reset for RAS.
Date: Thu, 29 Aug 2019 17:21:10 +0000
Message-ID: <2763a85d-cfd7-bf80-5d8b-3590cf35e6d0@amd.com>
References: <1567022426-6612-1-git-send-email-andrey.grodzovsky@amd.com>
 <85798da5-a4f1-28d3-c80f-9f262743cac9@gmail.com>
 <9a46188b-b528-0d1f-8c3f-b6ce5b73649f@amd.com>
 <8c2b0bf3-47ff-ea3b-a682-7ec76240be4d@amd.com>
 <1444ae5f-0997-d1ce-3e1e-23fea8822c88@amd.com>
 <3a39a720-ae2d-0019-aecc-422f0e3f27bb@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <3a39a720-ae2d-0019-aecc-422f0e3f27bb-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <45212D57BE974D409803BDDCAA8E992F-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Zhang,
 Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

DQpPbiA4LzI5LzE5IDEyOjE4IFBNLCBLdWVobGluZywgRmVsaXggd3JvdGU6DQo+IE9uIDIwMTkt
MDgtMjkgMTA6MDggYS5tLiwgR3JvZHpvdnNreSwgQW5kcmV5IHdyb3RlOg0KPj4gQWdyZWUsIHRo
ZSBwbGFjZW1lbnQgb2YgYW1kZ3B1X2FtZGtmZF9wcmUvcG9zdCBfcmVzZXQgaW4NCj4+IGFtZGdw
dV9kZXZpY2VfbG9jay91bmxvY2tfYWRldiBpcyBhIGJpdCB3aWVyZC4NCj4+DQo+IGFtZGdwdV9k
ZXZpY2VfcmVzZXRfc3Jpb3YgYWxyZWFkeSBjYWxscyBhbWRncHVfYW1ka2ZkX3ByZS9wb3N0X3Jl
c2V0DQo+IGl0c2VsZiB3aGlsZSBpdCBoYXMgZXhjbHVzaXZlIGFjY2VzcyB0byB0aGUgR1BVLg0K
DQpTbyBpbiB0aGF0IGNhc2UgYW1kZ3B1X2FtZGtmZF9wcmUvcG9zdF9yZXNldCBnZXRzIGNhbGxl
ZCB0d2ljZSAtIG9uY2UgDQpmcm9tIGFtZGdwdV9kZXZpY2VfbG9jay91bmxvY2tfYWRldiBhbmQg
c2Vjb25kIHRpbWUgZnJvbSANCmFtZGdwdV9kZXZpY2VfcmVzZXRfc3Jpb3YsIG5vID8gV2h5IGlz
IGl0ID8NCg0KDQo+IEl0IHdvdWxkIG1ha2Ugc2Vuc2UgdG8NCj4gbW92ZSB0aGUgc2FtZSBjYWxs
cyBpbnRvIGFtZGdwdV9kb19hc2ljX3Jlc2V0IGZvciB0aGUgYmFyZS1tZXRhbCBjYXNlLg0KDQoN
ClByb2JsZW0gaXMgaSBhbSBza2lwcGluZyBhbWRncHVfZG9fYXNpY19yZXNldCB0b3RhbGx5IGlu
IHRoaXMgY2FzZSBhcyANCnRoZXJlIGlzIG5vIEhXIHJlc2V0IGhlcmUgc28gaSB3aWxsIGp1c3Qg
ZXh0cmFjdCBpdCBmcm9tIA0KYW1kZ3B1X2RldmljZV9sb2NrL3VubG9ja19hZGV2DQoNCkFuZHJl
eQ0KDQoNCj4NCj4gUmVnYXJkcywNCj4gICDCoCBGZWxpeA0KPg0KPg0KPj4gQW5kcmV5DQo+Pg0K
Pj4gT24gOC8yOS8xOSAxMDowNiBBTSwgS29lbmlnLCBDaHJpc3RpYW4gd3JvdGU6DQo+Pj4+IEZl
bGl4IGFkdmlzZWQgdGhhdCB0aGUgd2F5IHRvIHN0b3AgYWxsIEtGRCBhY3Rpdml0eSBpcyBzaW1w
bHkgdG8gTk9UDQo+Pj4+IGNhbGwgYW1kZ3B1X2FtZGtmZF9wb3N0X3Jlc2V0IHNvIHRoYXQgd2h5
IEkgYWRkZWQgdGhpcy4gRG8geW91IG1lYW4geW91DQo+Pj4+IHByZWZlciBhbWRncHVfYW1ka2Zk
X3Bvc3RfcmVzZXQgdG8gYmUgb3V0c2lkZSBvZiBhbWRncHVfZGV2aWNlX3VubG9ja19hZGV2ID8N
Cj4+PiBZZXMsIGV4YWN0bHkuIEl0IGRvZXNuJ3Qgc2VlbXMgdG8gYmUgcmVsYXRlZCB0byB0aGUg
dW5sb2NrIG9wZXJhdGlvbiBpbg0KPj4+IHRoZSBmaXJzdCBwbGFjZSwgYnV0IHJhdGhlciBvbmx5
IHNpZ25hbHMgdGhlIEtGRCB0aGF0IHRoZSByZXNldCBpcw0KPj4+IGNvbXBsZXRlZC4NCj4+Pg0K
Pj4+IENocmlzdGlhbi4NCj4+Pg0KPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18NCj4+IGFtZC1nZnggbWFpbGluZyBsaXN0DQo+PiBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZw0KPj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
Zng=

From: Nirmoy <nirmodas-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [RFC PATCH] drm/amdgpu: fix amdgpu_vm_handle_fault return value
Date: Thu, 10 Oct 2019 11:27:01 +0000
Message-ID: <132de37c-a5f0-1b24-0f47-d581f689d943@amd.com>
References: <20191010104214.38728-1-nirmoy.das@amd.com>
 <df4bd681-d745-4cb0-3dec-38e826f4c9fe@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <df4bd681-d745-4cb0-3dec-38e826f4c9fe-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <FFCE3CC7D95E6F40AE0CAE769EB3A2FD-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, Nirmoy Das <nirmoy.aiemd-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "Das, Nirmoy" <Nirmoy.Das-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

DQpPbiAxMC8xMC8xOSAxOjE5IFBNLCBLb2VuaWcsIENocmlzdGlhbiB3cm90ZToNCj4gQW0gMTAu
MTAuMTkgdW0gMTI6NDIgc2NocmllYiBOaXJtb3kgRGFzOg0KPj4gYW1kZ3B1X3ZtX2hhbmRsZV9m
YXVsdCBzaG91bGQgcmV0dXJuIHRydWUgb24gc3VjY2Vzcw0KPiBOQUssIHRoYXQgaXMgaW50ZW50
aW9uYWwuDQo+DQo+IFRoZXJlIGlzIGEgZm9sbG93IHVwIHBhdGNoIHdoaWNoIGRpZG4ndCBtYWRl
IGl0IGludG8gb3VyIHNlcnZlciBicmFuY2gNCj4gd2hpY2ggaW1wbGVtZW50cyBmYXVsdHMgaGFu
ZGxpbmcuDQoNCkluIHRoYXQgY2FzZSBJIHRoaW5rIGl0IGlzIGdvb2QgYXMgaXQgaXMuDQoNClRo
YW5rcywNCg0KTmlybW95DQoNCj4gV2UgY291bGQgYWN0dWFsbHkgY2hhbmdlIHRoZSByZXR1cm4g
dmFsdWUgdG8gdm9pZCB1bnRpbCB0aGF0IG9uZSBsYW5kcywNCj4gQ2hyaXN0aWFuLg0KPg0KPj4g
U2lnbmVkLW9mZi1ieTogTmlybW95IERhcyA8bmlybW95LmRhc0BhbWQuY29tPg0KPj4gLS0tDQo+
PiAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8IDIgKy0NCj4+ICAg
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jDQo+PiBpbmRleCBkOWJlY2U5ODdlNjAu
LjZmNDY4YzZmZmVmMiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92bS5jDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dm0uYw0KPj4gQEAgLTMyMTUsNSArMzIxNSw1IEBAIGJvb2wgYW1kZ3B1X3ZtX2hhbmRsZV9mYXVs
dChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdW5zaWduZWQgaW50IHBhc2lkLA0KPj4gICAg
ZXJyb3JfdW5yZWY6DQo+PiAgICAJYW1kZ3B1X2JvX3VucmVmKCZyb290KTsNCj4+ICAgIA0KPj4g
LQlyZXR1cm4gZmFsc2U7DQo+PiArCXJldHVybiAociA9PSAwKSA/IHRydWUgOiBmYWxzZTsNCj4+
ICAgIH0NCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==

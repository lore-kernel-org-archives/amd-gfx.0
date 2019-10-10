From: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [RFC PATCH] drm/amdgpu: fix amdgpu_vm_handle_fault return value
Date: Thu, 10 Oct 2019 11:19:53 +0000
Message-ID: <df4bd681-d745-4cb0-3dec-38e826f4c9fe@amd.com>
References: <20191010104214.38728-1-nirmoy.das@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191010104214.38728-1-nirmoy.das-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <092D4D3ED03AE449A2A431AFF44DDE8F-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: Nirmoy Das <nirmoy.aiemd-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "Das, Nirmoy" <Nirmoy.Das-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMTAuMTAuMTkgdW0gMTI6NDIgc2NocmllYiBOaXJtb3kgRGFzOg0KPiBhbWRncHVfdm1faGFu
ZGxlX2ZhdWx0IHNob3VsZCByZXR1cm4gdHJ1ZSBvbiBzdWNjZXNzDQoNCk5BSywgdGhhdCBpcyBp
bnRlbnRpb25hbC4NCg0KVGhlcmUgaXMgYSBmb2xsb3cgdXAgcGF0Y2ggd2hpY2ggZGlkbid0IG1h
ZGUgaXQgaW50byBvdXIgc2VydmVyIGJyYW5jaCANCndoaWNoIGltcGxlbWVudHMgZmF1bHRzIGhh
bmRsaW5nLg0KDQpXZSBjb3VsZCBhY3R1YWxseSBjaGFuZ2UgdGhlIHJldHVybiB2YWx1ZSB0byB2
b2lkIHVudGlsIHRoYXQgb25lIGxhbmRzLA0KQ2hyaXN0aWFuLg0KDQo+DQo+IFNpZ25lZC1vZmYt
Ynk6IE5pcm1veSBEYXMgPG5pcm1veS5kYXNAYW1kLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgfCAyICstDQo+ICAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92bS5jDQo+IGluZGV4IGQ5YmVjZTk4N2U2MC4uNmY0NjhjNmZmZWYyIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYw0KPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYw0KPiBAQCAtMzIxNSw1ICsz
MjE1LDUgQEAgYm9vbCBhbWRncHVfdm1faGFuZGxlX2ZhdWx0KHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2LCB1bnNpZ25lZCBpbnQgcGFzaWQsDQo+ICAgZXJyb3JfdW5yZWY6DQo+ICAgCWFtZGdw
dV9ib191bnJlZigmcm9vdCk7DQo+ICAgDQo+IC0JcmV0dXJuIGZhbHNlOw0KPiArCXJldHVybiAo
ciA9PSAwKSA/IHRydWUgOiBmYWxzZTsNCj4gICB9DQoNCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeA==

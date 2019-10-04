From: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH][next] drm/amdgpu: remove redundant variable r and
 redundant return statement
Date: Fri, 4 Oct 2019 07:29:50 +0000
Message-ID: <70c50fec-7ab7-3ac9-3f49-d5f2651554e4@amd.com>
References: <20191003214049.23067-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191003214049.23067-1-colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Content-Language: en-US
Content-ID: <4C72520FA053004BB3A0D863783982FD-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: Colin King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

QW0gMDMuMTAuMTkgdW0gMjM6NDAgc2NocmllYiBDb2xpbiBLaW5nOg0KPiBGcm9tOiBDb2xpbiBJ
YW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmljYWwuY29tPg0KPg0KPiBUaGVyZSBpcyBhIHJldHVy
biBzdGF0ZW1lbnQgdGhhdCBpcyBub3QgcmVhY2hhYmxlIGFuZCBhIHZhcmlhYmxlIHRoYXQNCj4g
aXMgbm90IHVzZWQuICBSZW1vdmUgdGhlbS4NCj4NCj4gQWRkcmVzc2VzLUNvdmVyaXR5OiAoIlN0
cnVjdHVyYWxseSBkZWFkIGNvZGUiKQ0KPiBGaXhlczogZGU3YjQ1YmFiZDliICgiZHJtL2FtZGdw
dTogY2xlYW51cCBjcmVhdGluZyBCT3MgYXQgZml4ZWQgbG9jYXRpb24gKHYyKSIpDQo+IFNpZ25l
ZC1vZmYtYnk6IENvbGluIElhbiBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5jb20+DQoNClJl
dmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQoN
Cj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jIHwgMiAt
LQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jDQo+IGluZGV4IDQ4MWU0YzM4MTA4My4uODE0MTU5ZjE1
NjMzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRt
LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jDQo+IEBA
IC0xNjM2LDcgKzE2MzYsNiBAQCBzdGF0aWMgdm9pZCBhbWRncHVfdHRtX2Z3X3Jlc2VydmVfdnJh
bV9maW5pKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiAgIHN0YXRpYyBpbnQgYW1kZ3B1
X3R0bV9md19yZXNlcnZlX3ZyYW1faW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4g
ICB7DQo+ICAgCXVpbnQ2NF90IHZyYW1fc2l6ZSA9IGFkZXYtPmdtYy52aXNpYmxlX3ZyYW1fc2l6
ZTsNCj4gLQlpbnQgcjsNCj4gICANCj4gICAJYWRldi0+ZndfdnJhbV91c2FnZS52YSA9IE5VTEw7
DQo+ICAgCWFkZXYtPmZ3X3ZyYW1fdXNhZ2UucmVzZXJ2ZWRfYm8gPSBOVUxMOw0KPiBAQCAtMTY1
MSw3ICsxNjUwLDYgQEAgc3RhdGljIGludCBhbWRncHVfdHRtX2Z3X3Jlc2VydmVfdnJhbV9pbml0
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiAgIAkJCQkJICBBTURHUFVfR0VNX0RPTUFJ
Tl9WUkFNLA0KPiAgIAkJCQkJICAmYWRldi0+ZndfdnJhbV91c2FnZS5yZXNlcnZlZF9ibywNCj4g
ICAJCQkJCSAgJmFkZXYtPmZ3X3ZyYW1fdXNhZ2UudmEpOw0KPiAtCXJldHVybiByOw0KPiAgIH0N
Cj4gICANCj4gICAvKioNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

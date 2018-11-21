From: "Yang, Philip" <Philip.Yang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: disable page queue support for Vega12
Date: Wed, 21 Nov 2018 15:04:25 +0000
Message-ID: <1e279bbd-dd7d-2c1e-ae71-5f5ac89a255c@amd.com>
References: <20181121145440.4626-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181121145440.4626-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <90FCCA292C557443943611BC7D93FD1D-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

UmV2aWV3ZWQtYnk6IFBoaWxpcCBZYW5nIDxwaGlsaXAueWFuZ0BhbWQuY29tPg0KDQoNCk9uIDIw
MTgtMTEtMjEgOTo1NCBhLm0uLCBBbGV4IERldWNoZXIgd3JvdGU6DQo+IEtlZXAgaXQgZGlzYWJs
ZWQgdW50aWwgd2UgY29uZmlybSBpdCdzIHJlYWR5Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4
IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjRfMC5jIHwgNSArKystLQ0KPiAgIDEgZmlsZSBjaGFu
Z2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y0XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3NkbWFfdjRfMC5jDQo+IGluZGV4IGU2Y2IyYzM5OTk1Ny4uYTk3M2RlYTdiMjQy
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y0XzAuYw0K
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y0XzAuYw0KPiBAQCAtMTQ1
NSw5ICsxNDU1LDEwIEBAIHN0YXRpYyBib29sIHNkbWFfdjRfMF9md19zdXBwb3J0X3BhZ2luZ19x
dWV1ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4gICAJY2FzZSBDSElQX1ZFR0ExMDoN
Cj4gICAJCXJldHVybiBmd192ZXJzaW9uID49IDQzMDsNCj4gICAJY2FzZSBDSElQX1ZFR0ExMjoN
Cj4gLQkJcmV0dXJuIGZ3X3ZlcnNpb24gPj0gMzE7DQo+ICsJCS8qcmV0dXJuIGZ3X3ZlcnNpb24g
Pj0gMzE7Ki8NCj4gKwkJcmV0dXJuIGZhbHNlOw0KPiAgIAljYXNlIENISVBfVkVHQTIwOg0KPiAt
CQkvL3JldHVybiBmd192ZXJzaW9uID49IDExNTsNCj4gKwkJLypyZXR1cm4gZndfdmVyc2lvbiA+
PSAxMTU7Ki8NCj4gICAJCXJldHVybiBmYWxzZTsNCj4gICAJZGVmYXVsdDoNCj4gICAJCXJldHVy
biBmYWxzZTsNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

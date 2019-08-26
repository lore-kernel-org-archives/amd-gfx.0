From: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix a warning in smu11 i2c code
Date: Mon, 26 Aug 2019 18:57:11 +0000
Message-ID: <a078caa8-f588-de9a-86aa-277e12ee9193@amd.com>
References: <20190826185453.1793-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190826185453.1793-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <E6C485D2B91BCE4CB25140D8F79C62A7-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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

SG1tLCBteSBjb21waWxlciBkaWRuJ3Qgc2VudCBhIHdhcm5pbmcgYWJvdXQgdGhpcy4uLg0KDQpU
aGFua3MuDQoNClJldmlld2VkLWJ5OiBBbmRyZXkgR3JvZHpvdnNreSA8YW5kcmV5Lmdyb2R6b3Zz
a3lAYW1kLmNvbT4NCg0KQW5kcmV5DQoNCk9uIDgvMjYvMTkgMjo1NCBQTSwgQWxleCBEZXVjaGVy
IHdyb3RlOg0KPiBtYWtlIHN1cmUgcmVnIGlzIGluaXRpYWxpemVkIGluIHNtdV92MTFfMF9pMmNf
c2V0X2Nsb2NrX2dhdGluZy4NCj4NCj4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4
YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9zbXVfdjExXzBfaTJjLmMgfCAyICstDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9zbXVfdjExXzBfaTJjLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9z
bXVfdjExXzBfaTJjLmMNCj4gaW5kZXggNGNmY2VmMGZlZmY4Li43ZDBkNGM1N2IzMTUgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NtdV92MTFfMF9pMmMuYw0KPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zbXVfdjExXzBfaTJjLmMNCj4gQEAgLTUw
LDcgKzUwLDcgQEANCj4gICBzdGF0aWMgdm9pZCBzbXVfdjExXzBfaTJjX3NldF9jbG9ja19nYXRp
bmcoc3RydWN0IGkyY19hZGFwdGVyICpjb250cm9sLCBib29sIGVuKQ0KPiAgIHsNCj4gICAJc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSB0b19hbWRncHVfZGV2aWNlKGNvbnRyb2wpOw0KPiAt
CXVpbnQzMl90IHJlZzsNCj4gKwl1aW50MzJfdCByZWcgPSBSUkVHMzJfU09DMTUoU01VSU8sIDAs
IG1tU01VSU9fUFdSTUdUKTsNCj4gICANCj4gICAJcmVnID0gUkVHX1NFVF9GSUVMRChyZWcsIFNN
VUlPX1BXUk1HVCwgaTJjX2Nsa19nYXRlX2VuLCBlbiA/IDEgOiAwKTsNCj4gICAJV1JFRzMyX1NP
QzE1KFNNVUlPLCAwLCBtbVNNVUlPX1BXUk1HVCwgcmVnKTsNCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeA==

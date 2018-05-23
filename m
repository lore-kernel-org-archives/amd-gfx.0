From: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Remove unused variable in
 amdgpu_device_gpu_recover
Date: Wed, 23 May 2018 13:11:17 -0400
Message-ID: <2b4d2215-e1aa-cfa7-2edd-6a7fd1188c02@amd.com>
References: <20180523170819.18775-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180523170819.18775-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
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
To: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

UmV2aWV3ZWQtYnk6IEFuZHJleSBHcm9kem92c2t5IDxhbmRyZXkuZ3JvZHpvdnNreUBhbWQuY29t
PgoKQW5kcmV5CgoKT24gMDUvMjMvMjAxOCAwMTowOCBQTSwgSGFycnkgV2VudGxhbmQgd3JvdGU6
Cj4gSXQgdGhyb3dzIGFuIHVudXNlZCB2YXJpYWJsZSB3YXJuaW5nLgo+Cj4gU2lnbmVkLW9mZi1i
eTogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+Cj4gLS0tCj4gICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCAxIC0KPiAgIDEgZmlsZSBj
aGFuZ2VkLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2RldmljZS5jCj4gaW5kZXggYzE2NTRhNGRmZDgyLi41N2E0ZjM5M2FkYTMgMTAwNjQ0Cj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCj4gQEAgLTMxNzksNyAr
MzE3OSw2IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2RldmljZV9yZXNldF9zcmlvdihzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiwKPiAgIGludCBhbWRncHVfZGV2aWNlX2dwdV9yZWNvdmVyKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2LAo+ICAgCQkJICAgICAgc3RydWN0IGFtZGdwdV9qb2IgKmpv
YiwgYm9vbCBmb3JjZSkKPiAgIHsKPiAtCXN0cnVjdCBkcm1fYXRvbWljX3N0YXRlICpzdGF0ZSA9
IE5VTEw7Cj4gICAJaW50IGksIHIsIHJlc2NoZWQ7Cj4gICAKPiAgIAlpZiAoIWZvcmNlICYmICFh
bWRncHVfZGV2aWNlX2lwX2NoZWNrX3NvZnRfcmVzZXQoYWRldikpIHsKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=

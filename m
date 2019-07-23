From: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 3/3] drm/amdgpu/powerplay/vega12: call PrepareMp1ForUnload
 in power_off_asic
Date: Tue, 23 Jul 2019 20:00:55 +0000
Message-ID: <bda866af-42f0-d40d-baf3-ffbfcb2867e2@amd.com>
References: <20190723170049.9143-1-alexander.deucher@amd.com>
 <20190723170049.9143-3-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190723170049.9143-3-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <0B24ECD02447374BB162BF00500A30E9-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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

U2VyaWVzIGlzIEFja2VkLWJ5OiBBbmRyZXkgR3JvZHpvdnNreSA8YW5kcmV5Lmdyb2R6b3Zza3lA
YW1kLmNvbT4NCg0KQW5kcmV5DQoNCk9uIDcvMjMvMTkgMTowMCBQTSwgQWxleCBEZXVjaGVyIHdy
b3RlOg0KPiBOZWVkZWQgdG8gbWFrZSBzdXJlIHRoZSBzbXUgaXMgaWRsZSB3aGVuIHJlc2V0dGlu
Zy4gVGhpcyBtYXkgZml4DQo+IHNwb3JhdGljIGZhaWx1cmVzIHdpdGggR1BVIHJlc2V0Lg0KPg0K
PiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+
DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMl9o
d21nci5jIHwgNSArKysrKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCj4N
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2Ex
Ml9od21nci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3IvdmVnYTEyX2h3
bWdyLmMNCj4gaW5kZXggZWZiNmQzNzYyZmViLi4zZDM1MDQ0MTFiNjMgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMl9od21nci5jDQo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMl9od21nci5jDQo+
IEBAIC0yNDY4LDYgKzI0NjgsMTEgQEAgc3RhdGljIGludCB2ZWdhMTJfcG93ZXJfb2ZmX2FzaWMo
c3RydWN0IHBwX2h3bWdyICpod21ncikNCj4gICAJCQkpOw0KPiAgIAlkYXRhLT53YXRlcl9tYXJr
c19iaXRtYXAgJj0gfihXYXRlck1hcmtzTG9hZGVkKTsNCj4gICANCj4gKwlQUF9BU1NFUlRfV0lU
SF9DT0RFKChyZXN1bHQgPSBzbXVtX3NlbmRfbXNnX3RvX3NtYyhod21nciwNCj4gKwkJCVBQU01D
X01TR19QcmVwYXJlTXAxRm9yVW5sb2FkKSkgPT0gMCwNCj4gKwkJCSJbUHJlcGFyZU1wMUZvclVu
bG9hZF0gRmFpbGVkISIsDQo+ICsJCQlyZXR1cm4gcmVzdWx0KTsNCj4gKw0KPiAgIAlyZXR1cm4g
cmVzdWx0Ow0KPiAgIH0NCj4gICANCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeA==

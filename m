From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix gfx9 soft recovery
Date: Wed, 7 Aug 2019 11:00:57 +0200
Message-ID: <96fa3ab8-5238-8b41-05fe-6da31cdfc32f@gmail.com>
References: <20190807074023.31659-1-pierre-eric.pelloux-prayer@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190807074023.31659-1-pierre-eric.pelloux-prayer-5C7GfCeVMHo@public.gmane.org>
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
To: "Pelloux-prayer, Pierre-eric" <Pierre-eric.Pelloux-prayer-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

QW0gMDcuMDguMTkgdW0gMDk6NDAgc2NocmllYiBQZWxsb3V4LXByYXllciwgUGllcnJlLWVyaWM6
Cj4gVGhlIFNPQzE1X1JFR19PRkZTRVQoKSBtYWNybyB3YXNuJ3QgdXNlZCwgbWFraW5nIHRoZSBz
b2Z0IHJlY292ZXJ5IGZhaWwuCj4KPiB2MjogdXNlIFdSRUczMl9TT0MxNSBpbnN0ZWFkIG9mIFdS
RUczMiArIFNPQzE1X1JFR19PRkZTRVQKPgo+IFNpZ25lZC1vZmYtYnk6IFBpZXJyZS1FcmljIFBl
bGxvdXgtUHJheWVyIDxwaWVycmUtZXJpYy5wZWxsb3V4LXByYXllckBhbWQuY29tPgo+IFJldmll
d2VkLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CgpSZXZpZXdl
ZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0K
PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgfCAyICstCj4gICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYwo+IGluZGV4IGJjZDAzMDFlZWUxZS4uMWEyOTYzZTRiYzY4
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMKPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCj4gQEAgLTUzNzUsNyAr
NTM3NSw3IEBAIHN0YXRpYyB2b2lkIGdmeF92OV8wX3Jpbmdfc29mdF9yZWNvdmVyeShzdHJ1Y3Qg
YW1kZ3B1X3JpbmcgKnJpbmcsIHVuc2lnbmVkIHZtaWQpCj4gICAJdmFsdWUgPSBSRUdfU0VUX0ZJ
RUxEKHZhbHVlLCBTUV9DTUQsIE1PREUsIDB4MDEpOwo+ICAgCXZhbHVlID0gUkVHX1NFVF9GSUVM
RCh2YWx1ZSwgU1FfQ01ELCBDSEVDS19WTUlELCAxKTsKPiAgIAl2YWx1ZSA9IFJFR19TRVRfRklF
TEQodmFsdWUsIFNRX0NNRCwgVk1fSUQsIHZtaWQpOwo+IC0JV1JFRzMyKG1tU1FfQ01ELCB2YWx1
ZSk7Cj4gKwlXUkVHMzJfU09DMTUoR0MsIDAsIG1tU1FfQ01ELCB2YWx1ZSk7Cj4gICB9Cj4gICAK
PiAgIHN0YXRpYyB2b2lkIGdmeF92OV8wX3NldF9nZnhfZW9wX2ludGVycnVwdF9zdGF0ZShzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeA==

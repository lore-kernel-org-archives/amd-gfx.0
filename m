From: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/1] drm/amdgpu/gfx8: add support kernel interface
 queue(KIQ)
Date: Tue, 20 Dec 2016 17:49:27 +0800
Message-ID: <5858FEA7.9060800@amd.com>
References: <1482227322-2556-1-git-send-email-Xiangliang.Yu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1482227322-2556-1-git-send-email-Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
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
To: Xiangliang Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

CgpPbiAyMDE25bm0MTLmnIgyMOaXpSAxNzo0OCwgWGlhbmdsaWFuZyBZdSB3cm90ZToKPiArCWlm
IChraXEtPmVvcF9vYmogPT0gTlVMTCkgewo+ICsJCXIgPSBhbWRncHVfYm9fY3JlYXRlKGFkZXYs
Cj4gKwkJCQkgICAgIE1FQ19IUERfU0laRSwKPiArCQkJCSAgICAgUEFHRV9TSVpFLCB0cnVlLAo+
ICsJCQkJICAgICBBTURHUFVfR0VNX0RPTUFJTl9HVFQsIDAsIE5VTEwsIE5VTEwsCj4gKwkJCQkg
ICAgICZraXEtPmVvcF9vYmopOwo+ICsJCWlmIChyKSB7Cj4gKwkJCWRldl93YXJuKGFkZXYtPmRl
diwgIiglZCkgY3JlYXRlIEhEUCBFT1AgYm8gZmFpbGVkXG4iLCByKTsKPiArCQkJcmV0dXJuIHI7
Cj4gKwkJfQo+ICsJfQo+ICsKPiArCXIgPSBhbWRncHVfYm9fcmVzZXJ2ZShraXEtPmVvcF9vYmos
IGZhbHNlKTsKPiArCWlmICh1bmxpa2VseShyICE9IDApKSB7Cj4gKwkJZ2Z4X3Y4XzBfa2lxX2Zp
bmkoYWRldik7Cj4gKwkJcmV0dXJuIHI7Cj4gKwl9Cj4gKwo+ICsJciA9IGFtZGdwdV9ib19waW4o
a2lxLT5lb3Bfb2JqLCBBTURHUFVfR0VNX0RPTUFJTl9HVFQsCj4gKwkJCSAgJmtpcS0+ZW9wX2dw
dV9hZGRyKTsKPiArCWlmIChyKSB7Cj4gKwkJZGV2X3dhcm4oYWRldi0+ZGV2LCAiKCVkKSBwaW4g
SERQIEVPUCBibyBmYWlsZWRcbiIsIHIpOwo+ICsJCWdmeF92OF8wX2tpcV9maW5pKGFkZXYpOwo+
ICsJCXJldHVybiByOwo+ICsJfQo+ICsKPiArCXIgPSBhbWRncHVfYm9fa21hcChraXEtPmVvcF9v
YmosICh2b2lkICoqKSZocGQpOwp5b3UgY2FuIHVzZSBhbWRncHVfYm9fY3JlYXRlL2ZyZWVfa2Vy
bmVsIGhlbHBlciB0byBkbyB0aGVzZS4KClJlZ2FyZHMsCkRhdmlkIFpob3UKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH v2] drm/amdgpu: Reserve shared fence slot in
 amdgpu_vm_update_directories
Date: Tue, 3 Jul 2018 10:28:16 +0200
Message-ID: <78dcd991-2406-59f3-199a-721797a32c2c@daenzer.net>
References: <20180622164235.30770-1-michel@daenzer.net>
 <20180625090717.28522-1-michel@daenzer.net>
 <15c3905c-8e69-9d03-e506-929e4d9176e3@gmail.com> <5B3AD88D.2010604@amd.com>
 <a95367bc-1181-649d-eca0-64ec0380c6c2@amd.com> <5B3B2FE9.1000402@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <5B3B2FE9.1000402-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-CA
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
To: "Zhang, Jerry (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxOC0wNy0wMyAxMDoxMiBBTSwgWmhhbmcsIEplcnJ5IChKdW53ZWkpIHdyb3RlOgo+IAo+
IEJUVywgcmVzZXJ2YXRpb25fb2JqZWN0X3Jlc2VydmVfc2hhcmVkKCkgd2lsbCBleHRlbmQgdGhl
IG1heCBudW0gYXMgMgo+IHRpbWVzIGlmIGl0J3Mgbm90IGVub3VnaC4KPiAoZGVmYXVsdCB2YWx1
ZSBpcyA0KQoKVGhhdCdzIGFuIGltcGxlbWVudGF0aW9uIGRldGFpbCBhbmQgZGVwZW5kcyBvbiB0
aGUgY2lyY3Vtc3RhbmNlcy4gVGhlCm9ubHkgZ3VhcmFudGVlIGlzIHRoYXQgdGhlcmUncyBzcGFj
ZSBmb3IgYXQgbGVhc3Qgb25lIGZlbmNlIGFmdGVyCmNhbGxpbmcgcmVzZXJ2YXRpb25fb2JqZWN0
X3Jlc2VydmVfc2hhcmVkLCB1bnRpbApyZXNlcnZhdGlvbl9vYmplY3RfYWRkX3NoYXJlZF9mZW5j
ZSBpcyBjYWxsZWQuCgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAg
IHwgICAgICAgICAgICAgICBodHRwOi8vd3d3LmFtZC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVz
aWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=

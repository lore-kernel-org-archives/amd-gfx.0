From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: cleanup creating BOs at fixed location
Date: Tue, 17 Sep 2019 10:10:51 +0200
Message-ID: <b52f0c94-01a5-2932-db96-66ab0da47324@gmail.com>
References: <20190913120800.96299-1-christian.koenig@amd.com>
 <64e98754-d747-4004-4e8c-51a3e8bc454e@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <64e98754-d747-4004-4e8c-51a3e8bc454e-5C7GfCeVMHo@public.gmane.org>
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
To: "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>, "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, "Zhou1, Tao" <Tao.Zhou1-5C7GfCeVMHo@public.gmane.org>, "Chen, Guchun" <Guchun.Chen-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMTYuMDkuMTkgdW0gMjI6MDYgc2NocmllYiBMaSwgU3VuIHBlbmcgKExlbyk6Cj4KPiBPbiAy
MDE5LTA5LTEzIDg6MDggYS5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gW1NOSVBdCj4+
IC0JCWlmIChhbWRncHVfcmFzX3Jlc2VydmVfdnJhbShhZGV2LCBicCA8PCBQQUdFX1NISUZULAo+
PiAtCQkJCQlQQUdFX1NJWkUsICZibykpCj4+ICsJCWlmIChhbWRncHVfYm9fY3JlYXRlX2tlcm5l
bF9hdChhZGV2LCBicCA8PCBQQUdFX1NJWkUsIFBBR0VfU0laRSwKPiBJJ20gZ2V0dGluZyBhIGNv
bXBpbGUgd2FybmluZyBmcm9tIHRoZSBhYm92ZSBsaW5lOgo+Cj4gZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3Jhcy5jOjE0MDg6NDM6IHdhcm5pbmc6IGxlZnQgc2hpZnQgY291bnQg
Pj0gd2lkdGggb2YgdHlwZSBbLVdzaGlmdC1jb3VudC1vdmVyZmxvd10KPiAgIDE0MDggfCAgIGlm
IChhbWRncHVfYm9fY3JlYXRlX2tlcm5lbF9hdChhZGV2LCBicCA8PCBQQUdFX1NJWkUsIFBBR0Vf
U0laRSwKPiAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBefgo+Cj4gU2hvdWxkIGl0IGJlIDw8IFBBR0VfU0hJRlQ/CgpZZWFoLCBBbGV4IGFscmVhZHkg
Zml4ZWQgdGhhdCB1cCB5ZXN0ZXJkYXkuIFNvcnJ5IHRoYXQgSSBkaWRuJ3Qgbm90aWNlZCAKYWxs
IHRob3NlIHR5cG9zIGVhcmxpZXIsIGJ1dCBJIGRvbid0IGhhdmUgaGFyZHdhcmUgdG8gdGVzdCB0
aGlzLgoKQ2hyaXN0aWFuLgoKPgo+IFRoYW5rcywKPiBMZW8KPgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4

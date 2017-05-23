From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 5/5] drm/amd/amdgpu: Use modern 32/64-bit types in gfx6
Date: Tue, 23 May 2017 10:30:11 -0400
Message-ID: <d8801241-4e00-85e8-30d0-04f70b3f9a33@amd.com>
References: <20170515134854.26644-1-tom.stdenis@amd.com>
 <20170515134854.26644-6-tom.stdenis@amd.com>
 <BN6PR12MB16522D18D14FFC069912ECF2F7F90@BN6PR12MB1652.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB16522D18D14FFC069912ECF2F7F90-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjMvMDUvMTcgMTA6MjggQU0sIERldWNoZXIsIEFsZXhhbmRlciB3cm90ZToKPj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0KPj4gRnJvbTogYW1kLWdmeCBbbWFpbHRvOmFtZC1nZngtYm91
bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmddIE9uIEJlaGFsZgo+PiBPZiBUb20gU3QgRGVuaXMK
Pj4gU2VudDogTW9uZGF5LCBNYXkgMTUsIDIwMTcgOTo0OSBBTQo+PiBUbzogYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKPj4gQ2M6IFN0RGVuaXMsIFRvbQo+PiBTdWJqZWN0OiBbUEFUQ0gg
NS81XSBkcm0vYW1kL2FtZGdwdTogVXNlIG1vZGVybiAzMi82NC1iaXQgdHlwZXMgaW4gZ2Z4Ngo+
PiAKPj4gU3dpdGNoIHRvIHVpbnROTl90IGZyb20gInVOTiIgdHlwZXMgdG8gYmUgbW9yZSBjb25z
aXN0ZW50Cj4+IHdpdGggbW9kZXJuIGNvZGluZyBzdHlsZXMuCj4gCj4gSSB0aGluayB0ZWNobmlj
YWxseSB0aGUgdU5OIHR5cGVzIGFyZSBuYXRpdmUgZm9yIHRoZSBrZXJuZWwuICB0aGUgYzk5IAo+
IHR5cGVzIGFyZSBqdXN0IGZvciBjb252ZW5pZW5jZS4gIFNlZW1zIGxpa2UgYSBsb3Qgb2YgY2h1
cm4gdG8gbWUuCj4gCj4gQWxleAoKRmFpciBlbm91Z2ggYnV0IGFtZGdwdSBpcyBsaXR0ZXJlZCB3
aXRoIGZpbGVzIHRoYXQgdXNlIG9uZSBvciB0aGUgb3RoZXIgCm9yIHNvbWV0aW1lcyBib3RoLiAg
Oi0pCgpJIGFncmVlIGl0J3MgbG93IHByaW9yaXR5IHdoaWNoIGlzIHdoeSBJIHdhcyBhdHRhY2tp
bmcgdGhlIGxlc3NlciBhY3RpdmUgClNJIGNvZGUgOi0pCgpUaG91Z2ggSSdtIG5vdCBvZmZlbmRl
ZCBpZiB0aGV5J3JlIE5BSydlZCBlaXRoZXIgd2F5LgoKQ2hlZXJzLApUb20KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: expose amdgpu_sensors on pre-powerplay chips
Date: Wed, 15 Feb 2017 11:51:59 +0900
Message-ID: <35369b6f-b008-543a-fc0d-aa51fd0abe85@daenzer.net>
References: <20170214002301.6686-1-samuel.pitoiset@gmail.com>
 <cc9720c0-653d-f56d-e68e-032454baf324@amd.com>
 <34e0230b-2ccb-b2bd-63d9-c2477dd33bfe@gmail.com>
 <BN6PR12MB1652DD1BE92DB032AEC64C76F7580@BN6PR12MB1652.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB1652DD1BE92DB032AEC64C76F7580-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, 'Samuel Pitoiset' <samuel.pitoiset-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMTUvMDIvMTcgMDE6MTcgQU0sIERldWNoZXIsIEFsZXhhbmRlciB3cm90ZToKPj4gRnJvbTog
YW1kLWdmeCBbbWFpbHRvOmFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmddIE9u
IEJlaGFsZgo+PiBPZiBTYW11ZWwgUGl0b2lzZXQKPj4KPj4+IE90aGVyd2lzZSwgaXQgc2VlbXMg
dG8gd29yayB0aG91Z2ggdGhlIEdQVV9URU1QIHJlYWRzIGFzICI1MDAwIiBvbiBteQo+Pj4gS2F2
ZXJpIChtZWFuaW5nIHRlbXAgb2YgNUMgd2hpY2ggaXNuJ3QgdHJ1ZSkuCj4+Pgo+Pj4gSSBzdXNw
ZWN0IHRoZSBkcG0gY29kZSBpcyByZWFkaW5nIHRoZSB3cm9uZyByZWdpc3RlciB0byBnZXQgdGhl
IHRlbXAgYnV0Cj4+PiB3ZSBjYW4gZml4IHRoYXQgaW4gYW5vdGhlciBjaGFuZ2UgbGF0ZXIgb24u
Cj4+Cj4+IE5vIGlkZWEuIEl0IHdhcyBqdXN0IGEgY29weS1uLXBhc3RlLiBNYXliZSB0aGUgaW5p
dGlhbCBjb2RlIGlzIGJ1Z2d5Pwo+IAo+IEkgZG9u4oCZdCBrbm93IHRoYXQgdGhlIEdQVSB0ZW1w
IHNlbnNvciBvbiBDSSBiYXNlZCBBUFVzIGFjdHVhbGx5IHdvcmtzCj4gcHJvcGVybHkuICBJIHRo
aW5rIHRoZSBwYWNrYWdlIHRlbXBlcmF0dXJlIGlzIGV4cG9zZWQgdmlhIHRoZSBDUFUKPiB0aGVy
bWFscy4KClNlZW1zIHRvIHdvcmsgZmluZSB3aXRoIHJhZGVvbiBvbiBteSB0d28gS2F2ZXJpIGxh
cHRvcHMsIEZXSVcuCgpPbiBteSBkZXNrdG9wIEthdmVyaSwgdW5wbGF1c2libHkgbG93IHZhbHVl
cyAoYXJvdW5kIDktMTBDKSBhcmUgcmVwb3J0ZWQKYXQgaWRsZSBmb3IgYm90aCBHUFUgYW5kIENQ
VS4gV2l0aCBsb2FkLCBib3RoIGdvIHVwIHRvIGFyb3VuZCAzMEMsIHNvIGl0CnNlZW1zIGxpa2Ug
dGhlIHZhbHVlcyBtYWtlIHNlbnNlIGluIGEgcmVsYXRpdmUgc2Vuc2UgYnV0IG5vdCBpbiBhbgph
YnNvbHV0ZSBvbmUuCgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAg
IHwgICAgICAgICAgICAgICBodHRwOi8vd3d3LmFtZC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVz
aWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=

From: "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amd/powerplay: delete some dead code
Date: Thu, 21 Mar 2019 06:42:44 +0000
Message-ID: <MN2PR12MB33093EB678B90AE8B2970D26EC420@MN2PR12MB3309.namprd12.prod.outlook.com>
References: <20190321062707.GB21489@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190321062707.GB21489@kadam>
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
To: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "Gui,
 Jack" <Jack.Gui-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, "Wang,
 Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>, "kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, "Gao, Likun" <Likun.Gao-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+IEZyb206IERhbiBDYXJwZW50ZXIgW21haWx0
bzpkYW4uY2FycGVudGVyQG9yYWNsZS5jb21dCj4gU2VudDogVGh1cnNkYXksIE1hcmNoIDIxLCAy
MDE5IDI6MjcgUE0KPiBUbzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBh
bWQuY29tPgo+IENjOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29t
PjsgWmhvdSwgRGF2aWQoQ2h1bk1pbmcpCj4gPERhdmlkMS5aaG91QGFtZC5jb20+OyBEYXZpZCBB
aXJsaWUgPGFpcmxpZWRAbGludXguaWU+OyBEYW5pZWwgVmV0dGVyCj4gPGRhbmllbEBmZndsbC5j
aD47IEh1YW5nLCBSYXkgPFJheS5IdWFuZ0BhbWQuY29tPjsgV2FuZywgS2V2aW4oWWFuZykKPiA8
S2V2aW4xLldhbmdAYW1kLmNvbT47IEdhbywgTGlrdW4gPExpa3VuLkdhb0BhbWQuY29tPjsgR3Vp
LCBKYWNrCj4gPEphY2suR3VpQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zzsga2VybmVsLQo+IGphbml0b3JzQHZnZXIua2VybmVsLm9yZwo+IFN1YmplY3Q6IFtQQVRDSF0g
ZHJtL2FtZC9wb3dlcnBsYXk6IGRlbGV0ZSBzb21lIGRlYWQgY29kZQo+IAo+IFRoZSAic2l6ZSIg
dmFyaWFibGUgaXMgdW5zaWduZWQuICBXZSBuZXZlciBwYXNzIGludmFsaWQgc2l6ZXMgdG8gdGhp
cyBmdW5jdGlvbgo+IGFuZCB3ZSBhbHJlYWR5IHVzZWQgaXQgYXMgYW4gYXJyYXkgb2Zmc2V0IGVh
cmxpZXIgc28gaXQncyB0b28gbGF0ZSB0byBjaGVjayBoZXJlLgo+IAo+IFNpZ25lZC1vZmYtYnk6
IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAb3JhY2xlLmNvbT4KClRoYW5rcywgd2lsbCBh
cHBseSBpdC4KUmV2aWV3ZWQtYnk6IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+Cgo+IC0t
LQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjExXzAuYyB8IDMgLS0tCj4g
IDEgZmlsZSBjaGFuZ2VkLCAzIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjExXzAuYwo+IGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wb3dlcnBsYXkvc211X3YxMV8wLmMKPiBpbmRleCAxNzE0Mzg4OGUzN2UuLmI2MDI5NzU1NjNm
YyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjExXzAu
Ywo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92MTFfMC5jCj4gQEAg
LTE2NjgsOSArMTY2OCw2IEBAIHN0YXRpYyBpbnQKPiBzbXVfdjExXzBfc2V0X3Bvd2VyX3Byb2Zp
bGVfbW9kZShzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwgbG9uZwo+ICppbnB1dAo+ICAJfQo+IAo+
ICAJaWYgKHNtdS0+cG93ZXJfcHJvZmlsZV9tb2RlID09Cj4gUFBfU01DX1BPV0VSX1BST0ZJTEVf
Q1VTVE9NKSB7Cj4gLQkJaWYgKHNpemUgPCAwKQo+IC0JCQlyZXR1cm4gLUVJTlZBTDsKPiAtCj4g
IAkJcmV0ID0gc211X3YxMV8wX2dldF9hY3Rpdml0eV9tb25pdG9yX2NvZWZmKHNtdSwKPiAgCQkJ
CQkJCSAgICh1aW50OF90Cj4gKikoJmFjdGl2aXR5X21vbml0b3IpLAo+IAo+IFdPUktMT0FEX1BQ
TElCX0NVU1RPTV9CSVQpOwo+IC0tCj4gMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZng=

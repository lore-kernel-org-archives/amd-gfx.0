From: rezhu <rezhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/pp: silence a static checker warning
Date: Tue, 27 Mar 2018 16:59:44 +0800
Message-ID: <d09148ee-c7d7-7248-d1e5-08d349a58199@amd.com>
References: <20180323113903.GD28518@mwanda> <20180326033024.GC27239@hr-amur2>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180326033024.GC27239@hr-amur2>
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
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>, "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>, Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=ef=bf=bdnig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

QXBwbGllZC4gVGhhbmtzLgoKQmVzdCBSZWdhcmRzCgpSZXgKCk9uIDIwMTjlubQwM+aciDI25pel
IDExOjMwLCBIdWFuZyBSdWkgd3JvdGU6Cj4gT24gRnJpLCBNYXIgMjMsIDIwMTggYXQgMDI6Mzk6
MDNQTSArMDMwMCwgRGFuIENhcnBlbnRlciB3cm90ZToKPj4gVGhpcyBoYXMgYSBzdGF0aWMgY2hl
Y2tlciB3YXJuaW5nIGJlY2F1c2UgImZyZXYiIGFuZCAiY3JldiIgY2FuIGJlCj4+IHVuaW5pdGlh
bGl6ZWQgaWYgImluZm8iIGlzIE5VTEwuICBJIGp1c3QgY2hhbmdlZCB0aGUgb3JkZXIgb2YgdGhl
IGNoZWNrcwo+PiBzbyB0aGF0IHdlIGNoZWNrICJpbmZvIiBmaXJzdC4KPj4KPj4gU2lnbmVkLW9m
Zi1ieTogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBvcmFjbGUuY29tPgo+IFJldmlld2Vk
LWJ5OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPgo+Cj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9zbXU4X2h3bWdyLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9zbXU4X2h3bWdyLmMKPj4gaW5kZXggNzVhNDY1Zjc3
MWYwLi43YjI2NjA3YzY0NmEgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93
ZXJwbGF5L2h3bWdyL3NtdThfaHdtZ3IuYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bv
d2VycGxheS9od21nci9zbXU4X2h3bWdyLmMKPj4gQEAgLTMxOSwxMyArMzE5LDEzIEBAIHN0YXRp
YyBpbnQgc211OF9nZXRfc3lzdGVtX2luZm9fZGF0YShzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyKQo+
PiAgIAkJCUdldEluZGV4SW50b01hc3RlclRhYmxlKERBVEEsIEludGVncmF0ZWRTeXN0ZW1JbmZv
KSwKPj4gICAJCQkmc2l6ZSwgJmZyZXYsICZjcmV2KTsKPj4gICAKPj4gLQlpZiAoY3JldiAhPSA5
KSB7Cj4+IC0JCXByX2VycigiVW5zdXBwb3J0ZWQgSUdQIHRhYmxlOiAlZCAlZFxuIiwgZnJldiwg
Y3Jldik7Cj4+ICsJaWYgKGluZm8gPT0gTlVMTCkgewo+PiArCQlwcl9lcnIoIkNvdWxkIG5vdCBy
ZXRyaWV2ZSB0aGUgSW50ZWdyYXRlZCBTeXN0ZW0gSW5mbyBUYWJsZSFcbiIpOwo+PiAgIAkJcmV0
dXJuIC1FSU5WQUw7Cj4+ICAgCX0KPj4gICAKPj4gLQlpZiAoaW5mbyA9PSBOVUxMKSB7Cj4+IC0J
CXByX2VycigiQ291bGQgbm90IHJldHJpZXZlIHRoZSBJbnRlZ3JhdGVkIFN5c3RlbSBJbmZvIFRh
YmxlIVxuIik7Cj4+ICsJaWYgKGNyZXYgIT0gOSkgewo+PiArCQlwcl9lcnIoIlVuc3VwcG9ydGVk
IElHUCB0YWJsZTogJWQgJWRcbiIsIGZyZXYsIGNyZXYpOwo+PiAgIAkJcmV0dXJuIC1FSU5WQUw7
Cj4+ICAgCX0KPj4gICAKPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KPj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKPj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK

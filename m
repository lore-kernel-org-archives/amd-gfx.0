From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH v2] gpu: radeon: fix a potential NULL-pointer dereference
Date: Tue, 26 Mar 2019 10:51:04 +0100
Message-ID: <deadaf61-e92f-829c-8a96-7017519c5617@daenzer.net>
References: <0fc81efe-186b-3207-e0d0-b0bb95626069@daenzer.net>
 <20190325210552.12797-1-kjlu@umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190325210552.12797-1-kjlu-OJFnDUYgAso@public.gmane.org>
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
To: Kangjie Lu <kjlu-OJFnDUYgAso@public.gmane.org>
Cc: "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, pakki001-OJFnDUYgAso@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

T24gMjAxOS0wMy0yNSAxMDowNSBwLm0uLCBLYW5namllIEx1IHdyb3RlOgo+IEluIGNhc2UgYWxs
b2Nfd29ya3F1ZXVlIGZhaWxzLCB0aGUgZml4IGZyZWVzIG1lbW9yeSBhbmQKPiByZXR1cm5zIC1F
Tk9NRU0gdG8gYXZvaWQgcG90ZW50aWFsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZS4KPiAKPiBT
aWduZWQtb2ZmLWJ5OiBLYW5namllIEx1IDxramx1QHVtbi5lZHU+Cj4gLS0tCj4gdjI6IHVzZSBy
YWRlb25fY3J0Y19kZXN0cm95IHRvIHByb3Blcmx5IGNsZWFuIHVwIHJlc291cmNlcyBhcwo+IHN1
Z2dlc3RlZCBieSBNaWNoZWwgRMOkbnplciA8bWljaGVsQGRhZW56ZXIubmV0Pgo+IAo+ICBbLi4u
XQo+IAo+IEBAIC02NzEsMTMgKzY3MSwxOCBAQCBzdGF0aWMgdm9pZCByYWRlb25fY3J0Y19pbml0
KHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIGludCBpbmRleCkKPiAgCj4gIAlyYWRlb25fY3J0YyA9
IGt6YWxsb2Moc2l6ZW9mKHN0cnVjdCByYWRlb25fY3J0YykgKyAoUkFERU9ORkJfQ09OTl9MSU1J
VCAqIHNpemVvZihzdHJ1Y3QgZHJtX2Nvbm5lY3RvciAqKSksIEdGUF9LRVJORUwpOwo+ICAJaWYg
KHJhZGVvbl9jcnRjID09IE5VTEwpCj4gLQkJcmV0dXJuOwo+ICsJCXJldHVybiAtRU5PTUVNOwo+
ICAKPiAgCWRybV9jcnRjX2luaXQoZGV2LCAmcmFkZW9uX2NydGMtPmJhc2UsICZyYWRlb25fY3J0
Y19mdW5jcyk7Cj4gIAo+ICAJZHJtX21vZGVfY3J0Y19zZXRfZ2FtbWFfc2l6ZSgmcmFkZW9uX2Ny
dGMtPmJhc2UsIDI1Nik7Cj4gIAlyYWRlb25fY3J0Yy0+Y3J0Y19pZCA9IGluZGV4Owo+ICAJcmFk
ZW9uX2NydGMtPmZsaXBfcXVldWUgPSBhbGxvY193b3JrcXVldWUoInJhZGVvbi1jcnRjIiwgV1Ff
SElHSFBSSSwgMCk7Cj4gKwlpZiAoIXJhZGVvbl9jcnRjLT5mbGlwX3F1ZXVlKSB7Cj4gKwkJRFJN
X0VSUk9SKCJmYWlsZWQgdG8gYWxsb2NhdGUgdGhlIGZsaXAgcXVldWVcbiIpOwo+ICsJCXJhZGVv
bl9jcnRjX2Rlc3Ryb3koJnJhZGVvbl9jcnRjLT5iYXNlKTsKPiArCQlyZXR1cm4gLUVOT01FTTsK
PiArCX0KCnJhZGVvbl9jcnRjX2Rlc3Ryb3kgY3VycmVudGx5IHVuY29uZGl0aW9uYWxseSBjYWxs
czoKCglkZXN0cm95X3dvcmtxdWV1ZShyYWRlb25fY3J0Yy0+ZmxpcF9xdWV1ZSk7CgpBRkFJQ1Qg
ZGVzdHJveV93b3JrcXVldWUgd2lsbCBibG93IHVwIGlmIE5VTEwgaXMgcGFzc2VkIHRvIGl0LCBz
bwpyYWRlb25fY3J0Y19kZXN0cm95IG5lZWRzIHRvIGNoZWNrIGZvciB0aGF0LgoKCi0tIApFYXJ0
aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICBodHRwczov
L3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAg
ICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZng=

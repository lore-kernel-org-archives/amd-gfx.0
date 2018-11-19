From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Fix oops when pp_funcs->switch_power_profile
 is unset
Date: Mon, 19 Nov 2018 09:48:50 +0100
Message-ID: <90ff2b15-0786-63ea-1d97-6211617f40e4@gmail.com>
References: <1542318992-12464-1-git-send-email-Felix.Kuehling@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1542318992-12464-1-git-send-email-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
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
To: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

QW0gMTUuMTEuMTggdW0gMjI6NTYgc2NocmllYiBLdWVobGluZywgRmVsaXg6Cj4gT24gVmVnYTIw
IGFuZCBvdGhlciBwcmUtcHJvZHVjdGlvbiBHUFVzLCBwb3dlcnBsYXkgaXMgbm90IGVuYWJsZWQg
eWV0Lgo+IENoZWNrIGZvciBOVUxMIHBvaW50ZXJzIGJlZm9yZSBjYWxsaW5nIHBwX2Z1bmNzIGZ1
bmN0aW9uIHBvaW50ZXJzLgo+Cj4gQWxzbyBhZmZlY3RzIEthdmVyaS4KPgo+IENDOiBKb2VyZyBS
b2VkZWwgPGpyb2VkZWxAc3VzZS5kZT4KPiBTaWduZWQtb2ZmLWJ5OiBGZWxpeCBLdWVobGluZyA8
RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KCkFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJp
c3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2FtZGtmZC5jIHwgNyArKysrKy0tCj4gICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9hbWRrZmQuYwo+IGluZGV4IGE5Yzc1OTcuLjFjMWZlZDYgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5jCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5jCj4gQEAgLTUwMyw4ICs1MDMsMTEg
QEAgdm9pZCBhbWRncHVfYW1ka2ZkX3NldF9jb21wdXRlX2lkbGUoc3RydWN0IGtnZF9kZXYgKmtn
ZCwgYm9vbCBpZGxlKQo+ICAgewo+ICAgCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gKHN0
cnVjdCBhbWRncHVfZGV2aWNlICopa2dkOwo+ICAgCj4gLQlhbWRncHVfZHBtX3N3aXRjaF9wb3dl
cl9wcm9maWxlKGFkZXYsCj4gLQkJCQkJUFBfU01DX1BPV0VSX1BST0ZJTEVfQ09NUFVURSwgIWlk
bGUpOwo+ICsJaWYgKGFkZXYtPnBvd2VycGxheS5wcF9mdW5jcyAmJgo+ICsJICAgIGFkZXYtPnBv
d2VycGxheS5wcF9mdW5jcy0+c3dpdGNoX3Bvd2VyX3Byb2ZpbGUpCj4gKwkJYW1kZ3B1X2RwbV9z
d2l0Y2hfcG93ZXJfcHJvZmlsZShhZGV2LAo+ICsJCQkJCQlQUF9TTUNfUE9XRVJfUFJPRklMRV9D
T01QVVRFLAo+ICsJCQkJCQkhaWRsZSk7Cj4gICB9Cj4gICAKPiAgIGJvb2wgYW1kZ3B1X2FtZGtm
ZF9pc19rZmRfdm1pZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdTMyIHZtaWQpCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK

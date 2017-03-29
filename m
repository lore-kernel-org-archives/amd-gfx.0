From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Correct ring wptr address in debugfs (v2)
Date: Wed, 29 Mar 2017 19:50:31 +0200
Message-ID: <3bbf505a-8fe8-297e-72f2-896be27aaf77@vodafone.de>
References: <20170329174858.5462-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170329174858.5462-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
To: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>

QW0gMjkuMDMuMjAxNyB1bSAxOTo0OCBzY2hyaWViIFRvbSBTdCBEZW5pczoKPiBPbiBnZng5IGhh
cmR3YXJlIHRoZSB2YWx1ZSBpcyBub3Qgd3JhcHBlZCBhbmQgaXMgYSA2NC1iaXQgdmFsdWUuICBT
bwo+IHdlIHJlZHVjZSBpdCBtb2R1bG8gdGhlIHJpbmcgc2l6ZS4KPgo+IFNpZ25lZC1vZmYtYnk6
IFRvbSBTdCBEZW5pcyA8dG9tLnN0ZGVuaXNAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3Rp
YW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+Cj4gKHYyKSB1c2UgYnVmX21h
c2sgaW5zdGVhZCBvZiBjb21wdXRpbmcgb24gdGhlIGZseQo+IC0tLQo+ICAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3JpbmcuYyB8IDQgKystLQo+ICAgMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3JpbmcuYwo+IGluZGV4IGFjMGNlM2YyN2Y4Ny4uMTMwMzU3YmRjMjc1IDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmMKPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5jCj4gQEAgLTMyMCw4
ICszMjAsOCBAQCBzdGF0aWMgc3NpemVfdCBhbWRncHVfZGVidWdmc19yaW5nX3JlYWQoc3RydWN0
IGZpbGUgKmYsIGNoYXIgX191c2VyICpidWYsCj4gICAKPiAgIAlpZiAoKnBvcyA8IDEyKSB7Cj4g
ICAJCWVhcmx5WzBdID0gYW1kZ3B1X3JpbmdfZ2V0X3JwdHIocmluZyk7Cj4gLQkJZWFybHlbMV0g
PSBhbWRncHVfcmluZ19nZXRfd3B0cihyaW5nKTsKPiAtCQllYXJseVsyXSA9IHJpbmctPndwdHI7
Cj4gKwkJZWFybHlbMV0gPSBhbWRncHVfcmluZ19nZXRfd3B0cihyaW5nKSAmIHJpbmctPmJ1Zl9t
YXNrOwo+ICsJCWVhcmx5WzJdID0gcmluZy0+d3B0ciAmIHJpbmctPmJ1Zl9tYXNrOwo+ICAgCQlm
b3IgKGkgPSAqcG9zIC8gNDsgaSA8IDMgJiYgc2l6ZTsgaSsrKSB7Cj4gICAJCQlyID0gcHV0X3Vz
ZXIoZWFybHlbaV0sICh1aW50MzJfdCAqKWJ1Zik7Cj4gICAJCQlpZiAocikKCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK

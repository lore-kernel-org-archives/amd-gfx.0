From: Samuel Li <samuel.li-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/amdgpu: remove agp_base
Date: Mon, 15 Jan 2018 14:38:24 -0500
Message-ID: <3ca45da9-9b16-74a0-a5b6-a936d9db6e58@amd.com>
References: <20180115115105.27139-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180115115105.27139-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

ClRoZSBzZXJpZXMgIApSZXZpZXdlZC1ieTogU2FtdWVsIExpIDxTYW11ZWwuTGlAYW1kLmNvbT4K
ClNhbQoKT24gMjAxOC0wMS0xNSAwNjo1MSBBTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBO
byBBR1Agc3VwcG9ydCBmb3IgaW4gdGhpcyBkcml2ZXIuCj4gCj4gU2lnbmVkLW9mZi1ieTogQ2hy
aXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IC0tLQo+ICBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaCB8IDEgLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBk
ZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHUuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oCj4gaW5kZXggYTQw
YzgyMTgzMmMwLi42NDYyNzM4MDIxZDUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1LmgKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHUuaAo+IEBAIC01MTQsNyArNTE0LDYgQEAgc3RydWN0IGFtZGdwdV92bWh1YiB7Cj4gIHN0cnVj
dCBhbWRncHVfbWMgewo+ICAJcmVzb3VyY2Vfc2l6ZV90CQlhcGVyX3NpemU7Cj4gIAlyZXNvdXJj
ZV9zaXplX3QJCWFwZXJfYmFzZTsKPiAtCXJlc291cmNlX3NpemVfdAkJYWdwX2Jhc2U7Cj4gIAkv
KiBmb3Igc29tZSBjaGlwcyB3aXRoIDw9IDMyTUIgd2UgbmVlZCB0byBsaWUKPiAgCSAqIGFib3V0
IHZyYW0gc2l6ZSBuZWFyIG1jIGZiIGxvY2F0aW9uICovCj4gIAl1NjQJCQltY192cmFtX3NpemU7
Cj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=

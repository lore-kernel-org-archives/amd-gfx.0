From: "Zhang, Jerry (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/amd: fix init order of sched job
Date: Tue, 9 May 2017 16:33:36 +0800
Message-ID: <59117EE0.2040007@amd.com>
References: <1494317649-16751-1-git-send-email-David1.Zhou@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1494317649-16751-1-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
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
To: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMDUvMDkvMjAxNyAwNDoxNCBQTSwgQ2h1bm1pbmcgWmhvdSB3cm90ZToKPiBDaGFuZ2UtSWQ6
IEljZWQzOTFmNWMyNGE3OWFkN2FlY2FlMzNlMjJmZjA4OWY2OGYxMzM3Cj4gU2lnbmVkLW9mZi1i
eTogQ2h1bm1pbmcgWmhvdSA8RGF2aWQxLlpob3VAYW1kLmNvbT4KCkdvb2QgY2F0Y2ghClJldmll
d2VkLWJ5OiBKdW53ZWkgWmhhbmcgPEplcnJ5LlpoYW5nQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9zY2hlZHVsZXIvZ3B1X3NjaGVkdWxlci5jIHwgMiArLQo+ICAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9zY2hlZHVsZXIvZ3B1X3NjaGVkdWxlci5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9zY2hlZHVsZXIvZ3B1X3NjaGVkdWxlci5jCj4gaW5kZXggODBiYzRmNy4u
M2MyNThjMyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3NjaGVkdWxlci9ncHVf
c2NoZWR1bGVyLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3NjaGVkdWxlci9ncHVfc2No
ZWR1bGVyLmMKPiBAQCAtNDYwLDkgKzQ2MCw5IEBAIGludCBhbWRfc2NoZWRfam9iX2luaXQoc3Ry
dWN0IGFtZF9zY2hlZF9qb2IgKmpvYiwKPiAgIAlqb2ItPnNjaGVkID0gc2NoZWQ7Cj4gICAJam9i
LT5zX2VudGl0eSA9IGVudGl0eTsKPiAgIAlqb2ItPnNfZmVuY2UgPSBhbWRfc2NoZWRfZmVuY2Vf
Y3JlYXRlKGVudGl0eSwgb3duZXIpOwo+IC0Jam9iLT5pZCA9IGF0b21pYzY0X2luY19yZXR1cm4o
JnNjaGVkLT5qb2JfaWRfY291bnQpOwo+ICAgCWlmICgham9iLT5zX2ZlbmNlKQo+ICAgCQlyZXR1
cm4gLUVOT01FTTsKPiArCWpvYi0+aWQgPSBhdG9taWM2NF9pbmNfcmV0dXJuKCZzY2hlZC0+am9i
X2lkX2NvdW50KTsKPgo+ICAgCUlOSVRfV09SSygmam9iLT5maW5pc2hfd29yaywgYW1kX3NjaGVk
X2pvYl9maW5pc2gpOwo+ICAgCUlOSVRfTElTVF9IRUFEKCZqb2ItPm5vZGUpOwo+Cl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=

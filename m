From: "Zhang, Jerry (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/amdgpu: fix the incorrect scratch reg number
 on gfx v8
Date: Thu, 20 Jul 2017 15:40:40 +0800
Message-ID: <59705E78.4060802@amd.com>
References: <1500536173-19621-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1500536173-19621-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

dGhlIHNlcmlhbCBvZiBwYXRjaCBhcmUKClJldmlld2VkLWJ5OiBKdW53ZWkgWmhhbmcgPEplcnJ5
LlpoYW5nQGFtZC5jb20+CgpPbiAwNy8yMC8yMDE3IDAzOjM2IFBNLCBIdWFuZyBSdWkgd3JvdGU6
Cj4gU2lnbmVkLW9mZi1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KPiAtLS0KPiAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMgfCAyICstCj4gICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ2Z4X3Y4XzAuYwo+IGluZGV4IDE4MWViYTUuLmI1OGQ5OGQgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYwo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMKPiBAQCAtNzUwLDcgKzc1MCw3IEBAIHN0YXRp
YyB2b2lkIGdmeF92OF8wX2luaXRfZ29sZGVuX3JlZ2lzdGVycyhzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldikKPgo+ICAgc3RhdGljIHZvaWQgZ2Z4X3Y4XzBfc2NyYXRjaF9pbml0KHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2KQo+ICAgewo+IC0JYWRldi0+Z2Z4LnNjcmF0Y2gubnVtX3JlZyA9
IDc7Cj4gKwlhZGV2LT5nZnguc2NyYXRjaC5udW1fcmVnID0gODsKPiAgIAlhZGV2LT5nZnguc2Ny
YXRjaC5yZWdfYmFzZSA9IG1tU0NSQVRDSF9SRUcwOwo+ICAgCWFkZXYtPmdmeC5zY3JhdGNoLmZy
ZWVfbWFzayA9ICgxdSA8PCBhZGV2LT5nZnguc2NyYXRjaC5udW1fcmVnKSAtIDE7Cj4gICB9Cj4K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

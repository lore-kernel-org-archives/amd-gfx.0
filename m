From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Adjust IB test timeout for XGMI configuration
Date: Wed, 3 Apr 2019 09:55:56 +0200
Message-ID: <40dae9f8-cabd-d6ad-c6de-07902e6c5069@gmail.com>
References: <1554228693-28822-1-git-send-email-shaoyun.liu@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1554228693-28822-1-git-send-email-shaoyun.liu-5C7GfCeVMHo@public.gmane.org>
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
To: "Liu, Shaoyun" <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMDIuMDQuMTkgdW0gMjA6MTIgc2NocmllYiBMaXUsIFNoYW95dW46Cj4gT24gWEdNSSBjb25m
aWd1cmF0aW9uIHRoZSBpYiB0ZXN0IG1heSB0b29rcyBsb25nZXIgdG8gZmluaXNoCj4KPiBDaGFu
Z2UtSWQ6IElmM2FmZDhlYWMzYzM0MmQzMmMzODc4MDRiNTFmYzRhNGJkZDM1ZDM1Cj4gU2lnbmVk
LW9mZi1ieTogc2hhb3l1bmwgPHNoYW95dW4ubGl1QGFtZC5jb20+Cj4gLS0tCj4gICBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWIuYyB8IDMgKysrCj4gICAxIGZpbGUgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2liLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWIu
Ywo+IGluZGV4IDBiOGVmMmQuLjQ1ZjI1MWYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2liLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfaWIuYwo+IEBAIC0zNDYsNiArMzQ2LDkgQEAgaW50IGFtZGdwdV9pYl9yaW5nX3Rl
c3RzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+ICAgCQl0bW9fZ2Z4ID0gOCAqIEFNREdQ
VV9JQl9URVNUX1RJTUVPVVQ7Cj4gICAJfQo+ICAgCj4gKwlpZiAoYWRldi0+Z21jLnhnbWkuaGl2
ZV9pZCkKPiArCQl0bW9fZ2Z4ID0gMiAqIEFNREdQVV9JQl9URVNUX1RJTUVPVVQ7Cj4gKwoKUHJv
YmFibHkgYmV0dGVyIHRvIHVzZSBhbiAiZWxzZSBpZiIgdG8gbm90ZSB0aGF0IHRob3NlIHR3byBt
dXR1YWwgZXhjbHVzaXZlLgoKQWRkaXRpb25hbCB0byB0aGF0IEkgdGhpbmsgaXQgaXMgdGltZSBu
b3cgdG8gYWRkIApBTURHUFVfSUJfVEVTVF9HRlhfWEdNSV9USU1FT1VUIGRlZmluZSBpbnN0ZWFk
IG9mIGp1c3QgYWJ1c2luZyB0aGUgCmV4aXN0aW5nIG9uZSBvdmVyIGFuZCBvdmVyIGFnYWluIChz
YW1lIG9mIGNvdXJzZSBmb3IgdGhlIFNSSU9WIGNhc2UpLgoKQ2hyaXN0aWFuLgoKPiAgIAlmb3Ig
KGkgPSAwOyBpIDwgYWRldi0+bnVtX3JpbmdzOyArK2kpIHsKPiAgIAkJc3RydWN0IGFtZGdwdV9y
aW5nICpyaW5nID0gYWRldi0+cmluZ3NbaV07Cj4gICAJCWxvbmcgdG1vOwoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

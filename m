From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/gmc9: clarify GPUVM fault error message
Date: Wed, 25 Jul 2018 10:35:36 +0200
Message-ID: <6ca9d353-2a89-dc1c-1480-6309d24c8e2b@gmail.com>
References: <20180724165414.24442-1-alexander.deucher@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180724165414.24442-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

QW0gMjQuMDcuMjAxOCB1bSAxODo1NCBzY2hyaWViIEFsZXggRGV1Y2hlcjoKPiBUaGUgYWRkcmVz
cyBwcmludGVkIGlzIHRoZSBhY3R1YWwgYWRkcmVzcywgbm90IHRoZSBwYWdlLgo+Cj4gU2lnbmVk
LW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgoKUmV2aWV3
ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0t
Cj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jIHwgMiArLQo+ICAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2dtY192OV8wLmMKPiBpbmRleCA5ZGY5NGI0NWQxN2QuLjM5OWE1ZGIyNzY0
OSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYwo+IEBAIC0yNjksNyAr
MjY5LDcgQEAgc3RhdGljIGludCBnbWNfdjlfMF9wcm9jZXNzX2ludGVycnVwdChzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiwKPiAgIAkJCWVudHJ5LT5zcmNfaWQsIGVudHJ5LT5yaW5nX2lkLCBl
bnRyeS0+dm1pZCwKPiAgIAkJCWVudHJ5LT5wYXNpZCwgdGFza19pbmZvLnByb2Nlc3NfbmFtZSwg
dGFza19pbmZvLnRnaWQsCj4gICAJCQl0YXNrX2luZm8udGFza19uYW1lLCB0YXNrX2luZm8ucGlk
KTsKPiAtCQlkZXZfZXJyKGFkZXYtPmRldiwgIiAgYXQgcGFnZSAweCUwMTZsbHggZnJvbSAlZFxu
IiwKPiArCQlkZXZfZXJyKGFkZXYtPmRldiwgIiAgYXQgYWRkcmVzcyAweCUwMTZsbHggZnJvbSAl
ZFxuIiwKPiAgIAkJCWFkZHIsIGVudHJ5LT5jbGllbnRfaWQpOwo+ICAgCQlpZiAoIWFtZGdwdV9z
cmlvdl92ZihhZGV2KSkKPiAgIAkJCWRldl9lcnIoYWRldi0+ZGV2LAoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

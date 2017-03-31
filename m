From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/powerplay: fix locking typo
Date: Fri, 31 Mar 2017 17:01:14 +0200
Message-ID: <4bacb95f-7e64-022f-97a9-dd384892c2a0@vodafone.de>
References: <1490972090-14071-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1490972090-14071-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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

QW0gMzEuMDMuMjAxNyB1bSAxNjo1NCBzY2hyaWViIEFsZXggRGV1Y2hlcjoKPiBGaXhlczogMmE1
MDcxMDU2ZTZhNjAxZSAoImRybS9hbWQvcG93ZXJwbGF5OiBhZGQgZ2xvYmFsIFBvd2VyUGxheSBt
dXRleC4iKQo+IFJlcG9ydGVkLWJ5OiBKdWxpYSBMYXdhbGwgPGp1bGlhLmxhd2FsbEBsaXA2LmZy
Pgo+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNv
bT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5j
b20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kX3Bvd2VycGxh
eS5jIHwgMiArLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kX3Bv
d2VycGxheS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kX3Bvd2VycGxheS5j
Cj4gaW5kZXggZGZkNGZlNi4uNmYwZWQwNyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL3Bvd2VycGxheS9hbWRfcG93ZXJwbGF5LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L3Bvd2VycGxheS9hbWRfcG93ZXJwbGF5LmMKPiBAQCAtODk0LDcgKzg5NCw3IEBAIHN0YXRpYyBp
bnQgcHBfZHBtX3NldF9zY2xrX29kKHZvaWQgKmhhbmRsZSwgdWludDMyX3QgdmFsdWUpCj4gICAK
PiAgIAltdXRleF9sb2NrKCZwcF9oYW5kbGUtPnBwX2xvY2spOwo+ICAgCXJldCA9IGh3bWdyLT5o
d21ncl9mdW5jLT5zZXRfc2Nsa19vZChod21nciwgdmFsdWUpOwo+IC0JbXV0ZXhfbG9jaygmcHBf
aGFuZGxlLT5wcF9sb2NrKTsKPiArCW11dGV4X3VubG9jaygmcHBfaGFuZGxlLT5wcF9sb2NrKTsK
PiAgIAlyZXR1cm4gcmV0Owo+ICAgfQo+ICAgCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==

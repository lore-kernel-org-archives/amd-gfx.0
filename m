From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/6] drm/amdgpu: add VCN JPEG support
 amdgpu_ctx_num_entities
Date: Wed, 28 Nov 2018 09:12:10 +0100
Message-ID: <38be7a9a-9482-8b7a-cae7-2249dc921e8c@gmail.com>
References: <20181127211037.20910-1-alexander.deucher@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181127211037.20910-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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

TWF5YmUgZHJvcCBwYXRjaCAjMiB3aGVuIHlvdSByZWZhY3RvciB0aGF0IGNvZGUgaW4gcGF0Y2gg
IzMgYW5kICM0IGFueXdheS4KCk9uIHBhdGNoICMzIEkgd291bGQgcHV0IHRoZSBuZXcgaGVscGVy
IGludG8gYW1kZ3B1X2N0eC5jIGluc3RlYWQgYmVjYXVzZSAKdGhhdCBpcyByYXRoZXIgaG93IHJp
bmdzIG1hcCB0byB1c2Vyc3BhY2UgcXVldWVzLgoKQXBhcnQgZnJvbSB0aGF0IGl0IGxvb2tzIGdv
b2QgdG8gbWUuCgpDaHJpc3RpYW4uCgpBbSAyNy4xMS4xOCB1bSAyMjoxMCBzY2hyaWViIEFsZXgg
RGV1Y2hlcjoKPiBMb29rcyBsaWtlIGl0IHdhcyBtaXNzZWQgd2hlbiBzZXR0aW5nIHN1cHBvcnQg
d2FzIGFkZGVkLgo+Cj4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1
Y2hlckBhbWQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2N0eC5jIHwgMSArCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPgo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMKPiBpbmRleCBmOWI1NDIzNjEwMmQuLjk1
ZjRjNDEzOWZjNiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfY3R4LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMK
PiBAQCAtMzksNiArMzksNyBAQCBjb25zdCB1bnNpZ25lZCBpbnQgYW1kZ3B1X2N0eF9udW1fZW50
aXRpZXNbQU1ER1BVX0hXX0lQX05VTV0gPSB7Cj4gICAJW0FNREdQVV9IV19JUF9VVkRfRU5DXQk9
CTEsCj4gICAJW0FNREdQVV9IV19JUF9WQ05fREVDXQk9CTEsCj4gICAJW0FNREdQVV9IV19JUF9W
Q05fRU5DXQk9CTEsCj4gKwlbQU1ER1BVX0hXX0lQX1ZDTl9KUEVHXQk9CTEsCj4gICB9Owo+ICAg
Cj4gICBzdGF0aWMgaW50IGFtZGdwdXRfY3R4X3RvdGFsX251bV9lbnRpdGllcyh2b2lkKQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

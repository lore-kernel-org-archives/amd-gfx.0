From: zhoucm1 <zhoucm1-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: add the checking to avoid NULL pointer
 dereference
Date: Thu, 22 Nov 2018 15:00:40 +0800
Message-ID: <881e2f9e-6c00-f3ad-a6aa-345accb6f4a5@amd.com>
References: <20181122065523.5510-1-Deepak.Sharma@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181122065523.5510-1-Deepak.Sharma-5C7GfCeVMHo@public.gmane.org>
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
To: "Sharma, Deepak" <Deepak.Sharma-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>

CgpPbiAyMDE45bm0MTHmnIgyMuaXpSAxNDo1NiwgU2hhcm1hLCBEZWVwYWsgd3JvdGU6Cj4gd2hl
biByZXR1cm5lZCBmZW5jZSBpcyBub3QgdmFsaWQgbW9zdGx5IGR1ZSB0byB1c2Vyc3BhY2UgaWdu
b3JlZAo+IHByZXZpb3VzIGVycm9yIGNhdXNlcyBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UuCj4K
PiBTaWduZWQtb2ZmLWJ5OiBEZWVwYWsgU2hhcm1hIDxEZWVwYWsuU2hhcm1hQGFtZC5jb20+ClJl
dmlld2VkLWJ5OiBDaHVubWluZyBaaG91IDxkYXZpZDEuemhvdUBhbWQuY29tPgoKPiAtLS0KPiAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jIHwgMiArKwo+ICAgMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2NzLmMKPiBpbmRleCAwMjRkZmJkODdmMTEuLjE0MTY2Y2Q4YTEyZiAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYwo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jCj4gQEAgLTE0MDMsNiArMTQwMyw4IEBAIHN0
YXRpYyBzdHJ1Y3QgZG1hX2ZlbmNlICphbWRncHVfY3NfZ2V0X2ZlbmNlKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2LAo+ICAgCj4gICAJZmVuY2UgPSBhbWRncHVfY3R4X2dldF9mZW5jZShjdHgs
IGVudGl0eSwgdXNlci0+c2VxX25vKTsKPiAgIAlhbWRncHVfY3R4X3B1dChjdHgpOwo+ICsJaWYo
IWZlbmNlKQo+ICsJCXJldHVybiBFUlJfUFRSKC1FSU5WQUwpOwo+ICAgCj4gICAJcmV0dXJuIGZl
bmNlOwo+ICAgfQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

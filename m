From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Free resources of bo_list when idr_alloc fails
Date: Thu, 6 Jul 2017 09:24:09 +0200
Message-ID: <0abd8bd7-37bd-42a8-28d6-a46da66bafd3@vodafone.de>
References: <1499293623-24544-1-git-send-email-AlexBin.Xie@amd.com>
 <595DA5FA.5020609@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <595DA5FA.5020609-5C7GfCeVMHo@public.gmane.org>
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
To: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>, Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

UmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWc8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoK
QW0gMDYuMDcuMjAxNyB1bSAwNDo1MiBzY2hyaWViIHpob3VjbTE6Cj4gUmV2aWV3ZWQtYnk6IENo
dW5taW5nIFpob3UgPGRhdmlkMS56aG91QGFtZC5jb20+Cj4KPiBPbiAyMDE35bm0MDfmnIgwNuaX
pSAwNjoyNywgQWxleCBYaWUgd3JvdGU6Cj4+IFNpZ25lZC1vZmYtYnk6IEFsZXggWGllIDxBbGV4
QmluLlhpZUBhbWQuY29tPgo+PiAtLS0KPj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfYm9fbGlzdC5jIHwgMiArLQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2JvX2xpc3QuYyAKPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfYm9fbGlzdC5jCj4+IGluZGV4IGVmYTY5MDMuLmRjODc5NjIgMTAwNjQ0Cj4+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9ib19saXN0LmMKPj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2JvX2xpc3QuYwo+PiBAQCAtODMsNyArODMs
NyBAQCBzdGF0aWMgaW50IGFtZGdwdV9ib19saXN0X2NyZWF0ZShzdHJ1Y3QgCj4+IGFtZGdwdV9k
ZXZpY2UgKmFkZXYsCj4+ICAgICAgIHIgPSBpZHJfYWxsb2MoJmZwcml2LT5ib19saXN0X2hhbmRs
ZXMsIGxpc3QsIDEsIDAsIEdGUF9LRVJORUwpOwo+PiAgICAgICBtdXRleF91bmxvY2soJmZwcml2
LT5ib19saXN0X2xvY2spOwo+PiAgICAgICBpZiAociA8IDApIHsKPj4gLSAgICAgICAga2ZyZWUo
bGlzdCk7Cj4+ICsgICAgICAgIGFtZGdwdV9ib19saXN0X2ZyZWUobGlzdCk7Cj4+ICAgICAgICAg
ICByZXR1cm4gcjsKPj4gICAgICAgfQo+PiAgICAgICAqaWQgPSByOwo+Cj4gX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlz
dAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4CgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==

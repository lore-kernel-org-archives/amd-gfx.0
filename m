From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu:Fixed wrong emit frame size for enc
Date: Tue, 27 Feb 2018 16:13:00 +0100
Message-ID: <250baf31-8107-5c4e-000c-afff9245d5d7@gmail.com>
References: <1519743965-11792-1-git-send-email-James.Zhu@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1519743965-11792-1-git-send-email-James.Zhu-5C7GfCeVMHo@public.gmane.org>
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
To: James Zhu <James.Zhu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

WW91IGFyZSB1c2luZyBvdXRkYXRlZCBjb2RlLCB0aGF0IGhhcyBhbHJlYWR5IGJlIGZpeGVkIG9u
IAphbWQtc3RhZ2luZy1kcm0tbmV4dC4KCkNocmlzdGlhbi4KCkFtIDI3LjAyLjIwMTggdW0gMTY6
MDYgc2NocmllYiBKYW1lcyBaaHU6Cj4gRW1pdCBmcmFtZSBzaXplIHNob3VsZCBtYXRjaCB3aXRo
IGNvcnJlc3BvbmRpbmcgZnVuY3Rpb24sCj4gdXZkX3Y2XzBfZW5jX3JpbmdfZW1pdF92bV9mbHVz
aCBoYXMgNSBhbWRncHVfcmluZ193cml0ZQo+Cj4gU2lnbmVkLW9mZi1ieTogSmFtZXMgWmh1IDxK
YW1lcy5aaHVAYW1kLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2
ZF92Nl8wLmMgfCAyICstCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRf
djZfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y2XzAuYwo+IGluZGV4IGEz
ZTY0ZTIuLmYyNmY1MTUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
dXZkX3Y2XzAuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92Nl8wLmMK
PiBAQCAtMTU4MCw3ICsxNTgwLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBhbWRncHVfcmluZ19m
dW5jcyB1dmRfdjZfMF9lbmNfcmluZ192bV9mdW5jcyA9IHsKPiAgIAkuc2V0X3dwdHIgPSB1dmRf
djZfMF9lbmNfcmluZ19zZXRfd3B0ciwKPiAgIAkuZW1pdF9mcmFtZV9zaXplID0KPiAgIAkJNCAr
IC8qIHV2ZF92Nl8wX2VuY19yaW5nX2VtaXRfcGlwZWxpbmVfc3luYyAqLwo+IC0JCTYgKyAvKiB1
dmRfdjZfMF9lbmNfcmluZ19lbWl0X3ZtX2ZsdXNoICovCj4gKwkJNSArIC8qIHV2ZF92Nl8wX2Vu
Y19yaW5nX2VtaXRfdm1fZmx1c2ggKi8KPiAgIAkJNSArIDUgKyAvKiB1dmRfdjZfMF9lbmNfcmlu
Z19lbWl0X2ZlbmNlIHgyIHZtIGZlbmNlICovCj4gICAJCTEsIC8qIHV2ZF92Nl8wX2VuY19yaW5n
X2luc2VydF9lbmQgKi8KPiAgIAkuZW1pdF9pYl9zaXplID0gNSwgLyogdXZkX3Y2XzBfZW5jX3Jp
bmdfZW1pdF9pYiAqLwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

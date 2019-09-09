From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/1] drm/amdgpu: Fix KFD-related kernel oops on Hawaii
Date: Mon, 9 Sep 2019 13:27:58 +0200
Message-ID: <459c18b6-9b85-14b1-d42c-a49896df77ce@gmail.com>
References: <20190905232915.5537-1-Felix.Kuehling@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190905232915.5537-1-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
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
To: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMDYuMDkuMTkgdW0gMDE6Mjkgc2NocmllYiBLdWVobGluZywgRmVsaXg6Cj4gSGF3YWlpIG5l
ZWRzIHRvIGZsdXNoIGNhY2hlcyBleHBsaWNpdGx5LCBzdWJtaXR0aW5nIGFuIElCIGluIGEgdXNl
cgo+IFZNSUQgZnJvbSBrZXJuZWwgbW9kZS4gVGhlcmUgaXMgbm8gc19mZW5jZSBpbiB0aGlzIGNh
c2UuCj4KPiBGaXhlczogZWIzOTYxYTU3NDI0ICgiZHJtL2FtZGdwdTogcmVtb3ZlIGZlbmNlIGNv
bnRleHQgZnJvbSB0aGUgam9iIikKPiBTaWduZWQtb2ZmLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVs
aXguS3VlaGxpbmdAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJp
c3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2liLmMgfCAzICsrLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9pYi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2liLmMK
PiBpbmRleCA2ODgyZWViOTNiNGUuLmQ4MWUxNDFhMzNmYSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWIuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9pYi5jCj4gQEAgLTE0MSw3ICsxNDEsOCBAQCBpbnQgYW1kZ3B1X2li
X3NjaGVkdWxlKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywgdW5zaWduZWQgbnVtX2licywKPiAg
IAkvKiByaW5nIHRlc3RzIGRvbid0IHVzZSBhIGpvYiAqLwo+ICAgCWlmIChqb2IpIHsKPiAgIAkJ
dm0gPSBqb2ItPnZtOwo+IC0JCWZlbmNlX2N0eCA9IGpvYi0+YmFzZS5zX2ZlbmNlLT5zY2hlZHVs
ZWQuY29udGV4dDsKPiArCQlmZW5jZV9jdHggPSBqb2ItPmJhc2Uuc19mZW5jZSA/Cj4gKwkJCWpv
Yi0+YmFzZS5zX2ZlbmNlLT5zY2hlZHVsZWQuY29udGV4dCA6IDA7Cj4gICAJfSBlbHNlIHsKPiAg
IAkJdm0gPSBOVUxMOwo+ICAgCQlmZW5jZV9jdHggPSAwOwoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4

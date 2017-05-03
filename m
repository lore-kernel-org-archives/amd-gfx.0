From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 1/6] drm/amdgpu:fix cannot receive rcv/ack irq bug
Date: Wed, 3 May 2017 11:05:50 +0200
Message-ID: <18a844c9-ed0c-ca1d-c542-21aa114c66dc@vodafone.de>
References: <1493783292-2661-1-git-send-email-Monk.Liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1493783292-2661-1-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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
To: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMDMuMDUuMjAxNyB1bSAwNTo0OCBzY2hyaWViIE1vbmsgTGl1Ogo+IENoYW5nZS1JZDogSWU4
NjcyZTBjOTM1OGQ5NTQyODEwY2UwNWM4MjJkOTM2NzI0OWJiZDcKPiBTaWduZWQtb2ZmLWJ5OiBN
b25rIExpdSA8TW9uay5MaXVAYW1kLmNvbT4KCkFja2VkLWJ5OiBDaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbXhncHVfYWkuYyB8
IDQgKystLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9teGdwdV9haS5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbXhncHVfYWkuYwo+IGluZGV4IDE0OTMzMDEu
LjcxMmYzNmUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbXhncHVf
YWkuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L214Z3B1X2FpLmMKPiBAQCAt
Mjk2LDExICsyOTYsMTEgQEAgaW50IHhncHVfYWlfbWFpbGJveF9hZGRfaXJxX2lkKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2KQo+ICAgewo+ICAgCWludCByOwo+ICAgCj4gLQlyID0gYW1kZ3B1
X2lycV9hZGRfaWQoYWRldiwgQU1ER1BVX0lIX0NMSUVOVElEX0xFR0FDWSwgMTM1LCAmYWRldi0+
dmlydC5yY3ZfaXJxKTsKPiArCXIgPSBhbWRncHVfaXJxX2FkZF9pZChhZGV2LCBBTURHUFVfSUhf
Q0xJRU5USURfQklGLCAxMzUsICZhZGV2LT52aXJ0LnJjdl9pcnEpOwo+ICAgCWlmIChyKQo+ICAg
CQlyZXR1cm4gcjsKPiAgIAo+IC0JciA9IGFtZGdwdV9pcnFfYWRkX2lkKGFkZXYsIEFNREdQVV9J
SF9DTElFTlRJRF9MRUdBQ1ksIDEzOCwgJmFkZXYtPnZpcnQuYWNrX2lycSk7Cj4gKwlyID0gYW1k
Z3B1X2lycV9hZGRfaWQoYWRldiwgQU1ER1BVX0lIX0NMSUVOVElEX0JJRiwgMTM4LCAmYWRldi0+
dmlydC5hY2tfaXJxKTsKPiAgIAlpZiAocikgewo+ICAgCQlhbWRncHVfaXJxX3B1dChhZGV2LCAm
YWRldi0+dmlydC5yY3ZfaXJxLCAwKTsKPiAgIAkJcmV0dXJuIHI7CgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

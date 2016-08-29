From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: debugfs SMC addresses are byte addresses
Date: Mon, 29 Aug 2016 15:52:24 +0200
Message-ID: <efb0ac58-159a-4d77-af37-d64f8f264f17@vodafone.de>
References: <20160829130614.606-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20160829130614.606-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
To: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>

QW0gMjkuMDguMjAxNiB1bSAxNTowNiBzY2hyaWViIFRvbSBTdCBEZW5pczoKPiBTaWduZWQtb2Zm
LWJ5OiBUb20gU3QgRGVuaXMgPHRvbS5zdGRlbmlzQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hy
aXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDQgKystLQo+ICAgMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPiBpbmRleCAxYjMxYTdjMWQyMTcuLjI4
OGNmYjRmYTJiYSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZGV2aWNlLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2
aWNlLmMKPiBAQCAtMjY3OCw3ICsyNjc4LDcgQEAgc3RhdGljIHNzaXplX3QgYW1kZ3B1X2RlYnVn
ZnNfcmVnc19zbWNfcmVhZChzdHJ1Y3QgZmlsZSAqZiwgY2hhciBfX3VzZXIgKmJ1ZiwKPiAgIAl3
aGlsZSAoc2l6ZSkgewo+ICAgCQl1aW50MzJfdCB2YWx1ZTsKPiAgIAo+IC0JCXZhbHVlID0gUlJF
RzMyX1NNQygqcG9zID4+IDIpOwo+ICsJCXZhbHVlID0gUlJFRzMyX1NNQygqcG9zKTsKPiAgIAkJ
ciA9IHB1dF91c2VyKHZhbHVlLCAodWludDMyX3QgKilidWYpOwo+ICAgCQlpZiAocikKPiAgIAkJ
CXJldHVybiByOwo+IEBAIC0yNzA5LDcgKzI3MDksNyBAQCBzdGF0aWMgc3NpemVfdCBhbWRncHVf
ZGVidWdmc19yZWdzX3NtY193cml0ZShzdHJ1Y3QgZmlsZSAqZiwgY29uc3QgY2hhciBfX3VzZXIg
Kgo+ICAgCQlpZiAocikKPiAgIAkJCXJldHVybiByOwo+ICAgCj4gLQkJV1JFRzMyX1NNQygqcG9z
ID4+IDIsIHZhbHVlKTsKPiArCQlXUkVHMzJfU01DKCpwb3MsIHZhbHVlKTsKPiAgIAo+ICAgCQly
ZXN1bHQgKz0gNDsKPiAgIAkJYnVmICs9IDQ7CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==

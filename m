From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 13/42] drm/amd/display: Add bios firmware info version for
 VG12
Date: Thu, 22 Mar 2018 10:14:13 -0400
Message-ID: <ad087ef2-58e1-bf2f-7556-3fd08c716e65@amd.com>
References: <20180321134639.18782-1-alexander.deucher@amd.com>
 <20180321134639.18782-13-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180321134639.18782-13-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, "Jerry (Fangzhi) Zuo" <Jerry.Zuo-5C7GfCeVMHo@public.gmane.org>

T24gMjAxOC0wMy0yMSAwOTo0NiBBTSwgQWxleCBEZXVjaGVyIHdyb3RlOgo+IEZyb206ICJKZXJy
eSAoRmFuZ3poaSkgWnVvIiA8SmVycnkuWnVvQGFtZC5jb20+Cj4gCj4gVkcxMiBzaG93cyBtaW5v
ciByZXZpc2lvbiB2ZXJzaW9uIG9mIDIgd2hpY2ggaXMgbm90IGhhbmRsZWQgaW4KPiBiaW9zX3Bh
cnNlcl9nZXRfZmlybXdhcmVfaW5mbygpIHJvdXRpbmUuCj4gCj4gU2lnbmVkLW9mZi1ieTogSmVy
cnkgKEZhbmd6aGkpIFp1byA8SmVycnkuWnVvQGFtZC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogQWxl
eCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgoKUmV2aWV3ZWQtYnk6IEhhcnJ5
IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgoKSGFycnkKCj4gLS0tCj4gIGRyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9iaW9zL2Jpb3NfcGFyc2VyMi5jIHwgMSArCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvYmlvcy9iaW9zX3BhcnNlcjIuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9kYy9iaW9zL2Jpb3NfcGFyc2VyMi5jCj4gaW5kZXggZTc2ODBjNDFmMTE3
Li45ODVmZThjMjI4NzUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2Jpb3MvYmlvc19wYXJzZXIyLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvZGMvYmlvcy9iaW9zX3BhcnNlcjIuYwo+IEBAIC0xMzIxLDYgKzEzMjEsNyBAQCBzdGF0aWMg
ZW51bSBicF9yZXN1bHQgYmlvc19wYXJzZXJfZ2V0X2Zpcm13YXJlX2luZm8oCj4gIAkJY2FzZSAz
Ogo+ICAJCQlzd2l0Y2ggKHJldmlzaW9uLm1pbm9yKSB7Cj4gIAkJCWNhc2UgMToKPiArCQkJY2Fz
ZSAyOgo+ICAJCQkJcmVzdWx0ID0gZ2V0X2Zpcm13YXJlX2luZm9fdjNfMShicCwgaW5mbyk7Cj4g
IAkJCQlicmVhazsKPiAgCQkJZGVmYXVsdDoKPiAKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==

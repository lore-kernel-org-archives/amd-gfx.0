From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: change pte definitions to 64 bit
Date: Wed, 15 Feb 2017 19:14:15 +0100
Message-ID: <e167b5f6-bbcc-74de-236c-2ef187e51c43@vodafone.de>
References: <1487182140-24084-1-git-send-email-AlexBin.Xie@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1487182140-24084-1-git-send-email-AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMTUuMDIuMjAxNyB1bSAxOTowOSBzY2hyaWViIEFsZXggWGllOgo+IENoYW5nZS1JZDogSWFl
ZWIyNTNjYzVjMDI4YzkzYzUzNmVlNmVhMDgyMTNjN2ZhOGYyOTkKPiBTaWduZWQtb2ZmLWJ5OiBB
bGV4IFhpZSA8QWxleEJpbi5YaWVAYW1kLmNvbT4KCkFoLCBnb29kIGNhdGNoLiBJJ3ZlIG1pc3Nl
ZCB0aGF0IG9uZS4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+LgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV92bS5oIHwgMiArLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3ZtLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uaAo+IGluZGV4IDUx
ZmExMmYuLmNjMzg5YWYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3ZtLmgKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0u
aAo+IEBAIC02Myw3ICs2Myw3IEBAIHN0cnVjdCBhbWRncHVfYm9fbGlzdF9lbnRyeTsKPiAgICNk
ZWZpbmUgQU1ER1BVX1BURV9SRUFEQUJMRQkoMVVMTCA8PCA1KQo+ICAgI2RlZmluZSBBTURHUFVf
UFRFX1dSSVRFQUJMRQkoMVVMTCA8PCA2KQo+ICAgCj4gLSNkZWZpbmUgQU1ER1BVX1BURV9GUkFH
KHgpCSgoeCAmIDB4MWYpIDw8IDcpCj4gKyNkZWZpbmUgQU1ER1BVX1BURV9GUkFHKHgpCSgoeCAm
IDB4MWZVTEwpIDw8IDcpCj4gICAKPiAgICNkZWZpbmUgQU1ER1BVX1BURV9QUlQJCSgxVUxMIDw8
IDYzKQo+ICAgCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

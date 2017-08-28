From: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/9] drm/amdgpu: fix amdgpu_vm_bo_map trace point
Date: Mon, 28 Aug 2017 12:08:46 +0800
Message-ID: <5e9ab16d-eb38-33d5-3844-edbf75571ab4@amd.com>
References: <1503653899-1781-1-git-send-email-deathsimple@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1503653899-1781-1-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

UmV2aWV3ZWQtYnk6IENodW5taW5nIFpob3UgPGRhdmlkMS56aG91QGFtZC5jb20+CgoKT24gMjAx
N+W5tDA45pyIMjXml6UgMTc6MzgsIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gRnJvbTogQ2hy
aXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+Cj4gVGhhdCBzb21laG93
IGdvdCBsb3N0Lgo+Cj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFu
LmtvZW5pZ0BhbWQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3ZtLmMgfCAyICsrCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCj4KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+IGluZGV4IDdhMDY1NmMuLmM3NzY4
OWYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMK
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+IEBAIC0yMTEw
LDYgKzIxMTAsNyBAQCBpbnQgYW1kZ3B1X3ZtX2JvX21hcChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiwKPiAgIAo+ICAgCWlmIChmbGFncyAmIEFNREdQVV9QVEVfUFJUKQo+ICAgCQlhbWRncHVf
dm1fcHJ0X2dldChhZGV2KTsKPiArCXRyYWNlX2FtZGdwdV92bV9ib19tYXAoYm9fdmEsIG1hcHBp
bmcpOwo+ICAgCj4gICAJcmV0dXJuIDA7Cj4gICB9Cj4gQEAgLTIxNzUsNiArMjE3Niw3IEBAIGlu
dCBhbWRncHVfdm1fYm9fcmVwbGFjZV9tYXAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4g
ICAKPiAgIAlpZiAoZmxhZ3MgJiBBTURHUFVfUFRFX1BSVCkKPiAgIAkJYW1kZ3B1X3ZtX3BydF9n
ZXQoYWRldik7Cj4gKwl0cmFjZV9hbWRncHVfdm1fYm9fbWFwKGJvX3ZhLCBtYXBwaW5nKTsKPiAg
IAo+ICAgCXJldHVybiAwOwo+ICAgfQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==

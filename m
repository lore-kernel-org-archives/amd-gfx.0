From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/sdma5: fix mask value of POLL_REGMEM packet
 for pipe sync
Date: Thu, 10 Oct 2019 18:45:32 +0200
Message-ID: <f8d50c0e-daa2-252f-1c7e-b76310ccb3b8@daenzer.net>
References: <20191009170923.15479-1-xiaojie.yuan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191009170923.15479-1-xiaojie.yuan-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-CA
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
To: "Yuan, Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>
Cc: "Xiao, Jack" <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Zhang,
 Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

T24gMjAxOS0xMC0wOSA3OjA5IHAubS4sIFl1YW4sIFhpYW9qaWUgd3JvdGU6Cj4gc2RtYSB3aWxs
IGhhbmcgb25jZSBzZXF1ZW5jZSBudW1iZXIgdG8gYmUgcG9sbGVkIHJlYWNoZXMgMHgxMDAwXzAw
MDAKPiAKPiBTaWduZWQtb2ZmLWJ5OiBYaWFvamllIFl1YW4gPHhpYW9qaWUueXVhbkBhbWQuY29t
Pgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NV8wLmMgfCAyICst
Cj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPiAKPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NV8wLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y1XzAuYwo+IGluZGV4IGFkNWMzNTY2MzM3Yy4u
MzQ2MGMwMGYzZWFhIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Nk
bWFfdjVfMC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NV8wLmMK
PiBAQCAtMTEyNiw3ICsxMTI2LDcgQEAgc3RhdGljIHZvaWQgc2RtYV92NV8wX3JpbmdfZW1pdF9w
aXBlbGluZV9zeW5jKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZykKPiAgIAlhbWRncHVfcmluZ193
cml0ZShyaW5nLCBhZGRyICYgMHhmZmZmZmZmYyk7Cj4gICAJYW1kZ3B1X3Jpbmdfd3JpdGUocmlu
ZywgdXBwZXJfMzJfYml0cyhhZGRyKSAmIDB4ZmZmZmZmZmYpOwo+ICAgCWFtZGdwdV9yaW5nX3dy
aXRlKHJpbmcsIHNlcSk7IC8qIHJlZmVyZW5jZSAqLwo+IC0JYW1kZ3B1X3Jpbmdfd3JpdGUocmlu
ZywgMHhmZmZmZmZmKTsgLyogbWFzayAqLwo+ICsJYW1kZ3B1X3Jpbmdfd3JpdGUocmluZywgMHhm
ZmZmZmZmZik7IC8qIG1hc2sgKi8KCkhvdyBhYm91dCB+MHUgaW5zdGVhZD8KCgotLSAKRWFydGhs
aW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHBzOi8v
cmVkaGF0LmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAg
ICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4

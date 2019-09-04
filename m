From: "Liu, Aaron" <Aaron.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/2] drm/amd/display: bypass stereo programming
Date: Wed, 4 Sep 2019 06:06:21 +0000
Message-ID: <1567577166-18064-1-git-send-email-aaron.liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Huang,
 Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Li, Roman" <Roman.Li-5C7GfCeVMHo@public.gmane.org>

RnJvbTogUm9tYW4gTGkgPFJvbWFuLkxpQGFtZC5jb20+CgpoYWNrIHRvIGF2b2lkIGNyYXNoIG9u
IHJlbm9pcgpzaG91bGQgYmUgcmVzb2x2ZWQgYWZ0ZXIgdXBjb21pbmcgZ3BpbyByZWZhY3Rvcmlu
ZyBwcm9tb3Rpb24KClNpZ25lZC1vZmYtYnk6IFJvbWFuIExpIDxSb21hbi5MaUBhbWQuY29tPgot
LS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24xMC9kY24xMF9od19zZXF1ZW5j
ZXIuYyB8IDYgKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspCgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjEwL2RjbjEwX2h3X3NlcXVl
bmNlci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjEwL2RjbjEwX2h3X3Nl
cXVlbmNlci5jCmluZGV4IDViOWRkMTYuLmVlMjE4NmMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9kYy9kY24xMC9kY24xMF9od19zZXF1ZW5jZXIuYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMTAvZGNuMTBfaHdfc2VxdWVuY2VyLmMKQEAg
LTI4NDQsNiArMjg0NCwxMiBAQCBzdGF0aWMgdm9pZCBkY24xMF9zZXR1cF9zdGVyZW8oc3RydWN0
IHBpcGVfY3R4ICpwaXBlX2N0eCwgc3RydWN0IGRjICpkYykKIHsKIAlzdHJ1Y3QgY3J0Y19zdGVy
ZW9fZmxhZ3MgZmxhZ3MgPSB7IDAgfTsKIAlzdHJ1Y3QgZGNfc3RyZWFtX3N0YXRlICpzdHJlYW0g
PSBwaXBlX2N0eC0+c3RyZWFtOworI2lmZGVmIENPTkZJR19EUk1fQU1EX0RDX0RDTjJfMQorLyog
VE9ETzogcmVtb3ZlIGFmdGVyIGdwaW8gcmVmYWN0b3IgZ2V0cyBwcm9tb3RlZAorKiAgICAgICAg
b3RoZXJ3aXNlIGl0IGNhdXNpbmcgY3Jhc2ggb24gUmVub2lyCisqLworCXJldHVybjsKKyNlbmRp
ZgogCiAJZGNuMTBfY29uZmlnX3N0ZXJlb19wYXJhbWV0ZXJzKHN0cmVhbSwgJmZsYWdzKTsKIAot
LSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==

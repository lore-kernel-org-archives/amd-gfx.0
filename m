From: "Sharma, Deepak" <Deepak.Sharma-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amd: add the checking to avoid  NULL pointer dereference
Date: Thu, 22 Nov 2018 02:36:30 +0000
Message-ID: <20181122023610.22058-1-Deepak.Sharma@amd.com>
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
Cc: "Sharma, Deepak" <Deepak.Sharma-5C7GfCeVMHo@public.gmane.org>

d2hlbiByZXR1cm5lZCBmZW5jZSBpcyBub3QgdmFsaWQgbW9zdGx5IGR1ZSB0byB1c2Vyc3BhY2Ug
aWdub3JlZApwcmV2aW91cyBlcnJvciBjYXVzZXMgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlCgpT
aWduZWQtb2ZmLWJ5OiBEZWVwYWsgU2hhcm1hIDxEZWVwYWsuU2hhcm1hQGFtZC5jb20+Ci0tLQog
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMgfCAyICsrCiAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2NzLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3Mu
YwppbmRleCAwMjRkZmJkODdmMTEuLmM4NWJiMzEzZTZkZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2NzLmMKQEAgLTE0MjAsNiArMTQyMCw4IEBAIGludCBhbWRncHVfY3NfZmVu
Y2VfdG9faGFuZGxlX2lvY3RsKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIHZvaWQgKmRhdGEsCiAJ
ZmVuY2UgPSBhbWRncHVfY3NfZ2V0X2ZlbmNlKGFkZXYsIGZpbHAsICZpbmZvLT5pbi5mZW5jZSk7
CiAJaWYgKElTX0VSUihmZW5jZSkpCiAJCXJldHVybiBQVFJfRVJSKGZlbmNlKTsKKwlpZiAoIWZl
bmNlKQorCQlyZXR1cm4gLUVJTlZBTDsKIAogCXN3aXRjaCAoaW5mby0+aW4ud2hhdCkgewogCWNh
c2UgQU1ER1BVX0ZFTkNFX1RPX0hBTkRMRV9HRVRfU1lOQ09CSjoKLS0gCjIuMTUuMQoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

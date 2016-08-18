From: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 3/6] drm/amdgpu: allocate progressively higher ids for ctx
 until idr counter wraps
Date: Thu, 18 Aug 2016 15:50:15 +0800
Message-ID: <1471506618-29849-4-git-send-email-David1.Zhou@amd.com>
References: <1471506618-29849-1-git-send-email-David1.Zhou@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1471506618-29849-1-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
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
Cc: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David.Mao-5C7GfCeVMHo@public.gmane.org

Q2hhbmdlLUlkOiBJMGUzNmQ4Yjg0MmEyOWI2N2FmY2M0MTEzMzA3MDAyMzhiNDI4ZTc0NgpTaWdu
ZWQtb2ZmLWJ5OiBDaHVubWluZyBaaG91IDxEYXZpZDEuWmhvdUBhbWQuY29tPgotLS0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYyB8IDMgKystCiAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2N0eC5jCmluZGV4IDk2M2ExNGUuLjM1NzYxYmQgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYworKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfY3R4LmMKQEAgLTk3LDcgKzk3LDggQEAgc3RhdGljIGludCBhbWRn
cHVfY3R4X2FsbG9jKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCQlyZXR1cm4gLUVOT01F
TTsKIAogCW11dGV4X2xvY2soJmFtZGdwdV9jdHhfbG9jayk7Ci0JciA9IGlkcl9hbGxvYygmYW1k
Z3B1X2N0eF9pZHIsIGN0eCwgMSwgMCwgR0ZQX0tFUk5FTCk7CisJLyogYWxsb2NhdGUgcHJvZ3Jl
c3NpdmVseSBoaWdoZXIgaWRzIHVudGlsIGlkciBjb3VudGVyIHdyYXBzICovCisJciA9IGlkcl9h
bGxvY19jeWNsaWMoJmFtZGdwdV9jdHhfaWRyLCBjdHgsIDEsIDAsIEdGUF9LRVJORUwpOwogCWlm
IChyIDwgMCkgewogCQltdXRleF91bmxvY2soJmFtZGdwdV9jdHhfbG9jayk7CiAJCWtmcmVlKGN0
eCk7Ci0tIAoxLjkuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

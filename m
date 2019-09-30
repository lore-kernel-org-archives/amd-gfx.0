From: "Zhou1, Tao" <Tao.Zhou1-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/3] drm/amdgpu: initialize ras bad page bo array to NULL
Date: Mon, 30 Sep 2019 03:19:58 +0000
Message-ID: <20190930031938.10982-2-tao.zhou1@amd.com>
References: <20190930031938.10982-1-tao.zhou1@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190930031938.10982-1-tao.zhou1-5C7GfCeVMHo@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, "Chen, Guchun" <Guchun.Chen-5C7GfCeVMHo@public.gmane.org>, "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
Cc: "Zhou1, Tao" <Tao.Zhou1-5C7GfCeVMHo@public.gmane.org>

Z3VhcmFudGVlIGJvIHBvaW50ZXJzIGluIGJhZCBwYWdlIGJvIGFycmF5IGFyZSBOVUxMIGFmdGVy
IGFsbG9jYXRpb24KClNpZ25lZC1vZmYtYnk6IFRhbyBaaG91IDx0YW8uemhvdTFAYW1kLmNvbT4K
LS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMgfCAyICstCiAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfcmFzLmMKaW5kZXggM2YyYTJmMTNlNGM2Li5kMWJhZmE5MmNhOTEg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYworKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMKQEAgLTEzMTAsNyArMTMx
MCw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3Jhc19yZWFsbG9jX2VoX2RhdGFfc3BhY2Uoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJdW5zaWduZWQgaW50IGFsaWduX3NwYWNlID0gQUxJR04o
bmV3X3NwYWNlLCA1MTIpOwogCXZvaWQgKmJwcyA9IGttYWxsb2MoYWxpZ25fc3BhY2UgKiBzaXpl
b2YoKmRhdGEtPmJwcyksIEdGUF9LRVJORUwpOwogCXN0cnVjdCBhbWRncHVfYm8gKipicHNfYm8g
PQotCQkJa21hbGxvYyhhbGlnbl9zcGFjZSAqIHNpemVvZigqZGF0YS0+YnBzX2JvKSwgR0ZQX0tF
Uk5FTCk7CisJCQlremFsbG9jKGFsaWduX3NwYWNlICogc2l6ZW9mKCpkYXRhLT5icHNfYm8pLCBH
RlBfS0VSTkVMKTsKIAogCWlmICghYnBzIHx8ICFicHNfYm8pIHsKIAkJa2ZyZWUoYnBzKTsKLS0g
CjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

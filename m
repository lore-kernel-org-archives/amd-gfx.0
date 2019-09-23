From: "Yuan, Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/amdgpu/gfx10: enable gfxoff for navi12
Date: Mon, 23 Sep 2019 13:58:14 +0000
Message-ID: <20190923135746.8066-2-xiaojie.yuan@amd.com>
References: <20190923135746.8066-1-xiaojie.yuan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190923135746.8066-1-xiaojie.yuan-5C7GfCeVMHo@public.gmane.org>
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
Cc: "Xiao, Jack" <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>, "Wang,
 Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>, "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>, "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "Feng, Kenneth" <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>, "Yuan, Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogWGlhb2ppZSBZdWFuIDx4aWFvamllLnl1YW5AYW1kLmNvbT4KLS0tCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyB8IDIgKy0KIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ2Z4X3YxMF8wLmMKaW5kZXggMDgyYTBiMzI5OGE5Li4yMjQwNmY1NmM4MTggMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCkBAIC01ODAsNyArNTgwLDYgQEAgc3RhdGlj
IHZvaWQgZ2Z4X3YxMF8wX2NoZWNrX2dmeG9mZl9mbGFnKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2KQogewogCXN3aXRjaCAoYWRldi0+YXNpY190eXBlKSB7CiAJY2FzZSBDSElQX05BVkkxMDoK
LQljYXNlIENISVBfTkFWSTEyOgogCQlhZGV2LT5wbS5wcF9mZWF0dXJlICY9IH5QUF9HRlhPRkZf
TUFTSzsKIAkJYnJlYWs7CiAJZGVmYXVsdDoKQEAgLTQxODQsNiArNDE4Myw3IEBAIHN0YXRpYyBp
bnQgZ2Z4X3YxMF8wX3NldF9wb3dlcmdhdGluZ19zdGF0ZSh2b2lkICpoYW5kbGUsCiAJYm9vbCBl
bmFibGUgPSAoc3RhdGUgPT0gQU1EX1BHX1NUQVRFX0dBVEUpID8gdHJ1ZSA6IGZhbHNlOwogCXN3
aXRjaCAoYWRldi0+YXNpY190eXBlKSB7CiAJY2FzZSBDSElQX05BVkkxMDoKKwljYXNlIENISVBf
TkFWSTEyOgogCWNhc2UgQ0hJUF9OQVZJMTQ6CiAJCWlmICghZW5hYmxlKSB7CiAJCQlhbWRncHVf
Z2Z4X29mZl9jdHJsKGFkZXYsIGZhbHNlKTsKLS0gCjIuMjAuMQoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4

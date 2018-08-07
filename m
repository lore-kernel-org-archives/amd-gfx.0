From: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu/sriov: give 8s for recover vram under RUNTIME
Date: Tue, 7 Aug 2018 18:22:07 +0800
Message-ID: <1533637327-18411-1-git-send-email-Emily.Deng@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
Cc: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>, Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

VW5kZXIgcnVudGltZSwgdGhlIHdhaXQgZmVuY2UgdGltZSBjb3VsZCBiZSBxdWl0ZSBsb25nIHdo
ZW4Kb3RoZXIgVkZzIGFyZSBpbiBleGNsdXNpdmUgbW9kZS4KClNXREVWLTE2MTQ5MAoKQ2hhbmdl
LUlkOiBJZmMzMmQ1NmNhN2ZkZTAxYjFmNGZlMmIwZGI2OTU5YjUxOTA5MDA4YQpTaWduZWQtb2Zm
LWJ5OiBNb25rIExpdSA8TW9uay5MaXVAYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogRW1pbHkgRGVu
ZyA8RW1pbHkuRGVuZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9kZXZpY2UuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwpp
bmRleCAxZDkzM2RiLi5lZjgyYWQxIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZGV2aWNlLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2RldmljZS5jCkBAIC0zMTI0LDcgKzMxMjQsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV9kZXZp
Y2VfaGFuZGxlX3ZyYW1fbG9zdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAlsb25nIHRt
bzsKIAogCWlmIChhbWRncHVfc3Jpb3ZfcnVudGltZShhZGV2KSkKLQkJdG1vID0gbXNlY3NfdG9f
amlmZmllcyhhbWRncHVfbG9ja3VwX3RpbWVvdXQpOworCQl0bW8gPSBtc2Vjc190b19qaWZmaWVz
KDgwMDApOwogCWVsc2UKIAkJdG1vID0gbXNlY3NfdG9famlmZmllcygxMDApOwogCi0tIAoyLjcu
NAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

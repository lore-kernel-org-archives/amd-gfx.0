From: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/1] drm/amdgpu: Fix error handling in amdgpu_ras_recovery_init
Date: Thu, 3 Oct 2019 22:00:44 +0000
Message-ID: <20191003220028.13107-1-Felix.Kuehling@amd.com>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Cc: "Cox, Philip" <Philip.Cox-5C7GfCeVMHo@public.gmane.org>

RG9uJ3Qgc2V0IGEgc3RydWN0IHBvaW50ZXIgdG8gTlVMTCBiZWZvcmUgZnJlZWluZyBpdHMgbWVt
YmVycy4gSXQncwpoYXJkIHRvIHNlZSB3aGF0J3MgaGFwcGVuaW5nIGR1ZSB0byBhIGxvY2FsIHBv
aW50ZXItdG8tcG9pbnRlciBkYXRhCmFsaWFzaW5nIGNvbi0+ZWhfZGF0YS4KClNpZ25lZC1vZmYt
Ynk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9yYXMuYwppbmRleCA0ODY1NjhkZWQ2ZDYuLjBlMmVlNTg2OWI1ZiAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYwpAQCAtMTU0MiwxMCArMTU0MiwxMCBAQCBpbnQg
YW1kZ3B1X3Jhc19yZWNvdmVyeV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogcmVs
ZWFzZToKIAlhbWRncHVfcmFzX3JlbGVhc2VfYmFkX3BhZ2VzKGFkZXYpOwogZnJlZToKLQljb24t
PmVoX2RhdGEgPSBOVUxMOwogCWtmcmVlKCgqZGF0YSktPmJwcyk7CiAJa2ZyZWUoKCpkYXRhKS0+
YnBzX2JvKTsKIAlrZnJlZSgqZGF0YSk7CisJY29uLT5laF9kYXRhID0gTlVMTDsKIG91dDoKIAlE
Uk1fV0FSTigiRmFpbGVkIHRvIGluaXRpYWxpemUgcmFzIHJlY292ZXJ5IVxuIik7CiAKLS0gCjIu
MTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

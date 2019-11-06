From: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/4] Revert "drm/amdgpu: dont schedule jobs while in reset"
Date: Wed, 6 Nov 2019 12:51:09 -0500
Message-ID: <1573062672-23698-1-git-send-email-andrey.grodzovsky@amd.com>
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
Cc: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>, Shirish.S-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Christian.Koenig-5C7GfCeVMHo@public.gmane.org

VGhpcyByZXZlcnRzIGNvbW1pdCAzY2RmOWJkMDA4OTcyM2M0NjhkNWY2MjQwZTU0ZDFhZmE1MmU5
YTA0LgoKV2Ugd2lsbCBkbyBhIHByb3BlciBmaXggaW4gbmV4dCBwYXRjaC4KClNpZ25lZC1vZmYt
Ynk6IEFuZHJleSBHcm9kem92c2t5IDxhbmRyZXkuZ3JvZHpvdnNreUBhbWQuY29tPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYyB8IDUgKy0tLS0KIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfY3R4LmMKaW5kZXggMmNkYWYzYi4uNjYxNGQ4YSAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYwpAQCAtNjA0LDExICs2MDQsOCBAQCB2b2lkIGFt
ZGdwdV9jdHhfbWdyX2VudGl0eV9maW5pKHN0cnVjdCBhbWRncHVfY3R4X21nciAqbWdyKQogCQkJ
Y29udGludWU7CiAJCX0KIAotCQlmb3IgKGkgPSAwOyBpIDwgbnVtX2VudGl0aWVzOyBpKyspIHsK
LQkJCW11dGV4X2xvY2soJmN0eC0+YWRldi0+bG9ja19yZXNldCk7CisJCWZvciAoaSA9IDA7IGkg
PCBudW1fZW50aXRpZXM7IGkrKykKIAkJCWRybV9zY2hlZF9lbnRpdHlfZmluaSgmY3R4LT5lbnRp
dGllc1swXVtpXS5lbnRpdHkpOwotCQkJbXV0ZXhfdW5sb2NrKCZjdHgtPmFkZXYtPmxvY2tfcmVz
ZXQpOwotCQl9CiAJfQogfQogCi0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4

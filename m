From: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 20/22] drm/amdgpu: increase gart size to 512MB
Date: Mon, 26 Feb 2018 13:18:18 +0800
Message-ID: <1519622300-8990-21-git-send-email-Monk.Liu@amd.com>
References: <1519622300-8990-1-git-send-email-Monk.Liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1519622300-8990-1-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

MjU2TUIgaXMgdG9vIHNtYWxsIGNvbnNpZGVyIFBURS9QREUgc2hhZG93IGFuZCBUVE0KZXZpY3Rp
b24gYWN0aXZpdHkKCkNoYW5nZS1JZDogSWZhYTMwZGM3MzBlZWMzNmFmNDdmYmRlYjNjY2UzMGRl
OTA2N2IxN2YKU2lnbmVkLW9mZi1ieTogTW9uayBMaXUgPE1vbmsuTGl1QGFtZC5jb20+Ci0tLQog
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYyB8IDIgKy0KIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9nbWNfdjlfMC5jCmluZGV4IDY4MzlkOTMuLmU5MjUxMjEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ21jX3Y5XzAuYwpAQCAtNzg5LDcgKzc4OSw3IEBAIHN0YXRpYyBpbnQgZ21jX3Y5XzBf
bWNfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAkJc3dpdGNoIChhZGV2LT5hc2lj
X3R5cGUpIHsKIAkJY2FzZSBDSElQX1ZFR0ExMDogIC8qIGFsbCBlbmdpbmVzIHN1cHBvcnQgR1BV
Vk0gKi8KIAkJZGVmYXVsdDoKLQkJCWFkZXYtPmdtYy5nYXJ0X3NpemUgPSAyNTZVTEwgPDwgMjA7
CisJCQlhZGV2LT5nbWMuZ2FydF9zaXplID0gNTEyVUxMIDw8IDIwOwogCQkJYnJlYWs7CiAJCWNh
c2UgQ0hJUF9SQVZFTjogICAvKiBEQ0UgU0cgc3VwcG9ydCAqLwogCQkJYWRldi0+Z21jLmdhcnRf
c2l6ZSA9IDEwMjRVTEwgPDwgMjA7Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==

From: Le Ma <le.ma-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 4/4] drm/amdgpu: remove ras global recovery handling from
 ras_controller_int handler
Date: Mon, 28 Oct 2019 19:31:09 +0800
Message-ID: <1572262269-14985-4-git-send-email-le.ma@amd.com>
References: <1572262269-14985-1-git-send-email-le.ma@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1572262269-14985-1-git-send-email-le.ma-5C7GfCeVMHo@public.gmane.org>
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
Cc: Le Ma <Le.Ma-5C7GfCeVMHo@public.gmane.org>

RnJvbTogTGUgTWEgPExlLk1hQGFtZC5jb20+CgpDaGFuZ2UtSWQ6IElhOGE2MWE0YjNiZDUyOWYw
ZjY5MWU0M2U2OWIyOTlkN2QxNTFjMGMyClNpZ25lZC1vZmYtYnk6IExlIE1hIDxMZS5NYUBhbWQu
Y29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L25iaW9fdjdfNC5jIHwgNiArKysr
Ky0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9uYmlvX3Y3XzQuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L25iaW9fdjdfNC5jCmluZGV4IDBkYjQ1OGYuLjg3NjY5MGEgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L25iaW9fdjdfNC5jCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L25iaW9fdjdfNC5jCkBAIC0zMjQsNyArMzI0LDExIEBA
IHN0YXRpYyB2b2lkIG5iaW9fdjdfNF9oYW5kbGVfcmFzX2NvbnRyb2xsZXJfaW50cl9ub19iaWZy
aW5nKHN0cnVjdCBhbWRncHVfZGV2aWNlCiAJCQkJCQlSQVNfQ05UTFJfSU5URVJSVVBUX0NMRUFS
LCAxKTsKIAkJV1JFRzMyX1NPQzE1KE5CSU8sIDAsIG1tQklGX0RPT1JCRUxMX0lOVF9DTlRMLCBi
aWZfZG9vcmJlbGxfaW50cl9jbnRsKTsKIAotCQlhbWRncHVfcmFzX2dsb2JhbF9yYXNfaXNyKGFk
ZXYpOworCQkvKgorCQkgKiByYXNfY29udHJvbGxlcl9pbnQgaXMgZGVkaWNhdGVkIGZvciBuYmlm
IHJhcyBlcnJvciwKKwkJICogbm90IHRoZSBnbG9iYWwgaW50ZXJydXB0IGZvciBzeW5jIGZsb29k
CisJCSAqLworCQlhbWRncHVfcmFzX3Jlc2V0X2dwdShhZGV2LCB0cnVlKTsKIAl9CiB9CiAKLS0g
CjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=

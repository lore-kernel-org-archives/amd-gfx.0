From: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 5/6] drm/amdgpu: Add vega20 support on kfd probe
Date: Wed, 12 Sep 2018 21:44:06 -0400
Message-ID: <1536803047-29364-6-git-send-email-Felix.Kuehling@amd.com>
References: <1536803047-29364-1-git-send-email-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1536803047-29364-1-git-send-email-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
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
Cc: oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alexander.deucher-5C7GfCeVMHo@public.gmane.org, Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, Shaoyun Liu <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>

RnJvbTogU2hhb3l1biBMaXUgPFNoYW95dW4uTGl1QGFtZC5jb20+CgpBZGQgVmVnYTIwIHN1cHBv
cnQgaW4gYW1kZ3B1X2FtZGtmZF9kZXZpY2VfcHJvYmUuCgpTaWduZWQtb2ZmLWJ5OiBTaGFveXVu
IExpdSA8U2hhb3l1bi5MaXVAYW1kLmNvbT4KQWNrZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFu
ZGVyLmRldWNoZXJAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5L
dWVobGluZ0BhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5k
ZXVjaGVyQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVo
bGluZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRr
ZmQuYyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5jCmluZGV4IDdhMTY1YTkuLmM3MzNhOGY2IDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5jCkBAIC03OSw2ICs3
OSw3IEBAIHZvaWQgYW1kZ3B1X2FtZGtmZF9kZXZpY2VfcHJvYmUoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYpCiAJCWtmZDJrZ2QgPSBhbWRncHVfYW1ka2ZkX2dmeF84XzBfZ2V0X2Z1bmN0aW9u
cygpOwogCQlicmVhazsKIAljYXNlIENISVBfVkVHQTEwOgorCWNhc2UgQ0hJUF9WRUdBMjA6CiAJ
Y2FzZSBDSElQX1JBVkVOOgogCQlrZmQya2dkID0gYW1kZ3B1X2FtZGtmZF9nZnhfOV8wX2dldF9m
dW5jdGlvbnMoKTsKIAkJYnJlYWs7Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==

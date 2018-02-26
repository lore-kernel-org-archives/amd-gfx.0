From: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 11/22] drm/amdgpu: Remove the memory leak after unload amdgpu
 driver
Date: Mon, 26 Feb 2018 13:18:09 +0800
Message-ID: <1519622300-8990-12-git-send-email-Monk.Liu@amd.com>
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
Cc: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>

RnJvbTogRW1pbHkgRGVuZyA8RW1pbHkuRGVuZ0BhbWQuY29tPgoKTmVlZCB0byBjYWxsIGZ1bmN0
aW9uIGFtZGdwdV91Y29kZV9maW5pX2JvIHRvIHJlbGVhc2UgdWNvZGUgYm8gZm9yCnBzcCBmaXJt
d2FyZSBsb2FkIHR5cGUuCgpDaGFuZ2UtSWQ6IEkxYzdiZTgxMzU5OTNlMTEwNzZjOWQ0NmIzY2Q4
NzYxNTUxNGE5YWJiClNpZ25lZC1vZmYtYnk6IEVtaWx5IERlbmcgPEVtaWx5LkRlbmdAYW1kLmNv
bT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCAxICsK
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kZXZpY2UuYwppbmRleCA2OWZiNWU1MC4uNjE2OTZjNyAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwpAQCAtMTQ5MCw2ICsxNDkwLDcgQEAg
c3RhdGljIGludCBhbWRncHVfZGV2aWNlX2lwX2Zpbmkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpCiAKIAkvKiBkaXNhYmxlIGFsbCBpbnRlcnJ1cHRzICovCiAJYW1kZ3B1X2lycV9kaXNhYmxl
X2FsbChhZGV2KTsKKwlhbWRncHVfdWNvZGVfZmluaV9ibyhhZGV2KTsKIAogCWZvciAoaSA9IGFk
ZXYtPm51bV9pcF9ibG9ja3MgLSAxOyBpID49IDA7IGktLSkgewogCQlpZiAoIWFkZXYtPmlwX2Js
b2Nrc1tpXS5zdGF0dXMuc3cpCi0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==

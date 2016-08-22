From: Qiang Yu <Qiang.Yu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH xf86-video-amdgpu] Fix amdgpu_dri2_exchange_buffers
 width/height miss copy
Date: Mon, 22 Aug 2016 19:13:26 +0800
Message-ID: <1471864406-25978-1-git-send-email-Qiang.Yu@amd.com>
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
Cc: Qiang Yu <Qiang.Yu-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogUWlhbmcgWXUgPFFpYW5nLll1QGFtZC5jb20+Ci0tLQogc3JjL2FtZGdw
dV9kcmkyLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkKCmRpZmYgLS1naXQgYS9zcmMvYW1kZ3B1X2RyaTIuYyBiL3NyYy9hbWRncHVfZHJpMi5j
CmluZGV4IDAzZTNhMGIuLmRlNzAxYzIgMTAwNjQ0Ci0tLSBhL3NyYy9hbWRncHVfZHJpMi5jCisr
KyBiL3NyYy9hbWRncHVfZHJpMi5jCkBAIC02NjUsNyArNjY1LDcgQEAgYW1kZ3B1X2RyaTJfZXhj
aGFuZ2VfYnVmZmVycyhEcmF3YWJsZVB0ciBkcmF3LCBEUkkyQnVmZmVyUHRyIGZyb250LAogCiAJ
cmVnaW9uLmV4dGVudHMueDEgPSByZWdpb24uZXh0ZW50cy55MSA9IDA7CiAJcmVnaW9uLmV4dGVu
dHMueDIgPSBmcm9udF9wcml2LT5waXhtYXAtPmRyYXdhYmxlLndpZHRoOwotCXJlZ2lvbi5leHRl
bnRzLnkyID0gZnJvbnRfcHJpdi0+cGl4bWFwLT5kcmF3YWJsZS53aWR0aDsKKwlyZWdpb24uZXh0
ZW50cy55MiA9IGZyb250X3ByaXYtPnBpeG1hcC0+ZHJhd2FibGUuaGVpZ2h0OwogCXJlZ2lvbi5k
YXRhID0gTlVMTDsKIAlEYW1hZ2VSZWdpb25BcHBlbmQoJmZyb250X3ByaXYtPnBpeG1hcC0+ZHJh
d2FibGUsICZyZWdpb24pOwogCi0tIAoxLjkuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==

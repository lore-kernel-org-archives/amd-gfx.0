From: Qiang Yu <Qiang.Yu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH xserver 6/6] modesetting: remove redundent pixmap destroy
Date: Wed, 17 Aug 2016 18:29:11 +0800
Message-ID: <1471429751-17269-7-git-send-email-Qiang.Yu@amd.com>
References: <1471429751-17269-1-git-send-email-Qiang.Yu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1471429751-17269-1-git-send-email-Qiang.Yu-5C7GfCeVMHo@public.gmane.org>
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
To: xorg-devel-go0+a7rfsptAfugRpC6u6w@public.gmane.org
Cc: Qiang Yu <Qiang.Yu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

U2lnbmVkLW9mZi1ieTogUWlhbmcgWXUgPFFpYW5nLll1QGFtZC5jb20+Ci0tLQogaHcveGZyZWU4
Ni9kcml2ZXJzL21vZGVzZXR0aW5nL2RyaTIuYyB8IDIgLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2h3L3hmcmVlODYvZHJpdmVycy9tb2Rlc2V0dGluZy9k
cmkyLmMgYi9ody94ZnJlZTg2L2RyaXZlcnMvbW9kZXNldHRpbmcvZHJpMi5jCmluZGV4IDRjZjYz
OGUuLmIxOGYwYjggMTAwNjQ0Ci0tLSBhL2h3L3hmcmVlODYvZHJpdmVycy9tb2Rlc2V0dGluZy9k
cmkyLmMKKysrIGIvaHcveGZyZWU4Ni9kcml2ZXJzL21vZGVzZXR0aW5nL2RyaTIuYwpAQCAtMTkz
LDggKzE5Myw2IEBAIG1zX2RyaTJfY3JlYXRlX2J1ZmZlcihEcmF3YWJsZVB0ciBkcmF3YWJsZSwg
dW5zaWduZWQgaW50IGF0dGFjaG1lbnQsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHBpeG1hcF9jcHAsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IDApOwogICAgICAgICBpZiAocGl4bWFwID09IE5VTEwpIHsKLSAgICAgICAgICAgIGlmIChwaXht
YXApCi0gICAgICAgICAgICAgICAgc2NyZWVuLT5EZXN0cm95UGl4bWFwKHBpeG1hcCk7CiAgICAg
ICAgICAgICBmcmVlKHByaXZhdGUpOwogICAgICAgICAgICAgZnJlZShidWZmZXIpOwogICAgICAg
ICAgICAgcmV0dXJuIE5VTEw7Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==

From: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 05/11] drm/amdkfd: Fix incorrect destroy_mqd parameter
Date: Fri, 15 Sep 2017 19:42:56 -0400
Message-ID: <1505518982-29631-6-git-send-email-Felix.Kuehling@amd.com>
References: <1505518982-29631-1-git-send-email-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1505518982-29631-1-git-send-email-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
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
Cc: Yong Zhao <yong.zhao-5C7GfCeVMHo@public.gmane.org>, Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>

V2hlbiB1bmluaXRpYWxpemluZyBhIGtlcm5lbCBxdWV1ZS4KClNpZ25lZC1vZmYtYnk6IFlvbmcg
WmhhbyA8eW9uZy56aGFvQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IEZlbGl4IEt1ZWhsaW5nIDxG
ZWxpeC5LdWVobGluZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF9rZXJuZWxfcXVldWUuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF9rZXJuZWxfcXVldWUuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9rZXJuZWxf
cXVldWUuYwppbmRleCAwYzgyNDQ2Li4wOTM1NmQwIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGtmZC9rZmRfa2VybmVsX3F1ZXVlLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX2tlcm5lbF9xdWV1ZS5jCkBAIC0xODQsNyArMTg0LDcgQEAgc3RhdGljIHZv
aWQgdW5pbml0aWFsaXplKHN0cnVjdCBrZXJuZWxfcXVldWUgKmtxKQogCWlmIChrcS0+cXVldWUt
PnByb3BlcnRpZXMudHlwZSA9PSBLRkRfUVVFVUVfVFlQRV9ISVEpCiAJCWtxLT5tcWQtPmRlc3Ry
b3lfbXFkKGtxLT5tcWQsCiAJCQkJCU5VTEwsCi0JCQkJCWZhbHNlLAorCQkJCQlLRkRfUFJFRU1Q
VF9UWVBFX1dBVkVGUk9OVF9SRVNFVCwKIAkJCQkJS0ZEX1VOTUFQX0xBVEVOQ1lfTVMsCiAJCQkJ
CWtxLT5xdWV1ZS0+cGlwZSwKIAkJCQkJa3EtPnF1ZXVlLT5xdWV1ZSk7Ci0tIAoyLjcuNAoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

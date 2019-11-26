From: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 3/5] drm/amdgpu: do autoload right after MEC loaded for SRIOV
 VF
Date: Tue, 26 Nov 2019 19:50:22 +0800
Message-ID: <1574769024-30611-3-git-send-email-Monk.Liu@amd.com>
References: <1574769024-30611-1-git-send-email-Monk.Liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1574769024-30611-1-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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

c2luY2Ugd2UgZG9uJ3QgaGF2ZSBSTENHIHVjb2RlIGxvYWRpbmcgYW5kIG5vIFNSbGlzdCBhcyB3
ZWxsCgpTaWduZWQtb2ZmLWJ5OiBNb25rIExpdSA8TW9uay5MaXVAYW1kLmNvbT4KLS0tCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMgfCAzICstLQogMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9wc3AuYwppbmRleCA5NmE2YjAwLi5iNjVmZGE5IDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMKKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jCkBAIC0xNDkwLDggKzE0OTAsNyBAQCBzdGF0aWMgaW50
IHBzcF9ucF9md19sb2FkKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQogCQkJcmV0dXJuIHJldDsK
IAogCQkvKiBTdGFydCBybGMgYXV0b2xvYWQgYWZ0ZXIgcHNwIHJlY2lldmVkIGFsbCB0aGUgZ2Z4
IGZpcm13YXJlICovCi0JCWlmIChwc3AtPmF1dG9sb2FkX3N1cHBvcnRlZCAmJiB1Y29kZS0+dWNv
ZGVfaWQgPT0KLQkJCUFNREdQVV9VQ09ERV9JRF9STENfUkVTVE9SRV9MSVNUX1NSTV9NRU0pIHsK
KwkJaWYgKHBzcC0+YXV0b2xvYWRfc3VwcG9ydGVkICYmIHVjb2RlLT51Y29kZV9pZCA9PSAoYW1k
Z3B1X3NyaW92X3ZmKGFkZXYpID8gQU1ER1BVX1VDT0RFX0lEX0NQX01FQzIgOiBBTURHUFVfVUNP
REVfSURfUkxDX1JFU1RPUkVfTElTVF9TUk1fTUVNKSkgewogCQkJcmV0ID0gcHNwX3JsY19hdXRv
bG9hZChwc3ApOwogCQkJaWYgKHJldCkgewogCQkJCURSTV9FUlJPUigiRmFpbGVkIHRvIHN0YXJ0
IHJsYyBhdXRvbG9hZFxuIik7Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4

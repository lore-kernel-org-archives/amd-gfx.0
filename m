From: "Yuan, Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 04/10] drm/amdgpu: enable sdma clock gating for navi12
Date: Tue, 6 Aug 2019 06:46:30 +0000
Message-ID: <20190806064546.19434-5-xiaojie.yuan@amd.com>
References: <20190806064546.19434-1-xiaojie.yuan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190806064546.19434-1-xiaojie.yuan-5C7GfCeVMHo@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Yuan,
 Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>

ZW5hYmxlcyBzZG1hIG1lZGl1bSBncmFpbmVkIGNsb2NrIGdhdGluZyBhbmQgbWVtb3J5IGxpZ2h0
IHNsZWVwCgpTaWduZWQtb2ZmLWJ5OiBYaWFvamllIFl1YW4gPHhpYW9qaWUueXVhbkBhbWQuY29t
PgpSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgot
LS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252LmMgfCA0ICsrKy0KIDEgZmlsZSBjaGFu
Z2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9udi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbnYu
YwppbmRleCBjNDhiODUzYmVkY2YuLjVjOGY3YjdhYjNjNSAxMDA2NDQKLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvbnYuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9u
di5jCkBAIC01NjcsNyArNTY3LDkgQEAgc3RhdGljIGludCBudl9jb21tb25fZWFybHlfaW5pdCh2
b2lkICpoYW5kbGUpCiAJCQlBTURfQ0dfU1VQUE9SVF9HRlhfQ1BfTFMgfAogCQkJQU1EX0NHX1NV
UFBPUlRfR0ZYX1JMQ19MUyB8CiAJCQlBTURfQ0dfU1VQUE9SVF9IRFBfTUdDRyB8Ci0JCQlBTURf
Q0dfU1VQUE9SVF9IRFBfTFM7CisJCQlBTURfQ0dfU1VQUE9SVF9IRFBfTFMgfAorCQkJQU1EX0NH
X1NVUFBPUlRfU0RNQV9NR0NHIHwKKwkJCUFNRF9DR19TVVBQT1JUX1NETUFfTFM7CiAJCWFkZXYt
PnBnX2ZsYWdzID0gQU1EX1BHX1NVUFBPUlRfVkNOX0RQRzsKIAkJYWRldi0+ZXh0ZXJuYWxfcmV2
X2lkID0gYWRldi0+cmV2X2lkICsgMHhhOwogCQlicmVhazsKLS0gCjIuMjAuMQoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

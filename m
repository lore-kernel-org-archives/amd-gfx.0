From: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 5/6] drm/amd/amdgpu:  Enable VCE MGCG for Carrizo
Date: Wed,  3 Aug 2016 11:51:41 -0400
Message-ID: <20160803155142.27161-6-tom.stdenis@amd.com>
References: <20160803155142.27161-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20160803155142.27161-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogVG9tIFN0IERlbmlzIDx0b20uc3RkZW5pc0BhbWQuY29tPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZpLmMgfCAzICsrLQogMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3ZpLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92aS5jCmluZGV4
IDMzYmFkOTkxNzZmZS4uNTQ0OWEzYzhjOWViIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS92aS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZpLmMKQEAg
LTE1NzcsNyArMTU3Nyw4IEBAIHN0YXRpYyBpbnQgdmlfY29tbW9uX2Vhcmx5X2luaXQodm9pZCAq
aGFuZGxlKQogCQkJQU1EX0NHX1NVUFBPUlRfSERQX01HQ0cgfAogCQkJQU1EX0NHX1NVUFBPUlRf
SERQX0xTIHwKIAkJCUFNRF9DR19TVVBQT1JUX1NETUFfTUdDRyB8Ci0JCQlBTURfQ0dfU1VQUE9S
VF9TRE1BX0xTOworCQkJQU1EX0NHX1NVUFBPUlRfU0RNQV9MUyB8CisJCQlBTURfQ0dfU1VQUE9S
VF9WQ0VfTUdDRzsKIAkJLyogcmV2MCBoYXJkd2FyZSByZXF1aXJlcyB3b3JrYXJvdW5kcyB0byBz
dXBwb3J0IFBHICovCiAJCWFkZXYtPnBnX2ZsYWdzID0gMDsKIAkJaWYgKGFkZXYtPnJldl9pZCAh
PSAweDAwKSB7Ci0tIAoyLjkuMgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==

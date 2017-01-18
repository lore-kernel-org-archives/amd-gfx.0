From: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 3/3] drm/amdgpu:insert switch buffer only for VM submit
Date: Wed, 18 Jan 2017 10:40:33 +0800
Message-ID: <1484707233-29838-4-git-send-email-Monk.Liu@amd.com>
References: <1484707233-29838-1-git-send-email-Monk.Liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1484707233-29838-1-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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

Zm9yIG5vbi1WTSBzdWJtaXQgd2hpY2ggaXMgZnJvbSBrZXJuZWwgc2lkZSwgbm8gbmVlZAp0byBz
d2l0Y2ggYnVmZmVyIGF0IGFsbC4KCkNoYW5nZS1JZDogSTU1Yzk5M2U2MTExYTdjNDM4YTZiYzk0
YjM2YWFiZGFiOWVkNWY0YmQKU2lnbmVkLW9mZi1ieTogTW9uayBMaXUgPE1vbmsuTGl1QGFtZC5j
b20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2liLmMgfCAyICstCiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWIuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9pYi5jCmluZGV4IDc1NTIzMjYuLjEyMzAwYzMgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pYi5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pYi5jCkBAIC0yMjQsNyArMjI0LDcgQEAgaW50IGFt
ZGdwdV9pYl9zY2hlZHVsZShzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcsIHVuc2lnbmVkIG51bV9p
YnMsCiAJCWFtZGdwdV9yaW5nX3BhdGNoX2NvbmRfZXhlYyhyaW5nLCBwYXRjaF9vZmZzZXQpOwog
CiAJcmluZy0+Y3VycmVudF9jdHggPSBmZW5jZV9jdHg7Ci0JaWYgKHJpbmctPmZ1bmNzLT5lbWl0
X3N3aXRjaF9idWZmZXIpCisJaWYgKHZtICYmIHJpbmctPmZ1bmNzLT5lbWl0X3N3aXRjaF9idWZm
ZXIpCiAJCWFtZGdwdV9yaW5nX2VtaXRfc3dpdGNoX2J1ZmZlcihyaW5nKTsKIAlhbWRncHVfcmlu
Z19jb21taXQocmluZyk7CiAJcmV0dXJuIDA7Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

From: James Zhu <James.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/amdgpu:Always save uvd vcpu_bo in VM Mode
Date: Tue,  6 Mar 2018 15:14:06 -0500
Message-ID: <1520367246-8734-2-git-send-email-James.Zhu@amd.com>
References: <1520367246-8734-1-git-send-email-James.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1520367246-8734-1-git-send-email-James.Zhu-5C7GfCeVMHo@public.gmane.org>
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

V2hlbiBVVkQgaXMgaW4gVk0gbW9kZSwgdGhlcmUgaXMgbm90IHV2ZCBoYW5kbGUgZXhjaGFuZ2Vk
LAp1dmQuaGFuZGxlcyBhcmUgYWx3YXlzIDAuIFNvIHZjcHVfYm8gYWx3YXlzIG5lZWQgc2F2ZSwK
T3RoZXJ3aXNlIGFtZGdwdSBkcml2ZXIgd2lsbCBmYWlsIGR1cmluZyBzdXNwZW5kL3Jlc3VtZS4K
CkJ1Z3ppbGxhOiBodHRwczovL2J1Z3MuZnJlZWRlc2t0b3Aub3JnL3Nob3dfYnVnLmNnaT9pZD0x
MDUwMjEKU2lnbmVkLW9mZi1ieTogSmFtZXMgWmh1IDxKYW1lcy5aaHVAYW1kLmNvbT4KLS0tCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXZkLmMgfCAzICsrLQogMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91dmQuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV91dmQuYwppbmRleCA5ZDAzN2NiLi42MWEzMWU1IDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXZkLmMKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3V2ZC5jCkBAIC0zMDMsNyArMzAzLDggQEAgaW50IGFtZGdw
dV91dmRfc3VzcGVuZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAkJaWYgKGF0b21pY19y
ZWFkKCZhZGV2LT51dmQuaGFuZGxlc1tpXSkpCiAJCQlicmVhazsKIAotCWlmIChpID09IGFkZXYt
PnV2ZC5tYXhfaGFuZGxlcykKKwkvKiBvbmx5IHZhbGlkIGZvciBwaHlzaWNhbCBtb2RlICovCisJ
aWYgKGkgPT0gYWRldi0+dXZkLm1heF9oYW5kbGVzICYmIGFkZXYtPmFzaWNfdHlwZSA8IENISVBf
UE9MQVJJUzEwKQogCQlyZXR1cm4gMDsKIAogCXNpemUgPSBhbWRncHVfYm9fc2l6ZShhZGV2LT51
dmQudmNwdV9ibyk7Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==

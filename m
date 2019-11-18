From: Aaron Liu <aaron.liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 3/5] drm/amdgpu: enable TMZ bit in sdma copy pkt for sdma v4
Date: Mon, 18 Nov 2019 13:18:34 +0800
Message-ID: <1574054316-2802-3-git-send-email-aaron.liu@amd.com>
References: <1574054316-2802-1-git-send-email-aaron.liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1574054316-2802-1-git-send-email-aaron.liu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, Luben.Tuikov-5C7GfCeVMHo@public.gmane.org, Ray.Huang-5C7GfCeVMHo@public.gmane.org, Christian.Koenig-5C7GfCeVMHo@public.gmane.org, Aaron Liu <aaron.liu-5C7GfCeVMHo@public.gmane.org>

RW5hYmxlIHNkbWEgVE1aIG1vZGUgdmlhIHNldHRpbmcgVE1aIGJpdCBpbiBzZG1hIGNvcHkgcGt0
CmZvciBzZG1hIHY0CgpTaWduZWQtb2ZmLWJ5OiBBYXJvbiBMaXUgPGFhcm9uLmxpdUBhbWQuY29t
PgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29t
PgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjRfMC5jIHwgMyArKy0KIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y0XzAuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3NkbWFfdjRfMC5jCmluZGV4IDExMDQ0OWEuLmQyMDljYmYgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjRfMC5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjRfMC5jCkBAIC0yMzQyLDcgKzIzNDIsOCBAQCBzdGF0
aWMgdm9pZCBzZG1hX3Y0XzBfZW1pdF9jb3B5X2J1ZmZlcihzdHJ1Y3QgYW1kZ3B1X2liICppYiwK
IAkJCQkgICAgICAgYm9vbCB0bXopCiB7CiAJaWItPnB0cltpYi0+bGVuZ3RoX2R3KytdID0gU0RN
QV9QS1RfSEVBREVSX09QKFNETUFfT1BfQ09QWSkgfAotCQlTRE1BX1BLVF9IRUFERVJfU1VCX09Q
KFNETUFfU1VCT1BfQ09QWV9MSU5FQVIpOworCQlTRE1BX1BLVF9IRUFERVJfU1VCX09QKFNETUFf
U1VCT1BfQ09QWV9MSU5FQVIpIHwKKwkJU0RNQV9QS1RfQ09QWV9MSU5FQVJfSEVBREVSX1RNWih0
bXogPyAxIDogMCk7CiAJaWItPnB0cltpYi0+bGVuZ3RoX2R3KytdID0gYnl0ZV9jb3VudCAtIDE7
CiAJaWItPnB0cltpYi0+bGVuZ3RoX2R3KytdID0gMDsgLyogc3JjL2RzdCBlbmRpYW4gc3dhcCAq
LwogCWliLT5wdHJbaWItPmxlbmd0aF9kdysrXSA9IGxvd2VyXzMyX2JpdHMoc3JjX29mZnNldCk7
Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

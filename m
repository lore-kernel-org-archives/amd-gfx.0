From: Yang Xiao <YangX92-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] drm/radeon: avoid a possible array overflow
Date: Mon, 17 Dec 2018 11:52:49 +0000
Message-ID: <SG2PR01MB21691166E8B05DC64F8C0277ADBC0@SG2PR01MB2169.apcprd01.prod.exchangelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: "alexander.deucher-5C7GfCeVMHo@public.gmane.org" <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, "christian.koenig-5C7GfCeVMHo@public.gmane.org" <christian.koenig-5C7GfCeVMHo@public.gmane.org>, "David1.Zhou-5C7GfCeVMHo@public.gmane.org" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "airlied-cv59FeDIM0c@public.gmane.org" <airlied-cv59FeDIM0c@public.gmane.org>
Cc: Yang Xiao <YangX92-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

RnJvbTogWW91bmcgWGlhbyA8WWFuZ1g5MkBob3RtYWlsLmNvbT4KCldoZW4gbG9va2luZyB1cCB0
aGUgY29ubmVjdG9yIHR5cGUgbWFrZSBzdXJlIHRoZSBpbmRleAppcyB2YWxpZC4gIEF2b2lkcyBh
IGxhdGVyIGNyYXNoIGlmIHdlIHJlYWQgcGFzdCB0aGUgZW5kCm9mIHRoZSBhcnJheS4KClNlZSBj
b21taXQgZTE3MThkOTdhYTg4ICgiZHJtL2FtZGdwdTogYXZvaWQgYSBwb3NzaWJsZQphcnJheSBv
dmVyZmxvdyIpIGZvciBkZXRhaWwuCgpTaWduZWQtb2ZmLWJ5OiBZb3VuZyBYaWFvIDxZYW5nWDky
QGhvdG1haWwuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2F0b21iaW9z
LmMgfCA2ICsrKysrKwogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2F0b21iaW9zLmMgYi9kcml2ZXJzL2dw
dS9kcm0vcmFkZW9uL3JhZGVvbl9hdG9tYmlvcy5jCmluZGV4IGY0MjJhOGQuLjkxMjE5NjEgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2F0b21iaW9zLmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fYXRvbWJpb3MuYwpAQCAtNTgzLDYgKzU4Mywx
MiBAQCBib29sIHJhZGVvbl9nZXRfYXRvbV9jb25uZWN0b3JfaW5mb19mcm9tX29iamVjdF90YWJs
ZShzdHJ1Y3QgZHJtX2RldmljZSAqZGV2KQogCQkJCUFUT01fREVWSUNFX0NWX1NVUFBPUlQpCiAJ
CQkJY29udGludWU7CiAKKwkJCWlmIChjb25fb2JqX2lkID49IEFSUkFZX1NJWkUob2JqZWN0X2Nv
bm5lY3Rvcl9jb252ZXJ0KSkgeworCQkJCURSTV9FUlJPUigiaW52YWxpZCBjb25fb2JqX2lkICVk
IGZvciBkZXZpY2UgdGFnIDB4JTA0eFxuIiwKKwkJCQkJICBjb25fb2JqX2lkLCBsZTE2X3RvX2Nw
dShwYXRoLT51c0RldmljZVRhZykpOworCQkJCWNvbnRpbnVlOworCQkJfQorCiAJCQkvKiBJR1Ag
Y2hpcHMgKi8KIAkJCWlmICgocmRldi0+ZmxhZ3MgJiBSQURFT05fSVNfSUdQKSAmJgogCQkJICAg
IChjb25fb2JqX2lkID09Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==

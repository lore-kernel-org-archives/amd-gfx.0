From: Timothy Pearson <tpearson-z0qzliK6Om0mgXJStvpl+vpXobYPEAuW@public.gmane.org>
Subject: [PATCH 1/1] Fix undefined behaviour from signed integer overflow
Date: Sat, 23 Jun 2018 18:58:28 -0500 (CDT)
Message-ID: <410839238.2569260.1529798308752.JavaMail.zimbra@raptorengineeringinc.com>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

CkNhdWdodCBieSBVQlNBTgoKU2lnbmVkLW9mZi1ieTogVGltb3RoeSBQZWFyc29uIDx0cGVhcnNv
bkByYXB0b3JlbmdpbmVlcmluZy5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBs
YXkvc211bWdyL3NtdTdfc211bWdyLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bv
d2VycGxheS9zbXVtZ3Ivc211N19zbXVtZ3IuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJw
bGF5L3NtdW1nci9zbXU3X3NtdW1nci5jCmluZGV4IGQ2NDRhOWJiOTA3OC4uYTljMzg2ZmQ5NDkz
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVtZ3Ivc211N19z
bXVtZ3IuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVtZ3Ivc211N19z
bXVtZ3IuYwpAQCAtOTgsNyArOTgsNyBAQCBpbnQgc211N19jb3B5X2J5dGVzX3RvX3NtYyhzdHJ1
Y3QgcHBfaHdtZ3IgKmh3bWdyLCB1aW50MzJfdCBzbWNfc3RhcnRfYWRkcmVzcywKIAogCXdoaWxl
IChieXRlX2NvdW50ID49IDQpIHsKIAkvKiBCeXRlcyBhcmUgd3JpdHRlbiBpbnRvIHRoZSBTTUMg
YWRkcmVzIHNwYWNlIHdpdGggdGhlIE1TQiBmaXJzdC4gKi8KLQkJZGF0YSA9IHNyY1swXSAqIDB4
MTAwMDAwMCArIHNyY1sxXSAqIDB4MTAwMDAgKyBzcmNbMl0gKiAweDEwMCArIHNyY1szXTsKKwkJ
ZGF0YSA9IHNyY1swXSAqIDB4MTAwMDAwMFUgKyBzcmNbMV0gKiAweDEwMDAwVSArIHNyY1syXSAq
IDB4MTAwVSArIHNyY1szXTsKIAogCQlyZXN1bHQgPSBzbXU3X3NldF9zbWNfc3JhbV9hZGRyZXNz
KGh3bWdyLCBhZGRyLCBsaW1pdCk7CiAKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==

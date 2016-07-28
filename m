From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [Part II PATCH 10/15] drm/amd/powerplay: rename smum header guards
Date: Thu, 28 Jul 2016 15:25:00 +0800
Message-ID: <1469690705-877-11-git-send-email-ray.huang@amd.com>
References: <1469690705-877-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1469690705-877-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Cc: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>

VGhpcyBwYXRjaCByZW5hbWVzIHRoZSBzbXVtIGhlYWRlciBndWFyZHMgdG8gYWxpZ24gd2l0aCB0
aGUgZmlsZSBuYW1lLgoKUmVwb3J0ZWQtYnk6IEVkd2FyZCBPJ0NhbGxhZ2hhbiA8ZnVuZnVuY3Rv
ckBmb2xrbG9yZTE5ODQubmV0PgpTaWduZWQtb2ZmLWJ5OiBIdWFuZyBSdWkgPHJheS5odWFuZ0Bh
bWQuY29tPgpSZXZpZXdlZC1ieTogS2VuIFdhbmcgPFFpbmdxaW5nLldhbmdAYW1kLmNvbT4KLS0t
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9pY2VsYW5kX3NtdW0uaCB8IDQgKystLQogMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9pY2VsYW5kX3NtdW0uaCBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2ljZWxhbmRfc211bS5oCmluZGV4IDFlMDc2OWUuLjU5ODNlMzEgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2ljZWxhbmRfc211bS5oCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2ljZWxhbmRfc211bS5oCkBAIC0yMSw4ICsyMSw4
IEBACiAgKgogICovCiAKLSNpZm5kZWYgSUNFTEFORF9TTVVNR1JfSAotI2RlZmluZSBJQ0VMQU5E
X1NNVU1HUl9ICisjaWZuZGVmIElDRUxBTkRfU01VTV9ICisjZGVmaW5lIElDRUxBTkRfU01VTV9I
CiAKICNpbmNsdWRlICJwcHNtYy5oIgogCi0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==

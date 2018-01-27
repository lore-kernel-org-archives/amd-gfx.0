From: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 11/25] drm/amdkfd: Add missing #ifdef CONFIG_AMD_IOMMU_V2 guard
Date: Fri, 26 Jan 2018 20:09:27 -0500
Message-ID: <1517015381-1080-12-git-send-email-Felix.Kuehling@amd.com>
References: <1517015381-1080-1-git-send-email-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1517015381-1080-1-git-send-email-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+Ci0t
LQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYyB8IDIgKysKIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2Zk
X3Byb2Nlc3MuYwppbmRleCA0M2M4OWM1Li5hNTI3YzIyIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1ka2ZkL2tmZF9wcm9jZXNzLmMKQEAgLTQ1Miw2ICs0NTIsNyBAQCBzdHJ1Y3Qga2ZkX3Byb2Nl
c3NfZGV2aWNlICprZmRfYmluZF9wcm9jZXNzX3RvX2RldmljZShzdHJ1Y3Qga2ZkX2RldiAqZGV2
LAogCXJldHVybiBwZGQ7CiB9CiAKKyNpZiBkZWZpbmVkKENPTkZJR19BTURfSU9NTVVfVjJfTU9E
VUxFKSB8fCBkZWZpbmVkKENPTkZJR19BTURfSU9NTVVfVjIpCiAvKgogICogQmluZCBwcm9jZXNz
ZXMgZG8gdGhlIGRldmljZSB0aGF0IGhhdmUgYmVlbiB0ZW1wb3JhcmlseSB1bmJvdW5kCiAgKiAo
UEREX0JPVU5EX1NVU1BFTkRFRCkgaW4ga2ZkX3VuYmluZF9wcm9jZXNzZXNfZnJvbV9kZXZpY2Uu
CkBAIC01NjIsNiArNTYzLDcgQEAgdm9pZCBrZmRfcHJvY2Vzc19pb21tdV91bmJpbmRfY2FsbGJh
Y2soc3RydWN0IGtmZF9kZXYgKmRldiwgdW5zaWduZWQgaW50IHBhc2lkKQogCiAJa2ZkX3VucmVm
X3Byb2Nlc3MocCk7CiB9CisjZW5kaWYgLyogQ09ORklHX0FNRF9JT01NVV9WMiAqLwogCiBzdHJ1
Y3Qga2ZkX3Byb2Nlc3NfZGV2aWNlICprZmRfZ2V0X2ZpcnN0X3Byb2Nlc3NfZGV2aWNlX2RhdGEo
CiAJCQkJCQlzdHJ1Y3Qga2ZkX3Byb2Nlc3MgKnApCi0tIAoyLjcuNAoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A79CC88CB2
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Aug 2023 13:01:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1462D10E68D;
	Fri, 25 Aug 2023 13:01:57 +0000 (UTC)
X-Greylist: delayed 541 seconds by postgrey-1.36 at gabe;
 Fri, 25 Aug 2023 06:36:31 UTC
Received: from out-30.mta1.migadu.com (out-30.mta1.migadu.com [95.215.58.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C91C10E60C
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Aug 2023 06:36:31 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1692944857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x8g1PhZtieFXqvl5KlmXpfelaKvpJdAuWlFNqp32lxU=;
 b=azk9oKl/yWYIN5PPkoo3zBSOa5qD4a5Ttwotj7deRwg4VxJLVd1VH9ZPjzSxR8PPOtGk7H
 2eXNsnzhwSuxKFP68ub1/EATKxmpRZkXRApbQsGsMiJuZEaOOoibeOK2+BNWPK3PdLGpfw
 qaDtANXtL8laXrkLljPHNF5ob99FzAU=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 4/5] drm/amdgpu: Use pci_get_base_class() to reduce duplicated
 code
Date: Fri, 25 Aug 2023 14:27:13 +0800
Message-Id: <20230825062714.6325-5-sui.jingfeng@linux.dev>
In-Reply-To: <20230825062714.6325-1-sui.jingfeng@linux.dev>
References: <20230825062714.6325-1-sui.jingfeng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Fri, 25 Aug 2023 13:01:54 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: alsa-devel@alsa-project.org, Sui Jingfeng <suijingfeng@loongson.cn>,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-pci@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sui Jingfeng <suijingfeng@loongson.cn>

Should be no functional change.

Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 11 ++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 20 +++++---------------
 2 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index a5a2b06c6588..4f18af877105 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1389,14 +1389,11 @@ void amdgpu_acpi_detect(void)
 	struct pci_dev *pdev = NULL;
 	int ret;
 
-	while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, pdev)) != NULL) {
-		if (!atif->handle)
-			amdgpu_atif_pci_probe_handle(pdev);
-		if (!atcs->handle)
-			amdgpu_atcs_pci_probe_handle(pdev);
-	}
+	while ((pdev = pci_get_base_class(PCI_BASE_CLASS_DISPLAY, pdev))) {
+		if ((pdev->class != PCI_CLASS_DISPLAY_VGA << 8) &&
+		    (pdev->class != PCI_CLASS_DISPLAY_OTHER << 8))
+			continue;
 
-	while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_OTHER << 8, pdev)) != NULL) {
 		if (!atif->handle)
 			amdgpu_atif_pci_probe_handle(pdev);
 		if (!atcs->handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index 38ccec913f00..5bbb23e102ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -287,7 +287,11 @@ static bool amdgpu_atrm_get_bios(struct amdgpu_device *adev)
 	if (adev->flags & AMD_IS_APU)
 		return false;
 
-	while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, pdev)) != NULL) {
+	while ((pdev = pci_get_base_class(PCI_BASE_CLASS_DISPLAY, pdev))) {
+		if ((pdev->class != PCI_CLASS_DISPLAY_VGA << 8) &&
+		    (pdev->class != PCI_CLASS_DISPLAY_OTHER << 8))
+			continue;
+
 		dhandle = ACPI_HANDLE(&pdev->dev);
 		if (!dhandle)
 			continue;
@@ -299,20 +303,6 @@ static bool amdgpu_atrm_get_bios(struct amdgpu_device *adev)
 		}
 	}
 
-	if (!found) {
-		while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_OTHER << 8, pdev)) != NULL) {
-			dhandle = ACPI_HANDLE(&pdev->dev);
-			if (!dhandle)
-				continue;
-
-			status = acpi_get_handle(dhandle, "ATRM", &atrm_handle);
-			if (ACPI_SUCCESS(status)) {
-				found = true;
-				break;
-			}
-		}
-	}
-
 	if (!found)
 		return false;
 	pci_dev_put(pdev);
-- 
2.34.1


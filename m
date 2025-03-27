Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB8E3C36013
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Mar 2025 20:39:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 526B110E173;
	Thu, 27 Mar 2025 20:39:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HeB7P9YC";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C79E10E941
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Mar 2025 20:39:13 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9BF4C61130;
 Thu, 27 Mar 2025 20:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C350C4CEEA;
 Thu, 27 Mar 2025 20:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743107949;
 bh=EHZPu8MX51b3GqtEs+yWyJ0M1wEuCyDqgaxJRGmEHLo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HeB7P9YCxRTWvm16tTgqpzUcCDw/S6oJL41WnxgcXv39igBYvwY98yA2LKDEWy8A4
 XU9QcBv9H1UEx8y9VceVO2Ht+IkSaoSyjWWgtV9FzpEiTo24RtaTEjG0B2UAVPoU7Y
 0yR9lEuzDReQTN6G9jy8hOlzGztFYm6qv46ZNZA6P095xM/CvF4a8PO2Dr+YnFmNca
 XiWhd5ytG0+TH3blixV+ekASUnSUE4l0hSLRyIMzz1+kUdbpSl+7D6rFfnQwDNbMvi
 VN4Ou9HmNM3oJs0Lia//pouSD2RSJWaAvvwwiZvEJEHGeUk1moTWNfgWPWAIR97DeX
 /YXznFe1PKDEg==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 01/14] drm/amd: Use ACPI macros for amdgpu_acpi
Date: Thu, 27 Mar 2025 15:38:45 -0500
Message-ID: <20250327203858.3796086-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250327203858.3796086-1-superm1@kernel.org>
References: <20250327203858.3796086-1-superm1@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mario Limonciello <mario.limonciello@amd.com>

Messages emitted from amdgpu_acpi are not device specific nor DRM
specific, but rather operate on ACPI handles.  Adjust the messages
to use ACPI macros instead.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index b7f8f2ff143dd..1c5994de5a723 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -256,7 +256,7 @@ static int amdgpu_atif_verify_interface(struct amdgpu_atif *atif)
 
 	size = *(u16 *) info->buffer.pointer;
 	if (size < 12) {
-		DRM_INFO("ATIF buffer is too small: %zu\n", size);
+		acpi_handle_info(atif->handle, "ATIF buffer is too small: %zu\n", size);
 		err = -EINVAL;
 		goto out;
 	}
@@ -265,7 +265,7 @@ static int amdgpu_atif_verify_interface(struct amdgpu_atif *atif)
 	memcpy(&output, info->buffer.pointer, size);
 
 	/* TODO: check version? */
-	DRM_DEBUG_DRIVER("ATIF version %u\n", output.version);
+	acpi_handle_debug(atif->handle, "ATIF version %u\n", output.version);
 
 	amdgpu_atif_parse_notification(&atif->notifications, output.notification_mask);
 	amdgpu_atif_parse_functions(&atif->functions, output.function_bits);
@@ -616,7 +616,7 @@ static int amdgpu_atcs_verify_interface(struct amdgpu_atcs *atcs)
 
 	size = *(u16 *) info->buffer.pointer;
 	if (size < 8) {
-		DRM_INFO("ATCS buffer is too small: %zu\n", size);
+		acpi_handle_info(atcs->handle, "ATCS buffer is too small: %zu\n", size);
 		err = -EINVAL;
 		goto out;
 	}
@@ -625,7 +625,7 @@ static int amdgpu_atcs_verify_interface(struct amdgpu_atcs *atcs)
 	memcpy(&output, info->buffer.pointer, size);
 
 	/* TODO: check version? */
-	DRM_DEBUG_DRIVER("ATCS version %u\n", output.version);
+	acpi_handle_debug(atcs->handle, "ATCS version %u\n", output.version);
 
 	amdgpu_atcs_parse_functions(&atcs->functions, output.function_bits);
 
@@ -741,7 +741,7 @@ int amdgpu_acpi_pcie_performance_request(struct amdgpu_device *adev,
 
 		size = *(u16 *) info->buffer.pointer;
 		if (size < 3) {
-			DRM_INFO("ATCS buffer is too small: %zu\n", size);
+			acpi_handle_info(atcs->handle, "ATCS buffer is too small: %zu\n", size);
 			kfree(info);
 			return -EINVAL;
 		}
@@ -800,7 +800,7 @@ int amdgpu_acpi_power_shift_control(struct amdgpu_device *adev,
 
 	info = amdgpu_atcs_call(atcs, ATCS_FUNCTION_POWER_SHIFT_CONTROL, &params);
 	if (!info) {
-		DRM_ERROR("ATCS PSC update failed\n");
+		acpi_handle_err(atcs->handle, "ATCS PSC update failed\n");
 		return -EIO;
 	}
 
@@ -1429,8 +1429,9 @@ void amdgpu_acpi_detect(void)
 	if (atif->functions.system_params) {
 		ret = amdgpu_atif_get_notification_params(atif);
 		if (ret) {
-			DRM_DEBUG_DRIVER("Call to GET_SYSTEM_PARAMS failed: %d\n",
-					ret);
+			acpi_handle_debug(atif->handle,
+					  "GET_SYSTEM_PARAMS evaluation failed: %d\n",
+					  ret);
 			/* Disable notification */
 			atif->notification_cfg.enabled = false;
 		}
@@ -1439,8 +1440,9 @@ void amdgpu_acpi_detect(void)
 	if (atif->functions.query_backlight_transfer_characteristics) {
 		ret = amdgpu_atif_query_backlight_caps(atif);
 		if (ret) {
-			DRM_DEBUG_DRIVER("Call to QUERY_BACKLIGHT_TRANSFER_CHARACTERISTICS failed: %d\n",
-					ret);
+			acpi_handle_debug(atif->handle,
+					  "QUERY_BACKLIGHT_TRANSFER_CHARACTERISTICS evaluation failed: %d\n",
+					  ret);
 			atif->backlight_caps.caps_valid = false;
 		}
 	} else {
-- 
2.43.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB4CC07E8A
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Aug 2023 07:20:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5027710E50A;
	Wed,  2 Aug 2023 07:20:19 +0000 (UTC)
Received: from out28-196.mail.aliyun.com (out28-196.mail.aliyun.com
 [115.124.28.196])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8770B10E4C0;
 Wed,  2 Aug 2023 06:58:14 +0000 (UTC)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.3522126|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.0108132-0.00065214-0.988535;
 FP=0|0|0|0|0|-1|-1|-1; HT=ay29a033018047208; MF=sunran001@208suo.com; NM=1;
 PH=DS; RN=5; RT=5; SR=0; TI=SMTPD_---.U6a9kda_1690959486; 
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com
 fp:SMTPD_---.U6a9kda_1690959486) by smtp.aliyun-inc.com;
 Wed, 02 Aug 2023 14:58:08 +0800
From: Ran Sun <sunran001@208suo.com>
To: alexander.deucher@amd.com
Subject: [PATCH] drm/amdgpu: Clean up errors in uvd_v7_0.c
Date: Wed,  2 Aug 2023 06:58:04 +0000
Message-Id: <20230802065804.12360-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Wed, 02 Aug 2023 07:20:04 +0000
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
Cc: Ran Sun <sunran001@208suo.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the following errors reported by checkpatch:

ERROR: spaces required around that ':' (ctx:VxE)
that open brace { should be on the previous line

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index abaa4463e906..86d1d46e1e5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -679,11 +679,11 @@ static void uvd_v7_0_mc_resume(struct amdgpu_device *adev)
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 			WREG32_SOC15(UVD, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
 				i == 0 ?
-				adev->firmware.ucode[AMDGPU_UCODE_ID_UVD].tmr_mc_addr_lo:
+				adev->firmware.ucode[AMDGPU_UCODE_ID_UVD].tmr_mc_addr_lo :
 				adev->firmware.ucode[AMDGPU_UCODE_ID_UVD1].tmr_mc_addr_lo);
 			WREG32_SOC15(UVD, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
 				i == 0 ?
-				adev->firmware.ucode[AMDGPU_UCODE_ID_UVD].tmr_mc_addr_hi:
+				adev->firmware.ucode[AMDGPU_UCODE_ID_UVD].tmr_mc_addr_hi :
 				adev->firmware.ucode[AMDGPU_UCODE_ID_UVD1].tmr_mc_addr_hi);
 			WREG32_SOC15(UVD, i, mmUVD_VCPU_CACHE_OFFSET0, 0);
 			offset = 0;
@@ -1908,8 +1908,7 @@ static void uvd_v7_0_set_irq_funcs(struct amdgpu_device *adev)
 	}
 }
 
-const struct amdgpu_ip_block_version uvd_v7_0_ip_block =
-{
+const struct amdgpu_ip_block_version uvd_v7_0_ip_block = {
 		.type = AMD_IP_BLOCK_TYPE_UVD,
 		.major = 7,
 		.minor = 0,
-- 
2.17.1


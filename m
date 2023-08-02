Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D00C04A94
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Aug 2023 07:20:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFE3410E4F3;
	Wed,  2 Aug 2023 07:20:12 +0000 (UTC)
Received: from out28-171.mail.aliyun.com (out28-171.mail.aliyun.com
 [115.124.28.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91FB510E4A6;
 Wed,  2 Aug 2023 06:48:33 +0000 (UTC)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.3444751|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_alarm|0.00639894-4.13957e-05-0.99356; FP=0|0|0|0|0|-1|-1|-1;
 HT=ay29a033018047193; MF=sunran001@208suo.com; NM=1; PH=DS; RN=5; RT=5; SR=0;
 TI=SMTPD_---.U6YuGG9_1690958904; 
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com
 fp:SMTPD_---.U6YuGG9_1690958904) by smtp.aliyun-inc.com;
 Wed, 02 Aug 2023 14:48:25 +0800
From: Ran Sun <sunran001@208suo.com>
To: alexander.deucher@amd.com
Subject: [PATCH] drm/amdgpu: Clean up errors in mmhub_v9_4.c
Date: Wed,  2 Aug 2023 06:48:22 +0000
Message-Id: <20230802064822.12093-1-sunran001@208suo.com>
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

ERROR: code indent should use tabs where possible
ERROR: space required before the open parenthesis '('

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
index e790f890aec6..5718e4d40e66 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -108,7 +108,7 @@ static void mmhub_v9_4_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmi
 }
 
 static void mmhub_v9_4_init_system_aperture_regs(struct amdgpu_device *adev,
-					         int hubid)
+						int hubid)
 {
 	uint64_t value;
 	uint32_t tmp;
@@ -1568,7 +1568,7 @@ static int mmhub_v9_4_get_ras_error_count(struct amdgpu_device *adev,
 	uint32_t sec_cnt, ded_cnt;
 
 	for (i = 0; i < ARRAY_SIZE(mmhub_v9_4_ras_fields); i++) {
-		if(mmhub_v9_4_ras_fields[i].reg_offset != reg->reg_offset)
+		if (mmhub_v9_4_ras_fields[i].reg_offset != reg->reg_offset)
 			continue;
 
 		sec_cnt = (value &
-- 
2.17.1


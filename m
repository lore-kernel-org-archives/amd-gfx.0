Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5954FC04FDF
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Aug 2023 07:20:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E64C10E4DE;
	Wed,  2 Aug 2023 07:20:13 +0000 (UTC)
Received: from out28-4.mail.aliyun.com (out28-4.mail.aliyun.com [115.124.28.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0110110E4A0;
 Wed,  2 Aug 2023 06:37:56 +0000 (UTC)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.5040528|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.103306-0.00202804-0.894666;
 FP=0|0|0|0|0|-1|-1|-1; HT=ay29a033018047208; MF=sunran001@208suo.com; NM=1;
 PH=DS; RN=5; RT=5; SR=0; TI=SMTPD_---.U6YtKML_1690958263; 
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com
 fp:SMTPD_---.U6YtKML_1690958263) by smtp.aliyun-inc.com;
 Wed, 02 Aug 2023 14:37:45 +0800
From: Ran Sun <sunran001@208suo.com>
To: alexander.deucher@amd.com
Subject: [PATCH] drm/amdgpu: Clean up errors in vce_v3_0.c
Date: Wed,  2 Aug 2023 06:37:42 +0000
Message-Id: <20230802063742.11697-1-sunran001@208suo.com>
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

ERROR: that open brace { should be on the previous line

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index 8def62c83ffd..18f6e62af339 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -998,8 +998,7 @@ static void vce_v3_0_set_irq_funcs(struct amdgpu_device *adev)
 	adev->vce.irq.funcs = &vce_v3_0_irq_funcs;
 };
 
-const struct amdgpu_ip_block_version vce_v3_0_ip_block =
-{
+const struct amdgpu_ip_block_version vce_v3_0_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_VCE,
 	.major = 3,
 	.minor = 0,
@@ -1007,8 +1006,7 @@ const struct amdgpu_ip_block_version vce_v3_0_ip_block =
 	.funcs = &vce_v3_0_ip_funcs,
 };
 
-const struct amdgpu_ip_block_version vce_v3_1_ip_block =
-{
+const struct amdgpu_ip_block_version vce_v3_1_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_VCE,
 	.major = 3,
 	.minor = 1,
@@ -1016,8 +1014,7 @@ const struct amdgpu_ip_block_version vce_v3_1_ip_block =
 	.funcs = &vce_v3_0_ip_funcs,
 };
 
-const struct amdgpu_ip_block_version vce_v3_4_ip_block =
-{
+const struct amdgpu_ip_block_version vce_v3_4_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_VCE,
 	.major = 3,
 	.minor = 4,
-- 
2.17.1


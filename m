Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9279C04A94
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Aug 2023 07:25:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DB9310E5B7;
	Thu,  3 Aug 2023 07:25:07 +0000 (UTC)
Received: from out28-49.mail.aliyun.com (out28-49.mail.aliyun.com
 [115.124.28.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6B6F10E512;
 Wed,  2 Aug 2023 07:37:25 +0000 (UTC)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.6682332|0.5811412; CH=green;
 DM=|SPAM|false|; DS=CONTINUE|ham_alarm|0.05409-0.00146338-0.944447;
 FP=0|0|0|0|0|-1|-1|-1; HT=ay29a033018047206; MF=sunran001@208suo.com; NM=1;
 PH=DS; RN=5; RT=5; SR=0; TI=SMTPD_---.U6cMZwp_1690961835; 
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com
 fp:SMTPD_---.U6cMZwp_1690961835) by smtp.aliyun-inc.com;
 Wed, 02 Aug 2023 15:37:17 +0800
From: Ran Sun <sunran001@208suo.com>
To: alexander.deucher@amd.com
Subject: [PATCH] drm/amdgpu: Clean up errors in uvd_v3_1.c
Date: Wed,  2 Aug 2023 07:37:15 +0000
Message-Id: <20230802073715.13598-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Thu, 03 Aug 2023 07:25:02 +0000
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
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
index 0fef925b6602..5534c769b655 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
@@ -815,8 +815,7 @@ static const struct amd_ip_funcs uvd_v3_1_ip_funcs = {
 	.set_powergating_state = uvd_v3_1_set_powergating_state,
 };
 
-const struct amdgpu_ip_block_version uvd_v3_1_ip_block =
-{
+const struct amdgpu_ip_block_version uvd_v3_1_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_UVD,
 	.major = 3,
 	.minor = 1,
-- 
2.17.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA8AAC04FE2
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Aug 2023 07:20:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70F4D10E4F9;
	Wed,  2 Aug 2023 07:20:14 +0000 (UTC)
Received: from out28-197.mail.aliyun.com (out28-197.mail.aliyun.com
 [115.124.28.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DD2D10E1D9;
 Tue,  1 Aug 2023 09:30:33 +0000 (UTC)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.4867433|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_alarm|0.143503-0.00113365-0.855363; FP=0|0|0|0|0|-1|-1|-1;
 HT=ay29a033018047209; MF=sunran001@208suo.com; NM=1; PH=DS; RN=7; RT=7; SR=0;
 TI=SMTPD_---.U5rwF-m_1690882224; 
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com
 fp:SMTPD_---.U5rwF-m_1690882224) by smtp.aliyun-inc.com;
 Tue, 01 Aug 2023 17:30:26 +0800
From: Ran Sun <sunran001@208suo.com>
To: alexander.deucher@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch
Subject: [PATCH] gpu: amd: Clean up errors in ppatomfwctrl.h
Date: Tue,  1 Aug 2023 09:30:23 +0000
Message-Id: <20230801093023.7584-1-sunran001@208suo.com>
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

ERROR: open brace '{' following struct go on the same line

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.h
index 2fc1733bcdcf..e86e05c786d9 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.h
@@ -147,8 +147,7 @@ struct pp_atomfwctrl_bios_boot_up_values {
 	uint8_t    ucCoolingID;
 };
 
-struct pp_atomfwctrl_smc_dpm_parameters
-{
+struct pp_atomfwctrl_smc_dpm_parameters {
   uint8_t  liquid1_i2c_address;
   uint8_t  liquid2_i2c_address;
   uint8_t  vr_i2c_address;
-- 
2.17.1


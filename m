Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3EDCC04FDF
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Aug 2023 08:27:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B823F10E32C;
	Tue,  1 Aug 2023 08:27:48 +0000 (UTC)
Received: from out28-145.mail.aliyun.com (out28-145.mail.aliyun.com
 [115.124.28.145])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBB7A10E2FB;
 Tue,  1 Aug 2023 02:11:39 +0000 (UTC)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1111192|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_alarm|0.0123702-0.000752526-0.986877; FP=0|0|0|0|0|-1|-1|-1;
 HT=ay29a033018047204; MF=sunran001@208suo.com; NM=1; PH=DS; RN=7; RT=7; SR=0;
 TI=SMTPD_---.U5FqyPn_1690855890; 
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com
 fp:SMTPD_---.U5FqyPn_1690855890) by smtp.aliyun-inc.com;
 Tue, 01 Aug 2023 10:11:32 +0800
From: Ran Sun <sunran001@208suo.com>
To: alexander.deucher@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch
Subject: [PATCH] drm/amd: Clean up errors in smu_v13_0_5_ppt.c
Date: Tue,  1 Aug 2023 02:11:29 +0000
Message-Id: <20230801021129.4458-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Tue, 01 Aug 2023 08:27:46 +0000
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

ERROR: space prohibited before that ',' (ctx:WxW)

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
index ceb13c838067..bcc42abfc768 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
@@ -61,14 +61,14 @@
 #define smu_feature_get_enabled_mask(smu, mask)				smu_ppt_funcs(get_enabled_mask, -EOPNOTSUPP, smu, mask)
 #define smu_feature_is_enabled(smu, mask)				smu_ppt_funcs(feature_is_enabled, 0, smu, mask)
 #define smu_disable_all_features_with_exception(smu, mask)		smu_ppt_funcs(disable_all_features_with_exception, 0, smu, mask)
-#define smu_is_dpm_running(smu)						smu_ppt_funcs(is_dpm_running, 0 , smu)
+#define smu_is_dpm_running(smu)						smu_ppt_funcs(is_dpm_running, 0, smu)
 #define smu_notify_display_change(smu)					smu_ppt_funcs(notify_display_change, 0, smu)
 #define smu_populate_umd_state_clk(smu)					smu_ppt_funcs(populate_umd_state_clk, 0, smu)
 #define smu_enable_thermal_alert(smu)					smu_ppt_funcs(enable_thermal_alert, 0, smu)
 #define smu_disable_thermal_alert(smu)					smu_ppt_funcs(disable_thermal_alert, 0, smu)
 #define smu_smc_read_sensor(smu, sensor, data, size)			smu_ppt_funcs(read_sensor, -EINVAL, smu, sensor, data, size)
 #define smu_pre_display_config_changed(smu)				smu_ppt_funcs(pre_display_config_changed, 0, smu)
-#define smu_display_config_changed(smu)					smu_ppt_funcs(display_config_changed, 0 , smu)
+#define smu_display_config_changed(smu)					smu_ppt_funcs(display_config_changed, 0, smu)
 #define smu_apply_clocks_adjust_rules(smu)				smu_ppt_funcs(apply_clocks_adjust_rules, 0, smu)
 #define smu_notify_smc_display_config(smu)				smu_ppt_funcs(notify_smc_display_config, 0, smu)
 #define smu_run_btc(smu)						smu_ppt_funcs(run_btc, 0, smu)
-- 
2.17.1


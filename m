Return-Path: <SRS0=8rPh=AD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0E5C433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 07:16:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C10323A51
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 07:16:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C10323A51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BD766E55C;
	Mon, 22 Jun 2020 07:16:52 +0000 (UTC)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA0196E146
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2020 06:46:26 +0000 (UTC)
IronPort-SDR: ihHQsAbSIA6c2NlRAIfG5bqVoQggJ3HAf2WZlf7BL9M5ON8ooq9BwEUw5LaeaP5iYxsGrjCgzv
 vM7yc8TX124w==
X-IronPort-AV: E=McAfee;i="6000,8403,9659"; a="123340462"
X-IronPort-AV: E=Sophos;i="5.75,266,1589266800"; d="scan'208";a="123340462"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2020 23:46:26 -0700
IronPort-SDR: 9NBGk6WBCb2UOw8dNUnBjsVlrACUSRwemCNiykyAv6mjgTQNuEB6e4bWH1jYLFAk5RRJr1s1x3
 7gLzfO146knw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,266,1589266800"; d="scan'208";a="274918712"
Received: from bhanu-nuc8i7beh.iind.intel.com ([10.145.162.210])
 by orsmga003.jf.intel.com with ESMTP; 21 Jun 2020 23:46:23 -0700
From: Bhanuprakash Modem <bhanuprakash.modem@intel.com>
To: bhanuprakash.modem@intel.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH] Revert "drm/amd/display: Expose connector VRR range via
 debugfs"
Date: Mon, 22 Jun 2020 20:12:25 +0530
Message-Id: <20200622144225.16549-1-bhanuprakash.modem@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 22 Jun 2020 07:16:50 +0000
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
Cc: alexander.deucher@amd.com, manasi.d.navare@intel.com,
 harry.wentland@amd.com, nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As both VRR min and max are already part of drm_display_info,
drm can expose this VRR range for each connector.

Hence this logic should move to core DRM.

This reverts commit 727962f030c23422a01e8b22d0f463815fb15ec4.

Signed-off-by: Bhanuprakash Modem <bhanuprakash.modem@intel.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Manasi Navare <manasi.d.navare@intel.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 20 -------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 076af267b488..71387d2af2ed 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -820,24 +820,6 @@ static int output_bpc_show(struct seq_file *m, void *data)
 	return res;
 }
 
-/*
- * Returns the min and max vrr vfreq through the connector's debugfs file.
- * Example usage: cat /sys/kernel/debug/dri/0/DP-1/vrr_range
- */
-static int vrr_range_show(struct seq_file *m, void *data)
-{
-	struct drm_connector *connector = m->private;
-	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
-
-	if (connector->status != connector_status_connected)
-		return -ENODEV;
-
-	seq_printf(m, "Min: %u\n", (unsigned int)aconnector->min_vfreq);
-	seq_printf(m, "Max: %u\n", (unsigned int)aconnector->max_vfreq);
-
-	return 0;
-}
-
 #ifdef CONFIG_DRM_AMD_DC_HDCP
 /*
  * Returns the HDCP capability of the Display (1.4 for now).
@@ -1001,7 +983,6 @@ static ssize_t dp_dpcd_data_read(struct file *f, char __user *buf,
 DEFINE_SHOW_ATTRIBUTE(dmub_fw_state);
 DEFINE_SHOW_ATTRIBUTE(dmub_tracebuffer);
 DEFINE_SHOW_ATTRIBUTE(output_bpc);
-DEFINE_SHOW_ATTRIBUTE(vrr_range);
 #ifdef CONFIG_DRM_AMD_DC_HDCP
 DEFINE_SHOW_ATTRIBUTE(hdcp_sink_capability);
 #endif
@@ -1059,7 +1040,6 @@ static const struct {
 		{"phy_settings", &dp_phy_settings_debugfs_fop},
 		{"test_pattern", &dp_phy_test_pattern_fops},
 		{"output_bpc", &output_bpc_fops},
-		{"vrr_range", &vrr_range_fops},
 #ifdef CONFIG_DRM_AMD_DC_HDCP
 		{"hdcp_sink_capability", &hdcp_sink_capability_fops},
 #endif
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

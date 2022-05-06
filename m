Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9213C433FE
	for <amd-gfx@archiver.kernel.org>; Fri,  6 May 2022 15:43:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5109910E438;
	Fri,  6 May 2022 15:43:50 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84B9210E438
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 May 2022 15:43:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DEp0rdzkEsoocOSdQcpr31GKzYBkewEIRLK/zhZ7S7l3XVU/jLW8VK77mKiK6JrrzfaIwXXyrKVWgeE8ak+hKsDmO8w2nb9jlaE2JRh3kHO4DF0zY+ODA6g+wA6DN4P8cOteOihHmZDaAwrkeKM2fno+w9xJJLQNJhSAwEL1nNdNOEUnDNXN9K1oYrKMfpdcoUUZyiiPOV9NS1lpWvdHW7sSEwk1mUIzPdl7axzbM7LkELY9rNZXuRaTr2Nkwj2t2xywsO8ho0aAn6ikixTOpCxtA/qBcfji9iw4JKZ34Cgbj4aPxl+cTFMBvfsNNTN0/6kpl/Jmgg/oDFwW1B+Y7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2msVlxM6n7cNNC8PdiFN8oLVOLlh5FhF/FNHCgHjUI=;
 b=kRkNDQKnCcRkjD+L44u/78YLBxhYIvqHwfdYpHiJ16R1gBWoojabB39fHC/yUo7Yzw/RPsQP9QP46pvttSy/K4JT7UFG1y/hg23GQua2pdmhvvTIjWc+9kikeoXA3IBud89rUcemRb7jy+FScVPbYZAFes0/sjl0QJCWufJ06I8WkJvsr909pBO3vIJQxBdEcMC9d++/HPwrLfP07xtzEXvG9pyI4IImBgn1tFmASgc5/VePUG9tZeK6bWbU+ub9JNRCBppN6StnBjfILw7Mz6ki36QI+LvjcYV9F7S+amKI+7qzpS+Ubz4YDrSQWYiMYMbnwuxTbossC8+uu8j1Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2msVlxM6n7cNNC8PdiFN8oLVOLlh5FhF/FNHCgHjUI=;
 b=zxQrTM3MlV4g5SykBuSH8y5ntg/nTX2pO9QauZy6aqHT0bPgNaM0EHgCxEkwgg1sSBBwmS0MHuy1IF+jxx3TMqsJvIrZo+pmj2UatVbqBvPMe0YwAFnvlETHB3R/gCWCdX7hyxWDYpS+q3LBxwcVMWFHtGAvqbHuDD6JoeUOmNA=
Received: from MW4PR04CA0281.namprd04.prod.outlook.com (2603:10b6:303:89::16)
 by DM6PR12MB2889.namprd12.prod.outlook.com (2603:10b6:5:18a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Fri, 6 May
 2022 15:43:45 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::62) by MW4PR04CA0281.outlook.office365.com
 (2603:10b6:303:89::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Fri, 6 May 2022 15:43:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Fri, 6 May 2022 15:43:44 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 6 May
 2022 10:43:35 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/15] drm/amd/display: remove redundant CONFIG_DRM_AMD_DC_DCN
 in amdgpu_dm
Date: Fri, 6 May 2022 23:42:11 +0800
Message-ID: <20220506154214.3438665-13-stylon.wang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506154214.3438665-1-stylon.wang@amd.com>
References: <20220506154214.3438665-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46b14b25-ad73-4037-6438-08da2f77340a
X-MS-TrafficTypeDiagnostic: DM6PR12MB2889:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2889F70B9C64FFAC5AA19897FFC59@DM6PR12MB2889.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /7/RXwRLjitJ6MysQior3qCCarQ7nWjw9QLR4DLjUUYwhHBJ05XweDnv7XcIl4+BIMnfdY7KpXj0kwYohmyaoY9mNgj5Ak6WvPGMwvpg5Gq8Wzgagq320CAvMCEP1K0zcdM0S+nyhx4LCG5T/j6gb9LVZkvVwaTmMYu0E+dLujQOu6xUpQECwuYvUVvKvqprHapQuLSidT8Gk3JWorHgX0bs/vE5UWULz00nvV1yUuIgIZYYYBFCN/AP9wO7zmbXXmKY8KT/xd/QwO9S5QvtrqHVnYI89TuaksUJVxiVnyf+tIGXw3e+ia3cST4AmEFFXTK7ppBHEAd/nZocbMyekJz52PmsxlUbEYglqo4ZwbkXDCTec2cWUmnNbPNMQche1UjmeYRgVqv7gQPYmcm11Pw1zRKPD28MWXNwKfX1y35gDuPonAHE2HwUScQxaEM886Zh45Em5JjQar6rK4GIY/sS8ukQuSSYWCHFxCriq1k/brliWgkzra2SV4piWrR7ct01tKUV3RvQwcVDp3bZ+FRZ5FQbY1PoY6gNKsFgYWhY7B9aKLjd9DFRw/ZJSQzTD3Tp/C6jVZyjL065kuFBafjKG2l/2DlD6lfl3TJmxpqWlQLnhxsFf2jrPTwsY0RvMd1WtvSWbKlTOwgwbMBONaCOl81Sb3LMQjmf2JhvdYMWgYbigEOVlryfU/G+234nxFYdcGZgGgXpQsBrJMXeSA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(336012)(16526019)(2616005)(47076005)(426003)(186003)(1076003)(82310400005)(70206006)(70586007)(6916009)(8676002)(36756003)(54906003)(83380400001)(316002)(4326008)(86362001)(26005)(30864003)(44832011)(5660300002)(508600001)(36860700001)(81166007)(356005)(7696005)(6666004)(2906002)(40460700003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 15:43:44.5025 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b14b25-ad73-4037-6438-08da2f77340a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2889
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Hung <alex.hung@amd.com>

[Why & How]
CONFIG_DRM_AMD_DC_DCN is used by pass the compilation failures, but DC
code should be OS-agnostic.

This patch fixes it by removing unnecessasry CONFIG_DRM_AMD_DC_DCN
in amdgpu_dm directory.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 46 ++-----------------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  6 ---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  6 ---
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  2 -
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  2 -
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |  3 --
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |  4 --
 7 files changed, 3 insertions(+), 66 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 00ebda0bea44..2ea20dd7fccf 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -83,7 +83,6 @@
 #include <drm/drm_vblank.h>
 #include <drm/drm_audio_component.h>
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 #include "ivsrcid/dcn/irqsrcs_dcn_1_0.h"
 
 #include "dcn/dcn_1_0_offset.h"
@@ -92,7 +91,6 @@
 #include "vega10_ip_offset.h"
 
 #include "soc15_common.h"
-#endif
 
 #include "modules/inc/mod_freesync.h"
 #include "modules/power/power_helpers.h"
@@ -603,7 +601,6 @@ static void dm_crtc_high_irq(void *interrupt_params)
 	spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
 }
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
 /**
  * dm_dcn_vertical_interrupt0_high_irq() - Handles OTG Vertical interrupt0 for
@@ -827,7 +824,6 @@ static void dm_dmub_outbox1_low_irq(void *interrupt_params)
 	if (count > DMUB_TRACE_MAX_READ)
 		DRM_DEBUG_DRIVER("Warning : count > DMUB_TRACE_MAX_READ");
 }
-#endif /* CONFIG_DRM_AMD_DC_DCN */
 
 static int dm_set_clockgating_state(void *handle,
 		  enum amd_clockgating_state state)
@@ -1125,9 +1121,7 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 	switch (adev->ip_versions[DCE_HWIP][0]) {
 	case IP_VERSION(3, 1, 3): /* Only for this asic hw internal rev B0 */
 		hw_params.dpia_supported = true;
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 		hw_params.disable_dpia = adev->dm.dc->debug.dpia_debug.bits.disable_dpia;
-#endif
 		break;
 	default:
 		break;
@@ -1189,7 +1183,6 @@ static void dm_dmub_hw_resume(struct amdgpu_device *adev)
 	}
 }
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_addr_space_config *pa_config)
 {
 	uint64_t pt_base;
@@ -1244,8 +1237,7 @@ static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_
 	pa_config->is_hvm_enabled = 0;
 
 }
-#endif
-#if defined(CONFIG_DRM_AMD_DC_DCN)
+
 static void vblank_control_worker(struct work_struct *work)
 {
 	struct vblank_control_work *vblank_work =
@@ -1282,8 +1274,6 @@ static void vblank_control_worker(struct work_struct *work)
 	kfree(vblank_work);
 }
 
-#endif
-
 static void dm_handle_hpd_rx_offload_work(struct work_struct *work)
 {
 	struct hpd_rx_irq_offload_work *offload_work;
@@ -1410,9 +1400,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	mutex_init(&adev->dm.dc_lock);
 	mutex_init(&adev->dm.audio_lock);
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	spin_lock_init(&adev->dm.vblank_lock);
-#endif
 
 	if(amdgpu_dm_irq_init(adev)) {
 		DRM_ERROR("amdgpu: failed to initialize DM IRQ support.\n");
@@ -1505,12 +1493,10 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	if (amdgpu_dc_feature_mask & DC_EDP_NO_POWER_SEQUENCING)
 		init_data.flags.edp_no_power_sequencing = true;
 
-#ifdef CONFIG_DRM_AMD_DC_DCN
 	if (amdgpu_dc_feature_mask & DC_DISABLE_LTTPR_DP1_4A)
 		init_data.flags.allow_lttpr_non_transparent_mode.bits.DP1_4A = true;
 	if (amdgpu_dc_feature_mask & DC_DISABLE_LTTPR_DP2_0)
 		init_data.flags.allow_lttpr_non_transparent_mode.bits.DP2_0 = true;
-#endif
 
 	init_data.flags.seamless_boot_edp_requested = false;
 
@@ -1566,7 +1552,6 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		goto error;
 	}
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	if ((adev->flags & AMD_IS_APU) && (adev->asic_type >= CHIP_CARRIZO)) {
 		struct dc_phy_addr_space_config pa_config;
 
@@ -1575,7 +1560,6 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		// Call the DC init_memory func
 		dc_setup_system_context(adev->dm.dc, &pa_config);
 	}
-#endif
 
 	adev->dm.freesync_module = mod_freesync_create(adev->dm.dc);
 	if (!adev->dm.freesync_module) {
@@ -1587,14 +1571,12 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	amdgpu_dm_init_color_mod();
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	if (adev->dm.dc->caps.max_links > 0) {
 		adev->dm.vblank_control_workqueue =
 			create_singlethread_workqueue("dm_vblank_control_workqueue");
 		if (!adev->dm.vblank_control_workqueue)
 			DRM_ERROR("amdgpu: failed to initialize vblank_workqueue.\n");
 	}
-#endif
 
 #ifdef CONFIG_DRM_AMD_DC_HDCP
 	if (adev->dm.dc->caps.max_links > 0 && adev->family >= AMDGPU_FAMILY_RV) {
@@ -1626,7 +1608,6 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		}
 
 		amdgpu_dm_outbox_init(adev);
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 		if (!register_dmub_notify_callback(adev, DMUB_NOTIFICATION_AUX_REPLY,
 			dmub_aux_setconfig_callback, false)) {
 			DRM_ERROR("amdgpu: fail to register dmub aux callback");
@@ -1640,7 +1621,6 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 			DRM_ERROR("amdgpu: fail to register dmub hpd callback");
 			goto error;
 		}
-#endif /* CONFIG_DRM_AMD_DC_DCN */
 	}
 
 	if (amdgpu_dm_initialize_drm_device(adev)) {
@@ -1687,12 +1667,10 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
 {
 	int i;
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	if (adev->dm.vblank_control_workqueue) {
 		destroy_workqueue(adev->dm.vblank_control_workqueue);
 		adev->dm.vblank_control_workqueue = NULL;
 	}
-#endif
 
 	for (i = 0; i < adev->dm.display_indexes_num; i++) {
 		drm_encoder_cleanup(&adev->dm.mst_encoders[i].base);
@@ -2403,9 +2381,7 @@ static int dm_suspend(void *handle)
 	if (amdgpu_in_reset(adev)) {
 		mutex_lock(&dm->dc_lock);
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 		dc_allow_idle_optimizations(adev->dm.dc, false);
-#endif
 
 		dm->cached_dc_state = dc_copy_state(dm->dc->current_state);
 
@@ -3558,7 +3534,6 @@ static int dce110_register_irq_handlers(struct amdgpu_device *adev)
 	return 0;
 }
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 /* Register IRQ sources and initialize IRQ callbacks */
 static int dcn10_register_irq_handlers(struct amdgpu_device *adev)
 {
@@ -3747,7 +3722,6 @@ static int register_outbox_irq_handlers(struct amdgpu_device *adev)
 
 	return 0;
 }
-#endif
 
 /*
  * Acquires the lock for the atomic state object and returns
@@ -4251,7 +4225,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 			goto fail;
 		}
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	/* Use Outbox interrupt */
 	switch (adev->ip_versions[DCE_HWIP][0]) {
 	case IP_VERSION(3, 0, 0):
@@ -4284,7 +4257,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 			break;
 		}
 	}
-#endif
 
 	/* Disable vblank IRQs aggressively for power-saving. */
 	adev_to_drm(adev)->vblank_disable_immediate = true;
@@ -4380,7 +4352,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		}
 		break;
 	default:
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 		switch (adev->ip_versions[DCE_HWIP][0]) {
 		case IP_VERSION(1, 0, 0):
 		case IP_VERSION(1, 0, 1):
@@ -4406,7 +4377,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 					adev->ip_versions[DCE_HWIP][0]);
 			goto fail;
 		}
-#endif
 		break;
 	}
 
@@ -4555,7 +4525,7 @@ static int dm_early_init(void *handle)
 		adev->mode_info.num_dig = 6;
 		break;
 	default:
-#if defined(CONFIG_DRM_AMD_DC_DCN)
+
 		switch (adev->ip_versions[DCE_HWIP][0]) {
 		case IP_VERSION(2, 0, 2):
 		case IP_VERSION(3, 0, 0):
@@ -4592,7 +4562,6 @@ static int dm_early_init(void *handle)
 					adev->ip_versions[DCE_HWIP][0]);
 			return -EINVAL;
 		}
-#endif
 		break;
 	}
 
@@ -6646,10 +6615,8 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
 	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
 	struct amdgpu_device *adev = drm_to_adev(crtc->dev);
 	struct dm_crtc_state *acrtc_state = to_dm_crtc_state(crtc->state);
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	struct amdgpu_display_manager *dm = &adev->dm;
 	struct vblank_control_work *work;
-#endif
 	int rc = 0;
 
 	if (enable) {
@@ -6672,7 +6639,6 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
 	if (amdgpu_in_reset(adev))
 		return 0;
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	if (dm->vblank_control_workqueue) {
 		work = kzalloc(sizeof(*work), GFP_ATOMIC);
 		if (!work)
@@ -6690,7 +6656,6 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
 
 		queue_work(dm->vblank_control_workqueue, &work->work);
 	}
-#endif
 
 	return 0;
 }
@@ -9362,14 +9327,12 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 	/* Update the planes if changed or disable if we don't have any. */
 	if ((planes_count || acrtc_state->active_planes == 0) &&
 		acrtc_state->stream) {
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 		/*
 		 * If PSR or idle optimizations are enabled then flush out
 		 * any pending work before hardware programming.
 		 */
 		if (dm->vblank_control_workqueue)
 			flush_workqueue(dm->vblank_control_workqueue);
-#endif
 
 		bundle->stream_update.stream = acrtc_state->stream;
 		if (new_pcrtc_state->mode_changed) {
@@ -9702,21 +9665,18 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 	if (dc_state) {
 		/* if there mode set or reset, disable eDP PSR */
 		if (mode_set_reset_required) {
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 			if (dm->vblank_control_workqueue)
 				flush_workqueue(dm->vblank_control_workqueue);
-#endif
+
 			amdgpu_dm_psr_disable_all(dm);
 		}
 
 		dm_enable_per_frame_crtc_master_sync(dc_state);
 		mutex_lock(&dm->dc_lock);
 		WARN_ON(!dc_commit_state(dm->dc, dc_state));
-#if defined(CONFIG_DRM_AMD_DC_DCN)
                /* Allow idle optimization when vblank count is 0 for display off */
                if (dm->active_vblank_irq_count == 0)
                    dc_allow_idle_optimizations(dm->dc,true);
-#endif
 		mutex_unlock(&dm->dc_lock);
 	}
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 321279bc877b..3cc5c15303e6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -358,14 +358,12 @@ struct amdgpu_display_manager {
 	 */
 	struct mutex audio_lock;
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	/**
 	 * @vblank_lock:
 	 *
 	 * Guards access to deferred vblank work state.
 	 */
 	spinlock_t vblank_lock;
-#endif
 
 	/**
 	 * @audio_component:
@@ -469,14 +467,12 @@ struct amdgpu_display_manager {
 	struct hdcp_workqueue *hdcp_workqueue;
 #endif
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	/**
 	 * @vblank_control_workqueue:
 	 *
 	 * Deferred work for vblank control events.
 	 */
 	struct workqueue_struct *vblank_control_workqueue;
-#endif
 
 	struct drm_atomic_state *cached_state;
 	struct dc_state *cached_dc_state;
@@ -493,14 +489,12 @@ struct amdgpu_display_manager {
 	 */
 	const struct gpu_info_soc_bounding_box_v1_0 *soc_bounding_box;
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	/**
 	 * @active_vblank_irq_count:
 	 *
 	 * number of currently active vblank irqs
 	 */
 	uint32_t active_vblank_irq_count;
-#endif
 
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
 	/**
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 5193afb067d3..9a406378d906 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -295,9 +295,7 @@ static ssize_t dp_link_settings_write(struct file *f, const char __user *buf,
 	case LINK_RATE_RBR2:
 	case LINK_RATE_HIGH2:
 	case LINK_RATE_HIGH3:
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	case LINK_RATE_UHBR10:
-#endif
 		break;
 	default:
 		valid_input = false;
@@ -3415,7 +3413,6 @@ static int disable_hpd_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(disable_hpd_ops, disable_hpd_get,
 			 disable_hpd_set, "%llu\n");
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 /*
  * Temporary w/a to force sst sequence in M42D DP2 mst receiver
  * Example usage: echo 1 > /sys/kernel/debug/dri/0/amdgpu_dm_dp_set_mst_en_for_sst
@@ -3463,7 +3460,6 @@ static int dp_ignore_cable_id_get(void *data, u64 *val)
 }
 DEFINE_DEBUGFS_ATTRIBUTE(dp_ignore_cable_id_ops, dp_ignore_cable_id_get,
 			 dp_ignore_cable_id_set, "%llu\n");
-#endif
 
 /*
  * Sets the DC visual confirm debug option from the given string.
@@ -3612,12 +3608,10 @@ void dtn_debugfs_init(struct amdgpu_device *adev)
 			    adev, &mst_topo_fops);
 	debugfs_create_file("amdgpu_dm_dtn_log", 0644, root, adev,
 			    &dtn_log_fops);
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	debugfs_create_file("amdgpu_dm_dp_set_mst_en_for_sst", 0644, root, adev,
 				&dp_set_mst_en_for_sst_ops);
 	debugfs_create_file("amdgpu_dm_dp_ignore_cable_id", 0644, root, adev,
 				&dp_ignore_cable_id_ops);
-#endif
 
 	debugfs_create_file_unsafe("amdgpu_dm_visual_confirm", 0644, root, adev,
 				   &visual_confirm_fops);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 28cf24f6ab32..7c799ddc1d27 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -977,9 +977,7 @@ void dm_set_phyd32clk(struct dc_context *ctx, int freq_khz)
        // TODO
 }
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 void dm_helpers_enable_periodic_detection(struct dc_context *ctx, bool enable)
 {
 	/* TODO: add periodic detection implementation */
 }
-#endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 0542034530b1..23e82b839c20 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -45,12 +45,10 @@
 #include "amdgpu_dm_debugfs.h"
 #endif
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 #include "dc/dcn20/dcn20_resource.h"
 bool is_timing_changed(struct dc_stream_state *cur_stream,
 		       struct dc_stream_state *new_stream);
 
-#endif
 
 static ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
 				  struct drm_dp_aux_msg *msg)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
index c561e0d872d6..85628ad59e6c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
@@ -46,8 +46,6 @@ void amdgpu_dm_initialize_dp_connector(struct amdgpu_display_manager *dm,
 void
 dm_dp_create_fake_mst_encoders(struct amdgpu_device *adev);
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
-
 struct dsc_mst_fairness_vars {
 	int pbn;
 	bool dsc_enabled;
@@ -64,6 +62,5 @@ bool needs_dsc_aux_workaround(struct dc_link *link);
 void pre_validate_dsc(struct drm_atomic_state *state,
 		      struct dm_atomic_state **dm_state_ptr,
 		      struct dsc_mst_fairness_vars *vars);
-#endif
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index 13b1751e69bf..141fd2721501 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -29,7 +29,6 @@
 #include "amdgpu_dm.h"
 #include "modules/power/power_helpers.h"
 
-#ifdef CONFIG_DRM_AMD_DC_DCN
 static bool link_supports_psrsu(struct dc_link *link)
 {
 	struct dc *dc = link->ctx->dc;
@@ -53,7 +52,6 @@ static bool link_supports_psrsu(struct dc_link *link)
 
 	return true;
 }
-#endif
 
 /*
  * amdgpu_dm_set_psr_caps() - set link psr capabilities
@@ -73,11 +71,9 @@ void amdgpu_dm_set_psr_caps(struct dc_link *link)
 		link->psr_settings.psr_feature_enabled = false;
 
 	} else {
-#ifdef CONFIG_DRM_AMD_DC_DCN
 		if (link_supports_psrsu(link))
 			link->psr_settings.psr_version = DC_PSR_VERSION_SU_1;
 		else
-#endif
 			link->psr_settings.psr_version = DC_PSR_VERSION_1;
 
 		link->psr_settings.psr_feature_enabled = true;
-- 
2.35.1


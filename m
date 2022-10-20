Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F3EC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Oct 2022 15:50:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8166B10E116;
	Thu, 20 Oct 2022 15:50:12 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2539110E5F8
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 15:48:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTcipYJwHAZJG0RNFziwAl9zmbXHl4a0VIGFOf5SQTkco0hz1qJttfMX0Eq42liYWVhvYWPP1C2amsxV0XFbW23u1QdKLaQXyHupPOUmYO7uzq/zeOWTTZ2aB/ZGXeMtp/C8xxaFIw/sxdWIksTxmG5hkxhbrVRJM869VJBd5hYek2RxtljHJRy1OcqaLvxzff7+/DuAh3m8/Ap0pB3dEd+K7+7s+HzcA3kGbmp5A3nB52ZERHEoATEODWNuWwvZmHXv2+skvpmj1a+v5sTglOWZnmO7BynquFvqywQJ48rs518Ey7mGegO5u8yw6TI67nyFYH3paubbq7U9M4YDJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVo6AKQspwvXiXe0KN6SVvjZWgE0fAKhqnLPSAXKl6I=;
 b=G0bLeAQnn0gsRhTFx0mCk2Yd3UIfIdPhslIVKe/s982uX9KM0mOk0AFJNuO1eca+S81c5Yma48/cA4uppewxWDe3TFHJ/2iUTS1P8shUqUZO0Jkm9khYS3puHw4oGwLiY1GZl4FLNkb3Drf+8dV+O1NskptJJkAdYv2hYgFoJdmupd2HdKcqN6Oq/EllHnFuHZexd7YSU6mduNO9HaKbbJ8+gRPjeWOTQif/Aqi5oRi7DjuZuTDpSxW2sO0guecUVvZtAJ7+U4ivoSP21855LwezMwDtqA4VUehWMM4z9b3ZnRSXptVVA8Qamvb+97lSbbjgYWnUjelPArwcOyGW/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVo6AKQspwvXiXe0KN6SVvjZWgE0fAKhqnLPSAXKl6I=;
 b=NDbA7G64C6dqbZy8oQFN4lhdOJj0ionNPAoy1S5LkKmP8fvKgrcyMeySx7FVPCTFvoTRZTrWm2q6nBFcknrB7IuKbYYl1OOdXGVJ22vHmIC+dHxFki2WhfJ+EULzzviW8Xnsqothj8dfxxWYlQ8sr2T1b97VVKIBID+2um1Fr2k=
Received: from DS7PR03CA0081.namprd03.prod.outlook.com (2603:10b6:5:3bb::26)
 by PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Thu, 20 Oct
 2022 15:48:16 +0000
Received: from DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::60) by DS7PR03CA0081.outlook.office365.com
 (2603:10b6:5:3bb::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34 via Frontend
 Transport; Thu, 20 Oct 2022 15:48:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT091.mail.protection.outlook.com (10.13.173.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 20 Oct 2022 15:48:16 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 10:48:14 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 28/33] drm/amd/display: Expand kernel doc for DC
Date: Thu, 20 Oct 2022 11:46:57 -0400
Message-ID: <20221020154702.503934-29-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
References: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT091:EE_|PH0PR12MB5417:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d76d0f8-3d0e-4d17-a384-08dab2b280e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qkE6B/H68+003230ouSeDS2uMVFr6VA9JMLd68mUXzW4rdir1t/LWAIMQw8ymep3eMMNZBbMzzoam5HVXfvQxRdMRwFRozqLZVr5QzSoPTqxXl3OzS/wYM1t4hXSAkhJE3Ic8paQIof7W53n8T0J/O1GVcALCU25zYwg6zC/gCtaQnjmtLfJ+eUvvJdPzFw8T5CZ+p9rum9Ef1qnSc38ZcDngMZRCvd5Zgcl5QFCE09W/c39tgyqMU3KKns1yL2O2nAqVcCWz/OY+UUPFhlEEImjaYcYe7xlcxCHCbG5wcjmV5Y6uABP1GY84W5L9a/zbdxT7+Q3gu5ww2DS/55ZD6C1HQnwBq0ODSOkSm0m+p1rXtRKv7vvAQ1xsCvT2fwcsAkyMg08CEKlTRn9wtahEvG3bt847JZJ2aX8skAU8H/t59EDHG+JycSrmZwnY7h2GHcTurH3IwBgFD/xr6cjSpFYo4kXjJzh0bN4WJen/mboJY2K3F9WR+TSik/K6LZzVwkxmrBT6zmUhficQTomgH9VI4pQZf/S+CS1P0E9cstNqNc4VJCh1WRQCiYibuutjMin6AsZc5QFtPRT+f29+aV9cU++u4NAGz77dgQNvcb5f4VnPSNBE/rZQh0IQSLsXKbXFZYZaA4prAIBqyfdaBphg1y4rWrPmmXPvpr7N6Mkp0C++v8g5JusOd/C/Ym9lrGC4eOpecc+ITrPril1v7P0c//TEKOnFgS00zE7itHAKzSAzEiXkG+IrMn4D+fL1A21unOHgWzffnsklLjPDqDA4kXNQH8d8842nAxjqZ1bq3WKfrL1Z/yUbvDrk1JA
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199015)(46966006)(40470700004)(36840700001)(66899015)(36756003)(82310400005)(86362001)(82740400003)(41300700001)(356005)(426003)(47076005)(36860700001)(2616005)(83380400001)(81166007)(40460700003)(16526019)(1076003)(186003)(336012)(40480700001)(6666004)(7696005)(478600001)(5660300002)(2906002)(316002)(8936002)(6916009)(70206006)(8676002)(4326008)(26005)(54906003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 15:48:16.1955 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d76d0f8-3d0e-4d17-a384-08dab2b280e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5417
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This commit adds extra documentation for elements related to FAMs.

Reviewed-by: Aurabindo Pillai <Aurabindo.Pillai@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           | 19 +++++++++++---
 drivers/gpu/drm/amd/display/dc/dc_stream.h    | 11 ++++++++
 .../gpu/drm/amd/display/dc/dml/dc_features.h  |  7 ++++++
 .../amd/display/dc/dml/display_mode_enums.h   | 25 +++++++++++++++++++
 .../drm/amd/display/dc/dml/display_mode_vba.h |  9 +++++++
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  7 ++++++
 .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |  7 ++++++
 7 files changed, 82 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 9e0b59297661..80ce42b167b6 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -494,9 +494,12 @@ enum dcn_zstate_support_state {
 	DCN_ZSTATE_SUPPORT_ALLOW_Z10_ONLY,
 	DCN_ZSTATE_SUPPORT_DISALLOW,
 };
-/*
- * For any clocks that may differ per pipe
- * only the max is stored in this structure
+
+/**
+ * dc_clocks - DC pipe clocks
+ *
+ * For any clocks that may differ per pipe only the max is stored in this
+ * structure
  */
 struct dc_clocks {
 	int dispclk_khz;
@@ -523,6 +526,16 @@ struct dc_clocks {
 	bool prev_p_state_change_support;
 	bool fclk_prev_p_state_change_support;
 	int num_ways;
+
+	/**
+	 * @fw_based_mclk_switching
+	 *
+	 * DC has a mechanism that leverage the variable refresh rate to switch
+	 * memory clock in cases that we have a large latency to achieve the
+	 * memory clock change and a short vblank window. DC has some
+	 * requirements to enable this feature, and this field describes if the
+	 * system support or not such a feature.
+	 */
 	bool fw_based_mclk_switching;
 	bool fw_based_mclk_switching_shut_down;
 	int prev_num_ways;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 4d30ae0ca721..f4dfd3a49b68 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -201,7 +201,18 @@ struct dc_stream_state {
 	bool use_vsc_sdp_for_colorimetry;
 	bool ignore_msa_timing_param;
 
+	/**
+	 * @allow_freesync:
+	 *
+	 * It say if Freesync is enabled or not.
+	 */
 	bool allow_freesync;
+
+	/**
+	 * @vrr_active_variable:
+	 *
+	 * It describes if VRR is in use.
+	 */
 	bool vrr_active_variable;
 	bool freesync_on_desktop;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dc_features.h b/drivers/gpu/drm/amd/display/dc/dml/dc_features.h
index 74e86732e301..2cbdd75429ff 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dc_features.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dc_features.h
@@ -29,6 +29,13 @@
 #define DC__PRESENT 1
 #define DC__PRESENT__1 1
 #define DC__NUM_DPP 4
+
+/**
+ * @DC__VOLTAGE_STATES:
+ *
+ * Define the maximum amount of states supported by the ASIC. Every ASIC has a
+ * specific number of states; this macro defines the maximum number of states.
+ */
 #define DC__VOLTAGE_STATES 20
 #define DC__NUM_DPP__4 1
 #define DC__NUM_DPP__0_PRESENT 1
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_enums.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_enums.h
index f394b3f3922a..0bffae95f3a2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_enums.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_enums.h
@@ -105,14 +105,39 @@ enum source_macro_tile_size {
 enum cursor_bpp {
 	dm_cur_2bit = 0, dm_cur_32bit = 1, dm_cur_64bit = 2
 };
+
+/**
+ * @enum clock_change_support - It represents possible reasons to change the DRAM clock.
+ *
+ * DC may change the DRAM clock during its execution, and this enum tracks all
+ * the available methods. Note that every ASIC has their specific way to deal
+ * with these clock switch.
+ */
 enum clock_change_support {
+	/**
+	 * @dm_dram_clock_change_uninitialized: If you see this, we might have
+	 * a code initialization issue
+	 */
 	dm_dram_clock_change_uninitialized = 0,
+
+	/**
+	 * @dm_dram_clock_change_vactive: Support DRAM switch in VActive
+	 */
 	dm_dram_clock_change_vactive,
+
+	/**
+	 * @dm_dram_clock_change_vblank: Support DRAM switch in VBlank
+	 */
 	dm_dram_clock_change_vblank,
+
 	dm_dram_clock_change_vactive_w_mall_full_frame,
 	dm_dram_clock_change_vactive_w_mall_sub_vp,
 	dm_dram_clock_change_vblank_w_mall_full_frame,
 	dm_dram_clock_change_vblank_w_mall_sub_vp,
+
+	/**
+	 * @dm_dram_clock_change_unsupported: Do not support DRAM switch
+	 */
 	dm_dram_clock_change_unsupported
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index 630f3395e90a..d46aa4817e70 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -419,6 +419,15 @@ struct vba_vars_st {
 	double MinPixelChunkSizeBytes;
 	unsigned int DCCMetaBufferSizeBytes;
 	// Pipe/Plane Parameters
+
+	/** @VoltageLevel:
+	 * Every ASIC has a fixed number of DPM states, and some devices might
+	 * have some particular voltage configuration that does not map
+	 * directly to the DPM states. This field tells how many states the
+	 * target device supports; even though this field combines the DPM and
+	 * special SOC voltages, it mostly matches the total number of DPM
+	 * states.
+	 */
 	int VoltageLevel;
 	double FabricClock;
 	double DRAMSpeed;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 9498105c98ab..295845d49cb9 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -115,6 +115,13 @@ struct resource_funcs {
 				int vlevel);
 	void (*update_soc_for_wm_a)(
 				struct dc *dc, struct dc_state *context);
+
+	/**
+	 * @populate_dml_pipes - Populate pipe data struct
+	 *
+	 * Returns:
+	 * Total of pipes available in the specific ASIC.
+	 */
 	int (*populate_dml_pipes)(
 		struct dc *dc,
 		struct dc_state *context,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
index cd2be729846b..a819f0f97c5f 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
@@ -35,6 +35,13 @@
  ******************************************************************************/
 
 #define MAX_AUDIOS 7
+
+/**
+ * @MAX_PIPES:
+ *
+ * Every ASIC support a fixed number of pipes; MAX_PIPES defines a large number
+ * to be used inside loops and for determining array sizes.
+ */
 #define MAX_PIPES 6
 #define MAX_DIG_LINK_ENCODERS 7
 #define MAX_DWB_PIPES	1
-- 
2.35.1


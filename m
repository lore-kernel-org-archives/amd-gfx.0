Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74059C77B6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:54:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0BC510EDD2;
	Fri, 14 Apr 2023 15:54:31 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEB4110EDD0
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:54:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDo1QVZ18IHYGggh7axOUu1iySgHWAj24UaYCU3oDQYwWc7gUw1+8nmXs6EDbbvHsKHaQVE2WoCUbJGt/GZ73aN8cfTpWoLyG3pUhll3aUOgDOmNFoKoOUdxmXtgC3bMIMqhCBchkrZMY4hwQ7h/AI+eE9k1/a4oDqgJLm8O/1fz6XzNeni/oC9oC9QUUGf5NuLrzp6oc3VSQzIl2H0wswBuM6sRIqg7qceBpDAX38/DiW714PuWl1ntKbM74yGVF2xCHHeJqi2b/CtGFn+wC89zviQW5wlqma5vaPFGFmLh2Xt6Lgkw3YHBpj2OjnTeQoiKtPK+HPBS2zL9uAo1YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZflXKhFCBoCKgq6GzHBrI0dhMdeqIDu/d2AFd+a8KE=;
 b=Gba//w2U8gQM9MY3UvmjM1BHPsTy6YCqvyPtFzWKagpcj3N6e86cWqiPE/rskt4vSozOXJcUAM1sgBbVXrxfEPThgbCpkDgev7z2Mgk8lclt9CIcRgSOhp2pzdZNbVF9d+4DQUJHKLY4amwGN38CfQPso4ngg45yQqZIO9/4Pz6KkZFcO+ZDDz4ZV+yEJHYETeEAKu8VqS6KZR2AJkGQzSfzw8zbPnUYirfY8+fs8X+hIiUAaSbXrbrjhSpddsRH+Dy9qcv723AXkhpEbTx8vrtosS2JTdQNVuB4D4whrMiz8VQED8mMj5quPmsfa0R53vXTtiRTqbBNX4bVxU7BAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZflXKhFCBoCKgq6GzHBrI0dhMdeqIDu/d2AFd+a8KE=;
 b=f5BwWJcr6hUvA3bFu+aJs7MeKd5QTUDCD17FEVTGNgWycC8J+eQSsWTt1wPQ3awcsGN6D4TIvhliu9ITnkw8+H1JmaVsudQMewVMnfg1HIxDkc6ruy9hUAaZF7NQFT6SCbKCNpEPVgxAvLz4pdPggSWu8t7IhCMxwkqZOXEJXuM=
Received: from BN0PR03CA0013.namprd03.prod.outlook.com (2603:10b6:408:e6::18)
 by SJ1PR12MB6050.namprd12.prod.outlook.com (2603:10b6:a03:48b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 15:54:24 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::6b) by BN0PR03CA0013.outlook.office365.com
 (2603:10b6:408:e6::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:54:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.36 via Frontend Transport; Fri, 14 Apr 2023 15:54:24 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:54:22 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 25/66] drm/amd/display: Adding support for VESA SCR
Date: Fri, 14 Apr 2023 11:52:49 -0400
Message-ID: <20230414155330.5215-26-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT062:EE_|SJ1PR12MB6050:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a25eec2-aa62-4548-5a08-08db3d008513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LSm1wLaVsVJOfA8LTI5Hz34WUwews/mEV2OGv8gq4T2QelfkBqxRl6gODDCUsMAvYeHbbmaFaGZ/AAnVQwP6/rfGR5+/3wFvdmBcCsIJJrSsfWUtN61oa7fxIROSQ2a8McyIUK6oCPBSHgbJfRVh5djujQq52SNG0CuXQJBoyh9+HmpzxK56e+rS2UXTTb3ZkTxJqtIx116X8gYo9Qun4+L0JTBSA2QmJydEMSZ32IoyET62X+sBY5bOZ9W2i7ioSKDGR6/QovosY6BAQ/Rb2y8VENERsen/gZF16soCKDKPCoy0tEHMbDjwoe9FHlDtXb9hzXjbQBVWD4Rjw58UhA5eo3ae2ZCKgdCj19c860CgTLwZLc05lglZRHHgFo+InTxZbhofuAHWRfG5rVw7COz4JeYeV4u1iCmA7j61wsLh8VEprqEEW3lWY4hBte/f3fuSdhPTRQQQy8mG6dJBgjdeGmpCN+WUnCbM35Ooj+ndgCOYvhwaEYQ7baVjxKoqByYpQROeIpycjlVKxYQkksTint7X3GwxCkQ3DDV/IHtw7nlCvDezPaKbihSkzuk5Cx5wmPwNZyDt2DAogwqDpQmcIWr5fR6VbIuGlY4Xa+5QDRPSSihaGq9o/n3Jnck5etNs3MkBFXLHqJdOedHR8yRoyNGCzpNFyeU0fEgCma7bNTncm8umtWWu3HBJ3ryh/q3ZM2u5Qt5AccWzT7aTXql6Gi9A2vZ9gID5r5rmFhc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199021)(46966006)(36840700001)(40470700004)(426003)(47076005)(83380400001)(2616005)(36860700001)(82310400005)(336012)(26005)(186003)(1076003)(36756003)(5660300002)(86362001)(16526019)(316002)(6666004)(478600001)(54906003)(4326008)(70206006)(6916009)(70586007)(81166007)(41300700001)(82740400003)(356005)(8676002)(8936002)(40460700003)(40480700001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:54:24.4520 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a25eec2-aa62-4548-5a08-08db3d008513
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6050
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
Cc: stylon.wang@amd.com, Anthony Koo <Anthony.Koo@amd.com>,
 Iswara Nagulendran <Iswara.Nagulendran@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Iswara Nagulendran <Iswara.Nagulendran@amd.com>

[HOW&WHY]
Write DPCD 721 bit 7 to high, and
the appropriate luminance level
to DPCD 734-736 if bit 4 from DPCD register
734 is high, indicating that the panel
luminance control is enabled from the panel side.

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Iswara Nagulendran <Iswara.Nagulendran@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  7 +++++
 .../dc/link/protocols/link_dp_capability.c    |  9 +++++-
 .../link/protocols/link_edp_panel_control.c   | 29 ++++++++++++++++---
 include/drm/display/drm_dp.h                  |  3 ++
 4 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index 49aab1924665..4a7f6497dc5a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -566,6 +566,12 @@ struct dpcd_amd_device_id {
 	uint8_t dal_version_byte2;
 };
 
+struct target_luminance_value {
+	uint8_t byte0;
+	uint8_t byte1;
+	uint8_t byte2;
+};
+
 struct dpcd_source_backlight_set {
 	struct  {
 		uint8_t byte0;
@@ -1225,6 +1231,7 @@ struct dpcd_caps {
 	union dp_main_line_channel_coding_cap channel_coding_cap;
 	union dp_sink_video_fallback_formats fallback_formats;
 	union dp_fec_capability1 fec_cap1;
+	bool panel_luminance_control;
 	union dp_cable_id cable_id;
 	uint8_t edp_rev;
 	union edp_alpm_caps alpm_caps;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index eeaceed61bc4..50327a559a47 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -1449,7 +1449,8 @@ bool read_is_mst_supported(struct dc_link *link)
  */
 static bool dpcd_read_sink_ext_caps(struct dc_link *link)
 {
-	uint8_t dpcd_data;
+	uint8_t dpcd_data = 0;
+	uint8_t edp_general_cap2 = 0;
 
 	if (!link)
 		return false;
@@ -1458,6 +1459,12 @@ static bool dpcd_read_sink_ext_caps(struct dc_link *link)
 		return false;
 
 	link->dpcd_sink_ext_caps.raw = dpcd_data;
+
+	if (core_link_read_dpcd(link, DP_EDP_GENERAL_CAP_2, &edp_general_cap2, 1) != DC_OK)
+		return false;
+
+	link->dpcd_caps.panel_luminance_control = (edp_general_cap2 & DP_EDP_PANEL_LUMINANCE_CONTROL_CAPABLE) != 0;
+
 	return true;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index d895046787bc..5ab2de12ccf8 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -164,14 +164,35 @@ bool edp_set_backlight_level_nits(struct dc_link *link,
 	*(uint16_t *)&dpcd_backlight_set.backlight_transition_time_ms = (uint16_t)transition_time_in_ms;
 
 
-	if (core_link_write_dpcd(link, DP_SOURCE_BACKLIGHT_LEVEL,
+	if (!link->dpcd_caps.panel_luminance_control) {
+		if (core_link_write_dpcd(link, DP_SOURCE_BACKLIGHT_LEVEL,
 			(uint8_t *)(&dpcd_backlight_set),
 			sizeof(dpcd_backlight_set)) != DC_OK)
-		return false;
+			return false;
 
-	if (core_link_write_dpcd(link, DP_SOURCE_BACKLIGHT_CONTROL,
+		if (core_link_write_dpcd(link, DP_SOURCE_BACKLIGHT_CONTROL,
 			&backlight_control, 1) != DC_OK)
-		return false;
+			return false;
+	} else {
+		const uint8_t backlight_enable = DP_EDP_PANEL_LUMINANCE_CONTROL_ENABLE;
+		struct target_luminance_value *target_luminance = NULL;
+
+		//if target luminance value is greater than 24 bits, clip the value to 24 bits
+		if (backlight_millinits > 0xFFFFFF)
+			backlight_millinits = 0xFFFFFF;
+
+		target_luminance = (struct target_luminance_value *)&backlight_millinits;
+
+		if (core_link_write_dpcd(link, DP_EDP_BACKLIGHT_MODE_SET_REGISTER,
+			&backlight_enable,
+			sizeof(backlight_enable)) != DC_OK)
+			return false;
+
+		if (core_link_write_dpcd(link, DP_EDP_PANEL_TARGET_LUMINANCE_VALUE,
+			(uint8_t *)(target_luminance),
+			sizeof(struct target_luminance_value)) != DC_OK)
+			return false;
+	}
 
 	return true;
 }
diff --git a/include/drm/display/drm_dp.h b/include/drm/display/drm_dp.h
index ed10e6b6f99d..f1be179c5f1f 100644
--- a/include/drm/display/drm_dp.h
+++ b/include/drm/display/drm_dp.h
@@ -973,6 +973,7 @@
 
 #define DP_EDP_GENERAL_CAP_2		    0x703
 # define DP_EDP_OVERDRIVE_ENGINE_ENABLED		(1 << 0)
+# define DP_EDP_PANEL_LUMINANCE_CONTROL_CAPABLE (1 << 4)
 
 #define DP_EDP_GENERAL_CAP_3		    0x704    /* eDP 1.4 */
 # define DP_EDP_X_REGION_CAP_MASK			(0xf << 0)
@@ -998,6 +999,7 @@
 # define DP_EDP_DYNAMIC_BACKLIGHT_ENABLE		(1 << 4)
 # define DP_EDP_REGIONAL_BACKLIGHT_ENABLE		(1 << 5)
 # define DP_EDP_UPDATE_REGION_BRIGHTNESS		(1 << 6) /* eDP 1.4 */
+# define DP_EDP_PANEL_LUMINANCE_CONTROL_ENABLE  (1 << 7)
 
 #define DP_EDP_BACKLIGHT_BRIGHTNESS_MSB     0x722
 #define DP_EDP_BACKLIGHT_BRIGHTNESS_LSB     0x723
@@ -1022,6 +1024,7 @@
 
 #define DP_EDP_DBC_MINIMUM_BRIGHTNESS_SET   0x732
 #define DP_EDP_DBC_MAXIMUM_BRIGHTNESS_SET   0x733
+#define DP_EDP_PANEL_TARGET_LUMINANCE_VALUE 0x734
 
 #define DP_EDP_REGIONAL_BACKLIGHT_BASE      0x740    /* eDP 1.4 */
 #define DP_EDP_REGIONAL_BACKLIGHT_0	    0x741    /* eDP 1.4 */
-- 
2.34.1


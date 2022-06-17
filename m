Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2EAC43334
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jun 2022 19:35:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6108B10F329;
	Fri, 17 Jun 2022 19:35:52 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2043.outbound.protection.outlook.com [40.107.212.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AFF010F319
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 19:35:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQKZWlpQNqe5WtM+nd/ZBuYVEZKBdHhQbB0BsyX4wKQ/skohUkxAu00qq+4ZuxKMhzLywpOpRrtCctDtPjQy3RN8VWfeGcV/lMQ3PtP604EIrJxH81VoPeDpRJ4AUUePH9NuKD2zLcb7kBBvnwDhLaOYJdSLV6ZD5G2faegePIxcOkzGXAk1kjXuT1Gu1Vl2cPfKzQP/GvjEBQ9TTUH85qFxKA/h5qZL9fxvgBpGytQmXeR65PvY7rFEsIYPIiHThWnGSAmb0/b8vfPdHskLsl/VQPXr9ZB46oth9s+lvpjKBqQJ3PIrqc5I8syniZSEZ3UECv+X2kKtJTUw67VezA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytjGqY/ZmDC4vNY9oEwlIMYbNRD6ubb4fEsraFE86h0=;
 b=hEFSZvfglrEeFj1SX6gKzRt8c20Zjx916JewaVY8+vDPfNdSbhRiEvOA8do37GujSrz9LVkvHm6i+Z2Ta4WuXSNVn2ukhTowkQmykNbNKScBWepyKfXeokEL3wLuQYl+fbHNIqp+LJrMfsJo9bbXXeVQ45yUZlEQD/Kbl+6bFkACoEet7OupXLH6n7GGa6Lo7ixY0ngi92sWpB65KLgAPNY68piRA/J0T8gAYvtOAd1LylD395115G6c3m86dI3A4vu2MmzQlQxHWu3G/r3r00uUFekVUKZVChsY+UDbFIBN6Ue9i4V2NRuprsj56a19s2uOxR9jY9LNBSz/q0CXtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytjGqY/ZmDC4vNY9oEwlIMYbNRD6ubb4fEsraFE86h0=;
 b=l3EeEBGCzmkAlnTOi5FT0UBRA60bdt7xvDhSjYDi0pQx8MRhEG+wmOJuJtFoRFP7h1jzQ0Ol0aUB7hI5raFIqr6wx31acbIQEWhDQBSDG22b5yy8y1n6k7USHJxSkDo02f8hjXGjTNea7TQuUWpofj1rKyWRaZxzCS04i+B2mrA=
Received: from BN9PR03CA0148.namprd03.prod.outlook.com (2603:10b6:408:fe::33)
 by MWHPR12MB1502.namprd12.prod.outlook.com (2603:10b6:301:10::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Fri, 17 Jun
 2022 19:35:47 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::77) by BN9PR03CA0148.outlook.office365.com
 (2603:10b6:408:fe::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Fri, 17 Jun 2022 19:35:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Fri, 17 Jun 2022 19:35:46 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 17 Jun
 2022 14:35:43 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/31] drm/amd/display: Fix eDP not light up on resume
Date: Fri, 17 Jun 2022 15:34:49 -0400
Message-ID: <20220617193512.3471076-9-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
References: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36d0f040-f0a0-41e4-144f-08da50989360
X-MS-TrafficTypeDiagnostic: MWHPR12MB1502:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB15029CA2AEF22359337AB0D298AF9@MWHPR12MB1502.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5QOlTtJ0+55uUAaB5OS/CfX9gZsNtTALx3dvRDhAA5/rSqCwqCZI+SGkNxnZlBohE6EwHfqvTSge6AAdXvXQ6KliQSiCqHdBTGhUOTHirviXCpAvcRzsAeTwIR22iJ0bAh6PcNvLkQHV+wCGbcckzYiaasKC1YlrZ8kjBWEzrt3QwT1GeEdz4NT3ij9Plh9/hb5hrw476FAyGbutvyxCAggb/qFsUsEGyJ/aOc1+cTmfi/cYomGs1yEetHmG+yqFtTLaTklKS2YSadv+mH92/vyLRvgMYQGpzHOVK58Qq2KoMdJ7CBi+ChVyA/p7HIptOQvJAr3leUd+YngeSrWZxQkF9/1/Lekpka8r0tAWrBPdiITSLE7jfJfaKi0yXkyN19SizH2EMjU4P9kiIbl48CMA2exX6EGIc2ehrSPJJKXZVdnOtd4IPHjpgwR3N+sm0D9ioV2u4siCGC/eeccF5ui+PqlmvqgmQfonzyjNqRp/F9k1hEu45rNDJjyuosGUA45RJzAmq3xjoV5CkVwsF7uosQQ+CvdLsVCjy1pbshid1s6vDEskEyiF5sEVvykQEplmo4NdktfEzuZkJ+9VpxDYAiahMJW78bDbxcxAki/YUZmBFeoD8GbzMQUSCqPAAxcwbcaJZ8UKe65XMkGfVj35U7TFxYML1pcNgdENvokvS5aS4wJwFbMvFEMx4yCQsI4wObTryVmjsVrP3TjEMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(46966006)(36840700001)(40470700004)(26005)(86362001)(40460700003)(36756003)(7696005)(8676002)(70586007)(70206006)(4326008)(2906002)(5660300002)(8936002)(498600001)(186003)(336012)(426003)(356005)(47076005)(2616005)(16526019)(81166007)(6916009)(1076003)(83380400001)(54906003)(82310400005)(36860700001)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 19:35:46.3363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d0f040-f0a0-41e4-144f-08da50989360
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1502
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
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Sung Joon Kim <sungkim@amd.com>, Agustin Gutierrez <Agustin.Gutierrez@amd.com>,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Joon Kim <sungkim@amd.com>

[why]
Only on VG, if external display is disconnected during S3 suspend, the
internal panel doesn't light up on resume because we set the power state
using an unsupported DPCD register SET_POWER.  To check the register is
supported, we need to check SET_POWER_CAPABLE first which is
eDP-specific DPCD register field.

[how]
Check the SET_POWER_CAPABLE register field and decide the control of the
eDP power state based on the read register value.

Reviewed-by: Agustin Gutierrez <Agustin.Gutierrez@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Sung Joon Kim <sungkim@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c    | 6 +++++-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 7 +++++++
 drivers/gpu/drm/amd/display/dc/dc.h              | 1 +
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index fac27b45230f..82b74ee5f0c3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1104,9 +1104,13 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 				dc_ctx->dce_version == DCN_VERSION_3_01 &&
 				link->dpcd_caps.sink_dev_id == DP_BRANCH_DEVICE_ID_0022B9 &&
 				memcmp(&link->dpcd_caps.branch_dev_name, DP_SINK_BRANCH_DEV_NAME_7580,
-					sizeof(link->dpcd_caps.branch_dev_name)) == 0)
+					sizeof(link->dpcd_caps.branch_dev_name)) == 0) {
 				dc->config.edp_no_power_sequencing = true;
 
+				if (!link->dpcd_caps.set_power_state_capable_edp)
+					link->wa_flags.dp_keep_receiver_powered = true;
+			}
+
 			sink_caps.transaction_type = DDC_TRANSACTION_TYPE_I2C_OVER_AUX;
 			sink_caps.signal = SIGNAL_TYPE_EDP;
 			break;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index f9c10d044da6..fd95bd51988b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -5832,6 +5832,7 @@ void detect_edp_sink_caps(struct dc_link *link)
 	uint32_t link_rate_in_khz;
 	enum dc_link_rate link_rate = LINK_RATE_UNKNOWN;
 	uint8_t backlight_adj_cap;
+	uint8_t general_edp_cap;
 
 	retrieve_link_cap(link);
 	link->dpcd_caps.edp_supported_link_rates_count = 0;
@@ -5870,6 +5871,12 @@ void detect_edp_sink_caps(struct dc_link *link)
 	link->dpcd_caps.dynamic_backlight_capable_edp =
 				(backlight_adj_cap & DP_EDP_DYNAMIC_BACKLIGHT_CAP) ? true:false;
 
+	core_link_read_dpcd(link, DP_EDP_GENERAL_CAP_1,
+						&general_edp_cap, sizeof(general_edp_cap));
+
+	link->dpcd_caps.set_power_state_capable_edp =
+				(general_edp_cap & DP_EDP_SET_POWER_CAP) ? true:false;
+
 	dc_link_set_default_brightness_aux(link);
 
 	core_link_read_dpcd(link, DP_EDP_DPCD_REV,
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index ba57e03d3d9e..51f5d75bf9e3 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1245,6 +1245,7 @@ struct dpcd_caps {
 	bool panel_mode_edp;
 	bool dpcd_display_control_capable;
 	bool ext_receiver_cap_field_present;
+	bool set_power_state_capable_edp;
 	bool dynamic_backlight_capable_edp;
 	union dpcd_fec_capability fec_cap;
 	struct dpcd_dsc_capabilities dsc_caps;
-- 
2.25.1


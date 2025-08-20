Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B934CA0EFF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 20:21:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98DF910E7E8;
	Wed, 20 Aug 2025 20:21:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JXiluoeZ";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2076.outbound.protection.outlook.com [40.107.212.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41AA010E7E8
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 20:21:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hgzcshwlnieApnWzFHFwPK0xKIudzVKoncanXFzRZvijyHjgwpb8yuEDSwvFlhCzW6lO9BURYevTdyQMVYY42d6ADdEnoQOqLyQxyhKcY71fa5Jiikhtcesiu3c+YqTfxkKjv1JVQ6in/ESRlMftpvgI1VI1i1Ylzu2JwUi/mmqeINwmY3ZjmJecFcw6E8hc19wkm03OToXUwqiSXJeRmBdDj10/O1u/34F+qZsdFBhV52u4qHyC2L6TGdSCbZQ1aDGMHnV8gQt3pD6v6wQL3gDYVMeOLrxAZHhRBxPK8ZtfjuVHPh2NllShQbCRYlito5YOlUpJA/F8e4I98aOsDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bhqb2/GBpAJPU3dK2uGpc2R1cv6sy/QWVkbGSQzEwYI=;
 b=spU9lrxFUfHorOa/0/OqU7aEvxFUF53hQQCzStxP//DTVSj22y4VBSSVK58MLCbr9T3YLsJjF5SzRf7f80btWZEh+EFOBA0Zv0Sr1Nt+EvBJwZZn8bvLvb5HfbWbEXWWggqSjKplXsOf1HWiVTjowWjX5aQCJvlLwdEAOxo6alyjld2VNWJzs98MuSOafblrmpqVL7uPJEwBz+jTrt0r3BancAamJNHw/RX1D8pqcL1FqvSckq5yxVjDjHeUnAQg8WeOf0GIdZvRuT7u6vjPaZcqZw7DM7+5+IPopPHa0L1YgbeMfvvhEks7qDmPA5Mw+sdouM8OC0F6wksDBzueFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bhqb2/GBpAJPU3dK2uGpc2R1cv6sy/QWVkbGSQzEwYI=;
 b=JXiluoeZg92LSfLncEq4y3UiIbPtged41gC9MF+OuXrEnen9L+NRN9bSoy9yw3nXwbz7at+62Z7cpClfo/7P2c5bIi04ZUNWJEC+ClWb4mpAXQ5NFyTCZ2ifZ3g2AHD1QdI0G8skkjnb4mIRk8SPdA8JW9AqqqmbIxfecvkMabw=
Received: from DM6PR06CA0037.namprd06.prod.outlook.com (2603:10b6:5:54::14) by
 CY8PR12MB8068.namprd12.prod.outlook.com (2603:10b6:930:75::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.13; Wed, 20 Aug 2025 20:21:12 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:5:54:cafe::23) by DM6PR06CA0037.outlook.office365.com
 (2603:10b6:5:54::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 20:21:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 20:21:12 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 15:21:09 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 20 Aug
 2025 13:21:09 -0700
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 15:21:08 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Yihan Zhu <Yihan.Zhu@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 08/12] drm/amd/display: wait for otg update pending latch
 before clock optimization
Date: Wed, 20 Aug 2025 16:19:58 -0400
Message-ID: <20250820202103.1122706-9-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820202103.1122706-1-aurabindo.pillai@amd.com>
References: <20250820202103.1122706-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|CY8PR12MB8068:EE_
X-MS-Office365-Filtering-Correlation-Id: f68b469a-0909-4c8f-b32b-08dde0271b7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NicfDsU/di+e7d24YSNhNls088XHfsvCUHrGJlbTbXQoUW+6jm3j+YC7UZ52?=
 =?us-ascii?Q?GMLawf7a8RiJDBYEGWZLTFdsVSGWxfwqPFU/hTkGlHTbFuYoFhuqL9Xr4xRE?=
 =?us-ascii?Q?njYtTxywBpLXs07CgH18y4Z63yt5AzDz5HluOkHgVeLD2XktShLX30X0fG6E?=
 =?us-ascii?Q?MmCf/I4tyP+9XvFaDdW/qqmld7AdOQ0AeL3IuFaO/u2I+FMRcvp+bleW9HaV?=
 =?us-ascii?Q?ogcJmhDql47nTxsGbiHL31yAF34TavTwRhzbFaxxcWMrYsHy5z/KR31K+Xin?=
 =?us-ascii?Q?BMtf2FyNZRBm8X+ihd+LxtivPFbeb53bnnS7qEzcJ8x7G/gBUDwhtliZJGnm?=
 =?us-ascii?Q?E3WMuhI5NmKL5tJsmWl56dqPF+cpQPv1lVXGN8ijpQECY7Dog4MOjEdKEN4Y?=
 =?us-ascii?Q?9QxviTsrwrfjNSY8IRSkS1XqwzlbgxLd280WYXc4EsLAv9aXSFe3Wkm1oHjH?=
 =?us-ascii?Q?i2UusIFcuXgvfk9nmpvitab3s0NKWoUPZ/84KvOU8S9KvNsydwz3UcODncBn?=
 =?us-ascii?Q?oUzqekvjZH3ue/s5Fne0uwydUiqb4ZrFuxoLOe1TcMWp3EmwaDL3OkZkZYpC?=
 =?us-ascii?Q?I/kEYzCsEkogH+Djw8oVN4W/mZZLu3v8z1FoxhMp/UxQGBVYtIrL9ah6Bjg4?=
 =?us-ascii?Q?eNzwBJ0NmN7rUz4xQ9JeCeX/0Nabp4RFs3I5EEzaKVJTK8R+i0I6XnPrVPKF?=
 =?us-ascii?Q?XogwPLCPUx4cbIyG2QTksOhr07yREURnNtQoxbAQJO5pPkVFWMFdAnQJtYXs?=
 =?us-ascii?Q?UbeYqk2lrG9yQTH1cTy/xFp1LoCEkRTKSTzrDfSXYzXHUqID17XN84i+GMGL?=
 =?us-ascii?Q?KdPYcSU9+PTuPANcie9JvPMQWE2DQJT6jkYOn4Ovr3Aci8UkVzkIFky7t8kT?=
 =?us-ascii?Q?NvHXZg+Y3oaPmCXCMZk1Iee0OlIeZpgKEFJCz2rIObfURbN+IpNnaAay9H9i?=
 =?us-ascii?Q?SxAIYNjbC3gjoHZgbhgGW5RfD6OKe+rISIUpS37+tWZHIISpVdq8vYgL/Pid?=
 =?us-ascii?Q?kekFJUZ/w+T+FexBO7DzWD5Ss2qzLOBhRUg0SV0F68pt2tcQH1R7KhXOSWCe?=
 =?us-ascii?Q?M6x3mDJAdavpIYGxUGloRFz79XUslbyM0FM/y+NdDzaSdX/+Ssw6XTOzunEI?=
 =?us-ascii?Q?faXqdvY0fXcLuQhDAUJ5ky6QfS00umn8iUDVyI4sPXlVMYRcWGszxAao6Aeg?=
 =?us-ascii?Q?F2J/HDTYwTVJKuHn7COlmZ8jH8rmiyqb5SFcPxfZkzr17uSfO2IrwWje61JK?=
 =?us-ascii?Q?LxmjN2TS21hnEZcTqZ6YxnJq5Aj7yCrwcIZNO3pathyZ9d1S8VH8P1Lb9Xeo?=
 =?us-ascii?Q?7GYyL0neB9KJSFKINF5+vjOaXA+3dSx4aEOs0+JSFLYYA/4wSNbPIu1aVjYf?=
 =?us-ascii?Q?GtFBgz4icP3Iu/U7azxGoIf52PgA8xZJYPrKBJr2rDiUe2hlcKFkjOxrRfkM?=
 =?us-ascii?Q?oe/t0NtYiU/8gSSBNESTHiWNU0cEd3mZKIKsG8+caTlKOTSlJMeyX9j2SoYn?=
 =?us-ascii?Q?tftfTLf0yLIVpLisw3BxumZ8wAoCj5fatmj0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 20:21:12.4975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f68b469a-0909-4c8f-b32b-08dde0271b7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8068
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yihan Zhu <Yihan.Zhu@amd.com>

[WHY & HOW]
OTG pending update unlatched will cause system fail, wait OTG fully disabled to
avoid this error.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Yihan Zhu <Yihan.Zhu@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c  |  2 ++
 .../amd/display/dc/inc/hw/timing_generator.h   |  1 +
 .../drm/amd/display/dc/optc/dcn32/dcn32_optc.h |  1 +
 .../drm/amd/display/dc/optc/dcn35/dcn35_optc.c | 18 ++++++++++++++++++
 4 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index ec4e80e5b6eb..d82b1cb467f4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -1177,6 +1177,8 @@ void hwss_wait_for_odm_update_pending_complete(struct dc *dc, struct dc_state *c
 		tg = otg_master->stream_res.tg;
 		if (tg->funcs->wait_odm_doublebuffer_pending_clear)
 			tg->funcs->wait_odm_doublebuffer_pending_clear(tg);
+		if (tg->funcs->wait_otg_disable)
+			tg->funcs->wait_otg_disable(tg);
 	}
 
 	/* ODM update may require to reprogram blank pattern for each OPP */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index 267ace4eef8a..f2de2cf23859 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -374,6 +374,7 @@ struct timing_generator_funcs {
 	void (*wait_drr_doublebuffer_pending_clear)(struct timing_generator *tg);
 	void (*set_long_vtotal)(struct timing_generator *optc, const struct long_vtotal_params *params);
 	void (*wait_odm_doublebuffer_pending_clear)(struct timing_generator *tg);
+	void (*wait_otg_disable)(struct timing_generator *optc);
 	bool (*get_optc_double_buffer_pending)(struct timing_generator *tg);
 	bool (*get_otg_double_buffer_pending)(struct timing_generator *tg);
 	bool (*get_pipe_update_pending)(struct timing_generator *tg);
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h
index d159e3ed3bb3..ead92ad78a23 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h
@@ -62,6 +62,7 @@
 	SF(OTG0_OTG_CONTROL, OTG_DISABLE_POINT_CNTL, mask_sh),\
 	SF(OTG0_OTG_CONTROL, OTG_FIELD_NUMBER_CNTL, mask_sh),\
 	SF(OTG0_OTG_CONTROL, OTG_OUT_MUX, mask_sh),\
+	SF(OTG0_OTG_CONTROL, OTG_CURRENT_MASTER_EN_STATE, mask_sh),\
 	SF(OTG0_OTG_STEREO_CONTROL, OTG_STEREO_EN, mask_sh),\
 	SF(OTG0_OTG_STEREO_CONTROL, OTG_STEREO_SYNC_OUTPUT_LINE_NUM, mask_sh),\
 	SF(OTG0_OTG_STEREO_CONTROL, OTG_STEREO_SYNC_OUTPUT_POLARITY, mask_sh),\
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
index 72bff94cb57d..52d5ea98c86b 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
@@ -162,6 +162,8 @@ static bool optc35_disable_crtc(struct timing_generator *optc)
 	REG_WAIT(OTG_CLOCK_CONTROL,
 			OTG_BUSY, 0,
 			1, 100000);
+	REG_WAIT(OTG_CONTROL, OTG_CURRENT_MASTER_EN_STATE, 0, 1, 100000);
+
 	optc1_clear_optc_underflow(optc);
 
 	return true;
@@ -428,6 +430,21 @@ static void optc35_set_long_vtotal(
 	}
 }
 
+static void optc35_wait_otg_disable(struct timing_generator *optc)
+{
+	struct optc *optc1;
+	uint32_t is_master_en;
+
+	if (!optc || !optc->ctx)
+		return;
+
+	optc1 = DCN10TG_FROM_TG(optc);
+
+	REG_GET(OTG_CONTROL, OTG_MASTER_EN, &is_master_en);
+	if (!is_master_en)
+		REG_WAIT(OTG_CLOCK_CONTROL, OTG_CURRENT_MASTER_EN_STATE, 0, 1, 100000);
+}
+
 static const struct timing_generator_funcs dcn35_tg_funcs = {
 		.validate_timing = optc1_validate_timing,
 		.program_timing = optc1_program_timing,
@@ -479,6 +496,7 @@ static const struct timing_generator_funcs dcn35_tg_funcs = {
 		.set_odm_bypass = optc32_set_odm_bypass,
 		.set_odm_combine = optc35_set_odm_combine,
 		.get_optc_source = optc2_get_optc_source,
+		.wait_otg_disable = optc35_wait_otg_disable,
 		.set_h_timing_div_manual_mode = optc32_set_h_timing_div_manual_mode,
 		.set_out_mux = optc3_set_out_mux,
 		.set_drr_trigger_window = optc3_set_drr_trigger_window,
-- 
2.50.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74525CFD65C
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 15:58:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D15410E63B;
	Wed,  7 Jan 2026 15:58:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UJZuksSq";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011022.outbound.protection.outlook.com [40.107.208.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68F9110E639
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 15:58:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzAMSL4rchccyuY9jRa9KlHC43IMdBiy/vKCemu2vDxig8oecqOkfwzqi5qEDlfdbjGYhaJuKh2aLmTtnw5kbQWazhRUGqBqwksJIsbhksIkC7KxxEtdfRZgZoRFVOkSpZm9wXn1oKQDrM5r+WBDz9hnV42gyIbPtpTx/QoR8JnxjpKVughPcgnMM8Fl4EpJtC9fG11cX3Nnuu73qIsxcyFpvCRYR9Dyux6+OjS+Ae6lYMKEWUmSmjxE2zm7RZ6fjOyot3gnTYqTN0iluWXawgC0B5GmzkAqBy+BHjfuc3cSOXMcShRzFP2+yHRdBHUUnHnqt5PzvoiIkdwGnMtZHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3LEkTSyI8YHpIWbQ/X00R8N5fjumahmDGXe98HFUpc=;
 b=HSUUahKFmyLHhwbFQ/PvPpG7kt8Z1gwm2g402UrvT/3M/7XehzIAI9IVAfTqJMFZJJQsgce/XOwq4xDtpDM6vLa53NGUtbwnecwXCjGVIIPhGAVRT2F3rKZgH5BQliiSWnlnG42Y4Z3EPaqxuX8dXOL7DkHC+vbWwhAZO6E0AB8HpBlB43g5Gu5nxp0V1agfeTR0UlYAx1l0QnuqZAyCdCPcIYiBd7EUszxO1dec/DlQee7HGYVm5vlUE5FvBEIg56CNHC4yVki49GovoXVlh9rFegTmFR1khadIC1oOtf8nTZc8j/OLnqWABSrYP97rsY29WZdRPQ/ZVIbJhPuV4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3LEkTSyI8YHpIWbQ/X00R8N5fjumahmDGXe98HFUpc=;
 b=UJZuksSqXCLuA3qOapWlEDA6mTsQ5oFJXXre74QxfNdEcAiRCj3EW+6K6R2mpFMPA5CPFhCXs5X7UwEsnztFbwdxG3NHCztk2S9DIfJNVmW8MVHIZGbsJkdClCMw8fTQdoaorx7tZnwBRXk0MTgYsaq6H6lC3s4qTkSSeF+s8lY=
Received: from CH0P221CA0038.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::24)
 by BN3PR12MB9595.namprd12.prod.outlook.com (2603:10b6:408:2cb::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 15:58:12 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::6a) by CH0P221CA0038.outlook.office365.com
 (2603:10b6:610:11d::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.5 via Frontend Transport; Wed, 7
 Jan 2026 15:58:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 15:58:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 7 Jan
 2026 09:58:01 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Jan
 2026 09:58:01 -0600
Received: from mkmmattstew-dt.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 7 Jan 2026 09:58:00 -0600
From: Matthew Stewart <Matthew.Stewart2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Cruise Hung <Cruise.Hung@amd.com>, Matthew Stewart
 <matthew.stewart2@amd.com>
Subject: [PATCH 12/21] drm/amd/display: Always update divider settings for DP
 tunnel
Date: Wed, 7 Jan 2026 10:48:04 -0500
Message-ID: <20260107155421.1999951-13-Matthew.Stewart2@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107155421.1999951-1-Matthew.Stewart2@amd.com>
References: <20260107155421.1999951-1-Matthew.Stewart2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Matthew.Stewart2@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|BN3PR12MB9595:EE_
X-MS-Office365-Filtering-Correlation-Id: 09d891c3-040e-42c8-b6eb-08de4e058f7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Vy8gPSKWWILewn6+ECmoBFm5hh5+ZCRnGd+dqTH1jOup2Dcet7WllkhxrXWn?=
 =?us-ascii?Q?UR3PZSM+1Pr5oSpyMpS4UODJqQruqOLgzO2jriZv065qYN4g8CR7BlUq9H+D?=
 =?us-ascii?Q?SpV+2BLCzm0wGesYip20yzhCowc4fMGeAcZ2mIFdj2/q6h0p+TUfszCh44PL?=
 =?us-ascii?Q?jjk8Ujc0iDASYj5cQ+V1wjz859RrHSC8uHw4alYl4WHWRowiqRIDbuuJ0uQ7?=
 =?us-ascii?Q?0MUS/BsvoigXGmMpPxiljU/6kHaSCbsclGOauiyRLJ/JUt0UYcSRl+xx+zE9?=
 =?us-ascii?Q?HvLI0TakO/zT0O+Lv2+zsMTk4G1JhStzVYDXpS2Rz/FI0LhPUQa9GfhbgwHM?=
 =?us-ascii?Q?KvTsowHywzS7x8kH6X2vkCIkLth/im3MBTX58Cyz2AalYoV7MahMaANQt0mK?=
 =?us-ascii?Q?cuRUHIjNwgzanTeqs0TQG4GL7psyt/M8htiLU37BYNUBiAPXv+BX/5E8Q95p?=
 =?us-ascii?Q?1APp8SOmhHdyYaG56Dii2FZZBUuuEm/gH4fWjY8n7hLxWVg8At94vKnOwA0x?=
 =?us-ascii?Q?awUoqGXRouSRAa0ps4bSe9wfd3HuWMgXt2pCKwavHm9mCi7434j1rPSXCCP1?=
 =?us-ascii?Q?okEf1XfiGTA2xO7cPzGPbySVrRM6b7hRMAsKn0g0FWYNXHlB2yU2UcIurJo5?=
 =?us-ascii?Q?+Y76uCnuLZ4RWEK/mJU6akCW+10IL7Rv+xYPsg1O+zrqOkZdwPSm8nLqfSIo?=
 =?us-ascii?Q?xpEnK7nvg/+NMUw77U+sWNVUL6zFNl3WbJjvt+fkAKhGHD63u9yNgXTPM3JO?=
 =?us-ascii?Q?xTDjbvCEah0JsOwKGgqCXh6oyg743+WR8cy5Qx0X/CgYcc6hSB+siBZfoBi+?=
 =?us-ascii?Q?O+8o0IKhLij3zjDh+wO9AVmlnm34IeH7v1farZXm2UrR+DEWHGIV2feEbajP?=
 =?us-ascii?Q?bLO9hhZ9utUo5Lz69FwzaV9BY3+EF5/v9GiJEAI3TDCTTuLweohrhY7WBwUu?=
 =?us-ascii?Q?LW0XlbltUgqNQMzmNI6TvTjAg3YNThBE/XzvO3oxjRrTiQQ/u4b1uBVLgkCg?=
 =?us-ascii?Q?WaY3JG2dUqKa3FOyWdyLiZy82A/UD1wtP782UY67bVvrcyFOgvqS86H9KiZ9?=
 =?us-ascii?Q?fwQP+bWS0sUW773ZOBYtqKpwJRWE0kD+33Ry4b0klJWt2Id3ZKeQRTBZdxJ3?=
 =?us-ascii?Q?wY1fS11uLEGy6s/oQuJleGXcZWaN67E2PT0AU5fgg2uTxi8cd6IL7ZPGAUPv?=
 =?us-ascii?Q?otQaDgOn8MymAyYiylcRq/UAgDsK021/LNY1Krc1aQpdZhEfpSbcx6EbAOV9?=
 =?us-ascii?Q?1jtMB62oE3/Zvz/VKT8yQctV9n5i2g1OtOvSSuzm9dCcReypy7f+3t6uzmMU?=
 =?us-ascii?Q?DAcVeoOOXKXzElEzrSHfP79RqDDybQ3xTqgu6LWCpSpw4alwFSrVdQQUhtWe?=
 =?us-ascii?Q?Kwq5OlFQJ44ymhEvOXb25Si++RaeiVdL13Bo+RL5hy4NGzkz63s+hU0tzxny?=
 =?us-ascii?Q?biyfcHuFlMhuCMsqfEDkAH/X3D61Jn0KUB4GPFLM5fqZLIEyMTD1iCOLoCEN?=
 =?us-ascii?Q?Wq8D76Zwz9BdKXYqwEvzuG2GZfivZk2kqYkZLTYEOy0Ik7y52teWFaFcJy1A?=
 =?us-ascii?Q?/GGj4yA6AdzAiVaM/as=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 15:58:12.2043 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d891c3-040e-42c8-b6eb-08de4e058f7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9595
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

From: Cruise Hung <Cruise.Hung@amd.com>

[Why]
When transitioning from 640x480 at RBRx1 to HBR3x1,
both output pixel mode and pixel rate divider should update.
The needs_divider_update flag was only for 8b10b and 128b132b transition.

[How]
For DP tunneling, always update divider settings.

Reviewed-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Cruise Hung <Cruise.Hung@amd.com>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
---
 .../drm/amd/display/dc/link/accessories/link_dp_cts.c |  7 ++++++-
 .../amd/display/dc/resource/dcn31/dcn31_resource.c    | 11 +++++++----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
index 5a547d41d4a1..693d852b1c40 100644
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
@@ -70,6 +70,7 @@ static void dp_retrain_link_dp_test(struct dc_link *link,
 	struct dc_state *state = link->dc->current_state;
 	struct dc_stream_update stream_update = { 0 };
 	bool dpms_off = false;
+	bool needs_divider_update = false;
 	bool was_hpo_acquired = resource_is_hpo_acquired(link->dc->current_state);
 	bool is_hpo_acquired;
 	uint8_t count;
@@ -79,6 +80,10 @@ static void dp_retrain_link_dp_test(struct dc_link *link,
 	int num_streams_on_link = 0;
 	struct dc *dc = (struct dc *)link->dc;
 
+	needs_divider_update = (link->dc->link_srv->dp_get_encoding_format(link_setting) !=
+		link->dc->link_srv->dp_get_encoding_format((const struct dc_link_settings *) &link->cur_link_settings))
+		|| link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA;
+
 	udelay(100);
 
 	link_get_master_pipes_with_dpms_on(link, state, &count, pipes);
@@ -95,7 +100,7 @@ static void dp_retrain_link_dp_test(struct dc_link *link,
 		pipes[i]->stream_res.tg->funcs->disable_crtc(pipes[i]->stream_res.tg);
 	}
 
-	if (link->dc->res_pool->funcs->update_dc_state_for_encoder_switch) {
+	if (needs_divider_update && link->dc->res_pool->funcs->update_dc_state_for_encoder_switch) {
 		link->dc->res_pool->funcs->update_dc_state_for_encoder_switch(link,
 				link_setting, count,
 				*pipes, &audio_output[0]);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
index 0d667b54ccf8..e853ea110310 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
@@ -2250,12 +2250,15 @@ enum dc_status dcn31_update_dc_state_for_encoder_switch(struct dc_link *link,
 	int i;
 
 #if defined(CONFIG_DRM_AMD_DC_FP)
-	for (i = 0; i < state->stream_count; i++)
-		if (state->streams[i] && state->streams[i]->link && state->streams[i]->link == link)
-			link->dc->hwss.calculate_pix_rate_divider((struct dc *)link->dc, state, state->streams[i]);
+	if (link->dc->hwss.calculate_pix_rate_divider) {
+		for (i = 0; i < state->stream_count; i++)
+			if (state->streams[i] && state->streams[i]->link && state->streams[i]->link == link)
+				link->dc->hwss.calculate_pix_rate_divider((struct dc *)link->dc, state, state->streams[i]);
+	}
 
 	for (i = 0; i < pipe_count; i++) {
-		link->dc->res_pool->funcs->build_pipe_pix_clk_params(&pipes[i]);
+		if (link->dc->res_pool->funcs->build_pipe_pix_clk_params)
+			link->dc->res_pool->funcs->build_pipe_pix_clk_params(&pipes[i]);
 
 		// Setup audio
 		if (pipes[i].stream_res.audio != NULL)
-- 
2.52.0


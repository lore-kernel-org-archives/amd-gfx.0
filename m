Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC56C71130
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 19:44:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0531910E55C;
	Mon,  7 Jul 2025 19:44:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1zVIv9SH";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A59CA10E55A
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 19:44:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fjBmLTTgk3hUoxjQHjDE4AJhZ5o+/7uyNiwbOHVKIoaCmtLN3hp8bfyWbFQDgl9GUb7CDeXVZPiEEVdL49tZlg/zi7Ia2jK8s+u/dce2Vf4stBECqlfpQtfi9S4l7ACjG4CORsXX7ULqOJKKntwjPTj9XQZpP/8GR7RuA8e5aLQO9PRW758jAVGzMu5FcMscqsehfVrNJCvJvnm7DrkAUN8680eDfy3FBLU/DbwP0985aydLa/WrTGrenbVaGxo/T2u9ErpnZjA6xUMyG+/o0WhP96KT7kllftJqj+qbQl1hQV5OEpcQHpewtLgrreRa6i+HZcdHgHvRV1KwjRPE/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NsOWt+dS4A6vcUyfmUAde+UWCJuUrltKYPxCh3OBfsQ=;
 b=C4TnSL/kY9hu5yjw3UobYgg1yQ3KaVTY+ughK9/w9raAInLRHyEt+FqVHgXkQ7AVBFKCQ+/Jta8apSsthdkspMGF+qvVTAoF0dNUhW4fxTd5pDOPn7ptQ9xvCYypbOBpfWbF6Xy0DAXhqWru42fBKB7QG1LHA+O7Ct4oQhWCjvOr8Za/5fNkDQeR85B8XaiXj0DXKaatJS2dWl7saK008qBCs3cirWIOb0VLZig94HPhVSYse3TyZsNT3jfifhuPC+D1y2mJh2Pe05rZmCG9FxtqOyMZG8hD9zF2cfALa5u9TFSYQawEY2kbiBXiyOkRmLLiQn46bHNgru2UUrzaog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsOWt+dS4A6vcUyfmUAde+UWCJuUrltKYPxCh3OBfsQ=;
 b=1zVIv9SHFimqr3JyqsfDTNdeP/lbcXKnEr8ImYdGxkvxEiBQSol17I3cyywf+hFI/aCgTofZ57xJIp0x1ivNvjBd6CrkVfQrwP6YHyb1CQFqh/r56nB5U6iSuNUG4UBnXZrDGxTpoKH8wB1wkNAmlkoHwog2tEcszHN3cYD7OcA=
Received: from CH2PR07CA0043.namprd07.prod.outlook.com (2603:10b6:610:5b::17)
 by LV2PR12MB5917.namprd12.prod.outlook.com (2603:10b6:408:175::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Mon, 7 Jul
 2025 19:44:45 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::53) by CH2PR07CA0043.outlook.office365.com
 (2603:10b6:610:5b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 19:44:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 19:44:44 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 14:44:44 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 14:44:43 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 7 Jul 2025 14:44:43 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Karthi Kandasamy
 <karthi.kandasamy@amd.com>, Nevenko Stupar <nevenko.stupar@amd.com>, "Ivan
 Lipski" <ivan.lipski@amd.com>
Subject: [PATCH 02/17] drm/amd/display: prepare for new platform
Date: Mon, 7 Jul 2025 15:41:22 -0400
Message-ID: <20250707194358.1185190-3-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250707194358.1185190-1-IVAN.LIPSKI@amd.com>
References: <20250707194358.1185190-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|LV2PR12MB5917:EE_
X-MS-Office365-Filtering-Correlation-Id: e89e38ab-5d0f-460d-4f19-08ddbd8eb928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RJxgos6TAAYGSCUrYYylPz4MT/cUKTwP+UStKEbgoZ8O/kbrWIB1yHonDpXX?=
 =?us-ascii?Q?6o1oDyT9lHjSCJLDjEzHud+AZ1/vNkbOGCvilseNAmTPXjtDp+9p1WsTxiik?=
 =?us-ascii?Q?/1RNB2Pp8gtrLO8iuUdmoHtwpEX1JvJr40HY3Lp3gljN0ZdmAnZYZ9TV0JFx?=
 =?us-ascii?Q?NgPDKpDjyxDB77f/zN7F5gPNCJ0VOftHeAes4PZbcw3psJ1njjpofgqJOAh8?=
 =?us-ascii?Q?Gtr1TCHPBf78wpsokaDW3MlBkFKFL91zLYHi7rYKC1a804Tz9RkwpCTQW1HD?=
 =?us-ascii?Q?s84ydxCoRvicE46XKkhBXKDOzFV2RJT4GxlsuxlEmed/5TL9lTAglERBchGQ?=
 =?us-ascii?Q?OdwTnBjGFWgmfPwzXma+L2pmQQoTNJ1zpCYKGyclDrVtfFNvn4ezwxMQSNUg?=
 =?us-ascii?Q?y+kpORQTLJvbjrvnprmWfxAJ7/at/vlQnDruyv/siCwuSy34FkPevft8Qves?=
 =?us-ascii?Q?pwvki4IDf3onBMpwZJjfBOMBzsHuq6xT3KfCvbgF0tVUhtMQ1bFHb06A7Hix?=
 =?us-ascii?Q?3wJeWubBRLLlYSEnNhUz3VrJ5faRbDbMo3oW24C3dho59vd/6CusRg/BLgV2?=
 =?us-ascii?Q?w6k0BJIqk2DV6FfMdAG3PsrBxMNv7vU6xIvTn3mnltBvWlG1vhQWDa48CfL5?=
 =?us-ascii?Q?H53S+xeUJeLkajuVVKh+OreI1aahUMdLtcW5yOamBpUWpzAg6nRm35g26pk6?=
 =?us-ascii?Q?voQDHRoUjzWpvJQHr74f2KjhctLKYQ/ip1v5YQdYsDBLZYIGEsjICyJ0eMXd?=
 =?us-ascii?Q?nGZ2VYCLavjo/smkV2CwAEvYx41F7i0/xzq8g65IlPSHLFKewi77oC4c7D8C?=
 =?us-ascii?Q?RL9Ky8jpZjVtn7DyQ22CBJ0yysFZa3RdjhMw94JqBRPr4imQpmUqZ8BSpL0i?=
 =?us-ascii?Q?gwaw3F7J0rNN4AdN3Gcc0J1jrGWAAcpULorC3L3yGmLGlSpagLC7UNGbepbw?=
 =?us-ascii?Q?PVaxrkfyAlHQsokWWPJz96nGGwWbid84q+1dHgZnWMQzeuDOIsS7DDuErmS9?=
 =?us-ascii?Q?LJVIavO6//mImbImbTilEK73RjN+K0RnxfBPGstaNOP4B0PfGQScgPgPd2Ub?=
 =?us-ascii?Q?iLUC8x//jrk8/V7U6J2Rh05VoP+xlvS3o7F8znouA9D4GKbPc5GurQwUT6Ee?=
 =?us-ascii?Q?UbK4EYXEez4eFlvXHeV+GuHmkwwKFbpz17ZsfaNxEe+vS3gokDXpIkqdFH9n?=
 =?us-ascii?Q?nDmtgUK0/cdBSHXeeaU9lj3W0xf5d9CedbpQTwsw9sEdntvesydjuJYMy3VQ?=
 =?us-ascii?Q?j6VpGl8+VZxC1sJ6FfJ7lkK9p2OcNLhijJeqfVKMhKT8ch8Y9kzyUbLROjUH?=
 =?us-ascii?Q?ID6e5fL90DtTn46kDbijSXUekyz7Cl0FK1MnI5FmuE+joOpvnvXfpG5XYQrF?=
 =?us-ascii?Q?+xTDdyZtfx7dXMmKUnli2djM2MO5ua4FehkGtZnG+J7sQkGSP4Ub5nLeCFy2?=
 =?us-ascii?Q?J724e4nwTkXObo2RLWDZLQbPlv19Y1/8gi9usDbtX1nX8LHcVACezXKeA7n0?=
 =?us-ascii?Q?qJ7iVF/xfSrb3WlbpULChr7qSE1myK9DBUiQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 19:44:44.5098 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e89e38ab-5d0f-460d-4f19-08ddbd8eb928
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5917
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

From: Karthi Kandasamy <karthi.kandasamy@amd.com>

Expose some function for new platform use and add additionl check for
IP register

Reviewed-by: Nevenko Stupar <nevenko.stupar@amd.com>
Signed-off-by: Karthi Kandasamy <karthi.kandasamy@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dsc/dsc.h           |  1 +
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c  | 14 ++++++++------
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h  |  1 +
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dsc.h b/drivers/gpu/drm/amd/display/dc/dsc/dsc.h
index 1ebce5426a58..b0bd1f9425b5 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dsc.h
@@ -108,6 +108,7 @@ struct dsc_funcs {
 	void (*dsc_disable)(struct display_stream_compressor *dsc);
 	void (*dsc_disconnect)(struct display_stream_compressor *dsc);
 	void (*dsc_wait_disconnect_pending_clear)(struct display_stream_compressor *dsc);
+	void (*dsc_get_single_enc_caps)(struct dsc_enc_caps *dsc_enc_caps, unsigned int max_dscclk_khz);
 };
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index a0d61df07f22..cc9f40d97af2 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -51,7 +51,7 @@
 #define FN(reg_name, field_name) \
 	hws->shifts->field_name, hws->masks->field_name
 
-static void dcn401_initialize_min_clocks(struct dc *dc)
+void dcn401_initialize_min_clocks(struct dc *dc)
 {
 	struct dc_clocks *clocks = &dc->current_state->bw_ctx.bw.dcn.clk;
 
@@ -2632,10 +2632,12 @@ void dcn401_plane_atomic_power_down(struct dc *dc,
 
 	DC_LOGGER_INIT(dc->ctx->logger);
 
-	REG_GET(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, &org_ip_request_cntl);
-	if (org_ip_request_cntl == 0)
-		REG_SET(DC_IP_REQUEST_CNTL, 0,
-			IP_REQUEST_EN, 1);
+	if (REG(DC_IP_REQUEST_CNTL)) {
+		REG_GET(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, &org_ip_request_cntl);
+		if (org_ip_request_cntl == 0)
+			REG_SET(DC_IP_REQUEST_CNTL, 0,
+				IP_REQUEST_EN, 1);
+	}
 
 	if (hws->funcs.dpp_pg_control)
 		hws->funcs.dpp_pg_control(hws, dpp->inst, false);
@@ -2646,7 +2648,7 @@ void dcn401_plane_atomic_power_down(struct dc *dc,
 	hubp->funcs->hubp_reset(hubp);
 	dpp->funcs->dpp_reset(dpp);
 
-	if (org_ip_request_cntl == 0)
+	if (org_ip_request_cntl == 0 && REG(DC_IP_REQUEST_CNTL))
 		REG_SET(DC_IP_REQUEST_CNTL, 0,
 			IP_REQUEST_EN, 0);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
index 781cf0efccc6..2621b7725267 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
@@ -109,4 +109,5 @@ void dcn401_detect_pipe_changes(
 void dcn401_plane_atomic_power_down(struct dc *dc,
 		struct dpp *dpp,
 		struct hubp *hubp);
+void dcn401_initialize_min_clocks(struct dc *dc);
 #endif /* __DC_HWSS_DCN401_H__ */
-- 
2.43.0


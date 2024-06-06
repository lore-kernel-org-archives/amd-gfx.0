Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8344C27C5E
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:57:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CADD10EADB;
	Thu,  6 Jun 2024 21:57:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u/SJhSp7";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CFAE10EADB
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:57:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IlEOl779Lf8FCgyodB/ISEGP/FTEeIbTI9RCxJp0r4jOvN1R/273FiapX/Eg86c1nYcN9jhedgjWuA15WNV3T+8NarxYqEob+jqYp8NDOYMI8u//5lOKxzeVTSsTqacOIbY/gxiF3ysTyF9PsGEKbDcjm+8+ScIKcpJy7/uKtXRIUsfodkM2iL6URm2Ty6hRS0GvwcgthN/YrPFXKsbKSnjzqgRYZU8fcSi6YBW8nVJoJ6dpID0C0c2JYHxQT3Y+0YK1p1TznjJUpuieKuSm4KZ9kCybBrRFmBcKIhSnoJQ7DHp/WaVLDkihYD4q7l0g6WccDAv6wYGZHTgvDZFuVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sow5IFMZMNby5XTLVRjKFwTLK6JaQ7vsVvU39CGbjfs=;
 b=CoL1e1bslAvEDwTRX2phHm33aQech5CuB1ysMwWsjDNZfqPwSgRb/d0GHIwbhq3UFU89V4QH1sLInnuvtcBHTb6TS7oFfBMGX66JHDxpPlOS8wXDvc6NU1K2fYJoa7ws8QebcDJwzJP9TeGmWJXXf7GT9rR04RRYlj/FP60cPP5Rj3eDZySGa0srS2ACmE5hH/pNOqD4x3ZAoSs7DpNzsVMf4cT4k6wlwGgJYKCGwWGnOqks9WRyB8S0PaoeM3PB/4DMOcQUVoxSCVDsqg8GRtn6Y0hQaL7mXD8Y7J3bNO2rsPV/OX9WpQBtL8pLU3S8JRj+pkFSQooGE2e1yvBO9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sow5IFMZMNby5XTLVRjKFwTLK6JaQ7vsVvU39CGbjfs=;
 b=u/SJhSp7NQblAN+/gX2wD0Pf+QW4arzWrQUviOIaE7YqKoL+b5NFs6PR+HYWuG04jG3aO8ZYYTfFJKLKM0FO2NBclGo9280Ci4q5KaXpizOhD31aYMQBlpr4K1Hv1/jIHVYp3DWfTGapFB4TdJhJ1v5wUW2WpBx6rx2IHra4464=
Received: from BLAPR03CA0008.namprd03.prod.outlook.com (2603:10b6:208:32b::13)
 by DM6PR12MB4154.namprd12.prod.outlook.com (2603:10b6:5:21d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 21:57:19 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::b9) by BLAPR03CA0008.outlook.office365.com
 (2603:10b6:208:32b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31 via Frontend
 Transport; Thu, 6 Jun 2024 21:57:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:57:19 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:57:17 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, "Sung
 joon Kim" <sungjoon.kim@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 20/67] drm/amd/display: Add sequential ONO sequencing for DCN35
Date: Thu, 6 Jun 2024 17:55:45 -0400
Message-ID: <20240606215632.4061204-21-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|DM6PR12MB4154:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f5b64f7-c9c5-4e4a-d9d2-08dc8673a332
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WNhAPwH8rDCoDPYTdwaAuDHncKUvltiE7tGV3+0b7YrxZaF+M7ZJ5AwLQwgl?=
 =?us-ascii?Q?TXPOBYFG+LZ9WPFM0Czmw3OIYaF4a2fgG6fOcRTCLaaPYLSkExNA2ThmLvRL?=
 =?us-ascii?Q?of4a7YAblygR1gzijNLHnByhvGSGWPkTYtQy8nOmDbKFri3yogmyEAskHFy/?=
 =?us-ascii?Q?YPZekuDGk8o4wkmb8vNu4Y/8o4sdz+FX9ZLHW/2h0k/cbNKI60Nmg2Cargij?=
 =?us-ascii?Q?ngJNVtNf7HtmoIMcuAvRYe1JPz2JjgaQAVjHOv2Uo241YyJaKsa7NFmKM6u1?=
 =?us-ascii?Q?PIdAK7ikpN5abRS4jPkNanlnXDK8jj93UpNwcIxo0MUd5jmSkHCCxAGZu6Ja?=
 =?us-ascii?Q?B4QtGr3U7gQmSMMuD6vOKRLOrmeV7hunSqSDIW0NUZ9s/7LRotzZ9BJf419T?=
 =?us-ascii?Q?e3+AhN0Ba7dBTMQ9IVCzpi95v/6uM/GZl/hOpOeyEjU8nXGSmrxEwJpgXKxE?=
 =?us-ascii?Q?S7cQi9OBXe3XRVNu7lksadqLTI592dBg9BIKCbwscveupS0MJqDv0slQQQze?=
 =?us-ascii?Q?jh/SMW/d85GuA8sMirrCyG2IzaUi5St3sGkdMWVy06f4ig1W3NTuym5v+U8T?=
 =?us-ascii?Q?ojbmJCLx4p9ibI2DJNdzWD8XMIMcKqswGmC4cJ74TbV64WAS6qrXoBmPJN/w?=
 =?us-ascii?Q?RN55jb5P+YwA5vOYwgD8hoPI1inxePCk88MhCB96Ke1l0Z8NhwKKEYyOHl5A?=
 =?us-ascii?Q?7Yq5urOyc/+QSRyq3XhMGPxZ6rYUn6aVcpAvLXZmdK9p6X7n2T3NGgWNEvd8?=
 =?us-ascii?Q?JOTropKE+TDwktoEAagIwIZl583S9HlpoNOp8JR+4IsIwY0VPBLMpsWo/qjY?=
 =?us-ascii?Q?amHGCb4Ny+1L0zBTH78G5CI7sFWSlrvHiFchC7NXX5llS+k3lBLrYHi9aja4?=
 =?us-ascii?Q?Lp0Uf+tpnMh+myEEEIgEcXy77y8t+jZ0ywB0W4TRCiI/nMfAuP4Rftoq5mqd?=
 =?us-ascii?Q?q+s2RzV24/stFKuFhyK6LYI8DMB6bnnNBrqZfKqecfxzrr/u9W0ObGS39AOl?=
 =?us-ascii?Q?9fM7sGHB/jIUXTS7oUsy7A4LMZo3gTdNAHT6BeOD/2KtX+0aEw4ndqFORXoM?=
 =?us-ascii?Q?/6sN+T+4GIwU5Ywcpu3020t7ABVQBDzms8X6uClurNXIodmfNOCVHCuYuIbn?=
 =?us-ascii?Q?JwzlZ3Kcf+ZwEfCdWSlUk3FvRPsGxwxFLu2wiqsTxl3tqkeWu09SngzUWfGL?=
 =?us-ascii?Q?c2bsiJrwpNoZaUAOtMuMOVQmePbQkWkU1y2a/fR7xllqiPB6R+N0NMSpE2ph?=
 =?us-ascii?Q?ybviwHIaClps42GvXfUB7VyQpyH08Skuh0U2dvdZIIt1z9JVkY7r4u6PrGfQ?=
 =?us-ascii?Q?2+g/vmnQlq5w84bjeuIB1KEsiD77j5NZMA083KQVq6qB9F77REB0vsQzRX+v?=
 =?us-ascii?Q?3OMJ6RAdFcxqTyjbBqJ+Xu+9+z5wlT/3dL89K4ZLE8SvjXe6Hw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:57:19.6366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f5b64f7-c9c5-4e4a-d9d2-08dc8673a332
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4154
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
Adds support for performing the sequential ONO changes from DCN351
into DCN35 ASIC based on revision.

[How]
Check the revision and run the DCN351 sequences on applicable revisions.

Reviewed-by: Sung joon Kim <sungjoon.kim@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 85 +++++++++++++++----
 .../dc/resource/dcn35/dcn35_resource.c        |  4 +
 3 files changed, 75 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index c78296b06b79..1008cab97c76 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -291,6 +291,7 @@ struct dc_caps {
 	uint8_t subvp_drr_vblank_start_margin_us;
 	bool cursor_not_scaled;
 	bool dcmode_power_limits_present;
+	bool sequential_ono;
 };
 
 struct dc_bug_wa {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 2b3ba5971c69..4f87316e1318 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -1078,6 +1078,19 @@ void dcn35_calc_blocks_to_gate(struct dc *dc, struct dc_state *context,
 		update_state->pg_pipe_res_update[PG_OPTC][0] = false;
 	}
 
+	if (dc->caps.sequential_ono) {
+		for (i = dc->res_pool->pipe_count - 1; i >= 0; i--) {
+			if (!update_state->pg_pipe_res_update[PG_HUBP][i] &&
+			    !update_state->pg_pipe_res_update[PG_DPP][i]) {
+				for (j = i - 1; j >= 0; j--) {
+					update_state->pg_pipe_res_update[PG_HUBP][j] = false;
+					update_state->pg_pipe_res_update[PG_DPP][j] = false;
+				}
+
+				break;
+			}
+		}
+	}
 }
 
 void dcn35_calc_blocks_to_ungate(struct dc *dc, struct dc_state *context,
@@ -1177,6 +1190,19 @@ void dcn35_calc_blocks_to_ungate(struct dc *dc, struct dc_state *context,
 	if (hpo_frl_stream_enc_acquired)
 		update_state->pg_pipe_res_update[PG_HDMISTREAM][0] = true;
 
+	if (dc->caps.sequential_ono) {
+		for (i = dc->res_pool->pipe_count - 1; i >= 0; i--) {
+			if (update_state->pg_pipe_res_update[PG_HUBP][i] &&
+			    update_state->pg_pipe_res_update[PG_DPP][i]) {
+				for (j = i - 1; j >= 0; j--) {
+					update_state->pg_pipe_res_update[PG_HUBP][j] = true;
+					update_state->pg_pipe_res_update[PG_DPP][j] = true;
+				}
+
+				break;
+			}
+		}
+	}
 }
 
 /**
@@ -1197,6 +1223,8 @@ void dcn35_calc_blocks_to_ungate(struct dc *dc, struct dc_state *context,
  *	ONO Region 2, DCPG 24: mpc opp optc dwb
  *	ONO Region 0, DCPG 22: dccg dio dcio - SKIPPED. will be pwr dwn after lono timer is armed
  *
+ * If sequential ONO is specified the order is modified from ONO Region 11 -> ONO Region 0 descending.
+ *
  * @dc: Current DC state
  * @update_state: update PG sequence states for HW block
  */
@@ -1216,19 +1244,35 @@ void dcn35_hw_block_power_down(struct dc *dc,
 			pg_cntl->funcs->hpo_pg_control(pg_cntl, false);
 	}
 
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		if (update_state->pg_pipe_res_update[PG_HUBP][i] &&
-			update_state->pg_pipe_res_update[PG_DPP][i]) {
-			if (pg_cntl->funcs->hubp_dpp_pg_control)
-				pg_cntl->funcs->hubp_dpp_pg_control(pg_cntl, i, false);
+	if (!dc->caps.sequential_ono) {
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
+			if (update_state->pg_pipe_res_update[PG_HUBP][i] &&
+			    update_state->pg_pipe_res_update[PG_DPP][i]) {
+				if (pg_cntl->funcs->hubp_dpp_pg_control)
+					pg_cntl->funcs->hubp_dpp_pg_control(pg_cntl, i, false);
+			}
 		}
-	}
-	for (i = 0; i < dc->res_pool->res_cap->num_dsc; i++)
-		if (update_state->pg_pipe_res_update[PG_DSC][i]) {
-			if (pg_cntl->funcs->dsc_pg_control)
-				pg_cntl->funcs->dsc_pg_control(pg_cntl, i, false);
+
+		for (i = 0; i < dc->res_pool->res_cap->num_dsc; i++) {
+			if (update_state->pg_pipe_res_update[PG_DSC][i]) {
+				if (pg_cntl->funcs->dsc_pg_control)
+					pg_cntl->funcs->dsc_pg_control(pg_cntl, i, false);
+			}
 		}
+	} else {
+		for (i = dc->res_pool->pipe_count - 1; i >= 0; i--) {
+			if (update_state->pg_pipe_res_update[PG_DSC][i]) {
+				if (pg_cntl->funcs->dsc_pg_control)
+					pg_cntl->funcs->dsc_pg_control(pg_cntl, i, false);
+			}
 
+			if (update_state->pg_pipe_res_update[PG_HUBP][i] &&
+			    update_state->pg_pipe_res_update[PG_DPP][i]) {
+				if (pg_cntl->funcs->hubp_dpp_pg_control)
+					pg_cntl->funcs->hubp_dpp_pg_control(pg_cntl, i, false);
+			}
+		}
+	}
 
 	/*this will need all the clients to unregister optc interruts let dmubfw handle this*/
 	if (pg_cntl->funcs->plane_otg_pg_control)
@@ -1256,6 +1300,8 @@ void dcn35_hw_block_power_down(struct dc *dc,
  *	ONO Region 10, DCPG 3: dchubp3, dpp3
  *	ONO Region 3, DCPG 25: hpo - SKIPPED
  *
+ * If sequential ONO is specified the order is modified from ONO Region 0 -> ONO Region 11 ascending.
+ *
  * @dc: Current DC state
  * @update_state: update PG sequence states for HW block
  */
@@ -1274,11 +1320,13 @@ void dcn35_hw_block_power_up(struct dc *dc,
 	if (pg_cntl->funcs->plane_otg_pg_control)
 		pg_cntl->funcs->plane_otg_pg_control(pg_cntl, true);
 
-	for (i = 0; i < dc->res_pool->res_cap->num_dsc; i++)
-		if (update_state->pg_pipe_res_update[PG_DSC][i]) {
-			if (pg_cntl->funcs->dsc_pg_control)
-				pg_cntl->funcs->dsc_pg_control(pg_cntl, i, true);
-		}
+	if (!dc->caps.sequential_ono) {
+		for (i = 0; i < dc->res_pool->res_cap->num_dsc; i++)
+			if (update_state->pg_pipe_res_update[PG_DSC][i]) {
+				if (pg_cntl->funcs->dsc_pg_control)
+					pg_cntl->funcs->dsc_pg_control(pg_cntl, i, true);
+			}
+	}
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		if (update_state->pg_pipe_res_update[PG_HUBP][i] &&
@@ -1286,6 +1334,13 @@ void dcn35_hw_block_power_up(struct dc *dc,
 			if (pg_cntl->funcs->hubp_dpp_pg_control)
 				pg_cntl->funcs->hubp_dpp_pg_control(pg_cntl, i, true);
 		}
+
+		if (dc->caps.sequential_ono) {
+			if (update_state->pg_pipe_res_update[PG_DSC][i]) {
+				if (pg_cntl->funcs->dsc_pg_control)
+					pg_cntl->funcs->dsc_pg_control(pg_cntl, i, true);
+			}
+		}
 	}
 	if (update_state->pg_res_update[PG_HPO]) {
 		if (pg_cntl->funcs->hpo_pg_control)
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 28c459907698..391f9f69a923 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -1891,6 +1891,10 @@ static bool dcn35_resource_construct(
 	 */
 	dc->caps.max_disp_clock_khz_at_vmin = 650000;
 
+	/* Sequential ONO is based on ASIC. */
+	if (dc->ctx->asic_id.hw_internal_rev > 0x10)
+		dc->caps.sequential_ono = true;
+
 	/* Use pipe context based otg sync logic */
 	dc->config.use_pipe_ctx_sync_logic = true;
 
-- 
2.34.1


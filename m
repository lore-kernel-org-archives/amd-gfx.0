Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D13C27C55
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:02:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C08010EABD;
	Thu,  6 Jun 2024 21:02:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dAOVqBPc";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12B2B10EABD
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:02:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QlK+LJAZ4LAXKy8qfckPQJDezJkKFDgx/URjQ/egx/nBpweJYAlUs7numrqyaf5ILmO3EX2KzQAKSDL3F2LQikAik+8LaYV98Z3XN8GWTTkR34Iqc0juMq89cwLxUbAeoLQUhpJJbo5AajBeEgybSVZwWmVI0AE027ZoBdEoUiuvfcsR9r+9zKl0sZuVVoK0SqYw6xGWWM7W/Op5arTVGDrLWbGul3E4bzf8ruBdFVUVeTHo2irs2ckBfDCYBwIv4bw3/pQ1iu1Y1MIIAIfIObd+nOA4c/cPej2Ewx8XLiRVfhKVUYAJr9/T9UcG1daCdv11AWPzsngx2/WbtcNbiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sow5IFMZMNby5XTLVRjKFwTLK6JaQ7vsVvU39CGbjfs=;
 b=WMjEJSjrYuhYWbHnAmdj7nW3ij033oXApsia/kKG9zGNUMr1qLLz+XsbbPwjvspih/hgfN4O90VyZRHxHuMKXy9UpsBEPb6fDPkIzIcXWeAungnIASoK81O+vAUecmF+E3j+ESV747A37e7I8AvnRIR76SyQ+/2CFgtqm2Ps7M+Jq9d6g93Rva9lON+QwzOL04d+UgjsIQqPqpEpeQ7eFU5lfnv0R34DCSAAbh4Wza54HwQO62pxhs5Z9OeXKRHVxmWIeWIRT+DrNUiA7Q0Ssb2n+3BHaj8wdFuWP0yveuuNdG1P6ZWkoYRXMKzR1bhMXd0DOLFfIVmM3HXJOBrXEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sow5IFMZMNby5XTLVRjKFwTLK6JaQ7vsVvU39CGbjfs=;
 b=dAOVqBPcDV7NyWiKRwEY3HVN2pz6vMwqmfGbeHnJgig18lzzkOSBEtD5yoVV+3RGGQYPVco0pomtBzX8ABJe1yagHN64+9BE+7ytE/W3JYfFyQtG1zG+R6dc33QKy44TqE/pKOHmOi6W0uKjw2XmUn5k9jWtZBik6BVf9Ovi830=
Received: from SA9PR13CA0010.namprd13.prod.outlook.com (2603:10b6:806:21::15)
 by DM4PR12MB8475.namprd12.prod.outlook.com (2603:10b6:8:190::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 21:02:25 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:21:cafe::28) by SA9PR13CA0010.outlook.office365.com
 (2603:10b6:806:21::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.7 via Frontend
 Transport; Thu, 6 Jun 2024 21:02:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:02:25 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:02:19 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, "Sung
 joon Kim" <sungjoon.kim@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 20/67] drm/amd/display: Add sequential ONO sequencing for DCN35
Date: Thu, 6 Jun 2024 16:58:41 -0400
Message-ID: <20240606205928.4050859-21-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606205928.4050859-1-zaeem.mohamed@amd.com>
References: <20240606205928.4050859-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|DM4PR12MB8475:EE_
X-MS-Office365-Filtering-Correlation-Id: 8059358e-6174-4749-ac5b-08dc866bf7da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w4s9u8bc2PxfFKbqknB3WdrZh4WIRviYbkjgOcuDE6b+L3nj4mlKqSNzIXeV?=
 =?us-ascii?Q?fkJB/yqiZRUEIgilIWsdtiG4o03SdekvdpeQUDA+gYwGyihlj5qEtmzgaRlU?=
 =?us-ascii?Q?3salcZylpZPDNVkPy4Bk6kO3pLhlsIb4L9QT5fDmb/ngPKbvFNWEwkTk8G+o?=
 =?us-ascii?Q?Qiq6dVO9JJ2oIqaRt+PAOrh4GXqiaBwxcqMCBQqnbAGJImYydXo/KohVr5NK?=
 =?us-ascii?Q?E6Ti8ap/tUNwoPP8/J6vVwqdSmn8pxLoDReJDaFvXJ4d1ZjpQZ9xJ32D6HFv?=
 =?us-ascii?Q?0ibIezJVQE2NhCqPnR5FvCFoQDv+mH6eCEvX4Cbsr/P4KNN9ShbLW9ogqqXR?=
 =?us-ascii?Q?txd+YG/zHt4mSVJHZWDSSU9Fn1VGvWzsEgFn3XZWodJZkSQdhfldO6QJkbYW?=
 =?us-ascii?Q?hdtLDd/Zom1UfQa48XU7NK2dO3Q90K/OLIzFmMDwaIhN6RQbF/X3obq+HHI2?=
 =?us-ascii?Q?pjADwyulUsB+K+BGf6WvXRC9H4tOp7Gdy/Pb62Vif66UgbW/iwf6BpGxqmXk?=
 =?us-ascii?Q?AGd387HmI621zIB50I5169WfcQECMB2Idn/isrSZu0X8LmO4b09GrVYJa970?=
 =?us-ascii?Q?PpGCsTA9z9ftz6kwUjLwbVJS+iTKX7VmxvJ0R5RYTZN/9moNWubH2x1H7S9m?=
 =?us-ascii?Q?Xcu8WJyvP3UjnkmeVK2U+0o9ZxXeW3PskWA1vjZ4/konl/mQT+XEnRLFmt5z?=
 =?us-ascii?Q?njOV7TDj5iBFelzVre34DOcWZdU82nWYhAWi7OcSFcP+1C5blgmmnsMq2nOl?=
 =?us-ascii?Q?4r1wGsgZWmTnpaA0WSsuGeenybn+qw12RyLEo+H6aecGju56pZfaqgP2h6lw?=
 =?us-ascii?Q?wpNLeZkGNWHlULt07KHNWmkJLrqBPsQVD/QxTZqSXEf+pQAGq4ruPAspLRXT?=
 =?us-ascii?Q?wdeYCVK2QAYv0oB6781RpbnFdx6Aun4npxDqpYEuAxdNioo3m1e1ugwnBRHE?=
 =?us-ascii?Q?FJsSeVSl1fsBp9oAPIwe6wnjO1W9vm6Ji11KGusF08Dk+z4rIw5/ca7KbdHH?=
 =?us-ascii?Q?9aFwstmJfpX/0He1bEPKIcLQzE7JC7qn0kDnFa8qqQ7vvlNdKksku9fstm2v?=
 =?us-ascii?Q?pGAqQroXa6zGWJQLnIXOznyKiwmChAFC4nwib0DMWFjyZHO8ujx1mnv8MqLg?=
 =?us-ascii?Q?VKo5+q9Yqvj2rrP6yc5Z9KPqJ8pXhoffv40oQtMjM/g7fMXqwO61fN0zhewi?=
 =?us-ascii?Q?7aCQ/eCLxa6mJQfxyhqtuvHXneAlEnG6ftu1nOKmqgIEr/SsQDzZaN+zaD44?=
 =?us-ascii?Q?4FaGJwjU5185kyWYW9Qyajlf0ZXL0ZKXnKw3hpMtG660kLk75X76XEvN3TD2?=
 =?us-ascii?Q?uCo+eIIXXUBZlkJ+4S5FMfXSjdzXrG/UqeJWBxL6Q2eAJVI9Dlxynmo4qbpN?=
 =?us-ascii?Q?1m0ndxEqmFWhOaSa+SNPJ2vK711CWbxfUNjLfRTgkqqF64GglQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:02:25.6912 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8059358e-6174-4749-ac5b-08dc866bf7da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8475
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


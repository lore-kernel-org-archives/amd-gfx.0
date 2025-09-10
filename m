Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AEF9CA101F
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 05:33:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAD1E10E84F;
	Wed, 10 Sep 2025 05:33:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1dR+uqD/";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EA9910E852
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 05:33:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uitbiwXh//a8HmhXj51jBhTG0qNhOIlz4lke8rKlsF2vgHd3XBId0qUcB0i026DObHQjegW9JaKpXWGQvLxAunR3c7Jojy7D3Uld0+scYO3k38oHUTJKqXBv1q0jjk1VX2l+UGsoa85/z/LUlXDbKgL3fYSJvxDzDjDXKzhEjnaYMvJ4YV7mbz/anZTo4cSf3jL9O1hYQVQvpUjAaoyjAgXeG6MIJ4Agc7/ZVQ+3kC9WXK52M5sEL+yyQKWlIIT0hO1dnKQpkBMfsbLynf1z8KQ0ATXH8xb+6g5y442NLpiVnWVP/raC6CpCSRdIRHPg/IPm+N+fD/r/5gpE4g62Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GwffbhZ6k5qM6EwMUde6x6zngiWrD57Q4VPCLjvdLcc=;
 b=ezpkZUxN9gUfO7vI7kptzSNADp/RKXBhUfuP/XsMqAA4IgXeduBlfGRK6E/w8BfBgyGN1ZjLedaugMZSqBErcpd+xH5rFDfwGCkeFnDn7CtqRO0nBt39YvPWHCA+f6MxTchlvZHwlhU72o/tSRLpJJexuFKpe9jBcD8UB9i5B+7HKqs46m3UhLYXsct8RMfJfaTCyPRGS+Ij0pW0tDGaYCdRYRPyswBb0Q5LKOm/27PbkFDIUQF1ecthOMKKYqKV3KV2c5JRwHaKfC9XTckOjCQkXGXnkJIpLKNaI1NVVALyexqeeOmpHFb3T9OsKadsICk0KucjYOotiAuk/ED63g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwffbhZ6k5qM6EwMUde6x6zngiWrD57Q4VPCLjvdLcc=;
 b=1dR+uqD/Qk10yqY2n1u9DhueShW3pL4ptX+fRLEWKu+LCQW3MBorfPS7i93oYa+qpeqytlAje8SMsuJk3l9YVGk2IbE8TkXqGQ8Ll9Iql8zaghnJgew/bdWysAwYhSBSy9gpoOSawKSr1YYgVmbSpP0b3eg3Fczbqu9vpoZLh20=
Received: from DS7PR03CA0335.namprd03.prod.outlook.com (2603:10b6:8:55::34) by
 LV2PR12MB6013.namprd12.prod.outlook.com (2603:10b6:408:171::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 05:33:09 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:8:55:cafe::f6) by DS7PR03CA0335.outlook.office365.com
 (2603:10b6:8:55::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Wed,
 10 Sep 2025 05:33:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 05:33:09 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Sep
 2025 22:33:07 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Sep
 2025 22:33:07 -0700
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Sep 2025 22:33:04 -0700
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Dillon
 Varone" <Dillon.Varone@amd.com>, Alvin Lee <alvin.lee2@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 06/15] drm/amd/display: Disable stutter when programming
 watermarks on dcn32
Date: Wed, 10 Sep 2025 13:30:29 +0800
Message-ID: <20250910053222.2884632-7-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910053222.2884632-1-ray.wu@amd.com>
References: <20250910053222.2884632-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|LV2PR12MB6013:EE_
X-MS-Office365-Filtering-Correlation-Id: 7acdd277-f1bd-4460-aabc-08ddf02b86f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|30052699003|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zIonirM98IGNTq+AQrUCvJ7PP9txdM2xB2mlyGBZyiqlW/UaUfL6YgYox81l?=
 =?us-ascii?Q?qsyQhDXj0Oo4ftTS2UOVovJFYt0rG4SaeHuRTyiYRFqnvMpI94p4CVXBvYlI?=
 =?us-ascii?Q?LSiS7eCaHKSF0JW14LDfxKSoKm78SlMX7EXSbA6KqD9kkU9Pb1593wY0izi4?=
 =?us-ascii?Q?ZGuVlmSZV62LeShd7DXT5XtpI1liNKl4U7AixBMkYmUZhtKtLKCtqRT/tzb5?=
 =?us-ascii?Q?fMTPnySpYmOQVDuVgL32uaem76VuSoZrpCmtlMmTkkfModAKfSDfUG9S2fbg?=
 =?us-ascii?Q?E1NZ7Ev+LGR4OI7uBveepUjWjcwEhYw/PxWA8Ww223hXhHsA34+ISyuNme+h?=
 =?us-ascii?Q?FaeTgrKMVak6IFh3UUQjFtkyVMc80JeMMnbUzThY/I8wt6HB0bvHo4j9iByw?=
 =?us-ascii?Q?9bEOqCpcQYoN7O+O/Xdbeu7n8aa4DAkITmKZQwptJYS+H6UDB279J/b/eMGX?=
 =?us-ascii?Q?OETcLZwxbfMYPHLUKWYAmK+97o+fxN4HgFBrCIpUSVbr1LFVfwcV3AqzBpbk?=
 =?us-ascii?Q?X+Dz3cuIev17zKJaDnNbFi0UH6YdP+JOOuEVimABcGKzKRd9QZI/pwfovg2b?=
 =?us-ascii?Q?DOooYcCyZ2N48XWkdUzjmumkn0m86+iuoIUlEhnb2dg1tkflPscg10m3z+ap?=
 =?us-ascii?Q?pV6s+x8X4KW+HOeppKUHPYCS4sx9x1emZFA94k7Yu/MtPjVVjNzLBWdw6aZs?=
 =?us-ascii?Q?9x5qdKSA0yx3FhNhHnWDtPeXIvNDTlwej1a49TNqlIPxQskCCygpsK5hlJOX?=
 =?us-ascii?Q?SW7Up5CVYG4UsBEvbsOoDEFl7NzPuFDkbM9T6Kpi/FC2kfjAZukqrcWQyfuN?=
 =?us-ascii?Q?n6SGCo9C9y/3DvbAxnYEo4dP/pBFr0Hj1vrm1RqzW1a/NkaRG8A2YYPLJ6tB?=
 =?us-ascii?Q?nljfghLCfOgxJa4oQCsZRjsNK1GDeQEkKIrjbkObIv5rwaXpr5rB7cfXO6EV?=
 =?us-ascii?Q?SPJXUimLG36aV3j2Qzqr3u1NMZPI+ibmwgByOb253sW9tV14NsHw/JzVDjS5?=
 =?us-ascii?Q?TOS6QajKE7Mc7FXLsMt2clO/i4KzSkI910Jr7emAcUCQ64aA3NxOZ6oexXgu?=
 =?us-ascii?Q?P0fBTZ1sIaMo1/xU6ghTenNHx8hfD8nFJJIgMlhBWiurSg4ZwVIxP3O+a5+3?=
 =?us-ascii?Q?58VZK8SJCYgwpsvlhmMszOXGKhomM/6IGTgxheVex2sw5jlbT6g11rhuvXUz?=
 =?us-ascii?Q?+KKpaDYJ/pkAOHulrLNC8gjM8IUMtNa2MFZ2R+nl9+hO3m+8R4lSZyVw58AD?=
 =?us-ascii?Q?/vPOgFRdgWDtTspBU42ZeST3ko6vZDEQM1VRBjXfTX6GUbe5jocNjsIAZjHY?=
 =?us-ascii?Q?hlK7HG+Layv1EthZNhpjNoCLVUi1cNKSm3fO9cnFwIAvCaxu/j6JdlokVQHB?=
 =?us-ascii?Q?eLWBz46LbPVWZw0AN9/nT1Wb0tzeasIRcZMG7eFUf2vE63H+cNoYH8SqwtAT?=
 =?us-ascii?Q?DhW4C8j508PCHVK619XjGCNM6c/FTfBoaaFEeKolpEMFKGhBFIoZwTZ7YHPD?=
 =?us-ascii?Q?t0SFyq3Gw8R9hs8GmlhgYchDFY6DJBydHSTW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(30052699003)(82310400026)(376014)(1800799024)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 05:33:09.4303 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7acdd277-f1bd-4460-aabc-08ddf02b86f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6013
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

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY&HOW]
Reprogramming watermarks with stutter allowed can cause instability on
some ASICs. Disable it prior to raising watermarks (prepare bandwidth),
then re-enable after lowering (optimize bandwidth).

Disable by default for now to resolve an issue with amdgpu_dm missing
calls to dc_post_update_surfaces_to_stream to optimize watermarks and
re-enable stutter.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../display/dc/hubbub/dcn32/dcn32_hubbub.c    | 37 ++++++++++++++++---
 .../dc/resource/dcn32/dcn32_resource.c        |  1 +
 .../dc/resource/dcn32/dcn32_resource.h        |  3 +-
 4 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index aa808675fead..fec056d43535 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1163,6 +1163,7 @@ struct dc_debug_options {
 	unsigned int auxless_alpm_lfps_t1t2_us;
 	short auxless_alpm_lfps_t1t2_offset_us;
 	bool enable_pg_cntl_debug_logs;
+	bool disable_stutter_for_wm_program;
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn32/dcn32_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn32/dcn32_hubbub.c
index 92957398ac0a..3b71bfaca291 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn32/dcn32_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn32/dcn32_hubbub.c
@@ -28,6 +28,7 @@
 #include "dcn32_hubbub.h"
 #include "dm_services.h"
 #include "reg_helper.h"
+#include "dal_asic_id.h"
 
 
 #define CTX \
@@ -72,6 +73,14 @@ static void dcn32_init_crb(struct hubbub *hubbub)
 	REG_UPDATE(DCHUBBUB_DEBUG_CTRL_0, DET_DEPTH, 0x47F);
 }
 
+static void hubbub32_set_sdp_control(struct hubbub *hubbub, bool dc_control)
+{
+	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
+
+	REG_UPDATE(DCHUBBUB_SDPIF_CFG0,
+			SDPIF_PORT_CONTROL, dc_control);
+}
+
 void hubbub32_set_request_limit(struct hubbub *hubbub, int memory_channel_count, int words_per_channel)
 {
 	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
@@ -754,8 +763,17 @@ static bool hubbub32_program_watermarks(
 		unsigned int refclk_mhz,
 		bool safe_to_lower)
 {
+	struct dc *dc = hubbub->ctx->dc;
 	bool wm_pending = false;
 
+	if (!safe_to_lower && dc->debug.disable_stutter_for_wm_program &&
+			(ASICREV_IS_GC_11_0_0(dc->ctx->asic_id.hw_internal_rev) ||
+			ASICREV_IS_GC_11_0_3(dc->ctx->asic_id.hw_internal_rev))) {
+		/* before raising watermarks, SDP control give to DF, stutter must be disabled */
+		hubbub32_set_sdp_control(hubbub, false);
+		hubbub1_allow_self_refresh_control(hubbub, false);
+	}
+
 	if (hubbub32_program_urgent_watermarks(hubbub, watermarks, refclk_mhz, safe_to_lower))
 		wm_pending = true;
 
@@ -786,10 +804,20 @@ static bool hubbub32_program_watermarks(
 	REG_UPDATE(DCHUBBUB_ARB_DF_REQ_OUTSTAND,
 			DCHUBBUB_ARB_MIN_REQ_OUTSTAND, 0x1FF);*/
 
-	if (safe_to_lower || hubbub->ctx->dc->debug.disable_stutter)
-		hubbub1_allow_self_refresh_control(hubbub, !hubbub->ctx->dc->debug.disable_stutter);
+	if (safe_to_lower) {
+		/* after lowering watermarks, stutter setting is restored, SDP control given to DC */
+		hubbub1_allow_self_refresh_control(hubbub, !dc->debug.disable_stutter);
+
+		if (dc->debug.disable_stutter_for_wm_program &&
+				(ASICREV_IS_GC_11_0_0(dc->ctx->asic_id.hw_internal_rev) ||
+				ASICREV_IS_GC_11_0_3(dc->ctx->asic_id.hw_internal_rev))) {
+			hubbub32_set_sdp_control(hubbub, true);
+		}
+	} else if (dc->debug.disable_stutter) {
+		hubbub1_allow_self_refresh_control(hubbub, !dc->debug.disable_stutter);
+	}
 
-	hubbub32_force_usr_retraining_allow(hubbub, hubbub->ctx->dc->debug.force_usr_allow);
+	hubbub32_force_usr_retraining_allow(hubbub, dc->debug.force_usr_allow);
 
 	return wm_pending;
 }
@@ -974,8 +1002,7 @@ void hubbub32_init(struct hubbub *hubbub)
 	ignore the "df_pre_cstate_req" from the SDP port control.
 	only the DCN will determine when to connect the SDP port
 	*/
-	REG_UPDATE(DCHUBBUB_SDPIF_CFG0,
-			SDPIF_PORT_CONTROL, 1);
+	hubbub32_set_sdp_control(hubbub, true);
 	/*Set SDP's max outstanding request to 512
 	must set the register back to 0 (max outstanding = 256) in zero frame buffer mode*/
 	REG_UPDATE(DCHUBBUB_SDPIF_CFG1,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 4acd97b3e4c9..8aad920544bc 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -739,6 +739,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.fpo_vactive_min_active_margin_us = 200,
 	.fpo_vactive_max_blank_us = 1000,
 	.enable_legacy_fast_update = false,
+	.disable_stutter_for_wm_program = false
 };
 
 static struct dce_aux *dcn32_aux_engine_create(
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
index 20d714596021..99f0432288b4 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
@@ -1230,7 +1230,8 @@ unsigned int dcn32_get_max_hw_cursor_size(const struct dc *dc,
       SR(DCHUBBUB_ARB_MALL_CNTL),                                              \
       SR(DCN_VM_FAULT_ADDR_MSB), SR(DCN_VM_FAULT_ADDR_LSB),                    \
       SR(DCN_VM_FAULT_CNTL), SR(DCN_VM_FAULT_STATUS),                          \
-      SR(SDPIF_REQUEST_RATE_LIMIT)
+      SR(SDPIF_REQUEST_RATE_LIMIT),                                            \
+      SR(DCHUBBUB_SDPIF_CFG0)
 
 /* DCCG */
 
-- 
2.43.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8460CA0FED
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 05:27:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70E3D10E83C;
	Wed, 10 Sep 2025 05:27:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lcov0sZ/";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1131210E83C
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 05:27:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=un/nsHKdtk1GKUfX3Gxb+Ip2F+qoCVZFuD6SOVxNMQRojm6gdHzI1C701/AnJyl75DTCJz1IPPwXXEw3uYeKb3RTPASPMquZ9OK25E5UCMHlWmiG7KZkLCIje0yKAGVKKm7q8gTnXQk+T1mF5Yp571ix7l5JJJN5SdzrbjJkLRlhWkXyEJKsEQnRhWrh6L5S5RxyR1gTJZ08ovIIrMls7vYIUZUZ+MFmi20rehLl/xuak4CKBAK2zkqMZUknuUG97+0FHF7obrdBDmF7fE8xN34ggJpv7ebw2nhHjK7sHHnyuKqe4Z0Qnush3LQnQux81HJ9RZFThWvR5TBBulDvvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GwffbhZ6k5qM6EwMUde6x6zngiWrD57Q4VPCLjvdLcc=;
 b=Q9JFhxE3HqJoKlo1WqhL+60hLeixyC4S5j2cgT4jqZKkL2YWu1FpIUtsPJvQajRUAE4nA5LWSjcAWot9S2R+JVHIr7j6DoO5OBAvHo34CiO7SPKRXcPerGhWPuHrgH0EA2+d4jtts/HAJM8ekqCz74lWZtDxrnlxwxJ0BfQ1FrTeZzfhAGmgBRxpm1TvBXQGrhNMnWERxyINtnZLstxZJr8Fk+dSzY15tayl3TBgsaSeB9R3mp1k7TcCLe5eAC7TX0oR1++An0I4mqXbZiW3xo3rBPM82sLsOPNu6cCpIeNAjX15m+vl9rmR2HmkfLavoN1cUA6QNFgHt2jLqErENg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwffbhZ6k5qM6EwMUde6x6zngiWrD57Q4VPCLjvdLcc=;
 b=lcov0sZ/ySaSywIK/RayUZ3R1K5lXw4AO1vqzp21EC2+Sk+KiU/HpT8HL+lInGJvuGAd5FgAFc2kPVbmVsijEBQGF/gNveDOyQy6En2XuS1haLeQNns+3LkYkvQALR5QCNgsAMJRHJe1bCXz3GHlnMeCuqtuaUwSChfSLod9mlw=
Received: from MN2PR05CA0006.namprd05.prod.outlook.com (2603:10b6:208:c0::19)
 by MN2PR12MB4334.namprd12.prod.outlook.com (2603:10b6:208:1d1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 05:27:11 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com (2603:10b6:208:c0::4)
 by MN2PR05CA0006.outlook.office365.com (2603:10b6:208:c0::19) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15
 via Frontend Transport; Wed, 10 Sep 2025 05:27:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 05:27:11 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 9 Sep
 2025 22:27:05 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Sep
 2025 00:27:05 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Sep 2025 22:27:02 -0700
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
Date: Wed, 10 Sep 2025 13:22:08 +0800
Message-ID: <20250910052620.2884581-7-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910052620.2884581-1-ray.wu@amd.com>
References: <20250910052620.2884581-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|MN2PR12MB4334:EE_
X-MS-Office365-Filtering-Correlation-Id: cf6cacc5-8c6d-47b3-1e2f-08ddf02ab1ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|30052699003|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?exEqccaOnCvEFObLAPM0BwAn49Z9p2l0RJl3Nb/LUJJYZRg0Qm0fIw7lVJJU?=
 =?us-ascii?Q?SxiqpG/WsaGEahq3hGy07v8RiJHO1ho13dh6qcNRtrJ6vUhpkjMqqcozQszK?=
 =?us-ascii?Q?H6ecYcvbflO9sCLsxEDibO5ntyPPaeaHCDRYskIiIkaMDgRTB5jR67NEPWgE?=
 =?us-ascii?Q?b2ciVWgoiZRFFR97Gwaa67Qw58Kuqxqv1gTpaypeTwWxjTtET2NmnwC+v+BT?=
 =?us-ascii?Q?Jz/a9pEjpVhOx68OAvBEOEHPzpamv3EAVUtQynL3K5TnW5yLEgQ2yMw3e6EW?=
 =?us-ascii?Q?ejz31qTAuyyJqJWTudxW8qIJEudDvVCXOifpuBoGS4rcXFft51l0ysUY2PO/?=
 =?us-ascii?Q?H4wMYDOWeyzPNi1GNJ3AWL3Q66MSZwCqcIe2l6HeE/49W8XfEjbrPAhnY9od?=
 =?us-ascii?Q?6pmC/51b3f76e3799NKpo+hY5+iHPENGhUMJNjEMhfr2RYo396VrOJsv1Lau?=
 =?us-ascii?Q?V3cPUHrufDaE+aTkuUqWz+farcnxPactdtTM7ppImF1YLV2Z8Oo024CeyPmL?=
 =?us-ascii?Q?Y64PjaPBEqeZsoO08c6euhFAr2jigXyLzKWqhvnXx8tjeF8sHaHc1RWcKSOg?=
 =?us-ascii?Q?2gnsu1qoKwy77Uvr/N9NQ6hSc5Cn4W0z63Dg/EIb+ls0ls7ZzkxV5dkvfWEe?=
 =?us-ascii?Q?ePvyRrkQih/vJDE8U2JTuY+N6I/lrV3ukcBQjHcEatu/ytsvSyhWQ7IowW/N?=
 =?us-ascii?Q?Z7zlfvGG/gf26fOM0L+dMaGIFkANQsqqEEWW/rVKEoIyal0xk+E8Fm3SdCuv?=
 =?us-ascii?Q?Jv2MGT7jleCnDItixB/yTU05ZswVyoc9HIr0i2xYoTHIG6vjRKqDHa3882qB?=
 =?us-ascii?Q?cUqdtNiDcR1lU03qo3RIizfTl0er+OOuRWO9K/TUKdSX7+cfKJJ/emQi0BJw?=
 =?us-ascii?Q?uj4Z3wPrYTknQerhzaEii0hF5eIlCYcy9pZzpQf0rSaF7JQ8/oD0ZmOTARtu?=
 =?us-ascii?Q?Ph1Xt60kKi3bQ4lmo2Ug9O0e8i/JwymnYgYu+i7wVXKduJIlzK+mRRcSTfep?=
 =?us-ascii?Q?3ueL4FxsQtsIY7Km+a4W2KPgyAQ4VmiKoZoR9E72Lh8yR2zLGeQA69VqlQAY?=
 =?us-ascii?Q?zUp5h1GJWiTpkmylTZrfUscWwd4JLq4bEHtIGmxmIQxPPM6I+Hq4CoRIieLj?=
 =?us-ascii?Q?lCAxauam8/B94AjklSRoXRVBETgfnlQhi8sD3d6IRKoHB+95P4Jjtuw5hxUj?=
 =?us-ascii?Q?eHQsUKNYSCN+a8HJJXCbOfJGp3QOyp/RlxBYA18t1oinecxnYoCoFKdec8ao?=
 =?us-ascii?Q?IeFdKhB21g0XEG09TUPcWpYKm8BC2qU7bHSg/rQ5xGd4edrLm/fdf5j4XWES?=
 =?us-ascii?Q?x5+c5Ef+SiMc0J5E/XhkByexEyuiww16jmm2ZwIZR0dgOtHXmQ7aDTB1LquS?=
 =?us-ascii?Q?WGldC61WtDUhFckghfmLvSN3qHw3v7PGRZS1EjlZ6n/tRNTEvm2NoLXZLhJt?=
 =?us-ascii?Q?RY9iWNM4nWAVskEMsrhT672/dQK3a6SsZuHKJP6TKNc+ELhYNJn8Km8sK6hs?=
 =?us-ascii?Q?2l4Ut9bITSo/e2n6Y6j6stjPYGPmXmJSzq8b?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(30052699003)(36860700013)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 05:27:11.6245 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf6cacc5-8c6d-47b3-1e2f-08ddf02ab1ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4334
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


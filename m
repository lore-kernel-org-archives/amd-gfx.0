Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC89C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:42:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0873D11392E;
	Wed, 24 Apr 2024 08:42:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KdxR8QQr";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FFFC11392E
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:42:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=noPBVa3yoaeNUgWbbhuEI2Q8K3gtPQOKAlfkCSYkUbySfJUf76mGr45AblzprBqReOXvTUGQQqkRofzTXNwVaVS5GTmrNZTAO227owzriuUBGqyAYFxISnTWRxeeQDpDRgprTkK5WTPRasGfOOnPMndoFU1n8GZjfITVTCJ4YNsuvlXDo7cj2kv4FXrR7a9jKdUBU3UZfxVI1XnpFzaACUqNh4bE3B+SFZCqKqWgeW3EDTBtIUc/sLEnrNLZ3vw8JSqMSeqi+DEc/MEMQbYYNZJfffz6+z31Ju6f6OCRW7XH0u06mxzuIKQxbmYUTtXFlw9UO7taA1PWEi+FXp5p3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOrfDeCb4aBuoc8K38JwEgHB2LZQCCZfujsO3SueO2w=;
 b=JHul5WZsSAxFg5DAw90Qzn99AA6QUykqzbytZhOLMvLadioX5+zOfKGncr/zQX0MDdKKkT/PSwvbRvxpQfRO1qIZi7fOxNU5ba8EdZoVIzN4ryhiVKGeNtStoxZp7jkEbbnvOH/lsnraYDAKZO/W7xFuDjJPUbjlevJGzqmkCrY8H53qrtyBcaG2IIr1Op30Uu/lM7CD8Dtnibjj8Lo6ita3k5f6VMI9CuybzwqdRIQy5hMNYs87+0AIETLX2bLZ/NLdiDgX+L8mIHd8J9nVGOAe4OHrZ9RXEySfSiS7rp7HDR9nV8krJg6kr05U3bVBK/l7TO6HybyfkDiueho7sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOrfDeCb4aBuoc8K38JwEgHB2LZQCCZfujsO3SueO2w=;
 b=KdxR8QQrqUSoRXC+bHcSfc4q0M9VNOnFcaGUB1YnTLcIx0Wx3N1chnGnBDvP1lXxL+iuenCJ4LhM7Duil/SwrPxh7iDMwfRmXTK/h1uNLnwZblFTkG6rOeCyvSOSTt3hoHOVuqQmu8QteAjRW9IQ78gRRu37wEyEwLrd+Gg5DJM=
Received: from DM6PR06CA0039.namprd06.prod.outlook.com (2603:10b6:5:54::16) by
 PH7PR12MB6787.namprd12.prod.outlook.com (2603:10b6:510:1ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:42:10 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:5:54:cafe::d) by DM6PR06CA0039.outlook.office365.com
 (2603:10b6:5:54::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 08:42:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:42:09 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:42:04 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:42:04 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:42:00 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>
Subject: [PATCH 15/46] drm/amd/display: Adjust functions prefix for some of
 the dcn301 fpu functions
Date: Wed, 24 Apr 2024 16:31:31 +0800
Message-ID: <20240424083202.2647227-16-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424083202.2647227-1-Wayne.Lin@amd.com>
References: <20240424083202.2647227-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|PH7PR12MB6787:EE_
X-MS-Office365-Filtering-Correlation-Id: e704d457-1b8d-40db-27cd-08dc643a6e3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ptdsrG0Q+n0mh9XPqv5SrmWvOmVUaBJTBebbkKyBndXAotA5SBvBwhC4d71M?=
 =?us-ascii?Q?lvusZ5bKNN3cDhdym7Nz9ISyaFrJQHD3eKqLVpZSMrZaUvr6gGfEr5h4lt8t?=
 =?us-ascii?Q?0KoOHUBP551SYEZ1MMNmSqQV8KhMS7ABo+oLpU47sbSnRYp6U7JpyKi8Uz4C?=
 =?us-ascii?Q?W0CdrjgQKGMsf/F8q34oFWXvQnD1boHimg/yJaE8QV1MKO86noHGJc3iaJHZ?=
 =?us-ascii?Q?LpqEeGGSfNuqfHQ14InrTOdxdDUm1XocLlFLy/6+seJgGZXKzJFs29+kRYDV?=
 =?us-ascii?Q?xHsKjVxTIajT22fwXBgf7mwoIDnEzjOBSflS3fmXexaYFvekbHs0lRfbrtjw?=
 =?us-ascii?Q?ad1/2MT2hnuBlZSQtG7AixMPPVXDnSWQoKmfcJUwhpELj30eT0FpwzD8P3eN?=
 =?us-ascii?Q?zqC5KR/+dqaAQuNkX6he5qc1N4Y70TWTtv5oJUyEfZmRRJUfwjvuJS+ScXSW?=
 =?us-ascii?Q?mfeTLefoAXJRRivHU3Y9+DzjDDQ4MRlgzswevZ+EIbYLuV01QFdSBDzp+dWl?=
 =?us-ascii?Q?FCYiKxmdgcZ7snGXGg3WYNsLV8ZGCKorS609KFYufWckzzB7IGqJCaYGXR2+?=
 =?us-ascii?Q?MCcng9o2fKL96a0PJJOV9TEQxdMeOrPP+C0Q8wJiMXwZCn3GEzzk8Ibnyeb3?=
 =?us-ascii?Q?KDquPlDyZNLMIsSVXcyNLXL4MDwfyxlXTD9jcxmorm0q3mrLa99/6tOPmsCK?=
 =?us-ascii?Q?8AhMSGRNyd1xZIRaMw14RcvgEQicxvlha7nKu3nS/zaX2KXh8dwo6+uJ3dYD?=
 =?us-ascii?Q?jd6LuchJ5EvF8lzCZz5CeFjq92yAzpaHe3/eHOkBFvMudIW93jj93d3RKFTW?=
 =?us-ascii?Q?ubWoTLPx+1chAYVa6Oozvp6cDlJoHXkeN2x5qxyYeOPzuo2TR0dx3CnifSit?=
 =?us-ascii?Q?LpSQn6zqDDl/YVrTsBR8BrJki9vIlFw7Cx9OJHXmz3lClYgRVediKmM5igEI?=
 =?us-ascii?Q?s6G50QHQ7xTjbm+WwvvBHho317lNuwYLI0u9woByp8ZAGmWrzkWXhLqR6wus?=
 =?us-ascii?Q?99IgfpBLHOkVWpoLa7mwnPWQub4pspcg/I7u9H1OrvnE5OCeTQiAMnlQRGxi?=
 =?us-ascii?Q?m4j6PRphhuHlTQXv8ngTkczdPNzGmHUq0bRmN/vap2Eu+unvxgu3mu+7A+VA?=
 =?us-ascii?Q?PcA5393GJdVQpJ/AEGoVEPMdiuXGV7XG8fOYpxtWNSTE23z91cDLvdNLGik/?=
 =?us-ascii?Q?3Ma+Dj7Gbt0zQt416tix2rzLNIAQpU0w6k8hcyUbTbK1ooTgPKUsy4hua0PD?=
 =?us-ascii?Q?irZxSr6lzc752xXituLCCZaG8QvGQ/uP5ITsRPndEZyxaY07cWbvhirdhoF/?=
 =?us-ascii?Q?CYOfem10xZ+8vXAZwM0aR0GZ8FqQ6/ysaGKaHQhtJHV4NzjfWRFC8ZS9Nh0G?=
 =?us-ascii?Q?00LDIvtYZYdeEyczFv7H88m/TaiY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:42:09.9056 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e704d457-1b8d-40db-27cd-08dc643a6e3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6787
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Add dcn301_fpu prefix to some of the FPU function with the required
adjustments.

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/dc/dml/dcn301/dcn301_fpu.c    |  4 ++--
 .../amd/display/dc/dml/dcn301/dcn301_fpu.h    |  7 +++----
 .../dc/resource/dcn301/dcn301_resource.c      | 19 +++++++++++++------
 3 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
index 6ce90678b33c..0c0b2d67c9cd 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
@@ -320,7 +320,7 @@ static void calculate_wm_set_for_vlevel(int vlevel,
 
 }
 
-void dcn301_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
+void dcn301_fpu_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
 {
 	struct _vcs_dpi_voltage_scaling_st *s = dc->scratch.update_bw_bounding_box.clock_limits;
 	struct dcn301_resource_pool *pool = TO_DCN301_RES_POOL(dc->res_pool);
@@ -409,7 +409,7 @@ void dcn301_fpu_init_soc_bounding_box(struct bp_soc_bb_info bb_info)
 		dcn3_01_soc.sr_exit_time_us = bb_info.dram_sr_exit_latency_100ns * 10;
 }
 
-void dcn301_calculate_wm_and_dlg_fp(struct dc *dc,
+void dcn301_fpu_calculate_wm_and_dlg(struct dc *dc,
 		struct dc_state *context,
 		display_e2e_pipe_params_st *pipes,
 		int pipe_cnt,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.h
index 774b0fdfc80b..3e103e23dc6f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.h
@@ -26,15 +26,14 @@
 #ifndef __DCN301_FPU_H__
 #define __DCN301_FPU_H__
 
-void dcn301_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params);
+void dcn301_fpu_init_soc_bounding_box(struct bp_soc_bb_info bb_info);
+void dcn301_fpu_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params);
 
 void dcn301_fpu_set_wm_ranges(int i,
 	struct pp_smu_wm_range_sets *ranges,
 	struct _vcs_dpi_soc_bounding_box_st *loaded_bb);
 
-void dcn301_fpu_init_soc_bounding_box(struct bp_soc_bb_info bb_info);
-
-void dcn301_calculate_wm_and_dlg_fp(struct dc *dc,
+void dcn301_fpu_calculate_wm_and_dlg(struct dc *dc,
 		struct dc_state *context,
 		display_e2e_pipe_params_st *pipes,
 		int pipe_cnt,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
index 7538b548c572..346cec70de96 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
@@ -1363,14 +1363,21 @@ static void set_wm_ranges(
 	pp_smu->nv_funcs.set_wm_ranges(&pp_smu->nv_funcs.pp_smu, &ranges);
 }
 
-static void dcn301_calculate_wm_and_dlg(
-		struct dc *dc, struct dc_state *context,
-		display_e2e_pipe_params_st *pipes,
-		int pipe_cnt,
-		int vlevel)
+static void dcn301_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
 {
 	DC_FP_START();
-	dcn301_calculate_wm_and_dlg_fp(dc, context, pipes, pipe_cnt, vlevel);
+	dcn301_fpu_update_bw_bounding_box(dc, bw_params);
+	DC_FP_END();
+}
+
+static void dcn301_calculate_wm_and_dlg(struct dc *dc,
+					struct dc_state *context,
+					display_e2e_pipe_params_st *pipes,
+					int pipe_cnt,
+					int vlevel_req)
+{
+	DC_FP_START();
+	dcn301_fpu_calculate_wm_and_dlg(dc, context, pipes, pipe_cnt, vlevel_req);
 	DC_FP_END();
 }
 
-- 
2.37.3


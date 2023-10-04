Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB8CE936E9
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 21:22:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FE7710E1B4;
	Wed,  4 Oct 2023 21:22:18 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7033210E3C4
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 21:22:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmqZ524cRCUTuAFCDwcbfl1AvmfbT2Co8O2ES6Hhe9dG39L8gjZnY8rTIGFiTg/XdkR7jxARPTCOU1swG04RETIWzXAXtmRfwemsnAFMRd/Tb2OxayIVTEvCI6+tmGtD07cVn4xLUkeBi4KdWuFQGXjaaKNCebsut2L2T5C2RGTDoQC4YxeTl5IzAoN+NkMis9ItgWjlRDe+kgECRs5oA1aAtevfv27T+Fibg7qn3M5wkCR4Mih1O08OkjS//EaWTEsa2C+7sBAZ/zXO9Qn4y+Pvr3QQ2ct8yDlafAI/lpWlFe6ZRfxwhh5yD3qWxJpfi2riIjMco4SKD3O+u2mumA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nMGqBUM7M5VzgJ8pK9raDpgysHSvUE66i6n0yq5ups=;
 b=OmNFJBGSExynomvap7tF9sqsCsjm0d35ckZuZ0sF2jGPo03mNd92HNdxSRif+upNq0PNgdQCZSwf4XOQFmQiY1MQqWsW/kzFQX85wTMyc5abwulFKrDjVufmFKAS21SNQI8P1pDTRqr7Cpy8C2+Ai3yiEtTDwHu/XW34R8gZ8xi9wn6puEbWRpWE8tsQSQM+d5New5F3kEl0GbnlSLx3veDZxczvKfHyIO3hu0RSojiQZFiqH+gGOAB+7vRbwQd5wJgTqpqVnO6aqrwlUpCj/YsUhRlbE8wbyo+XxuY5SKyR0jvYALqqLxLKXd7pZKXy+AtrU58OpJ68tgfL2NWsGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nMGqBUM7M5VzgJ8pK9raDpgysHSvUE66i6n0yq5ups=;
 b=hUFmuUV2oC4BYlDSvinWYCpH1KdEm7XmOWiHGKAJrLK2kgqNoFrj8HNiyPj1rkt1qkmBv4ktAgd7OnysTXXW1l8NrbGWdS3JdLlQrBgbZqaPOeoh9qLuXqWdqqP6ZyBwcfM6ijCDrttlio4J57cWhOwcvvpdvduwULdABo+S4h8=
Received: from BL1PR13CA0130.namprd13.prod.outlook.com (2603:10b6:208:2bb::15)
 by CH0PR12MB5108.namprd12.prod.outlook.com (2603:10b6:610:bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.36; Wed, 4 Oct
 2023 21:22:09 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:2bb:cafe::fd) by BL1PR13CA0130.outlook.office365.com
 (2603:10b6:208:2bb::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.26 via Frontend
 Transport; Wed, 4 Oct 2023 21:22:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 21:22:09 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 16:21:59 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 13/16] drm/amd/display: correct dml2 input and dlg_refclk
Date: Wed, 4 Oct 2023 15:21:07 -0600
Message-ID: <20231004212110.3753955-14-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231004212110.3753955-1-Rodrigo.Siqueira@amd.com>
References: <20231004212110.3753955-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|CH0PR12MB5108:EE_
X-MS-Office365-Filtering-Correlation-Id: b0d45fb7-f591-44b9-96a9-08dbc51ff7b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VesmvfZg3bLVeXFTnzmjGHNLvAcIJegUJNb4RMTuyTwpt+qTzVbDnAflJdg/Ej+5Gm0EMc33XWEnos0Vk5Iex2kqUOewGU2Ioy1Rksf1UVB4zxc7xK1EtOxo4jPKraBblcCNbDb+pB6udVll8jsugo1qiHI/N3azgLoE7PczcdeRu7siUDD/oIwEIR8KtzEr2HHp8FtkFXitQN4a0CmYcrJbf1YTX58sCnqsMYeZ7I8giIIlGz2yWVtXIiHVcgUKS8gQh3kQxwXGScyrmMNEZmtRdmdtrG/jyPTv0E6oe5dqepmDHjkuBtLHlPs86F92FkfKiCjNjTkAzEJfJNHXh1pn+TAQpHpk9prtkgesltnKbWfBRGNh9gOdWMWmixVsjywRDCrQAfcgtP/kb4NZmhOPfH0f7ig8ndlYwtmSt/q9XLzehi3r1SsyOlGQg7aLERxq+dRUHfmyHQc436RMAlpKJeHyLhoPXvZQxH5JMJwNxuSrZCdzQ9aJn/aiqsmJvVoGijsG7xVpoZZN+/fl8uKdxXH5iGET3TtYB3gw8z/JMA2510mfIMo4niE0PYIb6nbQkWBb8S4i4LQTRSDroQfjOPjWgrG0esAucGh9uXRJ6fVNnPhNbN1sWhNGB28y/zj5NzqXRuQyrhCW4Vtp7z/Wi3f5X6dEktGblFZnIFG/RXHWF/0zYShtyk2g4TUytvARGkLVUwe36SVUo89Cn6EdKZZJHDrK/P2iC/AGGuS1zTCdv5BNIVQ7uMKozLgKPniL9tiCakrF4iceepqDVw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(346002)(396003)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(40460700003)(40480700001)(6666004)(478600001)(426003)(47076005)(36860700001)(86362001)(356005)(82740400003)(81166007)(2906002)(83380400001)(336012)(26005)(1076003)(2616005)(16526019)(36756003)(54906003)(70206006)(70586007)(5660300002)(41300700001)(6916009)(8936002)(4326008)(8676002)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 21:22:09.3250 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d45fb7-f591-44b9-96a9-08dbc51ff7b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5108
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
Cc: Charlene Liu <charlene.liu@amd.com>, Zhan Liu <zhan.liu@amd.com>,
 Sunpeng.Li@amd.com, richard.gong@amd.com, Qingqing
 Zhuo <Qingqing.Zhuo@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Alex Deucher <alexander.deucher@amd.com>,
 Harry.Wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <charlene.liu@amd.com>

dc->dml2_options.use_native_pstate_optimization flag will make driver
use dcn32 legacy_svp_drr related tuning. Set this to false fixed the
stutter underflow issue also based on HW suggest disable ODM by default
and let DML choose it.

Reviewed-by: Zhan Liu <zhan.liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Signed-off-by: Charlene Liu <charlene.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c | 7 +++----
 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c    | 8 ++++++--
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
index e2f3ddb3f225..2283daa45318 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
@@ -733,8 +733,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.support_eDP1_5 = true,
 	.enable_hpo_pg_support = false,
 	.enable_legacy_fast_update = true,
-	.disable_stutter = true,
-	.enable_single_display_2to1_odm_policy = true,
+	.enable_single_display_2to1_odm_policy = false,
 	.disable_idle_power_optimizations = true,
 	.dmcub_emulation = false,
 	.disable_boot_optimizations = false,
@@ -1835,6 +1834,7 @@ static bool dcn35_resource_construct(
 
 	/* Use pipe context based otg sync logic */
 	dc->config.use_pipe_ctx_sync_logic = true;
+	dc->config.use_default_clock_table = true;
 	/* read VBIOS LTTPR caps */
 	{
 		if (ctx->dc_bios->funcs->get_lttpr_caps) {
@@ -2065,11 +2065,10 @@ static bool dcn35_resource_construct(
 
 	dc->cap_funcs = cap_funcs;
 
-
 	dc->dcn_ip->max_num_dpp = pool->base.pipe_count;
 
 	dc->dml2_options.dcn_pipe_count = pool->base.pipe_count;
-	dc->dml2_options.use_native_pstate_optimization = false;
+	dc->dml2_options.use_native_pstate_optimization = true;
 	dc->dml2_options.use_native_soc_bb_construction = true;
 	if (dc->config.EnableMinDispClkODM)
 		dc->dml2_options.minimize_dispclk_using_odm = true;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
index 552d5cffce2d..11c131f6cf26 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -67,8 +67,12 @@ static void map_hw_resources(struct dml2_context *dml2,
 		in_out_display_cfg->hw.DPPPerSurface[i] = mode_support_info->DPPPerSurface[i];
 		in_out_display_cfg->hw.DSCEnabled[i] = mode_support_info->DSCEnabled[i];
 		in_out_display_cfg->hw.NumberOfDSCSlices[i] = mode_support_info->NumberOfDSCSlices[i];
-		in_out_display_cfg->hw.DLGRefClkFreqMHz = 50;
-
+		in_out_display_cfg->hw.DLGRefClkFreqMHz = 24;
+		if (dml2->v20.dml_core_ctx.project != dml_project_dcn35 &&
+			dml2->v20.dml_core_ctx.project != dml_project_dcn351) {
+			/*dGPU default as 50Mhz*/
+			in_out_display_cfg->hw.DLGRefClkFreqMHz = 50;
+		}
 		for (j = 0; j < mode_support_info->DPPPerSurface[i]; j++) {
 			dml2->v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_idx_to_stream_id[num_pipes] = dml2->v20.scratch.dml_to_dc_pipe_mapping.disp_cfg_to_stream_id[i];
 			dml2->v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_idx_to_stream_id_valid[num_pipes] = true;
-- 
2.40.1


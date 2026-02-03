Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08189E87834
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 15:13:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A068B10E6B2;
	Tue,  3 Feb 2026 15:13:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SQOnYY4W";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012049.outbound.protection.outlook.com [40.107.209.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25F5F10E6B2
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 15:13:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UsjCh0ayEPxHYm61xcoA5UbdMo6za+jm4458SMBSCiF1mKWI4Qii/DRXCN1VsZK56kkWmwhtVMl7TRexys9fi2mDNnjd0WvpgYKWaRdP3Yuyzh/uSZk+hh9AT3cAMhHmY77VhhegSVp3fTlP1+WwJkNGm/PfZQ4H/DfJ13pymfaaKfZG4fHJ+iCxwr6eNsJXdTEklJcpcs6H1L0jlS7LxGMdLrzpfaI6zWlqbISbuaHDEmy8c9sZMz4muVDO1NKoxYOAv6WNvK7Ts40tjbXwIgSxBQ7f6nP7MYM8hFt+K6fRSJ0WvcxkNUIaifTKT7nAhArokMw2osUi/BNKu0SFoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTy1Emxzc+qLvVwlGplUHYGYQpMgs2UMp49Xto26YXI=;
 b=i10oEDorCmSMWdxdXTXDFiO55bsUF+tXjDGGHIe91raZ8MIaNck4mauWCpKMg7Za2Y0YrSW1YL2qcG6xik9TV/OfGEC37fIUU7bQ+WnorvsN3a3a1hZzPCftKAU9XD3JgjFxBetHDqUleb5BU0+aVlawW17POYRXqTur2MAgqSHe7IPyvfV2r1s/3U/XdzLAh7WjQB5RbDqGrG4ZqQ79f2++gdKe1dSetBIuukGP6YK5fYFxgGefZz+IQH2rsrmHjxaDSS/fsUTmM/g5poBPesZgLAbkABG5zX+t59u45KcqDPjL22AIm1IcyimJa4cGfGPUmgzF3TgnToT2XQA6rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTy1Emxzc+qLvVwlGplUHYGYQpMgs2UMp49Xto26YXI=;
 b=SQOnYY4WdDykSRTUpb3zF9/6Lzz7evRQlBl21dX0a0Sk+YJuDqwkmkDu6xOL9mdHWe3ET8t6IYHWZqmQA0n1Cxc1c1kkeiNpmDuZ4dS/4C3o+MPSRHHDBd3UDovoQcZw1ALGBfbxyk9MbvWZsJSHwPljYjEhEQ39U3M1wIZmHSs=
Received: from BN9PR03CA0606.namprd03.prod.outlook.com (2603:10b6:408:106::11)
 by CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 15:13:42 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:106:cafe::7c) by BN9PR03CA0606.outlook.office365.com
 (2603:10b6:408:106::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 15:13:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 15:13:41 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 09:13:39 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 07:13:38 -0800
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 3 Feb 2026 07:13:35 -0800
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Carbones <ncarbone@amd.com>, Charlene Liu
 <charlene.liu@amd.com>
Subject: [PATCH 10/16] drm/amd/display: Correct hubp GfxVersion verification
Date: Tue, 3 Feb 2026 23:01:52 +0800
Message-ID: <20260203151229.3673042-11-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203151229.3673042-1-chiahsuan.chung@amd.com>
References: <20260203151229.3673042-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|CH2PR12MB4133:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ef807df-f1a6-4ed2-2546-08de6336d113
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6uTsZjKmK0HGMqtQw82FBJCUjlBSV+Kg3zyI0APUfaOgGb0/+pxQ1HPJbCVq?=
 =?us-ascii?Q?2uf0I5gNVRrR+BMuiqcdUC79QJRPFIhTZRJtOFt/weyftqeebjLWo8yYFs38?=
 =?us-ascii?Q?qZbtu8+cjh17l4110p5ep+7tKbVulYi+CV/dCE8tmRmKVqJMesEEocjZk0bF?=
 =?us-ascii?Q?/dIhhVQIx5Qob10Mg/mn9JwQSI4YNOEfVWR5n503UChnq71NfU3cGcZMS8rL?=
 =?us-ascii?Q?ilCb+D83h5OTcpUFIvV/FJA5NKBTEZlLBHu6FZp6rtrDC5861DtrKu31OJLV?=
 =?us-ascii?Q?c3DbviIQ5csjcrZAEVTb4iV1lri1qyzU5kjlF8cyVAB5EsSa0bFhVQCZMhFF?=
 =?us-ascii?Q?jVbgUffn2mmFCFFrFZO81ZBMS1qvuUlQKszggObJROZTAV/jWl62mi+pmgsr?=
 =?us-ascii?Q?UQK1LF3l4/Pnjh/rBMFVmY1D+4cgVp5DN+7ZDh2HwpQ4fCTOlK4xyiXw+lBI?=
 =?us-ascii?Q?gCNwvdxcXpOWoPuzVRbrVlOKh8NF0Sjp7h+Kk8TrZH9sFC/uVQ/KJv0098pK?=
 =?us-ascii?Q?jF5huGLe+iiR6gVEcdCU3Pb0C/bTVEENZ/ai2QMA82cB7OU7E23cvlNfAl9H?=
 =?us-ascii?Q?qrlYSm5cspm8PKC48rbIXrZ1R8D3/arSfV60ND/vAjWL41hcSzKi5NCZCNpH?=
 =?us-ascii?Q?O1OX/p4yBP0XwFlTRN3H6sGmdhTSELmMdCHzz+YNbKEj7EKT3zvgEhKkE458?=
 =?us-ascii?Q?L45PfkyVnE6bBn5c3WvaOyMPhQzxVi/P7Jl4hDGWQwIiXdh6PZg1Ssv9mg17?=
 =?us-ascii?Q?uFZnjqQ+PIR+sfgz9D+7BzhwFY5pgP+2f/7c2JJH3wnyrFwRDvinchkDBjFX?=
 =?us-ascii?Q?4yl+tyCwifb81VHnLbuCfaGhUY+A0db17hzE53rgjYZIpbWxIjQ9UV7hfdty?=
 =?us-ascii?Q?QL1enV1U/N/bojqEox7X2Z5lCPyd+yvI2ORlLKnvtIEeuS2t/nZ9yuzRnYla?=
 =?us-ascii?Q?8jQ9BOgeaWVGJ96+pYFkM0gJjJTzRCv3JqgG/qfVj430gPg8Jq1c1NDApb9/?=
 =?us-ascii?Q?ElcnImfc3EIfnfGQV9MhHA2IwkzA1xX6IMBHNEcKpqMeGra337JomTpht/1W?=
 =?us-ascii?Q?iNTbIEqd1Nho4B8LRZL0pPa4Hg8PKPJtjD4Ez6Vc2elEn/uXvmTy6vu9XToU?=
 =?us-ascii?Q?ugqaf6OJRaeXugUPdEhUzlNKLdcTmjr5lt2DoLF/1WVXZ+Ed14uTtcctUKSs?=
 =?us-ascii?Q?KpzvvK/yX0hNzX8ha1GdNa0c0gNndUqA1Pso+5xvlvy8HKXt63ahGfl5pXiE?=
 =?us-ascii?Q?MPCMtmfxrb0HXh9vu2qycTsYT0+wOTkg7UFmzbO5jlMh2hArFSkgn1N9Sr4o?=
 =?us-ascii?Q?hB75HWUqroYAbh9KpS08b4ZtZWULExY6R7N4ub0a62VV27y973wCkqnPSy6A?=
 =?us-ascii?Q?IdNhgZShnyyfxUGNRH67lvZ4vhfRm2TitQXvclBkCjMmOLKp41bEjwz+qNvO?=
 =?us-ascii?Q?MaSKZ2q72qfeXWb+VRe++0sMwRfNjGGH2CQ5USru4TuQK8pJnWXmHjOr0LXz?=
 =?us-ascii?Q?LlJGzqjqvz9CAqv24EObXzs/INrpC6WoW15UnKq+1jLMc35psiRjSyIognSM?=
 =?us-ascii?Q?K1Y9oeO6rK/bR6JaFTJSitSLCsNlgNWln1f7WDC0j8grvZV1746cXoYMd8ex?=
 =?us-ascii?Q?OIoLMK+SLVFLj6l6/I3iiQX4fmZ3jvRlwVsYV9dvyCm8gXqiq0f/yJuAGhFZ?=
 =?us-ascii?Q?YKcQfw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qyu78C2nPaEjGBPXfn/2I/lVMQup9neTsI0H9PtocixlEfyil9KqXMQPZeCa4N17Ex+qABxosvrqYhnXaNugeRTJnakL4zwzcfIFCQHkpttyD7LlWSGKiPae9fQRcXsb8n+ayYiIztvFPjutbGZBX/hvdhw04eXw+RS05SpfoO8K2QSqoYTIe3Pe+V/mqq4MjriC9OVfeqKaIWHhcH9KKwWkdHRX97HI0HOCYeILcUUbfsCRSav7EHF8VEtbwVapz4LYek0Y+Vw2QMe2Zsc+09e9R4me1xnCqRxLbXmP0Qbetszkes0arDhnd5mmwzgUgfemrFrhTnmHuboFckc8tv2VOWkalO3Nl/VqeOgCfp0c6LzVDCPeVSCTlPwuP9X6d+SiLHeKP+lnAK+1a/2iKTGzdxwpzS9gyID9mT9+a4zalxUWWzDGl/yt8ra1797e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 15:13:41.9815 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef807df-f1a6-4ed2-2546-08de6336d113
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4133
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

From: Nicholas Carbones <ncarbone@amd.com>

[Why]
DcGfxBase case was not accounted for in hubp program tiling functions,
causing tiling corruption on PNP.

[How]
Add handling for DcGfxBase so that tiling gets properly cleared.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Nicholas Carbones <ncarbone@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.c    | 35 +++++++++++--------
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.c    | 28 ++++++++-------
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.c    | 28 ++++++++-------
 3 files changed, 52 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
index e697d9bf1b44..78c866688c61 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
@@ -145,21 +145,26 @@ void hubp1_program_tiling(
 {
 	struct dcn10_hubp *hubp1 = TO_DCN10_HUBP(hubp);
 
-	ASSERT(info->gfxversion == DcGfxVersion9);
-
-	REG_UPDATE_6(DCSURF_ADDR_CONFIG,
-			NUM_PIPES, log_2(info->gfx9.num_pipes),
-			NUM_BANKS, log_2(info->gfx9.num_banks),
-			PIPE_INTERLEAVE, info->gfx9.pipe_interleave,
-			NUM_SE, log_2(info->gfx9.num_shader_engines),
-			NUM_RB_PER_SE, log_2(info->gfx9.num_rb_per_se),
-			MAX_COMPRESSED_FRAGS, log_2(info->gfx9.max_compressed_frags));
-
-	REG_UPDATE_4(DCSURF_TILING_CONFIG,
-			SW_MODE, info->gfx9.swizzle,
-			META_LINEAR, info->gfx9.meta_linear,
-			RB_ALIGNED, info->gfx9.rb_aligned,
-			PIPE_ALIGNED, info->gfx9.pipe_aligned);
+	ASSERT(info->gfxversion == DcGfxVersion9 || info->gfxversion == DcGfxBase);
+
+	if (info->gfxversion == DcGfxVersion9) {
+		REG_UPDATE_6(DCSURF_ADDR_CONFIG,
+				NUM_PIPES, log_2(info->gfx9.num_pipes),
+				NUM_BANKS, log_2(info->gfx9.num_banks),
+				PIPE_INTERLEAVE, info->gfx9.pipe_interleave,
+				NUM_SE, log_2(info->gfx9.num_shader_engines),
+				NUM_RB_PER_SE, log_2(info->gfx9.num_rb_per_se),
+				MAX_COMPRESSED_FRAGS, log_2(info->gfx9.max_compressed_frags));
+
+		REG_UPDATE_4(DCSURF_TILING_CONFIG,
+				SW_MODE, info->gfx9.swizzle,
+				META_LINEAR, info->gfx9.meta_linear,
+				RB_ALIGNED, info->gfx9.rb_aligned,
+				PIPE_ALIGNED, info->gfx9.pipe_aligned);
+	} else {
+		hubp1_clear_tiling(&hubp1->base);
+	}
+
 }
 
 void hubp1_program_size(
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
index 4715e60e812a..aaa8f8cf6c30 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
@@ -313,18 +313,22 @@ static void hubp2_program_tiling(
 	const struct dc_tiling_info *info,
 	const enum surface_pixel_format pixel_format)
 {
-	ASSERT(info->gfxversion == DcGfxVersion9);
-
-	REG_UPDATE_3(DCSURF_ADDR_CONFIG,
-			NUM_PIPES, log_2(info->gfx9.num_pipes),
-			PIPE_INTERLEAVE, info->gfx9.pipe_interleave,
-			MAX_COMPRESSED_FRAGS, log_2(info->gfx9.max_compressed_frags));
-
-	REG_UPDATE_4(DCSURF_TILING_CONFIG,
-			SW_MODE, info->gfx9.swizzle,
-			META_LINEAR, 0,
-			RB_ALIGNED, 0,
-			PIPE_ALIGNED, 0);
+	ASSERT(info->gfxversion == DcGfxVersion9 || info->gfxversion == DcGfxBase);
+
+	if (info->gfxversion == DcGfxVersion9) {
+		REG_UPDATE_3(DCSURF_ADDR_CONFIG,
+				NUM_PIPES, log_2(info->gfx9.num_pipes),
+				PIPE_INTERLEAVE, info->gfx9.pipe_interleave,
+				MAX_COMPRESSED_FRAGS, log_2(info->gfx9.max_compressed_frags));
+
+		REG_UPDATE_4(DCSURF_TILING_CONFIG,
+				SW_MODE, info->gfx9.swizzle,
+				META_LINEAR, 0,
+				RB_ALIGNED, 0,
+				PIPE_ALIGNED, 0);
+	} else {
+		hubp2_clear_tiling(&hubp2->base);
+	}
 }
 
 void hubp2_program_size(
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
index 207c2f86b7d7..2126830a5a9e 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
@@ -321,18 +321,22 @@ void hubp3_program_tiling(
 	const struct dc_tiling_info *info,
 	const enum surface_pixel_format pixel_format)
 {
-	ASSERT(info->gfxversion == DcGfxVersion9);
-
-	REG_UPDATE_4(DCSURF_ADDR_CONFIG,
-		NUM_PIPES, log_2(info->gfx9.num_pipes),
-		PIPE_INTERLEAVE, info->gfx9.pipe_interleave,
-		MAX_COMPRESSED_FRAGS, log_2(info->gfx9.max_compressed_frags),
-		NUM_PKRS, log_2(info->gfx9.num_pkrs));
-
-	REG_UPDATE_3(DCSURF_TILING_CONFIG,
-			SW_MODE, info->gfx9.swizzle,
-			META_LINEAR, info->gfx9.meta_linear,
-			PIPE_ALIGNED, info->gfx9.pipe_aligned);
+	ASSERT(info->gfxversion == DcGfxVersion9 || info->gfxversion == DcGfxBase);
+
+	if (info->gfxversion == DcGfxVersion9) {
+		REG_UPDATE_4(DCSURF_ADDR_CONFIG,
+			NUM_PIPES, log_2(info->gfx9.num_pipes),
+			PIPE_INTERLEAVE, info->gfx9.pipe_interleave,
+			MAX_COMPRESSED_FRAGS, log_2(info->gfx9.max_compressed_frags),
+			NUM_PKRS, log_2(info->gfx9.num_pkrs));
+
+		REG_UPDATE_3(DCSURF_TILING_CONFIG,
+				SW_MODE, info->gfx9.swizzle,
+				META_LINEAR, info->gfx9.meta_linear,
+				PIPE_ALIGNED, info->gfx9.pipe_aligned);
+	} else {
+		hubp3_clear_tiling(&hubp2->base);
+	}
 
 }
 
-- 
2.43.0


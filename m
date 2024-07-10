Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB0C6C3DA42
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:38:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80EEF10E8B2;
	Wed, 10 Jul 2024 19:38:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BXsZQZjn";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF0DF10E8B1
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:38:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mI0QowwmCOa7L9NVyGKTtSWNE5UQ8/yn3p7NhdrkQ5VNpWLdsaDZmlUHipD75wCapdBJXxbbJyG/mT1NETtHZ7dINPaHN5WqchdX452ljY6pVfh9xq70ecDaPaJyXQ08H7zjyn9omcREZ+l3D2v9BCMTk3k5Zd7fxyC1YKDuGFVcnZWYptm8rFLFgMygnImClq8vGNS3RZhWrqYbzvNm3tbTYPBiKSs2/HeFjU9gvfuHVOyVpdCLxyNsffXH/O6gYU029F2sRhNxvCiq4KXI+OMimehfsIIYom3g1CM+G8almmeCUOPThRMl9ZvJuS87fbMb1XpGk4r3gTVw2GZf2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dN7beNbzwTYXiywoRY9xAZefdqmLYuY+5zkZxpoDvtA=;
 b=QnQvtm90mW5UT5Q0H7tVSApGuMnBbhYsveV/pUjnqx5QAv0UjwbPxD0UODIr0QdmAF1RreJ271wbYYCukE4PoDXpOdxQRps205x/vJoPZoZmGuEnY1JZQb3ozIt0n/8vBdrtvZqA8bF8oea32BfV74RmeTmuEAuWFOuqgbeHlxyCunnDb+1lP76xQG51+jd96u5b7LdTr4m0DHnnWmqTP3F27X81ebjgrXMvfGQZkwT0Q2rxjLuk+hJwrWKMcGkhw2fHqE/rxqG2D6GG9K8pMmcwvGzN19kzVzyTy72xYhpBaz31xuNgaFGZz8j2LHl3Hs9qV04xA9mnMo2VURSLeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dN7beNbzwTYXiywoRY9xAZefdqmLYuY+5zkZxpoDvtA=;
 b=BXsZQZjnzF1leWNE1Mvlhm/s+03fEL3wawOsWIcr8TDlCgvs18ZIpb6NNDl9GjkxiVf8pBoFYQmm1P+h1ScAMth2H/5BJHREey0uMM4Ve41nAs+F5dkyxADIURgqbgb4l4nziCbeO5S1YK25mez21b/ORp7MAuTqh65SHtwuVy8=
Received: from MN0PR04CA0029.namprd04.prod.outlook.com (2603:10b6:208:52d::34)
 by CYYPR12MB8871.namprd12.prod.outlook.com (2603:10b6:930:c2::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 19:38:49 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:52d:cafe::f9) by MN0PR04CA0029.outlook.office365.com
 (2603:10b6:208:52d::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Wed, 10 Jul 2024 19:38:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 19:38:49 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:38:48 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:38:48 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 14:38:42 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>
Subject: [PATCH 20/50] drm/amd/display: Pass non-null to
 dcn20_validate_apply_pipe_split_flags
Date: Wed, 10 Jul 2024 15:36:37 -0400
Message-ID: <20240710193707.43754-21-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710193707.43754-1-Jerry.Zuo@amd.com>
References: <20240710193707.43754-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|CYYPR12MB8871:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ac19e8f-040e-43b5-9d00-08dca117ec00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AOBRh2aGD4F5EzZzeyDop9nbhZUEU2ewjwcWR+WFoCTJtsVa9tgVEqzD/vAc?=
 =?us-ascii?Q?NSDuTAXiQ1ywVuYadHsjXup32iNVn7zxSr/HPgwJmLcOzO+SOkXFKj6PnW42?=
 =?us-ascii?Q?dm10zkrPUBPDYoAWsuxZQKyHaCFRmlo6BTdOd/MG8tHMC4p0MhvvMI3xClbs?=
 =?us-ascii?Q?aD6D2izWSe4ZSKwrhlTzWc+yycvGY0fDZzOD5aGSi3GQ8P67sW3LbRGH5dYN?=
 =?us-ascii?Q?g4FkRg/QQWvnA82I6D+TdIz4Z8PJbxRZnCH85tTMfgOGOlFKuHuWptpY0Wdw?=
 =?us-ascii?Q?RxqvtDgfhMiCoAUuHgbcCoFNzj9kd5hNQaZLIVhLG5S/B3Bn5vmDqTvzHQD2?=
 =?us-ascii?Q?bo1LVYJcURSLnz5ytB6M4BhdIf0mhi3ibDINknitRnvcKvQ1rM2WhjJpmsli?=
 =?us-ascii?Q?+MlF1zMkTD0kiYcCOJ9DbKujW8ZU6PxlG82j2x8Vls1oFr7TVKWZcOLbhGAv?=
 =?us-ascii?Q?cWDa3OrsxnsTPYJLQx+vzqBnbgnQKKQxytsYlsAZZ1T3KVF+GsmWT+FqTwsi?=
 =?us-ascii?Q?51FOLLDenof8YoNAdksCwnFPRZ0QWzXHOUsdjb01PkDUzaM1ktY7yGdMCBvk?=
 =?us-ascii?Q?eXGyWeCtrJaRDXuitBc28RLXMOlZDIai6LS/7m4vKENelrjlHzvMECVnEEbf?=
 =?us-ascii?Q?H+oqDoLfcoSzhRn/hLpB1a8kuxHlvHdQ1UfSrDW86xLzquoC8FciF9XMoR7O?=
 =?us-ascii?Q?osn0dupAkwIp9T6zOBpSIqYJ5kdrTXMbDXQasG94XOzLCYfV04V7yuHAZKGW?=
 =?us-ascii?Q?vHhcQ7JMdVvk5j7XsBEMldHl8wUynQieo7OgZQ5fNjtmFK73p+d8mTZGAOnc?=
 =?us-ascii?Q?iBBzsNGtos6HGthOTMpBJPXTjaMx1PDqsTkkNIn4R+JDD+bfjyYnLetonAdP?=
 =?us-ascii?Q?FbCoyP/Og/oofnQGFOueBr5hq3BUb1T2jmrDWGfwaFj2dGMqIiVRnBskUumx?=
 =?us-ascii?Q?bvbAByCmMewEAM9C9DTBZ2xgSYy9B98K4drrcdfq19wlTadCYqw2dzGH+W2C?=
 =?us-ascii?Q?yEwvQtwqxGtmNfshlZz1tXbqPgqhaUTfdH6dD92xrr/VUFB6AbDIe3MZApKZ?=
 =?us-ascii?Q?0JJdj34GcSQPPEU8rYziivvAwV8wE8bAQ4jkva2s/KCF1BMvJxGYK44PqXHA?=
 =?us-ascii?Q?DjYdg/Gw6hJg2uVEjNBYFu2VlI/+C17nGFxqxBteJMK+i1qQpm138u0EGkNu?=
 =?us-ascii?Q?CtZHQwZhVchf5rhLXWmwPeO+tmizZz3UgouAoc7sjMuvKVMkwZq5FHE8Frh5?=
 =?us-ascii?Q?72pHZUCzOKr3NZau43FpWeDCBTPQt0KLn1KRiMzXwU0SshVWnIbPyi3xUA1w?=
 =?us-ascii?Q?dlFROie5WBmAYa/f1fKVw9tHDUs78/CWqgRLzLUV1RFZa0DOGDqdjeabxl8Q?=
 =?us-ascii?Q?ON28KvQW+j3o+0BxJX0t9GlW3qUtnX0IfxI4wRH0CpxBjCs9PKjoDYB5CqDz?=
 =?us-ascii?Q?pyBa/K0RAshkZt3iIJcMio0Nz6R4pbdz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:38:49.3675 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac19e8f-040e-43b5-9d00-08dca117ec00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8871
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

From: Alex Hung <alex.hung@amd.com>

[WHAT & HOW]
"dcn20_validate_apply_pipe_split_flags" dereferences merge, and thus it
cannot be a null pointer. Let's pass a valid pointer to avoid null
dereference.

This fixes 2 FORWARD_NULL issues reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c | 3 ++-
 drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
index 5e7cfa8e8ec9..eea2b3b307cd 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
@@ -2040,6 +2040,7 @@ bool dcn20_fast_validate_bw(
 {
 	bool out = false;
 	int split[MAX_PIPES] = { 0 };
+	bool merge[MAX_PIPES] = { false };
 	int pipe_cnt, i, pipe_idx, vlevel;
 
 	ASSERT(pipes);
@@ -2064,7 +2065,7 @@ bool dcn20_fast_validate_bw(
 	if (vlevel > context->bw_ctx.dml.soc.num_states)
 		goto validate_fail;
 
-	vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split, NULL);
+	vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split, merge);
 
 	/*initialize pipe_just_split_from to invalid idx*/
 	for (i = 0; i < MAX_PIPES; i++)
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
index 8663cbc3d1cf..347e6aaea582 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
@@ -774,6 +774,7 @@ bool dcn21_fast_validate_bw(struct dc *dc,
 {
 	bool out = false;
 	int split[MAX_PIPES] = { 0 };
+	bool merge[MAX_PIPES] = { false };
 	int pipe_cnt, i, pipe_idx, vlevel;
 
 	ASSERT(pipes);
@@ -816,7 +817,7 @@ bool dcn21_fast_validate_bw(struct dc *dc,
 			goto validate_fail;
 	}
 
-	vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split, NULL);
+	vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split, merge);
 
 	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
-- 
2.34.1


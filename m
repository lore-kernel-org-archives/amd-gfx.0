Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1BAC52D6F
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Aug 2024 22:04:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE92610E707;
	Wed, 21 Aug 2024 22:04:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yooWnilF";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B0F510E6FE
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 22:04:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RkZkfnTh1pupTM9u5v5QYOVvEuRmLOPBqWyuZ+MrFY2517HW9FpcRaV41ZHvIC0+P4/FsOJeZ/CbQOrFIMPTbZDmkiOr+Fd3b9I6QWiSsg6n0f4wCjzYcEyEO7wUnvbyERQPeyZ4DO36B8yil9/vh32rXZf4c5qI0+dB+pvODPx2MP9hkR+f90Yey36V2MlQSL+1xrRAEP6IsO4JbIVyOP3Ssh04aSqpDu0P5ibzIIBkEjPSEZAvtgyWAbF4Fa2uTrqgDMgRpX6m0mPkZ9zdqbagoKChQBALsisggg7KPAytbrduvvV5iUdRsFJ15QDtMcbGecH5mG1UBPeu7fSknA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gh+HfDuHFOE9XIRMGmPvXJUKDNH3jndDLwYnQzR/KcA=;
 b=WTFdLMqVb8JpTnuDeoAqQ/6wI0DnXNfKHpoV3lsREkwVLmRSi049/YGlHCht7ftMuAViXokUhpDORLj4AnKhVljwHBgNEzc3fsJDGjQu7Kjf8wRihKtZqUbIwlFkUxwj9E85cGR5w9npKxuYDbaqPMQz1r7dOsG+Yh4tdVT0aEMcaK2i+h1EIL7fg8qVe+JeDJyC+Bf+zr6v5yylKM6xEn7GQQ+yLpx8Jk34opzLN7Uw7w5FSMyqe9AJFyLDYGRLhklvYjrYyvLw8I6jCLLM87Tk321b9PhPA9AfHHnhptlwNZNT2AzGOYxWuA+LigrFTX5qW8e2MkQ/letjMeS/eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gh+HfDuHFOE9XIRMGmPvXJUKDNH3jndDLwYnQzR/KcA=;
 b=yooWnilFlg3Mit2NjPfOnM+pqKiw8IWcSIzZOFcgj3qHyJqriSOStKSEllxtMcnT+D0RPnYPEHwlh8SHI1orCjt02OtUwyYJLTt0YQAxVQ32U4xwZ4bfvN72HzZIwf/E1k+k8Zm4YTTV+0pb0X+vPe2A7nPppGOQNOUfgOLlMEU=
Received: from MN2PR05CA0003.namprd05.prod.outlook.com (2603:10b6:208:c0::16)
 by BL3PR12MB6380.namprd12.prod.outlook.com (2603:10b6:208:38d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 22:04:41 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:c0:cafe::74) by MN2PR05CA0003.outlook.office365.com
 (2603:10b6:208:c0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16 via Frontend
 Transport; Wed, 21 Aug 2024 22:04:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 22:04:41 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 Aug
 2024 17:04:39 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Sung joon Kim <sungjoon.kim@amd.com>
Subject: [PATCH 07/16] drm/amd/display: Allocate DCN35 clock table transfer
 buffers in GART
Date: Wed, 21 Aug 2024 18:01:49 -0400
Message-ID: <20240821220156.1498549-8-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821220156.1498549-1-zaeem.mohamed@amd.com>
References: <20240821220156.1498549-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|BL3PR12MB6380:EE_
X-MS-Office365-Filtering-Correlation-Id: ce2b43f0-d702-492b-c5b4-08dcc22d41e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4f1DkKJbkcQmJTOVGAMD4jqihpJGe849T9kvvU7fpZtsosTIvyAu5IqHejEG?=
 =?us-ascii?Q?/xUiyloWG4mlZ8e2mhMuCAqQHWmAI4GRnp7TbXlHMA7KvlFdRQETmedB7O8n?=
 =?us-ascii?Q?HlCxxofWbnTZy3YK/FbVLGuMZCMbzJBn8Nf8YXtwWyvrIM8vvrUdli84yFJP?=
 =?us-ascii?Q?J/w/6a3ozEq64OdJCYWGkXcRUBpHWELuqH9DRHYbDCjYpIBQm69xB/HGb0xe?=
 =?us-ascii?Q?/PCb16qXfLou0DR9OZcWpoHQnagpr237dZV28mFaQk69Lhr5rmYiqcbgSP8N?=
 =?us-ascii?Q?4o48bu6A1SUn/qc+1tRxmzZtA1wyo3BYlEkxgFweR3kkBbEcBMDk7MkBDtVx?=
 =?us-ascii?Q?SrLODiKnJmLPwSm/u3BWpGPIpcj2zX4HCUGMAdy/7BxqTgdCmwoRSSmGexTv?=
 =?us-ascii?Q?K7eBr4x5VW+nMPUSNyCks2W68/rg/hh+EI9KQ5ms8KlXXFaqoGfCiluZOZQv?=
 =?us-ascii?Q?NmyS/l8FuhCAsoEMAgdzoYlCMs7FQs3eQJWCBJXwcPO8PZuIA/j7+Vh3NWbb?=
 =?us-ascii?Q?fhcsKMd83IIweCo9WC604n/00CDaop7i6b5OLA82r2TF8WhlIJ/7th7DNN6e?=
 =?us-ascii?Q?I1JqeWEwpWI8CL3O95aZdoiIsaHn980SQ9HtjPNcNTTvUQAAAzqg3AimDsTw?=
 =?us-ascii?Q?BnuR1uNN9Ernato613z5OoReb3RbVd70i+y53XVesTXPue2f6IBpyKOi5u9n?=
 =?us-ascii?Q?B9FbloQOVgsqqbvRU+Mr0IN0OM8iWIy4Oy4bGK3rvULduyWCAcLzRKHk89ax?=
 =?us-ascii?Q?xt2PPiVNAA2Uvqsdqd8DlL/uj6F7zH3QPJUxosLG++Gojdvd8r5WYLRKciyi?=
 =?us-ascii?Q?cZLiIHMlvME4CaForvT0vAxI37o2ry/EbPSR14aeoYLPeIrKllrsiVkjkOmp?=
 =?us-ascii?Q?lKticUG2GP+R8AFjhW5nfiBWD0OJEEooOBio4OjLVNTqMxUDtc2dCxYGJ2JX?=
 =?us-ascii?Q?EnZkD1r3YsCPfG9CVXtCMJ9Wlg869f4iWyjREr1Ylm2ut9TBGaAL51NHc8/l?=
 =?us-ascii?Q?eMynJpng3Q9vmm4t2pmxLBukz865tKowvjOeNTtoqh1E2Ei3SkSxKHFla6fA?=
 =?us-ascii?Q?b1Dm4UISCTGag4uhXBSi5MN5KodBf08uLZARCOCrXZ3EtNCXVRS7ct3cU/gi?=
 =?us-ascii?Q?nCZExu29OWeUJ1mzGngLxbIc7ofr5QSlyBsW6OaZtRKp1l/bgc1fNNf4fJfx?=
 =?us-ascii?Q?V8l2nDdy4GmqiRpIOAqFnmGQJoQKP72hnD+TsuD61XNRSmwp4kmcw/67dHmj?=
 =?us-ascii?Q?Ag45bULETWwfflhl0InPCn91ldSPcji/5YlcRXM8OwOw5puXNRszLUO/mBxh?=
 =?us-ascii?Q?DqLmKro/TChgGqmwR0bZgi58P76KTlF7N4OoapfETt8g9ZgirDMMjpsM2o6h?=
 =?us-ascii?Q?NqaicRlXjwFo3nbq+ltMQZbh+GNli654o7X0xOdFsN+VMWzlqA9dgvlwZ3yr?=
 =?us-ascii?Q?CAQhoRzXNeZXJrl1L2miMPwk3GHsat08?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 22:04:41.3946 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce2b43f0-d702-492b-c5b4-08dcc22d41e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6380
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
Request from PMFW to use GART for clock table transfer tables as
framebuffer is being deprecated on APU.

[How]
Switch over to GART via the allocation flag.

Reviewed-by: Sung joon Kim <sungjoon.kim@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c    | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 0ce9b40dfc68..f50054089da7 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -1100,7 +1100,7 @@ void dcn35_clk_mgr_construct(
 
 	clk_mgr->smu_wm_set.wm_set = (struct dcn35_watermarks *)dm_helpers_allocate_gpu_mem(
 				clk_mgr->base.base.ctx,
-				DC_MEM_ALLOC_TYPE_FRAME_BUFFER,
+				DC_MEM_ALLOC_TYPE_GART,
 				sizeof(struct dcn35_watermarks),
 				&clk_mgr->smu_wm_set.mc_address.quad_part);
 
@@ -1112,7 +1112,7 @@ void dcn35_clk_mgr_construct(
 
 	smu_dpm_clks.dpm_clks = (DpmClocks_t_dcn35 *)dm_helpers_allocate_gpu_mem(
 				clk_mgr->base.base.ctx,
-				DC_MEM_ALLOC_TYPE_FRAME_BUFFER,
+				DC_MEM_ALLOC_TYPE_GART,
 				sizeof(DpmClocks_t_dcn35),
 				&smu_dpm_clks.mc_address.quad_part);
 
@@ -1209,7 +1209,7 @@ void dcn35_clk_mgr_construct(
 	}
 
 	if (smu_dpm_clks.dpm_clks && smu_dpm_clks.mc_address.quad_part != 0)
-		dm_helpers_free_gpu_mem(clk_mgr->base.base.ctx, DC_MEM_ALLOC_TYPE_FRAME_BUFFER,
+		dm_helpers_free_gpu_mem(clk_mgr->base.base.ctx, DC_MEM_ALLOC_TYPE_GART,
 				smu_dpm_clks.dpm_clks);
 
 	if (ctx->dc->config.disable_ips != DMUB_IPS_DISABLE_ALL) {
-- 
2.34.1


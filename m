Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1BACC04FFE
	for <amd-gfx@archiver.kernel.org>; Wed,  8 May 2024 17:15:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57B52113110;
	Wed,  8 May 2024 17:15:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0imEynHk";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2054.outbound.protection.outlook.com [40.107.101.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D15B113117
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 May 2024 17:15:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LEBnoeGJfBY+kbIyM8BBEl/QCrSKHSbRfxDq0NALEEGxtoIgZMHix6qKu2dX0bcImrhpF3yYlBjCDGq0gy1O7nzd+EadEc+AniZpCYs2W1Dc3twBzWqeWIk9NoJrWrjyJLJO+/7/IDl0vJQs3UcGULLQYmY+TY6GvMjzB9vnRHY2zDr/7Z3va81azAzwuvy1QilqhWRsL3v4nuzAXJjuD2ZIo+0wmxm3dre8bOGHou+txKmGDJFBNhD1WHWdh4A7CZgcognbKMRs++tVl8+ZyUxwrRmTPdSh2cBr+zq4kGZ7kRE9gLYsS3A9yezwx2Ceo3BjbQ6hQju0Ov6lcgEUZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5JXA3GINLOyTgzFJLHVLYLjUnQp6NIjVIctD1nyIgE=;
 b=f/DmXA/sYFVEcw15zLXLrsiUUUNz7nuqGwH6grFrvUoZKXl/OiUjrMQNGM1XDIknHCb/PLIwz8OnOEOxBDDTIhWgAaXN29qNf2dsWMYCZiAUm280tNRuBtRKQ57Yc1u5GOYNKJtL6UlhFmKqS9OoOIK0tLlqaYKIw0aCoBC74QezvBpBFX8K2g+DcTXaYu6duetsRcGzKjNTGmU53L8yLh7D8cHLTO8Yz9XbKRsS1OhQiTxdphmxgP73KEAAnWjAca/vpmK4pN2Et3bRmy1xB1iBMgMfDZ0c1ac1M/6bmb7/HcJ5sOewJ5uUNxX7Xss7dkX6BsN6Zq0Q/yyLQamxLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5JXA3GINLOyTgzFJLHVLYLjUnQp6NIjVIctD1nyIgE=;
 b=0imEynHk5EQz/y1r6Yc535HGdi1SzIRmvade1FzBLEkGROTRb8Se7Y5FNp6uDC62wEdujbHRY0Y0Fcb5mjnBYFLN02RxteIIwEVjtzL+3Hz4hyObKmFt00ZG3x2vpYVE70z+rUOT/4NoB21ObhBSReuEGPNcZc58PRI8HMgoFQ8=
Received: from BLAPR03CA0066.namprd03.prod.outlook.com (2603:10b6:208:329::11)
 by MW4PR12MB6875.namprd12.prod.outlook.com (2603:10b6:303:209::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Wed, 8 May
 2024 17:15:48 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:208:329:cafe::80) by BLAPR03CA0066.outlook.office365.com
 (2603:10b6:208:329::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46 via Frontend
 Transport; Wed, 8 May 2024 17:15:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 17:15:43 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 8 May
 2024 12:15:39 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 03/20] drm/amd/display: Remove unused code for some dc files
Date: Wed, 8 May 2024 11:13:03 -0600
Message-ID: <20240508171320.3292065-4-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508171320.3292065-1-alex.hung@amd.com>
References: <20240508171320.3292065-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|MW4PR12MB6875:EE_
X-MS-Office365-Filtering-Correlation-Id: fe6db557-d343-4c54-e99f-08dc6f827e3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hBGA0aseJqP6KKs1r3a/J5hvw5/TYgcvcmaE9B93SgFbzR835IRMFMSPoKqc?=
 =?us-ascii?Q?0Q76XQX4JJcYKO0d01lOXY7gvitxTRfqiyDjPNbIbZlvP70oligIcfr/djNs?=
 =?us-ascii?Q?1idu1/JTkBPo7ALm2L2o59IPcqlryIZxMGaryqiKL4Yk3Y4/LryrAdnrzSED?=
 =?us-ascii?Q?isaQU6WnD1c/8WdFtS/3zu7oU1K7eNEJg3T/azK6VG1N3KCPRQVPTCUfOLv4?=
 =?us-ascii?Q?Hs5X1wTzHnKreHhwwALpWMddn1+dFWDgP8AXqmbJx2XIsF++EuWMhLV5qDRv?=
 =?us-ascii?Q?xLY9/ujLxlkMVsZV4UkazpJdcBr5o1QW6751p6/D2rD3sVlnBgzH3rK3E52b?=
 =?us-ascii?Q?ceqxM/Pe7szIdJc9I6z1bfGS/xShn0O+7ZaLR/35xGTg8WtyBgELdBuSIxn/?=
 =?us-ascii?Q?O0I2/otPjrOAkgmhkaUG53P8dsGri6BQNja2i/DxcyCE1fbJu7ZAUhV32S6n?=
 =?us-ascii?Q?x1AXWebiEDhOahEXECwJFNzXDhBelMVImink7533PbQFM0KCeXk0UoAuYcIX?=
 =?us-ascii?Q?Uq7jxatD7Z+Li+AVT9EVKNGvAArGTyU1z6TOw5mtK8W2VL5X1dxKilKhsj+M?=
 =?us-ascii?Q?KZsFQ9e4WXVyhGO7vtJkUowGEcpEG7BiaMMYdYR9Qb47xbKbfN06p9f1+6B7?=
 =?us-ascii?Q?5QgdWBlErBPx9yaEYounNv80uNuIyPYTzmNY11fPLSxDrUDFoRz/Y8fWiok6?=
 =?us-ascii?Q?FpsTiul6jxvizMt5Og8v2rTJKC+t4cavXbm53iVVFl1vS9hTHyDTiqys7n0U?=
 =?us-ascii?Q?8PVwNcDlKKCQZkc5NZrhYL+z8M/D+zSoRyOBXxJgsaP0wQc3H9VsiZu6M6JQ?=
 =?us-ascii?Q?lw5wu2mjqXuDZaHjc/L4didVp5ofeOxmKtUZ1wbnDrlKsurN6uXZW+89Cp6Z?=
 =?us-ascii?Q?64qklklpg5LiZ71Q5HnAclv5UP30YV6uX63YRebKp8eqWu1k988Z7gigcBOl?=
 =?us-ascii?Q?29RqDlTFHZAfcowOCqeDS+T0bTPN3R/1D+qPyU7ocB5BNkM8QPerzuYKp4/y?=
 =?us-ascii?Q?ARzWUYITvfOR54nzhLR0GiHVgjoaH6G+GB1pNKDHdRAmUrj78GABF2rAn/C4?=
 =?us-ascii?Q?9jRp8Bx4v+CV4yBIFYYKMdnUCgnkBRnLM4taynLpQPGKzu6Gg/t3q3ymOj0W?=
 =?us-ascii?Q?fdtCn4NqKLPIjVr/NMn/hHFQ4vWCd9SfnGgSsQtHVz0VrJWmp4gml4jdDfKd?=
 =?us-ascii?Q?CtVGAzQD4ARw+/WvikJr9T6ld8qGuxuTddP7eUIbJo1x+jhMrvYCNpr2xfXr?=
 =?us-ascii?Q?chI6502FEZJD1Y5FQ/4ory4o3PAeh0KbrwFhalgCB+rZGzSFhSvQw5dwcRSJ?=
 =?us-ascii?Q?rwiJ/RGJMF+DD6s0Blx2wdvm6WHhN4BFAjPaISyfx00BxSaTfAtHhKHeq2vu?=
 =?us-ascii?Q?7Ulavng=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 17:15:43.3873 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe6db557-d343-4c54-e99f-08dc6f827e3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6875
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

Cleanup unused code in DC.

Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c         | 9 ---------
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h     | 3 ---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h | 4 ----
 3 files changed, 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index d19c67205de6..0f20a3d96d93 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3614,9 +3614,6 @@ static void commit_plane_for_stream_offload_fams2_flip(struct dc *dc,
 	for (i = 0; i < surface_count; i++) {
 		struct dc_plane_state *plane_state = srf_updates[i].surface;
 
-		/* set offload flag so driver does not program address */
-		plane_state->address.offload_flip = true;
-
 		for (j = 0; j < dc->res_pool->pipe_count; j++) {
 			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
 
@@ -3638,12 +3635,6 @@ static void commit_plane_for_stream_offload_fams2_flip(struct dc *dc,
 				stream,
 				srf_updates,
 				surface_count);
-
-	/* reset offload flip flag */
-	for (i = 0; i < surface_count; i++) {
-		struct dc_plane_state *plane_state = srf_updates[i].surface;
-		plane_state->address.offload_flip = false;
-	}
 }
 
 static void commit_planes_for_stream_fast(struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index 226285037b2b..959ae0df1e56 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -125,9 +125,6 @@ struct dc_plane_address {
 	union large_integer page_table_base;
 
 	uint8_t vmid;
-	/* dc should use hw flip queue rather than directly programming the surface address.
-	 * Value is determined on each flip. */
-	bool offload_flip;
 };
 
 struct dc_size {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h
index 54f889cfd911..ce93003dae01 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h
@@ -1091,10 +1091,6 @@ void mpc3_power_on_ogam_lut(
 
 void mpc3_init_mpcc(struct mpcc *mpcc, int mpcc_inst);
 
-void mpc3_mpc_init_single_inst(
-	struct mpc *mpc,
-	unsigned int mpcc_id);
-
 enum dc_lut_mode mpc3_get_ogam_current(
 	struct mpc *mpc,
 	int mpcc_id);
-- 
2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 183A4CD1294
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Apr 2024 19:51:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5751F112E83;
	Wed,  3 Apr 2024 19:51:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E9fldNoq";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2084.outbound.protection.outlook.com [40.107.212.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98EDC112E82
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Apr 2024 19:51:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CpYDy/8MgeE7xWwu6QyHZltqSP6im6VCd25Mz9JQ5hbwlOUYiHc4dTFEyWsl47E0ohUNBPI6ncbCFg4LIaPPI2/aIF9L9tKUEyVeAR42pyfnNbd/GzSLRu/IXWMN2GGDymZN7VHmFeFiuPJ0Qq/Lrrf0jwH3/5eY33xPkKK2jpcwjvQOp+KX1pQxTlThN7M14fQYQVTzJs6f4y/mStiwBAl7Mpl/9FQmp5hjupfw/6ridzlgNt6EmOFoigGSrkUL4VOXlGgqSG+LUW9cdN0GSIWVPev6q63+W0Bjk8P9YPh9t/0L6qBybrrwggjnzih9EWzxJMW4GUF2WE2BeIYJdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLgUeC37nZt+qj8KT1MwCaveXHDjBso0pLPkGM2FqbU=;
 b=TKNzDLwKF/mi4A/+VL3LtdcFNQkEYW0wWdtiw2FDfC1w4rICncAlgd14fnx//lIvZR9fIKsSH6Bkag+B0vlcnRBH8PYh/V+xi3LdZXdBWKTUM+QW/M/zf1L0mtMdOrxXU11Mf8fWH391lnLN7x3XbjbbxCdSOrRp4+NGRugjw5hIxowJNVlXOT13rt8P0FMbRgnX7ORs5XT3Rd6Y+Kw173sTACcq7w+f80nvX47FpYTKre1VeOOecHU/gWXYLxJ2w/eDxRkbezzH/lKhrq60fjmSntWaiD3rv2e4BS5KyVx3vdkB33U/GD6kK/Bp/yK41bwCPT3vIALpTer9vL+sfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLgUeC37nZt+qj8KT1MwCaveXHDjBso0pLPkGM2FqbU=;
 b=E9fldNoq4SlPgIfbaslW/SLzcfy8KYSB8EBvv+Ut+cej5VTj1NANAbsX/tuxCWAsKgA8ENrJwQBR6YfyhF3Kb/ds+SnVr1S2ZswvxYLWxiXDAdbcKl7D7eOvhLWe3ZdAD+TZH79gs3YwELs6VHJ5Jo4tBWT036+JAkqMFaqy+JY=
Received: from CH2PR07CA0011.namprd07.prod.outlook.com (2603:10b6:610:20::24)
 by PH7PR12MB7889.namprd12.prod.outlook.com (2603:10b6:510:27f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 19:51:50 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::c7) by CH2PR07CA0011.outlook.office365.com
 (2603:10b6:610:20::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Wed, 3 Apr 2024 19:51:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 3 Apr 2024 19:51:49 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 3 Apr
 2024 14:51:43 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, George Shen
 <george.shen@amd.com>, Nevenko Stupar <nevenko.stupar@amd.com>, "Chaitanya
 Dhere" <chaitanya.dhere@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH 14/28] drm/amd/display: Rebuild test pattern params for
 DP_TEST_PATTERN_VIDEO_MODE
Date: Wed, 3 Apr 2024 15:49:04 -0400
Message-ID: <20240403195116.25221-15-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403195116.25221-1-hamza.mahfooz@amd.com>
References: <20240403195116.25221-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|PH7PR12MB7889:EE_
X-MS-Office365-Filtering-Correlation-Id: 3273ff4d-e6f2-4082-54dc-08dc541780a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JkhNzDMQRE1vjT02TCV5S9dRO2zlL0XT8vJ12EVakgrs09RJQsQ9HQpeBGixEH7HtYyJfPO20Q8loSEsLUOET3XzNuymGP9m4VBf2KV6hunCB5gTN+0tQn9mMzjx2u4qn5mfMpjFX42uuD4ERJ/inpUegmUZsKN1huSUQtzn9UOf3NPTAbBDtgcr85JIW2av8PiXlTaGeTh8UG4CnYpJxyEAQ/P4kr11Bo5mrosBB9p27kde+Bk1Yjg+KOB2JBtm+TjRaT6PDcU0gKm0wi/L1gadnTYfskZ1t+xV+sd4fCV6etyvBKrGU4cSHMGXssvuiqNkc3Ib2gOwlC9l6u+78eaRlouyy6eDCQnJQtDSZinlDL3ME3he7KUuPLVxAEsg0oMyYOKBc+Sa69GXLIMmn+Sqd5kEteLwF2KCCnYeTsrUS4DRYM80cCmzSO/zB903PdLDA2nuvu+9fNtmCGHH6yeSqxTZXwJiMOb0WF/n3jXshEb0MpKRNa/BS2IZxfCLVSqhbPVxE9LNZaGXKe379ojxVOqxZLisVqzXjDMcIFxb5Dd3iMBNDfmV0Qxxl+5TySOm7jT41iHQjZ5fKbxv1690F82ly9jSqeSG29L7/hC+ABCwetco81RNc/pXTiEkI0DaCUaAWFkUKARjQuTPpYeDgcadbh6/ISGOEzd+SkGAVNjXV7WrMxOWj9ujRc/ZKYaxPLJtvVwO+9Cot1wXx3V1wGpEiV+bDYpexOZfengWtps8ojN7XxOukFuLl8mb
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 19:51:49.8573 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3273ff4d-e6f2-4082-54dc-08dc541780a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7889
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

From: George Shen <george.shen@amd.com>

[Why]
For video mode test pattern (i.e. test pattern disable), the call to
rebuild test pattern params for the pipe is skipped. This causes
dynamic disablement of test pattern to not work, as the
test_pattern_params of the pipe will not be updated and retain the
values of the previously enabled test pattern.

[How]
Rebuild test pattern params even when test pattern is video mode,
allowing the pipe to have updated test_pattern_params values.

Reviewed-by: Nevenko Stupar <nevenko.stupar@amd.com>
Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c    | 4 ++--
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index d48a181d2249..2633e481234f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2329,8 +2329,8 @@ static bool update_pipe_params_after_odm_slice_count_change(
 	if (pool->funcs->build_pipe_pix_clk_params)
 		pool->funcs->build_pipe_pix_clk_params(otg_master);
 
-	if (otg_master->stream->test_pattern.type != DP_TEST_PATTERN_VIDEO_MODE)
-		resource_build_test_pattern_params(&context->res_ctx, otg_master);
+	resource_build_test_pattern_params(&context->res_ctx, otg_master);
+
 	return result;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 9e6498d2439d..5be976fa44f9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -2120,7 +2120,7 @@ static bool dcn32_apply_merge_split_flags_helper(
 			struct pipe_ctx *otg_master = resource_get_otg_master_for_stream(&context->res_ctx,
 					context->streams[i]);
 
-			if (otg_master && otg_master->stream->test_pattern.type != DP_TEST_PATTERN_VIDEO_MODE)
+			if (otg_master)
 				resource_build_test_pattern_params(&context->res_ctx, otg_master);
 		}
 	}
-- 
2.44.0


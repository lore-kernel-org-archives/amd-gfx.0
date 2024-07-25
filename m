Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C75BDC3DA49
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 18:04:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E14410E8BB;
	Thu, 25 Jul 2024 18:04:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e6tSbTPW";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2077.outbound.protection.outlook.com [40.107.212.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B9C410E8BB
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 18:04:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iAiDieWpinfzhPQnWmKsBdNF8np7kULy7AKUxyZJjquk24NdLiEV0N4w/HP0qBTZsTnK0ZL6nq4lVSAIdFc/fZWlAmksu+YkU5vCj94JnqNILm8PmIWC3JU2chCdf+BDN11Raq9Bsoy6OcQ7AAM25CGBuQdwmISJ/9JsnWCKo0IZSy1JDV5l7382ByNLcCe0/8TLq5VeWbxBUp80kMizoLOqjYYO0IPbj1xg+XuNKzna2GuK26qE8Rj+pHPrcDcje3TZvNc31TmS64lcisSg0G1YqjWwPqfGcy6NN/NMpkKgwtuH1E/3SLiTynYesg3VSNlnulRZy0SqIv09zzL5Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/hzVRB2ktlZfPTfWpidInS0ODOsFbPgF+hlgTtYnts=;
 b=fD0nQ2EqLQpB3ff3bJruo4tashw11725MprtYqSXcd4VL1EIJHzYBAeDFRKGtGrXXwFByYklTLhkgVqUiBDXlO8Q5V48KGw2W1QZw7jY+oedceB0b1RBMgx/sSyDWH72HDVI4xVKr37jAUZ3W7n9xGWXVL33DLUoanu52XbfIglCqm8nGwbFNWgjcV3BjyOkFTb7Nmbg2p4Ic53IMXca19AISX3/gVxE4QvvmYYvTiXZHGMInARfX1Ig867Js4NLXy3Jg8SRRyVmjTYIDbQDOpKlH5g12A+Y6ncPrFKcJTj3eb73Sq1mDa/uZlDqkQctGcq7cctXFV5vXhKATMSntw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/hzVRB2ktlZfPTfWpidInS0ODOsFbPgF+hlgTtYnts=;
 b=e6tSbTPW8C8CQMU7GLapAtBoNh8QZfFMcj5ilg3Y3v5gSPWCwDJtUs7kwTk/LHxcnPLGV2+zw+dEshirvQN9FnTcUQWkd201K/CkIW1XIFaTj8wHwERIxbWZoJ4W/df6JYTRGERzpauN1d+fOPeV54YE3jYkK1lMdmBtYKme+D0=
Received: from CH2PR14CA0059.namprd14.prod.outlook.com (2603:10b6:610:56::39)
 by SA1PR12MB8700.namprd12.prod.outlook.com (2603:10b6:806:388::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Thu, 25 Jul
 2024 18:04:39 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::5b) by CH2PR14CA0059.outlook.office365.com
 (2603:10b6:610:56::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28 via Frontend
 Transport; Thu, 25 Jul 2024 18:04:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 18:04:38 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 13:04:29 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>
Subject: [PATCH 32/39] drm/amd/display: For FAMS2 don't program P-State force
 from driver
Date: Thu, 25 Jul 2024 12:01:16 -0600
Message-ID: <20240725180309.105968-33-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
References: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|SA1PR12MB8700:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b8d50ee-100d-4c20-c68a-08dcacd4402c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vbbicU3/hEFDKh/RhLCHDLHIL7Lhf7K65pTGyGQm97GsWEpXDa2DMdcBIKiq?=
 =?us-ascii?Q?EVjgOKelJd17hndYOpczLJRRRSMCLG2vWV6fFZJNQxZlmR85aRlADj0aJiQm?=
 =?us-ascii?Q?u4eq4/E5t+b/6cj2h/SEwZPzdPiepOL8j0FfY/eMcyCutKSd6ljobdOM4UWP?=
 =?us-ascii?Q?DVkDUYjvshsuJW0EMujXoY3k6E8SiGqaiTcVBC0YEzFlILP2mdSRlMhas/xa?=
 =?us-ascii?Q?FNp2wB0Y7U0pxLjUGqyfoydsspYZnq1/sew9wtTnk4J/i9fea+qbTCfwKYGR?=
 =?us-ascii?Q?v7jWcPB9Hubjb52e7JiJOTR4t7Va5sUTN+v+px4SBUg2YH9aeciDU9y7+KZa?=
 =?us-ascii?Q?Xp23q/dpzg4NZ6b6apuQMP01Jp+pH8/0i8ZzZWDcoxG6eLIlSuEQ2hjX6rsA?=
 =?us-ascii?Q?NvKySuZp5FzOnYtkb2kp4whGPerv/dcWmMVlmR0J7cCfz5N5BTbEMy3XyqFa?=
 =?us-ascii?Q?JV68j8UBh7M8IYY4DwW/LKGIXTi8szDO4+sYqQPL3gvsCabUT58eSxpKbvYz?=
 =?us-ascii?Q?RBDffMfSzqYC2ZbxPmc37J3AAnEVAwtRNVkKxLpljy5iuNIU9Y37OB/XK0qr?=
 =?us-ascii?Q?CatE7IWtcQvwlwLS4lltHd8V1WZKLxmU+a8N5RPtp3nPLL0f08DYnmW8LuQL?=
 =?us-ascii?Q?jWEiTtKeImD5ATTk8f/vB1MXIWJVWWnNMKt069p1B5S5uzPPsW4WChpnXd8T?=
 =?us-ascii?Q?rofTrra3N3ar/EW4nWFUENmsIi1iWeaiv16AH4nQ6Fa82d5XpmZ772ra5ceS?=
 =?us-ascii?Q?Oft+Fk96JZxsgVltLin0D4UO+ddL3muDi/X6blwx1BPcsQ7pnKX/efz2JhHv?=
 =?us-ascii?Q?AlsJB4WP5jehfP0DcLHvfR6CmSg8uwRCkr09cW5C8kyTJAVFwp5dnCkYeW4I?=
 =?us-ascii?Q?DcAcH4+zdLVLJQuph/Xq7zbluyHGKm9erw64aUNL6Ro7Y2RaBcF3vBRluJx4?=
 =?us-ascii?Q?woF9yQxXJXl5KlBrQuPmLUAFiUrKPJgX3hiRzi0UTGsXxF8zedQpsCQmY8eH?=
 =?us-ascii?Q?iYu6Ogm6Ese3fAHGiKG25105rUFyTAcUIMeQPmH+B5U4G4/MwIIkS8noMmuO?=
 =?us-ascii?Q?1F4VXFLen/uBuYrbS2Sm/dINrkhUZTvJeiDIhwFv9GAKRsPE2ruYF+CAehvm?=
 =?us-ascii?Q?NgdvYO8MuE9seoEUBqlh12uDToNp3jAkNuHynh8xtYMD1w/zvWJiEtDYC35U?=
 =?us-ascii?Q?Pv/qdwzpG0Rx7XYM2pLiG7JPoKzMoRht/3rG37UxF0VvuBQmd3LBDqGdRQ5u?=
 =?us-ascii?Q?n5jn/wF9mR4syR9BjzkvfdqD+WrJ5nNSQyb8QWkZHNLdqDFve4TdWHMEEzkT?=
 =?us-ascii?Q?HBHWXMxyDo+7fJaVmqp0Q9eUqKJJowgzdIXCX/R0F8jQ3uXP+cyWSu36NXVX?=
 =?us-ascii?Q?PPQZQoX768L+Pf/gtBAKxK+cWoxJ5XfhxrmTn0bzgLLjRTm5fiexb6mVYed5?=
 =?us-ascii?Q?ayAsTf8I5TVf6ZyZohg5LUWo0gKfZTDL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 18:04:38.6050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b8d50ee-100d-4c20-c68a-08dcacd4402c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8700
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

From: Alvin Lee <Alvin.Lee2@amd.com>

P-State force programming is handled entirely by FW in FAMS2.  Remove
any programming from driver side to prevent incorrect programming from
driver side (which may override FW programming)

Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c | 1 -
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
index 846c183fe3a8..b1ebf5053b4f 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
@@ -990,7 +990,6 @@ static struct hubp_funcs dcn401_hubp_funcs = {
 	.hubp_soft_reset = hubp31_soft_reset,
 	.hubp_set_flip_int = hubp401_set_flip_int,
 	.hubp_in_blank = hubp401_in_blank,
-	.hubp_update_force_pstate_disallow = hubp32_update_force_pstate_disallow,
 	.phantom_hubp_post_enable = hubp32_phantom_hubp_post_enable,
 	.hubp_update_mall_sel = hubp401_update_mall_sel,
 	.hubp_prepare_subvp_buffering = hubp32_prepare_subvp_buffering,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
index 2533f16510ba..457f4167e848 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
@@ -132,7 +132,6 @@ static const struct hwseq_private_funcs dcn401_private_funcs = {
 	.dccg_init = dcn20_dccg_init,
 	.set_mcm_luts = dcn401_set_mcm_luts,
 	.program_mall_pipe_config = dcn32_program_mall_pipe_config,
-	.update_force_pstate = dcn32_update_force_pstate,
 	.update_mall_sel = dcn32_update_mall_sel,
 	.calculate_dccg_k1_k2_values = NULL,
 	.apply_single_controller_ctx_to_hw = dce110_apply_single_controller_ctx_to_hw,
-- 
2.43.0


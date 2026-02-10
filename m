Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F0A8EA8118
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 13:56:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1B6D10E587;
	Tue, 10 Feb 2026 13:56:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1nfYVylM";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011068.outbound.protection.outlook.com [40.107.208.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 711A110E587
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 13:56:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8dzuwchtuCE1scdzBxJOJIKkYc9mdF16kN4SIigEC6czsSFWvZbyj/fK4HwYBhHSHtpBuUJDN5TG+xrSuC49R9qRAal8HLKJG/8XrRz043LxRmnMofSY3gQTc2I2t0fpweA/OMAK9qFxqsjm4OXV0pcKuKJPH82IV9r8ENAIY2xoIMBdysibjPbisSsR88uFE8P8NL3GPoNH7eDFL/3V1Spx6+brEggq/znOS3jTv/bmaxGn4uIONEitd2k4CuQ1zktj7mN5+NF3QrHMgnoOBexayNsnZoNCN10r6uAq/ALxR6kZimknR2GGV7cVR22VwYhE+/lNuw80MQ4odoSbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=snbcO+BDph5y+CUdLFqcP/A/8Qynj+7D+/FnUjC6bxI=;
 b=VOaYTOiweA9Qz68t1Hy7IMc09lHy0TZkwyyIhldjOD3Y1QjvEQPnRseHM/TkXEJjY8j3HJJEuUGGe+ZpYElgv/oFPSXPkE52V+FPTajw6Lr1wiNNE7Wb9brfurVsp3jo7p+OdWRYQYA6hfndWA5X5RgzpXpGReUm8fh9x94xnBYOu/iNd8OPSyvMYG5SjcxhfKYF8DKF67eYtaVGv9gMXDA07j9GSstuzK++ur2Q0pSA/taMW/n3T0EBEwrQlbM8mA4ABRP2HVRegoJHnGYpOT9FLwf4EN532MxzY4s+UYaHNOo/7v1F8+V1XF0FnZ/XL1cPDRbo5nBgivywmzL3PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=snbcO+BDph5y+CUdLFqcP/A/8Qynj+7D+/FnUjC6bxI=;
 b=1nfYVylMRO+PDGpBxg/ExKTr9CEU/9O9dAt5zz108TNgXMjOptVDwICNQ6mufe7FU6lFRKzsWsIoMwuMOwqoLPBvHhFTYwOqEFPbRye2VIxa59/rUo/Dmsk3epCqN0NtPmX22ap6umAnnsuenHuvUjACoTOcKsb+6IutOFLKxEI=
Received: from DM6PR02CA0126.namprd02.prod.outlook.com (2603:10b6:5:1b4::28)
 by PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Tue, 10 Feb
 2026 13:56:36 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:5:1b4:cafe::85) by DM6PR02CA0126.outlook.office365.com
 (2603:10b6:5:1b4::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Tue,
 10 Feb 2026 13:56:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 13:56:36 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 10 Feb
 2026 07:56:35 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Feb
 2026 07:56:35 -0600
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 10 Feb 2026 07:56:27 -0600
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 16/18] drm/amd/display: Check return of shaper curve to HW
 format
Date: Tue, 10 Feb 2026 21:50:09 +0800
Message-ID: <20260210135353.848421-17-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210135353.848421-1-ray.wu@amd.com>
References: <20260210135353.848421-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|PH7PR12MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: 30c4b18d-a802-45f1-e359-08de68ac34d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eSGzfXq595/71npU523iHao/jiSoBr5ClShGlCHzgU5NnSLBSdHBMYCgnMI7?=
 =?us-ascii?Q?ZZv1N8g8dVgknVIlBJFSfl5r/cqJ/JIVRvXy4gvGawP42RlSBhFYIfPLnHO4?=
 =?us-ascii?Q?WGrfd1W8bF4PekfLyCcUOuGbXI+eH3PJaNhvifI6dsfh2k+Sl97vSmqvZZMm?=
 =?us-ascii?Q?YyFaA3h2XgM+viLY7tNhcW05qFtQ4yMlUTfDQvguis0uQ8cy//1dQ3WMspwQ?=
 =?us-ascii?Q?Ag5/UNTmCFJE73FfBNBFejKJqt9qLxo2p586swyOcPS1/8ergF3LcFCIeXqz?=
 =?us-ascii?Q?clvivZNWzhAKP4lypXp9fNs69+R0BV8YCiO7npevAYHn1XXH5aLham9SE/eT?=
 =?us-ascii?Q?6zTVLwwv8JIb0ijBITaMRW7ChTJy3Zndpsymwc12w6HIzR6TL+wZZOLU3OGa?=
 =?us-ascii?Q?LfiQlLX+BH4K0AgEZMOUABUipYnHLYOuGnKy6LMrOBc6PJhXfhKRndNvVdR2?=
 =?us-ascii?Q?RA2DH7BvYK9F1+HqHCeI5FmF92Xe6OcSN69GxUq5oQxYfUctts2XXkl4o2oz?=
 =?us-ascii?Q?LFWxh7Zk+iaEgczawhLaAZFvTKLiSruCpHQSpDchDRNbcfIqZDElefO2SNLO?=
 =?us-ascii?Q?eh107W6mun8bXFe5uW+JrKjGggqs45TVCOtvMePF4HqzCi3QTMYRW05bzKNC?=
 =?us-ascii?Q?hBDKzEy0tEy3rM7RTUqoZ1rFN2jYCKr0tWNLtuzgi8o5wJiD/FIYahv7nCjc?=
 =?us-ascii?Q?Pd3ve8lP38a3jBCiADZ783OsLfG/NmgQnU4hyAp79JAGOFMxrgFNp+n+nUNV?=
 =?us-ascii?Q?YI5uqb8uS6oQPn+d2jJqC1haKVyMCMfHcIaxjGNWwKxtg2FYAGRZiLkewEtr?=
 =?us-ascii?Q?1+8gHVDsSP+lN8FS3zqktysYvPkM+8xIhRBjMK/Vcle+dFPnyw8mVwYHAP7d?=
 =?us-ascii?Q?F+NjDBBV566ijuVz5XvG25X44AmmQTTiSQaXJ04HLfqulU+0rALGauveSyqa?=
 =?us-ascii?Q?VwKFHz5G+DbE0UOmbD4qor2vM/WUMIkXVr+xBPKBekyvo7CuFwfdy/kaQJwc?=
 =?us-ascii?Q?XW82vgVcCb1lfmjfnhs50d8bClITW2bnrhKX21BLLsAHATNo9qf0evOrxOhC?=
 =?us-ascii?Q?l9LOCIWfIcaqVOsV4/a/6UOiR1pUVeTs1D73kqbVz78EL88dWLUz0J78xE5F?=
 =?us-ascii?Q?nWeDf+OoVzpeKjyHTuzE8LtAxAaG08TKVw3LmoEtIhAQez4vd1fPqR4fLYa/?=
 =?us-ascii?Q?D0Mf+bS1mgRAjiVXxYnUzWA/oYXXKDk8lMjG9hEpo8R9dFj22gBqN+caQMMn?=
 =?us-ascii?Q?jYHVWzD1bBZrfo61mIgBM1SIvKUE5o6jfnQ3xHZJcXXUalcmKPuL5hF5Jmmq?=
 =?us-ascii?Q?esPcPLT8puvl7x579mha0mE60IZCM0hzINjY2iI1bBnejFgdmAtY6oER3kGS?=
 =?us-ascii?Q?g4KPU1Suvy8Pq1gpZcIkP+JqE8tYFnzpUbrXhhz52LFPROCS6cvhO7gK1KTF?=
 =?us-ascii?Q?y2VtsRvBBtrqGmmFDOUTegapLUHG4DqR3WDJqGirY6t52Itb4u5U+CQm3IB3?=
 =?us-ascii?Q?vAn2t2EfAAIWYARAS3AzY+1kIEGfZhbECDoqOxn2pYJTeQ6/kBSv/fbXE7FQ?=
 =?us-ascii?Q?f6Wnh4bUjaObG1bgmNDF2l/8na2l61YOJBx5EqVfAYHrgnO0Q1gjlJlCJV+5?=
 =?us-ascii?Q?gExIEc/NgPuQJk1h7uR+my/IY93bLU/lMC3oFeoUD2H6yG4A5543hRRz60r8?=
 =?us-ascii?Q?q19FPw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 44Oz4te10Lk3rNomwy+Ut8dbvATCZXN5cGyx3t/hYHBzFnKo6st+ecKu9IDBE48Yl3M4HK5b88Z6pQkBeTcc8xdqVY2wmRGynIoAJw0WzJaZCF0rBmVctqf0Z9swMeFuX2PH85jjlbH72DW4grPMogRT999iT5YB2tIwIxAuWc94U3EUf6aEqs49GRpsJjEknCp9IhHHtGAvweXjsE/bwqDzQQGdxfjUoDq/LJDqbskdxj88jcCKesVa44Z2vcCxEyblqBx/V7PKdfpH+U6giKu2QELmiMDLkeKTbBvfaKbn+zyAOOu6R0S8Ddsgu5H41IT5Vcw8eUYV9M0tlfqAPD3eFMjA/YnoEmi1lBp0l2T0XPp8ij05Qigm+jms12a/37rva7W79he+RDT5iZqULI3il3tS7B/v6YGny6M3VsEO6XEmCALYjq+z/Y/cFaYm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 13:56:36.2446 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c4b18d-a802-45f1-e359-08de68ac34d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7794
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

[Why & How]
Check return of cm3_helper_translate_curve_to_hw_format.

This is reported as a CHECKED_RETURN error by Coverity.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 2767d3a97812..a0aaa727e9fa 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -486,7 +486,7 @@ bool dcn32_set_mcm_luts(
 	struct dpp *dpp_base = pipe_ctx->plane_res.dpp;
 	int mpcc_id = pipe_ctx->plane_res.hubp->inst;
 	struct mpc *mpc = pipe_ctx->stream_res.opp->ctx->dc->res_pool->mpc;
-	bool result = true;
+	bool rval, result;
 	const struct pwl_params *lut_params = NULL;
 
 	// 1D LUT
@@ -509,10 +509,10 @@ bool dcn32_set_mcm_luts(
 		lut_params = &plane_state->in_shaper_func.pwl;
 	else if (plane_state->in_shaper_func.type == TF_TYPE_DISTRIBUTED_POINTS) {
 		// TODO: dpp_base replace
-		cm3_helper_translate_curve_to_hw_format(plane_state->ctx,
+		rval = cm3_helper_translate_curve_to_hw_format(plane_state->ctx,
 							&plane_state->in_shaper_func,
 							&dpp_base->shaper_params, true);
-		lut_params = &dpp_base->shaper_params;
+		lut_params = rval ? &dpp_base->shaper_params : NULL;
 	}
 
 	mpc->funcs->program_shaper(mpc, lut_params, mpcc_id);
-- 
2.43.0


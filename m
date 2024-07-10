Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D77CAC3DA41
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:40:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83D5D10E8C5;
	Wed, 10 Jul 2024 19:40:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4ieWi+6D";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C15F10E8CC
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:40:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QnhiaiDJclva6GQv+NypyHvQA1wi5txI18Z0COE56qhBY8yr1hXTlCCi2A1/dQmRtYb7rjoOQPr42j/ibxAylGiH9LB4UvCDaVUiv4mSawtTBvhV3WYrY2yPN51ffzKHtr2wkam2lrP4ueOSreK7rJqcoSUg7IVczc6/7nF/TmXahJTwHDvBTSfP+pFmuAyZpFeghErwjp63ouIhPMuaH+s9KbtXum05NH2sPHTtTMkHAKxHwi5jKh7WLvRo/791rHRKlXXxJk/usThEvP9qHz8VPIZtftwDfRRLm6lHcdBom2gmYwkNhPZwoJPYIgIkNstAD/5qf8rfJ/2441zPpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17K4vtXHNA6T3QK/3huOuEMOMBDjmgx2NkzGjFXkN94=;
 b=d14GeKO/mLeUhpQ0Y3UxdC8q96NHYXmP779xsDWhu5I1PesX39zRAEWkJ91exTblShV4D3YE9OEcjvTbVp1IbVSQedZvIZaTSMXimA/jODaYd7oO9K/Vn79NYRd2cpzOyNVfAAwbxFu/r2fonpuyOyuTJl7tqWxHLnXfaNEKt6Uf0XLPwOUL4WU3DyJAXg9ApwDzha9awiQD1EL1O8pvpJE9a8kj+fEIO6ri8kZYAyBrVa/F7f0fl9Gh/JC/+1BDXNQmkABRdf0XbRcAYswrTJL+BB/Hpm4USltrLrXnAF6LHvTrHt8tRQjhxDatHXALrO2v8UOso8fo1WUPl1R7wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17K4vtXHNA6T3QK/3huOuEMOMBDjmgx2NkzGjFXkN94=;
 b=4ieWi+6DCrlNHnfyQeE1LN1jEGPvQMW6Bj1oTENEAuUerw/Yed3NJPfmSyoAMeYbYWB3yrProSsiNljuKojCp0SAlWfrgj4xRlYgXptSD28cKAOg5RCbFKm4brbCGTWUBy23Za1q1B7jNFHwi/EICAzi5hOiPuQw+3f3AC9Vzxo=
Received: from MN2PR22CA0009.namprd22.prod.outlook.com (2603:10b6:208:238::14)
 by MW3PR12MB4363.namprd12.prod.outlook.com (2603:10b6:303:56::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Wed, 10 Jul
 2024 19:40:35 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::47) by MN2PR22CA0009.outlook.office365.com
 (2603:10b6:208:238::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20 via Frontend
 Transport; Wed, 10 Jul 2024 19:40:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 19:40:35 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:40:34 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:40:34 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 14:40:33 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Joshua Aberback <joshua.aberback@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>
Subject: [PATCH 46/50] drm/amd/display: Remove unnecessary DSC power gating
 for DCN401
Date: Wed, 10 Jul 2024 15:37:03 -0400
Message-ID: <20240710193707.43754-47-Jerry.Zuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|MW3PR12MB4363:EE_
X-MS-Office365-Filtering-Correlation-Id: cf0d51c9-0c57-4927-5184-08dca1182b26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MK8qtL6qZYb0WSn9WhUTehXsmtZsorh+Rvg4KZ9KzA+qmvs2vr/9SZXlIWBJ?=
 =?us-ascii?Q?EEmBH/MCfbH0QorTW96D6TSG9czENKTVnndb0EU/Cy3sXThi4RKA8qal3+7t?=
 =?us-ascii?Q?bLiQ7oad0SXlnI9FVUnI39w0Xe8TnZjzESutw7cKa+m40NJfi6fGZ86ppVBi?=
 =?us-ascii?Q?UdDRJbo/o7Veiml0gX4qhBbQ0ldnBth3g2RBt01oYKi3l1+VLwnrle+0cRlq?=
 =?us-ascii?Q?3RL/0LK8+D0o2XrQ9iFESIGXz5onIYHFb3IBuacKUeZYKJNfOa4amvavKmMr?=
 =?us-ascii?Q?Q9gwBhyMDfPPOFm+zpgtGDZyIWfnt7xq84Qa12RzqURZSMq82r0IstJ8AmLc?=
 =?us-ascii?Q?ycqfyMjIid+ZsEEMN9JO0tLZx+B39xjDOxMjS73mFWX5uiaHAo+TjJiICrt2?=
 =?us-ascii?Q?DwvSMybUWGRLVcS3fF+Pzh+Q9qM7pMY7Ou3kOI/IqSVzb7JkH4PaSpgGxuwH?=
 =?us-ascii?Q?65S7BzTEFeUfsaO2Tc1bDx9PhUSNZ2Xr4ms0Eoy+71m+UOhSgABgo8mEmxXn?=
 =?us-ascii?Q?xiSWixAKUDObIjrqW8X4c7e3NmSP0Ga2dwBF8rWSB+/9CBSL1lDGAElxdtfW?=
 =?us-ascii?Q?YBO471GrVKrjoT+xPZcoOIpRg9Z0Ml9hLDBTvlZmFXuhou6qugoVYXpTe6kr?=
 =?us-ascii?Q?83F/xVX+ZQAJv5L2KBu7UBTCK+yIuR87JZf/jMA8pW6sPb0/88wlS2cqUcvl?=
 =?us-ascii?Q?fOrNGc4t+htKShom9DNQXNqoxREJEDGUQcYa4qxzsZK/k+9waLj+SXjun7dw?=
 =?us-ascii?Q?Tl3BGOaYIOyNETSyxj+/hcHL0s2mQml7O6laU9J1MM3P3P253AWxFWg0/xdm?=
 =?us-ascii?Q?OcvoXYjbJr2qjUYiF8SSXhmfPBsaHsASeK/Ym1luTTLpAglUuRiu+/4n/b0O?=
 =?us-ascii?Q?R7+D6pNlf94WTGngS41i1WYzt6Cu/fbPped4c8HH4VVIC5wHEnJfD4kIvhOC?=
 =?us-ascii?Q?Al3o2EXASzrcNF9ClEk1GnrBIIUuiOi6GTEvWnSyuqbIkydTJWLKWKy4p/ig?=
 =?us-ascii?Q?sRIqMzDHVBNPBJ3Ve/Jq3kqz4w9jjISrpKxVIYZdJbNG8186VW4b3ZfJleAn?=
 =?us-ascii?Q?ZI0AYFdexqf0Q/tajrh/OXv8J7k7temcIb5pB43GG+F9/9a6HDsoNIABWWv2?=
 =?us-ascii?Q?uhT+lcTcgx4NfLFZXFwgZL+ledSWKSKGftehj025fVUsxPgLcPsJt5+b4qss?=
 =?us-ascii?Q?hXC5acwj0brCwxNZ9r5Kt4Qh9Hs5o1cXbF4DKf9Egg9zBD0gH53lBSpNg7tn?=
 =?us-ascii?Q?XFpAZpriZggF5IqX6CtF8Wz7FtK0gWDDKKvzhjLldpIrXdPaDu7/wZft81oF?=
 =?us-ascii?Q?4n+T7DqTfEEtLAEDfGLH0ZZj98W43KSQ/dEP2fmD70EFPMoPoKjjYfvSO3Lb?=
 =?us-ascii?Q?ELE5CKUOjuL2+EPFwHJLrKKVejHiLd9V4KOdAQYMyJCtckJBeiXYvdLnztHS?=
 =?us-ascii?Q?zZ4k1V1qYrLc38Rdtx4rVcRJ+TM4JkOo?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:40:35.2486 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf0d51c9-0c57-4927-5184-08dca1182b26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4363
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

From: Joshua Aberback <joshua.aberback@amd.com>

[Why]
In some cases during topology changes, a pipe that was used to drive a
stream being removed can be re-assigned to drive a different stream. In
these cases, DSC power gating is not handled properly, leading to
situations where DSC is being setup while power gated.

[How]
 - remove enable_stream_gating and disable_stream_gating for DCN401

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
index 6a768702c7bd..1439f07f0b64 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
@@ -115,8 +115,6 @@ static const struct hwseq_private_funcs dcn401_private_funcs = {
 	.reset_hw_ctx_wrap = dcn20_reset_hw_ctx_wrap,
 	.enable_stream_timing = dcn401_enable_stream_timing,
 	.edp_backlight_control = dce110_edp_backlight_control,
-	.disable_stream_gating = dcn20_disable_stream_gating,
-	.enable_stream_gating = dcn20_enable_stream_gating,
 	.setup_vupdate_interrupt = dcn20_setup_vupdate_interrupt,
 	.did_underflow_occur = dcn10_did_underflow_occur,
 	.init_blank = dcn32_init_blank,
-- 
2.34.1


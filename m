Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83321C3DA7E
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 18:04:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3709210E8AD;
	Thu, 25 Jul 2024 18:04:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r3n0nVBU";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9BCD10E8AD
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 18:04:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JRjKdB4C4jM+yZT8yWUZAD3hNYspzYldurtklsROXo3qo226BOw5b2PULJonTyC/+tnjYg0FQoXlLzuQeKeKewM4QENN4OferBDSncb4P5KzxDLARHRJA4GY0t0eGSIkVHeCqF/gWwFm2NeFeUDJLIvIXNyDEndsrJupP6D4lcTWyWgIZji7ozgyoNs8/AHOa9aEiX/ZWmi+GKPH1JpDReGLa85Nf41kb3O+tWOvBmFgnVKsjwfHre/IzDZr2irox+ddkCx4hrNDfnlNitNmp+yB92AK/lZqcIUPbEzDKQ0ZRDvaczryjAcryXQ8dNRN3Zl002FsgUBJjTIvtLPkXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aX0KfVjqzNSmrHAgJbYI8Jp4Ndcw96GrukH805laMMM=;
 b=Tj3FsV9E2GBVSLZJP3gpkZUcMcNfG4H5TmEKIIcNDggHsuDZemLs/crv1aH+IkJPaJ+cyBHVchAhYpxhzrNPfkp2dLpluFzg+8lTs07r5yqpWaxIm8PJD8CMn0o+OJXV+9emb1rO6kbz0FKKh3zpm/C2OgHtTGZCe/STvS1L12CwNRGiECnxG9ygzrC9hYtLqPL5gavr9yQo4HHNvdpA2LHnbMW85GFpBoQ3mCF0zz9siIa8ocQuqcVY1ra+UEerDfI/5ij38PRpY5Zgiwn/KWO8LKBhrovgDbUALUr0pq046KBCRu0xPBTxUVjgKeBQIo2I5NmAgUPaltq12zFang==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aX0KfVjqzNSmrHAgJbYI8Jp4Ndcw96GrukH805laMMM=;
 b=r3n0nVBUCPYDLRGGlKoJi6H/rT7coxt2CKGa8B6xP8pkSUT6AmbHicJ63E95Pl2WvAiXVA73QeTMuE8X21D0pv542AzqTgoa4bo4jL2m4dP8OXvaQMai9yj8o/IQp4EgvG0ihYGKpEJ8it5/gSuh2J+Mj8twCPTfhFeiZCzV7Vs=
Received: from CH0PR03CA0373.namprd03.prod.outlook.com (2603:10b6:610:119::7)
 by SN7PR12MB7346.namprd12.prod.outlook.com (2603:10b6:806:299::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Thu, 25 Jul
 2024 18:04:23 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:119:cafe::a6) by CH0PR03CA0373.outlook.office365.com
 (2603:10b6:610:119::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28 via Frontend
 Transport; Thu, 25 Jul 2024 18:04:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 18:04:22 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 13:04:17 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Daniel Sa <Daniel.Sa@amd.com>,
 Alvin Lee <alvin.lee2@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Subject: [PATCH 25/39] drm/amd/display: Underflow Seen on DCN401 eGPU
Date: Thu, 25 Jul 2024 12:01:09 -0600
Message-ID: <20240725180309.105968-26-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|SN7PR12MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: 85f38736-9524-4ecf-7268-08dcacd436d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tSfacUcNHHh9U+s41y1FmYX04rUbxUlz8dDMmkIzA4wsPT5QK7NMBGEN8pg9?=
 =?us-ascii?Q?qlrVOltOgHIFi095xXH+qE5wtpFjkSWMmbIAvzrocoSbH+eFe4P3BGZrLJD6?=
 =?us-ascii?Q?ZW1dw+HzqjJYueOK/Vz8JlwHrX5YEMHWLw0zEqD4fB4N7XWkxKvPPtr+eIZz?=
 =?us-ascii?Q?f5VEs304gFru70CT+ZST8vnWNRT659vGB5AB1Bs1ZsWjF7LAB22LSvf/4sIr?=
 =?us-ascii?Q?fTGNHcGSfkI0uIesYpIz0YkQJL/MBCjKvNKKFmXw1ob4ZJKdfnXvZ/kQtbiR?=
 =?us-ascii?Q?o9kr40EjOYWiRlE04D9TmqW/hztC5FiHGzaqM3a/pnZWVO3vO5DbEGhobWxZ?=
 =?us-ascii?Q?J/O3sRtTGODXUMLXHXqBZfrOHOeaBnt7IYHs2Z3Avx0NNvDwAh0jZSh3m/OJ?=
 =?us-ascii?Q?BQhiqJLYXuWpAMj1/L4U9SEtXoRHXUe4NONqzyJgFvgWhse5So4up4AazNxa?=
 =?us-ascii?Q?Lv304owlrSeqjCUrhjoSMuDbz7q6hXY6jsUwBpJOnE0IPG0L6WkN5Hpunxod?=
 =?us-ascii?Q?ejod4PNcjxT4GPuP/YqqmY8GNmvq1tNRGJGwHQh0k0EOPPUgEB8hCmE/YesE?=
 =?us-ascii?Q?osRSVdNfkQMNyXHAeYhEwK0FLV7cmiqFHdzoDyhbc5pzAGP7TsfzMmFHZpoL?=
 =?us-ascii?Q?c+jAY6RAoyfM9DVLAklWwrkg4pGLt/51MdOSUM/2B0liOPwKAWnU1gm0YNwc?=
 =?us-ascii?Q?MiB7pYkim6IcF/ChhpSME2eq/pqiQEivy6Lo+pf8dTvyeE5qi4Po06dxpzrJ?=
 =?us-ascii?Q?PFZ0FSxPgNGYIkKF7PxJBLgPyJOt6xGf2A6m4G1sAxMODNIQtW9+ucWvbhsX?=
 =?us-ascii?Q?wrSby32V0+OxKxxCEWNHBla/nMVzHS0Kx8SbREQfRJuzmc6JWeOxlYsyo0hD?=
 =?us-ascii?Q?HJxNmQfgSG4+h0tbG34jZKtHXHiqEsqM7TeMrRJ159ADxSQhV/js7Hqwh8dF?=
 =?us-ascii?Q?Jp1sjYlXxyLJftJYX8k0BcJi3HJLP4XeXzYAJihk2CLrTmMB2r2IdfVqFXD4?=
 =?us-ascii?Q?yJ4jopZDHgF88fMlpGMTyvTx0IePPHZcaoBZHoU+oHNCxXhIgTgOQX5getX2?=
 =?us-ascii?Q?Bl/+zMogOGRcE0rhJo1vJv5EOD6nETCntfx8490YwMAgWPmEbu3wRMJ2DTFq?=
 =?us-ascii?Q?nVeAEnjPuEIT1p6ITUs8CdWFnr8/Lk6/yQ4YqmGwPjZhe8Ayn2CXYacD2aYQ?=
 =?us-ascii?Q?YBsmw5lcpp+6rDK38qVhiiNi+NzL1i+cIR/iVPRKxugrbuAx1UKu9AqjsBQ6?=
 =?us-ascii?Q?cazd8Pr3VuwIvhyUFmupNyeCpnUQW/VhGlDsFLEtGKobFmJwW5GAluHIYP2v?=
 =?us-ascii?Q?wOqAYkgmAIP+mZ5IrEmHP1hjyJgqSVUKw8LBOjNGONz1xPf5V7LUrm1qyhQV?=
 =?us-ascii?Q?+kkMey1JrxJEKzgVQ5fydrXyjOrQj9TEPHoE3PEh3fx4gOmGNHo1Rqe8qgkX?=
 =?us-ascii?Q?fWuRYla8f2xDQZlEh7v+1hDWWvL+nKCS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 18:04:22.9307 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f38736-9524-4ecf-7268-08dcacd436d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7346
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

From: Daniel Sa <Daniel.Sa@amd.com>

[WHY]
In dcn401 we read clock values before FW is loaded. These incorrect
values cause the driver to believe that we are running higher clocks
than what we actually have. This then causes corruption/underflow for
the eGPU.

[HOW]
When new values are read from HW, update internal structures to
propagate the new/correct value. Fixes issue

Signed-off-by: Daniel Sa <Daniel.Sa@amd.com>
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 8e1ca709d304..ceaaa8df3641 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -221,6 +221,7 @@ void dcn401_init_hw(struct dc *dc)
 	int edp_num;
 	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
 	uint32_t user_level = MAX_BACKLIGHT_LEVEL;
+	int current_dchub_ref_freq = 0;
 
 	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->init_clocks) {
 		dc->clk_mgr->funcs->init_clocks(dc->clk_mgr);
@@ -264,6 +265,8 @@ void dcn401_init_hw(struct dc *dc)
 					dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency,
 					&res_pool->ref_clocks.dccg_ref_clock_inKhz);
 
+			current_dchub_ref_freq = res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000;
+
 			(res_pool->hubbub->funcs->get_dchub_ref_freq)(res_pool->hubbub,
 					res_pool->ref_clocks.dccg_ref_clock_inKhz,
 					&res_pool->ref_clocks.dchub_ref_clock_inKhz);
@@ -433,8 +436,9 @@ void dcn401_init_hw(struct dc *dc)
 		dc->caps.dmub_caps.mclk_sw = dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch_ver > 0;
 		dc->caps.dmub_caps.fams_ver = dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch_ver;
 		dc->debug.fams2_config.bits.enable &= dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch_ver == 2;
-		if (!dc->debug.fams2_config.bits.enable && dc->res_pool->funcs->update_bw_bounding_box) {
-			/* update bounding box if FAMS2 disabled */
+		if ((!dc->debug.fams2_config.bits.enable && dc->res_pool->funcs->update_bw_bounding_box)
+			|| res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000 != current_dchub_ref_freq) {
+			/* update bounding box if FAMS2 disabled, or if dchub clk has changed */
 			if (dc->clk_mgr)
 				dc->res_pool->funcs->update_bw_bounding_box(dc,
 									    dc->clk_mgr->bw_params);
-- 
2.43.0


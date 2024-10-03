Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6920CF34D8
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Oct 2024 23:36:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CF9F10E9B3;
	Thu,  3 Oct 2024 23:36:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E7Q1YMto";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6986310E9B3
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Oct 2024 23:36:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yBZ9mYRkYLjmyzd4/KBXai/EPwPN+1aPoIusjYgYZPtbtShajzI37CweJMsoPvz1BaX0iBvO5RdBVqO7OoEDg7bwr+uMSS31Y8dgonQkZ3NsjWcI5lr38PgYEiFgR713HFwty7imT3JhxJhaFISiEZAnOPBTLCHlFA4Owp8B3LtdYY4s/DRLvu927ZQ+10VHpwRYt3lkBkBMaJBDRgYkBxj42QFjk4ulvPh6xzpK/dIp/PBtWoeNrR5ANBYrtmiRGkPbGcWJdxePAiG6zh8DE2Gyyh/ZXpb8j2wvJJ2ACCGSvW8bPh/jMG7dlLTuCK0HhjteCZElg1l/LvfKfyhxww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSs31y70+4GeeiMpBSfMJzfwFjp4k+Z5JEoYzEQeQ7E=;
 b=QZp9vzhJ2pB0a7z4yDG3Xzl0wApLRgTjWh3ezDsHF9Mcl5se7gaBbgAj0JuhG+zlfHj4CN1foRENn+tVHQ5EOWv2DHznkpD3+jTzGk7Rtyt/Tw7PkSbkgdDJg9a3T/xmhvU8pY28FRS5qNKXPYaMjzOgz7ak5zMsztnNdjnhJcUQr2YU6s4jhlusObLb1xblDYciAKwTG2pXSxxr/4Gnzs3AsXYmRSD77p5UtmfD7eJ5D9wX+baUcFrFm8aFqOd7cRej3SCxOxYLBll269jbj6yTQy8CJUeR0gtOJFFXfAxqcZuEm0Mj7SZN1A0i4gLcUz7n3SKeIlRh0Y6Socpwbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSs31y70+4GeeiMpBSfMJzfwFjp4k+Z5JEoYzEQeQ7E=;
 b=E7Q1YMtoDarmIuAwGW6T/UfsaFqA1spt5AHCDGaKoPpAcOUOOaL6sF+XrT9O+D1KTBrm1ADRBKykPQZwu/e8SDHqBTocjnkOTo9j3kXllSNPAs6C9AW/R1Y57fKdQ6rFKgft8j44T4DnAWv3xxEk0KUjoyHN5fAVTaEUFybFH48=
Received: from DM5PR07CA0113.namprd07.prod.outlook.com (2603:10b6:4:ae::42) by
 BY1PR12MB8445.namprd12.prod.outlook.com (2603:10b6:a03:523::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.25; Thu, 3 Oct 2024 23:36:15 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:4:ae:cafe::38) by DM5PR07CA0113.outlook.office365.com
 (2603:10b6:4:ae::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18 via Frontend
 Transport; Thu, 3 Oct 2024 23:36:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Thu, 3 Oct 2024 23:36:14 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 18:36:06 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Austin Zheng <Austin.Zheng@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 19/26] drm/amd/display: Move Link Encoder Assignment Out Of
 dc_global_validate
Date: Thu, 3 Oct 2024 17:33:37 -0600
Message-ID: <20241003233509.210919-20-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
References: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|BY1PR12MB8445:EE_
X-MS-Office365-Filtering-Correlation-Id: ffd0aba5-513b-4d4b-d54d-08dce4042c16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kQEe5BQr4BwmJq9DtdclM89G7xQYtDtcT/JqrEPfJ+dmFmv1jafL4fptOeQs?=
 =?us-ascii?Q?uQLbJQs7gPL+mO42smKHjrP/3RfhH2XzWEVaf+Ic7qEA5eZlY8FtcNINhhrC?=
 =?us-ascii?Q?nUrIfgf3v4oGrxP82n+LgJIRfsWAufkWyc29sphi8Uie8mEU8qa9Q9mnBUk3?=
 =?us-ascii?Q?T0/acymPEWjtF+wiEGolAlaN93ubI2qkhwIraN5rHoNWHLdeVbpTIX0kE4BM?=
 =?us-ascii?Q?bx+GsOlfEPJ1WCztZZsfdIZOOSVC51EbCUf42GeIIuQYrvGrXK+SVQevtDvn?=
 =?us-ascii?Q?oaFZuhR6VWrq7Ntwxk9/f+nqtXDklZOY6toCAkiH44lFyQyXZsYl6wMV/Rbl?=
 =?us-ascii?Q?ed5NQMqiFP6ealqG2nFP957jR3AcY+x5IhALLB9EHfMcJPMYIxMLN4LP8KaH?=
 =?us-ascii?Q?qBTGD7bLBOMqgnR9/tPu5AbR1AXGgqpsjRQYJDF4/N5v7b//B9K+qtaNRQuq?=
 =?us-ascii?Q?3VEQBZF7bn9YQnAxfu3jt9TSsuMLjxCW9Z3IxqhiY9nUHvQ9MnbD9T21UvVA?=
 =?us-ascii?Q?AHGUgGzlmkVawSDLes97POFi12YnaYmuuGYhA1SlCQRE/DeE+TWSYhppJtFg?=
 =?us-ascii?Q?ez0mgAfp1mZIFYY1lLv4PVivndoukdtDLKv+2pmC2V6cMIcLv+imVsF4nzw8?=
 =?us-ascii?Q?7+czKuvwAUa/DCWpaVpjtd9WSOc3D33yU80L+afYB2hyTfx460ufqRa5co5m?=
 =?us-ascii?Q?El2lrRDasoNDBpIO2mibp0t1t/EouCf1yXGxEFPQStLbCqbzr0jt6z/3hPo8?=
 =?us-ascii?Q?Qi5cyIZ3D6+Pxt2+gDYQIH6kuXOKGDZXyMaru0tU9E9cAArDOuqo74yetJiG?=
 =?us-ascii?Q?8gT4MytfLi/TOGf8Dpx+Gxltaf8eJBOVpy38avMor6v+GcgAur3DkwHzANmJ?=
 =?us-ascii?Q?eexASs807A7jpfVmRH98OEzECgpCFYz7cX5IzGkCH/POD/AXrzT9qx6hcd0w?=
 =?us-ascii?Q?3UDOV1KzbEWjBmQJ/6tLiBzI932CPKLMoOdPiZ6fUgiplOH0su04GHfxpFCY?=
 =?us-ascii?Q?tQLW4ho6yat0lypP9AaGbx6b5Io3jl1X/mCy4L8xUvVwzIfzAPQIjtU2vVdd?=
 =?us-ascii?Q?oRaAI0nrJ0I11ypqAASflOhr4aF66Ww8CIq/Gdp5ptSFphRFxyg5uAAfXAVn?=
 =?us-ascii?Q?w7MdjlWgJPZuI6YKIDAcaeQ/s5kmgpfDQ8E941i4GDMhD8AAjst8DsgpBOZX?=
 =?us-ascii?Q?AWhD7Xt8hOQeCkTbUJzDyAeImVSHEr4aW3dMELYRh7N1OHKGZnOkn+N92tZ8?=
 =?us-ascii?Q?5Vq+OXhpArjVouWe9/Xv7jpDC+Rk7BCOGI/egooMIuT44LhHyyItxgYIhT10?=
 =?us-ascii?Q?6VzDomo4bwTvsY/r9Q1DjGhbMI3JKDvWqoFl1/AIfc37EIu8xNBk24/gTK5T?=
 =?us-ascii?Q?eO6g3Go+yRgAsGRJOK3PN98m9f1U?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 23:36:14.8588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd0aba5-513b-4d4b-d54d-08dce4042c16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8445
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

From: Austin Zheng <Austin.Zheng@amd.com>

Assigning link encoder is not relevant to validating bandwidth so move
the logic outside of dc_global_validate.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c          | 8 ++++++++
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 7b239cbfbb4a..2d704c264b88 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2187,6 +2187,14 @@ enum dc_status dc_commit_streams(struct dc *dc, struct dc_commit_streams_params
 	context->power_source = params->power_source;
 
 	res = dc_validate_with_context(dc, set, params->stream_count, context, false);
+
+	/*
+	 * Only update link encoder to stream assignment after bandwidth validation passed.
+	 */
+	if (res == DC_OK && dc->res_pool->funcs->link_encs_assign)
+		dc->res_pool->funcs->link_encs_assign(
+			dc, context, context->streams, context->stream_count);
+
 	if (res != DC_OK) {
 		BREAK_TO_DEBUGGER();
 		goto fail;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index df513dbd32bd..33125b95c3a1 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -4091,14 +4091,6 @@ enum dc_status dc_validate_global_state(
 		if (!dc->res_pool->funcs->validate_bandwidth(dc, new_ctx, fast_validate))
 			result = DC_FAIL_BANDWIDTH_VALIDATE;
 
-	/*
-	 * Only update link encoder to stream assignment after bandwidth validation passed.
-	 * TODO: Split out assignment and validation.
-	 */
-	if (result == DC_OK && dc->res_pool->funcs->link_encs_assign && fast_validate == false)
-		dc->res_pool->funcs->link_encs_assign(
-			dc, new_ctx, new_ctx->streams, new_ctx->stream_count);
-
 	return result;
 }
 
-- 
2.45.2


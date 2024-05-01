Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17DD4C4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 07:18:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 951291130BC;
	Wed,  1 May 2024 07:18:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qtSS5cjh";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2087.outbound.protection.outlook.com [40.107.212.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C44DF1130BC
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 07:18:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9E+oV8YF0OT//PSiTWbi36VEYS85ENPhz+re1MijfqGw+vKfxzEzVBK5xDNFosynTcFv7wnxhDs8PMWhKmq83ZQzoqvxi5iD+f8DuRpxTtTEDX6UfZk/umBEMXLCQjaPf1vH6nQ3cY9e78C1T7gWXU/yQYaee5pyklsfxNzPo2kX3W3s8pDgzHvVKaOJvYgVVrlibDwdpWQuXqkWWKiSL+7jFmONbXoSHh3vIu7RObt5WXP2XbAJ+QhfBNCiarmjanx75gkTi5TnYyWvyZEiI76xtlH5ERs3+Hbid5VHjZGEA4twtaab84DXH/wo8YSolNP9Df317ny+qfbk5fxcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gs11XPdqsdKZnWv2pKVQtUzjqP+3WJnykF8qtvUMVaI=;
 b=gIkwNmIASL9e0MOkIqYeQU+GbZ6Adi7sUBUbXdBZNcG7PRyrTl25tSc03F3GoYJvz+rXNan6l3cuEnrdIYrHuBvvcVzicelT8a2M8inhVV4njIZqFUwR4BPI/EJnEQZzEt4nfkJmjI/DTluKkUxc0VZ+lWZDnp1mzLL8wS63WXuFbcVaamyH2J3AgFoY+3RU+yaN3CxoonBBwYCy2y2h1WDTW/wVKvF55o1pKS8YEb5b6yDag6qt7dNNgxvGBsFQT2pIfFWGTevl4xbzahYvWX9u6lePMFeKOJK6Rnskfs34V6qzba75PaiZ/xGvetzMiuFQeGQT8EeyAHqckz9c2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gs11XPdqsdKZnWv2pKVQtUzjqP+3WJnykF8qtvUMVaI=;
 b=qtSS5cjhfkhCTBkL+ChfOqbkNnlalpk1lKTwwCSgya78wmvi5CoaQCZ1yXp+YxupQBp5732HERsd+ZDMujOu3Bq0GrTa9BrIGtzEW4QbafOcGorUEuWBLCxynI4JjhyesRNoJMiLc3MUGlyGFr1xZHgk+R31poyZ6yd0mqJmJ3M=
Received: from PH7PR10CA0015.namprd10.prod.outlook.com (2603:10b6:510:23d::17)
 by SA1PR12MB8841.namprd12.prod.outlook.com (2603:10b6:806:376::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Wed, 1 May
 2024 07:18:35 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:510:23d:cafe::a6) by PH7PR10CA0015.outlook.office365.com
 (2603:10b6:510:23d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35 via Frontend
 Transport; Wed, 1 May 2024 07:18:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 1 May 2024 07:18:35 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:18:34 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 1 May 2024 02:18:31 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Samson Tam <samson.tam@amd.com>,
 Jun Lei <jun.lei@amd.com>
Subject: [PATCH 17/45] drm/amd/display: Clean-up recout calculation for visual
 confirm
Date: Wed, 1 May 2024 15:16:23 +0800
Message-ID: <20240501071651.3541919-18-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
References: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|SA1PR12MB8841:EE_
X-MS-Office365-Filtering-Correlation-Id: 16256203-d765-4f7d-4bc8-08dc69aeea3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400014|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y6jbRARy1hlbmdfLHpiwi+fWYKZ2nwOMh5rERWswX7RWhQka8p+FpCEvVuJk?=
 =?us-ascii?Q?Unvh3KfPecfybFSBQvSdDqQl8cKCsft4uI/2o7W/Fi+sO78nCyW/IOJXTf+e?=
 =?us-ascii?Q?0cahyVke0jluiaeMChyp0B2M4q30mSEAzQR0eBNMWLaim2cNZAstl+/GDFCO?=
 =?us-ascii?Q?5zVEcKeTvrjC5SndXl0Mh2xz9f9356yzN1SosTqBM4PVAbPNo1Mo7naA65wR?=
 =?us-ascii?Q?V9vFlpWGD5Zs+HPoYMi+8qJEvgsJ0r+lT8U3CiyLXPh3DyDyFVPlC1DX0Xh5?=
 =?us-ascii?Q?QMC/4tQWExwuM4UkWvjSg2Bae6jCBZdqhZoGiGrXEvr/hX6PFvVvrYLq3Bc5?=
 =?us-ascii?Q?3YIWSQdmyNbdxSUrbR2hjPumXZhTkqTqt01Ovy7W+2FenDvftQkGPJahEMCU?=
 =?us-ascii?Q?Wfx675QkTsNuFnhhKEdCwdH+elXdDYFwzbJXOCGNoDj1Tu1RAHyDUVEmLojL?=
 =?us-ascii?Q?8He0GAd3i/etxMTnXFthrvdMybIijkjaEo76DX3wrye4UBFQ4Rz+JdQBYYAW?=
 =?us-ascii?Q?LxeTaa/NWMMhV1JC7UyI919o7e3rvK4LMLYwjj6LKdzmGoQvLaD0qnLczLBc?=
 =?us-ascii?Q?9YHko7pFLBgII3RiUmWq/9g3qwhXvxsbPf5KC331LtbfO8dvAYDKYh9dVDbu?=
 =?us-ascii?Q?ORSPBkH08r6r2ZW7Akf16Matmd9td1+Njy8CaM+uJ2OS7YtDM2ChV47bNxhK?=
 =?us-ascii?Q?ceGQtJXxN4Zkb3BG1YyVovyFZY3aG//62FC/QXuQ4REmKfgersmCFeN9YOcy?=
 =?us-ascii?Q?ZkK4tQGYYK2nbW1X8O+kWlJIAikohig5h+7IkV8moydrpR1Lam+qfUFFAvP+?=
 =?us-ascii?Q?f4W5JAJW8REtgMK/JQfgQ+3a8MSe0lYFhw2n4LoOlF7xRGIYQwlYoa34zU3T?=
 =?us-ascii?Q?3mRJvY+tYNSnr6HHQhcWvtn5mUYQVvaCaSCv2oducFiN4NSz9ke9wTI0dSM5?=
 =?us-ascii?Q?5B8hmcFmm6Ke2G0n7z7BwvO/Om8+OtcZTW04S1/JHjAhQRbzDLJMGyspkgRd?=
 =?us-ascii?Q?/TVdJghq5xfSry0tu24vVT3Swm2SMU5jLy7Rcs2DhdcuRhUvV8DNIXU9j8ks?=
 =?us-ascii?Q?q/wum1Cuen2EDBA+KejmGopP98ehQJw0g9tunur8IyqrR+MwsETzHzghbeQr?=
 =?us-ascii?Q?nrqzYmYHvmMHPhRQiLifzs9p4XGFy2Z7HjyKmg5bMh/LMkuvZjtIk8E+hgxs?=
 =?us-ascii?Q?xy4Arrx1zNp41pGIx471a8zwTlVEu8uUWMOnU7pTMfT1c4X5ji3AJkb2yDx8?=
 =?us-ascii?Q?hn3yr3+GnYOEJ2XrzE1frI2/pLDQ1w6TMcFEC4l6GPLmnlFlOtTIWTe96cYU?=
 =?us-ascii?Q?Vp0mHQ5tl2kefbJjPZKTh/acA8XwDOQ/I0S19EWusvuRES/vHNZjk/nahu5i?=
 =?us-ascii?Q?aL+lek8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 07:18:35.4032 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16256203-d765-4f7d-4bc8-08dc69aeea3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8841
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

From: Samson Tam <samson.tam@amd.com>

[Why & How]
Split into a separate adjust and calculate call so
we can let the caller adjust recout

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Samson Tam <samson.tam@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 23 +++++++++++++------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index dbcd34c6338b..2d5983b2b541 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -973,24 +973,33 @@ static struct rect calculate_mpc_slice_in_timing_active(
 	return mpc_rec;
 }
 
-static void adjust_recout_for_visual_confirm(struct rect *recout,
-		struct pipe_ctx *pipe_ctx)
+static void calculate_adjust_recout_for_visual_confirm(struct pipe_ctx *pipe_ctx,
+	int *base_offset, int *dpp_offset)
 {
 	struct dc *dc = pipe_ctx->stream->ctx->dc;
-	int dpp_offset, base_offset;
+	*base_offset = 0;
+	*dpp_offset = 0;
 
 	if (dc->debug.visual_confirm == VISUAL_CONFIRM_DISABLE || !pipe_ctx->plane_res.dpp)
 		return;
 
-	dpp_offset = pipe_ctx->stream->timing.v_addressable / VISUAL_CONFIRM_DPP_OFFSET_DENO;
-	dpp_offset *= pipe_ctx->plane_res.dpp->inst;
+	*dpp_offset = pipe_ctx->stream->timing.v_addressable / VISUAL_CONFIRM_DPP_OFFSET_DENO;
+	*dpp_offset *= pipe_ctx->plane_res.dpp->inst;
 
 	if ((dc->debug.visual_confirm_rect_height >= VISUAL_CONFIRM_BASE_MIN) &&
 			dc->debug.visual_confirm_rect_height <= VISUAL_CONFIRM_BASE_MAX)
-		base_offset = dc->debug.visual_confirm_rect_height;
+		*base_offset = dc->debug.visual_confirm_rect_height;
 	else
-		base_offset = VISUAL_CONFIRM_BASE_DEFAULT;
+		*base_offset = VISUAL_CONFIRM_BASE_DEFAULT;
+}
+
+static void adjust_recout_for_visual_confirm(struct rect *recout,
+		struct pipe_ctx *pipe_ctx)
+{
+	int dpp_offset, base_offset;
 
+	calculate_adjust_recout_for_visual_confirm(pipe_ctx, &base_offset,
+		&dpp_offset);
 	recout->height -= base_offset;
 	recout->height -= dpp_offset;
 }
-- 
2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D3EC25B7A
	for <amd-gfx@archiver.kernel.org>; Thu, 23 May 2024 19:20:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE76110F2A3;
	Thu, 23 May 2024 19:20:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u7cBc+6t";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A46710F2A3
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 19:20:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSufLh5qEqKJbigYxc9m2ToJE/3Yp4xIIaLRVVk+5vCjLjM1gg8EorwGAieZMxMKmOK44Q9L39n2ombkQkQuWNCNupTZiKfObTtHceiSzpSnvzEzue1K7oYk3tsQ/mjHtr/RWndxN/xzJKHLWm4rwOtaLCSTt2rzxl1Bh/eG6Xbsy9Mr+iBOxvWP3Any1tcqGsIY/bqGmHmEV2nTZ2eD3OoPS49/zhqz2cE9NOp6nNCFnnYpxtZ4CbjvyOaUOusiJ88LeIaYxm+OJhrA+Hh3LzABeaxogkqrpxd5/5xGCmOAE5+NkR1hs4sPRx/klejas0YCHM7wIMiwAtLyEXxOtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dccwFJ6Prc9fbTT2te6HWpwqFqqKTwYGpSZ/e59FVF0=;
 b=MdhF+zSiSpqtrlbapW903fieQ8PZTyWafa/SmgL/gE6hfYNXPIiHhUdxfLrs9XHRFtjqwCv3wsJ8YNmKqCYFwM5+WdwWPdA7u7TsPdlDCxIs7v+1xCQKT3GbQE5gOblpuXsUshgt/WnE5HEuRJewg7HSRqN9McySiSVtQOs4C6024Q4A+FRLkUdZKOi/2pUl8/gtockf5dyfMQr8S59nECv7IZoJLgyKc5p/jm59NrpQDnsKeBM3eaQRobi0ycV5eFip/KIop7SjsvQHRoLqe46hm0ZD8OlnHMVLEj+oOsOlJp5KorRydeboJJ0fcQIItze8VaE0tAaBDTuhWj+LbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dccwFJ6Prc9fbTT2te6HWpwqFqqKTwYGpSZ/e59FVF0=;
 b=u7cBc+6ttXKAvX1YiK3FhX2yENlzhRagfv7JtwNbLT94+fmXnADPeF7ZevfMRt6WCZ32YAfS9hJ8qB5nRvinrhrA5Cl5m3K0w065HvhdK4/pzfmg1VhNySz/Vd1X0FICh9jPkengtjkgcosOfcFqDmn7WdSnZ2i6xqGaIwWIkRQ=
Received: from BL0PR02CA0033.namprd02.prod.outlook.com (2603:10b6:207:3c::46)
 by DS0PR12MB7629.namprd12.prod.outlook.com (2603:10b6:8:13e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 19:20:45 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:207:3c:cafe::10) by BL0PR02CA0033.outlook.office365.com
 (2603:10b6:207:3c::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22 via Frontend
 Transport; Thu, 23 May 2024 19:20:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 19:20:45 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 14:20:45 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 14:20:44 -0500
Received: from debian.net (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 23 May 2024 14:20:39 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
 <rodrigo.siqueira@amd.com>, <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>
Subject: [PATCH 03/13] drm/amd/display: Remove unused code
Date: Thu, 23 May 2024 19:20:17 +0000
Message-ID: <20240523192027.50630-3-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240523192027.50630-1-aurabindo.pillai@amd.com>
References: <20240523192027.50630-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|DS0PR12MB7629:EE_
X-MS-Office365-Filtering-Correlation-Id: 921df507-b8fb-46d7-5183-08dc7b5d7214
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aLpVpIQN0K/Ykz2mQIRSQH3PzXznj1h2m5ILuZwm3XFgA6BQZbixJsfxjHr7?=
 =?us-ascii?Q?/JNNMNq//wIWqM8QuBAtK8l3bMyDA75IxzcLfKg3/mR/58yTHOyZhsX3NsTi?=
 =?us-ascii?Q?1vJBuWlf/9QEvyJqsqZLc2rc05YSWhyewp4oi5Upzhjqbb9NTKKy7cXjF/hi?=
 =?us-ascii?Q?3HlShjtWvOMG1pC0gX+yuqpvJUr7SQzFu0zPJCi13DOVlvBjGs6A7QqstAsi?=
 =?us-ascii?Q?QQM0uszEV35TyE2OLdU/tUA4W7arTfVTaYqsggCuEqDj/vbe6IhhP/K0M22Z?=
 =?us-ascii?Q?52RB3Qa7hAfoEGU7Yh2KKXsU9WP7HbXF475c/5dDCgs1N1JaqkWoV/43R9B9?=
 =?us-ascii?Q?y+La3VExWQ6vGEUd44O8OzlDh1kIOFhRCdXFVPG82rbXKezhdNcOkcaiOX+S?=
 =?us-ascii?Q?fGhK8wOwoZWBlXkBi+Z+C524bV0RN2faBmX459nf9r6UHXHwwoMyNlyDGdIS?=
 =?us-ascii?Q?M+t/CID6bRTv1DJZ6ETm0ucC6G95COstepKyEqvcViUige67rzOikPfD9CqD?=
 =?us-ascii?Q?4ayyAU6G7dW/Y1OjutjgqGPorBQuYmVtzFWWEJXF8QqH9JmZP47xRpmzow7K?=
 =?us-ascii?Q?zofDo+T0IhFoACW74E4jP7GeTLQALx14d149jKczdMGwGBAEIsGQHaVp4VWG?=
 =?us-ascii?Q?Gh47yfxw6C8uRdO9B1Wa1WtE2/LB9BWPq3kDLFiqVQNLBgOgiLTSYDLZlYkP?=
 =?us-ascii?Q?VmFx4STXcrzhVyQ1tS5A6vB95lqsd2FrarMpHKDm9/mavYZ0bKcfLnv5aF3d?=
 =?us-ascii?Q?Ou06XQyR8zCGIv+SbxISuXB5Z1990uBNASLlSW8D+UsN83OzIso4nJpMXPnT?=
 =?us-ascii?Q?fOJzfBHLTfSVwrPHVAWEiSxOqQTGom9go9GRo8qUd68TIdyjoZLQcp6qPowC?=
 =?us-ascii?Q?4B08TY+xcVvFEoaeFNy2EEXRt0lYb97J54Y6nMGXWPCkoRQ7KqRlJjJAv5Di?=
 =?us-ascii?Q?aE5sU7m1tHMSrH0ojnwqEm/9n8bq/QVF4FZubNG7LMkzZlZhptVQSy96NKDM?=
 =?us-ascii?Q?Aqy8sZSd7IXVop4B3BeOQU2LOovzKpaNSn5Q2O9xlVsS6UReNA/gmc+yHqO0?=
 =?us-ascii?Q?b8A0xTAPCuFPG48c3hkp6BwSXa4vcf4CxIu5DQFVWnKlMHV58Bw5hWNOfLZR?=
 =?us-ascii?Q?4lwJSxwmimCDmU9JCQPN/xMlQwFAwkrkwTAOLIAyzb+EJq6n/Vykys0dVEU1?=
 =?us-ascii?Q?tWRlNMUEWBfDRZRsG3NxzdFFfxolIlFSivoB7GERfyfsRhegIViwGW0/RbP5?=
 =?us-ascii?Q?WfNmWDaOS/lst7uEZTjZLOtsazZCIHh9zGhnKgHPP1HC3qGmFtgDkZeZx/uq?=
 =?us-ascii?Q?TgzqR8MhDrv5Qix8ul8Wy+ZJyvSrBAptZVjoTmLXr4xcoYvwVcRinycK3DCW?=
 =?us-ascii?Q?MiA4Rldil7XHPiOl+wOe1bjAEwer?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 19:20:45.5408 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 921df507-b8fb-46d7-5183-08dc7b5d7214
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7629
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

This commit removes some unused code with the required adjustments.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                         | 1 -
 drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.h      | 2 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c                 | 5 -----
 .../gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c    | 6 +-----
 4 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 1055970d3888..31e3371b1b2e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1587,7 +1587,6 @@ struct dc_plane_state *dc_get_surface_for_mpcc(struct dc *dc,
 uint32_t dc_get_opp_for_plane(struct dc *dc, struct dc_plane_state *plane);
 
 void dc_set_disable_128b_132b_stream_overhead(bool disable);
-bool dc_get_disable_128b_132b_stream_overhead(void);
 
 /* The function returns minimum bandwidth required to drive a given timing
  * return - minimum required timing bandwidth in kbps.
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.h b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.h
index 1aaae7a5bd41..4bc85aaf17da 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.h
@@ -726,4 +726,4 @@ void dpp401_set_cursor_matrix(
 	enum dc_color_space color_space,
 	struct dc_csc_transform cursor_csc_color_matrix);
 
-#endif
+#endif /* __DCN401_DPP_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index b9d10e95ef7a..a1727e5bf024 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -1261,11 +1261,6 @@ void dc_set_disable_128b_132b_stream_overhead(bool disable)
 	disable_128b_132b_stream_overhead = disable;
 }
 
-bool dc_get_disable_128b_132b_stream_overhead(void)
-{
-	return disable_128b_132b_stream_overhead;
-}
-
 void dc_dsc_get_default_config_option(const struct dc *dc, struct dc_dsc_config_options *options)
 {
 	options->dsc_min_slice_height_override = dc->debug.dsc_min_slice_height_override;
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
index 597817b51228..054607c944a3 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
@@ -880,12 +880,8 @@ static void dcn401_program_compbuf_segments(struct hubbub *hubbub, unsigned comp
 				+ hubbub2->det3_size + compbuf_size_seg <= hubbub2->crb_size_segs);
 		REG_UPDATE(DCHUBBUB_COMPBUF_CTRL, COMPBUF_SIZE, compbuf_size_seg);
 		hubbub2->compbuf_size_segments = compbuf_size_seg;
-#ifdef DIAGS_BUILD
-		REG_GET(DCHUBBUB_COMPBUF_CTRL, CONFIG_ERROR, &cur_compbuf_size_seg);
-		ASSERT(!cur_compbuf_size_seg);
-#else
+
 		ASSERT(REG_GET(DCHUBBUB_COMPBUF_CTRL, CONFIG_ERROR, &cur_compbuf_size_seg) && !cur_compbuf_size_seg);
-#endif
 	}
 }
 
-- 
2.39.2


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F38ECA5FD7
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jan 2026 22:33:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1526810E89A;
	Wed, 21 Jan 2026 22:33:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BnEPIY48";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013052.outbound.protection.outlook.com
 [40.93.196.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28A3210E894
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 22:33:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ioXdTz5PxJWMfUa1cAdL8+C3fJwPg9UsHzDKGEBZZcQkdfnt+XChIVR/nHfnSFtZkn0zysC7ZXAbo1hPNS06VHr/6AKAA527mqr6eJx006ZJiyAXuEJA+GbsM43pzBQdy0QmYMrRvNmGNKZDK3+pjtROy9V20J2T9rP9yMHiYaEILM4WrnUeApbAuh0HY0QMxHWicUacNmmFjotYygXV3rppgE3k1VqKu/PlVsFDZwA+R3yQzDG5ZMV76nNtO5klSYje/HvpT1D6j/cL/U3uFYcbpJhBEosthmE8/bnxIUQpEto5cwnKAmBlZb5dxtpP3rxPZn4BZwl0qeIsz4MvQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rokYkjEkV7SH5aUGwzBS8LwSryIw7+DWzAQzOhV7o/4=;
 b=urVjn97119uoyCPnzOpJMXLcJ4dlw6xMr9hyhifGSfjDeHlnCzO5iw22Vf3rXWPlh6ivTqebjJBsh71/Z7thR2j7aJtLBi10aybPSM5bvqAzS3hzUNSjPd//RmCHrbQQUimHIuZZd8KO/jr0kIC04WgqfXFyc1FMgFGspugyntG+wjclbfAY+1b1Rv1jC66NiuxpIvtLJ3tJK7nDFuAo6m/vK7tk00dB8pcxprJIhhz4E+A9CXLpO8fov7pk5rrxSH69DxSy76OdVPMAnW3OgCfYJ9EowpZQl8Ls7gx3nJuxf+ZE2H2uLuCT4bKd7KXr4HZk1wYWn/UMrb7dm7X07w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rokYkjEkV7SH5aUGwzBS8LwSryIw7+DWzAQzOhV7o/4=;
 b=BnEPIY48akmuNrnfyKqojVSAJWBsyTpbi2zlcI/ouUUB/ff6HMqfHrjTH53YSYMb258E+lZpUpeWOMnzOY0uH98DPJBJrnGtRSLXCD6XkEqH1NI+Oropo+onb7iXfTDOhaV+nEr9e21gi35vIBp8ySmf/kPuOu+BXcCgikfDaR0=
Received: from SA9PR03CA0022.namprd03.prod.outlook.com (2603:10b6:806:20::27)
 by IA1PR12MB6306.namprd12.prod.outlook.com (2603:10b6:208:3e6::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 22:33:16 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:20:cafe::fb) by SA9PR03CA0022.outlook.office365.com
 (2603:10b6:806:20::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 22:33:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 22:33:15 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 21 Jan
 2026 16:33:10 -0600
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 21 Jan 2026 14:33:10 -0800
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Bhuvanachandra Pinninti <bpinnint@amd.com>, Martin Leung
 <martin.leung@amd.com>
Subject: [PATCH 11/13] drm/amd/display: Migrate HUBBUB register access from
 hwseq to hubbub component.
Date: Wed, 21 Jan 2026 17:31:47 -0500
Message-ID: <20260121223247.186241-12-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121223247.186241-1-aurabindo.pillai@amd.com>
References: <20260121223247.186241-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|IA1PR12MB6306:EE_
X-MS-Office365-Filtering-Correlation-Id: 53c8bb0f-ce1d-4d1b-97cb-08de593d11ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kJcMVEuEoh2k4BpqkYywjidOxoPrHBFRFgigH3ZABy91eI+4A+RBaBtE4bmw?=
 =?us-ascii?Q?uLnDc/Ezu1agrIOGUBwfAcbbUkWszk7C5c5SDVKHiF0+9oJsR2XKyJA+VTGB?=
 =?us-ascii?Q?KtIM3OISwDTy7rwoMsXTtqeuf7GeRLX2c8VGDbsss9mVKLToRDuVTAb7UUNS?=
 =?us-ascii?Q?f38qtL3AqmvlDoqDQ4VzZesJWB7+7XTqb2HoY50eGpV01V6/7aShhyxd2Lnn?=
 =?us-ascii?Q?KasLHVJ87k+SLgW/c2lpJ8JqSsWtPHEr0zH6Tc7ri86w75dNEiTrtHORukRc?=
 =?us-ascii?Q?qfY4CuEoNE8zjIgIjAYGQs/l5qQrDZl5umxwuL8h4wvnUIoDj6ZkrET5zvYv?=
 =?us-ascii?Q?3zbB8zLt6eRKdrA6GhKWR9ejAaqVVlTXRZ4r2md64LUzGyCCHr4E6Raw2riw?=
 =?us-ascii?Q?Blc6s1RAq6m4RfM0kWeROe5u+WLWcLiUcbSdwmBBUqJGwFls8SBMxuVGAGO4?=
 =?us-ascii?Q?U76gfScnJEyC0RUgR4pt4DeKGREW152gQEzGGHIVDNLUoiY1vfTrh/HRT6RK?=
 =?us-ascii?Q?ZhkOQSVKtFyVzkOgNmeZq6DJuM7MnPGrz64mnVGlE+ts5g4NVwKXadRbiox7?=
 =?us-ascii?Q?vEAgwpz0V7aVp5DzeEPcEJbUb95Bhwx8qPR0Wsu8WS4pMQN5enLTTGv4jeUf?=
 =?us-ascii?Q?Ym7gxMlDvg8chZ/Q47XesYhYUEGsbXA8yaFo7BueJ0z56ee0ypaaUZ9HhG6E?=
 =?us-ascii?Q?eAy8sdi8dJ2nujGdVGQ+r2PIGRLuM5qff6YRcLtDjIZgK2fkTgJNNnFK76cZ?=
 =?us-ascii?Q?q8vIV7rBsQ1hFumZ0sEMvFgcfFOdW0SiLypwvCILunxEjptsiXIa5SCgQU1a?=
 =?us-ascii?Q?pp2UagJknb+CB5n/XSF4/rlhNlw3h0mp2c+LDVNMnr/GsNdn4KoTUOUucxB+?=
 =?us-ascii?Q?cVC5yrrpzaFLrzmFhX/xBZgxZZMI9mOOKL+ebB+bYi2AyjZRvAl2CzzBCRsy?=
 =?us-ascii?Q?qV2W7ZKFxcUN7okr9ammDdJsS0sCfTvQhhKbh/bfu4JLkSHqZgfplDduPfy9?=
 =?us-ascii?Q?0oXYM555JxAom9ih6ECB3C7laiJNFxWoImojQvtSPf4A3ehQfNpWJsSG9knu?=
 =?us-ascii?Q?NpkXeKKMfIh5zMYl6HMt0x5+FrjgMrOGW8q8woD51ybdK3M4KY31ZbK1V3Hk?=
 =?us-ascii?Q?0z4dsgf2wEA4mGHkeAvBxiPJyjy8rO9myt+oRJvH+qy8UACnZ20jHa5VJ4u/?=
 =?us-ascii?Q?tvYq49bdlxtSRf5MOebu2M50MVHvYC4ih9rquGD2NjH+1OQx/3OQB8Rg9ux6?=
 =?us-ascii?Q?iKVVrHlCmdW0INZnKz8njNK3oaXL69vIBEqnWgfAt3hd/rdvvZk4MY9DYK18?=
 =?us-ascii?Q?Wq9gCnmnI0niRXg5aPQCAswFxc4q1KsesFEE5mMiUJOpA6qFIZoANftDHcMd?=
 =?us-ascii?Q?CVuzrLuxzVZEH7kDKZceLht858Fx870VDBv0rDXeSFdx6bcI6MquCcANr6Zi?=
 =?us-ascii?Q?U6TqNOx6rTcXHV7IHp87V3L/Q7OvL3GYsg3Mgee+9AA8dQzpLoeya82Hx/ru?=
 =?us-ascii?Q?kkody19wIkMhGaeDVMKtmVGYUvFpxAW9g75Nn7JuOi52tNDgcEUQSN7muDHa?=
 =?us-ascii?Q?uyBhaaYSFtdUkPIAPMHFx+bK1T0TLn4aBpiwZjz2aOEX8QjvJEWYPIZI749P?=
 =?us-ascii?Q?7MAnzlGI5VnC8waTVxVNnJ47SGI1E29a1vyKAD+HkPkyzFEbJPnlNmx93Aa4?=
 =?us-ascii?Q?Ov9MRA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 22:33:15.9170 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c8bb0f-ce1d-4d1b-97cb-08de593d11ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6306
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

From: Bhuvanachandra Pinninti <bpinnint@amd.com>

[why]
Direct HUBBUB register access in the hwseq layer was creating register conflicts.

[how]
Migrated HUBBUB registers from hwseq to the hubbub component.

Reviewed-by: Martin Leung <martin.leung@amd.com>
Signed-off-by: Bhuvanachandra Pinninti <bpinnint@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../amd/display/dc/hubbub/dcn10/dcn10_hubbub.c | 18 ++++++++++++++++++
 .../amd/display/dc/hubbub/dcn10/dcn10_hubbub.h |  4 ++++
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c    |  3 +--
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c    |  4 ++--
 .../amd/display/dc/hwss/dcn201/dcn201_hwseq.c  |  1 +
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c    |  1 +
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c    |  1 +
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c    |  1 +
 8 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.c
index 7847c1c4927b..97ef8281a476 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.c
@@ -944,3 +944,21 @@ void hubbub1_construct(struct hubbub *hubbub,
 		hubbub1->debug_test_index_pstate = 0xB;
 }
 
+void dcn10_hubbub_global_timer_enable(struct hubbub *hubbub, bool enable, uint32_t refdiv)
+{
+	struct dcn10_hubbub *hubbub1 = TO_DCN10_HUBBUB(hubbub);
+
+	if (refdiv > 0)
+		REG_UPDATE(DCHUBBUB_GLOBAL_TIMER_CNTL, DCHUBBUB_GLOBAL_TIMER_REFDIV, refdiv);
+
+	REG_UPDATE(DCHUBBUB_GLOBAL_TIMER_CNTL, DCHUBBUB_GLOBAL_TIMER_ENABLE, enable ? 1 : 0);
+}
+
+void dcn10_hubbub_read_fb_aperture(struct hubbub *hubbub, uint32_t *fb_base_value, uint32_t *fb_offset_value)
+{
+	struct dcn10_hubbub *hubbub1 = TO_DCN10_HUBBUB(hubbub);
+
+	REG_GET(DCHUBBUB_SDPIF_FB_BASE, SDPIF_FB_BASE, fb_base_value);
+	REG_GET(DCHUBBUB_SDPIF_FB_OFFSET, SDPIF_FB_OFFSET, fb_offset_value);
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h b/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h
index 0a29a758d013..990d3cd8e050 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h
@@ -519,4 +519,8 @@ bool hubbub1_program_pstate_watermarks(
 		unsigned int refclk_mhz,
 		bool safe_to_lower);
 
+void dcn10_hubbub_global_timer_enable(struct hubbub *hubbub, bool enable, uint32_t refdiv);
+
+void dcn10_hubbub_read_fb_aperture(struct hubbub *hubbub, uint32_t *fb_base_value, uint32_t *fb_offset_value);
+
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 73f469ce7cdd..c1586364ecd4 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -2678,8 +2678,7 @@ static void mmhub_read_vm_context0_settings(struct dcn10_hubp *hubp1,
 	uint32_t fb_base_value;
 	uint32_t fb_offset_value;
 
-	REG_GET(DCHUBBUB_SDPIF_FB_BASE, SDPIF_FB_BASE, &fb_base_value);
-	REG_GET(DCHUBBUB_SDPIF_FB_OFFSET, SDPIF_FB_OFFSET, &fb_offset_value);
+	dcn10_hubbub_read_fb_aperture(hws->ctx->dc->res_pool->hubbub, &fb_base_value, &fb_offset_value);
 
 	REG_GET(VM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32,
 			PAGE_DIRECTORY_ENTRY_HI32, &vm0->pte_base.high_part);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 16ea6179640e..a76436dcbe40 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -46,6 +46,7 @@
 #include "dchubbub.h"
 #include "reg_helper.h"
 #include "dcn10/dcn10_cm_common.h"
+#include "dcn10/dcn10_hubbub.h"
 #include "vm_helper.h"
 #include "dccg.h"
 #include "dc_dmub_srv.h"
@@ -3153,8 +3154,7 @@ void dcn20_fpga_init_hw(struct dc *dc)
 	REG_WRITE(RBBMIF_TIMEOUT_DIS, 0xFFFFFFFF);
 	REG_WRITE(RBBMIF_TIMEOUT_DIS_2, 0xFFFFFFFF);
 
-	REG_UPDATE(DCHUBBUB_GLOBAL_TIMER_CNTL, DCHUBBUB_GLOBAL_TIMER_REFDIV, 2);
-	REG_UPDATE(DCHUBBUB_GLOBAL_TIMER_CNTL, DCHUBBUB_GLOBAL_TIMER_ENABLE, 1);
+	dcn10_hubbub_global_timer_enable(dc->res_pool->hubbub, true, 2);
 	if (REG(REFCLK_CNTL))
 		REG_WRITE(REFCLK_CNTL, 0);
 	//
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c
index 1635e5a552ad..482053c4ad22 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c
@@ -39,6 +39,7 @@
 #include "dccg.h"
 #include "clk_mgr.h"
 #include "reg_helper.h"
+#include "dcn10/dcn10_hubbub.h"
 
 #define CTX \
 	hws->ctx
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index 81bcadf5e57e..c02ddada723f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -36,6 +36,7 @@
 #include "dcn10/dcn10_cm_common.h"
 #include "dcn30/dcn30_cm_common.h"
 #include "reg_helper.h"
+#include "dcn10/dcn10_hubbub.h"
 #include "abm.h"
 #include "clk_mgr.h"
 #include "hubp.h"
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
index 20f700b59847..2adbcc105aa6 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
@@ -32,6 +32,7 @@
 #include "dce/dce_hwseq.h"
 #include "clk_mgr.h"
 #include "reg_helper.h"
+#include "dcn10/dcn10_hubbub.h"
 #include "abm.h"
 #include "hubp.h"
 #include "dchubbub.h"
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 2675d7dca586..f7e16fee7594 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -32,6 +32,7 @@
 #include "dce/dce_hwseq.h"
 #include "clk_mgr.h"
 #include "reg_helper.h"
+#include "dcn10/dcn10_hubbub.h"
 #include "abm.h"
 #include "hubp.h"
 #include "dchubbub.h"
-- 
2.52.0


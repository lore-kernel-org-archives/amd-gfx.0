Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B301D35664
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 01:59:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3121310E5F9;
	Wed, 28 Jan 2026 01:59:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D3lqvi4S";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012057.outbound.protection.outlook.com
 [40.107.200.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E69010E5FA
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 01:59:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BIbTixU0IIKamBTpPm9hzzZ1qed4tmreJ+RqNTgMQ6oEbvJesqslNAzY1XeFi4pcyOcFHgpn5LL8G5qNBwXGWgieTHkUb5AljbiCGVXjv+KqL8wZ9hiXdwMznwDqnReRDi5EFUtANlndrQPPOH9+TRIVFRCCa5QAgi0nci2jQiHQKNKU1EGuNRMvTiR1P2hqIASKcGpLwHfyz5A7DAHXMcQfSZbO/H51oBKZzaNiIeMi26WvaDH9JzqU4w+6+ypuGV/qFerRMVmWOJW4ML57HckWQEijvKMdRQ7SXx9mxheRGRE+ug55xlRrWGEWw5vK9WKjbEiBzBHtV5/RpPH7RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCS73Di1oO7OSIlFBoH9Rb3QXAcFfd/EcpDehQF68i4=;
 b=CqPIkqki33Qa/QUarjG+rGF+aGoXNZiox0EBZdzV8uEhX+O8ghvO14uATndUkxG+eeYDxl8ms8VoXgQ4OgE8uHZd1AMpmly7qppdKIT0M/wX9Uvgm7c7P0Dc9VY168cKhizY46FjK7SybvQcFJEM+NQXty9bwvw+o4Fn+/PK9KYcBJLxFxj0qvif5QtMdTYxfyPhzmCbxt8nZjbZGP0KHs14fXfkbx8WbmyjiUO1Rr22E81aGaTY7tFt5u45f73alXQ1bCXqyBBSqjgaKpolfAivzVLr5lUsc06/AN6ApRKpZTYmzOmLli9pTJTDMl5nmEwVeNOxGCQQZnxUll1DTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCS73Di1oO7OSIlFBoH9Rb3QXAcFfd/EcpDehQF68i4=;
 b=D3lqvi4STEI/k30y+rmzF+fTTpiu71ikrKd9Y+hKEPdKsIhUFyin6IV9AVFZOJQibtlcsxSKwn4O7lgo89SbLR4xDyjQ1Q1rpFOBbfKLEXU5QvG+5zjSLEx4SNttkx7y5Jw5qRGeHtDEsewY96wRRockarDpTZm0IvC0lcDYK9E=
Received: from SJ0PR03CA0077.namprd03.prod.outlook.com (2603:10b6:a03:331::22)
 by IA1PR12MB7685.namprd12.prod.outlook.com (2603:10b6:208:423::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Wed, 28 Jan
 2026 01:59:52 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::bc) by SJ0PR03CA0077.outlook.office365.com
 (2603:10b6:a03:331::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 01:59:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 01:59:51 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 27 Jan
 2026 19:59:51 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 27 Jan
 2026 17:59:50 -0800
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 27 Jan 2026 19:59:47 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Ian Chen <ian.chen@amd.com>, Robin Chen
 <robin.chen@amd.com>
Subject: [PATCH 10/21] drm/amd/display: Add oem panel config for new features
Date: Wed, 28 Jan 2026 09:51:35 +0800
Message-ID: <20260128015538.568712-11-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128015538.568712-1-Wayne.Lin@amd.com>
References: <20260128015538.568712-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|IA1PR12MB7685:EE_
X-MS-Office365-Filtering-Correlation-Id: 81ccedcc-ca4c-49c0-17ef-08de5e10eccb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rSDmdJb2EZCxKP5rlTCbyD7AT7TGxGn/tV+ZEFmT71zN2N7NVCrCJ8l5n7MS?=
 =?us-ascii?Q?8a/yVe8UlMRywZlbpIhkgotZMqawGrasRE/VzZGi39IEjPLf01RGWwq/yhQD?=
 =?us-ascii?Q?NzpR/KkYU4ucdP202KK2M49GVQOvykPUWgEq75wSTrPImhPJ0qQrCvsj0YxB?=
 =?us-ascii?Q?a58BU9dLCsuKTpb4US46h++gwmR+quYl3A2THtwzE9Mva6iOysAPetqv6+zp?=
 =?us-ascii?Q?c7QUL++QK3Hdc9L1WXdIZq/l7CO3mpsfK0xSRoHB96hT2MbJOVHiGwoVnobn?=
 =?us-ascii?Q?hwZ+SIeaQonJEeR8iX+Yl+6AZP+PBzNRN4Qc3iid1w+T9+ggYg2cO+p+FtB/?=
 =?us-ascii?Q?J6NyUpnjBDnFX/2DxTYoKYPR1N6GP4ifkKO3a5wq3Ya7t51wK+ikfIyRol2o?=
 =?us-ascii?Q?OKhZiketzQFcHB0EBd1eaJE9h4uvlc4vxEqBvYRXzj01vuiIT+RhRFObt9Au?=
 =?us-ascii?Q?im7nk8DT8gKdgzXnH8qj0ldSeignV72w9/8XKlnEaWgvkuYNksKtVCt0BB0U?=
 =?us-ascii?Q?cHfc3Ds/XRSfGC2bPaVtGU9AIkuBW5bMLGa1mETb5wU5o2zy2NDyyQaM+k1x?=
 =?us-ascii?Q?cDzG8W9l7XiSNDEZBEhtJvWERRo/In9ENhNHn5j44zfS1U6isNyczhUJQrQc?=
 =?us-ascii?Q?FjaJYnl6GfG1eEzDpB95GAe1UVPCBuun1oAGxKeom5QGI2ElyQM2CjWd1XFH?=
 =?us-ascii?Q?QuCL3sTtqDshizjJcjU9gdIOZuBi+pSevnSX7vZ2qwJ44ahA6tbIvR5/V3D3?=
 =?us-ascii?Q?c7mF71FDuWxgUiQTqNkSEVYs0breLK02nHHiRCqlrXDWH447aMcFrGBLCf+G?=
 =?us-ascii?Q?tjrvVMD+ZbxMGPDbwwBk3YM8ojfdITrTV3KQsTF8wQuQHp6nKyaN0tc5raNE?=
 =?us-ascii?Q?+eIYjS2swH7Or7fFG0Or7kVcbiwa8Nd//yQO6b2OujFkJoNfG4KllU4ab1eW?=
 =?us-ascii?Q?z8yAmu7DNQwEF5EA9H7+u01m7O8JvSdYY1KOdxSnJkMLedHsbwZhKu/oFPOQ?=
 =?us-ascii?Q?2s6CNJ5uBN6U1EUIO077uPx8cz+Z+GezaMbfmOSLXhq5ShZ5Me9kkAXg4Rdh?=
 =?us-ascii?Q?67RjtwdIWSIpv9dSmrIT9ub1TMx2cNJQmSqKJ0wHzix4KYdEDRyHPP9+ga/d?=
 =?us-ascii?Q?m7R766x9rV/AnLLGXkQLwXfaQ+r2ggzL8I87MiTldg/Ympu1zc7jmIKS0/CU?=
 =?us-ascii?Q?k5AiQ1dcvp/yy1lx/iQm2oiDu8/5ldNK0tc8X5Z+4INMDH7x+ohjR7dQj8RS?=
 =?us-ascii?Q?E/v522lexg4SgiiD2wQkwcmG/z06LB/cxJSVStZLwYAPWItePteRU34+7cX3?=
 =?us-ascii?Q?Fb3p8fw+liKCBs2ipQY22/vvynba1J7hMzGoluDjJQLO1QhNGXLaynNNGy4a?=
 =?us-ascii?Q?6YW8DT5hASz+GomB1nZc1Jse8/BFbt8XIoFFkB26KahBvQ0FU44ppjsVqTdL?=
 =?us-ascii?Q?rTbsv+znNbUuSoOBB8tmx4yOykqxchYrt7NhjCuD77g5MuzFfpQP6Ym+mDGf?=
 =?us-ascii?Q?ryqbyFbdxpn/DFJifX0mYq51OMsC/EV6uZSkFW7uvjGrk95jZlSY+PEgxewo?=
 =?us-ascii?Q?kQYhJarxvenxWjVSCrcsTvgbA58MUX/qUPGXGRRRWLLGeoBKhsL4BNy35U5s?=
 =?us-ascii?Q?+Lvg9JEBUXIITMfPHX6xpfrgQ3W082bWY+r+xe6tjwUU400maZqw6FRG66kR?=
 =?us-ascii?Q?wKqp/w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 01:59:51.7043 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ccedcc-ca4c-49c0-17ef-08de5e10eccb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7685
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

From: Ian Chen <ian.chen@amd.com>

[WHAT]
Add oem panel config for below features:
- CACP_v2
- Adaptive VariBright
- Replay_FrameSkipping
- Replay_teamsOpt
- Ramless Idle Opt

Reviewed-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: Ian Chen <ian.chen@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h | 25 ++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 2e38b6840c71..bddb16bb76d4 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1256,7 +1256,7 @@ struct dc_panel_config {
 		unsigned int max_nonboost_brightness_millinits;
 		unsigned int min_brightness_millinits;
 	} nits_brightness;
-	/* PSR */
+	/* PSR/Replay */
 	struct psr {
 		bool disable_psr;
 		bool disallow_psrsu;
@@ -1266,6 +1266,8 @@ struct dc_panel_config {
 		bool rc_allow_fullscreen_VPB;
 		bool read_psrcap_again;
 		unsigned int replay_enable_option;
+		bool enable_frame_skipping;
+		bool enable_teams_optimization;
 	} psr;
 	/* ABM */
 	struct varib {
@@ -1282,6 +1284,27 @@ struct dc_panel_config {
 	struct ilr {
 		bool optimize_edp_link_rate; /* eDP ILR */
 	} ilr;
+	/* Adaptive VariBright*/
+	struct adaptive_vb {
+		bool disable_adaptive_vb;
+		unsigned int default_abm_vb_levels;        // default value = 0xDCAA6414
+		unsigned int default_cacp_vb_levels;
+		unsigned int default_abm_vb_hdr_levels;    // default value = 0xB4805A40
+		unsigned int default_cacp_vb_hdr_levels;
+		unsigned int abm_scaling_factors;          // default value = 0x23210012
+		unsigned int cacp_scaling_factors;
+		unsigned int battery_life_configures;      // default value = 0x0A141E
+		unsigned int abm_backlight_adaptive_pwl_1; // default value = 0x6A4F7244
+		unsigned int abm_backlight_adaptive_pwl_2; // default value = 0x4C615659
+		unsigned int abm_backlight_adaptive_pwl_3; // default value = 0x0064
+		unsigned int cacp_backlight_adaptive_pwl_1;
+		unsigned int cacp_backlight_adaptive_pwl_2;
+		unsigned int cacp_backlight_adaptive_pwl_3;
+	} adaptive_vb;
+	/* Ramless Idle Opt*/
+	struct rio {
+		bool disable_rio;
+	} rio;
 };
 
 #define MAX_SINKS_PER_LINK 4
-- 
2.43.0


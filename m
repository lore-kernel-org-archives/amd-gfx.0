Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7EF1F31E27
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 15:04:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75B9810E815;
	Thu,  9 Apr 2026 15:04:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="psfIt2pU";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012064.outbound.protection.outlook.com [52.101.48.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B016B10E813
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 15:04:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rFZvO7Gi4vtpcRcrA8Pxn5KnsXd2tM9r05MTE9cD05r81YZcy9htp3YfNyHsjCjMXzmVUqwW7WOAOonLz0aIyvqAr8mov+03ymoVSI8CYGq/Qv+b3lZHwq3CM67j6/onAjVcoOiic8RtucBq0dYfWFBzNaGM8ysipAIk8pA+k0KUmjBN9OINOUH9gUo3oa0+kRwTb2myNb2r8NHaeQ0GaYc+YTX/4gsfAkgaw6I4NEnZIyGJleY65sQObiOBfmnIDA3gws9WKUEnGSGLGZx6GlXNqiYvDub0mqr5MN/2mfPGP77XGS5oqECHMji+5DS4+v9YGYx/+rZaY6PPRPa4ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Jz4k86SsMRm+9b33cNBwNAYcFPibAdrivUZfUqaQ9o=;
 b=UBL5/U8NK61CoeiFTwdOZJmETNNXauwc/ZxYOH99oNmuRzUnT+28AxNb4nf35gayB6vjIDCxVp1yz4YWyEBVteEhWXE+kbrhxB9a6AD4o+4VwjcGTBRxwHISTBFj9m/hF5zeL79tRm1e/Zb0uuMUSziCQ0qm3cG6ZMsAR5YLUUivUoSFRmyiNPEAjfEnxijwkcv90v9t7FG4oJ9/JA3ELvhO5+l9WLeYR77MwIvdh8j75REijy7vQgmaiWr091VUSYCqFXrQyG7U/p571jnfhJ6YMr2ArH57Q9llrBCQqm2Vw9zCuhscMvwwhvRfKQYj296msFTjtXlPdletHrZZqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Jz4k86SsMRm+9b33cNBwNAYcFPibAdrivUZfUqaQ9o=;
 b=psfIt2pUZMY939mL/fDkyNFJQxsUi+vABdtkGg4Xou2kuBNPd6MLaXMCMkOBQcka5+XMc67O0JuRrrud71KPVYSngDINp/K1Y/twAmG0A8L3+u6Z1iRm4ZCbjdlMkJPhtam6VpWAYTtx9b5Tz82Jea6m0OvIR6RcZPNooldq/Pk=
Received: from SJ0PR13CA0049.namprd13.prod.outlook.com (2603:10b6:a03:2c2::24)
 by MN0PR12MB5835.namprd12.prod.outlook.com (2603:10b6:208:37a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.32; Thu, 9 Apr
 2026 15:04:23 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::a0) by SJ0PR13CA0049.outlook.office365.com
 (2603:10b6:a03:2c2::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.33 via Frontend Transport; Thu,
 9 Apr 2026 15:04:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 15:04:22 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 9 Apr
 2026 10:04:17 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 9 Apr
 2026 10:04:16 -0500
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Thu, 9 Apr 2026 10:04:16 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 4/6] drm/amd/display: add const qualifiers to watermark params
 struct
Date: Thu, 9 Apr 2026 11:03:12 -0400
Message-ID: <20260409150413.34779-5-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409150413.34779-1-aurabindo.pillai@amd.com>
References: <20260409150413.34779-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|MN0PR12MB5835:EE_
X-MS-Office365-Filtering-Correlation-Id: bc40d256-c634-4cbf-67c2-08de96494892
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: B04KnfcDevpF6FNsY8KK870MZ0aso3oPsOybNU+C8dz/raBgK5mdKWV/cAyLiHCNJKvXMdP4p9arlXo8CudUNLP98AWVIOez5BXMu8uPzEQ3thUDkceWXErtGZQuX63J9lGerpwD4pymzZTHikAqKp2Q68UR7tTFEVRQOnAnN5X3nf6SVjzbS/B8ea/yEbTKEr8aK83yGBEVR3heGaRYO1EOCQJU+ticIYzloDx2IB2lRL0Ug3YjtR3caKUQ2JX3/W2B1ee4CV8StDQKDT8YcjMWRrXl5/yvy8aT6GHVvK3bIx4LAhHubaQNiyTCv41noIkYQeIZXeRzh0MnbHjupEdcnZ6uDeTtQ7D5s/qKge0cqe+yJmkU0R7AJkQ0IdUvHrkOLo0bY58DW+kacTE9r5jAkV9glEHMdzHXzOu5KmpT0UECFA7o6btZdV10iblgJmt74WNqftqY2BF2hS/MsTssWrLJxYLibA5e4nbgb+3s5HPGDtlf1XXYw6YuE5dZ951f+7mo7Lp7Powwb1DCgWwp3yh4W/w/QZM18cZ+1OEaTI7jPFq55tF6Dli+qfqIR7+mdoE6RvIzvpPkCcRrBaRuXH4sbKdNmwphwP7klxaQ50kAM37/Dc1GpKrJoFuS5SpEqgrMiPPsPIyiavnMFnvrtsW/OOcdjfMhm5vdeUoQjdDIh/DgMOG7uZGJIAbO71dhmun8B255VpzJLxi8IWnS7fyUhS172fAe/Hwguw4nm+inL6LELOlXxOGism+djywaYBa2+hWLQLAQp5HfpA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rIhmIBVtL1Hz2cYLkFOTh1cuhBHCGm/ugwUd86Xdw1u/AOC8KsEmMmmnphpNyS5H/xwC3HduT2rx7H4H2Uk5d/WFfdqIw4xfPgAK370pjxrrTtiFIJhTakI4hKd82NvOOR35UVJgh1/qdS9TS51pVa/xOda0o9tctwoaIyiDTKYCeCGFlyagYoE03IKa12CQ178OLzSz6elCOV4p00wmqQi177bFWDCfCUfAQamuNhb1R6Fo2TWq4uK2Fj5jUpEwKltHg1T4PSEVRWdWeCimlzRF/FI6D/e3IkpIbGxiX2FY7TXRevAPAVhX02i3Gt9xECAoeaDFlfu3ao9sZI7OgWyMaR2LQRAT4CtB7OFClwv7gJLQGD5Mi9VbNzdh6RTb350pepDGtHWfnqMGlopqaAvXosDnj+uB8CGHTgFDY4j2hzgEQcWyG/VZKrjN/ruq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 15:04:22.6390 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc40d256-c634-4cbf-67c2-08de96494892
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5835
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

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
There are few non const input pointer fields. Setting them to const to
prevent future modification of read-only data.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../src/dml2_core/dml2_core_shared_types.h    | 34 +++++++++----------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
index 41d0c99d0864..987b29808ca4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
@@ -1721,30 +1721,30 @@ struct dml2_core_calcs_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport_param
 	double ReturnBW;
 	bool SynchronizeTimings;
 	bool SynchronizeDRRDisplaysForUCLKPStateChange;
-	unsigned int *dpte_group_bytes;
+	const unsigned int *dpte_group_bytes;
 	struct dml2_core_internal_SOCParametersList mmSOCParameters;
 	unsigned int WritebackChunkSize;
 	double SOCCLK;
 	double DCFClkDeepSleep;
-	unsigned int *DETBufferSizeY;
-	unsigned int *DETBufferSizeC;
-	unsigned int *SwathHeightY;
-	unsigned int *SwathHeightC;
-	unsigned int *SwathWidthY;
-	unsigned int *SwathWidthC;
-	unsigned int *DPPPerSurface;
-	double *BytePerPixelDETY;
-	double *BytePerPixelDETC;
-	unsigned int *DSTXAfterScaler;
-	unsigned int *DSTYAfterScaler;
+	const unsigned int *DETBufferSizeY;
+	const unsigned int *DETBufferSizeC;
+	const unsigned int *SwathHeightY;
+	const unsigned int *SwathHeightC;
+	const unsigned int *SwathWidthY;
+	const unsigned int *SwathWidthC;
+	const unsigned int *DPPPerSurface;
+	const double *BytePerPixelDETY;
+	const double *BytePerPixelDETC;
+	const unsigned int *DSTXAfterScaler;
+	const unsigned int *DSTYAfterScaler;
 	bool UnboundedRequestEnabled;
 	unsigned int CompressedBufferSizeInkByte;
 	bool max_outstanding_when_urgent_expected;
-	unsigned int max_outstanding_requests;
-	unsigned int max_request_size_bytes;
-	unsigned int *meta_row_height_l;
-	unsigned int *meta_row_height_c;
-	enum dml2_pstate_method *uclk_pstate_switch_modes;
+	const unsigned int max_outstanding_requests;
+	const unsigned int max_request_size_bytes;
+	const unsigned int *meta_row_height_l;
+	const unsigned int *meta_row_height_c;
+	const enum dml2_pstate_method *uclk_pstate_switch_modes;
 
 	// Output
 	struct dml2_core_internal_watermarks *Watermark;
-- 
2.53.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0937BC36002
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Apr 2025 21:42:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FB3C10E321;
	Wed,  9 Apr 2025 21:42:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="46nYadjN";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D397A10E321
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Apr 2025 21:41:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sSo7raqHghIP0l5XfjojGtVw6ZhbXNhhCDYgV1xUsj33DEe5b2RKmyIKdbjNIduJ1NUpxvnCwuuEWdxwXK3I49FRCDYD2fIu58Njp52k5hkOETGdUnvbWh1wuZzLTDmoNXcVBVzlX9aosuxVZwrI3AJ1ClzNvqexhmJgfNVMCXEJRj+zWH9xHfmIIWDYNDRQ6IyyrtaJm9ZsQDD/6jJGI4u08VFwfZlczMEtgij6BphDN6rkWIRkVt3na+7cX3uNWQVGPejFqeZRv80qhZ0KjjnAoMqbzvogJpLAbVl+D2i8xYuw8nqzJeemLbUpcNkvNteFu6mRUAG4tkpab7YWLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFY3Zi431SBg5l4gY1K626/e4nehuzj6tXXXPGzrHdU=;
 b=gNAxekHDqVdc6Fk55m4lQiWmL271artrNbm6UEsRkWqYUXLvZtBI+1qOkfqNacD1K40jYaJuykWqopyXlsEutzVBaAdtypW96qLRIwNuxi1s5wWL+RbdlnIID1w+yani2j08F5Oo+sp+zsNobvWHYqTdy2/xV/gabDhdQ5o/5y+DgVQmve7D3kYa4MfmetEFmhCrh5swll8Ide7v7f7ECh0Js7KqqL2qPJlksa9v3tMOJGptsx6KY3OTKAADc58jtpV26qItRV98vkw2YpmWwUGroE12Hoq7G4E37OOEpt5z7AIl8ixaTkOngz9L2VtzKrhCPg3KSr2iMq4h1dkFgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFY3Zi431SBg5l4gY1K626/e4nehuzj6tXXXPGzrHdU=;
 b=46nYadjNbYDClhuMw9UjU4hKpeNkd2q/79q+J3PSgDURnbAFLOXcgEoLSBgLR5kjUbkhPCgb8fgezIAOmgAfKZrQnuhHaVeaXmexDwH/0rBLtAZ7P7ZdnDdc9qYHAy99kC+XfGDliDgRDlCJL3ullxDDV4vE/eLBJH8fHdIMJQo=
Received: from BN0PR02CA0032.namprd02.prod.outlook.com (2603:10b6:408:e5::7)
 by CH3PR12MB8458.namprd12.prod.outlook.com (2603:10b6:610:155::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Wed, 9 Apr
 2025 21:41:53 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:408:e5:cafe::6e) by BN0PR02CA0032.outlook.office365.com
 (2603:10b6:408:e5::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.37 via Frontend Transport; Wed,
 9 Apr 2025 21:41:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Wed, 9 Apr 2025 21:41:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Apr
 2025 16:41:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
Subject: [PATCH] drm/amd/display/dml2: use vzalloc rather than kzalloc
Date: Wed, 9 Apr 2025 17:41:38 -0400
Message-ID: <20250409214138.1293048-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|CH3PR12MB8458:EE_
X-MS-Office365-Filtering-Correlation-Id: afd10032-7ac0-4f2f-01ab-08dd77af5763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?z+sqwMink31dZ/5eEWx8JTyBimPOfKZPDbxaN8pUHnc1N07R7ttWJwVbRwKf?=
 =?us-ascii?Q?8yQ4KcpfvokyrGIgpZ75DFyyB6qTlY8TCeJbJ/ioIRY+mwvAzS6ZJMJ4YL7U?=
 =?us-ascii?Q?35xMRu7mTExBaLjaUrlnYqeac8hosofi5yGE2ZmZ92IAK8UQaH0mKm19LOAj?=
 =?us-ascii?Q?kKaNCXTaboxl2azHzzsnYyiSqFUpzpqF1Z4uCf8mbT6ZIXQdevNVZr1B5J8I?=
 =?us-ascii?Q?sEDFCYKMGH5jK99v0kXHXxO9PlVNUbfNFcqsZ9Da1KOHlgOFyKwlsFA0cNoM?=
 =?us-ascii?Q?KubLG1LblT8FUPtjbmbvTwpjHLlK0qHZurZpY/yAcgKlr87COnpbku12pqop?=
 =?us-ascii?Q?FpMoSE2dR4SN0NuWia3QRY++o/FPY4+bAndkht58xkFv1I4/hITmcvsrWESP?=
 =?us-ascii?Q?2K9bknzWmcKPQoFPdvc0+GqWeVkcE25Q1pGxBHN2CNkeZ1yBRhyBufv+w4Ss?=
 =?us-ascii?Q?HNnc3WZGkfkD7zWP3u2gcr2KUVk6ZC/eW34ifEOpU9J+gFfUehuoEE4AaX4m?=
 =?us-ascii?Q?5bOUtFE1PNRt32aZSgv/GyQrKYjutIdBIbvBa8FkvBF+xACglcB36bthm0jN?=
 =?us-ascii?Q?B+wJ/pJ20ujLhtLxKmvAn5hfDRoOk2MUb26FOAFSfNH+0VQZSuhX3jain8+c?=
 =?us-ascii?Q?febxfyeSWFD4AkUK3S9fgocNapI0GTaAcartz8AHbSZrVh6x/xEauqxu6Xbd?=
 =?us-ascii?Q?w853CN9RtayZhcxR0GbbgMntmW+D9Wm70XtFFN2BAD3XPgUqN2jM7pqp0LDY?=
 =?us-ascii?Q?nDcU1Q5ZQzRwoHp/aD5CGx3+BYzbdYpSzNl8M3nID83s1A3ZN0xVEkYWKrUz?=
 =?us-ascii?Q?P7vxCTY46ijSJde3pQZwotsx328OE7wKh4ilkND8DXNlWAvBZJWsvqYhBV63?=
 =?us-ascii?Q?qPynGu0BFfzBukZsSyKla4jxUBdqo3UwtnXpRm7PNPCxzk97b3rhOGMGTbyo?=
 =?us-ascii?Q?T0FAmf0kElLYlfupv5l83GIkqpYF/KaWayIfdi/zpGM4Bx+giMj1Gjab6qqV?=
 =?us-ascii?Q?bRyZmJA3SnLHZG5JvLQBvsMn25nJbFmpdkSRht80MkdoW/gSG+nThvuRRuUv?=
 =?us-ascii?Q?fAZDb45TI5ry/2OcNgySbuXCgf7vnt1dGQTc6ZXK9ofR7aGpeYW/Zdb7GOOU?=
 =?us-ascii?Q?AD3nsoGBRAizQXEj1y3SzBtzxUGn4LFQkCK/ewoKQWLieI9U/2kWrxGaMagh?=
 =?us-ascii?Q?W1jDO7MtZ6EuVqUHvGFoWeZ5qkcTqgAtyzbFAwa6H63sgpmJZBsFDmZMmlyT?=
 =?us-ascii?Q?h8xNrT7g3SPWxCv7WoY5shq8fbs+pq+nvimSUPryUoagEKVSqC025rIsMuiO?=
 =?us-ascii?Q?9fvF35za5p1TDrWn3Zw0a+nM2z59MWnxgC5NvOsMRGNNZ6MilqfqxEo5el+3?=
 =?us-ascii?Q?nu5rndv8xBlU/SzOU07qKre1/+Vx0AdSK+KpsLcuQBHf/AzLXflyy0BK1Yv/?=
 =?us-ascii?Q?WR2rwzlKgFNOxZ10NREZlrOAPRonEDuSS2at5yLRCQXeT6HugSiTyA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 21:41:52.5098 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afd10032-7ac0-4f2f-01ab-08dd77af5763
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8458
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

The structures are large and they do not require continuous
memory so use vzalloc.

Fixes: 70839da63605 ("drm/amd/display: Add new DCN401 sources")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4126
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c | 11 ++++++-----
 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c    |  6 ++++--
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
index 94e99e540691c..5d16f36ec95c8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
@@ -2,6 +2,7 @@
 //
 // Copyright 2024 Advanced Micro Devices, Inc.
 
+#include <linux/vmalloc.h>
 
 #include "dml2_internal_types.h"
 #include "dml_top.h"
@@ -13,11 +14,11 @@
 
 static bool dml21_allocate_memory(struct dml2_context **dml_ctx)
 {
-	*dml_ctx = kzalloc(sizeof(struct dml2_context), GFP_KERNEL);
+	*dml_ctx = vzalloc(sizeof(struct dml2_context));
 	if (!(*dml_ctx))
 		return false;
 
-	(*dml_ctx)->v21.dml_init.dml2_instance = kzalloc(sizeof(struct dml2_instance), GFP_KERNEL);
+	(*dml_ctx)->v21.dml_init.dml2_instance = vzalloc(sizeof(struct dml2_instance));
 	if (!((*dml_ctx)->v21.dml_init.dml2_instance))
 		return false;
 
@@ -27,7 +28,7 @@ static bool dml21_allocate_memory(struct dml2_context **dml_ctx)
 	(*dml_ctx)->v21.mode_support.display_config = &(*dml_ctx)->v21.display_config;
 	(*dml_ctx)->v21.mode_programming.display_config = (*dml_ctx)->v21.mode_support.display_config;
 
-	(*dml_ctx)->v21.mode_programming.programming = kzalloc(sizeof(struct dml2_display_cfg_programming), GFP_KERNEL);
+	(*dml_ctx)->v21.mode_programming.programming = vzalloc(sizeof(struct dml2_display_cfg_programming));
 	if (!((*dml_ctx)->v21.mode_programming.programming))
 		return false;
 
@@ -115,8 +116,8 @@ bool dml21_create(const struct dc *in_dc, struct dml2_context **dml_ctx, const s
 
 void dml21_destroy(struct dml2_context *dml2)
 {
-	kfree(dml2->v21.dml_init.dml2_instance);
-	kfree(dml2->v21.mode_programming.programming);
+	vfree(dml2->v21.dml_init.dml2_instance);
+	vfree(dml2->v21.mode_programming.programming);
 }
 
 static void dml21_calculate_rq_and_dlg_params(const struct dc *dc, struct dc_state *context, struct resource_context *out_new_hw_state,
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
index 04316d719426a..525b7d04bf84c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -24,6 +24,8 @@
  *
  */
 
+#include <linux/vmalloc.h>
+
 #include "display_mode_core.h"
 #include "dml2_internal_types.h"
 #include "dml2_utils.h"
@@ -750,7 +752,7 @@ bool dml2_validate(const struct dc *in_dc, struct dc_state *context, struct dml2
 
 static inline struct dml2_context *dml2_allocate_memory(void)
 {
-	return (struct dml2_context *) kzalloc(sizeof(struct dml2_context), GFP_KERNEL);
+	return (struct dml2_context *) vzalloc(sizeof(struct dml2_context));
 }
 
 static void dml2_init(const struct dc *in_dc, const struct dml2_configuration_options *config, struct dml2_context **dml2)
@@ -824,7 +826,7 @@ void dml2_destroy(struct dml2_context *dml2)
 
 	if (dml2->architecture == dml2_architecture_21)
 		dml21_destroy(dml2);
-	kfree(dml2);
+	vfree(dml2);
 }
 
 void dml2_extract_dram_and_fclk_change_support(struct dml2_context *dml2,
-- 
2.49.0


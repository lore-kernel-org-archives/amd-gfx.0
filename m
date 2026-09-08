Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B7F6C79FA1
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:42:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7CA010EB6E;
	Tue,  8 Sep 2026 11:42:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LBASXwdS";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011046.outbound.protection.outlook.com [52.101.57.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D86EA10EB6E
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:42:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ltp0dzCXRA6HQ3JmfvGwCLqCVNGh7cmxq3FCbuYS+P6dbCqnkasyrHM2rjGQ8xPLGbYcuyTJ0nSkADM5LqP3e74JVZaEP7FJ/rpwui9jfhoBcNNH6AWQnih097o9biOQlCRSX3VDzNqlZ+WlXvgR2ce+/+vvTZbOb0OU3xPTQtWH7nnbGe4IacrpJ0g+7nmPS9J8HpURujHteIhugGnq84tJTDnUzfpCL/u3fhyC2h7E1N7hXz4kFoBexpdAwKg0NhT8PQDq1PJzezdmDSuLx/uubbrdbihO3EpzgLSjfcwEOXusv1CJGWW8nX4N7gnziWcjK1oe9MVXlEiAGLx/LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aUaVsZRdoDFRBvW/FU9fd8SfI01IHVpPwU7VPzSezAg=;
 b=jRnnGLjqoGQ0srjv0uYI1yeMlGEJMiEONluCD5xX/3dIdqAiitO3ue3OucFL4G+ALxrLwRUNcAvHawygMfB4B7XrdFiueUVoqNf56JVnhzyE4NrhT2uN1Cv6hCjp7Hyw8ZlP2c+PFmvzVan/36R5lyyk8MwrV+lGBIR++5+8F/O0GY/MP4KIv70OZIAHeDeCflMgncndmARYocJ9RMjnMxuxWlowiaZpKgV9NE+VrBQ+iffoOdShIRjrvv8mbwxcRQHV/CpnYtQQH+3rG7J+A3KPHqHzSX60qrPqP05dED3E6Sw0fEy2qHgQaSRHnEnvRHbeADUOcdqAz0HHeRkZzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUaVsZRdoDFRBvW/FU9fd8SfI01IHVpPwU7VPzSezAg=;
 b=LBASXwdSOvXQGoW7tMEa5xG7Trtwfz8T1RJt04km3FEXrZ9DhaHGG728yql3613CKTFAgJnB2IoaGPwuOVIw14IV2N2i3hfwmwiGPYXdgeKv8c4N64GjC+ut0djdb8/jitt5GBms2e8+i8IQOqBdQOkM7Sqg0vvQ0uWsZ/bM78g=
Received: from PH7P220CA0113.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::31)
 by DS7PR12MB9476.namprd12.prod.outlook.com (2603:10b6:8:250::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 11:42:38 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:510:32d:cafe::92) by PH7P220CA0113.outlook.office365.com
 (2603:10b6:510:32d::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 11:42:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:42:37 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:42:19 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:42:19 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:42:10 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tony Cheng <Tony.Cheng@amd.com>, Jun Lei
 <jun.lei@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 54/66] drm/amd/display: Add instance field to struct dccg
Date: Tue, 8 Sep 2026 19:31:47 +0800
Message-ID: <20260908113338.2433445-55-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|DS7PR12MB9476:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dd64314-a826-4d7c-2f65-08df0d9e4845
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Y8JXUPhX/3OYYns3wXLoo2gDt2chgrrHd5bViI1ahMnvBL+EGCxNKDhmoE3u571HUKUQXjR+G3vIKoMsycJx/ujj3XZa44SRPVVZTVxSK0lL5umT79VAa2Ley1f78Un05b6MV8fIDumyuz/J0HLXleqZfChIV65j2TJcVwtIKZOM03MA8CBP7QjJYTxO6+8+ZZKG8FzHdLc654VNdj6HBdtM0eCw1UvQ2WmpplNRTsBKmLfx963bdqBdTq0cESBhMRu7qRhACP7P3lNXyhejvkmG5WREClet2iBDmLXDohKSFCHyzUhLmZDNPhpyu7nRiyy+xvtbu8TA2TDYdt6JsYE6g5G5BSO+29YYAEOx91bueoS0LZEzatF+zjm/I17BsHH6nkUBwng2IY+tLzhqjDRSa4fVKCjjXgidNZn6EIst3Tq0WewCuF/YTwLmZspxA8FWJQX/P2Yy6O1k0Rr7WnJLxLXkS3l32ohsVhVqhQjpKhO8LATJmMl6/rqJNTWW5KHOT6NPTnAzIZ8c/mBonVPMwcKRdRISEbfIQVKVN+jbKMyaGSoeYsrUGpJYgJcfoI6HJ9D9ySvckeTDoFqlDoGO6XxaagT+GAOoL82N1MvENJ4uAcrEiYkYmxMXmkJlBS1Op3ApySshKI2Om1gEokQbZDTgpHOMzgY6nz1NFQFTrV1hVJd2efAtd9OL3s2ZEZSNKJjKEVNMQ2lKOW2yvA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nHF8x4NBraM1YujMyOuewStdyNAOBYKuT5G9jyIinaDzjxklTy0nGC0mxJ4PYScuh/CE05H2cuMnNYDpoRuPdTiKgU2g82nckqW0U1/SMoS4r7xr4syRjtaTazxYRo0uFtuoElprnbCaa2/7/eRzJJlaSagLdjzcjgs0naVJyFUcn0SPR+qN2eUdsBdCxSYE+AV3P1pq3k4bI18P1ocZZjUiWM2OQwHR3JribX4bRp86K7yo9NQAvW9kJI8CfLE6Gsl4uLhPv28hv397HzGoSBUl+3S2Qpt3rEL/U/CfC1NTeU7W9DPKBSWN7m60U5k7QeJiHMxT2UqTmboDmsLO+glHMM/5oFnQ/81wNfghMi7h/O4t8hs5b6U0hes70i318qe6rw+Hjde7Ovlga0+5bvxgGGUU+QsUM5KM1X1s5kWPB/v4mtg+l1cZm3AgNS4t
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:42:37.7774 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd64314-a826-4d7c-2f65-08df0d9e4845
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9476
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

From: Tony Cheng <Tony.Cheng@amd.com>

[Why]
struct dccg has no instance identifier, unlike other DC hardware
blocks. Debug and tracing helpers need one to identify the block.

[How]
Add an inst member to struct dccg and initialize it to 0 in every
dccgX_create(), since there is one DCCG instance per ASIC.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Tony Cheng <Tony.Cheng@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dccg/dcn201/dcn201_dccg.c | 1 +
 drivers/gpu/drm/amd/display/dc/dccg/dcn21/dcn21_dccg.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dccg/dcn30/dcn30_dccg.c   | 2 ++
 drivers/gpu/drm/amd/display/dc/dccg/dcn301/dcn301_dccg.c | 1 +
 drivers/gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dccg/dcn314/dcn314_dccg.c | 1 +
 drivers/gpu/drm/amd/display/dc/dccg/dcn32/dcn32_dccg.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c | 1 +
 drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dccg/dcn60/dcn60_dccg.c   | 1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h             | 1 +
 13 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.c
index 13ba7f5ce13e..71ebdd54f8f0 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.c
@@ -212,6 +212,7 @@ struct dccg *dccg2_create(
 	base->ctx = ctx;
 	base->funcs = &dccg2_funcs;
 
+	base->inst = 0;
 	dccg_dcn->regs = regs;
 	dccg_dcn->dccg_shift = dccg_shift;
 	dccg_dcn->dccg_mask = dccg_mask;
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn201/dcn201_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn201/dcn201_dccg.c
index 5b9ba9a811ea..ee27d7519d2d 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn201/dcn201_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn201/dcn201_dccg.c
@@ -82,6 +82,7 @@ struct dccg *dccg201_create(
 	base->ctx = ctx;
 	base->funcs = &dccg201_funcs;
 
+	base->inst = 0;
 	dccg_dcn->regs = regs;
 	dccg_dcn->dccg_shift = dccg_shift;
 	dccg_dcn->dccg_mask = dccg_mask;
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn21/dcn21_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn21/dcn21_dccg.c
index 1f23dfccf07a..d0735022f198 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn21/dcn21_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn21/dcn21_dccg.c
@@ -158,6 +158,7 @@ struct dccg *dccg21_create(
 	base->ctx = ctx;
 	base->funcs = &dccg21_funcs;
 
+	base->inst = 0;
 	dccg_dcn->regs = regs;
 	dccg_dcn->dccg_shift = dccg_shift;
 	dccg_dcn->dccg_mask = dccg_mask;
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn30/dcn30_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn30/dcn30_dccg.c
index 9df06df6c7f1..005ca01d7ecc 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn30/dcn30_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn30/dcn30_dccg.c
@@ -114,6 +114,7 @@ struct dccg *dccg3_create(
 	base->ctx = ctx;
 	base->funcs = &dccg3_funcs;
 
+	base->inst = 0;
 	dccg_dcn->regs = regs;
 	dccg_dcn->dccg_shift = dccg_shift;
 	dccg_dcn->dccg_mask = dccg_mask;
@@ -139,6 +140,7 @@ struct dccg *dccg30_create(
 	base->ctx = ctx;
 	base->funcs = &dccg3_funcs;
 
+	base->inst = 0;
 	dccg_dcn->regs = regs;
 	dccg_dcn->dccg_shift = dccg_shift;
 	dccg_dcn->dccg_mask = dccg_mask;
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn301/dcn301_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn301/dcn301_dccg.c
index 837f4e3d1a60..022e8d3dfce2 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn301/dcn301_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn301/dcn301_dccg.c
@@ -73,6 +73,7 @@ struct dccg *dccg301_create(
 	base->ctx = ctx;
 	base->funcs = &dccg301_funcs;
 
+	base->inst = 0;
 	dccg_dcn->regs = regs;
 	dccg_dcn->dccg_shift = dccg_shift;
 	dccg_dcn->dccg_mask = dccg_mask;
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.c
index ce90cba853f7..341509ad6f35 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.c
@@ -965,6 +965,7 @@ struct dccg *dccg31_create(
 	base->ctx = ctx;
 	base->funcs = &dccg31_funcs;
 
+	base->inst = 0;
 	dccg_dcn->regs = regs;
 	dccg_dcn->dccg_shift = dccg_shift;
 	dccg_dcn->dccg_mask = dccg_mask;
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn314/dcn314_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn314/dcn314_dccg.c
index 1a4d4cd58ad8..a71851779b37 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn314/dcn314_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn314/dcn314_dccg.c
@@ -429,6 +429,7 @@ struct dccg *dccg314_create(
 	base->ctx = ctx;
 	base->funcs = &dccg314_funcs;
 
+	base->inst = 0;
 	dccg_dcn->regs = regs;
 	dccg_dcn->dccg_shift = dccg_shift;
 	dccg_dcn->dccg_mask = dccg_mask;
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn32/dcn32_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn32/dcn32_dccg.c
index f75c5aa2d23e..52161c745a48 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn32/dcn32_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn32/dcn32_dccg.c
@@ -441,6 +441,7 @@ struct dccg *dccg32_create(
 	base->ctx = ctx;
 	base->funcs = &dccg32_funcs;
 
+	base->inst = 0;
 	dccg_dcn->regs = regs;
 	dccg_dcn->dccg_shift = dccg_shift;
 	dccg_dcn->dccg_mask = dccg_mask;
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
index 4fbd40b518cd..ba624f442915 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
@@ -2804,6 +2804,7 @@ struct dccg *dccg35_create(
 	base->ctx = ctx;
 	base->funcs = &dccg35_funcs;
 
+	base->inst = 0;
 	dccg_dcn->regs = regs;
 	dccg_dcn->dccg_shift = dccg_shift;
 	dccg_dcn->dccg_mask = dccg_mask;
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
index 7bff1b9da6f9..a4ece209d600 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
@@ -999,6 +999,7 @@ struct dccg *dccg401_create(
 	base->ctx = ctx;
 	base->funcs = &dccg401_funcs;
 
+	base->inst = 0;
 	dccg_dcn->regs = regs;
 	dccg_dcn->dccg_shift = dccg_shift;
 	dccg_dcn->dccg_mask = dccg_mask;
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c
index c9ea3b166876..cf6fffc2b26e 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c
@@ -382,6 +382,7 @@ struct dccg *dccg42_create(
 	base->ctx = ctx;
 	base->funcs = &dccg42_funcs;
 
+	base->inst = 0;
 	dccg_dcn->regs = regs;
 	dccg_dcn->dccg_shift = dccg_shift;
 	dccg_dcn->dccg_mask = dccg_mask;
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn60/dcn60_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn60/dcn60_dccg.c
index 8e2f88913e4c..eb8b7e12d2f1 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn60/dcn60_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn60/dcn60_dccg.c
@@ -179,6 +179,7 @@ struct dccg *dccg60_create(
 	base->ctx = ctx;
 	base->funcs = &dccg60_funcs;
 
+	base->inst = 0;
 	dccg_dcn->regs = regs;
 	dccg_dcn->dccg_shift = dccg_shift;
 	dccg_dcn->dccg_mask = dccg_mask;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index e756719308ab..4b7c55eeb0c6 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -193,6 +193,7 @@ struct dcn_dccg_reg_state {
 struct dccg {
 	struct dc_context *ctx;
 	const struct dccg_funcs *funcs;
+	int inst;
 	int pipe_dppclk_khz[MAX_PIPES];
 	int ref_dppclk;
 	bool dpp_clock_gated[MAX_PIPES];
-- 
2.43.0


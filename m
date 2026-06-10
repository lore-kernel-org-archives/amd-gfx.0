Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF79CD98C7
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 09:48:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 160DF10E86F;
	Wed, 10 Jun 2026 09:48:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V+TpvMcC";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011006.outbound.protection.outlook.com [52.101.52.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E51910E86F
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 09:48:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=alQ54JWwPa7nRCqGWHxrqdd8goJtjLnGlrpNnSzcw8qM4Bgtkyu3i39+LyUyKfhnH6LPKwL0t81FGBhBkIxwrLBojw0bPFj2qvO9vZZcKLEk4DvWtkC802nW2aaQ8/6kB8G+SiEIjyUtRhny+DuMxGAOZV/Jg1xxpWODhS+Qz8AmjaW1REvYnt/ztELxunMxtauvdQrmq5k1uywiSZ6D/91tfYGk8SMUeC7wHiSEf+1/QTBVIg7lGN4wTzKAPwS3fSoUcH2X0N54TlnZtpZVN4Rqulb3IFbdXue9gsuE4IdsZo/6GWiz5atBOHWjHPuYOVQDnBpheemWZ1K3SDe7dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTi7qEx4dVNAs70vGwUMiBygOIfdm+E7tPc5cLMuHqE=;
 b=sI0dTm1h2TduHz/mGTD3FNAVZinAsbgqUaJOjBpQoqi+IDs782wH8DTjkyzkIySFIKeGnva0MSlkBFHehi6Ardvga/oDqxUFU+g//BJCGUCwSuS7l6Grqbwt3EGcjNgfqYI3DwNlhp0OPyr6uyjfd2y+/3LoA0ZLYcZhEB1RV/aljQw/F+A/LS3DHR8qvKMt3KtaDc5oQ9DDRqYwLTduVIP2gFu0lw4KmLxtmhxmYNrUWIKcqjBPwOVcDkVvR62HCKNDnL2VEthe+vMm6rXcMOnJ9xe+/Y/QIGqTdNsXV3Xq2oq9Dz8eyAc+srxVW2sQcQRnvHvSpzcpYCfStBxlhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTi7qEx4dVNAs70vGwUMiBygOIfdm+E7tPc5cLMuHqE=;
 b=V+TpvMcCR74ntdFQ06EbyL9vwlMME4M4LcngN8UmZzsJJIp/SOeeWb3kaSsffw7QqYzBH2WMULriww6xLFMwnI5h8u/Fd89yoHuOL8U6Q11X4mnYHy7wcia+7y9kugnz5Gn5Q1ZCPi3qDZqGGn1BdkaiwovTadgPcXu8msqiEKE=
Received: from BN0PR02CA0018.namprd02.prod.outlook.com (2603:10b6:408:e4::23)
 by SN7PR12MB7322.namprd12.prod.outlook.com (2603:10b6:806:299::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 09:48:43 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:408:e4:cafe::8c) by BN0PR02CA0018.outlook.office365.com
 (2603:10b6:408:e4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Wed,
 10 Jun 2026 09:48:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 09:48:43 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 04:48:42 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 04:48:42 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 04:48:33 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Austin Zheng
 <austin.zheng@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 05/32] drm/amd/display: Remove unused project_id from DML2
 core instance
Date: Wed, 10 Jun 2026 17:44:49 +0800
Message-ID: <20260610094639.1965367-6-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610094639.1965367-1-chen-yu.chen@amd.com>
References: <20260610094639.1965367-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|SN7PR12MB7322:EE_
X-MS-Office365-Filtering-Correlation-Id: e59928e4-f0ea-4bc3-2b5c-08dec6d57566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|36860700016|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Yc6H4soJBZ1sLtemO3Vc8BGvK21vFFMsrKJ8uKWNAILs3/ajBT8pobbeKRE1WVKJMulpEU+LUNChoLSk1J5TZwjLc28RenHuGFI8iFqlBiQpSoJIM8XQzkMkbJ+kpj3muu4MijgutBYXBOS+7PxCMdvf5mSAXu3agKSR2aZX2yibY4kwG61jIgTOjgTT7hPFTagqrENQ0phX5kpctwC1WvYgzBbisAaEXKTPzn2IXZfz2HF7uSw9JZi/wssUT60a6l1UtwV11sG4PS6dnSW582OQM0jlPXgW12Q9ukCp/2YlefNVMau3a+SFaKDNQT2LbXxO+TzrTsFqnk+ihKGNoWUQKAihMnEE2DRFR7pIn1l2o6XdN0wyhKW7U21oYEpLlPhAxm916GkBu6FbUqJo6Md5gv2AqY2JuLR9fu2obLcw+2glQ5KeCdgGtQ7Qb59JyrUIJxPQsX4ge0MuGqcKg8dOJyQbCmQgt4uD9HCjfvUjUw2aWJ71FhwLPodOjt4cG6bq4CrZxYAl5WJsbLxSl94uq745Quo053X3JiFeycFPH4XuxWmm40Id60/GfN9iQm/o91YPoyswgal4I31EvqItiZzMJyRso91qn8Q1ivJ01PZ3X8eEB3xYF/Tq7NgHWil+EnaUcCafl8YxZuQV/ZaymTCnUlsraJkWtzcQLpphdkoone8qKsP/mpMxuLD0VurUolMib0e7n5hQQikeQVBBVej4E6c10dTlPbB1wZE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RCQExnDDltIxW4QGfeyx/cVvqPk0mLuc6uapE05M8S/IevGFv5UAzQ+JM5346jWx6+DY0DwSaWg/H1HDY3CDtxrDedSIYl3penPasba91ZsvDOOCT6xxlyhw51ML7EJJ4BqYVL2mldPCYNsugsA4a4IlH0cQDOPRGHbk3fGn5aTaQomouQ2ZNAmrnPL0zUv/jaCVuH48l0t5LtvdG8L8BMMNheZ3QdCHBOJVGTbpkQAh9x1SP+MeX9QNa51u+lfTqKbyGmFxmytDvzXvFwxe/4JsHiq8iaWaquSAFUHnroCBtIkXQAshhjBa49s3v+BzZVhWa7NgQ6aKtwiZj9zFLA4MBoMte1PWXFEyIg1ZyfHOnl739KC+u+OBjr1tVZm+uevr2qufm8T16KZ/82TWrvQK7L6zkI3W3NteKBEDy5b0Iw2d5EHSIBqyO5pEOw5U
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:48:43.2755 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e59928e4-f0ea-4bc3-2b5c-08dec6d57566
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7322
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

[Why]
The project_id field stored in dml2_core_instance and related
context structs was not consumed after initial setup and
represents unnecessary coupling between the core layer and
project-specific identifiers.

[How]
- Remove project_id field from dml2_core_instance
- Remove the corresponding assignment in dml2_core_create

Reviewed-by: Austin Zheng <austin.zheng@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../display/dc/dml2_0/dml21/src/dml2_core/dml2_core_factory.c   | 2 --
 .../dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h      | 2 --
 .../dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h        | 1 -
 3 files changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_factory.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_factory.c
index 67e307fa4310..9f1222f5a835 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_factory.c
@@ -15,8 +15,6 @@ bool dml2_core_create(enum dml2_project_id project_id, struct dml2_core_instance
 
 	memset(out, 0, sizeof(struct dml2_core_instance));
 
-	out->project_id = project_id;
-
 	switch (project_id) {
 	case dml2_project_dcn4x_stage1:
 		result = false;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
index 11e295253f72..e9f970794488 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
@@ -2329,7 +2329,6 @@ struct dml2_core_calcs_mode_support_ex {
 	const struct dml2_display_cfg *in_display_cfg;
 	const struct dml2_mcg_min_clock_table *min_clk_table;
 	int min_clk_index;
-	enum dml2_project_id project_id;
 	//unsigned int in_state_index;
 	struct dml2_core_internal_mode_support_info *out_evaluation_info;
 };
@@ -2342,7 +2341,6 @@ struct dml2_core_calcs_mode_programming_ex {
 	const struct dml2_mcg_min_clock_table *min_clk_table;
 	const struct core_display_cfg_support_info *cfg_support_info;
 	int min_clk_index;
-	enum dml2_project_id project_id;
 	struct dml2_display_cfg_programming *programming;
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h
index d328d92240b4..3ae817ea2aad 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h
@@ -489,7 +489,6 @@ struct dml2_core_scratch {
 };
 
 struct dml2_core_instance {
-	enum dml2_project_id project_id;
 	struct dml2_mcg_min_clock_table *minimum_clock_table;
 	struct dml2_core_internal_state_inputs inputs;
 	struct dml2_core_internal_state_intermediates intermediates;
-- 
2.43.0


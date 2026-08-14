Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB103C5B572
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:04:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76F4710F73E;
	Fri, 14 Aug 2026 21:04:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gIhyJMM5";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011013.outbound.protection.outlook.com [52.101.52.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB56A10F735
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:04:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TjitV50RYzHMLOMpxRvI6o+mCUXDrSpslf3Sd9W58aWgFQA6WVXTNRn0RNg3dQwvMBeKISqglNxp/wjXR0jnVrCJCbTF4P5DWU3s9KM/b9bUkFMPdZbuZcry6fyX1tVVa7osJKVxvxlmsSj5l3OxQKe73UTxjjwINGY/qx0xl6yFQUwmZMRtWcJgnNxgf06dVMVuKntIkeR2GU7Is1M6jooweQjV18XXaHDPNBRzacCrFlWMQatWDwkGzxSQzicbomCFzx4b7up+4y8pz3WLy2APCdWZBaVDrRxRO6jcW+wjryzbOUi2UxveIbgWy90egkBIecxOKecZKjDuaBgyWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJkJnBF3vlQLS3p/SFMq/xPvGL7XmROXw7HSSj3BVs0=;
 b=WXKnBQXduxEVIvdjOsYPfySINxnhRCDuH6AWyMheflgHoHBGt2NdturLQTzgW88ujpYmNjzRe7FIWgY0uwjRrNBaLs4TcVOAeC5E+mR3AZzJC1R6RIuocFevtk17PNpblSsODzsH3LWM33NLsUIHqCmHXtLefMY1WTwc7oeoTopf1iPYogkrUGHKKIIVtbjYgK5I4teMeo5aNKPu8se0ctg6S44Aa/0UXFbsOdwWkXYkhIP856WRaLg8Agr6ZXKNYWzbDmpbDbeQn77aokoGvuHvuUnwjxB2szwmbuNMwmq3+fNi8bU1W2phKtZjQf4Lisdb/oYWtKSSVhJsME8JHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJkJnBF3vlQLS3p/SFMq/xPvGL7XmROXw7HSSj3BVs0=;
 b=gIhyJMM563d+/5DaBqzM4ZEIGcYs8M4tyPt7XQiuXlEbK3Lc4M3p0yH+H7Hv90JLQL/sLTV5KAVm6Ag3qLdDnsyMDPHk8OW6Cl+4cxMzdUPin6iYkBiqZVbUzst8Pb7Qi1/hRBy3D4gv5RFrZ67dIxAEopjalBsixC+3JSEUywE=
Received: from BN0PR07CA0022.namprd07.prod.outlook.com (2603:10b6:408:141::14)
 by PH7PR12MB6738.namprd12.prod.outlook.com (2603:10b6:510:1a9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Fri, 14 Aug
 2026 21:03:52 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:141:cafe::a3) by BN0PR07CA0022.outlook.office365.com
 (2603:10b6:408:141::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:03:52 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:47 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou <tao.zhou1@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 083/109] drm/amd/ras: update interface to support multiple ras
 query methods
Date: Fri, 14 Aug 2026 17:02:20 -0400
Message-ID: <20260814210246.3067612-84-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|PH7PR12MB6738:EE_
X-MS-Office365-Filtering-Correlation-Id: 0866bfd3-dbbd-4df3-743f-08defa478b83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 13mVkevdXdkVxHJDFgwhpaOqz8PNCjno2HmyTqJ+dgiZeDnaSyM/gv98r5mkuAiPVhp1R92TiPUeV9qymf4GNxeVDS+FoxvhrtjglblVDUpoSyYRkOJFu/9mtHMVh4l+8YqQWtGd3T/nqkZ39YFPHwxtkbnw14ayD8o2VDWf+plNBlZRxUzZsD2YhOoxzbT17r7rqlMvUJzq3v099mDeZXdsBrCl2TZYBDG54iTCPsHYSQ+GAQh4tYyAZ6Nm5B1SfdEfwjhrHJhywrONgbtFZkVoWurWmppkkKFAGbQKntJMZMQg1nXtSobPkBP6840b+tjZbHMrleUL40MFvIm45ntl7FNGQAa43aeDYNLAObk/MjcQESYmeZ01hkTjsAar3P9DaEiJzQwkcFK1eKui08lrzK7m3pnclcGknmOs3b+hy1MzjG2TycD2qexGk0SS5T+2KAAwsOsOg9SKIYebl5fuZFvLh4vjzvq6oaGJhE0Lt2kvMNGf7o6/5Am4Z8RuO8IuSiXEaKBD0xqywZ/cvrBu9vHrT+9cscVM8skyQpww5DtsjgGM/pgkWh2yfnrAPL89ItV3a7ZDX3hHjpqOQqY3PqFXhHcwtaHAfPxxU/WpqT3Qxs1vcl3x/8aTp+qfngXzYE4ye/wk6JEZH2mVqD/RI2mGHl27qmpCLLm+1L1GBV98q/qAlMK2Ab9cSBnmpVge3aQm6f6IaG7D7L2uIg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uWx8JS2OZfRIjH2yWmDR4Od+zNVGYMn7/35hYVd8JguDA84LBMgyMZZc6hL7ptnC1ZjwSF6XgYIDuXmsGxJ/qLRKK+V66vt0QoJqqMZ+3HWoc305DDeBn6eeCckSaG/DIBrbPyBvvuaQXphZJV3blo5B7CSrA0btw7ExTgWFn9Nzy9mx0WU6vD0NTgm/9qoCG1Wj3e6L/pvFaTerKl/AafXv5BN34SD+w5xM2TEVIiYuxE1E95mclepkj9/PdGT703JKmZufdseBwqPpzU7JKuSWJ95sJde5YBZ231Z9SHkAJlAxQ7mIAZjtidEIAcOOnM1FxzzNjmw0zxtbdSLlnBLMB2+ZbfqJg/Vd5kAeu/fAgEyynOOBVfztF6UD79uXO7RMv9m0RPYpRGWrmy+AYgndBf6G67QXRo0/FbWltYz/C2uchiPZSZ5O92k1UhrT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:52.3064 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0866bfd3-dbbd-4df3-743f-08defa478b83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6738
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

From: YiPeng Chai <YiPeng.Chai@amd.com>

Add a parameter to differentiate callers that need new error
count vs total count, ensuring the new count is only cleared
by the intended caller.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/cmd.c         | 3 ++-
 drivers/gpu/drm/amd/ras/core/core.c        | 4 ++--
 drivers/gpu/drm/amd/ras/core/ras.h         | 2 +-
 drivers/gpu/drm/amd/ras/core/ras_process.c | 3 ++-
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/cmd.c b/drivers/gpu/drm/amd/ras/core/cmd.c
index 0c5ca4bad5840..2c328116f339c 100644
--- a/drivers/gpu/drm/amd/ras/core/cmd.c
+++ b/drivers/gpu/drm/amd/ras/core/cmd.c
@@ -43,7 +43,8 @@ static int ras_get_block_ecc_info(struct ras_core_context *ras_core,
 		return RAS_CMD__ERROR_INVALID_INPUT_SIZE;
 
 	memset(&err_data, 0, sizeof(err_data));
-	ret = ras_aca_get_block_ecc_count(ras_core, input_data->block_id, &err_data);
+	ret = ras_core_query_block_ecc_data(ras_core,
+				input_data->block_id, &err_data, false);
 	if (ret)
 		return RAS_CMD__ERROR_GENERIC;
 
diff --git a/drivers/gpu/drm/amd/ras/core/core.c b/drivers/gpu/drm/amd/ras/core/core.c
index 71c7c54ddb7c8..dc78e52de8869 100644
--- a/drivers/gpu/drm/amd/ras/core/core.c
+++ b/drivers/gpu/drm/amd/ras/core/core.c
@@ -554,7 +554,7 @@ int ras_core_update_ecc_info(struct ras_core_context *ras_core)
 }
 
 int ras_core_query_block_ecc_data(struct ras_core_context *ras_core,
-			enum ras_block_id block, struct ras_ecc_count *ecc_count)
+		enum ras_block_id block, struct ras_ecc_count *ecc_count, bool clear)
 {
 	int ret;
 
@@ -562,7 +562,7 @@ int ras_core_query_block_ecc_data(struct ras_core_context *ras_core,
 		return -EINVAL;
 
 	ret = ras_aca_get_block_ecc_count(ras_core, block, ecc_count);
-	if (!ret)
+	if (!ret && clear)
 		ras_aca_clear_block_new_ecc_count(ras_core, block);
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/ras/core/ras.h b/drivers/gpu/drm/amd/ras/core/ras.h
index a2f0491e4062b..6aad1d8779e21 100644
--- a/drivers/gpu/drm/amd/ras/core/ras.h
+++ b/drivers/gpu/drm/amd/ras/core/ras.h
@@ -429,7 +429,7 @@ int ras_core_put_seqno(struct ras_core_context *ras_core,
 
 int ras_core_update_ecc_info(struct ras_core_context *ras_core);
 int ras_core_query_block_ecc_data(struct ras_core_context *ras_core,
-		enum ras_block_id block, struct ras_ecc_count *ecc_count);
+		enum ras_block_id block, struct ras_ecc_count *ecc_count, bool clear);
 
 bool ras_core_gpu_in_reset(struct ras_core_context *ras_core);
 bool ras_core_gpu_is_rma(struct ras_core_context *ras_core);
diff --git a/drivers/gpu/drm/amd/ras/core/ras_process.c b/drivers/gpu/drm/amd/ras/core/ras_process.c
index e7f95a82fb901..395d10c94b195 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_process.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_process.c
@@ -88,7 +88,8 @@ static int ras_process_umc_event(struct ras_core_context *ras_core,
 		if (ret)
 			return ret;
 
-		ret = ras_core_query_block_ecc_data(ras_core, RAS_BLOCK_ID__UMC, &ecc_data);
+		ret = ras_core_query_block_ecc_data(ras_core,
+				RAS_BLOCK_ID__UMC, &ecc_data, true);
 		if (ret)
 			return ret;
 
-- 
2.55.0


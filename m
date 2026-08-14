Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE96CC5DF70
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0906E10F705;
	Fri, 14 Aug 2026 21:03:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h67xOdWD";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012021.outbound.protection.outlook.com
 [40.107.200.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F8AB10F6FD
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bbYmjjvcdPWNOntTustwqyMQbQC6pABH2nZ2bCrExbbOKiIhdKM4Zd9am10DbWREx6/Mk2MumZc5LOP1tjT92yS1ug4zALqzjhw24iZ26A9oZQu3CTRA6gq/IwP+gSgxeUnjEJZ0GXjklF5RgjxcNg3JUDxKY2GoGWv4dMVMD1FvY+Wvu6lJCEr99B1VfEzKZqkF8ITmPdHQsImS4p/T9uobpyvN/jmViixi1jLUGdYUt45gfx5ZjjLfquuYCNzCGQvAk0oGtF6F/k8nc5RCawo5QMsZ9jNfiHUzQ38vR718WHyJ3MlBeUc9szO5KKYIwiWVgUbMFBDHqFMPt7TUPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bg5dydwETfaYRrZWb1zC1sg5O/juPRsFj8PnJXtvWh8=;
 b=atpqCM8/SlQaY1LdbxzAYd9G53qkSjYjO+C+XGYnchQFSGE4tsCDSnz7Q1/EplpTxW3CICnOlEdJsou0dVc1hyruIB/CGePt+QAFMuRImdeanGoxoB2Pu9FyqlIJhpQGRxoRG9j03WlA7BsT0QTWqSjpccMJ2/SOwln+0ohXSKP4tDnwtV5LVWkUp4ooJZwmEC7vL2ts0dpT7zfKU0h8FKjp4GDBwaoqJI6Lnglnrmq2tWMq+bocJvMj8HgKyPjdonpg0zp9nlJCHUznH5DSr9AwKy5khq/alHNAave6ZfwkKunr+r2MURCHEG2wYkd1punO9GfAGhfc9xS6u9VLSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bg5dydwETfaYRrZWb1zC1sg5O/juPRsFj8PnJXtvWh8=;
 b=h67xOdWDS3HkI/KqYf3MnX0FOkvGHQqxgP0g2uNA8DNyejBTWqG+0PO3koBo8Ac7n8g2QAj3qAnff4ZTgZsxUTAqm3K9AlTz7SL9qt1S1qAhw1NX+mjUBrH5gh23nHq/3O4VHowhxk+w1fhobFWeHYs5Hn3s8yAqYGno/pB/4rw=
Received: from BN0PR10CA0015.namprd10.prod.outlook.com (2603:10b6:408:143::33)
 by CH3PR12MB7546.namprd12.prod.outlook.com (2603:10b6:610:149::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 21:03:33 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:143:cafe::21) by BN0PR10CA0015.outlook.office365.com
 (2603:10b6:408:143::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:03:32 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:30 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:28 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 051/109] drm/amd/ras: Add gpu rma exception handling
Date: Fri, 14 Aug 2026 17:01:48 -0400
Message-ID: <20260814210246.3067612-52-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|CH3PR12MB7546:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b37c841-ea85-47f3-d4e7-08defa477f93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|56012099006|6133799003|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: +9xI4+ZU2hG0OfBFZFQb7t1NquhCzHv5/eNfcKRWY6y2PMPmSY9iex1PLAI6cD1lMOmZXubwA8T8BJ+cTyhorMfuK8UrqUxyEdi7cwEgm4GTJNODKgTVdIgJ3/RgLNsD7dTOVHneiC3mLoVlIkDc/yxcIWJAkumALck/zjUivyNgoIuEf9OsZYt+5OCLsx9M15LoN3+NWsjUozXaYP8QqUl1MUrqvsUYTFqIzHfgUaH8Lzl7qlGvDWhC4ZbDuV7YYsG/BKETiTStmOrA6eKIs7koTRsqLUo8J/abCzW6Bw+/2NLNOWF/nu6QQVFowyYFXdNR4VHr8fOd43PEmfW5OQMraSWmf8KeYm6kSvVw9O/HsFTj8VuijIAQS9oJYrezUpmNI4BcZzR89kLGalZvipuZ2gqfJKEPhWrfYK2ORR+kqdmckPxY6wmvXJ3Dm8SMQZVOTZsJyT0GGhz1aRwDyLyvufFY3uXcbt9itsonHCqowBR3eELTGA0BV4NPuAVSykRVeDfoTlUQeeQXzY/MBTJ5H/Af4ac73a7gEjGaSjgtne9KzmCnTlf12yxj2XrulS+cPO7S9JEib/sAngkgJ2aze7E3q+yCdImllcBEYMRSN5L8ynffP9ZCLCVffOUE2bOrm0PX1cJH8TsGBBNjGa4PCpHuzH9MMQLrPVWn9CyHqwdZXoYqWbkD5Jv7YC1KMu72FQtdfE5+ykCpS2gTUw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(56012099006)(6133799003)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FJS4yZNsoLEXjK8q3khOEqypC/XXQRvzhazBccudoaSIQ+0Oyh5admY3SH/ZCxnRFVQC5KLNrZRonn1hgS1T1b3u5vhs7kj862UZqjAj6Sq1EcEBClvnhq/Cf1BoavHpjWFztymkYcULudMw8/bCRoO03KjDxAY6C2D8wjzw0p8ip+S5pFZozqZu1OO4ABYh5tHk29kf+H3Bm/m97Y0HNmQB0aPqZ7Y5Z8hob8P11E/2/g3rnu7KylT24cpRA2TZZTuV90sa19XrxM8uG1kOT7P6v4vPag67O5g/RXag0LYwH+2TcoycSK/eyqE2qUKwugvdyj+sXYVzcNW4YwolkIH4vMfqbmcZzXgnjWT8Hi3X1uN1W5Mm9zb1yw8YE7USPcYMzjNxr3CFNOYjEKMTZui5OXdjljOo8Eje2FYnNtrkOkuHpkh3JQPHdTsWVXy2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:32.2787 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b37c841-ea85-47f3-d4e7-08defa477f93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7546
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

Add gpu rma exception handling.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/core.c        |  3 +++
 drivers/gpu/drm/amd/ras/core/ras_process.c | 17 +++++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/core.c b/drivers/gpu/drm/amd/ras/core/core.c
index 8a8f5134fdac7..f093f29635888 100644
--- a/drivers/gpu/drm/amd/ras/core/core.c
+++ b/drivers/gpu/drm/amd/ras/core/core.c
@@ -287,6 +287,9 @@ static int ras_core_eeprom_recovery(struct ras_core_context *ras_core)
 		return ret;
 	}
 
+	if (ras_eeprom_mgr_get_gpu_op_status(ras_core) == RAS_GPU_OP_STATUS_RMA)
+		return -EPERM;
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/ras/core/ras_process.c b/drivers/gpu/drm/amd/ras/core/ras_process.c
index dd4a4c5673bdd..e7f95a82fb901 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_process.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_process.c
@@ -173,6 +173,14 @@ int ras_process_handle_ras_event(struct ras_core_context *ras_core)
 	if (ras_eeprom_mgr_fw_record_enabled(ras_core))
 		ras_umc_dump_fw_records(ras_core);
 
+	if (ras_eeprom_mgr_get_gpu_op_status(ras_core) == RAS_GPU_OP_STATUS_RMA) {
+		uint32_t rma_reset = GPU_RESET_CAUSE_RMA;
+
+		RAS_DEV_ERR(ras_core->dev, "Device is RMA, stop gpu work!\n");
+		ras_core_event_notify(ras_core, RAS_EVENT_ID__RESET_GPU, &rma_reset);
+		return -ERESTART;
+	}
+
 	do {
 		umc_event_count = atomic_read(&ras_proc->umc_interrupt_count);
 		ret = ras_process_umc_event(ras_core, umc_event_count);
@@ -210,6 +218,7 @@ static int ras_process_thread(void *context)
 {
 	struct ras_core_context *ras_core = (struct ras_core_context *)context;
 	struct ras_process *ras_proc = &ras_core->ras_proc;
+	int ret;
 
 	while (!kthread_should_stop()) {
 		ras_wait_event_interruptible_timeout(&ras_proc->ras_process_wq,
@@ -228,9 +237,13 @@ static int ras_process_thread(void *context)
 			continue;
 
 		if (ras_core->sys_fn && ras_core->sys_fn->async_handle_ras_event)
-			ras_core->sys_fn->async_handle_ras_event(ras_core, NULL);
+			ret = ras_core->sys_fn->async_handle_ras_event(ras_core, NULL);
 		else
-			ras_process_handle_ras_event(ras_core);
+			ret = ras_process_handle_ras_event(ras_core);
+
+		/* GPU Device is RMA */
+		if (ret == -ERESTART)
+			break;
 	}
 
 	return 0;
-- 
2.55.0


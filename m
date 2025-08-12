Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72136CA0EC4
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 07:35:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1547810E5B0;
	Tue, 12 Aug 2025 07:35:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HOAg1MG9";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DBF010E5B0
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 07:35:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eCcKu19zQMZiduWDDO7KYoPdPZWR+gHm3LLpWOUkmqYywhJdH9dOw+aVZcmejEpqKz97dazq2njNYUbVp8H3vyLTe6yzXsIWdLHJjccmBNcq/eRqBLYmzldvOnSd06fju2C1ThAWQKMXbbRNW0sm9vGqKUpqxzHTaRglfq4lVk/rJu2DHMYZuoW/a89A+yE7uNv9vvFsYOUXg0J+6jB7gEGvJWoxFi7pTHuuBwhMJdh/3v3dNlysPO9I/kWZw9TfFwknnAGsoYNL9SiYJddM04xYg2eRd83F8w99P73UH6FGgWU1r8unT0q/K17qU8rKRMvdShTRRitjyZ+0LV/DOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEfk8LxPWUbAirnpIuLWzlSHTzmFtf478VM4l7r6NBI=;
 b=H4GdZrAXs15FUeVmsEA+puk1UtF2CypE15z9jNiYFE9xjO3FHOV6SwUfMvl9mQRuU/1mmumsKy202bm87T0KdbvvIqB3w4Xj/KCAeYTQMNKNdfEBzcp4muzDqtKQTOQOZDNx6bK464ZGMxnFysVJVHidmFMxbxHzrl9dLN2yNHc6+11IQ1NGetJSefJ3GzpFlXDp37VRyg3ZIwmSM0KxliEg23La9nbHQqbD8w4d2nnUDBatdKZNH83UXD7oyil7eENrjkxDzzCm0gJVeyAQ6OQC2lfZbfIWvFH21WI7Xl3BahH+4YRLWwuMERqetKBWI+TXlKC67a87/ShXw6hAkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEfk8LxPWUbAirnpIuLWzlSHTzmFtf478VM4l7r6NBI=;
 b=HOAg1MG9Caa/ARYSRg6UrvGRXiQCw6MDPpcOsNSF5lfrgrQ+zP+m/dpBbESj8pBrkXQjByrddBwIVXXDyH0g/m8maE07d3Xev7alGSumS8yg/xjAS61KibKPNroMKAikM6+zh6iLklprXALBcgbHbhgqkuqu6zH+SNUtxkYPD7o=
Received: from MW4PR03CA0067.namprd03.prod.outlook.com (2603:10b6:303:b6::12)
 by LV5PR12MB9778.namprd12.prod.outlook.com (2603:10b6:408:300::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 07:35:15 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:303:b6:cafe::1f) by MW4PR03CA0067.outlook.office365.com
 (2603:10b6:303:b6::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.13 via Frontend Transport; Tue,
 12 Aug 2025 07:35:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 07:35:13 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 02:35:07 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <Stanley.Yang@amd.com>, <Hawking.Zhang@amd.com>,
 <kevinyang.wang@amd.com>, <YiPeng.Chai@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Correct the loss of aca bank reg info
Date: Tue, 12 Aug 2025 15:34:53 +0800
Message-ID: <20250812073453.257913-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|LV5PR12MB9778:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c7a58d7-bc38-4bb4-c033-08ddd972c6b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kBV+QCBURJqVWTz6DhMKJl+dDS8oU748x3SSpVQIspRCzGW11TCUP3NeDcUW?=
 =?us-ascii?Q?lBEiZhNJn41KbB1DddhPNRdUnjF3kmX7oD8B4xAPSltBQMBr2Xa6G3/AXLU3?=
 =?us-ascii?Q?IBO2KLxkyFxp3gfwwh3ZdV8I8Y9Xdk2wtY7jjmzgvpjCHSvNAmhnNQVZJkVk?=
 =?us-ascii?Q?b+OI3Wtf4l8kMoX43bcSboPdkWEHd2+0oyZOqVP2f0TplKbXwuowSOBYduN4?=
 =?us-ascii?Q?U/jnvI5mvBPXxd+Uw9DBB5ljj+B9aPLkPuj+3P7s6w0hByIKQfwpppfv4Eeb?=
 =?us-ascii?Q?mdMthG8MOikICkxVzvvYMQ5kjjo+/vcWRbxTxu/sBAWzbj08lMV2wVdsXkLI?=
 =?us-ascii?Q?9IRe9UiMtd4PXTWkIYtSNGW0FwLrU9ucSfBdWsFoJVyTylhXctRBoT84yFIJ?=
 =?us-ascii?Q?ivunmOM80wQJwNjVkbzFykW1MMFlh4Rst2ne/UpO4Es7HjzfHLgjcmif2ASq?=
 =?us-ascii?Q?5FLsWecE8chq/klfn0r4wYEXL75ljFwCwV2yYkIiKJmGEukNAq9H40OxyIsy?=
 =?us-ascii?Q?jC0mF1H7zcd1d3/ClgWtodtsuh1fk2LM1qE/Kuv/w0Bs/29Hvw4PPe45Mtso?=
 =?us-ascii?Q?jCnSCPma+8vwIzJYB3lGp8Ldb31DlkNJ4y6tWFYdCbh+0YC58ZvvpneULcxA?=
 =?us-ascii?Q?hZxRXlZ6hJPCtq8XiQKBeTvlhJYafBiA2EgV2vvnqngqqymC0o1yvNg6Oj1D?=
 =?us-ascii?Q?92g/eFSm23ViX5DiZ8ljWWjiGx7HZ3+Jo0WN0TDhme8ScSMe/o5wJqERtznH?=
 =?us-ascii?Q?ZtZE8Fzpj+dwcZDz24L2kqx1JQSCznOWmt2FKtgsHIbbyiYWmlsekwYn1urN?=
 =?us-ascii?Q?y47cW1w3F0mxtrBZmo6PDGlD/zVmjKnPFxXcvuC2an0/Yo9CYW5XaNaug1MW?=
 =?us-ascii?Q?5dKmYHqNMxnicvESpC2iL3LwjYKkpNkGqY6Emfu1w4BmanyHgcsM9xrgOQX0?=
 =?us-ascii?Q?01NE0NaDUTbRJB81fDmr4n/G3S+CNZ7WUUAbb7BAHHI91lzPy7WkEn10xIsh?=
 =?us-ascii?Q?AUd9YvzLigsNr0UM7tZJSoveWyh+PWmvkGCH3gvpQwFNLUTVY0KPG1Pif7om?=
 =?us-ascii?Q?GPJEJ4Rd0qTOnsDNxNrsb+ZgZD/LKO851AzsJCM8wQJR5Uul0KKbreOMSWlz?=
 =?us-ascii?Q?xmjtL6+m1qRFVTgWvRIWEwfGbe5EngefGaoM0HSeOv407JSYRhyk/jVOeEug?=
 =?us-ascii?Q?VXJQzD5jRGQ6TiBJs8hjVSXLI5TcyAgOykdQdf9Yxpmfrls5zboCziT2I8dN?=
 =?us-ascii?Q?iZ6wMd5s3VIXl7tz6l7tpouj5MDy5X9rRfbtZeqBvTPwVLA459dUkAXEnEn7?=
 =?us-ascii?Q?Lv3Kubn1101oN5FAAlUYz5B0pG9PCpapoBcjXopQmmwIFR4D2D0iS6BkTNCq?=
 =?us-ascii?Q?eJO24e7m/YFPFmGe+nC4VkktOnlZ0o9Rmc/D13pNJbAlO+sDGfxMn3oXLbd4?=
 =?us-ascii?Q?ExW6mE34zqOIkusfjXkGme5PFJNcdmOCZ0bRRDVXpDohCxMSmU29WLXqWiIg?=
 =?us-ascii?Q?AZ14/ALZHsa4nEJECqrZrkPvR1dI64DirNkg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 07:35:13.9572 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c7a58d7-bc38-4bb4-c033-08ddd972c6b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9778
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

By polling, poll ACA bank count to ensure that valid
ACA bank reg info can be obtained

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 46 +++++++------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  2 --
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  |  7 ----
 3 files changed, 13 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index f00a9e0c9c47..ad8ad08f0f33 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -122,7 +122,7 @@ const char *get_ras_block_str(struct ras_common_if *ras_block)
 /* typical ECC bad page rate is 1 bad page per 100MB VRAM */
 #define RAS_BAD_PAGE_COVER              (100 * 1024 * 1024ULL)
 
-#define MAX_UMC_POISON_POLLING_TIME_ASYNC  300  //ms
+#define MAX_UMC_POISON_POLLING_TIME_ASYNC  50  //ms
 
 #define AMDGPU_RAS_RETIRE_PAGE_INTERVAL 100  //ms
 
@@ -3317,8 +3317,6 @@ static void amdgpu_ras_ecc_log_init(struct ras_ecc_log_info *ecc_log)
 	mutex_init(&ecc_log->lock);
 
 	INIT_RADIX_TREE(&ecc_log->de_page_tree, GFP_KERNEL);
-	ecc_log->de_queried_count = 0;
-	ecc_log->prev_de_queried_count = 0;
 }
 
 static void amdgpu_ras_ecc_log_fini(struct ras_ecc_log_info *ecc_log)
@@ -3337,8 +3335,6 @@ static void amdgpu_ras_ecc_log_fini(struct ras_ecc_log_info *ecc_log)
 	mutex_unlock(&ecc_log->lock);
 
 	mutex_destroy(&ecc_log->lock);
-	ecc_log->de_queried_count = 0;
-	ecc_log->prev_de_queried_count = 0;
 }
 
 static bool amdgpu_ras_schedule_retirement_dwork(struct amdgpu_ras *con,
@@ -3386,49 +3382,33 @@ static int amdgpu_ras_poison_creation_handler(struct amdgpu_device *adev,
 				uint32_t poison_creation_count)
 {
 	int ret = 0;
-	struct ras_ecc_log_info *ecc_log;
 	struct ras_query_if info;
-	uint32_t timeout = 0;
+	uint32_t timeout = MAX_UMC_POISON_POLLING_TIME_ASYNC;
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
-	uint64_t de_queried_count;
-	uint32_t new_detect_count, total_detect_count;
-	uint32_t need_query_count = poison_creation_count;
 	enum ras_event_type type = RAS_EVENT_TYPE_POISON_CREATION;
+	uint64_t prev_de_queried_count = 0;
+	uint64_t bank_count = 0;
 
 	memset(&info, 0, sizeof(info));
 	info.head.block = AMDGPU_RAS_BLOCK__UMC;
 
-	ecc_log = &ras->umc_ecc_log;
-	total_detect_count = 0;
 	do {
 		ret = amdgpu_ras_query_error_status_with_event(adev, &info, type);
 		if (ret)
 			return ret;
 
-		de_queried_count = ecc_log->de_queried_count;
-		if (de_queried_count > ecc_log->prev_de_queried_count) {
-			new_detect_count = de_queried_count - ecc_log->prev_de_queried_count;
-			ecc_log->prev_de_queried_count = de_queried_count;
-			timeout = 0;
+		bank_count = amdgpu_aca_get_bank_count(adev);
+		if (bank_count) {
+			prev_de_queried_count = bank_count;
+			amdgpu_aca_clear_bank_count(adev);
+			timeout = MAX_UMC_POISON_POLLING_TIME_ASYNC;
 		} else {
-			new_detect_count = 0;
-		}
-
-		if (new_detect_count) {
-			total_detect_count += new_detect_count;
-		} else {
-			if (!timeout && need_query_count)
-				timeout = MAX_UMC_POISON_POLLING_TIME_ASYNC;
-
-			if (timeout) {
-				if (!--timeout)
-					break;
-				msleep(1);
-			}
+			--timeout;
+			msleep(1);
 		}
-	} while (total_detect_count < need_query_count);
+	} while (timeout);
 
-	if (total_detect_count)
+	if (prev_de_queried_count)
 		schedule_delayed_work(&ras->page_retirement_dwork, 0);
 
 	if (amdgpu_ras_is_rma(adev) && atomic_cmpxchg(&ras->rma_in_recovery, 0, 1) == 0)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index ff63020f9c6c..132b45a362c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -492,8 +492,6 @@ struct ras_ecc_err {
 struct ras_ecc_log_info {
 	struct mutex lock;
 	struct radix_tree_root de_page_tree;
-	uint64_t	de_queried_count;
-	uint64_t	prev_de_queried_count;
 };
 
 struct ras_critical_region {
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index e590cbdd8de9..8dbffe4d22d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -581,17 +581,10 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 
 	ret = amdgpu_umc_logs_ecc_err(adev, &con->umc_ecc_log.de_page_tree, ecc_err);
 	if (ret) {
-		if (ret == -EEXIST)
-			con->umc_ecc_log.de_queried_count++;
-		else
-			dev_err(adev->dev, "Fail to log ecc error! ret:%d\n", ret);
-
 		kfree(ecc_err);
 		return ret;
 	}
 
-	con->umc_ecc_log.de_queried_count++;
-
 	memset(page_pfn, 0, sizeof(page_pfn));
 	count = amdgpu_umc_lookup_bad_pages_in_a_row(adev,
 				pa_addr,
-- 
2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F24A5C27C4F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jun 2024 06:34:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 694A910E57A;
	Tue, 18 Jun 2024 06:34:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mfkioZPD";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7630810E570
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 06:34:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeTLCagSUGoOrX+X2iBRfaGsh+939smTUQjyJDEYihy4gmN+frRJytGNehA7Qc/v8z3zUN4hpzcTSRlqQVO/0wu/On/hvMbji7oFBItcfBFD5ODBJrrt8vPhrk7LAxPgeLxIE+JURWCsz12CcBb7zbESdUp72LIGF1k+MbveH86ccdzyYUQ4IMOCGHVCuxeT4XUeHKFG1pwuFZqmd9IzYpLq1p5qwJefIbGbNuIAMyWV3fV/csvGYPdnQTtL7GS8lqgrXvJhUsvu5wlLvuDTnkNkENLSK7GWIRtI0KU2WjgSkSnec+fltPUg8iPX9E16tMj0ysjj1tPQKLRfSpwFcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KeKjx7fSZvNV5jGGVnQmNR6xPqdJcUxf8X3nLyZ1yOg=;
 b=hyRCB2DBAXKNpoljvdtuYrlnE6hjzW0mGWbYutBsj5TKbURtBPUykNVoTgFRkxe1Jlj/F50yp28iLDfBNXYWkYwkTHVTHbOhf8gpiePzhyzAkcSsUD0Ec3xUNm4Ejs/CVkwFTDHgw/7YjAg+GXrfRSGDqe8SlQTvZEuR13+QZ81lEs6oU+PqH9VcqL0CpI2zHqYCnGpJXUZw25WC/KQou8uUKyLC3zaB9eB6YQQ2mA+79bwzwGSVulX49SXjR01VrP0oZ2F0+d5zcQfIRF0vQ5sm7aZOCHJYxB10kJiYq5Badyao0+VvVKHbUOHWNRRyaYtQcxp2k/7bqidj1VG4qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KeKjx7fSZvNV5jGGVnQmNR6xPqdJcUxf8X3nLyZ1yOg=;
 b=mfkioZPDc3QRJQ27Dx/PxlebZZY8VSP5bZw0FSQNeTM3mpRX7/AkXp9djOR2zXy3PG/EI+vBSAz0LyZdex8o6Y8z5ca8cJ2GEaF4fdyoXUJ2wbUAWcNhqF2HvLhp1uGV3rPcxF3h4vmJMvZO3kX85R8ANXd1gc+MyWO7Giid+L8=
Received: from SA9PR03CA0028.namprd03.prod.outlook.com (2603:10b6:806:20::33)
 by SA3PR12MB8438.namprd12.prod.outlook.com (2603:10b6:806:2f6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 18 Jun
 2024 06:34:32 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:806:20:cafe::e) by SA9PR03CA0028.outlook.office365.com
 (2603:10b6:806:20::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Tue, 18 Jun 2024 06:34:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 06:34:31 +0000
Received: from amd-02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Jun
 2024 01:34:29 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH 1/5] drm/amdgpu: add variable to record the deferred error
 number read by driver
Date: Tue, 18 Jun 2024 14:33:55 +0800
Message-ID: <20240618063359.304293-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|SA3PR12MB8438:EE_
X-MS-Office365-Filtering-Correlation-Id: 49646a63-7543-4ae6-6c0e-08dc8f60b659
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|1800799021|82310400023|376011|36860700010; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xEsxh0+Z3WLXopIgWFQwJekl/VQ4DVAIkVkTLzvXkVJmX/gkrJ0KqfLQ+WlG?=
 =?us-ascii?Q?i4yr4naCXL+xFI4uJbnxHHEByM61i2BeLQXdVtUUI/IVQpdTiBC2Vv0Sazg5?=
 =?us-ascii?Q?PgvUjO6V4XRCyKvlcWrZe+wLTfsTJ4p6FVr2kJNLDneSKsf0aGC1EyBBPOB2?=
 =?us-ascii?Q?seBwcrnU0J3sGVNuN4q3bRPjH6fr0ZDwc6tN1WSO252BIlV48mPmiAQrQJsH?=
 =?us-ascii?Q?Ax3IdIXzg2C+27Vzk6o65dh2qZ71ynDplpP4Ldnmpky3ZXqoyS/EAXv2FMW1?=
 =?us-ascii?Q?jq/z7P8umStvVvErLgb8mUxRFyK2lZRVzeQL4z4B0YrdAUW7eH8ggBNkJUpk?=
 =?us-ascii?Q?wTm+kzQjEgImmJmU/IIWDKjdbGmtxRu8AmAL1m2GzqvslNrA136+p9Alvn3O?=
 =?us-ascii?Q?Q7pOkh0L/oNgWxc+YxIvlvutOjAtgm4AebpPsGK6TxUQoHw1ayPv2DQNHWiU?=
 =?us-ascii?Q?btHrCmDB4ArMi9K1emaTImKVjw5WMIl7r0dlChSqhqPQXnRCJBAhBTj9D4dT?=
 =?us-ascii?Q?24CIK42dn1G0Tm74VUQJ+JSxITNcYYRCeyo99PkJX2SvG5NCZ18xpsIl2zIX?=
 =?us-ascii?Q?GTDviUCQ4XvtONICkCwXndNHqiJqiuJ/7CBBpZSFow81MCtR14kXIlx0Pvjs?=
 =?us-ascii?Q?AvVeSbV2dUUAQa/xdjdHk0EB1e+ctMATOTT8YqoTBvJRdjJi9pBXPDw0qas2?=
 =?us-ascii?Q?FOOcUI+R2Dhs41UnrAYjcrNW4UVcW+8k1gLIyDNA1sEovdm1BD28/BPUchRx?=
 =?us-ascii?Q?xkUHI6C0J3P/aS1DXDuYuiFm18uTwG6xCI/W8vZ+jQwB/4m3TvbieWVsPYr4?=
 =?us-ascii?Q?08JXK2KKWO5PUyboxa+h7TlUZbDsuer+5OBNMp5sX51h1yGDthIv+abJy4tT?=
 =?us-ascii?Q?RYFySIBZ5BWLEaCebFkij3Y38iyhtdIgVDrv30L7m6EbLQdlEPJqrRCdhA12?=
 =?us-ascii?Q?gAVVOUbOTDr/s/oH+hFo2q/bcZogq4SESRfXSOLgz6kBAdyKz+jf13GOOXeO?=
 =?us-ascii?Q?0of5iMLqZ1QlYnb66RZ7Nu5+O1J12KLRGV1ztZtm0z5oRZH71ZUUi0HlKVcB?=
 =?us-ascii?Q?ivsQuKB1s2DLf/xvQU9tTs8+5EdMGVzieC0EHtsGTPXfb5+10D0YMdl5Tj4U?=
 =?us-ascii?Q?KDI6YYi31ThS/z278JjZ1qmbxlQygu/RFY6y3GqM65m6iuLXRSnwqFbvVWK1?=
 =?us-ascii?Q?d3YtXa6hq06NZZgcRXaBB9amnSHVpXEb8u0zZ1PP/TZeWmJkVgDvwgaSabjs?=
 =?us-ascii?Q?8DeXMggycy6P8CTBAEn0eeB0tiSdV7TVkJS/7lB+PEK3NyJPnXFODGbXAucl?=
 =?us-ascii?Q?ExQzSbclY70OaLAagfEPh3m4Xj7wOCLjpf5MGNlYBi1fDsXxepE04iRh4tKm?=
 =?us-ascii?Q?Rj/0UDK8fCisBDwqwK+bScz3bGvrOiGp3ZqeujbBRzAIyrNElg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(1800799021)(82310400023)(376011)(36860700010); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 06:34:31.7932 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49646a63-7543-4ae6-6c0e-08dc8f60b659
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8438
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

Add variable to record the deferred error
number read by driver.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 62 ++++++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  3 +-
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  |  4 +-
 3 files changed, 48 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index d0dcd3d37e6d..ec8e848122f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -120,7 +120,7 @@ const char *get_ras_block_str(struct ras_common_if *ras_block)
 /* typical ECC bad page rate is 1 bad page per 100MB VRAM */
 #define RAS_BAD_PAGE_COVER              (100 * 1024 * 1024ULL)
 
-#define MAX_UMC_POISON_POLLING_TIME_ASYNC  100  //ms
+#define MAX_UMC_POISON_POLLING_TIME_ASYNC  300  //ms
 
 #define AMDGPU_RAS_RETIRE_PAGE_INTERVAL 100  //ms
 
@@ -2773,7 +2773,8 @@ static void amdgpu_ras_ecc_log_init(struct ras_ecc_log_info *ecc_log)
 	memset(&ecc_log->ecc_key, 0xad, sizeof(ecc_log->ecc_key));
 
 	INIT_RADIX_TREE(&ecc_log->de_page_tree, GFP_KERNEL);
-	ecc_log->de_updated = false;
+	ecc_log->de_queried_count = 0;
+	ecc_log->prev_de_queried_count = 0;
 }
 
 static void amdgpu_ras_ecc_log_fini(struct ras_ecc_log_info *ecc_log)
@@ -2792,7 +2793,8 @@ static void amdgpu_ras_ecc_log_fini(struct ras_ecc_log_info *ecc_log)
 	mutex_unlock(&ecc_log->lock);
 
 	mutex_destroy(&ecc_log->lock);
-	ecc_log->de_updated = false;
+	ecc_log->de_queried_count = 0;
+	ecc_log->prev_de_queried_count = 0;
 }
 #endif
 
@@ -2820,40 +2822,64 @@ static void amdgpu_ras_do_page_retirement(struct work_struct *work)
 	mutex_unlock(&con->umc_ecc_log.lock);
 }
 
-static void amdgpu_ras_poison_creation_handler(struct amdgpu_device *adev,
-				uint32_t timeout_ms)
+static int amdgpu_ras_poison_creation_handler(struct amdgpu_device *adev,
+				uint32_t poison_creation_count)
 {
 	int ret = 0;
 	struct ras_ecc_log_info *ecc_log;
 	struct ras_query_if info;
-	uint32_t timeout = timeout_ms;
+	uint32_t timeout = 0;
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+	uint64_t de_queried_count;
+	uint32_t new_detect_count, total_detect_count;
+	uint32_t need_query_count = poison_creation_count;
+	bool query_data_timeout = false;
 
 	memset(&info, 0, sizeof(info));
 	info.head.block = AMDGPU_RAS_BLOCK__UMC;
 
 	ecc_log = &ras->umc_ecc_log;
-	ecc_log->de_updated = false;
+	total_detect_count = 0;
 	do {
 		ret = amdgpu_ras_query_error_status(adev, &info);
-		if (ret) {
-			dev_err(adev->dev, "Failed to query ras error! ret:%d\n", ret);
-			return;
+		if (ret)
+			return ret;
+
+		de_queried_count = ecc_log->de_queried_count;
+		if (de_queried_count > ecc_log->prev_de_queried_count) {
+			new_detect_count = de_queried_count - ecc_log->prev_de_queried_count;
+			ecc_log->prev_de_queried_count = de_queried_count;
+			timeout = 0;
+		} else {
+			new_detect_count = 0;
 		}
 
-		if (timeout && !ecc_log->de_updated) {
-			msleep(1);
-			timeout--;
+		if (new_detect_count) {
+			total_detect_count += new_detect_count;
+		} else {
+			if (!timeout && need_query_count)
+				timeout = MAX_UMC_POISON_POLLING_TIME_ASYNC;
+
+			if (timeout) {
+				if (!--timeout) {
+					query_data_timeout = true;
+					break;
+				}
+				msleep(1);
+			}
 		}
-	} while (timeout && !ecc_log->de_updated);
+	} while (total_detect_count < need_query_count);
 
-	if (timeout_ms && !timeout) {
-		dev_warn(adev->dev, "Can't find deferred error\n");
-		return;
+	if (query_data_timeout) {
+		dev_warn(adev->dev, "Can't find deferred error! count: %u\n",
+			(need_query_count - total_detect_count));
+		return 0;
 	}
 
-	if (!ret)
+	if (total_detect_count)
 		schedule_delayed_work(&ras->page_retirement_dwork, 0);
+
+	return 0;
 }
 
 static int amdgpu_ras_poison_consumption_handler(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index e70c45712ddb..c50f5f2b1f4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -469,7 +469,8 @@ struct ras_ecc_log_info {
 	struct mutex lock;
 	siphash_key_t ecc_key;
 	struct radix_tree_root de_page_tree;
-	bool	de_updated;
+	uint64_t	de_queried_count;
+	uint64_t	prev_de_queried_count;
 };
 
 struct amdgpu_ras {
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 6d6350f220b0..0faa21d8a7b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -557,7 +557,7 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 	ret = amdgpu_umc_logs_ecc_err(adev, &con->umc_ecc_log.de_page_tree, ecc_err);
 	if (ret) {
 		if (ret == -EEXIST)
-			con->umc_ecc_log.de_updated = true;
+			con->umc_ecc_log.de_queried_count++;
 		else
 			dev_err(adev->dev, "Fail to log ecc error! ret:%d\n", ret);
 
@@ -566,7 +566,7 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 		return ret;
 	}
 
-	con->umc_ecc_log.de_updated = true;
+	con->umc_ecc_log.de_queried_count++;
 
 	return 0;
 }
-- 
2.34.1


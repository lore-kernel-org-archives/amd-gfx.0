Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C0FC5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:14:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1538910F379;
	Fri, 21 Aug 2026 16:14:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l/Wp+Sb8";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012016.outbound.protection.outlook.com [40.107.209.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8A0410F376
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:14:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d9hoGb2KG26aPpIEJ7HEmFf76IfdJ2JHVB6+Dkf9evZudF9VxHULlAx0GBupybIvx3HrC1plxbrYdJ5bXAu2WGwfHV6HCqfJmd3x8RCB++vNyVY4KRo8kWT8Fdb+mHdpGE9/UfaFMFFVff9q3BQjmRV8WBvkCN/rJlv843MAINmwNxpIsr227qHjXCJskZMmTLlcLDOoE87pXuHPFbRwPHFNzoma4bTWIER1Ud5HkqQ5Xff9NKK9rjcwenZyMygJJ36t6E7LTt+cWVDbyO1mIYOS8zYvnhYEXnHprfIrUnTPBcxz1v4bBIXsqsU1LWr9i08U1SZYJgMXi/vNq1m/+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDkCeTDYQI2ITl/yooKSjG8ul4uUITRbPTZTpvdzusg=;
 b=xVw8APeYDrK8X9ln57nJb9GPB7RdCZFLknmJgY4n1oQ0txQvgqSb7BYAby7WXBJmnv3rHLqHb4i+nQxKhfGpilBzZHRO6x6MgLsrTOQ5hTC6hXzzxAxZ5dvM9mNG8qitY2szOymz7tmriPdU84nRljRpxJBQCUmXse6csTrTfkH6IvF6N4//cajCPmDlE4LwXb6QNLMbc/shhg41/crC31PegAK5BbW/4QIiEUif/ycVVechZuZ7+U9bzctz/p+/Lkd1403qq9FXueRq2S0tK9LpS7yQOxFDLKQqqzNOG3fGcRDlYFSp9Ox8HIAkxitTWiFVI4TBgfvte0QYEVVEkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDkCeTDYQI2ITl/yooKSjG8ul4uUITRbPTZTpvdzusg=;
 b=l/Wp+Sb8Y5z0zK5OB0XsHdXalCsLK8QK6iV7vFR7GTpOADa6598wOQe3wPHN5xj2vcdZJsh+E0iyp0d8zLd8bcHVJmxkVAp8yKyIN4Qq5vwmkCYkizfrK590Uihu3PwqpaBAxRVZgVzWENZNz+uyBmdoESbQj9608damaKabEGU=
Received: from SJ0PR13CA0144.namprd13.prod.outlook.com (2603:10b6:a03:2c6::29)
 by DS2PR12MB9591.namprd12.prod.outlook.com (2603:10b6:8:27c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 16:14:21 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::d4) by SJ0PR13CA0144.outlook.office365.com
 (2603:10b6:a03:2c6::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Fri, 21
 Aug 2026 16:14:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:14:20 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:14:08 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:14:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Feifei Xu <Feifei.Xu@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 02/14] drm/amdgpu: add MEM_RESERVED_INFO to discovery table
Date: Fri, 21 Aug 2026 12:13:49 -0400
Message-ID: <20260821161401.754042-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821161401.754042-1-alexander.deucher@amd.com>
References: <20260821161401.754042-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|DS2PR12MB9591:EE_
X-MS-Office365-Filtering-Correlation-Id: 74db84ef-52d6-48f4-32c7-08deff9f4268
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: bes1Ib3yCTg0BuA8FStP4bRt+mhlL7KWK2eYuBj1xIasQVCW28nvDSVCVyzl/RBtd9GDSyZGUVbJilr2YEQlzgA14KW47YTJpmcDKyebUmQbaCx7UO7CqofRKU2U7ZhsOBsR9NlK2MGQsouFbeVJTB620nmNwe1O3pD11kyTHMa8saDFxNZ3NszCyjtLEHk/WcAz0XGJqHhRovPUigpZ8Wa5/7w9All1Fw6M52RdDIeHJUv48QbhgfjXp9wv+0wpuI4l1nu1zk1hxgAsSbITvdhNCQMfoILgaP+ukyeHF9hM9Km04pqWT83yO5y1XkF6SosNq0griG2e0rdTtmjtG6HJePreilC70aOqJePai4PxNW9vK+sbwpu9apWv62eAI8VU9Au1/OKBGjUU84GeSr/QrS0pPPxoVIUclLk7+QInQhoPvt9yR9EsHYs86uyKac2P+SPgIdjixQAQqY9xqXT6tU2fwezdgABHH3bumB7FIqb583gbk1suqq+I5n25fTsTHebTfkAeihCbNm1yi9FHVHpphdbINXSyxrruRMVene1MudJwc7YFhYH2jpOV4vRj7F8Am8H1gxOs9/lQgFBGxKSNDEDEMGoeIxmtPT8ZzTUv/E6E1wVXxa4AZZT+gSgtbDTzLBJt7x7f+AivEuNKTru4ievL+QG3EHi+Pu8wL+fcj85+ZJCpGK09FrusinxMg4HRcJi1ZT8z7GV7wQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LVObQ5hjmQZPq0czbKw2dfsPvu0QGPsjs+x8PwA5T15OBHvyezMDJvw+4+yPRXinoEBypoXRI2BTUPnY7lJ8htgqR4Q+cpy6/gydvA4SUqrCrBlxeo1SGaO7NUG7E4eRuDIr0P0rh53E2YTWgh6jgaVZAD2Wre/M4hWoVeGH7YJjQBQ46fG1GAiftEBak3tZ3m0m0SAi2xFaWa75DKG+H+VZ4BgDY/4MkQP/cb3dYBRJijz2mz0J9XjFpfiEZsZjySU0qpNv/XhbDwCI0kP7c6fLDzhwV6UqNSQtqBHo4ppYJW6oHNzRpCzMSUqQfaIPw2HjRHd1HdlzjTORS1tBEHDxljow2nkh5CMNUmzCqgiR6vbH2O+bXZJR2jAM3aOcnOyGO264YNFhCw1TPegPNoRPtdOVr8eN2wLJN+pU3GTyEIBgiANnyZ41/WXQZdp4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:14:20.6286 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74db84ef-52d6-48f4-32c7-08deff9f4268
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9591
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

From: Feifei Xu <Feifei.Xu@amd.com>

MEM_RESERVED_INFO holds the reserved info like size/offset for
firmware usage.
On soc_v1_0, MASTER_DIE_UMF_REGION_ID is to query UMF reserved region
info for master die MPASP. SPECIFIC_PURPOSE_REGION_ID is to query VRAM
base.

v1->v2: convert // to /* */ and move comments ahead of declarations
        (per Christian's review)

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/discovery.h | 54 ++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/discovery.h b/drivers/gpu/drm/amd/include/discovery.h
index 575705653e957..07199c6abc73a 100644
--- a/drivers/gpu/drm/amd/include/discovery.h
+++ b/drivers/gpu/drm/amd/include/discovery.h
@@ -33,6 +33,11 @@
 #define MALL_INFO_TABLE_ID              0x4C4C414D
 #define NPS_INFO_TABLE_ID 0x0053504E
 
+/* = ('I' << 16u | 'R' << 8u | 'M') */
+#define MEM_RSV_TABLE_SIGNATURE          0x0049524D
+#define MEM_RSV_TABLE_VERSION            0x01
+#define MAX_MEM_REGION_NUM               16
+
 typedef enum {
 	IP_DISCOVERY = 0,
 	GC,
@@ -40,7 +45,8 @@ typedef enum {
 	VCN_INFO,
 	MALL_INFO,
 	NPS_INFO,
-	TOTAL_TABLES = 6
+	MEM_RESERVED_INFO,
+	TOTAL_TABLES = 7
 } table;
 
 #pragma pack(1)
@@ -504,6 +510,52 @@ struct nps_info_v1_0 {
 		instance_info[NPS_INFO_TABLE_MAX_NUM_INSTANCES];
 };
 
+typedef enum {
+	NO_RESERVED_REGION_ID		= 0,
+	/* reserved for UEFI GOP/DMUB FW */
+	PRE_OS_DISP_FW_REGION_ID	= 1,
+	/* UMF reserved region for master die MPASP */
+	MASTER_DIE_UMF_REGION_ID	= 2,
+	/* DCC meta data */
+	DCC_META_DATA_REGION_ID		= 3,
+	/* GPUVM page fault region */
+	VM_PAGE_FAULT_REGION_ID		= 4,
+	/* G7 Alternate Pstate Aperture 1 */
+	G7_PSTATE_APERTURE1_ID		= 5,
+	/* G7 Alternate Pstate Aperture 2 */
+	G7_PSTATE_APERTURE2_ID		= 6,
+	/* G7 Alternate Pstate Mirror Region */
+	G7_PSTATE_MIRROR_REGION_ID	= 7,
+	/* G7 Pstate Training Data */
+	G7_TRAINING_DATA_REGION_ID	= 8,
+	/* Specific purpose memory region */
+	SPECIFIC_PURPOSE_REGION_ID	= 9,
+	MEM_RESERVED_REGION_NUM,
+} MEM_RESERVED_REGION_ID;
+
+typedef struct mem_reserved_info_header {
+	/* Table Signature */
+	uint32_t signature;
+	/* Table Version */
+	uint32_t version;
+	uint32_t size;
+} mem_reserved_info_header;
+
+typedef struct mem_reserved_info {
+	/* enum of MEM_RESERVED_REGION_ID */
+	uint32_t reserved_region_id;
+	/* Memory Reserved Region Size */
+	uint64_t reserved_region_size;
+	/* Memory Reserved Region Start Address */
+	uint64_t reserved_region_start;
+} mem_reserved_info;
+
+typedef struct mem_reserved_info_table_v1_0 {
+	mem_reserved_info_header header;
+	uint32_t list_num;
+	mem_reserved_info list[MAX_MEM_REGION_NUM];
+} mem_reserved_info_table_v1_0;
+
 #pragma pack()
 
 #endif
-- 
2.55.0


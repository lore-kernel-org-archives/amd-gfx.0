Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07CA5CD98F2
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 19:57:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88CBF10E81F;
	Mon, 22 Jun 2026 19:57:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fjt1cT99";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011065.outbound.protection.outlook.com [40.107.208.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8A2810E812
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 19:57:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LbUjb0jGAUmcpIEFhmOhS65rv6l53flylQcEUoQhrQZsaoNUhYEqtav4fNYVNZ9s7+gO847Q+CkNwjtyRasQIuzj7c47ATXaMMqYWkdyGxf4kP9UvPGoje4ZVqK1EfVqYqQ3CgNuU0+zcywSSbG4QGB3HLEzr74IfB8vL5Tjsbos8a+Y/yMFyHOWE1sWZa+wwsV7TZKfENl4AjFjszC764J8nH5nSAgxnkIf4AqPw44YYzUzMy48e65ePpTjqXqR7CnYk+HCawtv9MuY57fBX8P99kgYm4BiUPNbGnBQv1MJD7wWeIFb0F6ru/Jrcrf7LAMee6/GksHyiGDop5HC4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vL8/t+/uSWU4K/lUi4DZ4xY7v1DSll6t01bIRaVJ4M=;
 b=LU5IvyThYKisHMCO5GNWPJ2n+XG+w7zb+fRjMbfiIfutkGI0DtSFF19hqnN/9oEqT0949/5IYfk11MTK/mXDfK13zdBw9tYp69WTAUHpHRsijs7NxZw595z8js7fKZp+7p2ZdTq5o2mrWJ92poqom6eudRN88B0GMQBbTWBsA2ew2ddUJhym4IYjoSIf7WNfXFBz1gVEiTmJOoS7ORMgOrL/1K4XQxtOUhPBmBPb5O0gN35U1Ahay81IyqKGflCqnMyUZsuHIJYcTHmz4jOEcydsbtvStBFqKlW0XIFoNwUlaBFhXap2Qmk1PyzyJac+p6DMFaBd44yiSwBdSUUEEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vL8/t+/uSWU4K/lUi4DZ4xY7v1DSll6t01bIRaVJ4M=;
 b=fjt1cT99FSBq6W+nU510Pu/Leu5UmrFXZl3jx0RgEko6fbOAjiura7PQJtvmISnJtT/QyUZS9r9+YDvqdF0O/Q1/Cwt+Ak+9j3aNoSIWDzQ696pCq090ZuxgSmC5gkoJBSgXqjlwR78EVD1eEes2mB8UmbkgK9LbeRPia/b24VQ=
Received: from PH1PEPF000132EC.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::31)
 by IA0PR12MB7553.namprd12.prod.outlook.com (2603:10b6:208:43f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 19:57:46 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2a01:111:f403:f910::1) by PH1PEPF000132EC.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Mon,
 22 Jun 2026 19:57:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 22 Jun 2026 19:57:45 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 14:57:43 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH v3 4/8] drm/amdgpu: move struct amdgpu_mqd and helpers into
 header file
Date: Mon, 22 Jun 2026 15:57:25 -0400
Message-ID: <20260622195729.181216-5-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622195729.181216-1-shahyan.soltani@amd.com>
References: <20260622195729.181216-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|IA0PR12MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: 1caa9db8-50a7-4d6d-d25d-08ded0988769
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|23010399003|1800799024|6133799003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: vddx0dS+JrY7o224oK4wetclc3NXxRzbF25zFItwDOSU9rEYNl5JJs48yA8zpDF41raWH16C9Z2SxZ5kQQj9nPmBOp6Tjo1lsukIqohhyNOBk4fngaPJDovKI3+D9kuakonr07B6bkl48TDVIGcxGu4v5JYcjLCyf4MJlLbTW7b+QbjNKDrTaqBMOYTOD9wzx3R7Vlx19H9xTxTmasOSouW9M4QG7UN6vfFqZHkoJvEcIJm3IG99I3JwA99UbfCspPCioQqvUojnOHOIj+0UVUVaW/D7B0jw4xP9+SQcaQQOxBh98wpsrujENtEgue9gLOEzThctNhyrzFkDGqKxr+LBfFJStlJLfOVy9PYkWbtZ1DRDb8eqY/VSyw/BZNm7jCM8IhHOpcM4nB9G+hH0DN2j1BTqQhTs4UEYrCuxTSfzP3mmRbAP3+/T1/+YGeEh3Lhi9ntVrG4UkTH1Kkskxoth9PteqMe0ZI5OgNioKjl64F9f0qsTkkVZuRBpBFcz2gPltvVXoVisW+YCWY1JthtnGz9PReF3HC6ZlYNZpurniMV62VBj6KWOA3LpbB4ckWRt+acArv+OBrGCqDYbWKn3tPjJoefRjZ/2K+x/8wDTbIxIJgDgPOdLGtTa1T8cnb0yR7OOq0jfs6gIYGxwxMCdw8gbzBaarx6j35hGY5g7KmUp2rAXQvN3rejM227m7gXwIbQmRwOxsgU46b0GjQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(23010399003)(1800799024)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BrQsCAxXkPeA8YYZuE5p4IkGLDcJi8Ahzd6eIVVFJtn/8S8HHUs7cgJ2n95SpHEFHHyBQsHGwtY8FQwG+2NMIdRWkmcBG6X5QuntBW0o2scYlZ77x91SWNIf2CoF0rMFhGapgieGRGplsr8EVR124Uc0ZTHEEJX2z0Hu87KNGwOy979yE6QkYg39/dAlKclUO+7h/dDkSvfuM/qKl29DxA2wCMpVlKdP2NyyxPRiA5fGA1nzFesOTXQGwCwTU3lZJHlQB5E/y8negJs0lLjSyCckoddkImRZpw6Rs3eGEah3tyn28+rD8ItS7B4UF+VKLQVJESwix/O5S5kLdjtsp1OU1sOicdNcQ41VEHqmCdG2TR/vltahW096G9aFJl9ef6P/5r/5Nw+/lOxM/ptLTty69I+luNasqdABoMH+QFY/UU7cFCpf18Nm4vmWPq6f
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 19:57:45.7789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1caa9db8-50a7-4d6d-d25d-08ded0988769
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7553
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

Move struct amdgpu_mqd_prop, struct amdgpu_mqd, and helpers from the monolithic amdgpu.h
into existing amdgpu_mes.h file.

This is part of the ongoing effort to reduce the size of amdgpu.h into their own respective
separate headers.

Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>

---
Following v2's feedback struct amdgpu_mqd and helpers were moved into
the existing amdgpu_mes.h instead of creating a new amdgpu_mqh.h file
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 48 +------------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 46 ++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 61608acc0393..ca86cef62f44 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -96,7 +96,6 @@
 #include "amdgpu_doorbell.h"
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_discovery.h"
-#include "amdgpu_mes.h"
 #include "amdgpu_umc.h"
 #include "amdgpu_mmhub.h"
 #include "amdgpu_gfxhub.h"
@@ -115,6 +114,7 @@
 #include "amdgpu_eviction_fence.h"
 #include "amdgpu_wb.h"
 #include "amdgpu_ip.h"
+#include "amdgpu_mes.h"
 #include "amdgpu_sa.h"
 #include "amdgpu_uid.h"
 #include "amdgpu_video_codecs.h"
@@ -609,44 +609,6 @@ struct amd_powerplay {
 					  (rid == 0x01) || \
 					  (rid == 0x10))))
 
-enum amdgpu_mqd_update_flag {
-       AMDGPU_UPDATE_FLAG_DBG_WA_ENABLE = 1,
-       AMDGPU_UPDATE_FLAG_DBG_WA_DISABLE = 2,
-       AMDGPU_UPDATE_FLAG_IS_GWS = 4, /* quirk for gfx9 IP */
-};
-
-struct amdgpu_mqd_prop {
-	uint64_t mqd_gpu_addr;
-	uint64_t hqd_base_gpu_addr;
-	uint64_t rptr_gpu_addr;
-	uint64_t wptr_gpu_addr;
-	uint32_t queue_size;
-	bool use_doorbell;
-	uint32_t doorbell_index;
-	uint64_t eop_gpu_addr;
-	uint32_t hqd_pipe_priority;
-	uint32_t hqd_queue_priority;
-	uint32_t mqd_stride_size;
-	bool allow_tunneling;
-	bool hqd_active;
-	uint64_t shadow_addr;
-	uint64_t gds_bkup_addr;
-	uint64_t csa_addr;
-	uint64_t fence_address;
-	bool tmz_queue;
-	bool kernel_queue;
-	uint32_t *cu_mask;
-	uint32_t cu_mask_count;
-	uint32_t cu_flags;
-	bool is_user_cu_masked;
-};
-
-struct amdgpu_mqd {
-	unsigned mqd_size;
-	int (*init_mqd)(struct amdgpu_device *adev, void *mqd,
-			struct amdgpu_mqd_prop *p);
-};
-
 struct amdgpu_pcie_reset_ctx {
 	bool in_link_reset;
 	bool occurs_dpc;
@@ -1034,14 +996,6 @@ struct amdgpu_device {
 	struct amdgpu_kfd_dev		kfd;
 };
 
-/*
- * MES FW uses address(mqd_addr + sizeof(struct mqd) + 3*sizeof(uint32_t))
- * as fence address and writes a 32 bit fence value to this address.
- * Driver needs to allocate at least 4 DWs extra memory in addition to
- * sizeof(struct mqd). Add 8 DWs and align to AMDGPU_GPU_PAGE_SIZE for safety.
- */
-#define AMDGPU_MQD_SIZE_ALIGN(mqd_size) AMDGPU_GPU_PAGE_ALIGN(((mqd_size) + 32))
-
 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
 					 uint8_t ip, uint8_t inst)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 5255360353f4..7b4cfb5c8f83 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -438,6 +438,52 @@ struct amdgpu_mes_funcs {
 			      struct mes_inv_tlbs_pasid_input *input);
 };
 
+enum amdgpu_mqd_update_flag {
+	AMDGPU_UPDATE_FLAG_DBG_WA_ENABLE = 1,
+	AMDGPU_UPDATE_FLAG_DBG_WA_DISABLE = 2,
+	AMDGPU_UPDATE_FLAG_IS_GWS = 4, /* quirk for gfx9 IP */
+};
+
+struct amdgpu_mqd_prop {
+	uint64_t mqd_gpu_addr;
+	uint64_t hqd_base_gpu_addr;
+	uint64_t rptr_gpu_addr;
+	uint64_t wptr_gpu_addr;
+	uint32_t queue_size;
+	bool use_doorbell;
+	uint32_t doorbell_index;
+	uint64_t eop_gpu_addr;
+	uint32_t hqd_pipe_priority;
+	uint32_t hqd_queue_priority;
+	uint32_t mqd_stride_size;
+	bool allow_tunneling;
+	bool hqd_active;
+	uint64_t shadow_addr;
+	uint64_t gds_bkup_addr;
+	uint64_t csa_addr;
+	uint64_t fence_address;
+	bool tmz_queue;
+	bool kernel_queue;
+	uint32_t *cu_mask;
+	uint32_t cu_mask_count;
+	uint32_t cu_flags;
+	bool is_user_cu_masked;
+};
+
+struct amdgpu_mqd {
+	unsigned mqd_size;
+	int (*init_mqd)(struct amdgpu_device *adev, void *mqd,
+			struct amdgpu_mqd_prop *p);
+};
+
+/*
+ * MES FW uses address(mqd_addr + sizeof(struct mqd) + 3*sizeof(uint32_t))
+ * as fence address and writes a 32 bit fence value to this address.
+ * Driver needs to allocate at least 4 DWs extra memory in addition to
+ * sizeof(struct mqd). Add 8 DWs and align to AMDGPU_GPU_PAGE_SIZE for safety.
+ */
+#define AMDGPU_MQD_SIZE_ALIGN(mqd_size) AMDGPU_GPU_PAGE_ALIGN(((mqd_size) + 32))
+
 #define amdgpu_mes_kiq_hw_init(adev, xcc_id) \
 	(adev)->mes.kiq_hw_init((adev), (xcc_id))
 #define amdgpu_mes_kiq_hw_fini(adev, xcc_id) \
-- 
2.54.0


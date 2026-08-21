Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 642D5C5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:51:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F021210F3CD;
	Fri, 21 Aug 2026 19:51:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r0a/zsMT";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010056.outbound.protection.outlook.com [52.101.61.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BFDF10F3CD
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:51:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CTTw0ttYQsd0ztuYLoJa9zBSscB9M+q7dnt8NuAMdK02O7Aa4mYwEppOI0XbAnqM6jR8327DJiYO8dokuq5yNq7YnG0XBRQ0kDHK34Dev8YLJfGz3MVtxcgIsv5LvImQSF52XNpFIya94rGPW8n+MTew3pPio/4C7ti8jVRM9z/m7c9sJsw4M8DR9foDW4kHeYTsE8TXP4gaNsYvvPkE/yMHgBar/52exEbjVevotP9zZmJIe4JrzxiTArjrpg37wL2bV4Dvvv+XhRC30NK0ww7LofRdb3wIAgBZoVtEVBeL5+7TVGsawOgZoCZ+SaW3Z8qraTp4sXUPI/gEUupH2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TXixzsfJn7LecKbFS5XkbKvU7RLgND+6t3/1gwUmOQ=;
 b=JcsiFbXPn6oc6KvAC98p7TpSEtahknlLzlAnphwc7aOejDGDjYU3HCjYHDwgNk2UrmyYCJzeBWVQg7l2s5rfM3GYMBYXCMJYqN/cKtRvKemmmRgVl+hPiWn2d1+BziITm7Uw6CbrSfdvHRhbs6bZ9e3hCs6/zx56Zw7JVm3soWaEcNQGzdkx8N3Yr6yXJf/0CNWA3Z1GwF/mFOF51gM6JGUE/JqeEobeCAEQqiYRa3JRwgJ88ReGOwdKt093sjdhfuogz54RQWfJP6SFBEyB+hGcxCIjICBSEVOSN5A4GRPBybuwHn9mdQVpuCOFLIrsjOAyr411ebJQJdYtZ6li0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TXixzsfJn7LecKbFS5XkbKvU7RLgND+6t3/1gwUmOQ=;
 b=r0a/zsMTHFDFj2jp6Tck2dru7+8WVirnHFt7CVhhvxpZWCrIPVN5EIfBfSHgzahySHS884yYvr34tgJXYefRma6ba91DT1SKBUtadOYA64j35Nw1tgKhzwGpjIa8TLm4idQDLHSjdIl4ci2F12OLe7IxGLDdOjcV8VsSZiEqkE0=
Received: from CH5P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::21)
 by MW4PR12MB7429.namprd12.prod.outlook.com (2603:10b6:303:21b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 19:35:31 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::52) by CH5P222CA0017.outlook.office365.com
 (2603:10b6:610:1ee::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:31 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:26 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 24/95] drm/amdgpu: Add address allocator for NPA addresses
Date: Fri, 21 Aug 2026 15:33:47 -0400
Message-ID: <20260821193458.808626-25-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|MW4PR12MB7429:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fc2657c-d6d6-4cd6-c16e-08deffbb5c97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ZnhQTD02DBTwLarCFgZ4u8PYIYCiS9RR3Q6np0ObwVYFxVW1CROtN+mKwOfFdFSM+Gc/mtoaMYLTdFt/udA3Mm2NXSIrzxN1ZHIBKUgSFzsihw5Iow/1tRTEMGOq8tavJPIMYDp/bBicAgBC84Tv4pYbOkQcVnDRMvAnrzv86hVA3urG/gN2wDoIHZ1XAUtiOv36bzp7Kc5SZcQzYYRz/wU49prHIoQWeNZYnNflsE2jzDruCbepLrPwCFx1omdBgKSYxophZ6/MIVclS2iMcRkxrgiwFflOHmjs3AtDbeeg/5BW8FF/N4LDXbTP2FEfvuLy+VCr91BU8Bhc2EbxohnZ7QlKhw/l9WNQMyd/Lloh0CeIcYqkgA6axcIljBsqTPEgA5CPafL+GvlKVM5uh+7uCFcA6wNIdpOhRkA92gNnZk0VdS2DHdFaZ1Vc9WXRCBILQBgXexkFXgzUlBrmLEw6qRItXNwsX9ZuiJMChq6lu15rUj02es66KlEmnXWd23OD427All7kkszSZFC0G6St7iBadrspQ9rQPZeQ4ShC+ml8mq9m3ap/kzCFf1WDAzMyV5RRhdDRpIQYVBe5RjrdfgSBVw96K99YD+GLxyWHF/73C6qVDuMSUEceyueOyKD3guGr8xAoxpTfL1Pb2SA34ofu/eWAs4eK4NAzsQoAI+yuQW/oP7HOi/yx/Z7vtzNh+bk10TQtBmsuQXNgjw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 58nHZRlFNYVa6fHzM1y/9KKIMtiyyz+XAEaoVIh1Yjw+tsfr1Ql8XlJLeJHCZmYdrFKqfm7Mfjv69fmnwqTVje9BG6GBp08ZvOyi4yegZVeXC10YvLXM9tRxVXnO2pG/IyyTWubnjMpkldgLnVfXQuQoMWhwIKPJd/XNjMEHagYRrC1u22wCUi3QPz8srxVL4ZyfEo/GpVrrZ6vS7dkn8XiLWm3JTqRitQc/I38YW+kKzfX+IfoF9mZ/4KlpM8+f/G3O/yDJJxjO8YWIj0oom4j89dAnnTvrhoWLB6QqsVdntb38WzGWXdLW3d1XCYMbh/A6kSGX/FJZtFEdUn8JqD90aFMZPQtkeKBWH7fQpntx3f1dk/mEX0mr+1fB157sWNeX/Kun4Q65CX5SzDvdyLQ6uAreNoJPGEhog6GFxx7rCpphP8RNViborRk1vXrZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:31.0249 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fc2657c-d6d6-4cd6-c16e-08deffbb5c97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7429
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

From: Mukul Joshi <mukul.joshi@amd.com>

Add a address allocator, which uses DRM MM, for allocating and
deallocating NPA addresses for BOs exported/imported in a rack-scale
setup.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 86 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h | 10 +++
 2 files changed, 96 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 632825e975b27..9c8601f4d16be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -23,6 +23,7 @@
  */
 
 #include <linux/xarray.h>
+#include <drm/drm_mm.h>
 #include "amdgpu.h"
 #include "amdgpu_ualink.h"
 #include "amdgpu_xgmi.h"
@@ -1025,6 +1026,87 @@ void amdgpu_ualink_sysfs_fini(struct amdgpu_device *adev)
 	}
 }
 
+static int amdgpu_ualink_npa_alloc_va(struct amdgpu_device *adev,
+			       struct drm_mm_node *mm_node,
+			       u64 va, u64 range_start,
+			       u64 range_end, int size)
+{
+	struct amdgpu_ualink_npa_mm *npa_mm = &adev->ualink.npa_mm;
+	u64 alignment = 0;
+	int ret;
+
+	mutex_lock(&npa_mm->mm_lock);
+	if (va) {
+		mm_node->start = va;
+		mm_node->size = size;
+		ret = drm_mm_reserve_node(&npa_mm->mm, mm_node);
+	} else {
+		if (!range_start && !range_end) {
+			range_start = npa_mm->va_start;
+			range_end = npa_mm->va_start + npa_mm->va_size;
+		}
+
+		/* If size is greater than 2MB (or 512 pages),
+		 * align it to 2MB (or 512 pages) granularity.
+		 */
+		if (size >= 0x200)
+			alignment = 0x200;
+
+		ret = drm_mm_insert_node_in_range(&npa_mm->mm, mm_node, size,
+						  alignment, 0, range_start,
+						  range_end, 0);
+	}
+	mutex_unlock(&npa_mm->mm_lock);
+
+	if (ret)
+		dev_err(adev->dev, "Failed to allocate NPA address\n");
+
+	return ret;
+}
+
+static void amdgpu_ualink_npa_free_va(struct amdgpu_device *adev,
+			       struct drm_mm_node *mm_node)
+{
+	struct amdgpu_ualink_npa_mm *npa_mm = &adev->ualink.npa_mm;
+
+	mutex_lock(&npa_mm->mm_lock);
+	drm_mm_remove_node(mm_node);
+	mutex_unlock(&npa_mm->mm_lock);
+}
+
+static void amdgpu_ualink_npa_mm_init(struct amdgpu_device *adev)
+{
+	struct amdgpu_ualink_npa_mm *npa_mm = &adev->ualink.npa_mm;
+	u32 addr_mode = adev->ualink.info->vpod.addr_mode;
+	u64 va_size;
+
+	mutex_init(&npa_mm->mm_lock);
+
+	if (addr_mode == AMDGPU_UALINK_ADDR_MODE_SOURCE_IDENT) {
+		/* 51 bit address space in Source-Identification mode.
+		 * 39 bits in page granularity.
+		 */
+		npa_mm->va_start = 0;
+		va_size = GENMASK_ULL(38, 0);
+	} else {
+		/* 41 bit address space in Source-Alias mode.
+		 * 29 bits in page granularity.
+		 */
+		/* First 8MB is reserved for Metadata NPAs */
+		npa_mm->va_start = 0x800;
+		va_size = GENMASK_ULL(28, 0);
+	}
+
+	npa_mm->va_size = va_size - npa_mm->va_start;
+	drm_mm_init(&npa_mm->mm, npa_mm->va_start, npa_mm->va_size);
+}
+
+static void amdgpu_ualink_npa_mm_fini(struct amdgpu_device *adev)
+{
+	mutex_destroy(&adev->ualink.npa_mm.mm_lock);
+	drm_mm_takedown(&adev->ualink.npa_mm.mm);
+}
+
 int amdgpu_ualink_manager_start(struct amdgpu_device *adev)
 {
 	int i, r;
@@ -1047,6 +1129,8 @@ int amdgpu_ualink_manager_start(struct amdgpu_device *adev)
 		INIT_LIST_HEAD(&adev->ualink.imp_handles_list[i]);
 	}
 
+	amdgpu_ualink_npa_mm_init(adev);
+
 	return 0;
 }
 
@@ -1054,6 +1138,8 @@ void amdgpu_ualink_manager_stop(struct amdgpu_device *adev)
 {
 	int i;
 
+	amdgpu_ualink_npa_mm_fini(adev);
+
 	xa_destroy(&adev->ualink.exp_xa);
 	xa_destroy(&adev->ualink.imp_xa);
 	xa_destroy(&adev->ualink.handle_invalid_xa);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index fe05e584b82e4..95e770b69a48b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -121,6 +121,13 @@ struct amdgpu_ualink_station_config {
 };
 #define to_ualink_station_config(ko) container_of(ko, struct amdgpu_ualink_station_config, kobj)
 
+struct amdgpu_ualink_npa_mm {
+	struct drm_mm			mm;
+	u64				va_start;
+	u64				va_size;
+	struct mutex			mm_lock;
+};
+
 struct amdgpu_ualink_connection {
 	struct completion hello_done;
 	struct mutex lock;
@@ -160,6 +167,9 @@ struct amdgpu_ualink_mgr {
 
 	/* WQ to manage revocation of exported memory. */
 	struct workqueue_struct *npa_wq;
+
+	/* Memory-manager for managing NPA address space. */
+	struct amdgpu_ualink_npa_mm npa_mm;
 };
 
 int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev);
-- 
2.55.0


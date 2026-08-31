Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4251CC624D1
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:29:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1555710EA70;
	Mon, 31 Aug 2026 18:29:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xWgCGmJA";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011003.outbound.protection.outlook.com [52.101.62.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3970610E50F
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:28:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JglOr2FxwIkLU7vy+/UAKnaQE+X1IaIX/OBp9vTi9Swu0MxZpryOQHmbabaOdmqSIOkVGYWzRkuV1i7QC3omJKKpbuZwtQ/XgREHCgFexOs9WW4BDgKIwuHKUaRbvG0ZvuCwmuVswx9IyJNgqwFZc62N06o1QCKBP2u8pW+AZgHOCTB7Eq66oX8DwaRk35zSwiz9OTTuLAJkC8mRRthIaAu8ulTQ2K1IInP6vYffywJSTnayoVVVW24L5/1FLYZibl870C4qdkZIFTRKk9dFQs5qZQ/MFHCTqzadlO5SnYMpOIOg2o8qsMuRgFemmy1J9N/cv5172phCqDrMFW+P7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGPx5RjaGBK//F4Kt/KbjEXIRiTqxg7mtlf85OSXRPE=;
 b=HO4yKpgnpAkZ8oCYR61yZhbTJ12PsEJq1RoQeYol3DL0GavbwXJxmkImZsI/NNRHJ54mbIVjNiugwb8AotNV8L/ttfQ7WpSGFi1+zbnEpSnYyw/w2MGjD4ZVdc8UDe8LUGxxMAeyEauLNG5PNCha8XBpKKhA9UDYsQrmMUy5qTxuHMQ5N5GxHvk3ADgdEtDJgSZJvXiQhDwn82qONkulbJWBk1H4ynfOikLIOCy4D9gaCvSr3pp1/L+gxWlrBt7XbF8rOeOhX1rbfJu3y1QFkuLQUFR+t9IJ7DxBinVzlh3TwJmgwBM+t2WposCRvB880RFTVEDwJsLIP7vIj2iJPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGPx5RjaGBK//F4Kt/KbjEXIRiTqxg7mtlf85OSXRPE=;
 b=xWgCGmJAXuUCGv0zbZt/pY+XDkVKKzkmACXi2vx9kjC4mSi3rsDj/xIhItPyN3IPSRQNpVoWsPbkpvw2omTU4p2rTfOnFDd9lUHyt4g5LXr8dfVIjf74kTotYt129shgX0p+uvvCdiuJ1aVxKKMVLYVQZlAbr9P5Z2HbB4tFm3U=
Received: from BN9PR03CA0135.namprd03.prod.outlook.com (2603:10b6:408:fe::20)
 by MW3PR12MB4410.namprd12.prod.outlook.com (2603:10b6:303:5b::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:28:38 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:408:fe:cafe::7f) by BN9PR03CA0135.outlook.office365.com
 (2603:10b6:408:fe::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:38 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:21 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:21 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 24/95] drm/amdgpu: Add address allocator for NPA addresses
Date: Mon, 31 Aug 2026 14:26:43 -0400
Message-ID: <20260831182754.1089811-25-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|MW3PR12MB4410:EE_
X-MS-Office365-Filtering-Correlation-Id: 52a90275-cd1d-4283-be05-08df078dad00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: kzVslJFMrkZ/C5VUHflAuYeXLZxFOUatY9QswqXQUN6/jY+Jue7gk5gNBToTXk/Cav9Fdqu2ymM+IhOWXf+GkhllRMdFBKsXPE8yIc1JyPAU4cIJM73XF0FtHWYDyCbcENdp0nfwM0atf/gwScwqll0aAskYnrC/kl9pT2o4bpfpsbdSOR5zVlxcECBQ6QpEs/SWY0n/B83crm/Xons8H6fRozblJKAH9PCox//axMv4fdsbAMU3rpxZo0Y/xTm1E7QzFGgjOmRRz/N0/8UtGdUjymNdKJNOPVjLfhpPwhpcFEt0yo2LmStJqa/Sw5ukL4QsokojUKEV8WMcMJUNv15Y2m7cl3XqNL0VLXS6sj7DbR6e46MDQMjdHY+1CXz3E4mMCpBaRSrfMUYgR8xytjhIQA2g4VcmDj9xLcTrK3cFjRf6/JQj/wc+QW/scLo7bMY1X7ymCbTcbOX5SW4RIDYx8/PlrAelM3uDzWRd3z8e4U9BrHOEJYEELHd+5HNsC5+VpX6UOJC3FbsRD3QmetIA9+p6+FLSX01wVWTJDZX4eUeunlPvkbUHCov/hOX6qwbvPOGgzTXC6zJIE4gm7Mea2U8s6UeaiZAThAzsXBjk0xwiMjYM9pUfikx3TONi3jPmUShcw3NVB4j1cOO32niJcCfV0uzEgsNYNZIxOTdbCW1pGH9r3FBIeAtpz309Pa/9Gn/ykDY02wAXoeOWSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: B4gtVSk9jfmHFthK9YjAiyAOlNg0Y6kS4Vfi/fLNnG1dFAlPuHXmZhQak5XuSDH6ST0UsrEOIkW5VOWO1551KSEV2srbVg2BddC2OFY7MNLcVKlLnwRZgwOv6M2rva4LRLA1YkADTixec46+9Nid4YXVta0xBxpOiNAvn3VgSXPq8YXZXCE42clwX1eGDrnfX0JT5H4WhZOoJCSfDJaVEtFanBA7HgKl3USjFwEESD12Ft7SXSA7ZYZ7WbV41Uj5tZoGdJTy25FNAgHVII7mOefSVlRsgs/hF8/6UOaIYQSR3wMvonxHlecVOW9dKUNLtQbdGPyfv5clH08g8QELjGd7uN6GSqHVc1DgwF9x2UvtJCiWJLz8Cs0h7+JS5EHtyT71Q18Or39xU6mp3+nw+IkHy/WjPOmCQmazkKd9pu69gUfY8ekRd8G+wdJy/tqU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:38.3751 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a90275-cd1d-4283-be05-08df078dad00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4410
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
index 76aec9eaa59fe..4582299d96c4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -23,6 +23,7 @@
  */
 
 #include <linux/xarray.h>
+#include <drm/drm_mm.h>
 #include "amdgpu.h"
 #include "amdgpu_ualink.h"
 #include "amdgpu_xgmi.h"
@@ -1070,6 +1071,87 @@ void amdgpu_ualink_sysfs_fini(struct amdgpu_device *adev)
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
@@ -1092,6 +1174,8 @@ int amdgpu_ualink_manager_start(struct amdgpu_device *adev)
 		INIT_LIST_HEAD(&adev->ualink.imp_handles_list[i]);
 	}
 
+	amdgpu_ualink_npa_mm_init(adev);
+
 	return 0;
 }
 
@@ -1099,6 +1183,8 @@ void amdgpu_ualink_manager_stop(struct amdgpu_device *adev)
 {
 	int i;
 
+	amdgpu_ualink_npa_mm_fini(adev);
+
 	xa_destroy(&adev->ualink.exp_xa);
 	xa_destroy(&adev->ualink.imp_xa);
 	xa_destroy(&adev->ualink.handle_invalid_xa);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index 4b3e1f3af3333..a056d89d163ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -125,6 +125,13 @@ struct amdgpu_ualink_station_config {
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
@@ -164,6 +171,9 @@ struct amdgpu_ualink_mgr {
 
 	/* WQ to manage revocation of exported memory. */
 	struct workqueue_struct *npa_wq;
+
+	/* Memory-manager for managing NPA address space. */
+	struct amdgpu_ualink_npa_mm npa_mm;
 };
 
 int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev);
-- 
2.55.0


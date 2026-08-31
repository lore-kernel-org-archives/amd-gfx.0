Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E615BC61DD3
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:30:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CB4410EAAE;
	Mon, 31 Aug 2026 18:30:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VYfK257n";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011016.outbound.protection.outlook.com [40.107.208.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 467A610EA58
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:28:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vkoVkLyD2xlj2F4Wz38jqlZECNxu3eowbT8fUYsXPYChd1m/d8wzTOdbee7uzWRCTl/RZEhLLl2DHUHzP4Brl/zyjz1hmtgbfj5Z67HNmGSv+Vy3ubOd9cR7YYdZh+ZIQ+kj9qmr4DVXgNdLebklqEijNZ2WF2pkCxGamB6Al1rd/jHdJXkQsd9xoRUjHLeBWcDqZnMcmEGowb8TWYNOEZdN6JDPWi6+/dGQLSlyT1B/LHu4pSIo495uoLwOSjxm9UO6yR95sZH8NZ1UENyFV9E8uCnf6bsjhgRvK1HFz5APKmJ82l/MeR5XqQx9Ulc2ABWrXIfmNYAexLD47K/exg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HlEK0bhe7DUT47HXGq0mjWPpkvpEfVN84570TPEmvUg=;
 b=RES5n9xooGUFpVT5ZWt7tbkuvmPyrVHBuRpfaD0jmhnScE+xC2W1pnumL3mckT6/dfCt3Nd6/WcQv4LpGy89QQUuqDCqjfEo63DLZs2F34N35rvZ1yqftgBXUzkgmEcP3CDy2PfqD4RkivxJDi/tUrINgdsGcYcs5iYySWFtvXTDnRcSJz/p+klwIwMO3S4qk72al3R3bUwaY/+B14eVj+WmQzd55mqzYTPZT1rzx84WXGZDJCkM5ZhEHDYFdf1GqkONmzqnxJoXSOzJxO0KQSd5X1BZuozz3A+0lbd8uC9orS/faUyO1DaMC5IA/opRCAaxfummBps56v6frOpE+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlEK0bhe7DUT47HXGq0mjWPpkvpEfVN84570TPEmvUg=;
 b=VYfK257nlR/WIqLaiCccmqkNXws1JGoOQQtI0V42nIKtTM0enmOjPAdzZ6orkLgnZS946r0B7li5KkMnntxd3FdZu6yHC91dFyb/PxG0RCegWFMb5YafvwQBhaZ0HtazA/rTOAUt9UHeIo4OHFnFDNR3P2OMdDMTMccIcP2OOZw=
Received: from CH5P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::19)
 by BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:28:38 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::35) by CH5P220CA0021.outlook.office365.com
 (2603:10b6:610:1ef::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:37 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:23 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:22 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 26/95] drm/amdgpu: Rework VMID reservation logic
Date: Mon, 31 Aug 2026 14:26:45 -0400
Message-ID: <20260831182754.1089811-27-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|BL1PR12MB5732:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f58a703-7977-47e4-a721-08df078dac84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: pbpaRUtdrGikkYsQBG6BnvF7f+K/swKSEXDggTfmoxUPAikIZoZs6VsR0huqgZG0MNdy/okoEO4O7Inum56BNkUd+GAKcCRXQfiVceN/1eUbgGXc4eimtl60IXPv88bUhR6+iJUkuOQwIDaJVGqjBwxMeG3BfUS1cOwYrHOUCu/Q+1xhYzJwApBs8bGh03eq2KEMOZLqFROot6kHZlbi7ltT+VirW3h8wTc24KBfaDgQzViKHJzOOXvf6/RqECaYys3LvFt2dnDsa30vv8fPFho59wGh32A50WFqnusPE98o2o3688lxljFqYdc8Su8jAsjPycApCUpTAwhOFQTwHnW18kd+6KrNomjc/QKQZwSKTw9sNCTjbJ4QAt1fCRlXEwuQ8+hOxHvz8cpP0ES0D2zgPXGVMTiJlPtYVq8ExoLWRJImzcZzrYaIwyr3YvTM7X0GaC0QAtNFCfo0vtU3GBp/DfnN09ri6tW3DLlf0GGhNd62gpIbo7fjoWW64ryZ3ij1gARbmWGsl4/tDuJirGElP0DkwUfB3gNaEXX3W7+F3C9A6CwAqAQfgnUzU377Y2ssuOmDvm1aon7GehULvV2OV+uYz2jAQaCZAX/2fkwB1S2AkVmWZBEv/cbdWXKn9yoTmZQ4gd5zZ5Qpj6eeWGVQPRr8RrMzdL/DGOsyT8JranxNs9udwNM8M2ELEUSlYna77wJRdS6KxBcQcfJoZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: W3hcAMaFlD+RwXMhkNwUgaHJEXtlnacsPSGoDLhbYnsD62792+NnvDmANex2EQQ5u6yzMTyq9J/MVcwdMsAXaSxzuP/qTwAFKC82oLwNZA6TQ+40t3Tpp+D1yk8qN20kN+23QL3A1v3tIf/HA5TlYziBGTxVD7dp91a10rAcqnuytkiT/H0PdBO577Oama5s5AwUKRZ3AgQ0asV5O7EE5+/oKLqr5lIddY3MaSjpfJt1NLm6IA9NAdLm1cilDRRqvcbJDfSFuJImYXxLJgBUWv701BkdK3/rPTDaTHw7QYnNEHxrdbzV7Wreo4wyorPFNxGn1lEp7+ulVk5pW+7dMSN0ziW97lakuUsf3mMheJO+ykcWkB9pRTfIp60n0LnCVItH/R+V9lPl9JN5e9QtvbWWysQsojz1aoty60Tid/KANMrBc7B7t5DQhQWpA7lC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:37.5607 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f58a703-7977-47e4-a721-08df078dac84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5732
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

Rework the VMID reservation logic by passing in the mask
of VMIDs (for both GFXHUB and MMHUB) available for it to
use. The VMID masks for both GFXHUB and MMHUB are initialized
in the respective ASIC specific files.
This also helps in reserving per-ASIC VMIDs. This is in
preparation for reserving a VMID for NPA added in the next
patch.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 33 ++++++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h | 27 +++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  4 +++
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  |  5 ++++
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  | 14 +++++++----
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c   |  6 +++++
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c   |  6 +++++
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   |  6 +++++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  6 +++++
 17 files changed, 95 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 8a2d64f0ebc3f..8c32c69437645 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -625,12 +625,27 @@ void amdgpu_vmid_reset_all(struct amdgpu_device *adev)
 	for (i = 0; i < AMDGPU_MAX_VMHUBS; ++i) {
 		struct amdgpu_vmid_mgr *id_mgr =
 			&adev->vm_manager.id_mgr[i];
-
-		for (j = 1; j < id_mgr->num_ids; ++j)
+		for_each_set_bit(j, id_mgr->vmid_mask, AMDGPU_NUM_VMID)
 			amdgpu_vmid_reset(adev, i, j);
 	}
 }
 
+void amdgpu_vmid_mgr_set_vmid_mask(struct amdgpu_device *adev,
+				   unsigned long vmid_mask, bool for_mmhub)
+{
+	unsigned int i;
+
+	BUILD_BUG_ON(AMDGPU_NUM_VMID > BITS_PER_LONG);
+
+	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++) {
+		bool is_mmhub = AMDGPU_IS_MMHUB0(i) || AMDGPU_IS_MMHUB1(i);
+
+		if (is_mmhub == for_mmhub)
+			bitmap_copy(adev->vm_manager.id_mgr[i].vmid_mask,
+				    &vmid_mask, AMDGPU_NUM_VMID);
+	}
+}
+
 /**
  * amdgpu_vmid_mgr_init - init the VMID manager
  *
@@ -649,19 +664,8 @@ void amdgpu_vmid_mgr_init(struct amdgpu_device *adev)
 		mutex_init(&id_mgr->lock);
 		INIT_LIST_HEAD(&id_mgr->ids_lru);
 
-		/* for GC <10, SDMA uses MMHUB so use first_kfd_vmid for both GC and MM */
-		if (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(10, 0, 0))
-			/* manage only VMIDs not used by KFD */
-			id_mgr->num_ids = adev->vm_manager.first_kfd_vmid;
-		else if (AMDGPU_IS_MMHUB0(i) ||
-			 AMDGPU_IS_MMHUB1(i))
-			id_mgr->num_ids = 16;
-		else
-			/* manage only VMIDs not used by KFD */
-			id_mgr->num_ids = adev->vm_manager.first_kfd_vmid;
-
 		/* skip over VMID 0, since it is the system VM */
-		for (j = 1; j < id_mgr->num_ids; ++j) {
+		for_each_set_bit(j, id_mgr->vmid_mask, AMDGPU_NUM_VMID) {
 			amdgpu_vmid_reset(adev, i, j);
 			amdgpu_sync_create(&id_mgr->ids[j].active);
 			list_add_tail(&id_mgr->ids[j].list, &id_mgr->ids_lru);
@@ -685,6 +689,7 @@ void amdgpu_vmid_mgr_fini(struct amdgpu_device *adev)
 			&adev->vm_manager.id_mgr[i];
 
 		mutex_destroy(&id_mgr->lock);
+
 		for (j = 0; j < AMDGPU_NUM_VMID; ++j) {
 			struct amdgpu_vmid *id = &id_mgr->ids[j];
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
index 4b55d0d9703a3..46b2c21601263 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
@@ -26,6 +26,8 @@
 #include <linux/types.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
+#include <linux/bitops.h>
+#include <linux/find.h>
 #include <linux/dma-fence.h>
 
 #include "amdgpu_sync.h"
@@ -33,6 +35,27 @@
 /* maximum number of VMIDs */
 #define AMDGPU_NUM_VMID	16
 
+/**
+ * for_each_vmid_and_zero - iterate over VMID 0 plus every VMID set in a hub's
+ *                          vmid_mask
+ * @vmid:	loop cursor (int / unsigned int)
+ * @adev:	struct amdgpu_device *
+ * @hub:	vmhub index into adev->vm_manager.id_mgr[]
+ *
+ * Equivalent to OR-ing BIT(0) into id_mgr[hub].vmid_mask and walking the
+ * result with for_each_set_bit(). Used by the gfx_v*_constants_init() paths
+ * which must always touch VMID 0 (system) in addition to the regular VMIDs
+ * owned by the hub.
+ *
+ * Relies on AMDGPU_NUM_VMID (16) fitting in a single unsigned long, i.e.
+ * vmid_mask[] being a 1-element bitmap.
+ */
+#define for_each_vmid_and_zero(vmid, adev, hub)				\
+	for (unsigned long __vmid_mask =				\
+		(adev)->vm_manager.id_mgr[(hub)].vmid_mask[0] | BIT(0);	\
+	     __vmid_mask; __vmid_mask = 0)				\
+		for_each_set_bit((vmid), &__vmid_mask, AMDGPU_NUM_VMID)
+
 struct amdgpu_device;
 struct amdgpu_fpriv;
 struct amdgpu_vm;
@@ -65,10 +88,10 @@ struct amdgpu_vmid {
 
 struct amdgpu_vmid_mgr {
 	struct mutex		lock;
-	unsigned		num_ids;
 	struct list_head	ids_lru;
 	struct amdgpu_vmid	ids[AMDGPU_NUM_VMID];
 	bool			reserved_vmid;
+	DECLARE_BITMAP(vmid_mask, AMDGPU_NUM_VMID);
 };
 
 int amdgpu_pasid_alloc(unsigned int bits, struct amdgpu_fpriv *fpriv);
@@ -95,5 +118,7 @@ void amdgpu_vmid_reset_all(struct amdgpu_device *adev);
 
 void amdgpu_vmid_mgr_init(struct amdgpu_device *adev);
 void amdgpu_vmid_mgr_fini(struct amdgpu_device *adev);
+void amdgpu_vmid_mgr_set_vmid_mask(struct amdgpu_device *adev,
+				   unsigned long vmid_mask, bool for_mmhub);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 5033f85d31022..045b9c7d2a835 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -5368,7 +5368,7 @@ static void gfx_v10_0_constants_init(struct amdgpu_device *adev)
 	/* XXX SH_MEM regs */
 	/* where to put LDS, scratch, GPUVM in FSA64 space */
 	mutex_lock(&adev->srbm_mutex);
-	for (i = 0; i < adev->vm_manager.id_mgr[AMDGPU_GFXHUB(0)].num_ids; i++) {
+	for_each_vmid_and_zero(i, adev, AMDGPU_GFXHUB(0)) {
 		nv_grbm_select(adev, 0, 0, 0, i);
 		/* CP and shaders */
 		WREG32_SOC15(GC, 0, mmSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index d704ce328e6ec..e5dbd71cce763 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -2217,7 +2217,7 @@ static void gfx_v11_0_constants_init(struct amdgpu_device *adev)
 	/* XXX SH_MEM regs */
 	/* where to put LDS, scratch, GPUVM in FSA64 space */
 	mutex_lock(&adev->srbm_mutex);
-	for (i = 0; i < adev->vm_manager.id_mgr[AMDGPU_GFXHUB(0)].num_ids; i++) {
+	for_each_vmid_and_zero(i, adev, AMDGPU_GFXHUB(0)) {
 		soc21_grbm_select(adev, 0, 0, 0, i);
 		/* CP and shaders */
 		WREG32_SOC15(GC, 0, regSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index df8d36be613ac..6bb1c42efc5e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1856,7 +1856,7 @@ static void gfx_v12_0_constants_init(struct amdgpu_device *adev)
 	/* XXX SH_MEM regs */
 	/* where to put LDS, scratch, GPUVM in FSA64 space */
 	mutex_lock(&adev->srbm_mutex);
-	for (i = 0; i < adev->vm_manager.id_mgr[AMDGPU_GFXHUB(0)].num_ids; i++) {
+	for_each_vmid_and_zero(i, adev, AMDGPU_GFXHUB(0)) {
 		soc24_grbm_select(adev, 0, 0, 0, i);
 		/* CP and shaders */
 		WREG32_SOC15(GC, 0, regSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 73fc18ec94a20..d60cd64d444eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -1732,7 +1732,7 @@ static void gfx_v12_1_xcc_constants_init(struct amdgpu_device *adev,
 	/* XXX SH_MEM regs */
 	/* where to put LDS, scratch, GPUVM in FSA64 space */
 	mutex_lock(&adev->srbm_mutex);
-	for (i = 0; i < adev->vm_manager.id_mgr[AMDGPU_GFXHUB(0)].num_ids; i++) {
+	for_each_vmid_and_zero(i, adev, AMDGPU_GFXHUB(0)) {
 		soc_v1_0_grbm_select(adev, 0, 0, 0, i, GET_INST(GC, xcc_id));
 		/* CP and shaders */
 		WREG32_SOC15(GC, GET_INST(GC, xcc_id),
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 755371b665746..549d1239e326b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -1938,7 +1938,7 @@ static void gfx_v7_0_constants_init(struct amdgpu_device *adev)
 	WREG32(mmSH_STATIC_MEM_CONFIG, sh_static_mem_cfg);
 
 	mutex_lock(&adev->srbm_mutex);
-	for (i = 0; i < adev->vm_manager.id_mgr[0].num_ids; i++) {
+	for_each_vmid_and_zero(i, adev, 0) {
 		if (i == 0)
 			sh_mem_base = 0;
 		else
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 63288382bcf40..950874ef8d045 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -3765,7 +3765,7 @@ static void gfx_v8_0_constants_init(struct amdgpu_device *adev)
 	WREG32(mmSH_STATIC_MEM_CONFIG, sh_static_mem_cfg);
 
 	mutex_lock(&adev->srbm_mutex);
-	for (i = 0; i < adev->vm_manager.id_mgr[0].num_ids; i++) {
+	for_each_vmid_and_zero(i, adev, 0) {
 		vi_srbm_select(adev, 0, 0, 0, i);
 		/* CP and shaders */
 		if (i == 0) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 0dae8ff9c762a..3ba2584e48c6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2686,7 +2686,7 @@ static void gfx_v9_0_constants_init(struct amdgpu_device *adev)
 	/* XXX SH_MEM regs */
 	/* where to put LDS, scratch, GPUVM in FSA64 space */
 	mutex_lock(&adev->srbm_mutex);
-	for (i = 0; i < adev->vm_manager.id_mgr[AMDGPU_GFXHUB(0)].num_ids; i++) {
+	for_each_vmid_and_zero(i, adev, AMDGPU_GFXHUB(0)) {
 		soc15_grbm_select(adev, 0, 0, 0, i, 0);
 		/* CP and shaders */
 		if (i == 0) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index e1603563c49de..ce48da12edb29 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1241,7 +1241,7 @@ static void gfx_v9_4_3_xcc_constants_init(struct amdgpu_device *adev,
 	/* XXX SH_MEM regs */
 	/* where to put LDS, scratch, GPUVM in FSA64 space */
 	mutex_lock(&adev->srbm_mutex);
-	for (i = 0; i < adev->vm_manager.id_mgr[AMDGPU_GFXHUB(0)].num_ids; i++) {
+	for_each_vmid_and_zero(i, adev, AMDGPU_GFXHUB(0)) {
 		soc15_grbm_select(adev, 0, 0, 0, i, GET_INST(GC, xcc_id));
 		/* CP and shaders */
 		if (i == 0) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 75a552782c979..9a8a7921ce982 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -869,6 +869,10 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * amdkfd will use VMIDs 8-15
 	 */
 	adev->vm_manager.first_kfd_vmid = 8;
+	amdgpu_vmid_mgr_set_vmid_mask(adev,
+				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
+				      false);
+	amdgpu_vmid_mgr_set_vmid_mask(adev, GENMASK(AMDGPU_NUM_VMID - 1, 1), true);
 
 	amdgpu_vm_manager_init(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 7fb97be16b7c1..bee269a8877a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -855,6 +855,11 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 */
 	adev->vm_manager.first_kfd_vmid = adev->gfx.disable_kq ? 1 : 8;
 
+	amdgpu_vmid_mgr_set_vmid_mask(adev,
+				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
+				      false);
+	amdgpu_vmid_mgr_set_vmid_mask(adev, GENMASK(AMDGPU_NUM_VMID - 1, 1), true);
+
 	amdgpu_vm_manager_init(adev);
 
 	r = amdgpu_gmc_ras_sw_init(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 18511e7995ef9..3ae3ba42c6b0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -957,13 +957,17 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * number of VMs
 	 * VMID 0 is reserved for System
 	 * amdgpu graphics/compute will use VMIDs 1-7
-	 * amdkfd will use VMIDs 8-15
+	 * amdkfd will use VMIDs 8-15.
+	 * On GFX 12.1, amdkfd will use VMIDs 3-15.
 	 */
 	adev->vm_manager.first_kfd_vmid =
-		 amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0) ?
-		3 : 8;
-	adev->vm_manager.first_kfd_vmid =
-		adev->gfx.disable_kq ? 1 : (adev->vm_manager.first_kfd_vmid);
+		adev->gfx.disable_kq ? 1 :
+		(amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0) ?
+		3 : 8);
+	amdgpu_vmid_mgr_set_vmid_mask(adev,
+				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
+				      false);
+	amdgpu_vmid_mgr_set_vmid_mask(adev, GENMASK(AMDGPU_NUM_VMID - 1, 1), true);
 
 	amdgpu_vm_manager_init(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index ca7afb9b7d0ae..cdd11587b12ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -864,6 +864,12 @@ static int gmc_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * amdkfd will use VMIDs 8-15
 	 */
 	adev->vm_manager.first_kfd_vmid = 8;
+	amdgpu_vmid_mgr_set_vmid_mask(adev,
+				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
+				      false);
+	amdgpu_vmid_mgr_set_vmid_mask(adev,
+				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
+				      true);
 	amdgpu_vm_manager_init(adev);
 
 	/* base offset of vram pages */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 1c1eccfe383fd..c9cc55e18893b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -1045,6 +1045,12 @@ static int gmc_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * amdkfd will use VMIDs 8-15
 	 */
 	adev->vm_manager.first_kfd_vmid = 8;
+	amdgpu_vmid_mgr_set_vmid_mask(adev,
+				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
+				      false);
+	amdgpu_vmid_mgr_set_vmid_mask(adev,
+				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
+				      true);
 	amdgpu_vm_manager_init(adev);
 
 	/* base offset of vram pages */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index bf089595e5dac..8d8a0775878ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1122,6 +1122,12 @@ static int gmc_v8_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * amdkfd will use VMIDs 8-15
 	 */
 	adev->vm_manager.first_kfd_vmid = 8;
+	amdgpu_vmid_mgr_set_vmid_mask(adev,
+				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
+				      false);
+	amdgpu_vmid_mgr_set_vmid_mask(adev,
+				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
+				      true);
 	amdgpu_vm_manager_init(adev);
 
 	/* base offset of vram pages */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index b46b87291c512..633772fa71fda 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2038,6 +2038,12 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 			3 :
 			8;
 
+	amdgpu_vmid_mgr_set_vmid_mask(adev,
+				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
+				      false);
+	amdgpu_vmid_mgr_set_vmid_mask(adev,
+				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
+				      true);
 	amdgpu_vm_manager_init(adev);
 
 	gmc_v9_0_save_registers(adev);
-- 
2.55.0


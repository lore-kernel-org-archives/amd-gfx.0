Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 140EDC624DD
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:29:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4379A10EA86;
	Mon, 31 Aug 2026 18:29:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X5il3WxQ";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011055.outbound.protection.outlook.com [40.107.208.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26DD710EA72
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:29:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQh0tt/RnOroMwRTR/rVZAfljBkx8BPdtFpREPR/xuvLhoha61u3ccRUx3tSTneUn3f9OFCeH2cUPB/5/BPsDzFyv6dAJqst9OCWY7M4HxEoxZuUHQDZUeLny7ClkdpeWJEGYYNLaVWo1laj4XtBNYODq/FKOAtWsyAIXCMzvNidQW6Ygf3d71C2i5jGf52hzD1YoZHHR38dBCiyzsX6W3xIj8fWsHRr2pKAyqrKc21vigyNiC8ROXr7Jk5mu01MtbqATb4OcgHTWpmSunpGtc0heyKWNE9J8OXqHuOE0RIZDzUHr6/TMF4QT41bn5t0mX+4t+9nUm0DmNusz6kVUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2yXgcrsC52bnDDEyP7U56VlvgXG7ogzVEhB4RuZA7bM=;
 b=ZVkt01/vtNjPbO+hO9UFSMTNbkKXPrd7Qhr+ZZ5N3YH2z3CeFaydUKbS7g9r6OTbn4nzGVkbDOy3Pi0PpPG7iusrqEsR/MPF7waYuaMSGDn6b6RoOXBIx3Pub9c21YVg/W3U1HNZaLJkH6hnCVr0Zk/DymDZ2L+s2vza9LcBmr9iaflR4rjpyIVejB3itHuDYSKteFEzv4vbwkyaX3gQJGNHuF2anHqqTk/Kp3OxQNRQXFhZpfU8MfWaXbfU3hnWqtwtCfdM7HG5RWcK/3qtK5GrGoR1MigQ6QsggmDNm8AVhVDPvv0O7tSwwAeKKKboIlwlGu9G8Ipoq193eJOjkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yXgcrsC52bnDDEyP7U56VlvgXG7ogzVEhB4RuZA7bM=;
 b=X5il3WxQoU8SOua7z03hQOK+t3rnwrJyfFxPEIWDJ+Mjml/EAKFdVzT7XkbVyMV/lsB7KsMZvo8/x39S0urKeNQ05JL9tVeiPYGQ3ZEbJgJg/viw11KvOEwZi+NuOH9ZAWXPbN2rBYSzhQBWtpH3hwy4kugd4OJOaGStauZwFXg=
Received: from CH5PR03CA0005.namprd03.prod.outlook.com (2603:10b6:610:1f1::24)
 by LV1PR12MB999329.namprd12.prod.outlook.com (2603:10b6:408:3f8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:29:10 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::80) by CH5PR03CA0005.outlook.office365.com
 (2603:10b6:610:1f1::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:29:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:29:10 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:53 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 74/95] drm/amdkfd: program compute MQD coherent_aql_mtype on
 GFX 12.1
Date: Mon, 31 Aug 2026 14:27:33 -0400
Message-ID: <20260831182754.1089811-75-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|LV1PR12MB999329:EE_
X-MS-Office365-Filtering-Correlation-Id: edb14f51-0514-4bec-a18f-08df078dbfe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1LFL/0troxenQLUUeWHSR3oIsCi/4MK8cAw8Jb5Dz2HTL0xpUqJUVM9YwySNFM+BhpplLO99Vw12s7fyMsEd1MRAQKKbCJ6soHoEv4ttAVtLgiEM07jdCS8J23wuoryIhq6t8ay6p9s32G+ECKC0WM2B4u9Q+b19hsi7nNDNATShxaGceILLVryRZ3Pd+Dt2VlW7lPNHGiX8q0nORto/h6wHbOfxUY4dgRct4x73ux1bEyn144U09d7OGoQVSp0WNyC67JlvXCyFSart7UklznIq5C3CV/ZPxHJ6URXlAAuxUCSznDv3bg+pq0aMR3xv/yB4fS/VoBYGhRFCd4Ec7QA3XfwlYsTj+V1N6OBEdsD7YQcTLVKzzDTuiyOIHGqWlOMtsctF3oECEhRboEUJw4mo4TX2RYV7E9zg1cLS/4/YP55pP0GYPUTwtX1xpNSBXmRsSj2Z9iJUDgvIjOftGaG3DGshT0fKv1UAW/MAG6WBYnoIumIw0dpMGczW5Tm9kGDSALhOJsX2hKVLIUz80J6jhQZTeoqbkepH15WrAPCDr2gs5ChQB0BCaftFZ1N0Bi09Cl04QCkk9/E0baFbCVVfULo5JDAb+kAiTxmdK8Vv+ExCzCyRCyW8x8+Qcq/jCLG7RzP2wbIZwIWIjxNnDomHQQnAPdQKRITFyNdjEZF3YiVfSuIJ265pcTDAzVkwRAizZdivr5Dj9L2z3u0oyg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nfc2IHIHgRQM4frCRN8I6IJIj9Utv/2urpPyVEeQ8n/3d65UClR0SixrcT8iS++owHVhNC/Q1jeDUt6eTlJK7aRMu9MaH5y/2XOYj25vd0os2LawQASDA0XjBDILl1B+H3m0IvEojycZjoSaV9yUkHKkx+CZdO/kiLZH0H/18sfNNcLHIZaykKR0TjnHz15P44/IxsINN3rM7zYfgtfjA8l1QMaST4th/VeZr6cl8rwLgSuwNXoJ57z1usid2may/Q+OCiMGqFyU/tKDaDDnADLOyaI5f3qeKyGOAeskNWgWj73vhSwhqNUkfl3hJdheCJ+qnnGsW58k+Maw7I9eHBE2v6dPbjOLget0Er9cAWvy9C/jQNH2rGMnz3/h/qnc6ZO5Oe76k/a4T0MAdVP1zk1rvB7EvcUoyh1jnUhW75dDOQ0kx3O7eh0St1aQWhXz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:29:10.0607 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edb14f51-0514-4bec-a18f-08df078dbfe3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB999329
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

Name the compute MQD dword at offset 509 (previously reserved_509) as
coherent_aql_mtype in v12_1_compute_mqd and program it when initializing
a compute queue MQD.

The field must be set to 0 whenever the driver maps local or remote
memory as MTYPE_NC, and to 1 in all other cases. Add a shared helper
gmc_v12_1_get_mtypes() as the single source of truth for the local and
remote MTYPE decision (used by both the PTE coherence flags and the MQD
programming), and gmc_v12_1_get_coherent_aql_mtype() which derives the
0/1 value from it.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c        | 63 +++++++++++++------
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.h        |  1 +
 .../drm/amd/amdkfd/kfd_mqd_manager_v12_1.c    |  7 +++
 drivers/gpu/drm/amd/include/v12_structs.h     |  2 +-
 4 files changed, 54 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index fd24d66290f55..a3b7e240abaed 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -616,6 +616,50 @@ static void gmc_v12_1_get_npa_flags(struct amdgpu_device *adev,
 	*flags &= ~AMDGPU_PTE_EXECUTABLE;
 }
 
+/*
+ * Resolve the MTYPEs used for local and remote memory accesses on GFX 12.1.
+ * Remote memory always uses MTYPE_UC; local memory depends on the AID stepping
+ * and the amdgpu_mtype_local module parameter.
+ */
+static void gmc_v12_1_get_mtypes(struct amdgpu_device *adev,
+				 unsigned int *mtype_local,
+				 unsigned int *mtype_remote)
+{
+	bool is_aid_a1 = (adev->rev_id & 0x10);
+
+	*mtype_local = is_aid_a1 ? MTYPE_RW : MTYPE_NC;
+	/* Remote memory always uses MTYPE_UC on GFX 12.1. */
+	*mtype_remote = MTYPE_UC;
+
+	if (amdgpu_mtype_local == 0) {
+		DRM_INFO_ONCE("Using MTYPE_RW for local memory\n");
+		*mtype_local = MTYPE_RW;
+	} else if (amdgpu_mtype_local == 1) {
+		DRM_INFO_ONCE("Using MTYPE_NC for local memory\n");
+		*mtype_local = MTYPE_NC;
+	} else if (amdgpu_mtype_local == 2) {
+		DRM_INFO_ONCE("MTYPE_CC not supported, using %s for local memory\n",
+			      is_aid_a1 ? "MTYPE_RW" : "MTYPE_NC");
+	} else {
+		DRM_INFO_ONCE("Using %s for local memory and MTYPE_UC for remote memory\n",
+			      is_aid_a1 ? "MTYPE_RW" : "MTYPE_NC");
+	}
+}
+
+/*
+ * The compute MQD coherent_aql_mtype field (offset 509) must be programmed to
+ * 0 whenever the driver maps local or remote memory as MTYPE_NC, and to 1 in
+ * all other cases.
+ */
+u32 gmc_v12_1_get_coherent_aql_mtype(struct amdgpu_device *adev)
+{
+	unsigned int mtype_local, mtype_remote;
+
+	gmc_v12_1_get_mtypes(adev, &mtype_local, &mtype_remote);
+
+	return (mtype_local == MTYPE_NC || mtype_remote == MTYPE_NC) ? 0 : 1;
+}
+
 static void gmc_v12_1_get_coherence_flags(struct amdgpu_device *adev,
 					  struct amdgpu_bo *bo,
 					  uint64_t *flags)
@@ -631,27 +675,10 @@ static void gmc_v12_1_get_coherence_flags(struct amdgpu_device *adev,
 	unsigned int mtype, mtype_local, mtype_remote;
 	bool snoop = false;
 	bool is_local = false;
-	bool is_aid_a1;
 
 	switch (gc_ip_version) {
 	case IP_VERSION(12, 1, 0):
-		is_aid_a1 = (adev->rev_id & 0x10);
-
-		mtype_local = is_aid_a1 ? MTYPE_RW : MTYPE_NC;
-		/* Remote memory always uses MTYPE_UC on GFX 12.1. */
-		mtype_remote = MTYPE_UC;
-		if (amdgpu_mtype_local == 0) {
-			DRM_INFO_ONCE("Using MTYPE_RW for local memory\n");
-			mtype_local = MTYPE_RW;
-		} else if (amdgpu_mtype_local == 1) {
-			DRM_INFO_ONCE("Using MTYPE_NC for local memory\n");
-			mtype_local = MTYPE_NC;
-		} else if (amdgpu_mtype_local == 2) {
-			DRM_INFO_ONCE("MTYPE_CC not supported, using %s for local memory\n", is_aid_a1 ? "MTYPE_RW" : "MTYPE_NC");
-		} else {
-			DRM_INFO_ONCE("Using %s for local memory and MTYPE_UC for remote memory\n",
-					is_aid_a1 ? "MTYPE_RW" : "MTYPE_NC");
-		}
+		gmc_v12_1_get_mtypes(adev, &mtype_local, &mtype_remote);
 
 		is_local = (is_vram && adev == bo_adev);
 		snoop = true;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.h b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.h
index 22da84a1d5185..1c7aad7a1791d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.h
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.h
@@ -28,4 +28,5 @@ void gmc_v12_1_set_gmc_funcs(struct amdgpu_device *adev);
 void gmc_v12_1_set_irq_funcs(struct amdgpu_device *adev);
 void gmc_v12_1_init_vram_info(struct amdgpu_device *adev);
 void gmc_v12_1_init_nps_details(struct amdgpu_device *adev);
+u32 gmc_v12_1_get_coherent_aql_mtype(struct amdgpu_device *adev);
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
index 13a9ce02f3918..92ec081842df6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
@@ -31,6 +31,7 @@
 #include "gc/gc_12_1_0_sh_mask.h"
 #include "amdgpu_amdkfd.h"
 #include "kfd_device_queue_manager.h"
+#include "gmc_v12_1.h"
 
 static void update_mqd(struct mqd_manager *mm, void *mqd,
 		       struct queue_properties *q,
@@ -235,6 +236,12 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
 		m->cp_hqd_wg_state_offset = q->ctl_stack_size;
 	}
 
+	/*
+	 * coherent_aql_mtype (offset 509): program 0 when the driver maps local
+	 * or remote memory as MTYPE_NC, and 1 in all other cases.
+	 */
+	m->coherent_aql_mtype = gmc_v12_1_get_coherent_aql_mtype(mm->dev->adev);
+
 	*mqd = m;
 	if (gart_addr)
 		*gart_addr = addr;
diff --git a/drivers/gpu/drm/amd/include/v12_structs.h b/drivers/gpu/drm/amd/include/v12_structs.h
index 28f4b01326811..7fa0c07b51c67 100644
--- a/drivers/gpu/drm/amd/include/v12_structs.h
+++ b/drivers/gpu/drm/amd/include/v12_structs.h
@@ -1696,7 +1696,7 @@ struct v12_1_compute_mqd {
     uint32_t reserved_506; // offset: 506  (0x1FA)
     uint32_t reserved_507; // offset: 507  (0x1FB)
     uint32_t reserved_508; // offset: 508  (0x1FC)
-    uint32_t reserved_509; // offset: 509  (0x1FD)
+    uint32_t coherent_aql_mtype; // offset: 509  (0x1FD)
     uint32_t reserved_510; // offset: 510  (0x1FE)
     uint32_t reserved_511; // offset: 511  (0x1FF)
     uint32_t reserved_512; // offset: 512  (0x200)
-- 
2.55.0


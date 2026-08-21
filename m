Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A4EC5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 20:05:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C91510F3FE;
	Fri, 21 Aug 2026 19:36:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3jb7eVAX";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011055.outbound.protection.outlook.com [52.101.62.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1BBA10F39E
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:36:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kg5JHyKjw8MM1ctDtivVF0gPKU6nWTQMmrckr+6FoKa5W56trmlUI2rhL061vrYoq27Xvaa90WhYi6Z7ulKexfSGf432rihBhYwuPWv/Nu/g7/3Fw0ELD2EjoWF6Cef3nciI3i2OVTU3EwakbekmSWyKpaoKk2sJTrY+KeEvFCTJSEtTJZ74azwZ0GLqjqmVy9PzC71cEmtBZKxBFptisRpvLKOjhn89VyGjkMnSmLl0d3Hf37MIi2q0E494GsHmOsuANYWLTi0qMQQeKUy5Vo3/DmlcB9dK9GoE8AyiTybw+soxOO1BJ9TOg17EbO0DYJjKqQahM5/3wPVhzhQWSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2yXgcrsC52bnDDEyP7U56VlvgXG7ogzVEhB4RuZA7bM=;
 b=D515Mdn7z1hgK3ZE9o1R9uii2+9LLgSqOMxD+aMpcDo3UBWY04MZ7wj6aj+YodzNEndnfeTqCqe5M0gyvnVsjl48nyTjdCBu8tO+3mCr202K0giNfiwFHx60NbGYwFv8ZI+YR7dnxAPkQ72FS1pz3AZwTZx19TGDec3TqUEXjRHVICOXrSw6dKV96ss0/GCL1uo3EVnCHOrRgFPyvq8mw5wXx51u5jqIELG7gJNBLBmXfpFdGzL96vkMGCwvOnzmDozG0+5wOm+7wrmLOj/D5cHQ5PgIuWifERQHVeTc7L5GUu9kxa5P7F5tc/Pb+ZjmyPMMScmV9NCzcc+lcXmdmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yXgcrsC52bnDDEyP7U56VlvgXG7ogzVEhB4RuZA7bM=;
 b=3jb7eVAXUtY/hljXQD4TFZd2O8+G+tExdnkIQmbNcU2om4tS17ELPNAuvI+lOXqD+fJzTaagltECOSSXYW6mobLF/KSrSYto/5neNpUcoZLyooHRo07vdj529UAMZ/1v/L3zdgAa4SiVSk0nUNm8vfPa+ggdJn6wesKD8iJ/AkQ=
Received: from DS1P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:454::18) by
 SA5PPFCB4F033D6.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e2)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 19:36:02 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:8:454:cafe::7) by DS1P222CA0005.outlook.office365.com
 (2603:10b6:8:454::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:36:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:36:01 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:59 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:56 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 74/95] drm/amdkfd: program compute MQD coherent_aql_mtype on
 GFX 12.1
Date: Fri, 21 Aug 2026 15:34:37 -0400
Message-ID: <20260821193458.808626-75-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|SA5PPFCB4F033D6:EE_
X-MS-Office365-Filtering-Correlation-Id: 45954358-4b31-4e3b-c949-08deffbb6f06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1mKC9me0bklQb800mNmN9hOGWx93K5znPPo1RQRKHgqC9RiEgttP9nwXg0Owu0uyfu+RJ+oRtu40ApUmgFN6PrmwFaQLHHWHiuU6+a9eTPHrZ0yt7jCKsta6GX5YVgDUnj1pcZZrQHrndYvBM9PtcVH8mG13e8tzpEY3EKNDq1ncuFcuzCGkyuRW2F5fP0OBw0KStTD1ECiOPodl10BrrgcNlvEBHJPXAmptxoawTXrMAwlo/Ep3ReSAnrfhD1YNfU+VmWzyB5I88+19DlmNMjnihOe4Ta6z9j9fNF6NHi+7SCnvQJjOzf/sXGIBDt/T19huHjM8KqYG0uzEzRXDUD0v99eh5ViI8H0IrFY64NMMlaRy4aQs567Q/Hh/Pf9FmRb2kWNHL1DALfb+3LZM78rtGCnMGLoLBQqNltKQ8kl+7KZN517d/YcDzA4Vlz2Oka7pCfeJVyIXrX2W+8ooTnMHsLKYiGk20i69kXQNkjQn68LjV3Ik9vXsPvjcvBU7rWfGiwcxZAA75GVNDYQOxlKthZn/F/yqOUX3Exa7U4QcIkUl2FC04sNyzqoZgh+VlG0tLY4M4nVDASxaV/nc2Kyf3E5diKIqFqjlunCMJNUISq0RIXJm3aiqHa7y+xrYSUoDcrkzeEdsZYUR7It+pn5NtBEXKsDfFOIqtnM+vAFZlevyrg/qRjeEqHy3RAjhGu3S8bUQ+onNAufVzegbmQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AWoPjVQxpE+Qc30C1v1KC2eqpOR6zEzjZAUPCaTnIL089r8Ufo1u/iN+js583nhwveO/b6+xjA3KGWghsgc6haxZXUHAs+CsoT3Ufa+gQGX971xr35EgU17nNFNXKfkQi4RCczjE5e7KZ7It2bYHX891qxg4ztg80sHFY7Gy0WGrD2DuX44UKzqd1RqjWX+CL1X61iNhMb4diKJrtCmZx1LkR7MivSt3QNQ8jRnfTJbRvw362mpDfssYWq2nFtrf+F9p4O6i3FDUJsxFvsEIypZJeRM1dyktRPcMey4yUnzTtcS2QCS1FeSSUJs62JHciNVMd4XXTOBSq13hTwItRZMtY9ymmn3VDU9/jQtwW3B/yCsFECWakwdfLINJFaWwbOD7wwhs2u7V6mmXXWDKz7y6gZp8RpZIsc+KXnRSbmk5ybmVO3fIhcax/r2FVel2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:36:01.8907 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45954358-4b31-4e3b-c949-08deffbb6f06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFCB4F033D6
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


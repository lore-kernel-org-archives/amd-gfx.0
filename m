Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297DD606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 01:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ivWxsrXW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B31431125FE;
	Fri, 30 Oct 2026 01:26:18 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010029.outbound.protection.outlook.com [52.101.201.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AE0D1125FA
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 01:26:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ssggpEHfJ7wAMxXvlTeSjotj8CMhW9nZSzhW3Kuv3Hx1VVi4bQjsgMetgLIGHk1D+q8vhDfnOHvIxnc0ptsbZW00fL2mCLa3KB9mSaaOSG0KXl6nyzVWjhMDYAlG2BqSxjRwsJ7HJbWNHhDRbDTCq6BctjnaWB/hH7xAKQ7Use2ns9RSonGp1o4rYooC9fi4rHeIU5Dnfe7Pu8F6+JfoxRwkWh7KCXA4kyvGZWSuSDnrNriqk1DUb7/gPkDQvgp3Bp9Zq2xyJNlUrge1jOwCnVPxC5jHxS/FwO1CcpudcYCtDFS83X1VQe+forScApD6s29jxYbpMVv99a7sIdLrVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOC+e71WT0bM9fyWgy7wVlvse87ohuPUmm+wDOjqPdY=;
 b=Xukmm6KD3IyKj0Ds7vmrhxVkM5n/WGHLBEyTn1YoAFkKyjaIscGZdZidUQG/imqJZrV4hClveF0+uxuqG4eEmmAicjf3yq7sfiVQ5XsypFO4U9arMgecJLqdTP/HcpSevl0FHrQKDv/pSdOziQmvTKulKU20U3WG5LWrQwQqgY0c0d4UlmHaM0O50ri1rQdXCSkc4z/fKvsuiaZey1JvE1jktgwnEAmtNLFBn/3b+l+jdHICZlu8rw57vwkRwTH4YUyiPjm90vdA/VRjbK459ch9wsviThmh/CMZlIb6OIuqOIwFNK89uk/eKXC+Yaqgcv1moLR8HJCVxx+fm5AdvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOC+e71WT0bM9fyWgy7wVlvse87ohuPUmm+wDOjqPdY=;
 b=ivWxsrXWh/k0rgkGZBplJRSzUjOgo3SssoiCfubc6xZdX08XCfY9CLDSq1+EcLH4/hmyt+/9AnTywNu6ecE2nH2gTAzCOme/e0+r03+319sculoDTezksk6YIO8yZSLeP+Y45XmGRMTbzxUalhSjlXktXUp7tNnvWZryjxpXmpg=
Received: from PH7P220CA0047.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::6)
 by CH3PR12MB8188.namprd12.prod.outlook.com (2603:10b6:610:120::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 01:26:04 +0000
Received: from PH1PEPF00062F24.namprd02.prod.outlook.com
 (2603:10b6:510:32b:cafe::5) by PH7P220CA0047.outlook.office365.com
 (2603:10b6:510:32b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.9 via Frontend Transport; Fri, 30
 Oct 2026 01:26:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH1PEPF00062F24.mail.protection.outlook.com (10.167.243.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 01:26:02 +0000
Received: from alex-sierra-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 29 Oct
 2026 20:26:01 -0500
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Lijo.Lazar@amd.com>, <Mukul.Joshi@amd.com>,
 <Harish.Kasiviswanathan@amd.com>, Alex Sierra <alex.sierra@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: add persisting GL2 cache size support for
 gfx12.1
Date: Thu, 29 Oct 2026 20:25:47 -0500
Message-ID: <20261030012548.3262507-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261017165716.2829539-1-alex.sierra@amd.com>
References: <20261017165716.2829539-1-alex.sierra@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH1PEPF00062F24:EE_|CH3PR12MB8188:EE_
X-MS-Office365-Filtering-Correlation-Id: 5183333a-90be-407e-d7e7-08df3624c31a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|11063799006|5023799004|56012099006|261009223327099003|261009221727099003|261009223027099003|261009221227099003|261009220027099003|261026121527099003|261026140227099003|261028144727099003|261022075727099003|261021123027099003|261021121427099003|261022105027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: laPpOdghMgJhF1XfIK8nYrxF2MorhCDzFckf0DvrgKxhXW5mJBoHAR5oSE4FX0sVT7e9MYLuKMkuA4+GoT8epXLjUwQvb9NBW8XLYp4JWitv0nsFn0bI59RUQymNAyOZBgMNGbkapQCWI1GhGnYhBFBtwNcgNoItQHxtPhJ0N78fi7V3lBKT5puIgOn77vCAJQnxYs6jLvcdZBJPHcCb4Kg2KqVklb6Zz5udtivGjhc1PD6zkJxkgTFRzIQ5Piuo8q5esYt+bzWi5m1C+6ELmymSkuqeO8bTvNowBoFobDwKXr7lwyXgMc1pg8SWU8n6FDIAt9AKRLrnwre3mWlr7Fa+udqqFTyC6sU40xdjY2/Ydw1c7yMhUcfIiM59OOQ6+nmQAbOo/Urpl/t2J7n2F6snZPuUEP+akJ58h6i5fdvhUH6jRtcrda2PxwJu5vBC9ijSJ2Mqtok5Ka1lsDuxdnME0OiJnu7aed7xPMmAbmBjMyTTPxfmIxrLTn40JTJ2G9W67CNQlBd8fSHsKw5u9/PJIMSuWhH7aEQwyKoV1OoEqCY1VxGUh4e9cIhsifyeINyqihJr4XSaLSiHVaDKGx2mg3/tSa8W/5JQJmmK2S0VXCaxOJ+LnC6KfZ9+xrcmILZ6/5mm6T8Nbv3RJdKBxR6/Qx8a154MJdwntIxY1ZiGI526cjVtQc/37KjdmPmGfK2DPA/AHYTTVndY9WlRWg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(11063799006)(5023799004)(56012099006)(261009223327099003)(261009221727099003)(261009223027099003)(261009221227099003)(261009220027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261022075727099003)(261021123027099003)(261021121427099003)(261022105027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XxHRVoF+zGmqcMmwPFxV2wyE8tcJ2SZUewlSugcSO7yEdVZG92l3kcMWGccPeh2/i3Fqpp0ppiF3GDI/d/2+CKlTeU6bcWAtWLfEeFFfBYIxbug3Tcs7sgdrYEYbxs+J46R2OFF+L+prJ70gKWCFk91mkJxwwOEHV296V97133buq9y09rN9YyOKiHgMP2yRcLq+vgXlzi48c0/ZF3cfVHmf5eKiW+ZVRHJPIMdCyb9gApMg3g9c+zSFG96nzJIbQoPIFJbubVk83BBadkbIUm/N78QPJC5HbYYErNA7eJ5ufW1CV6FYfDrQrymQOFk63Ym4uG48U/FBWLISNVABTDvQH9z265zW1FSKMeIoUkwbkNzqafDiRMIC3xC5css0a8c2sIOO+GbN/Ozw7PXF/Lb5IOFJjGAFUYoSLzblXp2E9bIMHYNk2OYu5o6liS0p
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 01:26:02.8822 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5183333a-90be-407e-d7e7-08df3624c31a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH1PEPF00062F24.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8188
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Expose a new "persisting GL2 cache size" property for GC 12.1.0 through
two interfaces:

- AMDGPU_INFO ioctl: report the per-GL2-instance maximum (in bytes)
  through the new AMDGPU_INFO_GL2_PERSISTING_CACHE_SIZE_MAX query.
- DRM_IOCTL_AMDGPU_VM: let user mode (e.g. ROCr) request a persisting
  cache size for its VM via the new AMDGPU_VM_OP_GL2_PERSISTING_L2_CACHE
  op (the size in bytes is carried in the flags/size union of
  drm_amdgpu_vm_in), and read the current request back via
  AMDGPU_VM_OP_GL2_PERSISTING_L2_CACHE_GET (returned in the size field of
  drm_amdgpu_vm_out). Exposing both on the render node lets a request be
  saved and restored through the same interface it was configured on
  (e.g. CRIU checkpoint/restore). The default is 0.

The persisting GL2 cache is accounted per GL2 instance, the granularity
at which GL2 and its residency control are physically partitioned. The
generic gfx layer stays ASIC-agnostic and learns the number of GL2
instances and the instance(s) backing a GPU partition through SOC
callbacks. On gfx12.1 a GL2 instance maps 1:1 to an AID (gc12.1.0 has up
to 2 AIDs, each with its own L2 shared by its XCDs), so those callbacks
are implemented in terms of the device's AID mask.

The sizing comes from the IP discovery GC info table (gc_info v1.5):
gc_cache_ways_size_in_bytes is the persisting budget for the whole
device (the total across all GL2 instances, e.g. 12MB on a 2-instance
gc12.1.0) and gc_max_num_residency_ways is the way cap. The per-instance
maximum reported to user mode is derived on demand as the total budget
divided by the number of GL2 instances
(amdgpu_gfx_gl2_persisting_max_per_instance()); a table that does not
advertise a budget self-gates the feature to 0.

A requested size is translated into the 4-bit
GL2C_RESIDENCY_CTRL.RESIDENCY_WAYS field and programmed by a new gfx12.1
callback. The mapping is linear: 0 bytes disables it, the per-instance
maximum maps to gc_max_num_residency_ways ways, and intermediate sizes
scale proportionally, clamped to the way cap.

The feature is only offered in the SPX and DPX compute partition modes,
where a partition maps to whole GL2 instances that it owns exclusively
(on gfx12.1: SPX owns all AIDs; DPX owns one AID each). In TPX/QPX/CPX
several partitions share a single GL2 instance's L2, so the per-instance
request model does not apply: the AMDGPU_INFO query reports 0 and
AMDGPU_VM_OP_GL2_PERSISTING_L2_CACHE returns -EOPNOTSUPP
(amdgpu_gfx_gl2_residency_mode_supported()).

Each request is scoped to the GL2 instances of the process's GPU
partition (derived from the file private's xcp_id) and added to a
per-instance running total kept by a device-wide manager; the VM
remembers its own contribution so it can be removed again when the
request changes or the VM is torn down. The hardware is programmed from
the per-instance aggregate of all requests, clamped to the per-instance
maximum:
- a single process controls its instances' setting directly;
- processes that share a GL2 instance (multiple processes in the same
  partition) have their sizes summed for that instance;
- when the last requester on a GL2 instance goes away the aggregate is
  0, resetting RESIDENCY_WAYS to 0 for that idle instance.

The GL2C_RESIDENCY_CTRL register is not yet in the public register
headers, so its offset is defined locally in the gfx12.1 code.

Bump the KMS driver minor version so user space can detect the new UAPI.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   7 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       | 272 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  55 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  48 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |   7 +
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c        | 114 ++++++++
 include/uapi/drm/amdgpu_drm.h                 |  23 +-
 9 files changed, 525 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 7e7ce0d3f3f2..ac4c07c0e719 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -286,6 +286,13 @@ static int hw_id_map[MAX_HWIP] = {
 	[UMSCH_HWIP]	= UMSCH_HWID,
 	[ISP_HWIP]	= ISP_HWID,
 	[ATU_HWIP]	= ATU_HWID,
+	/*
+	 * AID-GC block (per-AID GC, hosts the AID-resident GL2). Needed so
+	 * reg_offset[AIGC_HWIP][aid] is populated from IP discovery and the
+	 * per-AID GL2 registers (e.g. GL2C_RESIDENCY_CTRL) can be reached via
+	 * RREG32_SOC15(AIGC, aid, ...). Only enumerated on gfx12.1+ (MI400).
+	 */
+	[AIGC_HWIP]	= AIGC_HWID,
 };
 
 static int amdgpu_discovery_get_tmr_info(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index c636c9f7396e..bc801afe16b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -128,9 +128,11 @@
  * - 3.63.0 - GFX12 display DCC supports 256B max compressed block size
  * - 3.64.0 - Userq IP support query
  * - 3.65.0 - Add userq syncobj timeline signaling support
+ * - 3.66.0 - Add persisting GL2 cache size query, AMDGPU_VM_OP_GL2_PERSISTING_L2_CACHE and
+ *            AMDGPU_VM_OP_GL2_PERSISTING_L2_CACHE_GET
  */
 #define KMS_DRIVER_MAJOR	3
-#define KMS_DRIVER_MINOR	65
+#define KMS_DRIVER_MINOR	66
 #define KMS_DRIVER_PATCHLEVEL	0
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 4cf0784121a5..1bbb3d646cfe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1015,6 +1015,278 @@ void amdgpu_gfx_off_ctrl_immediate(struct amdgpu_device *adev, bool enable)
 	amdgpu_gfx_do_off_ctrl(adev, enable, true);
 }
 
+/**
+ * amdgpu_gfx_gl2_persisting_mgr_init - initialize persisting GL2 accounting
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Must be called by an ASIC that implements set_persisting_gl2_cache before
+ * any request is tracked.
+ */
+void amdgpu_gfx_gl2_persisting_mgr_init(struct amdgpu_device *adev)
+{
+	struct amdgpu_gl2_persisting_mgr *mgr = &adev->gfx.gl2_persisting;
+
+	mutex_init(&mgr->lock);
+	memset(mgr->instance_sum, 0, sizeof(mgr->instance_sum));
+	mgr->initialized = true;
+}
+
+/* Number of GL2 instances the persisting GL2 cache is accounted across. The
+ * SOC callback owns the ASIC-specific definition (e.g. one per AID on MI450);
+ * default to a single instance when no callback is provided.
+ */
+static u32 amdgpu_gfx_gl2_num_instances(struct amdgpu_device *adev)
+{
+	if (adev->gfx.funcs->get_num_gl2_instances) {
+		u32 n = adev->gfx.funcs->get_num_gl2_instances(adev);
+
+		if (n)
+			return min_t(u32, n, AMDGPU_GL2_PERSISTING_MAX_INSTANCES);
+	}
+
+	return 1;
+}
+
+/**
+ * amdgpu_gfx_gl2_persisting_instance_mask - GL2 instances reachable by a GPU
+ * partition
+ *
+ * @adev: amdgpu_device pointer
+ * @xcp_id: partition id from the file private (AMDGPU_XCP_NO_PARTITION for
+ *          whole-GPU)
+ *
+ * Returns the mask of GL2 instances a process on @xcp_id can use. Falls back
+ * to all instances when there is no partitioning.
+ */
+u32 amdgpu_gfx_gl2_persisting_instance_mask(struct amdgpu_device *adev, u32 xcp_id)
+{
+	u32 all = GENMASK(amdgpu_gfx_gl2_num_instances(adev) - 1, 0);
+	struct amdgpu_xcp *xcp;
+	u32 xcc_mask;
+
+	if (!adev->xcp_mgr || xcp_id == AMDGPU_XCP_NO_PARTITION ||
+	    xcp_id >= adev->xcp_mgr->num_xcps ||
+	    !adev->gfx.funcs->xcc_to_gl2_instance_mask)
+		return all;
+
+	xcp = &adev->xcp_mgr->xcp[xcp_id];
+	if (amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX, &xcc_mask))
+		return all;
+
+	/* The XCP instance mask is in logical XCC space; the SOC-specific gfx
+	 * callback maps it to the set of GL2 instances those XCCs use.
+	 */
+	return adev->gfx.funcs->xcc_to_gl2_instance_mask(adev, xcc_mask);
+}
+
+/**
+ * amdgpu_gfx_gl2_residency_mode_supported - is GL2 residency control allowed
+ * in the current GPU partition mode?
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * GL2 residency control (the persisting cache size and the HT residency
+ * threshold) programs per-AID GL2C_RESIDENCY_CTRL state. It is only offered
+ * when a GPU partition maps to whole AIDs that it owns exclusively: SPX (a
+ * single partition owns all AIDs) and DPX (one partition per AID). In
+ * TPX/QPX/CPX several partitions share a single AID's L2, so the per-AID
+ * model does not apply and the feature is disabled. A device without a
+ * partition manager behaves like SPX.
+ */
+bool amdgpu_gfx_gl2_residency_mode_supported(struct amdgpu_device *adev)
+{
+	int mode;
+
+	if (!adev->xcp_mgr)
+		return true;
+
+	mode = amdgpu_xcp_query_partition_mode(adev->xcp_mgr, AMDGPU_XCP_FL_NONE);
+	switch (mode) {
+	case AMDGPU_SPX_PARTITION_MODE:
+	case AMDGPU_DPX_PARTITION_MODE:
+		return true;
+	default:
+		return false;
+	}
+}
+
+/**
+ * amdgpu_gfx_gl2_persisting_max_per_instance - per-instance persisting GL2
+ * cache limit
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * The IP discovery GC info table (v1.5) reports the whole-chip persisting GL2
+ * budget in gc_cache_ways_size_in_bytes (the total across all GL2 instances,
+ * e.g. 12MB on a 2-instance MI450). GL2 is shared per instance and the
+ * residency limit is enforced per instance, so return the total divided by
+ * the number of GL2 instances in the system.
+ *
+ * A zero budget means the discovery table does not describe this feature
+ * (ASICs without persisting GL2 support, or pre-v1.5 tables), or the current
+ * partition mode does not support it (TPX/QPX/CPX); return 0 so it is not
+ * advertised.
+ */
+u32 amdgpu_gfx_gl2_persisting_max_per_instance(struct amdgpu_device *adev)
+{
+	u32 total = adev->gfx.config.gc_cache_ways_size_in_bytes;
+
+	if (!total || !amdgpu_gfx_gl2_residency_mode_supported(adev))
+		return 0;
+
+	return total / amdgpu_gfx_gl2_num_instances(adev);
+}
+
+/**
+ * amdgpu_gfx_gl2_persisting_mgr_fini - tear down persisting GL2 accounting
+ *
+ * @adev: amdgpu_device pointer
+ */
+void amdgpu_gfx_gl2_persisting_mgr_fini(struct amdgpu_device *adev)
+{
+	struct amdgpu_gl2_persisting_mgr *mgr = &adev->gfx.gl2_persisting;
+
+	if (!mgr->initialized)
+		return;
+
+	mutex_destroy(&mgr->lock);
+	mgr->initialized = false;
+}
+
+/* (Re)program the hardware for every GL2 instance from the running
+ * per-instance totals, each clamped to the per-instance maximum. Caller must
+ * hold mgr->lock.
+ */
+static int amdgpu_gfx_gl2_persisting_reprogram(struct amdgpu_device *adev)
+{
+	struct amdgpu_gl2_persisting_mgr *mgr = &adev->gfx.gl2_persisting;
+	u32 max = amdgpu_gfx_gl2_persisting_max_per_instance(adev);
+	u32 instance_mask = GENMASK(amdgpu_gfx_gl2_num_instances(adev) - 1, 0);
+	int inst, r = 0;
+
+	if (!adev->gfx.funcs->set_persisting_gl2_cache)
+		return -EOPNOTSUPP;
+
+	for_each_inst(inst, instance_mask) {
+		r = adev->gfx.funcs->set_persisting_gl2_cache(adev, inst,
+						min_t(u64, mgr->instance_sum[inst], max));
+		if (r)
+			break;
+	}
+
+	return r;
+}
+
+/**
+ * amdgpu_gfx_gl2_persisting_set - set a VM's persisting GL2 cache request
+ *
+ * @adev: amdgpu_device pointer
+ * @vm: the requesting VM
+ * @instance_mask: mask of GL2 instances the request applies to (see
+ *            amdgpu_gfx_gl2_persisting_instance_mask())
+ * @size: requested persisting size in bytes (0 clears the request)
+ *
+ * Records/updates the request for @vm and reprograms the hardware using the
+ * per-instance aggregate of all outstanding requests, clamped to the
+ * per-instance maximum. With a single requester this effectively lets it
+ * control the setting directly; with multiple requesters their sizes are
+ * summed per GL2 instance.
+ */
+int amdgpu_gfx_gl2_persisting_set(struct amdgpu_device *adev,
+				  struct amdgpu_vm *vm, u32 instance_mask, u32 size)
+{
+	struct amdgpu_gl2_persisting_mgr *mgr = &adev->gfx.gl2_persisting;
+	int inst, r;
+
+	if (!mgr->initialized || !adev->gfx.funcs->set_persisting_gl2_cache)
+		return -EOPNOTSUPP;
+
+	/* GL2 residency control is only available in SPX/DPX partition modes;
+	 * in TPX/QPX/CPX several partitions share a GL2 instance's L2 (see
+	 * amdgpu_gfx_gl2_residency_mode_supported()).
+	 */
+	if (!amdgpu_gfx_gl2_residency_mode_supported(adev))
+		return -EOPNOTSUPP;
+
+	mutex_lock(&mgr->lock);
+
+	/* Swap this VM's previous contribution for the new one in the
+	 * per-instance totals: back out the old size from the instances it used
+	 * to target, then add the new size to the instances it targets now.
+	 */
+	for_each_inst(inst, vm->gl2_persisting_instance_mask)
+		mgr->instance_sum[inst] -= vm->gl2_persisting_size;
+	for_each_inst(inst, instance_mask)
+		mgr->instance_sum[inst] += size;
+
+	vm->gl2_persisting_size = size;
+	vm->gl2_persisting_instance_mask = size ? instance_mask : 0;
+
+	r = amdgpu_gfx_gl2_persisting_reprogram(adev);
+
+	mutex_unlock(&mgr->lock);
+	return r;
+}
+
+/**
+ * amdgpu_gfx_gl2_persisting_get - read back a VM's persisting GL2 cache request
+ *
+ * @adev: amdgpu_device pointer
+ * @vm: the VM to query
+ *
+ * Returns the persisting GL2 cache size (in bytes) currently requested by @vm,
+ * or 0 if @vm has no outstanding request (or the feature is unsupported).
+ * Exposed to user mode through AMDGPU_VM_OP_GL2_PERSISTING_L2_CACHE_GET so a
+ * request configured via the render node can be saved and restored (e.g. by
+ * CRIU checkpoint/restore) through that same interface.
+ */
+u32 amdgpu_gfx_gl2_persisting_get(struct amdgpu_device *adev,
+				  struct amdgpu_vm *vm)
+{
+	struct amdgpu_gl2_persisting_mgr *mgr = &adev->gfx.gl2_persisting;
+	u32 size;
+
+	if (!mgr->initialized)
+		return 0;
+
+	mutex_lock(&mgr->lock);
+	size = vm->gl2_persisting_size;
+	mutex_unlock(&mgr->lock);
+
+	return size;
+}
+
+/**
+ * amdgpu_gfx_gl2_persisting_remove - drop a VM's persisting GL2 cache request
+ *
+ * @adev: amdgpu_device pointer
+ * @vm: the VM being torn down
+ *
+ * Removes @vm's contribution and reprograms the hardware. When the last
+ * request is removed the aggregate becomes 0, which resets
+ * RESIDENCY_WAYS to 0 for an idle GPU.
+ */
+void amdgpu_gfx_gl2_persisting_remove(struct amdgpu_device *adev,
+				      struct amdgpu_vm *vm)
+{
+	struct amdgpu_gl2_persisting_mgr *mgr = &adev->gfx.gl2_persisting;
+	int inst;
+
+	if (!mgr->initialized)
+		return;
+
+	mutex_lock(&mgr->lock);
+	if (vm->gl2_persisting_size) {
+		for_each_inst(inst, vm->gl2_persisting_instance_mask)
+			mgr->instance_sum[inst] -= vm->gl2_persisting_size;
+		vm->gl2_persisting_size = 0;
+		vm->gl2_persisting_instance_mask = 0;
+		amdgpu_gfx_gl2_persisting_reprogram(adev);
+	}
+	mutex_unlock(&mgr->lock);
+}
+
 int amdgpu_set_gfx_off_residency(struct amdgpu_device *adev, bool value)
 {
 	int r = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 83e7e678a1ff..1b01dacddd25 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -382,6 +382,22 @@ struct amdgpu_gfx_funcs {
 	int (*get_xccs_per_xcp)(struct amdgpu_device *adev);
 	void (*get_hdp_flush_mask)(struct amdgpu_ring *ring,
 				uint32_t *ref_and_mask, uint32_t *reg_mem_engine);
+	/* Program the persisting portion of the GL2 cache for a single GL2
+	 * instance. @instance is the GL2 instance index; @size is the
+	 * aggregate persisting size in bytes for that instance (already
+	 * clamped to the per-instance maximum).
+	 */
+	int (*set_persisting_gl2_cache)(struct amdgpu_device *adev, u32 instance,
+					u32 size);
+	/* Map a (logical) GFX XCC instance mask to the mask of GL2 instances
+	 * those XCCs use. SOC-specific; used to scope persisting GL2 cache
+	 * requests to the GL2 instances of a GPU partition.
+	 */
+	u32 (*xcc_to_gl2_instance_mask)(struct amdgpu_device *adev, u32 xcc_mask);
+	/* Number of GL2 instances in the device: the granularity at which the
+	 * persisting GL2 cache is accounted and programmed. SOC-specific.
+	 */
+	u32 (*get_num_gl2_instances)(struct amdgpu_device *adev);
 };
 
 struct sq_work {
@@ -430,6 +446,31 @@ struct amdgpu_isolation_work {
 	struct delayed_work		work;
 };
 
+struct amdgpu_vm;
+
+/*
+ * @instance_sum is indexed by GL2 instance. GL2 instances are dense indices
+ * 0..N-1 reported by the SOC (get_num_gl2_instances); a u32 holds the mask of
+ * them, so these 32 entries cover every possible instance regardless of ASIC.
+ * On MI450 a GL2 instance maps 1:1 to an AID, but that stays SOC-specific.
+ */
+#define AMDGPU_GL2_PERSISTING_MAX_INSTANCES	(sizeof(u32) * BITS_PER_BYTE)
+
+/* Device-wide arbiter for the persisting GL2 cache. Like the gfx-off refcount
+ * (adev->gfx.gfx_off_*), this is a device-global gfx resource owned here and
+ * guarded by @lock. L2 is shared per GL2 instance, so all VMs' requests are
+ * accumulated into a running per-instance byte total in @instance_sum; each
+ * instance's total is clamped to the per-instance maximum before being
+ * programmed into GL2C_RESIDENCY_CTRL.RESIDENCY_WAYS. A VM's own contribution
+ * is remembered in the VM (amdgpu_vm.gl2_persisting_*) so it can be subtracted
+ * again on update or teardown.
+ */
+struct amdgpu_gl2_persisting_mgr {
+	struct mutex		lock;
+	u64			instance_sum[AMDGPU_GL2_PERSISTING_MAX_INSTANCES];
+	bool			initialized;
+};
+
 struct amdgpu_gfx {
 	struct mutex			gpu_clock_mutex;
 	struct amdgpu_gfx_config	config;
@@ -563,6 +604,9 @@ struct amdgpu_gfx {
 
 	bool				disable_kq;
 	bool				disable_uq;
+
+	/* Persisting GL2 cache request accounting (gfx12.1+) */
+	struct amdgpu_gl2_persisting_mgr	gl2_persisting;
 };
 
 struct amdgpu_gfx_deferred_entry {
@@ -643,6 +687,17 @@ void amdgpu_gfx_handle_priv_fault(struct amdgpu_device *adev,
 					u8 me_id, u8 pipe_id, u8 queue_id);
 void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable);
 void amdgpu_gfx_off_ctrl_immediate(struct amdgpu_device *adev, bool enable);
+void amdgpu_gfx_gl2_persisting_mgr_init(struct amdgpu_device *adev);
+void amdgpu_gfx_gl2_persisting_mgr_fini(struct amdgpu_device *adev);
+u32 amdgpu_gfx_gl2_persisting_instance_mask(struct amdgpu_device *adev, u32 xcp_id);
+bool amdgpu_gfx_gl2_residency_mode_supported(struct amdgpu_device *adev);
+u32 amdgpu_gfx_gl2_persisting_max_per_instance(struct amdgpu_device *adev);
+int amdgpu_gfx_gl2_persisting_set(struct amdgpu_device *adev,
+				  struct amdgpu_vm *vm, u32 instance_mask, u32 size);
+u32 amdgpu_gfx_gl2_persisting_get(struct amdgpu_device *adev,
+				  struct amdgpu_vm *vm);
+void amdgpu_gfx_gl2_persisting_remove(struct amdgpu_device *adev,
+				      struct amdgpu_vm *vm);
 int amdgpu_get_gfx_off_status(struct amdgpu_device *adev, uint32_t *value);
 int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block);
 void amdgpu_gfx_ras_suspend(struct amdgpu_device *adev, struct ras_common_if *ras_block);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 8fb72a5c999e..dee4789f4bbc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1389,6 +1389,9 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		kfree(caps);
 		return r;
 	}
+	case AMDGPU_INFO_GL2_PERSISTING_CACHE_SIZE_MAX:
+		ui32 = amdgpu_gfx_gl2_persisting_max_per_instance(adev);
+		return copy_to_user(out, &ui32, min(size, 4u)) ? -EFAULT : 0;
 	case AMDGPU_INFO_MAX_IBS: {
 		uint32_t max_ibs[AMDGPU_HW_IP_NUM];
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index d18508e059c6..99ea7f4d13aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2629,6 +2629,10 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	vm->is_compute_context = false;
 	vm->need_tlb_fence = amdgpu_userq_enabled(&adev->ddev);
 
+	/* No persisting GL2 cache request yet (see amdgpu_gfx_gl2_persisting_*). */
+	vm->gl2_persisting_size = 0;
+	vm->gl2_persisting_instance_mask = 0;
+
 	vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
 				    AMDGPU_VM_USE_CPU_FOR_GFX);
 
@@ -2827,6 +2831,11 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
 	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
 
+	/* Drop any persisting GL2 cache request owned by this VM. When the
+	 * last requester goes away this resets RESIDENCY_WAYS to 0.
+	 */
+	amdgpu_gfx_gl2_persisting_remove(adev, vm);
+
 	root = amdgpu_bo_ref(vm->root.bo);
 	amdgpu_bo_reserve(root, true);
 	dma_fence_wait(vm->last_unlocked, false);
@@ -2956,17 +2965,48 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	struct amdgpu_vm *vm = &fpriv->vm;
 
-	/* No valid flags defined yet */
-	if (args->in.flags)
-		return -EINVAL;
-
 	switch (args->in.op) {
 	case AMDGPU_VM_OP_RESERVE_VMID:
+		/* No valid flags defined yet */
+		if (args->in.flags)
+			return -EINVAL;
 		/* We only have requirement to reserve vmid from gfxhub */
 		return amdgpu_vmid_alloc_reserved(adev, vm, AMDGPU_GFXHUB(0));
 	case AMDGPU_VM_OP_UNRESERVE_VMID:
+		/* No valid flags defined yet */
+		if (args->in.flags)
+			return -EINVAL;
 		amdgpu_vmid_free_reserved(adev, vm, AMDGPU_GFXHUB(0));
 		break;
+	case AMDGPU_VM_OP_GL2_PERSISTING_L2_CACHE:
+		/* args->in.size aliases args->in.flags in the union. The current
+		 * request can be read back with
+		 * AMDGPU_VM_OP_GL2_PERSISTING_L2_CACHE_GET. Default is 0.
+		 *
+		 * Only gfx12.1 supports configuring the persisting GL2 cache,
+		 * and only in SPX/DPX partition modes (TPX/QPX/CPX return
+		 * -EOPNOTSUPP). The request is tracked per-VM by the gfx arbiter
+		 * and scoped to the GL2 instances of the process's GPU
+		 * partition; the hardware is programmed from the per-instance
+		 * aggregate of all processes' requests.
+		 */
+		if (adev->gfx.funcs->set_persisting_gl2_cache) {
+			u32 instance_mask = amdgpu_gfx_gl2_persisting_instance_mask(adev,
+								fpriv->xcp_id);
+
+			return amdgpu_gfx_gl2_persisting_set(adev, vm, instance_mask,
+							     args->in.size);
+		}
+		break;
+	case AMDGPU_VM_OP_GL2_PERSISTING_L2_CACHE_GET:
+		/* Read back this VM's current persisting GL2 cache request (in
+		 * bytes) so user mode can save it and restore it later through
+		 * AMDGPU_VM_OP_GL2_PERSISTING_L2_CACHE on the same render node
+		 * (e.g. CRIU checkpoint/restore). Returns 0 when the feature is
+		 * unsupported or no request is outstanding.
+		 */
+		args->out.size = amdgpu_gfx_gl2_persisting_get(adev, vm);
+		return 0;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index fec072f0f2de..6b5ea48b0b68 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -378,6 +378,13 @@ struct amdgpu_vm {
 
 	/* cached fault info */
 	struct amdgpu_vm_fault_info fault_info;
+
+	/* This VM's persisting GL2 cache request (gfx12.1), tracked so the gfx
+	 * arbiter can adjust its per-instance running total on update/teardown
+	 * and read it back (AMDGPU_VM_OP_GL2_PERSISTING_L2_CACHE_GET).
+	 */
+	u32			gl2_persisting_size;		/* bytes */
+	u32			gl2_persisting_instance_mask;	/* GL2 instances it applies to */
 };
 
 struct amdgpu_vm_manager {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 033379da7088..c3a165ca5998 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -22,6 +22,7 @@
  */
 #include <linux/delay.h>
 #include <linux/kernel.h>
+#include <linux/math64.h>
 #include <linux/firmware.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -50,6 +51,11 @@
 #define GFX12_MEC_HPD_SIZE	2048
 #define NUM_SIMD_PER_CU_GFX12_1	4
 
+#define regGL2C_RESIDENCY_CTRL				0x4E69
+#define regGL2C_RESIDENCY_CTRL_BASE_IDX			0
+#define GL2C_RESIDENCY_CTRL__RESIDENCY_WAYS__SHIFT	0x0
+#define GL2C_RESIDENCY_CTRL__RESIDENCY_WAYS_MASK	0x0000000FL
+
 #define RLCG_UCODE_LOADING_START_ADDRESS	0x00002000L
 
 #define regCP_HQD_EOP_CONTROL_DEFAULT                                             0x00000000
@@ -677,6 +683,105 @@ static int gfx_v12_1_ih_to_xcc_inst(struct amdgpu_device *adev, int ih_node)
 	return -EINVAL;
 }
 
+/*
+ * Translate a persisting GL2 cache size (in bytes) into the 4-bit
+ * GL2C_RESIDENCY_CTRL.RESIDENCY_WAYS value. The mapping is linear: a request of
+ * @ways_max_bytes (the per-AID persisting budget) maps to the full @ways_max
+ * ways (gc_max_num_residency_ways), 0 bytes disables it, and the result is
+ * clamped to @ways_max since the GL2 refuses to reserve more than that many
+ * ways per set.
+ */
+static u32 gfx_v12_1_gl2_persisting_size_to_ways(u32 size,
+						 u32 ways_max_bytes,
+						 u32 ways_max)
+{
+	u32 ways;
+
+	if (!ways_max_bytes)
+		return 0;
+
+	/*
+	 * gc_max_num_residency_ways comes from the IP discovery GC info table.
+	 * A zero here means an inconsistent/old table advertised a persisting
+	 * byte budget but no way cap, which would silently reserve nothing.
+	 */
+	if (WARN_ONCE(!ways_max,
+		      "GL2 persisting: gc_max_num_residency_ways is 0\n"))
+		return 0;
+
+	ways = div_u64((u64)size * ways_max, ways_max_bytes);
+
+	return min_t(u32, ways, ways_max);
+}
+
+static int gfx_v12_1_set_persisting_gl2_cache(struct amdgpu_device *adev,
+					      u32 instance, u32 size)
+{
+	/* On MI450 a GL2 instance maps 1:1 to an AID (AID-GC block). */
+	u32 aid = instance;
+	u32 ways, reg;
+
+	/*
+	 * Reg_L2Residency_Ways is a PF-only register. It may be programmed in
+	 * bare-metal or single-VF (one-VF) mode, but never by a guest in
+	 * multi-VF mode, where it would disturb the shared GL2 policy of the
+	 * other VFs (MI400 GLx Delta spec 5.34).
+	 */
+	if (amdgpu_sriov_multi_vf_mode(adev))
+		return -EPERM;
+
+	ways = gfx_v12_1_gl2_persisting_size_to_ways(size,
+						     amdgpu_gfx_gl2_persisting_max_per_instance(adev),
+						     adev->gfx.config.gc_max_num_residency_ways);
+
+	/* Keep the GPU awake while touching GC registers. */
+	amdgpu_gfx_off_ctrl(adev, false);
+
+	/*
+	 * GL2 is shared per AID and lives in the AID-GC ("AIGC") block, so the
+	 * residency register is a single per-AID control addressed through the
+	 * AIGC aperture (reg_offset[AIGC_HWIP][aid]) - not replicated per XCD.
+	 * The AIGC write is broadcast by GRBMA to all GL2Cs of that AID.
+	 */
+	reg = RREG32_SOC15(AIGC, aid, regGL2C_RESIDENCY_CTRL);
+	reg &= ~GL2C_RESIDENCY_CTRL__RESIDENCY_WAYS_MASK;
+	reg |= (ways << GL2C_RESIDENCY_CTRL__RESIDENCY_WAYS__SHIFT) &
+		GL2C_RESIDENCY_CTRL__RESIDENCY_WAYS_MASK;
+	WREG32_SOC15(AIGC, aid, regGL2C_RESIDENCY_CTRL, reg);
+
+	amdgpu_gfx_off_ctrl(adev, true);
+
+	/* When no process is requesting persisting cache on this AID anymore
+	 * (size == 0), it is effectively idle for this feature. Optionally
+	 * flush GL2 here so the next process starts from a clean slate.
+	 * TODO: issue a GL2 writeback/invalidate (regGL2C_WBINVL2).
+	 */
+
+	return 0;
+}
+
+static u32 gfx_v12_1_xcc_to_gl2_instance_mask(struct amdgpu_device *adev,
+					      u32 xcc_mask)
+{
+	u32 phys_mask = 0;
+	int i;
+
+	/* Translate logical XCC instances to physical, then let the SOC layer
+	 * group them into AIDs (it owns the per-AID XCC stride). On MI450 a GL2
+	 * instance maps 1:1 to an AID, so the AID mask is the GL2 instance mask.
+	 */
+	for_each_inst(i, xcc_mask)
+		phys_mask |= BIT(GET_INST(GC, i));
+
+	return soc_v1_0_get_aid_mask(phys_mask);
+}
+
+static u32 gfx_v12_1_get_num_gl2_instances(struct amdgpu_device *adev)
+{
+	/* One GL2 instance per AID on MI450. */
+	return hweight32(adev->aid_mask);
+}
+
 static const struct amdgpu_gfx_funcs gfx_v12_1_gfx_funcs = {
 	.get_gpu_clock_counter = &gfx_v12_1_get_gpu_clock_counter,
 	.select_se_sh = &gfx_v12_1_xcc_select_se_sh,
@@ -687,6 +792,9 @@ static const struct amdgpu_gfx_funcs gfx_v12_1_gfx_funcs = {
 	.update_perfmon_mgcg = &gfx_v12_1_update_perf_clk,
 	.get_xccs_per_xcp = &gfx_v12_1_get_xccs_per_xcp,
 	.ih_node_to_logical_xcc = &gfx_v12_1_ih_to_xcc_inst,
+	.set_persisting_gl2_cache = &gfx_v12_1_set_persisting_gl2_cache,
+	.xcc_to_gl2_instance_mask = &gfx_v12_1_xcc_to_gl2_instance_mask,
+	.get_num_gl2_instances = &gfx_v12_1_get_num_gl2_instances,
 };
 
 static int gfx_v12_1_gpu_early_init(struct amdgpu_device *adev)
@@ -1420,6 +1528,11 @@ static int gfx_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
 
 	mutex_init(&adev->gfx.mec.reset_mutex);
 
+	/* Initialize the persisting GL2 cache request accounting. Paired with
+	 * amdgpu_gfx_gl2_persisting_mgr_fini() in gfx_v12_1_sw_fini().
+	 */
+	amdgpu_gfx_gl2_persisting_mgr_init(adev);
+
 	return 0;
 }
 
@@ -1459,6 +1572,7 @@ static int gfx_v12_1_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	gfx_v12_1_free_microcode(adev);
 	amdgpu_gfx_sysfs_fini(adev);
+	amdgpu_gfx_gl2_persisting_mgr_fini(adev);
 
 	kfree(adev->gfx.ip_dump_core);
 	kfree(adev->gfx.ip_dump_compute_queues);
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 2f3b4710fe0e..a98299187875 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -645,16 +645,31 @@ union drm_amdgpu_sem {
 /* vm ioctl */
 #define AMDGPU_VM_OP_RESERVE_VMID	1
 #define AMDGPU_VM_OP_UNRESERVE_VMID	2
+#define AMDGPU_VM_OP_GL2_PERSISTING_L2_CACHE	3
+#define AMDGPU_VM_OP_GL2_PERSISTING_L2_CACHE_GET	4
 
 struct drm_amdgpu_vm_in {
 	/** AMDGPU_VM_OP_* */
 	__u32	op;
-	__u32	flags;
+	union {
+		__u32	flags;
+		/** Requested persisting GL2 cache size in bytes.
+		 *  Only used by AMDGPU_VM_OP_GL2_PERSISTING_L2_CACHE.
+		 */
+		__u32	size;
+	};
 };
 
 struct drm_amdgpu_vm_out {
-	/** For future use, no flags defined so far */
-	__u64	flags;
+	union {
+		/** For future use, no flags defined so far */
+		__u64	flags;
+		/** Current persisting GL2 cache size in bytes requested by
+		 *  this VM. Returned by
+		 *  AMDGPU_VM_OP_GL2_PERSISTING_L2_CACHE_GET.
+		 */
+		__u64	size;
+	};
 };
 
 union drm_amdgpu_vm {
@@ -1330,6 +1345,8 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
 #define AMDGPU_INFO_GPUVM_FAULT			0x23
 /* query FW object size and alignment */
 #define AMDGPU_INFO_UQ_FW_AREAS			0x24
+/* Max persisting GL2 cache size in bytes (gfx12.1+, 0 on chips without it) */
+#define AMDGPU_INFO_GL2_PERSISTING_CACHE_SIZE_MAX	0x25
 
 /* Hybrid Stack Specific Defs*/
 /* gpu capability */
-- 
2.34.1


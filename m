Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FFB606A338
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 17:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=x/ue6PGJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EAD510E29B;
	Fri, 30 Oct 2026 17:57:19 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010035.outbound.protection.outlook.com
 [52.101.193.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D29510E29B
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 17:57:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=im9WgbGLmBmW6DGoj/ATQ5SPOw8xAwPVFrJ3Zez0vQQ9NO6csJLIFpNL6rHjBCNIV//249ozKZyU7pp82VH/FAk/HEZQy/dUEnAllSNqiXh8bzl+0xBv8cgJwO3qNvXF+v1awYV0W47dPg8E/lrvcDkvbmUTLbqL9G+ZMifxHTMXyMARfYnhPUYJQAccoX2pkD5N8iTxRx7XFWZbtiU1F8nKKwFYN+g2XqBlmiNZ1Lu2IaFlrFo3pvOZpGyxRX4Uie67osfV+EvDv/2t0ltj1zFhUjIWYhQlkdmuStcaZLdN68+31oVqI1KyFoffuOR99K1Nz5GiB4ohY5TnJ3uAiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2DrUaclxdto4xZK7kASvfKPC4Y+57fsOIZfWZhTajEI=;
 b=nqwJkUdsmXrFV6W+hAB6gsb9wHJvgoq9srHhZgO/th1ndS9we9/H8EcRxeGegnZbANW9OJDpuB/YcKg4W0vxp4/Fl2qRnXE/z32rJM6pQqFhjhw9iW7YvOhgcZqFC2sR6L5eHvPiJqLy85lCf4Qb42k++QpCsKuHXzXy9Imjdsy+LyXEgT3zFqgCkSFK22viDB9fa68iHBAeAN6Q3ji44UHQ3j9mguWAMmVtocKHnf7TNg2V1m7e1u5oQXioyrX/ZKGx7oO0bvezd9rCf/GdHYXM7EI08j/G/kcfepN+joP/aDs0yxHAWEQ3fg1v4mEf4MUXWMxvKT7H7XCv4mBzcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DrUaclxdto4xZK7kASvfKPC4Y+57fsOIZfWZhTajEI=;
 b=x/ue6PGJD1UsaBcQZyztnt8lBnnfxqFPQa33Plb4KXkwxc9/qz92oUbqc5XX0fSG6aTeS+ClRcr5nVPas4V9pbhjmSYFWjguIit+0+SVcRnyZK1pEC708yoaZ/2YnnhVmEG2E4ymDvXx306GgIhGuu0YMdUoMbWpszJ2DHXHdgc=
Received: from BN9PR03CA0239.namprd03.prod.outlook.com (2603:10b6:408:f8::34)
 by IA4PR12MB492409.namprd12.prod.outlook.com (2603:10b6:207:129::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 17:57:10 +0000
Received: from BN3PEPF00022BD8.namprd03.prod.outlook.com
 (2603:10b6:408:f8:cafe::1c) by BN9PR03CA0239.outlook.office365.com
 (2603:10b6:408:f8::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.18 via Frontend Transport; Fri,
 30 Oct 2026 17:57:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BD8.mail.protection.outlook.com (10.167.248.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 17:57:09 +0000
Received: from Harpoon.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 12:56:51 -0500
From: Felix Kuehling <felix.kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>, SiuChi Chan
 <siuchi.chan@amd.com>
Subject: [PATCH] drm/amdgpu: Change default mtype_local for GFX12.1
Date: Fri, 30 Oct 2026 13:56:22 -0400
Message-ID: <20261030175622.1165735-1-felix.kuehling@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD8:EE_|IA4PR12MB492409:EE_
X-MS-Office365-Filtering-Correlation-Id: cbb36508-8ff1-467c-c0ea-08df36af3818
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|376014|82310400026|18002099003|56012099006|11063799006|3023799007|261026121527099003|261026140227099003|261022075727099003|261022105027099003|261028144727099003|261021123027099003|261021121427099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: sUP49tXgWZudDAssFX7kkNn7QlHV3kej5Da/1viyIipyHFnLSIJzZ5YEjWwe4201hLZeKecstwYMm84qyZAXpvw8TV8B8x6ja52VdNuxg5myc85F851S08l2ukxwTAkcaDPCZT0tNm2HrICj2t2GkYDeZxgjHBulh8zJP8LESPpsODSJladHUzwkWKdE5FGEeg1SDemLHwQDkr0HotxvsP1IEFlxhyajgIp4B2P1+cc2z80Dt31M3bglRMH1uHDHYVW6SI4qjejde+tfpIbLKtBV8YVnsgkL6m4EPiVNSHxaeuT0OGqRdmdfDAUu6N2ffVlhr651RK5JUjI9K/5NHTFSsyDHGOzsR/40y+DbZV35X/P6TxajowCIDFhqh+bbEO8zP9v/lGRVG3UGNop+/XXSNMREVNbtFeu0TRrCODmOzLR628YDDWzDLYwAaai7lhnYu43y199YKb6aQ5LebG0AkWiC2Ai2X/Tr5eF/T1zYY2KpZnB9HcpBZEEIu00GMgFXp731ePNPqa9ZqxNzwXOcunPHafqCFfgHTc59hYlAja/PH3uCjh76CF1YPQ/nfQjyE2nVVlGJ4yl7gUCdDOUq72Me/vuI38j3iba7ETVYiuS5heHf1Tvwtu9yGnpcefTrxT7h2zkvLk35u1VDlFqfUcv4Jtw36idgnoCrydCZmilxwSqzyRMFM24Sz0glV6SGAVX8bdrQd8rYrWMGkQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(56012099006)(11063799006)(3023799007)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(261028144727099003)(261021123027099003)(261021121427099003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CQCrjQ2/XK2Ovxte322nVLkuGn4zxj5Qk2qvTLVRxqUakHqPdw+OfCZO37dM0/fhL++NJm15Tipu3xQBxofLqmt04Ik/pCZ8v8AtJdzw0Ct13hQbtP9pJEUqhI+snvr5h4x7zlUszo4Zh6G/nhU183A6nEwp1/LXQSPd+I0baGYamf4FM+yqiSWcG4tsKwh2Et6jJ8fOKCPwp/YtwwP0jl7b+PbK9yO9maLCHbJlcaQr9gRXfiQtUHN9xipLhi4H6fDFtYJ66Q7ghMuxgUFzOdTj9gYCAn/IsXYyf/CPvBQc6/9B88fetDXLMxDYI6nXMJ79hVYacxJ+YJramd+v6EM6eiELdDYLuHSWVulmolmWCrnAeAyKYyzPMKNU5xjW1G7SecbtZLKTVJGwlJwOatOA6lbLx3Rnj3vd8r+KT+mqwhN9YaywFNErC/1P0SdV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 17:57:09.7782 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb36508-8ff1-467c-c0ea-08df36af3818
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BD8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB492409
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

Changed the definition of mtype_local=2 to MTYPE_CC or UC depending on
the chip. On GFX12.1 it means MTYPE_UC.

The default local MTYPE on GFX12.1 now depends on the XCD revision due
to ISA changes. Only XCD A0 will support MTYPE_NC.

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Tested-by: SiuChi Chan <siuchi.chan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c  | 13 +++++++++----
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c    |  7 +++++--
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3e5634de077f1..5e0029530b791 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -872,7 +872,7 @@ module_param_named_unsafe(no_queue_eviction_on_vm_fault, amdgpu_no_queue_evictio
  * DOC: mtype_local (int)
  */
 int amdgpu_mtype_local = -1;
-MODULE_PARM_DESC(mtype_local, "MTYPE for local memory (default: ASIC dependent, 0 = MTYPE_RW, 1 = MTYPE_NC, 2 = MTYPE_CC)");
+MODULE_PARM_DESC(mtype_local, "MTYPE for local memory (default: ASIC dependent, 0 = MTYPE_RW, 1 = MTYPE_NC, 2 = MTYPE_CC or MTYPE_UC)");
 module_param_named_unsafe(mtype_local, amdgpu_mtype_local, int, 0444);
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index df72eb2b67ae0..b676830120026 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -630,15 +630,19 @@ static void gmc_v12_1_get_mtypes(struct amdgpu_device *adev,
 				 unsigned int *mtype_remote)
 {
 	bool is_aid_a1 = SOC_V1_0_DIE_REV_AID(adev->rev_id) == 1;
+	bool is_xcd_a0 = SOC_V1_0_DIE_REV_XCD(adev->rev_id) == 0;
 
-	/* Local memory: ASIC default depends on the AID stepping. */
-	*mtype_local = is_aid_a1 ? MTYPE_RW : MTYPE_NC;
+	/* Local memory: Only AID A1 support MTYPE_RW. On AID A0 the default
+	 * MTYPE depends on the XCD revision due to ISA changes
+	 */
+	*mtype_local = is_aid_a1 ? MTYPE_RW :
+		       is_xcd_a0 ? MTYPE_NC : MTYPE_UC;
 	if (amdgpu_mtype_local == 0)
 		*mtype_local = MTYPE_RW;
 	else if (amdgpu_mtype_local == 1)
 		*mtype_local = MTYPE_NC;
 	else if (amdgpu_mtype_local == 2)
-		DRM_INFO_ONCE("MTYPE_CC not supported for local memory\n");
+		*mtype_local = MTYPE_UC;
 
 	/* Remote memory defaults to MTYPE_UC on GFX 12.1. */
 	*mtype_remote = MTYPE_UC;
@@ -648,7 +652,8 @@ static void gmc_v12_1_get_mtypes(struct amdgpu_device *adev,
 		*mtype_remote = MTYPE_UC;
 
 	DRM_INFO_ONCE("Using %s for local memory and %s for remote memory\n",
-		      *mtype_local == MTYPE_RW ? "MTYPE_RW" : "MTYPE_NC",
+		      *mtype_local == MTYPE_RW ? "MTYPE_RW" :
+		      *mtype_local == MTYPE_NC ? "MTYPE_NC" : "MTYPE_UC",
 		      *mtype_remote == MTYPE_NC ? "MTYPE_NC" : "MTYPE_UC");
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index ed5e3318877be..d0773ca9a0659 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1265,7 +1265,7 @@ svm_range_get_pte_flags(struct kfd_node *node, struct amdgpu_vm *vm,
 	bool coherent = flags & (KFD_IOCTL_SVM_FLAG_COHERENT | KFD_IOCTL_SVM_FLAG_EXT_COHERENT);
 	bool ext_coherent = flags & KFD_IOCTL_SVM_FLAG_EXT_COHERENT;
 	unsigned int mtype_local, mtype_remote;
-	bool is_aid_a1, is_local, is_spx;
+	bool is_aid_a1, is_xcd_a0, is_local, is_spx;
 
 	if (domain == SVM_RANGE_VRAM_DOMAIN)
 		bo_node = prange->svm_bo->node;
@@ -1354,12 +1354,15 @@ svm_range_get_pte_flags(struct kfd_node *node, struct amdgpu_vm *vm,
 		break;
 	case IP_VERSION(12, 1, 0):
 		is_aid_a1 = SOC_V1_0_DIE_REV_AID(node->adev->rev_id) == 1;
+		is_xcd_a0 = SOC_V1_0_DIE_REV_XCD(node->adev->rev_id) == 0;
 		is_local = (domain == SVM_RANGE_VRAM_DOMAIN) &&
 				(bo_node->adev == node->adev);
 
 		mtype_local = amdgpu_mtype_local == 0 ? AMDGPU_VM_MTYPE_RW :
 				amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC :
-				is_aid_a1 ? AMDGPU_VM_MTYPE_RW : AMDGPU_VM_MTYPE_NC;
+				amdgpu_mtype_local == 2 ? AMDGPU_VM_MTYPE_UC :
+				is_aid_a1 ? AMDGPU_VM_MTYPE_RW :
+				is_xcd_a0 ? AMDGPU_VM_MTYPE_NC : AMDGPU_VM_MTYPE_UC;
 		/* Remote memory defaults to MTYPE_UC on GFX 12.1 and can be
 		 * overridden through the amdgpu_mtype_remote module parameter
 		 * (0 = MTYPE_NC, 1 = MTYPE_UC).
-- 
2.43.0


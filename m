Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8951DC8302F
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jul 2025 06:45:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31E6A10E4FF;
	Tue,  1 Jul 2025 06:45:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xfvFHYhx";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 722CE10E4FF
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jul 2025 06:45:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uTf/Kjt4FqTG4F1Ygr1zY2zKzO/q9iFOj1suNEWc9uNZHHW75BuuMC8XOLaJ5s1S2FJuEv02WqeUCcpAxnZmkJQ4kDgcnkPJ6wgvP4BFroXa4WTopD9DqPCa34/p+maEcN+9UR83ro4YnuseCFfzFHYA9P25iOsCImD+anLCo9nU+9bqlw7N/8Pplxx49I84D4UBSukP9tkXCK21XgABvpJ+eY54pxmaxk2EB3FF2zIOaPq3DTZtwpay9AcU6LUL9dtJZc+/G5wvH9n1IGetCt+BSStz4sdTSXSeXMLxwi+VAmm4SENGN3HAhDbSKQIPgoHVKkRaJ0Pmeog9/ASqtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSaLe0twTCk+BJjZbqKLIL3aBJLd2Vze64YljWvWce0=;
 b=DOMupxz8pAkzKX7gi1+u53MBa05Nr0FDrwPOFv1Xn4bPdkhCDlz7CleqKuRWxtSLVXRr9/o9KmGjJzkG7fHIV8RuMst8ruiGAxhRhswr4xXmMjdRjTVinK7X88gVeEVKB96OWSszY1s8lacztLQ0PNqI7cte4I/V2P16crGyupwSaG8NbcCgRJcZP00Blyu1RMZTFlYRYE8BXuo5/XwdfnieouGvtrC/VsGMl0XVeKlLsGnJAZHyZGacyc2p6XlDXE94fq9LHPoudfhzbg9DZcs9Z8Bi3uEJd+Akf0r7E38DYgmhYnT8cpU2xnysHORNktAtgqVvSz/UbOp7nF5U1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSaLe0twTCk+BJjZbqKLIL3aBJLd2Vze64YljWvWce0=;
 b=xfvFHYhxPMPRwfbc0jcgK2eMf7XGHgYSTUM+yrKTW39V5eW8ueQPsx8li2RFsKHU1afikvw375PEQUUjbXks5lcJn5nTslyvyRf0iNEyKXGgIpYE1Jifxf1Tf9QeOlq/tiXiTydGHOjfushXAwE1uFYiSneijLVti2lDzDtxAb8=
Received: from BN9PR03CA0081.namprd03.prod.outlook.com (2603:10b6:408:fc::26)
 by MN0PR12MB6149.namprd12.prod.outlook.com (2603:10b6:208:3c7::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Tue, 1 Jul
 2025 06:45:16 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:408:fc:cafe::db) by BN9PR03CA0081.outlook.office365.com
 (2603:10b6:408:fc::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.29 via Frontend Transport; Tue,
 1 Jul 2025 06:45:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 06:45:15 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Jul 2025 01:45:12 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, David Yat Sin <David.YatSin@amd.com>
Subject: [PATCH v2] drm/amdgpu: Unify Device Aperture in amdgpu_info_ioctl for
 KGD/KFD
Date: Tue, 1 Jul 2025 12:14:59 +0530
Message-ID: <20250701064459.287603-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250623111717.224707-1-srinivasan.shanmugam@amd.com>
References: <20250623111717.224707-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|MN0PR12MB6149:EE_
X-MS-Office365-Filtering-Correlation-Id: 38a9c4a8-66f6-4227-3302-08ddb86ad64a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dStSWkZWZjkxZmtQekZqTUZCYlNyQ0wvQ2dTWTlBRExKNmdJRnZnQ1VTVmsy?=
 =?utf-8?B?OXFMODV3OTJYcnBTNk03cnVmdmdQMytQTVByRklraCtJOEJpa1prclVSSG9P?=
 =?utf-8?B?YTl1MmJnbWVPQTMxN05ZTndBWDRwSFZmZUFZWHk3UEg2N2JyUTYwb2hQdWM4?=
 =?utf-8?B?d0tLbzBtWi91QjFDTGdCMEttNlVqQURWL0lrdjRNYW9SdHRSYkd6S3ZxUVR1?=
 =?utf-8?B?UytDMkVoM28wZ284Y2twbzNOSzRmcjh0OWY4aitTL1hGNnlIRVI3NDJ1bDh1?=
 =?utf-8?B?dmRRUnJMUjZKemxjNExlTWhLSmxPbDZtTm5iQ09TY25IcXdESk5IRlltMXY2?=
 =?utf-8?B?NzNJZ0xjQjR6VXdYaEtWcHVGRHRFeUduUFY0RE9UeFdiR244VEpsYWpTelBW?=
 =?utf-8?B?bUJOUzBVZTF0UklqMWd2UHRndnl0SGl3MTVHeHJaRWF4Sm0zM1FkT1JaSXoz?=
 =?utf-8?B?RkQvcG1xeW1PeXBUVmd3WGRCbVEwYXF1Y3crT1p2a2VjOWw3M1BKbENJM0h0?=
 =?utf-8?B?ZHhIUG9DZ20rRTFRUEVjSmorZSswNGFBTUxDbVRpVERoa2JXNWZwbERkK1FQ?=
 =?utf-8?B?TlZBZ1lsb0lxbWNWMVFvL1pkbjJZTnE0dVp4WXd1WFY1WDZBMUx3OXl4Qk1y?=
 =?utf-8?B?Y0VPc0ZPQmlvT0RMUFN1RzRPcUpNeFF5TVJhRGZvNzExNS9mMHhmc1ZFRFVv?=
 =?utf-8?B?UDhsT0dVTUU3ZGJySmxwK2l0eU55T0tITHZBY0NKRk0yalZITWdxbjI4dVJu?=
 =?utf-8?B?dldxYTRUWkxnNzQ0RGxGTU5vWTBYRHk4cmIxYUwvbUIvV01NVWhZUXU2dDVJ?=
 =?utf-8?B?TEMwblB6RXJHZHREcHBHbTVCMjNaYm9obXNNL0x0SFFSMWxjOHpqVks5QnFR?=
 =?utf-8?B?d2tGVGpKSlMzdHptVDFHdUljUm5MK2ZOcUg1U0JLQ2JobUJzNFVBR2p5N0Vi?=
 =?utf-8?B?ZVNRK3NhZkYzUUY0c3hMTk5sYkJZUmFQd041NjZhR2t5eExNek42eUJTdTZz?=
 =?utf-8?B?SHlvcHRrVk9MelpQSGZjcHNCWWlzRWg4S29rZnZjakdGdWlYM3RhVmxRVEEr?=
 =?utf-8?B?Qnc4N1l4bUFTcVJNQjhrQlpocm52TDVYOVdwQ05BcVphdGhBQnl1ejNzUmN6?=
 =?utf-8?B?K1d6VGlkbVU4OXpvQ3B6RGV6NzBKdXhDWGk5R21mdFVUWjlTcC91UUR6NWww?=
 =?utf-8?B?UWhpOFU1OUNYb3I1NFg1QUF5RmFTSytONGdUZ3l1UURpVm5pM0dRdS9EWXVw?=
 =?utf-8?B?OHdCTVVTUG1HMW1MWUNvRlZOd1dWN0VKOEhaUTk4OHB2QklPR2FtOXVwT3dJ?=
 =?utf-8?B?bFp0cHF4RlVwcUFIUnJtWExPcG5qTVdqVC9NL3dYZlJYRGVKT3VKU0EyY1RQ?=
 =?utf-8?B?STcxTVVCbW5pN0NiMFI5UHdKK0xtK3NFSXFqVXE5aFNqSHlOQUJWanpYN3FS?=
 =?utf-8?B?bG4ra29HY0RXL2JHYlE3UVdXQXlFc29reW5UMDNKZFcrV1FSQUdRQ2dtUTdu?=
 =?utf-8?B?MGVnbk1odGtMWlc2Z2ZEa08zNnNsbmVHWDhQc3g1OVh0cXJGMEFFR09Vamhv?=
 =?utf-8?B?TjBuVjV5bXlic245c0szTllhbVB5U1drUXlON1o4SGlzS1hCeUtvRGJIUzA5?=
 =?utf-8?B?L2RwUVNSN1E4UlRPcGlveG1VOXBaclFsa05adXI3QmE5SlZLRUhyNWpKK2lH?=
 =?utf-8?B?RUxpMG9rUzhGZGJ2Um43Y2hBQ3d6NXhTRXluNXlaUm9HUHYvakFvKzVTUXhP?=
 =?utf-8?B?bjdrZ0dqNXhxSVZrK3BrSy82SlVieFBxaEZyQXVXV0FGQlc1RlZqemVkQ0Jy?=
 =?utf-8?B?aFMrcHpMTlFKdytjaDArcVhkckh3bytPSFJBYUg5UHA4M2U0Rlpob2hhMktT?=
 =?utf-8?B?YmtIMSswVTBjWkkyK0RQWkZ5T3JrZUs0Q0ZFbzVQaXA0bFhEWjNYMFB6RDdz?=
 =?utf-8?B?L2loY1lqaHhmdC9vTno1Z24wMDBFTForcHRJV2ovUHhIdW9pWmdlUjE1bTJQ?=
 =?utf-8?B?eFhIRXhTd0pFbWlRRHVNR1E1UG9vUElBRUp5SThESXBGS2VjQ2w3aFZVRkFJ?=
 =?utf-8?Q?wx+C30?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 06:45:15.7264 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a9c4a8-66f6-4227-3302-08ddb86ad64a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6149
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

This commit refines the amdgpu_info_ioctl function to unify
the reporting of device apertures for both KGD and KFD
subsystems.

v2:
- Use amdgpu_ip_version() instead of directly accessing
  adev->ip_versions. (Alex)
- Added AMDGPU_VM_ prefix to scratch and LDS base and limit macros.
  (Christian)
- Clarified in comments that the top 16 bits of the 64-bit address must
  not be 0x0000 or 0xffff to avoid sign extension problems. (Christian)

Cc: David Yat Sin <David.YatSin@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c      | 25 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h       | 23 ++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c | 45 ++++----------------
 include/uapi/drm/amdgpu_drm.h                |  6 +++
 4 files changed, 62 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 4aab5e394ce2..76d902342271 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -46,6 +46,7 @@
 #include "amdgpu_reset.h"
 #include "amd_pcie.h"
 #include "amdgpu_userq.h"
+#include "amdgpu_vm.h"
 
 void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
 {
@@ -1031,6 +1032,30 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 
 		dev_info->userq_ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
 
+		/* Retrieve Device Apertures */
+		if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 0, 0)) {
+			dev_info->lds_base = AMDGPU_VM_MAKE_LDS_APP_BASE_V9();
+			dev_info->scratch_base = AMDGPU_VM_MAKE_SCRATCH_APP_BASE_V9();
+
+			dev_info->lds_limit = AMDGPU_VM_MAKE_LDS_APP_LIMIT(dev_info->lds_base);
+			dev_info->scratch_limit =
+				AMDGPU_VM_MAKE_SCRATCH_APP_LIMIT(dev_info->scratch_base);
+		} else {
+			dev_info->lds_base = AMDGPU_VM_MAKE_LDS_APP_BASE_VI();
+			dev_info->scratch_base = AMDGPU_VM_MAKE_SCRATCH_APP_BASE_VI();
+
+			dev_info->lds_limit = AMDGPU_VM_MAKE_LDS_APP_LIMIT(dev_info->lds_base);
+			dev_info->scratch_limit =
+				AMDGPU_VM_MAKE_SCRATCH_APP_LIMIT(dev_info->scratch_base);
+		}
+
+		dev_dbg(adev->dev, "Node ID: %u\n", adev->dev->id);
+		dev_dbg(adev->dev, "GPU ID: %u\n", dev_info->device_id);
+		dev_dbg(adev->dev, "LDS Base: %llX\n", dev_info->lds_base);
+		dev_dbg(adev->dev, "LDS Limit: %llX\n", dev_info->lds_limit);
+		dev_dbg(adev->dev, "Scratch Base: %llX\n", dev_info->scratch_base);
+		dev_dbg(adev->dev, "Scratch Limit: %llX\n", dev_info->scratch_limit);
+
 		ret = copy_to_user(out, dev_info,
 				   min((size_t)size, sizeof(*dev_info))) ? -EFAULT : 0;
 		kfree(dev_info);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index f3ad687125ad..fd8f6da30096 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -184,6 +184,29 @@ struct amdgpu_bo_vm;
 #define AMDGPU_VM_USE_CPU_FOR_GFX (1 << 0)
 #define AMDGPU_VM_USE_CPU_FOR_COMPUTE (1 << 1)
 
+#define AMDGPU_VM_MAKE_SCRATCH_APP_BASE_VI() \
+	(((uint64_t)(0x1UL) << 61) + 0x100000000L)
+#define AMDGPU_VM_MAKE_SCRATCH_APP_LIMIT(base) \
+	(((uint64_t)(base) & 0xFFFFFFFF00000000UL) | 0xFFFFFFFF)
+
+#define AMDGPU_VM_MAKE_LDS_APP_BASE_VI() \
+	(((uint64_t)(0x1UL) << 61) + 0x0)
+#define AMDGPU_VM_MAKE_LDS_APP_LIMIT(base) \
+	(((uint64_t)(base) & 0xFFFFFFFF00000000UL) | 0xFFFFFFFF)
+
+/* On GFXv9 the LDS and scratch apertures are programmed independently
+ * using the high 16 bits of the 64-bit virtual address. They must be
+ * in the hole, which will be the case as long as the high 16 bits are
+ * neither 0x0000 nor 0xffff to avoid sign extension issues.
+ *
+ * The aperture sizes are still 4GB implicitly.
+ *
+ * Note: While GPUVM apertures are generally not applicable on GFXv9,
+ * there is at least one APU case where GFX9 has a limited GPUVM aperture.
+ */
+#define AMDGPU_VM_MAKE_LDS_APP_BASE_V9() ((uint64_t)(0x1UL) << 48)
+#define AMDGPU_VM_MAKE_SCRATCH_APP_BASE_V9() ((uint64_t)(0x2UL) << 48)
+
 /* VMPT level enumerate, and the hiberachy is:
  * PDB2->PDB1->PDB0->PTB
  */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
index 1d170dc50df3..291b068aaf8a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
@@ -276,35 +276,6 @@
  * for FLAT_* / S_LOAD operations.
  */
 
-#define MAKE_GPUVM_APP_BASE_VI(gpu_num) \
-	(((uint64_t)(gpu_num) << 61) + 0x1000000000000L)
-
-#define MAKE_GPUVM_APP_LIMIT(base, size) \
-	(((uint64_t)(base) & 0xFFFFFF0000000000UL) + (size) - 1)
-
-#define MAKE_SCRATCH_APP_BASE_VI() \
-	(((uint64_t)(0x1UL) << 61) + 0x100000000L)
-
-#define MAKE_SCRATCH_APP_LIMIT(base) \
-	(((uint64_t)base & 0xFFFFFFFF00000000UL) | 0xFFFFFFFF)
-
-#define MAKE_LDS_APP_BASE_VI() \
-	(((uint64_t)(0x1UL) << 61) + 0x0)
-#define MAKE_LDS_APP_LIMIT(base) \
-	(((uint64_t)(base) & 0xFFFFFFFF00000000UL) | 0xFFFFFFFF)
-
-/* On GFXv9 the LDS and scratch apertures are programmed independently
- * using the high 16 bits of the 64-bit virtual address. They must be
- * in the hole, which will be the case as long as the high 16 bits are
- * not 0.
- *
- * The aperture sizes are still 4GB implicitly.
- *
- * A GPUVM aperture is not applicable on GFXv9.
- */
-#define MAKE_LDS_APP_BASE_V9() ((uint64_t)(0x1UL) << 48)
-#define MAKE_SCRATCH_APP_BASE_V9() ((uint64_t)(0x2UL) << 48)
-
 /* User mode manages most of the SVM aperture address space. The low
  * 16MB are reserved for kernel use (CWSR trap handler and kernel IB
  * for now).
@@ -319,8 +290,8 @@ static void kfd_init_apertures_vi(struct kfd_process_device *pdd, uint8_t id)
 	 * node id couldn't be 0 - the three MSB bits of
 	 * aperture shouldn't be 0
 	 */
-	pdd->lds_base = MAKE_LDS_APP_BASE_VI();
-	pdd->lds_limit = MAKE_LDS_APP_LIMIT(pdd->lds_base);
+	pdd->lds_base = AMDGPU_VM_MAKE_LDS_APP_BASE_VI();
+	pdd->lds_limit = AMDGPU_VM_MAKE_LDS_APP_LIMIT(pdd->lds_base);
 
 	/* dGPUs: SVM aperture starting at 0
 	 * with small reserved space for kernel.
@@ -336,21 +307,21 @@ static void kfd_init_apertures_vi(struct kfd_process_device *pdd, uint8_t id)
 	pdd->qpd.cwsr_base = SVM_CWSR_BASE;
 	pdd->qpd.ib_base = SVM_IB_BASE;
 
-	pdd->scratch_base = MAKE_SCRATCH_APP_BASE_VI();
-	pdd->scratch_limit = MAKE_SCRATCH_APP_LIMIT(pdd->scratch_base);
+	pdd->scratch_base = AMDGPU_VM_MAKE_SCRATCH_APP_BASE_VI();
+	pdd->scratch_limit = AMDGPU_VM_MAKE_SCRATCH_APP_LIMIT(pdd->scratch_base);
 }
 
 static void kfd_init_apertures_v9(struct kfd_process_device *pdd, uint8_t id)
 {
-	pdd->lds_base = MAKE_LDS_APP_BASE_V9();
-	pdd->lds_limit = MAKE_LDS_APP_LIMIT(pdd->lds_base);
+	pdd->lds_base = AMDGPU_VM_MAKE_LDS_APP_BASE_V9();
+	pdd->lds_limit = AMDGPU_VM_MAKE_LDS_APP_LIMIT(pdd->lds_base);
 
 	pdd->gpuvm_base = AMDGPU_VA_RESERVED_BOTTOM;
 	pdd->gpuvm_limit =
 		pdd->dev->kfd->shared_resources.gpuvm_size - 1;
 
-	pdd->scratch_base = MAKE_SCRATCH_APP_BASE_V9();
-	pdd->scratch_limit = MAKE_SCRATCH_APP_LIMIT(pdd->scratch_base);
+	pdd->scratch_base = AMDGPU_VM_MAKE_SCRATCH_APP_BASE_V9();
+	pdd->scratch_limit = AMDGPU_VM_MAKE_SCRATCH_APP_LIMIT(pdd->scratch_base);
 
 	/*
 	 * Place TBA/TMA on opposite side of VM hole to prevent
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 66c4a03ac9f9..f285e9325d06 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1477,6 +1477,12 @@ struct drm_amdgpu_info_device {
 	/* Userq IP mask (1 << AMDGPU_HW_IP_*) */
 	__u32 userq_ip_mask;
 	__u32 pad;
+
+	/* Additional fields for memory aperture information */
+	__u64 lds_base;          /* LDS base */
+	__u64 lds_limit;         /* LDS limit */
+	__u64 scratch_base;      /* Scratch base */
+	__u64 scratch_limit;     /* Scratch limit */
 };
 
 struct drm_amdgpu_info_hw_ip {
-- 
2.34.1


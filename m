Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7646C04FF6
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Apr 2024 07:36:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 355F510EE62;
	Fri, 12 Apr 2024 07:36:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SMd3/ky8";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7324510EE62
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 07:36:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJ41SvofjixMSfhM0TqQRF6ZxZ3D9c7T34KGJyLE/mWhw3m3H8dhCIUH37snTDzpcYuHZBZPFRDQ6n/fQH7swL02e+sBKTiCtmR7ikRjUKQJBdJ17pkTqh75x/0rllN5KxgUoTZEX2jVfpv7JjTX+UiiZGmncbPhcFO7cD1JSnGpoo45wlOg0YIix2a7nbIT0iGGIzg3K+2ZbVlkeg4M6JWlrgg4zvUAhYDcsJIaSEvxGI4Q+3SXaM+AAE+yhNGfyzrQtpgvrrlEyspONPeyFXdDrU8wfmBO1ueQY2R/0n13W0jvARh8bE6TZKImEcxoh0wPEcavxL2OKmw6cVijkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOrBcT1myhi77jf4n59nVdWUUVjiJXPv4pD8O7shNQo=;
 b=hc1B9wsgMSGbxmfWlahlOxShuGoOfK+ffowSOvU/N2zyWg2HMXk27usfqmEB4VxSfmjS3vQSHVOKC3SX75BHZxykRfx3e4hI88lwXN0eTc8p1EEOgYbb5KtWCHr2DfFCte861O9OORmrzkDBXlm/iNADdwGS3q2XRDL/GqdsvxsNVjqjpN5CRUfWqwl7qw94xubTrF+A1kdx/L4ZfCmPPs3MP1wiTEm0CqKWHOaOLp9MpGVxEolpdDJuQnOrJPUz+sAqxTNj+xgFeXxsmSDqosfznyZmRORvdkjU7FIqtyX+SRB3e4mGFtPzQCEHrGSsmrjQDbySOedij6f8rDmz/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOrBcT1myhi77jf4n59nVdWUUVjiJXPv4pD8O7shNQo=;
 b=SMd3/ky8wHeEMPXgYZxk0p6fZUAE/ystLkh1Ep5kqOFLVQAWUEkrZDvAEFkz2FxXMsAjUK39G16LyDW2ybQDLgae764NlPpvhEUPxEQ9qjC007nfnfvsicxW/rI+Ysxb24lsOp7RyYkcHm4GNtqT7XYRQ3lChkphqbFpooe7m24=
Received: from BL0PR03CA0032.namprd03.prod.outlook.com (2603:10b6:208:2d::45)
 by DS0PR12MB8072.namprd12.prod.outlook.com (2603:10b6:8:dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 07:36:24 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:2d:cafe::3a) by BL0PR03CA0032.outlook.office365.com
 (2603:10b6:208:2d::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26 via Frontend
 Transport; Fri, 12 Apr 2024 07:36:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 07:36:24 +0000
Received: from pp-server-two.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 12 Apr
 2024 02:36:22 -0500
From: xinhui pan <xinhui.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <jannh@google.com>, xinhui pan <xinhui.pan@amd.com>, Vlad Stolyarov
 <hexed@google.com>
Subject: [PATCH] drm/amdgpu: validate the parameters of bo mapping operations
 more clearly
Date: Fri, 12 Apr 2024 15:35:44 +0800
Message-ID: <20240412073544.10008-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|DS0PR12MB8072:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d0e293e-b16e-4c82-b7d0-08dc5ac34190
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tVhm3KNS51rt1XdByj9o4iPpB418+38g14Y+V1u8jjsyHTOM7QwGGkTwbGcnEnAj9L1cMAy5wZYd5pLslPqcUSjnrFtCjar4WlZKkxYq0aArwtnc/PYcnIXAH+ZWYrneJ+xMBJEmjCV9AKRr4Cj6haxCjj+nlbjrZR16R3yxEWxaGownphKavbk6Dt+BW55esPS+iuA7QVmRBafu7qBq9Ztnm+5tI/9++MVaQ6egEpJrZwrk8JJJzZMOtjepQnxNeUyhlfY4tCA04Y+Egs031RjtGO3rBDQd0ZHPrla/Lw/ZTCMBENoyWAU7wwTVWuB9Pcgt5UC8Q5TxEhaIO4jq/Up5pyMQddAhhRBuAN4Ka+s3JRDeDCTQbvW2tpz8FcZpvdWPjufFxbQF5ecZPqOeIpGRP9eLn5Zinnxmwp6mrDSRBXpW18g8gWzbl4D95EWkXJwtmy/KY3lFdRQGqYzgIt9LggIEJckYrIPWxUfNKI2xW2NrFPNGpEuC3O8OiMrGQNagdTpcgzK40xgtbmgvi8XsQscXeqkBg3gsKSQwdynr95yPcDnzWdJ/grOLDVv4GhiPYXX3LNjLJ+I9ExZOTRTAQxIXrmj9GUs9siOlPT8jLfWuDIznZFBmVPYbMjNcMw8qeqx6NQNIL8zrIaEbys2VSFwD1EbXT+cPA2n4xbr4dDP7dkDCdW2vtF4v1MFZlzd29BOkxQiXsIwHn4Z4EM1GZ3Hsfgn8cMwx3zAYERqw9vq62c9fpddChZ676Qe+
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 07:36:24.4424 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d0e293e-b16e-4c82-b7d0-08dc5ac34190
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8072
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

Verify the parameters of
amdgpu_vm_bo_(map/replace_map/clearing_mappings) in one common place.

Reported-by: Vlad Stolyarov <hexed@google.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 72 ++++++++++++++++----------
 1 file changed, 46 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 8af3f0fd3073..4e2391c83d7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1647,6 +1647,37 @@ static void amdgpu_vm_bo_insert_map(struct amdgpu_device *adev,
 	trace_amdgpu_vm_bo_map(bo_va, mapping);
 }
 
+/* Validate operation parameters to prevent potential abuse */
+static int amdgpu_vm_verify_parameters(struct amdgpu_device *adev,
+					  struct amdgpu_bo *bo,
+					  uint64_t saddr,
+					  uint64_t offset,
+					  uint64_t size)
+{
+	uint64_t tmp, lpfn;
+
+	if (saddr & AMDGPU_GPU_PAGE_MASK
+	    || offset & AMDGPU_GPU_PAGE_MASK
+	    || size & AMDGPU_GPU_PAGE_MASK)
+		return -EINVAL;
+
+	if (check_add_overflow(saddr, size, &tmp)
+	    || check_add_overflow(offset, size, &tmp)
+	    || size == 0 /* which also leads to end < begin */)
+		return -EINVAL;
+
+	/* make sure object fit at this offset */
+	if (bo && offset + size > amdgpu_bo_size(bo))
+		return -EINVAL;
+
+	/* Ensure last pfn not exceed max_pfn */
+	lpfn = (saddr + size - 1) >> AMDGPU_GPU_PAGE_SHIFT;
+	if (lpfn >= adev->vm_manager.max_pfn)
+		return -EINVAL;
+
+	return 0;
+}
+
 /**
  * amdgpu_vm_bo_map - map bo inside a vm
  *
@@ -1673,21 +1704,14 @@ int amdgpu_vm_bo_map(struct amdgpu_device *adev,
 	struct amdgpu_bo *bo = bo_va->base.bo;
 	struct amdgpu_vm *vm = bo_va->base.vm;
 	uint64_t eaddr;
+	int r;
 
-	/* validate the parameters */
-	if (saddr & ~PAGE_MASK || offset & ~PAGE_MASK || size & ~PAGE_MASK)
-		return -EINVAL;
-	if (saddr + size <= saddr || offset + size <= offset)
-		return -EINVAL;
-
-	/* make sure object fit at this offset */
-	eaddr = saddr + size - 1;
-	if ((bo && offset + size > amdgpu_bo_size(bo)) ||
-	    (eaddr >= adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT))
-		return -EINVAL;
+	r = amdgpu_vm_verify_parameters(adev, bo, saddr, offset, size);
+	if (r)
+		return r;
 
 	saddr /= AMDGPU_GPU_PAGE_SIZE;
-	eaddr /= AMDGPU_GPU_PAGE_SIZE;
+	eaddr = saddr + (size - 1) / AMDGPU_GPU_PAGE_SIZE;
 
 	tmp = amdgpu_vm_it_iter_first(&vm->va, saddr, eaddr);
 	if (tmp) {
@@ -1740,17 +1764,9 @@ int amdgpu_vm_bo_replace_map(struct amdgpu_device *adev,
 	uint64_t eaddr;
 	int r;
 
-	/* validate the parameters */
-	if (saddr & ~PAGE_MASK || offset & ~PAGE_MASK || size & ~PAGE_MASK)
-		return -EINVAL;
-	if (saddr + size <= saddr || offset + size <= offset)
-		return -EINVAL;
-
-	/* make sure object fit at this offset */
-	eaddr = saddr + size - 1;
-	if ((bo && offset + size > amdgpu_bo_size(bo)) ||
-	    (eaddr >= adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT))
-		return -EINVAL;
+	r = amdgpu_vm_verify_parameters(adev, bo, saddr, offset, size);
+	if (r)
+		return r;
 
 	/* Allocate all the needed memory */
 	mapping = kmalloc(sizeof(*mapping), GFP_KERNEL);
@@ -1764,7 +1780,7 @@ int amdgpu_vm_bo_replace_map(struct amdgpu_device *adev,
 	}
 
 	saddr /= AMDGPU_GPU_PAGE_SIZE;
-	eaddr /= AMDGPU_GPU_PAGE_SIZE;
+	eaddr = saddr + (size - 1) / AMDGPU_GPU_PAGE_SIZE;
 
 	mapping->start = saddr;
 	mapping->last = eaddr;
@@ -1851,10 +1867,14 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
 	struct amdgpu_bo_va_mapping *before, *after, *tmp, *next;
 	LIST_HEAD(removed);
 	uint64_t eaddr;
+	int r;
+
+	r = amdgpu_vm_verify_parameters(adev, NULL, saddr, 0, size);
+	if (r)
+		return r;
 
-	eaddr = saddr + size - 1;
 	saddr /= AMDGPU_GPU_PAGE_SIZE;
-	eaddr /= AMDGPU_GPU_PAGE_SIZE;
+	eaddr = saddr + (size - 1) / AMDGPU_GPU_PAGE_SIZE;
 
 	/* Allocate all the needed memory */
 	before = kzalloc(sizeof(*before), GFP_KERNEL);
-- 
2.34.1


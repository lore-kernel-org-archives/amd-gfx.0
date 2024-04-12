Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C114C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Apr 2024 06:48:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F56010ECAF;
	Fri, 12 Apr 2024 06:48:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sE1UBWWq";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2051.outbound.protection.outlook.com [40.107.101.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC27110ECAF
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 06:47:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WTX85DxzFw4g67fwpaThxpNFJph9MTi99Kyz1m08Fj6mhHD9oxkrAISQ319AjS7187Qz7NUS3xG7kw1ywWHWVR00B7rUbpiggfAPYDcCw5Rd98GOb+DSb9dPcv3blyCcPcdFpT5MmK0kiQ+H5DhGajwA+EkTsB0skqmKgV2WMT7GywOri77c8SWXc0R6dVAjHav8Nfxn+EzcaqP+XiHW7fGxOAajUXsL/g0n3cT3AGPHBWVNPIM9JlX7KHpnSQTq6KkHJbHfyKG31wgg30gEVfrqCoeIDaDT1q8MfXwhD4O9F6dVllxeNbjgwGFHuk+iM/KFJ8cjEsxqtBP61xRXjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KjFnAJe49Zr8xwWl1vygXSBPmbmSmCet0DdPAAWsDlY=;
 b=dJ1hKpVMsd9r+Y29RWN9JV3J+zrIyHg5RrnFMwLvcX4ZbHcWYFrIWOko7ITI2zQYbAZr/r+MtnFwZe9AVuBT5CjzbODxjhFdkYtjfKypUS7to/3l+MZ8q2z1ekP4TVVgEFZDlFcEuzAXWEoZhpZS314UlHfkEX3jMtyZHxT6fCLDGPzKA/PghGc8Wc6NYOBI0Qqio29/vb/vGXqfaGFjxpgfUzyZNOAwr9vpViWPavz5JiYRuEqby4mmnduwP8R0TJGCAgMPrdKjbys9aenShn+Rcx/l2hb2Hk9yhNi+f7VKmaXXh5iTkVn+e2ZWlZOU3CD3pKlFJBONL6J6ugCRJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjFnAJe49Zr8xwWl1vygXSBPmbmSmCet0DdPAAWsDlY=;
 b=sE1UBWWqIpduUlh5pJkOD1XaLh2+GgJmHqpKTMXQupLdzju0l/IyBc4XVYMxOpgdKkVYN5uYH0Pk+t6CRK6dcybibKjNYr2SEKTSQgHVeI/L34YwjkEEetrIeCwRzlVuA4bMLBN38qCS0KeKluIuCYccqpQsjPIjPbPDYpLmBks=
Received: from SA0PR11CA0021.namprd11.prod.outlook.com (2603:10b6:806:d3::26)
 by DS0PR12MB8785.namprd12.prod.outlook.com (2603:10b6:8:14c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 06:47:50 +0000
Received: from SN1PEPF00036F3C.namprd05.prod.outlook.com
 (2603:10b6:806:d3:cafe::41) by SA0PR11CA0021.outlook.office365.com
 (2603:10b6:806:d3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26 via Frontend
 Transport; Fri, 12 Apr 2024 06:47:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F3C.mail.protection.outlook.com (10.167.248.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 06:47:50 +0000
Received: from pp-server-two.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 12 Apr
 2024 01:47:47 -0500
From: xinhui pan <xinhui.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <jannh@google.com>, xinhui pan <xinhui.pan@amd.com>, Vlad Stolyarov
 <hexed@google.com>
Subject: [PATCH] drm/amdgpu: validate the parameters of bo mapping operations
 more clearly
Date: Fri, 12 Apr 2024 14:47:22 +0800
Message-ID: <20240412064722.5549-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3C:EE_|DS0PR12MB8785:EE_
X-MS-Office365-Filtering-Correlation-Id: bfb4e1a8-14df-46dd-b4df-08dc5abc7883
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nBatWwPXk/ZVHM/0fGSBjD9QB2wrZXtmYRsLKNO+4GcYoVdfAgRU9hFnipmOl5CRF+FCxlcd8BCr3SqKKoOWlDQakZ4paBr65UMfmJwgIveXEUq0Bi6tnM7t8MdQkLAQEjbpwFUT+TY2/d1kxyjCeDytkbTI+Yk2Uej84Pu+9qVlX2L8w+WY9LkNKC/N0DB3TBo6hWZ5V96JFfWijz4unI6BsTiiTa/ZMYuWn6AfFJQVPR9WdhvDOhxph1HmWA2Gr2w+Ew0eYjB++cEtoussEK+RNNlYfwv6cqRI0GjBcW2JG+9bydsxEeGWw1dRB7VbmVvjFR9HDJbnCYCn891QxnlfmvCs5+M2yOfwtAt/hbbtvaKjYVLeK8p5/gRc4kS7QHEiiYgrh6h6bqKwo8JmyNhFOkzyr5eQ2xVPS34/gtpxmNN4hTgy1tyY1CdbhD63+q6J8CNj/feNWl+HSh/UE/D7q35jJt0yUjqeM7YmIWHu8c1d2e3Qjt26E6RaQdj2qqzWGbfDlxgbWzf/ajl0/SWdjvfY3UPBDSGW1cx5EFEvjPpn/HohTm0HBY5r5e7FtxCXaZP+lSm/N4S7l239DfbiSsH6FL5wUb/cjxuj0nY+Gfbgfe+lN/PSGIty22VVXP4Awjc9bSaESUVRfuEwTS5q4j1XVqh2vpcH381Dzoi7wHwn6962dTQlkdaHYh0zuiLvuNExbHy2qrjwZ3EsiH3fq7xmsV+RblpglmN7h9jGCDcRWykEyzh6C/rGqnkB
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 06:47:50.1547 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb4e1a8-14df-46dd-b4df-08dc5abc7883
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8785
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
Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 63 ++++++++++++++++----------
 1 file changed, 39 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 8af3f0fd3073..ea9721666756 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1647,6 +1647,37 @@ static void amdgpu_vm_bo_insert_map(struct amdgpu_device *adev,
 	trace_amdgpu_vm_bo_map(bo_va, mapping);
 }
 
+static int amdgpu_vm_bo_verify_parameters(struct amdgpu_device *adev,
+					  struct amdgpu_bo *bo,
+					  uint64_t saddr,
+					  uint64_t offset,
+					  uint64_t size)
+{
+	size_t tmp, lpfn;
+
+	if (saddr & AMDGPU_GPU_PAGE_MASK
+	    || offset & AMDGPU_GPU_PAGE_MASK
+	    || size & AMDGPU_GPU_PAGE_MASK)
+		return -EINVAL;
+
+	/* Check overflow */
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
@@ -1674,20 +1705,11 @@ int amdgpu_vm_bo_map(struct amdgpu_device *adev,
 	struct amdgpu_vm *vm = bo_va->base.vm;
 	uint64_t eaddr;
 
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
+	if (amdgpu_vm_bo_verify_parameters(adev, bo, saddr, offset, size))
 		return -EINVAL;
 
+	eaddr = (saddr + size - 1) / AMDGPU_GPU_PAGE_SIZE;
 	saddr /= AMDGPU_GPU_PAGE_SIZE;
-	eaddr /= AMDGPU_GPU_PAGE_SIZE;
 
 	tmp = amdgpu_vm_it_iter_first(&vm->va, saddr, eaddr);
 	if (tmp) {
@@ -1740,16 +1762,7 @@ int amdgpu_vm_bo_replace_map(struct amdgpu_device *adev,
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
+	if (amdgpu_vm_bo_verify_parameters(adev, bo, saddr, offset, size))
 		return -EINVAL;
 
 	/* Allocate all the needed memory */
@@ -1763,8 +1776,8 @@ int amdgpu_vm_bo_replace_map(struct amdgpu_device *adev,
 		return r;
 	}
 
+	eaddr = (saddr + size - 1) / AMDGPU_GPU_PAGE_SIZE;
 	saddr /= AMDGPU_GPU_PAGE_SIZE;
-	eaddr /= AMDGPU_GPU_PAGE_SIZE;
 
 	mapping->start = saddr;
 	mapping->last = eaddr;
@@ -1852,9 +1865,11 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
 	LIST_HEAD(removed);
 	uint64_t eaddr;
 
-	eaddr = saddr + size - 1;
+	if (amdgpu_vm_bo_verify_parameters(adev, NULL, saddr, 0, size))
+		return -EINVAL;
+
+	eaddr = (saddr + size - 1) / AMDGPU_GPU_PAGE_SIZE;
 	saddr /= AMDGPU_GPU_PAGE_SIZE;
-	eaddr /= AMDGPU_GPU_PAGE_SIZE;
 
 	/* Allocate all the needed memory */
 	before = kzalloc(sizeof(*before), GFP_KERNEL);
-- 
2.34.1


Return-Path: <SRS0=P/1w=P4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EE9C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 19:13:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CB4661101
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 19:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8CB4661101
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2319F6E17A;
	Tue,  9 Nov 2021 19:13:13 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2046.outbound.protection.outlook.com [40.107.95.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEB0E6E0A0
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Nov 2021 19:13:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+bCbMcygeU0GO7I8sJzQQfenfYkzcPic2JDRDoQbEF4ABjhVb4SO7BMCy9178Wkz0iOyD+gw17axSRe6YkRzx6h+HdTgKmcJvrdznxeVovbpiGhLV9ufUSKFvUeOuYEuVXDTg6U1RUd3/2aqzCyZgyLDv+eHH5KSHYQRtBqOXPC04uVo5F0YeP617F6XjcfoRXMGEAWWDwoYlUeQhrpB3vDPBOo1nbScleLw5haN4ZrqZ5MPRAeUTsiI3YwOCFLOyEMsUs0tx5wQs/GcEvoFYlhV0rnipwTwVcAMyzbR0zPCYCXWvRaiULZ7MgGB6lPGIWQ0N1gNUFAUKKrEu0eoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQt0kcpNrsUFMGYQ1loy/PYaw89hseiT9NTNK4b89aI=;
 b=VpZrP0D9sGNcilLJ7QqlwlLZACSjOgr0n80APK1/CTS/22V4epPZALRIywJR/qP7eJ9FAkhDxpv4LBMSCCB6W6NPT3PEoZHroK84TLxYi5d4AVCSc/ChdlZzM9R3kTs893WZutGCFL1IV1yOu7S5SxfMjUVuQo7NOmfVHUT6kUIbkDPxnNVHunua0wbN9w8tnHKP8bWdDsP5+9PvjtxDQ/hdWrJTxkMzyrPnpvOsq6fYD2V/PXPYVD9ORDqbPQQarTLJtg5mlxNPLVwtZ4ec0eNPsAZZxAcI5xhndZxwa7KdGD+wf7Iy+U3PorjjykiLxU+YyhP09avmdbaEhiQ/6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQt0kcpNrsUFMGYQ1loy/PYaw89hseiT9NTNK4b89aI=;
 b=kMCPYRhAoG4EjCv76QH+nW73Muv0RchkuEsWd5gpO3KgjVkwHbUNm0uJiDkLRJJxCUQr/hY6R95gjw/7cwyGsqhCh23s0EIIQdiIn+RsfM95pCHvKHAic/pMq7eVNflMKbsV/OMrWFmv8JF0w/i4/63AkbqgT3TLHux+qvIylH8=
Received: from DM5PR12CA0060.namprd12.prod.outlook.com (2603:10b6:3:103::22)
 by MN2PR12MB4533.namprd12.prod.outlook.com (2603:10b6:208:266::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Tue, 9 Nov
 2021 19:13:03 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:103:cafe::7b) by DM5PR12CA0060.outlook.office365.com
 (2603:10b6:3:103::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Tue, 9 Nov 2021 19:13:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Tue, 9 Nov 2021 19:13:03 +0000
Received: from RErrabolDevMach.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 9 Nov 2021
 13:12:59 -0600
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Pin MMIO/DOORBELL BO's in GTT  domain
Date: Tue, 9 Nov 2021 13:12:50 -0600
Message-ID: <20211109191250.20157-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4e7306d-16e8-4bda-ca66-08d9a3b4f43a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4533:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4533BC945EE3FE68F0057C8CE3929@MN2PR12MB4533.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k32z/Md4qqDa+A5VMQNQHT0YRpqn5sq1r3A6gfzTN6efahXX7+FY84u/75CHc8OqQbZwdYLEh+Aj2Yy3pDibxYfXukKS0ZHJf6+8M3lHkJuA0Cku0aUnuwdK4Mkkf+qYsfkaJ/rGnQxa79FDRrylCKmKFar9DjVdY40ilrpMNRX0tMWShE40Dtvx0f6tZ1fvjqwlJpehjWcw2f4VjGGSBhjU/+fTVKLyunBwPxkZl+mwBVZJKJl2mjFJ9Wh5rv1JW0FCnxNldA0MV8zUHiTEq+Y2ezS4cLQ62H9JLNcP4DMz4VDWimqrE1H5zM8NMXT6APpe8reehoE3Hi2Ukoyc2RCBmCajLEp4Ud8usMr67pam/MHod/Ma614CPor7rLMD8wb67CqNhQqBvamd9hht7dYVd/zaKNfXzH5HQ8JIMPt/07DkJzXbgE4o5iageQmA0FlS8PxsYvhxTe9zMaUG5rJEZZbJBXiqE7jg5vNW+mndC58sAsPeGYPoxLrLGUaYj8qkq6VgtAKSYe9ka5vc8B1rB+GZ2VqateGEacXvSmiJa0JwK2hscqNDTQJPepdpA5bSA8QeSFF4P3tao++enOXk7vLWKRXcnMXl6vX+NtbNeepSOfwRVQL0OAkJMGg9bmi7MQY+SFKcVTa2NQ0Q6zdvK/nWnn/gqyzqxIqwCYg53D4Nos6HEylIcVFF2VukJqeODCsTFiUANYwRzU+EMPKSzPVG75gOOl/jY0RlT4o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(82310400003)(6916009)(47076005)(336012)(83380400001)(36756003)(8936002)(4326008)(356005)(1076003)(2616005)(81166007)(316002)(70206006)(8676002)(426003)(186003)(2906002)(5660300002)(86362001)(6666004)(508600001)(36860700001)(16526019)(7696005)(70586007)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 19:13:03.5690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e7306d-16e8-4bda-ca66-08d9a3b4f43a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4533
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
Cc: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

MMIO/DOORBELL BOs encode control data and should be pinned in GTT
domain before enabling PCIe connected peer devices in accessing it

Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 08675f89bfb2..5e063fac0250 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1297,6 +1297,56 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
 	return ret;
 }
 
+/**
+ * amdgpu_amdkfd_gpuvm_pin_bo() - Pins a BO using following criteria
+ * @bo: Handle of buffer object being pinned
+ * @domain: Domain into which BO should be pinned
+ *
+ *   - USERPTR BOs are UNPINNABLE and will return error
+ *   - All other BO types (GTT, VRAM, MMIO and DOORBELL) will have their
+ *     PIN count incremented. It is valid to PIN a BO multiple times
+ *
+ * Return: ZERO if successful in pinning, Non-Zero in case of error.
+ * Will return -EINVAL if input BO parameter is a USERPTR type.
+ */
+static int amdgpu_amdkfd_gpuvm_pin_bo(struct amdgpu_bo *bo, u32 domain)
+{
+	int ret = 0;
+
+	ret = amdgpu_bo_reserve(bo, false);
+	if (unlikely(ret))
+		return ret;
+
+	ret = amdgpu_bo_pin_restricted(bo, domain, 0, 0);
+	if (ret)
+		pr_err("Error in Pinning BO to domain: %d\n", domain);
+
+	amdgpu_bo_sync_wait(bo, AMDGPU_FENCE_OWNER_KFD, false);
+	amdgpu_bo_unreserve(bo);
+
+	return ret;
+}
+
+/**
+ * amdgpu_amdkfd_gpuvm_unpin_bo() - Unpins BO using following criteria
+ * @bo: Handle of buffer object being unpinned
+ *
+ *   - Is a illegal request for USERPTR BOs and is ignored
+ *   - All other BO types (GTT, VRAM, MMIO and DOORBELL) will have their
+ *     PIN count decremented. Calls to UNPIN must balance calls to PIN
+ */
+void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdgpu_bo *bo)
+{
+	int ret = 0;
+
+	ret = amdgpu_bo_reserve(bo, false);
+	if (unlikely(ret))
+		return;
+
+	amdgpu_bo_unpin(bo);
+	amdgpu_bo_unreserve(bo);
+}
+
 int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
 					   struct file *filp, u32 pasid,
 					   void **process_info,
@@ -1523,10 +1573,22 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	if (offset)
 		*offset = amdgpu_bo_mmap_offset(bo);
 
+	if (flags & (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
+			KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
+		ret = amdgpu_amdkfd_gpuvm_pin_bo(bo, AMDGPU_GEM_DOMAIN_GTT);
+		if (ret) {
+			pr_err("Pinning MMIO/DOORBELL BO during ALLOC FAILED\n");
+			goto err_pin_bo;
+		}
+		bo->allowed_domains = AMDGPU_GEM_DOMAIN_GTT;
+		bo->preferred_domains = AMDGPU_GEM_DOMAIN_GTT;
+	}
+
 	return 0;
 
 allocate_init_user_pages_failed:
 	remove_kgd_mem_from_kfd_bo_list(*mem, avm->process_info);
+err_pin_bo:
 	drm_vma_node_revoke(&gobj->vma_node, drm_priv);
 err_node_allow:
 	drm_gem_object_put(gobj);
@@ -1559,6 +1621,14 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 	bool is_imported = false;
 
 	mutex_lock(&mem->lock);
+
+	/* Unpin MMIO/DOORBELL BO's that were pinnned during allocation */
+	if (mem->alloc_flags &
+	    (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
+	     KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
+		amdgpu_amdkfd_gpuvm_unpin_bo(mem->bo);
+	}
+
 	mapped_to_gpu_memory = mem->mapped_to_gpu_memory;
 	is_imported = mem->is_imported;
 	mutex_unlock(&mem->lock);
-- 
2.31.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7707DC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 17 May 2022 23:11:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 248A1112FB0;
	Tue, 17 May 2022 23:11:26 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FA56112FB0
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 23:11:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrraMuYDetBtKTMhbVIn5u6xaYVQA4EiltAt9xo5txjACJTdfflqHI0nk7ylYFDo4T7uvkh/smfY1Rwuu7r93jPbJVZP92BK9GkZNhH7gc266vhj9kBJndiR4WZA6whoSO1q1F+TpPBVUy9U5df2KBQ31mNTHbmMhKZYgMc7/u4Xsit+8hsp2PlZs+GVAwhW0R8We7/ke/Y32+sgxf32wXfreghAD9WKVbJcLjX31RwETqIn5PzcGczFuXmQhez6F6ZLrypCZAg7+iw0SE2u5RI7Wy+T+vXlwD2xiNhNg3WENRF5PaF8a8dBZcR0zRF9r5l4hj1ROMgATJvO0rxoEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DsK6smk133xAuyRSZ3vtK0bs9tSafbnVFV0nyL2BO3Q=;
 b=OtJ9KocXuLUXihNrDwcaykNo7ntR9XiQD8iAQIdfre+/U3dipnSEBl10ZX78Nekk4p/uPb8pHb2lSXkqmRZCYdYWlUAzsCPz1GFsMZPU8Js+H+1e293CFeXXYumTC2kpOH46HGjGBADHOR+Em/EAxS2GSkqkLCwh8eywiUWZKNgmAjzr7CxoOL841uGzV5NTyisRoFpgsKb6/ipHjjJR2h2k/EdkQw49be/xt1KHQkdYzFZYq9t7uSHbRjv97rzOojcm65JtL/6edmPdL+lpMPmSyvmqhwFVMxu+c2kOVE/LbUe7usynqBARhtSdqs9CdGwYNdnQ9C57O/8Ow7QvrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsK6smk133xAuyRSZ3vtK0bs9tSafbnVFV0nyL2BO3Q=;
 b=oC7608iY/GV0B4/hyKvRCAWnvOOoaDiWIikNovTosZMs7W6bBpJYYMxz08C/V3MrkM6w4kzMeyy7vjsneu4dgvMJ/GTx3/gbU+oSZZIwMgZ3S6SJDJ061abivOm5u4xFpPb22jD8M+Fg3eYECboFhXOOG9M9RIL6wYoUoD9cUf0=
Received: from DM6PR03CA0090.namprd03.prod.outlook.com (2603:10b6:5:333::23)
 by CY4PR12MB1830.namprd12.prod.outlook.com (2603:10b6:903:127::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 23:11:23 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::39) by DM6PR03CA0090.outlook.office365.com
 (2603:10b6:5:333::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18 via Frontend
 Transport; Tue, 17 May 2022 23:11:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Tue, 17 May 2022 23:11:22 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 17 May
 2022 18:11:20 -0500
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: remove acc_size from reserve/unreserve mem
Date: Tue, 17 May 2022 18:11:07 -0500
Message-ID: <20220517231108.14048-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bab6186d-5667-4ea7-0bff-08da385a8f50
X-MS-TrafficTypeDiagnostic: CY4PR12MB1830:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1830436796E70738E909E8F7FDCE9@CY4PR12MB1830.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DWq9wCBWEf+JyE3RDLzaAKUVDpNajvl29w7XhB655K/fpQNNUfMpvZ4JDlxygahYhXz5Bg4klolrme5r2c0rxs2Oq6lXNdkTs7QSxrm9sPxDdbA/7KmKR6Gd8+XdRdqN6dUdYbMFkaRpabGqh48K3tCtbYyJdZUZFKTLmgHSDkvJgJ64IXWNGrZhXLLcx2hXXHCtzo3CyB0m5cde63PlCD014RQO0oR40n45ZR+f95GHzeDHlQbvY2ZtBcXtYx37LZaQ+THC093cfWgpJ+0uSjxYUcUlKgzP0PQheEN63Mjl2Vgs0joEdx8ArNOFFEcmqnNDBe4iG73mlopvr7do/EgvfG88VXr02Fs/g0kfKJO/oV9jBGkf7rqUtceWPCRZIDOUBUH3IEzsTA1fBNxQBkP1Bl53ntkBy17XnJwVbZRh7Z/5uNXPmyFYfsYGzyvBM5FZbyGR/LPrVBX5SIdf9m22Www1IIYv9btEGFIcForeYJLYIcaRNuSffrYVIga7BhGSDL5gNzZ3cxJhFG+L1om2D4+Rz+AtWEh4TYvhPDpRU2Z+B0GFHD8jB8y/4fdjykh8CEtRuAB3kmXXs85c7CGF+oi7s5sNo8d7lgGtIyWlMz6Qqff+00Q8dA2UaobBoO0XSwUfWrMKtJAENERUQOEVu1PubZfq75f9HnVzYwxAXCUUc0g6pN6mkOMcNXd7EKBObAnoKA2IZaAVFadrsQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(6916009)(86362001)(316002)(47076005)(36860700001)(336012)(82310400005)(426003)(36756003)(5660300002)(4326008)(8936002)(44832011)(8676002)(81166007)(7696005)(2616005)(26005)(6666004)(83380400001)(508600001)(186003)(1076003)(16526019)(2906002)(40460700003)(356005)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 23:11:22.8008 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bab6186d-5667-4ea7-0bff-08da385a8f50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1830
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
Cc: Alex Sierra <alex.sierra@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

TTM used to track the "acc_size" of all BOs internally. We needed to
keep track of it in our memory reservation to avoid TTM running out
of memory in its own accounting. However, that "acc_size" accounting
has since been removed from TTM. Therefore we don't really need to
track it any more.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 57 ++++++-------------
 1 file changed, 16 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index fada3b149361..e985cf9c7ec0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -108,17 +108,8 @@ void amdgpu_amdkfd_reserve_system_mem(uint64_t size)
  * compromise that should work in most cases without reserving too
  * much memory for page tables unnecessarily (factor 16K, >> 14).
  */
-#define ESTIMATE_PT_SIZE(mem_size) ((mem_size) >> 14)
-
-static size_t amdgpu_amdkfd_acc_size(uint64_t size)
-{
-	size >>= PAGE_SHIFT;
-	size *= sizeof(dma_addr_t) + sizeof(void *);
 
-	return __roundup_pow_of_two(sizeof(struct amdgpu_bo)) +
-		__roundup_pow_of_two(sizeof(struct ttm_tt)) +
-		PAGE_ALIGN(size);
-}
+#define ESTIMATE_PT_SIZE(mem_size) ((mem_size) >> 14)
 
 /**
  * amdgpu_amdkfd_reserve_mem_limit() - Decrease available memory by size
@@ -136,28 +127,22 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 {
 	uint64_t reserved_for_pt =
 		ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);
-	size_t acc_size, system_mem_needed, ttm_mem_needed, vram_needed;
+	size_t system_mem_needed, ttm_mem_needed, vram_needed;
 	int ret = 0;
 
-	acc_size = amdgpu_amdkfd_acc_size(size);
-
+	system_mem_needed = 0;
+	ttm_mem_needed = 0;
 	vram_needed = 0;
 	if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_GTT) {
-		system_mem_needed = acc_size + size;
-		ttm_mem_needed = acc_size + size;
+		system_mem_needed = size;
+		ttm_mem_needed = size;
 	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
-		system_mem_needed = acc_size;
-		ttm_mem_needed = acc_size;
 		vram_needed = size;
 	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
-		system_mem_needed = acc_size + size;
-		ttm_mem_needed = acc_size;
-	} else if (alloc_flag &
-		   (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
-		    KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
-		system_mem_needed = acc_size;
-		ttm_mem_needed = acc_size;
-	} else {
+		system_mem_needed = size;
+	} else if (!(alloc_flag &
+				(KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
+				 KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))) {
 		pr_err("%s: Invalid BO type %#x\n", __func__, alloc_flag);
 		return -ENOMEM;
 	}
@@ -193,28 +178,18 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 static void unreserve_mem_limit(struct amdgpu_device *adev,
 		uint64_t size, u32 alloc_flag)
 {
-	size_t acc_size;
-
-	acc_size = amdgpu_amdkfd_acc_size(size);
-
 	spin_lock(&kfd_mem_limit.mem_limit_lock);
 
 	if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_GTT) {
-		kfd_mem_limit.system_mem_used -= (acc_size + size);
-		kfd_mem_limit.ttm_mem_used -= (acc_size + size);
+		kfd_mem_limit.system_mem_used -= size;
+		kfd_mem_limit.ttm_mem_used -= size;
 	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
-		kfd_mem_limit.system_mem_used -= acc_size;
-		kfd_mem_limit.ttm_mem_used -= acc_size;
 		adev->kfd.vram_used -= size;
 	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
-		kfd_mem_limit.system_mem_used -= (acc_size + size);
-		kfd_mem_limit.ttm_mem_used -= acc_size;
-	} else if (alloc_flag &
-		   (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
-		    KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
-		kfd_mem_limit.system_mem_used -= acc_size;
-		kfd_mem_limit.ttm_mem_used -= acc_size;
-	} else {
+		kfd_mem_limit.system_mem_used -= size;
+	} else if (!(alloc_flag &
+				(KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
+				 KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))) {
 		pr_err("%s: Invalid BO type %#x\n", __func__, alloc_flag);
 		goto release;
 	}
-- 
2.32.0


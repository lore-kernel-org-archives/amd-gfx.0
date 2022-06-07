Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B061EC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jun 2022 17:17:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A91710EEC9;
	Tue,  7 Jun 2022 17:17:23 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2062.outbound.protection.outlook.com [40.107.101.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2F2B10EEC3
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jun 2022 17:17:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCljErazR6PAqNIvGVJver2d01VDXG5XFwptU5sohwnlPIKkt4O6SQ2hhW45uy8BLIF9A6olJdds1syegoNSdMIR/WObgVhCe5yjKWE02zZaoAhnNYBAWYfhVKVQ/PxFHG4dLDe5wheEbPqD+I2CWtrk0P/8sR7Z08LGvNkHK8a3o+NA6mDpWIchdw5NCbMF+U60uuvooF1n5yTUEhNjRtjXnmKNGLTaXENAcHEPhWUEJzRWQgM5JuHOG1zEPDARNdJOJxXUjMpZ61ApAuPIVpUoSsu/3lJK/PlL214OCSmbPymYqImpen6l5L/zWug59FtzBBM0V1ZqDUkT23toqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UXxSwhOC7WuqdqD+TAKNpUAcPQ5FVApN8wm0yotUv+k=;
 b=lyPMVR/DQd7z7M8x5UmFdkUl/yi8wBRUZFnqpfwv626OTrFNm5UwgGyVUqI0WO2rcXLx9Io9+LtGzJqme4yqBuejTC4bqwq2aBD1f1S1MWeDcJhShx0SHi03fIpJRJDODFqTF5LjAKEcriC+fs9CfJCMrB2peXqYEoPIVbh1Dt4myoUaw2Xj8byl5gd/zBNKs9cxMXQJwfZ+sL6SoTWIXPxI6X22pSLdHh6URJcbGlD6Xeg/aHVeLbConSChr2gJy2HjfLiUWaPfKou7Y2Jzzhpn/omiV6pTh12zUb8tFjXR9NYTuO6/EkduSkuI8steISCdQrjPT1+2I7r4D53zNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXxSwhOC7WuqdqD+TAKNpUAcPQ5FVApN8wm0yotUv+k=;
 b=magBfWnNtYBzFEtWlg2XuE9r+g/8txk96Mr42M3LZEq1a+LKAoYigSiPYBVVEzDghpQh33rSZcW32KoUyiSRVSYigEl6xakuiPSAzAyHaPpoJTrQE1+mUQMD1Cu6U/VLXFHDzOSmOt4wlXZjTG1sMQc1NenLXo2HbjY18W6qmrk=
Received: from MWHPR08CA0046.namprd08.prod.outlook.com (2603:10b6:300:c0::20)
 by CY4PR1201MB0245.namprd12.prod.outlook.com (2603:10b6:910:1e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Tue, 7 Jun
 2022 17:17:19 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c0:cafe::8) by MWHPR08CA0046.outlook.office365.com
 (2603:10b6:300:c0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Tue, 7 Jun 2022 17:17:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Tue, 7 Jun 2022 17:17:19 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 7 Jun
 2022 12:17:17 -0500
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: remove acc_size from reserve/unreserve mem
Date: Tue, 7 Jun 2022 12:17:05 -0500
Message-ID: <20220607171706.28432-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f461c360-db3b-4e7b-f481-08da48a993cc
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0245:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB024594941C69B45751C9E6A9FDA59@CY4PR1201MB0245.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 29Epby/fKPCGJSD7ZEQGIUpSLejZlpg65oicb8dB9HPNolBYK64QGW1it2Ro0J5XMC8epmvQUwX4o9GR8mtqh3rRcOil1ktYRDuak7pfEJgHvBqNCphJxouYe0ohQfT+qpUS6PiEUs5xyPIeHXeqSoErWUNAbv19t1RqrhkEfEqeR3mM6Fn/VbCzmSmTRvJGyDvso/ze4EPFISsthK0B9CWs7dsxP0xT+4K2zoUPwV8mbjtntzddEBLtLQtAhHaZs5yDNYU6pva1HWA9yAVIOcOsJRRvwdZR+VCkkSQyZZxLxmPTOIb2dkgprtUyMcd6GTxnTet2HDz/xd+vrq/vwLyKaIBMUysESvu6zofz0Zop2ZzxR7S60jU8fi9ngAi6c/c/9Wciq/5nmbdpG+V+XJ+C69pZFkOQbRrrgKPOPy75XmcfzNFv6f8lQnvnHWe3Bnqoea8IxeOsMigelMqRctewgtuvBQ2VKY87LCNEqwqTmy5ZDI01+1B23UY8Rk7306pFJWBIvaBvVPx1rMm4cAJTUdMIOpGqGJ6z4Yb+F/gT5dc9ha8JJhTfgzL30xO7HhaGzb6DJKEN+GP0PysGQ50ktyo6oWic3cNO6Yc72ZDkdjky5BroUvO2W1XOacLxkDborfNrZLdMjAVA0wYmyjT9fJvjrLgewtW2KKjrwzGrqDeGe9XBnWNIVxkNJn162j8gKiUScpknQg58+xTfrw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(2616005)(86362001)(6666004)(6916009)(82310400005)(54906003)(83380400001)(36860700001)(2906002)(7696005)(5660300002)(4326008)(36756003)(8676002)(356005)(316002)(1076003)(336012)(426003)(47076005)(508600001)(16526019)(186003)(70206006)(8936002)(81166007)(70586007)(26005)(44832011)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 17:17:19.0827 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f461c360-db3b-4e7b-f481-08da48a993cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0245
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
Cc: Alex Sierra <alex.sierra@amd.com>, Philip Yang <philip.yang@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

TTM used to track the "acc_size" of all BOs internally. We needed to
keep track of it in our memory reservation to avoid TTM running out
of memory in its own accounting. However, that "acc_size" accounting
has since been removed from TTM. Therefore we don't really need to
track it any more.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Reviewed-by: Philip Yang <philip.yang@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 59 ++++++-------------
 1 file changed, 17 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 054e4a76ae2e..50730d2132a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -108,21 +108,12 @@ void amdgpu_amdkfd_reserve_system_mem(uint64_t size)
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
- * of buffer including any reserved for control structures
+ * of buffer.
  *
  * @adev: Device to which allocated BO belongs to
  * @size: Size of buffer, in bytes, encapsulated by B0. This should be
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


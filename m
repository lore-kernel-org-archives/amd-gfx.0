Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C781AC43334
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 01:56:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 407F18BDFC;
	Tue, 12 Jul 2022 01:56:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B9C58BDFC
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 01:56:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhdEWbuOd7LlTqDmqTiHMo3ngi7VOGqG3Zs3mMVCpWiG8SAgXILp1Qa60ZIfMGJhSM0OOwf3o9YmH1Pdqf9qsxjjossfbBMzwpsEeNnz8nfsgasdrtNsTIqTHuKA9hDiOl2rdQQ15KjDgu/dATD2Zx/GC3dlkKPM0ox9No4/4TLzqqLZ5hXvEaE1JVMqzUOfm9XbeIXgkbC8GW1f2eeMXYNa6Nc4RFqjs+HE0q3hmqrdqqbYVVFOXnIKQLPz4azaSKgpRNjujtPZiQ1pkVQjyUHgvz4YYwBW8k/tgtF14aIl9nkOZOgvF/uoBLLzm7bEu35UKxkYG0ccsX6R4YajRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDCe/0pgqQkTCVt4aqN+K3zcz5YWAuY4PnJSevB9p0g=;
 b=oKzkjfIrklfKwnHd/Uw2OKaLHzFmHFY79ZT7Sx3E59CxxKGqPA+MEVuTxRI5/Q+A+VLWv1YSx101zJYG+NUzzdg2eA++DD15A7OzJntx6HnbIx/VMbb09AhkA/r0YDCsCTi+bcGjaPbx0rCTr2OjFm4xEcTiYvGTBps9QXH6LGzK7UDs2gwpNMqUPClaLqfzFehz0uyYs8i8FEba7RCqIzEWvGMWPn/d9y8lexyXOcyXj0rahKs07FjDTQwR+IvFHTnh5rt7XQizIwSyOv1UuvHTa0lODRq3p4doNRwEyFDoEdq/B8zzsl5wjyKSGm0sq+P6o4Sx++P3Ym9IBCyx3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDCe/0pgqQkTCVt4aqN+K3zcz5YWAuY4PnJSevB9p0g=;
 b=jYoR3RrHew4JaBQ9CL0z0tdT91rQXHFkb21AcatSddgmr32vRfpSo8E6FQit5lDKonJaNtXhFF26KvJovW0XLaji53bVjiwsMnBg3JMpmCH9zn40FSfys7A25H/dkzGYrAw6HqRDRoQXUcZmtcJYiAkqp3Yz/HAQE4jsqN/BrHI=
Received: from BN8PR04CA0062.namprd04.prod.outlook.com (2603:10b6:408:d4::36)
 by SA0PR12MB4479.namprd12.prod.outlook.com (2603:10b6:806:95::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 01:56:18 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::3e) by BN8PR04CA0062.outlook.office365.com
 (2603:10b6:408:d4::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20 via Frontend
 Transport; Tue, 12 Jul 2022 01:56:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Tue, 12 Jul 2022 01:56:18 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 11 Jul
 2022 20:56:17 -0500
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: remove acc_size from reserve/unreserve mem
Date: Mon, 11 Jul 2022 20:56:02 -0500
Message-ID: <20220712015604.7697-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a6e8fed-100c-434a-0e4a-08da63a9b62a
X-MS-TrafficTypeDiagnostic: SA0PR12MB4479:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i40FwwT4vxexpK78xsYZuKXVf6nLtV4L4lQ1eK/2+LCHZ/DojADOjRiBkwdVDTNfOLqmRY9bB9yNWZizySzaDm9h7gS+axGN3xJpsY75Q+YcLG0tDYAsT+0TVSa4Lp9Hd9lmIzg6ZcWyRLMI0CmCEq81x0tXSWxBagoNF2l5Fe7j3wj6sa2q+PjsEfZDxlBf1E1nmF3oHvS093Hu1rFh68rs4d8jDrAMVHCFl6zxZJMi61WfXUrZKbU54xYjMwhQ+Oooyn6N6A/PtkVbWgSNiYPjAWKTVpIejMrjD0eGsqF7dwnSoryTnQX1vAm34fghBGAAXEGRwIcytEI7IUf9VGoy1H3Ih3IJEwxJhR4yBwYVh3ACRCxHMWoyOnFHsUFkhXaSLNV/rlYa1K8vTzv8lIMgjcAgdSRr/BYrDXnCvMOCNIovtMhi/NknsJRRNDYnY84btNlpQK8OMQEjllPa+FCc9D7uy3sXK/mSPoWWx/HP3XCQWeFP5rBGyjqfHKpL1ftOTl8ccvwehcyTCVpDDHydzrDCIb+E94kvCaa4aR9YTuROuBiAiHHjU04NLkuqKwuABr19VNvTbb3B7PiUsX1egz+4GKRT3Fr/WlgJ2nXwNsK9QtGJjTDwio+u6CAEJuLLVW4Y9UuUP6qzc55kQr3WjzUJ6/WHU8yX5iYioi7rpSaF07rqrh3QFs+Ilpkpob6X6mEr+HL7MGoyYCn9RhUWZzq4KV/6e1NY2LNT4jR7ZcnSzucff95kGXXAobC9rv+1tTd+yhyQfc/UKQFjrT0SfsCyd3K7qfBCxGTxxk1F/NvenqujE1d5YwrGgazhn/fjVJjmbJzh35sA6c6mzKEVBBVn3MWcWPH23J4DQEA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(39860400002)(376002)(136003)(40470700004)(46966006)(36840700001)(6916009)(4326008)(70586007)(36756003)(70206006)(82740400003)(336012)(36860700001)(426003)(81166007)(8676002)(356005)(47076005)(316002)(54906003)(44832011)(82310400005)(478600001)(2616005)(1076003)(16526019)(40480700001)(8936002)(86362001)(5660300002)(66574015)(41300700001)(186003)(26005)(2906002)(83380400001)(6666004)(40460700003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 01:56:18.2553 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a6e8fed-100c-434a-0e4a-08da63a9b62a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4479
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
 Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
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
Acked-by: Christian König <christian.koenig@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 60 ++++++-------------
 1 file changed, 17 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 4effee12a4ac..2bc36ff0aa0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -115,21 +115,12 @@ void amdgpu_amdkfd_reserve_system_mem(uint64_t size)
  * compromise that should work in most cases without reserving too
  * much memory for page tables unnecessarily (factor 16K, >> 14).
  */
-#define ESTIMATE_PT_SIZE(mem_size) max(((mem_size) >> 14), AMDGPU_VM_RESERVED_VRAM)
-
-static size_t amdgpu_amdkfd_acc_size(uint64_t size)
-{
-	size >>= PAGE_SHIFT;
-	size *= sizeof(dma_addr_t) + sizeof(void *);
 
-	return __roundup_pow_of_two(sizeof(struct amdgpu_bo)) +
-		__roundup_pow_of_two(sizeof(struct ttm_tt)) +
-		PAGE_ALIGN(size);
-}
+#define ESTIMATE_PT_SIZE(mem_size) max(((mem_size) >> 14), AMDGPU_VM_RESERVED_VRAM)
 
 /**
  * amdgpu_amdkfd_reserve_mem_limit() - Decrease available memory by size
- * of buffer including any reserved for control structures
+ * of buffer.
  *
  * @adev: Device to which allocated BO belongs to
  * @size: Size of buffer, in bytes, encapsulated by B0. This should be
@@ -143,19 +134,16 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
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
-
 		/*
 		 * Conservatively round up the allocation requirement to 2 MB
 		 * to avoid fragmentation caused by 4K allocations in the tail
@@ -163,14 +151,10 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 		 */
 		vram_needed = ALIGN(size, VRAM_ALLOCATION_ALIGN);
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
@@ -208,28 +192,18 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
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
 		adev->kfd.vram_used -= ALIGN(size, VRAM_ALLOCATION_ALIGN);
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


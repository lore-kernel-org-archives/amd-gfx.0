Return-Path: <SRS0=VH8F=JF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5668C433B4
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 10:22:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E90D61164
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 10:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E90D61164
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E136E6EA71;
	Thu,  8 Apr 2021 10:22:18 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDC5C6EA70
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Apr 2021 10:22:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aa4k/xiNTK5mz0gtWoQWk+IbsGThEq9r7ulZtSVieS3CPL+17Xb0+N1S5r7tI0dW3w7UXlEjPRsBexg1MN9LomOjAtaW706uJRljUn2ciMakbfFGcqj4SHujJOznS4h/G51dm5RX0hasHv2tCkwGfw99Qk66H4GXsOIu2rMmImK5EN1AfcSazzhpU7ADFMGk4nBqpJIMb6P6rFJpYHe6HAuZY6ReHqV4iYLYby+2pBbuEZYAVc7+5fjj4G8nOCDUWipgmf9vp19isIWojtlgPVfq2Vg/zqxNqZb6I3fvakdCuVg4w5ZhF4n8jXa29MUb9CJUD5BwzbJ8pXnYo1OwFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/L/eA3W80ALkKn4TWNncwzgYwn5jkx18bocORMn8fc=;
 b=BmqE3wXSFP6bBREd9OypVy1mKdyU6j7KIOQLiCof8bbWnaD2WvOwgHGz8RGd1P7G5ZEpYtKZIISyrq2Ga2TH3kna9IlVijkN3icErjAyYRqkvDR1ZIqmhAe9oUmensBDDX/vYzAdhwL2eZV4miDbnaBx8XgEuZ79i5IXYBwDfeJyFBN6BEkU0UPbGRdnAiqBEggUCPPsb2hKlT2v5EZqzkAw/c1FGmBgzgz9kX7KB9GxJ+4OsABZuz+MslXlv8rYe98VygPmgns8euEPEAcLQ8w1EOTpwe2CN/oNcdBkdzBq81oceKeqqtUqL4DREY11nzH/pnH1fV8v9BU/COY1Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/L/eA3W80ALkKn4TWNncwzgYwn5jkx18bocORMn8fc=;
 b=FBIX5SKtvc/CVMyo17dMReHM0Ze0y5uECUICI6HrsUcgWLAxV2ZOtb0zZndFoLR5jgNSQY9OQUefE4+3Z2M8C0PGxCHm3AhIiZSlb5QD3Eb/ffAdyAhuDbbG/E7yyoN6fTa+cgfCw3t5Cbc4vAau9fxo7uvcCizE0Y6HxCN3NXM=
Received: from BN6PR14CA0014.namprd14.prod.outlook.com (2603:10b6:404:79::24)
 by CH0PR12MB5059.namprd12.prod.outlook.com (2603:10b6:610:e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Thu, 8 Apr
 2021 10:22:16 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:79:cafe::be) by BN6PR14CA0014.outlook.office365.com
 (2603:10b6:404:79::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Thu, 8 Apr 2021 10:22:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Thu, 8 Apr 2021 10:22:15 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 8 Apr 2021
 05:22:15 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 8 Apr 2021
 05:22:15 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2 via Frontend
 Transport; Thu, 8 Apr 2021 05:22:14 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/8] drm/amdgpu: Change GC(KFD/GFX) register access from MMIO
 to RLCG
Date: Thu, 8 Apr 2021 18:21:59 +0800
Message-ID: <20210408102205.911-2-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210408102205.911-1-PengJu.Zhou@amd.com>
References: <20210408102205.911-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94f669e2-6d74-453c-6fd9-08d8fa782eb5
X-MS-TrafficTypeDiagnostic: CH0PR12MB5059:
X-Microsoft-Antispam-PRVS: <CH0PR12MB50596C9A8377F7EFA60033D0F8749@CH0PR12MB5059.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:202;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f9EOQVr0iLRPb0suwmpOh1OQY4uzTOEJuXtMd405EmrXlPsea7vs2mWrHvc6JS0e3NtHFWmI5fYK9lWHT+AUGmaXvw64Z+Ud6WF9rw79lRUqDTvPINb2LYi0QQF6kBxnAHf8PvoWyXvNrLnYK1JhO95bHIJhtYnDabmYU2dUYfRmHre/MHZyOJNFSsXDTrCGIbJZsWgGveOzElIDa2arfBASxrwq6dFD4eu4AL6bR/QPe8XvRtNkHmKyrh3j8IF3bLacIfRNKidtMPjgUv0TIBv1twpfMQkzfdz9/G5ED8J1BkwNh0eohnRfRL9YLxpag8rMVsBKZGUjG2yXHX4i3hlKlpr1q88uDL1JDN+kcly4mZttu6o5R4ON7FihXLJVPJoi1mPz0GmgtnixxLkTr8Tt2qStJ7rAUXd0p79BqN9P6yh6k5knGMroyskaluchcIZyWWx6+zKsw19jF8IUAgIptY8YQb8tY4TBnEcjDLr4I7JAP5kS89XN+UQkcijjK1WE/jj2K/NkbpPvBQZQy91ZXfRAvJt/yKpHIystq3ipF9VR/jc3aq5iz0h+v4CRmbOMxd9O/oHjARmAz/Ix+ipEKomJwyX4ZSS4YJef0CSzqI0apK9hofT/KnvRe7N/fUtNtl/oTeJe5Dr3kPI2Gh3CIcsPIPjEQZ5iGx8IwqOaFj78MRP+4S0d5/i76Fle
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(136003)(346002)(46966006)(36840700001)(426003)(86362001)(47076005)(70586007)(82310400003)(6916009)(4326008)(26005)(2616005)(70206006)(5660300002)(316002)(1076003)(30864003)(336012)(7696005)(82740400003)(8676002)(478600001)(356005)(186003)(8936002)(2906002)(6666004)(36860700001)(36756003)(83380400001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 10:22:15.9137 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f669e2-6d74-453c-6fd9-08d8fa782eb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5059
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In SRIOV environment, KMD should access GC registers
with RLCG if GC indirect access flag enabled.

Change GC register access from MMIO to RLCG.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    |  38 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 205 +++++++++---------
 drivers/gpu/drm/amd/amdgpu/nv.c               |   2 +-
 3 files changed, 124 insertions(+), 121 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 62aa1a6f64ed..9394dbf504de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -96,8 +96,8 @@ static void kgd_program_sh_mem_settings(struct kgd_dev *kgd, uint32_t vmid,
 
 	lock_srbm(kgd, 0, 0, 0, vmid);
 
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmSH_MEM_CONFIG), sh_mem_config);
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmSH_MEM_BASES), sh_mem_bases);
+	WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmSH_MEM_CONFIG), sh_mem_config);
+	WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmSH_MEM_BASES), sh_mem_bases);
 	/* APE1 no longer exists on GFX9 */
 
 	unlock_srbm(kgd);
@@ -161,7 +161,7 @@ static int kgd_init_interrupts(struct kgd_dev *kgd, uint32_t pipe_id)
 
 	lock_srbm(kgd, mec, pipe, 0, 0);
 
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmCPC_INT_CNTL),
+	WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCPC_INT_CNTL),
 		CP_INT_CNTL_RING0__TIME_STAMP_INT_ENABLE_MASK |
 		CP_INT_CNTL_RING0__OPCODE_ERROR_INT_ENABLE_MASK);
 
@@ -245,7 +245,7 @@ static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
 	/* Activate doorbell logic before triggering WPTR poll. */
 	data = REG_SET_FIELD(m->cp_hqd_pq_doorbell_control,
 			     CP_HQD_PQ_DOORBELL_CONTROL, DOORBELL_EN, 1);
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL), data);
+	WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL), data);
 
 	if (wptr) {
 		/* Don't read wptr with get_user because the user
@@ -274,17 +274,17 @@ static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
 		guessed_wptr += m->cp_hqd_pq_wptr_lo & ~(queue_size - 1);
 		guessed_wptr += (uint64_t)m->cp_hqd_pq_wptr_hi << 32;
 
-		WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_LO),
+		WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_LO),
 		       lower_32_bits(guessed_wptr));
-		WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_HI),
+		WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_HI),
 		       upper_32_bits(guessed_wptr));
-		WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR),
+		WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR),
 		       lower_32_bits((uint64_t)wptr));
-		WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR_HI),
+		WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR_HI),
 		       upper_32_bits((uint64_t)wptr));
 		pr_debug("%s setting CP_PQ_WPTR_POLL_CNTL1 to %x\n", __func__,
 			 (uint32_t)get_queue_mask(adev, pipe_id, queue_id));
-		WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_PQ_WPTR_POLL_CNTL1),
+		WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCP_PQ_WPTR_POLL_CNTL1),
 		       (uint32_t)get_queue_mask(adev, pipe_id, queue_id));
 	}
 
@@ -294,7 +294,7 @@ static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
 			     CP_HQD_EOP_RPTR, INIT_FETCHER, 1));
 
 	data = REG_SET_FIELD(m->cp_hqd_active, CP_HQD_ACTIVE, ACTIVE, 1);
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_ACTIVE), data);
+	WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_ACTIVE), data);
 
 	release_queue(kgd);
 
@@ -497,13 +497,13 @@ static bool kgd_hqd_is_occupied(struct kgd_dev *kgd, uint64_t queue_address,
 	uint32_t low, high;
 
 	acquire_queue(kgd, pipe_id, queue_id);
-	act = RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_ACTIVE));
+	act = RREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_ACTIVE));
 	if (act) {
 		low = lower_32_bits(queue_address >> 8);
 		high = upper_32_bits(queue_address >> 8);
 
-		if (low == RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_BASE)) &&
-		   high == RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_BASE_HI)))
+		if (low == RREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_BASE)) &&
+		   high == RREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_BASE_HI)))
 			retval = true;
 	}
 	release_queue(kgd);
@@ -551,7 +551,7 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd,
 	acquire_queue(kgd, pipe_id, queue_id);
 
 	if (m->cp_hqd_vmid == 0)
-		WREG32_FIELD15(GC, 0, RLC_CP_SCHEDULERS, scheduler1, 0);
+		WREG32_FIELD15_RLC(GC, 0, RLC_CP_SCHEDULERS, scheduler1, 0);
 
 	switch (reset_type) {
 	case KFD_PREEMPT_TYPE_WAVEFRONT_DRAIN:
@@ -605,7 +605,7 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd,
 	}
 	retry = 1000;
 	while (true) {
-		temp = RREG32(mmCP_HQD_DEQUEUE_REQUEST);
+		temp = RREG32_RLC(mmCP_HQD_DEQUEUE_REQUEST);
 		if (!(temp & CP_HQD_DEQUEUE_REQUEST__IQ_REQ_PEND_MASK))
 			break;
 		pr_debug("Dequeue request is pending\n");
@@ -621,11 +621,11 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd,
 	preempt_enable();
 #endif
 
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_DEQUEUE_REQUEST), type);
+	WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_DEQUEUE_REQUEST), type);
 
 	end_jiffies = (utimeout * HZ / 1000) + jiffies;
 	while (true) {
-		temp = RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_ACTIVE));
+		temp = RREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_ACTIVE));
 		if (!(temp & CP_HQD_ACTIVE__ACTIVE_MASK))
 			break;
 		if (time_after(jiffies, end_jiffies)) {
@@ -716,7 +716,7 @@ static int kgd_wave_control_execute(struct kgd_dev *kgd,
 
 	mutex_lock(&adev->grbm_idx_mutex);
 
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_INDEX), gfx_index_val);
+	WREG32_SOC15_RLC_SHADOW(GC, 0, mmGRBM_GFX_INDEX, gfx_index_val);
 	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_CMD), sq_cmd);
 
 	data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
@@ -726,7 +726,7 @@ static int kgd_wave_control_execute(struct kgd_dev *kgd,
 	data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
 		SE_BROADCAST_WRITES, 1);
 
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_INDEX), data);
+	WREG32_SOC15_RLC_SHADOW(GC, 0, mmGRBM_GFX_INDEX, data);
 	mutex_unlock(&adev->grbm_idx_mutex);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 85a6a10e048f..376c92b1f938 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4490,7 +4490,7 @@ static void gfx_v10_0_gpu_early_init(struct amdgpu_device *adev)
 		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
 		adev->gfx.config.sc_hiz_tile_fifo_size = 0;
 		adev->gfx.config.sc_earlyz_tile_fifo_size = 0x4C0;
-		gb_addr_config = RREG32_SOC15(GC, 0, mmGB_ADDR_CONFIG);
+		gb_addr_config = RREG32_SOC15_RLC(GC, 0, mmGB_ADDR_CONFIG);
 		break;
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
@@ -4820,15 +4820,15 @@ static void gfx_v10_0_select_se_sh(struct amdgpu_device *adev, u32 se_num,
 	else
 		data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SA_INDEX, sh_num);
 
-	WREG32_SOC15(GC, 0, mmGRBM_GFX_INDEX, data);
+	WREG32_SOC15_RLC_SHADOW(GC, 0, mmGRBM_GFX_INDEX, data);
 }
 
 static u32 gfx_v10_0_get_rb_active_bitmap(struct amdgpu_device *adev)
 {
 	u32 data, mask;
 
-	data = RREG32_SOC15(GC, 0, mmCC_RB_BACKEND_DISABLE);
-	data |= RREG32_SOC15(GC, 0, mmGC_USER_RB_BACKEND_DISABLE);
+	data = RREG32_SOC15_RLC(GC, 0, mmCC_RB_BACKEND_DISABLE);
+	data |= RREG32_SOC15_RLC(GC, 0, mmGC_USER_RB_BACKEND_DISABLE);
 
 	data &= CC_RB_BACKEND_DISABLE__BACKEND_DISABLE_MASK;
 	data >>= GC_USER_RB_BACKEND_DISABLE__BACKEND_DISABLE__SHIFT;
@@ -4925,8 +4925,9 @@ static void gfx_v10_0_init_compute_vmid(struct amdgpu_device *adev)
 	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
 		nv_grbm_select(adev, 0, 0, 0, i);
 		/* CP and shaders */
-		WREG32_SOC15(GC, 0, mmSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
-		WREG32_SOC15(GC, 0, mmSH_MEM_BASES, sh_mem_bases);
+		WREG32_SOC15_RLC(GC, 0, mmSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
+		WREG32_SOC15_RLC(GC, 0, mmSH_MEM_BASES, sh_mem_bases);
+
 	}
 	nv_grbm_select(adev, 0, 0, 0, 0);
 	mutex_unlock(&adev->srbm_mutex);
@@ -4936,8 +4937,8 @@ static void gfx_v10_0_init_compute_vmid(struct amdgpu_device *adev)
 	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_BASE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_SIZE, 2 * i, 0);
-		WREG32_SOC15_OFFSET(GC, 0, mmGDS_GWS_VMID0, i, 0);
-		WREG32_SOC15_OFFSET(GC, 0, mmGDS_OA_VMID0, i, 0);
+		WREG32_SOC15_OFFSET_RLC(GC, 0, mmGDS_GWS_VMID0, i, 0);
+		WREG32_SOC15_OFFSET_RLC(GC, 0, mmGDS_OA_VMID0, i, 0);
 	}
 }
 
@@ -4954,8 +4955,8 @@ static void gfx_v10_0_init_gds_vmid(struct amdgpu_device *adev)
 	for (vmid = 1; vmid < AMDGPU_NUM_VMID; vmid++) {
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_BASE, 2 * vmid, 0);
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_SIZE, 2 * vmid, 0);
-		WREG32_SOC15_OFFSET(GC, 0, mmGDS_GWS_VMID0, vmid, 0);
-		WREG32_SOC15_OFFSET(GC, 0, mmGDS_OA_VMID0, vmid, 0);
+		WREG32_SOC15_OFFSET_RLC(GC, 0, mmGDS_GWS_VMID0, vmid, 0);
+		WREG32_SOC15_OFFSET_RLC(GC, 0, mmGDS_OA_VMID0, vmid, 0);
 	}
 }
 
@@ -5036,8 +5037,8 @@ static void gfx_v10_0_get_tcc_info(struct amdgpu_device *adev)
 	uint32_t tcc_disable;
 
 	if (adev->asic_type >= CHIP_SIENNA_CICHLID) {
-		tcc_disable = RREG32_SOC15(GC, 0, mmCGTS_TCC_DISABLE_gc_10_3) |
-			      RREG32_SOC15(GC, 0, mmCGTS_USER_TCC_DISABLE_gc_10_3);
+		tcc_disable = RREG32_SOC15_RLC(GC, 0, mmCGTS_TCC_DISABLE_gc_10_3) |
+			      RREG32_SOC15_RLC(GC, 0, mmCGTS_USER_TCC_DISABLE_gc_10_3);
 	} else {
 		tcc_disable = RREG32_SOC15(GC, 0, mmCGTS_TCC_DISABLE) |
 			      RREG32_SOC15(GC, 0, mmCGTS_USER_TCC_DISABLE);
@@ -5067,13 +5068,13 @@ static void gfx_v10_0_constants_init(struct amdgpu_device *adev)
 	for (i = 0; i < adev->vm_manager.id_mgr[AMDGPU_GFXHUB_0].num_ids; i++) {
 		nv_grbm_select(adev, 0, 0, 0, i);
 		/* CP and shaders */
-		WREG32_SOC15(GC, 0, mmSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
+		WREG32_SOC15_RLC(GC, 0, mmSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
 		if (i != 0) {
 			tmp = REG_SET_FIELD(0, SH_MEM_BASES, PRIVATE_BASE,
 				(adev->gmc.private_aperture_start >> 48));
 			tmp = REG_SET_FIELD(tmp, SH_MEM_BASES, SHARED_BASE,
 				(adev->gmc.shared_aperture_start >> 48));
-			WREG32_SOC15(GC, 0, mmSH_MEM_BASES, tmp);
+			WREG32_SOC15_RLC(GC, 0, mmSH_MEM_BASES, tmp);
 		}
 	}
 	nv_grbm_select(adev, 0, 0, 0, 0);
@@ -5688,8 +5689,8 @@ static int gfx_v10_0_wait_for_rlc_autoload_complete(struct amdgpu_device *adev)
 	int i, r;
 
 	for (i = 0; i < adev->usec_timeout; i++) {
-		cp_status = RREG32_SOC15(GC, 0, mmCP_STAT);
-		bootload_status = RREG32_SOC15(GC, 0, mmRLC_RLCS_BOOTLOAD_STATUS);
+		cp_status = RREG32_SOC15_RLC(GC, 0, mmCP_STAT);
+		bootload_status = RREG32_SOC15_RLC(GC, 0, mmRLC_RLCS_BOOTLOAD_STATUS);
 		if ((cp_status == 0) &&
 		    (REG_GET_FIELD(bootload_status,
 			RLC_RLCS_BOOTLOAD_STATUS, BOOTLOAD_COMPLETE) == 1)) {
@@ -5727,7 +5728,7 @@ static int gfx_v10_0_wait_for_rlc_autoload_complete(struct amdgpu_device *adev)
 static int gfx_v10_0_cp_gfx_enable(struct amdgpu_device *adev, bool enable)
 {
 	int i;
-	u32 tmp = RREG32_SOC15(GC, 0, mmCP_ME_CNTL);
+	u32 tmp = RREG32_SOC15_RLC(GC, 0, mmCP_ME_CNTL);
 
 	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, ME_HALT, enable ? 0 : 1);
 	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, PFP_HALT, enable ? 0 : 1);
@@ -5740,7 +5741,7 @@ static int gfx_v10_0_cp_gfx_enable(struct amdgpu_device *adev, bool enable)
 	}
 
 	for (i = 0; i < adev->usec_timeout; i++) {
-		if (RREG32_SOC15(GC, 0, mmCP_STAT) == 0)
+		if (RREG32_SOC15_RLC(GC, 0, mmCP_STAT) == 0)
 			break;
 		udelay(1);
 	}
@@ -6022,9 +6023,9 @@ static int gfx_v10_0_cp_gfx_start(struct amdgpu_device *adev)
 	int ctx_reg_offset;
 
 	/* init the CP */
-	WREG32_SOC15(GC, 0, mmCP_MAX_CONTEXT,
+	WREG32_SOC15_RLC(GC, 0, mmCP_MAX_CONTEXT,
 		     adev->gfx.config.max_hw_contexts - 1);
-	WREG32_SOC15(GC, 0, mmCP_DEVICE_ID, 1);
+	WREG32_SOC15_RLC(GC, 0, mmCP_DEVICE_ID, 1);
 
 	gfx_v10_0_cp_gfx_enable(adev, true);
 
@@ -6098,10 +6099,10 @@ static void gfx_v10_0_cp_gfx_switch_pipe(struct amdgpu_device *adev,
 {
 	u32 tmp;
 
-	tmp = RREG32_SOC15(GC, 0, mmGRBM_GFX_CNTL);
+	tmp = RREG32_SOC15_RLC(GC, 0, mmGRBM_GFX_CNTL);
 	tmp = REG_SET_FIELD(tmp, GRBM_GFX_CNTL, PIPEID, pipe);
 
-	WREG32_SOC15(GC, 0, mmGRBM_GFX_CNTL, tmp);
+	WREG32_SOC15_RLC_SHADOW(GC, 0, mmGRBM_GFX_CNTL, tmp);
 }
 
 static void gfx_v10_0_cp_gfx_set_doorbell(struct amdgpu_device *adev,
@@ -6110,7 +6111,7 @@ static void gfx_v10_0_cp_gfx_set_doorbell(struct amdgpu_device *adev,
 	u32 tmp;
 
 	if (!amdgpu_async_gfx_ring) {
-		tmp = RREG32_SOC15(GC, 0, mmCP_RB_DOORBELL_CONTROL);
+		tmp = RREG32_SOC15_RLC(GC, 0, mmCP_RB_DOORBELL_CONTROL);
 		if (ring->use_doorbell) {
 			tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
 						DOORBELL_OFFSET, ring->doorbell_index);
@@ -6120,7 +6121,7 @@ static void gfx_v10_0_cp_gfx_set_doorbell(struct amdgpu_device *adev,
 			tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
 						DOORBELL_EN, 0);
 		}
-		WREG32_SOC15(GC, 0, mmCP_RB_DOORBELL_CONTROL, tmp);
+		WREG32_SOC15_RLC(GC, 0, mmCP_RB_DOORBELL_CONTROL, tmp);
 	}
 	switch (adev->asic_type) {
 	case CHIP_SIENNA_CICHLID:
@@ -6137,10 +6138,9 @@ static void gfx_v10_0_cp_gfx_set_doorbell(struct amdgpu_device *adev,
 	default:
 		tmp = REG_SET_FIELD(0, CP_RB_DOORBELL_RANGE_LOWER,
 				    DOORBELL_RANGE_LOWER, ring->doorbell_index);
-		WREG32_SOC15(GC, 0, mmCP_RB_DOORBELL_RANGE_LOWER, tmp);
-
-		WREG32_SOC15(GC, 0, mmCP_RB_DOORBELL_RANGE_UPPER,
-			     CP_RB_DOORBELL_RANGE_UPPER__DOORBELL_RANGE_UPPER_MASK);
+		WREG32_SOC15_RLC(GC, 0, mmCP_RB_DOORBELL_RANGE_LOWER, tmp);
+		WREG32_SOC15_RLC(GC, 0, mmCP_RB_DOORBELL_RANGE_UPPER,
+				 CP_RB_DOORBELL_RANGE_UPPER__DOORBELL_RANGE_UPPER_MASK);
 		break;
 	}
 }
@@ -6265,7 +6265,7 @@ static void gfx_v10_0_cp_compute_enable(struct amdgpu_device *adev, bool enable)
 			WREG32_SOC15(GC, 0, mmCP_MEC_CNTL_Sienna_Cichlid, 0);
 			break;
 		default:
-			WREG32_SOC15(GC, 0, mmCP_MEC_CNTL, 0);
+			WREG32_SOC15_RLC(GC, 0, mmCP_MEC_CNTL, 0);
 			break;
 		}
 	} else {
@@ -6279,7 +6279,7 @@ static void gfx_v10_0_cp_compute_enable(struct amdgpu_device *adev, bool enable)
 				      CP_MEC_CNTL__MEC_ME2_HALT_MASK));
 			break;
 		default:
-			WREG32_SOC15(GC, 0, mmCP_MEC_CNTL,
+			WREG32_SOC15_RLC(GC, 0, mmCP_MEC_CNTL,
 				     (CP_MEC_CNTL__MEC_ME1_HALT_MASK |
 				      CP_MEC_CNTL__MEC_ME2_HALT_MASK));
 			break;
@@ -6378,12 +6378,12 @@ static void gfx_v10_0_kiq_setting(struct amdgpu_ring *ring)
 		WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS_Sienna_Cichlid, tmp);
 		break;
 	default:
-		tmp = RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS);
+		tmp = RREG32_SOC15_RLC(GC, 0, mmRLC_CP_SCHEDULERS);
 		tmp &= 0xffffff00;
 		tmp |= (ring->me << 5) | (ring->pipe << 3) | (ring->queue);
-		WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
+		WREG32_SOC15_RLC(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
 		tmp |= 0x80;
-		WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
+		WREG32_SOC15_RLC(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
 		break;
 	}
 }
@@ -6405,25 +6405,25 @@ static int gfx_v10_0_gfx_mqd_init(struct amdgpu_ring *ring)
 	mqd->cp_mqd_base_addr_hi = upper_32_bits(ring->mqd_gpu_addr);
 
 	/* set up mqd control */
-	tmp = RREG32_SOC15(GC, 0, mmCP_GFX_MQD_CONTROL);
+	tmp = RREG32_SOC15_RLC(GC, 0, mmCP_GFX_MQD_CONTROL);
 	tmp = REG_SET_FIELD(tmp, CP_GFX_MQD_CONTROL, VMID, 0);
 	tmp = REG_SET_FIELD(tmp, CP_GFX_MQD_CONTROL, PRIV_STATE, 1);
 	tmp = REG_SET_FIELD(tmp, CP_GFX_MQD_CONTROL, CACHE_POLICY, 0);
 	mqd->cp_gfx_mqd_control = tmp;
 
 	/* set up gfx_hqd_vimd with 0x0 to indicate the ring buffer's vmid */
-	tmp = RREG32_SOC15(GC, 0, mmCP_GFX_HQD_VMID);
+	tmp = RREG32_SOC15_RLC(GC, 0, mmCP_GFX_HQD_VMID);
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_VMID, VMID, 0);
 	mqd->cp_gfx_hqd_vmid = 0;
 
 	/* set up default queue priority level
 	 * 0x0 = low priority, 0x1 = high priority */
-	tmp = RREG32_SOC15(GC, 0, mmCP_GFX_HQD_QUEUE_PRIORITY);
+	tmp = RREG32_SOC15_RLC(GC, 0, mmCP_GFX_HQD_QUEUE_PRIORITY);
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_QUEUE_PRIORITY, PRIORITY_LEVEL, 0);
 	mqd->cp_gfx_hqd_queue_priority = tmp;
 
 	/* set up time quantum */
-	tmp = RREG32_SOC15(GC, 0, mmCP_GFX_HQD_QUANTUM);
+	tmp = RREG32_SOC15_RLC(GC, 0, mmCP_GFX_HQD_QUANTUM);
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_QUANTUM, QUANTUM_EN, 1);
 	mqd->cp_gfx_hqd_quantum = tmp;
 
@@ -6445,7 +6445,7 @@ static int gfx_v10_0_gfx_mqd_init(struct amdgpu_ring *ring)
 
 	/* set up the gfx_hqd_control, similar as CP_RB0_CNTL */
 	rb_bufsz = order_base_2(ring->ring_size / 4) - 1;
-	tmp = RREG32_SOC15(GC, 0, mmCP_GFX_HQD_CNTL);
+	tmp = RREG32_SOC15_RLC(GC, 0, mmCP_GFX_HQD_CNTL);
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_BUFSZ, rb_bufsz);
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_BLKSZ, rb_bufsz - 2);
 #ifdef __BIG_ENDIAN
@@ -6454,7 +6454,7 @@ static int gfx_v10_0_gfx_mqd_init(struct amdgpu_ring *ring)
 	mqd->cp_gfx_hqd_cntl = tmp;
 
 	/* set up cp_doorbell_control */
-	tmp = RREG32_SOC15(GC, 0, mmCP_RB_DOORBELL_CONTROL);
+	tmp = RREG32_SOC15_RLC(GC, 0, mmCP_RB_DOORBELL_CONTROL);
 	if (ring->use_doorbell) {
 		tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
 				    DOORBELL_OFFSET, ring->doorbell_index);
@@ -6472,7 +6472,7 @@ static int gfx_v10_0_gfx_mqd_init(struct amdgpu_ring *ring)
 
 	/* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
 	ring->wptr = 0;
-	mqd->cp_gfx_hqd_rptr = RREG32_SOC15(GC, 0, mmCP_GFX_HQD_RPTR);
+	mqd->cp_gfx_hqd_rptr = RREG32_SOC15_RLC(GC, 0, mmCP_GFX_HQD_RPTR);
 
 	/* active the queue */
 	mqd->cp_gfx_hqd_active = 1;
@@ -6491,36 +6491,36 @@ static int gfx_v10_0_gfx_queue_init_register(struct amdgpu_ring *ring)
 	WREG32_SOC15(GC, 0, mmCP_GFX_HQD_WPTR_HI, mqd->cp_gfx_hqd_wptr_hi);
 
 	/* set GFX_MQD_BASE */
-	WREG32_SOC15(GC, 0, mmCP_MQD_BASE_ADDR, mqd->cp_mqd_base_addr);
-	WREG32_SOC15(GC, 0, mmCP_MQD_BASE_ADDR_HI, mqd->cp_mqd_base_addr_hi);
+	WREG32_SOC15_RLC(GC, 0, mmCP_MQD_BASE_ADDR, mqd->cp_mqd_base_addr);
+	WREG32_SOC15_RLC(GC, 0, mmCP_MQD_BASE_ADDR_HI, mqd->cp_mqd_base_addr_hi);
 
 	/* set GFX_MQD_CONTROL */
-	WREG32_SOC15(GC, 0, mmCP_GFX_MQD_CONTROL, mqd->cp_gfx_mqd_control);
+	WREG32_SOC15_RLC(GC, 0, mmCP_GFX_MQD_CONTROL, mqd->cp_gfx_mqd_control);
 
 	/* set GFX_HQD_VMID to 0 */
-	WREG32_SOC15(GC, 0, mmCP_GFX_HQD_VMID, mqd->cp_gfx_hqd_vmid);
+	WREG32_SOC15_RLC(GC, 0, mmCP_GFX_HQD_VMID, mqd->cp_gfx_hqd_vmid);
 
-	WREG32_SOC15(GC, 0, mmCP_GFX_HQD_QUEUE_PRIORITY,
+	WREG32_SOC15_RLC(GC, 0, mmCP_GFX_HQD_QUEUE_PRIORITY,
 			mqd->cp_gfx_hqd_queue_priority);
-	WREG32_SOC15(GC, 0, mmCP_GFX_HQD_QUANTUM, mqd->cp_gfx_hqd_quantum);
+	WREG32_SOC15_RLC(GC, 0, mmCP_GFX_HQD_QUANTUM, mqd->cp_gfx_hqd_quantum);
 
 	/* set GFX_HQD_BASE, similar as CP_RB_BASE */
 	WREG32_SOC15(GC, 0, mmCP_GFX_HQD_BASE, mqd->cp_gfx_hqd_base);
 	WREG32_SOC15(GC, 0, mmCP_GFX_HQD_BASE_HI, mqd->cp_gfx_hqd_base_hi);
 
 	/* set GFX_HQD_RPTR_ADDR, similar as CP_RB_RPTR */
-	WREG32_SOC15(GC, 0, mmCP_GFX_HQD_RPTR_ADDR, mqd->cp_gfx_hqd_rptr_addr);
-	WREG32_SOC15(GC, 0, mmCP_GFX_HQD_RPTR_ADDR_HI, mqd->cp_gfx_hqd_rptr_addr_hi);
+	WREG32_SOC15_RLC(GC, 0, mmCP_GFX_HQD_RPTR_ADDR, mqd->cp_gfx_hqd_rptr_addr);
+	WREG32_SOC15_RLC(GC, 0, mmCP_GFX_HQD_RPTR_ADDR_HI, mqd->cp_gfx_hqd_rptr_addr_hi);
 
 	/* set GFX_HQD_CNTL, similar as CP_RB_CNTL */
-	WREG32_SOC15(GC, 0, mmCP_GFX_HQD_CNTL, mqd->cp_gfx_hqd_cntl);
+	WREG32_SOC15_RLC(GC, 0, mmCP_GFX_HQD_CNTL, mqd->cp_gfx_hqd_cntl);
 
 	/* set RB_WPTR_POLL_ADDR */
 	WREG32_SOC15(GC, 0, mmCP_RB_WPTR_POLL_ADDR_LO, mqd->cp_rb_wptr_poll_addr_lo);
 	WREG32_SOC15(GC, 0, mmCP_RB_WPTR_POLL_ADDR_HI, mqd->cp_rb_wptr_poll_addr_hi);
 
 	/* set RB_DOORBELL_CONTROL */
-	WREG32_SOC15(GC, 0, mmCP_RB_DOORBELL_CONTROL, mqd->cp_rb_doorbell_control);
+	WREG32_SOC15_RLC(GC, 0, mmCP_RB_DOORBELL_CONTROL, mqd->cp_rb_doorbell_control);
 
 	/* active the queue */
 	WREG32_SOC15(GC, 0, mmCP_GFX_HQD_ACTIVE, mqd->cp_gfx_hqd_active);
@@ -6665,14 +6665,14 @@ static int gfx_v10_0_compute_mqd_init(struct amdgpu_ring *ring)
 	mqd->cp_hqd_eop_base_addr_hi = upper_32_bits(eop_base_addr);
 
 	/* set the EOP size, register value is 2^(EOP_SIZE+1) dwords */
-	tmp = RREG32_SOC15(GC, 0, mmCP_HQD_EOP_CONTROL);
+	tmp = RREG32_SOC15_RLC(GC, 0, mmCP_HQD_EOP_CONTROL);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_EOP_CONTROL, EOP_SIZE,
 			(order_base_2(GFX10_MEC_HPD_SIZE / 4) - 1));
 
 	mqd->cp_hqd_eop_control = tmp;
 
 	/* enable doorbell? */
-	tmp = RREG32_SOC15(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL);
+	tmp = RREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL);
 
 	if (ring->use_doorbell) {
 		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
@@ -6702,7 +6702,7 @@ static int gfx_v10_0_compute_mqd_init(struct amdgpu_ring *ring)
 	mqd->cp_mqd_base_addr_hi = upper_32_bits(ring->mqd_gpu_addr);
 
 	/* set MQD vmid to 0 */
-	tmp = RREG32_SOC15(GC, 0, mmCP_MQD_CONTROL);
+	tmp = RREG32_SOC15_RLC(GC, 0, mmCP_MQD_CONTROL);
 	tmp = REG_SET_FIELD(tmp, CP_MQD_CONTROL, VMID, 0);
 	mqd->cp_mqd_control = tmp;
 
@@ -6712,7 +6712,7 @@ static int gfx_v10_0_compute_mqd_init(struct amdgpu_ring *ring)
 	mqd->cp_hqd_pq_base_hi = upper_32_bits(hqd_gpu_addr);
 
 	/* set up the HQD, this is similar to CP_RB0_CNTL */
-	tmp = RREG32_SOC15(GC, 0, mmCP_HQD_PQ_CONTROL);
+	tmp = RREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_CONTROL);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, QUEUE_SIZE,
 			    (order_base_2(ring->ring_size / 4) - 1));
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
@@ -6740,7 +6740,7 @@ static int gfx_v10_0_compute_mqd_init(struct amdgpu_ring *ring)
 	tmp = 0;
 	/* enable the doorbell if requested */
 	if (ring->use_doorbell) {
-		tmp = RREG32_SOC15(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL);
+		tmp = RREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL);
 		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
 				DOORBELL_OFFSET, ring->doorbell_index);
 
@@ -6756,17 +6756,17 @@ static int gfx_v10_0_compute_mqd_init(struct amdgpu_ring *ring)
 
 	/* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
 	ring->wptr = 0;
-	mqd->cp_hqd_pq_rptr = RREG32_SOC15(GC, 0, mmCP_HQD_PQ_RPTR);
+	mqd->cp_hqd_pq_rptr = RREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_RPTR);
 
 	/* set the vmid for the queue */
 	mqd->cp_hqd_vmid = 0;
 
-	tmp = RREG32_SOC15(GC, 0, mmCP_HQD_PERSISTENT_STATE);
+	tmp = RREG32_SOC15_RLC(GC, 0, mmCP_HQD_PERSISTENT_STATE);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PERSISTENT_STATE, PRELOAD_SIZE, 0x53);
 	mqd->cp_hqd_persistent_state = tmp;
 
 	/* set MIN_IB_AVAIL_SIZE */
-	tmp = RREG32_SOC15(GC, 0, mmCP_HQD_IB_CONTROL);
+	tmp = RREG32_SOC15_RLC(GC, 0, mmCP_HQD_IB_CONTROL);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_IB_CONTROL, MIN_IB_AVAIL_SIZE, 3);
 	mqd->cp_hqd_ib_control = tmp;
 
@@ -6796,94 +6796,94 @@ static int gfx_v10_0_kiq_init_register(struct amdgpu_ring *ring)
 	WREG32_FIELD15(GC, 0, CP_PQ_WPTR_POLL_CNTL, EN, 0);
 
 	/* write the EOP addr */
-	WREG32_SOC15(GC, 0, mmCP_HQD_EOP_BASE_ADDR,
+	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_EOP_BASE_ADDR,
 	       mqd->cp_hqd_eop_base_addr_lo);
-	WREG32_SOC15(GC, 0, mmCP_HQD_EOP_BASE_ADDR_HI,
+	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_EOP_BASE_ADDR_HI,
 	       mqd->cp_hqd_eop_base_addr_hi);
 
 	/* set the EOP size, register value is 2^(EOP_SIZE+1) dwords */
-	WREG32_SOC15(GC, 0, mmCP_HQD_EOP_CONTROL,
+	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_EOP_CONTROL,
 	       mqd->cp_hqd_eop_control);
 
 	/* enable doorbell? */
-	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL,
+	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL,
 	       mqd->cp_hqd_pq_doorbell_control);
 
 	/* disable the queue if it's active */
 	if (RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE) & 1) {
 		WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_REQUEST, 1);
 		for (j = 0; j < adev->usec_timeout; j++) {
-			if (!(RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE) & 1))
+			if (!(RREG32_SOC15_RLC(GC, 0, mmCP_HQD_ACTIVE) & 1))
 				break;
 			udelay(1);
 		}
-		WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_REQUEST,
+		WREG32_SOC15_RLC(GC, 0, mmCP_HQD_DEQUEUE_REQUEST,
 		       mqd->cp_hqd_dequeue_request);
-		WREG32_SOC15(GC, 0, mmCP_HQD_PQ_RPTR,
+		WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_RPTR,
 		       mqd->cp_hqd_pq_rptr);
-		WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_LO,
+		WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_WPTR_LO,
 		       mqd->cp_hqd_pq_wptr_lo);
-		WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_HI,
+		WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_WPTR_HI,
 		       mqd->cp_hqd_pq_wptr_hi);
 	}
 
 	/* set the pointer to the MQD */
-	WREG32_SOC15(GC, 0, mmCP_MQD_BASE_ADDR,
+	WREG32_SOC15_RLC(GC, 0, mmCP_MQD_BASE_ADDR,
 	       mqd->cp_mqd_base_addr_lo);
-	WREG32_SOC15(GC, 0, mmCP_MQD_BASE_ADDR_HI,
+	WREG32_SOC15_RLC(GC, 0, mmCP_MQD_BASE_ADDR_HI,
 	       mqd->cp_mqd_base_addr_hi);
 
 	/* set MQD vmid to 0 */
-	WREG32_SOC15(GC, 0, mmCP_MQD_CONTROL,
+	WREG32_SOC15_RLC(GC, 0, mmCP_MQD_CONTROL,
 	       mqd->cp_mqd_control);
 
 	/* set the pointer to the HQD, this is similar CP_RB0_BASE/_HI */
-	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_BASE,
+	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_BASE,
 	       mqd->cp_hqd_pq_base_lo);
-	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_BASE_HI,
+	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_BASE_HI,
 	       mqd->cp_hqd_pq_base_hi);
 
 	/* set up the HQD, this is similar to CP_RB0_CNTL */
-	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_CONTROL,
+	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_CONTROL,
 	       mqd->cp_hqd_pq_control);
 
 	/* set the wb address whether it's enabled or not */
-	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_RPTR_REPORT_ADDR,
+	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_RPTR_REPORT_ADDR,
 		mqd->cp_hqd_pq_rptr_report_addr_lo);
-	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_RPTR_REPORT_ADDR_HI,
+	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_RPTR_REPORT_ADDR_HI,
 		mqd->cp_hqd_pq_rptr_report_addr_hi);
 
 	/* only used if CP_PQ_WPTR_POLL_CNTL.CP_PQ_WPTR_POLL_CNTL__EN_MASK=1 */
-	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR,
+	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR,
 	       mqd->cp_hqd_pq_wptr_poll_addr_lo);
-	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR_HI,
+	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR_HI,
 	       mqd->cp_hqd_pq_wptr_poll_addr_hi);
 
 	/* enable the doorbell if requested */
 	if (ring->use_doorbell) {
-		WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_LOWER,
+		WREG32_SOC15_RLC(GC, 0, mmCP_MEC_DOORBELL_RANGE_LOWER,
 			(adev->doorbell_index.kiq * 2) << 2);
-		WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
+		WREG32_SOC15_RLC(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
 			(adev->doorbell_index.userqueue_end * 2) << 2);
 	}
 
-	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL,
+	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL,
 	       mqd->cp_hqd_pq_doorbell_control);
 
 	/* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
-	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_LO,
+	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_WPTR_LO,
 	       mqd->cp_hqd_pq_wptr_lo);
-	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_HI,
+	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_WPTR_HI,
 	       mqd->cp_hqd_pq_wptr_hi);
 
 	/* set the vmid for the queue */
-	WREG32_SOC15(GC, 0, mmCP_HQD_VMID, mqd->cp_hqd_vmid);
+	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_VMID, mqd->cp_hqd_vmid);
 
-	WREG32_SOC15(GC, 0, mmCP_HQD_PERSISTENT_STATE,
+	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PERSISTENT_STATE,
 	       mqd->cp_hqd_persistent_state);
 
 	/* activate the queue */
-	WREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE,
+	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_ACTIVE,
 	       mqd->cp_hqd_active);
 
 	if (ring->use_doorbell)
@@ -7118,6 +7118,9 @@ static void gfx_v10_0_setup_grbm_cam_remapping(struct amdgpu_device *adev)
 {
 	uint32_t data;
 
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	/* initialize cam_index to 0
 	 * index will auto-inc after each data writting */
 	WREG32_SOC15(GC, 0, mmGRBM_CAM_INDEX, 0);
@@ -7185,7 +7188,7 @@ static void gfx_v10_0_setup_grbm_cam_remapping(struct amdgpu_device *adev)
 		/* mmVGT_TF_RING_SIZE_UMD -> mmVGT_TF_RING_SIZE */
 		data = (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_RING_SIZE_UMD) <<
 			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
-		       (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_RING_SIZE) <<
+			(SOC15_REG_OFFSET(GC, 0, mmVGT_TF_RING_SIZE) <<
 			GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
 		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
 		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
@@ -7193,7 +7196,7 @@ static void gfx_v10_0_setup_grbm_cam_remapping(struct amdgpu_device *adev)
 		/* mmVGT_TF_MEMORY_BASE_UMD -> mmVGT_TF_MEMORY_BASE */
 		data = (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_MEMORY_BASE_UMD) <<
 			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
-		       (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_MEMORY_BASE) <<
+			(SOC15_REG_OFFSET(GC, 0, mmVGT_TF_MEMORY_BASE) <<
 			GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
 		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
 		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
@@ -7201,7 +7204,7 @@ static void gfx_v10_0_setup_grbm_cam_remapping(struct amdgpu_device *adev)
 		/* mmVGT_TF_MEMORY_BASE_HI_UMD -> mmVGT_TF_MEMORY_BASE_HI */
 		data = (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_MEMORY_BASE_HI_UMD) <<
 			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
-		       (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_MEMORY_BASE_HI) <<
+			(SOC15_REG_OFFSET(GC, 0, mmVGT_TF_MEMORY_BASE_HI) <<
 			GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
 		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
 		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
@@ -7209,7 +7212,7 @@ static void gfx_v10_0_setup_grbm_cam_remapping(struct amdgpu_device *adev)
 		/* mmVGT_HS_OFFCHIP_PARAM_UMD -> mmVGT_HS_OFFCHIP_PARAM */
 		data = (SOC15_REG_OFFSET(GC, 0, mmVGT_HS_OFFCHIP_PARAM_UMD) <<
 			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
-		       (SOC15_REG_OFFSET(GC, 0, mmVGT_HS_OFFCHIP_PARAM) <<
+			(SOC15_REG_OFFSET(GC, 0, mmVGT_HS_OFFCHIP_PARAM) <<
 			GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
 		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
 		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
@@ -7217,7 +7220,7 @@ static void gfx_v10_0_setup_grbm_cam_remapping(struct amdgpu_device *adev)
 		/* mmVGT_ESGS_RING_SIZE_UMD -> mmVGT_ESGS_RING_SIZE */
 		data = (SOC15_REG_OFFSET(GC, 0, mmVGT_ESGS_RING_SIZE_UMD) <<
 			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
-		       (SOC15_REG_OFFSET(GC, 0, mmVGT_ESGS_RING_SIZE) <<
+			(SOC15_REG_OFFSET(GC, 0, mmVGT_ESGS_RING_SIZE) <<
 			GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
 		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
 		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
@@ -7225,7 +7228,7 @@ static void gfx_v10_0_setup_grbm_cam_remapping(struct amdgpu_device *adev)
 		/* mmVGT_GSVS_RING_SIZE_UMD -> mmVGT_GSVS_RING_SIZE */
 		data = (SOC15_REG_OFFSET(GC, 0, mmVGT_GSVS_RING_SIZE_UMD) <<
 			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
-		       (SOC15_REG_OFFSET(GC, 0, mmVGT_GSVS_RING_SIZE) <<
+			(SOC15_REG_OFFSET(GC, 0, mmVGT_GSVS_RING_SIZE) <<
 			GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
 		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
 		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
@@ -7233,7 +7236,7 @@ static void gfx_v10_0_setup_grbm_cam_remapping(struct amdgpu_device *adev)
 		/* mmSPI_CONFIG_CNTL_REMAP -> mmSPI_CONFIG_CNTL */
 		data = (SOC15_REG_OFFSET(GC, 0, mmSPI_CONFIG_CNTL_REMAP) <<
 			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
-		       (SOC15_REG_OFFSET(GC, 0, mmSPI_CONFIG_CNTL) <<
+			(SOC15_REG_OFFSET(GC, 0, mmSPI_CONFIG_CNTL) <<
 			GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
 		break;
 	}
@@ -7882,7 +7885,7 @@ static void gfx_v10_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
 	if (amdgpu_sriov_is_pp_one_vf(adev))
 		data = RREG32_NO_KIQ(reg);
 	else
-		data = RREG32(reg);
+		data = RREG32_RLC(reg);
 
 	data &= ~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK;
 	data |= (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
@@ -7890,7 +7893,7 @@ static void gfx_v10_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
 	if (amdgpu_sriov_is_pp_one_vf(adev))
 		WREG32_SOC15_NO_KIQ(GC, 0, mmRLC_SPM_MC_CNTL, data);
 	else
-		WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, data);
+		WREG32_SOC15_RLC(GC, 0, mmRLC_SPM_MC_CNTL, data);
 }
 
 static bool gfx_v10_0_check_rlcg_range(struct amdgpu_device *adev,
@@ -8875,20 +8878,20 @@ static int gfx_v10_0_kiq_set_interrupt_state(struct amdgpu_device *adev,
 	switch (type) {
 	case AMDGPU_CP_KIQ_IRQ_DRIVER0:
 		if (state == AMDGPU_IRQ_STATE_DISABLE) {
-			tmp = RREG32_SOC15(GC, 0, mmCPC_INT_CNTL);
+			tmp = RREG32_SOC15_RLC(GC, 0, mmCPC_INT_CNTL);
 			tmp = REG_SET_FIELD(tmp, CPC_INT_CNTL,
 					    GENERIC2_INT_ENABLE, 0);
-			WREG32_SOC15(GC, 0, mmCPC_INT_CNTL, tmp);
+			WREG32_SOC15_RLC(GC, 0, mmCPC_INT_CNTL, tmp);
 
 			tmp = RREG32(target);
 			tmp = REG_SET_FIELD(tmp, CP_ME2_PIPE0_INT_CNTL,
 					    GENERIC2_INT_ENABLE, 0);
 			WREG32(target, tmp);
 		} else {
-			tmp = RREG32_SOC15(GC, 0, mmCPC_INT_CNTL);
+			tmp = RREG32_SOC15_RLC(GC, 0, mmCPC_INT_CNTL);
 			tmp = REG_SET_FIELD(tmp, CPC_INT_CNTL,
 					    GENERIC2_INT_ENABLE, 1);
-			WREG32_SOC15(GC, 0, mmCPC_INT_CNTL, tmp);
+			WREG32_SOC15_RLC(GC, 0, mmCPC_INT_CNTL, tmp);
 
 			tmp = RREG32(target);
 			tmp = REG_SET_FIELD(tmp, CP_ME2_PIPE0_INT_CNTL,
@@ -9173,14 +9176,14 @@ static void gfx_v10_0_set_user_wgp_inactive_bitmap_per_sh(struct amdgpu_device *
 	data = bitmap << GC_USER_SHADER_ARRAY_CONFIG__INACTIVE_WGPS__SHIFT;
 	data &= GC_USER_SHADER_ARRAY_CONFIG__INACTIVE_WGPS_MASK;
 
-	WREG32_SOC15(GC, 0, mmGC_USER_SHADER_ARRAY_CONFIG, data);
+	WREG32_SOC15_RLC(GC, 0, mmGC_USER_SHADER_ARRAY_CONFIG, data);
 }
 
 static u32 gfx_v10_0_get_wgp_active_bitmap_per_sh(struct amdgpu_device *adev)
 {
 	u32 data, wgp_bitmask;
-	data = RREG32_SOC15(GC, 0, mmCC_GC_SHADER_ARRAY_CONFIG);
-	data |= RREG32_SOC15(GC, 0, mmGC_USER_SHADER_ARRAY_CONFIG);
+	data = RREG32_SOC15_RLC(GC, 0, mmCC_GC_SHADER_ARRAY_CONFIG);
+	data |= RREG32_SOC15_RLC(GC, 0, mmGC_USER_SHADER_ARRAY_CONFIG);
 
 	data &= CC_GC_SHADER_ARRAY_CONFIG__INACTIVE_WGPS_MASK;
 	data >>= CC_GC_SHADER_ARRAY_CONFIG__INACTIVE_WGPS__SHIFT;
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 46d4bbabce75..ce04bc6dea21 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -363,7 +363,7 @@ void nv_grbm_select(struct amdgpu_device *adev,
 	grbm_gfx_cntl = REG_SET_FIELD(grbm_gfx_cntl, GRBM_GFX_CNTL, VMID, vmid);
 	grbm_gfx_cntl = REG_SET_FIELD(grbm_gfx_cntl, GRBM_GFX_CNTL, QUEUEID, queue);
 
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_CNTL), grbm_gfx_cntl);
+	WREG32_SOC15_RLC_SHADOW(GC, 0, mmGRBM_GFX_CNTL, grbm_gfx_cntl);
 }
 
 static void nv_vga_set_state(struct amdgpu_device *adev, bool state)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3145DC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 08:14:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B81A161419
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 08:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B81A161419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F2516ED9F;
	Thu, 29 Apr 2021 08:14:07 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2063.outbound.protection.outlook.com [40.107.100.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B7DB6EDA0
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 08:14:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKB5b2ieSIUr3qIjaAvCKzW6XqyD3dI/exzR+Y/eFs3ulHlHBRL2P6+LjrW3voy9pLe1K/RoZm9cZq5javXDKNHCdANNqhaBNLM8kVMBNYUrNRnUrg+SEaYF3tuRwOdNrbM08WQjh1m36tCLCM56L+Ok1uVFYN8gtepPRe5qNy8OLyIdycJtjtylKb4kmvcefPF+kXyoQjiYIWCPH/4wRmzKZJClT0MJbr1WwS6I8c/qfBFWKjuw/U+nkBSt0fqCUlNbuSdybcm0C7xBZeVda+p44a3bCCMXecbGskjg30GXZCs6NukdpMagKjGqkrfInCBt/LUguR4vTmw5A53d3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBrYfxyuVKLBYcWBlOsosp86fC7KtifIejY6KoO2NG4=;
 b=nvSXdzbKJJkCF7qwUe78kkeO6aRKHaYcwmeG9weu8svcvZHiVfOhBswMjFPzfyknaQpD+q7Gq/ZyDdEiINKZkb4TJrxqZBfg/wJaf3676zrwn+WeRZyQhV3mpiA2594gYMkToA24Oa9CxZZZx72kiv81dVNqItQsYTiMXwakiNf0dXztsSfXuST0Mfj12UtxXyXyhsDV8KhI7Yp2Veqt4kn9O+s8bLxqvrZO4bSijPGdvfB0cjASZH8SVF3jdps4OtQrCRl2KbaNrARQarimpQGCzWEhY0kQmMfbGttFWISNAhSVj8VXDilc6q5JdsHxP/kReGHu2ykoxONn1RkcCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBrYfxyuVKLBYcWBlOsosp86fC7KtifIejY6KoO2NG4=;
 b=JZE2c+oI1cJLr9y+7Fe2pefJwGwU/CCDpq0ATBtfc3HQU7uCyXHDSC6wtWi37t3oxbU+4suDnKLHk4iYGH2TLiPoMzx096fibemhjrW7dFiywujSa/swXxQCEN6f00vkcYl8cOrrr5iDEZjWvk+x8BMWyKYy62V8zb3tFOfldI4=
Received: from DM3PR12CA0072.namprd12.prod.outlook.com (2603:10b6:0:57::16) by
 DM6PR12MB3308.namprd12.prod.outlook.com (2603:10b6:5:182::31) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.23; Thu, 29 Apr 2021 08:14:02 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:57:cafe::42) by DM3PR12CA0072.outlook.office365.com
 (2603:10b6:0:57::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend
 Transport; Thu, 29 Apr 2021 08:14:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4087.32 via Frontend Transport; Thu, 29 Apr 2021 08:14:02 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 03:14:01 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 03:14:01 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Thu, 29 Apr 2021 03:14:00 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/12] drm/amdgpu: Modify GC register access from MMIO to RLCG
 in file kfd_v10*
Date: Thu, 29 Apr 2021 16:13:36 +0800
Message-ID: <20210429081345.24217-3-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429081345.24217-1-PengJu.Zhou@amd.com>
References: <20210429081345.24217-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a20b56cd-143d-4300-ec34-08d90ae6bfd2
X-MS-TrafficTypeDiagnostic: DM6PR12MB3308:
X-Microsoft-Antispam-PRVS: <DM6PR12MB33088C9FDE77FA3D2D666064F85F9@DM6PR12MB3308.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:626;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gW8KMEievmOie5Lh1ZyYr6uWTTlxjKFmLVG2/SMxnXN+JtQNN5sWlVF6RoBG4ercjsy71t8EzGWi0rOYJ1hzixDplbK6gG021G+z3c24SPPwhZnzub2d505jT9KYa4mX1sjAtPlB3M5/nBTjk4VOijxnoZc32Phu6RdCq+BeWMSSRY8Qo/JiNzz1e2Ub+9QytAlnaaVp9VBaDJ5RzHr2txTGiQGWPWL4+jY9eaprQVeQJeECoX/vl240cPqZUM1xWLPjVvf1v7ew4Ql3WmObBG/ne2JNqPEuMTM+x5YhmMVZpPnYX5GUkP1tYYeqwpOpmaaEKtf1XEv9vb1JiIB3rMy606kG8zehiEQ+nwGdUfFZjCp6GTnOYd+lXL7uKQc1ayiVeWvs7+R3qI1oVHSykhrB7eQiUEca4xhlhkX7TapVwxmPVQVnTTaLEIfTEf61Y2tHsp81JTL/L3kkF61oautsOa5ce7ZkdOcgp21rAjUKhN/p4PlbtVBhs6zHsj+imNpfh7K9UXuy6j8EclRT5pHgcnHBXoapBMPHwzN92pVmjdwhy35PJpADPu2iYZWuUXMY1RHx5GGa/u2cYNMKxuRWKm3qPfbDKYny+70poXOIl1GSRBCSXH3PM0MWDAO0K6S+q2p2cRDgbwvrtYz1rkKvyYrPB3Ty4H9Nqj9Aj3PhBksxZ5S9taPrkIxr1k+w
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(36840700001)(46966006)(6666004)(2616005)(478600001)(47076005)(26005)(82310400003)(70206006)(70586007)(83380400001)(186003)(1076003)(356005)(82740400003)(4326008)(426003)(336012)(6916009)(86362001)(81166007)(7696005)(36860700001)(2906002)(8936002)(36756003)(5660300002)(316002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 08:14:02.5673 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a20b56cd-143d-4300-ec34-08d90ae6bfd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3308
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

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    | 42 +++++++++----------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 62aa1a6f64ed..491acdf92f73 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -96,8 +96,8 @@ static void kgd_program_sh_mem_settings(struct kgd_dev *kgd, uint32_t vmid,
 
 	lock_srbm(kgd, 0, 0, 0, vmid);
 
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmSH_MEM_CONFIG), sh_mem_config);
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmSH_MEM_BASES), sh_mem_bases);
+	WREG32_SOC15(GC, 0, mmSH_MEM_CONFIG, sh_mem_config);
+	WREG32_SOC15(GC, 0, mmSH_MEM_BASES, sh_mem_bases);
 	/* APE1 no longer exists on GFX9 */
 
 	unlock_srbm(kgd);
@@ -161,7 +161,7 @@ static int kgd_init_interrupts(struct kgd_dev *kgd, uint32_t pipe_id)
 
 	lock_srbm(kgd, mec, pipe, 0, 0);
 
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmCPC_INT_CNTL),
+	WREG32_SOC15(GC, 0, mmCPC_INT_CNTL,
 		CP_INT_CNTL_RING0__TIME_STAMP_INT_ENABLE_MASK |
 		CP_INT_CNTL_RING0__OPCODE_ERROR_INT_ENABLE_MASK);
 
@@ -239,13 +239,13 @@ static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
 
 	for (reg = hqd_base;
 	     reg <= SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_HI); reg++)
-		WREG32(reg, mqd_hqd[reg - hqd_base]);
+		WREG32_SOC15_IP(GC, reg, mqd_hqd[reg - hqd_base]);
 
 
 	/* Activate doorbell logic before triggering WPTR poll. */
 	data = REG_SET_FIELD(m->cp_hqd_pq_doorbell_control,
 			     CP_HQD_PQ_DOORBELL_CONTROL, DOORBELL_EN, 1);
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL), data);
+	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL, data);
 
 	if (wptr) {
 		/* Don't read wptr with get_user because the user
@@ -274,27 +274,27 @@ static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
 		guessed_wptr += m->cp_hqd_pq_wptr_lo & ~(queue_size - 1);
 		guessed_wptr += (uint64_t)m->cp_hqd_pq_wptr_hi << 32;
 
-		WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_LO),
+		WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_LO,
 		       lower_32_bits(guessed_wptr));
-		WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_HI),
+		WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_HI,
 		       upper_32_bits(guessed_wptr));
-		WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR),
+		WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR,
 		       lower_32_bits((uint64_t)wptr));
-		WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR_HI),
+		WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR_HI,
 		       upper_32_bits((uint64_t)wptr));
 		pr_debug("%s setting CP_PQ_WPTR_POLL_CNTL1 to %x\n", __func__,
 			 (uint32_t)get_queue_mask(adev, pipe_id, queue_id));
-		WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_PQ_WPTR_POLL_CNTL1),
+		WREG32_SOC15(GC, 0, mmCP_PQ_WPTR_POLL_CNTL1,
 		       (uint32_t)get_queue_mask(adev, pipe_id, queue_id));
 	}
 
 	/* Start the EOP fetcher */
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_EOP_RPTR),
+	WREG32_SOC15(GC, 0, mmCP_HQD_EOP_RPTR,
 	       REG_SET_FIELD(m->cp_hqd_eop_rptr,
 			     CP_HQD_EOP_RPTR, INIT_FETCHER, 1));
 
 	data = REG_SET_FIELD(m->cp_hqd_active, CP_HQD_ACTIVE, ACTIVE, 1);
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_ACTIVE), data);
+	WREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE, data);
 
 	release_queue(kgd);
 
@@ -365,7 +365,7 @@ static int kgd_hqd_dump(struct kgd_dev *kgd,
 		if (WARN_ON_ONCE(i >= HQD_N_REGS))	\
 			break;				\
 		(*dump)[i][0] = (addr) << 2;		\
-		(*dump)[i++][1] = RREG32(addr);		\
+		(*dump)[i++][1] = RREG32_SOC15_IP(GC, addr);		\
 	} while (0)
 
 	*dump = kmalloc(HQD_N_REGS*2*sizeof(uint32_t), GFP_KERNEL);
@@ -497,13 +497,13 @@ static bool kgd_hqd_is_occupied(struct kgd_dev *kgd, uint64_t queue_address,
 	uint32_t low, high;
 
 	acquire_queue(kgd, pipe_id, queue_id);
-	act = RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_ACTIVE));
+	act = RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE);
 	if (act) {
 		low = lower_32_bits(queue_address >> 8);
 		high = upper_32_bits(queue_address >> 8);
 
-		if (low == RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_BASE)) &&
-		   high == RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_BASE_HI)))
+		if (low == RREG32_SOC15(GC, 0, mmCP_HQD_PQ_BASE) &&
+		   high == RREG32_SOC15(GC, 0, mmCP_HQD_PQ_BASE_HI))
 			retval = true;
 	}
 	release_queue(kgd);
@@ -621,11 +621,11 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd,
 	preempt_enable();
 #endif
 
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_DEQUEUE_REQUEST), type);
+	WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_REQUEST, type);
 
 	end_jiffies = (utimeout * HZ / 1000) + jiffies;
 	while (true) {
-		temp = RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_ACTIVE));
+		temp = RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE);
 		if (!(temp & CP_HQD_ACTIVE__ACTIVE_MASK))
 			break;
 		if (time_after(jiffies, end_jiffies)) {
@@ -716,8 +716,8 @@ static int kgd_wave_control_execute(struct kgd_dev *kgd,
 
 	mutex_lock(&adev->grbm_idx_mutex);
 
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_INDEX), gfx_index_val);
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_CMD), sq_cmd);
+	WREG32_SOC15(GC, 0, mmGRBM_GFX_INDEX, gfx_index_val);
+	WREG32_SOC15(GC, 0, mmSQ_CMD, sq_cmd);
 
 	data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
 		INSTANCE_BROADCAST_WRITES, 1);
@@ -726,7 +726,7 @@ static int kgd_wave_control_execute(struct kgd_dev *kgd,
 	data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
 		SE_BROADCAST_WRITES, 1);
 
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_INDEX), data);
+	WREG32_SOC15(GC, 0, mmGRBM_GFX_INDEX, data);
 	mutex_unlock(&adev->grbm_idx_mutex);
 
 	return 0;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

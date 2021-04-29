Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307CDC43460
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 10:27:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7E7F61453
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 10:27:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E7F61453
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61A246EDE2;
	Thu, 29 Apr 2021 10:27:09 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2050.outbound.protection.outlook.com [40.107.212.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E44C16EDE2
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 10:27:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/DKi0fEbcHNZ2McnxeJpC8D2ruHw2qfpT+PoJlH9nVYwz33ca0TmygPDUMnGeha6kLSSjJ8+48x8uJV6kHNY349dZE/d+M11DIb37yBDf90naC1oEmA8Rr/R08xk5AEh4NYgNLl0slAy1kO2li6Bo9eyXomwy/m4tZFPOSS/1n2LrkZMe/RUqzAhZfsPpr3eueT/SEmjgX99XNj3lj85QwsOrP/xq/mNT3es3cCD19iL5CnHpwaM64q8CrD5TLLQsfqjgV5ZRlS0zdcIIcGYUf5GFDr4cYo/5AQ6cK1W41We4ecIzht0gqTEzpO98FFzhQcZUrZ+4KrHa1bBXBRKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNLbcP7C4ZZyd65NUd6cvGdopmipymp3amUucgjIXow=;
 b=fQ8DuFfOA8pCywBtZukGo0Ns4PpM7iJDTjwEYqKgUh/2FRqPq3XTvLk/Q+MhIo17aVVNVFTewNBe8nk4MeeIO2Y2WfdjkDd/5KXvyydTMzLzqlejkUrplDgdghQbhzsEr+BItYK2Mb9rLEVdEFnwfiJJCsziVsdP1PcvDL3hSAHbaUrVDwDTbZ3e5XpL5te3an1HrSSXcyPDaqO1uEWPZb/bXCixUcOK8tsnobBoqyJyn3Hb2xy3zPmrCG2jfWm0KUrVcn55tA9qTW9IR56HOtYxe2AymVb80bkfC9z+Sjz4BqDnzDjLxy7np88fsEDSwHcx6CnW51g/OQomSo4hag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNLbcP7C4ZZyd65NUd6cvGdopmipymp3amUucgjIXow=;
 b=omq3FFgcPGiocJQsvX7PQsoNf3PGqyoQxSNc+GASoxVg2JhcEFKQwvCAqYQLwt9+o6kjzacO787qVRdvr4ahcp3mnjvtc1ySswjGrtDg/t+C+euooDy+7QvnPMmwhEqovWKS4FpVN2Mqngwwv+t1EKCWgvLvgtAcD5NtVQFN4c4=
Received: from DM3PR12CA0070.namprd12.prod.outlook.com (2603:10b6:0:57::14) by
 CY4PR12MB1863.namprd12.prod.outlook.com (2603:10b6:903:120::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Thu, 29 Apr
 2021 10:27:06 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:57:cafe::37) by DM3PR12CA0070.outlook.office365.com
 (2603:10b6:0:57::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend
 Transport; Thu, 29 Apr 2021 10:27:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4087.27 via Frontend Transport; Thu, 29 Apr 2021 10:27:05 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 05:27:04 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Thu, 29 Apr 2021 05:27:03 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 05/12] drm/amdgpu: Modify GC register access from MMIO to
 RLCG in file sdma_v5*
Date: Thu, 29 Apr 2021 18:26:37 +0800
Message-ID: <20210429102644.31172-5-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429102644.31172-1-PengJu.Zhou@amd.com>
References: <20210429102644.31172-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75988eb1-1f7c-49c9-8fd1-08d90af95624
X-MS-TrafficTypeDiagnostic: CY4PR12MB1863:
X-Microsoft-Antispam-PRVS: <CY4PR12MB18632C0C407C5DC086BDAAD8F85F9@CY4PR12MB1863.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nF0Sfc2VzZwJIdYuWI8mURi6gGVunAcqEKFmhIhZYBryeOyMVNAtGwMcD6slNO6lrQ6mPGs1TbgWahS9Lh2hzoMQN3+h+YjFswuPcpKjLRSMDdMmxZGU/wBhJzI3Rf2bPghqd9DtGZ0N7BUE5PRdAqqk/sDEvROlu73M1PCnmFeIA0kxJzrVQDY/pesEM2R/dUCtC0Au/g97ha1u5/NUx7hK0gHqUYwqpOKKUPEAVGsSf2jZCq6rY67gR/G+ReY/wkWTfPxWRiJfbExoN3lM2U0Abgdm1RLLC4VXP+l+SlOwCZY6Z2v2WZEGgCOjWauGB/O9qRWG5mErDTs/fSvrMCs2lOyJnewrH1XMUJDqIjFTNd5OvDffFI+Vtr/S97nkAP8WhWW8zbIihJ4OmzpTREtXMrilChF259N43ZrBP+Py+ujFgJZK3KuXPcM6dOZZgltmqS2tpMohF9xjnPjdEWnpUUwzNq8dOapbyjp1AK2r+BMpcmP5YN7ao//eS4ROr73E5vthprKNINopKAfRSSkYVUObhE+5Hr+w9ZgaArDri3dUGC0b0eEOURPHlmXoZPjrBk7IlODgPbbg2YI4uf9B77OpfZ8PUBkHfQE+oxn3o7FOKfx1HPFw1qRDcD973f3gYwpc32h8h9aK42NWrvOKUabqQi5Jsvd9BFeRKMnP9ymSVCpXfvvMKE/oOE56
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(396003)(39850400004)(46966006)(36840700001)(82740400003)(6666004)(4326008)(83380400001)(316002)(186003)(36756003)(26005)(426003)(81166007)(6916009)(2906002)(356005)(7696005)(478600001)(47076005)(86362001)(70206006)(8936002)(8676002)(2616005)(36860700001)(336012)(5660300002)(82310400003)(1076003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 10:27:05.7077 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75988eb1-1f7c-49c9-8fd1-08d90af95624
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1863
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
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 78 ++++++++++++++------------
 1 file changed, 42 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 920fc6d4a127..0673c5700db6 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -324,9 +324,9 @@ static uint64_t sdma_v5_0_ring_get_wptr(struct amdgpu_ring *ring)
 		wptr = READ_ONCE(*((u64 *)&adev->wb.wb[ring->wptr_offs]));
 		DRM_DEBUG("wptr/doorbell before shift == 0x%016llx\n", wptr);
 	} else {
-		wptr = RREG32(sdma_v5_0_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR_HI));
+		wptr = RREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR_HI));
 		wptr = wptr << 32;
-		wptr |= RREG32(sdma_v5_0_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR));
+		wptr |= RREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR));
 		DRM_DEBUG("wptr before shift [%i] wptr == 0x%016llx\n", ring->me, wptr);
 	}
 
@@ -367,9 +367,9 @@ static void sdma_v5_0_ring_set_wptr(struct amdgpu_ring *ring)
 				lower_32_bits(ring->wptr << 2),
 				ring->me,
 				upper_32_bits(ring->wptr << 2));
-		WREG32(sdma_v5_0_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR),
+		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR),
 			lower_32_bits(ring->wptr << 2));
-		WREG32(sdma_v5_0_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR_HI),
+		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR_HI),
 			upper_32_bits(ring->wptr << 2));
 	}
 }
@@ -530,12 +530,12 @@ static void sdma_v5_0_gfx_stop(struct amdgpu_device *adev)
 		amdgpu_ttm_set_buffer_funcs_status(adev, false);
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
-		rb_cntl = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
+		rb_cntl = RREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 0);
-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
-		ib_cntl = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL));
+		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
+		ib_cntl = RREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL));
 		ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_ENABLE, 0);
-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL), ib_cntl);
+		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL), ib_cntl);
 	}
 }
 
@@ -596,11 +596,11 @@ static void sdma_v5_0_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
 		}
 
 		if (enable && amdgpu_sdma_phase_quantum) {
-			WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_PHASE0_QUANTUM),
+			WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_PHASE0_QUANTUM),
 			       phase_quantum);
-			WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_PHASE1_QUANTUM),
+			WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_PHASE1_QUANTUM),
 			       phase_quantum);
-			WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_PHASE2_QUANTUM),
+			WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_PHASE2_QUANTUM),
 			       phase_quantum);
 		}
 		if (!amdgpu_sriov_vf(adev))
@@ -667,58 +667,63 @@ static int sdma_v5_0_gfx_resume(struct amdgpu_device *adev)
 
 		/* Set ring buffer size in dwords */
 		rb_bufsz = order_base_2(ring->ring_size / 4);
-		rb_cntl = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
+		rb_cntl = RREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_SIZE, rb_bufsz);
 #ifdef __BIG_ENDIAN
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_SWAP_ENABLE, 1);
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL,
 					RPTR_WRITEBACK_SWAP_ENABLE, 1);
 #endif
-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
+		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
 
 		/* Initialize the ring buffer's read and write pointers */
-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR), 0);
-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_HI), 0);
-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR), 0);
-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI), 0);
+		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR), 0);
+		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_HI), 0);
+		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR), 0);
+		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI), 0);
 
 		/* setup the wptr shadow polling */
 		wptr_gpu_addr = adev->wb.gpu_addr + (ring->wptr_offs * 4);
-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_ADDR_LO),
+		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_ADDR_LO),
 		       lower_32_bits(wptr_gpu_addr));
-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_ADDR_HI),
+		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_ADDR_HI),
 		       upper_32_bits(wptr_gpu_addr));
-		wptr_poll_cntl = RREG32(sdma_v5_0_get_reg_offset(adev, i,
+		wptr_poll_cntl = RREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i,
 							 mmSDMA0_GFX_RB_WPTR_POLL_CNTL));
 		wptr_poll_cntl = REG_SET_FIELD(wptr_poll_cntl,
 					       SDMA0_GFX_RB_WPTR_POLL_CNTL,
 					       F32_POLL_ENABLE, 1);
-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_CNTL),
+		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_CNTL),
 		       wptr_poll_cntl);
 
 		/* set the wb address whether it's enabled or not */
-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_ADDR_HI),
+		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_ADDR_HI),
 		       upper_32_bits(adev->wb.gpu_addr + wb_offset) & 0xFFFFFFFF);
-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_ADDR_LO),
+		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_ADDR_LO),
 		       lower_32_bits(adev->wb.gpu_addr + wb_offset) & 0xFFFFFFFC);
 
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RPTR_WRITEBACK_ENABLE, 1);
 
-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_BASE), ring->gpu_addr >> 8);
-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_BASE_HI), ring->gpu_addr >> 40);
+		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_BASE),
+		       ring->gpu_addr >> 8);
+		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_BASE_HI),
+		       ring->gpu_addr >> 40);
 
 		ring->wptr = 0;
 
 		/* before programing wptr to a less value, need set minor_ptr_update first */
-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_MINOR_PTR_UPDATE), 1);
+		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_MINOR_PTR_UPDATE), 1);
 
 		if (!amdgpu_sriov_vf(adev)) { /* only bare-metal use register write for wptr */
-			WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR), lower_32_bits(ring->wptr) << 2);
-			WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI), upper_32_bits(ring->wptr) << 2);
+			WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR),
+			       lower_32_bits(ring->wptr) << 2);
+			WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI),
+			       upper_32_bits(ring->wptr) << 2);
 		}
 
-		doorbell = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL));
-		doorbell_offset = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL_OFFSET));
+		doorbell = RREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL));
+		doorbell_offset = RREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i,
+						mmSDMA0_GFX_DOORBELL_OFFSET));
 
 		if (ring->use_doorbell) {
 			doorbell = REG_SET_FIELD(doorbell, SDMA0_GFX_DOORBELL, ENABLE, 1);
@@ -727,8 +732,9 @@ static int sdma_v5_0_gfx_resume(struct amdgpu_device *adev)
 		} else {
 			doorbell = REG_SET_FIELD(doorbell, SDMA0_GFX_DOORBELL, ENABLE, 0);
 		}
-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL), doorbell);
-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL_OFFSET), doorbell_offset);
+		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL), doorbell);
+		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL_OFFSET),
+		       doorbell_offset);
 
 		adev->nbio.funcs->sdma_doorbell_range(adev, i, ring->use_doorbell,
 						      ring->doorbell_index, 20);
@@ -737,7 +743,7 @@ static int sdma_v5_0_gfx_resume(struct amdgpu_device *adev)
 			sdma_v5_0_ring_set_wptr(ring);
 
 		/* set minor_ptr_update to 0 after wptr programed */
-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_MINOR_PTR_UPDATE), 0);
+		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_MINOR_PTR_UPDATE), 0);
 
 		if (!amdgpu_sriov_vf(adev)) {
 			/* set utc l1 enable flag always to 1 */
@@ -771,15 +777,15 @@ static int sdma_v5_0_gfx_resume(struct amdgpu_device *adev)
 
 		/* enable DMA RB */
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 1);
-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
+		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
 
-		ib_cntl = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL));
+		ib_cntl = RREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL));
 		ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_ENABLE, 1);
 #ifdef __BIG_ENDIAN
 		ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_SWAP_ENABLE, 1);
 #endif
 		/* enable DMA IBs */
-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL), ib_cntl);
+		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL), ib_cntl);
 
 		ring->sched.ready = true;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

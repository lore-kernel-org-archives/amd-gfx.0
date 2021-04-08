Return-Path: <SRS0=VH8F=JF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA2AC433ED
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 05:33:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A91D61151
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 05:33:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A91D61151
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E38C789BF6;
	Thu,  8 Apr 2021 05:33:12 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4E2089B66
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Apr 2021 05:33:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbhdAI99e0j/FubJBYwAl3R0ciLbQbaldoyDPBHBJYFDtoKWHyEJY0IPrBR0zjEg2GtiUE/qFG3hthHGOpLSMLMWe6nUIi+Yh1Ha8LRQcB3C5GSiJ691m4IWyix0N7vGm71RjVDQMIiA98Hk8Slpan1cW0DrxESLUkeBNCUypw/p5TGp565dCE1CAL7VCrA20Ego7CKCgiTMWFEHU5l4ADlb7Lq1mCYG1kliGjapxijMZckAfzc2cbf4gc4fhP6LC+y7oLJS3RrEoils05/DX7RROMAUjo0m6Nt5Re4iqHV0xrx9SUreBdTE2blZQMX8/JXwyvBI19IwPue9QRSEkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qK0dRlRHy4kNGe36J6zhiwCN4oViBMy0yUSqdchK6R0=;
 b=RuLiO8HgyZnRfgx/jwGywy58Yunt0U0IAhh8BExTrAHJhGZxfpfHDeYbz7Jqge3uLK2S8NV+XUOSgEythtGbRo9w5TKDzUMXxQWgKsYXdovrgfuLuVDUqMCcC5HHptqK5VTGP+2jmUPC6cnx4f7ic3tR+EoAl5zcYemcCOvMDdnkpeaG9pJ+5HjxE9DEuGl5WzMk2wJTjGQVyYCzNbAZuOWmyj0t0ejFChbuFqfBvtq24sfONGeXb/pi68/g2zOCapwKndja0N3xQr2+aG7h+jSyACVFMgaJcDmXRpcPJhv3JBgtBcpxUyR/pbHTBDivpvdNg4oh85PrDmvGarbtpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qK0dRlRHy4kNGe36J6zhiwCN4oViBMy0yUSqdchK6R0=;
 b=obojvcBkdrnDHEa6OoALEZqwHG+xoKt3l3m0AAcVSZwM4gd/yC0QNHJqptpdZ7nDVJbFc6WpxFABEWI6EfXBfvEq0qVAWw6sLPGWDUKnNAooNgvY/unaOBgK0t7/9tmqxWiq/X6y+7FlUo3o5XZbP060gbJVKzT1v+v0UFQtHUQ=
Received: from BN6PR11CA0036.namprd11.prod.outlook.com (2603:10b6:404:4b::22)
 by BN8PR12MB3537.namprd12.prod.outlook.com (2603:10b6:408:6d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Thu, 8 Apr
 2021 05:33:09 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:4b:cafe::6f) by BN6PR11CA0036.outlook.office365.com
 (2603:10b6:404:4b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Thu, 8 Apr 2021 05:33:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Thu, 8 Apr 2021 05:33:09 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 8 Apr 2021
 00:33:09 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 8 Apr 2021
 00:33:08 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2 via Frontend
 Transport; Thu, 8 Apr 2021 00:33:07 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/8] drm/amdgpu: Change GC(SDMA) register access from MMIO to
 RLCG
Date: Thu, 8 Apr 2021 13:32:31 +0800
Message-ID: <20210408053236.30762-3-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210408053236.30762-1-PengJu.Zhou@amd.com>
References: <20210408053236.30762-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9b750fa-ca9c-4f15-bd3e-08d8fa4fcb57
X-MS-TrafficTypeDiagnostic: BN8PR12MB3537:
X-Microsoft-Antispam-PRVS: <BN8PR12MB35371A6C4D8F613E2E43F41DF8749@BN8PR12MB3537.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pb724WiNUcsWxIRR80lhiGB5tqSuE22WzEZvdMZKGDod6UXJ5O0xNDqPHkbrEj92wDnJzNWjoXp3Xsky5AjLKibCT9nXVOpQ+KI1lzBgBiw22Pb6zbcWCsKC+MvxL2X7BuKpK6252MO+7h9eJaMm6vjpxBD3aDo1TfFL/aT9L2sCmCqdcYK3oTdy9Jdcts4OOgChQsvvpCq3qtidOyY4BEDbT+AqH6bzXmrTPTayV1cDaHBcJbvaUwvxdr2Qnfhx4OhMG/ljR05R3/WmY4E0qzfB1dVOvKFeq4j+4gOjyfpGasqYW7Up/ABJLFqOmSq7sIps6jiEwfbtTb7kZhTZr5JaPVSXieri6Ks4T+ZI9tS4MFTEVQwDpZpl766BqpzuwuBZz77WMatbJN29vjhZegRAKIX2fHfvzzD/KCquuVdKcph2nEUYL7sfW21RIKM0VYddsS4MBnrS0HkIbF3MwFCHl/UiAdsKhBXc0zU4xPwjCYxjYbAn0tA3aJ+/Qs+QT9K3g3VpudumkyufFQqQbzJ635YRBJRMDK2FVSDQWeHNAaZCOf57RdD9EiTaerql+tPr9k6ALXk2S8ZNcmfIWe1pLfh+vVaOrB7u9eUSvfg6jKZSSJ+hfId/y1jfaPMh/656eyx56qea7QhpPh2uJxN+ni2MCzPjzsl1O9HNqQkKnCDskKXD2y2f/ZZhECgn
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(39860400002)(346002)(36840700001)(46966006)(36860700001)(36756003)(8936002)(2906002)(86362001)(81166007)(356005)(83380400001)(47076005)(82310400003)(1076003)(82740400003)(336012)(7696005)(186003)(26005)(8676002)(478600001)(316002)(5660300002)(4326008)(70206006)(54906003)(70586007)(426003)(2616005)(6666004)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 05:33:09.3370 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b750fa-ca9c-4f15-bd3e-08d8fa4fcb57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3537
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
Cc: jane.jian@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In SRIOV environment, KMD should access GC registers
with RLCG if GC indirect access flag enabled.

Change GC register access from MMIO to RLCG.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 78 ++++++++++++++------------
 1 file changed, 42 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 920fc6d4a127..f72faa132419 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -324,9 +324,9 @@ static uint64_t sdma_v5_0_ring_get_wptr(struct amdgpu_ring *ring)
 		wptr = READ_ONCE(*((u64 *)&adev->wb.wb[ring->wptr_offs]));
 		DRM_DEBUG("wptr/doorbell before shift == 0x%016llx\n", wptr);
 	} else {
-		wptr = RREG32(sdma_v5_0_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR_HI));
+		wptr = RREG32_RLC(sdma_v5_0_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR_HI));
 		wptr = wptr << 32;
-		wptr |= RREG32(sdma_v5_0_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR));
+		wptr |= RREG32_RLC(sdma_v5_0_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR));
 		DRM_DEBUG("wptr before shift [%i] wptr == 0x%016llx\n", ring->me, wptr);
 	}
 
@@ -367,9 +367,9 @@ static void sdma_v5_0_ring_set_wptr(struct amdgpu_ring *ring)
 				lower_32_bits(ring->wptr << 2),
 				ring->me,
 				upper_32_bits(ring->wptr << 2));
-		WREG32(sdma_v5_0_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR),
+		WREG32_RLC(sdma_v5_0_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR),
 			lower_32_bits(ring->wptr << 2));
-		WREG32(sdma_v5_0_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR_HI),
+		WREG32_RLC(sdma_v5_0_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR_HI),
 			upper_32_bits(ring->wptr << 2));
 	}
 }
@@ -530,12 +530,12 @@ static void sdma_v5_0_gfx_stop(struct amdgpu_device *adev)
 		amdgpu_ttm_set_buffer_funcs_status(adev, false);
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
-		rb_cntl = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
+		rb_cntl = RREG32_RLC(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 0);
-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
-		ib_cntl = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL));
+		WREG32_RLC(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
+		ib_cntl = RREG32_RLC(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL));
 		ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_ENABLE, 0);
-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL), ib_cntl);
+		WREG32_RLC(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL), ib_cntl);
 	}
 }
 
@@ -596,11 +596,11 @@ static void sdma_v5_0_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
 		}
 
 		if (enable && amdgpu_sdma_phase_quantum) {
-			WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_PHASE0_QUANTUM),
+			WREG32_RLC(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_PHASE0_QUANTUM),
 			       phase_quantum);
-			WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_PHASE1_QUANTUM),
+			WREG32_RLC(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_PHASE1_QUANTUM),
 			       phase_quantum);
-			WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_PHASE2_QUANTUM),
+			WREG32_RLC(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_PHASE2_QUANTUM),
 			       phase_quantum);
 		}
 		if (!amdgpu_sriov_vf(adev))
@@ -667,58 +667,63 @@ static int sdma_v5_0_gfx_resume(struct amdgpu_device *adev)
 
 		/* Set ring buffer size in dwords */
 		rb_bufsz = order_base_2(ring->ring_size / 4);
-		rb_cntl = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
+		rb_cntl = RREG32_RLC(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_SIZE, rb_bufsz);
 #ifdef __BIG_ENDIAN
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_SWAP_ENABLE, 1);
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL,
 					RPTR_WRITEBACK_SWAP_ENABLE, 1);
 #endif
-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
+		WREG32_RLC(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
 
 		/* Initialize the ring buffer's read and write pointers */
-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR), 0);
-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_HI), 0);
-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR), 0);
-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI), 0);
+		WREG32_RLC(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR), 0);
+		WREG32_RLC(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_HI), 0);
+		WREG32_RLC(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR), 0);
+		WREG32_RLC(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI), 0);
 
 		/* setup the wptr shadow polling */
 		wptr_gpu_addr = adev->wb.gpu_addr + (ring->wptr_offs * 4);
-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_ADDR_LO),
+		WREG32_RLC(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_ADDR_LO),
 		       lower_32_bits(wptr_gpu_addr));
-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_ADDR_HI),
+		WREG32_RLC(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_ADDR_HI),
 		       upper_32_bits(wptr_gpu_addr));
-		wptr_poll_cntl = RREG32(sdma_v5_0_get_reg_offset(adev, i,
+		wptr_poll_cntl = RREG32_RLC(sdma_v5_0_get_reg_offset(adev, i,
 							 mmSDMA0_GFX_RB_WPTR_POLL_CNTL));
 		wptr_poll_cntl = REG_SET_FIELD(wptr_poll_cntl,
 					       SDMA0_GFX_RB_WPTR_POLL_CNTL,
 					       F32_POLL_ENABLE, 1);
-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_CNTL),
+		WREG32_RLC(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_CNTL),
 		       wptr_poll_cntl);
 
 		/* set the wb address whether it's enabled or not */
-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_ADDR_HI),
+		WREG32_RLC(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_ADDR_HI),
 		       upper_32_bits(adev->wb.gpu_addr + wb_offset) & 0xFFFFFFFF);
-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_ADDR_LO),
+		WREG32_RLC(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_ADDR_LO),
 		       lower_32_bits(adev->wb.gpu_addr + wb_offset) & 0xFFFFFFFC);
 
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RPTR_WRITEBACK_ENABLE, 1);
 
-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_BASE), ring->gpu_addr >> 8);
-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_BASE_HI), ring->gpu_addr >> 40);
+		WREG32_RLC(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_BASE),
+		       ring->gpu_addr >> 8);
+		WREG32_RLC(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_BASE_HI),
+		       ring->gpu_addr >> 40);
 
 		ring->wptr = 0;
 
 		/* before programing wptr to a less value, need set minor_ptr_update first */
-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_MINOR_PTR_UPDATE), 1);
+		WREG32_RLC(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_MINOR_PTR_UPDATE), 1);
 
 		if (!amdgpu_sriov_vf(adev)) { /* only bare-metal use register write for wptr */
-			WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR), lower_32_bits(ring->wptr) << 2);
-			WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI), upper_32_bits(ring->wptr) << 2);
+			WREG32_RLC(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR),
+			       lower_32_bits(ring->wptr) << 2);
+			WREG32_RLC(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI),
+			       upper_32_bits(ring->wptr) << 2);
 		}
 
-		doorbell = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL));
-		doorbell_offset = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL_OFFSET));
+		doorbell = RREG32_RLC(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL));
+		doorbell_offset = RREG32_RLC(sdma_v5_0_get_reg_offset(adev, i,
+						mmSDMA0_GFX_DOORBELL_OFFSET));
 
 		if (ring->use_doorbell) {
 			doorbell = REG_SET_FIELD(doorbell, SDMA0_GFX_DOORBELL, ENABLE, 1);
@@ -727,8 +732,9 @@ static int sdma_v5_0_gfx_resume(struct amdgpu_device *adev)
 		} else {
 			doorbell = REG_SET_FIELD(doorbell, SDMA0_GFX_DOORBELL, ENABLE, 0);
 		}
-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL), doorbell);
-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL_OFFSET), doorbell_offset);
+		WREG32_RLC(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL), doorbell);
+		WREG32_RLC(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL_OFFSET),
+		       doorbell_offset);
 
 		adev->nbio.funcs->sdma_doorbell_range(adev, i, ring->use_doorbell,
 						      ring->doorbell_index, 20);
@@ -737,7 +743,7 @@ static int sdma_v5_0_gfx_resume(struct amdgpu_device *adev)
 			sdma_v5_0_ring_set_wptr(ring);
 
 		/* set minor_ptr_update to 0 after wptr programed */
-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_MINOR_PTR_UPDATE), 0);
+		WREG32_RLC(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_MINOR_PTR_UPDATE), 0);
 
 		if (!amdgpu_sriov_vf(adev)) {
 			/* set utc l1 enable flag always to 1 */
@@ -771,15 +777,15 @@ static int sdma_v5_0_gfx_resume(struct amdgpu_device *adev)
 
 		/* enable DMA RB */
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 1);
-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
+		WREG32_RLC(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
 
-		ib_cntl = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL));
+		ib_cntl = RREG32_RLC(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL));
 		ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_ENABLE, 1);
 #ifdef __BIG_ENDIAN
 		ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_SWAP_ENABLE, 1);
 #endif
 		/* enable DMA IBs */
-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL), ib_cntl);
+		WREG32_RLC(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL), ib_cntl);
 
 		ring->sched.ready = true;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

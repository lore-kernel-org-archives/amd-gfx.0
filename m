Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009BCC4743D
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 19:08:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B07E6601FA
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 19:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B07E6601FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70F8B6F8BB;
	Fri,  4 Jun 2021 19:08:50 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2088.outbound.protection.outlook.com [40.107.102.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E7046F8BB
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jun 2021 19:08:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ieBWpsxihT5UzEEcXciwnnMWHV1DtFTUpw9HQDOrzb3vErpKj/gVygT/jWlb+jDPYvZY2GIS71hUDLH/LHujy8Kcnd0uwAAYKpIyiziWsaqkRZ7rn27U4zGlIZtiyODqWK3CctvofoiFMF1uxP0kMZIe/SIN/u9ob1+2zZPoPbN6YDAfWrx1Os02f+0nDa5EHEJg66fvb9x+mq7J+es178f91Wy3m2QNBjuFUXDfRORtxxjpHHtAt+lYFUBO6KwLF+iCARpTcbBYroSLmBNpOwshcNZCL1MpdKfb15G+RQlsgM4T51S+BtftZLxDPiYxdCfn3BYhsG1v79OYkXLUdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzHBCIxtXMRw4x4btJYaMu/oFN46t0kugtcDlOeoo1s=;
 b=KNIO3cVh9eP32QLdmjfEbdH3nQhIbG9hwNCOidIvs+AoO9qDIxCfnUBB3rQmfdftxDKY04SRI2LFTTP3ZIrN4ySHyl4dp/R4g5dxdWIl1rNl//6/DvBbWER/tImb33jrMo2QN/WyjeEVkuLe+80WmjGiMEaHNS8C55954Giws7ibDv1RZsIYDFwGk2NNgRPFD18paXLnLiZRVPJC3+FYEvi6KRNNVKbRUg0qC26TbwXyAuTZS+zQxwZAj8sn98bFOP3gUvY9CGUsOulF/ZzeVzQQUHlanuM7MDiOYHkC0yORdiob8tK1zv6cgL91b8lZyutTB3e81bqBrA0S3rJ1zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzHBCIxtXMRw4x4btJYaMu/oFN46t0kugtcDlOeoo1s=;
 b=Fbcxjg7/CUgBIyqOXKCX0VUOi4OuMc0ZE4oZVQIAWvGvrYf+4JVfp2wfYjIXQjvmqK5p1mBz1/VeozyCu/ED68KwPiemYvukzPU6Bbf6Whr7U+pEOLR2m1dEQzPjmP1E1I0g8IjhgLKVpgz4aKOLMGqoIdukcuz5KJJJ06cNruM=
Received: from MWHPR03CA0015.namprd03.prod.outlook.com (2603:10b6:300:117::25)
 by DM5PR1201MB0060.namprd12.prod.outlook.com (2603:10b6:4:51::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.28; Fri, 4 Jun
 2021 19:08:47 +0000
Received: from CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:117:cafe::12) by MWHPR03CA0015.outlook.office365.com
 (2603:10b6:300:117::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend
 Transport; Fri, 4 Jun 2021 19:08:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT025.mail.protection.outlook.com (10.13.175.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Fri, 4 Jun 2021 19:08:46 +0000
Received: from Rohit-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 4 Jun 2021
 14:08:44 -0500
From: Rohit Khaire <rohit.khaire@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alexander Deucher
 <Alexander.Deucher@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, "Emily
 Deng" <Emily.Deng@amd.com>, Monk Liu <Monk.Liu@amd.com>, Peng Ju Zhou
 <PengJu.Zhou@amd.com>, Horace Chen <Horace.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: Modify register access in sdma_v5_2 to use _SOC15
 macros
Date: Fri, 4 Jun 2021 15:08:32 -0400
Message-ID: <20210604190832.1611-1-rohit.khaire@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20f421d8-2048-4235-8643-08d9278c2db1
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0060:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0060E90296B1FB74FCFEAE0E873B9@DM5PR1201MB0060.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nkyxptTj2v174b2waeYQNiKAs/Q5LIqBUHzXjGHLI+6G2DdR49V96QS4snDKXIYGShM5mTh55mYpi/pXDnRqRleA8/oPiKdxhWNbkms0LKt6GwcBhD/tnMZ4WkE40AVUymzl8h+sGPo9u17zXN2EMOl/3JuXAz/PgtqvfyNOTbIFXxvrbi20ZDyGIMxbZo8x47qHBV6P9VOJa4XNfL2I2xckfif4xpmhEwOE5eBbkeJgjYqqqBlO66bSolvGsKndFTBJ8eZrpNiXAHx1q8P+i5zbWeXEnuUa8u6+gfgNChNUiWJmvu2SPQNkFEUhrqVjuUApxZQTfuaNX+6NM+6Duyv+aoyRohHAWb6+pCOdOwQ5iYDk94tpISPhGty0A2wyAt7qwW2GYv1ltaKkON/eAg4lsvUPpWqkUSqnl+vyoOZqAhPOhJ6Q09K85cV9rJCv7Jkb1lF8wBAsJ7yzQxoLg5pEQFuU+raw+nMjJ3GdLuo7TFMRcmZThHwxhQFW9b7LX3R8hGfZDY14L0XZsItxoQEVxFC7nYEMWiN16U6/rso1rzdBfL625pveFkWSx4eeUWWgW4zpr6ggbV2Qq0Y/r6pTajtVS2IOUXNUYjorV6tcXAGy/kX9BFE/IkgRJ3yLt3PgeeTuSQ77P/MLQD0IF4Q5mjkTBSbOfkkbQSlmH+/0ngQyPLQBPt8iQJcDdLivfvUIK87ocaKJsxylCVuC+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(346002)(376002)(36840700001)(46966006)(1076003)(2616005)(8936002)(86362001)(70586007)(2906002)(44832011)(7696005)(30864003)(356005)(6636002)(54906003)(426003)(36756003)(26005)(478600001)(36860700001)(336012)(8676002)(4326008)(16526019)(6666004)(82310400003)(70206006)(186003)(110136005)(81166007)(316002)(47076005)(83380400001)(82740400003)(5660300002)(334744004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 19:08:46.3640 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f421d8-2048-4235-8643-08d9278c2db1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0060
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
Cc: Davis Ming <Davis.Ming@amd.com>, Rohit Khaire <rohit.khaire@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In SRIOV environment, KMD should access SDMA registers
with RLCG if GC indirect access flag enabled.

Using _SOC15 read/write macros ensures that they go
through RLC when the flag is enabled.

Signed-off-by: Rohit Khaire <rohit.khaire@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 70 +++++++++++++-------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 98059bce692f..62bc8bd7f9f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -495,12 +495,12 @@ static void sdma_v5_2_gfx_stop(struct amdgpu_device *adev)
 		amdgpu_ttm_set_buffer_funcs_status(adev, false);
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
-		rb_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
+		rb_cntl = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 0);
-		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
-		ib_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL));
+		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
+		ib_cntl = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL));
 		ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_ENABLE, 0);
-		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL), ib_cntl);
+		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL), ib_cntl);
 	}
 }
 
@@ -558,11 +558,11 @@ static void sdma_v5_2_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
 		f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
 				AUTO_CTXSW_ENABLE, enable ? 1 : 0);
 		if (enable && amdgpu_sdma_phase_quantum) {
-			WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE0_QUANTUM),
+			WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE0_QUANTUM),
 			       phase_quantum);
-			WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE1_QUANTUM),
+			WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE1_QUANTUM),
 			       phase_quantum);
-			WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE2_QUANTUM),
+			WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE2_QUANTUM),
 			       phase_quantum);
 		}
 		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);
@@ -620,62 +620,62 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
 		ring = &adev->sdma.instance[i].ring;
 		wb_offset = (ring->rptr_offs * 4);
 
-		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL), 0);
+		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL), 0);
 
 		/* Set ring buffer size in dwords */
 		rb_bufsz = order_base_2(ring->ring_size / 4);
-		rb_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
+		rb_cntl = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_SIZE, rb_bufsz);
 #ifdef __BIG_ENDIAN
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_SWAP_ENABLE, 1);
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL,
 					RPTR_WRITEBACK_SWAP_ENABLE, 1);
 #endif
-		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
+		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
 
 		/* Initialize the ring buffer's read and write pointers */
-		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR), 0);
-		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_HI), 0);
-		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR), 0);
-		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI), 0);
+		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR), 0);
+		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_HI), 0);
+		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR), 0);
+		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI), 0);
 
 		/* setup the wptr shadow polling */
 		wptr_gpu_addr = adev->wb.gpu_addr + (ring->wptr_offs * 4);
-		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_ADDR_LO),
+		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_ADDR_LO),
 		       lower_32_bits(wptr_gpu_addr));
-		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_ADDR_HI),
+		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_ADDR_HI),
 		       upper_32_bits(wptr_gpu_addr));
-		wptr_poll_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i,
+		wptr_poll_cntl = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i,
 							 mmSDMA0_GFX_RB_WPTR_POLL_CNTL));
 		wptr_poll_cntl = REG_SET_FIELD(wptr_poll_cntl,
 					       SDMA0_GFX_RB_WPTR_POLL_CNTL,
 					       F32_POLL_ENABLE, 1);
-		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_CNTL),
+		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_CNTL),
 		       wptr_poll_cntl);
 
 		/* set the wb address whether it's enabled or not */
-		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_ADDR_HI),
+		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_ADDR_HI),
 		       upper_32_bits(adev->wb.gpu_addr + wb_offset) & 0xFFFFFFFF);
-		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_ADDR_LO),
+		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_ADDR_LO),
 		       lower_32_bits(adev->wb.gpu_addr + wb_offset) & 0xFFFFFFFC);
 
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RPTR_WRITEBACK_ENABLE, 1);
 
-		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_BASE), ring->gpu_addr >> 8);
-		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_BASE_HI), ring->gpu_addr >> 40);
+		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_BASE), ring->gpu_addr >> 8);
+		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_BASE_HI), ring->gpu_addr >> 40);
 
 		ring->wptr = 0;
 
 		/* before programing wptr to a less value, need set minor_ptr_update first */
-		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_MINOR_PTR_UPDATE), 1);
+		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_MINOR_PTR_UPDATE), 1);
 
 		if (!amdgpu_sriov_vf(adev)) { /* only bare-metal use register write for wptr */
 			WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR), lower_32_bits(ring->wptr) << 2);
 			WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI), upper_32_bits(ring->wptr) << 2);
 		}
 
-		doorbell = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL));
-		doorbell_offset = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL_OFFSET));
+		doorbell = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL));
+		doorbell_offset = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL_OFFSET));
 
 		if (ring->use_doorbell) {
 			doorbell = REG_SET_FIELD(doorbell, SDMA0_GFX_DOORBELL, ENABLE, 1);
@@ -684,8 +684,8 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
 		} else {
 			doorbell = REG_SET_FIELD(doorbell, SDMA0_GFX_DOORBELL, ENABLE, 0);
 		}
-		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL), doorbell);
-		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL_OFFSET), doorbell_offset);
+		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL), doorbell);
+		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL_OFFSET), doorbell_offset);
 
 		adev->nbio.funcs->sdma_doorbell_range(adev, i, ring->use_doorbell,
 						      ring->doorbell_index,
@@ -695,7 +695,7 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
 			sdma_v5_2_ring_set_wptr(ring);
 
 		/* set minor_ptr_update to 0 after wptr programed */
-		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_MINOR_PTR_UPDATE), 0);
+		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_MINOR_PTR_UPDATE), 0);
 
 		/* set utc l1 enable flag always to 1 */
 		temp = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
@@ -706,19 +706,19 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
 		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), temp);
 
 		/* Set up RESP_MODE to non-copy addresses */
-		temp = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_CNTL));
+		temp = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_CNTL));
 		temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, RESP_MODE, 3);
 		temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, REDO_DELAY, 9);
-		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_CNTL), temp);
+		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_CNTL), temp);
 
 		/* program default cache read and write policy */
-		temp = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_PAGE));
+		temp = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_PAGE));
 		/* clean read policy and write policy bits */
 		temp &= 0xFF0FFF;
 		temp |= ((CACHE_READ_POLICY_L2__DEFAULT << 12) |
 			 (CACHE_WRITE_POLICY_L2__DEFAULT << 14) |
 			 SDMA0_UTCL1_PAGE__LLC_NOALLOC_MASK);
-		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_PAGE), temp);
+		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_PAGE), temp);
 
 		if (!amdgpu_sriov_vf(adev)) {
 			/* unhalt engine */
@@ -729,15 +729,15 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
 
 		/* enable DMA RB */
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 1);
-		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
+		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
 
-		ib_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL));
+		ib_cntl = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL));
 		ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_ENABLE, 1);
 #ifdef __BIG_ENDIAN
 		ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_SWAP_ENABLE, 1);
 #endif
 		/* enable DMA IBs */
-		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL), ib_cntl);
+		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL), ib_cntl);
 
 		ring->sched.ready = true;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

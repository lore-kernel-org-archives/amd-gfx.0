Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9A0C433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 14:39:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AFD661CE0
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 14:39:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AFD661CE0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17BD96E9A3;
	Mon, 17 May 2021 14:39:31 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B040D6E99B
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 14:39:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvIh7EBjl89BAg11sKDTDPs7cEZ0kvfdoOA+9CS19e/lHBQnovSoNmfyoMZZtYbopvzpCi1c8Y3b/xLotCq4Po6VyhxlXhh3Vaorfve3/TkSjsI2/dymy/CO65AKciC+xsUoBqpDyptu5tdld/hOWNUluRC1nt08AJntszUnIyJBgJgdbBThxYPvBv37VPHmn/OWnBC+PymXVMBp5gvmUpBfNhToAsEvnmh0MCVAJ9ivd4zV0CPXZXA83aXKZQJHwy96H+D96JRpbusLwrvgFLN1xoKG2Dz1+DACmK//xInVogXm76LPKsobC1cs+ecvLwGNCryvCm8UtqKZpyUKZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tu1oixNk5YSkaZ/2tz7J4PPFl0P4PBN7dYqVZRTBDYM=;
 b=G3eg8kjvma9sy3i1kW+ocbGbiVpa6E+wMNdQLotAhLn/4rhpU4rJE7gv5LZncG28xLhJpxs2Aq4rtXVnlgG6iIXGzUTzxnX7N/O+HA56a5WVSvHMF8zOwQf9+Ly5r03pwtdd3J/n3sVaD0xn+yZXj820CM9anPf0eXmb3GgS/qp/HGfkli90sf7OYJ/bxJTbcY5BC0pzTn4HvnJ9PvTrP/c5EVuVsIlLkI26zvN4XYPwwR3vZKjThEh+cmu80DvGfF+F8aykx0NOOE38dxYdWzPSe7gTDnaWqQZEbz9sin3KI34UVAHIUmHvHSphp7DMG+W36hjRVyqiBpRCvWjXnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tu1oixNk5YSkaZ/2tz7J4PPFl0P4PBN7dYqVZRTBDYM=;
 b=DTf5IdEN+d6rKsMmrzEQVu81d8UsQWpYeV/0zTGKL0UzGRC441S2OyfOwfSymrRHU2rh/BB6pdf+Ni07+byPvZF5LkjTxCIkglbvPySqpUyb6cK/N82/tD3dSKNZVwaxaR00mFxkXCF4kPheqJ/yZDOeyrmZoVFE9gv8yPoRgds=
Received: from DS7PR03CA0205.namprd03.prod.outlook.com (2603:10b6:5:3b6::30)
 by MW3PR12MB4474.namprd12.prod.outlook.com (2603:10b6:303:2e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 14:39:24 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::61) by DS7PR03CA0205.outlook.office365.com
 (2603:10b6:5:3b6::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend
 Transport; Mon, 17 May 2021 14:39:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Mon, 17 May 2021 14:39:24 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 17 May
 2021 09:39:23 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Mon, 17 May 2021 09:39:22 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 05/10] drm/amdgpu: Modify GC register access from MMIO to
 RLCG in file sdma_v5*
Date: Mon, 17 May 2021 22:39:05 +0800
Message-ID: <20210517143910.2125-5-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210517143910.2125-1-PengJu.Zhou@amd.com>
References: <20210517143910.2125-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df4ef509-34da-46f1-e79f-08d9194190e2
X-MS-TrafficTypeDiagnostic: MW3PR12MB4474:
X-Microsoft-Antispam-PRVS: <MW3PR12MB447487A4820EB597BA10FEC8F82D9@MW3PR12MB4474.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pnwxacN0LVjuO9vC1ClOYp0OYn/soMNuLZea5LgUJpZGlpQu9MmUqRuZoBoOe6likkT3FrQmL9JLrWdQidEA0sG9AL9Yr3Y94QIbnzOCJs7H6wdzUmD/c3ZSYQ0qFgTHuOdYw6oc5MPhmrsU9Cjzae8fp4rxHHy46N0cKBnpALVUmI41DMzmNWYRaY9WPNB2LKjw+1eGq15gu1SzU4BvzSQ0AmMw12RmZe5sc6IlCINjdIGO28lk5VJns7SzDlejCtjK9aw9F6zuO+snE69HseeV0azNNEv0gviH5/iNU7jnpz7uyfSV4LUKrLSIOPcPAr+PLgcJv1afJq0rSjdJ4DjTJVIlRp0YQPToB1i4ZDyXgxSdWfTfO0Z/Hno8tdGlJiOkkgW0HFG1A7DbuUazgeR2cHelRqh0M2laoEa2ztvXly3mGxQ9hMliFwvB21gkbwTump2IVSdzIyWvrLxOBL+kRHHoEE1VFskC/qakkz8KrDi8yB/4gIXlTDs/vG9KcorGOX2mnNbQJ0yIcJbGujy4mTSIamHINaK5rTkf+LAsPVLN50dUFY8MOESmwNV87dBkDtnxCZNdfC4Zr/IEIWvhPsy6K9EmGr8SW1ZpBafNOtZKENOnTmCEr4WrlhTr1uUJRyhKNXCAItNr3HFJpqI9bmpntNc6/wgCX2YwTrQYGrgKxPlAP/NlVge0dZAU
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39850400004)(396003)(346002)(376002)(136003)(36840700001)(46966006)(83380400001)(70586007)(426003)(47076005)(1076003)(26005)(82310400003)(70206006)(6666004)(336012)(86362001)(316002)(4326008)(356005)(81166007)(2616005)(82740400003)(7696005)(2906002)(36860700001)(8676002)(478600001)(8936002)(6916009)(186003)(5660300002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 14:39:24.3034 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df4ef509-34da-46f1-e79f-08d9194190e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4474
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
index 04c68a79eca4..e5dded824afa 100644
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
@@ -545,12 +545,12 @@ static void sdma_v5_0_gfx_stop(struct amdgpu_device *adev)
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
 
@@ -611,11 +611,11 @@ static void sdma_v5_0_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
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
@@ -682,58 +682,63 @@ static int sdma_v5_0_gfx_resume(struct amdgpu_device *adev)
 
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
@@ -742,8 +747,9 @@ static int sdma_v5_0_gfx_resume(struct amdgpu_device *adev)
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
@@ -752,7 +758,7 @@ static int sdma_v5_0_gfx_resume(struct amdgpu_device *adev)
 			sdma_v5_0_ring_set_wptr(ring);
 
 		/* set minor_ptr_update to 0 after wptr programed */
-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_MINOR_PTR_UPDATE), 0);
+		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_MINOR_PTR_UPDATE), 0);
 
 		if (!amdgpu_sriov_vf(adev)) {
 			/* set utc l1 enable flag always to 1 */
@@ -786,15 +792,15 @@ static int sdma_v5_0_gfx_resume(struct amdgpu_device *adev)
 
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

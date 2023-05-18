Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE569C7EE24
	for <amd-gfx@archiver.kernel.org>; Thu, 18 May 2023 07:04:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B87010E00B;
	Thu, 18 May 2023 07:04:56 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FAD610E00B
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 May 2023 07:04:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKr788de/IdSZkfljCoxLnKzddi5Gvrm1gmE4WRq1Wt6eMujjhzeAb4ubrfC1d1qTkyOiRdGuPvXWnPEx3OTNt0yGXWqRzzRYuNgqA2T2IsIoWq+xVvJuiBpPGXlgz6Qq0MFkGbqPHnZFipTF3MZZ74uWwBawzPwhYBkZBD5TGPa/uiM7Ld3mq6sEYDjVh942Q6yiL124fFy3AlTvSBnzks7Rar4wv33p65N2RydQR8IF8XEQyV8Y3zCKCvcQNEuFhITjiafLrulDw3exR+6tZmxE5FCzWxEr//f9LZpqZmRl4ZvOCA7OpBIzm0AqRBTvFPDW/FbTAUU4FdOnDMP7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRB+B8zmrA4aCPh4mTD0mcp5WDXNnzo0MrZYdYyzH0c=;
 b=gRVQ4HAFhqq9+S7x4TQKl3OXnISD3vfvWWmTdlvQd/UJ7FFCpNv9WsBq3F38csln/FL542QlG73d8pESuzMu+vntJtI6rL/+NUzYC2Vv+3JrPjtx44zZ158SidoJUs64Dys/9AyMJIUhWjI2XDhc7VlOHMun7GUQ5qZOZLRf337MKa9X86Ky1brvy0u+uT9B/jTvhKO/LSATSswEGLTMK2gIkswRC2LLGQNP0iv+DN81TNgF1ToGqUclwoae7CJQffCgK8tyuC4iv7RrTnYIRt8b6B1WnjAavpxjwUD2QlW7MUnaLUdJCattiIARoncdehPLE1Q3pIMOn8e0+We4dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRB+B8zmrA4aCPh4mTD0mcp5WDXNnzo0MrZYdYyzH0c=;
 b=0yg9zOcKwRvnJlj2bq2Xd16bI3QN03n5hMXqbs52sbnPoRHJY7IvPA1OFDx4Y+f5l+sN1qaubKM9QwIB2ddxa6Dg3uLLE3u4nQuabeUF1Xzeu5/YzNQpXWCaGXjnW8jFf34U65fDi1baTHeNJU9CCsqlmw8JbFm3RBe9Y5yZB+4=
Received: from MW4PR04CA0224.namprd04.prod.outlook.com (2603:10b6:303:87::19)
 by LV3PR12MB9185.namprd12.prod.outlook.com (2603:10b6:408:199::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 07:04:51 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::26) by MW4PR04CA0224.outlook.office365.com
 (2603:10b6:303:87::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.18 via Frontend
 Transport; Thu, 18 May 2023 07:04:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.19 via Frontend Transport; Thu, 18 May 2023 07:04:51 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 18 May 2023 02:04:48 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <christian.koenig@amd.com>, <xinhui.pan@amd.com>
Subject: [PATCH 1/3] drm/amdgpu/sdma: set sched.ready status after ring/IB
 test in sdma
Date: Thu, 18 May 2023 15:02:13 +0800
Message-ID: <20230518070215.3556653-2-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230518070215.3556653-1-guchun.chen@amd.com>
References: <20230518070215.3556653-1-guchun.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT045:EE_|LV3PR12MB9185:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d90ed9a-c563-4b7f-095b-08db576e2d09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ve8R3m9sjyJfz9aBul9veuCA1Q+Wl1/sQxkTwOxGWlXAjzuFqIS4CK+EKdf8fQSWnwF1p8wyl2rEt+L+Kbtd+7hBV7lTh3Xj6xldBNNr/hZeKSxEPFnEMQ3RdLr2G9EGYytsWSd7mpMVjijUzyMcUZjJBKopnpu3z99Qw+0+1t1xqBNMYOpad7rPlrRWwcU4rdOIKd9dC2yHU7S9HApmqzJ3t15d4dRp+8TY7fNhiTb/vOK/eaLNR9/ErPaWt2isOiYh6ES6znEdDm4prRwJ9nxEioaAzArjlqbxtP6jHoyRX1RLqDPV/1uKU+nlFIydgsHcO3hMi1HjHNCS3OlI+VbH+YYxx2Ux6g9I5TMdKyqs7uiwijV9uvcn18Exbv04PPPUeA3v+NyhGXCS5W/W1HO4jlVjBXxI+TjcpkX3X0n3TF1q9lyRTTBG7s+6jDZLKVgVkKOH8e/M32iPpHe1cpH6sMv5tGuXkLvX6mJ5ciAYLRU51AQCo1sl6od2TTlmwv4RpBFXUSlnOZ7E5+uJ2IauaypyiCNR+Mh05KXRGmfOBAU45xs4HBIYda3sOYQteo/WiX4siTDH0zs+/rsj1XWDc12eEnk/WoTCkTYu55zpQb008JjbPNw3mZBKaay6aQJuepNWsPjlbTB9L3Z7kG8Ev+U0ZFUH8Iy8hOtdxdry6csfoQke11CoVIt91/cqdOrx05gPy8n95mHDu/h0P9/KltxuAqfmFkoQxFWeaAyaYqgeDF/9RdXk9LBrSPh3v2D0hQ+EDQURjLWkLyD3+u81X5NeBL25fXxzpHSrLQU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199021)(40470700004)(46966006)(36840700001)(7696005)(6666004)(40480700001)(40460700003)(16526019)(186003)(1076003)(26005)(5660300002)(44832011)(82310400005)(86362001)(41300700001)(8676002)(8936002)(6636002)(82740400003)(356005)(4326008)(70586007)(70206006)(316002)(81166007)(336012)(2616005)(426003)(36860700001)(2906002)(36756003)(110136005)(47076005)(478600001)(83380400001)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 07:04:51.5080 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d90ed9a-c563-4b7f-095b-08db576e2d09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9185
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

sched.ready is nothing with ring initialization, it needs to set
to be true after ring/IB test in amdgpu_ring_test_helper to tell
the ring is ready for submission.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c    | 2 --
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   | 2 --
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   | 2 --
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 4 ----
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 4 ----
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 2 --
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   | 6 +-----
 drivers/gpu/drm/amd/amdgpu/si_dma.c      | 2 --
 9 files changed, 3 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index 67d16236b216..52598fbc9b39 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -489,8 +489,6 @@ static int cik_sdma_gfx_resume(struct amdgpu_device *adev)
 #endif
 		/* enable DMA IBs */
 		WREG32(mmSDMA0_GFX_IB_CNTL + sdma_offsets[i], ib_cntl);
-
-		ring->sched.ready = true;
 	}
 
 	cik_sdma_enable(adev, true);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index fd2a7b66ac56..51afc92994a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -466,8 +466,6 @@ static int sdma_v2_4_gfx_resume(struct amdgpu_device *adev)
 #endif
 		/* enable DMA IBs */
 		WREG32(mmSDMA0_GFX_IB_CNTL + sdma_offsets[i], ib_cntl);
-
-		ring->sched.ready = true;
 	}
 
 	sdma_v2_4_enable(adev, true);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index e572389089d2..344202870aeb 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -734,8 +734,6 @@ static int sdma_v3_0_gfx_resume(struct amdgpu_device *adev)
 #endif
 		/* enable DMA IBs */
 		WREG32(mmSDMA0_GFX_IB_CNTL + sdma_offsets[i], ib_cntl);
-
-		ring->sched.ready = true;
 	}
 
 	/* unhalt the MEs */
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 9295ac7edd56..e3581852ed9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1114,8 +1114,6 @@ static void sdma_v4_0_gfx_resume(struct amdgpu_device *adev, unsigned int i)
 #endif
 	/* enable DMA IBs */
 	WREG32_SDMA(i, mmSDMA0_GFX_IB_CNTL, ib_cntl);
-
-	ring->sched.ready = true;
 }
 
 /**
@@ -1202,8 +1200,6 @@ static void sdma_v4_0_page_resume(struct amdgpu_device *adev, unsigned int i)
 #endif
 	/* enable DMA IBs */
 	WREG32_SDMA(i, mmSDMA0_PAGE_IB_CNTL, ib_cntl);
-
-	ring->sched.ready = true;
 }
 
 static void
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 64dcaa2670dd..c3517d9fc38c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -659,8 +659,6 @@ static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i)
 #endif
 	/* enable DMA IBs */
 	WREG32_SDMA(i, regSDMA_GFX_IB_CNTL, ib_cntl);
-
-	ring->sched.ready = true;
 }
 
 /**
@@ -750,8 +748,6 @@ static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned int i)
 #endif
 	/* enable DMA IBs */
 	WREG32_SDMA(i, regSDMA_PAGE_IB_CNTL, ib_cntl);
-
-	ring->sched.ready = true;
 }
 
 static void sdma_v4_4_2_init_pg(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 92e1299be021..e2fe539ff3ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -819,8 +819,6 @@ static int sdma_v5_0_gfx_resume(struct amdgpu_device *adev)
 		/* enable DMA IBs */
 		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL), ib_cntl);
 
-		ring->sched.ready = true;
-
 		if (amdgpu_sriov_vf(adev)) { /* bare-metal sequence doesn't need below to lines */
 			sdma_v5_0_ctx_switch_enable(adev, true);
 			sdma_v5_0_enable(adev, true);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index ca7e8757d78e..23667605c372 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -617,8 +617,6 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
 		/* enable DMA IBs */
 		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL), ib_cntl);
 
-		ring->sched.ready = true;
-
 		if (amdgpu_sriov_vf(adev)) { /* bare-metal sequence doesn't need below to lines */
 			sdma_v5_2_ctx_switch_enable(adev, true);
 			sdma_v5_2_enable(adev, true);
@@ -630,6 +628,8 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
 			return r;
 		}
 
+		ring->sched.ready = true;
+
 		if (adev->mman.buffer_funcs_ring == ring)
 			amdgpu_ttm_set_buffer_funcs_status(adev, true);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 3d9a80511a45..280a878cad68 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -585,16 +585,12 @@ static int sdma_v6_0_gfx_resume(struct amdgpu_device *adev)
 		/* enable DMA IBs */
 		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_IB_CNTL), ib_cntl);
 
-		ring->sched.ready = true;
-
 		if (amdgpu_sriov_vf(adev))
 			sdma_v6_0_enable(adev, true);
 
 		r = amdgpu_ring_test_helper(ring);
-		if (r) {
-			ring->sched.ready = false;
+		if (r)
 			return r;
-		}
 
 		if (adev->mman.buffer_funcs_ring == ring)
 			amdgpu_ttm_set_buffer_funcs_status(adev, true);
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
index abca8b529721..42c4547f32ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
@@ -174,8 +174,6 @@ static int si_dma_start(struct amdgpu_device *adev)
 		WREG32(DMA_RB_WPTR + sdma_offsets[i], ring->wptr << 2);
 		WREG32(DMA_RB_CNTL + sdma_offsets[i], rb_cntl | DMA_RB_ENABLE);
 
-		ring->sched.ready = true;
-
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
 			return r;
-- 
2.25.1


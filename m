Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2098A606A330
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 09:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oYw8MJFc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5481811222A;
	Thu, 26 Nov 2026 09:35:05 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011053.outbound.protection.outlook.com [52.101.57.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0C5A11222A
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 09:34:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xlf+6Sm176Lhb5Q4BjtSe36WZUMAkD5VrjbJMhGQPI6JTbk768vIu7jHtePrnuQvC6Eme9a6+eLkI5BViPwPjLFO0hrtZ2XVN/7B+B0eNXNxgNUC9/RDIcMeXT5YMGj+0bfoY34W79qrCsKmVTjfeIjfwNLCQYYJxNeGEoFExzo4DmxSLOm1jtfiW/rkOMKBPMDSf0WUoGd+vLQ87BFE2g42a2rKBsRYYoGh8R1BlaVIrtW0L+oCEKCQ89KaWsdqXpBqmfYRaqmYBYS21z5okI62eSZ0k3JHpJE1IIaE7UtWwiC+fLAJ5w5Sb0kX/WWMEKPSPjg5V9CzvAO3CdB3bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RiFCbevSdOR8xhCFg4EnBpPY84T6kToMjbFRn1JNfEY=;
 b=vXQcEJQyf8b5U1xoCG3wuVZ2qSXohuQV4lkMsEb4ksnamPOf3TOm62aZuK/f2jIP1/fib2PwFiYbsnLpDPKn1bnlWKZhG8GX1zhB8g4a9aXN9RViV9iZmAYABh37gCwSnr4qStEY3qEGZNLUh3U3W9Yh6M7KXKWQs6OXoSWMRUwlEqwWGHeg2nBDoDSSWT7OFyq5SPaYkzTYiWmBJjK8m0j5g4h6ZjShOnbBYTcB6FkcHitMHTVhV0PfRlvUYcYHJJW2Y8JtPuZJF1zk04+B8/ScSsgGHlRrP0gPHnccgh16Dt4WxgdAB7wO1YCwsaEur1ch/EN8MpsQIvgXE4WKIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RiFCbevSdOR8xhCFg4EnBpPY84T6kToMjbFRn1JNfEY=;
 b=oYw8MJFcFaf2ywUf7NupTCQuCcpJcNgQOMX9wyjt55sJlmauS1CwdYhVRuDkOTt6WI9NUuepvSAvPIRRacqd/4Bb0ZjlYMox5aPE5pLPQTxgvjEkC+8L294EuGneJJYwhvVbFo0Ct3m5r2UB937w09V/D3G5oK3BSV5jYrE7bxE=
Received: from BN0PR03CA0045.namprd03.prod.outlook.com (2603:10b6:408:e7::20)
 by PH9PR12MB498472.namprd12.prod.outlook.com (2603:10b6:510:42c::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 09:34:54 +0000
Received: from BN7PEPF0000009E.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::92) by BN0PR03CA0045.outlook.office365.com
 (2603:10b6:408:e7::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Thu, 26
 Nov 2026 09:34:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF0000009E.mail.protection.outlook.com (10.167.248.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Thu, 26 Nov 2026 09:34:53 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 26 Nov
 2026 03:34:53 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 26 Nov 2026 03:34:51 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <timur.kristof@gmail.com>, <Mario.Novales@amd.com>, 
 <Manu.Rastogi@amd.com>, <Jiongyu.Zhu@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH v5 12/15] drm/amdgpu/gfx11: include SOFT_RESET_GFX in the gfx
 engine soft reset
Date: Thu, 26 Nov 2026 17:33:48 +0800
Message-ID: <20261126093417.192538-12-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261126093417.192538-1-Jesse.Zhang@amd.com>
References: <20261126093417.192538-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF0000009E:EE_|PH9PR12MB498472:EE_
X-MS-Office365-Filtering-Correlation-Id: d56ca197-1cbf-4431-b832-08df4ba086cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|6133799003|261009223027099003|22082099003|18002099003|3023799007|11063799006|10067099003|56012099006|261102123227099003|261026140227099003|261028144727099003|261026121527099003|261021123027099003|261022105027099003|261021121427099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: v5RPZV0T748zOOPiI+3PTi+qjzjwnge/o07f9WhU5QU5feNrc6MAaH7lZDZToz4cAWEp5/5DNm35cSvdtKMEZY2phWjbXKyqAG2oDWEVgOHX0bScyCZ9K9oE8VhkzAw64Bj7ZAqDCwXONvgFQNm9qP1CsQqNNagRxsKMCt+64/u1uvdDFNCEhqSCtWeo2ViHy1hcP2nOQgmAoatQiBXpTJsw7lP5nhiTG7QWnwjtRgxiSTEXHbj03xrtyzAgs7On2P6YyBPhUoZW9/PIxYBZYW+aUxQqd4aoyMwprnspVHnmj5wVMPUIQKhvCL4OQBXJ98nZF7vug12mAFCGhGeNpdUMxiXB+ElJ2U+NB5BlCmYqqXRCcALe+SK7YHX2S9M/uJSXb9CjvY0UQec9ON8zjLrMh7xB11aHv1Pzxk9mJNSj997bITceUdrviWyLN8VoxenTRGGPVfVWXWR01alvGKeUfZAp8/Ur1dwQIBjGDKrJxQx4qQYYEWe0ty3sEfE3LH+itNVyssyQQRDukJAXcK8/dRsbmLGwHucXpeLfXC5w85WJOhO463RioOSJ2XCf59v99vNv86slm7vg30mIyICqr/GLUwaYgrMVcJ4wCDd3VTJe+bVafKhlltmM7OJCWIolU0X6h8j7i4hMUlYLsP2zvMSIuErpW0cg3k63dHXZkGo5SVTXaJqdyKauMDnDkEKUPlKaSqnHRm+UY1BY/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(6133799003)(261009223027099003)(22082099003)(18002099003)(3023799007)(11063799006)(10067099003)(56012099006)(261102123227099003)(261026140227099003)(261028144727099003)(261026121527099003)(261021123027099003)(261022105027099003)(261021121427099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DwZXEDLTWoTiTwrklKe9bP+72NXteiTlMdjsviFrkeUPeIIbmXLmjVqL1An93NPoeLEKoJTUQJuZiq5VHlp+1OPw/oPfoH2+c4BoHIZrI5/C6TCEEzwFkv5si9rzBzRm+mwi59Bh1RifIEDpLb8wkEb5x/xA0uXUkoF2OCIPxniM9x2W/XS9OpzUP9Xld3t8w0We47pLE6aA71rJ0IFJZ+0xNzgQSBhE/BvM6u8P5YzAJwYO01hsmezpcvhy+jOLbzD3XzrtTIdYIj7TR5RcQJhyO3yIJflMr6l9Wr1QksLAYLOYtbxRLc3zmBIc1mLV5vGDAiUKKov0w4r+UxKKjRUc1sYU7TkMgugfl6lKT6ZKDJl6edpvsaO8ju5qaals15c3lQ4/MkPcVUKf7vyRWmhoJ+jR1YmUQzqu/Lc7Ni103FJFIFpy08sXVf7aSa1M
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 09:34:53.7943 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d56ca197-1cbf-4431-b832-08df4ba086cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF0000009E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR12MB498472
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

As on gfx12, pulse SOFT_RESET_GFX with CPF/CPG in the gfx engine reset,
with MES and RLC F32 halted and the GC drained, so that it recovers hangs
of the fixed-function pipeline too.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 95 ++++++++++++++++++++++----
 1 file changed, 83 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index a0ed3363f84d..824d7914bece 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6827,15 +6827,74 @@ static void gfx_v11_0_emit_mem_sync(struct amdgpu_ring *ring)
 				 CP_STAT__UTCL2IU_BUSY_MASK)
 
 /* Reset CPF/CPG, PFP/ME and the gfx HQDs, then boot PFP/ME again. */
+/*
+ * SOFT_RESET_GFX drops the memory requests in flight through the blocks it
+ * resets, and their clients then wait for them forever: MES still fetches
+ * instructions with its queues suspended, and RLC still writes its DRAM log
+ * in safe mode. The reset halts both, then waits for these busy bits of the
+ * GC memory interfaces to clear.
+ */
+#define GFX11_GC_MEM_BUSY	(GRBM_STATUS2__EA_BUSY_MASK | \
+				 GRBM_STATUS2__EA_LINK_BUSY_MASK | \
+				 GRBM_STATUS2__UTCL2_BUSY_MASK | \
+				 GRBM_STATUS2__UTCL2_RQ_PENDING_MASK | \
+				 GRBM_STATUS2__TCP_BUSY_MASK | \
+				 GRBM_STATUS2__CPC_BUSY_MASK | \
+				 GRBM_STATUS2__RLC_BUSY_MASK | \
+				 GRBM_STATUS2__RLC_RQ_PENDING_MASK | \
+				 GRBM_STATUS2__SDMA_BUSY_MASK | \
+				 GRBM_STATUS2__SDMA_SCH_RQ_PENDING_MASK | \
+				 GRBM_STATUS2__SDMA0_RQ_PENDING_MASK | \
+				 GRBM_STATUS2__SDMA1_RQ_PENDING_MASK)
+
+/* The RLC busy bits of its memory requests */
+#define GFX11_RLC_MEM_BUSY	(RLC_STAT__MC_BUSY_MASK | \
+				 RLC_STAT__RLC_SRM_BUSY_MASK | \
+				 RLC_STAT__RLC_SPM_BUSY_MASK)
+
+/* Wait for the requests in flight in the GC, with MES and RLC F32 halted. */
+static int gfx_v11_0_wait_gc_idle(struct amdgpu_device *adev)
+{
+	u32 busy, cpc, rlc;
+	int i;
+
+	for (i = 0; i < adev->usec_timeout; i++) {
+		busy = RREG32_SOC15(GC, 0, regGRBM_STATUS2) & GFX11_GC_MEM_BUSY;
+		cpc = RREG32_SOC15(GC, 0, regCP_CPC_STATUS);
+		rlc = RREG32_SOC15(GC, 0, regRLC_STAT);
+
+		/* The halted MES and F32 can stay busy, not their memory requests. */
+		if (!(cpc & GENMASK(21, 0) & ~CP_CPC_STATUS__MES_BUSY_MASK))
+			busy &= ~GRBM_STATUS2__CPC_BUSY_MASK;
+		if (!(rlc & GFX11_RLC_MEM_BUSY))
+			busy &= ~GRBM_STATUS2__RLC_BUSY_MASK;
+
+		if (!busy && !(RREG32_SOC15(GC, 0, regGCVM_L2_STATUS) &
+			       GCVM_L2_STATUS__L2_BUSY_MASK))
+			return 0;
+		udelay(1);
+	}
+
+	dev_err(adev->dev, "GC still busy, GRBM_STATUS2 0x%08x CPC 0x%08x RLC 0x%08x\n",
+		RREG32_SOC15(GC, 0, regGRBM_STATUS2), cpc, rlc);
+	return -ETIMEDOUT;
+}
+
 static int gfx_v11_0_soft_reset_gfx_cp(struct amdgpu_device *adev)
 {
-	u32 tmp, cntl, me_cntl;
-	int i;
+	u32 tmp, cntl, me_cntl, mes_cntl, rlc_cntl;
+	int i, r = 0;
 
 	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 	/* MES fetches its queues through CPF: keep it out of the reset. */
 	amdgpu_mes_lock(&adev->mes);
 
+	/* SOFT_RESET_GFX needs the GC quiet: halt MES and RLC F32. */
+	mes_cntl = RREG32_SOC15(GC, 0, regCP_MES_CNTL);
+	WREG32_SOC15(GC, 0, regCP_MES_CNTL, mes_cntl | CP_MES_CNTL__MES_HALT_MASK);
+	rlc_cntl = RREG32_SOC15(GC, 0, regRLC_CNTL);
+	adev->gfx.rlc.funcs->stop(adev);
+
 	me_cntl = RREG32_SOC15(GC, 0, regCP_ME_CNTL);
 
 	tmp = REG_SET_FIELD(me_cntl, CP_ME_CNTL, ME_HALT, 1);
@@ -6856,16 +6915,21 @@ static int gfx_v11_0_soft_reset_gfx_cp(struct amdgpu_device *adev)
 	tmp = REG_SET_FIELD(tmp, CP_SOFT_RESET_CNTL, GFX_HQD_REG_RESET, 1);
 	WREG32_SOC15(GC, 0, regCP_SOFT_RESET_CNTL, tmp);
 
-	tmp = RREG32_SOC15(GC, 0, regGRBM_SOFT_RESET);
-	tmp = REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPF, 1);
-	tmp = REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPG, 1);
-	WREG32_SOC15(GC, 0, regGRBM_SOFT_RESET, tmp);
-	tmp = RREG32_SOC15(GC, 0, regGRBM_SOFT_RESET);
-	udelay(50);
-	tmp = REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPF, 0);
-	tmp = REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPG, 0);
-	WREG32_SOC15(GC, 0, regGRBM_SOFT_RESET, tmp);
-	tmp = RREG32_SOC15(GC, 0, regGRBM_SOFT_RESET);
+	r = gfx_v11_0_wait_gc_idle(adev);
+	if (!r) {
+		tmp = RREG32_SOC15(GC, 0, regGRBM_SOFT_RESET);
+		tmp = REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPF, 1);
+		tmp = REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPG, 1);
+		tmp = REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_GFX, 1);
+		WREG32_SOC15(GC, 0, regGRBM_SOFT_RESET, tmp);
+		tmp = RREG32_SOC15(GC, 0, regGRBM_SOFT_RESET);
+		udelay(50);
+		tmp = REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPF, 0);
+		tmp = REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPG, 0);
+		tmp = REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_GFX, 0);
+		WREG32_SOC15(GC, 0, regGRBM_SOFT_RESET, tmp);
+		tmp = RREG32_SOC15(GC, 0, regGRBM_SOFT_RESET);
+	}
 
 	WREG32_SOC15(GC, 0, regCP_SOFT_RESET_CNTL, cntl);
 
@@ -6877,7 +6941,14 @@ static int gfx_v11_0_soft_reset_gfx_cp(struct amdgpu_device *adev)
 	}
 	/* A VMID reset the hung PFP didn't handle survives the reset. */
 	WREG32_SOC15(GC, 0, regCP_VMID_RESET, 0);
+	WREG32_SOC15(GC, 0, regRLC_CNTL, rlc_cntl);
+	WREG32_SOC15(GC, 0, regCP_MES_CNTL, mes_cntl);
 	amdgpu_mes_unlock(&adev->mes);
+	if (r) {
+		/* PFP/ME stay halted: a full reset follows. */
+		amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+		return r;
+	}
 
 	tmp = RREG32_SOC15(GC, 0, regCP_ME_CNTL);
 	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, CE_HALT,
-- 
2.50.1


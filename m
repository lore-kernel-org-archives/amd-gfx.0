Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80F8606A32C
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 09:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=iwLKSyat
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4FDA1121E3;
	Thu, 26 Nov 2026 09:35:04 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010037.outbound.protection.outlook.com
 [40.93.198.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 648CD11222C
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 09:34:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YjDWZM1nSFRgFIPqlj1TDOdlIRscUwy+g2DX23aL9n6Z/eKunCCsiJyFC/ufqi15N1s0GoIxt3Ms/EngRL9iPClPghntalNMQNPsPvc4LtU9ge6bi0wdxFdoVsGhoJKL+IHyAj0EWbvGcqDs0OmqMFgVjoJsSaIkr1U9STu1vGRRNFbCNVwvmlg21d0IPzAh0hfm8V+AsXOvoG+7nDBDMsAmawB62KTZqsCc9gimqF+QjzxZRKBo1UlPm/85eW6vSeXa8Yy1H17dlsP4miPWJtygoEN80aI8w3u5vHIqjVOnqE4f6OZQWGcgYpyoiQ51/qWtHdblHCvINsc+DomnLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bw7/XIBFdABLTVHShAqFo+bVmGVzvw+MxJvi4YupCbE=;
 b=C20Qper6bZ+OYQYPwCYpBGnsOh8Sr26BWFVVSeaCXwDLWgck3tY36uuy4jFT+VHxxkACk+fBSeRpzzwv+AF2Inr3haUPmL9LWFyU9ebMyEAnYnb7iPixBZX9fVKuivAwuk8NKzaaPp1coQ5e/VfSZ73zbDncvakxtAcosnZCWwFBBrB5Ys867KgpI/9Rp9TA5nrD2nZMlRhzYAJaMtZVQMN9YMtpjK1CPNCE/JM7ZfIq6AGNX2fmbPbIj9QE7eAiq3vlXDTNK3qcyrXFMsgVb1XQRfb1nc5jHos7iAMFlkU6C6fkboXqWmSJTDpxg1umXZagjLJUUWgXNpqh4v6tYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bw7/XIBFdABLTVHShAqFo+bVmGVzvw+MxJvi4YupCbE=;
 b=iwLKSyatyKMco8JyeGKrHmU6UaQuPQ3eKPOR7Up8HVL66l7mrBPbQV/rOMGiSBwupynaChiRt1VL2NJ4TNBg+j8WpXFoilSqwEFVmrRzA3Uzgx0wjKlxSFAb64tCq44SjofF4r4E/MEtQIj3uI7sCEuqmC+eR5MksPkq7kUBEBA=
Received: from BL1PR13CA0107.namprd13.prod.outlook.com (2603:10b6:208:2b9::22)
 by DS7PR12MB5839.namprd12.prod.outlook.com (2603:10b6:8:7a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 09:34:51 +0000
Received: from BN7PEPF0000009F.namprd04.prod.outlook.com
 (2603:10b6:208:2b9:cafe::62) by BL1PR13CA0107.outlook.office365.com
 (2603:10b6:208:2b9::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.688.4 via Frontend Transport; Thu, 26
 Nov 2026 09:34:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF0000009F.mail.protection.outlook.com (10.167.248.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Thu, 26 Nov 2026 09:34:51 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 26 Nov
 2026 03:34:50 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 26 Nov 2026 03:34:48 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <timur.kristof@gmail.com>, <Mario.Novales@amd.com>, 
 <Manu.Rastogi@amd.com>, <Jiongyu.Zhu@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH v5 11/15] drm/amdgpu/gfx12: include SOFT_RESET_GFX in the gfx
 engine soft reset
Date: Thu, 26 Nov 2026 17:33:47 +0800
Message-ID: <20261126093417.192538-11-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261126093417.192538-1-Jesse.Zhang@amd.com>
References: <20261126093417.192538-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF0000009F:EE_|DS7PR12MB5839:EE_
X-MS-Office365-Filtering-Correlation-Id: 751783a7-b8fc-4b76-d1b5-08df4ba08539
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|261009223027099003|22082099003|18002099003|3023799007|11063799006|10067099003|56012099006|261102123227099003|261026140227099003|261028144727099003|261026121527099003|261021123027099003|261022105027099003|261021121427099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: GCvtCHE+Q2AwmX1tyNUxjIYQCsDZxT87r9KfYTK2HisEROn5W++fP2Nb9sNFaDReFu9aprYqKc8QWYpHSHBU6K508g5cDN4rHZhfWdvNA97B0UDGIDNLN2BnII+hyxLcUlhVrV/bKSMxXt7rqzG5wbEwmypaNlS1kOPsBfQIg5qs77gX07LNzPnsKh5xFRDgjbwv7ZZ4nxF35ZDtRRh/5vULS873cIT4ILeDfkHIQX/W7GZZfHX01ZUKnPCEXKqvMp1YN9G132Q9koL1QWQ4JBAMoYvaMesNa8RNslibVxTTBafAjeIs5a4ga+QV/2rPsHcfsT0BnObasOyvTkudgtewHp9zmaMqzGQj14f8aT4tJDNmpIgRHSekk4iEMI5gUx/Dig2zQ7g+p0Vkm7arQ1RIaHPWa249+Nq4LaqR3Z8LEgM6Y5H0RscfPvNygfZ/JZ3ZDsXkqAlwxkggW4BIGaPMtx54tZdHb/b53Cdb8+8LZr+FiPdIHEz4I13XNIRONNXn9mMy0TEKk35nh6WZiJ4EsxpZz/h/48du9PQZalhqa7lW9iYBdY5pc3ZbwtCZLmakR0xg3bow2zKKg76TozIy3XcY5j3+pnFIjYl/LXP9bdNSlY0jBkwFRRcZYhOV70taFPe7HKCNh20/5umkF3G1enuQybCZfZUbZy8AFtqn6CZz3KPssxwXjWULGu4J1mIXNEn34Y3s/0f4fWWMbg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(261009223027099003)(22082099003)(18002099003)(3023799007)(11063799006)(10067099003)(56012099006)(261102123227099003)(261026140227099003)(261028144727099003)(261026121527099003)(261021123027099003)(261022105027099003)(261021121427099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2o5AR65TC4vGSfFE1+qmkufOyu+O114Y1KCDa7gNDnx+rKnnpczEeh8/Lkp9y4SEJ9qrmb/ivwI14N6wCnzDqdm3MVv4JXtfo4bX02rtlH89II4jXE0prKvGYKC5h/SRLO6ckxC4z+Ztw8RMaIZOW5ZWQB1txjJv8nsfMwst+DolRX36XKnDEcQvY5avLvsQxe9lx72K7ubDvV3owkPFW7Yn7MYroVtgHPJFdfxuhsTXJ9TxPUrStBiXebn05hM8pIgjT6hYxM/nZgfC5vQ98ncSJU3VIhwKvvqQsl+AHP2T55XPfPFdEKbBbnrDTJzHUqu9FW48M7wlqzQToHU6EVHn2vOwHBsxq0/KR0XpsglhQ96bEMOmL1VZBw7BfcSv9hbMz7TPUaXYpnEc1HkdpdBxXNZfXwRqg8vOcXbdVIc5uOaV854qCft2VOAFqYMv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 09:34:51.1525 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 751783a7-b8fc-4b76-d1b5-08df4ba08539
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF0000009F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5839
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

The gfx engine reset only pulses CPF/CPG, which leaves hangs of the
fixed-function pipeline to a full reset. Pulse SOFT_RESET_GFX too.

SOFT_RESET_GFX drops the memory requests in flight through the blocks it
resets, and their clients then wait for them forever: pulsed while RLC
writes its DRAM log, which it still does in safe mode, RLC stays MC_BUSY
and the next TLB invalidation of MES never completes; pulsed while MES
fetches instructions, which it still does with its queues suspended, its
next queue operation times out. Halt MES and RLC F32 across the reset and
wait for the GC memory interfaces to drain before the pulse. A halted MES
or F32 can stay busy, as long as it has no memory request in flight. If
the GC doesn't drain, skip the pulse and fail the reset, so a full reset
follows.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 100 +++++++++++++++++++++----
 1 file changed, 87 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 69bdae805597..8485d1aabf3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3874,16 +3874,78 @@ static int gfx_v12_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 				 CP_STAT__RCIU_BUSY_MASK | \
 				 CP_STAT__UTCL2IU_BUSY_MASK)
 
-/* Reset CPF/CPG, PFP/ME and the gfx HQDs, then boot PFP/ME again. */
+/*
+ * SOFT_RESET_GFX drops the memory requests in flight through the blocks it
+ * resets, and their clients then wait for them forever: MES still fetches
+ * instructions with its queues suspended, and RLC still writes its DRAM log
+ * in safe mode. The reset halts both, then waits for these busy bits of the
+ * GC memory interfaces to clear.
+ */
+#define GFX12_GC_MEM_BUSY	(GRBM_STATUS2__EA_BUSY_MASK | \
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
+#define GFX12_RLC_MEM_BUSY	(RLC_STAT__MC_BUSY_MASK | \
+				 RLC_STAT__RLC_SRM_BUSY_MASK | \
+				 RLC_STAT__RLC_SPM_BUSY_MASK)
+
+/* Wait for the requests in flight in the GC, with MES and RLC F32 halted. */
+static int gfx_v12_0_wait_gc_idle(struct amdgpu_device *adev)
+{
+	u32 busy, cpc, rlc;
+	int i;
+
+	for (i = 0; i < adev->usec_timeout; i++) {
+		busy = RREG32_SOC15(GC, 0, regGRBM_STATUS2) & GFX12_GC_MEM_BUSY;
+		cpc = RREG32_SOC15(GC, 0, regCP_CPC_STATUS);
+		rlc = RREG32_SOC15(GC, 0, regRLC_STAT);
+
+		/* The halted MES and F32 can stay busy, not their memory requests. */
+		if (!(cpc & GENMASK(21, 0) & ~CP_CPC_STATUS__MES_BUSY_MASK))
+			busy &= ~GRBM_STATUS2__CPC_BUSY_MASK;
+		if (!(rlc & GFX12_RLC_MEM_BUSY))
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
+/*
+ * Reset CPF/CPG, PFP/ME, the gfx HQDs and the fixed-function pipeline,
+ * then boot PFP/ME again.
+ */
 static int gfx_v12_0_soft_reset_gfx_cp(struct amdgpu_device *adev)
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
@@ -3907,16 +3969,21 @@ static int gfx_v12_0_soft_reset_gfx_cp(struct amdgpu_device *adev)
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
+	r = gfx_v12_0_wait_gc_idle(adev);
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
 
@@ -3928,7 +3995,14 @@ static int gfx_v12_0_soft_reset_gfx_cp(struct amdgpu_device *adev)
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
 
 	gfx_v12_0_set_pfp_ucode_start_addr(adev);
 	gfx_v12_0_set_me_ucode_start_addr(adev);
-- 
2.50.1


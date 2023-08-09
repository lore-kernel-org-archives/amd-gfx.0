Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BCE0EB64DD
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 08:31:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D593010E3FC;
	Wed,  9 Aug 2023 08:31:40 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDA9F10E3FC
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 08:31:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ey/AgmJ7caSfHYu0+5LYOW7G+ROoZxyXSNzfwrVGa2AkfHfJY2PYGkybxdXu6zNATqX3zY0mgGA8EsDFfbpU82YBPB2M6tOai/xag51TRFAnOCT74zHAGV4lfG/vIoRZLCuHFNSuSjGseLY5g6FJcwgSp35AG8ruBVFnNJt2YrBN6kMk5COw+Du5I2YLOf3tx85XK2NSTeVA3C3rHQhQvUwEYsrYJbHnk1zSamYTvYkYCJgFavEcjeHohzdGQ6cKIDWs+aUg/Vz81lvDOvJsuX34SfuJeDhUERHcO1mOqLgc23cuExYK0uPrIqWE/ms0VXu51GVXIjfaIrFLuiK65w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zuqzgx6scq4DGhpVk3Xs/bTPiLW2AYub60eqYlnGAKQ=;
 b=P4aeCoNOIjCurIXt0uNMg1hBsz8K6PxeUuADFdteyp1+Y1BhRwpmM37mCnlOXU7fG+UlfXZb2OCOkI3nfOYWFfguvClkqw4jh7VTc1Tl3SJHPyy+4LanbRsSQAMO7Ox3Zz8duksQaYOCaARgOAl4kZ4s7QO5Jc+Yv+lDRjt1w+1WujXSVLMgm1DT7tmc8ESnuV/WHvleGj0lVGoph2ID3yAr2aNXrriAnm+bucIQLqC5gPWY8BecCxtIUZVd1w8s04tyd9cTC8+py8kfJ8LwmO1PXkNPKYV9aWqKLU9fk9DGvl/lu/yNEPeujw9G0X6G361wxCPeMesA/bj1fMUT+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zuqzgx6scq4DGhpVk3Xs/bTPiLW2AYub60eqYlnGAKQ=;
 b=eRhU9ZY5VlVphp+24WUA2u+2BkfKHUDwxfE2VG1C+9z13gVqO1KXgkoXeGZTQQnFqQVsmuIKcxWKtHtbmPuTsCJeDVZ0ajSzyMO4GKwv0yYEPRnG0Hz+zl8l8uRU7SXd9UqYrJ4QKcbYDuA49sbfCc+2cVk6Y8bLMpz/JHQ2JdQ=
Received: from MW4PR04CA0227.namprd04.prod.outlook.com (2603:10b6:303:87::22)
 by DM4PR12MB8569.namprd12.prod.outlook.com (2603:10b6:8:18a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Wed, 9 Aug
 2023 08:31:37 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:303:87:cafe::26) by MW4PR04CA0227.outlook.office365.com
 (2603:10b6:303:87::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Wed, 9 Aug 2023 08:31:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 9 Aug 2023 08:31:36 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 03:30:46 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Add pci usage to nbio v7.9
Date: Wed, 9 Aug 2023 16:30:23 +0800
Message-ID: <20230809083023.427025-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230809083023.427025-1-asad.kamal@amd.com>
References: <20230809083023.427025-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|DM4PR12MB8569:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fd03f1d-fc54-435e-0ae1-08db98b30bcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1apMvg8/GrKClalVkpimvv01yu4oiopZSMNAZRjqc6lXh2gAEF2wLlN14r3llrOY8Af27C8FwU1GViZy0AJ3rbnehXg9XXnmCQLrgCMbx62yRtCkCPLQVKjf3rUiqStk36sdFOFJUiIS6jphwZQa0wES6EAgVWvb3rk7eO6dSL8ydxcSItHRGLiLgGtqJU8RoIFoHs5NQc3npxi7iP0tllMRBFqYIUw+dvsGTd8EtY4c1oVP9FOmqNJsl5IYwd/z3ihUF0W2VlsDpjKaaZkNPpAjym8LFroiFK+tJXu/loqFS6abRISCKxUMH0P82o32SkKBSjDhL6UBzyTI0tcZiIxLuW2D07fuDXwZLAZ5CEj/WdXfSmo3Fcg0oVpc+Kll8Al9mTaaber7cKkNfpOaIEJyTERK8tN+GZ+P/lNNs9i1wrwgICfMCN76WT2U+zf2GpT71Wfuf3Aba+JMzL6FG8mB0Vc9AUBBD8M6w/UwEUcJUPKLoKmjzbhBbMMCCfm6vYKh/U9HPbAl6c6HbVNeuCK91WWjgs3DpbM4nbKGTlsPOcq0s0fofWyuBBvvxJ5FoSnr4gUaV9V3IX1bgGxOG0oJXoZcq3JPYoUZBqL+ScMBtM0kTouMx8rxIumL3NoOYEtwMuwzJFSVkdzSnr9T8zcxpEGEfvp2hWMNDcD3g+joSA+yFlHl7FGT9FNkcyxmNHUqTRX6cf0e7ufN7CTdjNHGWCiMgKGvBodyrWfXBo+2i0dMlIYOC2qR5qsTBqnWTc+OddHeCUYpF6B8ZlgQig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(186006)(1800799006)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(2906002)(8676002)(8936002)(316002)(36756003)(7696005)(26005)(86362001)(6666004)(478600001)(41300700001)(5660300002)(40480700001)(4326008)(40460700003)(6916009)(44832011)(83380400001)(47076005)(36860700001)(54906003)(356005)(426003)(70206006)(70586007)(1076003)(336012)(16526019)(82740400003)(2616005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 08:31:36.6049 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd03f1d-fc54-435e-0ae1-08db98b30bcd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8569
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
Cc: Lijo Lazar <lijo.lazar@amd.com>, Shiwu Zhang <shiwu.zhang@amd.com>,
 asad.kamal@amd.com, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add implementation to get pcie usage for nbio v7.9.

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Shiwu Zhang <shiwu.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c        | 63 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/soc15.c            |  2 +-
 .../asic_reg/nbio/nbio_7_9_0_sh_mask.h        |  8 +++
 3 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index cd1a02d30420..77c9625dfb8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -32,6 +32,15 @@
 
 #define NPS_MODE_MASK 0x000000FFL
 
+#define smnPCIE_PERF_CNTL_TXCLK3		0x1A38021c
+#define smnPCIE_PERF_CNTL_TXCLK7		0x1A380888
+#define smnPCIE_PERF_COUNT_CNTL			0x1A380200
+#define smnPCIE_PERF_COUNT0_TXCLK3		0x1A380220
+#define smnPCIE_PERF_COUNT0_TXCLK7		0x1A38088C
+#define smnPCIE_PERF_COUNT0_UPVAL_TXCLK3	0x1A3808F8
+#define smnPCIE_PERF_COUNT0_UPVAL_TXCLK7	0x1A380918
+
+
 static void nbio_v7_9_remap_hdp_registers(struct amdgpu_device *adev)
 {
 	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
@@ -427,6 +436,59 @@ static void nbio_v7_9_init_registers(struct amdgpu_device *adev)
 	}
 }
 
+static void nbio_v7_9_get_pcie_usage(struct amdgpu_device *adev, uint64_t *count0,
+				     uint64_t *count1)
+{
+	uint32_t perfctrrx = 0;
+	uint32_t perfctrtx = 0;
+
+	/* This reports 0 on APUs, so return to avoid writing/reading registers
+	 * that may or may not be different from their GPU counterparts
+	 */
+	if (adev->flags & AMD_IS_APU)
+		return;
+
+	/* Use TXCLK3 counter group for rx event */
+	/* Use TXCLK7 counter group for tx event */
+	/* Set the 2 events that we wish to watch, defined above */
+	/* 40 is event# for received msgs */
+	/* 2 is event# of posted requests sent */
+	perfctrrx = REG_SET_FIELD(perfctrrx, PCIE_PERF_CNTL_TXCLK3, EVENT0_SEL, 40);
+	perfctrtx = REG_SET_FIELD(perfctrtx, PCIE_PERF_CNTL_TXCLK7, EVENT0_SEL, 2);
+
+	/* Write to enable desired perf counters */
+	WREG32_PCIE(smnPCIE_PERF_CNTL_TXCLK3, perfctrrx);
+	WREG32_PCIE(smnPCIE_PERF_CNTL_TXCLK7, perfctrtx);
+
+	/* Zero out and enable SHADOW_WR
+	 * Write 0x6:
+	 * Bit 1 = Global Shadow wr(1)
+	 * Bit 2 = Global counter reset enable(1)
+	 */
+	WREG32_PCIE(smnPCIE_PERF_COUNT_CNTL, 0x00000006);
+
+	/* Enable Gloabl Counter
+	 * Write 0x1:
+	 * Bit 0 = Global Counter Enable(1)
+	 */
+	WREG32_PCIE(smnPCIE_PERF_COUNT_CNTL, 0x00000001);
+
+	msleep(1000);
+
+	/* Disable Global Counter, Reset and enable SHADOW_WR
+	 * Write 0x6:
+	 * Bit 1 = Global Shadow wr(1)
+	 * Bit 2 = Global counter reset enable(1)
+	 */
+	WREG32_PCIE(smnPCIE_PERF_COUNT_CNTL, 0x00000006);
+
+	/* Get the upper and lower count  */
+	*count0 = RREG32_PCIE(smnPCIE_PERF_COUNT0_TXCLK3) |
+		  ((uint64_t)RREG32_PCIE(smnPCIE_PERF_COUNT0_UPVAL_TXCLK3) << 32);
+	*count1 = RREG32_PCIE(smnPCIE_PERF_COUNT0_TXCLK7) |
+		  ((uint64_t)RREG32_PCIE(smnPCIE_PERF_COUNT0_UPVAL_TXCLK7) << 32);
+}
+
 const struct amdgpu_nbio_funcs nbio_v7_9_funcs = {
 	.get_hdp_flush_req_offset = nbio_v7_9_get_hdp_flush_req_offset,
 	.get_hdp_flush_done_offset = nbio_v7_9_get_hdp_flush_done_offset,
@@ -450,4 +512,5 @@ const struct amdgpu_nbio_funcs nbio_v7_9_funcs = {
 	.get_compute_partition_mode = nbio_v7_9_get_compute_partition_mode,
 	.get_memory_partition_mode = nbio_v7_9_get_memory_partition_mode,
 	.init_registers = nbio_v7_9_init_registers,
+	.get_pcie_usage = nbio_v7_9_get_pcie_usage,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index afcaeadda4c7..4b8dce091bcd 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -893,7 +893,7 @@ static const struct amdgpu_asic_funcs aqua_vanjaram_asic_funcs =
 	.get_config_memsize = &soc15_get_config_memsize,
 	.need_full_reset = &soc15_need_full_reset,
 	.init_doorbell_index = &aqua_vanjaram_doorbell_index_init,
-	.get_pcie_usage = &vega20_get_pcie_usage,
+	.get_pcie_usage = &amdgpu_nbio_get_pcie_usage,
 	.need_reset_on_init = &soc15_need_reset_on_init,
 	.get_pcie_replay_count = &soc15_get_pcie_replay_count,
 	.supports_baco = &soc15_supports_baco,
diff --git a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_9_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_9_0_sh_mask.h
index a22481e7bcdb..e0c28c29ddb0 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_9_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_9_0_sh_mask.h
@@ -38896,5 +38896,13 @@
 #define RCC_DEV0_EPF0_VF7_GFXMSIX_PBA__MSIX_PENDING_BITS_0_MASK                                               0x00000001L
 #define RCC_DEV0_EPF0_VF7_GFXMSIX_PBA__MSIX_PENDING_BITS_1_MASK                                               0x00000002L
 
+//PCIE_PERF_CNTL_TXCLK3
+#define PCIE_PERF_CNTL_TXCLK3__EVENT0_SEL__SHIFT							      0x0
+#define PCIE_PERF_CNTL_TXCLK3__EVENT0_SEL_MASK								      0x000000FFL
+
+//PCIE_PERF_CNTL_TXCLK7
+#define PCIE_PERF_CNTL_TXCLK7__EVENT0_SEL__SHIFT							      0x0
+#define PCIE_PERF_CNTL_TXCLK7__EVENT0_SEL_MASK								      0x000000FFL
+
 
 #endif
-- 
2.34.1


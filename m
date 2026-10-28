Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23AF606A32A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 17:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3Dvwo8C9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5027510E6C6;
	Wed, 28 Oct 2026 17:05:57 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012030.outbound.protection.outlook.com [52.101.53.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04C0B10E6C6
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 17:05:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OUSe8MUO1UIUyy2JxTL2aGTCnGF5jTmnUnYD91SdkMEOUk9SZbUnXtJNqEHI/xbNdrp4rUP0aL8ij0byLlbf7GedQvIBcLLUB2JF5Oqg8j1D1WlQHunvi7uyISqqMmR0hzzQwMis8KtnyefWyKWhiHab/0fJGdcO4yTi1cw80DYnHE85U8Ia+J6MVpkWtkNNR8AJFX7P1QFFun8txo19rUWeMWM6VUhTwM34YwxwxmvGt+sLVMAoNwzPvMlPvoyIiEOQyCsUrdX0wFyugoP1J/n1PxyqkX8T0EYKL1Tjy8mxSyN3UAnXCU/sEhgKCsOZiviVc6Yu7ihwol13X0JwqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VWHwy4LY4g3c7bFFMcZgU1XdTTKC4NPptZARvOB+8Es=;
 b=BvcRtC9wPbYQK+VhNjz81G76APpxHfJORD7kvC1Zoc2/mVhvTvlQI5pFW/r3MoacX2MMZVzysVypPZcxYJ04kbNBpN2tZCmHhFbr1/wF60x/dhNSGyLKWvfs6TZhyMEQ7SvYd5mbhLlo3WWqqfoyk8qMs0uioPA4ypTSF+nOf1ITjStUCGk/N95Oc3D/lAsxwVd8txTG+d/8MZgDG0wmTwOHe7uVgsCC49Vs0GlR/sI6eLNpRBcZqyyYTPksfSEiPM73VDvy84KA1XU+cjl8OSkMmO/jmKnBs+rIqdZdRRuihnhEWNSKzZp43LHRSz34RNHcQJVf2qDj8D4cOGvzKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWHwy4LY4g3c7bFFMcZgU1XdTTKC4NPptZARvOB+8Es=;
 b=3Dvwo8C9bYR0IkiotIBCM8T9u19cUQ+OsQbFeEEaV+u8W6BelgY+oBJSrYUcb1SXhvDwMwbOAUZhxBhaLMd7kZWbO0HWO16QaCCZS4YQBq0xfSMePNCEBm1x2p54hdrtpJIxv/IM+rZGbC4lDLw9D7JnKlsuIS+JWtQam64VEAk=
Received: from MW4PR04CA0241.namprd04.prod.outlook.com (2603:10b6:303:88::6)
 by CH1PR12MB9575.namprd12.prod.outlook.com (2603:10b6:610:2ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 17:05:44 +0000
Received: from CO1PEPF00012E63.namprd05.prod.outlook.com
 (2603:10b6:303:88:cafe::81) by MW4PR04CA0241.outlook.office365.com
 (2603:10b6:303:88::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 17:05:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E63.mail.protection.outlook.com (10.167.249.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 17:05:43 +0000
Received: from 0yonsun-linux-dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Wed, 28 Oct 2026 12:05:42 -0500
From: Yongqiang Sun <Yongqiang.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Shaoyun.Liu@amd.com>, Yongqiang Sun <Yongqiang.Sun@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: restore MES12.1 mes_dbgext per XCC after XCC
 reset
Date: Wed, 28 Oct 2026 13:05:31 -0400
Message-ID: <20261028170531.463031-1-Yongqiang.Sun@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E63:EE_|CH1PR12MB9575:EE_
X-MS-Office365-Filtering-Correlation-Id: 79bb4c17-6a9b-4a80-7dc7-08df3515b395
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|261028144727099003|11063799006|56012099006|261022105027099003|261009223027099003|261022075727099003|261021121427099003|261026140227099003|261026121527099003|10067099003|261021123027099003|18002099003;
X-Microsoft-Antispam-Message-Info: fkz0Vmud4fLhsdw/4jSIBtnD3pe1Sc79HUkzA3et2AG0qMsCpET10wU5+tar0e22lSj/ZypDtPegdzk/9Of5lTvW500N5CEY/kMDyd2bRwLvJeegANY4oqL5dH+wYZev9dR5ycO3WRgU4FgHl9BxBSCjh6MC4dy/ZBqzgvAbYE4NUUbFviJTg8oTMJNCuEOdfdeT8X/vnx0TsXYVSRqumf+TaWRAfJksxwxp28dHOppYz3aHKfJVxmUWJUPxzRjmdMJdNwWMmiZFvOJ9UR72S/8QxWpa4KhWuSTiK/UaC0Ur2nSLR8JxMF0JeN1Q3XHqmTEo0cfjz21PGz1DevbwcNyyzuyRkkthhcfQD+wgMGgkZWiCFu2W7LzQf7YZTelkRF9wClE5xHytXJF4Rgx2Y9d/EHJrn3n5stfmMpwPlfhzlFzO/L8tc5/Q36H4DHSZ3IKWu/X7p5GLEdErt9MOWDE2C8aXVKwHnpLkHfN9CaDK2ZHuN7wrjeMHoWKvnhhWwen8/QmbqezC9n8djkAYJOygZBrnpgdzKelEex3iJ5Nqkl+k0YoKDlJ7Nfis/IlV06AbLFdQjhSFBnd22YjSF1QGjd2q54I8YCxhJJlbAlgonytCwd/cWTy38I77grn7e7cr0arRrfNnYy9lZMZN/CK1OSbZUl7c8NUyqghNcYN/uVzja/4SIBtdvuTjJQ8Le9GowP+Lb5d+/ZYlUw0Tqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(261028144727099003)(11063799006)(56012099006)(261022105027099003)(261009223027099003)(261022075727099003)(261021121427099003)(261026140227099003)(261026121527099003)(10067099003)(261021123027099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: z+ohRQH1hALjaGA2Z1mTnVPJjQ104JiFZOs1yzlBtgaZUEUqGAT6TpvKJLBiEN8Uz+RdJg5XWRkOx/32D7Q9kgfyTs/fY+lrCkccCbYO9OuLclM3IeoXTSD9pJYYYUEy8vChj3w98Pf+MvA+CdHoRwPKJq8DGfDtG2STwHG7Zir6+fvL9xpHzqXgAwHsNPlPc1BhZWExlIZm351fzvA5JsS1vUySK4py0Odaai6BJ1gd1ZCANJIBc6BAJwGevRiU32Kv5utFWdzC4HhZCEgZVa8das7d8kx5eDVnISlXUnUVZTKmA0L6+skQ1sP+Zri48Byru7g+jkTAgMMV0wFbXKrxTHfIT3o6yaEmCGTzPQcAwVUYW87IE6pBhbtMqQjJvhmEe6jZcVTKO1p0lzbfxhIJSxmmfw8d7lgilkPPC6GA6b65BRvAsn0WDgADHmh4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 17:05:43.2559 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79bb4c17-6a9b-4a80-7dc7-08df3515b395
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E63.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9575
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

Add mes 12.1 hooks to disarm only the XCCs whose MES is stopping
and rearm their log regions after both MES pipes are available again.
Program the debug interrupt enable per XCC so other XCCs continue logging
through the restart.

Signed-off-by: Yongqiang Sun <Yongqiang.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 90 ++++++++++++++++++++------
 1 file changed, 72 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index 528fc86b0bcaa..ec595449963e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -38,10 +38,13 @@ MODULE_FIRMWARE("amdgpu/gc_12_1_0_uni_mes.bin");
 
 static int mes_v12_1_hw_init(struct amdgpu_ip_block *ip_block);
 static int mes_v12_1_xcc_hw_init(struct amdgpu_ip_block *ip_block, int xcc_id);
+static int mes_v12_1_xcc_hw_fini(struct amdgpu_ip_block *ip_block, int xcc_id);
 static int mes_v12_1_hw_fini(struct amdgpu_ip_block *ip_block);
 static int mes_v12_1_kiq_hw_init(struct amdgpu_device *adev, uint32_t xcc_id);
 static int mes_v12_1_kiq_hw_fini(struct amdgpu_device *adev, uint32_t xcc_id);
 static int mes_v12_1_setup_coop_mode(struct amdgpu_device *adev, int xcc_id);
+static int mes_v12_1_enable_dbgext_irq_xcc(struct amdgpu_mes *mes,
+					   bool enable, u32 xcc_id);
 static int mes_v12_1_enable_dbgext_irq(struct amdgpu_mes *mes, bool enable);
 
 #define MES_EOP_SIZE   2048
@@ -988,38 +991,56 @@ static int mes_v12_1_inv_tlbs_pasid(struct amdgpu_mes *mes,
  * that lets the CP forward the assertion to the host IH.  CPC_INT_CNTL is
  * per-(me,pipe); the enable must be set on both me3 pipes (0 and 1)
  * - setting it only on the scheduler pipe is not sufficient.
- * Armed on every XCC, since each runs its own MES and each (xcc, pipe) logs into
- * its own buffer region.
+ * xcc_id selects the logical XCC.  That XCC runs its own MES, and both
+ * of its ME3 pipes are updated because either pipe can raise the
+ * debug-message interrupt.
  */
-static int mes_v12_1_enable_dbgext_irq(struct amdgpu_mes *mes, bool enable)
+static int mes_v12_1_enable_dbgext_irq_xcc(struct amdgpu_mes *mes,
+					   bool enable, u32 xcc_id)
 {
 	struct amdgpu_device *adev = mes->adev;
 	int num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	u32 cp_int_cntl;
-	int pipe, xcc_id, inst;
+	int pipe, inst;
+
+	if (xcc_id >= num_xcc)
+		return -EINVAL;
 
 	mutex_lock(&adev->srbm_mutex);
 
-	for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
-		inst = GET_INST(GC, xcc_id);
+	inst = GET_INST(GC, xcc_id);
 
-		for (pipe = 0; pipe < 2; pipe++) {
-			soc_v1_0_grbm_select(adev, 3, pipe, 0, 0, inst);
+	for (pipe = 0; pipe < 2; pipe++) {
+		soc_v1_0_grbm_select(adev, 3, pipe, 0, 0, inst);
 
-			cp_int_cntl = RREG32_SOC15(GC, inst, regCPC_INT_CNTL);
-			cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CPC_INT_CNTL,
-						    TIME_STAMP_INT_ENABLE, enable ? 1 : 0);
-			WREG32_SOC15(GC, inst, regCPC_INT_CNTL, cp_int_cntl);
-		}
-
-		soc_v1_0_grbm_select(adev, 0, 0, 0, 0, inst);
+		cp_int_cntl = RREG32_SOC15(GC, inst, regCPC_INT_CNTL);
+		cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CPC_INT_CNTL,
+					    TIME_STAMP_INT_ENABLE, enable ? 1 : 0);
+		WREG32_SOC15(GC, inst, regCPC_INT_CNTL, cp_int_cntl);
 	}
 
+	soc_v1_0_grbm_select(adev, 0, 0, 0, 0, inst);
+
 	mutex_unlock(&adev->srbm_mutex);
 
 	return 0;
 }
 
+static int mes_v12_1_enable_dbgext_irq(struct amdgpu_mes *mes, bool enable)
+{
+	u32 num_xcc = NUM_XCC(mes->adev->gfx.xcc_mask);
+	u32 xcc_id;
+	int r;
+
+	for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
+		r = mes_v12_1_enable_dbgext_irq_xcc(mes, enable, xcc_id);
+		if (r)
+			return r;
+	}
+
+	return 0;
+}
+
 static const struct amdgpu_mes_funcs mes_v12_1_funcs = {
 	.add_hw_queue = mes_v12_1_add_hw_queue,
 	.remove_hw_queue = mes_v12_1_remove_hw_queue,
@@ -1032,6 +1053,7 @@ static const struct amdgpu_mes_funcs mes_v12_1_funcs = {
 	.detect_and_reset_hung_queues = mes_v12_1_detect_and_reset_hung_queues,
 	.invalidate_tlbs_pasid = mes_v12_1_inv_tlbs_pasid,
 	.enable_dbgext_irq = mes_v12_1_enable_dbgext_irq,
+	.enable_dbgext_irq_xcc = mes_v12_1_enable_dbgext_irq_xcc,
 };
 
 static int mes_v12_1_allocate_ucode_buffer(struct amdgpu_device *adev,
@@ -1776,10 +1798,20 @@ static int mes_v12_1_kiq_hw_init(struct amdgpu_device *adev, uint32_t xcc_id)
 			goto failure;
 	}
 
+	/*
+	 * Partition resume restarts this XCC here and does not run
+	 * mes_v12_1_hw_init(), where dbgext is first armed.  Rearm only this
+	 * XCC.  Boot and full-device resume no-op: dbgext_stop() has cleared
+	 * dbgext_active, and hw_init() arms every XCC afterwards.
+	 */
+	r = amdgpu_mes_dbgext_rearm_xcc(adev, xcc_id);
+	if (r)
+		goto failure;
+
 	return r;
 
 failure:
-	mes_v12_1_hw_fini(ip_block);
+	mes_v12_1_xcc_hw_fini(ip_block, xcc_id);
 	return r;
 }
 
@@ -1787,6 +1819,13 @@ static int mes_v12_1_kiq_hw_fini(struct amdgpu_device *adev, uint32_t xcc_id)
 {
 	int inst = MES_PIPE_INST(xcc_id, AMDGPU_MES_SCHED_PIPE);
 
+	/*
+	 * Drain this XCC and stop reading it before its MES is halted.
+	 * A full suspend or unload has already cleared dbgext_active, so
+	 * this returns immediately there.
+	 */
+	amdgpu_mes_dbgext_disarm_xcc(adev, xcc_id);
+
 	if (adev->mes.ring[inst].sched.ready) {
 		amdgpu_mes_unmap_legacy_queue(adev, &adev->mes.ring[inst],
 					      RESET_QUEUES, 0, 0, xcc_id);
@@ -1879,7 +1918,11 @@ static int mes_v12_1_xcc_hw_init(struct amdgpu_ip_block *ip_block, int xcc_id)
 	return 0;
 
 failure:
-	mes_v12_1_hw_fini(ip_block);
+	/*
+	 * Fini this XCC only.  hw_fini() stops dbgext for every XCC, which
+	 * must not happen when one scheduler pipe fails.
+	 */
+	mes_v12_1_xcc_hw_fini(ip_block, xcc_id);
 	return r;
 }
 
@@ -1899,9 +1942,20 @@ static int mes_v12_1_hw_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
+static int mes_v12_1_xcc_hw_fini(struct amdgpu_ip_block *ip_block, int xcc_id)
+{
+	return 0;
+}
+
 static int mes_v12_1_hw_fini(struct amdgpu_ip_block *ip_block)
 {
-	amdgpu_mes_dbgext_stop(ip_block->adev);
+	struct amdgpu_device *adev = ip_block->adev;
+	int xcc_id, num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+
+	amdgpu_mes_dbgext_stop(adev);
+
+	for (xcc_id = 0; xcc_id < num_xcc; xcc_id++)
+		mes_v12_1_xcc_hw_fini(ip_block, xcc_id);
 
 	return 0;
 }
-- 
2.43.0


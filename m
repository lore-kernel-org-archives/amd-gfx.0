Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E342C982F0
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 20:03:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF0AF10EA7A;
	Mon, 21 Sep 2026 20:03:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LSkDYXzF";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013009.outbound.protection.outlook.com
 [40.93.196.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABEA010EA72
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 20:03:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQVjovu2Npfa3ll7RaYhRCw5rv/qF+rDPrawQ5LYGhWVt6l4Mk1EOERTPZkWFc/W7zYiLRKdWuQNbt0RZ4vdqyHISz9TBB9d8iGvJ3Pj88DAF9z7qEh18SwPD0CAED8cXyjaqiQ6jMujBgP1qa9djywiYiVWob4HCM+OY6I40DDx0VAEHDe8eztbLff21AGyKX7crkyppwB8gyHIho7Of/Ebx6NTMLsUHq4vAmtzZbwcfNkskGgfw2X8L5pvXm9DolEW2uThUANW9Ztorec8QnKOWL5rwocNVAmNsr6JmCs+ncESoJeVuUuh+odWEOVfjYV2I7q+TT1unWOt5JNVNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3NYsrlPymvzss5g5oTAOk74fSN7AcUBvChhLkr/jU8=;
 b=MLV/uOC6aVsrH2TUcjrCR91iHSZvFmSAsP4MCsPTHVzY8nFbeZ6QQzW4T3xCGC9IEEK2p9PemDIiRjdTPenwTR+7kjEYHlL35gbf/AaEg6LJLr/FujMnwNwuEJEhPBXmcz6sypPKtdb3q0+BnhYby9gRFYef96TwLaskZ0wkKMYRK28qHgtuF75on25dF/JTVagYv7o/NkLrRcz33Z0ayS71almv2l9jKs9egjK1IgVEAfLdTToPxLnKyImqXra38sXwHYRSjcvPr6rJyu+LQkaWgLDg5RsX/nETvbrDn6+I8WFgQaEzfvRDa9Mw1lQQTo7v6a3lM5XkgEP/+Kn3Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3NYsrlPymvzss5g5oTAOk74fSN7AcUBvChhLkr/jU8=;
 b=LSkDYXzFCFKoUCuaeFViK8BGpwabT5+YOEZGCR3ndhTKflG82nw2Fk481orCvDa7AYwMhyuOY25/0/lXragOo1/0nv47LAUNISiUog8gfF2FAGPrfN5L+4MFhdEpVEgbL4TyM2b/+t8RtoOvptVOCC73QG75LIClw5ln+I5HEI8=
Received: from BN9PR03CA0239.namprd03.prod.outlook.com (2603:10b6:408:f8::34)
 by SJ0PR12MB5662.namprd12.prod.outlook.com (2603:10b6:a03:429::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 20:03:32 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:408:f8:cafe::a9) by BN9PR03CA0239.outlook.office365.com
 (2603:10b6:408:f8::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 20:03:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.0 via Frontend Transport; Mon, 21 Sep 2026 20:03:32 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 15:03:23 -0500
Received: from work-495456.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 15:03:23 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <Bing.Ma@amd.com>
CC: <jamesz@amd.com>
Subject: [PATCH 11/12] drm/amdgpu: add profiler/spm support for gfx12_0
Date: Mon, 21 Sep 2026 16:03:12 -0400
Message-ID: <20260921200313.865829-11-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921200313.865829-1-James.Zhu@amd.com>
References: <20260921200313.865829-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|SJ0PR12MB5662:EE_
X-MS-Office365-Filtering-Correlation-Id: fb5dc1e3-be66-449b-38aa-08df181b6965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: xTGCDY0GelO/+3aHNECM5SBIN3vhVhC3sS5CrEw9aUVAXeyNd6rhmRr/0uBRENe0JSJt4Lwd4hJ/kBgmx48Qg2u8Kp3eV4XvotWGUut1xZWevU8BXSgDD+eh8Vpf2htWN1iIlaonBXjn2xlgXvYk7qsfil1jH4GrW9UToHM0Mnm/g5x7FbsS6kB53U9SuEeHRo4coPh9p0z1CHGMmtDinAONrPDTKm9uJV2G6UqKMxw4d5v961pW9BYDaVI/TWar2B9Ri48QXbOwolG5pCwYTY+MFi6y/EHxErQOrPia0iVB+hE9X7fBZCIZ8RESmmAkJleWm4QeOHlhS+wlP73R2ONvSacB+tBjR5bBcYf8Rds598+AIxNwiS2Q5tpcGaniwaoqK5c5k/WdnEk7kGnEGal8NYPiZNar63zke7QHV6mHspBmXQMcEYFC4tan99ZM5lsCNe6k1ZVJqqpi/zqH9owju9GIfMvYDuCSBQ6iLHeWUVX5GjXRRIll3U+9MuWzBUSL/I58zHlFICMZZjDUKE8FEnpWlBpRry6aFkFPFCAenkiyrolvwdJZhd4owGNW69i4NblYzBLJdPqTKMdYvMg8gFCOvrfhV9/faRpggqsH/qI+kM7otEhHoxUo5LxiNg4dQnbh5yNS5TYScKLuC73ms4aYSB7XxijJHhPF767PdpQM9G7qa0VIW23XdPbNFGwLajvSamyjHqH7J0Dkpw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xr9Rzi3LPSmEo+KcY/haOiFBoal5FDQBOniO/t2k/bH9orUFtSnymnwg4OnoQFRCeYfROi1J3OW4SbuR8FY2MsqWDhGv6Fh8JaNxQVrCh1l3SmtLYUe93l55QvzpWWBlZRiV+4NG1Mzl4OnWOQs3depxuWtGEh3K7VWgZvHM/QNfEvmMBQfjqBt2D1IzrydbFWeMlhzdsbk493YbKsyNrCyp59XOMOz4bJ/0/8A1GUhNlERscNCI+2FQvCvuDBKD+prmvknopwjipu8NNI6G7BM6JxQXR+t06YRLi3wLt7Bev1Rx9l8zTUKTtJiLuF2g3X+3LJD7JLkxafKu6awWE5kgcXwht62gVcdsJ+QlnSlcPxX4BKNIr0Vruc1PoK9SY48iMNfuGUeTSFa6T2spgDf3JsyCHe7e3Y15ytZpxDXaxMLJsm6UyhVqD2Q5YERk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 20:03:32.0788 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb5dc1e3-be66-449b-38aa-08df181b6965
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5662
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add the gfx_v12_0_spm_funcs backend. Ring setup writes
RLC_SPM_PERFMON_RING_BASE_LO/HI, _RING_SIZE, the segment threshold and
clears CP_CP_PERFMON_CNTL. start selects PERFMON_RING_MODE in
RLC_SPM_PERFMON_CNTL, resets the perfmon state through CP_CP_PERFMON_CNTL,
clears RLC_SPM_ACCUM_MODE and rewinds both RLC_SPM_RING_WRPTR and
RLC_SPM_RING_RDPTR; stop stops counting, resets the perfmon state and
rewinds the pointers again. set_rdptr updates RLC_SPM_RING_RDPTR as the
consumer drains the ring. All callbacks bracket their register access with
amdgpu_gfx_off_ctrl() so GFXOFF cannot swallow the writes, and program
GET_INST(GC, 0) since gfx12 is single-XCC.

Add the gfx.spm_irq source for
GFX_12_0_0__SRCID__RLC_STRM_PERF_MONITOR_INTERRUPT on SOC15_IH_CLIENTID_RLC,
toggle it through RLC_SPM_INT_CNTL in the set-interrupt-state callback,
take a reference in hw_init and drop it in hw_fini, and forward the
interrupt to the SPM manager via amdgpu_rlc_spm_interrupt(). Because gfx12
reports ring progress by interrupt, no polling thread is needed.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 133 +++++++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 398e9c463ec6..e02ab1046fb6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -272,6 +272,8 @@ static void gfx_v12_0_set_mqd_funcs(struct amdgpu_device *adev);
 static void gfx_v12_0_set_imu_funcs(struct amdgpu_device *adev);
 static int gfx_v12_0_get_cu_info(struct amdgpu_device *adev,
 				 struct amdgpu_cu_info *cu_info);
+static void gfx_v12_0_update_spm_vmid(struct amdgpu_device *adev,
+				      int xcc_id, struct amdgpu_ring *ring, unsigned vmid);
 static uint64_t gfx_v12_0_get_gpu_clock_counter(struct amdgpu_device *adev);
 static void gfx_v12_0_select_se_sh(struct amdgpu_device *adev, u32 se_num,
 				   u32 sh_num, u32 instance, int xcc_id);
@@ -1467,6 +1469,13 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 						  num_compute_rings);
 	}
 
+	/* SPM */
+	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_RLC,
+			      GFX_12_0_0__SRCID__RLC_STRM_PERF_MONITOR_INTERRUPT,
+			      &adev->gfx.spm_irq);
+	if (r)
+		return r;
+
 	/* EOP Event */
 	r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_GRBM_CP,
 			      GFX_12_0_0__SRCID__CP_EOP_INTERRUPT,
@@ -3854,6 +3863,10 @@ static int gfx_v12_0_hw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	r = amdgpu_irq_get(adev, &adev->gfx.spm_irq, 0);
+	if (r)
+		goto err_spm_irq;
+
 	r = amdgpu_irq_get(adev, &adev->gfx.priv_inst_irq, 0);
 	if (r)
 		goto err_priv_inst;
@@ -3873,6 +3886,8 @@ static int gfx_v12_0_hw_init(struct amdgpu_ip_block *ip_block)
 err_bad_op:
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
 err_priv_inst:
+	amdgpu_irq_put(adev, &adev->gfx.spm_irq, 0);
+err_spm_irq:
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	return r;
 }
@@ -3887,6 +3902,7 @@ static int gfx_v12_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	gfx_v12_0_set_userq_eop_interrupts(adev, false);
 	amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
+	amdgpu_irq_put(adev, &adev->gfx.spm_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 
 	if (!adev->no_hw_access) {
@@ -3972,6 +3988,85 @@ static uint64_t gfx_v12_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 	return clock;
 }
 
+static void gfx_v12_0_spm_start(struct amdgpu_device *adev, int xcc_id)
+{
+	uint32_t data = 0;
+
+	amdgpu_gfx_off_ctrl(adev, false);
+
+	data = RREG32_SOC15(GC, GET_INST(GC, 0), regRLC_SPM_PERFMON_CNTL);
+	data |= RLC_SPM_PERFMON_CNTL__PERFMON_RING_MODE_MASK;
+	WREG32_SOC15(GC, GET_INST(GC, 0), regRLC_SPM_PERFMON_CNTL, data);
+
+	data = REG_SET_FIELD(0, CP_CP_PERFMON_CNTL, SPM_PERFMON_STATE,
+			CP_PERFMON_STATE_DISABLE_AND_RESET);
+	WREG32_SOC15(GC, GET_INST(GC, 0), regCP_CP_PERFMON_CNTL, data);
+	WREG32_SOC15(GC, GET_INST(GC, 0), regRLC_SPM_ACCUM_MODE, 0);
+
+	WREG32_SOC15(GC, GET_INST(GC, 0), regRLC_SPM_RING_WRPTR, 0);
+	WREG32_SOC15(GC, GET_INST(GC, 0), regRLC_SPM_RING_RDPTR, 0);
+
+	WREG32_SOC15(GC, GET_INST(GC, 0), regRLC_SPM_INT_CNTL, 1);
+
+	amdgpu_gfx_off_ctrl(adev, true);
+}
+
+static void gfx_v12_0_spm_stop(struct amdgpu_device *adev, int xcc_id)
+{
+	uint32_t data = 0;
+
+	amdgpu_gfx_off_ctrl(adev, false);
+
+	data = REG_SET_FIELD(0, CP_CP_PERFMON_CNTL, SPM_PERFMON_STATE,
+			CP_PERFMON_STATE_STOP_COUNTING);
+	WREG32_SOC15(GC, GET_INST(GC, 0), regCP_CP_PERFMON_CNTL, data);
+
+	data = REG_SET_FIELD(0, CP_CP_PERFMON_CNTL, SPM_PERFMON_STATE,
+			CP_PERFMON_STATE_DISABLE_AND_RESET);
+	WREG32_SOC15(GC, GET_INST(GC, 0), regCP_CP_PERFMON_CNTL, data);
+
+	WREG32_SOC15(GC, GET_INST(GC, 0), regRLC_SPM_RING_WRPTR, 0);
+	WREG32_SOC15(GC, GET_INST(GC, 0), regRLC_SPM_RING_RDPTR, 0);
+
+	WREG32_SOC15(GC, GET_INST(GC, 0), regRLC_SPM_INT_CNTL, 0);
+
+	amdgpu_gfx_off_ctrl(adev, true);
+}
+
+static void gfx_v12_0_spm_set_rdptr(struct amdgpu_device *adev, int xcc_id, u32 rptr)
+{
+	amdgpu_gfx_off_ctrl(adev, false);
+	WREG32_SOC15(GC, GET_INST(GC, 0), regRLC_SPM_RING_RDPTR, rptr);
+	amdgpu_gfx_off_ctrl(adev, true);
+}
+
+static void gfx_v12_0_set_spm_perfmon_ring_buf(struct amdgpu_device *adev,
+					    int xcc_id, u64 gpu_addr, u32 size)
+{
+	amdgpu_gfx_off_ctrl(adev, false);
+	WREG32_SOC15(GC, GET_INST(GC, 0), regRLC_SPM_PERFMON_RING_BASE_LO,
+		     lower_32_bits(gpu_addr));
+	WREG32_SOC15(GC, GET_INST(GC, 0), regRLC_SPM_PERFMON_RING_BASE_HI,
+		     upper_32_bits(gpu_addr));
+	WREG32_SOC15(GC, GET_INST(GC, 0), regRLC_SPM_PERFMON_RING_SIZE, size);
+	WREG32_SOC15(GC, GET_INST(GC, 0), regRLC_SPM_SEGMENT_THRESHOLD, 0x1);
+	WREG32_SOC15(GC, GET_INST(GC, 0), regCP_CP_PERFMON_CNTL, 0);
+	amdgpu_gfx_off_ctrl(adev, true);
+}
+
+static const struct amdgpu_spm_funcs gfx_v12_0_spm_funcs = {
+	.start = &gfx_v12_0_spm_start,
+	.stop = &gfx_v12_0_spm_stop,
+	.set_rdptr = &gfx_v12_0_spm_set_rdptr,
+	.set_spm_perfmon_ring_buf = &gfx_v12_0_set_spm_perfmon_ring_buf,
+	.set_spm_config_size = 0,
+};
+
+static void gfx_v12_0_set_spm_funcs(struct amdgpu_device *adev)
+{
+	adev->gfx.spmfuncs = &gfx_v12_0_spm_funcs;
+}
+
 static int gfx_v12_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -4004,6 +4099,7 @@ static int gfx_v12_0_early_init(struct amdgpu_ip_block *ip_block)
 						  AMDGPU_MAX_COMPUTE_RINGS);
 	}
 
+	gfx_v12_0_set_spm_funcs(adev);
 	gfx_v12_0_set_kiq_pm4_funcs(adev);
 	gfx_v12_0_set_ring_funcs(adev);
 	gfx_v12_0_set_irq_funcs(adev);
@@ -5505,11 +5601,48 @@ static const struct amdgpu_irq_src_funcs gfx_v12_0_priv_inst_irq_funcs = {
 	.process = gfx_v12_0_priv_inst_irq,
 };
 
+static int gfx_v12_0_spm_set_interrupt_state(struct amdgpu_device *adev,
+					  struct amdgpu_irq_src *src,
+					  unsigned int type,
+					  enum amdgpu_interrupt_state state)
+{
+
+	switch (state) {
+	case AMDGPU_IRQ_STATE_DISABLE:
+		WREG32_SOC15(GC, GET_INST(GC, 0), regRLC_SPM_INT_CNTL, 0);
+		break;
+	case AMDGPU_IRQ_STATE_ENABLE:
+		WREG32_SOC15(GC, GET_INST(GC, 0), regRLC_SPM_INT_CNTL, 1);
+		break;
+	default:
+		break;
+	}
+
+
+	return 0;
+}
+
+static int gfx_v12_0_set_spm_irq(struct amdgpu_device *adev,
+			     struct amdgpu_irq_src *source,
+			     struct amdgpu_iv_entry *entry)
+{
+	amdgpu_rlc_spm_interrupt(adev, 0);
+	return 0;
+}
+
+static const struct amdgpu_irq_src_funcs gfx_v12_0_set_spm_irq_funcs = {
+	.set = gfx_v12_0_spm_set_interrupt_state,
+	.process = gfx_v12_0_set_spm_irq,
+};
+
 static void gfx_v12_0_set_irq_funcs(struct amdgpu_device *adev)
 {
 	adev->gfx.eop_irq.num_types = AMDGPU_CP_IRQ_LAST;
 	adev->gfx.eop_irq.funcs = &gfx_v12_0_eop_irq_funcs;
 
+	adev->gfx.spm_irq.num_types = 1;
+	adev->gfx.spm_irq.funcs = &gfx_v12_0_set_spm_irq_funcs;
+
 	adev->gfx.priv_reg_irq.num_types = 1;
 	adev->gfx.priv_reg_irq.funcs = &gfx_v12_0_priv_reg_irq_funcs;
 
-- 
2.34.1


Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A33F606A320
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 08:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Wlh78Rvw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB85610FA71;
	Wed, 28 Oct 2026 08:58:03 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012053.outbound.protection.outlook.com
 [40.107.200.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE0EC10FA81
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 08:57:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Afm4cM1kpxV/ZdRqWYU0rb4KljZUkUfnr4lHtxBZAJq+3UIg72Tg0S2KFx9TdNLDlqRd+2HTiuiaPPDdx3ZOEFxCMml8g9aM64qJHsti0nvo/r154uYaEUcnOa2cqr6FM9lDZXq+bl2dAfGGeNFeiyqRh0Ms4iy55uwv7APOFnoI9R2PU6JhXsgMtcM9mh/aczsoFSLDzA0XXQ9/WptkbdcD3kWhRMPxrI6NZ7MaoxOnnGB5tIjeLBWq9oLgtNygMU8aqY9R8Rvnp+AM91kHu48S3g5FN4qbwiaO7UociIFUgiMJcOkLautbgV27nL0yqXLeOsjs0d9vJmur6THMTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIyfhdQuAiBjD7tVn0zfd66ytjpL6hSdbYBmBqsROj0=;
 b=P34uvq9boXJB5BnaGfJPTa9OoeWNskYefhLYqog50VeGLC686JIDrHWLFiXKOMb38zN5g5ioPau2fuJ85Do83gUi9F1tcb7eafrjP76DSAS3025TqUxdO23NpzgaXUHKGdvAsavTUlTsmu29RynnDT87mfQKl8ceFMcrQG8ak1ZnUr0i+DeKPtwEOYASsQvDBlgfIRIlthjaVvfCEvfp6jrjJ2aHwvum1c/+oX7TR/eWTiJeOCoMTV/s6/j1CMUHkwoj02puscNPl67YBawo7+cdw9JPr7gyXtOhk104sWiCiHLpJkjjLVKidYQnOb7L1Tae5Kil20diYaSXlXiRWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIyfhdQuAiBjD7tVn0zfd66ytjpL6hSdbYBmBqsROj0=;
 b=Wlh78Rvwlf8UAG+1CKs2a+upXF+tssFjjRh2i7/AK34tXRoCMybCKFLsEwXVaqz8wUH3pwQ6z07MseLGzC9IslOT+lksPIPLBq7KgXenYQzFEAkPcLKB71mxcpmbx9INkT0C69EYFhz/rnUMQWYiIIMCaMgewzlBHP0lk/G5QzI=
Received: from BY5PR03CA0020.namprd03.prod.outlook.com (2603:10b6:a03:1e0::30)
 by MN2PR12MB4424.namprd12.prod.outlook.com (2603:10b6:208:26a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 08:57:51 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::6b) by BY5PR03CA0020.outlook.office365.com
 (2603:10b6:a03:1e0::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Wed,
 28 Oct 2026 08:57:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 08:57:50 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 03:57:49 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 28 Oct 2026 03:57:47 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <timur.kristof@gmail.com>, <Mario.Novales@amd.com>, 
 <Manu.Rastogi@amd.com>, <Jiongyu.Zhu@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH v3 05/15] drm/amdgpu/gfx12: add a gfx engine reset
Date: Wed, 28 Oct 2026 16:56:36 +0800
Message-ID: <20261028085736.3808569-5-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261028085736.3808569-1-Jesse.Zhang@amd.com>
References: <20261028085736.3808569-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|MN2PR12MB4424:EE_
X-MS-Office365-Filtering-Correlation-Id: f444b7c8-423d-4ddf-89e3-08df34d18b81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|23010399003|1800799024|261026140227099003|11063799006|56012099006|261026121527099003|261021121427099003|261022105027099003|261021123027099003|261022075727099003|261009223027099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: TUwLZCXXVuNA0alBCjCVLY/NN6UlANuLD//ZIzQpEOmDPXAyamRivanqZ+ORh6uLlI61du5bJ+g7W67fgINeLuPwYCHtAiVcNzeGtCyWhmyLT59dy6Ep8tbtf0aGR5P3G/DpTEdGCYVd0q++6Ua1w36YEeexh95GSrb5JRXE4EGLTIemD263MUcA7+T+oB6F5FOXprmvZWCtCKk/FJxu1vNdnqKPi9VuV961OLH0e3QHp20AvtKpKsGQpvTnsiK6eKQ2aDE8rE8Q9S9/HwHPT+cxXFQtbhEV/PtU0FiHZwcqBaAfc0aeyqAAsmehAqnC/ArdwPJnIX/oM41TU06Gpq2YLd/anuxdoStDQ1leIILb+YNazdqdrQH+RyT7y74+5pPRhjRWA201hFry99Ox4q/tQTSWa3ObabwFJ3cMWVlFNrlUmlXr4KdojH1i4F/gMiOe7+Pq5LuwpAZsSu4moGiaOd7OKZ90TaJLjRwUKIun0wAY/nBt+Srxt4RHfSN0GRL+a7HnrLaQZNJWiVwklWGymrgVVfY1KC6XqNdi5R6zMtnn68pFyUi/ns2xmN2iSJ/NmJnsSfmpG1n3nTiM7//4nSPvYTEpApc/y6Yot2sFATA9b/B7g8sk3QYTILuiTK3qS6Hge1mER8XJDS/5+ZTkWYfpGRZHIUTtlb/6INvoNKlunsLpIw0cNjdlIUspjHrIMVtu0/8IVJoZPVbqQg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(23010399003)(1800799024)(261026140227099003)(11063799006)(56012099006)(261026121527099003)(261021121427099003)(261022105027099003)(261021123027099003)(261022075727099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bo7R3EQ1ei6gj0lhSfjlLO9NnkzTUkKQJaoi8ZY+EB9DUaKkbinySqN1xZaoq8tNO5Nb+5dUtFGjxKijJFfb3ywqU1w/pMUP3r/W2F8APM3ZA+/OrkCkKeMzGH9IvdCVuA+rvIU/cWURN18AUht4CqzZIMgZo7IEg/fsMVdOhfv2WM5hJ20DGWPV1H6uNmR42hw9uXHTTzxaVQgePfst9kekB8UTO6wBdFq4DhxU/UC99df5WMODRNJc3l4ZQ33BMBaXCTlm8BuAM1j89D055mqKubrTTdD+K5+BYKNbbx0VNis4+BHs3qCMHA/Aj4LniY9hB3zyYzj1W1aGUbjMrhMAPzfoVrWF8+TF+5SB+edsqaOqBDRG0Q3E4pb3ndSwXBjoq0Yj4ARkXtgmOIGM8Br+SEca8rQuD2L/7m2I1GPBthz7GH/ga4Lib4WiCQLT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 08:57:50.1961 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f444b7c8-423d-4ddf-89e3-08df34d18b81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4424
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

Some hangs leave the gfx streaming engine of the CP front-end stuck,
eg. waiting for packet data that never arrives. Neither a queue reset
nor a pipe reset can stop it, so the recovery currently ends in a full
GPU reset, and VRAM is lost.

Implement the reset_engine callback for the graphics engine:
- halt PFP/ME;
- wait for the memory requests of the CP DMA to complete;
- with CP_SOFT_RESET_CNTL.GFX_ONLY_SOFT_RESET and GFX_HQD_REG_RESET set,
  pulse GRBM_SOFT_RESET.SOFT_RESET_CPF/CPG. A CPF reset alone does not
  clear the stuck stream;
- restart PFP/ME and restore CP_PFP_IB_CONTROL;
- remap the kernel gfx queue through MES from its MQD backup and restart
  it with gfx_v12_0_cp_gfx_start().

MEC and the compute part of CPF/CPG aren't reset, so the compute queues
aren't reset either.

MES fetches its own queues through CPF, and a MES command in flight
during the reset doesn't complete: hold the MES lock across the reset.

A CP DMA request in flight during the reset leaves the ME busy after it,
and MES then fails its next commands. Wait for those requests before
the reset, and give up after the usual timeout: the DMA of a hung stream
may never complete. Wait for them after the reset too, but not for the
whole CP, as the halted PFP stays busy until it is restarted. If the CP
doesn't go idle once PFP/ME run again, fail the reset so that a full
reset follows.

The reset also clears the HQDs of the gfx user queues, the caller has to
handle them.

The callback relies on the caller to only use it when the IP reports
AMDGPU_RESET_TYPE_IP_BLOCK_SOFT_RESET for the gfx rings, which a later
patch enables with MES and async gfx rings.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 129 +++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 184e009c8e50..defa5ca84fc2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -274,6 +274,8 @@ static void gfx_v12_0_set_imu_funcs(struct amdgpu_device *adev);
 static int gfx_v12_0_get_cu_info(struct amdgpu_device *adev,
 				 struct amdgpu_cu_info *cu_info);
 static uint64_t gfx_v12_0_get_gpu_clock_counter(struct amdgpu_device *adev);
+static int gfx_v12_0_reset_engine(struct amdgpu_device *adev,
+				  enum amd_ip_engine engine);
 static void gfx_v12_0_select_se_sh(struct amdgpu_device *adev, u32 se_num,
 				   u32 sh_num, u32 instance, int xcc_id);
 static u32 gfx_v12_0_get_wgp_active_bitmap_per_sh(struct amdgpu_device *adev);
@@ -964,6 +966,7 @@ static const struct amdgpu_gfx_funcs gfx_v12_0_gfx_funcs = {
 	.update_perfmon_mgcg = &gfx_v12_0_update_perf_clk,
 	.get_gfx_shadow_info = &gfx_v12_0_get_gfx_shadow_info,
 	.get_hdp_flush_mask = &amdgpu_gfx_get_hdp_flush_mask,
+	.reset_engine = &gfx_v12_0_reset_engine,
 };
 
 static int gfx_v12_0_gpu_early_init(struct amdgpu_device *adev)
@@ -3849,6 +3852,132 @@ static int gfx_v12_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
+/* The CP DMA and the interfaces its memory requests go through */
+#define GFX12_CP_STAT_MEM_BUSY	(CP_STAT__DMA_BUSY_MASK | \
+				 CP_STAT__TCIU_BUSY_MASK | \
+				 CP_STAT__RCIU_BUSY_MASK | \
+				 CP_STAT__UTCL2IU_BUSY_MASK)
+
+/*
+ * Soft reset the gfx CP and restart PFP and ME. Returns 0, or -ETIMEDOUT if the
+ * CP doesn't go idle after PFP and ME are restarted.
+ */
+static int gfx_v12_0_soft_reset_gfx_cp(struct amdgpu_device *adev)
+{
+	u32 tmp, cntl, me_cntl, ib_control;
+	int i;
+
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
+
+	/* MES fetches its queues through CPF: keep it out of the reset. */
+	amdgpu_mes_lock(&adev->mes);
+
+	me_cntl = RREG32_SOC15(GC, 0, regCP_ME_CNTL);
+	/* Cleared by the reset. */
+	ib_control = RREG32_SOC15(GC, 0, regCP_PFP_IB_CONTROL);
+
+	tmp = REG_SET_FIELD(me_cntl, CP_ME_CNTL, ME_HALT, 1);
+	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, PFP_HALT, 1);
+	WREG32_SOC15(GC, 0, regCP_ME_CNTL, tmp);
+	udelay(50);
+
+	/* A CP DMA in flight during the reset leaves the ME busy after it. */
+	for (i = 0; i < adev->usec_timeout; i++) {
+		if (!(RREG32_SOC15(GC, 0, regCP_STAT) & GFX12_CP_STAT_MEM_BUSY))
+			break;
+		udelay(1);
+	}
+
+	/* Without GFX_ONLY_SOFT_RESET, a CPF reset would also hit compute and MES. */
+	cntl = RREG32_SOC15(GC, 0, regCP_SOFT_RESET_CNTL);
+	tmp = REG_SET_FIELD(cntl, CP_SOFT_RESET_CNTL, GFX_ONLY_SOFT_RESET, 1);
+	tmp = REG_SET_FIELD(tmp, CP_SOFT_RESET_CNTL, GFX_HQD_REG_RESET, 1);
+	WREG32_SOC15(GC, 0, regCP_SOFT_RESET_CNTL, tmp);
+
+	/* A CPF reset alone leaves the streaming engine stuck. */
+	tmp = RREG32_SOC15(GC, 0, regGRBM_SOFT_RESET);
+	tmp = REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPF, 1);
+	tmp = REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPG, 1);
+	WREG32_SOC15(GC, 0, regGRBM_SOFT_RESET, tmp);
+	tmp = RREG32_SOC15(GC, 0, regGRBM_SOFT_RESET);
+	udelay(50);
+	tmp = REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPF, 0);
+	tmp = REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPG, 0);
+	WREG32_SOC15(GC, 0, regGRBM_SOFT_RESET, tmp);
+	tmp = RREG32_SOC15(GC, 0, regGRBM_SOFT_RESET);
+
+	WREG32_SOC15(GC, 0, regCP_SOFT_RESET_CNTL, cntl);
+
+	/* Not the whole CP: the halted PFP stays busy until restarted. */
+	for (i = 0; i < adev->usec_timeout; i++) {
+		if (!(RREG32_SOC15(GC, 0, regCP_STAT) & GFX12_CP_STAT_MEM_BUSY))
+			break;
+		udelay(1);
+	}
+	amdgpu_mes_unlock(&adev->mes);
+
+	gfx_v12_0_set_pfp_ucode_start_addr(adev);
+	gfx_v12_0_set_me_ucode_start_addr(adev);
+	tmp = RREG32_SOC15(GC, 0, regCP_ME_CNTL);
+	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, CE_HALT,
+			    REG_GET_FIELD(me_cntl, CP_ME_CNTL, CE_HALT));
+	WREG32_SOC15(GC, 0, regCP_ME_CNTL, tmp);
+	WREG32_SOC15(GC, 0, regCP_PFP_IB_CONTROL, ib_control);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+
+	tmp = RREG32_SOC15(GC, 0, regCP_ME_CNTL);
+	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, ME_HALT, 0);
+	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, PFP_HALT, 0);
+	WREG32_SOC15(GC, 0, regCP_ME_CNTL, tmp);
+	for (i = 0; i < adev->usec_timeout; i++) {
+		if (!RREG32_SOC15(GC, 0, regCP_STAT))
+			return 0;
+		udelay(1);
+	}
+	return -ETIMEDOUT;
+}
+
+/*
+ * Reset the graphics engine: the CP front-end (CPF/CPG), PFP/ME and the gfx
+ * HQDs. MEC, MES and the compute queues aren't reset.
+ */
+static int gfx_v12_0_reset_engine(struct amdgpu_device *adev,
+				  enum amd_ip_engine engine)
+{
+	int i, r;
+
+	lockdep_assert_held(&adev->gfx.mec.reset_mutex);
+
+	if (engine != AMD_IP_ENGINE_GFX)
+		return -EOPNOTSUPP;
+
+	amdgpu_gfx_off_ctrl(adev, false);
+
+	r = gfx_v12_0_soft_reset_gfx_cp(adev);
+	if (r) {
+		dev_err(adev->dev, "gfx CP still busy after reset, CP_STAT 0x%08x\n",
+			RREG32_SOC15(GC, 0, regCP_STAT));
+		goto exit;
+	}
+
+	/* Map the kernel gfx queue again: the reset cleared its HQD. */
+	r = amdgpu_gfx_disable_kgq(adev, 0);
+	if (r)
+		goto exit;
+
+	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
+		amdgpu_gfx_mqd_reset_restore(&adev->gfx.gfx_ring[i]);
+	r = amdgpu_gfx_enable_kgq(adev, 0);
+	if (r)
+		goto exit;
+
+	r = gfx_v12_0_cp_gfx_start(adev);
+
+exit:
+	amdgpu_gfx_off_ctrl(adev, true);
+	return r;
+}
+
 static uint64_t gfx_v12_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 {
 	uint64_t clock = 0;
-- 
2.50.1


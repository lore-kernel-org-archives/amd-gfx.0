Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9753606A322
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 08:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=dCagpeOS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F09010FA82;
	Wed, 28 Oct 2026 08:58:05 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010036.outbound.protection.outlook.com
 [52.101.193.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6829110FA83
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 08:57:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lC2BSx5W/ePzSxgNYkXxnFVO+S6A7In5vF/eLkbsKGIt2LC6kFp/6GqIlWrepi28GXQPDwjqGHMBecIv5ehmbJHUdAEiXN77/U/78ucXCUjCreVTNtEiAd5+3exDCJHmWmweHB/bFtCBi+wt6mmcCjfG79CGnM9qN76HkmyN9Exw0xnu43c1YXbYiQni0NoLnBnwW54DRhkJQnGiAMlYOsHVSkRd2TUUMWoFvdaj3XAq/QeDSqGiOvWuGb54vQUjBBbpcyam5Fzy5AhsS1avr4N6zFnsZtbxCJhrJ0e3TFcTufZ+82FB92s1IDtte2gMLEdS7pZmTYPSdyrMjnezRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eg4JfCskm9N5zxD5MmkCYITia79xM04fV+nVL3r7wPQ=;
 b=ueQVjK5KDpGoKdRpWH+f2AwzfT4tQLhx/AH6PAkkT17NEoYa6jv1QUGjyZ9BZrfBE66FNIuAswrGcVuBuUc+LCkOUmifJnQmz0MmOFfCm0tpT9Kn2sDFixDfm1aFqINT+dKmMM7M55AqQwNU4o42vx+x3AEUtnOHgLdfdhIeg3fd13QEjFiQLAvjEZl/JH4BeUlIEKLbKH5YqK55qNKoD00sK+EfoSPYfXWIVTSgggtDuHayfFXEreMZF69+qDtCjhAdHhTUfqHTOnwOGPd+ZZaV6MwXZ7gKOezVtRjXPqCNtGw5S0qxmLdv7BYWZQ8gOo7D7+hjRZPvc2oueQS0rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eg4JfCskm9N5zxD5MmkCYITia79xM04fV+nVL3r7wPQ=;
 b=dCagpeOSRRDq77d1KR0MlocowvADzAOY8PQKTizH3+35ODYRu+i56ZNLFLlbRHcDVjrvjMKTjLbsGZCGEUYejaKo7res4mqpoV+tY5nUzSArhUmbhMXgksHUtKy98RmDK9GCaEMV7yNVdp97x6RDfgmlN00QoQ0wuEeVVLOdq/I=
Received: from MW4PR03CA0334.namprd03.prod.outlook.com (2603:10b6:303:dc::9)
 by BN7PPFED9549B84.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Wed, 28 Oct
 2026 08:57:54 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:303:dc:cafe::13) by MW4PR03CA0334.outlook.office365.com
 (2603:10b6:303:dc::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 08:57:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 08:57:52 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 03:57:51 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 28 Oct 2026 03:57:49 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <timur.kristof@gmail.com>, <Mario.Novales@amd.com>, 
 <Manu.Rastogi@amd.com>, <Jiongyu.Zhu@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH v3 06/15] drm/amdgpu/gfx11: add a gfx engine reset
Date: Wed, 28 Oct 2026 16:56:37 +0800
Message-ID: <20261028085736.3808569-6-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261028085736.3808569-1-Jesse.Zhang@amd.com>
References: <20261028085736.3808569-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|BN7PPFED9549B84:EE_
X-MS-Office365-Filtering-Correlation-Id: f3d19bfc-f80c-41b1-2c78-08df34d18d0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|22082099003|6133799003|18002099003|261026140227099003|261021123027099003|261021121427099003|56012099006|11063799006|10067099003|261009223027099003|261022075727099003|261022105027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: lrqcypaiT7xVY3fWiwq+4EbnW18iQX/9MD8il4IjpU50r0PiLpMK030MJONUuSK6lnItvCiAoBw8/BJNSdMh1knMsx3FkSNbpiVkhNSdani/Wc4sn/5fxXlmusbgXX/lECacVl7nD2q9VjIoQG74hK8ZK4oe6mYeR9jNc0OdvyPDaBDBmpWV8B5AbzTcpTC6yTlGZVHcoSnHO408fr8yo36LyKmEHjzl9bsn25MmtcICKWx262WPJmHc1gWKzi+36lwU83SvWjz3pNZy9AniY7gQuF0an2pUabFjC2pN4UcxsGlgVdIJ2g//8vdkS53xQQxtAsx6/H3iSbXByHlziW1sPucNtwJ8mmE4+lXQBQB+IHZGB6N4wt08bNw9K2tmUuu2mfYZ06/XXprirc/ZpkpwffdFbsJdw50kpkVg48lHkqIEXfte8qw+69+9PJCO2H0DH0QMXpKicXETgyoihY5KBY8CcW4zTa3ssa/VQnqksQboNVzOH5DM7oOMxLzJThWB0ltssmCNK+79ZnK9OLkpWYaXCeVNtTLc0ZfQyCexk+DRLykRnDsv88yu17MGkAR+mHejGb3RAfQcBCaOt9k0gtpLdWeFwVUBV1Qwf2A8TW9kAiIgusuL1NzcOQggOqDnUFbhygj9wxVqOugS6M+/t01tJ0Pw7VZFPx5TRJj/7vXfh+YVg/ztazsnh9yx
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(22082099003)(6133799003)(18002099003)(261026140227099003)(261021123027099003)(261021121427099003)(56012099006)(11063799006)(10067099003)(261009223027099003)(261022075727099003)(261022105027099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zRMHE6XAzgqAXvFPIi1EZLrQaFKZ1wHEDnBr0PMHo9eKU3Ny0rwON5JaYMwM1FwJ7MJfkLx3Jy7mHsUvNq+LTDkE03tTKs81KqfjmvUJXJNn5RFUY4/ph0/Nuh3apHxnDUoGzWVottvfCyvp8F1rDT6xxMiNO1YtCjYYowFvVX4o/xSphIPJYWNRjugILOjllt253djABcLK+j2nDn0rdySEwLiTFRk9hJyJ3wJg3wi2ThFwhOq5XDeJBFct2+6M1rN3iq4SiWQ43diqTQQentTZFkWbICJQjNHcwpoVLzumE3hlOWw3BWw8KYwI6hid6kTIVk9WQHpnSVPKdT6Y01pkAVGJHefCnJ8L2HTLKJWM8z/WjsodVIR18q1sUaOU0QMRlQ1spDlolDUGfO2Vo7w/C3BF9PGxt1EFS3m14DHNu9L92HLAS/H/lp70CxPU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 08:57:52.7804 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d19bfc-f80c-41b1-2c78-08df34d18d0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFED9549B84
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

Implement the reset_engine callback for the graphics engine of gfx11, as
for gfx12:
- halt PFP/ME and wait for the memory requests of the CP DMA to complete;
- with CP_SOFT_RESET_CNTL.GFX_ONLY_SOFT_RESET and GFX_HQD_REG_RESET set,
  pulse GRBM_SOFT_RESET.SOFT_RESET_CPF/CPG, holding the MES lock, and
  wait for the memory requests again;
- clear CP_VMID_RESET;
- restart PFP/ME from the start of their RS64 firmware and restore
  CP_PFP_IB_CONTROL; if the CP doesn't go idle then, fail the reset so
  that a full reset follows;
- remap the kernel gfx queue through MES from its MQD backup and restart
  it with gfx_v11_0_cp_gfx_start().

MES resets a gfx queue by writing CP_VMID_RESET, which the PFP handles.
When the PFP hung, eg. on a bad opcode, the request stays pending across
the CPF/CPG reset, and the restarted PFP then waits on it forever for
queues the reset already cleared.

gfx11 has no helper to restart PFP/ME from their start addresses outside
of the firmware load: add one. A later patch enables the reset with
MES, async gfx rings and the RS64 firmware.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 176 +++++++++++++++++++++++++
 1 file changed, 176 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 315dfd806d56..e533a5939d02 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -363,6 +363,8 @@ static void gfx_v11_0_ring_invalidate_tlbs(struct amdgpu_ring *ring,
 static void gfx_v11_0_set_safe_mode(struct amdgpu_device *adev, int xcc_id);
 static void gfx_v11_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id);
 static void gfx_v11_0_userq_priv_fault_work(struct work_struct *work);
+static int gfx_v11_0_reset_engine(struct amdgpu_device *adev,
+				  enum amd_ip_engine engine);
 static void gfx_v11_0_update_perf_clk(struct amdgpu_device *adev,
 				      bool enable);
 
@@ -1150,6 +1152,7 @@ static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_funcs = {
 	.get_gfx_shadow_info = &gfx_v11_0_get_gfx_shadow_info,
 	.get_hdp_flush_mask = &amdgpu_gfx_get_hdp_flush_mask,
 	.detect_hung_queue = &gfx_v11_0_detect_hung_queue,
+	.reset_engine = &gfx_v11_0_reset_engine,
 };
 
 static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev)
@@ -6916,6 +6919,179 @@ static void gfx_v11_0_emit_mem_sync(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
 }
 
+/* Restart the PFP and ME pipes from the start of their RS64 firmware. */
+static void gfx_v11_0_restart_gfx_rs64(struct amdgpu_device *adev)
+{
+	const struct gfx_firmware_header_v2_0 *pfp_hdr, *me_hdr;
+	u32 pipe_id, tmp;
+
+	pfp_hdr = (const struct gfx_firmware_header_v2_0 *)adev->gfx.pfp_fw->data;
+	me_hdr = (const struct gfx_firmware_header_v2_0 *)adev->gfx.me_fw->data;
+
+	mutex_lock(&adev->srbm_mutex);
+	for (pipe_id = 0; pipe_id < adev->gfx.me.num_pipe_per_me; pipe_id++) {
+		soc21_grbm_select(adev, 0, pipe_id, 0, 0);
+		WREG32_SOC15(GC, 0, regCP_PFP_PRGRM_CNTR_START,
+			     (pfp_hdr->ucode_start_addr_hi << 30) |
+			     (pfp_hdr->ucode_start_addr_lo >> 2));
+		WREG32_SOC15(GC, 0, regCP_PFP_PRGRM_CNTR_START_HI,
+			     pfp_hdr->ucode_start_addr_hi >> 2);
+		WREG32_SOC15(GC, 0, regCP_ME_PRGRM_CNTR_START,
+			     (me_hdr->ucode_start_addr_hi << 30) |
+			     (me_hdr->ucode_start_addr_lo >> 2));
+		WREG32_SOC15(GC, 0, regCP_ME_PRGRM_CNTR_START_HI,
+			     me_hdr->ucode_start_addr_hi >> 2);
+
+		tmp = RREG32_SOC15(GC, 0, regCP_ME_CNTL);
+		if (pipe_id == 0) {
+			tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, PFP_PIPE0_RESET, 1);
+			tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, ME_PIPE0_RESET, 1);
+		} else {
+			tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, PFP_PIPE1_RESET, 1);
+			tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, ME_PIPE1_RESET, 1);
+		}
+		WREG32_SOC15(GC, 0, regCP_ME_CNTL, tmp);
+		if (pipe_id == 0) {
+			tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, PFP_PIPE0_RESET, 0);
+			tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, ME_PIPE0_RESET, 0);
+		} else {
+			tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, PFP_PIPE1_RESET, 0);
+			tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, ME_PIPE1_RESET, 0);
+		}
+		WREG32_SOC15(GC, 0, regCP_ME_CNTL, tmp);
+	}
+	soc21_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+}
+
+/* The CP DMA and the interfaces its memory requests go through */
+#define GFX11_CP_STAT_MEM_BUSY	(CP_STAT__DMA_BUSY_MASK | \
+				 CP_STAT__TCIU_BUSY_MASK | \
+				 CP_STAT__RCIU_BUSY_MASK | \
+				 CP_STAT__UTCL2IU_BUSY_MASK)
+
+/*
+ * Soft reset the gfx CP and restart PFP and ME. Returns 0, or -ETIMEDOUT if the
+ * CP doesn't go idle after PFP and ME are restarted.
+ */
+static int gfx_v11_0_soft_reset_gfx_cp(struct amdgpu_device *adev)
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
+		if (!(RREG32_SOC15(GC, 0, regCP_STAT) & GFX11_CP_STAT_MEM_BUSY))
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
+		if (!(RREG32_SOC15(GC, 0, regCP_STAT) & GFX11_CP_STAT_MEM_BUSY))
+			break;
+		udelay(1);
+	}
+
+	/* A CP_VMID_RESET the hung PFP never handled survives the reset. */
+	WREG32_SOC15(GC, 0, regCP_VMID_RESET, 0);
+	amdgpu_mes_unlock(&adev->mes);
+
+	gfx_v11_0_restart_gfx_rs64(adev);
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
+static int gfx_v11_0_reset_engine(struct amdgpu_device *adev,
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
+	r = gfx_v11_0_soft_reset_gfx_cp(adev);
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
+	r = gfx_v11_0_cp_gfx_start(adev);
+
+exit:
+	amdgpu_gfx_off_ctrl(adev, true);
+	return r;
+}
+
 static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 			       unsigned int vmid,
 			       struct amdgpu_fence *timedout_fence)
-- 
2.50.1


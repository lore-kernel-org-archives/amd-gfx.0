Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA4BBFEC11B
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 21:21:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5981F10E633;
	Tue, 24 Mar 2026 21:21:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PPaLONoR";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010059.outbound.protection.outlook.com [52.101.201.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AC8E10E601
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 21:21:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GWS3hnRt/fP62ysKqxsYL8/M+oNkj7k7i8IZ3XR0nKmclu+uAnklVzZBCA6Tk2OxhBwfY/0DAsiAkO1lxHbPu6CtB5MzPejlaDkSIcqdKssEe9fQw0jTE2c9Qg7RnON/84IdmU4OFGTNYZp9UpDeWik2X9urWkIvkr+m5rK/uA1eWWXzZV6/7U0wVt03OwvFhCqy3doia4N/4Mbpo4IAV0FWMFjA9i0OAcKc2TcQHoQVBCYKTJ0sJ6Qv8JAl0I1+b39ji4mK4UuJPS6lnd5gfDaXAbPONpzLtjt80mH805z4MnPA22VzbbIIdqCz83PqlXQOBVorkPlPN7+cDk0zfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QurdkCtLzrPIbK1B3pzGBq1okB9fg63CmTSafzPy8l0=;
 b=C2wJZnC8FLq35IIzLkfAkryazQEpaLGENHHVs0flfhX0P7uK6EgMhzsy+Hnq6OUlOHVnp82eazFPardmxJ4itk/Lao0bh5KK6d+7quRbSbbXlEp5D+OqPhnBs2XKcTtYug/XeLN6nweNSGnaGoBEw8nIlErc/2ayaQILoC/hI1FN1Xj1AwaEJZwNapB8093KeVF/K92xuXDDQ9SqUhZxMMqIsuoyiWWJeBc1kLRiqGWwK5ogDnv+G99h9DD0+QkkZRv4FOEt5swgxrwpP/BFuDtTlXw9G8LSbRc/J0ES/Ofzeoksi33mSHMp0MzxiVfRotmsuKaXZwRo7/XJyuyCRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QurdkCtLzrPIbK1B3pzGBq1okB9fg63CmTSafzPy8l0=;
 b=PPaLONoRDrDk4i/kQb7oWExPAhHDfVOc5CGy+p3HyoSJEluaO+OW3wlUN0T3xcq28QeAFUHKziZ/HEc3f/jUtlIo7bVgrdyVTm3vuJ6OQP87TrrrcZtQnrjBtUZWV9xTmC3BmtCko4xu6DUqjs2c4Q0qf8C2PFS6gg5WKz6gZHg=
Received: from SA1PR03CA0016.namprd03.prod.outlook.com (2603:10b6:806:2d3::18)
 by MN0PR12MB5785.namprd12.prod.outlook.com (2603:10b6:208:374::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Tue, 24 Mar
 2026 21:21:03 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:806:2d3:cafe::c6) by SA1PR03CA0016.outlook.office365.com
 (2603:10b6:806:2d3::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 21:20:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 21:21:02 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Mar
 2026 16:20:48 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <Bing.Ma@amd.com>, <David.Francis@amd.com>
CC: <Jesse.Zhang@amd.com>, <Jenny-Jing.Liu@amd.com>, <jamesz@amd.com>
Subject: [PATCH v2 16/17] drm/amdgpu: add profiler/spm support for gfx9
Date: Tue, 24 Mar 2026 17:20:29 -0400
Message-ID: <20260324212030.822932-17-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324212030.822932-1-James.Zhu@amd.com>
References: <20260324212030.822932-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|MN0PR12MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: e82ba62e-770f-4870-1f05-08de89eb4099
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: qoOGRYHVK+YNpcmTaW5Gg5uy4wbJeJ1WLPogx6wRBCXhQeZsYG4+R10k+FIm2KdD7yFa3eC7Vg9Cfl6mTZEcRcvOK8N7FAV4/iAGWIESwKPr2KyNUWdjg8Xr8H6PIaCwYrKpRImXZP+2NvdgubIuyr5vWMPrY54uIf9QPA0YtL2omk8q2fGId6kBKwgjptA4LoecMhSrIdw8wkVazLZN6N0iAqCB98NLjlzWI7oDUXjtAnmYMVIhpnrTlQr2v/UCB8jT6vBCUEt+J9o42JB0ntkhH4NVIsZ3MkFT586d1SaSoF1FeGniAKAzZzEhEquBggqEfGaW3tEJjMW/9c8rriNpkrP1g5lSRE0afbD7v+VVLKMYPgqV4x1gXtHxKAicpjkH18TxYLtBbiUtByu8jU32XUhKjIeAlGWobAhBIFoa0ghFwK2uuNBqtiUN8QPo0hh/vb7CDgwnJtvuiC3ImD3ZHOCB8/sOf+7bGc/E+54DSHFknFuXQA9rG5xfWZRs1FBQ16VVq4nKsFSZrmKyqyeOqolV3iDz1xfQdzHHRZP1cxkV2nMfkE9IaDnWnVXrqCHVdjjZk9qOhFBxwa9SoGmWmRrKoFkYiuXeW6MdFKa2Su+5sDC4YobC0cRBffzlEyQXg9Wsb4yGOhiL6mXzTJ7hH4i2LUEU6oH9WrE2UviWslj03TvATlcdHZySwQuTWgh3JpLHitgAL3OV5mBZuhBVXUdhCGIqlGn/nsrwu0cS5ZNN3Ah8p5ByRSDcDpWxSRXZAMzu/xp4/POUKd0Fmw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Hk3wPJSxzrNj/GzGGdo+9u5JbUm6rr1aAbx8VXXxjT4uhLY96O04t69yGA80csnkHYZt6CEEiCREwVxI3IDRH8VPPB8f+fYAy9Q3E3CKWEG6aOWkQQ17Ch2TMtk2Jfg2/7vPV99/y4YtYuVuR/l0xp5NX5D2PgbmzO6hMHcalUo3SklZGfZvdB+En3Kcsg4sPnhY0xJXRuLlGUFkiccche12cg74RMPSqyDzsJdDmjr1Zpuoxop4ifMO+Y7rsmJnxoFZ9VXVbMC5WainpaTQiCEjzYZyIXEH9fclsZhYC6OfYviJYdGq97v6qMu3WZfs3ZHHbiH8+/JVaS9W1D/8D0bFDmRlwf0wdNXUOagBh7UQaCC04bMreqntagAKWaKp+EDqBX+aT67IwSWBxchdhqrqNXz5jmCVvG+p1TwpXKAtOdC46iIdaYf2ocAKPnBR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 21:21:02.6623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e82ba62e-770f-4870-1f05-08de89eb4099
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5785
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

with implementation of amdgpu_spm_funcs callbacks for the GFX 9.0 IP block
and wire up the RLC Stream Performance Monitor interrupt
GFX_9_0__SRCID__RLC_STRM_PERF_MONITOR_INTERRUPT into the IRQ framework.

SPM function table (gfx_v9_0_spm_funcs):
  gfx_v9_0_spm_start(adev, 0):
    Programs the KIQ ring to:
    - Read-modify-write RLC_SPM_PERFMON_CNTL to set PERFMON_RING_MODE
      (0x1 = stall-on-full with interrupt at segment threshold).
    - Write CP_PERFMON_CNTL.SPM_PERFMON_STATE =
      CP_PERFMON_STATE_DISABLE_AND_RESET to reset the SPM counters and
      clear wptr to 0; manually resets RLC_SPM_RING_RDPTR to 0 to match.
    - Writes RLC_SPM_INT_CNTL = 1 to enable the SPM interrupt.

  gfx_v9_0_spm_stop(adev, 0):
    Programs the KIQ ring to:
    - Set CP_PERFMON_CNTL.SPM_PERFMON_STATE = STOP_COUNTING.
    - Set CP_PERFMON_CNTL.PERFMON_STATE = DISABLE_AND_RESET.
    - Reset RLC_SPM_RING_RDPTR to 0 (wptr is also reset by hardware).

  gfx_v9_0_spm_set_rdptr(adev, 0, rptr):
    Writes rptr to RLC_SPM_RING_RDPTR via KIQ ring.

  gfx_v9_0_set_spm_perfmon_ring_buf(adev, 0, gpu_addr, size):
    Programs the ring buffer via KIQ ring:
    - RLC_SPM_PERFMON_RING_BASE_LO/HI with the GPU address.
    - RLC_SPM_PERFMON_RING_SIZE with the buffer size.
    - RLC_SPM_SEGMENT_THRESHOLD = 1.
    - CP_PERFMON_CNTL = 0 (clear any leftover perfmon state).
    set_spm_config_size = 30 DWORDs per KIQ ring operation.

  gfx_v9_0_spm_funcs is registered in gfx_v9_0_set_spm_funcs(), called
  from gfx_v9_0_early_init() before KIQ and ring function setup.

SPM IRQ handling:
  The SPM interrupt source is registered in gfx_v9_0_sw_init() via
  amdgpu_irq_add_id() with client SOC15_IH_CLIENTID_RLC and source ID
  GFX_9_0__SRCID__RLC_STRM_PERF_MONITOR_INTERRUPT, connected to
  adev->gfx.spm_irq.

  gfx_v9_0_spm_set_interrupt_state(): enables or disables the SPM
  interrupt by writing RLC_SPM_INT_CNTL = 1/0 via direct MMIO.

  gfx_v9_0_spm_irq(): called from the interrupt handler, invokes
  amdgpu_rlc_spm_interrupt(adev, 0) for XCC 0 (gfx9 is single-XCC).

  amdgpu_irq_get(spm_irq) is called in gfx_v9_0_late_init() to enable
  the interrupt at the IRQ framework level. amdgpu_irq_put(spm_irq) is
  called in gfx_v9_0_hw_fini() to disable it.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |   1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 135 ++++++++++++++++++++++++
 2 files changed, 136 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 016eed89d6f3..30df02d322b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -472,6 +472,7 @@ struct amdgpu_gfx {
 	struct amdgpu_irq_src		priv_inst_irq;
 	struct amdgpu_irq_src		bad_op_irq;
 	struct amdgpu_irq_src		cp_ecc_error_irq;
+	struct amdgpu_irq_src		spm_irq;
 	struct amdgpu_irq_src		sq_irq;
 	struct amdgpu_irq_src		rlc_gc_fed_irq;
 	struct sq_work			sq_work;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 7e9d753f4a80..7435032c358a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2275,6 +2275,13 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->gfx.mec.num_pipe_per_mec = 4;
 	adev->gfx.mec.num_queue_per_pipe = 8;
 
+	/* SPM */
+	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_RLC,
+			      GFX_9_0__SRCID__RLC_STRM_PERF_MONITOR_INTERRUPT,
+			      &adev->gfx.spm_irq);
+	if (r)
+		return r;
+
 	/* EOP Event */
 	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_GRBM_CP, GFX_9_0__SRCID__CP_EOP_INTERRUPT, &adev->gfx.eop_irq);
 	if (r)
@@ -4056,6 +4063,7 @@ static int gfx_v9_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
 		amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
+	amdgpu_irq_put(adev, &adev->gfx.spm_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
 
@@ -4793,6 +4801,95 @@ static int gfx_v9_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 	return r;
 }
 
+static void gfx_v9_0_spm_start(struct amdgpu_device *adev, int xcc_id)
+{
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[0].ring;
+	uint32_t data = 0;
+
+	data = RREG32_SOC15(GC, 0, mmRLC_SPM_PERFMON_CNTL);
+	data |= RLC_SPM_PERFMON_CNTL__PERFMON_RING_MODE_MASK;
+	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_PERFMON_CNTL), data);
+
+	data = REG_SET_FIELD(0, CP_PERFMON_CNTL, SPM_PERFMON_STATE,
+			CP_PERFMON_STATE_DISABLE_AND_RESET);
+	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, 0, mmCP_PERFMON_CNTL), data);
+
+	/* When SPM is reset, RLC automatically resets wptr to 0.
+	 * Manually reset rptr to match this.
+	 */
+	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_RING_RDPTR), 0);
+
+	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_INT_CNTL), 1);
+}
+
+static void gfx_v9_0_spm_stop(struct amdgpu_device *adev, int xcc_id)
+{
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[0].ring;
+	uint32_t data = 0;
+
+	data = REG_SET_FIELD(0, CP_PERFMON_CNTL, SPM_PERFMON_STATE,
+			CP_PERFMON_STATE_STOP_COUNTING);
+	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, 0, mmCP_PERFMON_CNTL), data);
+
+	data = REG_SET_FIELD(0, CP_PERFMON_CNTL, PERFMON_STATE,
+			CP_PERFMON_STATE_DISABLE_AND_RESET);
+	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, 0, mmCP_PERFMON_CNTL), data);
+
+	/* When SPM is reset, RLC automatically resets wptr to 0.
+	 * Manually reset rptr to match this.
+	 */
+	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_RING_RDPTR), 0);
+}
+
+static void gfx_v9_0_spm_set_rdptr(struct amdgpu_device *adev, int xcc_id,  u32 rptr)
+{
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[0].ring;
+
+	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_RING_RDPTR), rptr);
+}
+
+static void gfx_v9_0_set_spm_perfmon_ring_buf(struct amdgpu_device *adev,
+					    int xcc_id, u64 gpu_addr, u32 size)
+{
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[0].ring;
+
+	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0,
+			mmRLC_SPM_PERFMON_RING_BASE_LO), lower_32_bits(gpu_addr));
+
+	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, 0,
+				mmRLC_SPM_PERFMON_RING_BASE_HI), upper_32_bits(gpu_addr));
+
+	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_PERFMON_RING_SIZE), size);
+	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_SEGMENT_THRESHOLD), 0x1);
+
+	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, 0, mmCP_PERFMON_CNTL), 0);
+}
+
+static const struct amdgpu_spm_funcs gfx_v9_0_spm_funcs = {
+	.start = &gfx_v9_0_spm_start,
+	.stop = &gfx_v9_0_spm_stop,
+	.set_rdptr = &gfx_v9_0_spm_set_rdptr,
+	.set_spm_perfmon_ring_buf = &gfx_v9_0_set_spm_perfmon_ring_buf,
+	.set_spm_config_size = 30,
+};
+
+static void gfx_v9_0_set_spm_funcs(struct amdgpu_device *adev)
+{
+	adev->gfx.spmfuncs = &gfx_v9_0_spm_funcs;
+}
+
 static int gfx_v9_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -4807,6 +4904,7 @@ static int gfx_v9_0_early_init(struct amdgpu_ip_block *ip_block)
 	adev->gfx.xcc_mask = 1;
 	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
 					  AMDGPU_MAX_COMPUTE_RINGS);
+	gfx_v9_0_set_spm_funcs(adev);
 	gfx_v9_0_set_kiq_pm4_funcs(adev);
 	gfx_v9_0_set_ring_funcs(adev);
 	gfx_v9_0_set_irq_funcs(adev);
@@ -4862,6 +4960,10 @@ static int gfx_v9_0_late_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	r = amdgpu_irq_get(adev, &adev->gfx.spm_irq, 0);
+	if (r)
+		return r;
+
 	r = amdgpu_irq_get(adev, &adev->gfx.priv_inst_irq, 0);
 	if (r)
 		return r;
@@ -7100,6 +7202,32 @@ static void gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
 	gfx_v9_0_query_utc_edc_status(adev, err_data);
 }
 
+static int gfx_v9_0_spm_set_interrupt_state(struct amdgpu_device *adev,
+					     struct amdgpu_irq_src *src,
+					     unsigned int type,
+					     enum amdgpu_interrupt_state state)
+{
+	switch (state) {
+	case AMDGPU_IRQ_STATE_DISABLE:
+		WREG32_SOC15(GC, 0, mmRLC_SPM_INT_CNTL, 0);
+		break;
+	case AMDGPU_IRQ_STATE_ENABLE:
+		WREG32_SOC15(GC, 0, mmRLC_SPM_INT_CNTL, 1);
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+static int gfx_v9_0_spm_irq(struct amdgpu_device *adev,
+			     struct amdgpu_irq_src *source,
+			     struct amdgpu_iv_entry *entry)
+{
+	amdgpu_rlc_spm_interrupt(adev, 0);
+	return 0;
+}
+
 static void gfx_v9_0_emit_wave_limit_cs(struct amdgpu_ring *ring,
 					uint32_t pipe, bool enable)
 {
@@ -7716,12 +7844,19 @@ static const struct amdgpu_irq_src_funcs gfx_v9_0_cp_ecc_error_irq_funcs = {
 	.process = amdgpu_gfx_cp_ecc_error_irq,
 };
 
+static const struct amdgpu_irq_src_funcs gfx_v9_0_spm_irq_funcs = {
+	.set = gfx_v9_0_spm_set_interrupt_state,
+	.process = gfx_v9_0_spm_irq,
+};
 
 static void gfx_v9_0_set_irq_funcs(struct amdgpu_device *adev)
 {
 	adev->gfx.eop_irq.num_types = AMDGPU_CP_IRQ_LAST;
 	adev->gfx.eop_irq.funcs = &gfx_v9_0_eop_irq_funcs;
 
+	adev->gfx.spm_irq.num_types = 1;
+	adev->gfx.spm_irq.funcs = &gfx_v9_0_spm_irq_funcs;
+
 	adev->gfx.priv_reg_irq.num_types = 1;
 	adev->gfx.priv_reg_irq.funcs = &gfx_v9_0_priv_reg_irq_funcs;
 
-- 
2.34.1


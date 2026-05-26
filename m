Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C526CD5BB1
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 14:12:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 962FA10E67E;
	Tue, 26 May 2026 14:12:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5lY+KuTX";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011000.outbound.protection.outlook.com [52.101.57.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A76F10E68C
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 14:12:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WFXMW8thdA6LHv8ZBHDXqTOFSmEYpw27fLjPWIFD8MZ0OS4+qEkdvF/rw5WK7R7oTpd3EDnoSiNUAFL1ReaqDLqtSMfPaRwts2HYtj9oYFtB+YplF4yjqL33ChYy3scaQC3HCf0Rc51/u4XjrmSeXKqUpbH+SwtJE4WKrFkalZ1Xj7Wu8TidYYTFlnQlrEX2bnHE3LndX87LOAU7uvbICSef4L2+q+a/TI4wf/viZOWknVZK6SX1sXG7objuT8bwZ0/SE66RsYjC/iMdxDzKdDdIqhgF6RRB8X673YqYK9kA0oUWGNa8dZDZJQix7yZ7cZCzEZstK9t9b5DWqo+Ldg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FO7wHy/z0jxbAOCnXNELEfCRhRvnMYaKiIjWtPq9VBc=;
 b=EqRAHYo3C3m426tjwci6/c0ffAMdMxKTFbu5e8aoMuGodneY6HlYQMjdVuaNf0Xbrut/VhBvIWeij9S8ztJiyU9k62I1e67qw8ce5m7xyR0w8zA77KO7Kd9O7c9EYXOElq8V8+DELTPyrqdxmcWfgrjl9YScijy/b8BgUNvobjAAq0M6EvtSJulIgb0V3mlw2Tn39K9R6YIVORDcC+tDZhXNeTgCWjnqV+Ie2qO1+3WOOe03dXKzk/VMkwTOfzSnUYF55nPwFwIwf5nYltFi9JqiN8DMeuQmTlWE+XJ8R+FHkx8ntonLfthWSBLVw54cB9vY2yRMzkpYFPqeLHWEpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FO7wHy/z0jxbAOCnXNELEfCRhRvnMYaKiIjWtPq9VBc=;
 b=5lY+KuTXx9kAsBslgLoEkv8OuFdsoDEiD+aOkkCpHkbwsAskj+UCROlZSDaU6f6ZaM4Uctz27Ue3CqCtnsJoZpHXBZJiFt9M4Y74Z2yozqfBozYdJCAZGZ+ankDJ6+mCAmEPQtpfu4ILn5XICTJzwmflWe++ipp8EUJtxw37RX0=
Received: from BN9PR03CA0679.namprd03.prod.outlook.com (2603:10b6:408:10e::24)
 by BN5PR12MB9485.namprd12.prod.outlook.com (2603:10b6:408:2a8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 14:12:05 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::94) by BN9PR03CA0679.outlook.office365.com
 (2603:10b6:408:10e::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Tue, 26
 May 2026 14:12:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 14:12:05 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 09:11:55 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Bing.Ma@amd.com>, <jamesz@amd.com>
Subject: [PATCH v4 16/17] drm/amdgpu: add profiler/spm support for gfx9
Date: Tue, 26 May 2026 10:11:28 -0400
Message-ID: <20260526141129.592886-16-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260526141129.592886-1-James.Zhu@amd.com>
References: <20260526141129.592886-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|BN5PR12MB9485:EE_
X-MS-Office365-Filtering-Correlation-Id: 04345ddc-3ee0-4ef6-e8e4-08debb30c3ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|5023799004|11063799006|6133799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: LYYKznMlFW6s1g10CivkC4NIJ7P4AmphGBcs1gtmmzhGJglvthHTBzPnRHx/sH/ChVB1YrDOELngeXkWEwUiJ8L/quSIFK1hBcTLyENXUI+UFQGjqo3NEzxWM8i66ZN6dKvrK4EagrkF0eaxrNutB/lFXxC8WLirfiFgGUuGy/9tqrFHlY+LLQcJZv+0WNbjFtx8MgIbP3Y0hyKSSRAVx4SPxtyfF0/QRLjM87wpw+fXCmJA4SuSz5CPIgXImGr5+LbzYIreM8jnOYHcKTT/wng3hFUueGma2+SjENbREy5KEIpO8b18GG0h4pe2ImCiYN8yt7ZkxJCx7NzuJHPSek20nv+bH6kSARGyiJluXJj3RsbFUNxU8fIoo0cQSL6lwOAHUXIFE7W1Mf9vwqW5AXTdYrNBscP5lwi2rl2ZX9X1ZqvGYfr45c2IMxQKkbPKMwqKPi55qTitwFgfm+o8DH0CvV9ZUyKdtnZw31H3oTi4J6TQU3gpSpDSo/tPGRwJvNhvj1ToskLrJcTRH7lR6N0jWB6E0zX6w9bavMmqW+3t0nYYkmlI+c5pQN75dGrRI07IzQaQw7x7QMoeDArK8bK+fZyur/kWAu4b0//jtujsMUXOSVGesFddZ9+rLZKqJVuokf8Vxpz2D1+7jVmGyfQVTxmqxwiFFPlgPKIZDGc2LV+7vvVdpS9vEdVaUsn+YmhApOWnCoadXGq9CAzJR+k2AmCS6rRmViGTGZrX2KQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(5023799004)(11063799006)(6133799003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ne7VuX3ZsjT0GJXpu1VSyXnbrfnSBB4AkkcuyK0nDXt3IgwGg+Q1g+1XrzPT6K87byyTqhk6oZc/pcwubnP8FjOoKjrDRIo9Ld4lHo2n9Tuic4NXy30G5ypjgoKadQO+Sl7FlJiefWO/zidbiX0m5lw+FrGtAVyS5qsUQIefq6+6vLBaTJxa/RN6dCieFuJAE6BrzdyOd2sY+70J3L4e7RqZEi5fNw+xfz2Cz6Wk0cYRyJrEJCidhL6sPazl6qZ53xq+9pDoVOqvHzTgVsodVlv+OuZB+P2TvPjS0KDPXgxLH0s5klKLuHnAt3yYK62MwXTfc2zHmy06GDALudRy165EZ92B+6tZB4mA8fPj7xUQFpQ2JE+S04pjn7SYfUp79iSboUYSQp3jjm1lVxqehwVFq/7EalRytMARSB8yctyV1G0yFzwzBCPEzIw7ta85
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 14:12:05.2732 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04345ddc-3ee0-4ef6-e8e4-08debb30c3ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9485
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
Reviewed-by: Bing Ma <Bing.Ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |   1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 135 ++++++++++++++++++++++++
 2 files changed, 136 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index b126ce881fae..e4506dd6b621 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -477,6 +477,7 @@ struct amdgpu_gfx {
 	struct amdgpu_irq_src		priv_inst_irq;
 	struct amdgpu_irq_src		bad_op_irq;
 	struct amdgpu_irq_src		cp_ecc_error_irq;
+	struct amdgpu_irq_src		spm_irq;
 	struct amdgpu_irq_src		sq_irq;
 	struct amdgpu_irq_src		rlc_gc_fed_irq;
 	struct amdgpu_irq_src		rlc_poison_irq;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 2eb32f92a77c..4cc7001c1e2f 100644
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
@@ -4060,6 +4067,7 @@ static int gfx_v9_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
 		amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
+	amdgpu_irq_put(adev, &adev->gfx.spm_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
 
@@ -4797,6 +4805,95 @@ static int gfx_v9_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
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
@@ -4811,6 +4908,7 @@ static int gfx_v9_0_early_init(struct amdgpu_ip_block *ip_block)
 	adev->gfx.xcc_mask = 1;
 	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
 					  AMDGPU_MAX_COMPUTE_RINGS);
+	gfx_v9_0_set_spm_funcs(adev);
 	gfx_v9_0_set_kiq_pm4_funcs(adev);
 	gfx_v9_0_set_ring_funcs(adev);
 	gfx_v9_0_set_irq_funcs(adev);
@@ -4866,6 +4964,10 @@ static int gfx_v9_0_late_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	r = amdgpu_irq_get(adev, &adev->gfx.spm_irq, 0);
+	if (r)
+		return r;
+
 	r = amdgpu_irq_get(adev, &adev->gfx.priv_inst_irq, 0);
 	if (r)
 		return r;
@@ -7104,6 +7206,32 @@ static void gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
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
@@ -7720,12 +7848,19 @@ static const struct amdgpu_irq_src_funcs gfx_v9_0_cp_ecc_error_irq_funcs = {
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


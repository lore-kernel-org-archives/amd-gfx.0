Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E5C5FEC118
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 21:21:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 099DD10E5DC;
	Tue, 24 Mar 2026 21:21:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nWQYqlHg";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010007.outbound.protection.outlook.com
 [52.101.193.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E998410E633
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 21:21:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gFb7Q/wdrvqK1DtmiCTJxUk3gINiVYmomHUh7m5znVN9CBcNEv299VU6kS+cc8J+hwvHc+haicP6QaAgbE89smaVdIIRNZV04+V4cZnw/vmikR0WOLaEGevzjyzayDp+a9VpyI220zgdxI7H0zlAZmykxO6a5klrLC8zxHi5DsIruFeAoOx4zO3HHF/Pfd73YJ9N21hII3FOBcWtvxCBkDLgkElfzFU7NNeN7FQ9okS8N2Tgv8BZkMRhrQ/eyYe5MCIU08miChN/zpRkFxENpLwIPnoRmZ4WaL/21Oh3Hq9mg7kwrqwwdKhgWT4NbdKFYNoCHyZUciRsDjhTMxxa5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SCx5TYbsLK/PGuqAd8xd9oHlvhwHZR8V4xp2Mke/Rc=;
 b=s1eUZWjJP8wgVMRnMPn4eTH3EJOH8jOyNwpJX4mUEjBmOVrnmlInmnCRD1HW1kTxjvOE8cCixVVpGzAvzBlpRwnvxcq2e9JBwtQqKTqFPXNRCjP/phrBhZCRVIROdLfFLof9yd+2Xj7VjYfeB+B5tAxfpsvyPszRA+2zbDFscMTj/pgfmPZim9t0wMegAP9o0jZQO8m6+nTLyaJSDwp/lnPXmPRoYsD+CsR6s4sKr+evd5rA7D1JxbjOjhQZunJ0jHptb9npjmJDGJJjrdJsHo+ysh3F1xtUJVxqxN2bbGFBuv9eieiA/qgbhig9L6qSzYX3UL3muc5CNGKJzyCe2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SCx5TYbsLK/PGuqAd8xd9oHlvhwHZR8V4xp2Mke/Rc=;
 b=nWQYqlHglWI2517LCZ/u2Bj8L39p/24slg4hzLOr+P9/IP85K3D0uRB+pptUtB93kJ/ay2j4cBojQYd2GHVw17ExAJaraJKKARD3WhAj4IWYGaU5nmg+MvIqZXd5Y6HnVLg03Ry5lwGVQ+yR7QYoVrC8q2yNHdvL7k1kC43FLWI=
Received: from SA1PR03CA0019.namprd03.prod.outlook.com (2603:10b6:806:2d3::21)
 by DM4PR12MB6664.namprd12.prod.outlook.com (2603:10b6:8:bb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 21:21:03 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:806:2d3:cafe::da) by SA1PR03CA0019.outlook.office365.com
 (2603:10b6:806:2d3::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 21:21:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 21:21:03 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Mar
 2026 16:20:48 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <Bing.Ma@amd.com>, <David.Francis@amd.com>
CC: <Jesse.Zhang@amd.com>, <Jenny-Jing.Liu@amd.com>, <jamesz@amd.com>
Subject: [PATCH v2 17/17] drm/amdgpu: add profiler/spm support for gfx9_4_3
Date: Tue, 24 Mar 2026 17:20:30 -0400
Message-ID: <20260324212030.822932-18-James.Zhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|DM4PR12MB6664:EE_
X-MS-Office365-Filtering-Correlation-Id: a4d494cd-8434-4bf6-1163-08de89eb410f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: PrGIEIhxM/tAOVQbZAhW7IsnAC3Kn3DoO0pRYLbwdHyz9eYBj8PIT/kjjX4hcrbVSUvZTCU1PaM0u13ckZIx3Dlq44/Ca78MrFDOOHDFiSgo6UrTdbojgnIsd6xQuP3pJKD0osJM7jxnsV1C6xp9FHL/Yoh1iGbI/0tONC6hzGih7a0pLijS32jUDNAmXpcsS+3aDUmfLD8iJQvhZV3txl9d+UpFQqZ6j0E/o0LxpWaNeJMCZ7UGoPFPazLwi+zg1jckfMjQyqb+DFcX8L2rdkMQztH8TOA7PnzfrHcv0b4bqqwxMOp/tnK7coxZ7KjzisyD12WMtwnivm28rz82cD2FLg2b0WrjaRS2UcekRHr90gwPDqi+u74iLIU1mRKK+2X+Yb18BUZ8NQfPT81/F99eI638HGCGNX6shq5UR4rSo+QdX3P71ATlZ30MhcUHXXCmPcnydZNfAOyCyqU4UWTvrlE2o4WE3EspFY8LDEvzziFYSJYtvamEMRWDZCNa9bqD74lNxsUWoQ4xLa25abQoNIlnTbc/W2Ejpom3X6wnvPTeSA3qCmCZKjgsDbqwOkordH4/uteE4/jtxPMk4NzGbkJohYgxv9LoHv8JpLi9nZWhPH1AMijUmCHrqOoW/zKnPio5LAY4Gs82jjTtfcrapTZEOzH2r4D9KJKPS1wABWJNqDHNeGHg6rngLL3Dj8LsU3U4wya9nYH5Eo2FxkSpj4f/iHvz5sGmlE2htInAZHPcteIEs4FrK2LjLEyZDGvnQdNHzdmHronlAJFEaQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6XzhhYXANtV0+tmAijCzPC4QA3FvCXO448znNCydY3lj1zfXHKElys9PBD5JvvvT6MNxDc5WRkBu03bauHj0FUPJ+7WEKjUuEg1gK28tv3pMWC9oVMd+4Z0gngYcTODg4IB2vSb2qvfI38gQuLuuJtECzApfqBm9XLKZhmzmBVXMGRVJGEQZgiW2u4hiCSl4CS3rLYGTkkmXlleOpkBGmo67vOCxmv2iIfj/YuLe5qQqTlYpQH0741StvWvQbE3ZsLOKocGYOnTzvaZZE04Z9tmA6hB5cPCR8YGDhGihnrF8nvdTdm8qXODOLVA8s8l4IhE26fAOny5pOyeM/XcTq2k/EeVWSR+E2Bxx8AxpDFYK/mFhmBKPM6qYi2z0HjrP5VugKl7vo0/dLs+FOlvi7g1ppjdqR3ccJZZtyU5SsYUph3z/cykyOWfNIOtDFL5H
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 21:21:03.4655 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d494cd-8434-4bf6-1163-08de89eb410f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6664
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

with implementation of amdgpu_spm_funcs callbacks for the GFX 9.4.3 IP
block and wire up the per-XCC RLC Stream Performance Monitor interrupt.

SPM function table (gfx_v9_4_3_spm_funcs):
  gfx_v9_4_3_spm_start(adev, xcc_id):
    Uses kiq[xcc_id].ring for the per-XCC KIQ ring. Programs:
    - Read-modify-write RLC_SPM_PERFMON_CNTL to set PERFMON_RING_MODE
      via MMIO read + KIQ write.
    - CP_PERFMON_CNTL.SPM_PERFMON_STATE = DISABLE_AND_RESET via KIQ.
    - RLC_SPM_RING_RDPTR = 0 via KIQ to match the hardware wptr reset.
    - RLC_SPM_INT_CNTL = 1 via KIQ to enable the SPM interrupt.
    - Read-modify-write RLC_CLK_CNTL to set RLC_SPM_CLK_CNTL_MASK via
      direct MMIO, gating the SPM clock domain on.

  gfx_v9_4_3_spm_stop(adev, xcc_id):
    Uses kiq[xcc_id].ring. Programs:
    - Clear RLC_CLK_CNTL.RLC_SPM_CLK_CNTL_MASK via direct MMIO.
    - CP_PERFMON_CNTL.SPM_PERFMON_STATE = STOP_COUNTING via KIQ.
    - CP_PERFMON_CNTL.PERFMON_STATE = DISABLE_AND_RESET via KIQ.
    - RLC_SPM_RING_RDPTR = 0 via KIQ.

  gfx_v9_4_3_spm_set_rdptr(adev, xcc_id, rptr):
    Writes rptr to RLC_SPM_RING_RDPTR via kiq[xcc_id].ring.

  gfx_v9_4_3_set_spm_perfmon_ring_buf(adev, xcc_id, gpu_addr, size):
    Programs via kiq[xcc_id].ring:
    - RLC_SPM_PERFMON_RING_BASE_LO/HI with the GPU address
      (currently uses GC instance 0 for base address registers).
    - RLC_SPM_PERFMON_RING_SIZE and RLC_SPM_SEGMENT_THRESHOLD = 1
      using GET_INST(GC, xcc_id) addressing.
    - CP_PERFMON_CNTL = 0.
    set_spm_config_size = 30 DWORDs per KIQ ring operation.

  gfx_v9_4_3_set_spm_funcs() registers gfx_v9_4_3_spm_funcs into
  adev->gfx.spmfuncs from gfx_v9_4_3_early_init().

SPM IRQ handling:
  The SPM interrupt source is registered in gfx_v9_4_3_sw_init() for
  client SOC15_IH_CLIENTID_RLC with source ID
  GFX_9_0__SRCID__RLC_STRM_PERF_MONITOR_INTERRUPT.

  gfx_v9_4_3_spm_set_interrupt_state(): iterates over all XCC instances
  and writes regRLC_SPM_INT_CNTL = 0/1 for each via WREG32_SOC15 with
  GET_INST(GC, i) to enable or disable the per-XCC interrupt.

  gfx_v9_4_3_spm_irq(): resolves xcc_id from the interrupt entry's
  node_id via gfx_v9_4_3_ih_to_xcc_inst(), then calls
  amdgpu_rlc_spm_interrupt(adev, xcc_id) to dispatch to the correct
  XCP's SPM manager.

update_spm_vmid refactoring:
  gfx_v9_4_3_update_spm_vmid_internal(adev, xcc_id, vmid) is
  extracted from the existing gfx_v9_4_3_update_spm_vmid() as a
  lockless helper that performs the read-modify-write on
  RLC_SPM_MC_CNTL.RLC_SPM_VMID using GET_INST(GC, xcc_id) addressing.
  The original RREG32() path is replaced with RREG32_SOC15() for
  correctness on multi-instance GC.

  gfx_v9_4_3_update_spm_vmid() now wraps the internal helper with
  amdgpu_gfx_off_ctrl(false/true) to prevent GFX power gating during
  the VMID register update, and is used for runtime vmid changes.

  gfx_v9_4_3_rlc_init() is updated to initialize the SPM VMID to 0xf
  for all XCC instances (instead of only XCC 0), and now skips the
  operation for SR-IOV VF or when update_spm_vmid is NULL.

  gfx_v9_4_3_xcc_rlc_resume() is restructured to unconditionally call
  rlc_stop() before firmware loading and rlc_start() after, regardless
  of firmware load type. gfx_v9_4_3_update_spm_vmid_internal() is
  called between stop and start to ensure the SPM VMID is correctly
  initialized to 0xf before the RLC is started for both legacy and PSP
  firmware loading paths.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 194 ++++++++++++++++++++++--
 1 file changed, 183 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index ad4d442e7345..a8371cf7ee53 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -169,6 +169,8 @@ static void gfx_v9_4_3_set_gds_init(struct amdgpu_device *adev);
 static void gfx_v9_4_3_set_rlc_funcs(struct amdgpu_device *adev);
 static int gfx_v9_4_3_get_cu_info(struct amdgpu_device *adev,
 				struct amdgpu_cu_info *cu_info);
+static void gfx_v9_4_3_update_spm_vmid_internal(struct amdgpu_device *adev,
+					      int xcc_id, unsigned int vmid);
 static void gfx_v9_4_3_xcc_set_safe_mode(struct amdgpu_device *adev, int xcc_id);
 static void gfx_v9_4_3_xcc_unset_safe_mode(struct amdgpu_device *adev, int xcc_id);
 
@@ -1066,6 +1068,13 @@ static int gfx_v9_4_3_sw_init(struct amdgpu_ip_block *ip_block)
 
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 
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
@@ -1454,10 +1463,14 @@ static void gfx_v9_4_3_init_rlcg_reg_access_ctrl(struct amdgpu_device *adev)
 
 static int gfx_v9_4_3_rlc_init(struct amdgpu_device *adev)
 {
-	/* init spm vmid with 0xf */
-	if (adev->gfx.rlc.funcs->update_spm_vmid)
-		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, 0xf);
+	int i, num_xcc;
+
+	if (amdgpu_sriov_vf(adev) || !adev->gfx.rlc.funcs->update_spm_vmid)
+		return 0;
 
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	for (i = 0; i < num_xcc; i++)
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, i, NULL, 0xf);
 	return 0;
 }
 
@@ -1632,14 +1645,15 @@ static int gfx_v9_4_3_xcc_rlc_resume(struct amdgpu_device *adev, int xcc_id)
 {
 	int r;
 
+	gfx_v9_4_3_xcc_rlc_stop(adev, xcc_id);
 	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
-		gfx_v9_4_3_xcc_rlc_stop(adev, xcc_id);
 		/* legacy rlc firmware loading */
 		r = gfx_v9_4_3_xcc_rlc_load_microcode(adev, xcc_id);
 		if (r)
 			return r;
-		gfx_v9_4_3_xcc_rlc_start(adev, xcc_id);
 	}
+	gfx_v9_4_3_update_spm_vmid_internal(adev, xcc_id, 0xf);
+	gfx_v9_4_3_xcc_rlc_start(adev, xcc_id);
 
 	amdgpu_gfx_rlc_enter_safe_mode(adev, xcc_id);
 	/* disable CG */
@@ -1667,28 +1681,38 @@ static int gfx_v9_4_3_rlc_resume(struct amdgpu_device *adev)
 	return 0;
 }
 
-static void gfx_v9_4_3_update_spm_vmid(struct amdgpu_device *adev,
-					      int inst, struct amdgpu_ring *ring, unsigned int vmid)
+static void gfx_v9_4_3_update_spm_vmid_internal(struct amdgpu_device *adev,
+					      int xcc_id, unsigned int vmid)
 {
 	u32 reg, pre_data, data;
 
-	reg = SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regRLC_SPM_MC_CNTL);
+	reg = SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_SPM_MC_CNTL);
 	if (amdgpu_sriov_is_pp_one_vf(adev) && !amdgpu_sriov_runtime(adev))
 		pre_data = RREG32_NO_KIQ(reg);
 	else
-		pre_data = RREG32(reg);
+		pre_data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_SPM_MC_CNTL);
 
 	data =	pre_data & (~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK);
 	data |= (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
 
 	if (pre_data != data) {
 		if (amdgpu_sriov_is_pp_one_vf(adev) && !amdgpu_sriov_runtime(adev)) {
-			WREG32_SOC15_NO_KIQ(GC, GET_INST(GC, inst), regRLC_SPM_MC_CNTL, data);
+			WREG32_SOC15_NO_KIQ(GC, GET_INST(GC, xcc_id), regRLC_SPM_MC_CNTL, data);
 		} else
-			WREG32_SOC15(GC, GET_INST(GC, inst), regRLC_SPM_MC_CNTL, data);
+			WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_SPM_MC_CNTL, data);
 	}
 }
 
+static void gfx_v9_4_3_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
+		struct amdgpu_ring *ring, unsigned int vmid)
+{
+	amdgpu_gfx_off_ctrl(adev, false);
+
+	gfx_v9_4_3_update_spm_vmid_internal(adev, xcc_id, vmid);
+
+	amdgpu_gfx_off_ctrl(adev, true);
+}
+
 static const struct soc15_reg_rlcg rlcg_access_gc_9_4_3[] = {
 	{SOC15_REG_ENTRY(GC, 0, regGRBM_GFX_INDEX)},
 	{SOC15_REG_ENTRY(GC, 0, regSQ_IND_INDEX)},
@@ -2376,6 +2400,7 @@ static int gfx_v9_4_3_hw_fini(struct amdgpu_ip_block *ip_block)
 	int i, num_xcc;
 
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
+	amdgpu_irq_put(adev, &adev->gfx.spm_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
 
@@ -2510,12 +2535,112 @@ static void gfx_v9_4_3_ring_emit_gds_switch(struct amdgpu_ring *ring,
 				   (1 << (oa_size + oa_base)) - (1 << oa_base));
 }
 
+static void gfx_v9_4_3_spm_start(struct amdgpu_device *adev, int xcc_id)
+{
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[xcc_id].ring;
+	uint32_t data = 0;
+
+	data = RREG32_SOC15(GC, GET_INST(GC, 0), regRLC_SPM_PERFMON_CNTL);
+	data |= RLC_SPM_PERFMON_CNTL__PERFMON_RING_MODE_MASK;
+	gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, GET_INST(GC, 0), regRLC_SPM_PERFMON_CNTL), data);
+
+	data = REG_SET_FIELD(0, CP_PERFMON_CNTL, SPM_PERFMON_STATE,
+			CP_PERFMON_STATE_DISABLE_AND_RESET);
+	gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, GET_INST(GC, 0), regCP_PERFMON_CNTL), data);
+
+	/* When SPM is reset, RLC automatically resets wptr to 0.
+	 * Manually reset rptr to match this.
+	 */
+	gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, GET_INST(GC, 0), regRLC_SPM_RING_RDPTR), 0);
+
+	gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, GET_INST(GC, 0), regRLC_SPM_INT_CNTL), 1);
+
+	data = RREG32_SOC15(GC, GET_INST(GC, 0), regRLC_CLK_CNTL);
+	data |= RLC_CLK_CNTL__RLC_SPM_CLK_CNTL_MASK;
+	WREG32_SOC15(GC, GET_INST(GC, 0), regRLC_CLK_CNTL, data);
+}
+
+static void gfx_v9_4_3_spm_stop(struct amdgpu_device *adev, int xcc_id)
+{
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[xcc_id].ring;
+	uint32_t data = 0;
+
+	data = RREG32_SOC15(GC, GET_INST(GC, 0), regRLC_CLK_CNTL);
+	data &= (~RLC_CLK_CNTL__RLC_SPM_CLK_CNTL_MASK);
+	WREG32_SOC15(GC, GET_INST(GC, 0), regRLC_CLK_CNTL, data);
+
+	data = REG_SET_FIELD(0, CP_PERFMON_CNTL, SPM_PERFMON_STATE,
+			CP_PERFMON_STATE_STOP_COUNTING);
+	gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, GET_INST(GC, 0), regCP_PERFMON_CNTL), data);
+
+	data = REG_SET_FIELD(0, CP_PERFMON_CNTL, PERFMON_STATE,
+			CP_PERFMON_STATE_DISABLE_AND_RESET);
+	gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, GET_INST(GC, 0), regCP_PERFMON_CNTL), data);
+
+	/* When SPM is reset, RLC automatically resets wptr to 0.
+	 * Manually reset rptr to match this.
+	 */
+	gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, GET_INST(GC, 0), regRLC_SPM_RING_RDPTR), 0);
+}
+
+static void gfx_v9_4_3_spm_set_rdptr(struct amdgpu_device *adev, int xcc_id,  u32 rptr)
+{
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[xcc_id].ring;
+
+	gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, GET_INST(GC, 0), regRLC_SPM_RING_RDPTR), rptr);
+}
+
+static void gfx_v9_4_3_set_spm_perfmon_ring_buf(struct amdgpu_device *adev,
+					    int xcc_id, u64 gpu_addr, u32 size)
+{
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[xcc_id].ring;
+
+	gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0,
+			regRLC_SPM_PERFMON_RING_BASE_LO), lower_32_bits(gpu_addr));
+
+	gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, 0,
+				regRLC_SPM_PERFMON_RING_BASE_HI), upper_32_bits(gpu_addr));
+
+	gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, GET_INST(GC, 0),
+				regRLC_SPM_PERFMON_RING_SIZE), size);
+	gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, GET_INST(GC, 0),
+				regRLC_SPM_SEGMENT_THRESHOLD), 0x1);
+
+	gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, GET_INST(GC, 0), regCP_PERFMON_CNTL), 0);
+}
+
+static const struct amdgpu_spm_funcs gfx_v9_4_3_spm_funcs = {
+	.start = &gfx_v9_4_3_spm_start,
+	.stop = &gfx_v9_4_3_spm_stop,
+	.set_rdptr = &gfx_v9_4_3_spm_set_rdptr,
+	.set_spm_perfmon_ring_buf = &gfx_v9_4_3_set_spm_perfmon_ring_buf,
+	.set_spm_config_size = 30,
+};
+
+static void gfx_v9_4_3_set_spm_funcs(struct amdgpu_device *adev)
+{
+	adev->gfx.spmfuncs = &gfx_v9_4_3_spm_funcs;
+}
+
 static int gfx_v9_4_3_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
 	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
 					  AMDGPU_MAX_COMPUTE_RINGS);
+	gfx_v9_4_3_set_spm_funcs(adev);
 	gfx_v9_4_3_set_kiq_pm4_funcs(adev);
 	gfx_v9_4_3_set_ring_funcs(adev);
 	gfx_v9_4_3_set_irq_funcs(adev);
@@ -2537,6 +2662,10 @@ static int gfx_v9_4_3_late_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	r = amdgpu_irq_get(adev, &adev->gfx.spm_irq, 0);
+	if (r)
+		return r;
+
 	r = amdgpu_irq_get(adev, &adev->gfx.priv_inst_irq, 0);
 	if (r)
 		return r;
@@ -3395,6 +3524,41 @@ static void gfx_v9_4_3_emit_mem_sync(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, 0x0000000A); /* POLL_INTERVAL */
 }
 
+static int gfx_v9_4_3_spm_set_interrupt_state(struct amdgpu_device *adev,
+					     struct amdgpu_irq_src *src,
+					     unsigned int type,
+					     enum amdgpu_interrupt_state state)
+{
+	int i, num_xcc;
+
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	for (i = 0; i < num_xcc; i++) {
+		switch (state) {
+		case AMDGPU_IRQ_STATE_DISABLE:
+			WREG32_SOC15(GC, GET_INST(GC, i), regRLC_SPM_INT_CNTL, 0);
+			break;
+		case AMDGPU_IRQ_STATE_ENABLE:
+			WREG32_SOC15(GC, GET_INST(GC, i), regRLC_SPM_INT_CNTL, 1);
+			break;
+		default:
+			break;
+		}
+	}
+	return 0;
+}
+
+static int gfx_v9_4_3_spm_irq(struct amdgpu_device *adev,
+			     struct amdgpu_irq_src *source,
+			     struct amdgpu_iv_entry *entry)
+{
+	int xcc_id;
+
+	xcc_id = gfx_v9_4_3_ih_to_xcc_inst(adev, entry->node_id);
+
+	amdgpu_rlc_spm_interrupt(adev, xcc_id);
+	return 0;
+}
+
 static void gfx_v9_4_3_emit_wave_limit_cs(struct amdgpu_ring *ring,
 					uint32_t pipe, bool enable)
 {
@@ -4822,11 +4986,19 @@ static const struct amdgpu_irq_src_funcs gfx_v9_4_3_priv_inst_irq_funcs = {
 	.process = gfx_v9_4_3_priv_inst_irq,
 };
 
+static const struct amdgpu_irq_src_funcs gfx_v9_4_3_spm_irq_funcs = {
+	.set = gfx_v9_4_3_spm_set_interrupt_state,
+	.process = gfx_v9_4_3_spm_irq,
+};
+
 static void gfx_v9_4_3_set_irq_funcs(struct amdgpu_device *adev)
 {
 	adev->gfx.eop_irq.num_types = AMDGPU_CP_IRQ_LAST;
 	adev->gfx.eop_irq.funcs = &gfx_v9_4_3_eop_irq_funcs;
 
+	adev->gfx.spm_irq.num_types = 1;
+	adev->gfx.spm_irq.funcs = &gfx_v9_4_3_spm_irq_funcs;
+
 	adev->gfx.priv_reg_irq.num_types = 1;
 	adev->gfx.priv_reg_irq.funcs = &gfx_v9_4_3_priv_reg_irq_funcs;
 
-- 
2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D79CCF2DB
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 08:34:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74A6F10E878;
	Mon, 19 Oct 2026 08:34:19 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010018.outbound.protection.outlook.com [52.101.56.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EDA310E86E
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 08:34:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GKAGGbsq7O4qp+zhBaGVKNVLZx+9xx9sGk1oTTlNPkZHHAIPLfq5kOE8dBBvLX3XeOmao3EesckVMRS1aKM7Sk8trqQ65+whR/lU3eVsNyQQNHr9TxS9dF5YHixEv/EFCjWyLPLCZi5aCvukcw8uozy0No8/FhzGqr9PkgggR7aGUzk3TtU0li3PnUMtSOMbNbeinpXX+6rkLPWaZ8ixFgr5rx6l81GTYQtYMyfRbcR79rrHkVGnoUoHz4Ok0npxk8sBQS5wOXZIcT0zv3r2HNtwOreo1QuZfA1xBOuBAdrT0cRwz9Ok/Zk4Mwf2TPc01gnyV5j8FnKyuBKmvu9ksw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/zajf11DpYoPMXrsB+5o/M2wAmXYxCo+j2FUO3Ifrw=;
 b=RKQQiF4t1e1F/fEX/99lfN7YRN5YFsUfcKF4vfWCS6ApuFyElTq4+sOlDo8TMdeaoNalUZeKTlNBZpj+IxWLl7FIfnCK4l9pqhZMEOo+YTdEVbN0ETkswsGzVvzF5fr2V0Bb4SUKHfTS59SQp+hnUC7EEY4EOvNnAYWfYUu2tyTmbz82l54WZ0KSffV7/drhdyWx06yTnBjt3IiP6U7HVD/mxhMoPR2Dq+wBhGLp1heP8qSxrkpoVrwfewcolCBtqZviL+nzBI7DVQ/PscfEfT7KXRtHxuTyq2rGQyPD8LmLVFRSoEiSR3flRf16BPo3z3Mf/sN+Ygotp0Zt3sZcMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/zajf11DpYoPMXrsB+5o/M2wAmXYxCo+j2FUO3Ifrw=;
 b=oEcnqkz88wJUDWF2LWNOKf9xPXuWt0mVpEhAXUufY5xT0P6NVI9/K7tdiabmN6GZ2/fUJdULKIuM+nKKhFe2QqnMj8qaaHtOw3LxmQSVRg3Iq+yCK+qY9F12Dg8QtqFvWTsrYBbG5rrZzRO8x3bHV+RtBjoTCHP1riYRbbLFxdc=
Received: from SJ0PR13CA0017.namprd13.prod.outlook.com (2603:10b6:a03:2c0::22)
 by CY5PR12MB6372.namprd12.prod.outlook.com (2603:10b6:930:e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 08:34:08 +0000
Received: from MW2PEPF00014679.namprd04.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::3d) by SJ0PR13CA0017.outlook.office365.com
 (2603:10b6:a03:2c0::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.14 via Frontend Transport; Mon,
 19 Oct 2026 08:34:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW2PEPF00014679.mail.protection.outlook.com (10.167.249.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 08:34:07 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 03:33:58 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 03:33:58 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 19 Oct 2026 03:33:57 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 02/13] drm/amdgpu/gfx12: add a gfx engine reset
Date: Mon, 19 Oct 2026 16:33:02 +0800
Message-ID: <20261019083402.2033724-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261019083402.2033724-1-Jesse.Zhang@amd.com>
References: <20261019083402.2033724-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PEPF00014679:EE_|CY5PR12MB6372:EE_
X-MS-Office365-Filtering-Correlation-Id: 527e7448-9c50-443b-39e8-08df2dbbbd79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|261009223027099003|10067099003|56012099006|3023799007|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: U72Mb1Ch2EZ34ochApSzUp+xD2tp+XDyuVCwcYpBctibQp0ZsyXK6YeDBIBTa7rc7YdWZwtHrSOJdVhhvp7zJXJlUZwfw+XdxuCQjieR3cPl8Xa0bO0xxm+NEwG/5BUTg48FaQhnIByCZVUU4Qe6DGM8VqvKVxUqt2An3unMIaoKPmo/etx9GlQAZKq4Y9gyg+Ww74iLdJjUac51pwYB2b9mfdLBu/a5mCKFWpoJ6QvIv18ULSzOD//lKCpknVyqaB9IBarnUJlXOQyLS0sLVnwFCKrM5JdTTA6jlKeRb/HoHcjWLsrsF8vx1Uua5ifGmBWNhwjmw0LGGSPrl7Ded6bpYsgzsuFvPb/GKf5jWDTi8RUYGX+InqbS9gUz15usueFpnPRtXf8UoXp4k3mtccl68KThP6Kyd3QG51vy0ddM8xNzONwSNNpwKl/Gxg5d1HWS2L8QkO0B8eaGVrHwluix6wpfr7Jg7nIiuiuPrFaojM3Fz1X3GuyXBL3t0wHzFDG2W2ZHUhTrjdnlKapKQSJ70J8krb/UjAuZVq3NxJfeJlS+cvo2qgeReX02Vyir4hewgM1hOYyZltxabIRXe2l6bvl7Vc9fOi4SuSTtv/6fRdjeLERVDPZs5lylVWVkolVejgTd5h2I6mQTRGTHEH+RvguyCl+EJkgqvXfIW8ShL0Wrd9smWWfnTYoh1b4oL0XPJkJ6re/aFcfExwVeWg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(261009223027099003)(10067099003)(56012099006)(3023799007)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bDT0/2khMynBqdI6GdsFK8PTIYoOPv52eELXupXwosJysSbz9v0N01Jda8z0o5tHWXZ7rFylWAvB+uJPfcv4PoR41ef1Vdaw1ZRbSpHA55E63tHDg8nhPpzsQ/dj3JVXFeNC9ahgUPF/nFH9fwaGAnfGSYUMvhAefQ3cAsH5lZiVBLO5vFVKgqeoHqyYt++RKxElYDdPvyrm/JMT5N6qKq3sd5prTK4xV5KxdDUAgxcHoASiiw7ipwCXhUxNPqUkY6cQ7LHpUTsW+H/zkDMsDXd0x11lYgJwXL2inRNt1HE2jvw4RS7jXKZLXgQBd5Ga8VWshOEHibAnqFgkbtEFSRGih/GEt871f5LXuvqbNIOin4OxKX25ODARzwYsyl714mYRGRNiouGYCy3JmyN2luY3y8kxtzuBeEuWjp6kJhGlNjWh+z7Lvv4//jMAVNl+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 08:34:07.0035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 527e7448-9c50-443b-39e8-08df2dbbbd79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2PEPF00014679.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6372
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

A PM4 packet that declares more DWORDs than its IB has left leaves the
gfx streaming engine waiting for data that never arrives. Neither a
queue reset nor a pipe reset can stop it, so the recovery currently
ends in a full GPU reset, and VRAM is lost.

Implement the reset_engine callback for the graphics engine:
- halt PFP/ME;
- wait for the memory requests of the CP DMA to complete;
- with CP_SOFT_RESET_CNTL.GFX_ONLY_SOFT_RESET and GFX_HQD_REG_RESET set,
  pulse GRBM_SOFT_RESET.SOFT_RESET_CPF/CPG. A CPF reset alone does not
  clear the stuck stream;
- restart PFP/ME and restore CP_PFP_IB_CONTROL;
- remap the kernel gfx queue through MES from its MQD backup.

MEC and the compute part of CPF/CPG aren't reset. On Navi48, compute
work from kernel queues, KFD and user queues completed normally across
thousands of engine resets, also with more compute queues than MES had
HQDs for.

MES fetches its own queues through CPF, though. A MES command that was
in flight during the reset never completed, so hold the MES lock across
the reset.

When the reset hit memory requests of the CP DMA in flight, eg. the ME
was halted in the middle of a DMA through TCIU, the ME stayed busy after
the reset, and running MES on it failed the next MES commands until MES
didn't respond at all. On Navi48 they completed within about 1 ms after
the halt; waiting for them made that go away in hundreds of resets under
load. The DMA of a hung stream may never complete: reset anyway after
the usual timeout then. If the CP still doesn't go idle once PFP/ME were
restarted, fail the reset so that a full reset follows. Check only
then: after the hang above, the PFP stays busy until restarted, so only
wait for the memory requests after the pulse too.

The reset also clears the HQDs of the gfx user queues, the caller has to
handle them.

The callback relies on the caller to only use it when the IP reports
AMDGPU_RESET_TYPE_PER_ENGINE, which a later patch enables with MES and
async gfx rings.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 142 +++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index d334fb805020..ee43fdc94ec0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -274,6 +274,8 @@ static void gfx_v12_0_set_imu_funcs(struct amdgpu_device *adev);
 static int gfx_v12_0_get_cu_info(struct amdgpu_device *adev,
 				 struct amdgpu_cu_info *cu_info);
 static uint64_t gfx_v12_0_get_gpu_clock_counter(struct amdgpu_device *adev);
+static int gfx_v12_0_reset_engine(struct amdgpu_device *adev,
+				  enum amdgpu_gfx_engine engine);
 static void gfx_v12_0_select_se_sh(struct amdgpu_device *adev, u32 se_num,
 				   u32 sh_num, u32 instance, int xcc_id);
 static u32 gfx_v12_0_get_wgp_active_bitmap_per_sh(struct amdgpu_device *adev);
@@ -959,6 +961,7 @@ static const struct amdgpu_gfx_funcs gfx_v12_0_gfx_funcs = {
 	.update_perfmon_mgcg = &gfx_v12_0_update_perf_clk,
 	.get_gfx_shadow_info = &gfx_v12_0_get_gfx_shadow_info,
 	.get_hdp_flush_mask = &amdgpu_gfx_get_hdp_flush_mask,
+	.reset_engine = &gfx_v12_0_reset_engine,
 };
 
 static int gfx_v12_0_gpu_early_init(struct amdgpu_device *adev)
@@ -3844,6 +3847,145 @@ static int gfx_v12_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
+/* The CP DMA and the interfaces its memory requests go through */
+#define GFX12_CP_STAT_MEM_BUSY	(CP_STAT__DMA_BUSY_MASK | \
+				 CP_STAT__TCIU_BUSY_MASK | \
+				 CP_STAT__RCIU_BUSY_MASK | \
+				 CP_STAT__UTCL2IU_BUSY_MASK)
+
+/*
+ * Soft reset the gfx CP and restart PFP and ME. Returns -ETIMEDOUT if the CP
+ * is still busy once restarted.
+ */
+static int gfx_v12_0_soft_reset_gfx_cp(struct amdgpu_device *adev)
+{
+	u32 tmp, cntl, me_cntl, ib_control;
+	int i;
+
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
+
+	/*
+	 * MES fetches its own queues through CPF: a MES command that is in
+	 * flight during the reset doesn't complete. Keep MES commands out
+	 * until the reset is released.
+	 */
+	amdgpu_mes_lock(&adev->mes);
+
+	me_cntl = RREG32_SOC15(GC, 0, regCP_ME_CNTL);
+	/* Cleared by the reset, but otherwise only set by the RLC on GFXOFF exit. */
+	ib_control = RREG32_SOC15(GC, 0, regCP_PFP_IB_CONTROL);
+
+	tmp = REG_SET_FIELD(me_cntl, CP_ME_CNTL, ME_HALT, 1);
+	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, PFP_HALT, 1);
+	WREG32_SOC15(GC, 0, regCP_ME_CNTL, tmp);
+	udelay(50);
+
+	/*
+	 * Let the memory requests of the CP DMA complete: when they are
+	 * still in flight during the reset, the ME stays busy after it. The
+	 * DMA of a hung stream may never complete, reset anyway then.
+	 */
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
+	/* Both are needed: a CPF reset alone leaves the streaming engine stuck. */
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
+	/*
+	 * Let the memory requests in flight drain before PFP/ME restart. Not
+	 * the whole CP: after a hang, the halted PFP stays busy until it is
+	 * restarted.
+	 */
+	for (i = 0; i < adev->usec_timeout; i++) {
+		if (!(RREG32_SOC15(GC, 0, regCP_STAT) & GFX12_CP_STAT_MEM_BUSY))
+			break;
+		udelay(1);
+	}
+	amdgpu_mes_unlock(&adev->mes);
+
+	/* Restart PFP and ME from the start of their firmware. */
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
+ * HQDs. MEC, MES and the compute queues keep running.
+ *
+ * A malformed packet whose length runs past the end of an IB leaves the gfx
+ * streaming engine waiting for data that never arrives. Neither a queue nor
+ * a pipe reset can stop it, but a CPF/CPG soft reset limited to gfx can.
+ */
+static int gfx_v12_0_reset_engine(struct amdgpu_device *adev,
+				  enum amdgpu_gfx_engine engine)
+{
+	int i, r;
+
+	lockdep_assert_held(&adev->gfx.mec.reset_mutex);
+
+	if (engine != AMDGPU_GFX_ENGINE_GFX)
+		return -EOPNOTSUPP;
+
+	amdgpu_gfx_off_ctrl(adev, false);
+
+	/* Leave a CP that doesn't go idle to a full reset. */
+	r = gfx_v12_0_soft_reset_gfx_cp(adev);
+	if (r)
+		dev_err(adev->dev, "gfx CP still busy after reset, CP_STAT 0x%08x\n",
+			RREG32_SOC15(GC, 0, regCP_STAT));
+
+	/* MES still has the kernel gfx queue mapped on the cleared HQD. */
+	if (!r)
+		r = amdgpu_gfx_disable_kgq(adev, 0);
+	if (!r) {
+		for (i = 0; i < adev->gfx.num_gfx_rings; i++)
+			amdgpu_gfx_mqd_reset_restore(&adev->gfx.gfx_ring[i]);
+		r = amdgpu_gfx_enable_kgq(adev, 0);
+	}
+	if (!r)
+		r = gfx_v12_0_cp_gfx_start(adev);
+
+	amdgpu_gfx_off_ctrl(adev, true);
+	return r;
+}
+
 static uint64_t gfx_v12_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 {
 	uint64_t clock = 0;
-- 
2.50.1


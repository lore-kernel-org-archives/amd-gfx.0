Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ECE606A31A
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 08:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KEoclnRb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44A941123CF;
	Thu, 22 Oct 2026 08:20:42 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010054.outbound.protection.outlook.com [52.101.201.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 060801123CF
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 08:20:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kUgQr+tv2Xm35HtZXK/ACBIR3VbErdntoEIKQutSjvxqpaxh/R1+aXse65wPtOe01kVxO+b/5oPiQCpxOaa49m0MMxLLvskMcm21386vKv0rlT5SEDup9hzKP2JxV2pvTMFu9Jvt/EqXdfV5bMRtIcdrNdDdtGsG2a9EQ4v8vdHFKPP5idko6sV+3H4UWOw51vgtDdbXZDYdLOZDpP4BZDWskjbyNX3se906I6QQ8rUmt2+Dm/6UfHa8/OWc2GSc/crmFJ3qDAF5j6C6V4d4siqF183a7gCvhNiPrnw+J4/vPwSypu07yyHNRSVdw88FIXUb00Ch5rk95C96gbDZOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PtJxrZwtVwSyzO7eIDiPBNOLO5+fYAHJiF9H46HOQn0=;
 b=OhWL+L4AC2es5FmkMfQtL+UsGcfmB2KWSJmwmGLi6cj1KczfSIVKuckHjEAix4wSWZ6eUJS8cI434K4LCfLm83D6je68jo4/HXbxGxGLDsPngONHOrknbjgjiwsGZKhqhZjsBWifJRYOXVqp9DbB3wRBU9bzOqD5XkXNMT02jlXJzLYbtGuIFOF0IZYam/YRPPsz2T1kI03poGTedbYtq+AKZIFL3dGct737PFBwT45ipXYcEV9TZDGMg7ElLd+dK9xWrkeUH2Yo/UPxac7mBybsqnkiQ95CaoH+OyxvhOC7cOFy1tuOUQpi+bcy5SSvPGJId1mSk1KP7/018fkG7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PtJxrZwtVwSyzO7eIDiPBNOLO5+fYAHJiF9H46HOQn0=;
 b=KEoclnRb5PqbNjlsljOnQzROx8psTfnpYIobFxWSI+aM0aekaqh/YYNlBVpxXpIfnpiDgzVMn7Ko4NK9JT0ZuXYFybJl4XzluqE5ZQoHYZR8J358LvIyogvoXgEQnfD+vgMwBfATjkpDKk2d6+WWj8/vsj4RosXO/neg4ntHdDU=
Received: from CH0P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::20)
 by DS5PPF78FC67EBA.namprd12.prod.outlook.com (2603:10b6:f:fc00::655)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Thu, 22 Oct
 2026 08:20:29 +0000
Received: from BN2PEPF0000A805.namprd02.prod.outlook.com
 (2603:10b6:610:11c:cafe::80) by CH0P221CA0024.outlook.office365.com
 (2603:10b6:610:11c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.17 via Frontend Transport; Thu,
 22 Oct 2026 08:20:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A805.mail.protection.outlook.com (10.167.245.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 08:20:28 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 03:20:20 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 22 Oct 2026 03:20:19 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, <Mario.Novales@amd.com>, <Manu.Rastogi@amd.com>,
 <Jiongyu.Zhu@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2 02/15] drm/amdgpu/gfx12: add a gfx engine reset
Date: Thu, 22 Oct 2026 16:19:42 +0800
Message-ID: <20261022082011.331462-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261022082011.331462-1-Jesse.Zhang@amd.com>
References: <20261022082011.331462-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A805:EE_|DS5PPF78FC67EBA:EE_
X-MS-Office365-Filtering-Correlation-Id: d7808642-5438-4c40-7411-08df301554d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|18002099003|10067099003|22082099003|261021121427099003|3023799007|261021123027099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: N1BNe/41VyFtQ4exUKoNZGPpLkNsnSdZOb0MAvMoHWHCfAt8bot/iD38uXkpdjp8NhJZHn0kiwYakEQ2vcO8+IzeiF4Lk4cxIn2ve7lwmRpk/9tsTUfjBcB3WTBebyjmDD0kmm0itQ/YeBGIc6xexZRxNj27m8RWWuT1FNZQrpNUbA6elBfjJv9CngZZYbg5CTAt6nee/zV1oM4VcjAMoQ1GSTf4h9eAQRYgNC4Iu/Akdm/ebN6iQ1SDOFZQqqtsgAMBye/9HQ9sSbQMWgWruWMkc+IlB6DaJcX6kciNHibFZxBJUn9SCVdERcMkT2kWn32wDuVoMu2fQ6DKzQ4c0pqpOAptFyX+LBn+yjH6gs2PlgqITrl6So/AWyloCZDKiJDjbS4jf/qaZFwxIybqX+wOOWMxuIhwaAIMEl8X5iUNqSzqGvOxBJ447yeZFQ8c/V7/vaT2tmTClzcXqb/+vYxXahUN4/946T2JZkq9wRatlwC75v5G9uapBzLgbdMZhBr5gs44CuxrJaTvQNc+NdeiMNXSrS+aNmoIbTQrr4pnUWWLN876Tn8OXYqu7uGUqp9ulYlvKK26prN1HI3Z3S32IeGl2Y8RVme2xtQpCTFz50J+rOE3P6gM94HcflQlcuLlMuQQV5m24vDYf3DL+5fWTivlW9apFcmVClLmoT1VyDTrqiG+bb0R1cFRmOOKoza/LCl8pZJM1r35sw4zPg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(18002099003)(10067099003)(22082099003)(261021121427099003)(3023799007)(261021123027099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Z2iHrJfuDe1soBqBNkSJBwzaO8MLllQk2Tg0+ci9B0zdilPe3a0cNAmEUI4yPMI/RAY4CsrfBPVgcbOzWCetqpQua2mW8f39HIa964RT4HcQlg9e/0sAUXnhC7ijNkkvnqNIHHAlhU1alH5lXjp9fI80OuSvs4W/bfVgs7RrQ8EQozg47GzbwclfUuHMPkEeiHfNHWqOPCuAIaRWhE1LGnGmZpJAeHg0UhX7lWbm3rt1so7D2RRgJcYjL1H19Co1dKXz1AneBkzO9fx4M99953uGpBxzFPDfdsdjOUIfh/4riUp3actX5GXq4ZDgxw3so+gcEG5t1GgYDUN9ix2Lftigt/Rl0xp81Kj4WS3TeRA6LwL98RvO9ZHRGbUUt1Byepc+uZVI59W8LJ/F+cvUivttZJnFc8e5dKxYRuo8LA0/O8E/pFGOwbeqtHo0xUYL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 08:20:28.5356 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7808642-5438-4c40-7411-08df301554d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A805.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF78FC67EBA
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
- remap the kernel gfx queue through MES from its MQD backup.

MEC and the compute part of CPF/CPG aren't reset, so the compute queues
keep running.

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
AMDGPU_RESET_TYPE_PER_ENGINE, which a later patch enables with MES and
async gfx rings.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 129 +++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index d334fb805020..dfc409e28914 100644
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
@@ -3844,6 +3847,132 @@ static int gfx_v12_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
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
+ * HQDs. MEC, MES and the compute queues keep running.
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


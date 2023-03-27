Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE07EC6FD1D
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 19:30:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C72310E6D3;
	Mon, 27 Mar 2023 19:30:36 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C92210E6E0
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 19:30:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6k0s1tMV4+Xsq3lnB2hCDF0EL5O8mGhYAoWExCm+4r3TU6ECFzu8CqblpcTz/qkAhnk4TfCJEGPWR3IkSty5m565tsKZfoGekcAiX1icd8lgKrn4Erp3VZADWvR/ukogwuoN77ni3OUFkbI/YgR8r3aKs4P0uzL9/4zbyJF/Y73g76pEFHJr0yz2GJjcu57jGh1/7jhBFd8QcRSGl1W9Pytwmw6GyYpeBdY0vB9uSho0Vk+IuxRLIQaSEaB2rpv5g2t3epek1DPhFCTcQTBBZ7JxZm74AM5qEbyLb8btGffxEIt4YOqASSL/AIeVzSHvRUSc5mrM4Bg3uYecbcHhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2G3lXI5bYdm6dzyYQqu/1VzsuBaTDo0v2sZMjuXrmNg=;
 b=Crtf6/1Th9ykVW6VZOHa70dmRi/bqX82c3S031vbmW5C5AoU28WndB54z+ND171yopcXXeQMtyOL+aw0UvLcxKIDSRPeEBq0DDMYTv/b/4Df7wnhFVSeHIUYzErY09fIIBDZLokQTOfHjAZa0uFjMiEBDh2mSVQ9E4M2Lba2PO8THFHTdVPStB7UoSJNd7EfvPuPX2wR5OeHKKBDBVXXIjy/DlxvYUc2agicNDCu2ndshaBeeiey88zljWSPbgikeroLJMPPlM+WBtFtcVIODevv6KzmtdfrqW6VDLJTqG8A02UFHTMICCNqmPXNYOaUDepX7TFYznbjzTesJ1MJkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2G3lXI5bYdm6dzyYQqu/1VzsuBaTDo0v2sZMjuXrmNg=;
 b=2BN8GVqGtq8ILxOQdsAnwP7i5OuGVxF9m8InrZRyqef4niSi8f1/LElvQETbs1zXREVNVGQ5BjQ9UwQa25173+nKIPdpVVIdV8jCXQrrY2r2c4CLugbEBMOwigFDJg8eoLhqqX/EU42xng3e/cAY8ak9QeSAIqq0efFw4hy/Jjc=
Received: from DM5PR08CA0041.namprd08.prod.outlook.com (2603:10b6:4:60::30) by
 SA0PR12MB7089.namprd12.prod.outlook.com (2603:10b6:806:2d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 19:30:21 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::10) by DM5PR08CA0041.outlook.office365.com
 (2603:10b6:4:60::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Mon, 27 Mar 2023 19:30:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Mon, 27 Mar 2023 19:30:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 14:30:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/10] drm/amdgpu: switch to v9_4_3 gfx_funcs callbacks for GC
 9.4.3
Date: Mon, 27 Mar 2023 15:29:51 -0400
Message-ID: <20230327192953.7756-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327192953.7756-1-alexander.deucher@amd.com>
References: <20230327192953.7756-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT041:EE_|SA0PR12MB7089:EE_
X-MS-Office365-Filtering-Correlation-Id: 58362907-bd4b-455f-c4fd-08db2ef9b43a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zRC89RlIKtEUFB4/RnnBB856yPxa9cdCp0Uka0ZEDKvuHUs4CErP/UO1CgU26HKsUYvWGa4Ms//8F72Gdw4BBwk31XTM5uG2eGOJBntGiY6ufwzfMOYvoCUplMY9j6fg+tSWP7lOiYvkWZLa7nxaZ33ISR9TbfY0obrmBoLdLmw9GBnL9gF7+aQTJ6ii6GpVP6TfO+3Tc/EmHPZWAtGzG5SV4TcmFKKsWQkWZJHN1URBCbf94nL5w9d7lYNJO7xiJxWamN7pnYXj2ZUzY8VC/VGNGieUzPLFyD/gLBOjYruRCxuFMzdpnWBA+H2bYDk7ud+7QeshuKIx8pyl5vXdKc8J6Aj9LkBLWB2FwsrKiuy2NRuq4ltCeLoA+KX2t2zpt+L0R7wBpQ3dCgYazfJAeAux0mltXIEbjh8rnQU15dvyUNSxhhM7bAALRuUQxz/5vBHIaiNTPb2loIfl+GCHlO0kE2eiJznR7r8gpGjULEgaM62tjMyDBOP7x99ObDqk+gWgVAhUazQw5dl5h8fbuWUC/GlcMxMg6Aa9jdBcCLvAg0gqiByoqcsV9ccRoZH+0MnGRASA5I7HeMjkUGR6FZ+HFRwMjZWGGRRjG0iB7SLIIMoFYNecGwVnuBqo8Sh3p7hYD2cNPekx8+c6KlSO+qCYcHuvckxRVSCytxSTsJQVBibKr9gYssbhtY7n3ZIdqrJ50lnrH8Awd1cn30Yve3W2Akuho2Tyzy27ldVrtqU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199021)(40470700004)(46966006)(36840700001)(54906003)(40460700003)(26005)(1076003)(316002)(83380400001)(2906002)(82310400005)(336012)(5660300002)(426003)(8936002)(81166007)(47076005)(356005)(82740400003)(36860700001)(86362001)(186003)(16526019)(70586007)(70206006)(40480700001)(41300700001)(2616005)(8676002)(36756003)(4326008)(6916009)(6666004)(478600001)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:30:20.7760 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58362907-bd4b-455f-c4fd-08db2ef9b43a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7089
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

add gfx_funcs callbacks implemenation based on
gc_v9_4_3 ip headers

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 154 +++++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.h |   1 +
 2 files changed, 126 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index b7536ba3f265..35372f910fca 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -26,6 +26,7 @@
 #include "amdgpu_gfx.h"
 #include "soc15.h"
 #include "soc15_common.h"
+#include "vega10_enum.h"
 
 #include "gc/gc_9_4_3_offset.h"
 #include "gc/gc_9_4_3_sh_mask.h"
@@ -34,6 +35,121 @@
 
 #define RLCG_UCODE_LOADING_START_ADDRESS 0x00002000L
 
+static uint64_t gfx_v9_4_3_get_gpu_clock_counter(struct amdgpu_device *adev)
+{
+	uint64_t clock;
+
+	amdgpu_gfx_off_ctrl(adev, false);
+	mutex_lock(&adev->gfx.gpu_clock_mutex);
+	WREG32_SOC15(GC, 0, regRLC_CAPTURE_GPU_CLOCK_COUNT, 1);
+	clock = (uint64_t)RREG32_SOC15(GC, 0, regRLC_GPU_CLOCK_COUNT_LSB) |
+		((uint64_t)RREG32_SOC15(GC, 0, regRLC_GPU_CLOCK_COUNT_MSB) << 32ULL);
+	mutex_unlock(&adev->gfx.gpu_clock_mutex);
+	amdgpu_gfx_off_ctrl(adev, true);
+
+	return clock;
+}
+
+static void gfx_v9_4_3_select_se_sh(struct amdgpu_device *adev,
+				    u32 se_num,
+				    u32 sh_num,
+				    u32 instance)
+{
+	u32 data;
+
+	if (instance == 0xffffffff)
+		data = REG_SET_FIELD(0, GRBM_GFX_INDEX,
+				     INSTANCE_BROADCAST_WRITES, 1);
+	else
+		data = REG_SET_FIELD(0, GRBM_GFX_INDEX,
+				     INSTANCE_INDEX, instance);
+
+	if (se_num == 0xffffffff)
+		data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
+				     SE_BROADCAST_WRITES, 1);
+	else
+		data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SE_INDEX, se_num);
+
+	if (sh_num == 0xffffffff)
+		data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
+				     SH_BROADCAST_WRITES, 1);
+	else
+		data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SH_INDEX, sh_num);
+
+	WREG32_SOC15_RLC_SHADOW_EX(reg, GC, 0, regGRBM_GFX_INDEX, data);
+}
+
+static uint32_t wave_read_ind(struct amdgpu_device *adev, uint32_t simd, uint32_t wave, uint32_t address)
+{
+	WREG32_SOC15_RLC(GC, 0, regSQ_IND_INDEX,
+		(wave << SQ_IND_INDEX__WAVE_ID__SHIFT) |
+		(simd << SQ_IND_INDEX__SIMD_ID__SHIFT) |
+		(address << SQ_IND_INDEX__INDEX__SHIFT) |
+		(SQ_IND_INDEX__FORCE_READ_MASK));
+	return RREG32_SOC15(GC, 0, regSQ_IND_DATA);
+}
+
+static void wave_read_regs(struct amdgpu_device *adev, uint32_t simd,
+			   uint32_t wave, uint32_t thread,
+			   uint32_t regno, uint32_t num, uint32_t *out)
+{
+	WREG32_SOC15_RLC(GC, 0, regSQ_IND_INDEX,
+		(wave << SQ_IND_INDEX__WAVE_ID__SHIFT) |
+		(simd << SQ_IND_INDEX__SIMD_ID__SHIFT) |
+		(regno << SQ_IND_INDEX__INDEX__SHIFT) |
+		(thread << SQ_IND_INDEX__THREAD_ID__SHIFT) |
+		(SQ_IND_INDEX__FORCE_READ_MASK) |
+		(SQ_IND_INDEX__AUTO_INCR_MASK));
+	while (num--)
+		*(out++) = RREG32_SOC15(GC, 0, regSQ_IND_DATA);
+}
+
+static void gfx_v9_4_3_read_wave_data(struct amdgpu_device *adev,
+				      uint32_t simd, uint32_t wave,
+				      uint32_t *dst, int *no_fields)
+{
+	/* type 1 wave data */
+	dst[(*no_fields)++] = 1;
+	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_STATUS);
+	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_PC_LO);
+	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_PC_HI);
+	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_EXEC_LO);
+	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_EXEC_HI);
+	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_HW_ID);
+	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_INST_DW0);
+	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_INST_DW1);
+	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_GPR_ALLOC);
+	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_LDS_ALLOC);
+	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_TRAPSTS);
+	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_IB_STS);
+	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_IB_DBG0);
+	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_M0);
+	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_MODE);
+}
+
+static void gfx_v9_4_3_read_wave_sgprs(struct amdgpu_device *adev, uint32_t simd,
+				       uint32_t wave, uint32_t start,
+				       uint32_t size, uint32_t *dst)
+{
+	wave_read_regs(adev, simd, wave, 0,
+		       start + SQIND_WAVE_SGPRS_OFFSET, size, dst);
+}
+
+static void gfx_v9_4_3_read_wave_vgprs(struct amdgpu_device *adev, uint32_t simd,
+				       uint32_t wave, uint32_t thread,
+				       uint32_t start, uint32_t size,
+				       uint32_t *dst)
+{
+	wave_read_regs(adev, simd, wave, thread,
+		       start + SQIND_WAVE_VGPRS_OFFSET, size, dst);
+}
+
+static void gfx_v9_4_3_select_me_pipe_q(struct amdgpu_device *adev,
+					u32 me, u32 pipe, u32 q, u32 vm)
+{
+	soc15_grbm_select(adev, me, pipe, q, vm);
+}
+
 static bool gfx_v9_4_3_is_rlc_enabled(struct amdgpu_device *adev)
 {
 	uint32_t rlc_setting;
@@ -80,35 +196,6 @@ static int gfx_v9_4_3_rlc_init(struct amdgpu_device *adev)
 	return 0;
 }
 
-static void gfx_v9_4_3_select_se_sh(struct amdgpu_device *adev,
-				    u32 se_num,
-				    u32 sh_num,
-				    u32 instance)
-{
-	u32 data;
-
-	if (instance == 0xffffffff)
-		data = REG_SET_FIELD(0, GRBM_GFX_INDEX,
-				     INSTANCE_BROADCAST_WRITES, 1);
-	else
-		data = REG_SET_FIELD(0, GRBM_GFX_INDEX, INSTANCE_INDEX,
-				     instance);
-
-	if (se_num == 0xffffffff)
-		data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SE_BROADCAST_WRITES,
-				     1);
-	else
-		data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SE_INDEX, se_num);
-
-	if (sh_num == 0xffffffff)
-		data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SH_BROADCAST_WRITES,
-				     1);
-	else
-		data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SH_INDEX, sh_num);
-
-	WREG32_SOC15_RLC_SHADOW_EX(reg, GC, 0, regGRBM_GFX_INDEX, data);
-}
-
 static void gfx_v9_4_3_wait_for_rlc_serdes(struct amdgpu_device *adev)
 {
 	u32 i, j, k;
@@ -320,6 +407,15 @@ static bool gfx_v9_4_3_is_rlcg_access_range(struct amdgpu_device *adev, u32 offs
 					ARRAY_SIZE(rlcg_access_gc_9_4_3));
 }
 
+const struct amdgpu_gfx_funcs gfx_v9_4_3_gfx_funcs = {
+        .get_gpu_clock_counter = &gfx_v9_4_3_get_gpu_clock_counter,
+        .select_se_sh = &gfx_v9_4_3_select_se_sh,
+        .read_wave_data = &gfx_v9_4_3_read_wave_data,
+        .read_wave_sgprs = &gfx_v9_4_3_read_wave_sgprs,
+        .read_wave_vgprs = &gfx_v9_4_3_read_wave_vgprs,
+        .select_me_pipe_q = &gfx_v9_4_3_select_me_pipe_q,
+};
+
 const struct amdgpu_rlc_funcs gfx_v9_4_3_rlc_funcs = {
 	.is_rlc_enabled = gfx_v9_4_3_is_rlc_enabled,
 	.set_safe_mode = gfx_v9_4_3_set_safe_mode,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.h
index d21ea9ebf146..84e69701b81a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.h
@@ -24,6 +24,7 @@
 #ifndef __GFX_V9_4_3_H__
 #define __GFX_V9_4_3_H__
 
+extern const struct amdgpu_gfx_funcs gfx_v9_4_3_gfx_funcs;
 extern const struct amdgpu_rlc_funcs gfx_v9_4_3_rlc_funcs;
 
 #endif /* __GFX_V9_4_3_H__ */
-- 
2.39.2


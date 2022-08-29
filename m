Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8198ECAAD5
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 14:30:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01BFA10F321;
	Mon, 29 Aug 2022 14:30:57 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFCCB10F312
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 14:30:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kymLaYFuWeu4fktFAvgpDyhdHSS7aXnNRtRfYGQbcSHjabOVnTrJ0Ocbbil/7kNuQ1V18eioy5A1I6+Z4nGDrkBzu6MkfSQz6WnSgBW8ZDVXOOQa/wgE5sqrn3QZ/PbuURzj5Ahobpr+nVOEkGEMB103QIbMz2wZzMLLI3Ji04ZWNkykopl2v50CT3P9PTfm3ZAaq8MrQZeg6R7pY/OJ0qSGVPwGKzTfVNmRTWHd6oAeTEMuUkTNLTqkqA0bji6vI/q2NaU+oBSoDuoh37FcV2LMT7fTMmX6Xllk9HjwQ004fVfR3xmM35ioxUv1Z/h6MQ4kHkcMf8oD2J4emM/tZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j41wxPkj5xltIs8qLdc7KztzZHiGYlbv7c9vxSmbOA4=;
 b=Sght4vxnzF4vP2JQ1biOPKobff8qHgigTNbc9in6DEZQb4hFmF30yHufxkvMV9InPMcTt+PXjxEebCP0xEGKKtXeJJ/EB9qpZhZ3RGzWFR6QqSxzIuAF0QS0J2zWnfbQLV8sNVkpAqSzAZahGHd/1bSqTol4XuXdjd8ooyaHMpZ7V0ugcseK1vzl7NH8r2FYy5FLeaWB5B8Oeyk+mydlfISam2/vrgnguWfhOrMB90t4L0n7tCkPsbOt2Y/Wcfp4gQUYPrruO9B4HJsWS0NAAdUCFnBOr5BnSdF+KRHJ0CZcNb/VXZeBExwayjOPo3L3JfjMz/EdcDkwAXeSCzdU7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j41wxPkj5xltIs8qLdc7KztzZHiGYlbv7c9vxSmbOA4=;
 b=jmWruqAo7BfKAz2p/GFqhqOhjAqRWikToFIc9SxnvmKN0ygHYqBpO7FJrvAxhYfw/gIiJ6JqBOLW6JHnPiFMA21Lu5SZGP5ui+fkfVzlBNaagS1+EnZ7IEb1DShFfnTHYnF4e4nXx1oy1KwCxOylK1dZra6jY5pj7vLtI9YXuUs=
Received: from MW4PR04CA0099.namprd04.prod.outlook.com (2603:10b6:303:83::14)
 by PH7PR12MB5878.namprd12.prod.outlook.com (2603:10b6:510:1d6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 29 Aug
 2022 14:30:48 +0000
Received: from CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::68) by MW4PR04CA0099.outlook.office365.com
 (2603:10b6:303:83::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19 via Frontend
 Transport; Mon, 29 Aug 2022 14:30:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT112.mail.protection.outlook.com (10.13.174.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 14:30:48 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 09:30:43 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/29] drm/amdgpu: add gfx9 hw debug mode enable and disable
 calls
Date: Mon, 29 Aug 2022 10:30:03 -0400
Message-ID: <20220829143026.1509027-7-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220829143026.1509027-1-jonathan.kim@amd.com>
References: <20220829143026.1509027-1-jonathan.kim@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35c4b3b5-53b4-4fdd-1da6-08da89cb10f4
X-MS-TrafficTypeDiagnostic: PH7PR12MB5878:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wvr+Pg63Ky5CVjzH0XgnxeesMyKMXFhb/zEaWLp29n7vV4jb0n7IivHByU1QTYT6hGhG7IMKpELsIXRYcTBJD0exPFSZLp7mivdkgvZDBfFf5iDut1XSDnOcuBO8uh8teQyC9vNbxjXPfQxC1H8806c23HSYUeJIc2UzUtMKbN/4i8fb06bMKIAfvlihtFtbIjxAKRG9Lhdt/ipv6br47fsk/gaUdchlgJVZS5SxmyELLKogGayW58ZZjGrImlbNnmYD8w58pGv81a3MpCkoGhmfriktrovJMee+6BxyIYuPN29W8tZSGjZNQURHvovF37e5hU0wYu4Mz8tcb4M77beLw+SDg3BIa+SPqBHtaxhhv+9SZwanHGBNniOqdMXGgne+ykjwj/KEe3f+Jr/ozLRQWGBzmVz9KWjAaZ4pGFKhkpB6bN3ElpXK6tS/z8kZ3ptY0TKs0FYMNEV5ZLoPQPvZTgOJOKE9pueIGl1MLMTlzIju1V2wPa0zbbS9OcZDsZ7Uo2yPRCcy+Lj1hEUMhSvUrpg+k1QfcVJa46xe8wjkQS+TAQyQhbmSub37zbmM0vN6mXxOmLbLWUhYIxcgo85iRKx8nPqwLHzdpP2Hr+kdGqZw/C/KS14FBUKAEwcV0Ru3dGNhvT38vNZUif68UIfTn7FsKJZAAsdUStTMziNoXk46qq4ldWZU1UK6p9H5sez1ODcKNlRNv1cP+Ex4SsbVGrM6e62U+M7GasDsF1CZoSUMog/4cHS/RM75Tki/+/A5CYcPMKMXx/xw6JvdJo1V6401PeGPymxB4dwfBU6MjegV3jexXDG+PAzbXisz
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(136003)(396003)(346002)(40470700004)(46966006)(36840700001)(36860700001)(16526019)(8936002)(41300700001)(40480700001)(5660300002)(44832011)(40460700003)(336012)(186003)(47076005)(426003)(2616005)(86362001)(1076003)(7696005)(6666004)(26005)(2906002)(316002)(6916009)(54906003)(82310400005)(70586007)(81166007)(36756003)(356005)(83380400001)(82740400003)(478600001)(70206006)(8676002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 14:30:48.0271 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c4b3b5-53b4-4fdd-1da6-08da89cb10f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5878
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
Cc: Felix.Kuehling@amd.com, Lancelot.Six@amd.com, Laurent.Morichetti@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Implement the per-device calls to enable or disable HW debug mode for
GFX9 prior to GFX9.4.1.

GFX9.4.1 and onward will require their own enable/disable sequence as
follow on patches.

When hardware debug mode setting is requested, waves will inherit
these settings in the Shader Processor Input's (SPI) Sequencer Global
Block (SQG). This means that the KGD must drain all waves from the SPI
into SQG (approximately 96 SPI clock cycles) prior to debug mode setting
to ensure that the order of operations that the debugger expects with
regards to debug mode setting transaction requests and wave inheritence
of that mode is upheld.

Also ensure that exception overrides are reset to their original state
prior to debug enable or disable.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 100 ++++++++++++++++--
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |   9 ++
 drivers/gpu/drm/amd/amdkfd/kfd_debug.h        |   3 +
 3 files changed, 102 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 81e3b528bbc9..e1aac6f6d369 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -46,14 +46,14 @@ enum hqd_dequeue_request_type {
 	SAVE_WAVES
 };
 
-static void lock_srbm(struct amdgpu_device *adev, uint32_t mec, uint32_t pipe,
+static void kgd_gfx_v9_lock_srbm(struct amdgpu_device *adev, uint32_t mec, uint32_t pipe,
 			uint32_t queue, uint32_t vmid)
 {
 	mutex_lock(&adev->srbm_mutex);
 	soc15_grbm_select(adev, mec, pipe, queue, vmid);
 }
 
-static void unlock_srbm(struct amdgpu_device *adev)
+static void kgd_gfx_v9_unlock_srbm(struct amdgpu_device *adev)
 {
 	soc15_grbm_select(adev, 0, 0, 0, 0);
 	mutex_unlock(&adev->srbm_mutex);
@@ -65,7 +65,7 @@ static void acquire_queue(struct amdgpu_device *adev, uint32_t pipe_id,
 	uint32_t mec = (pipe_id / adev->gfx.mec.num_pipe_per_mec) + 1;
 	uint32_t pipe = (pipe_id % adev->gfx.mec.num_pipe_per_mec);
 
-	lock_srbm(adev, mec, pipe, queue_id, 0);
+	kgd_gfx_v9_lock_srbm(adev, mec, pipe, queue_id, 0);
 }
 
 static uint64_t get_queue_mask(struct amdgpu_device *adev,
@@ -79,7 +79,7 @@ static uint64_t get_queue_mask(struct amdgpu_device *adev,
 
 static void release_queue(struct amdgpu_device *adev)
 {
-	unlock_srbm(adev);
+	kgd_gfx_v9_unlock_srbm(adev);
 }
 
 void kgd_gfx_v9_program_sh_mem_settings(struct amdgpu_device *adev, uint32_t vmid,
@@ -88,13 +88,13 @@ void kgd_gfx_v9_program_sh_mem_settings(struct amdgpu_device *adev, uint32_t vmi
 					uint32_t sh_mem_ape1_limit,
 					uint32_t sh_mem_bases)
 {
-	lock_srbm(adev, 0, 0, 0, vmid);
+	kgd_gfx_v9_lock_srbm(adev, 0, 0, 0, vmid);
 
 	WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmSH_MEM_CONFIG), sh_mem_config);
 	WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmSH_MEM_BASES), sh_mem_bases);
 	/* APE1 no longer exists on GFX9 */
 
-	unlock_srbm(adev);
+	kgd_gfx_v9_unlock_srbm(adev);
 }
 
 int kgd_gfx_v9_set_pasid_vmid_mapping(struct amdgpu_device *adev, u32 pasid,
@@ -164,13 +164,13 @@ int kgd_gfx_v9_init_interrupts(struct amdgpu_device *adev, uint32_t pipe_id)
 	mec = (pipe_id / adev->gfx.mec.num_pipe_per_mec) + 1;
 	pipe = (pipe_id % adev->gfx.mec.num_pipe_per_mec);
 
-	lock_srbm(adev, mec, pipe, 0, 0);
+	kgd_gfx_v9_lock_srbm(adev, mec, pipe, 0, 0);
 
 	WREG32_SOC15(GC, 0, mmCPC_INT_CNTL,
 		CP_INT_CNTL_RING0__TIME_STAMP_INT_ENABLE_MASK |
 		CP_INT_CNTL_RING0__OPCODE_ERROR_INT_ENABLE_MASK);
 
-	unlock_srbm(adev);
+	kgd_gfx_v9_unlock_srbm(adev);
 
 	return 0;
 }
@@ -646,6 +646,84 @@ int kgd_gfx_v9_wave_control_execute(struct amdgpu_device *adev,
 	return 0;
 }
 
+/*
+ * GFX9 helper for wave launch stall requirements on debug trap setting.
+ *
+ * vmid:
+ *   Target VMID to stall/unstall.
+ *
+ * stall:
+ *   0-unstall wave launch (enable), 1-stall wave launch (disable).
+ *   After wavefront launch has been stalled, allocated waves must drain from
+ *   SPI in order for debug trap settings to take effect on those waves.
+ *   This is roughly a ~96 clock cycle wait on SPI where a read on
+ *   SPI_GDBG_WAVE_CNTL translates to ~32 clock cycles.
+ *   KGD_GFX_V9_WAVE_LAUNCH_SPI_DRAIN_LATENCY indicates the number of reads required.
+ *
+ *   NOTE: We can afford to clear the entire STALL_VMID field on unstall
+ *   because GFX9.4.1 cannot support multi-process debugging due to trap
+ *   configuration and masking being limited to global scope.  Always assume
+ *   single process conditions.
+
+ */
+#define KGD_GFX_V9_WAVE_LAUNCH_SPI_DRAIN_LATENCY	3
+void kgd_gfx_v9_set_wave_launch_stall(struct amdgpu_device *adev,
+					uint32_t vmid,
+					bool stall)
+{
+	int i;
+	uint32_t data = RREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_WAVE_CNTL));
+
+	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 1))
+		data = REG_SET_FIELD(data, SPI_GDBG_WAVE_CNTL, STALL_VMID,
+							stall ? 1 << vmid : 0);
+	else
+		data = REG_SET_FIELD(data, SPI_GDBG_WAVE_CNTL, STALL_RA,
+							stall ? 1 : 0);
+
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_WAVE_CNTL), data);
+
+	if (!stall)
+		return;
+
+	for (i = 0; i < KGD_GFX_V9_WAVE_LAUNCH_SPI_DRAIN_LATENCY; i++)
+		RREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_WAVE_CNTL));
+}
+
+uint32_t kgd_gfx_v9_enable_debug_trap(struct amdgpu_device *adev,
+				bool restore_dbg_registers,
+				uint32_t vmid)
+{
+	mutex_lock(&adev->grbm_idx_mutex);
+
+	kgd_gfx_v9_set_wave_launch_stall(adev, vmid, true);
+
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_MASK), 0);
+
+	kgd_gfx_v9_set_wave_launch_stall(adev, vmid, false);
+
+	mutex_unlock(&adev->grbm_idx_mutex);
+
+	return 0;
+}
+
+uint32_t kgd_gfx_v9_disable_debug_trap(struct amdgpu_device *adev,
+					bool keep_trap_enabled,
+					uint32_t vmid)
+{
+	mutex_lock(&adev->grbm_idx_mutex);
+
+	kgd_gfx_v9_set_wave_launch_stall(adev, vmid, true);
+
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_MASK), 0);
+
+	kgd_gfx_v9_set_wave_launch_stall(adev, vmid, false);
+
+	mutex_unlock(&adev->grbm_idx_mutex);
+
+	return 0;
+}
+
 void kgd_gfx_v9_set_vm_context_page_table_base(struct amdgpu_device *adev,
 			uint32_t vmid, uint64_t page_table_base)
 {
@@ -833,7 +911,7 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev, int pasid,
 void kgd_gfx_v9_program_trap_handler_settings(struct amdgpu_device *adev,
                         uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr)
 {
-	lock_srbm(adev, 0, 0, 0, vmid);
+	kgd_gfx_v9_lock_srbm(adev, 0, 0, 0, vmid);
 
 	/*
 	 * Program TBA registers
@@ -851,7 +929,7 @@ void kgd_gfx_v9_program_trap_handler_settings(struct amdgpu_device *adev,
 	WREG32_SOC15(GC, 0, mmSQ_SHADER_TMA_HI,
 			upper_32_bits(tma_addr >> 8));
 
-	unlock_srbm(adev);
+	kgd_gfx_v9_unlock_srbm(adev);
 }
 
 const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
@@ -871,6 +949,8 @@ const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
 	.get_atc_vmid_pasid_mapping_info =
 			kgd_gfx_v9_get_atc_vmid_pasid_mapping_info,
 	.set_vm_context_page_table_base = kgd_gfx_v9_set_vm_context_page_table_base,
+	.enable_debug_trap = kgd_gfx_v9_enable_debug_trap,
+	.disable_debug_trap = kgd_gfx_v9_disable_debug_trap,
 	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
 	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
index c7ed3bc9053c..d39256162616 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
@@ -58,3 +58,12 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev, int pasid,
 		int *pasid_wave_cnt, int *max_waves_per_cu);
 void kgd_gfx_v9_program_trap_handler_settings(struct amdgpu_device *adev,
 		uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr);
+void kgd_gfx_v9_set_wave_launch_stall(struct amdgpu_device *adev,
+					uint32_t vmid,
+					bool stall);
+uint32_t kgd_gfx_v9_enable_debug_trap(struct amdgpu_device *adev,
+				      bool restore_dbg_registers,
+				      uint32_t vmid);
+uint32_t kgd_gfx_v9_disable_debug_trap(struct amdgpu_device *adev,
+					bool keep_trap_enabled,
+					uint32_t vmid);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
index b2217eb1399c..8aa7a3ad4e97 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
@@ -25,6 +25,9 @@
 
 #include "kfd_priv.h"
 
+void kgd_gfx_v9_set_wave_launch_stall(struct amdgpu_device *adev,
+					uint32_t vmid,
+					bool stall);
 int kfd_dbg_trap_disable(struct kfd_process *target);
 int kfd_dbg_trap_enable(struct kfd_process *target, uint32_t fd,
 			void __user *runtime_info,
-- 
2.25.1


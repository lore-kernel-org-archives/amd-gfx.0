Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD9EECAAD2
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 14:31:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E788A10F2F4;
	Mon, 29 Aug 2022 14:31:18 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79F5F10F2DD
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 14:30:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aT06PBiC4Uf2TNfucVEeNUOpT1ixUY1R3Hi84Es4lOmJNIhZ/J8gEkJ4ZVOboNcnRshNHf4j03Ea0hVENErvYmzG1g4NXeULOjpPXTuRfqp50uu7AYNyZImOGk80wks66MSUI4715qP7GRLdd5vFW2M3TYanswV8wZY5zMDJzl/3egpvegqKCjkrlHzwB90wVm0mCFiBL6XR+o/EqnM79Uuu2slJ1qQyMRLCI5WmEmi1ml19CI8RjQbHYPgbm9RMCzdFJ77aVSR0QNsVyjDCAHxAOGGJlbf/FExlg/5uQoyg2M41qkJxmc6hAKnhx87Lo+pvGIGksJ7Om0kgL38QOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzGOPLlTpbLXT6DQQDAE1dvk63zHfA+IDV5fQGbaSUE=;
 b=m6DY+AXwpE1DsT4A8fhX6Otyp8BMPQ+9XfD5oujJwrVEo50NYqA5mWnoqzWgZ/XYjupqycJhBLJoSFzYquLhgQISafdejcT17PSJ95Fo4aQ5PmrswwoAHWDA6Pvtr9IqTlPUH+3DWMEVr6Hl2XWp9/I66ru2Mh1rxgKBjSxKhJiwe3pe2hlOCtJxnVf1x2wJRj608bf/OOSdmzXJShmNZiFNHhzRbOgMQ/ADuDkQhQMdz43RrIxSM5wIOhiIzGa8blZe+Kw+fACedCLM7BHEUS4pmWybkfwjzo2qbnbw5ta9qTv59zAN1DK+Xt16CzULSMRsyvQk9sNoUH/T1woFsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzGOPLlTpbLXT6DQQDAE1dvk63zHfA+IDV5fQGbaSUE=;
 b=m7e18q7JDEDGMAFHPUeYELaJfZGWrSVU4FyZ/4/Knh4d6Rskid+UOUTZ9RIU2W3iubD1iNdBX5dmTVFhIAomkZ3pfeeFaXgga0LmGsgo9ETO6DYEHdVEgM1XUaYEv0vcb89djYnVEbXBTeMd5/yj8RVAw25t3hkni4iFsnXUSS4=
Received: from MW4PR04CA0104.namprd04.prod.outlook.com (2603:10b6:303:83::19)
 by BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Mon, 29 Aug
 2022 14:30:50 +0000
Received: from CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::e7) by MW4PR04CA0104.outlook.office365.com
 (2603:10b6:303:83::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Mon, 29 Aug 2022 14:30:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT112.mail.protection.outlook.com (10.13.174.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 14:30:49 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 09:30:44 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/29] drm/amdgpu: add gfx10 hw debug mode enable and disable
 calls
Date: Mon, 29 Aug 2022 10:30:05 -0400
Message-ID: <20220829143026.1509027-9-jonathan.kim@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 70db0f99-6fef-44dd-20fc-08da89cb11ff
X-MS-TrafficTypeDiagnostic: BN9PR12MB5368:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rpmx4f40UrYBN+AJLKlBRt/9y4KD6Jd70VjWIkwtVMc8g9G+BiJBDr0vu7OCUyN/xNLOOaJ0xNwPGNFBgvryz1GekuPBwN3bASwZjL5N48JH8nTDr1yXXC5px05dZ34A6Qm/M18mno592uZ7KxMVf1A3d3jqBJ+E4cXi8/LyAQIXGuYiZVJk18LjCfScvR7cRAXJGRNSLAN9HI74QeDvW17KTglpr8TFocj0xskCewXkFZtcozhslBsqav9UwIqXcp2K7hjCXzDGys+rkt1SJ+3TjSmef2dW3+DXfXYFgOYqJrH8Vb2Rm3v0i5lfwN9t3yvDZCPAJEuFfBFDjVYNB8IrB9S9rTYlEdX+W/UuX7l7sdJi07XtLHrDc4nC0s6Cux7uqfZY/GDhc9KvV/8Q60qZBtRQRl6tpLisHtqokO46rF+JdH5jRYqLiWknIy1zHoSf8EIGFk7s6kkB3CWvJFN4JRdPT1VM6cGuIq8q8yIUhfyPz1+sHzxJaSazP7Sjs174lz9WNM9ejkrGLNpGKY6vtFuTbhN8/WkmCWrwbdiA1Quv72n7izhusPUOO3VH0QXI1dAhud+CyWG6DASUJi8reTO6ENlPhGIGrxFB37vF0F9tqcFJsDulWIDZfbst5EhHJdlMniWx50NCQ8t64l4e5rPhST/zYqJpKek0K0inM/fHbYcIjqxAq3d9GhMJSVxh5u7Zvnw+1gdK392K8mb11OkfUyQo6aVAh8uvHol5DcYxXlo3Mi7HaFxET8tN4CV9UrpwRFzuzSKPfSzNrmn5Utk9xe9Zz6uzr6c/FQsNCb0Whzd8sH05e72pQPj+
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(396003)(39860400002)(376002)(136003)(36840700001)(46966006)(40470700004)(82310400005)(7696005)(83380400001)(2906002)(6666004)(30864003)(2616005)(44832011)(82740400003)(40480700001)(336012)(47076005)(186003)(426003)(36860700001)(16526019)(8676002)(4326008)(86362001)(70206006)(70586007)(40460700003)(1076003)(316002)(26005)(6916009)(81166007)(54906003)(36756003)(356005)(41300700001)(8936002)(478600001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 14:30:49.7927 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70db0f99-6fef-44dd-20fc-08da89cb11ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5368
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

Similar to GFX9 debug devices, set the hardware debug mode by draining
the SPI appropriately prior the mode setting request.

Because GFX10 has waves allocated by the work group boundaray and each
SE's SPI instances do not communicate, the SPI drain time is much longer.
This long drain time will be fixed for GFX11 onwards.

Also remove a bunch of deprecated misplaced references for GFX10.3.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    |  95 +++++++++++
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h    |  28 ++++
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c  | 147 +-----------------
 3 files changed, 126 insertions(+), 144 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 9378fc79e9ea..c09b45de02d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -708,6 +708,99 @@ static void set_vm_context_page_table_base(struct amdgpu_device *adev,
 	adev->gfxhub.funcs->setup_vm_pt_regs(adev, vmid, page_table_base);
 }
 
+/*
+ * GFX10 helper for wave launch stall requirements on debug trap setting.
+ *
+ * vmid:
+ *   Target VMID to stall/unstall.
+ *
+ * stall:
+ *   0-unstall wave launch (enable), 1-stall wave launch (disable).
+ *   After wavefront launch has been stalled, allocated waves must drain from
+ *   SPI in order for debug trap settings to take effect on those waves.
+ *   This is roughly a ~3500 clock cycle wait on SPI where a read on
+ *   SPI_GDBG_WAVE_CNTL translates to ~32 clock cycles.
+ *   KGD_GFX_V10_WAVE_LAUNCH_SPI_DRAIN_LATENCY indicates the number of reads required.
+ *
+ *   NOTE: We can afford to clear the entire STALL_VMID field on unstall
+ *   because current GFX10 chips cannot support multi-process debugging due to
+ *   trap configuration and masking being limited to global scope.  Always
+ *   assume single process conditions.
+ *
+ */
+
+#define KGD_GFX_V10_WAVE_LAUNCH_SPI_DRAIN_LATENCY	110
+static void kgd_gfx_v10_set_wave_launch_stall(struct amdgpu_device *adev, uint32_t vmid, bool stall)
+{
+	uint32_t data = RREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_WAVE_CNTL));
+	int i;
+
+	data = REG_SET_FIELD(data, SPI_GDBG_WAVE_CNTL, STALL_VMID,
+							stall ? 1 << vmid : 0);
+
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_WAVE_CNTL), data);
+
+	if (!stall)
+		return;
+
+	for (i = 0; i < KGD_GFX_V10_WAVE_LAUNCH_SPI_DRAIN_LATENCY; i++)
+		RREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_WAVE_CNTL));
+}
+
+uint32_t kgd_gfx_v10_enable_debug_trap(struct amdgpu_device *adev,
+				bool restore_dbg_registers,
+				uint32_t vmid)
+{
+
+	mutex_lock(&adev->grbm_idx_mutex);
+
+	kgd_gfx_v10_set_wave_launch_stall(adev, vmid, true);
+
+	/* assume gfx off is disabled for the debug session if rlc restore not supported. */
+	if (restore_dbg_registers) {
+		uint32_t data = 0;
+
+		data = REG_SET_FIELD(data, SPI_GDBG_TRAP_CONFIG,
+				VMID_SEL, 1 << vmid);
+		data = REG_SET_FIELD(data, SPI_GDBG_TRAP_CONFIG,
+				TRAP_EN, 1);
+		WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_CONFIG), data);
+		WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_DATA0), 0);
+		WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_DATA1), 0);
+
+		kgd_gfx_v10_set_wave_launch_stall(adev, vmid, false);
+
+		mutex_unlock(&adev->grbm_idx_mutex);
+
+		return 0;
+	}
+
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_MASK), 0);
+
+	kgd_gfx_v10_set_wave_launch_stall(adev, vmid, false);
+
+	mutex_unlock(&adev->grbm_idx_mutex);
+
+	return 0;
+}
+
+uint32_t kgd_gfx_v10_disable_debug_trap(struct amdgpu_device *adev,
+					bool keep_trap_enabled,
+					uint32_t vmid)
+{
+	mutex_lock(&adev->grbm_idx_mutex);
+
+	kgd_gfx_v10_set_wave_launch_stall(adev, vmid, true);
+
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_MASK), 0);
+
+	kgd_gfx_v10_set_wave_launch_stall(adev, vmid, false);
+
+	mutex_unlock(&adev->grbm_idx_mutex);
+
+	return 0;
+}
+
 static void program_trap_handler_settings(struct amdgpu_device *adev,
 		uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr)
 {
@@ -750,5 +843,7 @@ const struct kfd2kgd_calls gfx_v10_kfd2kgd = {
 	.get_atc_vmid_pasid_mapping_info =
 			get_atc_vmid_pasid_mapping_info,
 	.set_vm_context_page_table_base = set_vm_context_page_table_base,
+	.enable_debug_trap = kgd_gfx_v10_enable_debug_trap,
+	.disable_debug_trap = kgd_gfx_v10_disable_debug_trap,
 	.program_trap_handler_settings = program_trap_handler_settings,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
new file mode 100644
index 000000000000..370d6c312981
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
@@ -0,0 +1,28 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+uint32_t kgd_gfx_v10_enable_debug_trap(struct amdgpu_device *adev,
+				      bool restore_dbg_registers,
+				      uint32_t vmid);
+uint32_t kgd_gfx_v10_disable_debug_trap(struct amdgpu_device *adev,
+					bool keep_trap_enabled,
+					uint32_t vmid);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
index ba21ec6b35e0..73e3b9ae1fb0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
@@ -22,6 +22,7 @@
 #include <linux/mmu_context.h>
 #include "amdgpu.h"
 #include "amdgpu_amdkfd.h"
+#include "amdgpu_amdkfd_gfx_v10.h"
 #include "gc/gc_10_3_0_offset.h"
 #include "gc/gc_10_3_0_sh_mask.h"
 #include "oss/osssys_5_0_0_offset.h"
@@ -652,142 +653,6 @@ static void program_trap_handler_settings_v10_3(struct amdgpu_device *adev,
 	unlock_srbm(adev);
 }
 
-#if 0
-uint32_t enable_debug_trap_v10_3(struct amdgpu_device *adev,
-				uint32_t trap_debug_wave_launch_mode,
-				uint32_t vmid)
-{
-	uint32_t data = 0;
-	uint32_t orig_wave_cntl_value;
-	uint32_t orig_stall_vmid;
-
-	mutex_lock(&adev->grbm_idx_mutex);
-
-	orig_wave_cntl_value = RREG32(SOC15_REG_OFFSET(GC,
-				0,
-				mmSPI_GDBG_WAVE_CNTL));
-	orig_stall_vmid = REG_GET_FIELD(orig_wave_cntl_value,
-			SPI_GDBG_WAVE_CNTL,
-			STALL_VMID);
-
-	data = REG_SET_FIELD(data, SPI_GDBG_WAVE_CNTL, STALL_RA, 1);
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_WAVE_CNTL), data);
-
-	data = 0;
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_MASK), data);
-
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_WAVE_CNTL), orig_stall_vmid);
-
-	mutex_unlock(&adev->grbm_idx_mutex);
-
-	return 0;
-}
-
-uint32_t disable_debug_trap_v10_3(struct amdgpu_device *adev)
-{
-	mutex_lock(&adev->grbm_idx_mutex);
-
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_MASK), 0);
-
-	mutex_unlock(&adev->grbm_idx_mutex);
-
-	return 0;
-}
-
-uint32_t set_wave_launch_trap_override_v10_3(struct amdgpu_device *adev,
-						uint32_t trap_override,
-						uint32_t trap_mask)
-{
-	uint32_t data = 0;
-
-	mutex_lock(&adev->grbm_idx_mutex);
-
-	data = RREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_WAVE_CNTL));
-	data = REG_SET_FIELD(data, SPI_GDBG_WAVE_CNTL, STALL_RA, 1);
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_WAVE_CNTL), data);
-
-	data = 0;
-	data = REG_SET_FIELD(data, SPI_GDBG_TRAP_MASK,
-			EXCP_EN, trap_mask);
-	data = REG_SET_FIELD(data, SPI_GDBG_TRAP_MASK,
-			REPLACE, trap_override);
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_MASK), data);
-
-	data = RREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_WAVE_CNTL));
-	data = REG_SET_FIELD(data, SPI_GDBG_WAVE_CNTL, STALL_RA, 0);
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_WAVE_CNTL), data);
-
-	mutex_unlock(&adev->grbm_idx_mutex);
-
-	return 0;
-}
-
-uint32_t set_wave_launch_mode_v10_3(struct amdgpu_device *adev,
-					uint8_t wave_launch_mode,
-					uint32_t vmid)
-{
-	uint32_t data = 0;
-	bool is_stall_mode;
-	bool is_mode_set;
-
-	is_stall_mode = (wave_launch_mode == 4);
-	is_mode_set = (wave_launch_mode != 0 && wave_launch_mode != 4);
-
-	mutex_lock(&adev->grbm_idx_mutex);
-
-	data = REG_SET_FIELD(data, SPI_GDBG_WAVE_CNTL2,
-			VMID_MASK, is_mode_set ? 1 << vmid : 0);
-	data = REG_SET_FIELD(data, SPI_GDBG_WAVE_CNTL2,
-			MODE, is_mode_set ? wave_launch_mode : 0);
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_WAVE_CNTL2), data);
-
-	data = RREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_WAVE_CNTL));
-	data = REG_SET_FIELD(data, SPI_GDBG_WAVE_CNTL,
-			STALL_VMID, is_stall_mode ? 1 << vmid : 0);
-	data = REG_SET_FIELD(data, SPI_GDBG_WAVE_CNTL,
-			STALL_RA, is_stall_mode ? 1 : 0);
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_WAVE_CNTL), data);
-
-	mutex_unlock(&adev->grbm_idx_mutex);
-
-	return 0;
-}
-
-/* kgd_get_iq_wait_times: Returns the mmCP_IQ_WAIT_TIME1/2 values
- * The values read are:
- *	ib_offload_wait_time     -- Wait Count for Indirect Buffer Offloads.
- *	atomic_offload_wait_time -- Wait Count for L2 and GDS Atomics Offloads.
- *	wrm_offload_wait_time    -- Wait Count for WAIT_REG_MEM Offloads.
- *	gws_wait_time            -- Wait Count for Global Wave Syncs.
- *	que_sleep_wait_time      -- Wait Count for Dequeue Retry.
- *	sch_wave_wait_time       -- Wait Count for Scheduling Wave Message.
- *	sem_rearm_wait_time      -- Wait Count for Semaphore re-arm.
- *	deq_retry_wait_time      -- Wait Count for Global Wave Syncs.
- */
-void get_iq_wait_times_v10_3(struct amdgpu_device *adev,
-					uint32_t *wait_times)
-
-{
-	*wait_times = RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_IQ_WAIT_TIME2));
-}
-
-void build_grace_period_packet_info_v10_3(struct amdgpu_device *adev,
-						uint32_t wait_times,
-						uint32_t grace_period,
-						uint32_t *reg_offset,
-						uint32_t *reg_data)
-{
-	*reg_data = wait_times;
-
-	*reg_data = REG_SET_FIELD(*reg_data,
-			CP_IQ_WAIT_TIME2,
-			SCH_WAVE,
-			grace_period);
-
-	*reg_offset = mmCP_IQ_WAIT_TIME2;
-}
-#endif
-
 const struct kfd2kgd_calls gfx_v10_3_kfd2kgd = {
 	.program_sh_mem_settings = program_sh_mem_settings_v10_3,
 	.set_pasid_vmid_mapping = set_pasid_vmid_mapping_v10_3,
@@ -805,12 +670,6 @@ const struct kfd2kgd_calls gfx_v10_3_kfd2kgd = {
 	.get_atc_vmid_pasid_mapping_info = get_atc_vmid_pasid_mapping_info_v10_3,
 	.set_vm_context_page_table_base = set_vm_context_page_table_base_v10_3,
 	.program_trap_handler_settings = program_trap_handler_settings_v10_3,
-#if 0
-	.enable_debug_trap = enable_debug_trap_v10_3,
-	.disable_debug_trap = disable_debug_trap_v10_3,
-	.set_wave_launch_trap_override = set_wave_launch_trap_override_v10_3,
-	.set_wave_launch_mode = set_wave_launch_mode_v10_3,
-	.get_iq_wait_times = get_iq_wait_times_v10_3,
-	.build_grace_period_packet_info = build_grace_period_packet_info_v10_3,
-#endif
+	.enable_debug_trap = kgd_gfx_v10_enable_debug_trap,
+	.disable_debug_trap = kgd_gfx_v10_disable_debug_trap
 };
-- 
2.25.1


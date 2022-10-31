Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1108FA3741
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Oct 2022 16:24:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4695E10E2EA;
	Mon, 31 Oct 2022 16:24:41 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 233FA10E2DA
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Oct 2022 16:24:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbhGiQ2bh3E204gitqpQzdWTv0AyCdSbD5GUdxHWfIrvHH4nVC6K70fjYNq14GOXOLFIzzXdhUhhl9XHHAOJni4BZS6CXGGIz627a5HxFJ0GlPEVwIrmrT9UvR7CrrC87CKa7+jpoayJDzcNkgxUBJFb6TY9Ve1VvDHuNRxlprNurg79/CnDIbTMv5tbxeGzD5oKEaNYxQG2OxL71UfHsIYvlkNwqaHFP/i7z2hm+H4ZOwyRGynOPmH3i5lkTIVNUbHWdwMq2AqscAXnBp/HjHJjbo2LgD9jvN/kIZtS9o7SM31YY3doNtz/dPUKnkiFUKAf2Ctlq8xqaoLLxqWGtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QN/9EqAYs08W/FSOOuGTW3aIcibFVMhuCTPgh+hp/h8=;
 b=kfst/rxJiPk/cLXsVInH8q2rNITbvqMl7qxMtMNJ+KnQnoEFMSNXQ6rM6AQx8RLkGtMCXUYf282RDK9KkXwHMyy7s0oR7JeyTqAUSkBAQX3O62XamPhGtfPkUw2L71sJSfa0mgmhrpuPSYrfnrR57NoxjF6WY5a8k3Zb7deBjZ2JYOFLcGi//snwlhtStwhOU6QcBMmTxcnnuDdvjQtfUSDGvvRS2P35Pdxfk9f93o7rPW48bgdA83qrw4yz0aQk8lecYEe2dQ3GQPC8zrVn4xFyCJUwUDnlx6NPb7YKrY3idnJORAbzznAt/2XM6M9e17zT966aamEQT8ykR75T5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QN/9EqAYs08W/FSOOuGTW3aIcibFVMhuCTPgh+hp/h8=;
 b=bA3GJ/Z3gA4Z1O5klxUW83HRltBc5GY/gRlQg0nx4RzaIV3OmQQoD0TFGo7lpdDzwo2/BTHwsbq9vUFMdSTOju391rJusZpuUxD7KscUqK6+aTz80k4x4/rpN2n3a5dnJsxnBVmG3VhD5BAkpLs2uzqT2k3v7ohpr2f6fEggUqI=
Received: from MW4PR03CA0220.namprd03.prod.outlook.com (2603:10b6:303:b9::15)
 by PH8PR12MB7424.namprd12.prod.outlook.com (2603:10b6:510:228::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 16:24:33 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::75) by MW4PR03CA0220.outlook.office365.com
 (2603:10b6:303:b9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19 via Frontend
 Transport; Mon, 31 Oct 2022 16:24:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Mon, 31 Oct 2022 16:24:32 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 31 Oct
 2022 11:24:28 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/29] drm/amdkfd: add debug wave launch override operation
Date: Mon, 31 Oct 2022 12:23:50 -0400
Message-ID: <20221031162359.445805-20-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221031162359.445805-1-jonathan.kim@amd.com>
References: <20221031162359.445805-1-jonathan.kim@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT004:EE_|PH8PR12MB7424:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f442435-c6c1-4ef0-20c2-08dabb5c64b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZdNAN2V4aogTujhr53K6QO/5bzcUWuN1tvziyqdAUcHOxkjYxnUuu4k6dtH8XEnZR2Df2daltBfjgKvuHJpLNd3I/0mc8tjz+uwPBYr/mPV8UYRvP2Y1Wah9Bs/ZqbK6p4Dbjhvyt0q8ErTRwKMGr7cl+LqE8Z2iRA7kivd3nFDYjqp9JLpzNRPlDCGmnDwAttln5Ewg0xsGsnDwXY98PO5nl3rH1ljZB3TYF9zB/wooxovHdoyRPcJyKMRkZcJXRVduu4UTPNMCLO+537Il8EQoC0HOhGxe5YPIX3JBla04efCdmoKUxM7g9jrynsZfVSvn9qUSf0FfCLjapV9NGqv2a/bH3mrUbn2NSFTj4XrGzOl1DPUIJUSP/Rqo/JCFFXw6SbAAqlne33mUi5iF7eNfEBPczcGQ/Htwr1gISHGrkjtCAU5gps6F3GjQmIwVjcx+W66G3WYheUcxuz13EkuM6Vx4C27j+yiVeroPqPyFpSMgHmFr0TH1tVC8eLOtFhr7VC3eFKvJMp84swHN2crCLWlNVIb4Xr3w/hmbunIJUUiWW1bH1IkufZpDb9ZpXxR4HIKA4nhluniJzUJR0xWWOLoXE6k/59ACyP5kPW0viRxtOCC2agUnHEK6B7hjMwt5zCVf7xGaV7PsywTXdykYf63DqnBdO/juauLcpKpBeVlTqqQaqkPs/0PEjXI7LL5RMJKQbE5MUVs1K+6UjI1um7efqDb7Hh9jBoz7Y98CK4/tcxEFLBTo1T61Gl9wGEhe6SBtFtg9Yw8h8oqh8f5vi6OsTPuOXucG1zic2WZxkBo/g78P5ObsSNbY/12C
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199015)(36840700001)(40470700004)(46966006)(82310400005)(36756003)(86362001)(30864003)(426003)(47076005)(186003)(16526019)(40460700003)(336012)(1076003)(83380400001)(81166007)(356005)(41300700001)(5660300002)(8936002)(8676002)(4326008)(70586007)(36860700001)(6916009)(316002)(44832011)(2906002)(2616005)(7696005)(82740400003)(26005)(478600001)(6666004)(70206006)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 16:24:32.5277 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f442435-c6c1-4ef0-20c2-08dabb5c64b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7424
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This operation allows the debugger to override the enabled HW
exceptions on the device.

On debug devices that only support the debugging of a single process,
the HW exceptions are global and set through the SPI_GDBG_TRAP_MASK
register.
Because they are global, only address watch exceptions are allowed to
be enabled.  In other words, the debugger must preserve all non-address
watch exception states in normal mode operation by barring a full
replacement override or a non-address watch override request.

For multi-process debugging, all HW exception overrides are per-VMID so
all exceptions can be overridden or fully replaced.

In order for the debugger to know what is permissible, returned the
supported override mask back to the debugger along with the previously
enable overrides.

v2: switch unsupported override mode return from EPERM to EINVAL to
support unique EPERM on PTRACE failure.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  | 47 ++++++++++++++
 .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   |  2 +
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    | 55 ++++++++++++++++
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h    | 10 +++
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c  |  5 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 55 ++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h | 10 +++
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  7 ++
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c        | 65 +++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_debug.h        |  6 ++
 10 files changed, 261 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
index c9629fc5460c..a5003f6f05bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
@@ -25,6 +25,7 @@
 #include "amdgpu_amdkfd_gfx_v9.h"
 #include "gc/gc_9_4_2_offset.h"
 #include "gc/gc_9_4_2_sh_mask.h"
+#include <uapi/linux/kfd_ioctl.h>
 
 /* returns TRAP_EN, EXCP_EN and EXCP_REPLACE. */
 static uint32_t kgd_aldebaran_enable_debug_trap(struct amdgpu_device *adev,
@@ -54,6 +55,50 @@ static uint32_t kgd_aldebaran_disable_debug_trap(struct amdgpu_device *adev,
 	return data;
 }
 
+static int kgd_aldebaran_validate_trap_override_request(struct amdgpu_device *adev,
+							uint32_t trap_override,
+							uint32_t *trap_mask_supported)
+{
+	*trap_mask_supported &= KFD_DBG_TRAP_MASK_FP_INVALID |
+				KFD_DBG_TRAP_MASK_FP_INPUT_DENORMAL |
+				KFD_DBG_TRAP_MASK_FP_DIVIDE_BY_ZERO |
+				KFD_DBG_TRAP_MASK_FP_OVERFLOW |
+				KFD_DBG_TRAP_MASK_FP_UNDERFLOW |
+				KFD_DBG_TRAP_MASK_FP_INEXACT |
+				KFD_DBG_TRAP_MASK_INT_DIVIDE_BY_ZERO |
+				KFD_DBG_TRAP_MASK_DBG_ADDRESS_WATCH |
+				KFD_DBG_TRAP_MASK_DBG_MEMORY_VIOLATION;
+
+	if (trap_override != KFD_DBG_TRAP_OVERRIDE_OR &&
+			trap_override != KFD_DBG_TRAP_OVERRIDE_REPLACE)
+		return -EPERM;
+
+	return 0;
+}
+
+/* returns TRAP_EN, EXCP_EN and EXCP_RPLACE. */
+static uint32_t kgd_aldebaran_set_wave_launch_trap_override(struct amdgpu_device *adev,
+					uint32_t vmid,
+					uint32_t trap_override,
+					uint32_t trap_mask_bits,
+					uint32_t trap_mask_request,
+					uint32_t *trap_mask_prev,
+					uint32_t kfd_dbg_trap_cntl_prev)
+
+{
+	uint32_t data = 0;
+
+	*trap_mask_prev = REG_GET_FIELD(kfd_dbg_trap_cntl_prev, SPI_GDBG_PER_VMID_CNTL, EXCP_EN);
+	trap_mask_bits = (trap_mask_bits & trap_mask_request) |
+		(*trap_mask_prev & ~trap_mask_request);
+
+	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN, 1);
+	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_EN, trap_mask_bits);
+	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_REPLACE, trap_override);
+
+	return data;
+}
+
 const struct kfd2kgd_calls aldebaran_kfd2kgd = {
 	.program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
 	.set_pasid_vmid_mapping = kgd_gfx_v9_set_pasid_vmid_mapping,
@@ -73,6 +118,8 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd = {
 	.set_vm_context_page_table_base = kgd_gfx_v9_set_vm_context_page_table_base,
 	.enable_debug_trap = kgd_aldebaran_enable_debug_trap,
 	.disable_debug_trap = kgd_aldebaran_disable_debug_trap,
+	.validate_trap_override_request = kgd_aldebaran_validate_trap_override_request,
+	.set_wave_launch_trap_override = kgd_aldebaran_set_wave_launch_trap_override,
 	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
 	.build_grace_period_packet_info = kgd_gfx_v9_build_grace_period_packet_info,
 	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
index 60a204f767ba..b3682758184f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
@@ -397,6 +397,8 @@ const struct kfd2kgd_calls arcturus_kfd2kgd = {
 				kgd_gfx_v9_set_vm_context_page_table_base,
 	.enable_debug_trap = kgd_arcturus_enable_debug_trap,
 	.disable_debug_trap = kgd_arcturus_disable_debug_trap,
+	.validate_trap_override_request = kgd_gfx_v9_validate_trap_override_request,
+	.set_wave_launch_trap_override = kgd_gfx_v9_set_wave_launch_trap_override,
 	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
 	.build_grace_period_packet_info = kgd_gfx_v9_build_grace_period_packet_info,
 	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 2491402afd58..32a6e5fbeacd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -31,6 +31,7 @@
 #include "v10_structs.h"
 #include "nv.h"
 #include "nvd.h"
+#include <uapi/linux/kfd_ioctl.h>
 
 enum hqd_dequeue_request_type {
 	NO_ACTION = 0,
@@ -801,6 +802,58 @@ uint32_t kgd_gfx_v10_disable_debug_trap(struct amdgpu_device *adev,
 	return 0;
 }
 
+int kgd_gfx_v10_validate_trap_override_request(struct amdgpu_device *adev,
+					      uint32_t trap_override,
+					      uint32_t *trap_mask_supported)
+{
+	*trap_mask_supported &= KFD_DBG_TRAP_MASK_DBG_ADDRESS_WATCH;
+
+	/* The SPI_GDBG_TRAP_MASK register is global and affects all
+	 * processes. Only allow OR-ing the address-watch bit, since
+	 * this only affects processes under the debugger. Other bits
+	 * should stay 0 to avoid the debugger interfering with other
+	 * processes.
+	 */
+	if (trap_override != KFD_DBG_TRAP_OVERRIDE_OR)
+		return -EINVAL;
+
+	return 0;
+}
+
+uint32_t kgd_gfx_v10_set_wave_launch_trap_override(struct amdgpu_device *adev,
+					      uint32_t vmid,
+					      uint32_t trap_override,
+					      uint32_t trap_mask_bits,
+					      uint32_t trap_mask_request,
+					      uint32_t *trap_mask_prev,
+					      uint32_t kfd_dbg_trap_cntl_prev)
+{
+	uint32_t data, wave_cntl_prev;
+
+	mutex_lock(&adev->grbm_idx_mutex);
+
+	wave_cntl_prev = RREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_WAVE_CNTL));
+
+	kgd_gfx_v10_set_wave_launch_stall(adev, vmid, true);
+
+	data = RREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_MASK));
+	*trap_mask_prev = REG_GET_FIELD(data, SPI_GDBG_TRAP_MASK, EXCP_EN);
+
+	trap_mask_bits = (trap_mask_bits & trap_mask_request) |
+		(*trap_mask_prev & ~trap_mask_request);
+
+	data = REG_SET_FIELD(data, SPI_GDBG_TRAP_MASK, EXCP_EN, trap_mask_bits);
+	data = REG_SET_FIELD(data, SPI_GDBG_TRAP_MASK, REPLACE, trap_override);
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_MASK), data);
+
+	/* We need to preserve wave launch mode stall settings. */
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_WAVE_CNTL), wave_cntl_prev);
+
+	mutex_unlock(&adev->grbm_idx_mutex);
+
+	return 0;
+}
+
 /* kgd_gfx_v10_get_iq_wait_times: Returns the mmCP_IQ_WAIT_TIME1/2 values
  * The values read are:
  *     ib_offload_wait_time     -- Wait Count for Indirect Buffer Offloads.
@@ -886,6 +939,8 @@ const struct kfd2kgd_calls gfx_v10_kfd2kgd = {
 	.set_vm_context_page_table_base = set_vm_context_page_table_base,
 	.enable_debug_trap = kgd_gfx_v10_enable_debug_trap,
 	.disable_debug_trap = kgd_gfx_v10_disable_debug_trap,
+	.validate_trap_override_request = kgd_gfx_v10_validate_trap_override_request,
+	.set_wave_launch_trap_override = kgd_gfx_v10_set_wave_launch_trap_override,
 	.get_iq_wait_times = kgd_gfx_v10_get_iq_wait_times,
 	.build_grace_period_packet_info = kgd_gfx_v10_build_grace_period_packet_info,
 	.program_trap_handler_settings = program_trap_handler_settings,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
index 0abc1e805180..85c929fc2926 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
@@ -26,6 +26,16 @@ uint32_t kgd_gfx_v10_enable_debug_trap(struct amdgpu_device *adev,
 uint32_t kgd_gfx_v10_disable_debug_trap(struct amdgpu_device *adev,
 					bool keep_trap_enabled,
 					uint32_t vmid);
+int kgd_gfx_v10_validate_trap_override_request(struct amdgpu_device *adev,
+					     uint32_t trap_override,
+					     uint32_t *trap_mask_supported);
+uint32_t kgd_gfx_v10_set_wave_launch_trap_override(struct amdgpu_device *adev,
+					     uint32_t vmid,
+					     uint32_t trap_override,
+					     uint32_t trap_mask_bits,
+					     uint32_t trap_mask_request,
+					     uint32_t *trap_mask_prev,
+					     uint32_t kfd_dbg_trap_cntl_prev);
 void kgd_gfx_v10_get_iq_wait_times(struct amdgpu_device *adev, uint32_t *wait_times);
 void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *adev,
 					       uint32_t wait_times,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
index c57f2a6b6e23..ae3ead207df4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
@@ -673,5 +673,8 @@ const struct kfd2kgd_calls gfx_v10_3_kfd2kgd = {
 	.get_iq_wait_times = kgd_gfx_v10_get_iq_wait_times,
 	.build_grace_period_packet_info = kgd_gfx_v10_build_grace_period_packet_info,
 	.enable_debug_trap = kgd_gfx_v10_enable_debug_trap,
-	.disable_debug_trap = kgd_gfx_v10_disable_debug_trap
+	.disable_debug_trap = kgd_gfx_v10_disable_debug_trap,
+	.validate_trap_override_request = kgd_gfx_v10_validate_trap_override_request,
+	.set_wave_launch_trap_override = kgd_gfx_v10_set_wave_launch_trap_override
+
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 673c99c5523d..cb0044bbfae5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -38,6 +38,7 @@
 #include "soc15d.h"
 #include "gfx_v9_0.h"
 #include "amdgpu_amdkfd_gfx_v9.h"
+#include <uapi/linux/kfd_ioctl.h>
 
 enum hqd_dequeue_request_type {
 	NO_ACTION = 0,
@@ -724,6 +725,58 @@ uint32_t kgd_gfx_v9_disable_debug_trap(struct amdgpu_device *adev,
 	return 0;
 }
 
+int kgd_gfx_v9_validate_trap_override_request(struct amdgpu_device *adev,
+					uint32_t trap_override,
+					uint32_t *trap_mask_supported)
+{
+	*trap_mask_supported &= KFD_DBG_TRAP_MASK_DBG_ADDRESS_WATCH;
+
+	/* The SPI_GDBG_TRAP_MASK register is global and affects all
+	 * processes. Only allow OR-ing the address-watch bit, since
+	 * this only affects processes under the debugger. Other bits
+	 * should stay 0 to avoid the debugger interfering with other
+	 * processes.
+	 */
+	if (trap_override != KFD_DBG_TRAP_OVERRIDE_OR)
+		return -EINVAL;
+
+	return 0;
+}
+
+uint32_t kgd_gfx_v9_set_wave_launch_trap_override(struct amdgpu_device *adev,
+					     uint32_t vmid,
+					     uint32_t trap_override,
+					     uint32_t trap_mask_bits,
+					     uint32_t trap_mask_request,
+					     uint32_t *trap_mask_prev,
+					     uint32_t kfd_dbg_cntl_prev)
+{
+	uint32_t data, wave_cntl_prev;
+
+	mutex_lock(&adev->grbm_idx_mutex);
+
+	wave_cntl_prev = RREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_WAVE_CNTL));
+
+	kgd_gfx_v9_set_wave_launch_stall(adev, vmid, true);
+
+	data = RREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_MASK));
+	*trap_mask_prev = REG_GET_FIELD(data, SPI_GDBG_TRAP_MASK, EXCP_EN);
+
+	trap_mask_bits = (trap_mask_bits & trap_mask_request) |
+		(*trap_mask_prev & ~trap_mask_request);
+
+	data = REG_SET_FIELD(data, SPI_GDBG_TRAP_MASK, EXCP_EN, trap_mask_bits);
+	data = REG_SET_FIELD(data, SPI_GDBG_TRAP_MASK, REPLACE, trap_override);
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_MASK), data);
+
+	/* We need to preserve wave launch mode stall settings. */
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_WAVE_CNTL), wave_cntl_prev);
+
+	mutex_unlock(&adev->grbm_idx_mutex);
+
+	return 0;
+}
+
 /* kgd_gfx_v9_get_iq_wait_times: Returns the mmCP_IQ_WAIT_TIME1/2 values
  * The values read are:
  *     ib_offload_wait_time     -- Wait Count for Indirect Buffer Offloads.
@@ -992,6 +1045,8 @@ const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
 	.set_vm_context_page_table_base = kgd_gfx_v9_set_vm_context_page_table_base,
 	.enable_debug_trap = kgd_gfx_v9_enable_debug_trap,
 	.disable_debug_trap = kgd_gfx_v9_disable_debug_trap,
+	.validate_trap_override_request = kgd_gfx_v9_validate_trap_override_request,
+	.set_wave_launch_trap_override = kgd_gfx_v9_set_wave_launch_trap_override,
 	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
 	.build_grace_period_packet_info = kgd_gfx_v9_build_grace_period_packet_info,
 	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
index c0866497cb5c..47cff392b434 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
@@ -64,6 +64,16 @@ uint32_t kgd_gfx_v9_enable_debug_trap(struct amdgpu_device *adev,
 uint32_t kgd_gfx_v9_disable_debug_trap(struct amdgpu_device *adev,
 					bool keep_trap_enabled,
 					uint32_t vmid);
+int kgd_gfx_v9_validate_trap_override_request(struct amdgpu_device *adev,
+					     uint32_t trap_override,
+					     uint32_t *trap_mask_supported);
+uint32_t kgd_gfx_v9_set_wave_launch_trap_override(struct amdgpu_device *adev,
+					     uint32_t vmid,
+					     uint32_t trap_override,
+					     uint32_t trap_mask_bits,
+					     uint32_t trap_mask_request,
+					     uint32_t *trap_mask_prev,
+					     uint32_t kfd_dbg_trap_cntl_prev);
 void kgd_gfx_v9_get_iq_wait_times(struct amdgpu_device *adev, uint32_t *wait_times);
 void kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *adev,
 					       uint32_t wait_times,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 61612b9bdf8c..1f0ee2413b13 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2891,6 +2891,13 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
 				args->set_exceptions_enabled.exception_mask);
 		break;
 	case KFD_IOC_DBG_TRAP_SET_WAVE_LAUNCH_OVERRIDE:
+		r = kfd_dbg_trap_set_wave_launch_override(target,
+				args->launch_override.override_mode,
+				args->launch_override.enable_mask,
+				args->launch_override.support_request_mask,
+				&args->launch_override.enable_mask,
+				&args->launch_override.support_request_mask);
+		break;
 	case KFD_IOC_DBG_TRAP_SET_WAVE_LAUNCH_MODE:
 	case KFD_IOC_DBG_TRAP_SUSPEND_QUEUES:
 	case KFD_IOC_DBG_TRAP_RESUME_QUEUES:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index 594ccca25cae..8add359d1cb9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -442,6 +442,71 @@ int kfd_dbg_trap_enable(struct kfd_process *target, uint32_t fd,
 	return r;
 }
 
+static int kfd_dbg_validate_trap_override_request(struct kfd_process *p,
+						uint32_t trap_override,
+						uint32_t trap_mask_request,
+						uint32_t *trap_mask_supported)
+{
+	int i = 0;
+
+	*trap_mask_supported = 0xffffffff;
+
+	for (i = 0; i < p->n_pdds; i++) {
+		struct kfd_process_device *pdd = p->pdds[i];
+		int err = pdd->dev->kfd2kgd->validate_trap_override_request(
+								pdd->dev->adev,
+								trap_override,
+								trap_mask_supported);
+
+		if (err)
+			return err;
+	}
+
+	if (trap_mask_request & ~*trap_mask_supported)
+		return -EACCES;
+
+	return 0;
+}
+
+int kfd_dbg_trap_set_wave_launch_override(struct kfd_process *target,
+					uint32_t trap_override,
+					uint32_t trap_mask_bits,
+					uint32_t trap_mask_request,
+					uint32_t *trap_mask_prev,
+					uint32_t *trap_mask_supported)
+{
+	int r = 0, i;
+
+	r = kfd_dbg_validate_trap_override_request(target,
+						trap_override,
+						trap_mask_request,
+						trap_mask_supported);
+
+	if (r)
+		return r;
+
+	for (i = 0; i < target->n_pdds; i++) {
+		struct kfd_process_device *pdd = target->pdds[i];
+
+		amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
+		pdd->spi_dbg_override = pdd->dev->kfd2kgd->set_wave_launch_trap_override(
+				pdd->dev->adev,
+				pdd->dev->vm_info.last_vmid_kfd,
+				trap_override,
+				trap_mask_bits,
+				trap_mask_request,
+				trap_mask_prev,
+				pdd->spi_dbg_override);
+		amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
+
+		r = debug_refresh_runlist(pdd->dev->dqm);
+		if (r)
+			break;
+	}
+
+	return r;
+}
+
 void kfd_dbg_set_enabled_debug_exception_mask(struct kfd_process *target,
 					uint64_t exception_set_mask)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
index 837e09491a76..b54a50a5d310 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
@@ -45,6 +45,12 @@ int kfd_dbg_trap_disable(struct kfd_process *target);
 int kfd_dbg_trap_enable(struct kfd_process *target, uint32_t fd,
 			void __user *runtime_info,
 			uint32_t *runtime_info_size);
+int kfd_dbg_trap_set_wave_launch_override(struct kfd_process *target,
+					uint32_t trap_override,
+					uint32_t trap_mask_bits,
+					uint32_t trap_mask_request,
+					uint32_t *trap_mask_prev,
+					uint32_t *trap_mask_supported);
 
 int kfd_dbg_send_exception_to_runtime(struct kfd_process *p,
 					unsigned int dev_id,
-- 
2.25.1


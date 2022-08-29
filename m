Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C7D7C0502E
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 14:31:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F55510F314;
	Mon, 29 Aug 2022 14:31:28 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2044.outbound.protection.outlook.com [40.107.102.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B571F10F307
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 14:31:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fg8yZR27s5P+hcxy9Y4z23pumGJzmj2ztcXv65XyUkT3s4j1FdxkuuKc4kNFHB6M1SgB4OI68sCiXE+xCc5rL3uWMElinP2mikVXBqqvfQ+HBgQ/iOSVrIn8pA/GZy2pAb0yA32ttEoQtAQOoFj6jd+5KXJnm6nvwlrFKMWECEuId4iC9GFZ4uwy2Q0YbwWqvtCHzzZmYLbJRiYQNiVOWTQIw41Jj08yzRZRJxuOcs71n+zZNteP3UB8B3GcJYatCllTFCVSImSjFRijwEShaHJTC7LaBrv4MyoW+6MdGIuWiCKxTbBAN1Xe9MUQkWC9Z2OJ6LJU4sQv7b1LhE9CCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8n9LSSYV2oOIITuMEpc5y0nuybEAQIOZ7U3hV3MNs0=;
 b=kbVczfUvolGhzb5r8D7iqtNg714Y9fT1gEt6l+TnZlyVoUlJcu9LokwUVQnRiaRGjNhq7+JZP+blmNfXnAuzbo2sa9dsIxx3DBaehEW831pAwSzLtpTJZPjeUCwnF99KZDgOZZeaATLqS9xc44CfWMNhOX/t9UONqVuzo7lPe5+srQri3V/6fC1JUATJfFOyCTYrqJujIyhRY3qXUXOmcowAiaJvU7yK21XFACOZ+zgwNiE+zd92I1UYfuBp6aSKZAygjpbCwd0ljg4u9j9yq8HH2HdY4+2cmUAwsGTamBQZ/FNE6o+zS0lfc5q2/0lxBiO2v5inxnWlDwlt5qxCrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8n9LSSYV2oOIITuMEpc5y0nuybEAQIOZ7U3hV3MNs0=;
 b=oVJM3HyF8Kkq84eEZiDnc0CY/XyMGgTZ3w22ruW7ZaEY8h9EiqR7+DGEyf87sp8HVfJS4wsYpP7GcQRrM8Vu34EEgUN+QRyQBmy3QhY6xT9wKHwrxbl61KpdLDyHv/BA97d2sAbyx6T3Z6dR2ok8FjZhbtRDHgsy34aBjXX4WiQ=
Received: from MW4PR04CA0158.namprd04.prod.outlook.com (2603:10b6:303:85::13)
 by SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Mon, 29 Aug
 2022 14:31:16 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::83) by MW4PR04CA0158.outlook.office365.com
 (2603:10b6:303:85::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16 via Frontend
 Transport; Mon, 29 Aug 2022 14:31:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 14:31:15 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 09:30:50 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/29] drm/amdkfd: add debug wave launch override operation
Date: Mon, 29 Aug 2022 10:30:17 -0400
Message-ID: <20220829143026.1509027-21-jonathan.kim@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: a3a01f74-459a-4f36-300d-08da89cb218b
X-MS-TrafficTypeDiagnostic: SN6PR12MB4623:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ELeEVEt56BGG1GhiQ1FznyyxNQqvq45sJyfXwJQyA/O5vtYSaaPxz7mI+6oJ5D2GjI1YGPkth5AYdam9TNaRRS4QNN7Y1OJkBuVyLvy4dEEPnxCoWSIzQakmMudU9SxM8xIFX8yWaCKESMMHQZEU5dQn6h0Ew7cXKblEVb6gSekPdNsPRzM4Oz0pcAj8EtdXWKHL5+nlJhPIlPByfZROM2pPdT5LaZUu2z/0I6WGkaHMYibilLaOMAbC8NuszoWGlPhqp9KaMSX3s9E9ERpSpZnDumA0IridW/RYqN/WEdAPfmo0ukKZk9jy4xSOPYw/Thr8AWGw5MOSU4a8MrEOFh8/ME4w/gedHPnn4JRld2yTB9vfL7rv705ITmV90rURnIC2JxVzkP+G8KZ7a54Vci8/7tBMKKixwJMP09/WioiCwu82zvRyZUO8Qx8+XjTy++ZE1gA/UcjsaSriyL385AmkXoL7hVmW1my649GvLlBgqr2lvCLCGD4NpmjoasJAT0qDs9uvFpDokNyVtCceL3fpF0NQRdOWsfOE49FLp+BuEH5o2lZA/rpIZs5iwKVdyeenQ4t05wizjJdM+l599xoMFZZDj59kRMMXYlaSU2/HV5xzccF+I7mJSKvYTJi+DcN1B7a6OWNQuMQQiLeeGUykWSxH6nBb4PcD3HQl6rTNPPez/sa0OZn1F8SWxW/df7kvc/MfccWx9jAF+EFE7pwzFNGwahxzlaqztEotgrkkM9mmbOssHElTo9pWA7AUnAMmWD0Ejs4YIsVJww75BdtGU2eiwH1oQDh8ijPA0UFC0m2udy6YLY+jsE7AexAv
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(346002)(136003)(39860400002)(36840700001)(40470700004)(46966006)(82310400005)(36860700001)(40480700001)(356005)(40460700003)(86362001)(82740400003)(81166007)(8676002)(4326008)(70206006)(70586007)(41300700001)(478600001)(5660300002)(8936002)(54906003)(47076005)(316002)(6916009)(426003)(1076003)(16526019)(336012)(2616005)(186003)(7696005)(83380400001)(2906002)(44832011)(6666004)(30864003)(26005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 14:31:15.8607 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3a01f74-459a-4f36-300d-08da89cb218b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4623
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
index 2491402afd58..c3e6fd262287 100644
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
+		return -EPERM;
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
index 673c99c5523d..7ff6fabd6b1f 100644
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
+		return -EPERM;
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
index 5ac15a0b1bc6..29ebb9f89179 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2860,6 +2860,13 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
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
index 8619a86f1482..e6e8ca186a43 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -416,6 +416,71 @@ int kfd_dbg_trap_enable(struct kfd_process *target, uint32_t fd,
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


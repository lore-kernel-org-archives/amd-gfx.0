Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D29C61DFD
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 20:51:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B749E10E193;
	Mon, 31 Aug 2026 20:51:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="brqdxOFK";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011044.outbound.protection.outlook.com [52.101.62.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7F2C10E193
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 20:51:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2haoiT5gdlJ25k4bZ5AiQI5Hgg8gQvQ0AEoUnemP0mxukVTwZ5lCPrSZ7GUu3UUMGeBipHNObQcc16pgymRkyURNX0xA6QOabMs6i1u3VJ/ucwFkXo8EPCaN6V+mGHeV/nPQlrlQVmVqjRwJq6IAEakSQ/0fgN1xVo2Bh03hA9Jg9jto6A6HF/RHDs2UmKnj+hmLVd+CIkgLU8j1/zhJ3H3QnAzOhkJ+2NU0TbHK3KwAGP10j0BkOnPjx5Cx76mXcpdF1hROFWFDhWcGuMn+fMTAGD1A29ZINDfmMb0HFgmyRpENSSrlKdAQT0OTsM7gu/fG6uD+zFxn5hAfcQiqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bbQP6oolMk2tsRBOIZujWVPnn0w1aCVcGahlLk/lTA=;
 b=DCD7/2HKVREORMHgOSLxx/zykUvowYd3y1z+lceE3owYG2J5bv8KCCx0DunmGfdfUpBpcmx+t/BD85h9EvVCHXpYfYyw1BmLJJZFzfolXko/SxpwdBw4wP7lKkLsCzpg3PDyWs+WgYD+UFTrVR8KWIQyGk/jgiY6576/Yy/c7lEa55tSsj/ko8e683c11/+mVwZHhSHDQg2mWUxOgF/i1vsouxrFz3xfl6xZVD4TE5LK0rPzmCaLjzpul4IpAFA1PZ2e+6t65iq/zrvtBQTVDIZJWmw33Uvoy9BktMWcDgusw5gyKsUWnsScQaFqS3VW+1aRHxU+5VTNULRxaRwDAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bbQP6oolMk2tsRBOIZujWVPnn0w1aCVcGahlLk/lTA=;
 b=brqdxOFKN1+NSmpV38yXSDrkIETf+i0yrmZzBf8JtgSjlXTl34V3xXWjMtSjBudY+2ehrN9gTONiJa1EDqbr5esmj8mSDbcx4Iw9XjrMwiLsYQEAbX2JaBuLxlqDQBWSa8NMwB/VURfKS+AMsVVuNVO23CfhCEZDINYoHSA8iJA=
Received: from SJ0PR03CA0276.namprd03.prod.outlook.com (2603:10b6:a03:39e::11)
 by DM4PR12MB6277.namprd12.prod.outlook.com (2603:10b6:8:a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 20:51:08 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:a03:39e:cafe::35) by SJ0PR03CA0276.outlook.office365.com
 (2603:10b6:a03:39e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 20:51:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 20:51:05 +0000
Received: from devkfd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 15:51:04 -0500
From: Gang Ba <Gang.Ba@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kent.Russell@amd.com>
Subject: [PATCH] drm/amdkfd: Fix TCP XNACK scoreboard reset race
Date: Mon, 31 Aug 2026 16:50:59 -0400
Message-ID: <20260831205059.1803721-1-Gang.Ba@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|DM4PR12MB6277:EE_
X-MS-Office365-Filtering-Correlation-Id: cfbbc982-290a-4815-40b3-08df07a193d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|376014|82310400026|11063799006|10067099003|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: jirUgZgYUvzSUzs3KTKK4e6OGQcJ1OZ55xqoTbYVRhxCANLKPCxaP6543KiEQempqZE3HqCOI8wKIMKsCNtl3FeOfkTlSrJREmFEfyQ9iTp9lpwPzWqHCVMGdW6FCyIwAEqDghU/sMTp3kgpVcWGfwuyhYw8hTIpd9m71PLQTulEyqAZAYcccnUNkB20vJvEy7FKrApB6j0G5FHZhQZG04ji9GiUCsPVqDMmNni9+mG42fyvCkPmwGVnfT4Ndl1BSNVA7jbxjZxxBWC/WYqYoI/0iM9xi2jJPQ2RFf6Wg3v2/f7OjkzX2/z77yPpBzxxRei6mGZkPl3LnUHKwDQ0pxyOqsgSP6BDwMjx5RbVaK3CsBxXjBMDYJKqhEUvOxMQEQIz+KWos6NdPad8kj8xdgdDs6xsl8hO34qh/oAWQQ3QdzelYTMtCfFU6drE3/4FjAHjJEZEfyc/jlZQch4hkiloe/9cr6jbB0/b7EfqbPjJWMopRwqRKoHHj/wvJbd6RSsltPZvFNlyQwKSKf44QZFLqdzq/9if6JGHcx1ZpvmLLoF2Fka4bvtCNPiJd18tqwYakaahlFrFYumiaJPmse5H7TZwt6sz1Dz1lqaLnrU8Zkzox0blR7g0Yh6bME8uZXyISyRGrvKZ+IR19OkGgRBFwimuI7P6RS7sUxGw8AVfNXZwRDhpQ4NqoxmCIG2+V1bwDT4xgFVkJQDDaiEk3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(376014)(82310400026)(11063799006)(10067099003)(56012099006)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PQyvvGWEFl9NEG/VOE5Ymtf4f+OMYmed1AR8oq1e5oS2UIBHCeC/yz6JwAHvJ/KNpvuWCZ9/vPYh0MM7TLDaeb+AC4sZnpLu8l4RcToW0Ot6/1KVXcNttYHGpM+HwR/GDrk3LVuV0U1+SI2cY0oDeTKxF109ODp7jpK86LVmJRXKSeTPwcmIuaUjL46VD/myFD13yUQdVDCbtKAkhdkSm5V5FpLo7rvHVfRuaE7EP5B7EFdSW12sG8Kbak22BVdPOBDVXn9cVRA0DnbnT9nqAZnkWsXa2pSBt48F71blXOb8T8GrmetHyx+Y69U+aOr4lLoEXReezqMAYaz2ToofcoQweX3mgl+DsCawRTAcw35MSr8E9T4fsjD71zXwmAvJj5juUUtWDZKPhFWLoFVPZFc5lcBFEgtaIRcDnZc4EY5L69r/ePgNwIWm+GoJO5B5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 20:51:05.9956 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfbbc982-290a-4815-40b3-08df07a193d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6277
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

Fix a hardware RTL bug in the TCP XNACK scoreboard reset path where a wave
receiving a no-retry FAULT from UTC and subsequently terminating may leave
its scoreboard entry uncleared when reset events arrive back-to-back.

This can cause a later, unrelated wave using the same slot to incorrectly
inherit the XNACK error state, resulting in its VMEM operations being
dropped even though the wave never faulted.

Signed-off-by: Gang Ba <Gang.Ba@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  |  3 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 10 ++-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c       | 83 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h       |  1 +
 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   | 54 ++++++++++++
 .../gpu/drm/amd/include/kgd_kfd_interface.h   |  1 +
 7 files changed, 150 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
index 7e9f7a280c1b..2aaa9826c8f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
@@ -193,5 +193,6 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd = {
 	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
 	.hqd_get_pq_addr = kgd_gfx_v9_hqd_get_pq_addr,
 	.hqd_reset = kgd_gfx_v9_hqd_reset,
-	.hqd_sdma_get_doorbell = kgd_gfx_v9_hqd_sdma_get_doorbell
+	.hqd_sdma_get_doorbell = kgd_gfx_v9_hqd_sdma_get_doorbell,
+	.hqd_gfx_cleaner = kgd_gfx_v9_cleaner
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index b30ad9701bce..81f1945c4090 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -37,6 +37,7 @@
 #include "soc15.h"
 #include "soc15d.h"
 #include "gfx_v9_0.h"
+#include "gfx_v9_4_2.h"
 #include "amdgpu_amdkfd_gfx_v9.h"
 #include <uapi/linux/kfd_ioctl.h>
 
@@ -1226,11 +1227,15 @@ uint64_t kgd_gfx_v9_hqd_reset(struct amdgpu_device *adev,
 
 uint32_t kgd_gfx_v9_hqd_sdma_get_doorbell(struct amdgpu_device *adev,
 					  int engine, int queue)
-
 {
 	return 0;
 }
 
+void kgd_gfx_v9_cleaner(struct amdgpu_device *adev)
+{
+	gfx_v9_4_2_shader_cleaner_workarounds(adev);
+}
+
 const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
 	.program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
 	.set_pasid_vmid_mapping = kgd_gfx_v9_set_pasid_vmid_mapping,
@@ -1261,5 +1266,6 @@ const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
 	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
 	.hqd_get_pq_addr = kgd_gfx_v9_hqd_get_pq_addr,
 	.hqd_reset = kgd_gfx_v9_hqd_reset,
-	.hqd_sdma_get_doorbell = kgd_gfx_v9_hqd_sdma_get_doorbell
+	.hqd_sdma_get_doorbell = kgd_gfx_v9_hqd_sdma_get_doorbell,
+	.hqd_gfx_cleaner = kgd_gfx_v9_cleaner
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
index 9f43f16a1ace..3b8b7bd2377f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
@@ -115,3 +115,4 @@ uint64_t kgd_gfx_v9_hqd_reset(struct amdgpu_device *adev,
 			      unsigned int utimeout);
 uint32_t kgd_gfx_v9_hqd_sdma_get_doorbell(struct amdgpu_device *adev,
 					  int engine, int queue);
+void kgd_gfx_v9_cleaner(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index 8b84bba58752..d3e008134afb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -343,6 +343,28 @@ const struct soc15_reg_entry sgpr64_init_regs_aldebaran[] = {
 	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE7), 0xffffffff },
 };
 
+static const u32 fault_cleaner_compute_shader_aldebaran[] = {
+	0xbe8000ff, 0x00001000, 0x80808100, 0x86000000, 0xbf85fffd, 0xbf810000
+};
+
+const struct soc15_reg_entry fault_cleaner_init_regs_aldebaran[] = {
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_RESOURCE_LIMITS), 0x0000000 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_X), 0x40 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Y), 1 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Z), 1 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC1), 0xaf0000 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC2), 0xc8 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC3), 0xea4fac },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE0), 0xffffffff },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE1), 0xffffffff },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE2), 0xffffffff },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE3), 0xffffffff },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE4), 0xffffffff },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE5), 0xffffffff },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE6), 0xffffffff },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE7), 0xffffffff },
+};
+
 static int gfx_v9_4_2_run_shader(struct amdgpu_device *adev,
 				 struct amdgpu_ring *ring,
 				 const u32 *shader_ptr, u32 shader_size,
@@ -692,6 +714,67 @@ static int gfx_v9_4_2_do_vgprs_init(struct amdgpu_device *adev)
 	return r;
 }
 
+static int gfx_v9_4_2_do_cleaner(struct amdgpu_device *adev)
+{
+	int r;
+	/* CU_ID: 0~15, SIMD_ID: 0~3, WAVE_ID: 0 ~ 9 */
+	int wb_size = adev->gfx.config.max_shader_engines *
+			 CU_ID_MAX * SIMD_ID_MAX * WAVE_ID_MAX;
+	struct amdgpu_ib wb_ib;
+	struct dma_fence *fence = NULL;
+	u32 pattern = 0xa;
+
+	/* bail if the compute ring is not ready */
+	if (!adev->gfx.compute_ring[0].sched.ready)
+		return 0;
+
+	/* allocate the write-back buffer from IB */
+	memset(&wb_ib, 0, sizeof(wb_ib));
+	r = amdgpu_ib_get(adev, NULL, (1 + wb_size) * sizeof(uint32_t),
+			  AMDGPU_IB_POOL_DIRECT, &wb_ib);
+	if (r) {
+		dev_err(adev->dev, "failed to get ib (%d) for wb.\n", r);
+		return r;
+	}
+	memset(wb_ib.ptr, 0, (1 + wb_size) * sizeof(uint32_t));
+
+	r = gfx_v9_4_2_run_shader(adev,
+			&adev->gfx.compute_ring[0],
+			fault_cleaner_compute_shader_aldebaran,
+			sizeof(fault_cleaner_compute_shader_aldebaran),
+			fault_cleaner_init_regs_aldebaran,
+			ARRAY_SIZE(fault_cleaner_init_regs_aldebaran),
+			adev->gfx.cu_info.number * 32,
+			wb_ib.gpu_addr, pattern, &fence);
+
+	if (r) {
+		dev_err(adev->dev, "failed to clear MI200\n");
+		goto pro_end;
+	}
+
+	/* wait for the GPU to finish processing the IB */
+	r = dma_fence_wait(fence, false);
+	if (r)
+		dev_err(adev->dev, "timeout to clear MI200\n");
+
+pro_end:
+	if (fence)
+		dma_fence_put(fence);
+	amdgpu_ib_free(&wb_ib, NULL);
+
+	if (r)
+		dev_dbg(adev->dev, "Clean MI200 Failed\n");
+	else
+		dev_dbg(adev->dev, "Clean MI200 Successfully\n");
+
+	return r;
+}
+
+void gfx_v9_4_2_shader_cleaner_workarounds(struct amdgpu_device *adev)
+{
+	gfx_v9_4_2_do_cleaner(adev);
+}
+
 int gfx_v9_4_2_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 {
 	/* only support when RAS is enabled */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
index a603724c1dfc..5c911f0f5d01 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
@@ -30,6 +30,7 @@ void gfx_v9_4_2_init_golden_registers(struct amdgpu_device *adev,
 				      uint32_t die_id);
 void gfx_v9_4_2_init_sq(struct amdgpu_device *adev);
 void gfx_v9_4_2_set_power_brake_sequence(struct amdgpu_device *adev);
+void gfx_v9_4_2_shader_cleaner_workarounds(struct amdgpu_device *adev);
 int gfx_v9_4_2_do_edc_gpr_workarounds(struct amdgpu_device *adev);
 
 extern struct amdgpu_gfx_ras gfx_v9_4_2_ras;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 1688d8e595f2..3a963e2da649 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -359,6 +359,57 @@ static bool event_interrupt_isr_v9(struct kfd_node *dev,
 		!amdgpu_no_queue_eviction_on_vm_fault);
 }
 
+static void gfx942_workaround_cleaner(struct kfd_node *dev, uint16_t pasid)
+{
+	struct kfd_process *p;
+	struct kfd_process_device *pdd = NULL;
+	struct device_queue_manager *dqm;
+	int i, ret;
+
+	p = kfd_lookup_process_by_pasid(pasid, NULL);
+	if (!p)
+		return;
+
+	/* Evict all process devices before running the workaround */
+	for (i = 0; i < p->n_pdds; i++) {
+		pdd = p->pdds[i];
+		kfd_evict_process_device(pdd);
+	}
+
+	/* Run the GFX cleaner workaround on the faulting device.
+	 * Only run once per page fault (evicted == 1 after first evict).
+	 */
+	pdd = kfd_get_process_device_data(dev, p);
+	if (pdd) {
+		/* Only call cleaner once per page fault. Run the workaround
+		 * only on the first eviction (evicted == 1 after evict above).
+		 */
+		dqm = pdd->dev->dqm;
+		dqm_lock(dqm);
+		if (pdd->qpd.evicted == 1 && dqm->dev->kfd2kgd->hqd_gfx_cleaner)
+			dqm->dev->kfd2kgd->hqd_gfx_cleaner(dqm->dev->adev);
+		dqm_unlock(dqm);
+	}
+
+	/* Restore all process devices after workaround completes */
+	for (i = 0; i < p->n_pdds; i++) {
+		pdd = p->pdds[i];
+		if (!pdd->dev->dqm) {
+			dev_err(dev->adev->dev,
+				"Invalid dqm for process %d device %d\n", pasid, i);
+			continue;
+		}
+		ret = pdd->dev->dqm->ops.restore_process_queues(pdd->dev->dqm,
+								&pdd->qpd);
+		if (ret)
+			dev_err(dev->adev->dev,
+				"Failed to restore queues for process %d device %d: %d\n",
+				pasid, i, ret);
+	}
+
+	kfd_unref_process(p);
+}
+
 static void event_interrupt_wq_v9(struct kfd_node *dev,
 					const uint32_t *ih_ring_entry)
 {
@@ -547,6 +598,9 @@ static void event_interrupt_wq_v9(struct kfd_node *dev,
 			return;
 		}
 
+		if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2))
+			gfx942_workaround_cleaner(dev, pasid);
+
 		info.vmid = vmid;
 		info.mc_id = client_id;
 		info.page_addr = ih_ring_entry[4] |
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index 01c2631bbdff..a82afc613ef3 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -343,6 +343,7 @@ struct kfd2kgd_calls {
 	int (*hqd_sdma_get_counter)(struct amdgpu_device *adev,
 				    void *mqd, uint32_t num_sdma_queues_per_eng,
 				    uint64_t *val);
+	void (*hqd_gfx_cleaner)(struct amdgpu_device *adev);
 };
 
 #endif	/* KGD_KFD_INTERFACE_H_INCLUDED */
-- 
2.55.0


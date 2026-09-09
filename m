Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC5CC79FB6
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2026 20:15:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22B3B10F274;
	Wed,  9 Sep 2026 20:15:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i3KobUZ0";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010029.outbound.protection.outlook.com
 [52.101.193.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F86010F273
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2026 20:15:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TLmiLEo3PkUoXQfbZ4vZWBfvzVhgK3qytcoW/+3N5l8JzAfKGGBtjOsQKsJu/MUfNATbHhrs/U8tcGSUi4qmEGu+Dy6DIPntTMSMTC0+W5W7ZmD8C6AKudewhftoISse0E5SzGVCKyueRbhw3navTmfhjSxuWeyS4EZz9WYUPGP1W/7yrfNb9UDh7Oys5G+uBDbmRknb33F0RrkMsfpHIGJY5s4gUY7QK82AYWMN/xk8YeoC0wnL8PozLyOjyIm1nqFiTQl7y2LX0ENs6miEDcahSdioPyeUpkVfViG1XnVCm3ZVzn6nHAcX4lASS+TYxvwOTLG8DJ39wNN+YAXdUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSh0+SfSiK+7cJIGE5VhgJh2O09GZ1D5ssxtlCkWDbY=;
 b=u6XAf/jIewhO+uCDeOiytTcZKZ4fnuKYy8Z6rbmdink2r9G1mbVGZ2V57HUELodB9IgF1ip98f7atmAktTcurV2YTHsDSrdXnE/jTtvUJOneNhNgUfjcNwqE0xJGvRI9ZZM48cGm1AWSNFlmagwEI26XS5E6fJg6cKWxuhIERLde04luS4EOayOpyVlBgVPG2eY3vG1LbVOVJ3UYdzsfmbCMBFYZFv+dtZnKY2mff9GyrWf+QssT2dIDOytR/TL3H36RevBEuPN0IAhBdLd+YScXLzGJgLbQaoHZqscRlNlUCWLwpVngLJMes1ZEBcna9M5q+vM594mtRXAZjxYoSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSh0+SfSiK+7cJIGE5VhgJh2O09GZ1D5ssxtlCkWDbY=;
 b=i3KobUZ0RTnlpgsKF6Izf5eT6J1P6jxXaHZLvlJ6HuLEwzoWOseb3ceJC3IDd7/ojz6DYmqAWD1EQd9+8JVfl5iW6cO5cRZIj2lE80kcXFiqoOiwZutF9wFaj0TagYSgyVpa+9kySR0TXHqV/ccW0b37cj5IivWLZkodb/LXQfA=
Received: from DS7PR05CA0070.namprd05.prod.outlook.com (2603:10b6:8:57::28) by
 DM4PR12MB5745.namprd12.prod.outlook.com (2603:10b6:8:5c::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.7; Wed, 9 Sep 2026 20:15:43 +0000
Received: from BN7PEPF000000A8.namprd05.prod.outlook.com
 (2603:10b6:8:57:cafe::51) by DS7PR05CA0070.outlook.office365.com
 (2603:10b6:8:57::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.5 via Frontend Transport; Wed, 9
 Sep 2026 20:15:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF000000A8.mail.protection.outlook.com (10.167.245.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Wed, 9 Sep 2026 20:15:42 +0000
Received: from devkfd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 9 Sep
 2026 15:15:42 -0500
From: Gang Ba <Gang.Ba@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Jay.Cornwall@amd.com>, <Kent.Russell@amd.com>
Subject: [PATCH v3] drm/amdkfd: Fix TCP XNACK scoreboard reset race
Date: Wed, 9 Sep 2026 16:15:36 -0400
Message-ID: <20260909201536.942624-1-Gang.Ba@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A8:EE_|DM4PR12MB5745:EE_
X-MS-Office365-Filtering-Correlation-Id: 39a39487-a500-4288-0383-08df0eaf1fe0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|5023799004|11063799006|10067099003|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: yAD2hU/H8gvc99uT4ocy/HcMNzcOYyD97Mg3JpLxElCiS1+0IFVYMBNAeFlw7txFVUsrDFqI5DD4WhPZqyabQZIbstM7OmBf3u+R2TEAG3UunqVjJEWapnecWAzrBIebsP72BXby1sI5ZrjTWqK1QPmY/Oq9xV5p6D+ZJ04HwvCOnlpneDVO15D5cSKLTxe4Z5DIddbvY6AMtUj+g7ePiRfLzysgxty3FkwVKKeIeU5y5Iym1Ai7/rjKmD9nENndtiWVN51NaUAgzAgibfKLfZpYhD3KavJiEdF1v95L4a4bIvscY7aZvFLG52VS8rOmcEPa14PsnOyh5r9s/vfVmDW4Ko9dzJC/tO9qbFU5p168ngYo5ANIYQmRC35Hmld7tkhJmPcRnvhmXtDge1F16zKspJKAqm2eQnoF+Lr2xbsm/Gr1K/ads7trA96rSTlErFb9DIT1yMC/wKuqtpokkekzOcUOWB81XPpANJU3D6i+Pm0ayyFIbddvrBOvMGoOyFEeB/NPpe/Vtd8+SXpMoEj2tFh6e8KPnNZnYoU7mzqYqEnX0f5QekF2qCo06OKMpH46R7lV4QKvj04z2War99exZtvZNJjWKGBnieoemkI2jaEZEUV39Soz1cUaE7AM7b9LWnDCwaHZvwUHOk+PCtVjLptx8fYyepSVJ1gnmcft62wQ/3tFRryZha7+e8VDZfRBO38rN1XLPuGBCB//hQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(5023799004)(11063799006)(10067099003)(56012099006)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: F7i5jJFTzX/Ycz4RaVBTJFWMsgP+TF3TeF8tsDsLgL+dRNJyiU1zwVYPRjnhUIORHdC7sMdKzV3eVPLiId5jgrP+638S8BY+pT5UHVh0W6EqkW+KAPXRp/rId03DbWIgzMWpw1s21f/VxWk77R6KOSTtW+VFfqF4058QQwJgbfp+T/xLgpw+3o+4t6R5TcBzvuTZpWMMyzPI1WsS32A7DYloMHJsPOMu4v6PPFYy73PGOgoe3d6gd+5YckdifP8raBiVMIn3d4JFLfzWY+mt4TWDe8h1r8H+WP/xOzDCNX4ugpiFQ/zOqvFUf8TR+fu0GwTBtZxzN8VgDj3bZYukA3jhMWn3SZsvLQImg3U4gePO0a3jULozRYW0e161jLCV7NAmD7jrWMPZXPJPakFk0A0bhVbZqwyxRs8eFF9/0SKCWISHKWVFn7vJoSU+jgvH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 20:15:42.6304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a39487-a500-4288-0383-08df0eaf1fe0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF000000A8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5745
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
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 59 +++++++++++++
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  2 +
 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   | 23 +++++
 .../gpu/drm/amd/include/kgd_kfd_interface.h   |  1 +
 9 files changed, 180 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
index 7e9f7a280c1b..98cd0435ced5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
@@ -193,5 +193,6 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd = {
 	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
 	.hqd_get_pq_addr = kgd_gfx_v9_hqd_get_pq_addr,
 	.hqd_reset = kgd_gfx_v9_hqd_reset,
-	.hqd_sdma_get_doorbell = kgd_gfx_v9_hqd_sdma_get_doorbell
+	.hqd_sdma_get_doorbell = kgd_gfx_v9_hqd_sdma_get_doorbell,
+	.hqd_gfx_clean_fault = kgd_gfx_v9_clean_fault
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index b30ad9701bce..fc253260ade5 100644
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
 
+void kgd_gfx_v9_clean_fault(struct amdgpu_device *adev)
+{
+	gfx_v9_4_2_clean_fault(adev);
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
+	.hqd_gfx_clean_fault = kgd_gfx_v9_clean_fault
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
index 9f43f16a1ace..dba7ace872de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
@@ -115,3 +115,4 @@ uint64_t kgd_gfx_v9_hqd_reset(struct amdgpu_device *adev,
 			      unsigned int utimeout);
 uint32_t kgd_gfx_v9_hqd_sdma_get_doorbell(struct amdgpu_device *adev,
 					  int engine, int queue);
+void kgd_gfx_v9_clean_fault(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index 8b84bba58752..344156bf20ca 100644
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
 
+static int gfx_v9_4_2_clean_shaders(struct amdgpu_device *adev)
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
+void gfx_v9_4_2_clean_fault(struct amdgpu_device *adev)
+{
+	gfx_v9_4_2_clean_shaders(adev);
+}
+
 int gfx_v9_4_2_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 {
 	/* only support when RAS is enabled */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
index a603724c1dfc..1cbade5ed657 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
@@ -30,6 +30,7 @@ void gfx_v9_4_2_init_golden_registers(struct amdgpu_device *adev,
 				      uint32_t die_id);
 void gfx_v9_4_2_init_sq(struct amdgpu_device *adev);
 void gfx_v9_4_2_set_power_brake_sequence(struct amdgpu_device *adev);
+void gfx_v9_4_2_clean_fault(struct amdgpu_device *adev);
 int gfx_v9_4_2_do_edc_gpr_workarounds(struct amdgpu_device *adev);
 
 extern struct amdgpu_gfx_ras gfx_v9_4_2_ras;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 3ec6a73af22e..540fc205d20e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1504,6 +1504,63 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
 	return retval;
 }
 
+static int clean_process_queues_cpsch(struct device_queue_manager *dqm,
+				      struct qcm_process_device *qpd)
+{
+	struct queue *q;
+	struct kfd_process_device *pdd;
+	int retval = 0;
+
+	dqm_lock(dqm);
+	if (qpd->evicted++ > 0) /* already evicted, do nothing */
+		goto out;
+
+	pdd = qpd_to_pdd(qpd);
+
+	/* The debugger creates processes that temporarily have not acquired
+	 * all VMs for all devices and has no VMs itself.
+	 * Skip queue eviction on process eviction.
+	 */
+	if (!pdd->drm_priv)
+		goto out;
+
+	pr_debug_ratelimited("Evicting process pid %d queues\n",
+			    pdd->process->lead_thread->pid);
+
+	/* Mark all queues as evicted. Deactivate all active queues on
+	 * the qpd.
+	 */
+	list_for_each_entry(q, &qpd->queues_list, list) {
+		q->properties.is_evicted = true;
+		if (!q->properties.is_active)
+			continue;
+
+		q->properties.is_active = false;
+		decrement_queue_count(dqm, qpd, q);
+
+		dqm_evict_mqd_bo(dqm, q);
+	}
+
+	pdd->last_evict_timestamp = get_jiffies_64();
+
+	if (!down_read_trylock(&dqm->dev->adev->reset_domain->sem)) {
+		retval =  -EIO;
+		goto out;
+	}
+	
+	retval = unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD, false);
+
+	if (!retval) {
+		dqm->dev->kfd2kgd->hqd_gfx_clean_fault(dqm->dev->adev);
+		retval = map_queues_cpsch(dqm);
+	}
+	up_read(&dqm->dev->adev->reset_domain->sem);
+
+out:
+	dqm_unlock(dqm);
+	return retval;
+}
+
 static int restore_process_queues_nocpsch(struct device_queue_manager *dqm,
 					  struct qcm_process_device *qpd)
 {
@@ -3347,6 +3404,7 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev)
 		dqm->ops.get_queue_checkpoint_info = get_queue_checkpoint_info;
 		dqm->ops.checkpoint_mqd = checkpoint_mqd;
 		dqm->ops.set_perfcount = set_perfcount;
+		dqm->ops.clean_process_queues_cpsch = clean_process_queues_cpsch;
 		break;
 	case KFD_SCHED_POLICY_NO_HWS:
 		/* initialize dqm for no cp scheduling */
@@ -3368,6 +3426,7 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev)
 		dqm->ops.get_queue_checkpoint_info = get_queue_checkpoint_info;
 		dqm->ops.checkpoint_mqd = checkpoint_mqd;
 		dqm->ops.set_perfcount = set_perfcount;
+		dqm->ops.clean_process_queues_cpsch = clean_process_queues_cpsch;
 		break;
 	default:
 		dev_err(dev->adev->dev, "Invalid scheduling policy %d\n", dqm->sched_policy);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 21cf3c16f3f9..f55f313d6cc2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -201,6 +201,8 @@ struct device_queue_manager_ops {
 				  void *ctl_stack);
 	void	(*set_perfcount)(struct device_queue_manager *dqm,
 				  int enable);
+	int (*clean_process_queues_cpsch)(struct device_queue_manager *dqm,
+				    struct qcm_process_device *qpd);
 };
 
 struct device_queue_manager_asic_ops {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 1688d8e595f2..9b48fe598597 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -359,6 +359,24 @@ static bool event_interrupt_isr_v9(struct kfd_node *dev,
 		!amdgpu_no_queue_eviction_on_vm_fault);
 }
 
+static void gfx942_clean_fault(uint16_t pasid)
+{
+	struct kfd_process *p;
+	struct kfd_process_device *pdd = NULL;
+	struct device_queue_manager *dqm;
+
+	p = kfd_lookup_process_by_pasid(pasid, &pdd);
+
+	if (!pdd)
+		return;
+
+	/* To Clean the GFX on the faulting device	 */
+	dqm = pdd->dev->dqm;
+	dqm->ops.clean_process_queues_cpsch(dqm, &pdd->qpd);
+
+	kfd_unref_process(p);
+}
+
 static void event_interrupt_wq_v9(struct kfd_node *dev,
 					const uint32_t *ih_ring_entry)
 {
@@ -547,6 +565,11 @@ static void event_interrupt_wq_v9(struct kfd_node *dev,
 			return;
 		}
 
+			/* GPR cleaner shader for MI2XX */
+			if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2))
+				gfx942_clean_fault(pasid);
+
+
 		info.vmid = vmid;
 		info.mc_id = client_id;
 		info.page_addr = ih_ring_entry[4] |
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index 01c2631bbdff..d749669f8e6d 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -343,6 +343,7 @@ struct kfd2kgd_calls {
 	int (*hqd_sdma_get_counter)(struct amdgpu_device *adev,
 				    void *mqd, uint32_t num_sdma_queues_per_eng,
 				    uint64_t *val);
+	void (*hqd_gfx_clean_fault)(struct amdgpu_device *adev);
 };
 
 #endif	/* KGD_KFD_INTERFACE_H_INCLUDED */
-- 
2.55.0


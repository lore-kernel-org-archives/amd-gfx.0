Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3FB7EB64DA
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 17:47:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 198DB10E5CE;
	Fri,  7 Jul 2023 17:47:14 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48BEC10E5CC
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 17:47:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzh2mHEzbWEz6ax2DZLFJRCtEekqFvRMdvqwcVpfS1x58adb00HMmNB0ItcOPSfyyFZ08gYbX8uG9uQWLhwI5OdBUvoSemjg+gu1YfYtEvl8VhDiJQT1nLgbI9MgXAQ5Vr5k8W4iHZyiZEOLQKdrh/TnTqDzwXZm5DlodS2sbd+30FawV9ercv3SZyxIw7rtce97/5yxuY7Htn7YGiocMXtWsxHWTuSPpQ7NREwWxzunLsyPj/vX6r/ICjqSi3T/R02HPdimiwyYNMxpm8T6ezm29iP3YmQ8Je/Qo/3fuHV3nFtd03fNBLwgnuHPF/z9nIb6FhaOQC7Hh0ZTjXEWhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVPJIDnjO3jYyUT3pc4BSK7ImNicrqWsqSoWrnGu9Do=;
 b=D0UiEJRRQNZm0YFWQKzQwoQl+bQmwZI87rXSJ5y5YzKIyr58NEj1H2wf+Jhcnam46guB71K/gKTISiu43E2az/lFIN/rEoIN9jzCFdQ3/1sfhRvahoxty7+uNsKtpoE2hLJAFBP3isRh1kcfDGYvjkIxDLDPPZkdKxIkv0WSd5cUBkVRdq0rWgL+eX3Zg8v8yjz5DHHblTGCiZTF2ZLj8eX65pkLzvZGUGtXg+/lD5F7KfwOXAOcMNbE3LXKZYKurRcCdvEBRzhEtDv6+SXpi90AzH25UGpfkzhqPoY9OJLMVt5mRWksFrJfy5KZl+tLD2GmfwSuug4idVHj5UVyaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVPJIDnjO3jYyUT3pc4BSK7ImNicrqWsqSoWrnGu9Do=;
 b=Yxh4HbU36xfEKCnuIrCfqtBvf6HJzs/YrbcDpX4v7psLILRQMU4RZeYBTBdhEyhgORfg2qsrT04WN7ODv1fbFDIJjc3SmCteu5Kjwb9JTapd1hwfUFX0OFHzH0ob3vRvjLI9EaJ+/4GNlxHU9xrAYvSPZqh8ZazIxrgbjbsLebs=
Received: from MW2PR16CA0014.namprd16.prod.outlook.com (2603:10b6:907::27) by
 DM6PR12MB4369.namprd12.prod.outlook.com (2603:10b6:5:2a1::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.25; Fri, 7 Jul 2023 17:47:08 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::92) by MW2PR16CA0014.outlook.office365.com
 (2603:10b6:907::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25 via Frontend
 Transport; Fri, 7 Jul 2023 17:47:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Fri, 7 Jul 2023 17:47:07 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 7 Jul 2023 12:47:04 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amdkfd: add kfd2kgd debugger callbacks for GC v9.4.3
Date: Fri, 7 Jul 2023 13:46:45 -0400
Message-ID: <20230707174648.146441-2-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707174648.146441-1-jinhuieric.huang@amd.com>
References: <20230707174648.146441-1-jinhuieric.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT050:EE_|DM6PR12MB4369:EE_
X-MS-Office365-Filtering-Correlation-Id: 95317ce6-1918-48c2-6641-08db7f122f37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JO8URjv7blQuOmNsRi1WRk9dOBje/FzMxjFOAnI8Pt03615pDODH2E3YTcN6xK48EIrkpkSG9qTz7hrkstZL7+LK4RYn8Hb7C6ae2tK3wz7CFdyL+4HxLekThnEaStO3cArZoBfeZbFhDgQ8bYwzX+k+cTB7pIotlpQtHwyNaiHu+dUMQwTbPb5OaMKEvDNTBonNHrVnx6eU0QD2nIAHuMj6/4GI03f7OY3RyWh67CTKeHCzyOHKAgjHGU8JM3NuEZTgOm8aUG5aVLqDGvCKhsqBw218ExSt9AmMjFbwpE7sSWOPaQJ4LNM+OPUJvNHo9QvV0wvdpfQUVndcjnG1m//EwmHfBMVTfjBs0sFHWPzDO0/HcidJ4M3wzI8TeBpv1/kyC2/hUX1RoaOi/OYMQ9E/yNaxtUGX0cy+/UyX9vLXwhRhhZXGSR9j/Tt2fNBeUz8l1ZkHVOMIHtmiFCylDRTKPJ+bqOU4vCBGcCgHzxX4Gguhgi393TE8nBwbi/jNwdgj6D3QE5eNknJfjMS/yFbbD3DIBuvz5NTBU2SHX4TU3Zb+FlZyI/S9nqkuumMTykOU3vdQiBb3bMUenppfi+xbI1cDuNtNQWUqcMzP7i1EDYkAHuWsuXHT21S/LWIsDpMwHg3uZQB+/aT2Pdk7cp0yus/pIZkncKQ3PAuRiRCxmdhyvYLF/p0eI+BhXfmG+fuAYDlhbKh2mRXr0so5+vegxOuF6JVavvs/uy5lcEbv2xxaZTEvHMW4cTjQ38d8icQpyDQFbvVnvRQ2aC5H4g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199021)(46966006)(40470700004)(36840700001)(6666004)(7696005)(478600001)(54906003)(16526019)(1076003)(26005)(70206006)(70586007)(2906002)(30864003)(82310400005)(186003)(41300700001)(316002)(6916009)(4326008)(5660300002)(8936002)(8676002)(81166007)(356005)(82740400003)(86362001)(36756003)(40460700003)(47076005)(36860700001)(83380400001)(336012)(426003)(40480700001)(2616005)(66899021)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 17:47:07.9793 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95317ce6-1918-48c2-6641-08db7f122f37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4369
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
Cc: Eric Huang <jinhuieric.huang@amd.com>, Jonathan Kim <jonathan.kim@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jonathan Kim <jonathan.kim@amd.com>

Implement the similarities as GC v9.4.2, and the difference
for GC v9.4.3 HW spec, i.e. xcc instance.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  |   8 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h  |  27 +++
 .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   | 166 +++++++++++++++++-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    |   3 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h    |   6 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c    |   3 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |   3 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |   3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c        |   3 +-
 .../gpu/drm/amd/include/kgd_kfd_interface.h   |   3 +-
 10 files changed, 213 insertions(+), 12 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
index 60f9e027fb66..a06a99c5d311 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
@@ -23,6 +23,7 @@
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_amdkfd_arcturus.h"
 #include "amdgpu_amdkfd_gfx_v9.h"
+#include "amdgpu_amdkfd_aldebaran.h"
 #include "gc/gc_9_4_2_offset.h"
 #include "gc/gc_9_4_2_sh_mask.h"
 #include <uapi/linux/kfd_ioctl.h>
@@ -36,7 +37,7 @@
  * initialize the debug mode registers after it has disabled GFX off during the
  * debug session.
  */
-static uint32_t kgd_aldebaran_enable_debug_trap(struct amdgpu_device *adev,
+uint32_t kgd_aldebaran_enable_debug_trap(struct amdgpu_device *adev,
 					    bool restore_dbg_registers,
 					    uint32_t vmid)
 {
@@ -107,7 +108,7 @@ static uint32_t kgd_aldebaran_set_wave_launch_trap_override(struct amdgpu_device
 	return data;
 }
 
-static uint32_t kgd_aldebaran_set_wave_launch_mode(struct amdgpu_device *adev,
+uint32_t kgd_aldebaran_set_wave_launch_mode(struct amdgpu_device *adev,
 					uint8_t wave_launch_mode,
 					uint32_t vmid)
 {
@@ -125,7 +126,8 @@ static uint32_t kgd_gfx_aldebaran_set_address_watch(
 					uint32_t watch_address_mask,
 					uint32_t watch_id,
 					uint32_t watch_mode,
-					uint32_t debug_vmid)
+					uint32_t debug_vmid,
+					uint32_t inst )
 {
 	uint32_t watch_address_high;
 	uint32_t watch_address_low;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h
new file mode 100644
index 000000000000..a7bdaf8d82dd
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h
@@ -0,0 +1,27 @@
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
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
+uint32_t kgd_aldebaran_enable_debug_trap(struct amdgpu_device *adev,
+					bool restore_dbg_registers,
+					uint32_t vmid);
+uint32_t kgd_aldebaran_set_wave_launch_mode(struct amdgpu_device *adev,
+					uint8_t wave_launch_mode,
+					uint32_t vmid);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
index 5b4b7f8b92a5..543405a28b19 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
@@ -22,6 +22,7 @@
 #include "amdgpu.h"
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_amdkfd_gfx_v9.h"
+#include "amdgpu_amdkfd_aldebaran.h"
 #include "gc/gc_9_4_3_offset.h"
 #include "gc/gc_9_4_3_sh_mask.h"
 #include "athub/athub_1_8_0_offset.h"
@@ -32,6 +33,7 @@
 #include "soc15.h"
 #include "sdma/sdma_4_4_2_offset.h"
 #include "sdma/sdma_4_4_2_sh_mask.h"
+#include <uapi/linux/kfd_ioctl.h>
 
 static inline struct v9_sdma_mqd *get_sdma_mqd(void *mqd)
 {
@@ -361,6 +363,156 @@ static int kgd_gfx_v9_4_3_hqd_load(struct amdgpu_device *adev, void *mqd,
 	return 0;
 }
 
+/* returns TRAP_EN, EXCP_EN and EXCP_REPLACE. */
+static uint32_t kgd_gfx_v9_4_3_disable_debug_trap(struct amdgpu_device *adev,
+						bool keep_trap_enabled,
+						uint32_t vmid)
+{
+	uint32_t data = 0;
+
+	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN, 1);
+	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_EN, 0);
+	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_REPLACE, 0);
+
+	return data;
+}
+
+static int kgd_gfx_v9_4_3_validate_trap_override_request(
+				struct amdgpu_device *adev,
+				uint32_t trap_override,
+				uint32_t *trap_mask_supported)
+{
+	*trap_mask_supported &= KFD_DBG_TRAP_MASK_FP_INVALID |
+	                        KFD_DBG_TRAP_MASK_FP_INPUT_DENORMAL |
+	                        KFD_DBG_TRAP_MASK_FP_DIVIDE_BY_ZERO |
+	                        KFD_DBG_TRAP_MASK_FP_OVERFLOW |
+	                        KFD_DBG_TRAP_MASK_FP_UNDERFLOW |
+	                        KFD_DBG_TRAP_MASK_FP_INEXACT |
+	                        KFD_DBG_TRAP_MASK_INT_DIVIDE_BY_ZERO |
+	                        KFD_DBG_TRAP_MASK_DBG_ADDRESS_WATCH |
+	                        KFD_DBG_TRAP_MASK_DBG_MEMORY_VIOLATION |
+	                        KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_START |
+	                        KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_END;
+
+	if (trap_override != KFD_DBG_TRAP_OVERRIDE_OR &&
+			trap_override != KFD_DBG_TRAP_OVERRIDE_REPLACE)
+		return -EPERM;
+
+	return 0;
+}
+
+static uint32_t trap_mask_map_sw_to_hw(uint32_t mask)
+{
+	uint32_t trap_on_start = (mask & KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_START) ? 1 : 0;
+	uint32_t trap_on_end = (mask & KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_END) ? 1 : 0;
+	uint32_t excp_en = mask & (KFD_DBG_TRAP_MASK_FP_INVALID |
+				KFD_DBG_TRAP_MASK_FP_INPUT_DENORMAL |
+				KFD_DBG_TRAP_MASK_FP_DIVIDE_BY_ZERO |
+				KFD_DBG_TRAP_MASK_FP_OVERFLOW |
+				KFD_DBG_TRAP_MASK_FP_UNDERFLOW |
+				KFD_DBG_TRAP_MASK_FP_INEXACT |
+				KFD_DBG_TRAP_MASK_INT_DIVIDE_BY_ZERO |
+				KFD_DBG_TRAP_MASK_DBG_ADDRESS_WATCH |
+				KFD_DBG_TRAP_MASK_DBG_MEMORY_VIOLATION);
+	uint32_t ret;
+
+	ret = REG_SET_FIELD(0, SPI_GDBG_PER_VMID_CNTL, EXCP_EN, excp_en);
+	ret = REG_SET_FIELD(ret, SPI_GDBG_PER_VMID_CNTL, TRAP_ON_START, trap_on_start);
+	ret = REG_SET_FIELD(ret, SPI_GDBG_PER_VMID_CNTL, TRAP_ON_END, trap_on_end);
+
+	return ret;
+}
+
+static uint32_t trap_mask_map_hw_to_sw(uint32_t mask)
+{
+	uint32_t ret = REG_GET_FIELD(mask, SPI_GDBG_PER_VMID_CNTL, EXCP_EN);
+
+	if (REG_GET_FIELD(mask, SPI_GDBG_PER_VMID_CNTL, TRAP_ON_START))
+		ret |= KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_START;
+
+	if (REG_GET_FIELD(mask, SPI_GDBG_PER_VMID_CNTL, TRAP_ON_END))
+		ret |= KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_END;
+
+	return ret;
+}
+
+/* returns TRAP_EN, EXCP_EN and EXCP_REPLACE. */
+static uint32_t kgd_gfx_v9_4_3_set_wave_launch_trap_override(
+				struct amdgpu_device *adev,
+				uint32_t vmid,
+				uint32_t trap_override,
+				uint32_t trap_mask_bits,
+				uint32_t trap_mask_request,
+				uint32_t *trap_mask_prev,
+				uint32_t kfd_dbg_trap_cntl_prev)
+
+{
+	uint32_t data = 0;
+
+	*trap_mask_prev = trap_mask_map_hw_to_sw(kfd_dbg_trap_cntl_prev);
+
+	data = (trap_mask_bits & trap_mask_request) |
+	       (*trap_mask_prev & ~trap_mask_request);
+	data = trap_mask_map_sw_to_hw(data);
+
+	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN, 1);
+	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_REPLACE, trap_override);
+
+	return data;
+}
+
+#define TCP_WATCH_STRIDE (regTCP_WATCH1_ADDR_H - regTCP_WATCH0_ADDR_H)
+static uint32_t kgd_gfx_v9_4_3_set_address_watch(
+				struct amdgpu_device *adev,
+				uint64_t watch_address,
+				uint32_t watch_address_mask,
+				uint32_t watch_id,
+				uint32_t watch_mode,
+				uint32_t debug_vmid,
+				uint32_t inst)
+{
+	uint32_t watch_address_high;
+	uint32_t watch_address_low;
+	uint32_t watch_address_cntl;
+
+	watch_address_cntl = 0;
+	watch_address_low = lower_32_bits(watch_address);
+	watch_address_high = upper_32_bits(watch_address) & 0xffff;
+
+	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
+			TCP_WATCH0_CNTL,
+			MODE,
+			watch_mode);
+
+	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
+			TCP_WATCH0_CNTL,
+			MASK,
+			watch_address_mask >> 7);
+
+	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
+			TCP_WATCH0_CNTL,
+			VALID,
+			1);
+
+	WREG32_RLC((SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
+			regTCP_WATCH0_ADDR_H) +
+			(watch_id * TCP_WATCH_STRIDE)),
+			watch_address_high);
+
+	WREG32_RLC((SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
+			regTCP_WATCH0_ADDR_L) +
+			(watch_id * TCP_WATCH_STRIDE)),
+			watch_address_low);
+
+	return watch_address_cntl;
+}
+
+static uint32_t kgd_gfx_v9_4_3_clear_address_watch(struct amdgpu_device *adev,
+				uint32_t watch_id)
+{
+	return 0;
+}
+
 const struct kfd2kgd_calls gc_9_4_3_kfd2kgd = {
 	.program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
 	.set_pasid_vmid_mapping = kgd_gfx_v9_4_3_set_pasid_vmid_mapping,
@@ -380,5 +532,17 @@ const struct kfd2kgd_calls gc_9_4_3_kfd2kgd = {
 	.set_vm_context_page_table_base =
 				kgd_gfx_v9_set_vm_context_page_table_base,
 	.program_trap_handler_settings =
-				kgd_gfx_v9_program_trap_handler_settings
+				kgd_gfx_v9_program_trap_handler_settings,
+	.build_grace_period_packet_info =
+				kgd_gfx_v9_build_grace_period_packet_info,
+	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
+	.enable_debug_trap = kgd_aldebaran_enable_debug_trap,
+	.disable_debug_trap = kgd_gfx_v9_4_3_disable_debug_trap,
+	.validate_trap_override_request =
+			kgd_gfx_v9_4_3_validate_trap_override_request,
+	.set_wave_launch_trap_override =
+			kgd_gfx_v9_4_3_set_wave_launch_trap_override,
+	.set_wave_launch_mode = kgd_aldebaran_set_wave_launch_mode,
+	.set_address_watch = kgd_gfx_v9_4_3_set_address_watch,
+	.clear_address_watch = kgd_gfx_v9_4_3_clear_address_watch
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 8ad7a7779e14..fd42b524a161 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -886,7 +886,8 @@ uint32_t kgd_gfx_v10_set_address_watch(struct amdgpu_device *adev,
 					uint32_t watch_address_mask,
 					uint32_t watch_id,
 					uint32_t watch_mode,
-					uint32_t debug_vmid)
+					uint32_t debug_vmid,
+					uint32_t inst)
 {
 	uint32_t watch_address_high;
 	uint32_t watch_address_low;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
index e6b70196071a..306ea176032d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
@@ -44,10 +44,12 @@ uint32_t kgd_gfx_v10_set_address_watch(struct amdgpu_device *adev,
 					uint32_t watch_address_mask,
 					uint32_t watch_id,
 					uint32_t watch_mode,
-					uint32_t debug_vmid);
+					uint32_t debug_vmid,
+					uint32_t inst);
 uint32_t kgd_gfx_v10_clear_address_watch(struct amdgpu_device *adev,
 					uint32_t watch_id);
-void kgd_gfx_v10_get_iq_wait_times(struct amdgpu_device *adev, uint32_t *wait_times);
+void kgd_gfx_v10_get_iq_wait_times(struct amdgpu_device *adev,
+				uint32_t *wait_times);
 void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *adev,
 					       uint32_t wait_times,
 					       uint32_t grace_period,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
index 91c3574ebed3..77ca5cbfb601 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
@@ -743,7 +743,8 @@ static uint32_t kgd_gfx_v11_set_address_watch(struct amdgpu_device *adev,
 					uint32_t watch_address_mask,
 					uint32_t watch_id,
 					uint32_t watch_mode,
-					uint32_t debug_vmid)
+					uint32_t debug_vmid,
+					uint32_t inst)
 {
 	uint32_t watch_address_high;
 	uint32_t watch_address_low;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 51d93fb13ea3..bb496e818d52 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -822,7 +822,8 @@ uint32_t kgd_gfx_v9_set_address_watch(struct amdgpu_device *adev,
 					uint32_t watch_address_mask,
 					uint32_t watch_id,
 					uint32_t watch_mode,
-					uint32_t debug_vmid)
+					uint32_t debug_vmid,
+					uint32_t inst)
 {
 	uint32_t watch_address_high;
 	uint32_t watch_address_low;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
index 5f54bff0db49..4e8aa0432e8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
@@ -89,7 +89,8 @@ uint32_t kgd_gfx_v9_set_address_watch(struct amdgpu_device *adev,
 					uint32_t watch_address_mask,
 					uint32_t watch_id,
 					uint32_t watch_mode,
-					uint32_t debug_vmid);
+					uint32_t debug_vmid,
+					uint32_t inst);
 uint32_t kgd_gfx_v9_clear_address_watch(struct amdgpu_device *adev,
 					uint32_t watch_id);
 void kgd_gfx_v9_get_iq_wait_times(struct amdgpu_device *adev, uint32_t *wait_times);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index fff3ccc04fa9..24083db44724 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -466,7 +466,8 @@ int kfd_dbg_trap_set_dev_address_watch(struct kfd_process_device *pdd,
 				watch_address_mask,
 				*watch_id,
 				watch_mode,
-				pdd->dev->vm_info.last_vmid_kfd);
+				pdd->dev->vm_info.last_vmid_kfd,
+				0);
 	amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
 
 	if (!pdd->dev->kfd->shared_resources.enable_mes)
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index d0df3381539f..30d91d2ffe4c 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -315,7 +315,8 @@ struct kfd2kgd_calls {
 					uint32_t watch_address_mask,
 					uint32_t watch_id,
 					uint32_t watch_mode,
-					uint32_t debug_vmid);
+					uint32_t debug_vmid,
+					uint32_t inst);
 	uint32_t (*clear_address_watch)(struct amdgpu_device *adev,
 			uint32_t watch_id);
 	void (*get_iq_wait_times)(struct amdgpu_device *adev,
-- 
2.34.1


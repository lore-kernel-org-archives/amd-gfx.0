Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F2B1EB64DA
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jul 2023 22:59:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8249710E3C7;
	Wed,  5 Jul 2023 22:58:59 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A2D910E3C7
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jul 2023 22:58:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZ1IHaHd3rUn3cLKTPXBRvY1FGzOBCetltKu616g4Qpkx+WpnqIt0kQGUyl3x+pbvzPLEMIocviB9ijbhuURRi5CGTTFp2/5osPgkYCS4x3N5yDw288rysiWIw6m5Wr3hP6Blj7fiuwmOSPqKyydDgDgm1dyR8pI4rkjKuuOpYNsuorSNJo/amVgki47BV+av20W3zveu0wEINw22oARu1GkYAXPSoFoSpo5BtLVd8U3yibS/ripaVtK0RkKiroJ7O/r9chg0KiPk0+HGtxvPOzu9QkPEZMXva10ztUSl0KhgFvddpCNC2Oq9Btt3fIDC0UGgC7XDtf9Wl/CMpSkng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gm6iFiCJL4ZfBLu2pur7x40MsCW/HH2FxJYF8bkFnYo=;
 b=danj17N2YswTo/Wli/WtudsicwoswsIXihmiUA6IUSo+gCWDuYvaJ2gYN0pDBgkVvYyWxw6O5KSWkLrlg6D9CiuBIPXU96y0r7He04iqjob81pCh66xbxAhJLD7rL+IzOtrZzFntB+D2Qq548g32uWng4wT/k6fM0B6bTunoRP2Iu/BWl8KpADr9ZX3yhf41v1udJqZQBAm21LEFKdJe798hsy6kspphzjJ930gXZupbkNtrLoZKTSkaJhExPahvtDC31S1I8Dl2JltHh7NHq4NsSyPaNl5unZpbsISXMJtPij2BtFoM6qIk7bPZsi7OFuf04GIp1KbV+jUbOP0jkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gm6iFiCJL4ZfBLu2pur7x40MsCW/HH2FxJYF8bkFnYo=;
 b=5a+e67OZ1vHfiwJeLIjqEG6f9dvs0yW6+3sLcQuRwMCJPoQEs8d3uwe149IEjv1Z1alJufKizLXMfdx+J5M27xb9uOSk4hEypRO8xSpPKLX29jXiiYhLrbMPoOeQ379VhN/QJvLKBjV09oL2lzOpvmNVjPGhAD/PAIvNGu3jr7g=
Received: from MW3PR06CA0029.namprd06.prod.outlook.com (2603:10b6:303:2a::34)
 by CY8PR12MB7193.namprd12.prod.outlook.com (2603:10b6:930:5b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 22:58:54 +0000
Received: from CO1NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::9c) by MW3PR06CA0029.outlook.office365.com
 (2603:10b6:303:2a::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Wed, 5 Jul 2023 22:58:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT106.mail.protection.outlook.com (10.13.175.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Wed, 5 Jul 2023 22:58:54 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 5 Jul 2023 17:58:52 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/5] drm/amdgpu: add kfd2kgd debugger callbacks for GC v9.4.3
Date: Wed, 5 Jul 2023 18:56:51 -0400
Message-ID: <20230705225655.299335-2-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230705225655.299335-1-jinhuieric.huang@amd.com>
References: <20230705225655.299335-1-jinhuieric.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT106:EE_|CY8PR12MB7193:EE_
X-MS-Office365-Filtering-Correlation-Id: 973d2078-3065-416c-e1db-08db7dab680d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wvj048NEr67v3NW0xWhiS8qz285o8hUIzSokao3/dd1PfFwwWqJMpcT8w8ZZoe5zI6jMfXykK0vyQGfATQdL1yR9j0F2Nq56Ghz1eeo/okgjQRUZAabzM7VyKLghxkSC+1GgB1jzDmEd/M/Mcl9Cnx4EldLiBjQf4Wpg3x4L91Vrwq2g4AS2mor56p+mDc4/3pG9u3/C7wQtqnem6RupfSt49h70j42xb17JMs//fGAIW0hpraKtcCt5c7BSzl/To9PbpxR9A6NzrqfCfVm02F1SQc+j3QUKptZp2MpCscjHe7yOjNUoD6KN77umk/V2etBeoXtQABTSRNJw3PPEzoyuMqjyqQwG2RIPdDsQvl2t0c1WZmmq8Bb1+fkR3nCqShAeeDFDnIbTdgJSzmtFfNpyPVyecS6+IGEBMlgtvlWX9leJxvsAUyDeCcYBVteoAsd5F5QijFYcMij2ltuQYFEwp/s16dJ4SOFIxSZZl3G7HCQTUqTEEAHcAcwsNZey5od/AYJXOy7FOTmCaPypSKbiMcp2ATlLQApqGYW+enoLBiSsqYiHBaN3ecpGn1/vneKp6bifmZoOMvrMNe5yIFq0WSQEvsy3lZhymLDaSYIYW5RkHT9bCnIe/RoCilP+vJ2g+Hl4TSV/Dl6N/1C+R11vqlw58D3vlGOjGQaxeEoHx7SCgraXOli6p5ngeZtlyaARMsYGhT6SRGs4O2MnRqKtNZSVipxQmIcxDT2OAD2DvCW9dZcJh6JPs0o2KqgWr+9FgFb28RihvOKZNm7vZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199021)(40470700004)(46966006)(36840700001)(54906003)(7696005)(478600001)(336012)(186003)(26005)(1076003)(16526019)(2906002)(82310400005)(70586007)(6916009)(316002)(8936002)(82740400003)(41300700001)(8676002)(70206006)(5660300002)(356005)(4326008)(81166007)(40460700003)(86362001)(36756003)(426003)(47076005)(83380400001)(36860700001)(2616005)(40480700001)(66899021)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 22:58:54.0114 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 973d2078-3065-416c-e1db-08db7dab680d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7193
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
for GC v9.4.3 HW spec.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  |   7 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h  |  30 ++++
 .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   | 149 +++++++++++++++++-
 3 files changed, 182 insertions(+), 4 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
index 60f9e027fb66..f3f7e0437447 100644
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
@@ -50,7 +51,7 @@ static uint32_t kgd_aldebaran_enable_debug_trap(struct amdgpu_device *adev,
 }
 
 /* returns TRAP_EN, EXCP_EN and EXCP_REPLACE. */
-static uint32_t kgd_aldebaran_disable_debug_trap(struct amdgpu_device *adev,
+uint32_t kgd_aldebaran_disable_debug_trap(struct amdgpu_device *adev,
 						bool keep_trap_enabled,
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h
new file mode 100644
index 000000000000..ed349ff397bd
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h
@@ -0,0 +1,30 @@
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
+uint32_t kgd_aldebaran_disable_debug_trap(struct amdgpu_device *adev,
+					bool keep_trap_enabled,
+					uint32_t vmid);
+uint32_t kgd_aldebaran_set_wave_launch_mode(struct amdgpu_device *adev,
+					uint8_t wave_launch_mode,
+					uint32_t vmid);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
index 5b4b7f8b92a5..3299e268f234 100644
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
@@ -361,6 +363,139 @@ static int kgd_gfx_v9_4_3_hqd_load(struct amdgpu_device *adev, void *mqd,
 	return 0;
 }
 
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
+				uint32_t debug_vmid)
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
+	WREG32_RLC((SOC15_REG_OFFSET(GC, 0, regTCP_WATCH0_ADDR_H) +
+			(watch_id * TCP_WATCH_STRIDE)),
+			watch_address_high);
+
+	WREG32_RLC((SOC15_REG_OFFSET(GC, 0, regTCP_WATCH0_ADDR_L) +
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
@@ -380,5 +515,17 @@ const struct kfd2kgd_calls gc_9_4_3_kfd2kgd = {
 	.set_vm_context_page_table_base =
 				kgd_gfx_v9_set_vm_context_page_table_base,
 	.program_trap_handler_settings =
-				kgd_gfx_v9_program_trap_handler_settings
+				kgd_gfx_v9_program_trap_handler_settings,
+	.build_grace_period_packet_info =
+				kgd_gfx_v9_build_grace_period_packet_info,
+	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
+	.enable_debug_trap = kgd_aldebaran_enable_debug_trap,
+	.disable_debug_trap = kgd_aldebaran_disable_debug_trap,
+	.validate_trap_override_request =
+			kgd_gfx_v9_4_3_validate_trap_override_request,
+	.set_wave_launch_trap_override =
+			kgd_gfx_v9_4_3_set_wave_launch_trap_override,
+	.set_wave_launch_mode = kgd_aldebaran_set_wave_launch_mode,
+	.set_address_watch = kgd_gfx_v9_4_3_set_address_watch,
+	.clear_address_watch = kgd_gfx_v9_4_3_clear_address_watch
 };
-- 
2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA94EB64D7
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jun 2023 21:24:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6837010E39E;
	Wed, 28 Jun 2023 21:24:15 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C17D10E39D
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jun 2023 21:24:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRJ6JoRuDebimBEg2s3ZkE7l4opBQZYkrEXlBcXhChAxh13qKsA5tcSidwoTIbcYyDtlFzv1IGHys2SkbVPQXYb0DEIweGRAJel/6fD2R2UWynePj3L3S/r9dLMwCX5AnBMrQOXHL1eMlT6cyvVX0zg12Wtjf9jt2wkN4d/L9qvBkRFhzIYZ3dCq6P/ljzwoH4B1FPbWCqjHX/ZNgzAMHMl0gzJWed1xmxHwqx+j/NDwo9h9r4pSREL+nBO7mKGNt055zP8X3ZFwyJNycg6QqaRdqi1+ZbM5q1WqQ7DeB87D7S9ZA2SQWu5linNNnq27yVcug+t4LeON6RaneDDIKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lf4Ykrf58TbutvtgyYmtuhQPuc6vbNF16CodezAGFo=;
 b=QDeFq08WCAtqLeVnPD/bYCV26CVA28XGRCCUqaR6BU6i5qO2WfXgXu3Y2XATbJ5HmC7PhGc4BJFJx2SHQhfGc9zdXXMwJW7FS0zZdO8omsASQ8HHSxMmarVVxfzZez8fozxVfdkb1YZI6fkJ7lUZjuziGUUOY+BlrbijTdDe6aabpn1YfaGDpjFcOieVyyGpNMnl1ARiTe/nbzlH8x6FVwAzOvIjt0VmlHgXeeA5Oq2F6+NSvco7Nc7/7nAcnP2pqJt5N8JyUzchVqwuJUyIQBk8O7cq7UyHQ6gVUmFVbey+n0Ll5Veuy4Uo202rHaRC1fnt1jCYjNyc8mxjn5ArKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lf4Ykrf58TbutvtgyYmtuhQPuc6vbNF16CodezAGFo=;
 b=IbbqhHrlDReVxOWOg0bTLmMAMM4RCBsphR0XdCaaaFMwcW4zhzpveQugBMuCmpr7fZMMg0IPm4BG7sg25PLiNh9z5pRv1YiYNE896sB2OSAJPUqn0vKZK8E7hr9I/kQnXbAUtJhcFqLwrxdtO/d8gn6ew7RVkXIWovtm5TUp9to=
Received: from DM6PR06CA0052.namprd06.prod.outlook.com (2603:10b6:5:54::29) by
 PH8PR12MB6868.namprd12.prod.outlook.com (2603:10b6:510:1cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 21:23:59 +0000
Received: from DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::df) by DM6PR06CA0052.outlook.office365.com
 (2603:10b6:5:54::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.20 via Frontend
 Transport; Wed, 28 Jun 2023 21:23:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT082.mail.protection.outlook.com (10.13.173.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.48 via Frontend Transport; Wed, 28 Jun 2023 21:23:59 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 28 Jun 2023 16:23:58 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/5] drm/amdgpu: add debugger support for GC v9.4.3
Date: Wed, 28 Jun 2023 17:23:19 -0400
Message-ID: <20230628212323.248650-2-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230628212323.248650-1-jinhuieric.huang@amd.com>
References: <20230628212323.248650-1-jinhuieric.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT082:EE_|PH8PR12MB6868:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dd97eed-3a4c-4cba-f8a8-08db781dfcf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BKzPkQ6kPjW+DPaJ9KLGXJSsmlg8/Nj7eUUBF4Bhadrh/QFOGU6+jSCPcpHTqI3YTPOt9xkBs6aLyfv1hr+bRchSobPXVxx4sA3K/8JDys/89jzuqFY56FVtjphp0OI13tTnxq8VA7i4mYEJPvv6Xd3RgRrHLWfRUaVGJ5CL3G6r22KF16lhm3NMt3WjG410FiiidhGs+otfexqtHM2hYs7YbWgJIF/6VBT+mjHfAbBZhWp3godQYrv9jR3jO5FR/PEOt+bsAdL6dtC9yh7f/5P6vAnRMHMGF3lbzH3GN/aO6RGG+1wd9FosS6Uc0U7scpcjYLDycAdxzAb1V5SShH0W+svvy3WNGPuZ29metWnZe9Wac+2ZWHf7CPCbNAh4Q47knkapksh3OfnATW9v8i/yaWi/2bhP8fDWTRbpX9Q/EFNnFaE5fkPeOXN+XLYbiOoLGusJ5QXL5y46/lEugENt75U3qlc509q6j2UfAggOG6kU7kMYrKJUjhvvqiw69SgHG0gcZEj8J1QBcWZRiamiqKBQW3kZxPgIyl6Qpqwg3SQ4KLCePd7sPhMA5A0A4mBQ+SI7jtGHUo++Yx03G4dhiv0n10rkdjgo6tfA4p/8sBz2gCg7DOmGKGXxDSR9XwwwooWoBb70v6e+XhpgdHh9aTBpJqkAa4koURi7P8MHu+CqpKUL/32B58O6qt+Ga+cvThfG2EzKhu5C6/t97+ZuBXtkwnfLhbb3T6WYyYdWIH2rWf8kNE1lhV3xGXMtCT5sz/rEt2oQfCFOiOUvSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199021)(46966006)(36840700001)(40470700004)(5660300002)(4326008)(6916009)(70206006)(478600001)(36756003)(316002)(70586007)(8936002)(66899021)(8676002)(2906002)(40460700003)(36860700001)(54906003)(41300700001)(82310400005)(186003)(7696005)(40480700001)(86362001)(336012)(16526019)(47076005)(6666004)(426003)(26005)(356005)(1076003)(81166007)(82740400003)(2616005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 21:23:59.5901 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd97eed-3a4c-4cba-f8a8-08db781dfcf9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6868
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
 .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   | 146 +++++++++++++++++-
 3 files changed, 179 insertions(+), 4 deletions(-)
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
index 000000000000..5f776ede295e
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
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
index 5b4b7f8b92a5..7aab8dcf46e1 100644
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
+/* returns TRAP_EN, EXCP_EN and EXCP_RPLACE. */
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
@@ -380,5 +515,14 @@ const struct kfd2kgd_calls gc_9_4_3_kfd2kgd = {
 	.set_vm_context_page_table_base =
 				kgd_gfx_v9_set_vm_context_page_table_base,
 	.program_trap_handler_settings =
-				kgd_gfx_v9_program_trap_handler_settings
+				kgd_gfx_v9_program_trap_handler_settings,
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


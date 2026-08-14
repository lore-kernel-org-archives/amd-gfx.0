Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D39C5DF70
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04A6610F6F7;
	Fri, 14 Aug 2026 21:03:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A9YkqNw5";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011001.outbound.protection.outlook.com [40.107.208.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C250D10F6DB
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GZbFFoBkB2+j87j3oYVH5+A+t6GL1qKxWyIFOeXyPrtC0PhFXyFz6SFF3TjI6UyNYCJS0B6wWVfkUtOUfTxpL8u0loORLIKyNxa74YbzMq4Q/sf61dixNDT0XaC060UA/HB5sl36WbOBScefH6qFP8eLLkAXKB7wiBq1Ph8vSFb6MkpPXp7j8ywqnjVqwIESl1o5L6i68//dACmLuaPCEqIzqRF6jqmhwjNbQu7puV9RSCBdMGQcl1LL+TwkZWX1euZ2hHLJO6WytyS+L3p0CO1O7VZNJrhIkjdgtpZSYhu04ZjpAwTQLwm3fx2N+wHwFuzddf/UHmQ/c8qNZVGFvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYcylR2IPpaee7eTRLVC2vtGgmpYhglu6I2/T1rNVrQ=;
 b=AfwzlH8z5cM+Tvjo2mqVjGo78TpkAnezT99b6mc4iqYAOWYjIWJ+XQL9eYKfo1kwrZVMevbG4/G709DtYqKjxFdgy5rpyqbIxaQZwdbFxNvgwk0v4yxRAcoDgx2Y8YEQxmRR9DgmqD2N/pZ5nb+zAsd7BPsHReHwV+vJ/VAhSZouf9EraFnoheKxiLmx4Yc94mu4c5uSEe7Tn4Z6JQk0QiUIRW/Svd8t2u5G1JTBfRLFF5VoHsOvWyj2RFZoV1Ln1cyG7G91V28bPxs3N0MJyt4ZsOTwxkr7THnS9ko6ynK5ZE/gqc/pPZzPvw0mXj0Fgka2XOL0gm4Xy6zmdxCEMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYcylR2IPpaee7eTRLVC2vtGgmpYhglu6I2/T1rNVrQ=;
 b=A9YkqNw5xYMDYqo+KU1GxBmy9dajdHMLZ1MFRztV2MPOKepmUBkpoDi8FnLPfiJt9zNWlmt8L7nMUINjV1s1VZPfBANcNNxxJTfXRnOO1aCDWLeTgrbzLlYEKNGaMBRfuCnTAZM7YBPBKpgYvjXHTLqwL+S0oGxQSOr3YIHvhHs=
Received: from PH7PR17CA0023.namprd17.prod.outlook.com (2603:10b6:510:324::24)
 by CY3PR12MB9701.namprd12.prod.outlook.com (2603:10b6:930:103::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 21:03:15 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:510:324:cafe::2f) by PH7PR17CA0023.outlook.office365.com
 (2603:10b6:510:324::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:03:15 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:07 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:07 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 016/109] drm/amd/ras: Add aca parser v5_0
Date: Fri, 14 Aug 2026 17:01:13 -0400
Message-ID: <20260814210246.3067612-17-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|CY3PR12MB9701:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ae60da2-5397-4ac4-5b72-08defa47758a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|10067099003|56012099006|3023799007|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: YpYtQFrcIKwaXvRVMTxKRebiScZsvOBeaQcFw2K8eAwSDYXrvpFp8J0zkuYk++6PuFR5O53AsMXElCSSnVmKiMTHbR8rHHez2C9JNixlux4QXsX7qU1YUSS2A/bfZ46UqKl9i+hUSIkTMnWA1iwjwDEDD6ikFiW0pPn9JitVYmMUb5BK443v50xPLh1gL4V9sUACQP7hBG9NBLCtP6owkdiFAOE852OWO3kgPpO26f42UxzGt4KChJ8Xa4Lbg6q7bvuie9b4/Pv260XeQfOkWjzS/83ShzFzwFdgUTOeKcxsdLiXXbnPZpVigSGT1Y3aOAIT3LtdpUrNMCDs4kAjSD18lXDL26ulRD3SY4/L5VHUsbMK3jYXKWLHZPyQ0Sj1JeDObof+PkTTNdhEB8GEhb//yxLBQiBjPYx+qUPR1K8HC8xXgtO3ZYlOZzK4FKzjcAH0tN0m2WeKFwb6xItt/pl2TMJAIN4ftgex5Er1L6oxi4K+kQXxTE7pX/jKDeLzqQP2UQGi9ScQ0WNIs+HWmzelRf5bRItWqUX8He0u0DljL2mI72CuLN8aoEV5a1iAq4qTCoB6Vbx4vcl8e38+j4e2XMNSyxj3HZBIQrWeb57CbXN3P4+BEIoltlKF/eZ31HW6MbuvQubm2AJtZ27k4r9c8FX/+FjyOtP8tb6LBoMm3fy/NqTyyV/mzSUlH796sCi5BsCnq8pb9hxJkAVpgA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(10067099003)(56012099006)(3023799007)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2PppyGKMt4Pel+PLDCLaXGAfexTNlvDLf4fzsqUpkVJRkGDVW1LKVSyd9rBi0C93UzEJmpEbku3+DiDPV1/LurHZwDLgFutnBjByKFcWvfBBXv9Wz8n8k0bDhkR40VbJQH+eVyFN6kwU1dtpTz9lPf9BhEC9l+qEY8nZZlckCwjLLfdDNxTnVGWcMuDbI3r7CenzwZPpy/+zqiLwstlu5fvJYZlVtsy7dRL/XLzk5L1RUyw4gsisKzO45GEAaF9OBajp7V2nMeJ6aCYCVRkl066oKOCcGqJQo+1qBWLxNSrNW7oqnMxBl/DOZ9eUuIy4DMIcbgUKIlibb3x18WYMOkuUXgiTNfB6s6bFpW/K+1zY2g9YUggeIZYMF6Me7vThHtBsNqMVKKlYMEKI0A6ZU5TFllAWwEdralQTrfe1oBSLC/52xzHh4/BV5yY1Cx5I
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:15.4143 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae60da2-5397-4ac4-5b72-08defa47758a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9701
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

From: YiPeng Chai <YiPeng.Chai@amd.com>

Add aca parser v5_0.

V2:
  Support new mappings for hwip and hwid.

V3:
  Change aca ip version.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/Makefile       |   1 +
 drivers/gpu/drm/amd/ras/core/aca.c          |   3 +
 drivers/gpu/drm/amd/ras/core/aca.h          |   4 +
 drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c | 352 ++++++++++++++++++++
 drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.h |  62 ++++
 5 files changed, 422 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.h

diff --git a/drivers/gpu/drm/amd/ras/core/Makefile b/drivers/gpu/drm/amd/ras/core/Makefile
index 5b4cd6a3d3588..871c104db24e5 100644
--- a/drivers/gpu/drm/amd/ras/core/Makefile
+++ b/drivers/gpu/drm/amd/ras/core/Makefile
@@ -24,6 +24,7 @@ RAS_CORE_FILES = core.o \
 			ras_mp1_v13_0.o \
 			aca.o  \
 			aca_v1_0.o \
+			ras_aca_v5_0.o \
 			eeprom.o \
 			ras_umc.o \
 			ras_umc_v12_0.o \
diff --git a/drivers/gpu/drm/amd/ras/core/aca.c b/drivers/gpu/drm/amd/ras/core/aca.c
index 032524b921c14..23660e93eecde 100644
--- a/drivers/gpu/drm/amd/ras/core/aca.c
+++ b/drivers/gpu/drm/amd/ras/core/aca.c
@@ -24,6 +24,7 @@
 #include "ras.h"
 #include "aca.h"
 #include "aca_v1_0.h"
+#include "ras_aca_v5_0.h"
 #include "ras_mp1_v13_0.h"
 
 #define ACA_MARK_FATAL_FLAG    0x100
@@ -534,6 +535,8 @@ static const struct ras_aca_ip_func *aca_get_ip_func(
 	switch (ip_version) {
 	case IP_VERSION(1, 0, 0):
 		return &ras_aca_func_v1_0;
+	case IP_VERSION(5, 0, 0):
+		return &ras_aca_func_v5_0;
 	default:
 		RAS_DEV_ERR(ras_core->dev,
 			"ACA ip version(0x%x) is not supported!\n", ip_version);
diff --git a/drivers/gpu/drm/amd/ras/core/aca.h b/drivers/gpu/drm/amd/ras/core/aca.h
index 76fd511dfa7ef..343525dab744e 100644
--- a/drivers/gpu/drm/amd/ras/core/aca.h
+++ b/drivers/gpu/drm/amd/ras/core/aca.h
@@ -65,6 +65,10 @@ enum aca_ecc_hwip {
 	ACA_ECC_HWIP__UMC,
 	ACA_ECC_HWIP__SMU,
 	ACA_ECC_HWIP__PCS_XGMI,
+	ACA_ECC_HWIP__GFX,
+	ACA_ECC_HWIP__SDMA,
+	ACA_ECC_HWIP__MMHUB,
+	ACA_ECC_HWIP__MPIFOE,
 	ACA_ECC_HWIP_COUNT,
 };
 
diff --git a/drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c b/drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c
new file mode 100644
index 0000000000000..e407c3eb1c967
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c
@@ -0,0 +1,352 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
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
+ *
+ */
+#include "ras.h"
+#include "aca.h"
+#include "core_status.h"
+#include "ras_aca_v5_0.h"
+
+#define ACA_HWIP_MAP(ip, hwid, acatypes) \
+	{ACA_ECC_HWIP__##ip, hwid, acatypes, ARRAY_SIZE(acatypes)}
+
+#define ACA_GFX_XCD_HWID  0x2E2
+struct ras_aca_hwip_v5 {
+	enum aca_ecc_hwip hwip;
+	const u32 hwid;
+	const u32 *types;
+	u32 types_sz;
+};
+
+static const u32 smu_aca_types[] = {0x01};
+static const u32 pcs_xgmi_aca_types[] = {0x00};
+static const u32 umc_aca_types[] = {0x00};
+static const u32 gfx_aid_aca_types[] = {0x00, 0x01};
+static const u32 gfx_xcd_aca_types[] = {
+	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09,
+	0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F, 0x10, 0x12, 0x13, 0x14,
+};
+static const u32 gfx_sdma_aca_types[] = {0x11};
+static const u32 sdma_aca_types[] =   {0x00};
+static const u32 mmhub_aca_types[] =  {0x00};
+static const u32 mpifoe_aca_types[] = {0x00};
+
+static struct ras_aca_hwip_v5 aca_hwip_maps[] = {
+	ACA_HWIP_MAP(SMU,      0x01,  smu_aca_types),
+	ACA_HWIP_MAP(PCS_XGMI, 0x50,  pcs_xgmi_aca_types),
+	ACA_HWIP_MAP(UMC,      0x96,  umc_aca_types),
+	ACA_HWIP_MAP(GFX,      0x0B,  gfx_aid_aca_types),
+	ACA_HWIP_MAP(GFX,      0x2E2, gfx_xcd_aca_types),
+	ACA_HWIP_MAP(SDMA,     0x2E2, gfx_sdma_aca_types),
+	ACA_HWIP_MAP(SDMA,     0x15A, sdma_aca_types),
+	ACA_HWIP_MAP(MMHUB,    0x73,  mmhub_aca_types),
+	ACA_HWIP_MAP(MPIFOE,   0x1FD, mpifoe_aca_types),
+};
+
+static const u32 aca_gfx_xcd_instances[] = {
+	0x30000000,  /* XCD0 */
+	0x32000000,  /* XCD1 */
+	0x34000000,  /* XCD2 */
+	0x36000000,  /* XCD3 */
+};
+
+static void aca_decode_bank_info(struct aca_block *aca_blk,
+			struct aca_bank_reg *bank, struct aca_ecc_info *info)
+{
+	u64 ipid;
+	u32 instidhi, instidlo;
+	u32 inst, i;
+
+	ipid = bank->regs[ACA_REG_IDX__IPID];
+	info->hwid = ACA_V5_REG_IPID_HARDWAREID(ipid);
+	info->mcatype = ACA_V5_REG_IPID_ACATYPE(ipid);
+	/*
+	 * Unified DieID Format: SAASS. A:AID, S:Socket.
+	 * Unified DieID[4:4] = InstanceId[0:0]
+	 * Unified DieID[0:3] = InstanceIdHi[0:3]
+	 */
+	instidhi = ACA_V5_REG_IPID_INSTANCEIDHI(ipid);
+	instidlo = ACA_V5_REG_IPID_INSTANCEIDLO(ipid);
+	info->die_id = ((instidhi >> 2) & 0x03);
+	info->socket_id = ((instidlo & 0x1) << 2) | (instidhi & 0x03);
+	info->xcd_valid = false;
+
+	if ((aca_blk->blk_info->hwip == ACA_ECC_HWIP__GFX) &&
+	    (info->hwid == ACA_GFX_XCD_HWID) &&
+	    (aca_blk->blk_info->ras_block_id == RAS_BLOCK_ID__GFX)) {
+		inst = instidlo & GENMASK_ULL(31, 1);
+		info->xcd_id = 0;
+		for (i = 0; i < ARRAY_SIZE(aca_gfx_xcd_instances); i++) {
+			if (inst == aca_gfx_xcd_instances[i]) {
+				info->xcd_id = i;
+				info->xcd_valid = true;
+				break;
+			}
+		}
+	}
+}
+
+static bool aca_check_bank_hwip(struct aca_bank_reg *bank, enum aca_ecc_hwip type)
+{
+	struct ras_aca_hwip_v5 *hwip = NULL;
+	u32 hwid, acatype;
+	u64 ipid;
+	int i, t;
+
+	if (!bank || (type == ACA_ECC_HWIP__UNKNOWN))
+		return false;
+
+	ipid = bank->regs[ACA_REG_IDX__IPID];
+	hwid = ACA_V5_REG_IPID_HARDWAREID(ipid);
+	acatype = ACA_V5_REG_IPID_ACATYPE(ipid);
+
+	for (i = 0; i < ARRAY_SIZE(aca_hwip_maps); i++) {
+		if (aca_hwip_maps[i].hwid != hwid)
+			continue;
+
+		for (t = 0; t < aca_hwip_maps[i].types_sz; t++) {
+			if (aca_hwip_maps[i].types &&
+			    (aca_hwip_maps[i].types[t] == acatype)) {
+				hwip = &aca_hwip_maps[i];
+				goto out;
+			}
+		}
+	}
+
+out:
+	return hwip ? (hwip->hwip == type) : false;
+}
+
+static bool aca_match_bank_default(struct aca_block *aca_blk, void *data)
+{
+	return aca_check_bank_hwip((struct aca_bank_reg *)data, aca_blk->blk_info->hwip);
+}
+
+static bool aca_check_umc_de(struct ras_core_context *ras_core, u64 mc_umc_status)
+{
+	return (ras_core->poison_supported &&
+		    ACA_V5_REG_STATUS_VAL(mc_umc_status) &&
+		    ACA_V5_REG_STATUS_DEFERRED(mc_umc_status));
+}
+
+static bool aca_check_umc_ue(struct ras_core_context *ras_core, u64 mc_umc_status)
+{
+	if (aca_check_umc_de(ras_core, mc_umc_status))
+		return false;
+
+	return (ACA_V5_REG_STATUS_VAL(mc_umc_status) &&
+		    (ACA_V5_REG_STATUS_PCC(mc_umc_status) ||
+		     ACA_V5_REG_STATUS_UC(mc_umc_status) ||
+		     ACA_V5_REG_STATUS_TCC(mc_umc_status)));
+}
+
+static bool aca_check_umc_ce(struct ras_core_context *ras_core, u64 mc_umc_status)
+{
+	if (aca_check_umc_de(ras_core, mc_umc_status))
+		return false;
+
+	return (ACA_V5_REG_STATUS_VAL(mc_umc_status) &&
+		    (ACA_V5_REG_STATUS_CECC(mc_umc_status) ||
+		     (ACA_V5_REG_STATUS_UECC(mc_umc_status) &&
+		      ACA_V5_REG_STATUS_UC(mc_umc_status) == 0) ||
+		/* Identify data parity error in replay mode */
+		     ((ACA_V5_REG_STATUS_ERRORCODEEXT(mc_umc_status) == 0x5 ||
+		      ACA_V5_REG_STATUS_ERRORCODEEXT(mc_umc_status) == 0xb) &&
+		     !(aca_check_umc_ue(ras_core, mc_umc_status)))));
+}
+
+static int aca_parse_umc_bank(struct ras_core_context *ras_core,
+			struct aca_block *aca_blk, void *data, void *buf)
+{
+	struct aca_bank_reg *bank = (struct aca_bank_reg *)data;
+	struct aca_bank_ecc *err = (struct aca_bank_ecc *)buf;
+	u32 ext_error_code;
+	u64 status;
+
+	if (!ras_core || !aca_blk || !data || !buf)
+		return -EINVAL;
+
+	status = bank->regs[ACA_REG_IDX__STATUS];
+	if (!ACA_V5_REG_STATUS_VAL(status))
+		return 0;
+
+	memset(err, 0, sizeof(*err));
+	aca_decode_bank_info(aca_blk, bank, &err->bank_info);
+	err->bank_info.status = bank->regs[ACA_REG_IDX__STATUS];
+	err->bank_info.ipid = bank->regs[ACA_REG_IDX__IPID];
+	err->bank_info.addr = bank->regs[ACA_REG_IDX__ADDR];
+
+	ext_error_code = ACA_V5_REG_STATUS_ERRORCODEEXT(status);
+
+	if (aca_check_umc_de(ras_core, status))
+		err->de_count = 1;
+	else if (aca_check_umc_ue(ras_core, status))
+		err->ue_count = ext_error_code ?
+			1 : ACA_V5_REG_MISC0_ERRCNT(bank->regs[ACA_REG_IDX__MISC0]);
+	else if (aca_check_umc_ce(ras_core, status))
+		err->ce_count = ext_error_code ?
+			1 : ACA_V5_REG_MISC0_ERRCNT(bank->regs[ACA_REG_IDX__MISC0]);
+
+	return 0;
+}
+
+static bool aca_check_bank_is_de(struct ras_core_context *ras_core,
+				u64 status)
+{
+	return (ACA_V5_REG_STATUS_POISON(status) ||
+				ACA_V5_REG_STATUS_DEFERRED(status));
+}
+
+static int aca_parse_bank_default(struct ras_core_context *ras_core,
+				  struct aca_block *aca_blk,
+				  void *data, void *buf)
+{
+	struct aca_bank_reg *bank = (struct aca_bank_reg *)data;
+	struct aca_bank_ecc *err = (struct aca_bank_ecc *)buf;
+
+	u64 misc0, status;
+
+	if (!ras_core || !aca_blk || !data || !buf)
+		return -EINVAL;
+
+	misc0 = bank->regs[ACA_REG_IDX__MISC0];
+	status = bank->regs[ACA_REG_IDX__STATUS];
+
+	memset(err, 0, sizeof(*err));
+	aca_decode_bank_info(aca_blk, bank, &err->bank_info);
+	err->bank_info.status = status;
+	err->bank_info.ipid = bank->regs[ACA_REG_IDX__IPID];
+	err->bank_info.addr = bank->regs[ACA_REG_IDX__ADDR];
+
+	if (aca_check_bank_is_de(ras_core, status)) {
+		err->de_count = 1;
+	} else {
+		if (bank->ecc_type == RAS_ERR_TYPE__UE)
+			err->ue_count = 1;
+		else if (bank->ecc_type == RAS_ERR_TYPE__CE)
+			err->ce_count = ACA_V5_REG_MISC0_ERRCNT(misc0);
+	}
+
+	return 0;
+}
+
+static int aca_parse_xgmi_bank(struct ras_core_context *ras_core,
+			       struct aca_block *aca_blk,
+			       void *data, void *buf)
+{
+	struct aca_bank_reg *bank = (struct aca_bank_reg *)data;
+	struct aca_bank_ecc *err = (struct aca_bank_ecc *)buf;
+	u64 status, count;
+	int ext_error_code;
+
+	if (!ras_core || !aca_blk || !data || !buf)
+		return -EINVAL;
+
+	memset(err, 0, sizeof(*err));
+	aca_decode_bank_info(aca_blk, bank, &err->bank_info);
+	err->bank_info.status = bank->regs[ACA_REG_IDX__STATUS];
+	err->bank_info.ipid = bank->regs[ACA_REG_IDX__IPID];
+	err->bank_info.addr = bank->regs[ACA_REG_IDX__ADDR];
+
+	status = bank->regs[ACA_REG_IDX__STATUS];
+	ext_error_code = ACA_V5_REG_STATUS_ERRORCODEEXT(status);
+
+	count = ACA_V5_REG_MISC0_ERRCNT(bank->regs[ACA_REG_IDX__MISC0]);
+	if (bank->ecc_type == RAS_ERR_TYPE__UE) {
+		if (ext_error_code != 0 && ext_error_code != 1 && ext_error_code != 9)
+			count = 0ULL;
+		err->ue_count = count;
+	} else if (bank->ecc_type == RAS_ERR_TYPE__CE) {
+		count = ext_error_code == 6 ? count : 0ULL;
+		err->ce_count = count;
+	}
+
+	return 0;
+}
+
+static const struct aca_block_info aca_v5_0_umc = {
+	.name = "umc",
+	.ras_block_id = RAS_BLOCK_ID__UMC,
+	.hwip = ACA_ECC_HWIP__UMC,
+	.mask = ACA_ERROR__UE_MASK | ACA_ERROR__CE_MASK | ACA_ERROR__DE_MASK,
+	.bank_ops = {
+		.bank_match = aca_match_bank_default,
+		.bank_parse = aca_parse_umc_bank,
+	},
+};
+
+static const struct aca_block_info aca_v5_0_gfx = {
+	.name = "gfx",
+	.ras_block_id = RAS_BLOCK_ID__GFX,
+	.hwip = ACA_ECC_HWIP__GFX,
+	.mask = ACA_ERROR__UE_MASK | ACA_ERROR__CE_MASK,
+	.bank_ops = {
+		.bank_match = aca_match_bank_default,
+		.bank_parse = aca_parse_bank_default,
+	},
+};
+
+static const struct aca_block_info aca_v5_0_sdma = {
+	.name = "sdma",
+	.ras_block_id = RAS_BLOCK_ID__SDMA,
+	.hwip = ACA_ECC_HWIP__SDMA,
+	.mask = ACA_ERROR__UE_MASK,
+	.bank_ops = {
+		.bank_match = aca_match_bank_default,
+		.bank_parse = aca_parse_bank_default,
+	},
+};
+
+static const struct aca_block_info aca_v5_0_mmhub = {
+	.name = "mmhub",
+	.ras_block_id = RAS_BLOCK_ID__MMHUB,
+	.hwip = ACA_ECC_HWIP__MMHUB,
+	.mask = ACA_ERROR__UE_MASK,
+	.bank_ops = {
+		.bank_match = aca_match_bank_default,
+		.bank_parse = aca_parse_bank_default,
+	},
+};
+
+static const struct aca_block_info aca_v5_0_xgmi = {
+	.name = "xgmi",
+	.ras_block_id = RAS_BLOCK_ID__XGMI_WAFL,
+	.hwip = ACA_ECC_HWIP__PCS_XGMI,
+	.mask = ACA_ERROR__UE_MASK | ACA_ERROR__CE_MASK,
+	.bank_ops = {
+		.bank_match = aca_match_bank_default,
+		.bank_parse = aca_parse_xgmi_bank,
+	},
+};
+
+static const struct aca_block_info *aca_block_info_v5_0[] = {
+	&aca_v5_0_umc,
+	&aca_v5_0_gfx,
+	&aca_v5_0_sdma,
+	&aca_v5_0_mmhub,
+	&aca_v5_0_xgmi,
+};
+
+const struct ras_aca_ip_func ras_aca_func_v5_0 = {
+	.block_num = ARRAY_SIZE(aca_block_info_v5_0),
+	.block_info = aca_block_info_v5_0,
+};
diff --git a/drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.h b/drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.h
new file mode 100644
index 0000000000000..a3eb6d50cc2f6
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
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
+ *
+ */
+
+#ifndef __RAS_ACA_V5_0_H__
+#define __RAS_ACA_V5_0_H__
+#include "ras.h"
+
+#define ACA_V5_REG__FIELD(x, h, l)          (((x) & GENMASK_ULL(h, l)) >> l)
+#define ACA_V5_REG_STATUS_VAL(x)            ACA_V5_REG__FIELD(x, 63, 63)
+#define ACA_V5_REG_STATUS_OVERFLOW(x)       ACA_V5_REG__FIELD(x, 62, 62)
+#define ACA_V5_REG_STATUS_UC(x)             ACA_V5_REG__FIELD(x, 61, 61)
+#define ACA_V5_REG_STATUS_EN(x)             ACA_V5_REG__FIELD(x, 60, 60)
+#define ACA_V5_REG_STATUS_MISCV(x)          ACA_V5_REG__FIELD(x, 59, 59)
+#define ACA_V5_REG_STATUS_ADDRV(x)          ACA_V5_REG__FIELD(x, 58, 58)
+#define ACA_V5_REG_STATUS_PCC(x)            ACA_V5_REG__FIELD(x, 57, 57)
+#define ACA_V5_REG_STATUS_ERRCOREIDVAL(x)   ACA_V5_REG__FIELD(x, 56, 56)
+#define ACA_V5_REG_STATUS_TCC(x)            ACA_V5_REG__FIELD(x, 55, 55)
+#define ACA_V5_REG_STATUS_SYNDV(x)          ACA_V5_REG__FIELD(x, 53, 53)
+#define ACA_V5_REG_STATUS_CECC(x)           ACA_V5_REG__FIELD(x, 46, 46)
+#define ACA_V5_REG_STATUS_UECC(x)           ACA_V5_REG__FIELD(x, 45, 45)
+#define ACA_V5_REG_STATUS_DEFERRED(x)       ACA_V5_REG__FIELD(x, 44, 44)
+#define ACA_V5_REG_STATUS_POISON(x)         ACA_V5_REG__FIELD(x, 43, 43)
+#define ACA_V5_REG_STATUS_SCRUB(x)          ACA_V5_REG__FIELD(x, 40, 40)
+#define ACA_V5_REG_STATUS_ERRCOREID(x)      ACA_V5_REG__FIELD(x, 37, 32)
+#define ACA_V5_REG_STATUS_ADDRLSB(x)        ACA_V5_REG__FIELD(x, 29, 24)
+#define ACA_V5_REG_STATUS_ERRORCODEEXT(x)   ACA_V5_REG__FIELD(x, 21, 16)
+#define ACA_V5_REG_STATUS_ERRORCODE(x)      ACA_V5_REG__FIELD(x, 15, 0)
+
+#define ACA_V5_REG_IPID_ACATYPE(x)          ACA_V5_REG__FIELD(x, 63, 48)
+#define ACA_V5_REG_IPID_INSTANCEIDHI(x)     ACA_V5_REG__FIELD(x, 47, 44)
+#define ACA_V5_REG_IPID_HARDWAREID(x)       ACA_V5_REG__FIELD(x, 43, 32)
+#define ACA_V5_REG_IPID_INSTANCEIDLO(x)     ACA_V5_REG__FIELD(x, 31, 0)
+
+#define ACA_V5_REG_MISC0_VALID(x)           ACA_V5_REG__FIELD(x, 63, 63)
+#define ACA_V5_REG_MISC0_OVRFLW(x)          ACA_V5_REG__FIELD(x, 48, 48)
+#define ACA_V5_REG_MISC0_ERRCNT(x)          ACA_V5_REG__FIELD(x, 43, 32)
+
+#define ACA_V5_REG_SYND_ERRORINFORMATION(x)	ACA_V5_REG__FIELD(x, 17, 0)
+
+extern const struct ras_aca_ip_func ras_aca_func_v5_0;
+#endif
-- 
2.55.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A86B0CAC59A
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 01:36:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4811F10E609;
	Thu, 18 Sep 2025 01:36:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FP0gXLy5";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013063.outbound.protection.outlook.com
 [40.93.201.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59DDA10E5FB
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 01:36:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ULHy2gu/lv49rrmoh8gpvLd8OfPAdeFvAFz5WeI0tiFmAOMfo9cR3+zNAHh1oPyBOtyAQbQbv6DXQ3zlmflV8WffqIWr1WaM0lKiwI+jdfRdzCrAyGgH/HJaB0ORHJcWa+Ui8mRsbNe+4v6lZi7g8pJFtHO1VgYEy0pUDjQ1zSkGESoSCT3ESN/NnGmczazTlFoW6LMYOPs07fofqeBUksr0gR4DXdmvDsY01JQI+f3dmC+F+ckMarLc1ULjDvcUOHT4uIHc6aOnNphGffdtoPx6KuC/a/H0XkTiNFFHy4W8OoJmvCre/5OIIn8iATpIgdmuPbfoB6mVYn0dv8APXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDzHyVssDmKK+eqqkZzg+EMEgcmIuQ4HFk+PSeGJNSw=;
 b=TH2lDlATp6D6F1xjTeY3wyaANt54wt30d8/TUFEoWIRnrkcFi+52Ej/EbBXXqddwNavUMKfNhWTDJgCZ7smy8XzC4PQAn3fEO8sGH0aGqIkRGIrPSqTHDPgsfhlxc7f2n80QexPiVH6Kmt9KZq3IlCQZgkTm1B336j9udghrJexetsmL1+S1Wsks5tZzimVq/nYJFN8YlH3elwrRo8FPbGmF9nzZrnDbTrSYntCrQaPkuVAkEw1Ro9JnghOA750xmIrVe7/yyngNZI05zO0TpsgLvXBcS/OfsT4DgtrdPvS2jY5roviv5fV46aumE0mlNluLMg/M3vH/C+W0bMNsqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDzHyVssDmKK+eqqkZzg+EMEgcmIuQ4HFk+PSeGJNSw=;
 b=FP0gXLy5ssqotAm8ONF2KrMUTu85gxS87uHPUYN/hVn0UwQzRUfXYeYQcRIrAJdd/RF/TP60XZtRs3SI21uBd/PPfqyFgW9emDw3ZE6BJ411scwj5JwsBaAiZ4zygvxWvWNR+IGKtVT0fZ2qh31t++CV/ZDapuEGAwDhSzJtNDs=
Received: from SN1PR12CA0054.namprd12.prod.outlook.com (2603:10b6:802:20::25)
 by DS2PR12MB9685.namprd12.prod.outlook.com (2603:10b6:8:27a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 01:36:48 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:802:20:cafe::81) by SN1PR12CA0054.outlook.office365.com
 (2603:10b6:802:20::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 01:36:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 01:36:47 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Sep
 2025 18:36:45 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou
 <tao.zhou1@amd.com>
Subject: [PATCH 03/10] drm/amd/ras: Add amdgpu mp1 v13_0 configuration function
Date: Thu, 18 Sep 2025 09:35:00 +0800
Message-ID: <20250918013507.2629620-3-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918013507.2629620-1-YiPeng.Chai@amd.com>
References: <20250918013507.2629620-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|DS2PR12MB9685:EE_
X-MS-Office365-Filtering-Correlation-Id: 33045c6f-ad3b-4b3b-1219-08ddf653d556
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m2UesW8fKeniqglFVZpGP1paCefoghzA1MXYYLdiBIeCCY9zIcVnmCcQH06D?=
 =?us-ascii?Q?H8R3nO+MxpNiMML0BIi3iIA+0210inVXdWdlsYW5qWjw/aOQRGxOzdxgQRGC?=
 =?us-ascii?Q?E4YN4zI/ba+SOfnpOH6Hm7imFxSXeHUUrvIv3DEvBptOrLqSutqAuFYe0RRQ?=
 =?us-ascii?Q?P9Uxl6TvE6QENeHeOfL0Jm6h9zjMES5OF8oG3ilzVsObJqKuTnLuFtVtC+Xk?=
 =?us-ascii?Q?H9xXb2i1F6p541fiM6gPHahUhFSE5jiIMjPrHIRU4X9J6I5LFp6IRlyGy4kR?=
 =?us-ascii?Q?l6Q3h1YPcHU64KvE3fkPeNRlOhopduTkzqSZPrWhSrZXDWKRwrB+FP1g4wLj?=
 =?us-ascii?Q?ccutubw2w9JL4GkK2XTHZ3DtXrTabKGSa7M/eC7XZK8BVC25EFr94fEAjUDY?=
 =?us-ascii?Q?fKqSH9J6r1zWooTAf/e4vaog4uD4gxYIATdpwpy2NMkWnIw0ut4ud+ayBsmh?=
 =?us-ascii?Q?nZCHIofD+GbyI6MndfotJ1yz3gkIPfSWALz4IFqPU3tKs6Sd7cRvc7ySnsKe?=
 =?us-ascii?Q?vgFdpqsQS2mYLkv84zjOaU897a3S0q1sVrS+yHE0yPdmX0mkcwQBPGhy54Km?=
 =?us-ascii?Q?lAIOv4BypW4KDRDlnlzfHRehsNh9TyufYrijEUmEP+LoSgtK4ZUVyyI4nqCx?=
 =?us-ascii?Q?698jCiGezLjbFl3ybivBhBZ/9WyKlxzt+dYYF2eM+tX4JqkqEXJfg7SgasaW?=
 =?us-ascii?Q?hzVCx+vGRCgBLq66eWd0A0WE0BEePF2X+RSvkiX4XbAJbZp3yIcxAbLRFsrm?=
 =?us-ascii?Q?baNwnXuNfY11NboBri8IlA9qRW06KWU0biGBuQJ2Ta7YvzNxr0ODf0HCjR0p?=
 =?us-ascii?Q?1Mawl5A8qy/cA6x5BgiLB1RnhfdEiMBgj0w44YSyZkQ6eCm5Yga1hNyZKrEo?=
 =?us-ascii?Q?ZBey+nZUh76iPXHGlNhOAha9rdISK+UZ21fHbuwPTsV5VyhnaHS9l7Pcti0g?=
 =?us-ascii?Q?J4u3T5AWCW93+1tLd1VSok2QMcGc2jrT0jJsTt/F0IwzSJ3mnngn2i5PbKyS?=
 =?us-ascii?Q?fzFYQHr/oBbDsI8bdF2RVtP8MBtFT2g40lvBnARmWU/uABHuP+4zO394e+lI?=
 =?us-ascii?Q?gxrsP5iwVVb0vlyyhGIBfxqzY+CpLg2spOoGBagEsxp2oDhTl4EebKvVH6up?=
 =?us-ascii?Q?vrFvtVndDtIEgRglx21P8hHbzop8YVqMG7S460/+UKKUGjQN//rJtamc0zy2?=
 =?us-ascii?Q?jyEJP8q3tcbHAa3wHnP/ImWes/2s7QPB0Ho6AZx74L47xsMTThzMm/klbt5C?=
 =?us-ascii?Q?xb8KtYU7YSUUocHC2yrmSC0laJ/iXjg/niU/25nnueo8SNFH6Sf0e4iQlJls?=
 =?us-ascii?Q?y/UqYsa1j1eph8a6Jl0/MT2R/7SwXfS9EWH8EiEo5CL5DpDm/wCXteb3Hfqt?=
 =?us-ascii?Q?NSx/Q6BobA/TocpYNRyS/1vtw71F5Oz2lyFRc+rfQBFfRpQ6TKckQNZVx9E+?=
 =?us-ascii?Q?rtOU++CKrsx4lins+tFVbybLhXjV91FN9QlDBpSijPn78Oo1tOf/h1qQMSDw?=
 =?us-ascii?Q?1khiYmKeN67I+iiGiZpqNkyQbYnNQBQjkQNg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 01:36:47.7739 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33045c6f-ad3b-4b3b-1219-08ddf653d556
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9685
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

Add amdgpu mp1 v13_0 configuration function.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c    | 94 +++++++++++++++++++
 .../amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.h    | 30 ++++++
 2 files changed, 124 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
 create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.h

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
new file mode 100644
index 000000000000..79a51b1603ac
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
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
+#include "amdgpu_smu.h"
+#include "amdgpu_reset.h"
+#include "amdgpu_ras_mp1_v13_0.h"
+
+#define RAS_MP1_MSG_QueryValidMcaCeCount  0x3A
+#define RAS_MP1_MSG_McaBankCeDumpDW       0x3B
+
+static int mp1_v13_0_get_valid_bank_count(struct ras_core_context *ras_core,
+					  u32 msg, u32 *count)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
+	u32 smu_msg;
+	int ret = 0;
+
+	if (!count)
+		return -EINVAL;
+
+	smu_msg = (msg == RAS_MP1_MSG_QueryValidMcaCeCount) ?
+			SMU_MSG_QueryValidMcaCeCount : SMU_MSG_QueryValidMcaCount;
+
+	if (down_read_trylock(&adev->reset_domain->sem)) {
+		ret = amdgpu_smu_ras_send_msg(adev, smu_msg, 0, count);
+		up_read(&adev->reset_domain->sem);
+	} else {
+		ret = -RAS_CORE_GPU_IN_MODE1_RESET;
+	}
+
+	if (ret)
+		*count = 0;
+
+	return ret;
+}
+
+static int mp1_v13_0_dump_valid_bank(struct ras_core_context *ras_core,
+				     u32 msg, u32 idx, u32 reg_idx, u64 *val)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
+	uint32_t data[2] = {0, 0};
+	uint32_t param;
+	int ret = 0;
+	int i, offset;
+	u32 smu_msg = (msg == RAS_MP1_MSG_McaBankCeDumpDW) ?
+			     SMU_MSG_McaBankCeDumpDW : SMU_MSG_McaBankDumpDW;
+
+	if (down_read_trylock(&adev->reset_domain->sem)) {
+		offset = reg_idx * 8;
+		for (i = 0; i < ARRAY_SIZE(data); i++) {
+			param = ((idx & 0xffff) << 16) | ((offset + (i << 2)) & 0xfffc);
+			ret = amdgpu_smu_ras_send_msg(adev, smu_msg, param, &data[i]);
+			if (ret) {
+				RAS_DEV_ERR(adev, "ACA failed to read register[%d], offset:0x%x\n",
+					reg_idx, offset);
+				break;
+			}
+		}
+		up_read(&adev->reset_domain->sem);
+
+		if (!ret)
+			*val = (uint64_t)data[1] << 32 | data[0];
+	} else {
+		ret = -RAS_CORE_GPU_IN_MODE1_RESET;
+	}
+
+	return ret;
+}
+
+const struct ras_mp1_sys_func amdgpu_ras_mp1_sys_func_v13_0 = {
+	.mp1_get_valid_bank_count = mp1_v13_0_get_valid_bank_count,
+	.mp1_dump_valid_bank = mp1_v13_0_dump_valid_bank,
+};
+
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.h b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.h
new file mode 100644
index 000000000000..71c614ae1ae4
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
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
+#ifndef __AMDGPU_RAS_MP1_V13_0_H__
+#define __AMDGPU_RAS_MP1_V13_0_H__
+#include "ras.h"
+
+extern const struct ras_mp1_sys_func amdgpu_ras_mp1_sys_func_v13_0;
+
+#endif
-- 
2.34.1


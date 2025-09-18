Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 460D5CAC59A
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 01:33:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 870C510E5DC;
	Thu, 18 Sep 2025 01:33:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dXzVQ1OQ";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011055.outbound.protection.outlook.com [40.107.208.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41E0010E1D9
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 01:33:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yMhECZHC+GTwiArHKlNGHeIdZ6R3UA62cFIlo7GvdO2Q1Mgz2cx97wiw8nfJSbzJHFG3PatIlJ3K73+nBH3ndK6anBJfmejNEB6sfZMuIDtM0X9kr1fmUw4/QaG1dwS63bZW5xzASvLISgF3HpVZbH6DdPdQsyGqQXmj24dR5CH2RNS02RKL3yFjTZKLGPSCCfi+D5r91sa65koHq0Eyo19xe0FmP7POLYs7A+/Fw07sYIiVR/r25s/G8sTcEwAldVHJANBiJt3QA0aYsHdmkpRTnfYCiUnVWkGOsI0hHARpJVqfJc2tJP0U/FUu7cpIWKp4wQE1KwmqDwGIEnkADg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCPjvZfbsYaDhhbR0bKy3ryTiu5IeQQX+lh7RVnfzpk=;
 b=nw7xXBY+404XDA6uCrqdx5ZpAg4T1/IKe8O6z8zqRw9zQBPwM56j8Awri3axDoBgstIEe8zRfv5i+po0SJE6NQ9X4DGEosMwuG4xI23YqSluRBeOooEFZOIcOp545kBdhOsZz9p/HcPN3Y54iSJIXgBqAkfo6T/SADRkw6pVLV4iwPXgPzk2YjmanNzwicG6+AZy5wM7VpVvtixpm6AKm+xNi0x/bgZiLM8OEa5BlExz8TCpgrdYVeYw1Kw0gGMdz9x8g8TIAMuWaOHCmsXPxoZzudkz1vzCrVVTuUfRz8q7YiNbxOIwT3JSFtuqfCjtLTcIuOmtrTVNvjXuiY+cCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCPjvZfbsYaDhhbR0bKy3ryTiu5IeQQX+lh7RVnfzpk=;
 b=dXzVQ1OQEHPClANRTr3t5uH8lZ/DPDHVo1Z4wp+y6oqLRfjdGwaPQiesTQupDWdmD0bYbq+oNKyftyOhGNaZGSAbJ+EjC5Z1Q70rf5Oauvl4y1L3ZXdXM1GnrrPAExHxTFQawhzXRzU5G1OcgBJyXkEdAFAOSunE4/fG+QVgqqI=
Received: from SJ0PR13CA0219.namprd13.prod.outlook.com (2603:10b6:a03:2c1::14)
 by IA0PR12MB8422.namprd12.prod.outlook.com (2603:10b6:208:3de::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Thu, 18 Sep
 2025 01:33:12 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::90) by SJ0PR13CA0219.outlook.office365.com
 (2603:10b6:a03:2c1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Thu,
 18 Sep 2025 01:33:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 01:33:11 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Sep
 2025 18:33:08 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou
 <tao.zhou1@amd.com>
Subject: [PATCH 03/21] drm/amd/ras: Add ras aca parser v1.0
Date: Thu, 18 Sep 2025 09:32:14 +0800
Message-ID: <20250918013232.2629215-3-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918013232.2629215-1-YiPeng.Chai@amd.com>
References: <20250918013232.2629215-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|IA0PR12MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: c1f9c1c4-b636-4115-da83-08ddf6535463
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GGa2zJk7IpoKuRGdkJYzpokgz+OV5221DAMJnv6IMCqmgF9MF/Wud1ducY5O?=
 =?us-ascii?Q?8NSBtkg5zCDqG3J5bmAHRV5LYdL4kqXs1YIcNTOYEyhfaxLc1SG8YuydiSMm?=
 =?us-ascii?Q?j407pIM2UaAjhibUSa7i0Zi4JwK/G5QNGT19xV4birObjgXkMsjcBk2Tg4nB?=
 =?us-ascii?Q?Clmmzqt/x56wdaVPtydwPCtKXXGKo1haViyyHmRUkp4JaB0kmLRMdhr/3jge?=
 =?us-ascii?Q?hbfh0OlUDylY6X/tHbmjNhd9bj5KJKxdejY9GK5AF7Q/bCLYCCrIzJWRwCPU?=
 =?us-ascii?Q?6c8MsQfIJWDeF2ED/SqI7kE7IDUmpujWGuBBSPE6mScdbXwisshpDY4ajFsl?=
 =?us-ascii?Q?lu9b6otqNuCyEJJClBsV/xjHmYFFtnDNtw422clRK8HwwiIYEvI3wphgydgs?=
 =?us-ascii?Q?dhfgkFAQDE9Th3ImgugWopb5DopyXuwcXPx4JLZjywn0NmPRr1Y8Ioybg/PS?=
 =?us-ascii?Q?MmpRlseM61o//AzQkN+lLqSmGj9Y7eQ6tzg9ZGFFIEpYxqfMgyRTibdpYcJy?=
 =?us-ascii?Q?kzq6tgTBLRaE9PuHb8/HCATFSpSXIrb3PcG1wFbWh2vXwyViZG3V2iRQc94l?=
 =?us-ascii?Q?SkksrDB6SfPHNo2t7IyGTn5q5LTlxq622DV4UrTYmEi9PjZr6GIUeqIM3Fju?=
 =?us-ascii?Q?d8nhYOr5TKCu9ps0iTlEEMQga4WlKocveQauWHnq24pe3C29GESOGvB2Xq8S?=
 =?us-ascii?Q?IXrxFfIRFeABixwSJbL/r0cSoP9bfERs4yT8GHs/1RT4ZyufA0P9eORcwdyw?=
 =?us-ascii?Q?YthXddsLlwKwKSccu11xFW7uhguHCEBFZABGYaISWIhrNHlsuYtsyraAwBWM?=
 =?us-ascii?Q?jxomvFdq/UbAvyFwkuPpzIawfbs2Xg3GS7sFhaZRlss8bksfsl+poc3sKYTu?=
 =?us-ascii?Q?7zn55YphAiW/g+6WmgKnakH051z2P3ZdOAg167Z/1D+gqRtN/+ULmz5d3VsU?=
 =?us-ascii?Q?gy23JswH1OQoB2XnwDSljTxXvFgB4Y1BMHTMjSLqG9tYJHH+um8YcfzubYJF?=
 =?us-ascii?Q?OMI9BP8BxVXJRVY8MKOOoyuFHZwiXG8g+jKYfgesTI5LWgVCDJpSyUE5/EMa?=
 =?us-ascii?Q?Qrt26nMesX40uBPe38Q1m7/nqNrnupvoiNvkiB+niGHmCvxYeGRxPcHPPRbs?=
 =?us-ascii?Q?BPYwQRRSvy2SazzOl+5inj6u20l5caHlLTBGgb82OlGypIvu51a5aQITWui+?=
 =?us-ascii?Q?n9wuOJS3u+EPsFSFeNSoTewYhLxCzisYu7BPoWN05Ixhf/k+/SLxH2ztRLGB?=
 =?us-ascii?Q?ArLKrt5MrMDdX8wBXJtoP0XLqd3F/fH59AJpmNMp7WfCLfmIDavkZqBUqcqu?=
 =?us-ascii?Q?d1XM5K8fBcsefh2/Ckztk9cqZob1fgo96G9c/l9zV0GAQvSigdOpz2GzUsqz?=
 =?us-ascii?Q?QesBRhijqRHmlJ+RMNZWGV19X65hYIIhlzjqy0mkPxACXrzCI+G0rdw+XIlx?=
 =?us-ascii?Q?D/VWH6IngZHM4by37ADSZezuJfR2mvyy+nVoeZGiI0zp+TkXxKdj/MiRf9Fv?=
 =?us-ascii?Q?JuFuXkc6BH3KCMdXUVCYT3qfE9Kb0wp72M6L?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 01:33:11.3688 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f9c1c4-b636-4115-da83-08ddf6535463
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8422
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

Add ras aca parser v1.0.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../gpu/drm/amd/ras/rascore/ras_aca_v1_0.c    | 379 ++++++++++++++++++
 .../gpu/drm/amd/ras/rascore/ras_aca_v1_0.h    |  71 ++++
 2 files changed, 450 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c
 create mode 100644 drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.h

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c b/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c
new file mode 100644
index 000000000000..29df98948703
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c
@@ -0,0 +1,379 @@
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
+#include "ras.h"
+#include "ras_aca.h"
+#include "ras_core_status.h"
+#include "ras_aca_v1_0.h"
+
+struct ras_aca_hwip {
+	int hwid;
+	int mcatype;
+};
+
+static struct ras_aca_hwip aca_hwid_mcatypes[ACA_ECC_HWIP_COUNT] = {
+	[ACA_ECC_HWIP__SMU] = {0x01, 0x01},
+	[ACA_ECC_HWIP__PCS_XGMI] = {0x50, 0x00},
+	[ACA_ECC_HWIP__UMC] = {0x96, 0x00},
+};
+
+static int aca_decode_bank_info(struct aca_block *aca_blk,
+			struct aca_bank_reg *bank, struct aca_ecc_info *info)
+{
+	u64 ipid;
+	u32 instidhi, instidlo;
+
+	ipid = bank->regs[ACA_REG_IDX__IPID];
+	info->hwid = ACA_REG_IPID_HARDWAREID(ipid);
+	info->mcatype = ACA_REG_IPID_MCATYPE(ipid);
+	/*
+	 * Unified DieID Format: SAASS. A:AID, S:Socket.
+	 * Unified DieID[4:4] = InstanceId[0:0]
+	 * Unified DieID[0:3] = InstanceIdHi[0:3]
+	 */
+	instidhi = ACA_REG_IPID_INSTANCEIDHI(ipid);
+	instidlo = ACA_REG_IPID_INSTANCEIDLO(ipid);
+	info->die_id = ((instidhi >> 2) & 0x03);
+	info->socket_id = ((instidlo & 0x1) << 2) | (instidhi & 0x03);
+
+	if ((aca_blk->blk_info->hwip == ACA_ECC_HWIP__SMU) &&
+	    (aca_blk->blk_info->ras_block_id == RAS_BLOCK_ID__GFX))
+		info->xcd_id =
+			((instidlo & GENMASK_ULL(31, 1)) == mmSMNAID_XCD0_MCA_SMU) ? 0 : 1;
+
+	return 0;
+}
+
+static bool aca_check_bank_hwip(struct aca_bank_reg *bank, enum aca_ecc_hwip type)
+{
+	struct ras_aca_hwip *hwip;
+	int hwid, mcatype;
+	u64 ipid;
+
+	if (!bank || (type == ACA_ECC_HWIP__UNKNOWN))
+		return false;
+
+	hwip = &aca_hwid_mcatypes[type];
+	if (!hwip->hwid)
+		return false;
+
+	ipid = bank->regs[ACA_REG_IDX__IPID];
+	hwid = ACA_REG_IPID_HARDWAREID(ipid);
+	mcatype = ACA_REG_IPID_MCATYPE(ipid);
+
+	return hwip->hwid == hwid && hwip->mcatype == mcatype;
+}
+
+static bool aca_match_bank_default(struct aca_block *aca_blk, void *data)
+{
+	return aca_check_bank_hwip((struct aca_bank_reg *)data, aca_blk->blk_info->hwip);
+}
+
+static bool aca_match_gfx_bank(struct aca_block *aca_blk, void *data)
+{
+	struct aca_bank_reg *bank = (struct aca_bank_reg *)data;
+	u32 instlo;
+
+	if (!aca_check_bank_hwip(bank, aca_blk->blk_info->hwip))
+		return false;
+
+	instlo = ACA_REG_IPID_INSTANCEIDLO(bank->regs[ACA_REG_IDX__IPID]);
+	instlo &= GENMASK_ULL(31, 1);
+	switch (instlo) {
+	case mmSMNAID_XCD0_MCA_SMU:
+	case mmSMNAID_XCD1_MCA_SMU:
+	case mmSMNXCD_XCD0_MCA_SMU:
+		return true;
+	default:
+		break;
+	}
+
+	return false;
+}
+
+static bool aca_match_sdma_bank(struct aca_block *aca_blk, void *data)
+{
+	struct aca_bank_reg *bank = (struct aca_bank_reg *)data;
+	/* CODE_SDMA0 - CODE_SDMA4, reference to smu driver if header file */
+	static int sdma_err_codes[] = { 33, 34, 35, 36 };
+	u32 instlo;
+	int errcode, i;
+
+	if (!aca_check_bank_hwip(bank, aca_blk->blk_info->hwip))
+		return false;
+
+	instlo = ACA_REG_IPID_INSTANCEIDLO(bank->regs[ACA_REG_IDX__IPID]);
+	instlo &= GENMASK_ULL(31, 1);
+	if (instlo != mmSMNAID_AID0_MCA_SMU)
+		return false;
+
+	errcode = ACA_REG_SYND_ERRORINFORMATION(bank->regs[ACA_REG_IDX__SYND]);
+	errcode &= 0xff;
+
+	/* Check SDMA error codes */
+	for (i = 0; i < ARRAY_SIZE(sdma_err_codes); i++) {
+		if (errcode == sdma_err_codes[i])
+			return true;
+	}
+
+	return false;
+}
+
+static bool aca_match_mmhub_bank(struct aca_block *aca_blk, void *data)
+{
+	struct aca_bank_reg *bank = (struct aca_bank_reg *)data;
+	/* reference to smu driver if header file */
+	const int mmhub_err_codes[] = {
+		0, 1, 2, 3, 4, /* CODE_DAGB0 - 4 */
+		5, 6, 7, 8, 9, /* CODE_EA0 - 4 */
+		10, /* CODE_UTCL2_ROUTER */
+		11, /* CODE_VML2 */
+		12, /* CODE_VML2_WALKER */
+		13, /* CODE_MMCANE */
+	};
+	u32 instlo;
+	int errcode, i;
+
+	if (!aca_check_bank_hwip(bank, aca_blk->blk_info->hwip))
+		return false;
+
+	instlo = ACA_REG_IPID_INSTANCEIDLO(bank->regs[ACA_REG_IDX__IPID]);
+	instlo &= GENMASK_ULL(31, 1);
+	if (instlo != mmSMNAID_AID0_MCA_SMU)
+		return false;
+
+	errcode = ACA_REG_SYND_ERRORINFORMATION(bank->regs[ACA_REG_IDX__SYND]);
+	errcode &= 0xff;
+
+	/* Check MMHUB error codes */
+	for (i = 0; i < ARRAY_SIZE(mmhub_err_codes); i++) {
+		if (errcode == mmhub_err_codes[i])
+			return true;
+	}
+
+	return false;
+}
+
+static bool aca_check_umc_de(struct ras_core_context *ras_core, uint64_t mc_umc_status)
+{
+	return (ras_core->poison_supported &&
+		    ACA_REG_STATUS_VAL(mc_umc_status) &&
+		    ACA_REG_STATUS_DEFERRED(mc_umc_status));
+}
+
+static bool aca_check_umc_ue(struct ras_core_context *ras_core, uint64_t mc_umc_status)
+{
+	if (aca_check_umc_de(ras_core, mc_umc_status))
+		return false;
+
+	return (ACA_REG_STATUS_VAL(mc_umc_status) &&
+		    (ACA_REG_STATUS_PCC(mc_umc_status) ||
+		     ACA_REG_STATUS_UC(mc_umc_status) ||
+		     ACA_REG_STATUS_TCC(mc_umc_status)));
+}
+
+static bool aca_check_umc_ce(struct ras_core_context *ras_core, uint64_t mc_umc_status)
+{
+	if (aca_check_umc_de(ras_core, mc_umc_status))
+		return false;
+
+	return (ACA_REG_STATUS_VAL(mc_umc_status) &&
+		    (ACA_REG_STATUS_CECC(mc_umc_status) ||
+		     (ACA_REG_STATUS_UECC(mc_umc_status) &&
+		      ACA_REG_STATUS_UC(mc_umc_status) == 0) ||
+		/* Identify data parity error in replay mode */
+		     ((ACA_REG_STATUS_ERRORCODEEXT(mc_umc_status) == 0x5 ||
+		      ACA_REG_STATUS_ERRORCODEEXT(mc_umc_status) == 0xb) &&
+		     !(aca_check_umc_ue(ras_core, mc_umc_status)))));
+}
+
+static int aca_parse_umc_bank(struct ras_core_context *ras_core,
+			struct aca_block *ras_blk, void *data, void *buf)
+{
+	struct aca_bank_reg *bank = (struct aca_bank_reg *)data;
+	struct aca_bank_ecc *ecc = (struct aca_bank_ecc *)buf;
+	struct aca_ecc_info bank_info;
+	uint32_t ext_error_code;
+	uint64_t status0;
+
+	status0 = bank->regs[ACA_REG_IDX__STATUS];
+	if (!ACA_REG_STATUS_VAL(status0))
+		return 0;
+
+	memset(&bank_info, 0, sizeof(bank_info));
+	aca_decode_bank_info(ras_blk, bank, &bank_info);
+	memcpy(&ecc->bank_info, &bank_info, sizeof(bank_info));
+	ecc->bank_info.status = bank->regs[ACA_REG_IDX__STATUS];
+	ecc->bank_info.ipid = bank->regs[ACA_REG_IDX__IPID];
+	ecc->bank_info.addr = bank->regs[ACA_REG_IDX__ADDR];
+
+	ext_error_code = ACA_REG_STATUS_ERRORCODEEXT(status0);
+
+	if (aca_check_umc_de(ras_core, status0))
+		ecc->de_count = 1;
+	else if (aca_check_umc_ue(ras_core, status0))
+		ecc->ue_count = ext_error_code ?
+			1 : ACA_REG_MISC0_ERRCNT(bank->regs[ACA_REG_IDX__MISC0]);
+	else if (aca_check_umc_ce(ras_core, status0))
+		ecc->ce_count = ext_error_code ?
+			1 : ACA_REG_MISC0_ERRCNT(bank->regs[ACA_REG_IDX__MISC0]);
+
+	return 0;
+}
+
+static bool aca_check_bank_is_de(struct ras_core_context *ras_core,
+				uint64_t status)
+{
+	return (ACA_REG_STATUS_POISON(status) ||
+				ACA_REG_STATUS_DEFERRED(status));
+}
+
+static int aca_parse_bank_default(struct ras_core_context *ras_core,
+				  struct aca_block *ras_blk,
+				  void *data, void *buf)
+{
+	struct aca_bank_reg *bank = (struct aca_bank_reg *)data;
+	struct aca_bank_ecc *ecc = (struct aca_bank_ecc *)buf;
+	struct aca_ecc_info bank_info;
+	u64 misc0 = bank->regs[ACA_REG_IDX__MISC0];
+	u64 status = bank->regs[ACA_REG_IDX__STATUS];
+
+	memset(&bank_info, 0, sizeof(bank_info));
+	aca_decode_bank_info(ras_blk, bank, &bank_info);
+	memcpy(&ecc->bank_info, &bank_info, sizeof(bank_info));
+	ecc->bank_info.status = status;
+	ecc->bank_info.ipid = bank->regs[ACA_REG_IDX__IPID];
+	ecc->bank_info.addr = bank->regs[ACA_REG_IDX__ADDR];
+
+	if (aca_check_bank_is_de(ras_core, status)) {
+		ecc->de_count = 1;
+	} else {
+		if (bank->ecc_type == RAS_ERR_TYPE__UE)
+			ecc->ue_count = 1;
+		else if (bank->ecc_type == RAS_ERR_TYPE__CE)
+			ecc->ce_count = ACA_REG_MISC0_ERRCNT(misc0);
+	}
+
+	return 0;
+}
+
+static int aca_parse_xgmi_bank(struct ras_core_context *ras_core,
+			       struct aca_block *ras_blk,
+			       void *data, void *buf)
+{
+	struct aca_bank_reg *bank = (struct aca_bank_reg *)data;
+	struct aca_bank_ecc *ecc = (struct aca_bank_ecc *)buf;
+	struct aca_ecc_info bank_info;
+	u64 status, count;
+	int ext_error_code;
+
+	memset(&bank_info, 0, sizeof(bank_info));
+	aca_decode_bank_info(ras_blk, bank, &bank_info);
+	memcpy(&ecc->bank_info, &bank_info, sizeof(bank_info));
+	ecc->bank_info.status = bank->regs[ACA_REG_IDX__STATUS];
+	ecc->bank_info.ipid = bank->regs[ACA_REG_IDX__IPID];
+	ecc->bank_info.addr = bank->regs[ACA_REG_IDX__ADDR];
+
+	status = bank->regs[ACA_REG_IDX__STATUS];
+	ext_error_code = ACA_REG_STATUS_ERRORCODEEXT(status);
+
+	count = ACA_REG_MISC0_ERRCNT(bank->regs[ACA_REG_IDX__MISC0]);
+	if (bank->ecc_type == RAS_ERR_TYPE__UE) {
+		if (ext_error_code != 0 && ext_error_code != 9)
+			count = 0ULL;
+		ecc->ue_count = count;
+	} else if (bank->ecc_type == RAS_ERR_TYPE__CE) {
+		count = ext_error_code == 6 ? count : 0ULL;
+		ecc->ce_count = count;
+	}
+
+	return 0;
+}
+
+static const struct aca_block_info aca_v1_0_umc = {
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
+static const struct aca_block_info aca_v1_0_gfx = {
+	.name = "gfx",
+	.ras_block_id = RAS_BLOCK_ID__GFX,
+	.hwip = ACA_ECC_HWIP__SMU,
+	.mask = ACA_ERROR__UE_MASK | ACA_ERROR__CE_MASK,
+	.bank_ops = {
+		.bank_match = aca_match_gfx_bank,
+		.bank_parse = aca_parse_bank_default,
+	},
+};
+
+static const struct aca_block_info aca_v1_0_sdma = {
+	.name = "sdma",
+	.ras_block_id = RAS_BLOCK_ID__SDMA,
+	.hwip = ACA_ECC_HWIP__SMU,
+	.mask = ACA_ERROR__UE_MASK,
+	.bank_ops = {
+		.bank_match = aca_match_sdma_bank,
+		.bank_parse = aca_parse_bank_default,
+	},
+};
+
+static const struct aca_block_info aca_v1_0_mmhub = {
+	.name = "mmhub",
+	.ras_block_id = RAS_BLOCK_ID__MMHUB,
+	.hwip = ACA_ECC_HWIP__SMU,
+	.mask = ACA_ERROR__UE_MASK,
+	.bank_ops = {
+		.bank_match = aca_match_mmhub_bank,
+		.bank_parse = aca_parse_bank_default,
+	},
+};
+
+static const struct aca_block_info aca_v1_0_xgmi = {
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
+static const struct aca_block_info *aca_block_info_v1_0[] = {
+	&aca_v1_0_umc,
+	&aca_v1_0_gfx,
+	&aca_v1_0_sdma,
+	&aca_v1_0_mmhub,
+	&aca_v1_0_xgmi,
+};
+
+const struct ras_aca_ip_func ras_aca_func_v1_0 = {
+	.block_num = ARRAY_SIZE(aca_block_info_v1_0),
+	.block_info = aca_block_info_v1_0,
+};
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.h b/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.h
new file mode 100644
index 000000000000..40e5d94b037f
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.h
@@ -0,0 +1,71 @@
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
+ *
+ */
+
+#ifndef __RAS_ACA_V1_0_H__
+#define __RAS_ACA_V1_0_H__
+#include "ras.h"
+
+#define ACA__REG__FIELD(x, h, l)		  (((x) & GENMASK_ULL(h, l)) >> l)
+#define ACA_REG_STATUS_VAL(x)		    ACA__REG__FIELD(x, 63, 63)
+#define ACA_REG_STATUS_OVERFLOW(x)	    ACA__REG__FIELD(x, 62, 62)
+#define ACA_REG_STATUS_UC(x)		    ACA__REG__FIELD(x, 61, 61)
+#define ACA_REG_STATUS_EN(x)		    ACA__REG__FIELD(x, 60, 60)
+#define ACA_REG_STATUS_MISCV(x)		    ACA__REG__FIELD(x, 59, 59)
+#define ACA_REG_STATUS_ADDRV(x)		    ACA__REG__FIELD(x, 58, 58)
+#define ACA_REG_STATUS_PCC(x)		    ACA__REG__FIELD(x, 57, 57)
+#define ACA_REG_STATUS_ERRCOREIDVAL(x)  ACA__REG__FIELD(x, 56, 56)
+#define ACA_REG_STATUS_TCC(x)		    ACA__REG__FIELD(x, 55, 55)
+#define ACA_REG_STATUS_SYNDV(x)		    ACA__REG__FIELD(x, 53, 53)
+#define ACA_REG_STATUS_CECC(x)		    ACA__REG__FIELD(x, 46, 46)
+#define ACA_REG_STATUS_UECC(x)		    ACA__REG__FIELD(x, 45, 45)
+#define ACA_REG_STATUS_DEFERRED(x)	    ACA__REG__FIELD(x, 44, 44)
+#define ACA_REG_STATUS_POISON(x)	    ACA__REG__FIELD(x, 43, 43)
+#define ACA_REG_STATUS_SCRUB(x)		    ACA__REG__FIELD(x, 40, 40)
+#define ACA_REG_STATUS_ERRCOREID(x)	    ACA__REG__FIELD(x, 37, 32)
+#define ACA_REG_STATUS_ADDRLSB(x)	    ACA__REG__FIELD(x, 29, 24)
+#define ACA_REG_STATUS_ERRORCODEEXT(x)  ACA__REG__FIELD(x, 21, 16)
+#define ACA_REG_STATUS_ERRORCODE(x)	    ACA__REG__FIELD(x, 15, 0)
+
+#define ACA_REG_IPID_MCATYPE(x)		  ACA__REG__FIELD(x, 63, 48)
+#define ACA_REG_IPID_INSTANCEIDHI(x)  ACA__REG__FIELD(x, 47, 44)
+#define ACA_REG_IPID_HARDWAREID(x)	  ACA__REG__FIELD(x, 43, 32)
+#define ACA_REG_IPID_INSTANCEIDLO(x)  ACA__REG__FIELD(x, 31, 0)
+
+#define ACA_REG_MISC0_VALID(x)		  ACA__REG__FIELD(x, 63, 63)
+#define ACA_REG_MISC0_OVRFLW(x)		  ACA__REG__FIELD(x, 48, 48)
+#define ACA_REG_MISC0_ERRCNT(x)		  ACA__REG__FIELD(x, 43, 32)
+
+#define ACA_REG_SYND_ERRORINFORMATION(x)	ACA__REG__FIELD(x, 17, 0)
+
+/* NOTE: The following codes refers to the smu header file */
+#define ACA_EXTERROR_CODE_CE			0x3a
+#define ACA_EXTERROR_CODE_FAULT			0x3b
+
+#define mmSMNAID_XCD0_MCA_SMU 0x36430400	/* SMN AID XCD0 */
+#define mmSMNAID_XCD1_MCA_SMU 0x38430400	/* SMN AID XCD1 */
+#define mmSMNXCD_XCD0_MCA_SMU 0x40430400	/* SMN XCD XCD0 */
+#define mmSMNAID_AID0_MCA_SMU 0x03b30400	/* SMN AID AID0 */
+
+extern const struct ras_aca_ip_func ras_aca_func_v1_0;
+#endif
-- 
2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED151CAC5A8
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 01:33:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86C0110E5E1;
	Thu, 18 Sep 2025 01:33:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y3yawRf9";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010034.outbound.protection.outlook.com [52.101.85.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 343CA10E5E1
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 01:33:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jcXktXa7qqagME/rhodxBGhcTFchhMK2AUqVE9jxRu0KZXEK6ZQCfzEIE5mvm5Tq5iESHhBC1h/sV78qKSwocJ1ZC1lptB0CaC1M1TFQhQLp7Y0JrnJgX33+f59KykNgGvzPIvb1n2/nDK1ii2zWZo2DxDG3rcDQSosiM8mtyJQQFglTWq961XecUv7l1Xzp6k4hed2Tm8OpfLZyKQ/jHoCG5tL6KqXuZn2HsXLrgWapG6ZkSLiKbJK9E2GP/pQbmlWR01+b3NmtfuFLEzOjyqZrbeSHU8c2PKIumfql1K2P/OG1pyeykcWUmK/PpTz/vIboSTOEQzhruWnCnDdHgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGmYoVGt4E34rP1vzFaYuxYz2JqNvyzhBwzJKIyfgIU=;
 b=boHzqMFf4mQXuhX+P7FDOKkbzkNogF6fKV1rHp3i0SZJALBKpeQLRKyihdt8M1bKmdOd11ZR3kHLcaQiTdGRH6CDPNe4j8p0VMWMoANHtSKBFYcM2tGr1rFlNcYEr1smbpFyeOvuWTOurX6Kad+VN8Ba4qwgcu8Hdpzvb0AOv1Ty6IhfZcS2YmftcaJUxJTTpqttGMoF40cJKdrYnO+dUARBazpKpEQTuEUmrsYwzqnxsXAefO5DSJ5O7RNKNFoxdloMHeXcouCA7H3xUt7W1tv3Dx0mA4q4HvJ6jwDKFfL9b1IHJMI4t6LWLBh+aRdtj7hPGnxCDE31FkAaCd80Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGmYoVGt4E34rP1vzFaYuxYz2JqNvyzhBwzJKIyfgIU=;
 b=y3yawRf91+DttSFrcI8V3dom27msqo8rGIyT4aTXkzeqJhAJ4lSQuurJIE3odME+r43laS0RM3zDResndSp3ydE3+PODirGtWuTTBX9OXVRcD3NbYXmUcmadQR1CFGm8dJf/R9xdPb92fVPxROo5jrY6dh7IGqJJ+75iD08ajRk=
Received: from BYAPR07CA0089.namprd07.prod.outlook.com (2603:10b6:a03:12b::30)
 by PH0PR12MB8128.namprd12.prod.outlook.com (2603:10b6:510:294::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 01:33:15 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::fa) by BYAPR07CA0089.outlook.office365.com
 (2603:10b6:a03:12b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 01:33:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 01:33:13 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Sep
 2025 18:33:11 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou
 <tao.zhou1@amd.com>
Subject: [PATCH 04/21] drm/amd/ras: Add aca common ras functions
Date: Thu, 18 Sep 2025 09:32:15 +0800
Message-ID: <20250918013232.2629215-4-YiPeng.Chai@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|PH0PR12MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: e29ae1e8-ba15-4396-47b9-08ddf65355c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tRVw55GKRFbsIBNlh9YXdr7uZDq5Vrt8cHUxQ6pFMwGTTJTvtQ0VFt8kpAXB?=
 =?us-ascii?Q?yXXKzYsEgetIkfzAnBTjmQ6FQ04hiOu7LzSWuHNtjRSEaFe82zeSKygZDGri?=
 =?us-ascii?Q?jqsm5cmcVGgnzO+iq5OUhEwvJE3GnD2t2domulK+F1jEDHMG0S2UukqWlmBd?=
 =?us-ascii?Q?qBZZ9n57gsgmuborblzGbw5Bwgcii8z2f8G2v6OZH3EDqp0QTxhe4uEbrURw?=
 =?us-ascii?Q?h6aSkJe6WJMSq+L1bp2W9sUVgDlSNNQAGfIEGZhz8qnaVW3xxv05bWUsUHij?=
 =?us-ascii?Q?AJUNlz2k/KqMtVuzNis2uQpRv2MStrsZmy4IAwiVKvpaye1voE6qSiVBBzMl?=
 =?us-ascii?Q?ixLp/GjkrWjaXkQGUkszJVlDeGA7dLAqoiwY9HtcI4RsJRDWMDABKwh2AZgR?=
 =?us-ascii?Q?Fi7hAl1zU+JITl8Jvm3pxDb15uCeGQcbracJKpqP//B9zl4A3dR/TNug9eqi?=
 =?us-ascii?Q?bk6z+dej3iu5MGdH15AzPg43BLLd0iYvF8uoDawNYB1jsQ3TOgohqfRICjhr?=
 =?us-ascii?Q?tyivTNd50Chn69zwdjk1SVxaGNkRG52r2KkeuuC7LAY9RHwBKi7IXWF68O/n?=
 =?us-ascii?Q?D5y+1kvNKUvTr8eAj7/70Vj/0eKla7WUXBwObpISQZAlfYNjOgK+Y+sdGQxv?=
 =?us-ascii?Q?ZZ2NIKDeKgy0dIRSFHUUPm7ndnW9+aXo190LvJAVFvT9SvybICT+A9KRfE4T?=
 =?us-ascii?Q?2e0nR16yV3j4c1GQaj3S6jLj7ThPQjq+RQ8Fv8RgxLD5dTRc/qCw1CUywMIc?=
 =?us-ascii?Q?Gj24KyFgRLSRp0eMTrHmCorCa60L7YJyDMjKh1f5bRQTBJS9GV66XehqkAuP?=
 =?us-ascii?Q?97EzuhxqctTdZIzu29i5iloAN+568Vk5674tomt2G6gO7XUrtXZS0yULNqDp?=
 =?us-ascii?Q?Rj5lvAp2kMQyzc3CtrcazEW4gy+R70BLq/iwP9XpAMj1s64RfXgVSM/2CKxH?=
 =?us-ascii?Q?cRSBraqYmxvogGL85Msb+/LyM+mUJS3rIcPlGJMRSeqQdcbT4JfjT1CBSuOM?=
 =?us-ascii?Q?UU8hgFH78sl+Fo0o1mi2mWr3wxxDvmjhj7/BPTWg8vwhheARXMotBaBLtWGY?=
 =?us-ascii?Q?Si58PrFnUxhe9SDVzCg9tti9xLqr7B2abJhf1BOeswG9yhiQe+dS3z1Jbqrp?=
 =?us-ascii?Q?yVcxQEFxQB4DTmw7XLIpIOxkdBfH61YuwfVQfVj3rLlmzgjny19B1sTFsGvx?=
 =?us-ascii?Q?iR/DfHzbn0r8+YfT/ES47msqWsKJ3qS0Ex6I1o/tQc/rhAMExepw8dZjq7WT?=
 =?us-ascii?Q?snPlaXbscCwTMS7rHobkoCo76J6Er5Xz2TZHnbrgvRLYCMT3zgJI/XYPF0dM?=
 =?us-ascii?Q?Xw/xN39v9XTutQNxdfTp9GXOqeLVEesVTBIOTg5QCI7I15oxXm/07q0/9z1o?=
 =?us-ascii?Q?96Php7k87Rn3DJ5RaChZeGIz2QLo5xY6eD8sFpgUJihKmfSXRqSqGtAMZJHI?=
 =?us-ascii?Q?8UzSAKWWdCP06MaabJ0hrt9/iN1kAOuKtL7OUZ9M8ewOz9qIjp+bMsSnDLmt?=
 =?us-ascii?Q?np1DwTA0+sgNFOnnehdAd2tgabEJPX8YWXLq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 01:33:13.6985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e29ae1e8-ba15-4396-47b9-08ddf65355c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8128
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

Add aca common ras functions:
1. Aca hw init/fini.
2. Get ecc count of each ras block.
3. Update query ecc count from mp1.
4. Clear ras block ecc count.

V3:
  Update the calling function.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_aca.c | 661 ++++++++++++++++++++++
 drivers/gpu/drm/amd/ras/rascore/ras_aca.h | 168 ++++++
 2 files changed, 829 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/ras/rascore/ras_aca.c
 create mode 100644 drivers/gpu/drm/amd/ras/rascore/ras_aca.h

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_aca.c b/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
new file mode 100644
index 000000000000..1dfb1d8266e9
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
@@ -0,0 +1,661 @@
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
+#include "ras_aca_v1_0.h"
+#include "ras_mp1_v13_0.h"
+
+#define ACA_MARK_FATAL_FLAG    0x100
+#define ACA_MARK_UE_READ_FLAG  0x1
+
+#define blk_name(block_id) ras_core_get_ras_block_name(block_id)
+
+static struct aca_regs_dump {
+	const char *name;
+	int reg_idx;
+} aca_regs[] = {
+	{"CONTROL",		ACA_REG_IDX__CTL},
+	{"STATUS",		ACA_REG_IDX__STATUS},
+	{"ADDR",		ACA_REG_IDX__ADDR},
+	{"MISC",		ACA_REG_IDX__MISC0},
+	{"CONFIG",		ACA_REG_IDX__CONFG},
+	{"IPID",		ACA_REG_IDX__IPID},
+	{"SYND",		ACA_REG_IDX__SYND},
+	{"DESTAT",		ACA_REG_IDX__DESTAT},
+	{"DEADDR",		ACA_REG_IDX__DEADDR},
+	{"CONTROL_MASK",	ACA_REG_IDX__CTL_MASK},
+};
+
+
+static void aca_report_ecc_info(struct ras_core_context *ras_core,
+				u64 seq_no, u32 blk, u32 skt, u32 aid,
+				struct aca_aid_ecc *aid_ecc,
+				struct aca_bank_ecc *new_ecc)
+{
+	struct aca_ecc_count ecc_count = {0};
+
+	ecc_count.new_ue_count = new_ecc->ue_count;
+	ecc_count.new_de_count = new_ecc->de_count;
+	ecc_count.new_ce_count = new_ecc->ce_count;
+	if (blk == RAS_BLOCK_ID__GFX) {
+		struct aca_ecc_count *xcd_ecc;
+		int xcd_id;
+
+		for (xcd_id = 0; xcd_id < aid_ecc->xcd.xcd_num; xcd_id++) {
+			xcd_ecc = &aid_ecc->xcd.xcd[xcd_id].ecc_err;
+			ecc_count.total_ue_count += xcd_ecc->total_ue_count;
+			ecc_count.total_de_count += xcd_ecc->total_de_count;
+			ecc_count.total_ce_count += xcd_ecc->total_ce_count;
+		}
+	} else {
+		ecc_count.total_ue_count = aid_ecc->ecc_err.total_ue_count;
+		ecc_count.total_de_count = aid_ecc->ecc_err.total_de_count;
+		ecc_count.total_ce_count = aid_ecc->ecc_err.total_ce_count;
+	}
+
+	if (ecc_count.new_ue_count) {
+		RAS_DEV_INFO(ras_core->dev,
+		"{%llu} socket: %d, die: %d, %u new uncorrectable hardware errors detected in %s block\n",
+			seq_no, skt, aid, ecc_count.new_ue_count, blk_name(blk));
+		RAS_DEV_INFO(ras_core->dev,
+		"{%llu} socket: %d, die: %d, %u uncorrectable hardware errors detected in total in %s block\n",
+			seq_no, skt, aid, ecc_count.total_ue_count, blk_name(blk));
+	}
+
+	if (ecc_count.new_de_count) {
+		RAS_DEV_INFO(ras_core->dev,
+		"{%llu} socket: %d, die: %d, %u new %s detected in %s block\n",
+			seq_no, skt, aid, ecc_count.new_de_count,
+			(blk == RAS_BLOCK_ID__UMC) ?
+				"deferred hardware errors" : "poison consumption",
+			blk_name(blk));
+		RAS_DEV_INFO(ras_core->dev,
+		"{%llu} socket: %d, die: %d, %u %s detected in total in %s block\n",
+			seq_no, skt, aid, ecc_count.total_de_count,
+			(blk == RAS_BLOCK_ID__UMC) ?
+				"deferred hardware errors" : "poison consumption",
+			blk_name(blk));
+	}
+
+	if (ecc_count.new_ce_count) {
+		RAS_DEV_INFO(ras_core->dev,
+		"{%llu} socket: %d, die: %d, %u new correctable hardware errors detected in %s block\n",
+			seq_no, skt, aid, ecc_count.new_ce_count, blk_name(blk));
+		RAS_DEV_INFO(ras_core->dev,
+		"{%llu} socket: %d, die: %d, %u correctable hardware errors detected in total in %s block\n",
+			seq_no, skt, aid, ecc_count.total_ce_count, blk_name(blk));
+	}
+}
+
+static void aca_bank_log(struct ras_core_context *ras_core,
+			 int idx, int total, struct aca_bank_reg *bank,
+			 struct aca_bank_ecc *bank_ecc)
+{
+	int i;
+
+	RAS_DEV_INFO(ras_core->dev,
+		"{%llu}" RAS_HW_ERR "Accelerator Check Architecture events logged\n",
+		bank->seq_no);
+	/* plus 1 for output format, e.g: ACA[08/08]: xxxx */
+	for (i = 0; i < ARRAY_SIZE(aca_regs); i++)
+		RAS_DEV_INFO(ras_core->dev,
+			"{%llu}" RAS_HW_ERR "ACA[%02d/%02d].%s=0x%016llx\n",
+			bank->seq_no, idx + 1, total,
+			aca_regs[i].name, bank->regs[aca_regs[i].reg_idx]);
+}
+
+static void aca_log_bank_data(struct ras_core_context *ras_core,
+			struct aca_bank_reg *bank, struct aca_bank_ecc *bank_ecc,
+			struct ras_log_batch_tag *batch)
+{
+	if (bank_ecc->ue_count)
+		ras_log_ring_add_log_event(ras_core, RAS_LOG_EVENT_UE, bank->regs, batch);
+	else if (bank_ecc->de_count)
+		ras_log_ring_add_log_event(ras_core, RAS_LOG_EVENT_DE, bank->regs, batch);
+	else
+		ras_log_ring_add_log_event(ras_core, RAS_LOG_EVENT_CE, bank->regs, batch);
+}
+
+static int aca_get_bank_count(struct ras_core_context *ras_core,
+			      enum ras_err_type type, u32 *count)
+{
+	return ras_mp1_get_bank_count(ras_core, type, count);
+}
+
+static bool aca_match_bank(struct aca_block *aca_blk, struct aca_bank_reg *bank)
+{
+	const struct aca_bank_hw_ops *bank_ops;
+
+	if (!aca_blk->blk_info)
+		return false;
+
+	bank_ops = &aca_blk->blk_info->bank_ops;
+	if (!bank_ops->bank_match)
+		return false;
+
+	return bank_ops->bank_match(aca_blk, bank);
+}
+
+static int aca_parse_bank(struct ras_core_context *ras_core,
+			  struct aca_block *aca_blk,
+			  struct aca_bank_reg *bank,
+			  struct aca_bank_ecc *ecc)
+{
+	const struct aca_bank_hw_ops *bank_ops = &aca_blk->blk_info->bank_ops;
+
+	if (!bank_ops || !bank_ops->bank_parse)
+		return -RAS_CORE_NOT_SUPPORTED;
+
+	return bank_ops->bank_parse(ras_core, aca_blk, bank, ecc);
+}
+
+static int aca_check_block_ecc_info(struct ras_core_context *ras_core,
+			struct aca_block *aca_blk, struct aca_ecc_info *info)
+{
+	if (info->socket_id >= aca_blk->ecc.socket_num_per_hive) {
+		RAS_DEV_ERR(ras_core->dev,
+			"Socket id (%d) is out of config! max:%u\n",
+			info->socket_id, aca_blk->ecc.socket_num_per_hive);
+		return -ENODATA;
+	}
+
+	if (info->die_id >= aca_blk->ecc.socket[info->socket_id].aid_num) {
+		RAS_DEV_ERR(ras_core->dev,
+			"Die id (%d) is out of config! max:%u\n",
+			info->die_id, aca_blk->ecc.socket[info->socket_id].aid_num);
+		return -ENODATA;
+	}
+
+	if ((aca_blk->blk_info->ras_block_id == RAS_BLOCK_ID__GFX) &&
+	    (info->xcd_id >=
+		 aca_blk->ecc.socket[info->socket_id].aid[info->die_id].xcd.xcd_num)) {
+		RAS_DEV_ERR(ras_core->dev,
+			"Xcd id (%d) is out of config! max:%u\n",
+			info->xcd_id,
+			aca_blk->ecc.socket[info->socket_id].aid[info->die_id].xcd.xcd_num);
+		return -ENODATA;
+	}
+
+	return 0;
+}
+
+static int aca_log_bad_bank(struct ras_core_context *ras_core,
+				 struct aca_block *aca_blk, struct aca_bank_reg *bank,
+				 struct aca_bank_ecc *bank_ecc)
+{
+	struct aca_ecc_info *info;
+	struct aca_ecc_count *ecc_err;
+	struct aca_aid_ecc *aid_ecc;
+	int ret;
+
+	info = &bank_ecc->bank_info;
+
+	ret = aca_check_block_ecc_info(ras_core, aca_blk, info);
+	if (ret)
+		return ret;
+
+	mutex_lock(&ras_core->ras_aca.aca_lock);
+	aid_ecc = &aca_blk->ecc.socket[info->socket_id].aid[info->die_id];
+	if (aca_blk->blk_info->ras_block_id == RAS_BLOCK_ID__GFX)
+		ecc_err = &aid_ecc->xcd.xcd[info->xcd_id].ecc_err;
+	else
+		ecc_err = &aid_ecc->ecc_err;
+
+	ecc_err->new_ce_count += bank_ecc->ce_count;
+	ecc_err->total_ce_count += bank_ecc->ce_count;
+	ecc_err->new_ue_count += bank_ecc->ue_count;
+	ecc_err->total_ue_count += bank_ecc->ue_count;
+	ecc_err->new_de_count += bank_ecc->de_count;
+	ecc_err->total_de_count += bank_ecc->de_count;
+	mutex_unlock(&ras_core->ras_aca.aca_lock);
+
+	if ((aca_blk->blk_info->ras_block_id == RAS_BLOCK_ID__UMC) &&
+	    bank_ecc->de_count) {
+		struct ras_bank_ecc  ras_ecc = {0};
+
+		ras_ecc.nps = ras_core_get_curr_nps_mode(ras_core);
+		ras_ecc.addr = bank_ecc->bank_info.addr;
+		ras_ecc.ipid = bank_ecc->bank_info.ipid;
+		ras_ecc.status = bank_ecc->bank_info.status;
+		ras_ecc.seq_no = bank->seq_no;
+
+		if (ras_core_gpu_in_reset(ras_core))
+			ras_umc_log_bad_bank_pending(ras_core, &ras_ecc);
+		else
+			ras_umc_log_bad_bank(ras_core, &ras_ecc);
+	}
+
+	aca_report_ecc_info(ras_core,
+		bank->seq_no, aca_blk->blk_info->ras_block_id, info->socket_id, info->die_id,
+		&aca_blk->ecc.socket[info->socket_id].aid[info->die_id], bank_ecc);
+
+	return 0;
+}
+
+static struct aca_block *aca_get_bank_aca_block(struct ras_core_context *ras_core,
+				struct aca_bank_reg *bank)
+{
+	int i = 0;
+
+	for (i = 0; i < RAS_BLOCK_ID__LAST; i++)
+		if (aca_match_bank(&ras_core->ras_aca.aca_blk[i], bank))
+			return &ras_core->ras_aca.aca_blk[i];
+
+	return NULL;
+}
+
+static int aca_dump_bank(struct ras_core_context *ras_core, u32 ecc_type,
+			 int idx, void *data)
+{
+	struct aca_bank_reg *bank = (struct aca_bank_reg *)data;
+	int i, ret, reg_cnt;
+
+	reg_cnt = min_t(int, 16, ARRAY_SIZE(bank->regs));
+	for (i = 0; i < reg_cnt; i++) {
+		ret = ras_mp1_dump_bank(ras_core, ecc_type, idx, i, &bank->regs[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static uint64_t aca_get_bank_seqno(struct ras_core_context *ras_core,
+				enum ras_err_type err_type, struct aca_block *aca_blk,
+				struct aca_bank_ecc *bank_ecc)
+{
+	uint64_t seq_no = 0;
+
+	if (bank_ecc->de_count) {
+		if (aca_blk->blk_info->ras_block_id == RAS_BLOCK_ID__UMC)
+			seq_no = ras_core_get_seqno(ras_core, RAS_SEQNO_TYPE_DE, true);
+		else
+			seq_no = ras_core_get_seqno(ras_core,
+					RAS_SEQNO_TYPE_POISON_CONSUMPTION, true);
+	} else if (bank_ecc->ue_count) {
+		seq_no = ras_core_get_seqno(ras_core, RAS_SEQNO_TYPE_UE, true);
+	} else {
+		seq_no = ras_core_get_seqno(ras_core, RAS_SEQNO_TYPE_CE, true);
+	}
+
+	return seq_no;
+}
+
+static bool aca_dup_update_ue_in_fatal(struct ras_core_context *ras_core,
+				u32 ecc_type)
+{
+	struct ras_aca *aca = &ras_core->ras_aca;
+
+	if (ecc_type != RAS_ERR_TYPE__UE)
+		return false;
+
+	if (aca->ue_updated_mark & ACA_MARK_FATAL_FLAG) {
+		if (aca->ue_updated_mark & ACA_MARK_UE_READ_FLAG)
+			return true;
+
+		aca->ue_updated_mark |= ACA_MARK_UE_READ_FLAG;
+	}
+
+	return false;
+}
+
+void ras_aca_mark_fatal_flag(struct ras_core_context *ras_core)
+{
+	struct ras_aca *aca = &ras_core->ras_aca;
+
+	if (!aca)
+		return;
+
+	aca->ue_updated_mark |= ACA_MARK_FATAL_FLAG;
+}
+
+void ras_aca_clear_fatal_flag(struct ras_core_context *ras_core)
+{
+	struct ras_aca *aca = &ras_core->ras_aca;
+
+	if (!aca)
+		return;
+
+	if ((aca->ue_updated_mark & ACA_MARK_FATAL_FLAG) &&
+		(aca->ue_updated_mark & ACA_MARK_UE_READ_FLAG))
+		aca->ue_updated_mark = 0;
+}
+
+static int aca_banks_update(struct ras_core_context *ras_core,
+			u32 ecc_type, void *data)
+{
+	struct aca_bank_reg bank;
+	struct aca_block *aca_blk;
+	struct aca_bank_ecc bank_ecc;
+	struct ras_log_batch_tag *batch_tag = NULL;
+	u32 count = 0;
+	int ret;
+	int i;
+
+	mutex_lock(&ras_core->ras_aca.bank_op_lock);
+
+	if (aca_dup_update_ue_in_fatal(ras_core, ecc_type))
+		goto out;
+
+	ret = aca_get_bank_count(ras_core, ecc_type, &count);
+	if (ret)
+		goto out;
+
+	if (!count)
+		goto out;
+
+	batch_tag = ras_log_ring_create_batch_tag(ras_core);
+	for (i = 0; i < count; i++) {
+		memset(&bank, 0, sizeof(bank));
+		ret = aca_dump_bank(ras_core, ecc_type, i, &bank);
+		if (ret)
+			break;
+
+		bank.ecc_type = ecc_type;
+
+		memset(&bank_ecc, 0, sizeof(bank_ecc));
+		aca_blk = aca_get_bank_aca_block(ras_core, &bank);
+		if (aca_blk)
+			ret = aca_parse_bank(ras_core, aca_blk, &bank, &bank_ecc);
+
+		bank.seq_no = aca_get_bank_seqno(ras_core, ecc_type, aca_blk, &bank_ecc);
+
+		aca_log_bank_data(ras_core, &bank, &bank_ecc, batch_tag);
+		aca_bank_log(ras_core, i, count, &bank, &bank_ecc);
+
+		if (!ret && aca_blk)
+			ret = aca_log_bad_bank(ras_core, aca_blk, &bank, &bank_ecc);
+
+		if (ret)
+			break;
+	}
+	ras_log_ring_destroy_batch_tag(ras_core, batch_tag);
+
+out:
+	mutex_unlock(&ras_core->ras_aca.bank_op_lock);
+	return ret;
+}
+
+int ras_aca_update_ecc(struct ras_core_context *ras_core, u32 type, void *data)
+{
+	/* Update aca bank to aca source error_cache first */
+	return aca_banks_update(ras_core, type, data);
+}
+
+static struct aca_block *ras_aca_get_block_handle(struct ras_core_context *ras_core, uint32_t blk)
+{
+	return &ras_core->ras_aca.aca_blk[blk];
+}
+
+static int ras_aca_clear_block_ecc_count(struct ras_core_context *ras_core, u32 blk)
+{
+	struct aca_block *aca_blk;
+	struct aca_aid_ecc  *aid_ecc;
+	int skt, aid, xcd;
+
+	mutex_lock(&ras_core->ras_aca.aca_lock);
+	aca_blk = ras_aca_get_block_handle(ras_core, blk);
+	for_each_socket_aid_loop(aca_blk, skt, aid) {
+		aid_ecc = &aca_blk->ecc.socket[skt].aid[aid];
+		if (blk == RAS_BLOCK_ID__GFX) {
+			for (xcd = 0; xcd < aid_ecc->xcd.xcd_num; xcd++)
+				memset(&aid_ecc->xcd.xcd[xcd], 0, sizeof(struct aca_xcd_ecc));
+		} else {
+			memset(&aid_ecc->ecc_err, 0, sizeof(aid_ecc->ecc_err));
+		}
+	}
+	mutex_unlock(&ras_core->ras_aca.aca_lock);
+
+	return 0;
+}
+
+int ras_aca_clear_all_blocks_ecc_count(struct ras_core_context *ras_core)
+{
+	enum ras_block_id blk;
+	int ret;
+
+	for (blk = RAS_BLOCK_ID__UMC; blk < RAS_BLOCK_ID__LAST; blk++) {
+		ret = ras_aca_clear_block_ecc_count(ras_core, blk);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+int ras_aca_clear_block_new_ecc_count(struct ras_core_context *ras_core, u32 blk)
+{
+	struct aca_block *aca_blk;
+	int skt, aid, xcd;
+	struct aca_ecc_count *ecc_err;
+	struct aca_aid_ecc  *aid_ecc;
+
+	mutex_lock(&ras_core->ras_aca.aca_lock);
+	aca_blk = ras_aca_get_block_handle(ras_core, blk);
+	for_each_socket_aid_loop(aca_blk, skt, aid) {
+		aid_ecc = &aca_blk->ecc.socket[skt].aid[aid];
+		if (blk == RAS_BLOCK_ID__GFX) {
+			for (xcd = 0; xcd < aid_ecc->xcd.xcd_num; xcd++) {
+				ecc_err = &aid_ecc->xcd.xcd[xcd].ecc_err;
+				ecc_err->new_ce_count = 0;
+				ecc_err->new_ue_count = 0;
+				ecc_err->new_de_count = 0;
+			}
+		} else {
+			ecc_err = &aid_ecc->ecc_err;
+			ecc_err->new_ce_count = 0;
+			ecc_err->new_ue_count = 0;
+			ecc_err->new_de_count = 0;
+		}
+	}
+	mutex_unlock(&ras_core->ras_aca.aca_lock);
+
+	return 0;
+}
+
+static int ras_aca_get_block_each_aid_ecc_count(struct ras_core_context *ras_core,
+						u32 blk, u32 skt, u32 aid, u32 xcd,
+						struct aca_ecc_count *ecc_count)
+{
+	struct aca_block *aca_blk;
+	struct aca_ecc_count *ecc_err;
+
+	aca_blk = ras_aca_get_block_handle(ras_core, blk);
+	if (blk == RAS_BLOCK_ID__GFX)
+		ecc_err = &aca_blk->ecc.socket[skt].aid[aid].xcd.xcd[xcd].ecc_err;
+	else
+		ecc_err = &aca_blk->ecc.socket[skt].aid[aid].ecc_err;
+
+	ecc_count->new_ce_count = ecc_err->new_ce_count;
+	ecc_count->total_ce_count = ecc_err->total_ce_count;
+	ecc_count->new_ue_count = ecc_err->new_ue_count;
+	ecc_count->total_ue_count = ecc_err->total_ue_count;
+	ecc_count->new_de_count = ecc_err->new_de_count;
+	ecc_count->total_de_count = ecc_err->total_de_count;
+
+	return 0;
+}
+
+static inline void _add_ecc_count(struct aca_ecc_count *des, struct aca_ecc_count *src)
+{
+	des->new_ce_count += src->new_ce_count;
+	des->total_ce_count += src->total_ce_count;
+	des->new_ue_count += src->new_ue_count;
+	des->total_ue_count += src->total_ue_count;
+	des->new_de_count += src->new_de_count;
+	des->total_de_count += src->total_de_count;
+}
+
+static const struct ras_aca_ip_func *aca_get_ip_func(
+				struct ras_core_context *ras_core, uint32_t ip_version)
+{
+	switch (ip_version) {
+	case IP_VERSION(1, 0, 0):
+		return &ras_aca_func_v1_0;
+	default:
+		RAS_DEV_ERR(ras_core->dev,
+			"ACA ip version(0x%x) is not supported!\n", ip_version);
+		break;
+	}
+
+	return NULL;
+}
+
+int ras_aca_get_block_ecc_count(struct ras_core_context *ras_core,
+				u32 blk, void *data)
+{
+	struct ras_ecc_count *err_data = (struct ras_ecc_count *)data;
+	struct aca_block *aca_blk;
+	int skt, aid, xcd;
+	struct aca_ecc_count ecc_xcd;
+	struct aca_ecc_count ecc_aid;
+	struct aca_ecc_count ecc;
+
+	if (blk >= RAS_BLOCK_ID__LAST)
+		return -EINVAL;
+
+	if (!err_data)
+		return -EINVAL;
+
+	aca_blk = ras_aca_get_block_handle(ras_core, blk);
+	memset(&ecc, 0, sizeof(ecc));
+
+	mutex_lock(&ras_core->ras_aca.aca_lock);
+	if (blk == RAS_BLOCK_ID__GFX) {
+		for_each_socket_aid_loop(aca_blk, skt, aid) {
+			memset(&ecc_aid, 0, sizeof(ecc_aid));
+			for (xcd = 0; xcd < aca_blk->ecc.socket[skt].aid[aid].xcd.xcd_num; xcd++) {
+				memset(&ecc_xcd, 0, sizeof(ecc_xcd));
+				if (ras_aca_get_block_each_aid_ecc_count(ras_core,
+						blk, skt, aid, xcd, &ecc_xcd))
+					continue;
+				_add_ecc_count(&ecc_aid, &ecc_xcd);
+			}
+			_add_ecc_count(&ecc, &ecc_aid);
+		}
+	} else {
+		for_each_socket_aid_loop(aca_blk, skt, aid) {
+			memset(&ecc_aid, 0, sizeof(ecc_aid));
+			if (ras_aca_get_block_each_aid_ecc_count(ras_core,
+					blk, skt, aid, 0, &ecc_aid))
+				continue;
+			_add_ecc_count(&ecc, &ecc_aid);
+		}
+	}
+
+	err_data->new_ce_count = ecc.new_ce_count;
+	err_data->total_ce_count = ecc.total_ce_count;
+	err_data->new_ue_count = ecc.new_ue_count;
+	err_data->total_ue_count = ecc.total_ue_count;
+	err_data->new_de_count = ecc.new_de_count;
+	err_data->total_de_count = ecc.total_de_count;
+	mutex_unlock(&ras_core->ras_aca.aca_lock);
+
+	return 0;
+}
+
+int ras_aca_sw_init(struct ras_core_context *ras_core)
+{
+	struct ras_aca *ras_aca = &ras_core->ras_aca;
+	struct ras_aca_config *aca_cfg = &ras_core->config->aca_cfg;
+	struct aca_block *aca_blk;
+	uint32_t socket_num_per_hive;
+	uint32_t aid_num_per_socket;
+	uint32_t xcd_num_per_aid;
+	int blk, skt, aid;
+
+	socket_num_per_hive = aca_cfg->socket_num_per_hive;
+	aid_num_per_socket = aca_cfg->aid_num_per_socket;
+	xcd_num_per_aid = aca_cfg->xcd_num_per_aid;
+
+	if (!xcd_num_per_aid || !aid_num_per_socket ||
+		(socket_num_per_hive > MAX_SOCKET_NUM_PER_HIVE) ||
+	    (aid_num_per_socket > MAX_AID_NUM_PER_SOCKET) ||
+	    (xcd_num_per_aid > MAX_XCD_NUM_PER_AID)) {
+		RAS_DEV_ERR(ras_core->dev, "Invalid ACA system configuration: %d, %d, %d\n",
+			socket_num_per_hive, aid_num_per_socket, xcd_num_per_aid);
+		return -EINVAL;
+	}
+
+	memset(ras_aca, 0, sizeof(*ras_aca));
+
+	for (blk = 0; blk < RAS_BLOCK_ID__LAST; blk++) {
+		aca_blk = &ras_aca->aca_blk[blk];
+		aca_blk->ecc.socket_num_per_hive = socket_num_per_hive;
+		for (skt = 0; skt < aca_blk->ecc.socket_num_per_hive; skt++) {
+			aca_blk->ecc.socket[skt].aid_num = aid_num_per_socket;
+			if (blk == RAS_BLOCK_ID__GFX) {
+				for (aid = 0; aid < aca_blk->ecc.socket[skt].aid_num; aid++)
+					aca_blk->ecc.socket[skt].aid[aid].xcd.xcd_num =
+								xcd_num_per_aid;
+			}
+		}
+	}
+
+	mutex_init(&ras_aca->aca_lock);
+	mutex_init(&ras_aca->bank_op_lock);
+
+	return 0;
+}
+
+int ras_aca_sw_fini(struct ras_core_context *ras_core)
+{
+	struct ras_aca *ras_aca = &ras_core->ras_aca;
+
+	mutex_destroy(&ras_aca->aca_lock);
+	mutex_destroy(&ras_aca->bank_op_lock);
+
+	return 0;
+}
+
+int ras_aca_hw_init(struct ras_core_context *ras_core)
+{
+	struct ras_aca *ras_aca = &ras_core->ras_aca;
+	struct aca_block *aca_blk;
+	const struct ras_aca_ip_func *ip_func;
+	int i;
+
+	ras_aca->aca_ip_version = ras_core->config->aca_ip_version;
+	ip_func = aca_get_ip_func(ras_core, ras_aca->aca_ip_version);
+	if (!ip_func)
+		return -EINVAL;
+
+	for (i = 0; i < ip_func->block_num; i++) {
+		aca_blk = &ras_aca->aca_blk[ip_func->block_info[i]->ras_block_id];
+		aca_blk->blk_info = ip_func->block_info[i];
+	}
+
+	ras_aca->ue_updated_mark = 0;
+
+	return 0;
+}
+
+int ras_aca_hw_fini(struct ras_core_context *ras_core)
+{
+	struct ras_aca *ras_aca = &ras_core->ras_aca;
+
+	ras_aca->ue_updated_mark = 0;
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_aca.h b/drivers/gpu/drm/amd/ras/rascore/ras_aca.h
new file mode 100644
index 000000000000..ab9c6e700390
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_aca.h
@@ -0,0 +1,168 @@
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
+#ifndef __RAS_ACA_H__
+#define __RAS_ACA_H__
+#include "ras.h"
+
+#define MAX_SOCKET_NUM_PER_HIVE 8
+#define MAX_AID_NUM_PER_SOCKET 4
+#define MAX_XCD_NUM_PER_AID 2
+#define MAX_ACA_RAS_BLOCK  20
+
+#define ACA_ERROR__UE_MASK			(0x1 << RAS_ERR_TYPE__UE)
+#define ACA_ERROR__CE_MASK			(0x1 << RAS_ERR_TYPE__CE)
+#define ACA_ERROR__DE_MASK			(0x1 << RAS_ERR_TYPE__DE)
+
+#define for_each_socket_aid_loop(aca_blk, skt, aid)  \
+for ((skt) = 0; (skt) < ((aca_blk)->ecc.socket_num_per_hive); (skt)++) \
+	for ((aid) = 0; (aid) < ((aca_blk)->ecc.socket[(skt)].aid_num); (aid)++)
+
+enum ras_aca_reg_idx {
+	ACA_REG_IDX__CTL		= 0,
+	ACA_REG_IDX__STATUS		= 1,
+	ACA_REG_IDX__ADDR		= 2,
+	ACA_REG_IDX__MISC0		= 3,
+	ACA_REG_IDX__CONFG		= 4,
+	ACA_REG_IDX__IPID		= 5,
+	ACA_REG_IDX__SYND		= 6,
+	ACA_REG_IDX__DESTAT		= 8,
+	ACA_REG_IDX__DEADDR		= 9,
+	ACA_REG_IDX__CTL_MASK	= 10,
+	ACA_REG_MAX_COUNT		= 16,
+};
+
+struct ras_core_context;
+struct aca_block;
+
+struct aca_bank_reg {
+	u32 ecc_type;
+	u64 seq_no;
+	u64 regs[ACA_REG_MAX_COUNT];
+};
+
+enum aca_ecc_hwip {
+	ACA_ECC_HWIP__UNKNOWN = -1,
+	ACA_ECC_HWIP__PSP = 0,
+	ACA_ECC_HWIP__UMC,
+	ACA_ECC_HWIP__SMU,
+	ACA_ECC_HWIP__PCS_XGMI,
+	ACA_ECC_HWIP_COUNT,
+};
+
+struct aca_ecc_info {
+	int die_id;
+	int socket_id;
+	int xcd_id;
+	int hwid;
+	int mcatype;
+	uint64_t status;
+	uint64_t ipid;
+	uint64_t addr;
+};
+
+struct aca_bank_ecc {
+	struct aca_ecc_info bank_info;
+	u32 ce_count;
+	u32 ue_count;
+	u32 de_count;
+};
+
+struct aca_ecc_count {
+	u32 new_ce_count;
+	u32 total_ce_count;
+	u32 new_ue_count;
+	u32 total_ue_count;
+	u32 new_de_count;
+	u32 total_de_count;
+};
+
+struct aca_xcd_ecc {
+	struct aca_ecc_count ecc_err;
+};
+
+struct aca_aid_ecc {
+	union {
+		struct aca_xcd {
+			struct aca_xcd_ecc xcd[MAX_XCD_NUM_PER_AID];
+			u32 xcd_num;
+		} xcd;
+		struct aca_ecc_count ecc_err;
+	};
+};
+
+struct aca_socket_ecc {
+	struct aca_aid_ecc aid[MAX_AID_NUM_PER_SOCKET];
+	u32 aid_num;
+};
+
+struct aca_block_ecc {
+	struct aca_socket_ecc socket[MAX_SOCKET_NUM_PER_HIVE];
+	u32 socket_num_per_hive;
+};
+
+struct aca_bank_hw_ops {
+	bool (*bank_match)(struct aca_block *ras_blk, void *data);
+	int (*bank_parse)(struct ras_core_context *ras_core,
+			struct aca_block *aca_blk, void *data, void *buf);
+};
+
+struct aca_block_info {
+	char name[32];
+	u32 ras_block_id;
+	enum aca_ecc_hwip hwip;
+	struct aca_bank_hw_ops bank_ops;
+	u32 mask;
+};
+
+struct aca_block {
+	const struct aca_block_info  *blk_info;
+	struct aca_block_ecc ecc;
+};
+
+struct ras_aca_ip_func {
+	uint32_t block_num;
+	const struct aca_block_info **block_info;
+};
+
+struct ras_aca {
+	uint32_t aca_ip_version;
+	const struct ras_aca_ip_func *ip_func;
+	struct mutex  aca_lock;
+	struct mutex  bank_op_lock;
+	struct aca_block aca_blk[MAX_ACA_RAS_BLOCK];
+	uint32_t ue_updated_mark;
+};
+
+int ras_aca_sw_init(struct ras_core_context *ras_core);
+int ras_aca_sw_fini(struct ras_core_context *ras_core);
+int ras_aca_hw_init(struct ras_core_context *ras_core);
+int ras_aca_hw_fini(struct ras_core_context *ras_core);
+int ras_aca_get_block_ecc_count(struct ras_core_context *ras_core, u32 blk, void *data);
+int ras_aca_clear_block_new_ecc_count(struct ras_core_context *ras_core, u32 blk);
+int ras_aca_clear_all_blocks_ecc_count(struct ras_core_context *ras_core);
+int ras_aca_update_ecc(struct ras_core_context *ras_core, u32 ecc_type, void *data);
+void ras_aca_mark_fatal_flag(struct ras_core_context *ras_core);
+void ras_aca_clear_fatal_flag(struct ras_core_context *ras_core);
+#endif
-- 
2.34.1


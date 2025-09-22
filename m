Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 424DECAC5AA
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Sep 2025 02:40:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D388710E389;
	Mon, 22 Sep 2025 02:40:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VsQ8j1gi";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012036.outbound.protection.outlook.com [52.101.53.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D73F10E389
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Sep 2025 02:40:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iDvHkZiL3qqLtOXyd0mG9ORwP4N3lm1734SrvGKKvXFyoAzqOJFuh6QrxK6m6p0Bc1McckZ9M2RwNijGoct7DJ19Wjg04/z11f3JGoPWcN6EAs3whnUen1dXkg0AsuILinRyxSBsU3d2c6I4Gq11GndF6oxKlJB2ZIhfHsGEuhqOTXxljs1P222OdTwqXmM7WGPRSqn6z+U0VhXdZfnrChT152K0yCiV0c3v3trGCKX3XfK+INSjZyYLZlPzFjqImulzqhOqEPt4jRAwuCT+paY+8BcpuLOXmlCe8eNSZE4HyMVDIAzPvmh88oKe1UXhLMeY8mQVGF78GOkq5fw4XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QH6R5UPZX6DkVHs3W6vywvOS+zqZ4mxsO1scZfuosh8=;
 b=EKfhXxffQF5Hu7aAuGi3Xln/SuxKyDXxAsnJHKqmVFstTlUafsppyiAfb4fY3MH1p6AYwO3vl3+6mjxqqQX68f0fsivKD5uCf8N8EFiFJ+3IClZlFAvxAHzdeAuJHEBiuqpIN8WzL6BzsD/GnV3l/WblFXDi03Gdk5emg2w2XF+A29D+K6F7CxsHtuCwaxsuAPw141ttdH8FKaiLQwMQAe7N+Xw7yWk+YcKPfPv9/WuSr0S3ImXvvOfmQONo0Sc+/arnKTC4F9jKrUwwPDhZnwF0UUfcMiBEmCKFgmD6pCn52ynIpkkGFile+BnNJlnsv0YLBY/x23a3Bmnz9vcX3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QH6R5UPZX6DkVHs3W6vywvOS+zqZ4mxsO1scZfuosh8=;
 b=VsQ8j1girRw49MCvXj8xfcoyilZBPX2V1GF15ZcIKEjXsaGU7fy3fEnxdfH6fumQ3tQyoIkwajjWAAVx16ObG6O6CXNLDqDubEQGH4cN2QNmxXSVRmyyIjf1ZkFzRzuAaZ6LPnWE7w3ZTKYu7wTJN4ffE8HTYLEqDVyM/leuLlo=
Received: from BYAPR01CA0062.prod.exchangelabs.com (2603:10b6:a03:94::39) by
 SJ2PR12MB9237.namprd12.prod.outlook.com (2603:10b6:a03:554::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.19; Mon, 22 Sep 2025 02:39:54 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:a03:94:cafe::5b) by BYAPR01CA0062.outlook.office365.com
 (2603:10b6:a03:94::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Mon,
 22 Sep 2025 02:38:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.0 via Frontend Transport; Mon, 22 Sep 2025 02:39:54 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 21 Sep
 2025 19:39:51 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou
 <tao.zhou1@amd.com>
Subject: [PATCH V5 15/20] drm/amd/ras: Add ras ioctl command handler
Date: Mon, 22 Sep 2025 10:38:39 +0800
Message-ID: <20250922023844.3108065-15-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250922023844.3108065-1-YiPeng.Chai@amd.com>
References: <20250922023844.3108065-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|SJ2PR12MB9237:EE_
X-MS-Office365-Filtering-Correlation-Id: beca115e-83c4-401e-662d-08ddf981500c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TQXFQRz2nmT5TNrn2cGwmRWkK8DzmA3FA1vYsH7IkgpNkv0GjH/I5uYOtjIW?=
 =?us-ascii?Q?RAjQbkmw/gGEFg2Rb9uE4kv2SaNGiVjh/APvAePpM+pK0OCy9ThGhrRUp/2c?=
 =?us-ascii?Q?bXEju/K+uYB0JUKVorJSBvCo1vNFZ3H2B1pDaBWadZFdA2AHAGIQbngYn3zc?=
 =?us-ascii?Q?nrELlNgMJb739uUYFEPnd2qjPVIRDdK465bbt+8ia/QO1gwbnE9dFoXB3s5B?=
 =?us-ascii?Q?eSFQLMvaKSHyjJzB0jPTSYr1T69iRmkFO3XLxGZvZhmMlL+EfPb+82mIFqNB?=
 =?us-ascii?Q?VTBcZmT2DHQ76dk6HAnRviCsJO2zLjxOuTX8i9Fznqpi78sUnh3pIsN1YF6z?=
 =?us-ascii?Q?dgvnqhi52SHzDWr6trkyG5eLkXuXFzsZimbFN8Pwy724/C/TJxneeGSJKVmj?=
 =?us-ascii?Q?ByD0Xr8gzs2lixMoxsqZo+HSus5qgtYVbBAwET7Dm44YW+sg6bLqPKiQFhfy?=
 =?us-ascii?Q?0M7HpnzHTONizdgd3j5QfMo7TlYxmQiMnmmmCn+aj3df2MOAvD4cM1cJgAU5?=
 =?us-ascii?Q?CLTN0PqzmuvSUCBi3SHoTvQOsrU2Al7pdkY1Q+sjaR3fj1laWvB2WX1RZjhj?=
 =?us-ascii?Q?u468P7qPn5Flo+dSjVxwlZQMoN8jz7MjBM40Q03Nb2HgNv0TMhIcWo9Tf1rx?=
 =?us-ascii?Q?1RMv7Eua3Slyf4LwFXi3wZQHhXpJWZb7wuDTEyA+jXylUy7iu8ybewb/LVIP?=
 =?us-ascii?Q?xcroHio+qV8XsPdGwxUtJHk6yefiTOgMcO1frgX4Hmdx1RZ45fn7bVq6zUgR?=
 =?us-ascii?Q?IYwOoxbIdPpEV0FXw3JEEjTJmXf1heccNbk05H7XdqXd7e+pHFkMgvIwyKwX?=
 =?us-ascii?Q?h5oONU9qODmTZwpC5aBJ9iY8OuQh4op8y2hRz8C/K4i3JieHdLcnfv7eGm4+?=
 =?us-ascii?Q?YLuYZjioRWEiqX7Y6JwPc0p2wGSQp9tn21SRT9Hy4UV3nFbrPkAUztpEn7zm?=
 =?us-ascii?Q?rfmsHiLMGMo91da4kFGzXBi47of9ZEmIW63RPW3iq1Y6hfwamrK+gzX+Ok/C?=
 =?us-ascii?Q?dUO9DLU6Ptjl+ssKnGn7bK8fiWxAH7/If8Zj5XsexCKTHjr25m4NrpjDy7Pi?=
 =?us-ascii?Q?OXWViIiDHGm7zLeD376oB3PHlLUdz+sC2w2FfW4f6GrbVM97RqnIBOnR3xdT?=
 =?us-ascii?Q?Pj3HZcohW1WX55ZCZxuPQxRoIcVVjO2L142A9+3UgQ9hiTkWP/D7omtak9SH?=
 =?us-ascii?Q?kO+wgGt5LsP0smw06tAn8YDp39peWdAaVSIXVcL1EsXuY04QQ8m22CAJq5qF?=
 =?us-ascii?Q?5IP0/x0yPpMd9D6Zu8TFqLk2l69jDoqQ7Injv9npKb2GCLNQ8ix9NvUVGH8B?=
 =?us-ascii?Q?xI7K9tvWhD4TAJom6ntUdn1qOmQiPJ6+uTRnfnZs2Usl942E0ztU2Ux+Datf?=
 =?us-ascii?Q?nmXjfZPZICn4XEJPmDpqM7EYzYn78dWfnAkz3I14ZghZdf2sWCFOXsIlMRSL?=
 =?us-ascii?Q?ch2puGdGEOcmUf9ueuXPN+1x2BzwkGdTZFd0I95kR8ED2vMbskeOCDwmsP6s?=
 =?us-ascii?Q?+zrCE0ei0oC9xv5LmWuFRfEjE4O3DHumJAO1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 02:39:54.4224 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: beca115e-83c4-401e-662d-08ddf981500c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9237
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

Add ras ioctl command handler.

V2:
  Remove ras global device list.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_cmd.c | 527 ++++++++++++++++++++++
 drivers/gpu/drm/amd/ras/rascore/ras_cmd.h | 425 +++++++++++++++++
 2 files changed, 952 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/ras/rascore/ras_cmd.c
 create mode 100644 drivers/gpu/drm/amd/ras/rascore/ras_cmd.h

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c
new file mode 100644
index 000000000000..697619b30ea2
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c
@@ -0,0 +1,527 @@
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
+#include "ras_cmd.h"
+
+#define RAS_CMD_MAJOR_VERSION 6
+#define RAS_CMD_MINOR_VERSION 0
+#define RAS_CMD_VERSION  (((RAS_CMD_MAJOR_VERSION) << 10) | (RAS_CMD_MINOR_VERSION))
+
+static int ras_cmd_add_device(struct ras_core_context *ras_core)
+{
+	INIT_LIST_HEAD(&ras_core->ras_cmd.head);
+	ras_core->ras_cmd.ras_core = ras_core;
+	ras_core->ras_cmd.dev_handle = (uint64_t)ras_core ^ RAS_CMD_DEV_HANDLE_MAGIC;
+	return 0;
+}
+
+static int ras_cmd_remove_device(struct ras_core_context *ras_core)
+{
+	memset(&ras_core->ras_cmd, 0, sizeof(ras_core->ras_cmd));
+	return 0;
+}
+
+static int ras_get_block_ecc_info(struct ras_core_context *ras_core,
+				struct ras_cmd_ioctl *cmd, void *data)
+{
+	struct ras_cmd_block_ecc_info_req *input_data =
+			(struct ras_cmd_block_ecc_info_req *)cmd->input_buff_raw;
+	struct ras_cmd_block_ecc_info_rsp *output_data =
+			(struct ras_cmd_block_ecc_info_rsp *)cmd->output_buff_raw;
+	struct ras_ecc_count err_data;
+	int ret;
+
+	if (cmd->input_size != sizeof(struct ras_cmd_block_ecc_info_req))
+		return RAS_CMD__ERROR_INVALID_INPUT_SIZE;
+
+	memset(&err_data, 0, sizeof(err_data));
+	ret = ras_aca_get_block_ecc_count(ras_core, input_data->block_id, &err_data);
+	if (ret)
+		return RAS_CMD__ERROR_GENERIC;
+
+	output_data->ce_count = err_data.total_ce_count;
+	output_data->ue_count = err_data.total_ue_count;
+	output_data->de_count = err_data.total_de_count;
+
+	cmd->output_size = sizeof(struct ras_cmd_block_ecc_info_rsp);
+	return RAS_CMD__SUCCESS;
+}
+
+static void ras_cmd_update_bad_page_info(struct ras_cmd_bad_page_record *ras_cmd_record,
+	struct eeprom_umc_record *record)
+{
+	ras_cmd_record->retired_page = record->cur_nps_retired_row_pfn;
+	ras_cmd_record->ts = record->ts;
+	ras_cmd_record->err_type = record->err_type;
+	ras_cmd_record->mem_channel = record->mem_channel;
+	ras_cmd_record->mcumc_id = record->mcumc_id;
+	ras_cmd_record->address = record->address;
+	ras_cmd_record->bank = record->bank;
+	ras_cmd_record->valid = 1;
+}
+
+static int ras_cmd_get_group_bad_pages(struct ras_core_context *ras_core,
+	uint32_t group_index, struct ras_cmd_bad_pages_info_rsp *output_data)
+{
+	struct eeprom_umc_record record;
+	struct ras_cmd_bad_page_record *ras_cmd_record;
+	uint32_t i = 0, bp_cnt = 0, group_cnt = 0;
+
+	output_data->bp_in_group = 0;
+	output_data->group_index = 0;
+
+	bp_cnt = ras_umc_get_badpage_count(ras_core);
+	if (bp_cnt) {
+		output_data->group_index = group_index;
+		group_cnt = bp_cnt / RAS_CMD_MAX_BAD_PAGES_PER_GROUP
+			+ ((bp_cnt % RAS_CMD_MAX_BAD_PAGES_PER_GROUP) ? 1 : 0);
+
+		if (group_index >= group_cnt)
+			return RAS_CMD__ERROR_INVALID_INPUT_DATA;
+
+		i = group_index * RAS_CMD_MAX_BAD_PAGES_PER_GROUP;
+		for (;
+		   i < bp_cnt && output_data->bp_in_group < RAS_CMD_MAX_BAD_PAGES_PER_GROUP;
+		   i++) {
+			if (ras_umc_get_badpage_record(ras_core, i, &record))
+				return RAS_CMD__ERROR_GENERIC;
+
+			ras_cmd_record = &output_data->records[i % RAS_CMD_MAX_BAD_PAGES_PER_GROUP];
+
+			memset(ras_cmd_record, 0, sizeof(*ras_cmd_record));
+			ras_cmd_update_bad_page_info(ras_cmd_record, &record);
+			output_data->bp_in_group++;
+		}
+	}
+	output_data->bp_total_cnt = bp_cnt;
+	return RAS_CMD__SUCCESS;
+}
+
+static int ras_cmd_get_bad_pages(struct ras_core_context *ras_core,
+				struct ras_cmd_ioctl *cmd, void *data)
+{
+	struct ras_cmd_bad_pages_info_req *input_data =
+			(struct ras_cmd_bad_pages_info_req *)cmd->input_buff_raw;
+	struct ras_cmd_bad_pages_info_rsp *output_data =
+			(struct ras_cmd_bad_pages_info_rsp *)cmd->output_buff_raw;
+	int ret;
+
+	if (cmd->input_size != sizeof(struct ras_cmd_bad_pages_info_req))
+		return RAS_CMD__ERROR_INVALID_INPUT_SIZE;
+
+	ret = ras_cmd_get_group_bad_pages(ras_core, input_data->group_index, output_data);
+	if (ret)
+		return RAS_CMD__ERROR_GENERIC;
+
+	output_data->version = 0;
+
+	cmd->output_size = sizeof(struct ras_cmd_bad_pages_info_rsp);
+	return RAS_CMD__SUCCESS;
+}
+
+static int ras_cmd_clear_bad_page_info(struct ras_core_context *ras_core,
+				struct ras_cmd_ioctl *cmd, void *data)
+{
+	if (cmd->input_size != sizeof(struct ras_cmd_dev_handle))
+		return RAS_CMD__ERROR_INVALID_INPUT_SIZE;
+
+	if (ras_eeprom_reset_table(ras_core))
+		return RAS_CMD__ERROR_GENERIC;
+
+	if (ras_umc_clean_badpage_data(ras_core))
+		return RAS_CMD__ERROR_GENERIC;
+
+	return RAS_CMD__SUCCESS;
+}
+
+static int ras_cmd_reset_all_error_counts(struct ras_core_context *ras_core,
+				struct ras_cmd_ioctl *cmd, void *data)
+{
+	if (cmd->input_size != sizeof(struct ras_cmd_dev_handle))
+		return RAS_CMD__ERROR_INVALID_INPUT_SIZE;
+
+	if (ras_aca_clear_all_blocks_ecc_count(ras_core))
+		return RAS_CMD__ERROR_GENERIC;
+
+	if (ras_umc_clear_logged_ecc(ras_core))
+		return RAS_CMD__ERROR_GENERIC;
+
+	return RAS_CMD__SUCCESS;
+}
+
+static int ras_cmd_get_cper_snapshot(struct ras_core_context *ras_core,
+			struct ras_cmd_ioctl *cmd, void *data)
+{
+	struct ras_cmd_cper_snapshot_rsp *output_data =
+			(struct ras_cmd_cper_snapshot_rsp *)cmd->output_buff_raw;
+	struct ras_log_batch_overview overview;
+
+	if (cmd->input_size != sizeof(struct ras_cmd_cper_snapshot_req))
+		return RAS_CMD__ERROR_INVALID_INPUT_SIZE;
+
+	ras_log_ring_get_batch_overview(ras_core, &overview);
+
+	output_data->total_cper_num = overview.logged_batch_count;
+	output_data->start_cper_id = overview.first_batch_id;
+	output_data->latest_cper_id = overview.last_batch_id;
+
+	output_data->version = 0;
+
+	cmd->output_size = sizeof(struct ras_cmd_cper_snapshot_rsp);
+	return RAS_CMD__SUCCESS;
+}
+
+static int ras_cmd_get_cper_records(struct ras_core_context *ras_core,
+			struct ras_cmd_ioctl *cmd, void *data)
+{
+	struct ras_cmd_cper_record_req *req =
+			(struct ras_cmd_cper_record_req *)cmd->input_buff_raw;
+	struct ras_cmd_cper_record_rsp *rsp =
+			(struct ras_cmd_cper_record_rsp *)cmd->output_buff_raw;
+	struct ras_log_info *trace[MAX_RECORD_PER_BATCH] = {0};
+	struct ras_log_batch_overview overview;
+	uint32_t offset = 0, real_data_len = 0;
+	uint64_t batch_id;
+	uint8_t *buffer;
+	int ret = 0, i, count;
+
+	if (cmd->input_size != sizeof(struct ras_cmd_cper_record_req))
+		return RAS_CMD__ERROR_INVALID_INPUT_SIZE;
+
+	if (!req->buf_size || !req->buf_ptr || !req->cper_num)
+		return RAS_CMD__ERROR_INVALID_INPUT_DATA;
+
+	if (!access_ok((void *)req->buf_ptr, req->buf_size)) {
+		RAS_DEV_ERR(ras_core->dev, "Invalid cper buffer memory!\n");
+		return RAS_CMD__ERROR_INVALID_INPUT_DATA;
+	}
+
+	buffer = kzalloc(req->buf_size, GFP_KERNEL);
+	if (!buffer)
+		return RAS_CMD__ERROR_GENERIC;
+
+	ras_log_ring_get_batch_overview(ras_core, &overview);
+	for (i = 0; i < req->cper_num; i++) {
+		batch_id = req->cper_start_id + i;
+		if (batch_id >= overview.last_batch_id)
+			break;
+
+		count = ras_log_ring_get_batch_records(ras_core, batch_id, trace,
+					ARRAY_SIZE(trace));
+		if (count > 0) {
+			ret = ras_cper_generate_cper(ras_core, trace, count,
+					&buffer[offset], req->buf_size - offset, &real_data_len);
+			if (ret)
+				break;
+
+			offset += real_data_len;
+		}
+	}
+
+	if ((ret && (ret != -ENOMEM)) ||
+		copy_to_user((void *)req->buf_ptr, buffer, offset)) {
+		kfree(buffer);
+		return RAS_CMD__ERROR_GENERIC;
+	}
+
+	rsp->real_data_size = offset;
+	rsp->real_cper_num = i;
+	rsp->remain_num = (ret == -ENOMEM) ? (req->cper_num - i) : 0;
+	rsp->version = 0;
+
+	cmd->output_size = sizeof(struct ras_cmd_cper_record_rsp);
+
+	kfree(buffer);
+
+	return RAS_CMD__SUCCESS;
+}
+
+static int ras_cmd_get_batch_trace_snapshot(struct ras_core_context *ras_core,
+	struct ras_cmd_ioctl *cmd, void *data)
+{
+	struct ras_cmd_batch_trace_snapshot_rsp *rsp =
+			(struct ras_cmd_batch_trace_snapshot_rsp *)cmd->output_buff_raw;
+	struct ras_log_batch_overview overview;
+
+
+	if (cmd->input_size != sizeof(struct ras_cmd_batch_trace_snapshot_req))
+		return RAS_CMD__ERROR_INVALID_INPUT_SIZE;
+
+	ras_log_ring_get_batch_overview(ras_core, &overview);
+
+	rsp->total_batch_num = overview.logged_batch_count;
+	rsp->start_batch_id = overview.first_batch_id;
+	rsp->latest_batch_id = overview.last_batch_id;
+	rsp->version = 0;
+
+	cmd->output_size = sizeof(struct ras_cmd_batch_trace_snapshot_rsp);
+	return RAS_CMD__SUCCESS;
+}
+
+static int ras_cmd_get_batch_trace_records(struct ras_core_context *ras_core,
+	struct ras_cmd_ioctl *cmd, void *data)
+{
+	struct ras_cmd_batch_trace_record_req *input_data =
+			(struct ras_cmd_batch_trace_record_req *)cmd->input_buff_raw;
+	struct ras_cmd_batch_trace_record_rsp *output_data =
+			(struct ras_cmd_batch_trace_record_rsp *)cmd->output_buff_raw;
+	struct ras_log_batch_overview overview;
+	struct ras_log_info *trace_arry[MAX_RECORD_PER_BATCH] = {0};
+	struct ras_log_info *record;
+	int i, j, count = 0, offset = 0;
+	uint64_t id;
+	bool completed = false;
+
+	if (cmd->input_size != sizeof(struct ras_cmd_batch_trace_record_req))
+		return RAS_CMD__ERROR_INVALID_INPUT_SIZE;
+
+	if ((!input_data->batch_num) || (input_data->batch_num > RAS_CMD_MAX_BATCH_NUM))
+		return RAS_CMD__ERROR_INVALID_INPUT_DATA;
+
+	ras_log_ring_get_batch_overview(ras_core, &overview);
+	if ((input_data->start_batch_id < overview.first_batch_id) ||
+	    (input_data->start_batch_id >= overview.last_batch_id))
+		return RAS_CMD__ERROR_INVALID_INPUT_SIZE;
+
+	for (i = 0; i < input_data->batch_num; i++) {
+		id = input_data->start_batch_id + i;
+		if (id >= overview.last_batch_id) {
+			completed = true;
+			break;
+		}
+
+		count = ras_log_ring_get_batch_records(ras_core,
+					id, trace_arry, ARRAY_SIZE(trace_arry));
+		if (count > 0) {
+			if ((offset + count) > RAS_CMD_MAX_TRACE_NUM)
+				break;
+			for (j = 0; j < count; j++) {
+				record = &output_data->records[offset + j];
+				record->seqno = trace_arry[j]->seqno;
+				record->timestamp = trace_arry[j]->timestamp;
+				record->event = trace_arry[j]->event;
+				memcpy(&record->aca_reg,
+					&trace_arry[j]->aca_reg, sizeof(trace_arry[j]->aca_reg));
+			}
+		} else {
+			count = 0;
+		}
+
+		output_data->batchs[i].batch_id = id;
+		output_data->batchs[i].offset = offset;
+		output_data->batchs[i].trace_num = count;
+		offset += count;
+	}
+
+	output_data->start_batch_id = input_data->start_batch_id;
+	output_data->real_batch_num = i;
+	output_data->remain_num = completed ? 0 : (input_data->batch_num - i);
+	output_data->version = 0;
+
+	cmd->output_size = sizeof(struct ras_cmd_batch_trace_record_rsp);
+
+	return RAS_CMD__SUCCESS;
+}
+
+static enum ras_ta_block __get_ras_ta_block(enum ras_block_id block)
+{
+	switch (block) {
+	case RAS_BLOCK_ID__UMC:
+		return RAS_TA_BLOCK__UMC;
+	case RAS_BLOCK_ID__SDMA:
+		return RAS_TA_BLOCK__SDMA;
+	case RAS_BLOCK_ID__GFX:
+		return RAS_TA_BLOCK__GFX;
+	case RAS_BLOCK_ID__MMHUB:
+		return RAS_TA_BLOCK__MMHUB;
+	case RAS_BLOCK_ID__ATHUB:
+		return RAS_TA_BLOCK__ATHUB;
+	case RAS_BLOCK_ID__PCIE_BIF:
+		return RAS_TA_BLOCK__PCIE_BIF;
+	case RAS_BLOCK_ID__HDP:
+		return RAS_TA_BLOCK__HDP;
+	case RAS_BLOCK_ID__XGMI_WAFL:
+		return RAS_TA_BLOCK__XGMI_WAFL;
+	case RAS_BLOCK_ID__DF:
+		return RAS_TA_BLOCK__DF;
+	case RAS_BLOCK_ID__SMN:
+		return RAS_TA_BLOCK__SMN;
+	case RAS_BLOCK_ID__SEM:
+		return RAS_TA_BLOCK__SEM;
+	case RAS_BLOCK_ID__MP0:
+		return RAS_TA_BLOCK__MP0;
+	case RAS_BLOCK_ID__MP1:
+		return RAS_TA_BLOCK__MP1;
+	case RAS_BLOCK_ID__FUSE:
+		return RAS_TA_BLOCK__FUSE;
+	case RAS_BLOCK_ID__MCA:
+		return RAS_TA_BLOCK__MCA;
+	case RAS_BLOCK_ID__VCN:
+		return RAS_TA_BLOCK__VCN;
+	case RAS_BLOCK_ID__JPEG:
+		return RAS_TA_BLOCK__JPEG;
+	default:
+		return RAS_TA_BLOCK__UMC;
+	}
+}
+
+static enum ras_ta_error_type __get_ras_ta_err_type(enum ras_ecc_err_type error)
+{
+	switch (error) {
+	case RAS_ECC_ERR__NONE:
+		return RAS_TA_ERROR__NONE;
+	case RAS_ECC_ERR__PARITY:
+		return RAS_TA_ERROR__PARITY;
+	case RAS_ECC_ERR__SINGLE_CORRECTABLE:
+		return RAS_TA_ERROR__SINGLE_CORRECTABLE;
+	case RAS_ECC_ERR__MULTI_UNCORRECTABLE:
+		return RAS_TA_ERROR__MULTI_UNCORRECTABLE;
+	case RAS_ECC_ERR__POISON:
+		return RAS_TA_ERROR__POISON;
+	default:
+		return RAS_TA_ERROR__NONE;
+	}
+}
+
+static int ras_cmd_inject_error(struct ras_core_context *ras_core,
+			struct ras_cmd_ioctl *cmd, void *data)
+{
+	struct ras_cmd_inject_error_req *req =
+		(struct ras_cmd_inject_error_req *)cmd->input_buff_raw;
+	struct ras_cmd_inject_error_rsp *output_data =
+		(struct ras_cmd_inject_error_rsp *)cmd->output_buff_raw;
+	int ret = 0;
+	struct ras_ta_trigger_error_input block_info = {
+		.block_id = __get_ras_ta_block(req->block_id),
+		.sub_block_index = req->subblock_id,
+		.inject_error_type = __get_ras_ta_err_type(req->error_type),
+		.address = req->address,
+		.value = req->method,
+	};
+
+	ret = ras_psp_trigger_error(ras_core, &block_info, req->instance_mask);
+	if (!ret) {
+		output_data->version = 0;
+		output_data->address = block_info.address;
+		cmd->output_size = sizeof(struct ras_cmd_inject_error_rsp);
+	} else {
+		RAS_DEV_ERR(ras_core->dev, "ras inject block %u failed %d\n", req->block_id, ret);
+		ret = RAS_CMD__ERROR_ACCESS_DENIED;
+	}
+
+	return ret;
+}
+
+static struct ras_cmd_func_map ras_cmd_maps[] = {
+	{RAS_CMD__INJECT_ERROR, ras_cmd_inject_error},
+	{RAS_CMD__GET_BLOCK_ECC_STATUS, ras_get_block_ecc_info},
+	{RAS_CMD__GET_BAD_PAGES, ras_cmd_get_bad_pages},
+	{RAS_CMD__CLEAR_BAD_PAGE_INFO, ras_cmd_clear_bad_page_info},
+	{RAS_CMD__RESET_ALL_ERROR_COUNTS, ras_cmd_reset_all_error_counts},
+	{RAS_CMD__GET_CPER_SNAPSHOT, ras_cmd_get_cper_snapshot},
+	{RAS_CMD__GET_CPER_RECORD, ras_cmd_get_cper_records},
+	{RAS_CMD__GET_BATCH_TRACE_SNAPSHOT, ras_cmd_get_batch_trace_snapshot},
+	{RAS_CMD__GET_BATCH_TRACE_RECORD, ras_cmd_get_batch_trace_records},
+};
+
+int rascore_handle_cmd(struct ras_core_context *ras_core,
+		struct ras_cmd_ioctl *cmd, void *data)
+{
+	struct ras_cmd_func_map *ras_cmd = NULL;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ras_cmd_maps); i++) {
+		if (cmd->cmd_id == ras_cmd_maps[i].cmd_id) {
+			ras_cmd = &ras_cmd_maps[i];
+			break;
+		}
+	}
+
+	if (!ras_cmd)
+		return	RAS_CMD__ERROR_UKNOWN_CMD;
+
+	return ras_cmd->func(ras_core, cmd, data);
+}
+
+int ras_cmd_init(struct ras_core_context *ras_core)
+{
+	return ras_cmd_add_device(ras_core);
+}
+
+int ras_cmd_fini(struct ras_core_context *ras_core)
+{
+	ras_cmd_remove_device(ras_core);
+	return 0;
+}
+
+int ras_cmd_query_interface_info(struct ras_core_context *ras_core,
+	struct ras_query_interface_info_rsp *rsp)
+{
+	rsp->ras_cmd_major_ver = RAS_CMD_MAJOR_VERSION;
+	rsp->ras_cmd_minor_ver = RAS_CMD_MINOR_VERSION;
+
+	return 0;
+}
+
+int ras_cmd_translate_soc_pa_to_bank(struct ras_core_context *ras_core,
+	uint64_t soc_pa, struct ras_fb_bank_addr *bank_addr)
+{
+	struct umc_bank_addr  umc_bank = {0};
+	int ret;
+
+	ret = ras_umc_translate_soc_pa_and_bank(ras_core, &soc_pa, &umc_bank, false);
+	if (ret)
+		return RAS_CMD__ERROR_GENERIC;
+
+	bank_addr->stack_id = umc_bank.stack_id;
+	bank_addr->bank_group = umc_bank.bank_group;
+	bank_addr->bank = umc_bank.bank;
+	bank_addr->row = umc_bank.row;
+	bank_addr->column = umc_bank.column;
+	bank_addr->channel = umc_bank.channel;
+	bank_addr->subchannel = umc_bank.subchannel;
+
+	return 0;
+}
+
+int ras_cmd_translate_bank_to_soc_pa(struct ras_core_context *ras_core,
+		struct ras_fb_bank_addr bank_addr, uint64_t *soc_pa)
+{
+	struct umc_bank_addr  umc_bank = {0};
+
+	umc_bank.stack_id = bank_addr.stack_id;
+	umc_bank.bank_group = bank_addr.bank_group;
+	umc_bank.bank = bank_addr.bank;
+	umc_bank.row = bank_addr.row;
+	umc_bank.column = bank_addr.column;
+	umc_bank.channel = bank_addr.channel;
+	umc_bank.subchannel = bank_addr.subchannel;
+
+	return ras_umc_translate_soc_pa_and_bank(ras_core, soc_pa, &umc_bank, true);
+}
+
+uint64_t ras_cmd_get_dev_handle(struct ras_core_context *ras_core)
+{
+	return ras_core->ras_cmd.dev_handle;
+}
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.h b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.h
new file mode 100644
index 000000000000..6df8c70f5ad8
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.h
@@ -0,0 +1,425 @@
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
+#ifndef __RAS_CMD_H__
+#define __RAS_CMD_H__
+#include "ras.h"
+#include "ras_eeprom.h"
+#include "ras_log_ring.h"
+#include "ras_cper.h"
+
+#define RAS_CMD_DEV_HANDLE_MAGIC 0xFEEDAD00UL
+
+#define RAS_CMD_MAX_IN_SIZE 256
+#define RAS_CMD_MAX_GPU_NUM 32
+#define RAS_CMD_MAX_BAD_PAGES_PER_GROUP 32
+
+/* position of instance value in sub_block_index of
+ * ta_ras_trigger_error_input, the sub block uses lower 12 bits
+ */
+#define RAS_TA_INST_MASK 0xfffff000
+#define RAS_TA_INST_SHIFT 0xc
+
+enum ras_cmd_interface_type {
+	RAS_CMD_INTERFACE_TYPE_NONE,
+	RAS_CMD_INTERFACE_TYPE_AMDGPU,
+	RAS_CMD_INTERFACE_TYPE_VF,
+	RAS_CMD_INTERFACE_TYPE_PF,
+};
+
+enum ras_cmd_id_range {
+	RAS_CMD_ID_COMMON_START = 0,
+	RAS_CMD_ID_COMMON_END = 0x10000,
+	RAS_CMD_ID_AMDGPU_START = RAS_CMD_ID_COMMON_END,
+	RAS_CMD_ID_AMDGPU_END = 0x20000,
+	RAS_CMD_ID_MXGPU_START = RAS_CMD_ID_AMDGPU_END,
+	RAS_CMD_ID_MXGPU_END = 0x30000,
+	RAS_CMD_ID_MXGPU_VF_START = RAS_CMD_ID_MXGPU_END,
+	RAS_CMD_ID_MXGPU_VF_END = 0x40000,
+};
+
+enum ras_cmd_id {
+	RAS_CMD__BEGIN = RAS_CMD_ID_COMMON_START,
+	RAS_CMD__QUERY_INTERFACE_INFO,
+	RAS_CMD__GET_DEVICES_INFO,
+	RAS_CMD__GET_BLOCK_ECC_STATUS,
+	RAS_CMD__INJECT_ERROR,
+	RAS_CMD__GET_BAD_PAGES,
+	RAS_CMD__CLEAR_BAD_PAGE_INFO,
+	RAS_CMD__RESET_ALL_ERROR_COUNTS,
+	RAS_CMD__GET_SAFE_FB_ADDRESS_RANGES,
+	RAS_CMD__TRANSLATE_FB_ADDRESS,
+	RAS_CMD__GET_LINK_TOPOLOGY,
+	RAS_CMD__GET_CPER_SNAPSHOT,
+	RAS_CMD__GET_CPER_RECORD,
+	RAS_CMD__GET_BATCH_TRACE_SNAPSHOT,
+	RAS_CMD__GET_BATCH_TRACE_RECORD,
+	RAS_CMD__SUPPORTED_MAX = RAS_CMD_ID_COMMON_END,
+};
+
+enum ras_cmd_response {
+	RAS_CMD__SUCCESS = 0,
+	RAS_CMD__SUCCESS_EXEED_BUFFER,
+	RAS_CMD__ERROR_UKNOWN_CMD,
+	RAS_CMD__ERROR_INVALID_CMD,
+	RAS_CMD__ERROR_VERSION,
+	RAS_CMD__ERROR_INVALID_INPUT_SIZE,
+	RAS_CMD__ERROR_INVALID_INPUT_DATA,
+	RAS_CMD__ERROR_DRV_INIT_FAIL,
+	RAS_CMD__ERROR_ACCESS_DENIED,
+	RAS_CMD__ERROR_GENERIC,
+	RAS_CMD__ERROR_TIMEOUT,
+};
+
+enum ras_error_type {
+	RAS_TYPE_ERROR__NONE = 0,
+	RAS_TYPE_ERROR__PARITY = 1,
+	RAS_TYPE_ERROR__SINGLE_CORRECTABLE = 2,
+	RAS_TYPE_ERROR__MULTI_UNCORRECTABLE = 4,
+	RAS_TYPE_ERROR__POISON = 8,
+};
+
+struct ras_core_context;
+struct ras_cmd_ioctl;
+
+struct ras_cmd_mgr {
+	struct list_head head;
+	struct ras_core_context *ras_core;
+	uint64_t dev_handle;
+};
+
+struct ras_cmd_func_map {
+	uint32_t cmd_id;
+	int (*func)(struct ras_core_context *ras_core,
+			struct ras_cmd_ioctl *cmd, void *data);
+};
+
+struct ras_device_bdf {
+	union {
+		struct {
+			uint32_t function : 3;
+			uint32_t device : 5;
+			uint32_t bus : 8;
+			uint32_t domain : 16;
+		};
+		uint32_t u32_all;
+	};
+};
+
+struct ras_cmd_param {
+	uint32_t idx_vf;
+	void *data;
+};
+
+#pragma pack(push, 8)
+struct ras_cmd_ioctl {
+	uint32_t magic;
+	union {
+		struct {
+			uint16_t ras_cmd_minor_ver : 10;
+			uint16_t ras_cmd_major_ver : 6;
+		};
+		uint16_t ras_cmd_ver;
+	};
+	union {
+		struct {
+			uint16_t plat_major_ver : 10;
+			uint16_t plat_minor_ver : 6;
+		};
+		uint16_t plat_ver;
+	};
+	uint32_t cmd_id;
+	uint32_t cmd_res;
+	uint32_t input_size;
+	uint32_t output_size;
+	uint32_t reserved[6];
+	uint8_t  input_buff_raw[RAS_CMD_MAX_IN_SIZE];
+	uint8_t  output_buff_raw[];
+};
+
+struct ras_cmd_dev_handle {
+	uint64_t dev_handle;
+};
+
+struct ras_cmd_block_ecc_info_req {
+	struct ras_cmd_dev_handle dev;
+	uint32_t block_id;
+	uint32_t subblock_id;
+	uint32_t reserved[4];
+};
+
+struct ras_cmd_block_ecc_info_rsp {
+	uint32_t version;
+	uint32_t ce_count;
+	uint32_t ue_count;
+	uint32_t de_count;
+	uint32_t reserved[6];
+};
+
+struct ras_cmd_inject_error_req {
+	struct ras_cmd_dev_handle dev;
+	uint32_t block_id;
+	uint32_t subblock_id;
+	uint64_t address;
+	uint32_t error_type;
+	uint32_t instance_mask;
+	union {
+		struct {
+			/* vf index */
+			uint64_t vf_idx : 6;
+			/* method of error injection. i.e persistent, coherent etc */
+			uint64_t method : 10;
+			uint64_t rsv    : 48;
+		};
+		uint64_t value;
+	};
+	uint32_t reserved[8];
+};
+
+struct ras_cmd_inject_error_rsp {
+	uint32_t version;
+	uint32_t reserved[5];
+	uint64_t address;
+};
+
+struct ras_cmd_dev_info {
+	uint64_t dev_handle;
+	uint32_t location_id;
+	uint32_t ecc_enabled;
+	uint32_t ecc_supported;
+	uint32_t vf_num;
+	uint32_t asic_type;
+	uint32_t oam_id;
+	uint32_t reserved[8];
+};
+
+struct ras_cmd_devices_info_rsp {
+	uint32_t version;
+	uint32_t dev_num;
+	uint32_t reserved[6];
+	struct ras_cmd_dev_info devs[RAS_CMD_MAX_GPU_NUM];
+};
+
+struct ras_cmd_bad_page_record {
+	union {
+		uint64_t address;
+		uint64_t offset;
+	};
+	uint64_t retired_page;
+	uint64_t ts;
+
+	uint32_t err_type;
+
+	union {
+		unsigned char bank;
+		unsigned char cu;
+	};
+
+	unsigned char mem_channel;
+	unsigned char mcumc_id;
+
+	unsigned char valid;
+	unsigned char reserved[8];
+};
+
+struct ras_cmd_bad_pages_info_req {
+	struct ras_cmd_dev_handle device;
+	uint32_t group_index;
+	uint32_t reserved[5];
+};
+
+struct ras_cmd_bad_pages_info_rsp {
+	uint32_t version;
+	uint32_t group_index;
+	uint32_t bp_in_group;
+	uint32_t bp_total_cnt;
+	uint32_t reserved[4];
+	struct ras_cmd_bad_page_record records[RAS_CMD_MAX_BAD_PAGES_PER_GROUP];
+};
+
+struct ras_query_interface_info_req {
+	uint32_t reserved[8];
+};
+
+struct ras_query_interface_info_rsp {
+	uint32_t version;
+	uint32_t ras_cmd_major_ver;
+	uint32_t ras_cmd_minor_ver;
+	uint32_t plat_major_ver;
+	uint32_t plat_minor_ver;
+	uint8_t  interface_type;
+	uint8_t  rsv[3];
+	uint32_t reserved[8];
+};
+
+#define RAS_MAX_NUM_SAFE_RANGES 64
+struct ras_cmd_ras_safe_fb_address_ranges_rsp {
+	uint32_t version;
+	uint32_t num_ranges;
+	uint32_t reserved[4];
+	struct {
+		uint64_t start;
+		uint64_t size;
+		uint32_t idx;
+		uint32_t reserved[3];
+	} range[RAS_MAX_NUM_SAFE_RANGES];
+};
+
+enum ras_fb_addr_type {
+	RAS_FB_ADDR_SOC_PHY, /* SPA */
+	RAS_FB_ADDR_BANK,
+	RAS_FB_ADDR_VF_PHY, /* GPA */
+	RAS_FB_ADDR_UNKNOWN
+};
+
+struct ras_fb_bank_addr {
+	uint32_t stack_id; /* SID */
+	uint32_t bank_group;
+	uint32_t bank;
+	uint32_t row;
+	uint32_t column;
+	uint32_t channel;
+	uint32_t subchannel; /* Also called Pseudochannel (PC) */
+	uint32_t reserved[3];
+};
+
+struct ras_fb_vf_phy_addr {
+	uint32_t vf_idx;
+	uint32_t reserved;
+	uint64_t addr;
+};
+
+union ras_translate_fb_address {
+	struct ras_fb_bank_addr bank_addr;
+	uint64_t soc_phy_addr;
+	struct ras_fb_vf_phy_addr vf_phy_addr;
+};
+
+struct ras_cmd_translate_fb_address_req {
+	struct ras_cmd_dev_handle dev;
+	enum ras_fb_addr_type src_addr_type;
+	enum ras_fb_addr_type dest_addr_type;
+	union ras_translate_fb_address trans_addr;
+};
+
+struct ras_cmd_translate_fb_address_rsp {
+	uint32_t version;
+	uint32_t reserved[5];
+	union ras_translate_fb_address trans_addr;
+};
+
+struct ras_dev_link_topology_req {
+	struct ras_cmd_dev_handle src;
+	struct ras_cmd_dev_handle dst;
+};
+
+struct ras_dev_link_topology_rsp {
+	uint32_t  version;
+	uint32_t  link_status;  /* HW status of the link */
+	uint32_t  link_type;    /* type of the link */
+	uint32_t  num_hops;     /* number of hops */
+	uint32_t reserved[8];
+};
+
+struct ras_cmd_cper_snapshot_req {
+	struct ras_cmd_dev_handle dev;
+};
+
+struct ras_cmd_cper_snapshot_rsp {
+	uint32_t version;
+	uint32_t reserved[4];
+	uint32_t total_cper_num;
+	uint64_t start_cper_id;
+	uint64_t latest_cper_id;
+};
+
+struct ras_cmd_cper_record_req {
+	struct ras_cmd_dev_handle dev;
+	uint64_t cper_start_id;
+	uint32_t cper_num;
+	uint32_t buf_size;
+	uint64_t buf_ptr;
+	uint32_t reserved[4];
+};
+
+struct ras_cmd_cper_record_rsp {
+	uint32_t version;
+	uint32_t real_data_size;
+	uint32_t real_cper_num;
+	uint32_t remain_num;
+	uint32_t reserved[4];
+};
+
+struct ras_cmd_batch_trace_snapshot_req {
+	struct ras_cmd_dev_handle dev;
+};
+
+struct ras_cmd_batch_trace_snapshot_rsp {
+	uint32_t version;
+	uint32_t reserved[4];
+	uint32_t total_batch_num;
+	uint64_t start_batch_id;
+	uint64_t latest_batch_id;
+};
+
+struct ras_cmd_batch_trace_record_req {
+	struct ras_cmd_dev_handle dev;
+	uint64_t start_batch_id;
+	uint32_t batch_num;
+	uint32_t reserved[5];
+};
+
+struct batch_ras_trace_info {
+	uint64_t batch_id;
+	uint16_t offset;
+	uint8_t  trace_num;
+	uint8_t  rsv;
+	uint32_t reserved;
+};
+
+#define RAS_CMD_MAX_BATCH_NUM  300
+#define RAS_CMD_MAX_TRACE_NUM  300
+struct ras_cmd_batch_trace_record_rsp {
+	uint32_t version;
+	uint16_t real_batch_num;
+	uint16_t remain_num;
+	uint64_t start_batch_id;
+	uint32_t reserved[2];
+	struct batch_ras_trace_info batchs[RAS_CMD_MAX_BATCH_NUM];
+	struct ras_log_info records[RAS_CMD_MAX_TRACE_NUM];
+};
+
+#pragma pack(pop)
+
+int ras_cmd_init(struct ras_core_context *ras_core);
+int ras_cmd_fini(struct ras_core_context *ras_core);
+int rascore_handle_cmd(struct ras_core_context *ras_core, struct ras_cmd_ioctl *cmd, void *data);
+uint64_t ras_cmd_get_dev_handle(struct ras_core_context *ras_core);
+int ras_cmd_query_interface_info(struct ras_core_context *ras_core,
+	struct ras_query_interface_info_rsp *rsp);
+int ras_cmd_translate_soc_pa_to_bank(struct ras_core_context *ras_core,
+			uint64_t soc_pa, struct ras_fb_bank_addr *bank_addr);
+int ras_cmd_translate_bank_to_soc_pa(struct ras_core_context *ras_core,
+			struct ras_fb_bank_addr bank_addr, uint64_t *soc_pa);
+#endif
-- 
2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78872CAC5A7
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Sep 2025 02:39:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E55610E385;
	Mon, 22 Sep 2025 02:39:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bM7b1beK";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011030.outbound.protection.outlook.com [52.101.62.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD49C10E37F
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Sep 2025 02:39:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kLV54CCoIzKETPm9jbZ0jpfBBlYbGrCPW3rsTPBdwWgQqQkVcIE7cwPbxUoFn7d0QvmgAaRuUYptq0GWS5V9ReNzR3Gc0a5XN7K1iIfYs20sRV02SKLHS8UPuigEs5v/B5KFPOdfyqDRuYQzZncuMQaXM8hjjO+fiS5lkG2hgwfCYYTfuM3ntygaF9kN+tAOSGp/E0BcuLNQU04ERVHZm8p+hTkC20eRnwT06SHMDBtElXg7iR6emaxM8LrrImIGZM6byfRYIW23wqqSOUhQwLY+DsYi712+UXiuAY3jFnWZsR07gGLTipYRI2p74F7uhQdCiYA87GQPnHiN7KznFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORU5KQpSGr8/38w82hl7ZEz8XWkgj0XD/Q9N2Z/LpRg=;
 b=hMmapMDfrnuWAqBJhcaaSTBgVZsuqwG542wjVqC9QvPoAdky12Eh6ZvPnfObepZVVo1tHBsfPOdvcBLhaNiHdxL/U2xinEAeVidlMuU66YM8RB2kRzvQ85/jh8r/Hs/xWisVYFAXyVDJUBc/8hiCtAtIEGulo8CYvfQh6TQJZ9MPOV28cyl0IPfoEbK9BV+txXJL0P0GwWpE+QRQIx2993WAc6AmWYYuxMT4mJ8Qx1rDUvdTHNKPB1Us5ybti4xogLj45YkF9lsW0lWqs+ctDD1Ky6O9UrVW8nOtX6vHddqnZ6ha57BlohuAMD7xIfb1iar+LfN4BpJ1sVFKXKyl7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORU5KQpSGr8/38w82hl7ZEz8XWkgj0XD/Q9N2Z/LpRg=;
 b=bM7b1beKwDevzb+mrbEojW6TpFOlVtroam9m373EFjBA4+UewMrKIGjlbBh9p+41pO4dieD+oUU4UlSqI+tR36NBw7TJZuiw2mklJ+VrUJId5eBIHRaMg7n9PxAPb+DY8XsNKwc6ofyIkMAuxKO+PD/ftkzU4Rfo7FD5MDIyCXc=
Received: from BYAPR01CA0055.prod.exchangelabs.com (2603:10b6:a03:94::32) by
 MN2PR12MB4126.namprd12.prod.outlook.com (2603:10b6:208:199::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 02:39:42 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:a03:94:cafe::57) by BYAPR01CA0055.outlook.office365.com
 (2603:10b6:a03:94::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Mon,
 22 Sep 2025 02:40:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.0 via Frontend Transport; Mon, 22 Sep 2025 02:39:41 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 21 Sep
 2025 19:39:38 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou
 <tao.zhou1@amd.com>
Subject: [PATCH V5 09/20] drm/amd/ras: Add umc common ras functions
Date: Mon, 22 Sep 2025 10:38:33 +0800
Message-ID: <20250922023844.3108065-9-YiPeng.Chai@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|MN2PR12MB4126:EE_
X-MS-Office365-Filtering-Correlation-Id: 6047f2e3-eb47-4a37-0dd4-08ddf9814852
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dhfqSp28Lv4jHqMf9q4swO9SCLOC2sDyBJEjY2+G3Ybz1hJWWzMJX9QodDmp?=
 =?us-ascii?Q?pPz4CIDjpz1fEbSr10V66Unrziu7j51V8QXIp55/98MPstQ+/JW+HonS78nF?=
 =?us-ascii?Q?YMDNwsWqUtpcB8jWk1fyMQ7eiTZ3Mx5BEza2CiTVkLcwykNUP2xTyGea/yoH?=
 =?us-ascii?Q?7LTRGsxh2BeM+Ll2Hm+vGekf5Dyb+mcojJW45XZx5zku4FOU4pAfITaAOtKp?=
 =?us-ascii?Q?6Oeh2T7SBEYBM7M/cIz/dUXDHHC+PkaPrfe6iHPGi7j2qSvAUywSyXJEmeVk?=
 =?us-ascii?Q?vWjqXVewUOX91VRjyfETVkotuOOsf8Iw7O8RCJCRhOAznAI8172JereG8+Uj?=
 =?us-ascii?Q?pfnuzXy4irzMBZYGUDI9dO1z07ATI4HV8IZqC06mZDEVQv3OiuAxY7deia6V?=
 =?us-ascii?Q?KP/iqrsiE342/VRFB3esrhwyyL5XaXH0rWiZ7irl5D7UN0pVS+YEjXljHKXz?=
 =?us-ascii?Q?5lVbyTQptbR3YaioKpapeSU/4L7e+FifSWDXaZiqoawBe347wxXU7wkLA+FN?=
 =?us-ascii?Q?r4dhpGHBcoiKqin+JVjUQhUgTUoZLns8zG47D6EQuCsEYSUjrUXHGF7yGlbr?=
 =?us-ascii?Q?d49/kBH9mL3FOxkfxKIZ/iwgqMuXV34v9XJgfB7ZFwz6z+2gyV9EkskM6Uf7?=
 =?us-ascii?Q?4eXvBMKVSBBmNg2ejENuba3009gwt6qOmIkmjx62gaj/LdkQWI86NzeNoQw2?=
 =?us-ascii?Q?vvW55e8jqf0ReuVZf6yjNYFmjLOgTlpGq1s7nTxp4LVvNzjCjrOYQdotOrNp?=
 =?us-ascii?Q?QRa7/dmogPxb+C49fL3vBKR/dCH/j6exEig30jdvcMl17jtxnwA3aC3mG8KI?=
 =?us-ascii?Q?qo5kcjJfr2MlxzB8Mo7iuqxy+cH97zAjZVqal413Q2C3nmc28p1hEcHA95Fr?=
 =?us-ascii?Q?JTZnTqrVd9mEoGBIcBF83DRhEdCcHDNqcsramFCBr+L/FqxRo2plZrXLPbZA?=
 =?us-ascii?Q?WqW48h6PkyDte6flXe7mZdRH6PLhySFdYg3vg7Sk2jR6flnOIdO3cHdz1Hpq?=
 =?us-ascii?Q?Q3TJQMiGBw7dMM38Cr2D3XV9LxTZhCSF+JOWgtVOQFglzpwVAfQQMbot3aoh?=
 =?us-ascii?Q?EjsBk+9xGp5mXkYF/G9rfNnHtrMEsUMteHFmY1mxadlFzgfE953wdqBv4nNF?=
 =?us-ascii?Q?x4gUe5DUg/cLqEZOtNUq6ndulO72zARhb0uDeA0d00QhKcF8/EZaY9Yr+w0u?=
 =?us-ascii?Q?WSrkx48zzKj/6FjoLGZSl44d+Yolamm4jaRbafNiHBAbulrjZwf8CcNEp11u?=
 =?us-ascii?Q?G+TvcQyHW188uEMDJcoWf1p+T7279tDlZaCTQZP7H5+zDQxOoao9vJcZPYj1?=
 =?us-ascii?Q?10q7XNcDcVMZoVhue0AkW66JM0Z3m1qNSSJjbvXzjQ3YifpMSmUXV+wtDEGH?=
 =?us-ascii?Q?Q64Z22cu1QgeX2yytOeoz2l8hCZWR11SCQo7MinGVKgzW93OwlUjI1zScqYU?=
 =?us-ascii?Q?xHopPvGf9Xeu9r7Nkjyoe/v5bKzDPTrFYzkABMnJ49TovI1WZ6Mt/eeWNS1n?=
 =?us-ascii?Q?1z25UM9iL2N1Mgfar9Wnys1iL9VI2vU2lEKQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 02:39:41.4577 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6047f2e3-eb47-4a37-0dd4-08ddf9814852
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126
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

Add umc common ras functions.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_umc.c | 706 ++++++++++++++++++++++
 drivers/gpu/drm/amd/ras/rascore/ras_umc.h | 166 +++++
 2 files changed, 872 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/ras/rascore/ras_umc.c
 create mode 100644 drivers/gpu/drm/amd/ras/rascore/ras_umc.h

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
new file mode 100644
index 000000000000..4067359bb299
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
@@ -0,0 +1,706 @@
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
+#include "ras_umc.h"
+#include "ras_umc_v12_0.h"
+
+#define MAX_ECC_NUM_PER_RETIREMENT  16
+
+/* bad page timestamp format
+ * yy[31:27] mm[26:23] day[22:17] hh[16:12] mm[11:6] ss[5:0]
+ */
+#define EEPROM_TIMESTAMP_MINUTE  6
+#define EEPROM_TIMESTAMP_HOUR    12
+#define EEPROM_TIMESTAMP_DAY     17
+#define EEPROM_TIMESTAMP_MONTH   23
+#define EEPROM_TIMESTAMP_YEAR    27
+
+static uint64_t ras_umc_get_eeprom_timestamp(struct ras_core_context *ras_core)
+{
+	struct ras_time tm = {0};
+	uint64_t utc_timestamp = 0;
+	uint64_t eeprom_timestamp = 0;
+
+	utc_timestamp = ras_core_get_utc_second_timestamp(ras_core);
+	if (!utc_timestamp)
+		return utc_timestamp;
+
+	ras_core_convert_timestamp_to_time(ras_core, utc_timestamp, &tm);
+
+	/* the year range is 2000 ~ 2031, set the year if not in the range */
+	if (tm.tm_year < 2000)
+		tm.tm_year = 2000;
+	if (tm.tm_year > 2031)
+		tm.tm_year = 2031;
+
+	tm.tm_year -= 2000;
+
+	eeprom_timestamp = tm.tm_sec + (tm.tm_min << EEPROM_TIMESTAMP_MINUTE)
+				+ (tm.tm_hour << EEPROM_TIMESTAMP_HOUR)
+				+ (tm.tm_mday << EEPROM_TIMESTAMP_DAY)
+				+ (tm.tm_mon << EEPROM_TIMESTAMP_MONTH)
+				+ (tm.tm_year << EEPROM_TIMESTAMP_YEAR);
+	eeprom_timestamp &= 0xffffffff;
+
+	return eeprom_timestamp;
+}
+
+static const struct ras_umc_ip_func *ras_umc_get_ip_func(
+				struct ras_core_context *ras_core, uint32_t ip_version)
+{
+	switch (ip_version) {
+	case IP_VERSION(12, 0, 0):
+		return &ras_umc_func_v12_0;
+	default:
+		RAS_DEV_ERR(ras_core->dev,
+			"UMC ip version(0x%x) is not supported!\n", ip_version);
+		break;
+	}
+
+	return NULL;
+}
+
+int ras_umc_psp_convert_ma_to_pa(struct ras_core_context *ras_core,
+		struct umc_mca_addr *in, struct umc_phy_addr *out,
+		uint32_t nps)
+{
+	struct ras_ta_query_address_input addr_in;
+	struct ras_ta_query_address_output addr_out;
+	int ret;
+
+	if (!in)
+		return -EINVAL;
+
+	memset(&addr_in, 0, sizeof(addr_in));
+	memset(&addr_out, 0, sizeof(addr_out));
+
+	addr_in.ma.err_addr = in->err_addr;
+	addr_in.ma.ch_inst = in->ch_inst;
+	addr_in.ma.umc_inst = in->umc_inst;
+	addr_in.ma.node_inst = in->node_inst;
+	addr_in.ma.socket_id = in->socket_id;
+
+	addr_in.addr_type = RAS_TA_MCA_TO_PA;
+
+	ret = ras_psp_query_address(ras_core, &addr_in, &addr_out);
+	if (ret) {
+		RAS_DEV_WARN(ras_core->dev,
+			"Failed to query RAS physical address for 0x%llx, ret:%d",
+			in->err_addr, ret);
+		return -EREMOTEIO;
+	}
+
+	if (out) {
+		out->pa = addr_out.pa.pa;
+		out->bank = addr_out.pa.bank;
+		out->channel_idx = addr_out.pa.channel_idx;
+	}
+
+	return 0;
+}
+
+static int ras_umc_log_ecc(struct ras_core_context *ras_core,
+		unsigned long idx, void *data)
+{
+	struct ras_umc *ras_umc = &ras_core->ras_umc;
+	int ret;
+
+	mutex_lock(&ras_umc->tree_lock);
+	ret = radix_tree_insert(&ras_umc->root, idx, data);
+	if (!ret)
+		radix_tree_tag_set(&ras_umc->root, idx, UMC_ECC_NEW_DETECTED_TAG);
+	mutex_unlock(&ras_umc->tree_lock);
+
+	return ret;
+}
+
+int ras_umc_clear_logged_ecc(struct ras_core_context *ras_core)
+{
+	struct ras_umc *ras_umc = &ras_core->ras_umc;
+	uint64_t buf[8] = {0};
+	void  **slot;
+	void *data;
+	void *iter = buf;
+
+	mutex_lock(&ras_umc->tree_lock);
+	radix_tree_for_each_slot(slot, &ras_umc->root, iter, 0) {
+		data = ras_radix_tree_delete_iter(&ras_umc->root, iter);
+		kfree(data);
+	}
+	mutex_unlock(&ras_umc->tree_lock);
+
+	return 0;
+}
+
+static void ras_umc_reserve_eeprom_record(struct ras_core_context *ras_core,
+				struct eeprom_umc_record *record)
+{
+	struct ras_umc *ras_umc = &ras_core->ras_umc;
+	uint64_t page_pfn[16];
+	int count = 0, i;
+
+	memset(page_pfn, 0, sizeof(page_pfn));
+	if (ras_umc->ip_func && ras_umc->ip_func->eeprom_record_to_nps_pages) {
+		count = ras_umc->ip_func->eeprom_record_to_nps_pages(ras_core,
+					record, record->cur_nps, page_pfn, ARRAY_SIZE(page_pfn));
+		if (count <= 0) {
+			RAS_DEV_ERR(ras_core->dev,
+				"Fail to convert error address! count:%d\n", count);
+			return;
+		}
+	}
+
+	/* Reserve memory */
+	for (i = 0; i < count; i++)
+		ras_core_event_notify(ras_core,
+			RAS_EVENT_ID__RESERVE_BAD_PAGE, &page_pfn[i]);
+}
+
+/* When gpu reset is ongoing, ecc logging operations will be pended.
+ */
+int ras_umc_log_bad_bank_pending(struct ras_core_context *ras_core, struct ras_bank_ecc *bank)
+{
+	struct ras_umc *ras_umc = &ras_core->ras_umc;
+	struct ras_bank_ecc_node *ecc_node;
+
+	ecc_node = kzalloc(sizeof(*ecc_node), GFP_KERNEL);
+	if (!ecc_node)
+		return -ENOMEM;
+
+	memcpy(&ecc_node->ecc, bank, sizeof(ecc_node->ecc));
+
+	mutex_lock(&ras_umc->pending_ecc_lock);
+	list_add_tail(&ecc_node->node, &ras_umc->pending_ecc_list);
+	mutex_unlock(&ras_umc->pending_ecc_lock);
+
+	return 0;
+}
+
+/* After gpu reset is complete, re-log the pending error banks.
+ */
+int ras_umc_log_pending_bad_bank(struct ras_core_context *ras_core)
+{
+	struct ras_umc *ras_umc = &ras_core->ras_umc;
+	struct ras_bank_ecc_node *ecc_node, *tmp;
+
+	mutex_lock(&ras_umc->pending_ecc_lock);
+	list_for_each_entry_safe(ecc_node,
+		tmp, &ras_umc->pending_ecc_list, node){
+		if (ecc_node && !ras_umc_log_bad_bank(ras_core, &ecc_node->ecc)) {
+			list_del(&ecc_node->node);
+			kfree(ecc_node);
+		}
+	}
+	mutex_unlock(&ras_umc->pending_ecc_lock);
+
+	return 0;
+}
+
+int ras_umc_log_bad_bank(struct ras_core_context *ras_core, struct ras_bank_ecc *bank)
+{
+	struct ras_umc *ras_umc = &ras_core->ras_umc;
+	struct eeprom_umc_record umc_rec;
+	struct eeprom_umc_record *err_rec;
+	int ret;
+
+	memset(&umc_rec, 0, sizeof(umc_rec));
+
+	mutex_lock(&ras_umc->bank_log_lock);
+	ret = ras_umc->ip_func->bank_to_eeprom_record(ras_core, bank, &umc_rec);
+	if (ret)
+		goto out;
+
+	err_rec = kzalloc(sizeof(*err_rec), GFP_KERNEL);
+	if (!err_rec) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	memcpy(err_rec, &umc_rec, sizeof(umc_rec));
+	ret = ras_umc_log_ecc(ras_core, err_rec->cur_nps_retired_row_pfn, err_rec);
+	if (ret) {
+		if (ret == -EEXIST) {
+			RAS_DEV_INFO(ras_core->dev, "The bad pages have been logged before.\n");
+			ret = 0;
+		}
+
+		kfree(err_rec);
+		goto out;
+	}
+
+	ras_umc_reserve_eeprom_record(ras_core, err_rec);
+
+	ret = ras_core_event_notify(ras_core,
+			RAS_EVENT_ID__BAD_PAGE_DETECTED, NULL);
+
+out:
+	mutex_unlock(&ras_umc->bank_log_lock);
+	return ret;
+}
+
+static int ras_umc_get_new_records(struct ras_core_context *ras_core,
+			struct eeprom_umc_record *records, u32 num)
+{
+	struct ras_umc *ras_umc = &ras_core->ras_umc;
+	struct eeprom_umc_record *entries[MAX_ECC_NUM_PER_RETIREMENT];
+	u32 entry_num = num < MAX_ECC_NUM_PER_RETIREMENT ? num : MAX_ECC_NUM_PER_RETIREMENT;
+	int count = 0;
+	int new_detected, i;
+
+	mutex_lock(&ras_umc->tree_lock);
+	new_detected = radix_tree_gang_lookup_tag(&ras_umc->root, (void **)entries,
+			0, entry_num, UMC_ECC_NEW_DETECTED_TAG);
+	for (i = 0; i < new_detected; i++) {
+		if (!entries[i])
+			continue;
+
+		memcpy(&records[i], entries[i], sizeof(struct eeprom_umc_record));
+		count++;
+		radix_tree_tag_clear(&ras_umc->root,
+				entries[i]->cur_nps_retired_row_pfn, UMC_ECC_NEW_DETECTED_TAG);
+	}
+	mutex_unlock(&ras_umc->tree_lock);
+
+	return count;
+}
+
+static bool ras_umc_check_retired_record(struct ras_core_context *ras_core,
+				struct eeprom_umc_record *record, bool from_eeprom)
+{
+	struct ras_umc *ras_umc = &ras_core->ras_umc;
+	struct eeprom_store_record *data = &ras_umc->umc_err_data.rom_data;
+	uint32_t nps = 0;
+	int i, ret;
+
+	if (from_eeprom) {
+		nps = ras_umc->umc_err_data.umc_nps_mode;
+		if (ras_umc->ip_func && ras_umc->ip_func->eeprom_record_to_nps_record) {
+			ret = ras_umc->ip_func->eeprom_record_to_nps_record(ras_core, record, nps);
+			if (ret)
+				RAS_DEV_WARN(ras_core->dev,
+					"Failed to adjust eeprom record, ret:%d", ret);
+		}
+		return false;
+	}
+
+	for (i = 0; i < data->count; i++) {
+		if ((data->bps[i].retired_row_pfn == record->retired_row_pfn) &&
+		    (data->bps[i].cur_nps_retired_row_pfn == record->cur_nps_retired_row_pfn))
+			return true;
+	}
+
+	return false;
+}
+
+/* alloc/realloc bps array */
+static int ras_umc_realloc_err_data_space(struct ras_core_context *ras_core,
+		struct eeprom_store_record *data, int pages)
+{
+	unsigned int old_space = data->count + data->space_left;
+	unsigned int new_space = old_space + pages;
+	unsigned int align_space = ALIGN(new_space, 512);
+	void *bps = kzalloc(align_space * sizeof(*data->bps), GFP_KERNEL);
+
+	if (!bps)
+		return -ENOMEM;
+
+	if (data->bps) {
+		memcpy(bps, data->bps,
+				data->count * sizeof(*data->bps));
+		kfree(data->bps);
+	}
+
+	data->bps = bps;
+	data->space_left += align_space - old_space;
+	return 0;
+}
+
+static int ras_umc_update_eeprom_rom_data(struct ras_core_context *ras_core,
+		struct eeprom_umc_record *bps)
+{
+	struct eeprom_store_record *data = &ras_core->ras_umc.umc_err_data.rom_data;
+
+	if (!data->space_left &&
+		ras_umc_realloc_err_data_space(ras_core, data, 256)) {
+		return	-ENOMEM;
+	}
+
+	memcpy(&data->bps[data->count], bps, sizeof(*data->bps));
+	data->count++;
+	data->space_left--;
+	return 0;
+}
+
+static int ras_umc_update_eeprom_ram_data(struct ras_core_context *ras_core,
+				struct eeprom_umc_record *bps)
+{
+	struct ras_umc *ras_umc = &ras_core->ras_umc;
+	struct eeprom_store_record *data = &ras_umc->umc_err_data.ram_data;
+	uint64_t page_pfn[16];
+	int count = 0, j;
+
+	if (!data->space_left &&
+		ras_umc_realloc_err_data_space(ras_core, data, 256)) {
+		return	-ENOMEM;
+	}
+
+	memset(page_pfn, 0, sizeof(page_pfn));
+	if (ras_umc->ip_func && ras_umc->ip_func->eeprom_record_to_nps_pages)
+		count = ras_umc->ip_func->eeprom_record_to_nps_pages(ras_core,
+					bps, bps->cur_nps, page_pfn, ARRAY_SIZE(page_pfn));
+
+	if (count > 0) {
+		for (j = 0; j < count; j++) {
+			bps->cur_nps_retired_row_pfn = page_pfn[j];
+			memcpy(&data->bps[data->count], bps, sizeof(*data->bps));
+			data->count++;
+			data->space_left--;
+		}
+	} else {
+		memcpy(&data->bps[data->count], bps, sizeof(*data->bps));
+		data->count++;
+		data->space_left--;
+	}
+
+	return 0;
+}
+
+/* it deal with vram only. */
+static int ras_umc_add_bad_pages(struct ras_core_context *ras_core,
+				 struct eeprom_umc_record *bps,
+				 int pages, bool from_eeprom)
+{
+	struct ras_umc *ras_umc = &ras_core->ras_umc;
+	struct ras_umc_err_data *data = &ras_umc->umc_err_data;
+	int i, ret = 0;
+
+	if (!bps || pages <= 0)
+		return 0;
+
+	mutex_lock(&ras_umc->umc_lock);
+	for (i = 0; i < pages; i++) {
+		if (ras_umc_check_retired_record(ras_core, &bps[i], from_eeprom))
+			continue;
+
+		ret = ras_umc_update_eeprom_rom_data(ras_core, &bps[i]);
+		if (ret)
+			goto out;
+
+		if (data->last_retired_pfn == bps[i].cur_nps_retired_row_pfn)
+			continue;
+
+		data->last_retired_pfn = bps[i].cur_nps_retired_row_pfn;
+
+		if (from_eeprom)
+			ras_umc_reserve_eeprom_record(ras_core, &bps[i]);
+
+		ret = ras_umc_update_eeprom_ram_data(ras_core, &bps[i]);
+		if (ret)
+			goto out;
+	}
+out:
+	mutex_unlock(&ras_umc->umc_lock);
+
+	return ret;
+}
+
+/*
+ * read error record array in eeprom and reserve enough space for
+ * storing new bad pages
+ */
+int ras_umc_load_bad_pages(struct ras_core_context *ras_core)
+{
+	struct eeprom_umc_record *bps;
+	uint32_t ras_num_recs;
+	int ret;
+
+	ras_num_recs = ras_eeprom_get_record_count(ras_core);
+	/* no bad page record, skip eeprom access */
+	if (!ras_num_recs ||
+	    ras_core->ras_eeprom.record_threshold_config == DISABLE_RETIRE_PAGE)
+		return 0;
+
+	bps = kcalloc(ras_num_recs, sizeof(*bps), GFP_KERNEL);
+	if (!bps)
+		return -ENOMEM;
+
+	ret = ras_eeprom_read(ras_core, bps, ras_num_recs);
+	if (ret) {
+		RAS_DEV_ERR(ras_core->dev, "Failed to load EEPROM table records!");
+	} else {
+		ras_core->ras_umc.umc_err_data.last_retired_pfn = UMC_INV_MEM_PFN;
+		ret = ras_umc_add_bad_pages(ras_core, bps, ras_num_recs, true);
+	}
+
+	kfree(bps);
+	return ret;
+}
+
+/*
+ * write error record array to eeprom, the function should be
+ * protected by recovery_lock
+ * new_cnt: new added UE count, excluding reserved bad pages, can be NULL
+ */
+static int ras_umc_save_bad_pages(struct ras_core_context *ras_core)
+{
+	struct ras_umc *ras_umc = &ras_core->ras_umc;
+	struct eeprom_store_record *data = &ras_umc->umc_err_data.rom_data;
+	uint32_t eeprom_record_num;
+	int save_count;
+	int ret = 0;
+
+	if (!data->bps)
+		return 0;
+
+	eeprom_record_num = ras_eeprom_get_record_count(ras_core);
+	mutex_lock(&ras_umc->umc_lock);
+	save_count = data->count - eeprom_record_num;
+	/* only new entries are saved */
+	if (save_count > 0) {
+		if (ras_eeprom_append(ras_core,
+					   &data->bps[eeprom_record_num],
+					   save_count)) {
+			RAS_DEV_ERR(ras_core->dev, "Failed to save EEPROM table data!");
+			ret = -EIO;
+			goto exit;
+		}
+
+		RAS_DEV_INFO(ras_core->dev, "Saved %d pages to EEPROM table.\n", save_count);
+	}
+
+exit:
+	mutex_unlock(&ras_umc->umc_lock);
+	return ret;
+}
+
+int ras_umc_handle_bad_pages(struct ras_core_context *ras_core, void *data)
+{
+	struct eeprom_umc_record records[MAX_ECC_NUM_PER_RETIREMENT];
+	int count, ret;
+
+	memset(records, 0, sizeof(records));
+	count = ras_umc_get_new_records(ras_core, records, ARRAY_SIZE(records));
+	if (count <= 0)
+		return -ENODATA;
+
+	ret = ras_umc_add_bad_pages(ras_core, records, count, false);
+	if (ret) {
+		RAS_DEV_ERR(ras_core->dev, "Failed to add ras bad page!\n");
+		return -EINVAL;
+	}
+
+	ret = ras_umc_save_bad_pages(ras_core);
+	if (ret) {
+		RAS_DEV_ERR(ras_core->dev, "Failed to save ras bad page\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int ras_umc_sw_init(struct ras_core_context *ras_core)
+{
+	struct ras_umc *ras_umc = &ras_core->ras_umc;
+
+	memset(ras_umc, 0, sizeof(*ras_umc));
+
+	INIT_LIST_HEAD(&ras_umc->pending_ecc_list);
+
+	INIT_RADIX_TREE(&ras_umc->root, GFP_KERNEL);
+
+	mutex_init(&ras_umc->tree_lock);
+	mutex_init(&ras_umc->pending_ecc_lock);
+	mutex_init(&ras_umc->umc_lock);
+	mutex_init(&ras_umc->bank_log_lock);
+
+	return 0;
+}
+
+int ras_umc_sw_fini(struct ras_core_context *ras_core)
+{
+	struct ras_umc *ras_umc = &ras_core->ras_umc;
+	struct ras_umc_err_data *umc_err_data = &ras_umc->umc_err_data;
+	struct ras_bank_ecc_node *ecc_node, *tmp;
+
+	mutex_destroy(&ras_umc->umc_lock);
+	mutex_destroy(&ras_umc->bank_log_lock);
+
+	if (umc_err_data->rom_data.bps) {
+		umc_err_data->rom_data.count = 0;
+		kfree(umc_err_data->rom_data.bps);
+		umc_err_data->rom_data.bps = NULL;
+		umc_err_data->rom_data.space_left = 0;
+	}
+
+	if (umc_err_data->ram_data.bps) {
+		umc_err_data->ram_data.count = 0;
+		kfree(umc_err_data->ram_data.bps);
+		umc_err_data->ram_data.bps = NULL;
+		umc_err_data->ram_data.space_left = 0;
+	}
+
+	ras_umc_clear_logged_ecc(ras_core);
+
+	mutex_lock(&ras_umc->pending_ecc_lock);
+	list_for_each_entry_safe(ecc_node,
+		tmp, &ras_umc->pending_ecc_list, node){
+		list_del(&ecc_node->node);
+		kfree(ecc_node);
+	}
+	mutex_unlock(&ras_umc->pending_ecc_lock);
+
+	mutex_destroy(&ras_umc->tree_lock);
+	mutex_destroy(&ras_umc->pending_ecc_lock);
+
+	return 0;
+}
+
+int ras_umc_hw_init(struct ras_core_context *ras_core)
+{
+	struct ras_umc *ras_umc = &ras_core->ras_umc;
+	uint32_t nps;
+
+	nps = ras_core_get_curr_nps_mode(ras_core);
+
+	if (!nps || (nps >= UMC_MEMORY_PARTITION_MODE_UNKNOWN)) {
+		RAS_DEV_ERR(ras_core->dev, "Invalid memory NPS mode: %u!\n", nps);
+		return -ENODATA;
+	}
+
+	ras_umc->umc_err_data.umc_nps_mode = nps;
+
+	ras_umc->umc_vram_type = ras_core->config->umc_cfg.umc_vram_type;
+	if (!ras_umc->umc_vram_type) {
+		RAS_DEV_ERR(ras_core->dev, "Invalid UMC VRAM Type: %u!\n",
+			ras_umc->umc_vram_type);
+		return -ENODATA;
+	}
+
+	ras_umc->umc_ip_version = ras_core->config->umc_ip_version;
+	ras_umc->ip_func = ras_umc_get_ip_func(ras_core, ras_umc->umc_ip_version);
+	if (!ras_umc->ip_func)
+		return -EINVAL;
+
+	return 0;
+}
+
+int ras_umc_hw_fini(struct ras_core_context *ras_core)
+{
+	return 0;
+}
+
+int ras_umc_clean_badpage_data(struct ras_core_context *ras_core)
+{
+	struct ras_umc_err_data *data = &ras_core->ras_umc.umc_err_data;
+
+	mutex_lock(&ras_core->ras_umc.umc_lock);
+
+	kfree(data->rom_data.bps);
+	kfree(data->ram_data.bps);
+
+	memset(data, 0, sizeof(*data));
+	mutex_unlock(&ras_core->ras_umc.umc_lock);
+
+	return 0;
+}
+
+int ras_umc_fill_eeprom_record(struct ras_core_context *ras_core,
+		uint64_t err_addr, uint32_t umc_inst, struct umc_phy_addr *cur_nps_addr,
+		enum umc_memory_partition_mode cur_nps, struct eeprom_umc_record *record)
+{
+	struct eeprom_umc_record *err_rec = record;
+
+	/* Set bad page pfn and nps mode */
+	EEPROM_RECORD_SETUP_UMC_ADDR_AND_NPS(err_rec,
+			RAS_ADDR_TO_PFN(cur_nps_addr->pa), cur_nps);
+
+	err_rec->address = err_addr;
+	err_rec->ts = ras_umc_get_eeprom_timestamp(ras_core);
+	err_rec->err_type = RAS_EEPROM_ERR_NON_RECOVERABLE;
+	err_rec->cu = 0;
+	err_rec->mem_channel = cur_nps_addr->channel_idx;
+	err_rec->mcumc_id = umc_inst;
+	err_rec->cur_nps_retired_row_pfn = RAS_ADDR_TO_PFN(cur_nps_addr->pa);
+	err_rec->cur_nps_bank = cur_nps_addr->bank;
+	err_rec->cur_nps = cur_nps;
+	return 0;
+}
+
+int ras_umc_get_saved_eeprom_count(struct ras_core_context *ras_core)
+{
+	struct ras_umc_err_data *err_data = &ras_core->ras_umc.umc_err_data;
+
+	return err_data->rom_data.count;
+}
+
+int ras_umc_get_badpage_count(struct ras_core_context *ras_core)
+{
+	struct eeprom_store_record *data = &ras_core->ras_umc.umc_err_data.ram_data;
+
+	return data->count;
+}
+
+int ras_umc_get_badpage_record(struct ras_core_context *ras_core, uint32_t index, void *record)
+{
+	struct eeprom_store_record *data = &ras_core->ras_umc.umc_err_data.ram_data;
+
+	if (index >= data->count)
+		return -EINVAL;
+
+	memcpy(record, &data->bps[index], sizeof(struct eeprom_umc_record));
+	return 0;
+}
+
+bool ras_umc_check_retired_addr(struct ras_core_context *ras_core, uint64_t addr)
+{
+	struct ras_umc *ras_umc = &ras_core->ras_umc;
+	struct eeprom_store_record *data = &ras_umc->umc_err_data.ram_data;
+	uint64_t page_pfn = RAS_ADDR_TO_PFN(addr);
+	int i, ret = false;
+
+	mutex_lock(&ras_umc->umc_lock);
+	for (i = 0; i < data->count; i++) {
+		if (data->bps[i].cur_nps_retired_row_pfn == page_pfn) {
+			ret = true;
+			break;
+		}
+	}
+	mutex_unlock(&ras_umc->umc_lock);
+
+	return ret;
+}
+
+int ras_umc_translate_soc_pa_and_bank(struct ras_core_context *ras_core,
+	uint64_t *soc_pa, struct umc_bank_addr *bank_addr, bool bank_to_pa)
+{
+	struct ras_umc *ras_umc = &ras_core->ras_umc;
+	int ret = 0;
+
+	if (bank_to_pa)
+		ret = ras_umc->ip_func->bank_to_soc_pa(ras_core, *bank_addr, soc_pa);
+	else
+		ret = ras_umc->ip_func->soc_pa_to_bank(ras_core, *soc_pa, bank_addr);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.h b/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
new file mode 100644
index 000000000000..7d9e779d8c4c
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
@@ -0,0 +1,166 @@
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
+#ifndef __RAS_UMC_H__
+#define __RAS_UMC_H__
+#include "ras.h"
+#include "ras_eeprom.h"
+#include "ras_cmd.h"
+
+#define UMC_VRAM_TYPE_UNKNOWN 0
+#define UMC_VRAM_TYPE_GDDR1   1
+#define UMC_VRAM_TYPE_DDR2    2
+#define UMC_VRAM_TYPE_GDDR3   3
+#define UMC_VRAM_TYPE_GDDR4   4
+#define UMC_VRAM_TYPE_GDDR5   5
+#define UMC_VRAM_TYPE_HBM     6
+#define UMC_VRAM_TYPE_DDR3    7
+#define UMC_VRAM_TYPE_DDR4    8
+#define UMC_VRAM_TYPE_GDDR6   9
+#define UMC_VRAM_TYPE_DDR5    10
+#define UMC_VRAM_TYPE_LPDDR4  11
+#define UMC_VRAM_TYPE_LPDDR5  12
+#define UMC_VRAM_TYPE_HBM3E   13
+
+#define UMC_ECC_NEW_DETECTED_TAG       0x1
+#define UMC_INV_MEM_PFN  (0xFFFFFFFFFFFFFFFF)
+
+/* three column bits and one row bit in MCA address flip
+ * in bad page retirement
+ */
+#define UMC_PA_FLIP_BITS_NUM 4
+
+enum umc_memory_partition_mode {
+	UMC_MEMORY_PARTITION_MODE_NONE = 0,
+	UMC_MEMORY_PARTITION_MODE_NPS1 = 1,
+	UMC_MEMORY_PARTITION_MODE_NPS2 = 2,
+	UMC_MEMORY_PARTITION_MODE_NPS3 = 3,
+	UMC_MEMORY_PARTITION_MODE_NPS4 = 4,
+	UMC_MEMORY_PARTITION_MODE_NPS6 = 6,
+	UMC_MEMORY_PARTITION_MODE_NPS8 = 8,
+	UMC_MEMORY_PARTITION_MODE_UNKNOWN
+};
+
+struct ras_core_context;
+struct ras_bank_ecc;
+
+struct umc_flip_bits {
+	uint32_t flip_bits_in_pa[UMC_PA_FLIP_BITS_NUM];
+	uint32_t flip_row_bit;
+	uint32_t r13_in_pa;
+	uint32_t bit_num;
+};
+
+struct umc_mca_addr {
+	uint64_t err_addr;
+	uint32_t ch_inst;
+	uint32_t umc_inst;
+	uint32_t node_inst;
+	uint32_t socket_id;
+};
+
+struct umc_phy_addr {
+	uint64_t pa;
+	uint32_t bank;
+	uint32_t channel_idx;
+};
+
+struct umc_bank_addr {
+	uint32_t stack_id; /* SID */
+	uint32_t bank_group;
+	uint32_t bank;
+	uint32_t row;
+	uint32_t column;
+	uint32_t channel;
+	uint32_t subchannel; /* Also called Pseudochannel (PC) */
+};
+
+struct ras_umc_ip_func {
+	int (*bank_to_eeprom_record)(struct ras_core_context *ras_core,
+			struct ras_bank_ecc *bank, struct eeprom_umc_record *record);
+	int (*eeprom_record_to_nps_record)(struct ras_core_context *ras_core,
+			struct eeprom_umc_record *record, uint32_t nps);
+	int (*eeprom_record_to_nps_pages)(struct ras_core_context *ras_core,
+			struct eeprom_umc_record *record, uint32_t nps,
+			uint64_t *pfns, uint32_t num);
+	int (*bank_to_soc_pa)(struct ras_core_context *ras_core,
+			struct umc_bank_addr bank_addr, uint64_t *soc_pa);
+	int (*soc_pa_to_bank)(struct ras_core_context *ras_core,
+			uint64_t soc_pa, struct umc_bank_addr *bank_addr);
+};
+
+struct eeprom_store_record {
+	/* point to data records array */
+	struct eeprom_umc_record *bps;
+	/* the count of entries */
+	int count;
+	/* the space can place new entries */
+	int space_left;
+};
+
+struct ras_umc_err_data {
+	struct eeprom_store_record rom_data;
+	struct eeprom_store_record ram_data;
+	enum umc_memory_partition_mode umc_nps_mode;
+	uint64_t last_retired_pfn;
+};
+
+struct ras_umc {
+	u32 umc_ip_version;
+	u32 umc_vram_type;
+	const struct ras_umc_ip_func *ip_func;
+	struct radix_tree_root root;
+	struct mutex  tree_lock;
+	struct mutex  umc_lock;
+	struct mutex  bank_log_lock;
+	struct mutex  pending_ecc_lock;
+	struct ras_umc_err_data umc_err_data;
+	struct list_head pending_ecc_list;
+};
+
+int ras_umc_sw_init(struct ras_core_context *ras);
+int ras_umc_sw_fini(struct ras_core_context *ras);
+int ras_umc_hw_init(struct ras_core_context *ras);
+int ras_umc_hw_fini(struct ras_core_context *ras);
+int ras_umc_psp_convert_ma_to_pa(struct ras_core_context *ras_core,
+		struct umc_mca_addr *in, struct umc_phy_addr *out,
+		uint32_t nps);
+int ras_umc_handle_bad_pages(struct ras_core_context *ras_core, void *data);
+int ras_umc_log_bad_bank(struct ras_core_context *ras, struct ras_bank_ecc *bank);
+int ras_umc_log_bad_bank_pending(struct ras_core_context *ras_core, struct ras_bank_ecc *bank);
+int ras_umc_log_pending_bad_bank(struct ras_core_context *ras_core);
+int ras_umc_clear_logged_ecc(struct ras_core_context *ras_core);
+int ras_umc_load_bad_pages(struct ras_core_context *ras_core);
+int ras_umc_get_saved_eeprom_count(struct ras_core_context *ras_core);
+int ras_umc_clean_badpage_data(struct ras_core_context *ras_core);
+int ras_umc_fill_eeprom_record(struct ras_core_context *ras_core,
+		uint64_t err_addr, uint32_t umc_inst, struct umc_phy_addr *cur_nps_addr,
+		enum umc_memory_partition_mode cur_nps, struct eeprom_umc_record *record);
+
+int ras_umc_get_badpage_count(struct ras_core_context *ras_core);
+int ras_umc_get_badpage_record(struct ras_core_context *ras_core, uint32_t index, void *record);
+bool ras_umc_check_retired_addr(struct ras_core_context *ras_core, uint64_t addr);
+int ras_umc_translate_soc_pa_and_bank(struct ras_core_context *ras_core,
+			uint64_t *soc_pa, struct umc_bank_addr *bank_addr, bool bank_to_pa);
+#endif
-- 
2.34.1


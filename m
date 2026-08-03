Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C72C55179
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2026 03:38:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4923910E504;
	Mon,  3 Aug 2026 03:38:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1Lg+/etw";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012016.outbound.protection.outlook.com [52.101.48.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5808910E4FD
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2026 03:38:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JzIgkB4Apuz+S4DnnT0f962W3JbM6ZQS7w2tVJ6jYGGL+c4oIVsb6DQfSsXZQFv3YGKWjSYQ10FNMGUpyyZPSl2+rIEExlhoKDn5R+W813DB3lozlnqEE2KI8o3MOzwETy/MT2teXTmiW7/3UpuJ72qIzuKqCs/l+xrlJlyJP2H05xayxjSMk5vP6KURiyAnIFfNCpCAg2wBrEiVyETMLIiK7D0yLGA4BiMWqG2mfQc3b5iMDoLAM06tSy6Xnl7/2t3tAivn44qK3WlhZMGT4ic3BurXc8ceyR1dn/WcuzCpEWPe7kMJHSlPIL7yypYypBpqjI0c+xQge8y36Rc/RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Edt3ElWma3X+IWHR1Eux8lEqosImaV2BBljrqUWmp8k=;
 b=tmxVB0Ul/9gSEcDYalYD5M5hhRW5t8ARuP0S/iTtKAdXYm0jfFm8PHvvfyXIhweD13KaCsbp2Y3HtA+ETLHBT+MzAqr+fSssUxvEPCFL1RgtbNx7KSWpl4O6mWpDsXdwFqlLlWl7j/i5sG8rOWI/iily31F02fNuAnzv1C1MX6lZE+lB2rxm6hIEVpnEuvlSx+/sisBpYPYZu7mIwYhvbCs0A/zIqtbjIyyoD3QZkV3GYLkZVKHiRI3g3ahuP4oH763swdQEU39FGFVqwyDslwShyyKOC3BhiBceif0ZypOx8vLq+clEiacZ+rUqN9gcplS+59gFt2GS1ISRbFnUFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Edt3ElWma3X+IWHR1Eux8lEqosImaV2BBljrqUWmp8k=;
 b=1Lg+/etw7SqqAVlce4EwtYsc4i4UHqvzuPxT1Eo6f5uYU2fXQ3EP15hTcaNbUfMGKzx/3EgNqiDkLe5SYrz1PiVPhMcOWLS21v24Rhm3rV51DJXnN51C9zuXVuRJvZKq9TxkgMe4DyopNlwFae0j/91gKiEmCcAnYXswI907OVE=
Received: from BN9PR03CA0666.namprd03.prod.outlook.com (2603:10b6:408:10e::11)
 by DM4PR12MB6159.namprd12.prod.outlook.com (2603:10b6:8:a8::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.17; Mon, 3 Aug 2026 03:38:19 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::ae) by BN9PR03CA0666.outlook.office365.com
 (2603:10b6:408:10e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.17 via Frontend Transport; Mon, 3
 Aug 2026 03:38:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 03:38:18 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 2 Aug
 2026 22:38:17 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 2/3] drm/amd/ras: add get_die_id for uniras umc v12
Date: Mon, 3 Aug 2026 11:38:05 +0800
Message-ID: <20260803033806.2881888-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260803033806.2881888-1-tao.zhou1@amd.com>
References: <20260803033806.2881888-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|DM4PR12MB6159:EE_
X-MS-Office365-Filtering-Correlation-Id: f31d7212-9a71-43cc-3895-08def110a8df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: R6RI861BBuOC9dn/vhT0uTOlnds5hUAY/uAdO54z32XhEkQrVuRUR/UvxClI3xPyc0b65LIzJ37O1BHIErW/n/KWqBNyRBVZgIJwlAtUfD4wQbs5/Haj0kjeFKF3gJY8OLBBDpDkrfXZVf1/qkT/ge9fEx1MjhXOpCQKJcAB/otMw73lcY4NQHY/j8wQjFfcnWuDVCfisBT9DhPUwbQY3s1P0kVMXh1NO1+WdoxjVbJpT2QV6Cn4fVueHJqc1t6SsqYVxSBMWul/0XaAFF9fB3bunhra03046MYuwXW3S8i2ABkGQfw4l+kqg1kxH5F3ceFEKl6nZlOuGZU0oiaJpqJq45FUJSaho3OGzKGhTZ7avwYiW/lzEBNDaskHI6pup6ym1JgRCfz8kGMa8Io/+fO94bm/zxBXeRDFtuD0r2F6jLpsc1GQ64tYtgqh4zk08UdlfYVuOszM8qZnwMfka+fGuRYG8aRjjWXzNuuYWerLkswnM+XSKEuwdcaLJWvEks2SQp3nkDXaWJyf3KIkHG4QiW+xnxu8FWQpM3VnlZMp2gG+9U1wle/Eqv5f+x0uOPHOFvPz0geHC9RlCuiqOemjzuYOhgtDU+gmwLorsZzJCgx1NkTv22t2T6SRjw+SaKO/XgVzJJkoxycY9pImj1nlJuBmh97YjYeghio+38Fe5pyo8jUjpn/0iTAHMU6DepS78rOwAch7MOHEc8Ch8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8WYByIFNKPiFHrq0UpYekfLDDWcDxXd98j+eZgNyr7sP76om2Iag+Ty2aCYO8pgF8+t4BnkmYLXfe4p84F9mi4Z4quL5YH9i4uIVlBUTKFEODCWfMRARPLA0kbFcgr4amsTdaDm02TaxE2iuNfAIZadsXTk3UkXia60S5bEme+o2l0xlJLF6RrhcW5wmSxq/Mua748Jm0q+QYswWaGDdsVpRzYKzHDNNwwykV0R1/9oOUxHF23aON4JIQeLhpPxNySQzlDKDyRDQAr0ocnWZXfqjz554ix7DVh9eHvQzPz7+1Y3yH4ymK64I1hR6j3BK3i1CFqwXmyqk1mmM6dFLNCUqSVqHbc/aN9Ru/OwUdpTCNqw2a07ZL9bbeeEF260jrB0JjT+YtNHMIfkXpdP+/CSYnzc1foeqMyrlfnTLxY5858xtmR3df89plOtxLHRx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 03:38:18.7778 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f31d7212-9a71-43cc-3895-08def110a8df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6159
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

For legacy ras eeprom format, die id (node instance) is not stored,
we get it from mca address and physical address (pa) here, and now
we can calculate pa in any nps mode for legacy ras eeprom data as well.

Also refactor eeprom_rec2nps_addr to simplify code.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_umc.c     | 38 ++++++++++++++++---
 drivers/gpu/drm/amd/ras/rascore/ras_umc.h     |  1 +
 .../gpu/drm/amd/ras/rascore/ras_umc_v12_0.c   | 25 ++++++++++++
 3 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
index b8e3a92ab174..becbf8d2d09e 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
@@ -323,8 +323,9 @@ int ras_umc_ma2pa(struct ras_core_context *ras_core,
 	return ret;
 }
 
-static int ras_umc_eeprom_rec2nps_addr(struct ras_core_context *ras_core,
-	struct eeprom_umc_record *record, uint64_t *pa, uint32_t nps)
+static int __eeprom_rec2nps_addr(struct ras_core_context *ras_core,
+	struct eeprom_umc_record *record, uint64_t *pa,
+	uint32_t nps, uint32_t die_id)
 {
 	struct device_system_info dev_info = {0};
 	struct umc_mca_addr addr_in;
@@ -339,7 +340,7 @@ static int ras_umc_eeprom_rec2nps_addr(struct ras_core_context *ras_core,
 	addr_in.err_addr = record->address;
 	addr_in.ch_inst = record->mem_channel;
 	addr_in.umc_inst = record->mcumc_id;
-	addr_in.node_inst = UMC_INV_AID_NODE;
+	addr_in.node_inst = die_id;
 	addr_in.socket_id = dev_info.socket_id;
 
 	ret = ras_umc_ma2pa(ras_core, &addr_in, &addr_out, nps);
@@ -351,6 +352,33 @@ static int ras_umc_eeprom_rec2nps_addr(struct ras_core_context *ras_core,
 	return 0;
 }
 
+static int ras_umc_eeprom_rec2nps_addr(struct ras_core_context *ras_core,
+	struct eeprom_umc_record *record, uint64_t *pa, uint32_t nps)
+{
+	return __eeprom_rec2nps_addr(ras_core, record, pa, nps, UMC_INV_AID_NODE);
+}
+
+/* For legacy eeprom data format, the scope of channel index is
+ * limited to umc instance, and die id is not stored, have to
+ * get it from PA
+ */
+static int ras_umc_eeprom_rec2nps_addr_legacy(struct ras_core_context *ras_core,
+	struct eeprom_umc_record *record, uint64_t *pa, uint32_t nps)
+{
+	uint32_t die_id;
+
+	/* although die id is gotten from PA in nps1 mode, the id is
+	 * fitable for any nps mode
+	 */
+	if (ras_core->ras_umc.ip_func && ras_core->ras_umc.ip_func->get_die_id)
+		die_id = ras_core->ras_umc.ip_func->get_die_id(record->address,
+				RAS_PFN_TO_ADDR(record->retired_row_pfn));
+	else
+		return -EINVAL;
+
+	return __eeprom_rec2nps_addr(ras_core, record, pa, nps, die_id);
+}
+
 static int ras_umc_eeprom_rec2nps_rec(struct ras_core_context *ras_core,
 	struct eeprom_umc_record *record, uint32_t nps)
 {
@@ -375,8 +403,8 @@ static int ras_umc_eeprom_rec2nps_rec(struct ras_core_context *ras_core,
 		/* old eeprom data format, the scope of channel index is
 		 * limited to umc instance
 		 */
-		/* TODO */
-		ret = -EOPNOTSUPP;
+		if (ras_umc_eeprom_rec2nps_addr_legacy(ras_core, record, &pa, nps))
+			return -EOPNOTSUPP;
 	}
 
 	record->cur_nps = nps;
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.h b/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
index 9d32ac344316..44f1b01d217b 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
@@ -133,6 +133,7 @@ struct ras_umc_ip_func {
 		uint32_t nps);
 	uint64_t (*nps_pa_to_row_pa)(struct ras_core_context *ras_core,
 		uint64_t pa, enum umc_memory_partition_mode nps, bool zero_pfn_ok);
+	uint32_t (*get_die_id)(uint64_t mca_addr, uint64_t pa);
 };
 
 struct eeprom_store_record {
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
index 73eb1dba16ec..1ab397e45d3c 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
@@ -489,6 +489,30 @@ static void umc_v12_0_mca_ipid_parse(struct ras_core_context *ras_core, uint64_t
 		*sid = ACA_IPID_2_SOCKET_ID(ipid);
 }
 
+static uint32_t umc_v12_0_get_die_id(uint64_t mca_addr, uint64_t pa)
+{
+	uint32_t die = 0;
+
+	/* we only calculate die id for nps1 mode right now */
+	die += ((((pa >> 12) & 0x1ULL)^
+			((pa >> 20) & 0x1ULL) ^
+			((pa >> 27) & 0x1ULL) ^
+			((pa >> 34) & 0x1ULL) ^
+			((pa >> 41) & 0x1ULL)) << 0);
+
+	/* the original PA_C4 and PA_R13 may be cleared in retired_page, so
+	 * get them from mca_addr.
+	 */
+	die += ((((pa >> 13) & 0x1ULL) ^
+			((mca_addr >> 5) & 0x1ULL) ^
+			((pa >> 28) & 0x1ULL) ^
+			((mca_addr >> 23) & 0x1ULL) ^
+			((pa >> 42) & 0x1ULL)) << 1);
+	die &= 3;
+
+	return die;
+}
+
 const struct ras_umc_ip_func ras_umc_func_v12_0 = {
 	.bank_to_eeprom_record = umc_v12_0_bank_to_eeprom_record,
 	.eeprom_record_to_nps_pages = umc_v12_0_eeprom_record_to_nps_pages,
@@ -497,5 +521,6 @@ const struct ras_umc_ip_func ras_umc_func_v12_0 = {
 	.mca_ipid_parse = umc_v12_0_mca_ipid_parse,
 	.ma2pa = umc_v12_ma2pa,
 	.nps_pa_to_row_pa = umc_v12_0_nps_pa_to_row_pa,
+	.get_die_id = umc_v12_0_get_die_id,
 };
 
-- 
2.34.1


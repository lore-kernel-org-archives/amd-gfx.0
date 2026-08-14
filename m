Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9028BC5B572
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0092710F6F5;
	Fri, 14 Aug 2026 21:03:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RPXo7wKJ";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010069.outbound.protection.outlook.com
 [52.101.193.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 894DC10F6E2
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LVJnhbi7B0KgbAp3/Y7NVDAZj8AqqaiUa4OQa4vZgGfsIXFZodCUlbgJc0c6Yyz5hj6nn3UfU2hQv32FWjmMFH+v19F9DXURLyrFrSkQhv5ZfmtN7wJ2zY0/7kXWBg3g7Dl+IQI+lHIK/o6478N2zaztJPWOSfEAhqN1QpuR25wiLHmo2Fv9wBb9ZRlfNCxFTblO6KJUnnf6PmQyD4s4JpAUesEJhmog+pcjsojKYxNJjMRhNaWpcEOBh5eUfKt0UxVaBDtmSfE+B+T8OteQbgC9336xHXIeikj3nY85NFiUb+o1e1qxYjbKj2RtX0BTBqjJOZCEQUc+hjGl8BnEPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/s/GvCrhSNTNDPsnMdgEodfDyORFnWEcf1kUbWWAC1c=;
 b=RA4kIBNTdmG9ng7U0r7My7WY8QdBtVDweM5FqGA/MMpnAaMKJK/YRDP/CMMsGYyZNe3r+a4ktHILvlHtSVb1PuMDqgcsCTl/qXnfKQ7ZrF4rzHUiCBpfVPhvI6A4ok/N6nqDOohf6C5cqTJtDXCEMABM7QOx7Rgo6DakvgA6bIZSHiqbWLBSKIXvD9PMsJKhmY9hJePr7EtDmnF7CInpes+UsKhQ++nUiGVCBZYqea9s95Qp9pVqBgpNktN13rjM8y4MWkkUE4HfJTC3AlljXgkxhMuC8tFzMoEQmbdFOXbOsCIt46t0yC6WmcmdIHMyj7xnEDuhlz1JdBRnqOQfsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/s/GvCrhSNTNDPsnMdgEodfDyORFnWEcf1kUbWWAC1c=;
 b=RPXo7wKJeqyVwfhbDEsR43pBLcpzqPlyFoHB7lGchN+jCxV11prGTq+0naRvm+wkz1PcdPflbZjefRFXcpMPcQ+9w7G8PF29Hj3rRoizE3fTBGk0UC4jxjNuFKy/yShxSw5yIrgnA6z1oK227CVaPulJOcNfE6MzufA4/nlwENc=
Received: from CH0PR04CA0011.namprd04.prod.outlook.com (2603:10b6:610:76::16)
 by DM6PR12MB4044.namprd12.prod.outlook.com (2603:10b6:5:21d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 21:03:35 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:76:cafe::73) by CH0PR04CA0011.outlook.office365.com
 (2603:10b6:610:76::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:03:35 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:29 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 052/109] drm/amd/ras: use record count instead of bad page
 count for EEPROM threshold checking
Date: Fri, 14 Aug 2026 17:01:49 -0400
Message-ID: <20260814210246.3067612-53-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|DM6PR12MB4044:EE_
X-MS-Office365-Filtering-Correlation-Id: 221ff617-e4f3-46b4-bee5-08defa4781b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|22082099003|18002099003|56012099006|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: ijGPPOvmhtaPnDNAuadsGLUXT6blDpnD+SQGNWy0ozeuPX3RwkrmVSvMASG5tYiacQRX9aXbvsdw7X5aOU5ZnQyMwnuic35ARfiEpnl5Qa4EOZcuUxs1qRna4BSKfXbRQAeYsuXUDjWpzn/MiWBISdP9aK6M680Nbl/g0UCwO+yvMhy/lEDIcJe7bmKz+2RhNpKmry3XSJhjKSrwxY5veV6fl8Z8+uENSQgc4mw66lEUu2Mwqdvnjrq2Vqri4OB/GfA3W4RlXKRvQ9KDdAPaiuU1U5ZCXTIy7hLEaEwsNu/2zaOF0vMCp3una75fECHDRtGrLEFKHXGo3G8U8KWD73lHR3xxhyVuT4tHN0ITxLWhwzR2mc9WEGzPxTf28HMnyqHPH3XzbSkTuGLVH5WKOtbB133LBhLiqYyh/Gl5m5Ox7Ac/95/7K2hkmTgi7l3UxMNOi7a1429jZzB642HrEiq16SygDBLc/RSOjNLFg2WRhUJdMIB4/MiUi2PBv7NKHLPSoQb8sRjCAmrpsVfZD2MWXh56+R9VdRA6/wC70hBehEmJKyTxztz8wVdzESwWDd/YcSWrVvfYAo6Y5Xb/kH/MV3dia/d6yk/fEQ5wvjeE0XGq+yoYOuZqNygBbXZzjPUyjynOLe6XxPd9TC7baOnDpLhrZQ2GGJDE7vwOApo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(22082099003)(18002099003)(56012099006)(6133799003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Gxpmdf3H1v4H2DjkV+v893RkMbw/txdIOgBSxHY05aSUtsjxymNxvJNVfJE64JnuNx6Z6xHXR4vgKh5AWUocOlMK3fOzGWpLIFlYeR8Ca7YFPVOPBDgaOMyfKCfU7zosiFwZEhwZz9ABQn+cE+xHtAbGm/WeWLzosaVwIPmZU/8zJtOmUz7O1w/T5wHCL9Rjuts1FFoJZx0wQ3WCJ2MmVuYPJKpzAQTASHB6+9w93j5pF8HKiv0aPvYfzPWvb7HStCjtJPbpsyouCQ4hSDm0mtipaqrcVcoHCQAWlinqcAKC5wyKjVFljZj/eQYsdELXA5WyNxu3DR03/Ch6FSGp6Fre8bVZZiNtoVbSL/cOlXnxHm3dPR1lMdiYV9O1CM2vHcSYBcgb8bpRDIVaYql82dZkHQqdA/+KiMCEEKN5/bIQ75OSUnpTT96Y5yju3dw8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:35.8855 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 221ff617-e4f3-46b4-bee5-08defa4781b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4044
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

- Since EEPROM threshold configuration is record count, use
  record count instead of bad page count for EEPROM threshold
  checking.
- RMA check and notification have been moved to ras_eeprom_mgr.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/eeprom.c | 28 ++++++---------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/eeprom.c b/drivers/gpu/drm/amd/ras/core/eeprom.c
index 01e4cde581f42..6b8f9fec5da80 100644
--- a/drivers/gpu/drm/amd/ras/core/eeprom.c
+++ b/drivers/gpu/drm/amd/ras/core/eeprom.c
@@ -732,35 +732,20 @@ static int ras_eeprom_append_table(struct ras_eeprom_control *control,
 static int ras_eeprom_update_header(struct ras_eeprom_control *control)
 {
 	struct ras_core_context *ras_core = to_ras_core_context(control->mgr);
-	int threshold_config = control->record_threshold_config;
 	u8 *buf, *pp, csum;
 	u32 buf_size;
-	int bad_page_count;
+	int record_count;
 	int res;
 
-	bad_page_count = ras_umc_get_badpage_count(ras_core);
-	ras_core_event_notify(ras_core, RAS_EVENT_ID__UPDATE_BAD_PAGE_NUM,
-			      &bad_page_count);
-
+	record_count = ras_umc_get_saved_eeprom_count(ras_core);
 	/* Modify the header if it exceeds.
 	 */
-	if (threshold_config != 0 &&
-		bad_page_count > control->record_threshold_count) {
-		RAS_DEV_WARN(ras_core->dev,
-			"Saved bad pages %d reaches threshold value %d\n",
-			bad_page_count, control->record_threshold_count);
+	if (record_count >= control->record_threshold_count) {
 		control->tbl_hdr.header = RAS_TABLE_HDR_BAD;
 		if (control->tbl_hdr.version >= RAS_TABLE_VER_V2_1) {
 			control->tbl_rai.rma_status = RAS_GPU_RETIRED__ECC_REACH_THRESHOLD;
 			control->tbl_rai.health_percent = 0;
 		}
-
-		if ((threshold_config != WARN_NONSTOP_OVER_THRESHOLD) &&
-			(threshold_config != NONSTOP_OVER_THRESHOLD))
-			ras_core->is_rma = true;
-
-		/* ignore the -ENOTSUPP return value */
-		ras_core_event_notify(ras_core, RAS_EVENT_ID__DEVICE_RMA, NULL);
 	}
 
 	if (control->tbl_hdr.version >= RAS_TABLE_VER_V2_1)
@@ -801,11 +786,10 @@ static int ras_eeprom_update_header(struct ras_eeprom_control *control)
 	 * bad page records have been stored in eeprom,
 	 * now calculate gpu health percent
 	 */
-	if (threshold_config != 0 &&
-	    control->tbl_hdr.version >= RAS_TABLE_VER_V2_1 &&
-	    bad_page_count <= control->record_threshold_count)
+	if (control->tbl_hdr.version >= RAS_TABLE_VER_V2_1 &&
+	    record_count <= control->record_threshold_count)
 		control->tbl_rai.health_percent = ((control->record_threshold_count -
-			bad_page_count) * 100) / control->record_threshold_count;
+			record_count) * 100) / control->record_threshold_count;
 
 	/* Recalc the checksum.
 	 */
-- 
2.55.0


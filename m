Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A771E8304D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 04:12:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 210FD10E305;
	Tue,  3 Feb 2026 04:12:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hObzstLT";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010015.outbound.protection.outlook.com
 [52.101.193.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CADB10E4EA
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 04:12:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qKdSd6lszDpCxQ2qs9d3psJ3eoAQQZJS5nHoi0f+gUE8Bjmiq17GwYdohzfLAd4Oxh44C8ZeLbdxYABYXQfAW/MZhTwIL37I9ikf4FrNBhFgCXt/iag03Xq074yhGcwc8v6CulyWj3vy6uvYgZrzkTQbVQFCdEI2YSETgsjXQM9rnl1ajjAklQuBu49fEvkmbStBx/laZ8PTXRSMYM/g7t2gFPWcms/4Qmey6FGYTy+Ufs7jGH1xv6Ks+UMU5P2hU9qpveeiqbIgKjFGml42ETBurqBF287ZlDT7o53WGqAOSXeWojG02ZaRlJcwDLd+pYf8VNMxoVS2RJUhywqbrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kg7U5onN+odpUeQesO0XotfUzEXLHz/1nRwlh5a7QPQ=;
 b=w9pom1n8fa1D0PcYiUzCWfya1cOJ3XL9rux6WMkyp5w6aE+j//QVP81tMqmV+KCiZzffPfErfkPqWOxEVGHbTnXB0klAV5kWCE6vN2HmpMXfVY8XgElbGK2uIK9QUDM3Y177EdMXk6Z/tTACF+RNuAGoNtHBmAf9WDOTJ9BO+I0TFaGREWlNGQUr8tcmZfyZFmPzqi2WHdIOa437vSljtxVeK84f/rMsJK+nCR+jwHbaMfSuHP025gDVxxRBrxWe3wl7MVaIzO0MlCO2bmAZRyWBOjk1D8dgq5JKP8b4z56wAa84HDRgG8/KcMKqH5xLGtNRsJyuJI4n52Xu/XCpRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kg7U5onN+odpUeQesO0XotfUzEXLHz/1nRwlh5a7QPQ=;
 b=hObzstLTjCnh58PeQYv+rOyIPBbnvLxU21KXMapP3/fGh/fbX9SBKK1IRpAnUH9egST/4ZT9ckaJuWYvrQCS0sr3K2IP4ijdRLdtXlHufPb+jNZX5Skkf4lGT6VxFRfxVuaQfpN0YxVbYtQ5Maq1B1agZ5N9lHZdSAc5ZAF0Vp8=
Received: from BN9PR03CA0457.namprd03.prod.outlook.com (2603:10b6:408:139::12)
 by CH3PR12MB7569.namprd12.prod.outlook.com (2603:10b6:610:146::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 04:12:53 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:408:139:cafe::27) by BN9PR03CA0457.outlook.office365.com
 (2603:10b6:408:139::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 04:12:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 04:12:52 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 2 Feb 2026 22:12:50 -0600
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <YiPeng.Chai@amd.com>, <KevinYang.Wang@amd.com>,
 Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH V2 06/14] drm/amd/ras: Add table reset func for pmfw eeprom
Date: Tue, 3 Feb 2026 12:11:58 +0800
Message-ID: <20260203041206.1299104-6-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203041206.1299104-1-ganglxie@amd.com>
References: <20260203041206.1299104-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|CH3PR12MB7569:EE_
X-MS-Office365-Filtering-Correlation-Id: 78bfe0c1-8fa5-41a0-b03f-08de62da8047
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C7qnaN+dL+4BFUgzvA8RAsbl94T/dVXDFA7+ALNiaualbEsAkT4uV2Ma3RCQ?=
 =?us-ascii?Q?0DuGDPBObPtrJo6BD1YROjtQPpe0uJYguTaDKn2lOajb0xhWqhnYy9WPiZIR?=
 =?us-ascii?Q?Ds9Egi/PHM0dmS9WmzPcjZBggBdBgiuVlH3eEG108AV3ZwA1f2m3gMkT9rBu?=
 =?us-ascii?Q?nNJdFVN06aUCXkVjoZgi6Wdw7HATG1wcmWuRDgL7pDxSsMF7PcPCfF6yL93g?=
 =?us-ascii?Q?wPg20X5IxTdtqDj2ozMMw6cMhmPe+lZyMtMClYc9LrGHZ7K8uCQKokdgOF6q?=
 =?us-ascii?Q?lg75KpZc+GWAczGVMSV2qUnYR9ud15JLICgO1YlpceOm4akNIxne/B1aIo+r?=
 =?us-ascii?Q?uCtEUvbhGCIdXaTT2B5O9m8z4d6zjckKq6wNVVXXsksKfR3fLPa/YeSQjQEI?=
 =?us-ascii?Q?PMtus0JVJ3VZ71QMyzTHCoRl9u4eyYOfYbUBRnvMSJRuAvvrG54JKuhlf7bL?=
 =?us-ascii?Q?/0ve8BPlkNFZWacvOCYClT99AYgGu2bZuBvxTHX3j3RpZmzYDy1MNG1f1yUa?=
 =?us-ascii?Q?TEweXfYMnslvBS1idqt/qs8cxq/uV7xuMlspmSvJLZBNp0NhyalXcKIN6IvY?=
 =?us-ascii?Q?BMW4aFBjvjoCwMeBq+pWrbRvoVqZNdogyFVDK84TRzzq86NyRZmfVacrAyRa?=
 =?us-ascii?Q?fZd59mH/yzKSQLXc2sJ3b/ufo+vxIO6B0MWO2OSNpikaM0seLhP81/kaamYG?=
 =?us-ascii?Q?zy2ue6vntax/XMJ6MkXXP3ot/DBqoJrpwRwfmkLhPnbbuzChaQWvmeO+hF7V?=
 =?us-ascii?Q?qZhEusZQxQZcWVI0JLvRyBU6s14+Ls3fHrKRkekuVxxvwNmhFntilIB9pcDh?=
 =?us-ascii?Q?OsffWQOgjqno1yO9TSso9SX0SwpeMMbkKOJCK+/P39pWo5fvzUPD15TJhaMZ?=
 =?us-ascii?Q?t/zxzDsMWZLfYHYt9AnRzRwoTZXsWOBwia1EfruuBNSPnaKrC8IWMd+3C4dY?=
 =?us-ascii?Q?AVwa+ltgDIVAEcRQzZAwEppd4CfrejGRFhhIsPMvz1kPY+arkoyz6trCIYk5?=
 =?us-ascii?Q?DUgl18QClhU8aHdo5snDs+hP3OQ5GufxHxuWLAa44lg8Qa6oPb3+DjDhxli7?=
 =?us-ascii?Q?lbByKsC4WPKx+Twg0l56YNM3ePPsorgPM1BfSKFNF+nSXRY6ZDwGVGB2mCR7?=
 =?us-ascii?Q?MaWbttz+eQJr4VgiWci6KS9b+59Mz7tZ7M8PVEIm161T0Ft/5C6kTJHtPT1E?=
 =?us-ascii?Q?KYEp6Dt+ly7E3PEUIR+pmMvuVnAoP779pXYD3MyF3ENj49FC+HpE1TlCRXR+?=
 =?us-ascii?Q?y1PdQkzIQUU0Qlu0FScFS4je+uKLXBwxpPJbEaW1w9fHHwo+TZDU6dLsXXxK?=
 =?us-ascii?Q?iUN1rqOXG3VDc/sLxvgBfMhz6ItIUFGwOypgh8Swqn+7GK6aNgN/kbWgU7H3?=
 =?us-ascii?Q?Z6+ZjgiqyMVigOi+ih4TXfm682NUhmmjCrxZNie/sa7UjCnKUo8rHlBBQRNK?=
 =?us-ascii?Q?gaiFpKyEwhBfDwBAYpJi4/ELKBYcILkYBWPm1Rel9dMnbsiVfPoKor3h/Q2b?=
 =?us-ascii?Q?WQJpAwz2pOmbjmhDHB4A2AOjwLp8qvXGtjWRyiUe4D3MEky8Wy2qpNedYBPq?=
 =?us-ascii?Q?y0P+17EGR3eVzoFL+Q9/20/V4yrJ+272IpP5e3RDo8yiPinSG1qGU0JDvqyV?=
 =?us-ascii?Q?DRWVSjhxOV169GWQyQx0bzSY6iorborsySea0IVugEBccfxrWR/iDLto7E5R?=
 =?us-ascii?Q?qZ7wug=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hVJwLMWhDQ1Zf8B9eCRwYww+GJSnfJIl9BjwM+jHai3UG+ALmWO7vrjviu+kPclGCXI/G/1H4RoVQVxKhTLTH7x2T5nxQBm/6WRpmmPk8tqNXBR0D57Y6b6founx/RBAWS2ueFjM6jXK4xyI2ws4CYDdjiKnPq0FiYOoRUHPV4KUgB2u0/CWGFoTzYlQScNc3LjBMsQWiPYL291R4OHlm5xhZbWcDfMfjHLi4owpct8JP+jBj3ThOs92/j6JzX4+OoMTPjFh2busLmSd1Lxtpd2wYZnA+D3YCR6rRCqnOjLmEVtDmiE0k/9HNq2nbg5FAjYMtgO23U9hU1TVPYo3cQbE90Z3QhrNCBJ9KFEpNAUX7baKNF21MLfNh6IxH3B678MBxKAR36lQ/gk2G0S1QGQ3Vzq+6fOLgpPbExcZSuYc4icDpWMmgWmHYkjjxCHf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 04:12:52.7322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78bfe0c1-8fa5-41a0-b03f-08de62da8047
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7569
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

add table reset func for pmfw eeprom, add smu eeprom control
structure

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras.h         |  1 +
 drivers/gpu/drm/amd/ras/rascore/ras_cmd.c     |  9 ++++--
 .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.c   | 29 +++++++++++++++++++
 .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.h   | 26 +++++++++++++++++
 4 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras.h b/drivers/gpu/drm/amd/ras/rascore/ras.h
index 6e223eff522c..ae10d853c565 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
@@ -313,6 +313,7 @@ struct ras_core_context {
 
 	bool ras_eeprom_supported;
 	struct ras_eeprom_control ras_eeprom;
+	struct ras_fw_eeprom_control ras_fw_eeprom;
 
 	struct ras_psp ras_psp;
 	struct ras_umc ras_umc;
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c
index 94e6d7420d94..4f89810d85a1 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c
@@ -146,8 +146,13 @@ static int ras_cmd_clear_bad_page_info(struct ras_core_context *ras_core,
 	if (cmd->input_size != sizeof(struct ras_cmd_dev_handle))
 		return RAS_CMD__ERROR_INVALID_INPUT_SIZE;
 
-	if (ras_eeprom_reset_table(ras_core))
-		return RAS_CMD__ERROR_GENERIC;
+	if (ras_fw_eeprom_supported(ras_core)) {
+		if (ras_fw_eeprom_reset_table(ras_core))
+			return RAS_CMD__ERROR_GENERIC;
+	} else {
+		if (ras_eeprom_reset_table(ras_core))
+			return RAS_CMD__ERROR_GENERIC;
+	}
 
 	if (ras_umc_clean_badpage_data(ras_core))
 		return RAS_CMD__ERROR_GENERIC;
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
index f880fc49477d..ae63e7394829 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
@@ -161,3 +161,32 @@ int ras_fw_erase_ras_table(struct ras_core_context *ras_core,
 	return sys_func->mp1_send_eeprom_msg(ras_core,
 			RAS_SMU_EraseRasTable, 0, result);
 }
+
+int ras_fw_eeprom_reset_table(struct ras_core_context *ras_core)
+{
+	struct ras_fw_eeprom_control *control = &ras_core->ras_fw_eeprom;
+	u32 erase_res = 0;
+	int res;
+
+	mutex_lock(&control->ras_tbl_mutex);
+
+	res = ras_fw_erase_ras_table(ras_core, &erase_res);
+	if (res || erase_res) {
+		RAS_DEV_WARN(ras_core->dev, "RAS EEPROM reset failed, res:%d result:%d",
+									res, erase_res);
+		if (!res)
+			res = -EIO;
+	}
+
+	control->ras_num_recs = 0;
+	control->bad_channel_bitmap = 0;
+	ras_core_event_notify(ras_core, RAS_EVENT_ID__UPDATE_BAD_PAGE_NUM,
+		&control->ras_num_recs);
+	ras_core_event_notify(ras_core, RAS_EVENT_ID__UPDATE_BAD_CHANNEL_BITMAP,
+		&control->bad_channel_bitmap);
+	control->update_channel_flag = false;
+
+	mutex_unlock(&control->ras_tbl_mutex);
+
+	return res;
+}
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
index 46f45e82a3f3..a1003db3c33b 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
@@ -24,6 +24,31 @@
 #ifndef __RAS_EEPROM_FW_H__
 #define __RAS_EEPROM_FW_H__
 
+struct ras_fw_eeprom_control {
+	uint32_t version;
+	/* record threshold */
+	int record_threshold_config;
+	uint32_t record_threshold_count;
+	bool update_channel_flag;
+
+	/* Number of records in the table.
+	 */
+	u32 ras_num_recs;
+
+	/* Maximum possible number of records
+	 * we could store, i.e. the maximum capacity
+	 * of the table.
+	 */
+	u32 ras_max_record_count;
+
+	/* Protect table access via this mutex.
+	 */
+	struct mutex ras_tbl_mutex;
+
+	/* Record channel info which occurred bad pages
+	 */
+	u32 bad_channel_bitmap;
+};
 
 void ras_fw_init_feature_flags(struct ras_core_context *ras_core);
 bool ras_fw_eeprom_supported(struct ras_core_context *ras_core);
@@ -41,5 +66,6 @@ int ras_fw_get_badpage_ipid(struct ras_core_context *ras_core,
 				    uint16_t index, uint64_t *ipid);
 int ras_fw_erase_ras_table(struct ras_core_context *ras_core,
 				   uint32_t *result);
+int ras_fw_eeprom_reset_table(struct ras_core_context *ras_core);
 
 #endif
-- 
2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673DDC5DF7A
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FEDA10F72D;
	Fri, 14 Aug 2026 21:03:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KG7U6pdQ";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012044.outbound.protection.outlook.com [52.101.53.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5440910F701
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MnV/52/pm9Ju4WuP+ndyhE0FlP34gy5OzO8Br3tZU5DNjrA80D+rN2a2Vpi1H+HgIjKxrLDmvLgbfPPFK+plrMBQNveLze2OqnqTkknsdCLxTSqeKwXBRCpGqoFtJUYnoTdiXYY7WqMONNMz2byv5EobLp6cC/G6s/PWhgtrdkBRWAAIrPrWYDyODT2ViEV5Q+oH9rwm8CTv/klodW05awBOp8pKBAzTCRHx4u+eKfgazlpxbOvjq2o3cuHLsJQ43xJH8tjYm7Cb11hO+q33cTK2mOYbyJOmZUHPkxMkdJWZC1CWbo7B4Unbb9Enc8VknlugFuzPw2Fe3Dlh0w2pHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIZXeATPBXaLrdD+1uiEBZKAmFcllEKZMzCCnscj5qU=;
 b=S9kQ4bWTGl+nQAyH2t6fja2q9aP0A2ff+FvBFXULHLJt+hYQDWgXow3N93X7SV+GXZLQCtwWM4cvxaw/1/AgYHqbZi1UbT9lOBxsEqyj0CnjXdmavH043hb6fSFHquFJMA6RECPbkSQKecXws3H6M45WOLLZLkQG8cSdjKw0B6XvrV2L+j/+/yTB/9B62lm6WXeM1U4odTv+y5RuPvw27R4j8Th1Ga+acyhLeYwkdjC2QUUdrQlO6whmFqMpn7641rdDCsrYIsDKtxBGJymGlxHvjY4GThlRyQPu4W3hwVKdI1K6vOClR0DtGGf+m4NLW6/kMRt9dwpCZ6fBuuRiug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIZXeATPBXaLrdD+1uiEBZKAmFcllEKZMzCCnscj5qU=;
 b=KG7U6pdQPx66EdCuYvkLKghozsfTppIlWlBGSL8fR8EgNYpLRSbFT1kzCUFZAczrZ/GGNqIyFuC3K3Fs+DzD2ocQd+Mbk0EAMdvBK2P+TKpWhYk2/PYum22Ug6HRsfhL02xLdSZMMzfl+F6prbL2guenXdJeAqTWAM3bY8P53NE=
Received: from CH2PR10CA0028.namprd10.prod.outlook.com (2603:10b6:610:4c::38)
 by CH3PR12MB8459.namprd12.prod.outlook.com (2603:10b6:610:139::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 21:03:42 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:4c:cafe::10) by CH2PR10CA0028.outlook.office365.com
 (2603:10b6:610:4c::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Fri,
 14 Aug 2026 21:03:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:03:40 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:38 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 067/109] drm/amd/ras: fix silent error swallowing in
 get_record_count paths
Date: Fri, 14 Aug 2026 17:02:04 -0400
Message-ID: <20260814210246.3067612-68-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|CH3PR12MB8459:EE_
X-MS-Office365-Filtering-Correlation-Id: fa18c606-18a8-44ab-fc2f-08defa478474
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|6133799003|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: H3K/sNqa+G8U5N6tr48wT5oUx6tZ439umo2Z1hRQFD4+vjPYMPMNUzhiTUGl9lewq0HfTerrA9VLQ2FNPLTWVqdJQjelMC27Y0lcC3ysDwIW85BQLPZGlHXMiU9QLSgYxG3v0X/yTaAcxtKxwQCJygaV9ptV7djIYQ25CZovl54LdHoT0cz4SbNbLCwaoq2ily1/EHS7+einnDSacszIDO58NCopGh0R1kL1v8u6auTBMrO2dCv60LCvwJmUaQbUjBilKYOFipxd+O/RsOaqIAY0hmj2DMJ/RIVjKjV7u9Ikw3yetlrlTub3+GO5Yc7enveSng1TKpQZWW+9aKVtpk+h1sUeTxXrEZcJhYjJHIOHrIDhGe6BMqeTj6n+BsduX9PRXT7ZBWQz8SRZB9YBsZaVS/h51KDdXxF0PflH1X9rjJL2vrYGXfwJxTWmJU/rh20u6U+5PYQgHG9hUwx62d/aawWjRH3sM817C0W2X/D3Z1rckh4DOdRPBFqjiG8hs3eJolC0rN7E9gcVnzH3MkCzLLMXHo+aFApVwt/iU4H0UTK/bwCbEM/TLMRvRBNmqwY8aFyArGJ0YNxoD9Cx/In1VoSmVW0QksKaYLm83Jpq2RpHTeB7Lkxudeh4seDRjU4QLlhftAYR8bqOL4S1rqmGK99/VgKP/Vzv3k8zd04=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(6133799003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wiS//K3guKaUHND8fV9P60Mp7HbndMcTvgtJhG4ysoLzz3sAj6E0tkbWiKncFwLrZJHD/mzTPimTHNnZObTOhUm+MGvBp+/vOHMVvtBrBvY9fygwN4Q15WNkxD459hnzEL23tLRBxBIhCsHmdkcVFVSKAQ8Z9zWzFjvlz8dqJC679NSElQwzpQHV52Ozp1KmZb7IjnSE57sO3UUkGN/yK8S9eCY7EGl1hM7SOy3t8ZJjeAAGjQY2tE40YJkvUKTe8XkkY32PjJ2uUsHbFeXmY0sOfbmsCyKUJC1ihg8Ry8IG3h1ubqSQTXysq4KnFg201poCDdS1fveglJXLFOBvxcOZ/I26g7j5sE5KpwQbQYXXz5UBgY//iAsjqARtv/KaOj09MXmfbNsGepAQ8qXhshu2e26e+mv9LLQzMc/BlLgIpR4Ut/O4vvtzjPyc9iy9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:40.4771 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa18c606-18a8-44ab-fc2f-08defa478474
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8459
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

Fix silent error swallowing in get_record_count paths.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/core.c           |  4 ++--
 drivers/gpu/drm/amd/ras/core/eeprom.c         |  4 ++--
 drivers/gpu/drm/amd/ras/core/eeprom_fw.c      |  4 ++--
 drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.h |  2 +-
 drivers/gpu/drm/amd/ras/core/ras_umc.c        | 17 ++++++++++-------
 5 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/core.c b/drivers/gpu/drm/amd/ras/core/core.c
index f093f29635888..00dc6084454cd 100644
--- a/drivers/gpu/drm/amd/ras/core/core.c
+++ b/drivers/gpu/drm/amd/ras/core/core.c
@@ -274,8 +274,8 @@ static int ras_core_eeprom_recovery(struct ras_core_context *ras_core)
 	int ret;
 
 	count = ras_eeprom_mgr_get_record_count(ras_core);
-	if (!count)
-		return 0;
+	if (count <= 0)
+		return count;
 
 	/* Avoid bad page to be loaded again after gpu reset */
 	if (ras_umc_get_saved_eeprom_count(ras_core) >= count)
diff --git a/drivers/gpu/drm/amd/ras/core/eeprom.c b/drivers/gpu/drm/amd/ras/core/eeprom.c
index 3c16446ddfc47..61cc0538f4622 100644
--- a/drivers/gpu/drm/amd/ras/core/eeprom.c
+++ b/drivers/gpu/drm/amd/ras/core/eeprom.c
@@ -1141,12 +1141,12 @@ static int ras_eeprom_hw_fini(struct ras_core_context *ras_core)
 	return 0;
 }
 
-static uint32_t ras_eeprom_get_record_count(struct ras_core_context *ras_core)
+static int ras_eeprom_get_record_count(struct ras_core_context *ras_core)
 {
 	struct ras_eeprom_control *control = ras_core->eeprom_mgr.ras_eeprom;
 
 	if (!control)
-		return 0;
+		return -EINVAL;
 
 	return control->ras_num_recs;
 }
diff --git a/drivers/gpu/drm/amd/ras/core/eeprom_fw.c b/drivers/gpu/drm/amd/ras/core/eeprom_fw.c
index 5f86ff54d9ed7..02369d54bdffd 100644
--- a/drivers/gpu/drm/amd/ras/core/eeprom_fw.c
+++ b/drivers/gpu/drm/amd/ras/core/eeprom_fw.c
@@ -97,12 +97,12 @@ static int fw_eeprom_sync_data(struct ras_core_context *ras_core,
 	return ret;
 }
 
-static u32 fw_eeprom_get_record_count(struct ras_core_context *ras_core)
+static int fw_eeprom_get_record_count(struct ras_core_context *ras_core)
 {
 	struct fw_eeprom_control *ctl;
 
 	if (!ras_core->eeprom_mgr.ras_eeprom)
-		return 0;
+		return -EINVAL;
 
 	ctl = ras_core->eeprom_mgr.ras_eeprom;
 
diff --git a/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.h b/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.h
index 873c96b287845..b15682b44a6ef 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.h
+++ b/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.h
@@ -80,7 +80,7 @@ struct ras_eeprom_ops {
 		struct eeprom_umc_record *records, u32 num);
 	int (*append_records)(struct ras_core_context *ras_core,
 		struct eeprom_umc_record *records, u32 num);
-	u32 (*get_record_count)(struct ras_core_context *ras_core);
+	int (*get_record_count)(struct ras_core_context *ras_core);
 	int (*get_eeprom_info)(struct ras_core_context *ras_core,
 		struct ras_eeprom_info *eeprom_info, bool fast_mode);
 	int (*unlock_eeprom)(struct ras_core_context *ras_core);
diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc.c b/drivers/gpu/drm/amd/ras/core/ras_umc.c
index 3558d4633a4e7..32203e85ef14b 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_umc.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc.c
@@ -676,12 +676,12 @@ int ras_umc_add_bad_pages(struct ras_core_context *ras_core,
 int ras_umc_load_bad_pages(struct ras_core_context *ras_core)
 {
 	struct eeprom_umc_record *bps;
-	uint32_t ras_num_recs, c = 0;
-	int ret;
+	uint32_t c = 0;
+	int ras_num_recs, ret;
 
 	ras_num_recs = ras_eeprom_mgr_get_record_count(ras_core);
-	if (!ras_num_recs)
-		return 0;
+	if (ras_num_recs <= 0)
+		return ras_num_recs;
 
 	bps = kzalloc_objs(*bps, ras_num_recs);
 	if (!bps)
@@ -710,7 +710,7 @@ static int ras_umc_save_bad_pages(struct ras_core_context *ras_core)
 	struct ras_umc *ras_umc = &ras_core->ras_umc;
 	struct eeprom_store_record *data = &ras_umc->umc_err_data.rom_data;
 	struct eeprom_store_record *ram_data = &ras_umc->umc_err_data.ram_data;
-	uint32_t eeprom_record_num, logical_count = 0;
+	int eeprom_record_num, logical_count = 0;
 	int save_count;
 	int ret = -ENODATA;
 
@@ -722,6 +722,9 @@ static int ras_umc_save_bad_pages(struct ras_core_context *ras_core)
 		return -EINVAL;
 
 	eeprom_record_num = ras_eeprom_mgr_get_record_count(ras_core);
+	if (eeprom_record_num < 0)
+		return eeprom_record_num;
+
 	mutex_lock(&ras_umc->umc_lock);
 	save_count = data->count - eeprom_record_num;
 	logical_count = ram_data->bad_page_num - ram_data->bad_page_num_old;
@@ -981,8 +984,8 @@ int ras_umc_dump_fw_records(struct ras_core_context *ras_core)
 
 	eeprom_count = ras_eeprom_mgr_get_record_count(ras_core);
 	/* no bad page record, skip eeprom access */
-	if (!eeprom_count)
-		return 0;
+	if (eeprom_count <= 0)
+		return eeprom_count;
 
 	umc_count = ras_umc_get_saved_eeprom_count(ras_core);
 	if (umc_count == eeprom_count) {
-- 
2.55.0


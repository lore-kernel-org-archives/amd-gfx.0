Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D062C5DF7B
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB59B10F71D;
	Fri, 14 Aug 2026 21:03:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SosY/c+f";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011045.outbound.protection.outlook.com [52.101.52.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B247F10F705
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ngv5oPZ125W/Qxi4CpyhD4FayxhWS9WerhM4SaNs84ECFeBxWSZJB5IRdA4bH+6QO776Om1JzKfqQcMAhSd9qOG0FrjkYXg4lGuqAhG3joQl953AoabOSvMNhGUdn3Miu45HmN8u0nZAh7zpCdcrfNsKsmm337uhm3lQodF5nuFijczaWp0gUnisHHrvaWqJRFFm8nWusQ1Lbd+2i9y9qsc6U8XlSUju4svO+3yzMbbK7gQisqjk60J5fMSGegMF9BK/OrVSSuBTqm3/GFNllt4gZkFJ0Fk6LA00Vr0izd+/TpGrsJcedpTSNa4Ga+OKFuV5pyCqrDWPtAe9d1+x6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+al8+IWr9QCiiEGW9tClNNsrJtI6xF0EwIlYbbspZw=;
 b=HBVX0QujrQr3XIKElpqWCKffKwID7JePJzOx+ZrNDgQDOJB36pG4YiUsHfJ37yB4+dhIixPzl/34fUMtVCYeQZFWVjVQGIZ8gqGpmCU2I27PwPOTpiVK0d5l0u2RE7JhhBtmIKfEpkB8fE7iFZBex3X8lT+1NEYLQ8c/Sj4aI0EBNXZg8R1uEPFLjBMg89LOO+quTWOpYR3l4pVnX9MtSb/UdILUAQA8Fnx0+EXA8ujaJOWCH5UEfmWoy5ow0FqcHl/4kZsrhOAWaf3c7M7KCSStggU3wv8sNWQdSKQ6n3zBs77cPSHg7mTDBGDj7unPSJ9cvLuC72efLFvLt6rxLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+al8+IWr9QCiiEGW9tClNNsrJtI6xF0EwIlYbbspZw=;
 b=SosY/c+fqb+/yXevaqQtBGcnykneIufAFuQq/W7Y1dZVYxh79AAGLV4wTPTinv13ZapBN5vVakjxUof2I2Lkg4epDLRrBMnD5vn5TeQM9Ypa8fewwpGewJns0g0tkTh8Dcpqm1Injl9l5ctqLNQ3AWkb9ix5gKtxxy3n+ohGjSE=
Received: from DS1PR07CA0028.namprd07.prod.outlook.com (2603:10b6:8:44d::17)
 by DS0PR12MB8071.namprd12.prod.outlook.com (2603:10b6:8:df::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.15; Fri, 14 Aug 2026 21:03:33 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:8:44d:cafe::b) by DS1PR07CA0028.outlook.office365.com
 (2603:10b6:8:44d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:03:33 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:26 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:25 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 047/109] drm/amd/ras: add interface to obtain FW eeprom
 records at runtime
Date: Fri, 14 Aug 2026 17:01:44 -0400
Message-ID: <20260814210246.3067612-48-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|DS0PR12MB8071:EE_
X-MS-Office365-Filtering-Correlation-Id: 655ccee1-0417-4839-af62-08defa478027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 6cjALb5+SbuhsxHh5U8CBFMmoXq8qUQyZTPeIRE8OYtnxWP/MnOttdj+klrNf0Uaz5ngGN1/WayDxfZmMYFsCZOqEZpLpB8SX/cxkssaTURFUY4uh8K8hkT9CbQ2AKoQnCGmCRDS88eBi/NS+I8eFV3knwjDJnWTjp65ahZWiTk1Q51jGaQhX2QL+Go7HhlBbCOexHp5AFmApC2J39EFJsfSawQ9iS6AfLZkMQQlh9iGMriDiK37ZHQRdQTIkxnaxdmu4GCElijfxzUmdbMSG+/gk1dmbGWeKp0M7LN5IRbAJow1y/61VSax1hFDIcwIgZfxUWMvpIl1OZi55WZsJ7x5hWeBrPalaYB9FBBGpzc4FIG3TMxtKIckEGaGp5vE7S4gZFH3Ww5sKDbAXr6XXK6YjQ8rSyqatoPYARSAQ0ebdjvPnKSZ7ixnqh2wIZ1m8c5rgiHtvhxEIfhUsGl6V9ugvvZoyZ3/BwcdURxFVA2+I7rEqoe9C4/y5m3UHehK51q0xnrYw4Nfp2Wh2P/WP41fe5ZVSbJ1oZx+Md+jNEnNT0kSb8ErmubA4ZFv0lEHkoRCcN3sJhNHfIy83QnVq2f9fM9X5/jgrV7QsL5SjOvXNHCeS+8BDF1bmurHHnqaB7tQV26h83lg1P1zLtppSL1P9ibiz8Ebv3YKh3G6juYqx+84D5s+mKM1qN+ga/vwwSosH+Ct/paX3mtz6vaFEA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zz7VWVMdMnhQvAFFxx7anVFzP5eAqrOXBrLRIpAvcf3fqCcMOix4NsSSROKLjaWn+xEbe4fQ0pyoegpPhAfq9NNHiZFI2WqbGpFovgzjuklPoz87+rE18RRU7J5AV6RNqaNlNPbr7Tm/7pkT7t4oJ68/VgLF1AypevI4dYpu35ZRxUm8sWkfqe2eaO0I2DasglWfjynKyTb1y/kNZlyxYf+cIUxtL2WJawN8catsF8pOh4w4Nm6v9G78W7Yfq+x0oueMatieMtRIFgZX7ScPCgd2fK64nXrGt6jDs46PiIqgez60tPYqeJNvjhc/iPgGDu/xHBRRW8ViIG/dNYLKXMb1dlzxthWm+3tCiMiq9QuLp+DphTpOy/NL8UXaMJkshupfYDH7mdOXQhxD0WqmhcoEyc7g00dsCoqdiz/McUsJpAK6S8WIr0mtGZSurT6k
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:33.2575 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 655ccee1-0417-4839-af62-08defa478027
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8071
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

Add interface to obtain FW eeprom records at runtime.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/aca.c         |  4 ++-
 drivers/gpu/drm/amd/ras/core/ras_process.c |  3 ++
 drivers/gpu/drm/amd/ras/core/ras_umc.c     | 40 ++++++++++++++++++++++
 drivers/gpu/drm/amd/ras/core/ras_umc.h     |  1 +
 4 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/ras/core/aca.c b/drivers/gpu/drm/amd/ras/core/aca.c
index 07a9cc030ca14..a2529645af098 100644
--- a/drivers/gpu/drm/amd/ras/core/aca.c
+++ b/drivers/gpu/drm/amd/ras/core/aca.c
@@ -247,7 +247,9 @@ static int aca_log_bad_bank(struct ras_core_context *ras_core,
 	ecc_err->total_de_count += bank_ecc->de_count;
 	mutex_unlock(&ras_core->ras_aca.aca_lock);
 
-	if ((aca_blk->blk_info->ras_block_id == RAS_BLOCK_ID__UMC) &&
+	/* Log ACA bad bank when FW management EEPROM is disabled. */
+	if (!ras_eeprom_mgr_fw_record_enabled(ras_core) &&
+	    (aca_blk->blk_info->ras_block_id == RAS_BLOCK_ID__UMC) &&
 	    bank_ecc->de_count) {
 		struct ras_bank_ecc  ras_ecc = {0};
 
diff --git a/drivers/gpu/drm/amd/ras/core/ras_process.c b/drivers/gpu/drm/amd/ras/core/ras_process.c
index c001074c8c568..dd4a4c5673bdd 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_process.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_process.c
@@ -170,6 +170,9 @@ int ras_process_handle_ras_event(struct ras_core_context *ras_core)
 	ras_aca_clear_fatal_flag(ras_core);
 	ras_umc_log_pending_bad_bank(ras_core);
 
+	if (ras_eeprom_mgr_fw_record_enabled(ras_core))
+		ras_umc_dump_fw_records(ras_core);
+
 	do {
 		umc_event_count = atomic_read(&ras_proc->umc_interrupt_count);
 		ret = ras_process_umc_event(ras_core, umc_event_count);
diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc.c b/drivers/gpu/drm/amd/ras/core/ras_umc.c
index 9cf1515dfd02e..b9961796a5395 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_umc.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc.c
@@ -675,6 +675,10 @@ static int ras_umc_save_bad_pages(struct ras_core_context *ras_core)
 	int save_count;
 	int ret = -ENODATA;
 
+	/* Not need to save bad pages when FW management EEPROM is enabled. */
+	if (ras_eeprom_mgr_fw_record_enabled(ras_core))
+		return 0;
+
 	if (!data->bps)
 		return -EINVAL;
 
@@ -918,3 +922,39 @@ int ras_umc_record_to_nps_record(struct ras_core_context *ras_core,
 
 	return ras_umc_eeprom_rec2nps_rec(ras_core, record, nps);
 }
+
+int ras_umc_dump_fw_records(struct ras_core_context *ras_core)
+{
+	struct eeprom_umc_record rec;
+	int eeprom_count, umc_count, new_count = 0;
+	uint32_t c;
+	int i, ret;
+
+	eeprom_count = ras_eeprom_mgr_get_record_count(ras_core);
+	/* no bad page record, skip eeprom access */
+	if (!eeprom_count)
+		return 0;
+
+	umc_count = ras_umc_get_saved_eeprom_count(ras_core);
+	if (umc_count == eeprom_count) {
+		return 0;
+	} else if (umc_count > eeprom_count) {
+		RAS_DEV_ERR(ras_core->dev, "Invalid error count: eeprom:%d, umc:%d\n",
+			eeprom_count, umc_count);
+		return 0;
+	}
+
+	for (i = umc_count; i < eeprom_count; i++) {
+		memset(&rec, 0, sizeof(rec));
+		ret = ras_eeprom_mgr_get_records(ras_core, i, &rec, 1);
+		if (ret)
+			return 0;
+
+		c = 0;
+		ret = ras_umc_add_bad_pages(ras_core, &rec, 1, &c);
+		if (!ret)
+			new_count += c;
+	}
+
+	return new_count;
+}
diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc.h b/drivers/gpu/drm/amd/ras/core/ras_umc.h
index 221cd008e55a0..5a3e019af8ad9 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_umc.h
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc.h
@@ -224,4 +224,5 @@ int ras_umc_bank_to_umc_record(struct ras_core_context *ras_core,
 		struct ras_bank_ecc *bank, struct eeprom_umc_record *record);
 int ras_umc_record_to_nps_record(struct ras_core_context *ras_core,
 		struct eeprom_umc_record *record,  uint32_t nps);
+int ras_umc_dump_fw_records(struct ras_core_context *ras_core);
 #endif
-- 
2.55.0


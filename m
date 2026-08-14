Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED1ADC5DF75
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2551410F71F;
	Fri, 14 Aug 2026 21:03:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2WZlnKrW";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011021.outbound.protection.outlook.com
 [40.93.194.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C07B10F701
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K8dRH0cJZaLZMsXZ7L9RVmcE8CAUsQgptTQ7k5J6zGiQdKIn+2AG4J35xc06mVVaMzRB2ZJuIRBUz3A14fxsvE2for5BHKqqafvWJYoYGVavOygAT7Fy+JYwWOz6Xjx9Fmu2tlhvdAy4LOfnhPOL0UKfNx8oB/+VXu/+vIoT772cdZSOTpiNfYOTr5OyDBoGaqv0116v/HaAzdepIqN/ykCbwmNEAxwWLK3iuBLL+BtLahddoISqS1f15ELx1fXM9xMfNKv7CPHCeznz/xCkKLjKRWRwgCh8TdP4P+OsbPwnKavWS/emF1f2H4gSxsozuM0+OhKIlBgZCgoiZgHf4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAZ9cm4ZI40wLHCzQ53HTqm9RCkfDw2dI58gd1lG1Xg=;
 b=chhgYYiY2g3rhhyzDbbKJj/PPZgrWE5QIsob5AkLg9vhkW5Mi4jNlOi0XZgHmUi6z42yG/0CSyhDrM1lVg9xVo/4e0VySlyzd55CULo1RJw/dptBvwuVAIK0OgbBc3gin5VimRiAQLtTVlVz0CRO3Hq/sPA7epUiRzg2MgzvuDquCvJbz7IRmsyK4LR8cMyeo4FTtFJOSw2fNX8b/1wHem639w56wm7GkJ9Vp6V7WBFXyAL7cjDVIoQDoWByZDt4gp7XSlKtBVdK0AFhWpH14q1gFKZkohBVboG3z6xpANOjLPp48KOq/wHCv72AZLceMYrRKiYD7Qn/guc8L+fmJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAZ9cm4ZI40wLHCzQ53HTqm9RCkfDw2dI58gd1lG1Xg=;
 b=2WZlnKrWo3VTM7XCaPnyrNa9DyV5672DEEwXTWtWG12BRMENXV0p0uqI30rfIVcqCnQnC+cwp0rneVZDaQA5yGOVjU1xYBXu0Sh2aX28dSHfRRAZ3ZhC6C+qtB53Gb9aCuJa6GoPEn7Qz8uIKP5olRJNFHXyaIAiWOrATMzor1E=
Received: from BN9P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::13)
 by CH3PR12MB9344.namprd12.prod.outlook.com (2603:10b6:610:1c8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 21:03:43 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:10b:cafe::8f) by BN9P223CA0008.outlook.office365.com
 (2603:10b6:408:10b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Fri,
 14 Aug 2026 21:03:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:03:43 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:40 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:37 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:37 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 066/109] drm/amd/ras: harden error handling and fix
 resource/lock issues
Date: Fri, 14 Aug 2026 17:02:03 -0400
Message-ID: <20260814210246.3067612-67-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|CH3PR12MB9344:EE_
X-MS-Office365-Filtering-Correlation-Id: 9931617b-1343-40c7-df74-08defa47864c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|56012099006|10067099003|6133799003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: cESmgBtmngLCXy6F3IlX0ClNfq3cIx/VBGePP67eeRJAUwy/eI2oSHaubvEZ/pWaQd//RcP+P0iVoPv5d190eaDxzYsrgPOsY4iDpjdCM4rTuUk+xCery7/nSwXsZeLTF3/iPsLTjfiCg7bL/c+NGEb3A/KRitl6ejR9Fi7ULNZ5YfB8014fl+dTMj9obfAHqZZU0LKUuueGYa4DDfhq/e6z46dM+iqZBxv1wDLStrm+AMl//Dqk6ipNgafVR/O/ZbEW5ycKBlS35d7No4ZxjXvFG0kIpzURDBi8uoMlBs98pcCGbpyVXgp0m8U4LDr15ioI8H19sT03wPFoP8OZxj1aRhuQkSjfaAT+ObpKxg+0QCIdxmlOnSX+9GEU2HCcRqZ3pPeaOc5eORRKvoTT55BmlwmgjoxrlLUb8FVLFFZDaWlA41DGhpjAWU2dxcihtFMWtciRCzwwiwj2T3FjAwZZRZj/o+AZFLgqK1g4J0d9aJwgoHusJJFXiMz/q7h8aR3qZJO8tzeOPawq1D/oG1uhqnryzg25GUohGuSg4NSHPrcZWR/5+ZKh4+m/ulk9zQEoaAgejQJa6Aw0AApOBdYN4PTgKqGkRq1vZ4CRPVPC/wpYRdXJKll+ZLe8qLDAkTaSrxyoN9Nk3yBlxMGurUhDJbDmCkhHwqC9YcCjcFFMGBB5njpME6X80AYdXvzQdWjs+P7IK3seB3SS2hsONQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(56012099006)(10067099003)(6133799003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: D1IY7rGLChEqTZv4IBnU/6MFoe3LPxeeOx/tC/FlYWPpZscstGl5Wl3SvTEGFcAH5CGQ2/zgOpE6HqBv+Ycn7IuAXOGHMOsybM3W6NdpdTXBn2AugbmA6+A+oWY13nqlt9QovK8bE7tU112ZxoB7nSlrRRXx98TPv8WQaCLplCjBCR/8YLATzLHnp3M5dSHLJq1NRSLqR34GQ3cwli9XJLdjIbI7U8WH2E390BNKLRl6jojhi4YPZqq6GJIZ/4Hn+l0vvu6eIVEuYYt9UrYVo+siHqynowAELLgLykqCqmxEzbLKIJYXOeZXmjS/dRb7KUJgfXhNPoN1uj4PGmSQC27tTqCCj/TGBya0HycVWQLI1kipZOCcZQRFo5iZfkx9IJxjtOKOg6Mz5wnzqXa0S1R7Ui4bLf88PGIwTZdn6m2AB6ZGTKelAuPCsiwrxBBh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:43.5569 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9931617b-1343-40c7-df74-08defa47864c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9344
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

Harden error handling and fix resource/lock issues.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/eeprom_fw.c | 19 +++++++++++++------
 drivers/gpu/drm/amd/ras/core/ras_mp1.c   |  2 +-
 drivers/gpu/drm/amd/ras/core/ras_umc.c   | 11 ++++++++---
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/eeprom_fw.c b/drivers/gpu/drm/amd/ras/core/eeprom_fw.c
index f7fb2dd7afe72..5f86ff54d9ed7 100644
--- a/drivers/gpu/drm/amd/ras/core/eeprom_fw.c
+++ b/drivers/gpu/drm/amd/ras/core/eeprom_fw.c
@@ -36,10 +36,11 @@ static int fw_eeprom_reset_ras_table(struct ras_core_context *ras_core)
 	mutex_lock(&ctl->record_lock);
 	res = ras_mp1_reset_ras_table(ras_core, &erase_res);
 	if (res || erase_res) {
-		RAS_DEV_WARN(ras_core->dev, "RAS EEPROM reset failed, res:%d result:%d",
-									res, erase_res);
+		RAS_DEV_WARN(ras_core->dev,
+			"RAS EEPROM reset failed, res:%d result:%d\n", res, erase_res);
 		if (!res)
 			res = -EIO;
+		goto out;
 	}
 
 	ctl->record_count = 0;
@@ -51,6 +52,8 @@ static int fw_eeprom_reset_ras_table(struct ras_core_context *ras_core)
 	ctl->rma_status = 0;
 	ctl->bad_channel_bitmap = 0;
 
+out:
+	mutex_unlock(&ctl->record_lock);
 	return res;
 }
 
@@ -73,6 +76,11 @@ static int fw_eeprom_sync_data(struct ras_core_context *ras_core,
 		RAS_DEV_ERR(ras_core->dev, "EEPROM ECC error count mismatch!\n");
 		ret = -EFAULT;
 		goto out;
+	} else if (fw_err_rec_num > MAX_EEPROM_ERR_RECORD_NUM) {
+		RAS_DEV_ERR(ras_core->dev,
+			"Invalid EEPROM error count:0x%x\n", fw_err_rec_num);
+		ret = -EOVERFLOW;
+		goto out;
 	}
 
 	for (idx = ctl->record_count;
@@ -141,9 +149,6 @@ static int fw_eeprom_sw_init(struct ras_core_context *ras_core,
 	if (!ctl)
 		return -ENOMEM;
 
-	mgr->ras_eeprom = ctl;
-	memset(ctl, 0, sizeof(*ctl));
-
 	ctl->eeprom_ip_version = param->eeprom_ip_version;
 	ctl->records = kzalloc(sizeof(*ctl->records) * MAX_EEPROM_ERR_RECORD_NUM, GFP_KERNEL);
 	if (!ctl->records) {
@@ -154,10 +159,12 @@ static int fw_eeprom_sw_init(struct ras_core_context *ras_core,
 	ctl->max_record_count = MAX_EEPROM_ERR_RECORD_NUM;
 	mutex_init(&ctl->record_lock);
 
+	mgr->ras_eeprom = ctl;
+
 	return 0;
 
 out:
-	kfree(ctl->records);
+	kfree(ctl);
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/ras/core/ras_mp1.c b/drivers/gpu/drm/amd/ras/core/ras_mp1.c
index 34578806ef3c0..2452448806f65 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_mp1.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_mp1.c
@@ -148,7 +148,7 @@ int ras_mp1_get_record_count(struct ras_core_context *ras_core, u32 *count)
 	int ret;
 
 	if (!count || !mp1->ip_func || !mp1->ip_func->get_record_count)
-		return 0;
+		return -EOPNOTSUPP;
 
 	mutex_lock(&mp1->op_mutex);
 	ret = mp1->ip_func->get_record_count(ras_core, count);
diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc.c b/drivers/gpu/drm/amd/ras/core/ras_umc.c
index 0e6a341f0729a..3558d4633a4e7 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_umc.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc.c
@@ -488,6 +488,7 @@ static int ras_umc_log_record(struct ras_core_context *ras_core,
 				struct eeprom_umc_record *record)
 {
 	struct eeprom_umc_record *rec;
+	int ret;
 
 	rec = kzalloc(sizeof(*rec), GFP_KERNEL);
 	if (!rec)
@@ -495,7 +496,11 @@ static int ras_umc_log_record(struct ras_core_context *ras_core,
 
 	memcpy(rec, record, sizeof(*rec));
 
-	return ras_umc_log_ecc(ras_core, rec->cur_nps_retired_row_pfn, rec);
+	ret = ras_umc_log_ecc(ras_core, rec->cur_nps_retired_row_pfn, rec);
+	if (ret)
+		kfree(rec);
+
+	return ret;
 }
 
 /* alloc/realloc bps array */
@@ -537,7 +542,7 @@ static int ras_umc_update_eeprom_rom_data(struct ras_core_context *ras_core,
 
 	/* update bad channel bitmap */
 	if (bps->mem_channel < BITS_PER_TYPE(data->umc_channel_bitmap))
-		data->umc_channel_bitmap |= 1 << bps->mem_channel;
+		data->umc_channel_bitmap |= 0x1ULL << bps->mem_channel;
 
 	return 0;
 }
@@ -585,7 +590,7 @@ static int ras_umc_update_eeprom_ram_data(struct ras_core_context *ras_core,
 
 	/* update bad channel bitmap */
 	if (bps->mem_channel < BITS_PER_TYPE(data->umc_channel_bitmap))
-		data->umc_channel_bitmap |= 1 << bps->mem_channel;
+		data->umc_channel_bitmap |= 0x1ULL << bps->mem_channel;
 
 	return 0;
 }
-- 
2.55.0


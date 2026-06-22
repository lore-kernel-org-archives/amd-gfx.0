Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C2C2CD98F6
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 04:43:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C156910E487;
	Mon, 22 Jun 2026 04:43:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L8iwfVNp";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013002.outbound.protection.outlook.com
 [40.107.201.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90A5E10E486
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 04:43:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LK5+ImI4PLYkT4sSfb+3tJbj6ljZfwCQRDE8ACA2CIc68yLvFDPKCGP/0kLyGlNu7L9xXmQvaeHX0POJOPSmIbqX0ABDXtWhP46LTj9J/+vnJNRkdqOVJIpEJnEE41vQcna2jw2im7CQhZQVuG7Dz1M9aZTPi+Svbe6gpsLQ/8Csduzd3P3viG0z/LPHC/baSLVRUGVrJWoq8a5nFQ1dOlPA1BefArjeJOoxSIQiNAO2S1tbPtzl7ydGVNPKkxeLzlfVcbky64XYzyY0MCm7JSSujs8vLNKpUY/KaJBDIogbssjEyEoeuACtvmSlX1c0Fug8+d0jTtAcbB/cZtX7zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JlIcRwXMZSqjMHEi65hWATiitbHU752MptOWsFRkfNw=;
 b=OmtaPYsIuidt6A8qAUypFc1VORlVCsdiAB5NIr3KOmRfKp13B/ua0CRaMXb2sRVo3NIzYrKKQPaX0+0SJXrzT20WUxT2yTB+iEsI/iJMNyi0doU16Z0nDo8q4kdonHWAIUzGgTrG8rITBF0keIzNmy2ZEMx8XclR4glH8QQ+gyNcaOjl6mZ+gObXS51I2NCkatTSR9Y/Renx/itRCD6QvRPcpHfmpAX9Jw+3OClL0SXKvHN8u5caq1uAKFZjFMRb3AcxfuJi4GL8jiLRZrAgz9xmWcvZakutgfk/TyKv3m+5IZtgs3ETm8/e8ygJiQWxRSum26cIjXLpWuTENvMY2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlIcRwXMZSqjMHEi65hWATiitbHU752MptOWsFRkfNw=;
 b=L8iwfVNpSPYGNN4Eq148xrh7EXqtVTmzNCk7ye52RGUUEo+BMVeLFJeg4tDovJhwJTmE0517aRUnWr9j9nY2ICr1xqt4Rmribuxx/Pijayd7QYWjXTulTn5QMgzdt9bGYMg7s8q06h2kYGvcrRhcFmJcyuah+MTZ4d348i5o8gc=
Received: from BL1PR13CA0419.namprd13.prod.outlook.com (2603:10b6:208:2c2::34)
 by SN7PR12MB7452.namprd12.prod.outlook.com (2603:10b6:806:299::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 04:43:14 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:2c2:cafe::40) by BL1PR13CA0419.outlook.office365.com
 (2603:10b6:208:2c2::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.11 via Frontend Transport; Mon,
 22 Jun 2026 04:43:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 04:43:13 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 21 Jun
 2026 23:43:12 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>, "Ce
 Sun" <cesun102@amd.com>
Subject: [PATCH v1 39/48] drm/amdgpu: retire legacy pmfw eeprom interface
 wrapper
Date: Mon, 22 Jun 2026 12:40:28 +0800
Message-ID: <36aa838f5fa6ca29deff17f6381885aad9802296.1782103074.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1782103073.git.cesun102@amd.com>
References: <cover.1782103073.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|SN7PR12MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: 2108af5a-6937-445c-5f94-08ded018c53a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|22082099003|18002099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: KBklKRvOlkgSfiK0o/VtwDikcyFMNPmdLQ3TlFBX5nqCZMOESbZ1OgxYyATG7xADSLBxV/YRhFi24KFBh4FAGbdfV18f4iNiiNpqapMw4Wpi2V1fqepZ2jfwtT1xmU/T01BH33W9GqWxTpXg4bK2aAD+dPNAJ3fpStRZxyAOj7JUZwvsj7/Ct5IAku/QsSt1ngHtiTUKGeGeR0x6DnK3zJoHw4ELSt2LQavI8Z49ODekAYRXDcIlAZqGh//pBtTHPL4aU+G3lr78GhGFGC+c9O575oIdePxIl/Tbqxv5mTRJDyk1ZiCAobBduiT63P0GLgXwVZlJgnu3FXj9YZ7A4MJxo1xMi2oWBJVeQLJQUuiTM2DXWmZlfT9H9/YVI52w7B9LEGvFKU7/Iho5qju49m8Umo6EI7ZQcIQW/XsWL0KDjnFcYWHnDHOFmK6X7eb3vI+urI+kC6P2WJJXqyWdoy5WvqxzDL0AjDHspsaRV1Fd+ajxCwN+Hfbmfs+AoUJe61WI2X+cArKIhJN6YQ453DG1np1LP3W6pvma/8nVHTdPK9E5iZx1qLZTBhIYghPkyIjKIPTDkP5dAUpIm2cVAhxco9pyyG+wMOTD2OkQk4cpuDIn9CqDjyj10v2mzYE37s+B7H1TGEPPAJVNg3CJ6ZzNEoYFApdPUg+ZQYJHofxFE/nahwPmCF67feLrj/a0j2TSGvcgP/WLVWFFX9zIFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IU/epP876VjF3dIuEdO4JFvlWgz8fQR7s3DbY/QbUasjCMW+ELnvRI6OB6S31NivqnKA+oSpwQX1nv1x5uZcWl1P56S1kbKssmgsFzkmums6kMnQ8IOj8r9XjRBsVGRoFspQlxjZPT86oI0cgaDmeNJkZU7GHCtEkVlvgAkINEXf6zYCIUj4v5dCpAXspTBG1j6xZotvMrKxRw5us8MeddUbkTTm0kHSU4NYMY6SiilfAb3roJrhPfoSNAful3a2AuaXQfRUkE3nMIIx7/UAlmsXuUw2ZH3z/2cgg7PP2ro+YoYS7xniBfPkDWAlf7pWw+/U8wJ5pEsp9OCZmK02QbJMa+cSEkzrXv0d3jLl/0r9EBzL/3Qkx4ODiv4uP+GnyIqWAZ/3w5yqNFliNLo6wXm8//5ExdCoSaIsYYmnrfpgNDUJwGaubamu9DrFqncz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 04:43:13.9494 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2108af5a-6937-445c-5f94-08ded018c53a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7452
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

retire legacy pmfw eeprom interface wrapper functions

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 98 -------------------
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    | 21 ----
 2 files changed, 119 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index baa8cc3646d5..8c398c2e6709 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1740,104 +1740,6 @@ bool amdgpu_ras_smu_eeprom_supported(struct amdgpu_device *adev)
 	return !!(flags & RAS_SMU_FEATURE_BIT__RAS_EEPROM);
 }
 
-int amdgpu_ras_smu_get_table_version(struct amdgpu_device *adev,
-				     uint32_t *table_version)
-{
-	const struct ras_smu_drv *smu_ras_drv = amdgpu_ras_get_smu_ras_drv(adev);
-
-	if (!amdgpu_ras_smu_eeprom_supported(adev))
-		return -EOPNOTSUPP;
-
-	if (smu_ras_drv->smu_eeprom_funcs->get_ras_table_version)
-		return smu_ras_drv->smu_eeprom_funcs->get_ras_table_version(adev,
-										 table_version);
-	return -EOPNOTSUPP;
-}
-
-int amdgpu_ras_smu_get_badpage_count(struct amdgpu_device *adev,
-				     uint32_t *count, uint32_t timeout)
-{
-	const struct ras_smu_drv *smu_ras_drv = amdgpu_ras_get_smu_ras_drv(adev);
-
-	if (!amdgpu_ras_smu_eeprom_supported(adev))
-		return -EOPNOTSUPP;
-
-	if (smu_ras_drv->smu_eeprom_funcs->get_badpage_count)
-		return smu_ras_drv->smu_eeprom_funcs->get_badpage_count(adev,
-									     count, timeout);
-	return -EOPNOTSUPP;
-}
-
-int amdgpu_ras_smu_get_badpage_mca_addr(struct amdgpu_device *adev,
-					uint16_t index, uint64_t *mca_addr)
-{
-	const struct ras_smu_drv *smu_ras_drv = amdgpu_ras_get_smu_ras_drv(adev);
-
-	if (!amdgpu_ras_smu_eeprom_supported(adev))
-		return -EOPNOTSUPP;
-
-	if (smu_ras_drv->smu_eeprom_funcs->get_badpage_mca_addr)
-		return smu_ras_drv->smu_eeprom_funcs->get_badpage_mca_addr(adev,
-										index, mca_addr);
-	return -EOPNOTSUPP;
-}
-
-int amdgpu_ras_smu_set_timestamp(struct amdgpu_device *adev,
-				 uint64_t timestamp)
-{
-	const struct ras_smu_drv *smu_ras_drv = amdgpu_ras_get_smu_ras_drv(adev);
-
-	if (!amdgpu_ras_smu_eeprom_supported(adev))
-		return -EOPNOTSUPP;
-
-	if (smu_ras_drv->smu_eeprom_funcs->set_timestamp)
-		return smu_ras_drv->smu_eeprom_funcs->set_timestamp(adev,
-									 timestamp);
-	return -EOPNOTSUPP;
-}
-
-int amdgpu_ras_smu_get_timestamp(struct amdgpu_device *adev,
-				 uint16_t index, uint64_t *timestamp)
-{
-	const struct ras_smu_drv *smu_ras_drv = amdgpu_ras_get_smu_ras_drv(adev);
-
-	if (!amdgpu_ras_smu_eeprom_supported(adev))
-		return -EOPNOTSUPP;
-
-	if (smu_ras_drv->smu_eeprom_funcs->get_timestamp)
-		return smu_ras_drv->smu_eeprom_funcs->get_timestamp(adev,
-									 index, timestamp);
-	return -EOPNOTSUPP;
-}
-
-int amdgpu_ras_smu_get_badpage_ipid(struct amdgpu_device *adev,
-				    uint16_t index, uint64_t *ipid)
-{
-	const struct ras_smu_drv *smu_ras_drv = amdgpu_ras_get_smu_ras_drv(adev);
-
-	if (!amdgpu_ras_smu_eeprom_supported(adev))
-		return -EOPNOTSUPP;
-
-	if (smu_ras_drv->smu_eeprom_funcs->get_badpage_ipid)
-		return smu_ras_drv->smu_eeprom_funcs->get_badpage_ipid(adev,
-									    index, ipid);
-	return -EOPNOTSUPP;
-}
-
-int amdgpu_ras_smu_erase_ras_table(struct amdgpu_device *adev,
-				   uint32_t *result)
-{
-	const struct ras_smu_drv *smu_ras_drv = amdgpu_ras_get_smu_ras_drv(adev);
-
-	if (!amdgpu_ras_smu_eeprom_supported(adev))
-		return -EOPNOTSUPP;
-
-	if (smu_ras_drv->smu_eeprom_funcs->erase_ras_table)
-		return smu_ras_drv->smu_eeprom_funcs->erase_ras_table(adev,
-									   result);
-	return -EOPNOTSUPP;
-}
-
 void amdgpu_ras_check_bad_page_status(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index 3c7fcce5fe8b..5e5275ae7aab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -165,27 +165,6 @@ void amdgpu_ras_eeprom_check_and_recover(struct amdgpu_device *adev);
 
 bool amdgpu_ras_smu_eeprom_supported(struct amdgpu_device *adev);
 
-int amdgpu_ras_smu_get_table_version(struct amdgpu_device *adev,
-							uint32_t *table_version);
-
-int amdgpu_ras_smu_get_badpage_count(struct amdgpu_device *adev,
-								uint32_t *count, uint32_t timeout);
-
-int amdgpu_ras_smu_get_badpage_mca_addr(struct amdgpu_device *adev,
-								uint16_t index, uint64_t *mca_addr);
-
-int amdgpu_ras_smu_set_timestamp(struct amdgpu_device *adev,
-										uint64_t timestamp);
-
-int amdgpu_ras_smu_get_timestamp(struct amdgpu_device *adev,
-							uint16_t index, uint64_t *timestamp);
-
-int amdgpu_ras_smu_get_badpage_ipid(struct amdgpu_device *adev,
-								uint16_t index, uint64_t *ipid);
-
-int amdgpu_ras_smu_erase_ras_table(struct amdgpu_device *adev,
-									uint32_t *result);
-
 int amdgpu_ras_eeprom_read_idx(struct amdgpu_ras_eeprom_control *control,
 			struct eeprom_table_record *record, u32 rec_idx,
 			const u32 num);
-- 
2.34.1


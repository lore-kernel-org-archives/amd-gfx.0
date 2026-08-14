Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92673C5CFC1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB9A910F70C;
	Fri, 14 Aug 2026 21:03:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pPOCBFkN";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013038.outbound.protection.outlook.com
 [40.93.201.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DD4A10F70A
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RLLfb/bMKrOYPF7wNnBQB0ITaeE1IAKRgbpSbxtBWNyBWLFHYt9/rjh1wEsItruBJG1nmucMjhZj2FBWrIzr71h0Wzg/FqLCcc3YtmQwkmOSdD2xU+jOWVOEp4Qw3oNHHYgSEZWzO14rkAIp90T4eBT6Anqqx+2ofsS/iaKV6btud0J36vz/OlQW3nCS5h7s9iCR1HtdwhLc97Btx/OR7NK7PB7jDagaWBim2xvyR8fvYNVroZuILhD5/mzwPHbzaN+mrznbjCiGkNk4c1Y1tYQtkj8K7jo0KxM4B6InS7quFD0iur0n9+CRfqodBmksC2r6b8L/mUtwHQ9j8NAm0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pI9juKnM8GGPCvRjw9Kx8PX0PBcD3expTBnMiRIlioY=;
 b=DebA2sWwXf9UDIkWSR3pU3ZrqBFVCNwzqpOpa+0WVA7c8Z4KMIEwsVGihz9Eqt+8Kz9TlnWoD8B82bFvFU3wgwx2gxIXKZyOETR/g19LuXyaN2vzcD0xtBxjAPHQC5fEKuPTcctYodresJqBfuJ+UyLZkjkZetrrOr4rx/dEnyAfYvaLJ5dRuSTpoiF5ii3q1CWcQ8nW04lcfBc092SxmvyA2H9kOhK+8pav53loWJpnvHQKOdGyOIcJTTYmG/865qStr/gM/CWH0fKb+2DZeII0hRMLUJERKnRT+lv6OHemH4oi72+W8mmSK72uADt45lR619S1xpyfOyex5XK7SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pI9juKnM8GGPCvRjw9Kx8PX0PBcD3expTBnMiRIlioY=;
 b=pPOCBFkNvasWecmzSyCijNcyvEnCniID+edvobV0yueCyeyiUP7ArJwvNZOd/nz+ONQJcBRnAVK3EYzatKd5Wg62OhURBahr2yvNFWiPgpzXn9ajYKRZ2/4us5cPLnCoB9SRVdL9SCNkxqzPvFu3r2S5lwD+yyUxXSJw3aJo7XU=
Received: from BN9PR03CA0966.namprd03.prod.outlook.com (2603:10b6:408:109::11)
 by SA1PR12MB7367.namprd12.prod.outlook.com (2603:10b6:806:2b5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 21:03:33 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:109:cafe::7b) by BN9PR03CA0966.outlook.office365.com
 (2603:10b6:408:109::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Fri,
 14 Aug 2026 21:03:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:03:32 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:31 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:29 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:29 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 053/109] drm/amd/ras: remove unused code from ras eeprom
Date: Fri, 14 Aug 2026 17:01:50 -0400
Message-ID: <20260814210246.3067612-54-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|SA1PR12MB7367:EE_
X-MS-Office365-Filtering-Correlation-Id: baf337ad-ec60-4eb0-692a-08defa477ff9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|22082099003|18002099003|56012099006|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: N/IT+4z1F5giv1Odc0hWvP+Ge3k8Xpynhah1rMUrFT2gW4gX6MBceR9q71O5kri3Ox74u4gTkWzj5ODwGjVIUM0yyL50Oui41iIZM7aOO8c9YIQAXC1Mm1v5RpOM1xqz7sSeqN88HPT9lpUh23yKlSIX8e78x3q4s3zsXk4EETkorsaAndY/HJy7t9o8cgMWOV/MQH6V2rYpTx2nv1DvBr/19o4EBQAuYeakhIzBs+eAm4OEf+Kv2P0THmJX6GKdpKxWZ2KscwspEf1NZdt3XPV/ZcoqeZ2kVp/1CczZrc2IluiVKNQVk7upOQUOvggo+KXH33jHpdh7/GB+JKL/7GNUBLKq1hPjhz7ukuNasFURIJusUAY06ulVvQzSQhbd4CRoFOx1vkVyPVjIoOe/UVZdELfRMyXFcEvJfNte6oa5kcdI0KMSpwWRxCsvdAicAsnUKMfCodyxDv6BQwRbt/U3wkRx4y+HmD9Uq6V+Pw8r+O6I4l0hCruvWgYh8fAL1EuDh3gESnP3hBPnamcXtYBbrx3rAe0Pv5cJo1rvu/WWZB9FQvlH8xfZdlqV4h3nZM7v1mV5b9elMhUxKxWCcd+wbLoWAtL7PnOwY2+fpQCpMAmDrNovW6u5757Cf0v86xnUZiQ5R9xcr2Wsltblu2WPHBNEzdRKYz+uG0G7rYuRiJsttmIFfWvtnZpqWdNIDkTgBS277tHWzeGRqq481A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(22082099003)(18002099003)(56012099006)(6133799003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ho2ObF3ueIN/MDsOPNfqjebPTNfHw7v3QSVr+hSpN6/h9/YuZf6flR+K5vqNo7OEFaJykUFcsw54w3LTeRYjof/6u3KXaPhI2v0yT9Q3jjjQEnS/kR77mVG8h5zc5Am46Mofc/6tou0FKoDl5vXIKD4LXsqXNVY5lmCPLUXA7XjPfmacnWANtTMaON3RItgFXY5uhG0NtQiTNuZYSFMrHDKhTUGFUE9miB+CYVYTUZPg5qYXsz01YDTH/Tn8UQca7nnzwJaQu2p2CTsnxMaSSrA4wUD0Ric2c9m6Su1P0MxP91F94MHCDn9EI6LyxBMKlOeEVpMfEwtoKfy1QuVgKzSTC2EMYX1Wtb36LVrynFYVFO714mQcrlDgl0Yq+7bK9Se7D72ynpAavro8t/JVtLYG5OWq+NSiPOgyavl0OBYznO4coK97QD+HOqge5wwR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:32.9440 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baf337ad-ec60-4eb0-692a-08defa477ff9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7367
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

Remove unused code from ras eeprom.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/eeprom.c | 215 +-------------------------
 drivers/gpu/drm/amd/ras/core/eeprom.h |   5 -
 drivers/gpu/drm/amd/ras/core/ras.h    |   9 --
 3 files changed, 1 insertion(+), 228 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/eeprom.c b/drivers/gpu/drm/amd/ras/core/eeprom.c
index 6b8f9fec5da80..3c16446ddfc47 100644
--- a/drivers/gpu/drm/amd/ras/core/eeprom.c
+++ b/drivers/gpu/drm/amd/ras/core/eeprom.c
@@ -153,10 +153,6 @@
 
 #define to_ras_core_context(x) (container_of(x, struct ras_core_context, eeprom_mgr))
 
-static bool __is_ras_eeprom_supported(struct ras_core_context *ras_core)
-{
-	return ras_core->ras_eeprom_supported;
-}
 
 static bool __get_eeprom_i2c_addr(struct ras_core_context *ras_core,
 				  struct ras_eeprom_control *control)
@@ -326,19 +322,6 @@ __encode_table_ras_info_to_buf(struct ras_eeprom_table_ras_info *rai,
 	pp[0] = cpu_to_le32(tmp);
 }
 
-static void
-__decode_table_ras_info_from_buf(struct ras_eeprom_table_ras_info *rai,
-				 unsigned char *buf)
-{
-	u32 *pp = (uint32_t *)buf;
-	u32 tmp;
-
-	tmp = le32_to_cpu(pp[0]);
-	rai->rma_status = tmp & 0xFF;
-	rai->health_percent = (tmp >> 8) & 0xFF;
-	rai->ecc_page_threshold = (tmp >> 16) & 0xFFFF;
-}
-
 static int __write_table_ras_info(struct ras_eeprom_control *control)
 {
 	struct ras_core_context *ras_core = to_ras_core_context(control->mgr);
@@ -439,7 +422,7 @@ static void ras_set_eeprom_table_version(struct ras_eeprom_control *control)
 	hdr->version = RAS_TABLE_VER_V3;
 }
 
-int ras_eeprom_reset_table(struct ras_core_context *ras_core)
+static int ras_eeprom_reset_table(struct ras_core_context *ras_core)
 {
 	struct ras_eeprom_control *control = ras_core->eeprom_mgr.ras_eeprom;
 	struct ras_eeprom_table_header *hdr = &control->tbl_hdr;
@@ -549,38 +532,6 @@ __decode_table_record_from_buf(struct ras_eeprom_control *control,
 	record->retired_row_pfn = (le64_to_cpu(tmp) & 0xffffffffffff);
 }
 
-bool ras_eeprom_check_safety_watermark(struct ras_core_context *ras_core)
-{
-	struct ras_eeprom_control *control = ras_core->eeprom_mgr.ras_eeprom;
-	bool ret = false;
-	int bad_page_count;
-
-	if (!__is_ras_eeprom_supported(ras_core) ||
-	    !control->record_threshold_config)
-		return false;
-
-	bad_page_count = ras_umc_get_badpage_count(ras_core);
-	if (control->tbl_hdr.header == RAS_TABLE_HDR_BAD) {
-		if (bad_page_count > control->record_threshold_count)
-			RAS_DEV_WARN(ras_core->dev, "RAS records:%d exceed threshold:%d",
-				bad_page_count, control->record_threshold_count);
-
-		if ((control->record_threshold_config == WARN_NONSTOP_OVER_THRESHOLD) ||
-			(control->record_threshold_config == NONSTOP_OVER_THRESHOLD)) {
-			RAS_DEV_WARN(ras_core->dev,
-				"Please consult AMD Service Action Guide (SAG) for appropriate service procedures.\n");
-			ret = false;
-		} else {
-			ras_core->is_rma = true;
-			RAS_DEV_WARN(ras_core->dev,
-				"Please consider adjusting the customized threshold.\n");
-			ret = true;
-		}
-	}
-
-	return ret;
-}
-
 /**
  * __ras_eeprom_write -- write indexed from buffer to EEPROM
  * @control: pointer to control structure
@@ -1034,41 +985,6 @@ static int __verify_ras_table_checksum(struct ras_eeprom_control *control)
 	return res < 0 ? res : csum;
 }
 
-static int __read_table_ras_info(struct ras_eeprom_control *control)
-{
-	struct ras_eeprom_table_ras_info *rai = &control->tbl_rai;
-	struct ras_core_context *ras_core = to_ras_core_context(control->mgr);
-	unsigned char *buf;
-	int res;
-
-	buf = kzalloc(RAS_TABLE_V2_1_INFO_SIZE, GFP_KERNEL);
-	if (!buf) {
-		RAS_DEV_ERR(ras_core->dev,
-			"Failed to alloc buf to read EEPROM table ras info\n");
-		return -ENOMEM;
-	}
-
-	/**
-	 * EEPROM table V2_1 supports ras info,
-	 * read EEPROM table ras info
-	 */
-	res = __eeprom_read(ras_core,
-			      control->i2c_address + control->ras_info_offset,
-			      buf, RAS_TABLE_V2_1_INFO_SIZE);
-	if (res < RAS_TABLE_V2_1_INFO_SIZE) {
-		RAS_DEV_ERR(ras_core->dev,
-			"Failed to read EEPROM table ras info, res:%d\n", res);
-		res = res >= 0 ? -EIO : res;
-		goto Out;
-	}
-
-	__decode_table_ras_info_from_buf(rai, buf);
-
-Out:
-	kfree(buf);
-	return res == RAS_TABLE_V2_1_INFO_SIZE ? 0 : res;
-}
-
 static int __ras_table_init(struct ras_core_context *ras_core)
 {
 	struct ras_eeprom_control *control = ras_core->eeprom_mgr.ras_eeprom;
@@ -1156,95 +1072,6 @@ static int __ras_table_init(struct ras_core_context *ras_core)
 	return 0;
 }
 
-int ras_eeprom_check_storage_status(struct ras_core_context *ras_core)
-{
-	struct ras_eeprom_control *control = ras_core->eeprom_mgr.ras_eeprom;
-	struct ras_eeprom_table_header *hdr;
-	int bad_page_count;
-	int res = 0;
-
-	if (!__is_ras_eeprom_supported(ras_core))
-		return 0;
-
-	if (!__get_eeprom_i2c_addr(ras_core, control))
-		return -EINVAL;
-
-	hdr = &control->tbl_hdr;
-
-	bad_page_count = ras_umc_get_badpage_count(ras_core);
-	if (hdr->header == RAS_TABLE_HDR_VAL) {
-		RAS_DEV_INFO(ras_core->dev,
-			"Found existing EEPROM table with %d records\n",
-			bad_page_count);
-
-		if (hdr->version >= RAS_TABLE_VER_V2_1) {
-			res = __read_table_ras_info(control);
-			if (res)
-				return res;
-		}
-
-		res = __verify_ras_table_checksum(control);
-		if (res)
-			RAS_DEV_ERR(ras_core->dev,
-				"RAS table incorrect checksum or error:%d\n", res);
-
-		/* Warn if we are at 90% of the threshold or above
-		 */
-		if (10 * bad_page_count >= 9 * control->record_threshold_count)
-			RAS_DEV_WARN(ras_core->dev,
-				"RAS records:%u exceeds 90%% of threshold:%d\n",
-				bad_page_count,
-				control->record_threshold_count);
-
-	} else if (hdr->header == RAS_TABLE_HDR_BAD &&
-		   control->record_threshold_config != 0) {
-		if (hdr->version >= RAS_TABLE_VER_V2_1) {
-			res = __read_table_ras_info(control);
-			if (res)
-				return res;
-		}
-
-		res = __verify_ras_table_checksum(control);
-		if (res)
-			RAS_DEV_ERR(ras_core->dev,
-				"RAS Table incorrect checksum or error:%d\n", res);
-
-		if (control->record_threshold_count >= bad_page_count) {
-			/* This means that, the threshold was increased since
-			 * the last time the system was booted, and now,
-			 * ras->record_threshold_count - control->num_recs > 0,
-			 * so that at least one more record can be saved,
-			 * before the page count threshold is reached.
-			 */
-			RAS_DEV_INFO(ras_core->dev,
-				"records:%d threshold:%d, resetting RAS table header signature",
-				bad_page_count,
-				control->record_threshold_count);
-			res = ras_eeprom_correct_header_tag(control, RAS_TABLE_HDR_VAL);
-		} else {
-			RAS_DEV_ERR(ras_core->dev, "RAS records:%d exceed threshold:%d",
-				bad_page_count, control->record_threshold_count);
-			/* send the event when threshold is exceeded, and ignore the
-			 * return value here
-			 */
-			ras_core_event_notify(ras_core, RAS_EVENT_ID__DEVICE_RMA, NULL);
-
-			if ((control->record_threshold_config == WARN_NONSTOP_OVER_THRESHOLD) ||
-				(control->record_threshold_config == NONSTOP_OVER_THRESHOLD)) {
-				RAS_DEV_WARN(ras_core->dev,
-				"Please consult AMD Service Action Guide (SAG) for appropriate service procedures\n");
-				res = 0;
-			} else {
-				ras_core->is_rma = true;
-				RAS_DEV_ERR(ras_core->dev,
-				"User defined threshold is set, runtime service will be halt when threshold is reached\n");
-			}
-		}
-	}
-
-	return res < 0 ? res : 0;
-}
-
 static int ras_eeprom_sw_init(struct ras_core_context *ras_core,
 		struct ras_eeprom_param *param)
 {
@@ -1324,46 +1151,6 @@ static uint32_t ras_eeprom_get_record_count(struct ras_core_context *ras_core)
 	return control->ras_num_recs;
 }
 
-void ras_eeprom_sync_info(struct ras_core_context *ras_core)
-{
-	struct ras_eeprom_control *control;
-
-	if (!ras_core)
-		return;
-
-	control = ras_core->eeprom_mgr.ras_eeprom;
-	ras_core_event_notify(ras_core, RAS_EVENT_ID__UPDATE_BAD_PAGE_NUM,
-		&control->ras_num_recs);
-	ras_core_event_notify(ras_core, RAS_EVENT_ID__UPDATE_BAD_CHANNEL_BITMAP,
-		&control->bad_channel_bitmap);
-}
-
-enum ras_gpu_health_status
-	ras_eeprom_check_gpu_status(struct ras_core_context *ras_core)
-{
-	struct ras_eeprom_control *control = ras_core->eeprom_mgr.ras_eeprom;
-	struct ras_eeprom_table_ras_info *rai = &control->tbl_rai;
-
-	if (!__is_ras_eeprom_supported(ras_core) ||
-	    !control->record_threshold_config)
-		return RAS_GPU_HEALTH_NONE;
-
-	if (control->tbl_hdr.header == RAS_TABLE_HDR_BAD)
-		return RAS_GPU_IN_BAD_STATUS;
-
-	return rai->rma_status;
-}
-
-int ras_eeprom_get_version(struct ras_core_context *ras_core, uint32_t *version)
-{
-	if (!ras_core || !version)
-		return -EINVAL;
-
-	*version = ras_core->ras_eeprom.tbl_hdr.version;
-
-	return 0;
-}
-
 static int ras_eeprom_get_records(struct ras_core_context *ras_core, u32 start,
 		struct eeprom_umc_record *record, u32 num)
 {
diff --git a/drivers/gpu/drm/amd/ras/core/eeprom.h b/drivers/gpu/drm/amd/ras/core/eeprom.h
index 7c0466e9b90ed..f4dac13d70056 100644
--- a/drivers/gpu/drm/amd/ras/core/eeprom.h
+++ b/drivers/gpu/drm/amd/ras/core/eeprom.h
@@ -86,7 +86,6 @@ struct ras_eeprom_control {
 	struct ras_eeprom_table_ras_info tbl_rai;
 
 	/* record threshold */
-	int record_threshold_config;
 	uint32_t record_threshold_count;
 	bool update_channel_flag;
 
@@ -171,15 +170,11 @@ struct eeprom_umc_record {
 
 struct ras_core_context;
 
-int ras_eeprom_reset_table(struct ras_core_context *ras_core);
-
 bool ras_eeprom_check_safety_watermark(struct ras_core_context *ras_core);
 
 int ras_eeprom_check_storage_status(struct ras_core_context *ras_core);
 enum ras_gpu_health_status
 	ras_eeprom_check_gpu_status(struct ras_core_context *ras_core);
-void ras_eeprom_sync_info(struct ras_core_context *ras_core);
-int ras_eeprom_get_version(struct ras_core_context *ras_core, uint32_t *version);
 
 extern struct ras_eeprom_ops ras_drv_eeprom_ops;
 #endif
diff --git a/drivers/gpu/drm/amd/ras/core/ras.h b/drivers/gpu/drm/amd/ras/core/ras.h
index ba656c82d4ee6..4cee407c36595 100644
--- a/drivers/gpu/drm/amd/ras/core/ras.h
+++ b/drivers/gpu/drm/amd/ras/core/ras.h
@@ -216,7 +216,6 @@ struct ras_mp1_sys_func {
 };
 
 struct ras_eeprom_param_config {
-	int eeprom_record_threshold_config;
 	u32 eeprom_ip_version;
 	u64 eeprom_record_threshold_count;
 	enum ras_work_mode_over_thresh work_mode_over_thresh;
@@ -343,13 +342,6 @@ struct ras_umc_config {
 
 struct ras_eeprom_config {
 	const struct ras_eeprom_sys_func *eeprom_sys_fn;
-	int eeprom_record_threshold_config;
-	uint32_t eeprom_record_threshold_count;
-	void *eeprom_i2c_adapter;
-	u32 eeprom_i2c_addr;
-	u32 eeprom_i2c_port;
-	u16 max_i2c_read_len;
-	u16 max_i2c_write_len;
 };
 
 struct ras_core_config {
@@ -385,7 +377,6 @@ struct ras_core_context {
 	struct ras_aca ras_aca;
 
 	bool ras_eeprom_supported;
-	struct ras_eeprom_control ras_eeprom;
 	struct ras_eeprom_mgr eeprom_mgr;
 
 	struct ras_psp ras_psp;
-- 
2.55.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B11BAC02182
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2025 10:31:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E73910E6AB;
	Wed, 22 Jan 2025 10:31:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hDUAGEvQ";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D615210E6AB
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2025 10:30:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VNiAFc+qluLxDxaTBO7VrBYbTFY4B6JYqQTob+VFh/cZd/2fBmME9ifbuj7DslijN0P+sAFDb0VIWRenuZHwrbc6zOOlTIkravon9r3kOoBlHxqsqmf7oznChPKFZCs8LV25PUtCzL8P+VYR1yHEJ0dtqJJZ+sbckuwbehpkty2IV/ZDL1gAYEQjOwHhVWxk9J7diT5j4eUIoTeRbwmsC5cv0ax/ritWC6fN0kAGTg/sGOd9xbZt/JX/cH6EwkCekMDaO6KP0YsseIJYFmtUn7SlOiXVBpUYV3IHIW7No1d/2mSld1xyHbmxLYsqhpXTtie3EEdiC1MSwxIPi7KrHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jUNgfSMD0bN+xLTF3YhBjDYFvU6xSEYE2t9lSoCgEc=;
 b=kySyWWMG4dNIWMfaXnSlXzkBt/VC+UTqP8iRicgJ2iAxpAtseheJbVx8LsOd2zhOdeQKd89nmhU34u6OYAdBBC6D5BOZNb1+wA0lvWnzu4/E6owqVFKSvATj643ShAbwlrERSBeL8Qv4y5amihRtuQPferGEanK5afKReTTspDutO0ip//Ssv6d7zdicOXYmNAoYt2Ws89Uu88I9cwz/+1eBhbGg1wXVpyHyOP69iG31L65GfUtF/HGWLC5oj2t7baX807WtfqEOepnJKVFGz7oqq3SeFFnr7LpyHKbQT07sMK6ycwp+felr9Q4w0oUW1jYwmWVYNbGDf9F9yPWNkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jUNgfSMD0bN+xLTF3YhBjDYFvU6xSEYE2t9lSoCgEc=;
 b=hDUAGEvQu0h2417I44dlBZy0tkZYP+As+vPDg6aI/qgqMMjWn6+i374uH4ojhYUrntlpizfAhoo8eOixY0rHVjdQWbssEjs98G/qz1Uz7b9UFOU0IgCDzGj2S4xsVSKorx63Pxi33VV3nAVXC3gJH4ZWlg2I7mJxZcruw56XQ7A=
Received: from MW3PR06CA0006.namprd06.prod.outlook.com (2603:10b6:303:2a::11)
 by SN7PR12MB7955.namprd12.prod.outlook.com (2603:10b6:806:34d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Wed, 22 Jan
 2025 10:30:55 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::b) by MW3PR06CA0006.outlook.office365.com
 (2603:10b6:303:2a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Wed,
 22 Jan 2025 10:30:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Wed, 22 Jan 2025 10:30:54 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 Jan 2025 04:30:52 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <Tao.Zhou1@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Update usage for bad page threshold
Date: Wed, 22 Jan 2025 18:30:18 +0800
Message-ID: <20250122103018.17264-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|SN7PR12MB7955:EE_
X-MS-Office365-Filtering-Correlation-Id: 71f78480-5ac1-4e2c-4821-08dd3acfd9bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jgKwgk8CCYMa987ym98Wun01atur9g+BOSOCqcKJm/AdPSAxvlOjgcHaegSN?=
 =?us-ascii?Q?bXO6x95UHkzJLwDGSub+pmMfocoHYlpMFHWJRh/7y7ctuxEZegsWx80CsZzs?=
 =?us-ascii?Q?vWXTd/xCZSlR05Vy+wLa1wFD3HYw9nFoZwu6ERR3hRJSJRzvb9jJ4XTrWvkQ?=
 =?us-ascii?Q?Y7cvGjyGyRRpnQgC+DcLMnooudZaA3MiAoNjr+EDFtTXjzYrMM12xZk11ZmM?=
 =?us-ascii?Q?Sctn+6EyXslAm1N0L7GeCFLYZGAklUVkKCX7GXUzUZQh4rToWe44lkMsoHxk?=
 =?us-ascii?Q?wWLoEOy/RPwuChWV7+jX5JvIjTKSIDhSQ+LzKAYmwMD/G03SNalYrZrLobXw?=
 =?us-ascii?Q?zzQX6SJcEleVc56M7AjKq/R9HKYF8sRmw/a5KtE81mHX6WPl25Iu3hu9vObY?=
 =?us-ascii?Q?i1AphSW3UuNV8xQb8snkjwXDpYSo4htD+9Yh7nDUuhVp4bpT4OevaIEWrmBb?=
 =?us-ascii?Q?BBnC7oW4E7U/N1sUMb92a7HWVJiPYdRGD2GoANPoaGHzKPr04ZRV80JbQ4ih?=
 =?us-ascii?Q?iLzBHCOOWXt22K+937OSPYrvcE9KKv5O2zC1NDhKrydz5CN6LL3n+fFIb+1L?=
 =?us-ascii?Q?Q0mWQU6fBgHzgRrecDbVJbdsBYuG78hhiNoDO00CqQPrSB7LyPxWVTm456u3?=
 =?us-ascii?Q?ajeQ0MqioN5jB7fG6/pU+wufYcYLDMJdAFlDuDolelHD3jAAynFvtY/OnT03?=
 =?us-ascii?Q?YZKGxWVvqzhUCdwAIcsnadlccC3ikqLpUelApmtwawAWBVwy69xc2CbRG26e?=
 =?us-ascii?Q?Ylb0vjwEo5LYCEjn0Fz6REDVh5VFuO5PU6USwOtgRJN0J5OfyTWXvCkIWjsT?=
 =?us-ascii?Q?7iEk8MaTO7HEHNrO4KaKGPNzneOFVLmjzKA1FhKVEDo52qZ7fRb8SL9Z4PWk?=
 =?us-ascii?Q?XdP+2F++3svzI4TkJ6R2LWzujiO9EGIprNDQ0/nZQGmXMpH78ADoxeGsLe/3?=
 =?us-ascii?Q?nnH+qyxJuYesVGSIjC/BsDDs/nGqg9eu4iVButgJNLJ9YrAoUlm9kSgmA4Na?=
 =?us-ascii?Q?raSs5OlrISgjckg1nseOU0ERFq3gDrHAlGSkb6tTPDN8M9t13qosgFZ+ApAF?=
 =?us-ascii?Q?yrydklxBEfPgqY2w8aXZsNGBpIPdL4OpkSz46kZ0pjeAAJ0EJFh9JkksbSJl?=
 =?us-ascii?Q?pyjAkWBSB/WMtWKtZns0pjNeIbPc3bHLygKgzhziawyccr8PPiuHGbSS5hUh?=
 =?us-ascii?Q?1sG1m6FiItIqakZrtLaZm7aLYBCzd5tXO/4oR7S9zIw/01C1ecojf0gy5wBl?=
 =?us-ascii?Q?abx/XAGXWa7aVvtLW6MaehoJXE7+TSskYH+xRsjsil6X6HaZKq+KKjkP2y3Q?=
 =?us-ascii?Q?YE7kQnTFbqFVv6tT0UomDAcLGW7kvtoFiEhMa7afns2lmKWYuKGVlLfuMfEJ?=
 =?us-ascii?Q?xyNUd1P5RFg57vVPAebxSjwbUkfY89da5NoJ23GfM1STq6qdUVGXzwLVWaMF?=
 =?us-ascii?Q?lb4LW89D4gIka+G8x65SzZ1mYZrTMny9Oh0m8dtIy7akPeArkdwCNJWygGZA?=
 =?us-ascii?Q?72azwhHZat7WgZ4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 10:30:54.0486 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71f78480-5ac1-4e2c-4821-08dd3acfd9bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7955
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

The driver's behavior varies based on
the configuration of amdgpu_bad_page_threshold setting

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 54 ++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 25 +++++----
 4 files changed, 44 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 99d884e6763a..87ea2e2a062f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -983,7 +983,7 @@ module_param_named(reset_method, amdgpu_reset_method, int, 0644);
  * result in the GPU entering bad status when the number of total
  * faulty pages by ECC exceeds the threshold value.
  */
-MODULE_PARM_DESC(bad_page_threshold, "Bad page threshold(-1 = ignore threshold (default value), 0 = disable bad page retirement, -2 = driver sets threshold)");
+MODULE_PARM_DESC(bad_page_threshold, "Bad page threshold(-1 = ignore threshold (default value), 0 = disable bad page retirement, -2 = threshold determined by a formula, 0 < threshold < max records, user-defined threshold)");
 module_param_named(bad_page_threshold, amdgpu_bad_page_threshold, int, 0444);
 
 MODULE_PARM_DESC(num_kcq, "number of kernel compute queue user want to setup (8 if set to greater than 8 or less than 0, only affect gfx 8+)");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 960476e6124b..5676ffe5c43a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3071,35 +3071,35 @@ static void amdgpu_ras_validate_threshold(struct amdgpu_device *adev,
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 
 	/*
-	 * Justification of value bad_page_cnt_threshold in ras structure
+	 * amdgpu_bad_page_threshold is used to config
+	 * the threshold for the number of bad pages.
+	 * -1:	Threshold is set to default value
+	 *	Driver will issue a warning message when threshold is reached
+	 * 	and continue runtime services.
+	 * 0:	Disable bad page retirement
+	 *	Driver will not retire bad pages
+	 *	which is intended for debugging purpose.
+	 * -2:	Threshold is determined by a formula
+	 *  	that assumes 1 bad page per 100M of local memory.
+	 *	Driver will continue runtime services when threhold is reached.
+	 * 0 < threshold < max number of bad page records in EEPROM,
+	 *	A user-defined threshold is set
+	 *	Driver will halt runtime services when this custom threshold is reached.
 	 *
-	 * Generally, 0 <= amdgpu_bad_page_threshold <= max record length
-	 * in eeprom or amdgpu_bad_page_threshold == -2, introduce two
-	 * scenarios accordingly.
-	 *
-	 * Bad page retirement enablement:
-	 *    - If amdgpu_bad_page_threshold = -2,
-	 *      bad_page_cnt_threshold = typical value by formula.
-	 *
-	 *    - When the value from user is 0 < amdgpu_bad_page_threshold <
-	 *      max record length in eeprom, use it directly.
-	 *
-	 * Bad page retirement disablement:
-	 *    - If amdgpu_bad_page_threshold = 0, bad page retirement
-	 *      functionality is disabled, and bad_page_cnt_threshold will
-	 *      take no effect.
 	 */
+        if (amdgpu_bad_page_threshold == -2) {
+                u64 val = adev->gmc.mc_vram_size;
 
-	if (amdgpu_bad_page_threshold < 0) {
-		u64 val = adev->gmc.mc_vram_size;
+                do_div(val, RAS_BAD_PAGE_COVER);
+                con->bad_page_cnt_threshold = min(lower_32_bits(val),
+                                                  max_count);
+        } else if (amdgpu_bad_page_threshold == -1) {
+                con->bad_page_cnt_threshold = ((con->reserved_pages_in_bytes) >> 21) << 4;
+        } else {
+                con->bad_page_cnt_threshold = min_t(int, max_count,
+                                                    amdgpu_bad_page_threshold);
+        }
 
-		do_div(val, RAS_BAD_PAGE_COVER);
-		con->bad_page_cnt_threshold = min(lower_32_bits(val),
-						  max_count);
-	} else {
-		con->bad_page_cnt_threshold = min_t(int, max_count,
-						    amdgpu_bad_page_threshold);
-	}
 }
 
 #ifdef HAVE_KFIFO_PUT_NON_POINTER
@@ -3852,8 +3852,10 @@ static void amdgpu_ras_init_reserved_vram_size(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 2):
 	case IP_VERSION(13, 0, 6):
 	case IP_VERSION(13, 0, 12):
+		con->reserved_pages_in_bytes = AMDGPU_RAS_RESERVED_VRAM_SIZE_DEFAULT;
+		break;
 	case IP_VERSION(13, 0, 14):
-		con->reserved_pages_in_bytes = AMDGPU_RAS_RESERVED_VRAM_SIZE;
+		con->reserved_pages_in_bytes = (AMDGPU_RAS_RESERVED_VRAM_SIZE_DEFAULT << 1);
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 82db986c36a0..cc4586581dba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -65,7 +65,7 @@ struct amdgpu_iv_entry;
 
 /* Reserve 8 physical dram row for possible retirement.
  * In worst cases, it will lose 8 * 2MB memory in vram domain */
-#define AMDGPU_RAS_RESERVED_VRAM_SIZE	(16ULL << 20)
+#define AMDGPU_RAS_RESERVED_VRAM_SIZE_DEFAULT	(16ULL << 20)
 /* The high three bits indicates socketid */
 #define AMDGPU_RAS_GET_FEATURES(val)  ((val) & ~AMDGPU_RAS_FEATURES_SOCKETID_MASK)
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 0d824f016916..bd9ed86d8fde 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1428,8 +1428,9 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
 
 		res = __verify_ras_table_checksum(control);
 		if (res)
-			DRM_ERROR("RAS table incorrect checksum or error:%d\n",
-				  res);
+			dev_err(adev->dev,
+				"RAS table incorrect checksum or error:%d\n",
+				res);
 
 		/* Warn if we are at 90% of the threshold or above
 		 */
@@ -1447,8 +1448,9 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
 
 		res = __verify_ras_table_checksum(control);
 		if (res) {
-			dev_err(adev->dev, "RAS Table incorrect checksum or error:%d\n",
-				  res);
+			dev_err(adev->dev,
+				"RAS Table incorrect checksum or error:%d\n",
+				res);
 			return -EINVAL;
 		}
 		if (ras->bad_page_cnt_threshold > control->ras_num_bad_pages) {
@@ -1466,17 +1468,18 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
 			res = amdgpu_ras_eeprom_correct_header_tag(control,
 								   RAS_TABLE_HDR_VAL);
 		} else {
-			dev_err(adev->dev, "RAS records:%d exceed threshold:%d",
+			dev_warn(adev->dev,
+				"RAS records:%d exceed threshold:%d\n",
 				control->ras_num_bad_pages, ras->bad_page_cnt_threshold);
-			if (amdgpu_bad_page_threshold == -1) {
-				dev_warn(adev->dev, "GPU will be initialized due to bad_page_threshold = -1.");
+			if ((amdgpu_bad_page_threshold == -1) ||
+			    (amdgpu_bad_page_threshold == -2)) {
 				res = 0;
+				dev_warn(adev->dev,
+					 "Please consult AMD Service Action Guide (SAG) for appropriate service procedures\n");
 			} else {
 				ras->is_rma = true;
-				dev_err(adev->dev,
-					"RAS records:%d exceed threshold:%d, "
-					"GPU will not be initialized. Replace this GPU or increase the threshold",
-					control->ras_num_bad_pages, ras->bad_page_cnt_threshold);
+				dev_warn(adev->dev,
+					 "User defined threshold is set, runtime service will be halt when threshold is reached\n");
 			}
 		}
 	} else {
-- 
2.17.1


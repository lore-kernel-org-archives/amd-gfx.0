Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D81E2C02181
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2025 11:38:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84DBB10E6D1;
	Wed, 22 Jan 2025 11:38:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lomGWU1T";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::606])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC56110E6D3
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2025 11:38:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=viCM1uwL78ouEaABXnDU9eILJs+LJ2Wwl5asYsKTSTgXP76JUcikmsvwJKwFNDfhA0wKn02JmWE2WLFh6YUcLwAJfEFSPEyaNJponEPpBsBBkCw/vEvvLQNXjG3kMhRADZWbqrGxrXPXrGT3jd4H+o5Wp+bKSwARtXzhM8gkEangk9goxR20LPzZc1UTjglHgWxB66fpWkOKPk6s/P9yh90QyE+qTCujcCZSiLFqA5vNFxHtt8xgsWSpcLYGtm6lG807xif5rbNm4pyLNBcfC+Z76xEx7XFTKJ5/KZvaQf/qT/9LFRhJouVgvEqbCCFpxYgodW/5dx6lNebuQjDsfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1tkyIEbfEIS9uWLL+D84uBTmtJY38faiJlkXufSSqE=;
 b=A3ZVcKej7GvvMsCQCWJD2OVvl8U40UyUi68TkNmF42lPK4Ae7yYql/Lp08ns1sZmq4vNx+bcbmn995Eq0d3OVDmsX72Hg15ZnVByp76Q49ayXLmKjCPjTHidjw6uOtPq4INtk/uJa+jpZpi9yIqVs4qUwXXmr6vdUYmOyE2pNCK6Pff2a/47e9Kd/ifsl/MDZlIGou5JWuxCCOvwC20OLf9irIkAFbU/0t3ejpjKashYEGQ/9jGn4+tAKt0YT+tGaHSX0rOnfCxohUOyn4lU/PVHhB2NAcwbA5xxRLzMvEh5/INsnezrvFAsiJxjrmeXJ0Jz8m5UbEJ5ciSMPh1VZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1tkyIEbfEIS9uWLL+D84uBTmtJY38faiJlkXufSSqE=;
 b=lomGWU1TPTdxT9kVldHs70kRJm8b+02laBXEqPfPNv+wlzDm5gRFWuDDqCBGUINxN+zQJRR79AhvYmhzK+poxNOF9fmb2Rt8oAknMgtloXKTcoZ1CmBZKJn0F7wzCtbSckxWwUvzpM8cHv2XB/XWtBSewTM2TPF0ayu5ZqeTri8=
Received: from CH2PR10CA0023.namprd10.prod.outlook.com (2603:10b6:610:4c::33)
 by SJ1PR12MB6196.namprd12.prod.outlook.com (2603:10b6:a03:456::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Wed, 22 Jan
 2025 11:38:19 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::27) by CH2PR10CA0023.outlook.office365.com
 (2603:10b6:610:4c::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.14 via Frontend Transport; Wed,
 22 Jan 2025 11:38:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Wed, 22 Jan 2025 11:38:18 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 Jan 2025 05:38:17 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <Tao.Zhou1@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH v2] drm/amdgpu: Update usage for bad page threshold
Date: Wed, 22 Jan 2025 19:37:58 +0800
Message-ID: <20250122113758.13491-2-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|SJ1PR12MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: 98a3532c-4fc0-43ff-4851-08dd3ad94490
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l/ztK4qvHQcw+3zAXrJvJ7SO5cd/7uNIO69Y2B6whgSYCaTGEOxDjVOf4vRY?=
 =?us-ascii?Q?kPtOF2k+b0Uw6OahKO1eM13mwKwcRUQHJptrpqMOnzT/ds+UUCiNAiS+MrPb?=
 =?us-ascii?Q?kamqReu3USuStHa6AAGChM7Mz3+Iqe+c55OsecYE2R1bpdzWvZXbwvgYH01A?=
 =?us-ascii?Q?CbEu864cb7WMitofiq+EbVhLNOwjjGrA2l3uoSrPub24lYH5/agK4O/ns/BH?=
 =?us-ascii?Q?9tKcorvmt+ajsUO1fIpH7N2nsINIQZ8rBEvlk6sN117000m30V6GYJytutK4?=
 =?us-ascii?Q?wO5652+qhdS/1ozs2IVz4+xKaUwQX0s2Jj2tO221kbIpHhOX0b7aT8usdILN?=
 =?us-ascii?Q?Aw4/RmkfpcDwwC2ojtrCbDSS7veIKxkxa0XX442RPb61wnl/dvRddrCB2V63?=
 =?us-ascii?Q?Wnt+rrn4nx8pRAP8l+u4eEaMyNqB9slxoWFlPpvIU8gQUzxa0oaKlUC50MOf?=
 =?us-ascii?Q?5rFYlJGrElPBglNm/Afow4eOVe4Cyl8e66nuc0pjAZTuKia/DJ0j9YWcJxY9?=
 =?us-ascii?Q?eidUUktv6d5+DsBg7dB7zfj3gqBH6AOLeRmjRntTvlnAn/yNozUENJXkselW?=
 =?us-ascii?Q?xqofB8A0v2xhMDlSDyj2B3jRsV6oj5tooRvLj7KBnqMmr9owgT2IGjR7rDH8?=
 =?us-ascii?Q?6fk/ZK4FS5/GZelS6TeJWutNpBKh9cV6SAbXlT/AGxOZrdl8kaRZtMMSgJcQ?=
 =?us-ascii?Q?bFRpNOz5bJTjuifnF7OgDfvJC7BbQCqab9zwaFhbCGhMEkJYCn8SRC1kORRZ?=
 =?us-ascii?Q?2FbU5aHesH8rehtVH1cTyq2TSoMuYyhsqYlL28PeO1JYN/PfqQmK3rXal9fh?=
 =?us-ascii?Q?a2txBk2eQU8NRsef6Bh8KuBTI/SkbO1DzG/yNDJrUFC9yQFEKDSUsW1eQBxf?=
 =?us-ascii?Q?W0/dtT+bGEwpkXyt+zcdAo7qlHuczU7KRuKlNXiAQhFZUEglqr9Rqs55grFT?=
 =?us-ascii?Q?mHNRjIQSe9eBgSTCX/lrxFVSRtjJV1+qQtGC5gvjJbADs4owLQgdjOB4Batf?=
 =?us-ascii?Q?P1xJdo+Wz4pf+VLl04I8WoKp6qi2s6ttjh1qjWIFkSl+dZ7PzcuiD/vlsSD/?=
 =?us-ascii?Q?H5bt2/uxqESEwIE4+WSUC15H4ir8HYPuRzfNfhk1RTDbb8ADdi6vpANAhaUi?=
 =?us-ascii?Q?BL6peUgv5agWfnH5en2yYJnOv4Pzi9SSvO2fOcrw5CwHOemSkfmE1dpOlnq5?=
 =?us-ascii?Q?Wx9vurV4zQM9WBowXcjdwHU3urjiLZ7pkdF/PxUltaZKIJmW/e2TK4trwxuT?=
 =?us-ascii?Q?6s/0lDbXDddSdJJAVBG0DErg7R8m5qLSzXGEj7g7HfI7k14hZ/wHKcdqTIcL?=
 =?us-ascii?Q?k/vV2Ne9JRAwl2M4VwAvSfK9pZnTTW2AGx2tUIKAgNIgpHNTpHz+K8IzJzzJ?=
 =?us-ascii?Q?BvkDOgjwJ0bykzrwPmXkonJyMJkKtJwCNnNLFFugxgQ5FtF/xh1lli7i5+j3?=
 =?us-ascii?Q?6CxF5gUnsQ1XPHURpRWS7Iy7+c6QHe8dWGfeD4YcglZTqIsScSLsr4mpDCLT?=
 =?us-ascii?Q?qHPYGuh5Cdj4l1s=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 11:38:18.8161 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a3532c-4fc0-43ff-4851-08dd3ad94490
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6196
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
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 41 +++++++-------
 4 files changed, 53 insertions(+), 46 deletions(-)

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
index 0d824f016916..0e3e7127c11e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -558,16 +558,17 @@ bool amdgpu_ras_eeprom_check_err_threshold(struct amdgpu_device *adev)
 			return false;
 
 	if (con->eeprom_control.tbl_hdr.header == RAS_TABLE_HDR_BAD) {
-		if (amdgpu_bad_page_threshold == -1) {
+		if (con->eeprom_control.ras_num_bad_pages > con->bad_page_cnt_threshold)
 			dev_warn(adev->dev, "RAS records:%d exceed threshold:%d",
-				con->eeprom_control.ras_num_bad_pages, con->bad_page_cnt_threshold);
+				 con->eeprom_control.ras_num_bad_pages, con->bad_page_cnt_threshold);
+		if ((amdgpu_bad_page_threshold == -1) ||
+		    (amdgpu_bad_page_threshold == -2)) {
 			dev_warn(adev->dev,
-				"But GPU can be operated due to bad_page_threshold = -1.\n");
+				 "Please consult AMD Service Action Guide (SAG) for appropriate service procedures.\n");
 			return false;
 		} else {
-			dev_warn(adev->dev, "This GPU is in BAD status.");
-			dev_warn(adev->dev, "Please retire it or set a larger "
-				 "threshold value when reloading driver.\n");
+			dev_warn(adev->dev,
+				 "Please consider adjusting the customized threshold.\n");
 			return true;
 		}
 	}
@@ -758,7 +759,8 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eeprom_control *control)
 			control->tbl_rai.health_percent = 0;
 		}
 
-		if (amdgpu_bad_page_threshold != -1)
+		if ((amdgpu_bad_page_threshold != -1) &&
+		    (amdgpu_bad_page_threshold != -2))
 			ras->is_rma = true;
 
 		/* ignore the -ENOTSUPP return value */
@@ -1428,8 +1430,9 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
 
 		res = __verify_ras_table_checksum(control);
 		if (res)
-			DRM_ERROR("RAS table incorrect checksum or error:%d\n",
-				  res);
+			dev_err(adev->dev,
+				"RAS table incorrect checksum or error:%d\n",
+				res);
 
 		/* Warn if we are at 90% of the threshold or above
 		 */
@@ -1447,8 +1450,9 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
 
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
@@ -1466,17 +1470,18 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
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


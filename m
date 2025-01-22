Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41616C02181
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2025 11:13:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E87BF10E3AA;
	Wed, 22 Jan 2025 11:13:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ww/mC4Ga";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDEEB10E3AA
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2025 11:12:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GNY0CJdWQ4yZ7QMXK8Ls8/GOoOZe4xtzO+tbIk6Ro1irZhJPOvkJfgDzMi0dN2OrPaxBU9936PDDo6G3nFRqeYbU4HaG54opEz1petulOtegFnfE0DpihKDb6vwbLJuhD0moPFbkpNwlTvDbh0wqYFV2TbILnkvbt95R7+29Fe8cQgdH0f8R52ziZ+fhI39nSkEszrQUfnF9KoeiDEgSVUXeqszQgsoqjt8oAa5tG9Sb+GlbWUzZpoK7AZOQx5D+2snHggQEi7zTtFSG67FyV8nMoNKl0xqMXcc7WcbVUPWxxf9Qb2XjLwjiT2qsblkSG3dO18BiN/h3zph/EHE5vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/Olg7JVfQ4WKdqVMpQYk60VBmaFr+9lk6GxiTFNHy8=;
 b=nff3xQmTD1+C9aJjF1zvrrQ7AqTBqy0QiH2nbT3ztjoC4GGcHPcJNfQpzAgFer9iWPZQeNvRnSwSh5t3vfMUcQEWu1/koFGpYVJ/CPOVHB2Kg7M0yISavqshkihyfwSKGZM9CpcFFTHAE/8vVy0GO9SgJf8q9onJQv4sgP1p355nIDK7omD+V3fsWe6dnBZaetuFUbBtWF2XReo1Zn8z1oGsqSTwsg2x8rDhklIcIrSpwapBwkZP/3X3bcm2B32BMWncXLIStgDBO/SajPPgeFW42Kys9BlWmHb51kyQTZgl5lPxfV5i8oH8GPJ/W273+uTTOcJIM/GHNH+ZUoKPhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/Olg7JVfQ4WKdqVMpQYk60VBmaFr+9lk6GxiTFNHy8=;
 b=Ww/mC4Ga/WJX9+keaNRYSFwL86kw6g5Uhbki7Ke3PmiK6Y9Mh8Fr8pNMf/HDR/+8njsAP4ZvgUvz4NiTWN+btewERuZhiDxLBR2wHUvLIAQaWBlXoV1Fmow0Z6sPf5ZOSnXOT8+pct8AzTjVeYTuhdSxtkrsnA359+NE8B78imk=
Received: from MN2PR03CA0028.namprd03.prod.outlook.com (2603:10b6:208:23a::33)
 by PH0PR12MB8774.namprd12.prod.outlook.com (2603:10b6:510:28e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Wed, 22 Jan
 2025 11:12:42 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:208:23a:cafe::c6) by MN2PR03CA0028.outlook.office365.com
 (2603:10b6:208:23a::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Wed,
 22 Jan 2025 11:12:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Wed, 22 Jan 2025 11:12:41 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 Jan 2025 05:12:39 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <Tao.Zhou1@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Update usage for bad page threshold
Date: Wed, 22 Jan 2025 19:11:56 +0800
Message-ID: <20250122111156.17411-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|PH0PR12MB8774:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f4a2459-0189-4316-6e3c-08dd3ad5b029
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tJLWtDrvT/thSLLYMVDqfSnWhMKAR4X+118FJlBoN3eaqHqdzd9jtPFXj+pK?=
 =?us-ascii?Q?Zfn5VQ1KadjG7Fjom9KL62JL+X/BMoIKx5KlvMwrQF8wb9wduR0PcJSV+bTN?=
 =?us-ascii?Q?oDJKcMF3GzPm13ITj8R7sJyQ/C6bgGxWW8ZIxnVMXZLnhmDTCC8+01PV412k?=
 =?us-ascii?Q?5KLvAP3/AiN/Fsoch1FAEtVgyhrGF/VFQaLjcKZXybfei+S4N9PKSdFCeimx?=
 =?us-ascii?Q?UYSaBXMxwuN9y/xHKKdBbT6+rgkQXZyO8KmW4zAtyFLrjyrue5AUQ9wPaUiW?=
 =?us-ascii?Q?HK2TcBNZuoL99ov/REwwwDZuOwJ92xAw4vpwHlGxxrMYq4qUJkCbYZJBBo2D?=
 =?us-ascii?Q?qe1DQKxGxwn7PYOw07EkI+d1LEAjF1BwZFNVNR4z4gdx4piqkRcvoZCaQzAC?=
 =?us-ascii?Q?J3f/CJ892XItoDs7IjccGghxSl66sumgceiQ43wFdG5CTf23fiT1NT9BDZCa?=
 =?us-ascii?Q?WZ2q6/hFRiaFvasxZMCwI2oVROW9UqyrSH+VD3CD/eN4LtMvWbnLFIKySclq?=
 =?us-ascii?Q?0qSBuvBJlOX2EEDUiCyM3oakPqoHouhmAS1wVRhIFl6XGfS5Ms2nCSasJgG9?=
 =?us-ascii?Q?8zF1tKCHOmid2p8HKGwFnADxjcoKWHDW1JMmk3ib75Zxlls2ZQcYlFRKPr/7?=
 =?us-ascii?Q?wUZFX0ajM8hemIxp7M9m9t6vNl3V78Ny3xlqtOt0Ywe85V6XntNKPjvv7aWO?=
 =?us-ascii?Q?l/OTQe/uCu2y05SBwAMC5dUo62lMjbU1E16A990KZiHCz3zM13Gw1/jM/IWN?=
 =?us-ascii?Q?iZDJHOwDE7B/XTubQr/bZfYZiuVaZm4L/UiU3LqiV3ZsCfcApjl4opeuBFcj?=
 =?us-ascii?Q?0+yaqz4voS9m5f2fQqUEykHIlnZl0NBspk6/NqDBohvhv9g3wzG3Rg/rgjUQ?=
 =?us-ascii?Q?C/R2EEfkvebVIMvh+aTrvXtBUjcPghhTr4TZB+yQwZuuVT+vPxQ3xOipZCQI?=
 =?us-ascii?Q?P5N6l0I5XmDC2YIcP0CqslaXLSHBiVdZDFL+zKBJendhNt/e6mhcZTJ/eOQb?=
 =?us-ascii?Q?j+Pc8dNz5s3UjBlDFpN3WsRdsksJy7Mz8wYpirayAbTNpM1LAp0ZeLrl/B0J?=
 =?us-ascii?Q?PPoOaz/gp3t8AV/fDjSkWJt43P8f3xRc6WwyT+kHSTkm6HCoEuDSV+KV5wr5?=
 =?us-ascii?Q?1m8nWzqYvDVxQxitqh3pWxawxhdpkuFDrNwQuAdxpi1rDuAdY/xrmWsmG+1T?=
 =?us-ascii?Q?Oay24VwJnmA+i5Lwt+2hA5jchxIYgftHPSSKbfGDhWSYlyHolUZGXJ0P3uLL?=
 =?us-ascii?Q?aIxkXqF94XbBALKbpoOA4HFILiqLGu/8oaccWQPRR5NnRAPuHyUNs4CbAeH5?=
 =?us-ascii?Q?nr0SLlpYtp2v2eolmeVD/NyoV8w3ldSYZi5Fpf49MPWnF/eX/T+Pqx84fDLs?=
 =?us-ascii?Q?0NYNghXVa/Ekr2QsqfMgh1U1ApaL9gV/IPwekdbUtH5Lo4vAWGCipcvx7yRr?=
 =?us-ascii?Q?ZrHQiVL4oK8bhgrM5pB60WcyuIc03HO+lmBv1BFC2d6IR6OyxTWjPIWVPIwt?=
 =?us-ascii?Q?1w5aCBj0qd7sDP0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 11:12:41.3803 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f4a2459-0189-4316-6e3c-08dd3ad5b029
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8774
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
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 28 +++++-----
 4 files changed, 46 insertions(+), 40 deletions(-)

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
index 0d824f016916..c05ef519deb7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -758,7 +758,8 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eeprom_control *control)
 			control->tbl_rai.health_percent = 0;
 		}
 
-		if (amdgpu_bad_page_threshold != -1)
+		if ((amdgpu_bad_page_threshold != -1) &&
+		    (amdgpu_bad_page_threshold != -2))
 			ras->is_rma = true;
 
 		/* ignore the -ENOTSUPP return value */
@@ -1428,8 +1429,9 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
 
 		res = __verify_ras_table_checksum(control);
 		if (res)
-			DRM_ERROR("RAS table incorrect checksum or error:%d\n",
-				  res);
+			dev_err(adev->dev,
+				"RAS table incorrect checksum or error:%d\n",
+				res);
 
 		/* Warn if we are at 90% of the threshold or above
 		 */
@@ -1447,8 +1449,9 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
 
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
@@ -1466,17 +1469,18 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
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


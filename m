Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC9FCDB466
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 08:21:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1915810F19C;
	Thu, 25 Jun 2026 08:21:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OXPfOJgs";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012043.outbound.protection.outlook.com [40.107.209.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D649010F19A
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 08:21:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qavhx5cFsSG1DOeu9xdCd29I10JYCTMAb0Waj+UV7QQ8ctyvRZDFYWFm4k2WC50jVfvmX+/TYQUnqeOXNGmw1ubaR/9cV9e0jNCuEGbWqU/NItM/q6f+xd6cCCOzAAAQmlMWY31Hoj/UJBKoAWvSxkUfrIgNK8jEePGIo8tU6dp39gaEPBIPuyqNmeoPS6p3ggUavcIXrNe6j0Cnu/vph4IPBZEvf7mbpscsVYE8XApFUR075J4kRw0GWQIx8jgkR8YUH49y3SsqPBlUhhA5NsqBKiOtvKJNC8zDnk90WUYpIWgQeEwuppkV+oanzrUIqKQ7M8g/VA0sNgZXg6+Gpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2SuQwwe175OBIrVNQWK96vHd8cbyoyySSvhr6AVrdCc=;
 b=eGbGOONllKo5A0CVWg2OxX7+hy8gFo7/JV3jTsCCS+N3Ey/zQMN3+abCMVK2c3fi2ypCTq7PCfHbxDiLiq7eGAkYHNuGFqqT177lJqubj08CfM4E5Pe02Ow5eoeXuT0KxTCqXvZkTR3TVMSr905ZAQ2/Lu7Za8SsES2ywE8pj1giOGYvKPvW7LeJ+1/mzXticapS8CGBvynK2l7Ul7YFOhfMq1DjeZRK0+puPopS+eqLyecqsFOg02p85tyAARhubRtO/WOXATxMaZRhxWS/4d/8ybc+iaUyQj1IvEKtDDhmRo6wHZ822sSNwmIYf3h2FBofNEqt6Wsjr2Gr5rygMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SuQwwe175OBIrVNQWK96vHd8cbyoyySSvhr6AVrdCc=;
 b=OXPfOJgsPk5E/uxz8ycZp75WU9A8GdlknBn9pz2TqivhO+g/JJqKzCXSL1L36INXBo2IXI9Mq874D4TaTuk6/Z7i3jClUAW4BdrjF/k+XTKMJadwb3U97PAEhbOtpABsDIsv5uJTBHZdfz+kaQEjWKpVtgunWjCdOH7wdeA0rxo=
Received: from CYXPR03CA0063.namprd03.prod.outlook.com (2603:10b6:930:d1::25)
 by CY1PR12MB9560.namprd12.prod.outlook.com (2603:10b6:930:fd::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 08:21:23 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:930:d1:cafe::a0) by CYXPR03CA0063.outlook.office365.com
 (2603:10b6:930:d1::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.16 via Frontend Transport; Thu,
 25 Jun 2026 08:21:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 08:21:23 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 03:21:20 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v3 36/44] drm/amdgpu: retire legacy pmfw eeprom reset
Date: Thu, 25 Jun 2026 16:19:29 +0800
Message-ID: <b9be96feb8ac52dc0f0a437a14c90c9355076083.1782373702.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <b5587fca5f57f8f352245edf2c76606ad3307923.1782373701.git.cesun102@amd.com>
References: <b5587fca5f57f8f352245edf2c76606ad3307923.1782373701.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|CY1PR12MB9560:EE_
X-MS-Office365-Filtering-Correlation-Id: 909dcebd-7442-4365-763a-08ded292be47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: CAzdhVc7lXcCKZbOerqLBpzRYtcvhY01BCJLfUIY2BzKn/R2wDBaATC0J/Rlxk4QmBj+Tv5frnYZM4zfaRvh8ESEYHLEq/Ooq6DPbCkD1apAXlEHwJNy4KeLfkmqZ03xUPLGS+3crcPw5RqjOMq/1W4/cdiAietitf2TKcgfxZ/OeYPu3w/YwbD1Gt1RMnNIQSQ5LOhDSP+ZF734pLQw95zUAnBsr6NOESaHvpHB1Ai99HTecEKvHUrwPhPIMj6Z91GXHEcbRjzeYrK7sG/EethRdX7MlVaOwcMTUC0SsNUBnuqtoDVCyxOajmzk4nguPK+7UjgOaBV9RpOGFWxjr0YPygzckpw6O5tL5c9dr52zh/XpMbUpDcOw1emx7Ji3FHrhjFozWRDVIGTFXDdWTjh3cUGaFuKULRD8WiZjVFwmPXi3lLlHg8T7C+98J0Gmz9b/H4SJ/LwEVfnL+mF5UITwq1lquIFwsnhl5i8Sbqw0ODrzDScs6gcwMpqTG2hBDDNUsi8YZuV8twPUimDJxc9zpTaWcTsEg/MCdjgjrrPDiY7hqWDoB6PI56ruICLasxFU551HXlTrVRdGrYlLl2mA2zV7qebArmpCcuD8IWNVaADh8tWbAGqxbp67k6ifeO+gcCSeCZRF26TD1hCnRtSBUjuKL9pj44YwFZoOJ6go0FqNdZG9W+wdDLbpfqXsBgHovTYijt2vZUHJw8CsbA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ued7SM5fqeQuNOIxvb1RktUvbL8wqj0ip7n0P9+lmpF8TPZbhj40cOzVXdZJ3jx4baGbLLm7c2Sf0edWUW0LWFfoeqk39WRyjn7OIKAQcpRhzViED9quSXD0PCDwZpG/nvNv/iD6adatltbKQ17Bw5dsIFQi0sbUrYxRTrOT9xRQ82XOeQBpfpCXlFQTq2cJp22T12ZGyHOhU3w1SQ4TLnntf/Ai/RHFcWdH6C4pqEnfORRcSt4hGE+H0B8meMZNxOe+qVLUg+5oNW6VR/yJpePVYVE5bhyQhEaoYfs0tA/wJ1TkQod2lPnSrDzp9TvwHZEYMNpFWedkxYjgTcY/8zMWGxoQR8GuB02KMH8X1P62Xy7FawkTgS6J4RFEQE8F27MJQ3FmPhjxHUBWuoXXSvmluNiS6c/JBMC+Tw5C5QAu8SzDZ+iiVNitQvWkz0Ww
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 08:21:23.1722 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 909dcebd-7442-4365-763a-08ded292be47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9560
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

Remove the legacy pmfw eeprom reset adaptation function,
as the feature is deprecated and unused

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 71 ++++++++-----------
 1 file changed, 30 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 09aa5655e3c1..baa8cc3646d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -450,57 +450,46 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control)
 	struct amdgpu_ras_eeprom_table_header *hdr = &control->tbl_hdr;
 	struct amdgpu_ras_eeprom_table_ras_info *rai = &control->tbl_rai;
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	u32 erase_res = 0;
 	u8 csum;
 	int res;
 
 	mutex_lock(&control->ras_tbl_mutex);
 
-	if (!amdgpu_ras_smu_eeprom_supported(adev)) {
-		hdr->header = RAS_TABLE_HDR_VAL;
-		amdgpu_ras_set_eeprom_table_version(control);
-
-		if (hdr->version >= RAS_TABLE_VER_V2_1) {
-			hdr->first_rec_offset = RAS_RECORD_START_V2_1;
-			hdr->tbl_size = RAS_TABLE_HEADER_SIZE +
-					RAS_TABLE_V2_1_INFO_SIZE;
-			rai->rma_status = GPU_HEALTH_USABLE;
-
-			control->ras_record_offset = RAS_RECORD_START_V2_1;
-			control->ras_max_record_count = RAS_MAX_RECORD_COUNT_V2_1;
-			/**
-			 * GPU health represented as a percentage.
-			 * 0 means worst health, 100 means fully health.
-			 */
-			rai->health_percent = 100;
-			/* ecc_page_threshold = 0 means disable bad page retirement */
-			rai->ecc_page_threshold = con->bad_page_cnt_threshold;
-		} else {
-			hdr->first_rec_offset = RAS_RECORD_START;
-			hdr->tbl_size = RAS_TABLE_HEADER_SIZE;
+	hdr->header = RAS_TABLE_HDR_VAL;
+	amdgpu_ras_set_eeprom_table_version(control);
 
-			control->ras_record_offset = RAS_RECORD_START;
-			control->ras_max_record_count = RAS_MAX_RECORD_COUNT;
-		}
+	if (hdr->version >= RAS_TABLE_VER_V2_1) {
+		hdr->first_rec_offset = RAS_RECORD_START_V2_1;
+		hdr->tbl_size = RAS_TABLE_HEADER_SIZE +
+				RAS_TABLE_V2_1_INFO_SIZE;
+		rai->rma_status = GPU_HEALTH_USABLE;
 
-		csum = __calc_hdr_byte_sum(control);
-		if (hdr->version >= RAS_TABLE_VER_V2_1)
-			csum += __calc_ras_info_byte_sum(control);
-		csum = -csum;
-		hdr->checksum = csum;
-		res = __write_table_header(control);
-		if (!res && hdr->version > RAS_TABLE_VER_V1)
-			res = __write_table_ras_info(control);
+		control->ras_record_offset = RAS_RECORD_START_V2_1;
+		control->ras_max_record_count = RAS_MAX_RECORD_COUNT_V2_1;
+		/**
+		 * GPU health represented as a percentage.
+		 * 0 means worst health, 100 means fully health.
+		 */
+		rai->health_percent = 100;
+		/* ecc_page_threshold = 0 means disable bad page retirement */
+		rai->ecc_page_threshold = con->bad_page_cnt_threshold;
 	} else {
-		res = amdgpu_ras_smu_erase_ras_table(adev, &erase_res);
-		if (res || erase_res) {
-			dev_warn(adev->dev, "RAS EEPROM reset failed, res:%d result:%d",
-										res, erase_res);
-			if (!res)
-				res = -EIO;
-		}
+		hdr->first_rec_offset = RAS_RECORD_START;
+		hdr->tbl_size = RAS_TABLE_HEADER_SIZE;
+
+		control->ras_record_offset = RAS_RECORD_START;
+		control->ras_max_record_count = RAS_MAX_RECORD_COUNT;
 	}
 
+	csum = __calc_hdr_byte_sum(control);
+	if (hdr->version >= RAS_TABLE_VER_V2_1)
+		csum += __calc_ras_info_byte_sum(control);
+	csum = -csum;
+	hdr->checksum = csum;
+	res = __write_table_header(control);
+	if (!res && hdr->version > RAS_TABLE_VER_V1)
+		res = __write_table_ras_info(control);
+
 	control->ras_num_recs = 0;
 	control->ras_num_bad_pages = 0;
 	control->ras_num_mca_recs = 0;
-- 
2.34.1


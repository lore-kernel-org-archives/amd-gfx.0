Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C64C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 17:26:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8EB261A4F
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 17:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C8EB261A4F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 594A06ECE5;
	Thu, 21 Oct 2021 17:26:45 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2CD86ECE5
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 17:26:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/apUE+iDvVSVO/WXqtarPisXu9dPCYYWl1XnuiKUT1pOKa5dcT2R9LtcnRY7d1OAhaNC1RLw/gHK+o1ilxBfXlPnpMDiwT9Syf7kKjfFCjx5efx1BWAzjahsnyZiMHZYCx8Ef1GFagZkB3NgBYm9IamzO83NjbLY5K9e1I2lOj34TaBsyWmIQ1vPPXE3RlLUtDP3YODpjF9YbYyxE1EW5ObtbSsfSnButh6cnDSAI/maygab6ntxbPLQQAtL6k1pR9tGvWpQI4O0sGcXimN15v0vp7OfV7WmVS5YW8NPEMiXGavKMxj8HRt+U+9xOMvFWhxf0InKj3VRAlwIsd1RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTb76/AnyBeORcMvg5TW95w1f8ZCb3ZRGONDpaI0kZI=;
 b=cvfaqWmWFz0BaGYpdA0vwC9SS0Gvhup1Ow3DvA1dS43WMiKMapiPF94ufGCbWOluhyhGwWltenE68PKkyl5An5cTppZhBNggj9VRHRLeXE21gkijurUl3JlLafeb94ZGQyHil8ZaVAzvxGjub469R8AcBd+nA6b3HTrzHzErnFYt8cwdG2gXcoKWWGpp8+CqDXNl75w0XWIrIbNC5Z5RgOMUgbBJDyDRqYb1Vu8jI5TL2Mt8TQc/tjWL1EytHqxDuxag/Z+49597FdmkdUjy+9d4HjgMJBwLyr6+j2o+Ijm8S6PQ1/pYkBl6UuUYe2Ymj2oqe69zY51PUCsAMtDJkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTb76/AnyBeORcMvg5TW95w1f8ZCb3ZRGONDpaI0kZI=;
 b=vafkceJXK49fFgjZS27iy3HTv2tSX6BoDJHwBP0M4a8eZ5z/PvyyuhbhDV1nHe23UX/eIFdr+wT3lVxOW9y8DvxpT7ANcZPQqs+a2tfpQuIyvBMBdR6bmgRxfQziBOvPoYavqMC6eH3LK/TycejY3gxA4UMQ5Q5B60V8CkF6Jyw=
Received: from DM3PR11CA0005.namprd11.prod.outlook.com (2603:10b6:0:54::15) by
 DM5PR12MB1564.namprd12.prod.outlook.com (2603:10b6:4:f::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.18; Thu, 21 Oct 2021 17:26:41 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:54:cafe::65) by DM3PR11CA0005.outlook.office365.com
 (2603:10b6:0:54::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Thu, 21 Oct 2021 17:26:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 17:26:41 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 21 Oct
 2021 12:26:40 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kent Russell <kent.russell@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Make EEPROM messages dev_ instead of DRM_
Date: Thu, 21 Oct 2021 13:26:28 -0400
Message-ID: <20211021172628.1294703-3-kent.russell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211021172628.1294703-1-kent.russell@amd.com>
References: <20211021172628.1294703-1-kent.russell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e77fd236-ede9-4d7c-627b-08d994b7f258
X-MS-TrafficTypeDiagnostic: DM5PR12MB1564:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1564899972425360A32C6A0B85BF9@DM5PR12MB1564.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qAykoMva8U/eZdd4DUPFCDbmO4OZUq4K1omSaJXdbg6VfJqxXJev0NwzfCavHnTu8F5RgQRRa3pdlMfIFignZZG6hQcY93GjQLGf0wHcU9cy5DBcteEiMbv69bpzKwsd2utryTRR7gq00LoAvu5+BK/jwbmsaryYu/9RyTdFO96Qjp1rUNZPZGExrQyVDRnMwmqkVGtpTROtKJzs3f8QdMRyjxRkO+KzrOtyxbMBuB4QbZ2CmmjQKkPtNGcLV0HPxs1zZwi19VN97FhI6x89GTCud19LVR2P8VuiUxiIg82Qc+D3SRXg0GAqhi8FjRj9qFn6H/qfvePZmbsBsDmCCCgPdYLefajIpXSaP5RNBKgHSDhLF8lPqjNQSFCBm9G/90eF8raOgKjjZqpBJM0vyAfCFFlteGPZJjbiHSODk6IfTAZ3OtFSap+7pS11ccSmqStxVJgvTfLEPwQGgw+TFRcOaFxEdcxBtFj+QXJNB7VTTSWhG4Cjjv6DZpsddxTBmiWlJoGlQrjukmJtoHqTOQ13/NDmYXm5XJVv8awpr87IYCL0btRAJ5iNZyKhw+RemS//vwDFl/PW2VEVtB8xjEcc3yvEa1ZpDdch1d50O5J03C42yQJwOJeD1YR4kypk8hOg3aRKlnXyASd4mhc342Gw+2Lic7nWcDtDLqH4P7iJgL9hETHFFGSE3K9oUGlXxaLF7LRbBvg26wFco0YO/9DLf3nb1uXAvJK1343bkWc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(6916009)(2906002)(36860700001)(26005)(82310400003)(356005)(16526019)(186003)(7696005)(5660300002)(2616005)(86362001)(4326008)(47076005)(83380400001)(8936002)(36756003)(316002)(81166007)(336012)(15650500001)(508600001)(70586007)(70206006)(6666004)(44832011)(426003)(1076003)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 17:26:41.4591 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e77fd236-ede9-4d7c-627b-08d994b7f258
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1564
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

Since the EEPROM is specific to the device for each of these messages,
use the dev_* macro instead of DRM_* to make it easier to identify the
GPU that correlates to the EEPROM messages.

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 40 +++++++++----------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 0428a1d3d22a..3792a69b876f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -201,9 +201,9 @@ static int __write_table_header(struct amdgpu_ras_eeprom_control *control)
 	up_read(&adev->reset_sem);
 
 	if (res < 0) {
-		DRM_ERROR("Failed to write EEPROM table header:%d", res);
+		dev_err(adev->dev, "Failed to write EEPROM table header:%d", res);
 	} else if (res < RAS_TABLE_HEADER_SIZE) {
-		DRM_ERROR("Short write:%d out of %d\n",
+		dev_err(adev->dev, "Short write:%d out of %d\n",
 			  res, RAS_TABLE_HEADER_SIZE);
 		res = -EIO;
 	} else {
@@ -395,12 +395,12 @@ static int __amdgpu_ras_eeprom_write(struct amdgpu_ras_eeprom_control *control,
 				  buf, buf_size);
 	up_read(&adev->reset_sem);
 	if (res < 0) {
-		DRM_ERROR("Writing %d EEPROM table records error:%d",
+		dev_err(adev->dev, "Writing %d EEPROM table records error:%d",
 			  num, res);
 	} else if (res < buf_size) {
 		/* Short write, return error.
 		 */
-		DRM_ERROR("Wrote %d records out of %d",
+		dev_err(adev->dev, "Wrote %d records out of %d",
 			  res / RAS_TABLE_RECORD_SIZE, num);
 		res = -EIO;
 	} else {
@@ -541,7 +541,7 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eeprom_control *control)
 	buf_size = control->ras_num_recs * RAS_TABLE_RECORD_SIZE;
 	buf = kcalloc(control->ras_num_recs, RAS_TABLE_RECORD_SIZE, GFP_KERNEL);
 	if (!buf) {
-		DRM_ERROR("allocating memory for table of size %d bytes failed\n",
+		dev_err(adev->dev, "allocating memory for table of size %d bytes failed\n",
 			  control->tbl_hdr.tbl_size);
 		res = -ENOMEM;
 		goto Out;
@@ -554,11 +554,11 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eeprom_control *control)
 				 buf, buf_size);
 	up_read(&adev->reset_sem);
 	if (res < 0) {
-		DRM_ERROR("EEPROM failed reading records:%d\n",
+		dev_err(adev->dev, "EEPROM failed reading records:%d\n",
 			  res);
 		goto Out;
 	} else if (res < buf_size) {
-		DRM_ERROR("EEPROM read %d out of %d bytes\n",
+		dev_err(adev->dev, "EEPROM read %d out of %d bytes\n",
 			  res, buf_size);
 		res = -EIO;
 		goto Out;
@@ -604,10 +604,10 @@ int amdgpu_ras_eeprom_append(struct amdgpu_ras_eeprom_control *control,
 		return 0;
 
 	if (num == 0) {
-		DRM_ERROR("will not append 0 records\n");
+		dev_err(adev->dev, "will not append 0 records\n");
 		return -EINVAL;
 	} else if (num > control->ras_max_record_count) {
-		DRM_ERROR("cannot append %d records than the size of table %d\n",
+		dev_err(adev->dev, "cannot append %d records than the size of table %d\n",
 			  num, control->ras_max_record_count);
 		return -EINVAL;
 	}
@@ -650,12 +650,12 @@ static int __amdgpu_ras_eeprom_read(struct amdgpu_ras_eeprom_control *control,
 				 buf, buf_size);
 	up_read(&adev->reset_sem);
 	if (res < 0) {
-		DRM_ERROR("Reading %d EEPROM table records error:%d",
+		dev_err(adev->dev, "Reading %d EEPROM table records error:%d",
 			  num, res);
 	} else if (res < buf_size) {
 		/* Short read, return error.
 		 */
-		DRM_ERROR("Read %d records out of %d",
+		dev_err(adev->dev, "Read %d records out of %d",
 			  res / RAS_TABLE_RECORD_SIZE, num);
 		res = -EIO;
 	} else {
@@ -689,10 +689,10 @@ int amdgpu_ras_eeprom_read(struct amdgpu_ras_eeprom_control *control,
 		return 0;
 
 	if (num == 0) {
-		DRM_ERROR("will not read 0 records\n");
+		dev_err(adev->dev, "will not read 0 records\n");
 		return -EINVAL;
 	} else if (num > control->ras_num_recs) {
-		DRM_ERROR("too many records to read:%d available:%d\n",
+		dev_err(adev->dev, "too many records to read:%d available:%d\n",
 			  num, control->ras_num_recs);
 		return -EINVAL;
 	}
@@ -1005,7 +1005,7 @@ static int __verify_ras_table_checksum(struct amdgpu_ras_eeprom_control *control
 		control->ras_num_recs * RAS_TABLE_RECORD_SIZE;
 	buf = kzalloc(buf_size, GFP_KERNEL);
 	if (!buf) {
-		DRM_ERROR("Out of memory checking RAS table checksum.\n");
+		dev_err(adev->dev, "Out of memory checking RAS table checksum.\n");
 		return -ENOMEM;
 	}
 
@@ -1014,7 +1014,7 @@ static int __verify_ras_table_checksum(struct amdgpu_ras_eeprom_control *control
 				 control->ras_header_offset,
 				 buf, buf_size);
 	if (res < buf_size) {
-		DRM_ERROR("Partial read for checksum, res:%d\n", res);
+		dev_err(adev->dev, "Partial read for checksum, res:%d\n", res);
 		/* On partial reads, return -EIO.
 		 */
 		if (res >= 0)
@@ -1061,7 +1061,7 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 				 control->i2c_address + control->ras_header_offset,
 				 buf, RAS_TABLE_HEADER_SIZE);
 	if (res < RAS_TABLE_HEADER_SIZE) {
-		DRM_ERROR("Failed to read EEPROM table header, res:%d", res);
+		dev_err(adev->dev, "Failed to read EEPROM table header, res:%d", res);
 		return res >= 0 ? -EIO : res;
 	}
 
@@ -1071,11 +1071,11 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 	control->ras_fri = RAS_OFFSET_TO_INDEX(control, hdr->first_rec_offset);
 
 	if (hdr->header == RAS_TABLE_HDR_VAL) {
-		DRM_DEBUG_DRIVER("Found existing EEPROM table with %d records",
+		dev_dbg(adev->dev, "Found existing EEPROM table with %d records",
 				 control->ras_num_recs);
 		res = __verify_ras_table_checksum(control);
 		if (res)
-			DRM_ERROR("RAS table incorrect checksum or error:%d\n",
+			dev_err(adev->dev, "RAS table incorrect checksum or error:%d\n",
 				  res);
 
 		/* Warn if we are at 90% of the threshold or above
@@ -1088,7 +1088,7 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 		   amdgpu_bad_page_threshold != 0) {
 		res = __verify_ras_table_checksum(control);
 		if (res)
-			DRM_ERROR("RAS Table incorrect checksum or error:%d\n",
+			dev_err(adev->dev, "RAS Table incorrect checksum or error:%d\n",
 				  res);
 		if (ras->bad_page_cnt_threshold > control->ras_num_recs) {
 			/* This means that, the threshold was increased since
@@ -1116,7 +1116,7 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 			}
 		}
 	} else {
-		DRM_INFO("Creating a new EEPROM table");
+		dev_info(adev->dev, "Creating a new EEPROM table");
 
 		res = amdgpu_ras_eeprom_reset_table(control);
 	}
-- 
2.25.1


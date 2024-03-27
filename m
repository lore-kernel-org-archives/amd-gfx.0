Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C9E5C54E67
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Mar 2024 06:16:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8BCA10F897;
	Wed, 27 Mar 2024 06:16:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eJ4AkG2O";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 053CD10F897
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Mar 2024 06:16:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QXggQgnmL6ugFN6RUkf29QG/qT90/jZSqiY4NH1kvwT7sTmlRRRC6/yQFOeazLoghXQ0RI7IrNnGE20XDRcjB73qiXjrj2E6sGkks1NnZaidFb0V9s/k+ylFdxWPUxgkkqFp1iPKZk2gNOf8ggZlaDBHGNZ2gmj9omrolGceVaG41EgWcgvnkFW18g2aFmV1EwS02mzngtrshmXCM74s0edTmMZTIAHHRofepCdkOGwFFiS+S+GNfciQx2Li9Zit5q8ibRl/GY3G//gC8k3zCpU2sVxSfBJXYWp5dAYgMt59j2A6EyQWojMfgWCbIx7zlTiVns4EaIaYPy2PYhDIAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ji4XSLeuF0f+1YwegdAIa9XZel6NVCvIpgEwe851eD0=;
 b=j6yL22LDLpHqsKvaPIrYkopzZycMLUTsyvHfKLR3BNbMCtv8QpLFJMp8guUcA9ZqtbYn/TPIFoop4NywT7tPI+T10HnTGTdTJg9P/H3Fi9jyEvzZXaFvtdP6ET4krA88dtazEZsPNCqwxBsraNbn2No8BX3xlgFijgm6oUM3f6KiCTKdhHPTbvNjpDgeqWq/eL3QEUHGz/zk3ZNV+BM348qH5NsS6QD+VW331SnwhUBw8Fn0tf2eqayRdc4ons/mivr0KOmEMwS1BM/1YxevpHn5w4tg21UI1s3g6hNc0sv/7idIBX+qTEtvhoYqNK2/+eduq1hsN0xYFJLT0I42hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ji4XSLeuF0f+1YwegdAIa9XZel6NVCvIpgEwe851eD0=;
 b=eJ4AkG2Oe0vQW6dYv90OLhrRfZ8WTCufkmjQbM8DuYsZjwtDAlmsks6A7zDe4XSqYGCTT4ZWAbsdlpXdNzwHjfVYetWx7lEVL1nv6ZgeJw5qNnyiHu/6+sXw2cyONHVJtf0uMwOYU9Zp0PlOTSEMm3FMEOhQVJqNxqkwk1MyN4Q=
Received: from SJ0PR03CA0176.namprd03.prod.outlook.com (2603:10b6:a03:338::31)
 by PH8PR12MB7135.namprd12.prod.outlook.com (2603:10b6:510:22c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Wed, 27 Mar
 2024 06:16:15 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::2) by SJ0PR03CA0176.outlook.office365.com
 (2603:10b6:a03:338::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Wed, 27 Mar 2024 06:16:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 27 Mar 2024 06:16:14 +0000
Received: from canli-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 27 Mar
 2024 01:16:12 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Candice Li <candice.li@amd.com>
Subject: [PATCH] drm/amdgpu: Update EEPROM RAS table for mismatched table
 version
Date: Wed, 27 Mar 2024 14:15:44 +0800
Message-ID: <20240327061544.1115433-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|PH8PR12MB7135:EE_
X-MS-Office365-Filtering-Correlation-Id: a51ef423-8f81-40a1-e0ef-08dc4e256821
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uguFN6Ct5bIsbGUAOaOYXE3AN2GoYiXeX3VRhA7dCZMN0KFl6kw5E3ekuc4Khdtfu7hFtmNtQS/jmIMfbg7Y8S10eBCG7SuZpuz4oxU+Z95lRt8//jP1RpJXXO1eQ+lQuTKlZTYSmgtkoytI9YpW3nbIW1iPOpqsHdgKaun7Hb+vIlr4CuX885nkmvNw+HSLW1xWWXPIEad4n7x8M7TjviUKIyBgpUk+L2NAPWHcPuNfP8y34k+Rs+AYcetPEGgI8PaAjSY389N2dcPOKAeQzKwVK7tQFB10opFxnCT1DJbWByjJszQ9FbsSVSunUBw13tEG0Yg1lQydUBm/vpJqwU4awrdM6H/M1OeuhZDgSDRgH4HVmBVY8OTxw6CxDRm/tW+HDpUGWPQJSnozkr2V086u6EoPxxiGsKeGJ5C9cd49Q05c+538I7s7DZOiVEO5/DQQZVy5ZfN6N091AIwZoXtphpAVC+evwas84pjbSKRcrhGXr6HrogYddTJjdaYrEN+nuzrBM5XQG/oashApGhtB+yMNAFX5yhr1lSvzoe/kTxHpTboEek50QsospBJVlTIwOqHvez4HIe8+y/v+d7XUPQULWHIEEOllgvsn19Sw4Kg6kMqRK4nmcgkQX9QoDtAjoE3c44cCApw5oFsGy1wUSbfLY9IOYM9V2iOmL9NcBJoU2eFcKN8NhTOIWj0Sti77OlyyBpT1N0gSWN/SQRoxpQNu0Cfi3yQP7TTBSrk58QlifvKdYCAsrus5n5Q5
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 06:16:14.6168 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a51ef423-8f81-40a1-e0ef-08dc4e256821
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7135
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

Update table version and restore bad page records to EEPROM RAS table
for mismatched table version case. Otherwise force to reset the table.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 88 ++++++++++++++++---
 1 file changed, 78 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 06a62a8a992e9b..42d0ef2f512474 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1319,6 +1319,37 @@ static int __read_table_ras_info(struct amdgpu_ras_eeprom_control *control)
 	return res == RAS_TABLE_V2_1_INFO_SIZE ? 0 : res;
 }
 
+static bool amdgpu_ras_eeprom_table_version_validate(struct amdgpu_ras_eeprom_control *control)
+{
+	struct amdgpu_device *adev = to_amdgpu_device(control);
+	struct amdgpu_ras_eeprom_table_header *hdr = &control->tbl_hdr;
+
+	switch (amdgpu_ip_version(adev, UMC_HWIP, 0)) {
+	case IP_VERSION(8, 10, 0):
+	case IP_VERSION(12, 0, 0):
+		return hdr->version == RAS_TABLE_VER_V2_1;
+	default:
+		return hdr->version == RAS_TABLE_VER_V1;
+	}
+}
+
+static void amdgpu_ras_update_eeprom_control(struct amdgpu_ras_eeprom_table_header *hdr)
+{
+	struct amdgpu_ras_eeprom_control *control =
+		container_of(hdr, struct amdgpu_ras_eeprom_control, tbl_hdr);
+
+	if (hdr->version == RAS_TABLE_VER_V2_1) {
+		control->ras_num_recs = RAS_NUM_RECS_V2_1(hdr);
+		control->ras_record_offset = RAS_RECORD_START_V2_1;
+		control->ras_max_record_count = RAS_MAX_RECORD_COUNT_V2_1;
+	} else {
+		control->ras_num_recs = RAS_NUM_RECS(hdr);
+		control->ras_record_offset = RAS_RECORD_START;
+		control->ras_max_record_count = RAS_MAX_RECORD_COUNT;
+	}
+	control->ras_fri = RAS_OFFSET_TO_INDEX(control, hdr->first_rec_offset);
+}
+
 int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 			   bool *exceed_err_limit)
 {
@@ -1326,7 +1357,9 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 	unsigned char buf[RAS_TABLE_HEADER_SIZE] = { 0 };
 	struct amdgpu_ras_eeprom_table_header *hdr = &control->tbl_hdr;
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
-	int res;
+	int res, res1;
+	struct eeprom_table_record *bps;
+	u32 num_recs;
 
 	*exceed_err_limit = false;
 
@@ -1355,16 +1388,51 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 
 	__decode_table_header_from_buf(hdr, buf);
 
-	if (hdr->version == RAS_TABLE_VER_V2_1) {
-		control->ras_num_recs = RAS_NUM_RECS_V2_1(hdr);
-		control->ras_record_offset = RAS_RECORD_START_V2_1;
-		control->ras_max_record_count = RAS_MAX_RECORD_COUNT_V2_1;
-	} else {
-		control->ras_num_recs = RAS_NUM_RECS(hdr);
-		control->ras_record_offset = RAS_RECORD_START;
-		control->ras_max_record_count = RAS_MAX_RECORD_COUNT;
+	amdgpu_ras_update_eeprom_control(hdr);
+
+	if (!amdgpu_ras_eeprom_table_version_validate(control)) {
+		num_recs = control->ras_num_recs;
+		if (num_recs && amdgpu_bad_page_threshold) {
+			/* Save bad page records existed in EEPROM */
+			bps = kcalloc(num_recs, sizeof(*bps), GFP_KERNEL);
+			if (!bps)
+				return -ENOMEM;
+
+			res1 = amdgpu_ras_eeprom_read(control, bps, num_recs);
+			if (res1)
+				dev_warn(adev->dev, "Fail to load EEPROM table, force to reset it.");
+
+			res = amdgpu_ras_eeprom_reset_table(control);
+			if (res) {
+				dev_err(adev->dev, "Failed to create a new EEPROM table.");
+				kfree(bps);
+				return res < 0 ? res : 0;
+			}
+
+			if (!res1) {
+				/* Update the EEPROM table with correct table version and
+				 * original bad page records
+				 */
+				amdgpu_ras_update_eeprom_control(hdr);
+				res = amdgpu_ras_eeprom_append(control, bps, num_recs);
+
+				if (res) {
+					dev_warn(adev->dev, "Fail to update EEPROM table, force to reset it.");
+					res = amdgpu_ras_eeprom_reset_table(control);
+				}
+			}
+
+			kfree(bps);
+		} else
+			res = amdgpu_ras_eeprom_reset_table(control);
+
+		if (res) {
+			dev_err(adev->dev, "Failed to reset EEPROM table.");
+			return res < 0 ? res : 0;
+		}
+
+		amdgpu_ras_update_eeprom_control(hdr);
 	}
-	control->ras_fri = RAS_OFFSET_TO_INDEX(control, hdr->first_rec_offset);
 
 	if (hdr->header == RAS_TABLE_HDR_VAL) {
 		DRM_DEBUG_DRIVER("Found existing EEPROM table with %d records",
-- 
2.25.1


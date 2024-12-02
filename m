Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FD8D78304
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2024 10:24:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C1C510E6B9;
	Mon,  2 Dec 2024 10:24:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hGDGL+gi";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC1A310E6B9
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2024 10:24:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hJOZAMzo28pCknI280qBZ72JpgwpAd8UHD74p77r+Zk5FkyMkRenqkVJFXfTnybYvwBCh3jy/K366rQdMKGHqMenRXIBA8TX0Sd+2gKitRF3HTkG3SRpK0M4qhuaXCwyL0lUKUqkqsHk/itfgb0wVbHbF0Bfey559Jd7YFdXVIKm/Q0XRnQii6z0QIV74uz+kUr5hwSmokX1FnL92HFBYZe+p4WrJGb9nMf6LZ1UEiXr+DPOJB/uUgaOA9q85vH+tIFJS5QH7706r/nF67O//wkuWasZyekbYpbuHVv6Tcno2MjrAuKncUgy8SQsbW3lesUHFwHOBEZqfHeMnwJQ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNEHdAVEurQheYF5agV0qARMrmXSwEei+jvPGRQWkNY=;
 b=s9rYfr+vtETY67ZvMk207CzrqhT5MROQsoZopLLYY50UJpydD98vZnAbFXD+i1H2Fsr7N2QbINYmaehGgfCJSWQ/I2ST5XnYzivZNCOCqXhsLB3Hcjdm0FBMm63qXclcKrmh/yJ9fVXOM+7O6PnC9v+Zv2J/E2NeY27zMWTMft2JOSJTX3JkiRH14Xiwazjj9Q25a7OFQY5HuU67zbiCIoDq3sST6KhtuTIG7CyLWj+3sUpuWF5pm4YNokpe2k10HHSJ5vRww8Mb7GMPnQOUy2MnmUZxTvudeZTObq1YDIIj4Yc++XEQ37SkDviOea8kS1fxQOfYPGVQr9Z250AGgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNEHdAVEurQheYF5agV0qARMrmXSwEei+jvPGRQWkNY=;
 b=hGDGL+givD+LGiVM2ILu7gpJe6jc3eeZqFvtGRuPS6SvnlOJGxvrLF13Xeab2ir5L9pAyJQhsQFB4WY68W+jo4cNhpvMvHu2rI/XzljuUXedmt7QjzIpQ7Dab0H2cLXRSO4GQqR+//3kBNFEAhltsH5cqaHOgJVQIlckvPddipk=
Received: from BYAPR07CA0102.namprd07.prod.outlook.com (2603:10b6:a03:12b::43)
 by DM6PR12MB4042.namprd12.prod.outlook.com (2603:10b6:5:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 10:24:46 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:a03:12b:cafe::96) by BYAPR07CA0102.outlook.office365.com
 (2603:10b6:a03:12b::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.16 via Frontend Transport; Mon,
 2 Dec 2024 10:24:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 10:24:45 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 04:24:43 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: correct the calculation of RAS bad page
Date: Mon, 2 Dec 2024 18:24:33 +0800
Message-ID: <20241202102433.117496-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202102433.117496-1-tao.zhou1@amd.com>
References: <20241202102433.117496-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|DM6PR12MB4042:EE_
X-MS-Office365-Filtering-Correlation-Id: c1e449d0-697e-4d6c-645c-08dd12bb8b31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FtaO58nav66707LHmrV5MuxEpJZ1kv5nObHwdi/u/2DichAn5IxIebGM/54r?=
 =?us-ascii?Q?ibAdf/preaSJY3SKmCrlZF+70//yLc4aEuceWoM7E71kbsjbzSX01WvphLYH?=
 =?us-ascii?Q?/hF4vGgwFFnatE4qe4YGSo5hV8X3dujsk88MS4N1t3oglSnjf785FOvn1LVu?=
 =?us-ascii?Q?75BMM23DT6mmOhRbRKF7oTG9f0KuHGAvCVf3cRo+0CoRGLkRGbPP4dTU9Ul/?=
 =?us-ascii?Q?XMJBQfm609FitbajdOccZtYIY94a5zkVctx1B30mevSUJNmHITk/d69kOixk?=
 =?us-ascii?Q?QYJTgwQUeDsg+y2i1gzf42rQciSzbXl/ida1Ja0uwS2KqAFQhasSQpWWRlhI?=
 =?us-ascii?Q?7f/kMd1KT0nnV1NMRMs2FiM9DmEgOTvS1+1yZfZv3X4zt30pDwEdCfkK5SVF?=
 =?us-ascii?Q?xLy1gtKliloLiCe0K33SYWH0G/AxOsTrqkR3nGrbp2cYL5TuRTs2P5mMSyM6?=
 =?us-ascii?Q?9bdb2aTlDyDFNORjOrOSudLkQkYUqQnsAREqig5UY/qYukPqJKZxFyeAjPyr?=
 =?us-ascii?Q?wzz5o2WMrn1b/Mg6H+hn+CEXQ+qDkIH41piiL7CuFeBVZql3XNEj7feydMLc?=
 =?us-ascii?Q?BjYxIKGYE6Ze6CXlINz7EGxuVO7eoY9a0sjCCfozqPbu7BDf59biLpxeADF6?=
 =?us-ascii?Q?MYH3i9Gtbg1pCzQ8lQUzQnXz+sd5XUkApLZEQp5aEUbDrKM8bSbBZUnK5t+3?=
 =?us-ascii?Q?MKwZm6UQGqAPKUajQqieVjKW9vJOwSk0v+cwZA2olyi9olajQMD8B6+SgiRe?=
 =?us-ascii?Q?shci5x7nqUmwNha/1J+EEtwatT8wYes0dvJfzuJpZFz1ZznYHZ7koaSjmu0X?=
 =?us-ascii?Q?ifDIic54TMDHTzOnCNU3DHVDy0tZatGXwq+3MFDbEPABLKaDnDBgq3QyLIpU?=
 =?us-ascii?Q?mlyXYRSDObP8H8s5fle6GAEqbfcvrIeQoJXrXo1QEnKBfpt+QDVuk/MvtJ/V?=
 =?us-ascii?Q?n6TTOZNkyM769LAdrY8x0NWPpQaCWPwNxbIdDU/CN0S5Rl0F6OKP4+oryvIm?=
 =?us-ascii?Q?fgJ7zVOOGQZ31/VayrgzRB1+remvC911N5bT6kjmqcuQjNsho3R65M/H8W+O?=
 =?us-ascii?Q?OuZh2OEylqPDfpwnZWtfI62DfRyKluYA6TuNp/0D02T08NteMx8VeDCbSGVQ?=
 =?us-ascii?Q?aYnxYvvTgzofNHsuEQpamqME3AKowKIp4FW3xEcSPPe3aeLb7ia/pIavFey0?=
 =?us-ascii?Q?VyNhhVkPAZli3aAQ64dUtfj5/uLnoc8TNIeOWHwL1NfQUp3/Yk4LF5Wh2/NH?=
 =?us-ascii?Q?pkr44xgQ89hN/97CY//idLKVLShHVJo9/LJG/ejbux9b2PfBqTsdQ24raf/i?=
 =?us-ascii?Q?otlQggoL/ahL3yw0hOM9+DEKmCzg9Pu43aiSuJIZxdQJoAEiAbpZ1PM0Z2Ft?=
 =?us-ascii?Q?mqcKkL+E1jrT9aMZYb2DGgO/fEXzxK4dAXCRG1ZYX+eb3rl/ysddYKZATU6a?=
 =?us-ascii?Q?kxlNrM5qjUghc3EhsHtuaGZ4a36uGLfR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 10:24:45.8214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e449d0-697e-4d6c-645c-08dd12bb8b31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4042
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

After the introduction of NPS RAS, one bad page record on eeprom may be
related to 1 or 16 bad pages, so the bad page record and bad page are
two different concepts, define a new variable to store bad page number.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 10 +----
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 40 +++++++++++++------
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  5 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       |  2 +-
 4 files changed, 35 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index da072ab3fb5c..d03e4ae708dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2934,13 +2934,7 @@ int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev,
 	mutex_lock(&con->recovery_lock);
 	control = &con->eeprom_control;
 	data = con->eh_data;
-	bad_page_num = control->ras_num_recs;
-	/* one record on eeprom stands for all pages in one memory row
-	 * in this mode
-	 */
-	if (control->rec_type == AMDGPU_RAS_EEPROM_REC_MCA)
-		bad_page_num = control->ras_num_recs * adev->umc.retire_unit;
-
+	bad_page_num = control->ras_num_bad_pages;
 	save_count = data->count - bad_page_num;
 	mutex_unlock(&con->recovery_lock);
 
@@ -3432,7 +3426,7 @@ int amdgpu_ras_init_badpage_info(struct amdgpu_device *adev)
 			return ret;
 
 		amdgpu_dpm_send_hbm_bad_pages_num(
-			adev, control->ras_num_recs);
+			adev, control->ras_num_bad_pages);
 
 		if (con->update_channel_flag == true) {
 			amdgpu_dpm_send_hbm_bad_channel_flag(
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 9dae4ac2f5d0..0b15f0370b67 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -470,9 +470,10 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control)
 		res = __write_table_ras_info(control);
 
 	control->ras_num_recs = 0;
+	control->ras_num_bad_pages = 0;
 	control->ras_fri = 0;
 
-	amdgpu_dpm_send_hbm_bad_pages_num(adev, control->ras_num_recs);
+	amdgpu_dpm_send_hbm_bad_pages_num(adev, control->ras_num_bad_pages);
 
 	control->bad_channel_bitmap = 0;
 	amdgpu_dpm_send_hbm_bad_channel_flag(adev, control->bad_channel_bitmap);
@@ -559,7 +560,7 @@ bool amdgpu_ras_eeprom_check_err_threshold(struct amdgpu_device *adev)
 	if (con->eeprom_control.tbl_hdr.header == RAS_TABLE_HDR_BAD) {
 		if (amdgpu_bad_page_threshold == -1) {
 			dev_warn(adev->dev, "RAS records:%d exceed threshold:%d",
-				con->eeprom_control.ras_num_recs, con->bad_page_cnt_threshold);
+				con->eeprom_control.ras_num_bad_pages, con->bad_page_cnt_threshold);
 			dev_warn(adev->dev,
 				"But GPU can be operated due to bad_page_threshold = -1.\n");
 			return false;
@@ -621,6 +622,7 @@ amdgpu_ras_eeprom_append_table(struct amdgpu_ras_eeprom_control *control,
 			       const u32 num)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(to_amdgpu_device(control));
+	struct amdgpu_device *adev = to_amdgpu_device(control);
 	u32 a, b, i;
 	u8 *buf, *pp;
 	int res;
@@ -723,6 +725,12 @@ amdgpu_ras_eeprom_append_table(struct amdgpu_ras_eeprom_control *control,
 	control->ras_num_recs = 1 + (control->ras_max_record_count + b
 				     - control->ras_fri)
 		% control->ras_max_record_count;
+
+	if (control->rec_type == AMDGPU_RAS_EEPROM_REC_PA)
+		control->ras_num_bad_pages = control->ras_num_recs;
+	else
+		control->ras_num_bad_pages =
+			control->ras_num_recs * adev->umc.retire_unit;
 Out:
 	kfree(buf);
 	return res;
@@ -740,10 +748,10 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eeprom_control *control)
 	/* Modify the header if it exceeds.
 	 */
 	if (amdgpu_bad_page_threshold != 0 &&
-	    control->ras_num_recs >= ras->bad_page_cnt_threshold) {
+	    control->ras_num_bad_pages >= ras->bad_page_cnt_threshold) {
 		dev_warn(adev->dev,
 			"Saved bad pages %d reaches threshold value %d\n",
-			control->ras_num_recs, ras->bad_page_cnt_threshold);
+			control->ras_num_bad_pages, ras->bad_page_cnt_threshold);
 		control->tbl_hdr.header = RAS_TABLE_HDR_BAD;
 		if (control->tbl_hdr.version == RAS_TABLE_VER_V2_1) {
 			control->tbl_rai.rma_status = GPU_RETIRED__ECC_REACH_THRESHOLD;
@@ -798,9 +806,9 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eeprom_control *control)
 	 */
 	if (amdgpu_bad_page_threshold != 0 &&
 	    control->tbl_hdr.version == RAS_TABLE_VER_V2_1 &&
-	    control->ras_num_recs < ras->bad_page_cnt_threshold)
+	    control->ras_num_bad_pages < ras->bad_page_cnt_threshold)
 		control->tbl_rai.health_percent = ((ras->bad_page_cnt_threshold -
-						   control->ras_num_recs) * 100) /
+						   control->ras_num_bad_pages) * 100) /
 						   ras->bad_page_cnt_threshold;
 
 	/* Recalc the checksum.
@@ -1402,9 +1410,15 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
 	if (!__get_eeprom_i2c_addr(adev, control))
 		return -EINVAL;
 
+	if (control->rec_type == AMDGPU_RAS_EEPROM_REC_PA)
+		control->ras_num_bad_pages = control->ras_num_recs;
+	else
+		control->ras_num_bad_pages =
+			control->ras_num_recs * adev->umc.retire_unit;
+
 	if (hdr->header == RAS_TABLE_HDR_VAL) {
 		DRM_DEBUG_DRIVER("Found existing EEPROM table with %d records",
-				 control->ras_num_recs);
+				 control->ras_num_bad_pages);
 
 		if (hdr->version == RAS_TABLE_VER_V2_1) {
 			res = __read_table_ras_info(control);
@@ -1419,9 +1433,9 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
 
 		/* Warn if we are at 90% of the threshold or above
 		 */
-		if (10 * control->ras_num_recs >= 9 * ras->bad_page_cnt_threshold)
+		if (10 * control->ras_num_bad_pages >= 9 * ras->bad_page_cnt_threshold)
 			dev_warn(adev->dev, "RAS records:%u exceeds 90%% of threshold:%d",
-					control->ras_num_recs,
+					control->ras_num_bad_pages,
 					ras->bad_page_cnt_threshold);
 	} else if (hdr->header == RAS_TABLE_HDR_BAD &&
 		   amdgpu_bad_page_threshold != 0) {
@@ -1435,7 +1449,7 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
 		if (res)
 			DRM_ERROR("RAS Table incorrect checksum or error:%d\n",
 				  res);
-		if (ras->bad_page_cnt_threshold > control->ras_num_recs) {
+		if (ras->bad_page_cnt_threshold > control->ras_num_bad_pages) {
 			/* This means that, the threshold was increased since
 			 * the last time the system was booted, and now,
 			 * ras->bad_page_cnt_threshold - control->num_recs > 0,
@@ -1445,13 +1459,13 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
 			dev_info(adev->dev,
 				 "records:%d threshold:%d, resetting "
 				 "RAS table header signature",
-				 control->ras_num_recs,
+				 control->ras_num_bad_pages,
 				 ras->bad_page_cnt_threshold);
 			res = amdgpu_ras_eeprom_correct_header_tag(control,
 								   RAS_TABLE_HDR_VAL);
 		} else {
 			dev_err(adev->dev, "RAS records:%d exceed threshold:%d",
-				control->ras_num_recs, ras->bad_page_cnt_threshold);
+				control->ras_num_bad_pages, ras->bad_page_cnt_threshold);
 			if (amdgpu_bad_page_threshold == -1) {
 				dev_warn(adev->dev, "GPU will be initialized due to bad_page_threshold = -1.");
 				res = 0;
@@ -1460,7 +1474,7 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
 				dev_err(adev->dev,
 					"RAS records:%d exceed threshold:%d, "
 					"GPU will not be initialized. Replace this GPU or increase the threshold",
-					control->ras_num_recs, ras->bad_page_cnt_threshold);
+					control->ras_num_bad_pages, ras->bad_page_cnt_threshold);
 			}
 		}
 	} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index b87422df52fd..81d55cb7b397 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -95,6 +95,11 @@ struct amdgpu_ras_eeprom_control {
 	 */
 	u32 ras_num_recs;
 
+	/* the bad page number is ras_num_recs or
+	 * ras_num_recs * umc.retire_unit
+	 */
+	u32 ras_num_bad_pages;
+
 	/* First record index to read, 0-based.
 	 * Range is [0, num_recs-1]. This is
 	 * an absolute index, starting right after
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 1881bcd040c7..cffe22b86118 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -169,7 +169,7 @@ void amdgpu_umc_handle_bad_pages(struct amdgpu_device *adev,
 						err_data->err_addr_cnt, false);
 			amdgpu_ras_save_bad_pages(adev, &err_count);
 
-			amdgpu_dpm_send_hbm_bad_pages_num(adev, con->eeprom_control.ras_num_recs);
+			amdgpu_dpm_send_hbm_bad_pages_num(adev, con->eeprom_control.ras_num_bad_pages);
 
 			if (con->update_channel_flag == true) {
 				amdgpu_dpm_send_hbm_bad_channel_flag(adev, con->eeprom_control.bad_channel_bitmap);
-- 
2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65020C28B2E
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 10:06:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9889510E74D;
	Wed, 12 Mar 2025 10:06:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fa75n/WD";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D37F710E74B
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 10:06:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mVsP68GacZL5yHYUlubcEHy1ZVkkzgJNUQLdzhiP5F4hwXMBAeWh7Z5G95I/xN+cRAW4Ea++UgF5Gt/phsCYoCU2xq42dWpAFSzPC+0a3C3MiafjTi8HfDiAQt9CRuN0ORpwK98NG/6pFLRGd0sq47iMyB1uWuBIosc5hArXE6heE81XKEXWSafRsPDbVFS/wGVykegEQ4aXMXFCA3Ad5zY7lJBB96C91njBtncM8N8vSLaq5zkmTNPUOaWoV2egWPuxMIc+RlmIwfwzAq944lPrr1fxix5TAYMcXKZvTUysv8vvdfJdnRYYmBvIZzZATHcj/I9MyscMjDE54Z52MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fK8tsFZoOtODvkaqxuFTqGweGAcIQ8kkGXbyTvMZYvI=;
 b=NFKH2mKhNtJDzkRi2MHbTfK2W2rk2c/LjLTulek2XBpSY0q1+VZRTSsJXShCm4yR0em2ooCAUdofNulfLQpyVEveNtS0dGYE0p4pPPXvO1xQzUrmjo4P+8iUP8aTAawLDt4L/YX43AKXdbJW5gQPcUw9WdbmPSToSU00H/DHf2/Zqp5hysz54ZHhLzBchFPyPZWQoKLIekXX5D3foZNqh8LtlX05o4EHqwNWJB8jYqZ1clR9dZj1cQs5XR5C9tQgOvkx3MuYxCAM2GZx2vsWhYIqBv+CvXDAeUYOs+ARNOk5zyBgXH9iIYcqUYbeC3KSSU0h5M9pmxqG93RevhjOSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fK8tsFZoOtODvkaqxuFTqGweGAcIQ8kkGXbyTvMZYvI=;
 b=fa75n/WDhn4/e4I9aMi5WyDXeSZyXjjqNnUgU7k8CMt5vVDDo617zJaUKJNFyBt0wZL0OeSzqG33sLvK5wUDsYMRYXQMmG4LKIyCMXzp668Akrpr68SZucWfxQUeTwd+uVjY33aaKNxNwfSbLVJ1lSUTV6beYF7DP76PyJrculk=
Received: from BLAPR03CA0138.namprd03.prod.outlook.com (2603:10b6:208:32e::23)
 by DM4PR12MB6638.namprd12.prod.outlook.com (2603:10b6:8:b5::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Wed, 12 Mar 2025 10:06:00 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:32e:cafe::e5) by BLAPR03CA0138.outlook.office365.com
 (2603:10b6:208:32e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.21 via Frontend Transport; Wed,
 12 Mar 2025 10:06:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 12 Mar 2025 10:06:00 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Mar
 2025 05:05:58 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: format old RAS eeprom data into V3 version
Date: Wed, 12 Mar 2025 18:05:48 +0800
Message-ID: <20250312100548.283389-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|DM4PR12MB6638:EE_
X-MS-Office365-Filtering-Correlation-Id: cf4165f7-fb95-4977-953a-08dd614d7d77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AR8cgHAQuGbhZTkgu/lkQX1m4dulXe3fV5wbj8LRXi2DYAgEPTjk33S47J77?=
 =?us-ascii?Q?ZhgU3EcpOw82HU3DBqLaU14OywTuuLU4ocJc+9SuXXoXcsvxFZPlKgBs7yQC?=
 =?us-ascii?Q?/0xpiPLwJrKWlIoZ8c7mYA0DXcUzLm6rrcfv17KQs1rViOD7xkMgCBV+G6O/?=
 =?us-ascii?Q?S6o5DdYNK3yx6YvRqRxnFKBjc3pTfw/x8P2pQxsS145TRJqJe1/Ljfv/vxpr?=
 =?us-ascii?Q?4RnQeJcRgwPBBXZEU8Ken1ahWLTpvDDEgoGWFl606QFgsUFEEPad9/mvQNip?=
 =?us-ascii?Q?BHzKP4kBK2C3kXDU+1STfKw7WGIwtJXmbkkCWKrN1c72kXqVBTdHMl/JhVB+?=
 =?us-ascii?Q?/YXFGPU7pexgTbx/ypcAgFiuEgH3PA7OMMy9jA5o8t+J+00he+vLfu3B6ds3?=
 =?us-ascii?Q?G5ZsvP8UiFSNNNkiNb5EN2UDcH3PRY4X3iTIKRQA287a2OFZjLrlIYzPAfYX?=
 =?us-ascii?Q?DSe9Ak1Q24pGHj/4Y+J2PhciNBwqQRhZUTBrPp1uEMcfb6NlAgvee+Gqt1d9?=
 =?us-ascii?Q?M8Db+tqscJuICytfJEJZP70FWJ4UCseS6+cdDLHg4adXu24Mn8gKBk4TS2AH?=
 =?us-ascii?Q?3UlD1j98olONa8RnrTvmshDNUJdfti+bPr6Tfg/csNd/ljMz+1CMvbuypUVd?=
 =?us-ascii?Q?BaO4+VQ2Qe/E5inxS0Ha7NqvudY8Cot6Vdb5ZkM5OTJWBIBRxgQMyjDQQKbR?=
 =?us-ascii?Q?5UMAh+ZGMx3Wm9J4OShnVThtm/m1CXcXd5iFZL83z3/jUlOxbZhCgleDAkW4?=
 =?us-ascii?Q?w6dcsr6vK1bP7ekGT/zNa8o7iuz4yK77j5jsZN1ocNyJAc2okO5mH6FWxjtb?=
 =?us-ascii?Q?LUDA/qDUOAypIp+L4KnPM0gvhZpdLTNMpTB5QNhxd9Uz7GpEPoSQ3g0Zjt+9?=
 =?us-ascii?Q?wz0KoyrqTyRQeCtOBTzx5+3aZIKMqmiFcwe3wnM4VkzLjpaKXdHJp4yXJggh?=
 =?us-ascii?Q?lqL9ZbHUWihNQTZ4K6T5D23qlNI87iGHARjUd6eUgawqO06jwzY5szCoJfLB?=
 =?us-ascii?Q?SbQ+esg73fQqV/MXBkRoFs4S7lEu3KIrhsbkN2tAwD6wYWnUU6MzqJYsqcWx?=
 =?us-ascii?Q?HgN4lD54k+729nR57TgBoOVMFEByRhVIqebF/3hjY+TJ3BxoQjZ2rvOfUoAC?=
 =?us-ascii?Q?313kM/HB9axNMuvqsZGO/1qzRHBcF6ZNQ4ecWFfBTK3I9KCEaVdIkmx/afqM?=
 =?us-ascii?Q?m5OxMjeYWrV228X8zwRECcCbvJmNbsMSqflqRYZucrH2ixy4+OjDGwzHqmhG?=
 =?us-ascii?Q?wZRY5dyUddQLoMigs9w3xVFMI/R0Pd2vuZ8s/wU6bLpBZO5jLVfQn1j3+aqX?=
 =?us-ascii?Q?+E+7eSiwIsoJ0YaG59p4iAZZYExcuNVPbuHJw0Zg3VU65LZN3RQlj0nNN3up?=
 =?us-ascii?Q?JCQfLz5GyLkbE3MbK4dyu0eRiZErVMbnlVq2glzPOnT8zYjbB11pIox4Joqz?=
 =?us-ascii?Q?RSfAQH6KZLqGP6kALTenGpDnLx8UssnPg629ir5b/qXqwX2RFpkbNQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 10:06:00.1374 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf4165f7-fb95-4977-953a-08dd614d7d77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6638
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

Clear old data and save it in V3 format.

v2: only format eeprom data for new ASICs.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  7 +++++
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 26 ++++++++++---------
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  1 +
 3 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 837f33698b38..d3b9b4d9fb89 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3465,6 +3465,13 @@ int amdgpu_ras_init_badpage_info(struct amdgpu_device *adev)
 				adev, control->bad_channel_bitmap);
 			con->update_channel_flag = false;
 		}
+
+		/* The format action is only applied to new ASICs */
+		if (IP_VERSION_MAJ(amdgpu_ip_version(adev, UMC_HWIP, 0)) >= 12 &&
+		    control->tbl_hdr.version < RAS_TABLE_VER_V3)
+			if (!amdgpu_ras_eeprom_reset_table(control))
+				if (amdgpu_ras_save_bad_pages(adev, NULL))
+					dev_warn(adev->dev, "Failed to format RAS EEPROM data in V3 version!\n");
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 09a6f8bc1a5a..71dddb8983ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -413,9 +413,11 @@ static void amdgpu_ras_set_eeprom_table_version(struct amdgpu_ras_eeprom_control
 
 	switch (amdgpu_ip_version(adev, UMC_HWIP, 0)) {
 	case IP_VERSION(8, 10, 0):
-	case IP_VERSION(12, 0, 0):
 		hdr->version = RAS_TABLE_VER_V2_1;
 		return;
+	case IP_VERSION(12, 0, 0):
+		hdr->version = RAS_TABLE_VER_V3;
+		return;
 	default:
 		hdr->version = RAS_TABLE_VER_V1;
 		return;
@@ -443,7 +445,7 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control)
 	hdr->header = RAS_TABLE_HDR_VAL;
 	amdgpu_ras_set_eeprom_table_version(control);
 
-	if (hdr->version == RAS_TABLE_VER_V2_1) {
+	if (hdr->version >= RAS_TABLE_VER_V2_1) {
 		hdr->first_rec_offset = RAS_RECORD_START_V2_1;
 		hdr->tbl_size = RAS_TABLE_HEADER_SIZE +
 				RAS_TABLE_V2_1_INFO_SIZE;
@@ -461,7 +463,7 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control)
 	}
 
 	csum = __calc_hdr_byte_sum(control);
-	if (hdr->version == RAS_TABLE_VER_V2_1)
+	if (hdr->version >= RAS_TABLE_VER_V2_1)
 		csum += __calc_ras_info_byte_sum(control);
 	csum = -csum;
 	hdr->checksum = csum;
@@ -752,7 +754,7 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eeprom_control *control)
 			"Saved bad pages %d reaches threshold value %d\n",
 			control->ras_num_bad_pages, ras->bad_page_cnt_threshold);
 		control->tbl_hdr.header = RAS_TABLE_HDR_BAD;
-		if (control->tbl_hdr.version == RAS_TABLE_VER_V2_1) {
+		if (control->tbl_hdr.version >= RAS_TABLE_VER_V2_1) {
 			control->tbl_rai.rma_status = GPU_RETIRED__ECC_REACH_THRESHOLD;
 			control->tbl_rai.health_percent = 0;
 		}
@@ -765,7 +767,7 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eeprom_control *control)
 		amdgpu_dpm_send_rma_reason(adev);
 	}
 
-	if (control->tbl_hdr.version == RAS_TABLE_VER_V2_1)
+	if (control->tbl_hdr.version >= RAS_TABLE_VER_V2_1)
 		control->tbl_hdr.tbl_size = RAS_TABLE_HEADER_SIZE +
 					    RAS_TABLE_V2_1_INFO_SIZE +
 					    control->ras_num_recs * RAS_TABLE_RECORD_SIZE;
@@ -805,7 +807,7 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eeprom_control *control)
 	 * now calculate gpu health percent
 	 */
 	if (amdgpu_bad_page_threshold != 0 &&
-	    control->tbl_hdr.version == RAS_TABLE_VER_V2_1 &&
+	    control->tbl_hdr.version >= RAS_TABLE_VER_V2_1 &&
 	    control->ras_num_bad_pages <= ras->bad_page_cnt_threshold)
 		control->tbl_rai.health_percent = ((ras->bad_page_cnt_threshold -
 						   control->ras_num_bad_pages) * 100) /
@@ -818,7 +820,7 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eeprom_control *control)
 		csum += *pp;
 
 	csum += __calc_hdr_byte_sum(control);
-	if (control->tbl_hdr.version == RAS_TABLE_VER_V2_1)
+	if (control->tbl_hdr.version >= RAS_TABLE_VER_V2_1)
 		csum += __calc_ras_info_byte_sum(control);
 	/* avoid sign extension when assigning to "checksum" */
 	csum = -csum;
@@ -1035,7 +1037,7 @@ uint32_t amdgpu_ras_eeprom_max_record_count(struct amdgpu_ras_eeprom_control *co
 	/* get available eeprom table version first before eeprom table init */
 	amdgpu_ras_set_eeprom_table_version(control);
 
-	if (control->tbl_hdr.version == RAS_TABLE_VER_V2_1)
+	if (control->tbl_hdr.version >= RAS_TABLE_VER_V2_1)
 		return RAS_MAX_RECORD_COUNT_V2_1;
 	else
 		return RAS_MAX_RECORD_COUNT;
@@ -1280,7 +1282,7 @@ static int __verify_ras_table_checksum(struct amdgpu_ras_eeprom_control *control
 	int buf_size, res;
 	u8  csum, *buf, *pp;
 
-	if (control->tbl_hdr.version == RAS_TABLE_VER_V2_1)
+	if (control->tbl_hdr.version >= RAS_TABLE_VER_V2_1)
 		buf_size = RAS_TABLE_HEADER_SIZE +
 			   RAS_TABLE_V2_1_INFO_SIZE +
 			   control->ras_num_recs * RAS_TABLE_RECORD_SIZE;
@@ -1383,7 +1385,7 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
 
 	__decode_table_header_from_buf(hdr, buf);
 
-	if (hdr->version == RAS_TABLE_VER_V2_1) {
+	if (hdr->version >= RAS_TABLE_VER_V2_1) {
 		control->ras_num_recs = RAS_NUM_RECS_V2_1(hdr);
 		control->ras_record_offset = RAS_RECORD_START_V2_1;
 		control->ras_max_record_count = RAS_MAX_RECORD_COUNT_V2_1;
@@ -1423,7 +1425,7 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
 		DRM_DEBUG_DRIVER("Found existing EEPROM table with %d records",
 				 control->ras_num_bad_pages);
 
-		if (hdr->version == RAS_TABLE_VER_V2_1) {
+		if (hdr->version >= RAS_TABLE_VER_V2_1) {
 			res = __read_table_ras_info(control);
 			if (res)
 				return res;
@@ -1443,7 +1445,7 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
 					ras->bad_page_cnt_threshold);
 	} else if (hdr->header == RAS_TABLE_HDR_BAD &&
 		   amdgpu_bad_page_threshold != 0) {
-		if (hdr->version == RAS_TABLE_VER_V2_1) {
+		if (hdr->version >= RAS_TABLE_VER_V2_1) {
 			res = __read_table_ras_info(control);
 			if (res)
 				return res;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index 13f7eda9a696..ec6d7ea37ad0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -28,6 +28,7 @@
 
 #define RAS_TABLE_VER_V1           0x00010000
 #define RAS_TABLE_VER_V2_1         0x00021000
+#define RAS_TABLE_VER_V3           0x00030000
 
 struct amdgpu_device;
 
-- 
2.34.1


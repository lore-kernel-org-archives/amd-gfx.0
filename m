Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C42C19F32
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Mar 2025 06:46:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E854110E7FB;
	Fri,  7 Mar 2025 06:46:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0OJcl1MJ";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4CA510E7FB
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Mar 2025 06:46:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vcz3ZEBWjsjdCJycsQwoqr1bWWY2mrWx5AMW8wcKQyi0xpZ5k026ixT0g/qs0sA1zC5j1taeMLbP2OX3WYFHrEwa997LZWdNBiquu/liYOn42Ag9EF5mcfEemKG1FzCk8Ts1obZNAqQMtevktqW8YwsYK5J5SY9megWHzpdKRfEmQmTOcDZm6tnbJqSH6sxaVBiAeuxXtfhkqsO5QSwTEwjDLoe7RVv7+YfSTMDIvundguyfa9Ym6gKSRUFPbmXHeEUYhWPqxzUGGIp9iwphc/rkwgMaGKDHaiSpbMmcCJuzkISgadFvhrA8ovUSEEURJZkEUWldwJuniH7u5UxAhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nFUCTtcoYZ3Fjn6Tb9q3UXL6FwimaJCsIM6QAZRmHY=;
 b=jkWgV53fngOqVOqSePjclvUBzF334053ROKVHtR5clYfGirCXRwZxetf1aZpfi8pw2MJIfHNdIpqEceDWbUDp9+J1pHwSGkCWpm79NHR6u91O+m/o7bIETwhJSq1HTOQ93HJcVxFR3HZp6F1qIYibkxYD1hBsvw9PDm0/quaYNWGGLdjlz3epHRl2nX2YT5zs1o2k5VtvrCM1jfhltgVSUoJ4Hpt0mSFe+FUwXrB/0bitfFYIVLXKKNIYrUfDcPSUYFfDX8DXm0xMDNwJS8fbLXlT7eVmTdCJ69lXExSiONHfuAi8Ll0r3mYB469QSkracaCw97oSWZAfuEO7jqR6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nFUCTtcoYZ3Fjn6Tb9q3UXL6FwimaJCsIM6QAZRmHY=;
 b=0OJcl1MJZ/yLe0ixofElnxkd5aOp4nIYniwoBs1jweeb50KTMxNiHVDNzmN8KQFVkt9R5O48jg7XNsuzvkKPozXvzBtISKH9TzDS6+J+Nk8A8v2tZUfFe8glIOGHZ3GWp0H1aKF7s/e+0DhZcL+TJyLLSC4zJ3fZec2BOI6SAJc=
Received: from BY5PR13CA0020.namprd13.prod.outlook.com (2603:10b6:a03:180::33)
 by SJ2PR12MB7942.namprd12.prod.outlook.com (2603:10b6:a03:4c3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 06:46:50 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::60) by BY5PR13CA0020.outlook.office365.com
 (2603:10b6:a03:180::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Fri,
 7 Mar 2025 06:46:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 06:46:49 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Mar
 2025 00:46:48 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: format old RAS eeprom data into V3 version
Date: Fri, 7 Mar 2025 14:46:39 +0800
Message-ID: <20250307064639.273141-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|SJ2PR12MB7942:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a98ecca-e75c-4b81-1d65-08dd5d43d692
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n90I4znSSRIvfJYW8XRVxfykLBNQuF7BoLzTLLlCe0D5LM7ewRFWCr19+IDi?=
 =?us-ascii?Q?7z5t2fXtfK+mWS3NwHdg6JFRt1PvRe7gL3ecOTe6eoeLl/onYI7g7nr6RZuf?=
 =?us-ascii?Q?fEIPeivq0lAnx9TQBDGonnpmGF2bOofYPEBBRHoVmMeNLZCgm2PK7z5o+0HM?=
 =?us-ascii?Q?ksQJdU2aKt697BvGiIUR2ezQT86K6lDZFsaBgXndY2m3q9an7J+oV6aJf6Xz?=
 =?us-ascii?Q?eRh/i3/vOMPz5PZtHcW8Ec3LTNKB1mIQpDnlWqXsEzEmEBjyrFSfYtV6WLss?=
 =?us-ascii?Q?to8RYpG2kNofq8Aer2bZxH/T2zmw/QI44M4at9OM6uFdbe6kCERD6kdwW0Dq?=
 =?us-ascii?Q?nTlNrNAHn89V2B78VJe7at6JKFU8u/iLLF3MjR5vO1LjeiXMNuqSIRLs+Sz7?=
 =?us-ascii?Q?zoEgex5NcBFjy5e6HEZZMDt9yKS0U0PwjxtfAnheT4qi071WBKR+T35dfzBQ?=
 =?us-ascii?Q?bnNzplJCikoWWeo/WZ5UyexK6FTdZ0xRkcMDM1TisUscX9LwzbAGgg1Amfx2?=
 =?us-ascii?Q?6u5FNb37CcVuKUoxw7gYsLbvwEqNu33EVi0bKELeJCezScuTOqRnQnQch1ry?=
 =?us-ascii?Q?zUexJv5GU1lXy/uMmhel2ICOeQT1NaleBAoL98CDH2EtoI+lvtkQ7GIJOD6l?=
 =?us-ascii?Q?AgKTNxzjETMGx+UcPxKqqGflE8Mwm3Y/FkadWEtIqjN5oEzYdkbQ+m8Ea5CM?=
 =?us-ascii?Q?jVe26lBqYtp+1oaqNsbJ+s1f3oXV0AFv9pT8lStcZJGGILeNdlLoTE0YRRCl?=
 =?us-ascii?Q?/lT3pFPI0mW2VN0L+LBryWhGFCcMupbq2UK6uCfSY/c1DucmSRyZ4b3i12ex?=
 =?us-ascii?Q?BWVbk5ldSNe6Vw1nS6wBixu56A+35h8o1wlchDLjTxVCVGHImc9qaWc6mB6Y?=
 =?us-ascii?Q?7MDrwXuJrKh7QSGb9Yd6Bx4BCr9EUNAgMvXAww46g5u6/CuuSi1cedjn156q?=
 =?us-ascii?Q?i2vSBMbPhz8pXhfIhbEuFHVm0EVbbCl1o6QhM7pWbIyPDdL3OaCaZParj3JZ?=
 =?us-ascii?Q?3iQc8dqoEiHpe33P11AmygBU5ABWY4pW7NFf+0a/CZ+6JS/PeqpTiDd3GfzC?=
 =?us-ascii?Q?d/lzx5EXwj4G3gQXizAK92OzhFFdV25X9wn8XHMav1T9a5VN4vB5KxHyJiPW?=
 =?us-ascii?Q?8YYsjU7KuZD5t/gb5ltJikCYyTKW+Lo2HaYIEv60iU67jAbPjbyTR90AJi+l?=
 =?us-ascii?Q?ixI04y+LDujRTsFa+FhQ7xQXTcpwPx1xFhJcdJxGQHSJ3duALQ1MDlJUlFxT?=
 =?us-ascii?Q?zMurTuB28fUOR1E9oUTKTgDG/6gHE/6QLwY3Kk+oZ/RFMk2wvTN2ICZHeIQM?=
 =?us-ascii?Q?x2JHCEgVNtUnYPQu6wOKadUq0Tvr6KROTlqEwun3mwBrJEdbMlXBD8fzJS7s?=
 =?us-ascii?Q?4xOtxt3XMcU2wZZ5eBgqryOiz07ZmYzgy8RBIx1fzewv4qcToJLlURUO3lZP?=
 =?us-ascii?Q?uKJ6NfEyxYOtJ+W8PkFXMCZRDYhnBW+UQVDTqvBWeCOukEDk0Hep2Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 06:46:49.8851 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a98ecca-e75c-4b81-1d65-08dd5d43d692
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7942
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

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  5 ++++
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 26 ++++++++++---------
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  1 +
 3 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 837f33698b38..266f24002e07 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3465,6 +3465,11 @@ int amdgpu_ras_init_badpage_info(struct amdgpu_device *adev)
 				adev, control->bad_channel_bitmap);
 			con->update_channel_flag = false;
 		}
+
+		if (control->tbl_hdr.version < RAS_TABLE_VER_V3)
+			if (!amdgpu_ras_eeprom_reset_table(control))
+				if (amdgpu_ras_save_bad_pages(adev, NULL))
+					dev_warn(adev->dev, "Failed to save EEPROM data in V3 format!\n");
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


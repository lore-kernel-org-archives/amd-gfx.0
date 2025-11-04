Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41BD7CCF9E3
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 06:58:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D55DC10E524;
	Tue,  4 Nov 2025 06:58:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="et2yif+I";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010048.outbound.protection.outlook.com [52.101.201.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F29A610E524
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 06:58:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LulWDPD5gCX3Bwk21yY8wsc66RuA6/vMXJc791VcN3kz3nzhF1JvDKiLFlaJLh5y9kfhrd7CzpCHWcMA6AiUFkCgSSz6PCStkGi+emAeNPBLJp9n1Obu7C/U9Lh6sloK4ipZcV0EbQAdfwCKhqEt2J8ViVIBw6ocfnwLZfOeObglWQevird6mUYIXXaMkVsALArvtwyAeZDOxBsBetb5qvpzuU0HX5cGEUoA0G1/YBKv8pfHpk52z1hnPA7GrKjmrcCLjRQQKJzYeHSGtHEJYduViW8s/vvZizzuYXnWERXmkeLxEQO8cuBbLyuR9rxcdyRJ7YzewqAEqHF7UhSJTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RSZpmOlzArhuHgT5K0i0M/sSlWCyjvvHbwIsXHGEOc=;
 b=UF7bGH4hJsLWtT0yE88AiPa2STFI8T/mr9sp1UYwOi73Yf9owv4IYWSAc3WlcGePnW3/j4wvHMBj6ZIzjKQh7+Aj76NULkbSLaQw9vlse53vRe4DOpzemB/im4Aof4W2XyyF9/3cJUDXVepfuB5M9fKKEoT9BLjhF/GJwiVU3DZEGBc/DHdWrAEmyjkBSFanLg84ZTs1ZgBoAdgOjowMsRNf0Ub8GVNg1wmnsUzNyOj0YXgD7VKcOFNVcEFEjFfZBrtJ9ZItY2kzb1eNPmZghV/8RPs7aCI7KgvySBl11nkiF5yOwqtC5rDcn20d9ripw39pG/O4ZeAdBPt2HEPd0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RSZpmOlzArhuHgT5K0i0M/sSlWCyjvvHbwIsXHGEOc=;
 b=et2yif+IlMtIV+gzrh6b31fV84sfFN9nSnQPohg9DDuQ4kL2EEXq3pANuaR0ox6W6uPv5gjnQdRsYRAgMWddB0jeSkIzKqhy4DwP58U5USkIdujCvgJ8WKE8q8Abz998msuj7cqCcjXeJM1Asevp5GsiJyPFkeSXy8I0gldwAjg=
Received: from MN2PR20CA0057.namprd20.prod.outlook.com (2603:10b6:208:235::26)
 by DM4PR12MB6542.namprd12.prod.outlook.com (2603:10b6:8:89::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.16; Tue, 4 Nov 2025 06:58:23 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:208:235:cafe::90) by MN2PR20CA0057.outlook.office365.com
 (2603:10b6:208:235::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 06:58:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 06:58:23 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 3 Nov 2025 22:58:21 -0800
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH 06/10] drm/amdgpu: adapt reset function for pmfw eeprom
Date: Tue, 4 Nov 2025 14:57:41 +0800
Message-ID: <20251104065745.1737050-6-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104065745.1737050-1-ganglxie@amd.com>
References: <20251104065745.1737050-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|DM4PR12MB6542:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f597795-f2ad-4859-59f9-08de1b6f8baa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+HoIw+U6F98i+WR/PsbwfS8eZEq7i6CxYY1ZxeBqgCO7i9J9XdA2Dw81ced9?=
 =?us-ascii?Q?Fpv4fORUaNGne5BrJ9ioY3ek9ZT51pKU/d0sd/wIZngsk46TluBSffEgczSh?=
 =?us-ascii?Q?54aPxNR6ZNBLIwj6AKy8Ht8ePfCBMcXX8GD4lwH7BWtMIK+vfEEmyiNxnD6N?=
 =?us-ascii?Q?UwEwkRFAZfXn4/A62wlYqzNAdZhY++rmZHbpmAsPVr3QBamwprIYH9Eey2/9?=
 =?us-ascii?Q?sf0jjxb5FaFBdcOIgW0Qd5OvBf35yoSjxUxv4zqI+Utdp8OyirMt9zU4pUMF?=
 =?us-ascii?Q?7wIBwghlBQ4fM9ZrgbgTflCc1AWoj1CQ81AqBQ4+0r8beQdgh1oXTaHyUWjD?=
 =?us-ascii?Q?fLfAf06JRtay6uDFoI1qn/eLtU7I8X8d9W4h3cpByMNqhlko1GP12vVFWmGX?=
 =?us-ascii?Q?qwwO3gIMbxsr8kDXxRr2fwGgvbawlkqxWESYVX1s7S8oqEiH8yHsPrYiniO/?=
 =?us-ascii?Q?/1td4/AtOBG+64fMp/B4mj1Qm/HA6AzH6LiCfZYmBXhAA9ONhSxVsK8DTPQh?=
 =?us-ascii?Q?p1ZrW+CqlcqrstInWLI8FiJB2M2GRh+q2oHG3xft3VByw/SDY/LkzUgZp1H3?=
 =?us-ascii?Q?ED7KDFLxIw0xt7i01pqvMDZumviA/fnTsR3/R4gmp+esiHGArcol1PNQBHI2?=
 =?us-ascii?Q?UH67xVnpD/0a+Nb6MZ4egXvcYli4vX/NWEz6eWkwTOTGAbGyrRnp9mf1ecLI?=
 =?us-ascii?Q?yo8eaRbjcV6qNP9hGddQGwpSCD7Itgx1mqlAypylzW51yCzhCiZK/aQUBPv5?=
 =?us-ascii?Q?EE4iCvDUeXZImfjIQA38TwLIKvEh3FUsBL5RysDJWznZUlBRlcYRSdV5gg6D?=
 =?us-ascii?Q?LXjoqEOwvWM8Ls+8pbDhzIqayHZBojND7yk8UmvcHaQjk4BwY0wm3i19NXAC?=
 =?us-ascii?Q?ibFVdHXGswzqn5gGrmeW0MjUobti0ilKBBSYNETNMmBRau+EC4zWnICwjiFB?=
 =?us-ascii?Q?MJxVZwgN9zWdIA/iJcqzvCuR4ACAlpqJoDaUmZMy85e2LYIHIQQ1EQU7cIZB?=
 =?us-ascii?Q?UnDRoawsJWQwiClLzT6+dQc4OzznZ7m5SXLbNRNP37mbWkKtstEp0VBt2I8g?=
 =?us-ascii?Q?vUV7B8b6NU0C6W7OwqTZ///QRlqJkIVUwtgL02EXxkpSMHov81qkvujzXPy1?=
 =?us-ascii?Q?10vpLZ0N3NezrtXXqbHs98GV8EyI47ixcMHOCR1Gz21Wo03E2tplRQIkc4Or?=
 =?us-ascii?Q?2bmG2ndNFwTXAGRi9hnwuvIwTYF2i3RGd16BFJ9B6WULiKzuqAMI3++PoTZL?=
 =?us-ascii?Q?2SrS388mVN+nkjygSra5R7ygDTRLAvYeOS4/F3ltBF4MryzbdLGTXXgrH6ru?=
 =?us-ascii?Q?tq1qsthylOqEcFLmP68zHc+IsHXbFxcngfTyZS8rSSqX/pGsikugjykqeriI?=
 =?us-ascii?Q?tzUEt0OCK+sDKfhVzRH3uuLo0aTfGJwGIbS4tQrGh068v+Iw1FlXlnEChGCA?=
 =?us-ascii?Q?YqHldpYTiPhqPTGzbXRE4ZpjeI7IK/FoeFXeyZNHQEAAjBe30ak0WyhjhJz1?=
 =?us-ascii?Q?oSXH3E95ej0QBnHqbhtjqj0ZVkaFVjP9ZpCbK4gvV4Bl0MuMxBThjV+21w?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 06:58:23.1266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f597795-f2ad-4859-59f9-08de1b6f8baa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6542
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

adapt reset function for pmfw eeprom

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 61 +++++++++++--------
 1 file changed, 36 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 258ff0f121a2..e9c5781e4376 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -444,40 +444,51 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control)
 	struct amdgpu_ras_eeprom_table_header *hdr = &control->tbl_hdr;
 	struct amdgpu_ras_eeprom_table_ras_info *rai = &control->tbl_rai;
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	u32 erase_res = 0;
 	u8 csum;
 	int res;
 
 	mutex_lock(&control->ras_tbl_mutex);
 
-	hdr->header = RAS_TABLE_HDR_VAL;
-	amdgpu_ras_set_eeprom_table_version(control);
+	if (!amdgpu_ras_smu_eeprom_supported(adev)) {
+		hdr->header = RAS_TABLE_HDR_VAL;
+		amdgpu_ras_set_eeprom_table_version(control);
 
-	if (hdr->version >= RAS_TABLE_VER_V2_1) {
-		hdr->first_rec_offset = RAS_RECORD_START_V2_1;
-		hdr->tbl_size = RAS_TABLE_HEADER_SIZE +
-				RAS_TABLE_V2_1_INFO_SIZE;
-		rai->rma_status = GPU_HEALTH_USABLE;
-		/**
-		 * GPU health represented as a percentage.
-		 * 0 means worst health, 100 means fully health.
-		 */
-		rai->health_percent = 100;
-		/* ecc_page_threshold = 0 means disable bad page retirement */
-		rai->ecc_page_threshold = con->bad_page_cnt_threshold;
+		if (hdr->version >= RAS_TABLE_VER_V2_1) {
+			hdr->first_rec_offset = RAS_RECORD_START_V2_1;
+			hdr->tbl_size = RAS_TABLE_HEADER_SIZE +
+					RAS_TABLE_V2_1_INFO_SIZE;
+			rai->rma_status = GPU_HEALTH_USABLE;
+			/**
+			 * GPU health represented as a percentage.
+			 * 0 means worst health, 100 means fully health.
+			 */
+			rai->health_percent = 100;
+			/* ecc_page_threshold = 0 means disable bad page retirement */
+			rai->ecc_page_threshold = con->bad_page_cnt_threshold;
+		} else {
+			hdr->first_rec_offset = RAS_RECORD_START;
+			hdr->tbl_size = RAS_TABLE_HEADER_SIZE;
+		}
+
+		csum = __calc_hdr_byte_sum(control);
+		if (hdr->version >= RAS_TABLE_VER_V2_1)
+			csum += __calc_ras_info_byte_sum(control);
+		csum = -csum;
+		hdr->checksum = csum;
+		res = __write_table_header(control);
+		if (!res && hdr->version > RAS_TABLE_VER_V1)
+			res = __write_table_ras_info(control);
 	} else {
-		hdr->first_rec_offset = RAS_RECORD_START;
-		hdr->tbl_size = RAS_TABLE_HEADER_SIZE;
+		res = amdgpu_ras_smu_erase_ras_table(adev, &erase_res);
+		if (res || erase_res) {
+			dev_warn(adev->dev, "RAS EEPROM reset failed, res:%d result:%d",
+										res, erase_res);
+			if (!res)
+				res = -EIO;
+		}
 	}
 
-	csum = __calc_hdr_byte_sum(control);
-	if (hdr->version >= RAS_TABLE_VER_V2_1)
-		csum += __calc_ras_info_byte_sum(control);
-	csum = -csum;
-	hdr->checksum = csum;
-	res = __write_table_header(control);
-	if (!res && hdr->version > RAS_TABLE_VER_V1)
-		res = __write_table_ras_info(control);
-
 	control->ras_num_recs = 0;
 	control->ras_num_bad_pages = 0;
 	control->ras_num_mca_recs = 0;
-- 
2.34.1


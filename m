Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4FA4C021AD
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2025 03:38:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5383910E370;
	Thu, 20 Feb 2025 03:38:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mOT5O1JM";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FBBB10E370
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2025 03:38:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ql9JPzWNB9NiDt3gqc0AY1mu3vXJbsKbRyvMEgWjnPyHl/Pl/9C41QKZPZC6H8mOTNx/gTLdn+VXzaPANwrNCPOkYKlnevYePIs4Ob6JUDfWw3XXadW7d7+BJebp5XDg2OiHzq0ilZCkvI4qAdcuX6Bd6kC0QvxFE7G/GTu0bm7EaT/HgafySYtGDgwWQY+UuFapvLC9YWE2Ks/VnE3pt8kFZui147YwsMON0Hq6KK3HTMmkGqmzTgeVx7G6ZoOBypAwpw6gc/Ut9XgyqOWZbhKTq6v3o1M4O35rEgAbu+KeKGPcXSq5ds5bMOa2MoaLRTn48k8LBkhiqw/PZA15ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ot7RWUncuT0oP3apvDURpsPY7vywV7ymCRUTgH4jDjw=;
 b=aO63kDLNxgxUm7kVR/zAPS8tjak59IkH480v3l0ipIqcn1p2gFME2bU4/8jv8t2uHtfeQdwnIIiYA+xxcKYGuAvmlYfnF68eQ9stt6oM+QlrQZ+ZfceMjl10572kmcXKFlm9onzLH2CCFlSundnYHtT5c1z/h+FCEkqKkYuL676Lt8UuM6EFEDM/zEt2bsR6cSIIW1zpUBjhauBMgI6t/42Ssg6bgAQNtJDAsUM+5fRrqCAgwluGSlK558CFVuGzqEX3GTookGm8reW8PxaXwKhXfyLz7fno+8fXLcZOs/N9oCUAIGkmtVGCLSQe7uHVN6ebrcAU4kP1s5IfF33giw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ot7RWUncuT0oP3apvDURpsPY7vywV7ymCRUTgH4jDjw=;
 b=mOT5O1JM+dHOR/ByLiQwhkzypccGiJfkBWaMWVDJgQ9JJDrfOoL6wvuGbKVyK0YXrkoztYH7Xr5wPMs9TGvkWfSy4bDpLlSVoNOU9+j5bXhCniJvgZs3slRbzWlEdnAEY2JALIhSk5mhtJtMeoLysAX4CYCYXzBCbKW5IXIQk6I=
Received: from BY5PR16CA0015.namprd16.prod.outlook.com (2603:10b6:a03:1a0::28)
 by PH8PR12MB8606.namprd12.prod.outlook.com (2603:10b6:510:1ce::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Thu, 20 Feb
 2025 03:38:07 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::71) by BY5PR16CA0015.outlook.office365.com
 (2603:10b6:a03:1a0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Thu,
 20 Feb 2025 03:38:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 03:38:07 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 19 Feb 2025 21:37:32 -0600
From: ganglxie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>, ganglxie <ganglxie@amd.com>
Subject: [PATCH] drm/amdgpu: Save nps to eeprom and refine code add nps info
 into eeprom records, and refine bad page adding logic based on nps info.
Date: Thu, 20 Feb 2025 11:36:01 +0800
Message-ID: <20250220033601.1089344-1-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|PH8PR12MB8606:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a66b305-32f4-4f54-de99-08dd515ffd76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z2V/qxe1leKkn9hDiqv4GeAhHg/OAOWnMPBSK1fu36NTYDIeyxiPUfUKIlyq?=
 =?us-ascii?Q?toWlS/gOFHZL0x6VpQl7fUWNqzVr0ezmJI8KtiS4gcs76xfNwcOGNjM/G5ka?=
 =?us-ascii?Q?iB6Inw0uSd96EOEANEs0skqZYSl+SrtqiMdQggRsmAgk98YHuBhPjvlzwZcw?=
 =?us-ascii?Q?3DM3/oM/yYFwrHCfJuhBnqWmgjqkmqkg3V2O1gQYrxPkWBAW1tHiW/D25c/o?=
 =?us-ascii?Q?uPHcRxF/Tju8JfqirfhLdeXuQI6tJfzp6heUqeV86IeBomhVUQwWtX+tF/gA?=
 =?us-ascii?Q?MH54u8h2x4LuHKFX0TODsQUhGT0oGdKi4sR1yE5V/zzYU9jEhXVxJitOycQP?=
 =?us-ascii?Q?WLc1fz44VIJKUq0X4V2/Vy4UhT1o/T21IoAbBdyAU9pKcgsSTX06Pgspad8Q?=
 =?us-ascii?Q?bPG+kP8gx7eZ+MQ9xMPgqaBm4IBsoAVXq0QfdJZSouwL1UtxivXDAPmR161y?=
 =?us-ascii?Q?5nbm3J5NQDxRjRYfK6IZnvFQjAwdIlk+ARd2BRWY3Njk7te6m4go39hQO+RW?=
 =?us-ascii?Q?WyQnjPlkgUqaIQwCdbJAygMXUpPl7rOFCBK3zdP4NpHHLIO1j2mEa+8i3guo?=
 =?us-ascii?Q?aNdgfiw7byjnGoSMdUDTBed5Wa3optTW57VTNknIB3tvb4RWQ4++jrDG29vU?=
 =?us-ascii?Q?2yBBJQa/H11we41b1/viIrLoIozJvzIbCvOmhxmhDVLIg+CZy2/g8KUBSLI5?=
 =?us-ascii?Q?qEp65n9lt8hyqipgF/lxvve4TGG/k5TRSxUnp1vtkuO0uiiM6Bk5whT1+V+I?=
 =?us-ascii?Q?sSC9kQz1dbmPUS7vML5e3YN3FBaEaJpSexsx7/eWshz35yU/uFHuVanHHIrN?=
 =?us-ascii?Q?VFPAmYpbfHIxYrbQnxTSpqZ+9xTwz0x1X8+KbXncesTr8dTukjrb963vNwtV?=
 =?us-ascii?Q?azaLJKFJmOqkEgPj325wAcYfKmiCCTRj2NcLDYWwW5U8a66Qlj7Dz6Ch9/zq?=
 =?us-ascii?Q?kbnhUO8IHvqmVzopIIw6yHYW9xXHcNvB3wc4+YhLx8yMgTTuCbPx6SD5MD7e?=
 =?us-ascii?Q?SPeMqBeVn0oHcMZ31VpCUdmqyjz+OyV2H9EKUXm7llOwYVNm04HOL3sFjvlu?=
 =?us-ascii?Q?WI/FG15oEOegG0crS2/JvcaAdsAFTZl+s7YOgpDRL7/scjE/pFqNW63+zuji?=
 =?us-ascii?Q?lBtmeuyF1XD+ald1MyuEu+qrtTbx7wXIcufkKp4NTom3uYeJuQRfmod0n/UI?=
 =?us-ascii?Q?bJMG06ZwRW/5aULwgKLUfPFS4PESgDtGuhaXq503YDFuGshMG8aJ2/MLlSjm?=
 =?us-ascii?Q?h4pen/kKW6t6lPjLq86sYDlr/ru/EV27YCl0o2q+l/+ZkykRUzOYg+Xt4eqn?=
 =?us-ascii?Q?JN62cKMVHaVPcu8uyIEN1N/QctXLsIwKCMCTToqOLO+iuxwHnvMt7bzEudVt?=
 =?us-ascii?Q?cRD4JkQQ8wVpwNqZNLqo/aw5uS/PycNWLwwWEFZavF3rkG5wcYUw8lVyy03r?=
 =?us-ascii?Q?zM+tnKfzMC1WVitxPMIj6gEJdjCGGNBbwrjWC5K6LSMl2D8VU6/rpWFQKpez?=
 =?us-ascii?Q?26sPljUdqCnXy98=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 03:38:07.0928 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a66b305-32f4-4f54-de99-08dd515ffd76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8606
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

Signed-off-by: ganglxie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 239 +++++++++---------
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    |  25 +-
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h       |   7 +
 4 files changed, 148 insertions(+), 143 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 5420e2d6d244..85ce6e2504da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2800,21 +2800,98 @@ static int amdgpu_ras_mca2pa(struct amdgpu_device *adev,
 	else
 		return  -EINVAL;
 }
+static int __amdgpu_ras_restore_bad_pages(struct amdgpu_device *adev,
+					struct eeprom_table_record *bps, int count)
+{
+	int j;
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	struct ras_err_handler_data *data = con->eh_data;
+
+	for (j = 0; j < count; j++) {
+		if (amdgpu_ras_check_bad_page_unlock(con,
+			bps[j].retired_page << AMDGPU_GPU_PAGE_SHIFT))
+			continue;
+
+		if (!data->space_left &&
+			amdgpu_ras_realloc_eh_data_space(adev, data, 256)) {
+			return -ENOMEM;
+		}
+
+		amdgpu_ras_reserve_page(adev, bps[j].retired_page);
+
+		memcpy(&data->bps[data->count], &(bps[j]),
+				sizeof(struct eeprom_table_record));
+		data->count++;
+		data->space_left--;
+	}
+
+	return 0;
+}
+static int __amdgpu_ras_convert_unit_rec_from_rom(struct amdgpu_device *adev,
+					struct eeprom_table_record *bps, struct ras_err_data *err_data,
+					enum amdgpu_memory_partition nps)
+{
+	int i = 0;
+	int ret = 0;
+	enum amdgpu_memory_partition save_nps;
+
+	save_nps = (bps[0].retired_page >> UMC_NPS_SHIFT) & UMC_NPS_MASK;
 
+	for(i = 0; i< adev->umc.retire_unit; i++)
+		bps[i].retired_page &= ~(UMC_NPS_MASK << UMC_NPS_SHIFT);
+
+	if (save_nps) {
+		if(save_nps == nps) {
+			if (amdgpu_umc_pages_in_a_row(adev, err_data,
+					bps[0].retired_page << AMDGPU_GPU_PAGE_SHIFT))
+				return -EINVAL;
+		} else {
+			if (amdgpu_ras_mca2pa_by_idx(adev, &bps[0], err_data))
+				return -EINVAL;
+		}
+	} else {
+		if (amdgpu_ras_mca2pa(adev, &bps[0], err_data)) {
+			if (nps == AMDGPU_NPS1_PARTITION_MODE)
+				memcpy(err_data->err_addr, bps,
+					sizeof(struct eeprom_table_record) * adev->umc.retire_unit);
+			else
+				return -EOPNOTSUPP;
+		}
+	}
+
+	return __amdgpu_ras_restore_bad_pages(adev, err_data->err_addr, adev->umc.retire_unit);
+}
+static int __amdgpu_ras_convert_single_rec_from_rom(struct amdgpu_device *adev,
+					struct eeprom_table_record *bps, struct ras_err_data *err_data,
+					enum amdgpu_memory_partition nps)
+{
+	enum amdgpu_memory_partition save_nps;
+
+	save_nps = (bps->retired_page >> UMC_NPS_SHIFT) & UMC_NPS_MASK;
+	bps->retired_page &= ~(UMC_NPS_MASK << UMC_NPS_SHIFT);
+
+	if(save_nps == nps) {
+		if (amdgpu_umc_pages_in_a_row(adev, err_data,
+				bps->retired_page << AMDGPU_GPU_PAGE_SHIFT))
+			return -EINVAL;
+	} else {
+		if (amdgpu_ras_mca2pa_by_idx(adev, bps, err_data))
+			return -EINVAL;
+	}
+	return __amdgpu_ras_restore_bad_pages(adev, err_data->err_addr,
+										adev->umc.retire_unit);
+}
 /* it deal with vram only. */
 int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 		struct eeprom_table_record *bps, int pages, bool from_rom)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	struct ras_err_handler_data *data;
 	struct ras_err_data err_data;
-	struct eeprom_table_record *err_rec;
 	struct amdgpu_ras_eeprom_control *control =
 			&adev->psp.ras_context.ras->eeprom_control;
 	enum amdgpu_memory_partition nps = AMDGPU_NPS1_PARTITION_MODE;
 	int ret = 0;
-	uint32_t i, j, loop_cnt = 1;
-	bool find_pages_per_pa = false;
+	uint32_t i;
 
 	if (!con || !con->eh_data || !bps || pages <= 0)
 		return 0;
@@ -2825,108 +2902,41 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 				sizeof(struct eeprom_table_record), GFP_KERNEL);
 		if (!err_data.err_addr) {
 			dev_warn(adev->dev, "Failed to alloc UMC error address record in mca2pa conversion!\n");
-			ret = -ENOMEM;
-			goto out;
+			return -ENOMEM;
 		}
 
-		err_rec = err_data.err_addr;
-		loop_cnt = adev->umc.retire_unit;
 		if (adev->gmc.gmc_funcs->query_mem_partition_mode)
 			nps = adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
 	}
 
 	mutex_lock(&con->recovery_lock);
-	data = con->eh_data;
-	if (!data) {
-		/* Returning 0 as the absence of eh_data is acceptable */
-		goto free;
-	}
-
-	for (i = 0; i < pages; i++) {
-		if (from_rom &&
-		    control->rec_type == AMDGPU_RAS_EEPROM_REC_MCA) {
-			if (!find_pages_per_pa) {
-				if (amdgpu_ras_mca2pa_by_idx(adev, &bps[i], &err_data)) {
-					if (!i && nps == AMDGPU_NPS1_PARTITION_MODE) {
-						/* may use old RAS TA, use PA to find pages in
-						 * one row
-						 */
-						if (amdgpu_umc_pages_in_a_row(adev, &err_data,
-									      bps[i].retired_page <<
-									      AMDGPU_GPU_PAGE_SHIFT)) {
-							ret = -EINVAL;
-							goto free;
-						} else {
-							find_pages_per_pa = true;
-						}
-					} else {
-						/* unsupported cases */
-						ret = -EOPNOTSUPP;
-						goto free;
-					}
-				}
-			} else {
-				if (amdgpu_umc_pages_in_a_row(adev, &err_data,
-						bps[i].retired_page << AMDGPU_GPU_PAGE_SHIFT)) {
-					ret = -EINVAL;
-					goto free;
-				}
-			}
-		} else {
-			if (from_rom && !find_pages_per_pa) {
-				if (bps[i].retired_page & UMC_CHANNEL_IDX_V2) {
-					/* bad page in any NPS mode in eeprom */
-					if (amdgpu_ras_mca2pa_by_idx(adev, &bps[i], &err_data)) {
-						ret = -EINVAL;
+
+	if(from_rom) {
+		for (i = 0; i < pages; i++) {
+			if (control->ras_num_recs - i >= adev->umc.retire_unit) {
+				if ((bps[i].address == bps[i + 1].address) &&
+					(bps[i].mem_channel == bps[i + 1].mem_channel)) {
+					//deal retire_unit records a time
+					ret = __amdgpu_ras_convert_unit_rec_from_rom(adev,
+									&bps[i], &err_data, nps);
+					if (ret)
 						goto free;
-					}
+					i += (adev->umc.retire_unit - 1);
 				} else {
-					/* legacy bad page in eeprom, generated only in
-					 * NPS1 mode
-					 */
-					if (amdgpu_ras_mca2pa(adev, &bps[i], &err_data)) {
-						/* old RAS TA or ASICs which don't support to
-						 * convert addrss via mca address
-						 */
-						if (!i && nps == AMDGPU_NPS1_PARTITION_MODE) {
-							find_pages_per_pa = true;
-							err_rec = &bps[i];
-							loop_cnt = 1;
-						} else {
-							/* non-nps1 mode, old RAS TA
-							 * can't support it
-							 */
-							ret = -EOPNOTSUPP;
-							goto free;
-						}
-					}
+					break;
 				}
-
-				if (!find_pages_per_pa)
-					i += (adev->umc.retire_unit - 1);
 			} else {
-				err_rec = &bps[i];
+				break;
 			}
 		}
-
-		for (j = 0; j < loop_cnt; j++) {
-			if (amdgpu_ras_check_bad_page_unlock(con,
-				err_rec[j].retired_page << AMDGPU_GPU_PAGE_SHIFT))
-				continue;
-
-			if (!data->space_left &&
-			    amdgpu_ras_realloc_eh_data_space(adev, data, 256)) {
-				ret = -ENOMEM;
+		for (; i < pages; i++) {
+			ret = __amdgpu_ras_convert_single_rec_from_rom(adev,
+				&bps[i], &err_data, nps);
+			if (ret)
 				goto free;
-			}
-
-			amdgpu_ras_reserve_page(adev, err_rec[j].retired_page);
-
-			memcpy(&data->bps[data->count], &(err_rec[j]),
-					sizeof(struct eeprom_table_record));
-			data->count++;
-			data->space_left--;
 		}
+	} else {
+		ret = __amdgpu_ras_restore_bad_pages(adev, bps, pages);
 	}
 
 free:
@@ -2971,24 +2981,14 @@ int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev,
 
 	/* only new entries are saved */
 	if (save_count > 0) {
-		if (control->rec_type == AMDGPU_RAS_EEPROM_REC_PA) {
+		for (i = 0; i < unit_num; i++) {
 			if (amdgpu_ras_eeprom_append(control,
-						     &data->bps[control->ras_num_recs],
-						     save_count)) {
+					&data->bps[bad_page_num + i * adev->umc.retire_unit],
+					1)) {
 				dev_err(adev->dev, "Failed to save EEPROM table data!");
 				return -EIO;
 			}
-		} else {
-			for (i = 0; i < unit_num; i++) {
-				if (amdgpu_ras_eeprom_append(control,
-						&data->bps[bad_page_num + i * adev->umc.retire_unit],
-						1)) {
-					dev_err(adev->dev, "Failed to save EEPROM table data!");
-					return -EIO;
-				}
-			}
 		}
-
 		dev_info(adev->dev, "Saved %d pages to EEPROM table.\n", save_count);
 	}
 
@@ -3005,6 +3005,7 @@ static int amdgpu_ras_load_bad_pages(struct amdgpu_device *adev)
 		&adev->psp.ras_context.ras->eeprom_control;
 	struct eeprom_table_record *bps;
 	int ret;
+	int i = 0;
 
 	/* no bad page record, skip eeprom access */
 	if (control->ras_num_recs == 0 || amdgpu_bad_page_threshold == 0)
@@ -3018,13 +3019,22 @@ static int amdgpu_ras_load_bad_pages(struct amdgpu_device *adev)
 	if (ret) {
 		dev_err(adev->dev, "Failed to load EEPROM table records!");
 	} else {
-		if (control->ras_num_recs > 1 &&
-		    adev->umc.ras && adev->umc.ras->convert_ras_err_addr) {
-			if ((bps[0].address == bps[1].address) &&
-			    (bps[0].mem_channel == bps[1].mem_channel))
-				control->rec_type = AMDGPU_RAS_EEPROM_REC_PA;
-			else
-				control->rec_type = AMDGPU_RAS_EEPROM_REC_MCA;
+		if (adev->umc.ras && adev->umc.ras->convert_ras_err_addr) {
+			for (i = 0; i < control->ras_num_recs; i++) {
+				if ((control->ras_num_recs - i) >= adev->umc.retire_unit) {
+					if ((bps[i].address == bps[i + 1].address) &&
+								(bps[i].mem_channel == bps[i + 1].mem_channel)) {
+						control->ras_num_pa_recs += adev->umc.retire_unit;
+						i += (adev->umc.retire_unit -1);
+					} else {
+						control->ras_num_mca_recs += (control->ras_num_recs - i);
+						break;
+					}
+				} else {
+					control->ras_num_mca_recs += (control->ras_num_recs - i);
+					break;
+				}
+			}
 		}
 
 		ret = amdgpu_ras_eeprom_check(control);
@@ -3438,12 +3448,7 @@ int amdgpu_ras_init_badpage_info(struct amdgpu_device *adev)
 		return ret;
 
 	if (!adev->umc.ras || !adev->umc.ras->convert_ras_err_addr)
-		control->rec_type = AMDGPU_RAS_EEPROM_REC_PA;
-
-	/* default status is MCA storage */
-	if (control->ras_num_recs <= 1 &&
-	    adev->umc.ras && adev->umc.ras->convert_ras_err_addr)
-		control->rec_type = AMDGPU_RAS_EEPROM_REC_MCA;
+		control->ras_num_pa_recs = control->ras_num_recs;
 
 	if (control->ras_num_recs) {
 		ret = amdgpu_ras_load_bad_pages(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 83b54efcaa87..1679e2b52af7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -727,11 +727,9 @@ amdgpu_ras_eeprom_append_table(struct amdgpu_ras_eeprom_control *control,
 				     - control->ras_fri)
 		% control->ras_max_record_count;
 
-	if (control->rec_type == AMDGPU_RAS_EEPROM_REC_PA)
-		control->ras_num_bad_pages = control->ras_num_recs;
-	else
-		control->ras_num_bad_pages =
-			control->ras_num_recs * adev->umc.retire_unit;
+	control->ras_num_mca_recs += num;
+	control->ras_num_bad_pages += num * adev->umc.retire_unit;
+
 Out:
 	kfree(buf);
 	return res;
@@ -852,6 +850,7 @@ int amdgpu_ras_eeprom_append(struct amdgpu_ras_eeprom_control *control,
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
 	int res, i;
+	uint64_t nps = AMDGPU_NPS1_PARTITION_MODE;
 
 	if (!__is_ras_eeprom_supported(adev))
 		return 0;
@@ -865,9 +864,12 @@ int amdgpu_ras_eeprom_append(struct amdgpu_ras_eeprom_control *control,
 		return -EINVAL;
 	}
 
+	if(adev->gmc.gmc_funcs->query_mem_partition_mode)
+		nps = adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
+
 	/* set the new channel index flag */
 	for (i = 0; i < num; i++)
-		record[i].retired_page |= UMC_CHANNEL_IDX_V2;
+		record[i].retired_page |= (nps << UMC_NPS_SHIFT);
 
 	mutex_lock(&control->ras_tbl_mutex);
 
@@ -881,7 +883,7 @@ int amdgpu_ras_eeprom_append(struct amdgpu_ras_eeprom_control *control,
 
 	/* clear channel index flag, the flag is only saved on eeprom */
 	for (i = 0; i < num; i++)
-		record[i].retired_page &= ~UMC_CHANNEL_IDX_V2;
+		record[i].retired_page &= ~(nps << UMC_NPS_SHIFT);
 
 	return res;
 }
@@ -1392,6 +1394,8 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
 	}
 	control->ras_fri = RAS_OFFSET_TO_INDEX(control, hdr->first_rec_offset);
 
+	control->ras_num_mca_recs = 0;
+	control->ras_num_pa_recs = 0;
 	return 0;
 }
 
@@ -1412,11 +1416,8 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
 	if (!__get_eeprom_i2c_addr(adev, control))
 		return -EINVAL;
 
-	if (control->rec_type == AMDGPU_RAS_EEPROM_REC_PA)
-		control->ras_num_bad_pages = control->ras_num_recs;
-	else
-		control->ras_num_bad_pages =
-			control->ras_num_recs * adev->umc.retire_unit;
+	control->ras_num_bad_pages = control->ras_num_pa_recs +
+			control->ras_num_mca_recs * adev->umc.retire_unit;
 
 	if (hdr->header == RAS_TABLE_HDR_VAL) {
 		DRM_DEBUG_DRIVER("Found existing EEPROM table with %d records",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index 81d55cb7b397..13f7eda9a696 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -43,19 +43,6 @@ enum amdgpu_ras_eeprom_err_type {
 	AMDGPU_RAS_EEPROM_ERR_COUNT,
 };
 
-/*
- * one UMC MCA address could map to multiply physical address (PA),
- * such as 1:16, we use eeprom_table_record.address to store MCA
- * address and use eeprom_table_record.retired_page to save PA.
- *
- * AMDGPU_RAS_EEPROM_REC_PA: one record store one PA
- * AMDGPU_RAS_EEPROM_REC_MCA: one record store one MCA address
- */
-enum amdgpu_ras_eeprom_rec_type {
-	AMDGPU_RAS_EEPROM_REC_PA,
-	AMDGPU_RAS_EEPROM_REC_MCA,
-};
-
 struct amdgpu_ras_eeprom_table_header {
 	uint32_t header;
 	uint32_t version;
@@ -100,6 +87,12 @@ struct amdgpu_ras_eeprom_control {
 	 */
 	u32 ras_num_bad_pages;
 
+	/* Number of records store mca address */
+	u32 ras_num_mca_recs;
+
+	/* Number of records store physical address */
+	u32 ras_num_pa_recs;
+
 	/* First record index to read, 0-based.
 	 * Range is [0, num_recs-1]. This is
 	 * an absolute index, starting right after
@@ -120,7 +113,6 @@ struct amdgpu_ras_eeprom_control {
 	/* Record channel info which occurred bad pages
 	 */
 	u32 bad_channel_bitmap;
-	enum amdgpu_ras_eeprom_rec_type rec_type;
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index a4a7e61817aa..857693bcd8d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -71,6 +71,13 @@
  */
 #define UMC_CHANNEL_IDX_V2	BIT_ULL(47)
 
+/*
+ * save nps value to eeprom_table_record.retired_page[47:40],
+ * the channel index flag above will be retired.
+ */
+#define UMC_NPS_SHIFT 40
+#define UMC_NPS_MASK 0xffULL
+
 typedef int (*umc_func)(struct amdgpu_device *adev, uint32_t node_inst,
 			uint32_t umc_inst, uint32_t ch_inst, void *data);
 
-- 
2.34.1


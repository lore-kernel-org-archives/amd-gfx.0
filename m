Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA7EC021AD
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2025 06:17:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E98F10E8C8;
	Thu, 20 Feb 2025 06:17:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pun0ST5L";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 438F810E8C8
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2025 06:17:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lNnFolu5Uin8Qm53PIdTJBZsoz7bxfo3WDXTv3TqGFPhEip24cx5nz6EUx8jcZZRiUAs5L6GTK6jDEBUn1VO+U4H7p7lLxYjoSzvF96fTa+guInsX8G2dOF7hWmBwlnFwqnx5a+Z4GIAEJIFS3Wpm/7Gcri9odf+I+sPVRsqg/9gi9x3mSaJ3othRROXaOq00BJO8MOntfiT+BqlFr4XQt6gwGBzPwlQBx7cRMk0SqkVrJ2xZrgiZOieq7wOlq1QCRzuoEi124LFJlamREnlabr8nd3oL2QDuWni2kuIZcjz5MyTaGuzzHQ398X01xjDDd08OyzlgUOoAly+7cgV3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=upbocqQrDOvdUcbJs+pJrhwnPj/2gfDEFdyq4MmnFnQ=;
 b=kLjl/YcsbKnps9m7FU6C38BN/tRk+aUIVAtkQHq1VAW4+pARN6AXeYJtac8qmuO7AT08wksx823Rru5d8WIr4Q78v21yUNnktWADMwymWUCtvW9Xi+tgkQvr1j11slSlQJjQrN8Uun17afT4P+7AY+CMTbxhFDnrPZKv3TbxEsTnEjqi+R60BEr9hU1OJG6ZoBvIPY+FeuPfDhfovm1dkWgpS+xXOonhxiLfrQaEGw8Qe3eA9dlfA9/SI4sIBjSFfjyYV4r5k9qSUPNJLNaW7jriWAkbt1aiPEQUfqD7qYm91mkS2tfSGZb62gUK8YC3QBypwFvCR59sA0De/Xv0uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upbocqQrDOvdUcbJs+pJrhwnPj/2gfDEFdyq4MmnFnQ=;
 b=pun0ST5Lc7+zKcb0dUrlqvn14k8mcpn1DMJ5kQfmD4KXj+1v0zDZHs3CJCUyrIsI7RyGjiuHAXw6FD9acxhCt297ZGKqlw00RQ5lo6+grm985uBwtcYBiSjK8omaAcAzzP4y038l9UP+mF64sUE5N0BHuSjs49pT+adElgXOaf8=
Received: from SJ0PR03CA0003.namprd03.prod.outlook.com (2603:10b6:a03:33a::8)
 by CYYPR12MB8731.namprd12.prod.outlook.com (2603:10b6:930:ba::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 06:17:22 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::95) by SJ0PR03CA0003.outlook.office365.com
 (2603:10b6:a03:33a::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 06:17:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 06:17:21 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Feb 2025 00:17:19 -0600
From: ganglxie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>, ganglxie <ganglxie@amd.com>
Subject: [PATCH] drm/amdgpu: Save nps to eeprom and refine code
Date: Thu, 20 Feb 2025 14:16:37 +0800
Message-ID: <20250220061637.1092474-1-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|CYYPR12MB8731:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f015931-9bd0-49fe-d0f4-08dd51763c97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?epW0Yo23pFT0v261Wn9Ek4e4YhGnTymx0TJwZV7IoZP4YEltDpgtL29s9RPG?=
 =?us-ascii?Q?8vINv/u9ydNQN6ptpV+NSz6egycOCBx0ftOgfC+dPjua7yzdsfuyCHZr9XwH?=
 =?us-ascii?Q?lwB0MMbJHM1yJ+om2EeF5f1IOPWQNGuCVRg7PP83x08RFCa8i1/0OU4yMdfY?=
 =?us-ascii?Q?lPF0HXOSEz5vNnjv0lxqeMdDZ57p1BluXoYl57WhAACwHAI/V+wcx2rClAtD?=
 =?us-ascii?Q?/yaKnHVWQVYiVUExw0sfsxIGggu68/wMa+kt9roCk8RQ6Rl8YKxiQcbZW3pY?=
 =?us-ascii?Q?L7b6aK78q2TKZshhAnoYZcr9HBs7SNmvb62U7aSXnuUJ5MBaf66TQOD4LxPz?=
 =?us-ascii?Q?J9vh/UuJ1WeYmsUEXyx8r9/t6znFeKQDZiZ82nHxfkMqQcLBtBBeuTkceKGD?=
 =?us-ascii?Q?x7xgpEs1HoKi1JoFpvAuD/R5tZOZp22+wwEEUDLccQouW8bgL3fghbtS5OlC?=
 =?us-ascii?Q?8UWz7KcBMQcfQqfKfVaWKydj9NtZnYWv13w4NxLMdYnQPlgoAscm2GynnQow?=
 =?us-ascii?Q?jee8M1X09xME248bfC6AOQKB+ZXZxu2GnPwygE4hvSE6CthWl4vXxOrWz8R2?=
 =?us-ascii?Q?tzVytbGaEyItHWUmUUV6rzmnk+6ubwsLgOgLF+kN9daoWEp+aatf3nGnqQup?=
 =?us-ascii?Q?4JaWKdrdKm/yN5W9ecotjzZ+U3Vo+Ww8nTDqtSk2rwVqy/NWO7TnUwwFfc00?=
 =?us-ascii?Q?zzcQTRWNbb2KJ2NA6R5jLaChDlFGWEgQ9z0L+aUp6k3pYhd8ixMqxcIfyE6p?=
 =?us-ascii?Q?O3czwFrKQ9WzD81tMaZ0xDxDpkTfUTr95VWgDaDOZ3U6nHsKJjKBJwASZckB?=
 =?us-ascii?Q?5tWNE113yAjySj2lQEPGMvZKOtb+L/zwrttKugqo2dL/qc/GONGTlTXWA0HN?=
 =?us-ascii?Q?QzKJIblgUfYUkLJw4RgkG59uODTzl92F876Z5QFlneZ2J6e9Ox/EfOCOO0wg?=
 =?us-ascii?Q?Au+gvla+6bWYx2QRE7nSLQn9aY0IX7InuHHH42oJoX32Wp0Sy7xlxPPmmCmD?=
 =?us-ascii?Q?QQ8Z2QfpRS1cY+JC2gOimOfaswXiT8jkON0p/yGreBRbPS+Ycl6QHdblbj0I?=
 =?us-ascii?Q?wM/x2wlMMwr6JCBHYaIxdDnH+W4pIQdrb9KfcOqUZY3c+MBSMaF3nhcunBNU?=
 =?us-ascii?Q?KUwohDFbhKCuXiHa2cLsPpsCu7hMq5bxY5pv1DPActsuz0mKNGo7TDDz3yV9?=
 =?us-ascii?Q?ZNFFDCzmVg8743CfOja/MKOQAGIh+TSeKRsVzVhOwdZKb+TenvUN7l0tnH4t?=
 =?us-ascii?Q?tDNdmr55FIHGgHrdP7sOJbEHoKLtSjVTsemWxYy7GP9yP0L9XYW6df+6Ou2b?=
 =?us-ascii?Q?SoBnZmHENntwzwbzuTRbHUwJM5a8q1uasCqOn4x9k9TXayALv/erMdv2RxZc?=
 =?us-ascii?Q?ScdKkzaluY9wAyLxttyrvpd+ysRZWf2hOzLZE06HY7ntWUrhuUxUv3vPg+Jk?=
 =?us-ascii?Q?tyj8o1fPfgKhZyKOdFBddxl6icBG30KW+uFN+Uw6S2+Zf2Kv2f3T7RIbTVcJ?=
 =?us-ascii?Q?cdPxcnoxCcfubsc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 06:17:21.9332 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f015931-9bd0-49fe-d0f4-08dd51763c97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8731
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

add nps info into eeprom records, and refine adding bad page
logic based on nps info.

Signed-off-by: ganglxie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 244 +++++++++---------
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    |  25 +-
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h       |   7 +
 4 files changed, 153 insertions(+), 143 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 5420e2d6d244..3945dda54b3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2801,20 +2801,101 @@ static int amdgpu_ras_mca2pa(struct amdgpu_device *adev,
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
+
+static int __amdgpu_ras_convert_unit_rec_from_rom(struct amdgpu_device *adev,
+				struct eeprom_table_record *bps, struct ras_err_data *err_data,
+				enum amdgpu_memory_partition nps)
+{
+	int i = 0;
+	int ret = 0;
+	enum amdgpu_memory_partition save_nps;
+
+	save_nps = (bps[0].retired_page >> UMC_NPS_SHIFT) & UMC_NPS_MASK;
+
+	for (i = 0; i < adev->umc.retire_unit; i++)
+		bps[i].retired_page &= ~(UMC_NPS_MASK << UMC_NPS_SHIFT);
+
+	if (save_nps) {
+		if (save_nps == nps) {
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
+
+static int __amdgpu_ras_convert_single_rec_from_rom(struct amdgpu_device *adev,
+				struct eeprom_table_record *bps, struct ras_err_data *err_data,
+				enum amdgpu_memory_partition nps)
+{
+	enum amdgpu_memory_partition save_nps;
+
+	save_nps = (bps->retired_page >> UMC_NPS_SHIFT) & UMC_NPS_MASK;
+	bps->retired_page &= ~(UMC_NPS_MASK << UMC_NPS_SHIFT);
+
+	if (save_nps == nps) {
+		if (amdgpu_umc_pages_in_a_row(adev, err_data,
+				bps->retired_page << AMDGPU_GPU_PAGE_SHIFT))
+			return -EINVAL;
+	} else {
+		if (amdgpu_ras_mca2pa_by_idx(adev, bps, err_data))
+			return -EINVAL;
+	}
+	return __amdgpu_ras_restore_bad_pages(adev, err_data->err_addr,
+									adev->umc.retire_unit);
+}
+
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
@@ -2825,108 +2906,41 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
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
+	if (from_rom) {
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
@@ -2971,24 +2985,14 @@ int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev,
 
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
 
@@ -3005,6 +3009,7 @@ static int amdgpu_ras_load_bad_pages(struct amdgpu_device *adev)
 		&adev->psp.ras_context.ras->eeprom_control;
 	struct eeprom_table_record *bps;
 	int ret;
+	int i = 0;
 
 	/* no bad page record, skip eeprom access */
 	if (control->ras_num_recs == 0 || amdgpu_bad_page_threshold == 0)
@@ -3018,13 +3023,23 @@ static int amdgpu_ras_load_bad_pages(struct amdgpu_device *adev)
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
+						(bps[i].mem_channel == bps[i + 1].mem_channel)) {
+						control->ras_num_pa_recs += adev->umc.retire_unit;
+						i += (adev->umc.retire_unit - 1);
+					} else {
+						control->ras_num_mca_recs +=
+									(control->ras_num_recs - i);
+						break;
+					}
+				} else {
+					control->ras_num_mca_recs += (control->ras_num_recs - i);
+					break;
+				}
+			}
 		}
 
 		ret = amdgpu_ras_eeprom_check(control);
@@ -3438,12 +3453,7 @@ int amdgpu_ras_init_badpage_info(struct amdgpu_device *adev)
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
index 83b54efcaa87..ab27cecb5519 100644
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
 
+	if (adev->gmc.gmc_funcs->query_mem_partition_mode)
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


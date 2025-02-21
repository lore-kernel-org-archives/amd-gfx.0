Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3E1C021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 03:19:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C59A10EA14;
	Fri, 21 Feb 2025 03:19:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ndOKvB1n";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2045.outbound.protection.outlook.com [40.107.96.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2BD710EA14
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 03:19:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GbzP61Rh9qVcxEkFi6plt24Y9XWhdsIXvUWWV2xNi/G3PTdNJ+yw+j9P9FMJjwuye4votvbx1si4uZKVf5lejmZzn/iTGJkdRxzwCmCPCVykM8UMXxzU3+B2i6TiqoohPqzRHNRjRZNDh1AuKPkzH7/a1nrr+sL0HoC6xmv5U64JvJ3F4VreC9hwLRWCJzT6SLok0W8OAUCLo4RQPt849bfC9BE3E5ddFABXaC5RMVUuax9iA/PcI4scz5jl44MHMEqi5O2x/4TXXmug9v1rkDIFhyExJBznoQlbyE4mdzXg3R/JB7aKIkz1e74E5A/vze3wg4mT7+pVrv0ke/ciDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijbJBV3mXn8cpyps8suHNJzVCbzkZaQul91oqcackak=;
 b=KMxINqLcchKe8xh3ObzI+H9Rm1aJlqCXOWsR1PAZ1QS7wzglqz3zuvSlM7DJCPKHQoDX4X2BjPc0W5L/6FQSVJnWLPckpcwq2W+sFoRX1pSJfC2DpdWC4ef9pOvWso3zjyULVHPdkFreETJA4GXJWEpHdDP74x58WEDGcbN+s2sZL123rE7RnRYLRLeYqj5WtkMcR+pXfcYEDZc30fuYPaXH9+KIkbwl0sWcPVa8L9P9F9JIJjcaVWVwk1BbuD/EtOYlWRVhNkz1gtNgdG8119ab5jscIublruKSo7uxrkMWATuTiXat2n52QRjZmXOlz67Bi4mXCIO0sZtFocxLsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijbJBV3mXn8cpyps8suHNJzVCbzkZaQul91oqcackak=;
 b=ndOKvB1nIssEG0EC1aZFevpijz0C42xOLvXVfg6FI57NR8FVLKlTFIrHouoZbo85Q1w/WyyK1D/pIHL/koepjA1HXi9t9pehcRB3Ymx+k/rbpzYPKDSv1Kerr6ZwvJcoNEZ/E+TjKiRnFZivc2SWpkHZFXMx3hagj1Eo4GrPDbU=
Received: from PH8PR02CA0050.namprd02.prod.outlook.com (2603:10b6:510:2da::19)
 by SA1PR12MB8141.namprd12.prod.outlook.com (2603:10b6:806:339::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 03:19:03 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:510:2da:cafe::44) by PH8PR02CA0050.outlook.office365.com
 (2603:10b6:510:2da::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Fri,
 21 Feb 2025 03:19:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 03:19:03 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Feb 2025 21:19:00 -0600
From: ganglxie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>, ganglxie <ganglxie@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Refine bad page adding
Date: Fri, 21 Feb 2025 11:18:35 +0800
Message-ID: <20250221031835.1105893-1-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|SA1PR12MB8141:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c636de2-7316-448c-fa12-08dd52267e06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YJHuPxMbsI5pSYQTha8wtYe+A6LH0KnLg/5lxJyxQRPuP62askooICCLbcO6?=
 =?us-ascii?Q?ogpKWeXL58NwxQoraA0ixYNPNnKUaWoBRUtn8pxHTPMYgbKxrJoJFHM1Dm0s?=
 =?us-ascii?Q?7gfvX251j01EX8DAKHnAOiFHUmgk2VbbhPOIkpImijCdRegPUofErYIMG901?=
 =?us-ascii?Q?Rp8VsxLOIqeaH3hjdsxvoxj4EiignV9wq+1sWdOJEh5EOQyV87aHb6KWGh9m?=
 =?us-ascii?Q?+RiYQvN/EDUpqfri5V3AX2A+pb8e2p1AWL+KpMfhYeKL3fID/IF1xIlGAopZ?=
 =?us-ascii?Q?IjxVGunwk343Ob2wAgAR6Z5y++COfbiyNjF2bXuX7xxjALdSVt4YMWd5r5qy?=
 =?us-ascii?Q?v3QDjQ6eI1iHXrYovk957FeGSjjzaQkfid+TZNFy3OpLVo4ggY+tkWA3PpqY?=
 =?us-ascii?Q?TywVXFcBLjmL6ZUZH2XfnWrf5nE1Ourf4YD0Td6Erar/6cIWwzvhHkw+Duua?=
 =?us-ascii?Q?xl0MD/ntzbVwmBoC1zQsFSy5Z1bWorR0Q6I/ztMU+4D5BjcBVVHXMrOEc1Ec?=
 =?us-ascii?Q?m8piH0K5NoCm3o6bkRUnKl0wMGbhZEFTp+FalaP/HQHcEKfA5TkksTntBbpp?=
 =?us-ascii?Q?tzrcu4C+AKnQ3958TEBErZUtxTVI5d+BQfhkOJBYRR8/IQNOqms9wJkkyKHe?=
 =?us-ascii?Q?JAUyVqyzLsmfbG16wROpWVSlmlKp+68myt5QrkeUwGVkvfqRaKBTRe2yO2r+?=
 =?us-ascii?Q?ebruUq6YXYpECTOB2zsTBe1hQF8fxDiYC/btG/ei9gO7UyJL1l3KnyL52SP+?=
 =?us-ascii?Q?WwQSScK7RpqM87UA0VZUfW0JsR/aPLf1Endmsdzs/hSSKCIbVzwZey0XWAwL?=
 =?us-ascii?Q?D/JYxmlpO+OF6KuSw0rRCi8P+Ri5q/E5uypZtGwXD4BPKlvHW3jnacf6iKp6?=
 =?us-ascii?Q?An9TR8oup3tm/cHyi1OtyV1W2kku1NsJcyIG/Snb/SbhtuMujibZcx+YEDsl?=
 =?us-ascii?Q?jJw53tQ4Pxvvq4EO6omqvUOpGQQ0YHY310oecZIl9vUzozhjFrxLHk74J+Mp?=
 =?us-ascii?Q?7izOiM5Jd8x8oQnkeos7ZHYoXqK9uE/+o+XSC1j9FD6N092UDu2amKWTrQD6?=
 =?us-ascii?Q?X16Mdkqmf4oi1Zvv+qCXYDt4bT4rWRAcT3wZgHQaVVVq/LYbeKAxUOp2Cjde?=
 =?us-ascii?Q?dRvcSvZsifiTBgmoPwn2BnPSfJxWu3TdSY74cOWPrNcOXveqEAsxxg1or/VJ?=
 =?us-ascii?Q?Ti5AOydIu64WekC2SZZ9Prq0b5teXLFqKf3KWPW2YuzUDzsLedOTfT5SnQxf?=
 =?us-ascii?Q?Nmd/9Lrn4jJZYhcKiFXESAm4Cg04zDOulVBGpXXCs8c81GrJyICVapKM6gUx?=
 =?us-ascii?Q?16b5tW3+w3SkWbeOgw449CrJIi98CX2F6giOVbE1oz3tHIVko6+TVoLIWUwy?=
 =?us-ascii?Q?7PifV8SRsY85s3xw649c6FdY489sy+8VZtV92ACpX7HEw8GnjGNnz/h1u7tW?=
 =?us-ascii?Q?CLC3ueNiGalMmQYR5k/7efTMibCltJTmT7gRLwKdsRR1J+p6TYuwRinwTNEb?=
 =?us-ascii?Q?gTfjHsK4X/drWoQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 03:19:03.1381 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c636de2-7316-448c-fa12-08dd52267e06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8141
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

bad page adding can be simpler with nps info

Signed-off-by: ganglxie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 196 +++++++++++++-----------
 1 file changed, 105 insertions(+), 91 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 5420e2d6d244..439841a2d1c2 100644
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
+static int __amdgpu_ras_convert_rec_array_from_rom(struct amdgpu_device *adev,
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
+static int __amdgpu_ras_convert_rec_from_rom(struct amdgpu_device *adev,
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
+				    (bps[i].mem_channel == bps[i + 1].mem_channel)) {
+					//deal with retire_unit records a time
+					ret = __amdgpu_ras_convert_rec_array_from_rom(adev,
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
+			ret = __amdgpu_ras_convert_rec_from_rom(adev,
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
-- 
2.34.1


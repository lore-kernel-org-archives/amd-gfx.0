Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87047C369CB
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 07:02:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AE1F10E2DA;
	Tue, 29 Apr 2025 07:02:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SQnfx24P";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1C5810E2DA
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 07:01:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qm8V1DW8bIkrIfqS/7Ocfe5Sh3+6ChO0bfsozUv/P4RQ3Ci6+ltnDFqXzzc+p6hRis0hs9IQPMM/Z8lMYv0XciZnN9t9zq/VxvWHYvv/og4/MGCqf63KfeCKZK41ahbAyyqJuxq4MYZ7Y/QdhThZ0JnCSASthewBP7AAicN27cqZRZd9yVDOLvdaPG9WLc9/xvufLmyGloYLuLwu9hNHmvMvjk2++/L584mBl/+N3FcU8JQr5VgUD+oTJ1FsiMVjCBe7ZICTzrHCOplPfekiP0HjzaFZL5kcd5Ak/tTWp6YASpfwOgpHEvu6fMCiDqGLogX6wpylbpmWwqyKcsxg2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDE9wI2H5JzpTX2kWoZp71Qcx45FjNQ3SbQajChYdeg=;
 b=FGdKEYKzRVoZBShftlS7URb7mWMyH1L+KGwt9tET0zbepw96DES+dkPUynikMe58fUnGwE+squYnX7SBeVpPhVbTzyd8Xl1RtS/qExGemaRrawHwKz0fmPsVxhtCJhQoyUStmIvatDxV7dlREgnUxTETOfntzeFDlGasBC0Nn0cMzcHQ+2qInHyNIiTabt2YtXEfQUO/1ZpBM1xqfvoAmcFy3tAONrXnMD3VvLSqV2F29m5Xu4PsLmMnMORKSCnYzp1mt+vfc0fXy4fkZ3IYJgzDYsE3yxKMUeEWIsxEoHXg6JWJmYvVqLR/Hbjd04x7Vb9MVervhjGKZzJW2sVSwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDE9wI2H5JzpTX2kWoZp71Qcx45FjNQ3SbQajChYdeg=;
 b=SQnfx24PdH6UJtuprVVBt/VVG5WbgZc9CJGl/BVy77UxIlUO9Tr3onOcAYkqrNJHwW7iO9qPn3EeSZ1AhAoNaK3xilm1lJnCNSf8zZICJ1K9DdU2MR+JnsuXV6QHlwtC7Wp/bDFNO0/qIzE9U7j+Pyb6JjJcuFZKKATrn9G9KlY=
Received: from MN2PR11CA0016.namprd11.prod.outlook.com (2603:10b6:208:23b::21)
 by IA1PR12MB6091.namprd12.prod.outlook.com (2603:10b6:208:3ed::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 07:01:49 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:23b:cafe::25) by MN2PR11CA0016.outlook.office365.com
 (2603:10b6:208:23b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Tue,
 29 Apr 2025 07:01:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Tue, 29 Apr 2025 07:01:48 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Apr 2025 02:01:46 -0500
From: ganglxie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, ganglxie <ganglxie@amd.com>
Subject: [PATCH] Add support for leagcy records in eeprom format V3
Date: Tue, 29 Apr 2025 15:01:21 +0800
Message-ID: <20250429070121.299873-1-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|IA1PR12MB6091:EE_
X-MS-Office365-Filtering-Correlation-Id: ac3bde87-a086-41a2-c0cf-08dd86ebb611
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BMRvznCQmAgoiKS4pY6LWvO2mMIXHBkJO+82ZJBwMmWcMtkIJU/ltGKd3MzG?=
 =?us-ascii?Q?EltDKm07XTXFmEojQksuywZsDdqFDV0GAapEA6RRBf7ZS0/GkuosfRWl9UYc?=
 =?us-ascii?Q?4h12vmEVw33XbnsZX3w3GWcFblb90A34D4QVxARcr8Ia7OCANPpO7fPXD4x3?=
 =?us-ascii?Q?EdS7SRvoEle/pplSP1PVzUVCd5aBJmkeKCe70SsUk5T6SfF6dwkVQUybOf11?=
 =?us-ascii?Q?/Iv0teRgGOBCtvv+SqpRmy9rn1MpLsbS5Xahd6lyQ2ueN6MWD2EQyFxrM3sZ?=
 =?us-ascii?Q?5Il25DkZeY5ZdT9xVh3ff1Ql7QLstZVhQHSDO/SB7VU7CyOxUrUMT/Flan09?=
 =?us-ascii?Q?vbwu6Mth8l8pKARhtpsNoUGFL+tudACmzYXsLA4LzvCwIWi4o1IlKo/lzCSM?=
 =?us-ascii?Q?p7df45hURHdI/b1uPJXT8gSK+RYCTYze6ksqhrvA7o+4ta+BMUejJ4tNb2eZ?=
 =?us-ascii?Q?IzAj9KNFDrMn06bYvzRo3HAh/ux16oPoDb/kBFdUffwHtwEReRkaNh+JzVIA?=
 =?us-ascii?Q?pUZ3b5hQLeV3aDD5Wg5mc2evz006+w9O0bMjqKTVhNPtlg/fCYJ9OWt2gsZS?=
 =?us-ascii?Q?TFPCqLCSMj7sDLF5BGrbtQUsX8yIKbyeZe0PpvMfENbm4UB6FgqHoVF+WmWm?=
 =?us-ascii?Q?3MvPQw90bJ9rPPAGA2Szhvv5/1vut2Ape/irF8s4SUv2M7abFvcQ+TM3nfBT?=
 =?us-ascii?Q?iuAE+csgJvDXepfKYOAjea6ppR0SVfBY3AlCPQ/DOukuT3v0wtdxUgwMYK+N?=
 =?us-ascii?Q?psZXXk/kTqgM0mYo5yQI8DMHJ8LPckTQft0EBLH9LrwOfe3O0vrlRGGWsPJ6?=
 =?us-ascii?Q?ZuwfkoikjWthL51YzewvrbOLFY07+c7I9T+/74U7YqWLBCWexD1FRKGZlIgP?=
 =?us-ascii?Q?rR2SVC7Bg2yGI/d0y2ZM1Et8EyYSDzusmx0QM1hZrwGjC4mGtgp7KMkbfhEf?=
 =?us-ascii?Q?VYIoOLh+u08ZZcC5zjmjzb/isF1dQQK4Nyz7gWOZClukuq0KRznAhR4+LTjv?=
 =?us-ascii?Q?wHXWliF/tFsBwR+neIUB70LvbTSwCDUv+35dZp+GJARGG4/IhjasijXdYmcC?=
 =?us-ascii?Q?V9/PZH2OuO4O1rACHNAfV7fCsGCoHkBtS8YeV6sYGja1YiuimjzB5EVYMMzQ?=
 =?us-ascii?Q?dqWDoR8qNStwOt4dYBK+Qi84OVjhQ7RLqH/DZ6vJ+cLJ7lnppH5/NM0oosVs?=
 =?us-ascii?Q?uiePBHu6rtFkMlXE3iWY92g58VD4FcnqwHS9xBs6NkijVHT8EHdn/c2Rv++S?=
 =?us-ascii?Q?0ZIAzWjzaSAvDK+NosJJ2v2EQGWfWyhiWUyQPnvW7fj2liz1+SLBqiimUlMi?=
 =?us-ascii?Q?gskhAIIytLwN6Zs3TBivCGGT+W/sNRjFE322MkFJS5xRq5bVVbeBI+vDu3hv?=
 =?us-ascii?Q?I5kqtWI6q2jMByPTlbHsB4mlNkjwvXNmvnAyfV+/+8LftK9Xw41tF9zAaaBA?=
 =?us-ascii?Q?GrBtHCcAz61rHSTL98rXJTy3FgygfWoClLE1Od4VlX3mNbWfRe3M8gbw57k5?=
 =?us-ascii?Q?2X5gHdb3SW0Q/8UGHiNY2D/38iNwMoV4RC79?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 07:01:48.6082 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3bde87-a086-41a2-c0cf-08dd86ebb611
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6091
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

After eeprom records format upgrades to V3, records that have 'address == 0' should be
supported in NPS1

Signed-off-by: ganglxie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 73 ++++++++++++++++---------
 1 file changed, 48 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index e85143acf3a2..4f4e12452ecc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2881,6 +2881,17 @@ static int __amdgpu_ras_convert_rec_from_rom(struct amdgpu_device *adev,
 	save_nps = (bps->retired_page >> UMC_NPS_SHIFT) & UMC_NPS_MASK;
 	bps->retired_page &= ~(UMC_NPS_MASK << UMC_NPS_SHIFT);
 
+	/* if address== 0, the rec must be a PA rec under NPS1 */
+	if (bps->address == 0) {
+		if (nps == AMDGPU_NPS1_PARTITION_MODE) {
+			if (amdgpu_umc_pages_in_a_row(adev, err_data,
+				bps->retired_page << AMDGPU_GPU_PAGE_SHIFT))
+				return -EINVAL;
+			goto out;
+		} else {
+			return -EOPNOTSUPP;
+		}
+	}
 	if (save_nps == nps) {
 		if (amdgpu_umc_pages_in_a_row(adev, err_data,
 				bps->retired_page << AMDGPU_GPU_PAGE_SHIFT))
@@ -2889,6 +2900,8 @@ static int __amdgpu_ras_convert_rec_from_rom(struct amdgpu_device *adev,
 		if (amdgpu_ras_mca2pa_by_idx(adev, bps, err_data))
 			return -EINVAL;
 	}
+
+out:
 	return __amdgpu_ras_restore_bad_pages(adev, err_data->err_addr,
 									adev->umc.retire_unit);
 }
@@ -2903,7 +2916,7 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 			&adev->psp.ras_context.ras->eeprom_control;
 	enum amdgpu_memory_partition nps = AMDGPU_NPS1_PARTITION_MODE;
 	int ret = 0;
-	uint32_t i;
+	uint32_t i = 0;
 
 	if (!con || !con->eh_data || !bps || pages <= 0)
 		return 0;
@@ -2924,28 +2937,31 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 	mutex_lock(&con->recovery_lock);
 
 	if (from_rom) {
-		for (i = 0; i < pages; i++) {
-			if (control->ras_num_recs - i >= adev->umc.retire_unit) {
-				if ((bps[i].address == bps[i + 1].address) &&
-				    (bps[i].mem_channel == bps[i + 1].mem_channel)) {
-					//deal with retire_unit records a time
-					ret = __amdgpu_ras_convert_rec_array_from_rom(adev,
-									&bps[i], &err_data, nps);
-					if (ret)
-						goto free;
-					i += (adev->umc.retire_unit - 1);
+		/* there is no pa recs in V3, so skip pa recs processing */
+		if (control->tbl_hdr.version < RAS_TABLE_VER_V3) {
+			for (i = 0; i < pages; i++) {
+				if (control->ras_num_recs - i >= adev->umc.retire_unit) {
+					if ((bps[i].address == bps[i + 1].address) &&
+						(bps[i].mem_channel == bps[i + 1].mem_channel)) {
+						/* deal with retire_unit records a time */
+						ret = __amdgpu_ras_convert_rec_array_from_rom(adev,
+										&bps[i], &err_data, nps);
+						if (ret)
+							control->ras_num_bad_pages -= adev->umc.retire_unit;
+						i += (adev->umc.retire_unit - 1);
+					} else {
+						break;
+					}
 				} else {
 					break;
 				}
-			} else {
-				break;
 			}
 		}
 		for (; i < pages; i++) {
 			ret = __amdgpu_ras_convert_rec_from_rom(adev,
 				&bps[i], &err_data, nps);
 			if (ret)
-				goto free;
+				control->ras_num_bad_pages -= adev->umc.retire_unit;
 		}
 	} else {
 		ret = __amdgpu_ras_restore_bad_pages(adev, bps, pages);
@@ -3040,21 +3056,28 @@ static int amdgpu_ras_load_bad_pages(struct amdgpu_device *adev)
 		dev_err(adev->dev, "Failed to load EEPROM table records!");
 	} else {
 		if (adev->umc.ras && adev->umc.ras->convert_ras_err_addr) {
-			for (i = 0; i < control->ras_num_recs; i++) {
-				if ((control->ras_num_recs - i) >= adev->umc.retire_unit) {
-					if ((bps[i].address == bps[i + 1].address) &&
-						(bps[i].mem_channel == bps[i + 1].mem_channel)) {
-						control->ras_num_pa_recs += adev->umc.retire_unit;
-						i += (adev->umc.retire_unit - 1);
+			/*In V3, there is no pa recs, and some cases(when address==0) may be parsed
+			as pa recs, so add verion check to avoid it.
+			*/
+			if (control->tbl_hdr.version < RAS_TABLE_VER_V3) {
+				for (i = 0; i < control->ras_num_recs; i++) {
+					if ((control->ras_num_recs - i) >= adev->umc.retire_unit) {
+						if ((bps[i].address == bps[i + 1].address) &&
+							(bps[i].mem_channel == bps[i + 1].mem_channel)) {
+							control->ras_num_pa_recs += adev->umc.retire_unit;
+							i += (adev->umc.retire_unit - 1);
+						} else {
+							control->ras_num_mca_recs +=
+										(control->ras_num_recs - i);
+							break;
+						}
 					} else {
-						control->ras_num_mca_recs +=
-									(control->ras_num_recs - i);
+						control->ras_num_mca_recs += (control->ras_num_recs - i);
 						break;
 					}
-				} else {
-					control->ras_num_mca_recs += (control->ras_num_recs - i);
-					break;
 				}
+			} else {
+				control->ras_num_mca_recs = control->ras_num_recs;
 			}
 		}
 
-- 
2.34.1


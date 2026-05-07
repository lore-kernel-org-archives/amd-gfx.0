Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9EE3CD3439
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2026 14:45:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 670FA10F18C;
	Thu,  7 May 2026 14:45:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CBDlOYQd";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010001.outbound.protection.outlook.com [52.101.85.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7FDA10F182
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2026 14:45:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LP5CRKufIfKgoQ6wFlLgvp1u4AJs/ItJMpmL8T2LCVCYQDPlZGkWOW1zx15qaCNZTKzv0Cy/RNbXgjSeozekt0JR0QrfEXGxVzg9BruDyTAQRryqllQMIivunICs6yMLOxXGJpqkmrd4MvC7ohxKtXsr/flMn3I/WOCf+vnqHnZj9M9cc1o5Or26Pu5Mg68tDWwVYltTeegv8gvXJY4B+kLxRW25ykpTaiBiIpXcAmoPn2uZi8ZmO/Go0dVczkStt92QBjXJ62A7loFyjT3uxaeVZERDULivJ+5IL+OS0XJB8OixropjHPthKkf3/cwiaCWtwq8ubfoK7AUPcxLq3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xbr3Oq1Er+5xpI0+3rRSywVwCp9fKUoQBJKnVRU+0jA=;
 b=IaTLxxR87VW0AlS+fgc2etEaFh+fqSce1jEb5o44a/PfqlIubK2polc1/062MkTnoi/2Di1UPV4uSpkxKfnHadZaGsaGCoOQtDI16ysYwXPpOBguOU3X/kUwpXVD60tsx+s6Q5/ki4WByxRtCSx24TacfSTniIpkd44j+VZxHbu0hjOmo6uEXAZkFVKc/Nt0ZzQQUQlrHTmFvq6HsLkowhw3gdLu/i1HNK5KoPpAhV45AiqkGEjGAFu20SpNjjeeZlotjUKk76ca+n6gJcQvjAWj6MvsSZMAkWC0BDAxY4pBkCthWumuf8aks8N8idtxjPrrhRVc77cWB+W3/Cuwig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xbr3Oq1Er+5xpI0+3rRSywVwCp9fKUoQBJKnVRU+0jA=;
 b=CBDlOYQddbxM6W+99JxYri1cgR/q3sHX6NZp5oZFTlHgC93AP5Q4t2GMGoeSYv26BW0RtrTMn5MYEg+4BufUkQvBeCBGYe0m5qRvz27W1EL5FCKWz3ynE5f5MvdP4BKh9HLZYIV/5D62c1U+WoPvA9nHwUrRNVBoSTNzAMehe3A=
Received: from BN9PR03CA0887.namprd03.prod.outlook.com (2603:10b6:408:13c::22)
 by CH3PR12MB8755.namprd12.prod.outlook.com (2603:10b6:610:17e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Thu, 7 May
 2026 14:45:01 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:408:13c:cafe::da) by BN9PR03CA0887.outlook.office365.com
 (2603:10b6:408:13c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.18 via Frontend Transport; Thu,
 7 May 2026 14:45:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 14:45:00 +0000
Received: from MKM-D1-FRANKSU9.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 7 May
 2026 09:44:54 -0500
From: Chenglei Xie <Chenglei.Xie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <jeffrey.chan@amd.com>, <zhigang.luo@amd.com>,
 <alexander.deucher@amd.com>, <chenglei.xie@amd.com>
Subject: [PATCH] drm/amdgpu: bound bad-page list writes to allocated capacity
Date: Thu, 7 May 2026 10:44:49 -0400
Message-ID: <20260507144449.25778-1-Chenglei.Xie@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|CH3PR12MB8755:EE_
X-MS-Office365-Filtering-Correlation-Id: 458fa143-7855-405c-d3dd-08deac47376a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8k/ERd45wLfSF9MhoT/b3m7Eh+3t/erMZebprC7XEWJnPjWdD+tc6Yhui5pPTUkdRBGeIBLJbU5OUFELjc4beGlOYrGY6MzbW6T4szXBeP6TKEpe0sSHoKFwQ9yac9kXcpdeOmxJzbnP63s6qMitqOTIcZmkAl8Tgxe9AL2uAURDxT2KmfL+3TqzZeiWuu9QLFeQMRRtIaG7O1uuCeb1sa87hphmmvFp1HB/mgKgmd5wrY7fXS1Qoyz+v9M2CvdvE8D7eEjN5laIbP1GXz7jK6vkMeFzan3nbw7OZ1UzMwf9OhcLR0B//A/3jqCpWGDZ8ByA9utgs23+euFhqRsg5IEAjQv/z/amoutd+i8Y3Wm0vKKQHDe/N7SLGx3nCai2eTTWE9ffnJjhnWHzR1FDBWVSibJyqwFIlT6xH2SZSLDQbMb6msyPw/RgTuNQe8aJjKejxPrWpX8e/CquX80iijx6zQ87iQfmT6/PJVhXZayh6YlOt2d1Z+kQGKpWELZZ7recyxE9SF3JRb84SPXhNOTfwRLxvB3w7iELEYKiCKmR3wYSekXCAVLP4DgZjrYAEU/NBsmEU6sli1bpyzHHebq8+ieehqvflVuN9XATqIX1496jkfAa1t8oP3nrmX2zH7waTQiFnWo7jDqskDJyO+5ZJYzt0lnPelAu5K7NmTceXKUu/KD7RHVkOEOu5UjiPmM/7RfsVv4kzAvaZVC/yxRPZ1tHCpr/8gO0cpnnKfc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RrJ0xPiGNCqQmAdd16vAHkuSIXe7UitM7vzQmWk3rd4L2cJNfylYTjwY59Paq0Cs4i48BNkYU+vi/ZvhG2hLVM/e/DFnHMgP8PBj0lNU6ASJ70VPXcPEZTRP7zYbBqIaDBIANw3zEPgGWLhM4r/Kjb7sfZ4C1G72vw2RzpBq7Ej79cvqILkxOn5v0y6q0g3hD6YQ6TgR01MpQKedbRntk8/nYu6HGFzCqPd46GI5Gjtt4tH13hd99OgyayrMoCt+yV8MqZXgJeHlvwEKKji0QYQGAAct2te4u6tSiKH+vLRjcdBBtW1pmpkaS2UQgpAVULXtrCeLRuo8sN92xmplnP6om9s8GvsOpzbLfqPewXy+xyvagkj2DRVDtky9Amj9QM5hcEWGPVQX1pYWBsrg1CY2f6fpfm4IAelm7zUdr9bPsc2UPrCliXs6svbj7ELu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 14:45:00.5153 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 458fa143-7855-405c-d3dd-08deac47376a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8755
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

PF2VF bad-page data can provide more entries than the VF-side bad-page buffer can hold. amdgpu_virt_ras_add_bps() copied entries without checking remaining capacity, which can overrun the 512-entry allocation.

Add an explicit max bad-page constant, validate pages against remaining space before memcpy(), and make the helper return bool so the caller stops processing when the buffer is full. This preserves normal behavior while preventing overwrite from malformed or malicious input.

Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
Change-Id: I924d2b5e369bef007eb1577f287a2274ec83d5a9
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 53 +++++++++++++++---------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 6974b1c5b56c2..8ac808d70356c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -283,14 +283,12 @@ unsigned int amd_sriov_msg_checksum(void *obj,
 	return ret;
 }
 
+#define AMDGPU_VIRT_RAS_MAX_BAD_PAGES 512
+
 static int amdgpu_virt_init_ras_err_handler_data(struct amdgpu_device *adev)
 {
 	struct amdgpu_virt *virt = &adev->virt;
 	struct amdgpu_virt_ras_err_handler_data **data = &virt->virt_eh_data;
-	/* GPU will be marked bad on host if bp count more then 10,
-	 * so alloc 512 is enough.
-	 */
-	unsigned int align_space = 512;
 	void *bps = NULL;
 	struct amdgpu_bo **bps_bo = NULL;
 
@@ -298,11 +296,14 @@ static int amdgpu_virt_init_ras_err_handler_data(struct amdgpu_device *adev)
 	if (!*data)
 		goto data_failure;
 
-	bps = kmalloc_array(align_space, sizeof(*(*data)->bps), GFP_KERNEL);
+	/* GPU will be marked bad on host if bp count more then 10,
+	 * so alloc 512 is enough.
+	 */
+	bps = kmalloc_array(AMDGPU_VIRT_RAS_MAX_BAD_PAGES, sizeof(*(*data)->bps), GFP_KERNEL);
 	if (!bps)
 		goto bps_failure;
 
-	bps_bo = kmalloc_array(align_space, sizeof(*(*data)->bps_bo), GFP_KERNEL);
+	bps_bo = kmalloc_array(AMDGPU_VIRT_RAS_MAX_BAD_PAGES, sizeof(*(*data)->bps_bo), GFP_KERNEL);
 	if (!bps_bo)
 		goto bps_bo_failure;
 
@@ -361,17 +362,27 @@ void amdgpu_virt_release_ras_err_handler_data(struct amdgpu_device *adev)
 	virt->virt_eh_data = NULL;
 }
 
-static void amdgpu_virt_ras_add_bps(struct amdgpu_device *adev,
-		struct eeprom_table_record *bps, int pages)
+static bool amdgpu_virt_ras_add_bps(struct amdgpu_device *adev,
+		const struct eeprom_table_record *bps, int pages)
 {
 	struct amdgpu_virt *virt = &adev->virt;
 	struct amdgpu_virt_ras_err_handler_data *data = virt->virt_eh_data;
 
 	if (!data)
-		return;
+		return false;
+
+	if (pages > AMDGPU_VIRT_RAS_MAX_BAD_PAGES - data->count) {
+		dev_warn_ratelimited(adev->dev,
+				     "RAS WARN: bad page buffer full, count=%d pages=%d max=%d\n",
+				     data->count, pages,
+				     AMDGPU_VIRT_RAS_MAX_BAD_PAGES);
+		return false;
+	}
 
 	memcpy(&data->bps[data->count], bps, pages * sizeof(*data->bps));
 	data->count += pages;
+
+	return true;
 }
 
 static void amdgpu_virt_ras_reserve_bps(struct amdgpu_device *adev)
@@ -443,20 +454,22 @@ static void amdgpu_virt_add_bad_page(struct amdgpu_device *adev,
 
 	memset(&bp, 0, sizeof(bp));
 
-	if (bp_block_size) {
-		bp_cnt = bp_block_size / sizeof(uint64_t);
-		for (bp_idx = 0; bp_idx < bp_cnt; bp_idx++) {
-			retired_page = *(uint64_t *)(vram_usage_va +
-					bp_block_offset + bp_idx * sizeof(uint64_t));
-			bp.retired_page = retired_page;
+	if (!bp_block_size)
+		return;
 
-			if (amdgpu_virt_ras_check_bad_page(adev, retired_page))
-				continue;
+	bp_cnt = bp_block_size / sizeof(uint64_t);
+	for (bp_idx = 0; bp_idx < bp_cnt; bp_idx++) {
+		retired_page = *(uint64_t *)(vram_usage_va +
+				bp_block_offset + bp_idx * sizeof(uint64_t));
+		bp.retired_page = retired_page;
 
-			amdgpu_virt_ras_add_bps(adev, &bp, 1);
+		if (amdgpu_virt_ras_check_bad_page(adev, retired_page))
+			continue;
 
-			amdgpu_virt_ras_reserve_bps(adev);
-		}
+		if (!amdgpu_virt_ras_add_bps(adev, &bp, 1))
+			break;
+
+		amdgpu_virt_ras_reserve_bps(adev);
 	}
 }
 
-- 
2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 981D8CD4851
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2026 14:44:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 365FF10EB34;
	Tue, 12 May 2026 14:44:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GsUKQ3lQ";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010024.outbound.protection.outlook.com [52.101.61.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1009A10EB34
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 14:44:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FF7FcaScbW3U4di74FTGiwV2nyC1UbLkQ00uv2/u6gSV9/palPaxmQmYZ8UZPhu8ay0C7sZ33w2N59yoiFrmja9uEcgzoo8BnxOY1aHmMY3ukPvL0y/GBGxoJJoJ/xN63p0YeKhXs1qkudQoAWz9aiF2ALBRhgwwtRHBEVVMkzkfrDw0fQ+4qonTLdl78cm3PzXDuSQpOvo029gRLEkX9S8aIAeiPAEqIwRMDL2eWv1m7LHVBn51NihVU4u8w8FvllNfzpyY3lnMUPoa7FKjhy1FwIotq+rwx/S8KijQEnGVLNxeYT9jGpEVvLUvfHpV/xUjvCO7ook0JVnMeDylJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0kwo7pEB255oKgxuoC1Hv3lp0ROsrtD7Iib2q7/koA=;
 b=RGsSod7JM6QQYBViyxhTjOsAhDCtZwWbLyp5+yrSgnKq4/luWSzSyNPLofoVByNf/qwedva6p0SJY8GLdz7oLPdJRmpd27jMdfD4xC9YDy/AA/TwvCAVJr+z6bvBNfj8t9K4HIMhHQm1ADoVxqwDcpbUFR550fhRZ33JTCGk/jSHCCQ232u9ImZcCKUgEYEB3oNCCBkYk6CCNJg9L+4YTbmquCqAaWVBXukzKr++ZjWCNI6iEV1M5FiW+wejQUpQZ66YQq5xywTREvolfLHp9+Eav93yDNPsbZcPFR6VscG2vQuzV1VAXZ1F1DjnVfJL8gVLRAjjDbmF63bmp52m1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0kwo7pEB255oKgxuoC1Hv3lp0ROsrtD7Iib2q7/koA=;
 b=GsUKQ3lQwTU3z09y2zgG0DmGl0rUNefkPwSVRhPpaz04xXVoJmFS8A0ffHxZJhbwxUsczluEsahfQHZBgd4KNU3glY+Tk0mc7YEhWjlsaykjci43KmVNDf1gwoR14eg4CN5eMPSCx5SsW3Ulayi3SIi5Tm9DslHoIL08J+CEOvg=
Received: from BLAPR03CA0100.namprd03.prod.outlook.com (2603:10b6:208:32a::15)
 by SJ2PR12MB7797.namprd12.prod.outlook.com (2603:10b6:a03:4c5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 14:44:38 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:208:32a:cafe::c2) by BLAPR03CA0100.outlook.office365.com
 (2603:10b6:208:32a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.11 via Frontend Transport; Tue,
 12 May 2026 14:44:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 14:44:37 +0000
Received: from MKM-D1-FRANKSU9.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 12 May
 2026 09:44:35 -0500
From: Chenglei Xie <Chenglei.Xie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <jeffrey.chan@amd.com>, <zhigang.luo@amd.com>,
 <alexander.deucher@amd.com>, <chenglei.xie@amd.com>, <YiPeng.Chai@amd.com>
Subject: [PATCH v3] drm/amdgpu: change VF RAS bad bage space to dynamic
 allocation
Date: Tue, 12 May 2026 10:44:29 -0400
Message-ID: <20260512144429.213175-1-Chenglei.Xie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260508180705.217683-1-Chenglei.Xie@amd.com>
References: <20260508180705.217683-1-Chenglei.Xie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|SJ2PR12MB7797:EE_
X-MS-Office365-Filtering-Correlation-Id: 41194090-8d3a-4f48-9c90-08deb034fdd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info: lHssT5qugw6BGGH1CaryxU5dqnpiVdVepd3rrhs83EgC0omb15GKzcYInAzqcUID05Txw6K6t6Lsa5l0YCEGxBNaR/K4R7H2cUuEpA5e1xzmJvzi4wnb6QoEpTs9W4kledV0jyHOOwckjWjYBOcVq4/FTsI8XdZ8r8JyEGvSU3y8L8+9wbr+cTTU7TPCV0mk0DNoMIPYFLEGBLL5jgi+jR8PT9xg4TJ0zn9jDOS5GqQ8ED9A1lkG0g6V7a6unLOmf/JxsvGMlx9xUI1h8dHbCy0hlSYMKRmfO3sz2TUjaF0UrPdBaTdu3jRria+1mDiNPPGzzWsu17WAqABwCHM0Up7n2SMlZB1eJ6CzmJIfq4iOkyXbwJB7vjNwtfpPvCYwAL2stBVHnegjILZsTQZGjROZ78BowRsVVdF34CD+hX7AHlI1VbgJTbX9b9acaU9pYH059dtaQMfnRvD2vXzY0GxTA5jpOqvuOtdpao3krLDeHSAP/xNwBKCFi0V7MaUiibaYy1+TTV/PXgwL8LXN2ujEYk3GS76jYs5TB2HYLxz4jcNS7hgOQjfnIv6VmiyCKHb62y4uGqvE93AL7uC4vX+qCHwvnXbP6AWRmFAeJbfa5oz8kzYj8iT69EQZX99a8qaZ+D4pPvix7+6U1IavrRwVAc8T71nkRoL4JlTuksr1YTZUaqwr1T90BKX2t24icpg/G7bh2HwW2y3JZEzCeV+oyvxK9FIyj8w+MbLE5DU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(56012099003)(22082099003)(18002099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uRD99bQDck+8QcvThbkSzKRJWjSpk7DGJMwwwnqZmF/F5doFL44JWe4RN1YUwskhKYCWW5FxfMJ49m0BQKBc511NPrJp6PA6GmD53K/lSqhASU+qAk+ML0Fk/+KmYuDXiMsbuAAxm3NlQ23U2zd8pjfpKFTvtUo717mW9581YE7BxPTGg7Isbkt6W64JKIigSK8knsxBCPdfIl5qo5VyfwZn4fmNmRqCco24akJWAHFuQuiCz5Cavu/XGxj9NuNSZlhjIOqUJUi0JdW/blG3U4yvZXAMONlxdnsfGf4EHUJLUbpntXN//XwjoBxXKuMljDyg8Z7DfjJgxPtLTwzDl+AOamC9cEcST++u0Klcv1PS1LvsMYA+ed6U3KSkjhtSyO84EMBSOES63N+jWHVNvBSZZFDrnucdxL5swMdrDje/zFsDk+e/4Q7uNRz8B+Ty
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 14:44:37.6255 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41194090-8d3a-4f48-9c90-08deb034fdd6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7797
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

The VF RAS error handler stored bad pages in fixed-size arrays. If the
PF2VF block described more entries than fit, amdgpu_virt_ras_add_bps()
could memcpy past the end of those arrays.

Track table length in a capacity field, allocate a small initial table,
and grow bps / bps_bo together when count + pages would exceed capacity.
Keep amdgpu_virt_ras_add_bps() as the single append path: validate the
addition, grow if needed, then memcpy and bump count.

On allocation failure the existing tables are left unchanged and the
caller stops ingesting more bad pages from the message.

Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 109 ++++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |   2 +
 2 files changed, 90 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 6974b1c5b56c2..beb2693e4c704 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -283,14 +283,63 @@ unsigned int amd_sriov_msg_checksum(void *obj,
 	return ret;
 }
 
+#define AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_INIT_CAPACITY	512
+
+/**
+ * amdgpu_virt_ras_realloc_eh_data_space - alloc/realloc VF bad-page @data->bps and @data->bps_bo
+ * @adev: amdgpu device
+ * @data: VF RAS error-handler data
+ * @pages: minimum number of new slots to add beyond @data->capacity
+ *
+ * Return: 0 on success, %-ENOMEM on failure.
+ */
+static int amdgpu_virt_ras_realloc_eh_data_space(struct amdgpu_device *adev,
+		struct amdgpu_virt_ras_err_handler_data *data,
+		int pages)
+{
+	struct eeprom_table_record *new_bps;
+	struct amdgpu_bo **new_bo;
+	unsigned int old_space;
+	unsigned int new_space;
+	unsigned int align_space;
+
+	old_space = (unsigned int)data->capacity;
+	new_space = old_space + max_t(unsigned int, (unsigned int)pages,
+				      (unsigned int)AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_INIT_CAPACITY);
+	if (new_space < old_space || new_space > INT_MAX)
+		return -ENOMEM;
+
+	align_space = ALIGN(new_space, AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_INIT_CAPACITY);
+	if (align_space > INT_MAX)
+		return -ENOMEM;
+
+	new_bps = kmalloc_array(align_space, sizeof(*data->bps), GFP_KERNEL);
+	new_bo = kcalloc(align_space, sizeof(*data->bps_bo), GFP_KERNEL);
+	if (!new_bps || !new_bo) {
+		kfree(new_bps);
+		kfree(new_bo);
+		dev_warn_ratelimited(adev->dev,
+				     "RAS WARN: failed to grow bad page table to %u slots\n",
+				     align_space);
+		return -ENOMEM;
+	}
+
+	memcpy(new_bps, data->bps, data->count * sizeof(*data->bps));
+	memcpy(new_bo, data->bps_bo, data->count * sizeof(*data->bps_bo));
+
+	kfree(data->bps);
+	kfree(data->bps_bo);
+	data->bps = new_bps;
+	data->bps_bo = new_bo;
+	data->capacity = (int)align_space;
+
+	return 0;
+}
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
 
@@ -298,16 +347,17 @@ static int amdgpu_virt_init_ras_err_handler_data(struct amdgpu_device *adev)
 	if (!*data)
 		goto data_failure;
 
-	bps = kmalloc_array(align_space, sizeof(*(*data)->bps), GFP_KERNEL);
+	bps = kmalloc_array(AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_INIT_CAPACITY, sizeof(*(*data)->bps), GFP_KERNEL);
 	if (!bps)
 		goto bps_failure;
 
-	bps_bo = kmalloc_array(align_space, sizeof(*(*data)->bps_bo), GFP_KERNEL);
+	bps_bo = kcalloc(AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_INIT_CAPACITY, sizeof(*(*data)->bps_bo), GFP_KERNEL);
 	if (!bps_bo)
 		goto bps_bo_failure;
 
 	(*data)->bps = bps;
 	(*data)->bps_bo = bps_bo;
+	(*data)->capacity = AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_INIT_CAPACITY;
 	(*data)->count = 0;
 	(*data)->last_reserved = 0;
 
@@ -361,17 +411,32 @@ void amdgpu_virt_release_ras_err_handler_data(struct amdgpu_device *adev)
 	virt->virt_eh_data = NULL;
 }
 
-static void amdgpu_virt_ras_add_bps(struct amdgpu_device *adev,
-		struct eeprom_table_record *bps, int pages)
+static bool amdgpu_virt_ras_add_bps(struct amdgpu_device *adev,
+		const struct eeprom_table_record *bps, int pages)
 {
 	struct amdgpu_virt *virt = &adev->virt;
 	struct amdgpu_virt_ras_err_handler_data *data = virt->virt_eh_data;
+	int need;
 
-	if (!data)
-		return;
+	if (!data || pages <= 0)
+		return false;
+
+	if (pages > INT_MAX - data->count) {
+		dev_warn_ratelimited(adev->dev,
+				     "RAS WARN: bad page table size overflow (count=%d pages=%d)\n",
+				     data->count, pages);
+		return false;
+	}
+
+	need = data->count + pages;
+	if (need > data->capacity &&
+	    amdgpu_virt_ras_realloc_eh_data_space(adev, data, need - data->capacity))
+		return false;
 
 	memcpy(&data->bps[data->count], bps, pages * sizeof(*data->bps));
 	data->count += pages;
+
+	return true;
 }
 
 static void amdgpu_virt_ras_reserve_bps(struct amdgpu_device *adev)
@@ -443,20 +508,22 @@ static void amdgpu_virt_add_bad_page(struct amdgpu_device *adev,
 
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
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 9da0c6e9b8695..af2acf8eee6e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -263,6 +263,8 @@ struct amdgpu_virt_ras_err_handler_data {
 	struct eeprom_table_record *bps;
 	/* point to reserved bo array */
 	struct amdgpu_bo **bps_bo;
+	/* number of slots in bps[] / bps_bo[] (always >= count) */
+	int capacity;
 	/* the count of entries */
 	int count;
 	/* last reserved entry's index + 1 */
-- 
2.34.1


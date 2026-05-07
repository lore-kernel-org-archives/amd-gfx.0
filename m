Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1681CD343B
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2026 14:41:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53D5810E2B0;
	Thu,  7 May 2026 14:41:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qT8AvoCb";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013035.outbound.protection.outlook.com
 [40.107.201.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E6BB10E2B0
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2026 14:41:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H6qchKfqjBaFOUzZpVkGKTA7Pr9xaOmp1mgMWOSRlXl63jvQRcobYHmc2Dac4wjzplyYRScXuLbb7GAZ7tOlgZJWYdlDNmQNOWWi0BlhnTxIT/vOmBlvKtgdeH5CMbXba5zhyhUejrYbt3PkIhL93wuqYS6uZCQTa9rrvxZbwggwIcSx1QBiPZqs++MIp3Vu73Ht9eqOkl1Ei34LfqSx8oDeAAWvsTPdbEIU7pK5T4ahGAhJq1ToQognf5lqtcrkWv6/bYeK74kvRoqN67aIOkt+Tp9OIUexp5p6htcNc8v2GxecJY312j8ZdDyAi7mesUnsFwAmFXilp/QSYY7UNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xbr3Oq1Er+5xpI0+3rRSywVwCp9fKUoQBJKnVRU+0jA=;
 b=iF0X6gEQlnClITBXiGeuPU34wfyWe89YgyyzQ+2xlWjM1g5fIgrdZq2GjadAIrhver6yvhdJWAyPxNLnEIDD14IPYpyAlMjCbNS0qgwS91Dw2ZLeLtRWn1rtKZM7GwpX/cRO+NBtBWDBykOCJ5Zwr40uEv/DPCDtb1VBfUQdX8kZ3G5CYoH8mQAiNvztgR+g2d/FZB6NOhOovXAtjD/3vE0dmIpVVO9LXn3aRQtnLk3Mhly+ncCVMeIK4gwbGVZil3YCCuXU7aDms1kNI4w74J53CkMTKiLbs/fsuTCsZ/m2PuamcII6KzwY4gbQ3n42mIMkAcbFmzb7PPyatoTc4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xbr3Oq1Er+5xpI0+3rRSywVwCp9fKUoQBJKnVRU+0jA=;
 b=qT8AvoCbXX3ynFSj3bMYvJSo6YEHJQHc6K4nyaO7aA3kjWe8isV0eR9uev/aIfZsReJlCujLfpDg9v6SdVWDsTcDUxyQAln8zvMWAjT/8TeC9ArfshN4+IYkzi50YyB9/uBJZQoIM43zixZGy4zZE90oes6oRLQX46Ra+fkyemw=
Received: from BYAPR21CA0016.namprd21.prod.outlook.com (2603:10b6:a03:114::26)
 by PH7PR12MB7164.namprd12.prod.outlook.com (2603:10b6:510:203::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Thu, 7 May
 2026 14:41:45 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::a4) by BYAPR21CA0016.outlook.office365.com
 (2603:10b6:a03:114::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.7 via Frontend Transport; Thu, 7
 May 2026 14:41:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 14:41:44 +0000
Received: from MKM-D1-FRANKSU9.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 7 May
 2026 09:41:37 -0500
From: Chenglei Xie <Chenglei.Xie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <jeffrey.chan@amd.com>, <zhigang.luo@amd.com>,
 <=alexander.deucher@amd.com>, <chenglei.xie@amd.com>
Subject: [PATCH] drm/amdgpu: bound bad-page list writes to allocated capacity
Date: Thu, 7 May 2026 10:41:31 -0400
Message-ID: <20260507144131.24922-1-Chenglei.Xie@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|PH7PR12MB7164:EE_
X-MS-Office365-Filtering-Correlation-Id: 59544a87-8da7-4431-ca47-08deac46c2cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5BYFQ+mAqcBk9t9/v47/PrNwomgIKsT0jE3wd+OYraiRpZWZzWlhVITPK5kXT1iArpjaekG6kJoTMtcI9DrB3QmgYX9HJxQX3OjgRTE08M3WOVwHf5jX1duYJjrdNSV7WDCTabIS4E9IFYxhJcINDgDkDfK1dTcW4feXaos039eTgHvpO+hS5teGtgLeaoBy5OGZmFIaoDV9BtFeLEbmW0Fr4JvqAp8mkMV1DrNiLvW+D418saXBMfEpk/f1yQifruMkd2axmoULpJYCoV6ZY5/+BmWsRjfEmS0K3z04rUp/nG7z9c6MWXmFFHHSCZdhGruszbjxv+kLLhQTXk/lnkXbRkNgX9YpCnnHN5PEFL5NZ4QHhmHi0GIPZb22Bv3ouyJqyp/c43WFoJh5cb8N4h+oibRfGxTw0+TCJ5LMU6bfgduxzhKxLnFlf5/aX8J2Q9dxikRG2/ikkzElguArLW79n+QVaWzrIFJPrGayzo6OcbNKsKwHsuKwFGI0AtMIPz0cwi9xlXgqSTUvSrOfBN8IvC7kmuDmkBqR4LAmhniGhtIIZK4pJkmdc/n3aM6L+A8Xsx9CNx1Qr5gzYdQsnIZJwHoDiTOLz9ngwyYZZsXOnnnTgHrzQL65Yb9aVKYGLsCWu7HTyvDF9HIbRYQ2/ao3pnoIW5tsgOIsEB9EgPPTNJqTWfGTtaooEL7ggLZVJVdWp8QzVSMr+9JPZL6bhAIaKfbcRc3cDZbyrjfiJJo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ecuaHlesrlMRabXh/HE2UodqvuuDY59JXzDs81ZfH6kJTxMOnhs/0Zw8FVbu1ugALkJzBswUw6ZKOl+aTX9+HTFxxmyu2VGJdbIFMckz9ZdabNtAg1fEnw/jC7CfhgXeJkuyyBIEaSJdZhEhsWej8ReFfz5yAyUlc0NWKNvlHX9cnMiBJpxOr1i27VZhS+wC/ssOmo9YSMoe7ot1twW+x/Cn+rlXqGCqcOaCRHQ/kw6gKoDimtlKiDJ/hsKQ6+PWulvOXEEw1OiSBUQV05A547jMl3wVfJa5DTG81uPvzYUWx0d9kbMohTiOWetndlI40x3dVWMhBwL8LuiaTjjxUZr0EWfORRP9D/qCDfRzM7c/vy01/KQsdx4Ixi7D3TYNtlcrtwzHD4Jk3Yfx4mhtTDIs9xMN+1XlYaLBiutQzzFocMjO4qqh5+VNRFkObm79
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 14:41:44.7918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59544a87-8da7-4431-ca47-08deac46c2cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7164
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


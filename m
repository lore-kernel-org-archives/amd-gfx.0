Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 254D7CD98E2
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Nov 2025 21:08:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B25E110E940;
	Thu, 13 Nov 2025 21:08:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Nq3vhsUT";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010039.outbound.protection.outlook.com [52.101.85.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B06210E940
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 21:08:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rqFZ2ofWgadsjal/Cw+pgCdZFMBBWMDqhSjUniKccYJOqtKLsTE2ecn8TqiVrgcXvzfXh9F/ugkA67WgbxfG9U7VN4oH1OY5J9zYrQ9NfT2dmHvC3pQeTuqFXOxh+1yJFVY7uOGcdUfqCCYBkzI8ihtAYOHwaormzqFeuYWhyZBXOYox9tcUq2JLJYg8z8VRsBy8xqw0T5xkLo/ZrIoiQAIOmJVgeaIavo0Taw5EI2t2QtnnjZHJSAn/FDdJVrfu01u2+69tsQroitH6w7xN0oVTN0XTYo43qzRN2J8YUwgSqCRS7nDM82pKQTLSTIhJKrrUfSMyAlXiyXP336BWoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h58sM8SlGKEolKZBzxp6KIPCXBCA9VeLviHifWG1c8w=;
 b=tH1O/nuesn6ju//J3hHrRQK7iHoyDKde11/kX/VDyiY9OkXSASqqwyEb+gPcxwMXEkozL0SNHkmbS5wujqB9AM7mlZhrs0XhDXUlSYHBnGl9lUyvR64kaTJj20O8Pu1Cl1oO7m84LK/PmcKT6+TqCym/xUVvc4PGbEvLBZH9eQ4KNLL4PixZCGJqUYCd4Rj0axKWqqAJ8wmhxHGETxKDb59dcSf1p8qpN4P2uzgWyHVBJyNrpq0VdCEjxciiVO0Fl0+VZ/SX6U0OhHb7LE6hNIxgU02wlgIHSQ3qqRCkWd+wVN9ncB3uVqHwf1kuZ1LnhgxzJZ6/j2Ts1nA78+i8yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h58sM8SlGKEolKZBzxp6KIPCXBCA9VeLviHifWG1c8w=;
 b=Nq3vhsUTYWA2Ma97pRoxX5X6a3zYVQrYzt52cviUeYCV05GFL6YXAyPnvsVALP6JZxZqq3VvPMUHbtD1tDafnz2nR6IszHthT7+MtYOQRn6uwPUKZ78MxXXBav+ML6CYHdRz+3y1TyypI9SGRZgViXLzIfuRIFPOkCXrLbCPsyw=
Received: from CH0P223CA0009.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::35)
 by MN0PR12MB6296.namprd12.prod.outlook.com (2603:10b6:208:3d3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 21:08:28 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:116:cafe::30) by CH0P223CA0009.outlook.office365.com
 (2603:10b6:610:116::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 21:08:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 21:08:28 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 13 Nov
 2025 13:08:27 -0800
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Nov
 2025 15:08:27 -0600
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Thu, 13 Nov 2025 13:08:27 -0800
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH v2] drm/amdkfd: Use huge page size to check split svm range
 alignment
Date: Thu, 13 Nov 2025 15:09:55 -0600
Message-ID: <20251113210955.352373-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: xiaogang.chen@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|MN0PR12MB6296:EE_
X-MS-Office365-Filtering-Correlation-Id: a313f287-7815-4435-79ed-08de22f8cab8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mX9UROVkpsMkglu6/UYkj2BQtlE2SZoYOqGq4UqWDOLV6JN3xJON9JqovJ0Q?=
 =?us-ascii?Q?Pfv75EHlMQSfnK7iLoWU4O+vYX07jpqQHH1fRUhdmeVoCsmwUrPdcH4lt9kd?=
 =?us-ascii?Q?OEExGpZ6jQxCCVbw9dDrJAMeoSM2m2rpUa7zu44K+iUGZlBkYKWbw4upK11a?=
 =?us-ascii?Q?O/5BJaGfwTVAzRFw+hc+u3eQYzvR5q8Htzh0nKvCmvQjoOEaICj4iypt9WGw?=
 =?us-ascii?Q?pjd96xjVcNYh8YPi1nX00Al/5+FzN76GiCh3TXdnPn/pDSH8W7ilTDwtuA2i?=
 =?us-ascii?Q?8gYLvFR2IZz/RyhgVmk2jdgctnyKIMGoRwRRYuXojXczlKXsE+b5rMk92GY2?=
 =?us-ascii?Q?e+3cgLWFrUtbL/VBVdbepvWEdkGMyWHHf3uy73WZchLYVMtc2YFEw9Ob9zVz?=
 =?us-ascii?Q?pq7OpfdSRRnsO7+OvNv+0S1x6fTgfZIj0oMn7gRPcgMtAERL1VRogBTcvAhP?=
 =?us-ascii?Q?4xkDXGuAd9lUx+YIY8RK7Uww93fi2yuM13VUhS/BF1yun/CyusDtZLHDt2fX?=
 =?us-ascii?Q?7izBy2VrHA9YE/xltoxZFTJK0paaql1fWCFZD+Bl8T0O8KA6Ere1QH/HZiK7?=
 =?us-ascii?Q?lVUNmsZM5UB/DWeHP48SUXDFfXAZlBnJmVwzx4bxqim7T0i9JOJOkTIbxu6B?=
 =?us-ascii?Q?TQQm7tuQxuAnS1PLKrQ0knKmxemI4Mj7q+UOkIBv1tm74VHa3rfvsR2HIX7C?=
 =?us-ascii?Q?aXh7Mjjvmo4tci58Ex5tMfcmRSFcpEnM40j+WHVJjJbtQnhIQGtaJ7B6gzGp?=
 =?us-ascii?Q?n9DFz8N4zu8UDan4uJgqF3nX3vrOOZP489y/pufpjmiZYX9iRLM8f5UjfcxD?=
 =?us-ascii?Q?poFZkVbfB2Y0XKKcsIX/R4r1L6q4PrhbGIeF8xRd30XMvAgTOyVUWw5+NwEn?=
 =?us-ascii?Q?jq7hvTRx1+O52tJ3cRV9IYLsXquvl5hS9UlDpcS9gQFd6Izz++ek+Ji0dVm0?=
 =?us-ascii?Q?Y6SV7X9c0ShbcIkS+T0zsw6G1PDuPPIcT6A9ZMfc+bV6aLFR5g5YoppMoU3d?=
 =?us-ascii?Q?g8t2TYT/wSAFv9l+XWmanTcOw6LkotfloEe8zgZ8Lb4+Uhn/pqm89Vhsbh33?=
 =?us-ascii?Q?4yg79ybsck91Dl0cydlzgZ3NBUtPoQE3FA9a3tq3U736Jco7ZewezkH3aSRc?=
 =?us-ascii?Q?vhXPoiOWgXk1TlYXKVXtyP/ju7FA60qoF2Ycf2EousxVM4+R5GsxKH21eq9R?=
 =?us-ascii?Q?O/P+bQPKj5SREUvSqngJv5IqVkejfhKU66j0gAIzrSstXoVKzHPtFsz/YcOD?=
 =?us-ascii?Q?69QFiYApAqVsc7CMEt1L3/Adx77+cNCj6mtykZCdbUP+JtTigyEMs3bcEQK2?=
 =?us-ascii?Q?4pC2cAeLhECS16gClXOuArUf7hBryFF/Qya142zT9T4wGQ74q8RHcDFBp+C/?=
 =?us-ascii?Q?ZFQ55sdhGq4cfigfVO4hc/GGgc5KJ8BVEa3C5lpDx4Zyzseocy5fj9BRAa11?=
 =?us-ascii?Q?kokK3JYezlLvzCbdKqtLegUO9VUzPKg6OGYxp013+EIbvCW1Dor4rEHV83nL?=
 =?us-ascii?Q?amsxWqUVcoo42wrHFwMwLhu6kgg8jSIa2Vr73ushOWT7yulIw3XkTCf+TCG1?=
 =?us-ascii?Q?z3zP1uxbet6wm8LlUXY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 21:08:28.0990 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a313f287-7815-4435-79ed-08de22f8cab8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6296
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

From: Xiaogang Chen <xiaogang.chen@amd.com>

Fixes: 7ef6b2d4b7e5 (drm/amdkfd: remap unaligned svm ranges that have split)

When split svm ranges that have been mapped using huge page should use huge
page size(2MB) to check split range alignment, not prange->granularity that
means migration granularity.

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 521c14c7a789..c60d8134db45 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1146,11 +1146,14 @@ svm_range_split_tail(struct svm_range *prange, uint64_t new_last,
 {
 	struct svm_range *tail = NULL;
 	int r = svm_range_split(prange, prange->start, new_last, &tail);
+	bool huge_page_mapping = IS_ALIGNED(prange->start, 512);
 
 	if (!r) {
 		list_add(&tail->list, insert_list);
-		if (!IS_ALIGNED(new_last + 1, 1UL << prange->granularity))
-			list_add(&tail->update_list, remap_list);
+		if (huge_page_mapping) {
+			if (!IS_ALIGNED(tail->start, 512))
+				list_add(&tail->update_list, remap_list);
+		}
 	}
 	return r;
 }
@@ -1162,11 +1165,16 @@ svm_range_split_head(struct svm_range *prange, uint64_t new_start,
 	struct svm_range *head = NULL;
 	int r = svm_range_split(prange, new_start, prange->last, &head);
 
+	bool huge_page_mapping = IS_ALIGNED(prange->start, 512);
+
 	if (!r) {
 		list_add(&head->list, insert_list);
-		if (!IS_ALIGNED(new_start, 1UL << prange->granularity))
-			list_add(&head->update_list, remap_list);
+		if (huge_page_mapping) {
+			if (!IS_ALIGNED(prange->start, 512))
+				list_add(&head->update_list, remap_list);
+		}
 	}
+
 	return r;
 }
 
-- 
2.34.1


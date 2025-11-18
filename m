Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8504CCEE342
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Nov 2025 17:31:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2203510E501;
	Tue, 18 Nov 2025 17:31:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0LNECclJ";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010050.outbound.protection.outlook.com [52.101.201.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54BA610E501
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 17:31:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xm7+yhI6WPpf6voTfQ2ecPy1SMdVKZ9648M/S8YNo53ejyxrqEY7opbFcLTRPezyKDGXOyNsq7kk2y0XFmceiVZhij41OF54xa3EbOiZZ5KEhesRvX8E86JqyQB2khtglMVRAn3F/HX9+C1DFK480o9v3qotxopDe2nA93F/1T8M4nUCOiz/DYrWnpt0G3iKld+JHmQ97iz+yMiybou4ziRQn2N83PBK1Dpl+R6ECHFVGJndrJDUEpy0VAfaS74S/Hw7/1DrxBDvptTTJIqU2Ck9q1IYalSyizgS2/n+Y+gUjFS5Z20Kidj7emTMjrpAWB5meK0l5R9Sb8O5t+ATvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cf/+GjA795IKvSJC0dRCblQDkr0HA5f9Xo1R6FltRYw=;
 b=E0Z1DSTCEUruz/jOpquI9O+06cexKiPXkTqK/p6mwoTf5Vwcqkk0wuPlxXJ/mYsxOSXzK064MnO2eYhQvZDnJpy+Nxjwjf3m9xTUsAXsI3yYV3Mnw2okJ+5Z1yUi1g24sOpnOs3vxy2gjfMHBHpR1zQ3S0LdgfzuWUWFdeazsqaUGLQnVc1gFgz2gFdqj2SCVZWEDDovXaxJN+C+KR/Vb2wvYDzGfn6EPwsjba3EzICzxFgTtI/wdzJLX29b4t+fcUARr8P99u/xZF3k3db847cjlOZTeEy80P+TedOygWJjIqDvC9kkyC3hLvwcK6DF9UrbKw+oCfouIOuNxVv5gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cf/+GjA795IKvSJC0dRCblQDkr0HA5f9Xo1R6FltRYw=;
 b=0LNECclJya1gjDi4u0Hvv6Goo06Zkr2KSQ3PmAUDeGm46pBq3VHn08EJsHTOQpLu66S+W1tm0HRchoCfwlUVq8Zbj/mStyKXBJo8mRt78w/pOTlaCCED6iw51Xqh2HDoQXgmrsyyi2+XwBnsKneISe0YzpZg38iXFXAWbv7wmS0=
Received: from BL1P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::15)
 by DM3PR12MB9351.namprd12.prod.outlook.com (2603:10b6:8:1ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 17:30:56 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:208:2c5::4) by BL1P221CA0004.outlook.office365.com
 (2603:10b6:208:2c5::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Tue,
 18 Nov 2025 17:30:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 17:30:56 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 18 Nov
 2025 09:30:55 -0800
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Tue, 18 Nov 2025 09:30:55 -0800
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH v3] drm/amdkfd: Use huge page size to check split svm range
 alignment
Date: Tue, 18 Nov 2025 11:32:28 -0600
Message-ID: <20251118173228.1873433-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|DM3PR12MB9351:EE_
X-MS-Office365-Filtering-Correlation-Id: 808a0b8b-9705-4866-7d73-08de26c83b36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dnIpTJbAXmXdMhzbQDqEQuJwl1ZiI+kxcfWWnbCflEod+zyFAnZs0o67106L?=
 =?us-ascii?Q?RztRgOiyfdI9GMMAAQKxR+2JgA70ScJM/kX9Mv+1dzrFB3AxH9aYCvGc/1Nz?=
 =?us-ascii?Q?mIs2bdVVFcy6hlRMqe9ne0BXoLovHKau9wTBK0gPX24z6L5wSPT9scs3KgD6?=
 =?us-ascii?Q?U2XMK+Axafoge9HPtt2ffnPXMh42e0qEmIp6XYSOMnQNGXfAAI6wPeQ+KdGC?=
 =?us-ascii?Q?IRRRiNsVw3RE2GzTtaGRGT+HkWOlTC9hF2+H4O9CQRKb0M0t/YWwmI/JPqpL?=
 =?us-ascii?Q?kPZ0Ul/gJ8trwLo/IRyX/ydUGNXrO6IMHhuIftbwnY6E1Ycbeb8WtFY/klwH?=
 =?us-ascii?Q?5QWKiMpjhZ1N9jZNPrvnJrDv4UznuT4zPwIJmgKzH0g7duDopLYREEERat5k?=
 =?us-ascii?Q?7vmmh+0ZppquZ8Jfw0KiaFKIsMNKEGL1keWOhb3gZ/sg5+dnQxUBcJ322Tql?=
 =?us-ascii?Q?rpIHAQxqQOMw4wmybIuXEYnNgl95VtoMOCPYeGya5wFXU1uhPlk+W4Wogx/D?=
 =?us-ascii?Q?sRrhDnOv/9yIfgK22cjuMWIMvbJUhh8xgDioZuy0W42fAfnL1FWaFhlQx2TQ?=
 =?us-ascii?Q?IJHCrNwYxyCbXtGQ60mEfInXXlk77ZOLBSaAJccqZ5113G8Lmgwcy4972fBq?=
 =?us-ascii?Q?GoWJuS2jeWJyeb1N3ocgGnmrOkDALgiXn3UvQM6bKokPwgjCvspr0b2JLBFk?=
 =?us-ascii?Q?L6AujiOjkoyY0zdwvfGNFH5/w7CMA0mgRTYHLS40BH0yW6ll5h2W+DbIcvTo?=
 =?us-ascii?Q?4Ugs8UNudF6+ABjjO3FSUil3iM1KpI41jEYzyykBYTT6ggKka/9kh812Qemj?=
 =?us-ascii?Q?vPkBO2qlWbiIWF355Oz58u83KWH3aK/+eL+OHtNdPQG8lvSBn1jphXcisSma?=
 =?us-ascii?Q?/NHFlY4RYFHlh/q9Dc/KQGM/NjbFlq/Qf39sUl/yxfAYcaMgjJ+wWpxJwhqv?=
 =?us-ascii?Q?U5900ciLDwiByuv7+v+3Akscj8SLKUyYv9T0eOX/FkjI48xeO2FhC03lgH0U?=
 =?us-ascii?Q?QKAGe6vYro3CT4/G+c3K3/MOml6F8RxTZMH/C7jghz1x1xMZnIU7pEPNryze?=
 =?us-ascii?Q?PrOTZduMNyY05o7qqgJ/4a9pxUJOw/ZvyOgBKqtchBrY+UrF1bIjcAR/NzG7?=
 =?us-ascii?Q?skG4afkweFbGfmjbOBk/O2lKXwpIofORxySwFvgXaJ0D96On7fYmtd0ZXUVK?=
 =?us-ascii?Q?5D547TedfkMqIl2dD6GBAndEuXjz55LBvlxj/DnNNgOOj44AQRABRAvc/goM?=
 =?us-ascii?Q?fTpPqAvTuUqYCSDu7MSKl7kLmGriALaLPJPymWs3b9TL0obTNq8HFSj8F0en?=
 =?us-ascii?Q?kgc+oqh3dyNHJus198UjoyPT/uJa/9KdsyrBNmwQm/X2f+6dnMfaMGZ8vW52?=
 =?us-ascii?Q?RfxDTORxOYyNMV6O3CShGUP11c3yd1QkJFOYYWSmj2mg6p9C0s5Ln7PFUmIZ?=
 =?us-ascii?Q?34aFytqO2Hy7yOG9dJlA7+2Iv6/3FAetyMcpazt95n8dWRPQ7EF8x88BGFl9?=
 =?us-ascii?Q?aDC0rLnVP5+oAwMWtcZnD0PNXB59ufbO9KVjzyzGqiL94DYwzxzveOwNP8FV?=
 =?us-ascii?Q?cGvQxWI/mAoSOoYXI/E=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 17:30:56.1498 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 808a0b8b-9705-4866-7d73-08de26c83b36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9351
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

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>:
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 63 ++++++++++++++++++++++++++--
 1 file changed, 59 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 521c14c7a789..7bb94555e5f9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1145,12 +1145,39 @@ svm_range_split_tail(struct svm_range *prange, uint64_t new_last,
 		     struct list_head *insert_list, struct list_head *remap_list)
 {
 	struct svm_range *tail = NULL;
+	unsigned long start_align = ALIGN(prange->start, 512);
+	unsigned long last_align_down = ALIGN_DOWN(prange->last, 512);
 	int r = svm_range_split(prange, prange->start, new_last, &tail);
+	bool huge_page_mapping = (last_align_down > start_align) &&
+				 (last_align_down - start_align) >= 512;
 
 	if (!r) {
 		list_add(&tail->list, insert_list);
-		if (!IS_ALIGNED(new_last + 1, 1UL << prange->granularity))
-			list_add(&tail->update_list, remap_list);
+		/* original prange has huge page mapping */
+		if (huge_page_mapping) {
+
+			/* tail->start is inside huge page mapping but not 2MB aligned
+			 * or tail size is smaller than 512 pages
+			 */
+			if (tail->start >= start_align && tail->start <= last_align_down &&
+				(!IS_ALIGNED(tail->start, 512) ||
+				(tail->last - tail->start) < 512)) {
+
+				list_add(&tail->update_list, remap_list);
+				return 0;
+			}
+
+			/* tail->last is inside huge page mapping but not 2MB aligned
+			 * or tail size is smaller than 512 pages
+			 */
+			if (tail->last >= start_align && tail->last <= last_align_down &&
+				(!IS_ALIGNED(tail->last, 512) ||
+				(tail->last - tail->start) < 512)) {
+
+				list_add(&tail->update_list, remap_list);
+				return 0;
+			}
+		}
 	}
 	return r;
 }
@@ -1160,13 +1187,41 @@ svm_range_split_head(struct svm_range *prange, uint64_t new_start,
 		     struct list_head *insert_list, struct list_head *remap_list)
 {
 	struct svm_range *head = NULL;
+	unsigned long start_align = ALIGN(prange->start, 512);
+	unsigned long last_align_down = ALIGN_DOWN(prange->last, 512);
 	int r = svm_range_split(prange, new_start, prange->last, &head);
+	bool huge_page_mapping = (last_align_down >= start_align) &&
+				 (last_align_down - start_align) >= 512;
 
 	if (!r) {
 		list_add(&head->list, insert_list);
-		if (!IS_ALIGNED(new_start, 1UL << prange->granularity))
-			list_add(&head->update_list, remap_list);
+
+		/* original prange has huge page mapping */
+		if (huge_page_mapping) {
+			/* head->start is inside huge page mapping but not 2MB aligned
+			 * or head size is smaller than 512 pages
+			 */
+			if (head->start >= start_align && head->start <= last_align_down &&
+				(!IS_ALIGNED(head->start, 512) ||
+				(head->last - head->start) < 512)) {
+
+				list_add(&head->update_list, remap_list);
+				return 0;
+			}
+
+			/* head->last is inside huge page mapping but not 2MB aligned
+			 * or head size is smaller than 512 pages
+			 */
+			if (head->last >= start_align && head->last <= last_align_down &&
+				(!IS_ALIGNED(head->last, 512) ||
+				(head->last - head->start) < 512)) {
+
+				list_add(&head->update_list, remap_list);
+				return 0;
+			}
+		}
 	}
+
 	return r;
 }
 
-- 
2.34.1


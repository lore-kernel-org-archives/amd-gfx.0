Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94453C021AA
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 09:24:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F99610E22D;
	Fri, 21 Feb 2025 09:24:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2KO9R9IP";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B828810E22D
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 09:24:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gKy+tk89qfFPLh7G4tmPtYPcd1lguRoNVY6NE0A47zpcCmTzODZxm10wTRf2qANKZdFuzUyHw6uBDCW8fSjrc7rLnr5RNqPrI4ZMrwzCWwJxWxippdtjJIF+OAolmMJRd1b1DItFeM8LnZWCijYhiRjc+UnL3vxPWViO3SHwXUdUBPwoNxzfKTyafnHDF708xqYyvppIBwBfUIwWBvIB2Gm74VTh2B8+1iYDE0kLQo6JzDUl1qDGomKD6k5v0Y/YoOWrYL1uUirVgZ7av3J2g7PxBH18Cq59+KOnYYo3NerRN6AUlV2DVD9lY6fSKltaE+35N63zd2SOKpE49akMlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9qBTP2KRhklO07qEpoMLfTbYxcv+O0cMe2vjv46kZ4=;
 b=P6wATpycJTVjAA1GVZxd1Y4FfQmrBnIFQH25TakRdE9JF6K3vdFT85Bsr+ugJnbOkw0cthdNPDOGBe+Q5GGrE/0FuYfOIGNDuOxHtdVNW+MZa1RNXun6YPBBL0LQfrgc18i3fyLm8VIWWFv+nFyHcxuinh/Vjhx1Q88wIWoTM1r8AyTPnE/Jk0ljKhpFyOqAeSa7pAwfYROppwgL1IsuVmp9tnUt8Lj/wv0fF7enP8wIMelQe/FRixbEweUXoJcanMzTQA0NawC3w/ORTpnMwaUkl1SRyY2gWvrBePo/hSXOASFoirikc8OKJwnKWs0+QGswM1ZUcsqRKdTJ2zdu2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9qBTP2KRhklO07qEpoMLfTbYxcv+O0cMe2vjv46kZ4=;
 b=2KO9R9IPIKJdkrXrwaeOsXGw2/ntErBiSl1Cf8pUDxHaFdG/ERRlfiCQIJorwCYf6If3dxcXMBvEaYoigZJMR6WHa083I605HB4jaY3l1O09mEz/ktp7zTDTMFaxoTm59i6GHdZo8q8GGFK7WikT8YmFb6vkrPJHl9qqvzb5Umc=
Received: from MW4PR03CA0328.namprd03.prod.outlook.com (2603:10b6:303:dd::33)
 by PH7PR12MB9223.namprd12.prod.outlook.com (2603:10b6:510:2f2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 09:24:11 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:303:dd:cafe::91) by MW4PR03CA0328.outlook.office365.com
 (2603:10b6:303:dd::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.20 via Frontend Transport; Fri,
 21 Feb 2025 09:24:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 09:24:10 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Feb 2025 03:24:08 -0600
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Felix.Kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH] amdkfd: initialize svm lists at where they are defined
Date: Fri, 21 Feb 2025 17:23:55 +0800
Message-ID: <20250221092355.336312-1-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|PH7PR12MB9223:EE_
X-MS-Office365-Filtering-Correlation-Id: b9dfba35-5be0-4ccc-00a4-08dd52597fc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zhvgeBO+31pPTDHDAFRr5B6r2mlIpi8Fs3D48dOm20pQ/od27F9hoZhgeW7q?=
 =?us-ascii?Q?nysMvc+iuwXepwKkyswhAAQSp3BMKejHDZussLichupqLvy/h1WLg36gUkLT?=
 =?us-ascii?Q?vtgTv27mzmEg3JpFJdNk2PI49hyBYedwJJD18xeAeGuRwf2SChx1+teXsb3q?=
 =?us-ascii?Q?fdlAForF+6/iDMNy3dZbtLupGg137Ik/QksGyCtLWDmwL7mOhv2+IBjWgVc9?=
 =?us-ascii?Q?O3MMv9BE7WlU4gDAntw5btNcKdDBzG6CJqTndAKYDIskPuWUz63whGHpUsO2?=
 =?us-ascii?Q?H3NlX8UWuwYkb2n6oDsU9Yr/9v3wbUUjYQ4WnTjtjEpWBLdRjRfhd2929vQT?=
 =?us-ascii?Q?LVJYE35y46ECik3xghoFb+RE2Jazm4yXAXqN/mr7Vyo68o7KnNuM4+yCpTHK?=
 =?us-ascii?Q?FIJhekqsB2AYfjyTEkai5p7Q1dcDFeZmzXGjO7CWSFtmD8AQCIlNErrYwLvX?=
 =?us-ascii?Q?KvQ931Ub9PRWcGw+72nj0nHFTEXTJJvlMm9JdEKb8v1vHH1eRrY4YADKJH71?=
 =?us-ascii?Q?wR/l/N7/HEL0vxv5L8rdZk8rmU5okJgB6cngRMKMpIYcNqGcOyVpqF6NJ17x?=
 =?us-ascii?Q?+/Pp3cLouQpJEehEjsFA+982ogATbHlWXT1bh4idOHIx2iD1TslY6Hj/OHCI?=
 =?us-ascii?Q?5dEbdFatQXHmJF8dgcEakyQvei3lWEGOIrXZTI09kez8MlXGpa0w9OVNGRFz?=
 =?us-ascii?Q?8HVnwZrB2B0CsPmjbGVrYdb9Yo9cDCAoTXnuOASNfdRoo9dmPT/9n2ToMFhh?=
 =?us-ascii?Q?FvtYvZ3fzCyPahZyWyNkZ3m0EylSlKMJW9snwKgNSG1iASf21am/bUZuF5IJ?=
 =?us-ascii?Q?5kngL0JjTAhOqBS12p7HRilIBDPbCVgN3FJ3W8FkWKs36QuTVtEdSYU8cx9l?=
 =?us-ascii?Q?mNRZAaEc09p5jXCGbrI0fsK84Z82eOktt3eo5bcBnBvzKY1EJ8hxwzcRU55c?=
 =?us-ascii?Q?BKb4U4AdFbNC2xiY/pYZZBf9hSg3/PeQwRYfowHvMXBRx/JCo1JBGbKvDk3J?=
 =?us-ascii?Q?Hv7i2JFvYIB8/oztqNt5NEEEbI9M305O6zlnbo6Cc+sTZmmROhtpk3Dv/de2?=
 =?us-ascii?Q?s9YpwD6tMYs4Oy6sKOvVX+iqUzmFrErfuEm+WjditEMKAOrA7xdqiuI7R9Db?=
 =?us-ascii?Q?5Z0OKWsPXhiBfiCdCNFh6ozy44B59yPP/Dk+myxCSbQt3nOuT7BpdUtG+ZGm?=
 =?us-ascii?Q?l2XhDmDaezynOT2fiw5ULs9HefxkUO8ePqZGF43HSusk+jjI65g0ZB0cyzm9?=
 =?us-ascii?Q?Dzi4sjMghCKZUhpY2hYjBN3HlIfGuvHtusvrDuLv/+pI18kD3Yc7FL0qtCE+?=
 =?us-ascii?Q?lkdnsNXLCU+768g5vlZDXNhgNTelf5Oq640uXQPBr+DvDuVv3MkJ2AvxCtcZ?=
 =?us-ascii?Q?4PmYS0RmDYSW0gvB3lq9IrQpK+Gx77lrRmOuRpp+PwMtZM+KFxKY3Aiv4GqJ?=
 =?us-ascii?Q?zacYWzsJS3Rqu4xiSNq520KV+oYdJcM0TFHQ2Src/cYiGkjMCtJogq9JJTIH?=
 =?us-ascii?Q?6nKNLvWs3tjvJh0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 09:24:10.3616 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9dfba35-5be0-4ccc-00a4-08dd52597fc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9223
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

This commit initialized svm lists at where they are
defined. This is defensive programing for security
and consistency.

Initalizing variables ensures that their states are
always valid, avoiding issues caused by
uninitialized variables that could lead to
unpredictable behaviros.

And we should not assume the callee would always
initialize them

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index bd3e20d981e0..cbc997449379 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2130,11 +2130,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 
 	pr_debug("svms 0x%p [0x%llx 0x%lx]\n", &p->svms, start, last);
 
-	INIT_LIST_HEAD(update_list);
-	INIT_LIST_HEAD(insert_list);
-	INIT_LIST_HEAD(remove_list);
 	INIT_LIST_HEAD(&new_list);
-	INIT_LIST_HEAD(remap_list);
 
 	node = interval_tree_iter_first(&svms->objects, start, last);
 	while (node) {
@@ -3635,6 +3631,11 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 	if (r)
 		return r;
 
+	INIT_LIST_HEAD(&update_list);
+	INIT_LIST_HEAD(&insert_list);
+	INIT_LIST_HEAD(&remove_list);
+	INIT_LIST_HEAD(&remap_list);
+
 	svms = &p->svms;
 
 	mutex_lock(&process_info->lock);
-- 
2.47.1


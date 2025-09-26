Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D99F8CAC5BB
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 21:04:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39FAB10E0C4;
	Fri, 26 Sep 2025 21:04:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sR1XK3dK";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011001.outbound.protection.outlook.com
 [40.93.194.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A46A10E0C4
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 21:04:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VRjLj1uOJmz24NyrOasKMze+zfnTPzD3aPxmwPx8HeOkAi4EZskC2W7m4x8IaKk2WXGBzEHPN0RO0JodktZsJMx29YlVvQgJYZDOTDhpWsBQqHIvJ8DPdgwxCCQQlCjYuGOKKSBOUOa5a8rcIkuOSYurKajpEwybF6vm9IOBDtORCyGbgoCjlNDjqy38hC4MiShXIp0RvTKXM1UAXFGDWd4f54Qf5yOBjMYSeI3gBm7CAPJJ4Db3a9VloANivZf+zKVugJwOGVw1vo3NYDhn1UCdMdl+ylikR1AachlH4RsnBr7uBXGp3y1lIcREbJmviJ2fWvq+CKbaibD+j6KxWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1VXly7KCcfXFcM8SEC+6N3JgP50LjtOakAYpveILQys=;
 b=QFNvUcR7AAp48dnG6PjWmCmfaEox6BSbXBStrocJ3i7/84BZbO35oZ6TPy95ytbu39WfVWI6WQAgnnpkvlhl1LvNzn+ZXGe8CH5p73d02X4nS4viKg0Ri+3Sxc1xFmmFtIXi/7YAM5gwdpgmDaK9u7vARgMFVYKE4R+Hl42nEq+PLUJWZETO1sqsUvkuTYsY+AXqkIefdaP1AVcX6sWhoUU8UcpA8DyMqwFm/A8+hjLme979JP4xxHu3v9NbVYjEI38t6w4ozPgFzAwowZTuc7Nb/CW74tsI9fLbwn7+iMFKDoZL0+LqgUOP+r8481rbe6LPummWnAlNMQNYsKBrwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VXly7KCcfXFcM8SEC+6N3JgP50LjtOakAYpveILQys=;
 b=sR1XK3dKgzp96cbtr0qf9NXMER2Rbkr3eEr33WcGtQTCifOuLZDAIUea54NNHBA6tKnwE7ODgUHHeo8RH4vnkAN4Jo1x7jBwb3lZrnrPRWVdLrTMV0I0089YVAGMgLK/J0RCaUES6YtPSJE3RIV+FmXQMWBauD8f0VPyFtUs3uM=
Received: from MN2PR01CA0031.prod.exchangelabs.com (2603:10b6:208:10c::44) by
 PH7PR12MB5998.namprd12.prod.outlook.com (2603:10b6:510:1da::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.10; Fri, 26 Sep 2025 21:04:09 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:10c:cafe::bc) by MN2PR01CA0031.outlook.office365.com
 (2603:10b6:208:10c::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.22 via Frontend Transport; Fri,
 26 Sep 2025 21:02:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 21:04:08 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 14:04:07 -0700
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH] drm/amdkfd: Fix svm_bo and vram page refcount
Date: Fri, 26 Sep 2025 17:03:30 -0400
Message-ID: <20250926210331.17401-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|PH7PR12MB5998:EE_
X-MS-Office365-Filtering-Correlation-Id: d4300f9e-cd74-46a2-99b1-08ddfd403bdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E67pwBbbMHIoXf5mUwD94s0k9VMw7HCKkFwjaGEIe9vxPaPKU89jxhIQK6fh?=
 =?us-ascii?Q?RWeD8WgO1TOLS1WnpTzCAVo15/ETApXpClMzjkgP5G7pIA4dbm3vs/Bc6GR7?=
 =?us-ascii?Q?jrcyEYJbSV239ujY0t0tMFVlRpWWAjbNG1nNCah8JdDZVC4kNEMoRVSddsJk?=
 =?us-ascii?Q?UjhltIZoGE8ivuZycZF4jKW/DHVYGFCbJB4tHUgJpoGQJ07iVKqO6+Yh0rVx?=
 =?us-ascii?Q?5VNAfMUpdiDSYwSNDCRoXKkXVOJdTU1jBbUUT59+XnlR6cNTeQqZmzmYxVjX?=
 =?us-ascii?Q?NqjbEDGvNnQvO+vN4lpz4yNS47sX0cwdyDwNbUzkUueS1euBuNpMeKwp5fhK?=
 =?us-ascii?Q?4zchDlLWrJ/gx0TFskHyWxxv2mukS3KOFohHl9X72n/E29uHCtDeo9S7Z+v6?=
 =?us-ascii?Q?90zKTqOGjl3nx0RltF1V6DD/dGRiYmsyafPsPBzcR3fbLBBrWKBAc/YYufNy?=
 =?us-ascii?Q?AjA3XdyPmnsiVAqaW3ABHiSKpojqHwojwEBB5YSxuETFJLZ4PDMbh8j1h4eh?=
 =?us-ascii?Q?bW49Pd449QQgmpElIBH3zRKE9M1wptzEL2QIYWeu2kf9aU022IOp2SgRg+Ce?=
 =?us-ascii?Q?PTfDU9jcapUmKna61ALKCEBNf3eEYKT9Avl7nP09h/6msCqZqLRXK4siX42q?=
 =?us-ascii?Q?+juK7nMlu06LTYE1fk7WwVUpFz1jEGr8nHlXFd3rprabPs73zk6ahpAJKXrj?=
 =?us-ascii?Q?RNEP73UeGemk5z+yt1/CGEPg8Jgm89KxgX8E21WTpep7rbKy+Ea8ZjdtGN64?=
 =?us-ascii?Q?A+WyM78M5tFbW9vZbNYqfovzcjre1iIn9KZb07Y62CXGSuoTjM1N3yQSuddU?=
 =?us-ascii?Q?INWBvb8vTFiIFzfsFhYxug0IcA6wb6WvwdQdXwC3Es+7spDbz/Qj9ZvNfgoM?=
 =?us-ascii?Q?KP00ZYXum34gYTD9eKU4vY2vTjtlU8CyCPLYC2MgcDMdef0jFW0hDzclIgT1?=
 =?us-ascii?Q?VFP8EJ50Y5oxs80B2sbBNNeFl43Yghs7w+z5aBLbSMKol9lYKyQkxNAgRhwI?=
 =?us-ascii?Q?X8uxNIIokFzlEYw9SG8teEAfAv+sc0OQ6IIApOklz5wcAsOnWnTudlpX0CWC?=
 =?us-ascii?Q?UzaYwTsz2L7Jt+ERcGD3qu2N0fxYme6T+k+9Z2XtWoF78D5oPwhpKeA9++tS?=
 =?us-ascii?Q?iXDIWKUEnvUXmQ3ElAX9zH3bgps+8bcbUYDfBFOPkjqT7MpMtSvrtFxaRc1/?=
 =?us-ascii?Q?V9tgsszcAjyrsuqjx3njedgMvslVNsPR9tFTnT2YSvdju+k7ByQxLUkREsNx?=
 =?us-ascii?Q?/Eod3SWMoo5r00Il9xRsKhkWBYtFUg33aHg7ysgNpvVOm74Jmbvn79MDFLYy?=
 =?us-ascii?Q?55io2iNn3zx2XCVIYodzAz1+37H1kY+4P87z0fhst2oCOp+ALMIO8uJMYMpl?=
 =?us-ascii?Q?nIKqOkPexVoGI//moxonaMfAZLQUQiNxsRcmtP5cfPqWf38aOQdUlQCLsyWi?=
 =?us-ascii?Q?uWVGB5L2TNqCzxzy/soPvZDmNz7luUNz9UnsdCrmQTe2Xj015RlL+54PWSnB?=
 =?us-ascii?Q?zUSEc9FeVtTFZh5NMYM8ImUYQ/ohqMqSJHPhtBRgMmcr1zQ8WIyLJBr2paHx?=
 =?us-ascii?Q?Tt46G7DYqLZldT/K+SU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 21:04:08.0094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4300f9e-cd74-46a2-99b1-08ddfd403bdc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5998
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

zone_device_page_init uses set_page_count to set vram page refcount to
1, there is race if step 2 happens between step 1 and 3.

1. CPU page fault handler get vram page, migrate the vram page to
system page
2. GPU page fault migrate to the vram page, set page refcount to 1
3. CPU page fault handler put vram page, the vram page refcount is
0 and reduce the vram_bo refcount
4. vram_bo refcount is 1 off because the vram page is still used.

Afterwards, this causes use-after-free bug and page refcount warning.

zone_device_page_init should not use in page migration, change to
get_page fix the race bug.

Add WARN_ONCE to report this issue early because the refcount bug is
hard to investigate.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index d10c6673f4de..15ab2db4af1d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -217,7 +217,8 @@ svm_migrate_get_vram_page(struct svm_range *prange, unsigned long pfn)
 	page = pfn_to_page(pfn);
 	svm_range_bo_ref(prange->svm_bo);
 	page->zone_device_data = prange->svm_bo;
-	zone_device_page_init(page);
+	get_page(page);
+	lock_page(page);
 }
 
 static void
@@ -552,6 +553,17 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	if (mpages) {
 		prange->actual_loc = best_loc;
 		prange->vram_pages += mpages;
+		/*
+		 * To guarent we hold correct page refcount for all prange vram
+		 * pages and svm_bo refcount.
+		 * After prange migrated to VRAM, each vram page refcount hold
+		 * one svm_bo refcount, and vram node hold one refcount.
+		 * After page migrated to system memory, vram page refcount
+		 * reduced to 0, svm_migrate_page_free reduce svm_bo refcount.
+		 * svm_range_vram_node_free will free the svm_bo.
+		 */
+		WARN_ONCE(prange->vram_pages == kref_read(&prange->svm_bo->kref),
+			  "svm_bo refcount leaking\n");
 	} else if (!prange->actual_loc) {
 		/* if no page migrated and all pages from prange are at
 		 * sys ram drop svm_bo got from svm_range_vram_node_new
-- 
2.49.0


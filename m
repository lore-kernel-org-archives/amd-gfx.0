Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A1ACAC581
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 16:15:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CA2410E55C;
	Mon,  8 Sep 2025 16:15:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L2govR3i";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 654A710E559
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 16:15:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ri664encsjNWR+PDYgdFfOMVhjnATyKc6+Rci6tjS5YQqTFIiZ16MlwtQxLP38p3si1RXJZ6yfuLYun0VTmRWQsqMV3IA7SWNY1P6OtjyJz0uYUaHw8J1NiVjOlfvwMWST2yF8DSiYK0nyWfUeYfuzn/wT+bxC1XAa7hbVHlVLvKxvckA9OqTN0ChC9K8tCMMlF90kaGdxraa/4jhHgC1B6aMMA5rB1oxp94LIX8EbWdko9rQ3aErhL+LCfsl3KZsJxB910BUyKlo6Xy/ASFkqdWGKFD18nUvITKlBUIq07EoUqgORRFQwau65yZEPX2J4Q0ag2m7kAAz1A4VeODyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4WNYCTz1tlqiClPmXM37RF0gQ0r473n4XpowLpdMFSo=;
 b=E6Lux2N5Rktovad2dsQ9fZT6qiBXw9TdS+A0wb5ZstlzSR5XImVl4noGVZhiCZnMW7JqUKnWE5zxuwWvuEpJpG3fjvLfnJENkvXMsOLBhGoCRLG9qgdxisPcfmeJZgYDXof1vHVDfCjgY+jwaP6QR2MWgZlNT3tv+5wSVQ1QbIWmlZilJswNSaYjtkDx+JBWbNLsIoxR4EdJYOgh2VUYljP4y/vmQhS7FcgFpONpByJZEevCJ08Mvyu4SdDrdS7UyW9mGdc6o+PPOUWvC9wp3ZH/MoLP2dy+ErxrumEg6n/d6MYY/kziz94hWtN40p/OftoSS2oozw43cWD9ycdHUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WNYCTz1tlqiClPmXM37RF0gQ0r473n4XpowLpdMFSo=;
 b=L2govR3iDjipBIhpJPemDMGzoBCzjPy/1wW7ri+deb+bDVBfI8QK/3p14tG39tUxvD2jKMkGEDcRz9Za5HWXVU5MUDgV9HL0qx8YQmBJi5kzkD+XznNeYV/n9T5YRlmIjjXC560ky52N/8I3csgKSshAETkdIJiN8nHo41cF0FE=
Received: from BL1PR13CA0345.namprd13.prod.outlook.com (2603:10b6:208:2c6::20)
 by IA1PR12MB8494.namprd12.prod.outlook.com (2603:10b6:208:44c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 16:15:41 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:2c6:cafe::64) by BL1PR13CA0345.outlook.office365.com
 (2603:10b6:208:2c6::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.11 via Frontend Transport; Mon,
 8 Sep 2025 16:15:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 16:15:41 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 09:15:35 -0700
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.kuehling@amd.com>, <philip.yang@amd.com>, <chengjun.yao@amd.com>,
 <jamesz@amd.com>
Subject: [PATCH v2 3/3] drm/amdkfd: free system struct pages when migration
 bit is cleared
Date: Mon, 8 Sep 2025 12:15:26 -0400
Message-ID: <20250908161526.99413-3-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908161526.99413-1-James.Zhu@amd.com>
References: <20250908161526.99413-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|IA1PR12MB8494:EE_
X-MS-Office365-Filtering-Correlation-Id: 82549d52-b12c-4523-838f-08ddeef2f4e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qNIdRaYFw60Waqyegi+RTVMJQ5aVfx8QzG3tgffcJgY3tzJ4XBkjYoeVFE7N?=
 =?us-ascii?Q?kBA84I9ajKhXs3ZMG9KuN5AhqKZ7H29wiD0cYcewS8c2Cpn738JhUf31rjbj?=
 =?us-ascii?Q?KNJgNpeJHccQRefE/sCqgT0i2Zg0EKVTzNcRtOIabR7mjc8kdyz4NWMCSEK5?=
 =?us-ascii?Q?62RVqSODLNCWaQwsONsIvD6Cbfv9NqsTfRyo/M5kOY+pS534QVqXkjuMfw+2?=
 =?us-ascii?Q?JudTIKm9NQ3VOAfa1Z6KRQex3bf9rrFSv8zqffci7lN0RyrXrlS5n4S2EFsH?=
 =?us-ascii?Q?fEOXu4XvXw52/ESiUepAm4YlzNIFHXmtAI5MTEUryOZuKrTlJlp5T3/5C7G/?=
 =?us-ascii?Q?Jkxyvg9bwsmTJMBYYOYpQh1ZuSj+gUENEa/OKa2dXapEPCwYtG1lOMPNhUTI?=
 =?us-ascii?Q?ugaVm9HB9CYMdXSHRtQxDo9l3URIWaTEMS9cS/dZibormgtqqfyliEytId5/?=
 =?us-ascii?Q?237YK7ZSNEvHhRr85u8obevhMul0/eE3Si7j/J5zG42vViRSaxnOXUeYlN53?=
 =?us-ascii?Q?RmZ5P6rDbbefGvYy1HEt7WInDDvbNPyPMgPQ71evBVhOqQjIS8pBYR95uGFD?=
 =?us-ascii?Q?tFRVKfV0nHB9SQSKfAS378Mz57Bf5GyMSNmdoIGlWrbVGaumOyK3I5WvlZGq?=
 =?us-ascii?Q?iepHUXfJnm+IiVFHxg9YwsgNc9Y4R4CD+5RxOIYITwQh2t2rLPiR6fNbUuC/?=
 =?us-ascii?Q?+PnPDewWw6AeIjthF483QW5pnhD3mUlblr+ELx/V0wKB8lQed9kupMpjy4/R?=
 =?us-ascii?Q?BWBf3mU20DhDkmA4JqM6Q/VnDr3zI4BieBIpkfGaPbwfFFkxsMg7EC3kBvPw?=
 =?us-ascii?Q?2LRJhNSYEqE9BiwlE5d3QANZbPJEBfNE/Kvc6Hmv29+gUcMcEkEpthWf/x/9?=
 =?us-ascii?Q?+Yjt4iJ5MWaNOu98IK/kNOOvj3VfVwllFknxYovNvmGGfnKVHYxVsd5jD7FR?=
 =?us-ascii?Q?IUUu+C+McLCziw+vAry4Y1Yh7X7Nb0jqjBss188yhUn/nhN4ltWrQh+rjeLs?=
 =?us-ascii?Q?Ei4EM/tyewNAzC5GRZ4DK7HLcHTH9oc/+6w8r42O9L1jp40ZZT1LoRI5LZye?=
 =?us-ascii?Q?sbmpO+1nETwOC3aDIOe11FYSuaXVKFKa7RK98CEnAJPthMfvW+lF8DqBgzFT?=
 =?us-ascii?Q?cOVt9ueoccLgwGcuCmYrPd76XjdRcMO/YJXVHA1hExyT7Kd5FT0bYjkGGL5j?=
 =?us-ascii?Q?z25LdbQLwZoFnB5cogmhr+tjkqhRgXKWH4SSl9pIezKOPY0W903FwImNDw3l?=
 =?us-ascii?Q?IedVGCaWezPbEUI/XLm4PbpHBaCe5bIhEIStXjOgTyrYBictVvB9IrPda76J?=
 =?us-ascii?Q?us7tFvW00RmCyckXiJ8DUhI30xv2Q/XF+bi4edUT0Xriunz4JHBw1uUOsj2m?=
 =?us-ascii?Q?W8NQQyW9dTg1/w2BNo4yGXEhYHt9XD2BiJ6+foc6+UPcQve3PKdkV+yrLbl4?=
 =?us-ascii?Q?n1i+Ozyv04YB0HdjxhGB2vMLxCZ2K4/Go8T1G4KepIDk90LmYURnAmCov0HN?=
 =?us-ascii?Q?l1D1tr99UEwOueq3fvQpnPBAyAiF1b9fY9yc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 16:15:41.4162 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82549d52-b12c-4523-838f-08ddeef2f4e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8494
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

if destination is on system ram. migrate_vma_pages can fail if a CPU
thread faults on the same page. However, the page table is locked and
only one of the new pages will be inserted. The device driver will see
that the MIGRATE_PFN_MIGRATE bit is cleared if it loses the race.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 83b9d019c885..eb43542896e0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -260,15 +260,20 @@ static void svm_migrate_put_sys_page(unsigned long addr)
 	put_page(page);
 }
 
-static unsigned long svm_migrate_successful_pages(struct migrate_vma *migrate)
+static unsigned long svm_migrate_successful_pages(struct migrate_vma *migrate,
+						bool dst_on_ram)
 {
 	unsigned long mpages = 0;
 	unsigned long i;
 
 	for (i = 0; i < migrate->npages; i++) {
-		if (migrate->dst[i] & MIGRATE_PFN_VALID &&
-			migrate->src[i] & MIGRATE_PFN_MIGRATE)
+		if (migrate->dst[i] & MIGRATE_PFN_VALID) {
+			if (migrate->src[i] & MIGRATE_PFN_MIGRATE) {
 				mpages++;
+			} else if (dst_on_ram) {
+				svm_migrate_put_sys_page(migrate->dst[i]);
+				migrate->dst[i] = 0;
+			}
 		}
 	}
 	return mpages;
@@ -448,7 +453,7 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 	svm_migrate_copy_done(adev, mfence);
 	migrate_vma_finalize(&migrate);
 
-	mpages = svm_migrate_successful_pages(&migrate);
+	mpages = svm_migrate_successful_pages(&migrate, false);
 	pr_debug("migrated/collected/requested 0x%lx/0x%lx/0x%lx\n",
 			 mpages, cpages, migrate.npages);
 
@@ -748,7 +753,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 				    scratch, npages);
 	migrate_vma_pages(&migrate);
 
-	mpages = svm_migrate_successful_pages(&migrate);
+	mpages = svm_migrate_successful_pages(&migrate, true);
 	pr_debug("migrated/collected/requested 0x%lx/0x%lx/0x%lx\n",
 		mpages, cpages, migrate.npages);
 
-- 
2.34.1


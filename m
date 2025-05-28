Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB0FC5AD49
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 17:19:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA58E10E656;
	Wed, 28 May 2025 17:19:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qIbLM8YA";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D859210E619
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 17:19:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=emWMu/SQ2pW9PmLX5T88ub44QimXRf+HcVns8Z8s9O+5GFxNIrqUodySMYvFqUH8v79nnQ0GEqj+/8Kc6AhhNBN7XQFBr9Qzt38U+Ce+faggr4q+h4CjMQ3awYJHxTcdJKsyx7VxCEJHF81FPCfOicJJHpTOfEne6xtoHdp+rFkGVefQwSNFZ27RMVKWStg30ZuMJYcHuQKPJDuFWFNGFi4fSQ5LozZJtZz7aJXCR2gNwXp/SA9LvblKxArfc6+did014HuSaa4YWIumYHym/68Z0yBjxO1ecCJD5it5nBZi9Ye+khqgAuEIBAGQZtQGnkNX6JIhy7i50+26dDEimQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykHkpKNs3chNeJmvaPbKZ8DCSFUD1qJHTzOFTsnv7UU=;
 b=OXboy2qVGErR6IJinU70cWGSgwCpUH0Gtyr+a2Blz142aCOvdUUVauKFt19zPFmm1jFs/csh1KpwIBMEu74gEkz4EkCnuzqkZqHMWCMPehPcqZ/VlGuHrMHzNfqHWcxWRVc89UM7NCBkspneVrSy01HTsbBo4oF5MWJukKIAr7Zjbqiln1+d3U1e0Xa4rOLMyEcKc3OLQWl63iBqqjl2w0Xe63uQFGteCGt0xaX317jAPSeae1xqoJoTV35R0wFb6CvmyJ+gl2QzOX4zINAg+c/6KmQuls9LCj4EQ5rvprcaHnbDWUzeRuSxgROcIQ+KmHOqw9B09xvSCMM+JWG+FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykHkpKNs3chNeJmvaPbKZ8DCSFUD1qJHTzOFTsnv7UU=;
 b=qIbLM8YAjhuu+sn6X4vGL52ccM1WEqcwT1PS2jLIwoylOXEF915PL1pjHwN2c88fA1xHI9fGqOVlYl/d105QXqCwBbPSq+TTjUa/zMWAsGtYmmjR7lQlS9DrNBJ+918ePIc88aCJC/vLoFpEWM7kHyKDtTIIrWlahUGD/6GALNA=
Received: from SN6PR04CA0083.namprd04.prod.outlook.com (2603:10b6:805:f2::24)
 by IA0PPF0C93AC97B.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bc7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Wed, 28 May
 2025 17:19:23 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:805:f2:cafe::ab) by SN6PR04CA0083.outlook.office365.com
 (2603:10b6:805:f2::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Wed,
 28 May 2025 17:19:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 17:19:22 +0000
Received: from work-495456.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 May
 2025 12:19:19 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <philip.yang@amd.com>
CC: <Felix.kuehling@amd.com>, <christian.koenig@amd.com>, <jamesz@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: add svm_migrate_successful_pages
Date: Wed, 28 May 2025 13:19:08 -0400
Message-ID: <20250528171908.82639-2-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250528171908.82639-1-James.Zhu@amd.com>
References: <20250528171908.82639-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|IA0PPF0C93AC97B:EE_
X-MS-Office365-Filtering-Correlation-Id: 5197496e-3afc-49a3-4da1-08dd9e0bca32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?apKrUfuS808xg/xqK+cqYGNP79XYCvX4xtpgjNDE0d8Uro5TtijVcGABNVQ8?=
 =?us-ascii?Q?abUqtNdlIWIeT2VRL9l8x5Br2Mja+ef+UbEKfA+5jH/8VTu2yy2fQOtXeaOZ?=
 =?us-ascii?Q?qo0DqJQSAr2L7jlcEH7nwalX8hE5UrtSPJ0QGk4hUowL0iUu2IGivt/et2XY?=
 =?us-ascii?Q?AnlzunRrGPjCCpkeCLimyCLog49p8ZdjWnCcIfmnwKpOzwowpMDCCrvsbV1c?=
 =?us-ascii?Q?GwotPqWHZDsa0MVRjgMrHre1OzTf6IXQ9EMRn6sg7NhFMbsP4gQVTmpATOU4?=
 =?us-ascii?Q?/NIUxgvdwo/MVBGkmhzsjWGBESqIH9agkCQ69qSK8UWAdbKgQuwDKyQZ+u6O?=
 =?us-ascii?Q?xTJdMRVZAC/k7h7pS0ZUpnDWlwDlwpM3V+6E6n9kr+FEfQAcc9gJIU5fLSNx?=
 =?us-ascii?Q?G2ejxqCL7EQmeoF7hRzs6uQsSTLixoZgFbs1CzgDazoVow0/3ni/yXddVmcq?=
 =?us-ascii?Q?OhWbCV4foal8GMiWeiEuly29rKsz5f2/YScea6cnJoCi5s2zQerCTfimUUuB?=
 =?us-ascii?Q?a+T2+dFslO7wYtY6MsxEVHGnfz6B2OSHsvj3PfdjM/vDSl7yDyHuZYDVIvJG?=
 =?us-ascii?Q?uO2SL47N8RFfPCS48TAWp8L6U5AlLLh7N9o8YfkRBU2cdxhz8NBcFW24BXM4?=
 =?us-ascii?Q?PyMVy9JjWOSQu+p+OI5UH9vbZl1DqrJKQ0+t4yQA9tXodCD4VukxiRkZ5Hqq?=
 =?us-ascii?Q?I1TsFMg3nR2BxRnUM4YSsW85YfIHSQFytDvBliAd/RA8d9Hjbmoxn2eaCDrH?=
 =?us-ascii?Q?b/nLgwjl1lGVFrdMBqubv/mNTdE433bgfdcxATyHcAX5Hc/8Q5vZmlmiHEL5?=
 =?us-ascii?Q?fNr5PofmHXyuerl4s/IdiKtFHJ+543gYCpJ4xPRbOMHKWvIfUNMQ9L/Qpk7e?=
 =?us-ascii?Q?f8DryrWptuwsuWjPO8cqfRbc0o/3dh4EmUdcC+SxTFNmlTcZ0sHF8sIeNzsz?=
 =?us-ascii?Q?5I2W5od7VdtbzyIXQWdR5iPB54QsY5qlm9vCeRKDFRgUrQEsmCZdDUNFw5RW?=
 =?us-ascii?Q?YpWp6DeAlEcWodHGAJDcZzpW803q+si+OI3CLMa5kOjOFaI0zmPZvrkYkQFZ?=
 =?us-ascii?Q?1L+B9atOPXepqfepWTv8R+jofHcHHE44ooMvUsBooA3pCa+Z2Dm6k9qAU5fn?=
 =?us-ascii?Q?7ud4HUhUpVt+OoRxArJNphaiSNYoYMsGcXlOBGbUgFul9yESlipBaOZwm62U?=
 =?us-ascii?Q?yBVrKSkH5yWNdsdoGf5HYL/wuq8O3Cx4r4HhyN1hyJeYs0wjFm3yHEctKzLu?=
 =?us-ascii?Q?yOYp1TRVROsrYkD2ywWvS69lih7ieJTfFPpSW9+Ve4C0ukEFm30YpxIR/bpf?=
 =?us-ascii?Q?yUON9+BOSgWmdB7CQTxT4yH3TV2FPrUgQfninyibFJiiTcJTKUqtseJAwgM3?=
 =?us-ascii?Q?2azHy0lvBREPmbZWkUDC5Nonz9t3UULlbl2H8RvszH13kyj4fl2pPnWABwkT?=
 =?us-ascii?Q?V27FvbGXhYsouuTfFMtoJio2et1o+3u79JKyJTrxioFm/4qWXw46uhjOfanG?=
 =?us-ascii?Q?yz2U7lmyPRr7bu8/MVgcXGMv9TxsqOwTwNOG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 17:19:22.9958 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5197496e-3afc-49a3-4da1-08dd9e0bca32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF0C93AC97B
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

to get migration pages. When migrating pages from system to vram,
needn't check bit MIGRATE_PFN_VALID, since the system page could
be allocated, but not be accessed.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 25 ++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index f0b690d4bb46..131838bf8751 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -260,17 +260,20 @@ static void svm_migrate_put_sys_page(unsigned long addr)
 	put_page(page);
 }
 
-static unsigned long svm_migrate_unsuccessful_pages(struct migrate_vma *migrate)
+static unsigned long svm_migrate_successful_pages(struct migrate_vma *migrate)
 {
-	unsigned long upages = 0;
+	unsigned long mpages = 0;
 	unsigned long i;
 
 	for (i = 0; i < migrate->npages; i++) {
-		if (migrate->src[i] & MIGRATE_PFN_VALID &&
-		    !(migrate->src[i] & MIGRATE_PFN_MIGRATE))
-			upages++;
+                if (migrate->flags == MIGRATE_VMA_SELECT_SYSTEM &&
+			migrate->src[i] & MIGRATE_PFN_MIGRATE)
+                        mpages++;
+                 else if (migrate->src[i] & MIGRATE_PFN_VALID &&
+				migrate->src[i] & MIGRATE_PFN_MIGRATE)
+                        mpages++;
 	}
-	return upages;
+	return mpages;
 }
 
 static int
@@ -447,7 +450,7 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 	svm_migrate_copy_done(adev, mfence);
 	migrate_vma_finalize(&migrate);
 
-	mpages = cpages - svm_migrate_unsuccessful_pages(&migrate);
+	mpages = svm_migrate_successful_pages(&migrate);
 	pr_debug("successful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
 			 mpages, cpages, migrate.npages);
 
@@ -688,7 +691,6 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 {
 	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
 	uint64_t npages = (end - start) >> PAGE_SHIFT;
-	unsigned long upages = npages;
 	unsigned long cpages = 0;
 	unsigned long mpages = 0;
 	struct amdgpu_device *adev = node->adev;
@@ -748,9 +750,9 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 				    scratch, npages);
 	migrate_vma_pages(&migrate);
 
-	upages = svm_migrate_unsuccessful_pages(&migrate);
-	pr_debug("unsuccessful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
-		 upages, cpages, migrate.npages);
+	mpages = svm_migrate_successful_pages(&migrate);
+	pr_debug("successful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
+		 mpages, cpages, migrate.npages);
 
 	svm_migrate_copy_done(adev, mfence);
 	migrate_vma_finalize(&migrate);
@@ -764,7 +766,6 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 				    node->id, 0, trigger, r);
 out:
 	if (!r && cpages) {
-		mpages = cpages - upages;
 		pdd = svm_range_get_pdd_by_node(prange, node);
 		if (pdd)
 			WRITE_ONCE(pdd->page_out, pdd->page_out + mpages);
-- 
2.34.1


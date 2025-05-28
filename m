Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4167FC5AD49
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 21:17:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFC9D10E0AE;
	Wed, 28 May 2025 21:17:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZSltXZVW";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2080.outbound.protection.outlook.com [40.107.101.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F07810E642
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 21:17:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kwPt1/UZP3pJNE9iJ99qkrCubTy2y0YHs4ssu54RI7lUwiYP0JXoQwey2/HAyxGrLt63cZ5U2fSzn/TiK3B3HfRAy/V9slf6bDMkhouhg4/K+1bnahr90w04OShPxnfVpnu5FaABJzKA662tsTMmkcUOJrPKi79v35a98lwkpaJHNJPiftF/VRztR2bLejGuO1SmZ3ZPJqCjF0oGQj83XaVoBaVl9Wkt4AaWlBmfYn7Y37oPtFbhJKUqr2mIVrIoMrBCu8H6ysRokP0otFWJlFewHcfSgN6AuX91T9AYLMX3Vz7WSY8cDGN6EsaAnbxN21nE40rdMdfNegwXjlq19A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFVVM8kFREfBoSgEWZkzqO5vA0x+BYGHQj/Tek0H4Uc=;
 b=jfvZIIIWCOj319/NHyMCE1cICu4k61tHbpjXsSC+Hd2eXocPWmLafKLzts7gxVxMHPSJStdwmss5kImV+UNXQ29DnVqOCWzMh3N+TwnMYBbw/S9sYdveLj4AbnYVbkBz31IhIXJtBlxJ9y2w6MqR3iiSs9XtGvc3XxOTZKjh+Rph1wyvGEaJXCaN3Xpn6/RGGGtKTqaLkjGk3FxinZfUGXNIXTHTwXoKqJjhwIT4RhqNlMyxWt7uCv+yAVtjj0BDKQTajRfiwINPU/u0U15vdWjG9y9M380iHdzeyrE46EDSU26ZJf7EjzLPCvHkP2WLIckbDyeMQfg0YHz9dn+Ing==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFVVM8kFREfBoSgEWZkzqO5vA0x+BYGHQj/Tek0H4Uc=;
 b=ZSltXZVWi5kPG+2LLjEtr3J5eg+9AvOgZ1ByDBqzEzRpAuleYipaUrZhisMbrP6a5wJ8DqC3nro3mcfsHwFephfW2EXcmgT1mbRmbv3ZmnynnpW+okjkXBOrn2tyvWbjdEkwFHafNlwiWQm0E5CCAyo2fT7m44jV1g9134l4GBA=
Received: from CH0PR03CA0380.namprd03.prod.outlook.com (2603:10b6:610:119::8)
 by IA0PR12MB7626.namprd12.prod.outlook.com (2603:10b6:208:438::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Wed, 28 May
 2025 21:16:54 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:119:cafe::d0) by CH0PR03CA0380.outlook.office365.com
 (2603:10b6:610:119::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Wed,
 28 May 2025 21:16:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 21:16:53 +0000
Received: from work-495456.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 May
 2025 16:16:52 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <philip.yang@amd.com>
CC: <Felix.kuehling@amd.com>, <christian.koenig@amd.com>, <jamesz@amd.com>
Subject: [PATCH v2 2/2] drm/amdkfd: add svm_migrate_successful_pages
Date: Wed, 28 May 2025 17:16:40 -0400
Message-ID: <20250528211640.21234-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <49993128-e74d-2c05-fca9-80b511b27537@amd.com>
References: <49993128-e74d-2c05-fca9-80b511b27537@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|IA0PR12MB7626:EE_
X-MS-Office365-Filtering-Correlation-Id: cccc3e0c-80eb-48f3-95c3-08dd9e2cf825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EFsmDWaA7Uv0G+9EsySg0RIxkAcpifISCt6hKrGpAfyeYbYUGDi5OHglNbMi?=
 =?us-ascii?Q?5pPYXsR4WqOAjS5H/NV+Uuek1DeFI5t0iN8G5IK2x+QRBrdTz3kiJ66ZrOgy?=
 =?us-ascii?Q?B2UpknJ5kZteZaAV8XLg8aCPRk+Mxr3VgelxOc2eSrkqHzgB519YoAmLiPhl?=
 =?us-ascii?Q?NP5KjN+k9kGaWoAslx08Ixy5Z2B2g31dCmbf9+oqm3rAUrUwseLgsvdCGxhc?=
 =?us-ascii?Q?ygklaFILgvJIwsOLvvtlxXgsDs3fqJd/C4JnkPqYmvzZXD006MsTzyUhc50O?=
 =?us-ascii?Q?HjoyIYs7KBOFoCQHxMicbCmaTYsbe8uRf66G9bicaE1Te5ijYLIemqGhObTi?=
 =?us-ascii?Q?28L3R8+pmMD7RI4j+0ff3vH3TMsqRsLpcPk94M/U5QFh1bYqtNRRSk/A075B?=
 =?us-ascii?Q?1UNmgf49lC1eG48WgovnMPOSMkrko29FNcZ/Ye4gwL2CqL0OAmav9VEGZuPW?=
 =?us-ascii?Q?WYZKqWSh7aVF63KVnOc5lP995HW6000uNIhzJvvKBh5tBwplYi1Xs/MAcpuK?=
 =?us-ascii?Q?zxUYvsN5+vrR9LYiVGjeYPw20yaZygFGji1jLrN6JjeWc69R1ygReTt6E7hh?=
 =?us-ascii?Q?O5f9eThFU75gSvqeqKtIFdwlHjRAtiPzE5vbkdQlYJQ2fVy99On991WgUNC8?=
 =?us-ascii?Q?XJTocOrOYwfALtO2Ih01fYQ+Az+zcWSDnM5lTcTLTuT6AAOnKVIf8Zj6rzhw?=
 =?us-ascii?Q?9Vjw0dsiizlxxiGIOFq/gXyOL/P60cm3zBmHtlQJvt+VH98KzEi88IySeRN8?=
 =?us-ascii?Q?SjHYONJkUuedzddKY82+VioUI5QtOyh6Qq5g+335t0nOhUNrgPEFAzReqoVJ?=
 =?us-ascii?Q?YbuqM4+nUVWYAa4Lm40VYEE7ZMn7pVncAbLZwDMCXROLsgD2gfgS/NPFNAe7?=
 =?us-ascii?Q?0YFUmfUnmuqurgz/HJ4jl+VM9VjGhEwWWc48EwkCA1vvABpo9sbo64XSEwq3?=
 =?us-ascii?Q?1RA2R+VVEOMCSnU3oF4FlIXGq3El65/q2IHVFLKB98vUxSAIcugkog3pY85C?=
 =?us-ascii?Q?eeQR8JTa4lN3lShxfte2TORFX6Hbrvu2+eV3SScji5gnbP6ws3YaVSVUd3B2?=
 =?us-ascii?Q?yM3TBPMYkFrINMSF8HiCnxGxJzvz/zcpW7sxvoJqOaW4ZR5mChFlJkm/CCpj?=
 =?us-ascii?Q?jsq/ASJeyuXDub4kRYz0gl5v3Eu5hjlOCuzLfyBaAZrP+i7Z45fB3haGZBkt?=
 =?us-ascii?Q?aFXtIMw59s85DOFm6uGA8V0j0QYPN40P+MvOg5y1+0FuoBuuoMl+AKAQKZtW?=
 =?us-ascii?Q?U4Ez+5qJr34f2u9/VitcR493fD+BmyTBybSMXnPH2ZDQ0R+SVTU/ak7GTmh7?=
 =?us-ascii?Q?+ExrWOGNmJ7dysvrlA5RQgErVnOPJ19YlvQbPgrLh3PHW1VtwPiYEGCL6cA5?=
 =?us-ascii?Q?Hllwo8eV1eMWLnDamW6CiPoOJe74fnGitpTxyi+bOJTmMW4qUbZkdnPFIhlD?=
 =?us-ascii?Q?0SRRuM+TOm81r4aVBx2v8t7Y1Zg2MVQY2V+6CjNGY2nTUV7Ls+SXI0CWO3vn?=
 =?us-ascii?Q?5PyP0rrpQJN45p8iSsiXw5nRcc7NtafJB/Jd?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 21:16:53.4891 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cccc3e0c-80eb-48f3-95c3-08dd9e2cf825
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7626
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

to get migration pages. dst bit MIGRATE_PFN_VALID and src
bit MIGRATE_PFN_MIGRATE should always be set when success.

-v2 use dst to check MIGRATE_PFN_VALID bit(suggested-by philip)

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index f0b690d4bb46..a41db1009f58 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -260,17 +260,17 @@ static void svm_migrate_put_sys_page(unsigned long addr)
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
+		if (migrate->src[i] & MIGRATE_PFN_MIGRATE &&
+			migrate->dst[i] & MIGRATE_PFN_VALID)
+                        mpages++;
 	}
-	return upages;
+	return mpages;
 }
 
 static int
@@ -447,7 +447,7 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 	svm_migrate_copy_done(adev, mfence);
 	migrate_vma_finalize(&migrate);
 
-	mpages = cpages - svm_migrate_unsuccessful_pages(&migrate);
+	mpages = svm_migrate_successful_pages(&migrate);
 	pr_debug("successful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
 			 mpages, cpages, migrate.npages);
 
@@ -688,7 +688,6 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 {
 	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
 	uint64_t npages = (end - start) >> PAGE_SHIFT;
-	unsigned long upages = npages;
 	unsigned long cpages = 0;
 	unsigned long mpages = 0;
 	struct amdgpu_device *adev = node->adev;
@@ -748,9 +747,9 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
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
@@ -764,7 +763,6 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 				    node->id, 0, trigger, r);
 out:
 	if (!r && cpages) {
-		mpages = cpages - upages;
 		pdd = svm_range_get_pdd_by_node(prange, node);
 		if (pdd)
 			WRITE_ONCE(pdd->page_out, pdd->page_out + mpages);
-- 
2.34.1


Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3359A606A319
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 00:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=v+M9KV5w
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A633410F116;
	Tue, 20 Oct 2026 00:31:09 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013055.outbound.protection.outlook.com
 [40.107.201.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0FD410F0F2
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 00:31:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jIq0fGYPv0Sd3OmHrfXt3tQAHOUJIGmboNeK561TwckW8xNv1KOoN5ks+cV5+7YtNvmOqc/nbRM18tT6ozSE9B7vqBcYohHl8C9eJYqZm5XD37cJJBCw9jO7RTyvscvEsVcTEp5KoNvDYn5FKr9i0JHg1QvUUuj+tF5q+/1bjd9VpM0QqNlJudzPiMV3Pcj58cW+ca1FLfLy0R9Ivv2P+otpXlmqVb0VjVppg8hi+VpxrBbJtEY6gHtp2Zq5TVCHjjtwvKNJTBnMqa71D44AgJ2Ky6nTX6pzSlbGcrFacMMXQz/Wi60C5rj4mn9JOEz7/Sd1ZPmd3xMkZsT3YO7CPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nxiN8TINYKUEMSD6b2e3oG3Vr/qXxDYn0rQXX0Wd3vU=;
 b=LI+e1WS+GPgqGMXsGKQzYEsA4CSIjQsyCPVRfi5j2sMlFlOf4WY1Ssngcwz5dNmy9+/2XNgJ4W7X2s1orZDR3X2iDcFGrXFqfFwReUhhuAZq8xYrzcZZiodJ1JLcE98v8LWuEJ0iTVZGx9o25PTGCdcQZ1yh/ySJG/99AQyqJvctn5Y8tM+iRpN6A5XwQuBHAAXOA3xzbeM/SbebqzqYD35g4j+TiMRdGFmYlpdPj3F5gL18VeremmYi+iqj5lYhM19nOmZ0G+UX5nUPRw+4sGzkNP99ZegQ9Bi3UInBo3u9+mfH6ON+O7XSsBDyIcj3Bmqj3eozWBf5HzH0OMIBog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxiN8TINYKUEMSD6b2e3oG3Vr/qXxDYn0rQXX0Wd3vU=;
 b=v+M9KV5wK4+lFMVotE2fCptZyfh0slm3M/9wqxTr3o/+NQD03/6fjV/tLS61UhJ1vvUiW6l9m2bJZ8mQ0LCswJgY95WaVtJ4gj/7K1bOaihtscdxEbM4b77D/I8PlPW4AXDND0BdaFFRvNJAyiHO2MkXxqAoBVtif0xoaR9JAbo=
Received: from CH0PR04CA0051.namprd04.prod.outlook.com (2603:10b6:610:77::26)
 by SJ1PR12MB6291.namprd12.prod.outlook.com (2603:10b6:a03:456::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 00:30:58 +0000
Received: from CH2PEPF000166BF.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::70) by CH0PR04CA0051.outlook.office365.com
 (2603:10b6:610:77::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Tue,
 20 Oct 2026 00:30:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF000166BF.mail.protection.outlook.com (10.167.252.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 20 Oct 2026 00:30:58 +0000
Received: from tuf-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 19:30:59 -0500
From: Apurv Mishra <Apurv.Mishra@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alex.Sierra@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <Xiaogang.Chen@amd.com>, Apurv Mishra <Apurv.Mishra@amd.com>
Subject: [PATCH] drm/amdkfd: Don't reuse a VRAM page that is still referenced
Date: Mon, 19 Oct 2026 20:30:39 -0400
Message-ID: <20261020003039.369579-1-Apurv.Mishra@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000166BF:EE_|SJ1PR12MB6291:EE_
X-MS-Office365-Filtering-Correlation-Id: 83c82c6d-2db2-4957-4aca-08df2e416953
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|56012099006|11063799006|261009223027099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: a+V9cmfmDpf0MTtolVPS63L1LmO3gXfmCtIumgWeT6qgZYyRhuAxXc2AYIcIY52XXs80T+bBHurZJNZ/mVFCJSS8MYblYcmTdSd41urHcpEP0JF0WT8fFY9j4tlMgs8eNCNV/LQAW1ihg5CafUuecFP4+eqRhxkneJWqxWaqqkgCKz10OT/byVIWeQnGxni5QsE9Rw3X9XBi4HItQ3vbkkqIpnbzCCvkdvrHYV2TF8bAsKJfCmygvxyIygy08G686cp/IX/x2T/30aimuFZdjVhjPh+WbiFY7kW4Mc5eDitoK+ctAsG0c/6s+ImJoS9BIueaY/SIbsSWmPKsbv4l1uS9aRDy9FnNo1DeLwsLKmTXpGIfMfVeWCvqrM5M+8vFtPwyxAfrGZuVmnv0EfrYr6giQjTpL0miqrfhnCM9O6Ez+CLiqmYY4XiUj2vr72Eo9bY5icGkESi5q8YONRRxAs4MvPKntjFFCz3X4OTroLAK05NdRbPQEJ2saCWPVfR87H/7GkTkDttrve2ftKBQw2NBg2cW8GIhjHXQJD0mWu9AopaBs0cfqxBtg7vK6EltPPC2dVPfcnK3sOEL2bGu7U93I067RG6MRftRNPJZ0QrC/HkrTp0MzTZl5wWMISTh+fE8eRMEbSU4dAQi/PqyizGPfbWDHQCvdtzLu23MCw3NsdxTsjChO1S1Crsi0aNw4qZo/ghWrr1bVGFh4JUcFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wb71U4gNMDGyEEm5LWXukfiY/s4DN+qc1JYtmXnJuI7xEnGJJkkU/YU80Yf8ImHeBCUebyZy58v01gQyNlFj+aAi1ZBNgJlLX+jNVFUnx0MFFfPAVfRTpt6mZJ4D5mE+ug5WrPcRAkk0d8pctO7pIC1df1g5zWZh4pEQyAEp+/7dvri0AVOcPS50QKpPr8iD4FOgo5VQ5W9MNRNsbqJkBSBUgHrp1BYwtzReUtky01dTXR13N0VjIH5mKWx3dXVhPToZcn2Khm7Oyf/9rL6ZIQBoUTFc0hRHcVdd08ZwRw33erxYoPy+3JiSEqWGCQ/MVPCFBugm9gBvQNq7OC7k86hTTpR8S3+IDFqduwoj6EJ7re1T6rY6ZEYyJkdgIK6a4iSd577qB+KjPAqW0d/mP9nSwJajtJJQHF57afNvXdtVE/EGyKdNN2Xfk0K5m+QH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 00:30:58.4158 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c82c6d-2db2-4957-4aca-08df2e416953
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000166BF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6291
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In svm_migrate_copy_to_vram(), skip VRAM pages with a non-zero refcount
and leave those pages in system memory for this migration.

When an svm_bo is reused, a VRAM page can still be held by an in-flight
CPU fault (do_swap_page -> svm_migrate_to_ram). Migrating to VRAM then
re-initializes the page via zone_device_page_init(), resetting its
refcount. The fault's late put_page() frees the page mid-migration, so
migrate_vma_finalize() never restores that PTE. It is left pointing at a
freed system page and hmm_range_fault() hits BUG_ON in
pfn_swap_entry_to_page() (swapops.h).

Signed-off-by: Apurv Mishra <Apurv.Mishra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 8b96e1fe741a..1eb92ac6eb05 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -297,16 +297,26 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 	amdgpu_res_first(prange->ttm_res, ttm_res_offset,
 			 npages << PAGE_SHIFT, &cursor);
 	for (i = j = 0; (i < npages) && (mpages < migrate->cpages); i++) {
-		struct page *spage;
+		struct page *spage = migrate_pfn_to_page(migrate->src[i]);
 
 		if (migrate->src[i] & MIGRATE_PFN_MIGRATE) {
 			dst[i] = cursor.start + (j << PAGE_SHIFT);
 			migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
-			svm_migrate_get_vram_page(prange, migrate->dst[i]);
-			migrate->dst[i] = migrate_pfn(migrate->dst[i]);
-			mpages++;
+			/*
+			 * A reused svm_bo page may still be held by a CPU fault.
+			 * Reinitializing it would free it under this migration,
+			 * so leave this page in system memory.
+			 */
+			if (page_ref_count(pfn_to_page(migrate->dst[i]))) {
+				dst[i] = 0;
+				migrate->dst[i] = 0;
+				spage = NULL;
+			} else {
+				svm_migrate_get_vram_page(prange, migrate->dst[i]);
+				migrate->dst[i] = migrate_pfn(migrate->dst[i]);
+				mpages++;
+			}
 		}
-		spage = migrate_pfn_to_page(migrate->src[i]);
 		if (spage && !is_zone_device_page(spage)) {
 			src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE,
 					      DMA_BIDIRECTIONAL);
-- 
2.43.0


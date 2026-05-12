Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0DBACD4F24
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2026 17:50:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A16510E58F;
	Tue, 12 May 2026 17:50:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QzHX95bm";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011071.outbound.protection.outlook.com [52.101.57.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7989910E58F
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 17:50:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yZddWTdae2+nCk4P2r1qCIx97CVpqbiqzmVw1R50NdTOPL+pJoWpV9Mqay+pwRcmSp/2Y2m76nKAyi0CEVglkqO29xesc4Efk+2usrPHWsC2FoMNwOkurIrgp1jx4XYreaKagqVXfBOqcChCLK8u9ojTGau/kY8tocnBglDeG3Xiqqqz5Cyf73jpEn0x/ujMwfqjU4foT08AjRZLcfODoIoz1ckDIv1/HHjMO6Q7i30tjI86lETqeE82Dd/pC7SU5p6Yt1ABhblxx8YqYZEmmiCW6DEXu7+NAo7ywQ7Le8e5b2lI+qov23Gz4GI+c/6qs4kt3fmR1ZLO6sGZoz4MOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JP5JfXHM+vcCl+2OnR5VQoH+tdwWw0bPkb6PmYKMzuU=;
 b=fJ5WdzUIDYyKnzwuj18C2u67Al4c+3JQ62RZdHkpTqUMJH2N4D0sj10Wo4/OBgravUMsfSmiTB9KaSbKGJaNiJZkBLP77Lin6vQZn3O88roZI2B8ueEQhZCe65Vp0ljn8q4Q5tCr+1BUG1oLWhxsZsFIEbvJ8ZEiAmd0D9GktQ5LmRj+4W4E6iJBKi8huY7t5QVzrAOtGFy64Nq1lAuqb+yVbInGCnOiMsaI2sIc5FDBya+7//58gD+fD23wq2H0xr7Y59EOifGvFGaNa5EeUT0yzjYUJ3WAYRSmdXkqHWs4z3E/j3USDkqojYD4NcOxUGUTotNMOdSb/PHMY8H1Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JP5JfXHM+vcCl+2OnR5VQoH+tdwWw0bPkb6PmYKMzuU=;
 b=QzHX95bmfHFQLCSXdtPrmYxGyabUwOMzkHcDMEWEhy+7I9Rgpmr4Z6+EIwymhfs4nGb5RfYzycnWgII8Dt+CQSYy6rc79zXDTWBKv7/kaD5efqEOe4cnD+0nlRioSM/RdSqBqwMieHrvSDL44Xzln2zrPj1aH+bQ6jiN7MvFpnA=
Received: from BN9PR03CA0232.namprd03.prod.outlook.com (2603:10b6:408:f8::27)
 by DS0PR12MB6582.namprd12.prod.outlook.com (2603:10b6:8:d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 17:50:12 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:f8:cafe::94) by BN9PR03CA0232.outlook.office365.com
 (2603:10b6:408:f8::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.11 via Frontend Transport; Tue,
 12 May 2026 17:50:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 17:50:11 +0000
Received: from 0yonsun-linux-dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 12 May 2026 12:50:10 -0500
From: "Sun, Yongqiang" <Yongqiang.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: "Sun, Yongqiang" <Yongqiang.Sun@amd.com>
Subject: [PATCH] drm/amdkfd: fix signal page mmap PFN for GTT-backed event
 pages.
Date: Tue, 12 May 2026 13:49:57 -0400
Message-ID: <20260512174957.357982-1-Yongqiang.Sun@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|DS0PR12MB6582:EE_
X-MS-Office365-Filtering-Correlation-Id: 4357efe8-43bb-4ccf-2fce-08deb04eea3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|11063799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: CHmwyTSOogsYAb4zoI7SQsPTaabqRRgTBIC0f7sMx7/JRBP/ic7IdcD5nBbFBgDfPO9c8Qxppp2rtm/lQlNaCV+5FqSyNqec35hlqiu1csCITCyaPgygObnlJgdguvS6+ea8UDKiq2t2nWe1NYz9NoFDe/koJggPU+kr/GY3+dYFIEkrnSVF+Ub0ntVfv8fAYowk0U7p8eG+yhQUIbiiTUV68iFQF1gTY/2hpflOAtHMDW3U0IB5odmu04qA4mJNeU56Z93SB2ZlWnYTmjeQVq7/yYy2cjWYRwSzD7lks+eXByS4iWsSclGWPyZ9bCw/Apad5+fm/vAwNjqo0xI9X7XOg3Av9potpQ6UaKaSOWTlWd7jYv3BO2BXR5Wxa+y7eFaaL65jOFL5cXpUHRmWhsKv1HvX4YWy81aDwa93ZJ3fFZjBqjKCIJHA5W0ci4RbLy1TyP2OJlLCwKLWqjJ6WWc1HhTvzZyG2Asjq1OOi9MoS3kAymjodE2OomjDIkFkmAIRVwwTxKYkGGvuD3hB8OFRlyXh9j7y0SsZivdvaDDhced1+MYCPCqGPKMa7ig2h2V+TJmvqm9zzEdp55UwIRNrZO5YvC6xo7vwqnc8x26yCSGN2TK0wHGYoibTV/3VTv8KPTKfiW775sAg/E1Df7Dexrt3n9cO3gyhgGEXEeJDs8pmYCTlNwdTPjSSKQYtRX+1FPzmktVTSyr5oa7QKzQ5SikULI66R7qRjs/oRF8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(11063799003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wQY7NAlvf6Q5Q4+et0SSX/gRI8S5/ELTuwVHD1YoAm8BPv4RnQe7EHLI2NOTiNP6vGW5oseTQbY0KQgo/6ZbjagBELQ+J8Ovfm9qC8Cdt1pgeBi/7s3g6F3xSZ9HsvgS4QgeFQyY0MXWNJpgGrwBzmQdBy/q6/63yrbLZfUZIkuuogD+rxhbyyvgcSRhOme3UD6SC8jMYkQx/uQ0MKwu1OMTm6ytd69XkBgeZvpba91QdUlVqVgEL5ySUJcv0lp7fSZZefDCqQO8X9Xbsy9AeTh1czq6843ToOlinQFENFaPB8eKJ16RczQCJJzRUGeqjSmRX9n2jQYkoXssKkrk8JVxCs+rQ4PmRhVjH4+IPDlK7O/LuptVfC2z1zcCM+iNgnLpQcAwfmuZQKMEZ5Aq/D0/zxBFNAk2HrLtZCOHTVIMYpRkw9AZcsScpW3YWtvz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 17:50:11.6718 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4357efe8-43bb-4ccf-2fce-08deb04eea3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6582
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

__pa(kernel_address) is invalid for vmap'd GTT kmap addresses. Record
page->user_pfn at setup (virt_to_page / vmalloc_to_pfn) and use it in
kfd_event_mmap() instead of __pa().

Change-Id: I61061ab280850afa776191c30ba90a475afab46d
Signed-off-by: "Sun, Yongqiang" <Yongqiang.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index e9be798c0a2b..6e0beacca81e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -21,8 +21,10 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  */
 
+#include <linux/mm.h>
 #include <linux/mm_types.h>
 #include <linux/slab.h>
+#include <linux/vmalloc.h>
 #include <linux/types.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/mm.h>
@@ -54,6 +56,7 @@ struct kfd_event_waiter {
 struct kfd_signal_page {
 	uint64_t *kernel_address;
 	uint64_t __user *user_address;
+	unsigned long user_pfn;
 	bool need_to_free_pages;
 };
 
@@ -82,6 +85,7 @@ static struct kfd_signal_page *allocate_signal_page(struct kfd_process *p)
 
 	page->kernel_address = backing_store;
 	page->need_to_free_pages = true;
+	page->user_pfn = page_to_pfn(virt_to_page(backing_store));
 	pr_debug("Allocated new event signal page at %p, for process %p\n",
 			page, p);
 
@@ -349,6 +353,11 @@ static int kfd_event_page_set(struct kfd_process *p, void *kernel_address,
 	       KFD_SIGNAL_EVENT_LIMIT * 8);
 
 	page->kernel_address = kernel_address;
+	/* kmap for GTT is vmap-backed; do not use __pa() on kernel_address */
+	if (is_vmalloc_addr(kernel_address))
+		page->user_pfn = vmalloc_to_pfn(kernel_address);
+	else
+		page->user_pfn = page_to_pfn(virt_to_page(kernel_address));
 
 	p->signal_page = page;
 	p->signal_mapped_size = size;
@@ -1087,8 +1096,11 @@ int kfd_event_mmap(struct kfd_process *p, struct vm_area_struct *vma)
 		return -EINVAL;
 	}
 
-	pfn = __pa(page->kernel_address);
-	pfn >>= PAGE_SHIFT;
+	if (!page->user_pfn) {
+		pr_err("signal page has no recorded PFN\n");
+		return -EINVAL;
+	}
+	pfn = page->user_pfn;
 
 	vm_flags_set(vma, VM_IO | VM_DONTCOPY | VM_DONTEXPAND | VM_NORESERVE
 		       | VM_DONTDUMP | VM_PFNMAP);
-- 
2.43.0


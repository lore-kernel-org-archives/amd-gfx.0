Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A930C5B572
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2026 14:00:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAC8910E7D1;
	Mon, 17 Aug 2026 14:00:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ec/EwQXA";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012055.outbound.protection.outlook.com
 [40.107.200.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0953010E7D1
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2026 14:00:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQNtV2v/lSmjcSgQtWCd7ZTQ3TUKqyBHSY1CMrfEY+K7mX/G9axNw4mYZcF+2EaaCwy6/bJ65VHEo3EZ/VMdZ4uDUUFsaP0a+g8IxpqjqNJIEA5UuSzU6STIGrlt0EWYImWg+nzlE2MsEk7XmBFCIBhIZUf+zmTX8UhJcb/20NiZuyD5MbPBk1AWK5hs42T/pCi120hJFn8BcsCFm4e0pnNj/kinhcaUxz+cn/UK5wDSeZCE4dEUzprPrSUHmUopDJMRKjuziyCBGsjPWPUkzJtSGeg2Re7fSGP4+Es6YUo9GA8I9UnXuYTFJoRYtvLTX6vsZ9/uW7KLk+SWQ1EWRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+rxmrnLj/DuCxDXeepGHglyZ1x3VG8PPcqHB8SwtH8=;
 b=ptqx6l+W5MxHjA6x+9xCZca/vvTk5BPsNGYjasE8XTY/BudC5GEnH8U6Wcm1OoUe+1k6FyOtGiz1qQnQVmnJ3EOfTo7FloJ8FRWKgQtJF6WcGStzfK813GQhxPtz4c3rvrgn5ramXkq3hcCnMzvz26ar+vOBKT8GjwnoE+NDSeaHB+1XFS4GkU3Izv8+tXqyPANiGDzW55T2NPTYTiHNUuYdy5s/1SZjtPC8V7HsMmK0bVzz0ycVOIZIcra69HyGSRYkHkHNtiS1qryhi0P4ZPBtjTMvo+6ITAZpqAWdmGCllXgbX3ghkDhhA5Y8bOl9V6unmJQ5FRGqjkz4aIwU7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+rxmrnLj/DuCxDXeepGHglyZ1x3VG8PPcqHB8SwtH8=;
 b=Ec/EwQXAOQgbe9KXvV2Lk3xVfmb3vg1yu5de66kFiokeYWvnPPxTVfR/9FMw1SEmjd9usjcU9fhV5YeL6PseqRv5rLleqPSqYgRhxbF8Rj3yEvIzVWDKS70dPusqPE5OUEXFAcURKq3zy9ZGSEFju4yq26TlC8Sn0b20G6deDKI=
Received: from DS7P220CA0099.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25d::18) by
 MW4PR12MB7333.namprd12.prod.outlook.com (2603:10b6:303:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 14:00:27 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:8:25d:cafe::a9) by DS7P220CA0099.outlook.office365.com
 (2603:10b6:8:25d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Mon,
 17 Aug 2026 14:00:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Mon, 17 Aug 2026 14:00:25 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 17 Aug
 2026 09:00:25 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 17 Aug
 2026 09:00:25 -0500
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45
 via Frontend Transport; Mon, 17 Aug 2026 09:00:25 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH 1/3] drm/amdkfd: Fix error path at svm_migrate_copy_to_ram
Date: Mon, 17 Aug 2026 08:59:16 -0500
Message-ID: <20260817135918.228397-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|MW4PR12MB7333:EE_
X-MS-Office365-Filtering-Correlation-Id: 62b2d557-f27f-4079-6fd4-08defc67e35c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: PVdrk5c7xs7IXtmS0zEwlXfbVCOZMnP/CLUXkAAX8d+1AzD1KtR4cERzntZuNSc0ZLZEfJ5GJQhdZpu+AtOJTczQAhA5kYos3eGvJ2ronDkxbcEgyTDNjdErUM8/klDHhS36980nmw1xQfZg9ytapbne/33/BwtTU71Ymf1C8avubdq0hekBBa8Bm9u6BRchrPVpDVfHA9GOEngnwAfYwCwoUAto/ayLG3/R3H+DnkbA7mAkLPeKTy3GvROtpYygSiKGn3tD+NI52c3H01tkD8LqfYON4aAfB9elVJO9UzG2n1eW4D2TparNdwuNMIP8K8a+UhHeEURRFGd1WDqS/8OLaQp5LqpArs4TsiJGnEWo1DtAzAzAM9AEEAXM+PwvU1LocuVQBeFxkI+O9xWZDVy8z+8kxBeOoObNKdcz9BHC8XnS1J9wjJiRy55knXAiL3Qp+TS4zABifkOPeKiq9CBdQ6cxwfWpcUjFvYSXfRO7jAnEKxo52BhTV/PVcbWaRuZ+P/FkZb66jXMhZzlz8Uqa8WL4lOuVNKbUk/HEi70iXt1l8lkqRD4idoOib/pQ6dnYMFprBRJaP/smrwcr0/0sQudMPPFORyYUGAMisPByCa1cNFm6z2gNqIiNm59U6atCIjnTdD8UhPgQcxi9K/hNW5eAEN2xWvEgG4Ir+IS6SRh5whb9JdTiXtVZJYBwqKySBX8R3dsSCp+G6WQDww==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oItbPDZQqBUGOaehwzBcl+aqo6/mfjZjwJo/m40o1dwsrkbatiyu85SeUxQvfynEoCv66ONN8c7re37BL8zSEwaN2pNPuuJlgumSyByP3LdoeExlvM/mYRnsQPL2GZXx+uB+6rMPH8HibAascSGMebSbhIvcqvsgCVf2RTqC5VqTzk9mxY05TjHmHjOMaqitQcu74z82pZY4r0CkmWcu3oom9g/3iCkgfkgHNpnMupdN7tCSg7C43pmxAI0uIh7vRSB/JzcrjkF5nIPF4d/293Nt+roZ+dvuIo60mmNhEwStOzQDUd5igy9mi4PsZ4GpEaOGYhdU7LnTJ5YwDZNRAgKf3JA/3HAbQszaBL6HMvEgPV+lPJuA+f+bAeKelHzz+q98kh4+Q/XnZ31C7Lpmhjl4lcmyh9g//JoGOApz1dKvmTPUXllSvrPDxv9OV3Mi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 14:00:25.8695 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62b2d557-f27f-4079-6fd4-08defc67e35c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7333
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

If page migration from device to sys ram fails for some reasons driver needs
release and unlock allocated system pages. To do that driver should use page
physical address, or pfn, then get struct page*. Current driver uses dma
address(for adev) that is not correct with IOMMU enabled, or even in general.

The patch releases and unlocks allocated system pages based on where migration
failed by struct page* of sys ram pages. Also dma_unmap correspodent system
ram pages at error path.

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 46 ++++++++++++++++--------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 226e76ae0be7..aea82da5f575 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -258,15 +258,6 @@ svm_migrate_get_sys_page(struct vm_area_struct *vma, unsigned long addr)
 	return page;
 }
 
-static void svm_migrate_put_sys_page(unsigned long addr)
-{
-	struct page *page;
-
-	page = pfn_to_page(addr >> PAGE_SHIFT);
-	unlock_page(page);
-	put_page(page);
-}
-
 static unsigned long svm_migrate_successful_pages(struct migrate_vma *migrate)
 {
 	unsigned long mpages = 0;
@@ -591,9 +582,10 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			dma_addr_t *scratch, u64 npages)
 {
 	struct device *dev = adev->dev;
-	u64 *src;
+	struct page *dpage = NULL;
 	dma_addr_t *dst;
-	struct page *dpage;
+	u64 *src;
+
 	u64 i = 0, j;
 	u64 addr;
 	int r = 0;
@@ -647,6 +639,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 		r = dma_mapping_error(dev, dst[i]);
 		if (r) {
 			dev_err(adev->dev, "%s: fail %d dma_map_page\n", __func__, r);
+			dst[i] = 0;
 			goto out_oom;
 		}
 
@@ -654,17 +647,40 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 				     dst[i] >> PAGE_SHIFT, page_to_pfn(dpage));
 
 		migrate->dst[i] = migrate_pfn(page_to_pfn(dpage));
+
+		dpage = NULL;
 		j++;
 	}
 
-	r = svm_migrate_copy_memory_gart(adev, dst + i - j, src + i - j, j,
-					 FROM_VRAM_TO_RAM, mfence);
-
+	if (j > 0)
+		r = svm_migrate_copy_memory_gart(adev, dst + i - j, src + i - j, j,
+						 FROM_VRAM_TO_RAM, mfence);
 out_oom:
 	if (r) {
 		pr_debug("failed %d copy to ram\n", r);
+
+		/* first release current dpage when dma_map_page fail */
+		if (dpage) {
+			unlock_page(dpage);
+			put_page(dpage);
+			dpage = NULL;
+		}
+
+		/* release previous allocated sys pages and unmap dma address */
 		while (i--) {
-			svm_migrate_put_sys_page(dst[i]);
+
+			if (dst[i] && !dma_mapping_error(dev, dst[i])) {
+				dma_unmap_page(dev, dst[i], PAGE_SIZE,
+					       DMA_BIDIRECTIONAL);
+				dst[i] = 0;
+			}
+
+			dpage = migrate_pfn_to_page(migrate->dst[i]);
+			if (!dpage)
+				continue;
+
+			unlock_page(dpage);
+			put_page(dpage);
 			migrate->dst[i] = 0;
 		}
 	}
-- 
2.34.1


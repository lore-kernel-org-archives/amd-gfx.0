Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6D360A380C
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 17:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=4Wkr+M/8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B13010E6BE;
	Fri, 23 Oct 2026 17:17:57 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010006.outbound.protection.outlook.com
 [52.101.193.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C4F110E083
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 17:17:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=loKD88qIumrVzAPxiirynWUOezbOuKIxv93PyhPeodx8nnD8W4LZ6ywXtoBwTll0vdkrVflvDHhU5SL4mQYectheto4DfrDhpqPRB/iUrI7DjfuwEidcOpTK1np9V6Qabb9oylxypQGVUU4wKe64xQxVWV5QLbnHXAh2t+OKxGJgqPuqxFwXWnPDOWBeVxxUq398hKUdeqjSu8ui631LATGWbNY1iJx7Bpch/99RYT4DAcJN1TqoCvrMpEGpjhc8EyqKE56/tQ7C3rKUCsM3s+s8alkQLIaLkpdRu6dFFnClJR6s2rzik8khrWCl6vSbO3tWZIfXJY+6BO76sDeugg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nxiN8TINYKUEMSD6b2e3oG3Vr/qXxDYn0rQXX0Wd3vU=;
 b=hiJw6KpBEnBWpmCJT0sX8Over58QuZT+Z1njjpQSRTdMnTFBl4vUJiln4XTJI21jfy8KhTwR65cWe79bVajLcbxbRpFlTrZNIIol0RTO1eXFWlAjbU25KzuWFqHRHpih55RLEZ0LY84z5uuBLLvyyYZnUFTagIbu9VEFeQNiLP1QnNxT3N8MQPiFlTaNx9xs1rBsDTE4/HHtKS6Z8eCPvoeOw/y6m4mFptj1dlxk6yN8+ZHGXjOtJTwGeuEiEhiEiSxy/n/KZvm8SYZA+mH4JFlPCC12a/XZmX1q9ykpDzrKQZWT+PFUsruH0wFW4Y9yNEZqNbiC6hg5w5GGIh3twA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxiN8TINYKUEMSD6b2e3oG3Vr/qXxDYn0rQXX0Wd3vU=;
 b=4Wkr+M/8zENiaorALyjJQ0HiL5ipy68vfq2HJ/gN/XjQGQZkznoEPnDmTL5O+jZrjCr2RnobFiW3m66KHeTgT0J1vrAVB6i5AO2/4+G3flVRV41iOQE/Nr8mgDN+dtH8a44+1W5xPPfqhR5I+pVJKzIs8zw4PJOToIqz1n7ImRE=
Received: from CH0P223CA0003.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::15)
 by SAEPR12MB328447.namprd12.prod.outlook.com (2603:10b6:802:209::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 17:17:47 +0000
Received: from CH7PEPF00000019.namprd21.prod.outlook.com
 (2603:10b6:610:116:cafe::85) by CH0P223CA0003.outlook.office365.com
 (2603:10b6:610:116::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.19 via Frontend Transport; Fri,
 23 Oct 2026 17:17:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH7PEPF00000019.mail.protection.outlook.com (10.167.244.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.0 via Frontend Transport; Fri, 23 Oct 2026 17:17:47 +0000
Received: from tuf-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 12:17:46 -0500
From: Apurv Mishra <Apurv.Mishra@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Alex.Sierra@amd.com>,
 <Harish.Kasiviswanathan@amd.com>, <Xiaogang.Chen@amd.com>, Apurv Mishra
 <Apurv.Mishra@amd.com>
Subject: [PATCH] drm/amdkfd: Don't reuse a VRAM page that is still referenced
Date: Fri, 23 Oct 2026 13:17:22 -0400
Message-ID: <20261023171722.46301-1-Apurv.Mishra@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH7PEPF00000019:EE_|SAEPR12MB328447:EE_
X-MS-Office365-Filtering-Correlation-Id: b90a2311-ba94-4f5e-2852-08df31298f20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|18002099003|10067099003|11063799006|56012099006|261021121427099003|261021123027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: fyNWinJ72Ht/TdIfvLZEuzv2D8Sez0bL02bKyK2Zn+0DbqGOtncGJWiDw/mVyg454aL8pxgBdRUZlvQxxy9nnd1dlsMGMjpQGiTCMhDk/w9zRCMlNb7xCrShTaojmxDsAnelHK0XQXzMKsrbSHYBHjZkIas6221vCqgEwVJmry//qm/vGxh0EFTk2pHFC0H/SG1z8k0lfDEEqSxmchWfkAG2djSWALy19OGXOqVWRefLKOnjo8rmTjgXYi+m6xh3z3Z8s4dL19U1TvhW4qag/gQrl028moXJ7EouJOxcefn6IVHLxTmkfMUMiWjWX0BtiyMFZ2q3IuI+ZTz+4twowiW3Q+oc1IwABQUi4pODPEErmQH+eOPbr/oRNPA0OoJnhxslYpnp5nIcbUt5OtM/ksk1ynRQ/nWqr+k6sCg+8hHB3gj2V9mAVDlCZqCTv1e+DyRajv2s2f/CpOd0nmn03JSbdxsX5odI5oERijjueKArA4j0NDuJeyMrne7C1xf38L6mgemZc8XcO+buUW4wfghtz6IcV6hIXuXf3x9+wMn24iQXyedXTSGbH2FZ41FFZEBR9MDidkclQp3Rghyiqe5WqzzucIYCfGlgEl5GiYb4lck9dpEUf85UChgVxCfWy4kIE3LgaUWf1YW5uOuNS9aeeHqZV1hgHgFTwSCRHn8N0rDE94rCuvbemJ89mrq7SEBusfyDVq6RC1xH41WkqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(18002099003)(10067099003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 66IpJA2DZFcY1BKY9EqSYgutI2aS1RvgE8+zk7hU6iYDqpl4HNtl0AQTpLwMwiYgNshefrfIKMMvMALwe0VbGTcqTYNuwMHwVAHT4eEJQ731JS8/1XB7cPMAoSHbK9zXXPmF/d8X695SvfXHygjnAvn960ACdTK/D6zA7EN5pqupU7Ep4MThVls+btlGympNr6PEiepTeeJobo/R8DCIGrh2I0YPseWD6iEJLkmKYTmNmycavwM8QFafcwW8WmTgIBMJ6xB5uHbUqWP7V8w6uBOi1p+UmdBqXtsQ6xx9Q8QNZfq/7CCPGZR7GxtylNs4JtOEKk385a2LUaTynBQWDUO2RCB2GZjv3/oYkpzXJTuBbBQ5/e1KPcc/Y+Daa/2FvUB+P1kXQCaba0HnbP3nLV7DwE9V9ORZ4U6XiHNai2WXMb40TlujjuYr36S++DsI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 17:17:47.4282 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b90a2311-ba94-4f5e-2852-08df31298f20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH7PEPF00000019.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAEPR12MB328447
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


Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FD8C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:34:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C75C161059
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C75C161059
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DA466E087;
	Wed, 12 May 2021 17:34:50 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B65856E054
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:34:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VY1uQtx8q6ATnoeXao7vcrtzj95R6igcXm7m+/unHBBs7eXtskmglas35iFRFDga53Cs6Oq5aF+SkA88X1IokRmbumS0dawIcREupB4hpRKMKQOLQRjyX5rCxI7Vujc0G4tJ9gdKyy137WYoHn7+KvKn0pAqVPvMk7749sC6/9rUupQQSOR9WhmeplkRMvBhxtdMEiFE1z4DDy6zNLyMsexjW64RkIULC2r6PeT9bNqZ/vkUXJHQ76fOhlbW9Q0q7U0xbX/oDPQfg/FTfs9JJ9y9F8FD/DUVCpfFrIezAcJ/OcSxyf0IPURaJMdLJJHeemSZLrh+RC26jtB2eThW7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ik9Ss/rnU5q0pZouGbpUid2xbE/8xwIOcodLAn3baGE=;
 b=QNygmVQ6dbHGYWG9cTGQzirxGHIWF+RNVPY0vjWltapldVYcfqLDHgeRYEnRV5AnCaTFmLD63q36GGkgfQ5dO8GIvyZRquhQgAIvpRI7Tqmo0UmpTnDfr3ribGGT31YfINUpbgcWsOrwHwv/LOlwnpn8HIeTA/R4CXv8HHrFOGmKbYOzuAhogb4J8lmYmrOWzoYTV6x46mVMb3vCHVsFp/GSVpmufoV390iLvNf8bOepQQc8AShq9hWG1pOqNMaULvIK9UKDq4ik1SqJHwANq4ekpf5d52foL/5H8+KpkbGbtOaahPxijMP+tJVsOaQK1r+xqWfO7eBkVyEN4cNQrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ik9Ss/rnU5q0pZouGbpUid2xbE/8xwIOcodLAn3baGE=;
 b=O3p/Smk1PsFjVJdhMrD/7wiUE3BSMNJaRa+RFnQC4ZuSrM/UaVwBktadI5/IU73jJNYTGOQJDOtl/LFYLdPkS1jy7qUt2pCSZDVJSCVjqLu1h9W39m2apOw8arIaInDmEfTumcGZgtIzqoqNdjr1BfAmyriRcfKvyzgmkHKkkoA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SN1PR12MB2415.namprd12.prod.outlook.com (2603:10b6:802:26::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Wed, 12 May
 2021 17:34:47 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::31de:f08e:20b2:d121]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::31de:f08e:20b2:d121%9]) with mapi id 15.20.4108.031; Wed, 12 May 2021
 17:34:47 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdkfd: skip invalid pages during migrations
Date: Wed, 12 May 2021 12:34:28 -0500
Message-Id: <20210512173429.957-2-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210512173429.957-1-alex.sierra@amd.com>
References: <20210512173429.957-1-alex.sierra@amd.com>
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SA9PR13CA0056.namprd13.prod.outlook.com
 (2603:10b6:806:22::31) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SA9PR13CA0056.namprd13.prod.outlook.com (2603:10b6:806:22::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.20 via Frontend Transport; Wed, 12 May 2021 17:34:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 862fcb26-5cae-4251-bcba-08d9156c3d05
X-MS-TrafficTypeDiagnostic: SN1PR12MB2415:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB24154E88F8BA605F794F6FBDFD529@SN1PR12MB2415.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ya+jJzKzAi/wkpmH0wjQX4f5pHnjRSa7mAAJLh+sTBFMJFvkj+Kd7MJlVGV54w0jxSQDxTp+9/Q4dR2W5+zU+90tgPzpneWve629eY23+VR3VYIIrps8ORvZRXe0Zg51z2VwOtIaxZk2aDlTXn757UUyXltaTj9nTp30Sk9lyQ0WSKCGF3gBL+5BIKeUxjkeU7Yg/lEViq4vg7jp0fDV8LdZ9AeNKu6BoLizrCmxqQGL+yuxrVrGrf7NnRT39nVvTcbGlZEgqaWy5FSinETcSjPiBC1J0skk5B1LFqENwidEZYBqyqQ8RSErviL56ClN1lkYSOpMjiYTMBLpCqO8r0aHUkPxnag6P27W2ZsPpFN4CaBjwN6gOH4XoVtRHsaaC9rvpFhix7DIi5o4xBmBeF0OXkgTgfKPiVWggIn1Y3nLz7GHIXjKDxXFsWqTX88+LBHjfW15LEGLz8+panNMLn4u0epq/vlPhGvAtbN41dNPvSM7CFyvMWqKdWD1mhOvyqFOyMu2UK4PomjgiE8Fy0rEiCuNbmUw+CiUGIBD0KOm8HjA+xifoJuyvAjzPI6nC++QqM91VHBLXNhi/r6wtchnFlkF+cLI41XrHTwldlY+6KhGPNy0vVWRIY1PyWSZKCbVphw/sK2svkXN0Wp0h10px6OndCCdRzBD5oxxRqc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(1076003)(16526019)(26005)(8936002)(4326008)(38100700002)(186003)(6486002)(8676002)(83380400001)(2906002)(66556008)(66476007)(478600001)(66946007)(86362001)(52116002)(44832011)(36756003)(38350700002)(5660300002)(956004)(7696005)(6916009)(6666004)(2616005)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?p8GcDyKLKZrbU+5lsD8ZwzFoCxsn3sWyXpBEqPknAE2DhPIaBg/PicU+ULej?=
 =?us-ascii?Q?LOn8tCQVHfLz6A/5NLHXu783sOvfk08GmW5F0vYq8xboBzVx+2rRp5klQw/N?=
 =?us-ascii?Q?AYVke0hCo0FMtZ08z9cXtg2PupzSDxTjBbLWUeXc7C8a9KiwqHJKA+Y0+RYt?=
 =?us-ascii?Q?jiafO6mUYVhpP+bpHXOI/GpTwzy4LDqbBOcHduM8mJ2kjP/zl27QZtxNpbvt?=
 =?us-ascii?Q?w9cTiVjgwN6kmfrAoEAQcQV5k5ivtNuXSvKH6Ep9P6ae+WhRS80zpgR9Yf7i?=
 =?us-ascii?Q?w6HZET2SyopWGt/FwHIiZnsFH3d4A3mxKXio7e4VYv6FiILZ+IMzu0XGcEZQ?=
 =?us-ascii?Q?7lpryFzt7w+LPIlr64T0Q/+B8PlyW6/GKSawj9UgLroxQp7STKa2YWiJ/rcN?=
 =?us-ascii?Q?JnNW1ZZTZtOZWLz9fuaQv8AI3xzv2ftNg3TnGtaLt4uHpdagMRWpaszDKn/1?=
 =?us-ascii?Q?GEPN9HZP2srWDhTZ6QOAztQsoB5QsoZIwB5Sd1FRudGx484nLoVE+J/BYX3G?=
 =?us-ascii?Q?6k8Mwcfk/vaUEbaWrb8K++wD5VtSNuSR1ASRAJNwE9Nps9S/xI3X75WBFjWV?=
 =?us-ascii?Q?CsqPgE9AfajKSOa83fHWVs8qGT1Ph2e9wPavdv6L9HI2JnxJ40phoPC11Vz1?=
 =?us-ascii?Q?DmgCXMW1jrX+2duofR5UcJlpnT7YujFm/Vnb3422Nvj90dirNVe+uXpGSJyP?=
 =?us-ascii?Q?eruRpuuuiYeFXgie+Dmj8HMUF9poEYcrcet3PUZ/K/Ug/PgIrm/tmPBzx8JZ?=
 =?us-ascii?Q?SVy1ZSIPLYdU3Me4SKHWBzr3CMhwLby4QSSpDL8fuLu3Su4yT6O+7FNwGtjj?=
 =?us-ascii?Q?k2+PMYxyOCpKT7esZGc40r7FJz5MT4JthdxPZa6qaoz5SYQ/oOEGnnHG4KB8?=
 =?us-ascii?Q?CDpUmSIWJ7tZu93Cy+R+4afk5ZRbkKfTlWjjO81x4jCOheenEByPATFyW9ms?=
 =?us-ascii?Q?FhPQFU6R6MXRyyIXjJcGiIcDvkLPPtosja4Ihk72ouJ/1zMa1JpqaLPQBhXe?=
 =?us-ascii?Q?1Q0oxY7tCg7rW+XXbF22HIIymV8F2styfRgeRwzuFT7Bw0dgjOrSjlZZPhpT?=
 =?us-ascii?Q?Xo5Mo5+MTbMwhJA6Jgv3i8jQHsNpOayAY5teYMj9X1ky8nlCeQWuRdXDGmEY?=
 =?us-ascii?Q?eoBr36DdZ9MZQ6XZzeCM9urpnxIf+AhTFheQNMCPD4zvxF7/n4iQdM4SSoeJ?=
 =?us-ascii?Q?Jy8KBXAuW+RGEKeQBxAmpiQZi80Q4t9ndNf/ELp1gqcdTo/sirLXj6VZ0Ea7?=
 =?us-ascii?Q?T4rlpV/wV95DddK1UCGIiI7tOGfR78SiHGvYZJQKPz3D6bIVoflnuuUzfpF5?=
 =?us-ascii?Q?5yBSlU3FyAiLwyhNMSbDQlrq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 862fcb26-5cae-4251-bcba-08d9156c3d05
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:34:47.6223 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: njdIbo/z979ZyGfGlWYLPEEiC9JDTJnFCQOMnpibZqpdfO4Zk3Va2zYCw9N5xMZ8XBZoIjrw0dV3Ka7Ydg8Eaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2415
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Invalid pages can be the result of pages that have been migrated
already due to copy-on-write procedure or pages that were never
migrated to VRAM in first place. This is not an issue anymore,
as pranges now support mixed memory domains (CPU/GPU).

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 36 +++++++++++-------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index b298aa8dea4d..e1cc844b2f4e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -419,7 +419,6 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 	size_t size;
 	void *buf;
 	int r = -ENOMEM;
-	int retry = 0;
 
 	memset(&migrate, 0, sizeof(migrate));
 	migrate.vma = vma;
@@ -438,7 +437,6 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 	migrate.dst = migrate.src + npages;
 	scratch = (dma_addr_t *)(migrate.dst + npages);
 
-retry:
 	r = migrate_vma_setup(&migrate);
 	if (r) {
 		pr_debug("failed %d prepare migrate svms 0x%p [0x%lx 0x%lx]\n",
@@ -446,17 +444,9 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 		goto out_free;
 	}
 	if (migrate.cpages != npages) {
-		pr_debug("collect 0x%lx/0x%llx pages, retry\n", migrate.cpages,
+		pr_debug("Partial migration. 0x%lx/0x%llx pages can be migrated\n",
+			 migrate.cpages,
 			 npages);
-		migrate_vma_finalize(&migrate);
-		if (retry++ >= 3) {
-			r = -ENOMEM;
-			pr_debug("failed %d migrate svms 0x%p [0x%lx 0x%lx]\n",
-				 r, prange->svms, prange->start, prange->last);
-			goto out_free;
-		}
-
-		goto retry;
 	}
 
 	if (migrate.cpages) {
@@ -547,9 +537,8 @@ static void svm_migrate_page_free(struct page *page)
 static int
 svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			struct migrate_vma *migrate, struct dma_fence **mfence,
-			dma_addr_t *scratch)
+			dma_addr_t *scratch, uint64_t npages)
 {
-	uint64_t npages = migrate->cpages;
 	struct device *dev = adev->dev;
 	uint64_t *src;
 	dma_addr_t *dst;
@@ -566,15 +555,23 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 	src = (uint64_t *)(scratch + npages);
 	dst = scratch;
 
-	for (i = 0, j = 0; i < npages; i++, j++, addr += PAGE_SIZE) {
+	for (i = 0, j = 0; i < npages; i++, addr += PAGE_SIZE) {
 		struct page *spage;
 
 		spage = migrate_pfn_to_page(migrate->src[i]);
 		if (!spage) {
-			pr_debug("failed get spage svms 0x%p [0x%lx 0x%lx]\n",
+			pr_debug("invalid page. Could be in CPU already svms 0x%p [0x%lx 0x%lx]\n",
 				 prange->svms, prange->start, prange->last);
-			r = -ENOMEM;
-			goto out_oom;
+			if (j) {
+				r = svm_migrate_copy_memory_gart(adev, dst + i - j,
+								 src + i - j, j,
+								 FROM_VRAM_TO_RAM,
+								 mfence);
+				if (r)
+					goto out_oom;
+				j = 0;
+			}
+			continue;
 		}
 		src[i] = svm_migrate_addr(adev, spage);
 		if (i > 0 && src[i] != src[i - 1] + PAGE_SIZE) {
@@ -607,6 +604,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 
 		migrate->dst[i] = migrate_pfn(page_to_pfn(dpage));
 		migrate->dst[i] |= MIGRATE_PFN_LOCKED;
+		j++;
 	}
 
 	r = svm_migrate_copy_memory_gart(adev, dst + i - j, src + i - j, j,
@@ -664,7 +662,7 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 
 	if (migrate.cpages) {
 		r = svm_migrate_copy_to_ram(adev, prange, &migrate, &mfence,
-					    scratch);
+					    scratch, npages);
 		migrate_vma_pages(&migrate);
 		svm_migrate_copy_done(adev, mfence);
 		migrate_vma_finalize(&migrate);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

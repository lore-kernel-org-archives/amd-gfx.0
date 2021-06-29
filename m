Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F98C11F67
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 18:03:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E641861DD7
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 18:03:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E641861DD7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5278B6E8E3;
	Tue, 29 Jun 2021 18:03:02 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B83C56E8D9
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 18:02:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWmEVmvVMqT9OIZvumwToe8hSrZa71y6sro0IpBHi3I3NB31oKEtOjEChPr/PU9RsANKLJf7Whhvuyf/zDRVRu1zx/8L9aiB2DiJtOpsSipKSUb3pgG+02e9Uaz1UIBI2JQb94b+V1w2JwSZIaFIfQtl3onS0a080/sjh1a6w+2nYrDehdKvrEffwkjZeGOaaChTLrEEpKmYtFD5oqw4Y+TMMwBY00VJJu4D1iVLplBXRN/Xg5NyGoDTRmFi/TCYNySPjkLdbmTrKQhF5QSdsMVpSstN3BJpZWCXcPQ3ouZtNvpGRT9Rwdrunc4AIxWOuRczZDUZX180Sb/K9I+xIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4Wayk83wBn8vaNzj4b1+a/i1vuaYAjeDesYAs+Vyzs=;
 b=RZ0lhDB34bpG4jmgiaf5jSdoH7QRjMvEd29n9apB6nf0cxSW7hRfMaqvpuH+H6KhoKq9LXSJXUoNhDXROzvXgBT6RIqv01Mq0Z79nLey63cEJ48tps/ySeOCZB2l0Vf20KBw8mXE6jvZW951Vv7jJUlVCOyUXzCOOiYtzjRQ2jirlP2tqySfG6YiGJevWsBDKc+xfTrTiQT39nMZ39UiyiIQA75z9chIWRPI84qbN0WGOxvBwV+q8rexhX0jWqXlIWqfsGIb8lSC+JZwHhlSaLGUbkh9U3Qo6rVHfQ1si7wdkP6vIDiKJk0bhb/N5uYIeTQEpBsPqgr8QjcztCKwkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4Wayk83wBn8vaNzj4b1+a/i1vuaYAjeDesYAs+Vyzs=;
 b=Qus3ixogtH4C1h9OY+gNHUV5A1r25cAeBf/SY5qvxsFqSUQdf/cnKnptmQ65n4S/YSOJ4OXNLPn2UVJJ5u0r+RfDJSF7BAMuaUoPiegjgOhJdYbBzIZtoi+xTuKUgrS5H/qju3+pNeiu/RcdbsmLU8tF3F7LHwYZX7HSlQ+U7zs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SN1PR12MB2542.namprd12.prod.outlook.com (2603:10b6:802:26::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Tue, 29 Jun
 2021 18:02:55 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::5ce6:fed4:e00f:27e4]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::5ce6:fed4:e00f:27e4%6]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 18:02:55 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/11] drm/amdkfd: skip invalid pages during migrations
Date: Tue, 29 Jun 2021 13:02:02 -0500
Message-Id: <20210629180206.8002-7-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210629180206.8002-1-alex.sierra@amd.com>
References: <20210629180206.8002-1-alex.sierra@amd.com>
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN7P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::27) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SN7P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18 via Frontend Transport; Tue, 29 Jun 2021 18:02:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38118257-e4cd-4ee9-0b1b-08d93b281f01
X-MS-TrafficTypeDiagnostic: SN1PR12MB2542:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB25422EAD1D94A00F554F02FCFD029@SN1PR12MB2542.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9jvaZQKCYlwEemJU8zZU19b6jMbfVfq+08m/0ML8Sy6y/eyXEeGeHJssceteN6VWlzykajB3IJjgjHcizZ7n7FpgQeAwMj/lWzrF+MiQ93ZosYMWYEdg/sth+sZvTdkB3SgGpAYhR09YiYdVgyvM/9r7DS4M5ljZ8JK4n16rV8jJcSOuN9jtc74255wkD63NHlJOavqybwmRQd7E1GMgm4HEXaxZg+nyWsGefclGsiv3lRRzS6zFjdyTiWo6My48+2mlSbOU7uaYvPFou47TtGJ1aQv273He1AuMOhz9iOUAil0G2ImS8esXTSiqMpZm3m+P0wMIHFI3EImeAlCf09N3zonjLuXB7F8407KYeC08YYW9gOv5EsWQo5iwze/u/S+YDW/LPY2p+xskSVTyHpEAFwyAohqWMgLWnT9E2Nq8UQ8foLqi5GvOYxR/Iv+59vjTRmLl6IXcEFjqv3WWRnPs2EaG1H7g1IUz+t9iQHXhM4P/5Gf4zpGfAofrmfiTXnzMsrSx/QaNxSr6K3akNFzG3nIG1Sc/rSw39CGCXsNzGfk/uXNyE4UtQYPD+cFn9RVWOjuKiZnWU7rKoMsqHDEFHcJ+vG/sEsQM/GX/yAtbxpMgMJ+UDlYWrNu7AsxBIPfupcx5tJwcKj0YGAAyf8pWFtZfeVNq4Xze42Lp/LX/Ot32tWOltNM+IJz3ERRLa2U8VICB+yCMF/MGUbYXTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(38100700002)(2616005)(86362001)(52116002)(186003)(4326008)(44832011)(6666004)(6916009)(7696005)(54906003)(956004)(8936002)(16526019)(8676002)(38350700002)(1076003)(26005)(36756003)(6486002)(66556008)(66476007)(66946007)(2906002)(83380400001)(5660300002)(316002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R4YaIP2aOxkP0khVt5mptf6vpf0mR+05HYBXeqvYDc4MWuAqz7LyDP3vePGw?=
 =?us-ascii?Q?cuZRZKOuXDbVOhXEcRktkF54wlX60i5TeiuNNgD6n/hdMfaJEjL6LjInFwa0?=
 =?us-ascii?Q?e7h8t8tMWY0ecDVfQZezPGkp9sQ49WhlJYcASP6usZEcb8VEikmNQymoQv7R?=
 =?us-ascii?Q?6VP1z3T4YdpTrXDSwzOOaa0Hek0S0Ep3qV1MPcdws86XEYFQcBLVmR4wNAqO?=
 =?us-ascii?Q?OdeNwcCyn/A7alJT4zXeJSCA3iheioRJtdspIifSlByMxMzOekEUDexKEdV3?=
 =?us-ascii?Q?IgdFxmsHXnpvRc5aVLFUi/ZY8J91Kb6aEj5HkwNSeLGLRVCaOPJ51/1Skar4?=
 =?us-ascii?Q?TcqkZhnDuicVOI/7AYlUbDT7nZN0mhGUR+ybSo7SIgy1KNGJ0K0wr7MjWOYg?=
 =?us-ascii?Q?1VQWfCTDBKqjYQrXfQO8uPnxfeRgjWuywLcHulPAg8+6vP9RxG5gd4B4urJd?=
 =?us-ascii?Q?fAnnRTrz5YqufyQ21X9WpJfQqj6F8Cl5LujaO014dvXTEXYgDax+8TCN79R5?=
 =?us-ascii?Q?+iKR0pmTjeHgo5MQgadDmtanYYPtOwONFh/YsysOlMMWseeSly3bb4ZWu41R?=
 =?us-ascii?Q?n5R4tOChENS4D9XpFlXZ2J9zxfW2vlG2DJzOd3reQEnkKuoWuifODV0KbTWT?=
 =?us-ascii?Q?tMQosFjqbGih2lYc9moD50qSEeHJvlm6CbW3YRo1he2fNGg7CUI3sSZdrDQd?=
 =?us-ascii?Q?2fe9TY1FOEECiTxoBY+WMddC2PC/ISb4fhUuY6c9V+VwOeb9yhOTR+TFqXuD?=
 =?us-ascii?Q?vlLpGDSorxfpqPF5ZMd/ytjTHOWNIcJpQN6gKk6lowd/wms09eveUednQzIO?=
 =?us-ascii?Q?Sy1cVfRTaj9Edb+VbRD74gX57M3Ozw2GuUQ1lKqmkhLJ79T9WH3HoeBNro24?=
 =?us-ascii?Q?6SYihdR+6Ud42+g7gVtL3UMHF9DEP1h7Zb+Qe38opRE1XUAzqqK6ARqEQuEC?=
 =?us-ascii?Q?GVa/vulL8RXJci9bY8zGQwjGl/bQC6epBGFgEYqtrSY1N0crHwFsGKTA2BpV?=
 =?us-ascii?Q?I6qtK9E4g3v/lYFelIjbXdp4lJh7j2nakDLH1VOuVHtt35ybk6lei7hPeDJ+?=
 =?us-ascii?Q?MEcyxc+eluO0slkPi03HwScoTSzu2i6gZl666q2EfRbqVBDQAVqqysBbv46g?=
 =?us-ascii?Q?u5JZnqKs7JSSNOedXHdqP3y5ShWOfKPQg3ph+spGVOJ/FHYhEu28Qph7Tbla?=
 =?us-ascii?Q?Xrk4lRSilHuC6dkOJrriOGJryl1y2SQtwh9qDqo7p/1aHXT63wzoCg5OCGYh?=
 =?us-ascii?Q?wYSv1qCAjvNEnmfI2WepEFGhDpS2sMXUdqjM4xPkB9Ioz5TonXZa5tNGCdrB?=
 =?us-ascii?Q?Nq4vwiPjxYUvJN7nBgKF1YE7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38118257-e4cd-4ee9-0b1b-08d93b281f01
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 18:02:55.5494 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GFzYTw43mDRVzZGepgyvbxip86WsCnoqdXSIVp68a8IlZKHv7d1OK5uklx9gvi2lBOLbNkfvBrshgSS7Luc9Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2542
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
Cc: Alex Sierra <alex.sierra@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Invalid pages can be the result of pages that have been migrated
already due to copy-on-write procedure or pages that were never
migrated to VRAM in first place. This is not an issue anymore,
as pranges now support mixed memory domains (CPU/GPU).

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 38 +++++++++++-------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 33d4a118d05f..7b31c8596786 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -420,7 +420,6 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 	size_t size;
 	void *buf;
 	int r = -ENOMEM;
-	int retry = 0;
 
 	memset(&migrate, 0, sizeof(migrate));
 	migrate.vma = vma;
@@ -439,7 +438,6 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 	migrate.dst = migrate.src + npages;
 	scratch = (dma_addr_t *)(migrate.dst + npages);
 
-retry:
 	r = migrate_vma_setup(&migrate);
 	if (r) {
 		pr_debug("failed %d prepare migrate svms 0x%p [0x%lx 0x%lx]\n",
@@ -447,17 +445,9 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
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
@@ -554,9 +544,8 @@ static void svm_migrate_page_free(struct page *page)
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
@@ -573,15 +562,23 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 	src = (uint64_t *)(scratch + npages);
 	dst = scratch;
 
-	for (i = 0, j = 0; i < npages; i++, j++, addr += PAGE_SIZE) {
+	for (i = 0, j = 0; i < npages; i++, addr += PAGE_SIZE) {
 		struct page *spage;
 
 		spage = migrate_pfn_to_page(migrate->src[i]);
-		if (!spage) {
-			pr_debug("failed get spage svms 0x%p [0x%lx 0x%lx]\n",
+		if (!spage || !is_zone_device_page(spage)) {
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
@@ -614,6 +611,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 
 		migrate->dst[i] = migrate_pfn(page_to_pfn(dpage));
 		migrate->dst[i] |= MIGRATE_PFN_LOCKED;
+		j++;
 	}
 
 	r = svm_migrate_copy_memory_gart(adev, dst + i - j, src + i - j, j,
@@ -672,7 +670,7 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 
 	if (migrate.cpages) {
 		r = svm_migrate_copy_to_ram(adev, prange, &migrate, &mfence,
-					    scratch);
+					    scratch, npages);
 		migrate_vma_pages(&migrate);
 		svm_migrate_copy_done(adev, mfence);
 		migrate_vma_finalize(&migrate);
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

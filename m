Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5F1C49EA7
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 16:04:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6272E60FEA
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 16:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6272E60FEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 432F66E20B;
	Mon, 21 Jun 2021 16:04:48 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBFF76E1F5
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 16:04:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J59oj1DV8RNFoZTRX8A457jFepAhscwx8m0E1s0w2n4jJ8L3LLqAJIImLAxIrJ7BNuk6Gz2rZa598LlCUbwwbLiWWwCcoQsf7BMN04L1TY4sdjEkKh44H1s0++acPYRZQ09T8PA1ukmlhQnf8HosnZIMyhXKriOmrvZclc0j7IlwhqWOI1rtx+zvTiw12JvpVAeP48K6sQxseietKwkOdmLqTmXIq9EPcw2BnLYlUOx5pkQoH44OWjgbBxpf0ziK/oJPS3zaY/EkPHahNVqvPY9X4KJfMEuAUQLEwq1Bc+Cru/4Cp5YJWjN2T3ptsyXe7GuuyP/USwMmKd9RZwBE1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8vOWckKnAlpjiXZ1/MMp3os/cjQAKv24HViE4pKeAc=;
 b=dLajwY4n7ij1QUifcxW8ofG8P60JHtG3cLmFFR2+l1CZYdbf3VgWN7r1H5cTSAHVvFLdaH+Qu1GS8le2PbBSurPI0uzOCFzzocvACmedxpnlfVLxSQZFHlkWnWxDyCulH4vnzbtYRx1smRnI4++KC1Til43ldUXLYJSqm4ng35zVuogGdwZtf8YLHV9SxGGRYIHE5b2e976hKohHIdb5DsSCryzAP6HgWBCoV3UwlL5nQimr5jiR3H1dhz+8NkX7b7P0WJWdowPjVbE2we/a+r9wJxOLeNfd5HPI5XlSzlfOxB/DZs/0KVgdbc9ljg9TPVtx2jvmHENCqJYYgywzfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8vOWckKnAlpjiXZ1/MMp3os/cjQAKv24HViE4pKeAc=;
 b=HolcXWHjjYLqoVlrswifDI0q5RMr+Z9r3gjWoRoi2fHvkgW9gBKevzr+E7SgmW++tLidmxWlH4GQPwIJ6UzxsMBvrwylZHdpsm6PWC8JuMl43wD8Rq2NwIQfzchcVINPoU51FQvbF7IqlHKENKqdTm8p637ObaBwOVvhDRcWmXs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SN1PR12MB2447.namprd12.prod.outlook.com (2603:10b6:802:27::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Mon, 21 Jun
 2021 16:04:40 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::5ce6:fed4:e00f:27e4]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::5ce6:fed4:e00f:27e4%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 16:04:40 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/10] drm/amdkfd: skip invalid pages during migrations
Date: Mon, 21 Jun 2021 11:04:19 -0500
Message-Id: <20210621160423.3517-6-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621160423.3517-1-alex.sierra@amd.com>
References: <20210621160423.3517-1-alex.sierra@amd.com>
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SA9PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:806:21::28) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SA9PR13CA0023.namprd13.prod.outlook.com (2603:10b6:806:21::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.7 via Frontend Transport; Mon, 21 Jun 2021 16:04:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb7d2c3c-20cb-4d25-879c-08d934ce465e
X-MS-TrafficTypeDiagnostic: SN1PR12MB2447:
X-Microsoft-Antispam-PRVS: <SN1PR12MB24474FF0F813000CA850BC00FD0A9@SN1PR12MB2447.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5BpIFsr5zyqPRXhRv1LLiExt4ywcCYs4uCMRgtUUkr5BFslMWvAmbLhrlY1WGCC3QG186rZK83429mFxsrS4X7zm6a7+07XrSUAC3PY1qz++1+Ry4I9d9FZKSrSkhNiZCjRJ7at0yhOIfJHuAAzKxF30mn/Xh+cLfGfull0IGfAaOf5ua0Rsdw77DThm3z2WV7mR4CyO2n/4hvRQkevPKkcC7Z6O9eh1uAqO89apsmqZDzOgcCd+46BeswSns805FcaYYzlceq7kInvndcn4jw/SUgtaleTu6l2fb7zOdJPI/ZfLxxV1FWZB/ywvaOlrbak6/8Ke5qVbNjKeqQqiEsmvUWQpQYEqc8bX7ioWKoCD36KXmjx5dRvAXJQlnV8ehXUYSrKG5w7ZhSQhJWimAZ5nizdSBhJTM4ZC/s9kzB9CH8UuQ/PCY48HvNoxj/mR9PzaojmaKpPwy7xtRKnjdL5y+12kSteJaueuKo2ZfCyvwPlizapDR28XS2c2mZwTYSzw2Xo5k5mMj0S0bKX/ZZFNAYWHY2Rx/zA8bUA4jPa1S+cLpTgK0mD9ZIvL+0b0Nwz01vgDh/OpacslZHVAhBudmHZcZ19zKN/74XOQJb7dNgBSXKpBca5KtmEZomK0g8kCUrS6sUa3rvpKwsuFxXKL/K/4r2TCchr6ABK2NVk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(26005)(38100700002)(86362001)(38350700002)(36756003)(956004)(8936002)(2616005)(16526019)(8676002)(186003)(5660300002)(44832011)(83380400001)(66946007)(6666004)(6916009)(6486002)(498600001)(66476007)(66556008)(52116002)(7696005)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EBYb+ia6IQ4E+IaMJ1xR3wzMfHAoUD1/SA+Sy/rCKI5S/awB9DmgS7YAVuaA?=
 =?us-ascii?Q?xcMx67tRnESCvF8qYfbv2PQw8dlybBxRhGpyatKBpR+Wx19pa+NjbJqc2/5r?=
 =?us-ascii?Q?EPXSq6Rv6Z4V7dxTItLYL58f3o3/oUUsPlgpHjPaBd8rwHNKHzcQ4pXviZhg?=
 =?us-ascii?Q?ROY/ho35iOsNNab7uM5Zaz2D+9aFht61tBkBiimBhEOGK+J7WiuY8jqlxw4v?=
 =?us-ascii?Q?T9RHeH2CfzGsYcTSihtjSpy8V82ERAMtP2RJFbFWynXDfKKq9BXehzino/S5?=
 =?us-ascii?Q?JDRneBDARSxiBthcD4O0/TNQYmPKkVVAzvKr5YdVvaKWn5f7N8OJT2KcjUa1?=
 =?us-ascii?Q?Y6XciVKFJ9Ob1zGbAgWhrkoqRN8p+U7Ye2+LbrQSMjD51zlfuN1uWffh/DXI?=
 =?us-ascii?Q?aMWF7GoVHxE+6B7zfN1XxMGAN7tjjM1YDtBwqK2pPfdIA1wXkHzj0yOUY9HX?=
 =?us-ascii?Q?6Ug1kT8JIolRg1nmB/W2Ib+k5gUmHYbBubSfQcwz0LOmtfbvgao5hm8wCJDe?=
 =?us-ascii?Q?Q1PtdvRV1IVuFbM05I/OubHeH2ilMG4U/xaIb5yIAZ4lo5Ykq2cWDzyfDMsC?=
 =?us-ascii?Q?eYQ8nyRLJhnNPhHIl8e4vpZ4mQJsS4JGnMGDLPH6cMqYXFzznOB2V6u3690k?=
 =?us-ascii?Q?5g8Le1OnRUNnhDTLyxSIN7g1tM2GROpGpGlJ78wa0aGuYJ3x1sacDsCbWlqY?=
 =?us-ascii?Q?UizKGJAkiByUDSG1BiaU2AhiJU4FdzX7eas/gbl4PhMaUm681YyWUnkhVR2w?=
 =?us-ascii?Q?jUGDLZ7DUCNRtLrryA+ekGAXS7vih7xqOjBl+8FmTwIoBCeuGDVNU+oc69uT?=
 =?us-ascii?Q?Yup2cdn8sLdyOCZgcxqhh/a1/X1ISTLZZTdTX++luTkFe1OEp/s3l8OmLAc4?=
 =?us-ascii?Q?qop95wX4q5tk6uwz977lECY2kQVhDksnXuPk8PcfNYtoPuYwcQ9H4xysvs78?=
 =?us-ascii?Q?AV6yze3rDBicLcusDNDAkF1N19fIV9JGZxwZNbXX9zuoZ82St/dAgaxVVeRd?=
 =?us-ascii?Q?aCqDjBfqWmfii/VSy9n5cFoArqgMS4c7RLqpSWSgR6oljb0Fd97yu6v/qIez?=
 =?us-ascii?Q?p5p9jPxeWv7j0juEohrJWyDqRUGhGsP3k9CSORwgJ1pBbmhcaH4hu6gfFus1?=
 =?us-ascii?Q?O1U+gxPEXu5PkYFvVyhr9n1/X1LbXAHEthYAlL35npkYGSWKBsXw6pDVvhRf?=
 =?us-ascii?Q?1XBJK3Srswxkq2iEPchqw9q/qCD9r2kiSFpAuiTemDJ8AwNwVGm7oTRgtuKO?=
 =?us-ascii?Q?K27IabNErtp8GwAFL9sDnNurNSEaoszUXSV2H2gCloaTWVICnC8jmBndDPDV?=
 =?us-ascii?Q?KIWc//h4Pk7U/7iy+hW8AhSs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb7d2c3c-20cb-4d25-879c-08d934ce465e
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 16:04:39.9377 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zbpZVKEeuHxyn3xx5EYR8MgoZtXpFqRT1rYFoW/ISgOdZOwbs5IS18U3e3De8jix68FcQiKHM/VnlUx0Tqn+vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2447
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
index b298aa8dea4d..6fd68528c425 100644
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
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

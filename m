Return-Path: <SRS0=WxFm=O3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E04C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Oct 2021 18:23:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1429261130
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Oct 2021 18:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1429261130
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A34AC6E027;
	Thu,  7 Oct 2021 18:23:54 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F120C6E027
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Oct 2021 18:23:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOCh8nXGac/PukCl41OQsbUa0nzj6ybfry/YpkWWf94KzpRvLODTwUGC9glCjjMEUewvuBB+ofSdxfhsM8XJ8ptlFuoMckDBeOYI9W5L/DM9fGRNBwtzlGaNZ7cAbfps/JAgWJcNdosvynaLkzCQ1jMSOP6P3Zs0I/6Yg04Yi4OM9UDzV1oZHI/AYWKeUv+WucBscNNkodl/EHfpurwV0sA2lc7o/JQCWsGHJX3y885yhmppSNXcsnjwEo213pccR5Gsn7B6dQOtjYVolTjMqVdZbYT+pdbPaXH9+qxOM0x6Buf0Ovfy0W70ncfqamBuJ5cKRPxOMiRF6uT1Bxt+XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXSNDRx5jl4hXNqR13PXPbqRaMX2xbUVJbArHFhJw7A=;
 b=WU0Q4tOwOp8yx6HFnBnAG0eXT/2xoRNNn/tUyXvAXe4/Erp26tk/DtBUd1s+DNZaP1+zBIwigZJpDAcZXQQ69dgxZJCAyznEvp8xUc7AIebup/XN2W61yhCAsJTcEvnvxcMdr4i52435YdiQPRbgz84QnEpbUV46zQBWbdrweL9G8aPYGGfW4JRIN+VsCS+WYzC8uxNElY0C49E+TpCrSTvBsmSETLKMmf3i9gt5gFlDjuy/s2BNeOTDiPGlbXkrbnFU4XalpHjSHkDyZHz0fmMKb41snnQM86c74VLtA5vhBCanEOnh/+GAEdNMpXc7aollMn6Pn4/g6BzjpV7trw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXSNDRx5jl4hXNqR13PXPbqRaMX2xbUVJbArHFhJw7A=;
 b=lNNn/YzbWHaOv00fSvj+xvrPn+cmC4Nxe348ZdCmcM8hkIIfKRHpRG9eQiwZKM5FzOQZawllp/C2KS744NA9tCMvjhnlwYJZAUJzOAgetqVrQIcKxcBiISanUt0EbiwsMmR42ZID/PIj22R3tMtTJ7BfEm83iZbUmaiyxTk1uSA=
Received: from MWHPR02CA0006.namprd02.prod.outlook.com (2603:10b6:300:4b::16)
 by BN8PR12MB3028.namprd12.prod.outlook.com (2603:10b6:408:43::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Thu, 7 Oct
 2021 18:23:50 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:4b:cafe::b) by MWHPR02CA0006.outlook.office365.com
 (2603:10b6:300:4b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Thu, 7 Oct 2021 18:23:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Thu, 7 Oct 2021 18:23:47 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 7 Oct 2021
 13:23:46 -0500
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Sierra <alex.sierra@amd.com>
Subject: [PATCH] drm/amdkfd: rm BO resv on validation to avoid deadlock
Date: Thu, 7 Oct 2021 13:23:35 -0500
Message-ID: <20211007182335.17152-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 253c9747-639f-40ef-f900-08d989bf9ada
X-MS-TrafficTypeDiagnostic: BN8PR12MB3028:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3028D31868700FA72F047DEAFDB19@BN8PR12MB3028.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KXP7a+7dAaF/Hz1Cg5HRsnF2r73ST4+jXWLIBcUYcWPVM1ZgzVbFmIVqX59OlD+7C7lSqbLnsxIS3b8FyNmBDJuXBBrm0sWB/hc3KWm3OK9HRuRSV2Ba6KXpQlLO584ISmMjCPkeHv5DJfGFkrAdnBxnHOMcaW+xq/5JQfO056xGO5gYTZzjAFe7rn2dKVScNuz5lrycee3m2afXU9DTLtAAnLnpiM0cFXMA+DJRtAmcN7bjySSC+S/66Ul1+1rx/a2eQRIBRc8QFIRXRgSrBbi/Hu3NGaMFWCOjiadGImSVJcBZPxy3nc1CWDmIjXWccxXlCioQxVAKjhIRUOj2HqJONp+bg1eSIY+vYdY5fmJ+CMNBs6Lxe/zHxNIlLEDSFJccjvdxYBWa6vD1MJVckwlwLlYWjzW7l+P/8fEe4ePUodefXyvY+l9AFGFaNv1b4VaoBWIHTG5TlhdufCaO5qq9QKkyawfDZGiNyUCA2wr8CeSBVPJ0ygvhrhXK9ifCe7XRqDXkspca5x+RoB/wtITNdjOnPWFeZrzNyn0Yveh5ctpW8r/4uc2OtGBruedPITNv8m5itAOt4B08A1U/EOqsZnbgwVJtGBQIAT50PxUm8v6HAgC2oq/aDLQD7IKoexUE9L931hwaXJfv0m9krwzk5VUeA9lgHaatK17xTQsDMDYOI5LJ4YHd9DzjF6K85K8Q5zH5fvs91Qb74oX+S6O1mIxipH50XrTTq427JEQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(2906002)(26005)(1076003)(83380400001)(16526019)(70206006)(2616005)(186003)(6916009)(36860700001)(316002)(44832011)(508600001)(4326008)(70586007)(82310400003)(6666004)(86362001)(81166007)(47076005)(356005)(8676002)(5660300002)(336012)(8936002)(426003)(7696005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 18:23:47.7897 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 253c9747-639f-40ef-f900-08d989bf9ada
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3028
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

This fix the deadlock with the BO reservations during SVM_BO evictions
while allocations in VRAM are concurrently performed. More specific,
while the ttm waits for the fence to be signaled (ttm_bo_wait), it
already has the BO reserved. In parallel, the restore worker might be
running, prefetching memory to VRAM. This also requires to reserve the
BO, but blocks the mmap semaphore first. The deadlock happens when the
SVM_BO eviction worker kicks in and waits for the mmap semaphore held
in restore worker. Preventing signal the fence back, causing the
deadlock until the ttm times out.

We don't need to hold the BO reservation anymore during validation
and mapping. Now the physical addresses are taken from hmm_range_fault.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index c4de7ce2f21c..6de3fb5266bf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1326,11 +1326,6 @@ static int svm_range_reserve_bos(struct svm_validate_context *ctx)
 		ctx->tv[gpuidx].num_shared = 4;
 		list_add(&ctx->tv[gpuidx].head, &ctx->validate_list);
 	}
-	if (ctx->prange->svm_bo && ctx->prange->ttm_res) {
-		ctx->tv[MAX_GPU_INSTANCE].bo = &ctx->prange->svm_bo->bo->tbo;
-		ctx->tv[MAX_GPU_INSTANCE].num_shared = 1;
-		list_add(&ctx->tv[MAX_GPU_INSTANCE].head, &ctx->validate_list);
-	}
 
 	r = ttm_eu_reserve_buffers(&ctx->ticket, &ctx->validate_list,
 				   ctx->intr, NULL);
-- 
2.32.0


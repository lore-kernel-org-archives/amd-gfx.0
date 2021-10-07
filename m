Return-Path: <SRS0=WxFm=O3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273FDC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Oct 2021 21:44:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1F5760F23
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Oct 2021 21:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D1F5760F23
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AE6A6E02F;
	Thu,  7 Oct 2021 21:44:04 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D4076E02F
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Oct 2021 21:44:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pm24nu6WTZAkk/kaXbHm6qbF4hUwBAHHWqG1+jarGWXRFt2LaFGMuukm6L1hY5mvwJ/9bZEu16aD7gtbxU79Syl0CA5KBcSR7Ttrgf4dFKuI0wu3jKVLVCBqszaUNBCSk6IO9mFA4Zdxnc4bysIBJnz9nZYMnYm13IwZVyT2TDxF+DcdpnApABDIUvG/Rhgiul3RP6xbIEsXU2JjdCyjKbyuh10g9ruCgGNwkmd894fUT+lVOLlMxoJa3X8CkH1vyHRb3kIh1Gsar6PHhaPhEO+6LBKzjTbhbIqZAlR7jx4G4bzqmSzhpND/FmPJLRvVo3LDTTfoT4Wz5Rb+EETENg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9jBCaGBPYXnsm0GnOB2DQKkAQ2W9WV8mrdoE5sLtNE=;
 b=SGPpeLIghoNYMTGcISt3olbuJb82ZGzC4WA1sL2D1710VZb4Vywiq4IxCRnTLewHut8o6MItPcLHXsJg9fWt7cpqOd51jDmuJhEclsSskyhK4NX7gks2N+v1KrRQhzreAkzpEaAdz8RQxbd7z+xB07nI3xc39fDzFOBOhUbPPdKUGbl3TaAkC+x/kfIoSaOj8zOHuQ0Ww2Ji1an8wXgIaT8jZbG2B8k0CW2wT7ywky8kWfjdaroWRoz795nn2RXzRNpOY+i1mR1AlGRH5Tx00JO3tezo4fHrSaRWSfcuz9oeW5fYiXZX/MDDl7u2hd3A1AP2Z0zwmmyuTr80wA5huA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9jBCaGBPYXnsm0GnOB2DQKkAQ2W9WV8mrdoE5sLtNE=;
 b=ltzBzN0efrYUmYTif+I9AqK2Ent6f0oA6K31ieD88AnsFcKxMp2ZudIdL3f4eNGJdf7O5ySl8IbDGyJ/K6AQz3QEdivDQA1UsNNCmk/8g/+YJrwJjUBmHr8r5LcCHN4TW4ZDGhy7gnT649N3jAlp0twlJNyv+d0U6MjMHX2mjlE=
Received: from BN0PR03CA0004.namprd03.prod.outlook.com (2603:10b6:408:e6::9)
 by DM6PR12MB4778.namprd12.prod.outlook.com (2603:10b6:5:167::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19; Thu, 7 Oct
 2021 21:44:01 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::81) by BN0PR03CA0004.outlook.office365.com
 (2603:10b6:408:e6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend
 Transport; Thu, 7 Oct 2021 21:44:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Thu, 7 Oct 2021 21:44:00 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 7 Oct 2021
 16:44:00 -0500
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Sierra <alex.sierra@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>
Subject: [PATCH] drm/amdkfd: rm BO resv on validation to avoid deadlock
Date: Thu, 7 Oct 2021 16:43:48 -0500
Message-ID: <20211007214348.18726-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ffc958a-b8c4-4e8a-faf7-08d989db932f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4778:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4778AEF0FF36F6D7B315D13DFDB19@DM6PR12MB4778.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Td+shEmCOBVcw+iyJRX3K97SL4iy/04tymS/zy6Ehps7CBm9beIYmWooDrYUcQb74XltX5Lh+zv059ffIcR74VjOge0snD4nnJM2oodvu5fZ5NxdnfiX/eWGmiz63XV77K68MBIMhWf14mVDDNvet0lUwtV2/RdL4oDBKEuGgINanMbVZlJQL2L1XTT8I0kW4eKAs2U532+s7o9EtUbhvOROkuPj07LX0R0PmGoNJxCrXJdWOlO/EBLZPROOfkqfC54sOGWA9sN6Ubn9cGPBuTTmXg0r0zZbDEXu/sr4SsT5y2Q1fW1OaBIFTU8H/XL+6nfJBp22We3iXsI/nCGtHAcEHHJ0yt22dl6Wiijw0pCOx0w23HsakF3V2+aA4hwo+g57nAMYubahgIy9HZmEIIqT95LbrvjUWycCtft8+aykDz1Pt7gskcXEVC2adDv0uzmyriHosQlZapOFoY74K9/pUyU8ANBIH4rSqSGtNNfzs3y+DsE0lVLDD8omaenlkoQrcQ9vySgslsicOj5l6lni8EsahMTmTJZcVXF8UVgo1LbdWdnBWUq+3kfMmnT8LF6OgExozqm67Pcjy+dSjjp88aDAXOBM4TpKgkDrcqgDAKtWlviV79Ic1L0SZ8qjJhsOSkm168YT3fqMRG/st8EcGPXdP9jHJPh6efPwW9+cs77BJORfShRnQNp9ejCPjC20lY+w7P2AFB+I8Ct+5VC7rY+yZJzVKfhYHwP+/Q8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(36756003)(6666004)(70586007)(426003)(44832011)(70206006)(86362001)(2616005)(2906002)(5660300002)(81166007)(6916009)(356005)(4326008)(8676002)(54906003)(186003)(8936002)(508600001)(16526019)(316002)(26005)(83380400001)(7696005)(82310400003)(336012)(36860700001)(1076003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 21:44:00.9444 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ffc958a-b8c4-4e8a-faf7-08d989db932f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4778
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
We also take migrate_mutex to prevent range migration while
validate_and_map update GPU page table.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index c4de7ce2f21c..8db60b06b0e8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1299,7 +1299,7 @@ struct svm_validate_context {
 	struct svm_range *prange;
 	bool intr;
 	unsigned long bitmap[MAX_GPU_INSTANCE];
-	struct ttm_validate_buffer tv[MAX_GPU_INSTANCE+1];
+	struct ttm_validate_buffer tv[MAX_GPU_INSTANCE];
 	struct list_head validate_list;
 	struct ww_acquire_ctx ticket;
 };
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


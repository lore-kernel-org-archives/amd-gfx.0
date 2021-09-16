Return-Path: <SRS0=YYL8=OG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8810C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Sep 2021 20:10:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77B2C611CA
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Sep 2021 20:10:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 77B2C611CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96B626E5BF;
	Thu, 16 Sep 2021 20:10:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF8B56E5BF
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Sep 2021 20:10:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIGwc+NYr/AJ4Pvorg3eDkMwIwx/RTh/NmO/5zqga3PStYmpTkr/+PrAij2YJs0iCG2eMJ6ALqmxmkWo+JvpirkQar5lE97fERqsOT61DkcAGt7BBv24W4WS4Q49wzKFn54ifmMMwfwehN27YxFD1QARHO1b2mg73UUM0SpKcHdns5Ngm2Z4NQ2B2w3U8qMlz/b+QNn/R1w9gD9mFVLreR6BF7JqhDYIKS38u0SqKzsGHzWI129FxY8zrAlvGakOc+6tenmF00V0WqgrF1NQK8v0nqcAnEWPrFVSuaZ6sxSj7FNc/0e81v4dSzYmiC3fI337atfIse6Hifl5gMHmiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=4IdYj5n/qhkgNc4J009EmXnM2lG7SD4juMfPOAapo8M=;
 b=ZcT9rS7R79c17KQlqyPBqIJflwhgbYF2t0ccX2sTFUJt80zD0+KmN/0or/ZvQSOYTSPpVUWg46ydMeUp7GJAnupOvG0789xKlG8atgcVBjXOZJo8mSDgKl/3uLVKGK20r4qbU9+9ZavXhLjiqdNiwyYjXDqSiKTe/zirGMpLTBPJicORx0xx+es9sXR2f+/9IlGQHwIN85gVWkOpPgXEbOMWnC0UlSzUE9q83ItP20JmIoOJPl/JQP6PfIvL3ChF4bXMXMQH2FjBLXUPq69RSOwgVoiJpPhwL37AqOqcoUo+9lC3GPzTWPst32G6EjN6sEDmZojX99syBTN1J+8OOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4IdYj5n/qhkgNc4J009EmXnM2lG7SD4juMfPOAapo8M=;
 b=pAIYqv+R5OQC270e2ZByHLkFEyBKQvYSKtN7mmHKAqT88tygKFXROSZ705woqRa1qG1upydC7JVgVrElhk//2yrYYuQz1DoyvJzTePZyPrNtCeN7cZeX2oRJrqlJ50G/AERJkmHku8l47YnPqMJmHmALcoZjlMGTYOICw83e9sw=
Received: from MWHPR17CA0070.namprd17.prod.outlook.com (2603:10b6:300:93::32)
 by MN2PR12MB3280.namprd12.prod.outlook.com (2603:10b6:208:ad::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.18; Thu, 16 Sep
 2021 20:10:51 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:93:cafe::78) by MWHPR17CA0070.outlook.office365.com
 (2603:10b6:300:93::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Thu, 16 Sep 2021 20:10:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 20:10:51 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 16 Sep
 2021 15:10:48 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH] drm/amdkfd: fix dma mapping leaking warning
Date: Thu, 16 Sep 2021 16:10:34 -0400
Message-ID: <20210916201034.25378-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 219e84e1-55ab-4a2d-7b91-08d9794e14b6
X-MS-TrafficTypeDiagnostic: MN2PR12MB3280:
X-Microsoft-Antispam-PRVS: <MN2PR12MB32803F43D8F93047C2AF9B16E6DC9@MN2PR12MB3280.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DcFKpAHGwz0CVSESV3ev42MhGTRqbyDfgY/Tm6K8QIJM+0CeTaF1cQz4nASi8D/7sbGBpgeDwc2VXbxoTx7oSPC904EBrDuNvyVh0I0vih+BmbOGtFVcpu2nQJocAIMEBvp6hpxtDq93M3w2ci57sRG+nqyblkneHiSnkaK9VdmN3gpB2UQ9iTiByBl5J372Z1nE4I8k7D1wqWTbdxYmi03rTgmfG74ufUcJsOVUjYelBWGb6lq6Epgcidw1eM5dBvEqNWaD1KAI8CRtB3aSnSAEsw8vJn/hIg7kvceoK718TCX2dfzHa5HvImpGCUqHccQNBQqRRDy3Sppn58RdgAYdeFqPCjbP2w4bjbXtd90c7+VKFsOU2xqs55hNea6fpcNEdj7eitBZwkqAtxhnaVr30nZ6cekqIHdnWDAOgMpf2JyfXfcd4MwccMW+ogPZBlZbf+7u2QmS2SyJl5l4N6XmJ3f0wC4t4K8zP5Qd/tyPfgR6Dvw6UhDkUaEWqfIXpBYnmjuFNLSWzfuDxBad2DP6WPP5J4rBTMpP1ZZ6oGNOg1Yvdyd5dZy1bxKtmzbfO4G0wa3UxH9qVykvSMH/3xKGtZNW7Tt6qBpbxoWkmbPasWOfS/U5cflVxIIFqYQYFf3Nq14F+RZ5mv6yz9H8+4Evnfzj/Fk85oEPxxT3rrZzcp0TVeWDYilLiaIbUcj9jAJS3S1kzE4JVJHuVmIYNcHpWszQJKweK/YUHPglTJA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(36840700001)(46966006)(36756003)(82310400003)(86362001)(8676002)(316002)(478600001)(2906002)(8936002)(82740400003)(356005)(36860700001)(6666004)(1076003)(81166007)(4326008)(7696005)(6916009)(5660300002)(83380400001)(336012)(426003)(2616005)(47076005)(70206006)(70586007)(16526019)(186003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 20:10:51.0090 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 219e84e1-55ab-4a2d-7b91-08d9794e14b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3280
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

For xnack off, restore work dma unmap previous system memory page, and
dma map the updated system memory page to update GPU mapping, this is
not dma mapping leaking, remove the WARN_ONCE for dma mapping leaking.

prange->dma_addr store the VRAM page pfn after the range migrated to
VRAM, should not dma unmap VRAM page when updating GPU mapping or
remove prange. Add helper svm_is_valid_dma_mapping_addr to check VRAM
page and error cases.

Keep SVM_RANGE_VRAM_DOMAIN flag in dma_addr to diff VRAM page and dma
map page, but move it to bit 8 to avoid amdgpu vm update mapping path
BUG_ON(*addr & 0xFFFF00000000003FULL).

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 13 +++++++++----
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h |  2 +-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 2e3ee9c46a10..237ff2d0a8d9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -118,6 +118,13 @@ static void svm_range_remove_notifier(struct svm_range *prange)
 		mmu_interval_notifier_remove(&prange->notifier);
 }
 
+static bool
+svm_is_valid_dma_mapping_addr(struct device *dev, dma_addr_t dma_addr)
+{
+	return dma_addr && !dma_mapping_error(dev, dma_addr) &&
+	       !(dma_addr & SVM_RANGE_VRAM_DOMAIN);
+}
+
 static int
 svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 		      unsigned long offset, unsigned long npages,
@@ -139,8 +146,7 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 
 	addr += offset;
 	for (i = 0; i < npages; i++) {
-		if (WARN_ONCE(addr[i] && !dma_mapping_error(dev, addr[i]),
-			      "leaking dma mapping\n"))
+		if (svm_is_valid_dma_mapping_addr(dev, addr[i]))
 			dma_unmap_page(dev, addr[i], PAGE_SIZE, dir);
 
 		page = hmm_pfn_to_page(hmm_pfns[i]);
@@ -209,7 +215,7 @@ void svm_range_dma_unmap(struct device *dev, dma_addr_t *dma_addr,
 		return;
 
 	for (i = offset; i < offset + npages; i++) {
-		if (!dma_addr[i] || dma_mapping_error(dev, dma_addr[i]))
+		if (!svm_is_valid_dma_mapping_addr(dev, dma_addr[i]))
 			continue;
 		pr_debug("dma unmapping 0x%llx\n", dma_addr[i] >> PAGE_SHIFT);
 		dma_unmap_page(dev, dma_addr[i], PAGE_SIZE, dir);
@@ -1177,7 +1183,6 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	for (i = offset; i < offset + npages; i++) {
 		last_domain = dma_addr[i] & SVM_RANGE_VRAM_DOMAIN;
-		dma_addr[i] &= ~SVM_RANGE_VRAM_DOMAIN;
 
 		if ((prange->start + i) < prange->last &&
 		    i + 1 < offset + npages &&
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 6dc91c33e80f..f53399fd37c6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -35,7 +35,7 @@
 #include "amdgpu.h"
 #include "kfd_priv.h"
 
-#define SVM_RANGE_VRAM_DOMAIN (1UL << 0)
+#define SVM_RANGE_VRAM_DOMAIN (1UL << 8)
 #define SVM_ADEV_PGMAP_OWNER(adev)\
 			((adev)->hive ? (void *)(adev)->hive : (void *)(adev))
 
-- 
2.17.1


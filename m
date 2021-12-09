Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 742BCC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 21:19:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E947F10E33A;
	Thu,  9 Dec 2021 21:19:12 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66C8610E33A
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 21:19:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dgVWC0kvIphBmqhStl2+slBYOHoswhEZsYyrYBfBsw6Wv1R4URulWX24KfAWxoUOPBsMyXL7Xmt9L9QFZYNAjIHoX8VImye2nknKv7Dr2ZX3tZvA25HagNQZ5xQ6tKHJmNtseMaDs9JqkQJBq4e9hRYTAQXTqwF6y88qm2yoeNGT/pSDMe4Q4Pn2rqTYoxL5Esbl7WwYYsqYLUU7/oS7e0qDOkHm43JfkVnPLDBQnmUjKgJcfTnqExtBaMc/9ICAhSYYSPc/u+vuww8BizhWcm4staOMWrQa3arYp1xzd0aioXJc7ribyDoKfHvDO+LiChGAiSrKBRidWlDEF+Ni3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKaLpIB/uB50HvRowGnWfP4d6HNZB7kjRODLqpnaT84=;
 b=BFBZgSzI4vbegfeyP9WZg+jkxl0R+jLtzU8dRhao7EeKYEsmbNPwfLq1a8sRFV1jg0gzU+WEEGInU4E7GSfSHX8dIMknw3N1n7jSGYSLlsXYBH40CXbwhbtX8ut7lToDAM1/HUMIzanY9GYYQfm++7gxh1bBZIlKmJFpD27DdMJZ75kJbAs4tGTh2Bf3rPuKaWtdzEEwCwuxUtyHDouumGly4fBt8PIxpY4JXnKpGh30WJgeexRbQraYJo7zoyhTuhKWeiZ51mridCthKaEtprISPLaIcpvXI4buO3Che52RJEHgyn7NwyJO5xjanoULM3E/rjkEBYIva48pydg7RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKaLpIB/uB50HvRowGnWfP4d6HNZB7kjRODLqpnaT84=;
 b=xhTLK2tryt3S40N09d/UIGXbq19JJqApxAchguhfe00mvFEAkxtsFs8J6xtjeQiXn/vdzR/pN29KgLsUl93tIFMo/0xQMbOGfxlm4TeCGxN99fmXTPU5n5DDSUEVI1TrIO99U4RrGAQhXxLiZrtXAaQqQuF9nIqpGzFKOyrjsAE=
Received: from BN1PR10CA0022.namprd10.prod.outlook.com (2603:10b6:408:e0::27)
 by MWHPR12MB1151.namprd12.prod.outlook.com (2603:10b6:300:e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 21:19:09 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::27) by BN1PR10CA0022.outlook.office365.com
 (2603:10b6:408:e0::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Thu, 9 Dec 2021 21:19:09 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Thu, 9 Dec 2021 21:19:08 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 9 Dec
 2021 15:19:07 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdkfd: fix svm_bo release invalid wait context warning
Date: Thu, 9 Dec 2021 16:18:41 -0500
Message-ID: <20211209211841.3768-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211130201321.22190-1-Philip.Yang@amd.com>
References: <20211130201321.22190-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f94b27c-9351-491a-e9e2-08d9bb598970
X-MS-TrafficTypeDiagnostic: MWHPR12MB1151:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB115144503192ADFB915A3CC8E6709@MWHPR12MB1151.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:820;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dOHYYR9mFs2CRoEwJ0j1WlB1iOnGQFTQIl59V9/krdWcmi0Ze5UR6NiAcPckqZAbMnPLxjJZy4rAuLR3pgMzkTLVQa2rtRHT9yi4JJ5wGZocRGyB7BodtyyHYK/jPHCD//WuLM1mEl5f3RIVhwyKIDWD3qAqQSUKfsh1HYTJo+N0GWQgzWN5Vy4thiLTak+yxxHByveP/Z2kFfxSzFMRegXrub4cnY8csC7z1+GzcrcPYKWamMar4XSozxGv8ux4JMriJUO7ll5E7oTPq11aNsBUFIpSxNfT6mh7yxIf59q8nqi5PmSMIr0BBQ3S379yfPgx4cpN9+sAJxZ4dImwwuHPBM7dNx7kr3ss94VI1TEFMELG/cKTs4qJXr/lp1SEWXXvn3hpMeSg0ig7Cixlwvlx8QnnlfmmKiU4v7U+1K/IOizTpdakSQhZDptlYWqAYXzc33aXAZqZIbeleXVRF+IsIULp9dRd4fGj4sjVfgm0Birc9j4P7GUGMpdt1COB4HSkjXjOmjQ8buSKOQ/AeGZ566VH7U4ia8CjJBYRk0yDRGBQKbgqZhOeT7U0fvd+KSruFgiIjGq2yRAPb5EwqairNPLxLv+4qCyd8G6inSvd6V+aBMHSPW6OIWakT3cLn9o4y8P2OgOIBPnymq85pCzfb2yAKtCdzMa0U8Eqp4JJCj0nW5iv6WB28X6E/OoUEvRVC+rInuCBz59mcbpQ5qqDWUx+ekl+R+USWG1PSI1sJ0JwpcKcxxP9NswSNpiZwuutXj36PKviigOMUb+9bmafxKie8y8HBSjYhSZfVCc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(2906002)(336012)(36860700001)(26005)(54906003)(186003)(5660300002)(6916009)(16526019)(7696005)(426003)(70206006)(508600001)(316002)(6666004)(36756003)(70586007)(4326008)(63350400001)(63370400001)(8936002)(2616005)(8676002)(1076003)(82310400004)(356005)(83380400001)(86362001)(47076005)(40460700001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 21:19:08.1529 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f94b27c-9351-491a-e9e2-08d9bb598970
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1151
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add svm_range_bo_unref_async to schedule work to wait for svm_bo
eviction work done and then free svm_bo. __do_munmap put_page
is atomic context, call svm_range_bo_unref_async to avoid warning
invalid wait context. Other non atomic context call svm_range_bo_unref.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 31 +++++++++++++++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  3 ++-
 3 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 9731151b67d6..d5d2cf2ee788 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -550,7 +550,7 @@ static void svm_migrate_page_free(struct page *page)
 
 	if (svm_bo) {
 		pr_debug_ratelimited("ref: %d\n", kref_read(&svm_bo->kref));
-		svm_range_bo_unref(svm_bo);
+		svm_range_bo_unref_async(svm_bo);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index c178d56361d6..b216842b5fe2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -332,6 +332,8 @@ static void svm_range_bo_release(struct kref *kref)
 	struct svm_range_bo *svm_bo;
 
 	svm_bo = container_of(kref, struct svm_range_bo, kref);
+	pr_debug("svm_bo 0x%p\n", svm_bo);
+
 	spin_lock(&svm_bo->list_lock);
 	while (!list_empty(&svm_bo->range_list)) {
 		struct svm_range *prange =
@@ -365,12 +367,33 @@ static void svm_range_bo_release(struct kref *kref)
 	kfree(svm_bo);
 }
 
-void svm_range_bo_unref(struct svm_range_bo *svm_bo)
+static void svm_range_bo_wq_release(struct work_struct *work)
 {
-	if (!svm_bo)
-		return;
+	struct svm_range_bo *svm_bo;
+
+	svm_bo = container_of(work, struct svm_range_bo, release_work);
+	svm_range_bo_release(&svm_bo->kref);
+}
+
+static void svm_range_bo_release_async(struct kref *kref)
+{
+	struct svm_range_bo *svm_bo;
+
+	svm_bo = container_of(kref, struct svm_range_bo, kref);
+	pr_debug("svm_bo 0x%p\n", svm_bo);
+	INIT_WORK(&svm_bo->release_work, svm_range_bo_wq_release);
+	schedule_work(&svm_bo->release_work);
+}
 
-	kref_put(&svm_bo->kref, svm_range_bo_release);
+void svm_range_bo_unref_async(struct svm_range_bo *svm_bo)
+{
+	kref_put(&svm_bo->kref, svm_range_bo_release_async);
+}
+
+static void svm_range_bo_unref(struct svm_range_bo *svm_bo)
+{
+	if (svm_bo)
+		kref_put(&svm_bo->kref, svm_range_bo_release);
 }
 
 static bool
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 6dc91c33e80f..2f8a95e86dcb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -48,6 +48,7 @@ struct svm_range_bo {
 	struct work_struct		eviction_work;
 	struct svm_range_list		*svms;
 	uint32_t			evicting;
+	struct work_struct		release_work;
 };
 
 enum svm_work_list_ops {
@@ -195,7 +196,7 @@ void svm_range_list_lock_and_flush_work(struct svm_range_list *svms, struct mm_s
  */
 #define KFD_IS_SVM_API_SUPPORTED(dev) ((dev)->pgmap.type != 0)
 
-void svm_range_bo_unref(struct svm_range_bo *svm_bo);
+void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
 #else
 
 struct kfd_process;
-- 
2.17.1


Return-Path: <SRS0=2XV/=OH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6E7C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 19:16:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DA0361260
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 19:16:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5DA0361260
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C40926EE6C;
	Fri, 17 Sep 2021 19:16:15 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7B6A6EE66
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 19:16:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zn/ZbBmUjwaAOsfsf8/bI6+yo7E+6Fsx7SgWTja/ZtLGlabeoZpduyv2beaUQBvDBcYmwveny9LGj0eUDjc9Tozs+oML5ej1bY/XxSXswu1HEMFMC6nm3vyeJkopyQdE4ItGLfqz84zOZ7xARF7Ttllp3nxTV65hGPI0mePLCukBRdFd22zCAdoBGUrDLi9iOtiKovcHPD8FfxH67m7Ca9XyKqQSX9uUnrhvkdGvEtGH6U0Ly4EgUycZv8li7a4Vbw8VMq4dOkYqcMoa8rBuZi/EBXRBPAgtqI15eA3OGZakAMh9omD7VnrUA2VyVxKc/iQX352gY6zZkiFWtd4Tkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=x0gMIbcJF3JXsobt8exXlaALkE3cZ2YDv8LqgAsSuT8=;
 b=GHAQDev6XxRaf09R962rGxKCJfZEB8JmhEQS6g4LXfxDsso1oIz0eiVn2FsxhO3fE7wiVV9xXAKO6P7Q2omfZUHF8RO9FtqPXy5ti3EBhk/twBnN6E+8I1SM4E6auqvUqF5hNrGa48BrcSKUnOVdPZz8f+nfhNaEQL5maLFFHvDRUEARIBs1CC8Uo9jYccWDIPbG8JYz9hPuZiz3edNHrryrPg8m3zXPCbeQl0goMCwEyH3eOWllXwmMvwzVuz+ZB76h1PPqHPtwl0GHW2uAC0lk9pV5QvL07jcSF9pEuTF4EsZiU5/N/oYCbczVoW6cmauVdtIcJXJqwXN7oB98iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0gMIbcJF3JXsobt8exXlaALkE3cZ2YDv8LqgAsSuT8=;
 b=YxESuRW8dvMPdxMoVn5mv0xuXRpCmlO5Gdi1DKKetS/hgX88f0imlkm+Q4qXC2xqKBmnQiHvcLjWy/fQIsLwfZetMMV6vyCNx2VS4qbTysqXmnTbiq6DZ5QNjHn282gZmTjjPUVTDgEAb31YvacgDWW7fJtJqtg+gpOpZqumaeM=
Received: from BN6PR17CA0006.namprd17.prod.outlook.com (2603:10b6:404:65::16)
 by DM6PR12MB4009.namprd12.prod.outlook.com (2603:10b6:5:1cd::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.17; Fri, 17 Sep
 2021 19:16:11 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:65:cafe::3a) by BN6PR17CA0006.outlook.office365.com
 (2603:10b6:404:65::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Fri, 17 Sep 2021 19:16:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 19:16:11 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 17 Sep
 2021 14:16:11 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH] drm/amdkfd: handle svm migrate init error
Date: Fri, 17 Sep 2021 15:15:58 -0400
Message-ID: <20210917191558.18709-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 293d7292-ae40-46eb-2679-08d97a0f9c81
X-MS-TrafficTypeDiagnostic: DM6PR12MB4009:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4009A534D8028308B76C56EDE6DD9@DM6PR12MB4009.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LB6x6eMoe7y+JVXPndwsKKUWTb3PIbCEij5zH1mIP1N/xE5qof9SiPY3da4190iXBQZA67MuNPuOl+E7XysL4RN/tVI+RlPdVu+lPw7jD8zH9pAxjJjrHQwMGvJbQcOjANKRJZ7IDKrJf7O/wS83M2CrtTnnLx2HWuUewp9pTsD4PWNN8TS6MHDqfF+low7OwQnrBDJPLlGI78+By8VonwiAZPWDFl8eVJXmBnd9EZIlttrgQVIjOVgP2+HISt5YcrAxFXyQ0dodMOUF97oCUM4+ZOyaaFivehwy/ugQ1GzkY4VwXw1oJf564TC5E3N+tg5X2qAqcRJwHOBwQT7s8jeULvkFyOMLh9ZvUureKJHE9hajqxe0o198dl+YHsxIq/GO0lTQoSNlqRssQjf7SxX9vcHdeOmrX3B3efHiIidvHPUTC/l1kJr5970iD3rPJk1fhJHdCCyLeH5sDkvKX/Zd43b2iJiAlrYskPM40ExZfYUE+e8x/SirmMdJmg75GXHIwKn5hNLIwbDDoHeW+SYwqjqkZpI2J6dWDr6L9/35qOZhyZuQfvYRQMZ1wlGmLEvmBqDLgsW3fD7MF9SxzCHwoYCpeZ3pfm35Nwu/U9LxyVz2FPgJi37KZjxTQh72Anyp+fr6qS0/Li3ey0f7tAZr6KFBN/oiNSWHOJbRifQqY88esI1JkXRF6KrBXMsxAC3/aGlYf8wFNp+3CK/Cfn9YuRIMNL81xq7+BxMRRAM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(81166007)(36756003)(6916009)(47076005)(5660300002)(356005)(4326008)(7696005)(86362001)(2906002)(6666004)(316002)(8676002)(336012)(70206006)(70586007)(36860700001)(8936002)(1076003)(508600001)(186003)(16526019)(2616005)(26005)(82310400003)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 19:16:11.8013 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 293d7292-ae40-46eb-2679-08d97a0f9c81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4009
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

If svm migration init failed to create pages for device memory, set flag
to disable SVM capability, svm migrate fini skip release device pages
and mem region.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index dab290a4d19d..21f745e0b86c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -894,6 +894,9 @@ int svm_migrate_init(struct amdgpu_device *adev)
 	r = devm_memremap_pages(adev->dev, pgmap);
 	if (IS_ERR(r)) {
 		pr_err("failed to register HMM device memory\n");
+
+		/* Disable SVM support capability */
+		pgmap->type = 0;
 		devm_release_mem_region(adev->dev, res->start,
 					res->end - res->start + 1);
 		return PTR_ERR(r);
@@ -913,6 +916,9 @@ void svm_migrate_fini(struct amdgpu_device *adev)
 {
 	struct dev_pagemap *pgmap = &adev->kfd.dev->pgmap;
 
+	if (!KFD_IS_SVM_API_SUPPORTED(adev->kfd.dev))
+		return;
+
 	devm_memunmap_pages(adev->dev, pgmap);
 	devm_release_mem_region(adev->dev, pgmap->range.start,
 				pgmap->range.end - pgmap->range.start + 1);
-- 
2.17.1


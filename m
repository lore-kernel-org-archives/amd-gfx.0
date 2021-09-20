Return-Path: <SRS0=Av9g=OK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31D5C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Sep 2021 21:55:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C15B61242
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Sep 2021 21:55:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6C15B61242
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C77F96E88C;
	Mon, 20 Sep 2021 21:55:49 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2067.outbound.protection.outlook.com [40.107.102.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37B716E88C
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Sep 2021 21:55:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hmy5GFmi25aS0LVyvsr+xgR+/yQt4xTN/fflvM2LR1z+9nRbxp4ZXe5qy3UwE2kktKZv1t+B58PfejWQ3YiCcEXjz98C9rDvoGCco+WcN3Wu1CKWN50ZbMQhSwvHrKpUZX2KiPBZQZJcE8caVeo2MhQGiezKzXvnM6+hypNaRLs+En2gstC1CMAC7/KnkcRa5TyPqF5FBPXUwxl0HKOr+vvtfhvFLgqiWZIsQ82eVw7OIdRYndvRWr1EG7gn0lvL+hOdDar+udpIbp0wQ0mKhl+W8gj/SoDnh+/yODUWUDNHn5t9wJ0KwZf5R3SeVcAuXbGQ8QHjklagy0oONxt88A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=v9guoryNoIfZvlHkDmnmVYk0bgIIdX6FlNt29Q25pbE=;
 b=Wnu1BRF4urFIEYv4iMUaNeT90RaUNgbleDfYdI+/najJm148r4WLhDXBybcKxaxjB0FPy5APr9VXEnA3IgM37ge6A0urT7TZWh3IG+yjmyCMio0DsY8LZAsj5Gk6nl9I+e9WBz8Diu+mniwx8Q+T/T4nyXKkN3Gxt8FigJLUYWcwCc/IXmbs2PKQwx/dkT4P4Dk+rIqt9TWNgH3pDgHy1w4XftA6NdIhAaZYPLNPU9xKWRWzmh5uLCDIxHTCSrwbuawsvVAUvTowEwYjvVnP83FDLrdvx/Kj7mLL4f/dh18tWOfwdkjE4BhyiI+HMPB+pgwJIOsVWOzlOhXDyfSWEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9guoryNoIfZvlHkDmnmVYk0bgIIdX6FlNt29Q25pbE=;
 b=ZlQqyxwBmQSRVrMjbt2LL5lBAyVv4PF1ESLhZgRcQhZmSyAPutaECP001+xLG4d4PxKYBTrB1ke/VpDFR9JJDq8lFeUN1OUF6T3DNFZAWfWDmFFuDIuvEVBFts/slDs3CZQwJ+bu2Qqt0Bu3tyhWm3PA3hIxD4knrtHMqT+iBCw=
Received: from BN9PR03CA0172.namprd03.prod.outlook.com (2603:10b6:408:f4::27)
 by MN2PR12MB3568.namprd12.prod.outlook.com (2603:10b6:208:c3::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Mon, 20 Sep
 2021 21:55:46 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::ac) by BN9PR03CA0172.outlook.office365.com
 (2603:10b6:408:f4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16 via Frontend
 Transport; Mon, 20 Sep 2021 21:55:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Mon, 20 Sep 2021 21:55:46 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 20 Sep
 2021 16:55:45 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH] drm/amdkfd: fix svm_migrate_fini warning
Date: Mon, 20 Sep 2021 17:55:32 -0400
Message-ID: <20210920215532.26132-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f83e5de-53e0-40a9-251b-08d97c816674
X-MS-TrafficTypeDiagnostic: MN2PR12MB3568:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3568951BF508DB285FA76FC8E6A09@MN2PR12MB3568.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O2/B+Fd30Dr4DkXXmX9F3Pg/Pdc26yiZtc/19KBHveeBbfEg6Y8JRSNK6y0djNkihR110FNvZ89AmQZ//ux3mw7Ua2U/Em1InFDBED8IMbpY6Nux+sWZSFmkWZ1yG7jn3Lm8gcjyH1Z2cmHcUBzIy9URGdyzyhGpEyDZudVSXhprRU0HqCFzhohuaBk+htsNcNkPM6kjO9udTq1FpXBjxK2rFMw1uK60qGyJafYHLqhE5Qlmeis/n///EgqGt/By1f8bMqi4f2qr8v13EZqJJvIKrbM9+VC0xO9od24Oua2LxT2rDkIMCA/gPn2AG0QJBKuF24OmOx8hAITmOD0+jZAG9prB3ipBRjy/Je4kTbED21ZfZtFGOwqYx6YMrZu5B9VqbGF4R/kskqfDvP+Z2fMqNfIrsLLef0cLmNJNFtkbBZtlLRaWGsAS4d21qzayTMa4soTay9nJsmdsZMTtLhyTPI3IQvSR1+QKg60y9cxFgqerS77HNOeFzXGXErgM4t4Sde4krSQnbNYLdSTIWD8M8g0niqJ6d+fxbzgEAr9WhcU7b5PSDTjUZYmrCWYfwRTEOEaa6CJzsu21jUb+1S2uHup6913+tm9pCld7GxGY/rKTtdTlRm4qGOfFburaM0gIZACbwmB26I+AjJa+VQnpKTuFD3ucb+ptMiJES4E8Wv2Nwk+9PjHBEsdoELZxWeuN3caGhX8NNHAFDnpAfQ/HoeH5pvoWQWg7yaIngDs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(316002)(16526019)(1076003)(6666004)(47076005)(426003)(26005)(6916009)(8676002)(7696005)(508600001)(82310400003)(86362001)(70586007)(36860700001)(8936002)(356005)(2906002)(5660300002)(70206006)(83380400001)(336012)(81166007)(36756003)(2616005)(4326008)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2021 21:55:46.0719 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f83e5de-53e0-40a9-251b-08d97c816674
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3568
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

Don't use devm_request_free_mem_region to alloc VRAM region for pgmap,
because driver__detach releases all device resource region, then calls
amdgpu_device_fini_sw, which calls devm_memunmap_pages generating below
warning trace:

WARNING: CPU: 1 PID: 3646 at drivers/base/devres.c:795
devm_release_action+0x51/0x60
Call Trace:
    ? memunmap_pages+0x360/0x360
    svm_migrate_fini+0x2d/0x60 [amdgpu]
    kgd2kfd_device_exit+0x23/0xa0 [amdgpu]
    amdgpu_amdkfd_device_fini_sw+0x1d/0x30 [amdgpu]
    amdgpu_device_fini_sw+0x45/0x290 [amdgpu]
    amdgpu_driver_release_kms+0x12/0x30 [amdgpu]
    drm_dev_release+0x20/0x40 [drm]
    release_nodes+0x196/0x1e0
    device_release_driver_internal+0x104/0x1d0
    driver_detach+0x47/0x90
    bus_remove_driver+0x7a/0xd0
    pci_unregister_driver+0x3d/0x90
    amdgpu_exit+0x11/0x20 [amdgpu]
Trying to free nonexistent resource <000007fc00000000-000007fdffffffff>

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 21f745e0b86c..aa96767920a9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -880,7 +880,7 @@ int svm_migrate_init(struct amdgpu_device *adev)
 	 * should remove reserved size
 	 */
 	size = ALIGN(adev->gmc.real_vram_size, 2ULL << 20);
-	res = devm_request_free_mem_region(adev->dev, &iomem_resource, size);
+	res = request_free_mem_region(&iomem_resource, size, "amdgpu_vram");
 	if (IS_ERR(res))
 		return -ENOMEM;
 
@@ -891,14 +891,13 @@ int svm_migrate_init(struct amdgpu_device *adev)
 	pgmap->ops = &svm_migrate_pgmap_ops;
 	pgmap->owner = SVM_ADEV_PGMAP_OWNER(adev);
 	pgmap->flags = MIGRATE_VMA_SELECT_DEVICE_PRIVATE;
-	r = devm_memremap_pages(adev->dev, pgmap);
+	r = memremap_pages(pgmap, dev_to_node(adev->dev));
 	if (IS_ERR(r)) {
 		pr_err("failed to register HMM device memory\n");
 
 		/* Disable SVM support capability */
 		pgmap->type = 0;
-		devm_release_mem_region(adev->dev, res->start,
-					res->end - res->start + 1);
+		release_mem_region(res->start, res->end - res->start + 1);
 		return PTR_ERR(r);
 	}
 
@@ -919,7 +918,7 @@ void svm_migrate_fini(struct amdgpu_device *adev)
 	if (!KFD_IS_SVM_API_SUPPORTED(adev->kfd.dev))
 		return;
 
-	devm_memunmap_pages(adev->dev, pgmap);
-	devm_release_mem_region(adev->dev, pgmap->range.start,
-				pgmap->range.end - pgmap->range.start + 1);
+	memunmap_pages(pgmap);
+	release_mem_region(pgmap->range.start,
+			   pgmap->range.end - pgmap->range.start + 1);
 }
-- 
2.17.1


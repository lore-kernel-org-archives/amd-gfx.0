Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C317C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:53:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 599D461186
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:53:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 599D461186
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DADDE6E909;
	Tue, 21 Sep 2021 18:53:27 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 754566E909
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:53:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bdShhTi98rpMnRrpdt8AE35elwBxe2hhQkI5+l3itNeBCEd56sFxKME/usc4tKpbbvn9oUrrrgTqH0/v0cfDG4kZ3UluT6cyL00GWA/fEF81R1TqWKkK7/Qloq0CxzMrNBLtdzM3pI7lnUpaV+pcVS5FEYY1rCrX0Dh89+WyWmmC2T9hFZOALTGzj540mZhudYMT4NK5Cr5lGxDui//uSQVBfhhYJjOq0HrIgqug8ZYrVAJjePmD68fq8ynphwrnMsXMs+q730KNrVZfpJYQ2yYulV7O8L/Ixms4b4uAKcoUehv+TUOtRLkPfPcw2ZEfT7yQWmLEaFhri2iC41e20Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=rxSOB7XuCrBmfEapHvbRhKbk1hlUO8YMwZDYR+z/F2k=;
 b=CEXureP8BQNZbZ2bcQnT6Mh3xabcL+ne+w3wy9jEzXVnek+CtA65wZZnOA6s4XHHeicZKY7jwEfXiw8Zwutv7p0ZJ1hVbiPB3Bdo9H1o9yPe7mPH2gO9S1vR8ueHdHfV/Je/+us4vK1tzVhScA6a6GlwJ3efcwHBzZQ80bEoDQhBOY+Bsmel6kKYw1eV8Pj4Ck20rQuIJtEWDQk9KjILkIv8QUXEbJPExkmxKoTeb2ImPOMuF7nLLdTXxXNs2O6g6hxF+TKi0ZSH2W1QOx7C+OYQR/wqvNcebXQmm1Iamr+yBo6OIQNPDQrvJWmT8yLk8MsOflEaqOzlrbknEZDgtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxSOB7XuCrBmfEapHvbRhKbk1hlUO8YMwZDYR+z/F2k=;
 b=fLEa3Obqk67Lk6vnwDDtOOtBbZPvhHKV9QG/23GVK8optsgiQtfs4/NdSWfvOSJoARKRg9LLRsTJ/2IumbntiaHo892TdZ7icJna6FiCCEgHzw7l02pbYckJ5HKVE5krK2WFBANT1c+cLDnr8V7Ii8Cr03oJhwzVzZWPSGzB8vg=
Received: from DM5PR13CA0033.namprd13.prod.outlook.com (2603:10b6:3:7b::19) by
 SJ0PR12MB5405.namprd12.prod.outlook.com (2603:10b6:a03:3af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 21 Sep
 2021 18:53:24 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:7b:cafe::ce) by DM5PR13CA0033.outlook.office365.com
 (2603:10b6:3:7b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.6 via Frontend
 Transport; Tue, 21 Sep 2021 18:53:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 18:53:23 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:53:22 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v2 2/2] drm/amdkfd: fix svm_migrate_fini warning
Date: Tue, 21 Sep 2021 14:53:07 -0400
Message-ID: <20210921185307.25811-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210921185307.25811-1-Philip.Yang@amd.com>
References: <20210921185307.25811-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a3b9402-d1a4-436b-7e32-08d97d3116db
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5405:
X-Microsoft-Antispam-PRVS: <SJ0PR12MB54051B027641AFB9281A7DB9E6A19@SJ0PR12MB5405.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hj/IZeXbzWQnJZGv1vYARzOnlZiIDn452/6mwe/xodlttqp/WXm/COtknn6Ry/83V8IIMMW7DHl2zOpUIFANQ9TYUx15A9v5uJ3GH8/FiYG9jvga00RcRP8L16tySZyusan1I4+F2agcSJ4BbWzD8tLRK7rk2vfA7fsn93K+mPMS8c2iy1NqsCcmb0hMpSZjmCcJCYkEQW/c3J9No5eJSuYEELcJChePziRVX6a4pT1VpaWATHVuefBy1tEPJCIcj6jSG/NqiEGPwm3vXZx3XVkk1gT0Pyxm+yKk+0nCD1sgKTOuWNy6m9xG6BBCLaSelQVjgca9Q06Tr2EDOjIPKCtMfKcx9KWH/5ObrYqOlgRCAQ4BExcHW3LNTTkPvxfaW9hhC32Lzu0FCX9JfYO2TtCA3pGwa/c1O0cPrvRK1yVqFs/m+SO9Ohf/sUi0+Xjy/9LoNu6iA8gWsn4CzN0cBNgDYcRMbFqtr3WDyjMh2devMmMcvqpJp4x3GS2elKuyPosOV85s8lqng4+fHDj905Ln1IQ1NPN/Amm2DmT8PtZ6NlKk2Qs8D7cditKtgM5TaL0ZTF1RALUVuzVVJ8L5rTIWIUA/e7sAvF+ttLFP60rngwislfXi4iq3CrVL3XsH8/n4MYfGDcc860QPsN6w3izB+Yx1mhf1wzPo/csPSP+9EzQXsmNUbZczVhj1gUo4atGkZVoAmjaFUM9Qke3d3FgXZ/vYOcmahZ/HKhBxo90=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(83380400001)(70586007)(82310400003)(7696005)(26005)(426003)(4326008)(336012)(508600001)(2616005)(36860700001)(86362001)(966005)(36756003)(186003)(81166007)(6916009)(356005)(1076003)(47076005)(16526019)(5660300002)(70206006)(8676002)(6666004)(316002)(8936002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:53:23.9109 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3b9402-d1a4-436b-7e32-08d97d3116db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5405
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

Device manager releases device-specific resources when a driver
disconnects from a device, devm_memunmap_pages and
devm_release_mem_region calls in svm_migrate_fini are redundant.

It causes below warning trace after patch "drm/amdgpu: Split
amdgpu_device_fini into early and late", so remove function
svm_migrate_fini.

BUG: https://gitlab.freedesktop.org/drm/amd/-/issues/1718

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

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c  |  1 -
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 13 ++++---------
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.h |  5 -----
 3 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 98d1b3ab3a46..c2a4d920da40 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -971,7 +971,6 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 void kgd2kfd_device_exit(struct kfd_dev *kfd)
 {
 	if (kfd->init_complete) {
-		svm_migrate_fini((struct amdgpu_device *)kfd->kgd);
 		device_queue_manager_uninit(kfd->dqm);
 		kfd_interrupt_exit(kfd);
 		kfd_topology_remove_device(kfd);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 165e0ebb619d..4a16e3c257b9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -891,6 +891,10 @@ int svm_migrate_init(struct amdgpu_device *adev)
 	pgmap->ops = &svm_migrate_pgmap_ops;
 	pgmap->owner = SVM_ADEV_PGMAP_OWNER(adev);
 	pgmap->flags = MIGRATE_VMA_SELECT_DEVICE_PRIVATE;
+
+	/* Device manager releases device-specific resources, memory region and
+	 * pgmap when driver disconnects from device.
+	 */
 	r = devm_memremap_pages(adev->dev, pgmap);
 	if (IS_ERR(r)) {
 		pr_err("failed to register HMM device memory\n");
@@ -911,12 +915,3 @@ int svm_migrate_init(struct amdgpu_device *adev)
 
 	return 0;
 }
-
-void svm_migrate_fini(struct amdgpu_device *adev)
-{
-	struct dev_pagemap *pgmap = &adev->kfd.dev->pgmap;
-
-	devm_memunmap_pages(adev->dev, pgmap);
-	devm_release_mem_region(adev->dev, pgmap->range.start,
-				pgmap->range.end - pgmap->range.start + 1);
-}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
index 0de76b5d4973..2f5b3394c9ed 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
@@ -47,7 +47,6 @@ unsigned long
 svm_migrate_addr_to_pfn(struct amdgpu_device *adev, unsigned long addr);
 
 int svm_migrate_init(struct amdgpu_device *adev);
-void svm_migrate_fini(struct amdgpu_device *adev);
 
 #else
 
@@ -55,10 +54,6 @@ static inline int svm_migrate_init(struct amdgpu_device *adev)
 {
 	return 0;
 }
-static inline void svm_migrate_fini(struct amdgpu_device *adev)
-{
-	/* empty */
-}
 
 #endif /* IS_ENABLED(CONFIG_HSA_AMD_SVM) */
 
-- 
2.17.1


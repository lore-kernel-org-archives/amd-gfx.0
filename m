Return-Path: <SRS0=Z8oe=5X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AC1C2BA16
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 07:52:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 596B82072A
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 07:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aExxM0m/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 596B82072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 196526E580;
	Tue,  7 Apr 2020 07:52:37 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CA366E580
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2020 07:52:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWRkAH14n5mmunkV6leEZ3hDHzLXPhmqOCIc02NUFuOx6J8zBDSL5Q//3vVrKYYWvqmqMDLQ5popO19JBR2izWUZ+w5XepgkEP9L/2s8bMhWYkH82BFgQteuRZnblrI2fAX6KhLUH+a33wmHMGLKz0c1nIBVHZCWqk9HuviuvvPY16u2ulgBWx1HvLopxqx/yRrIKjF0GjYmbQjlpFaYaC8lNPP+v/JvEJ5IPiTlLQxklL8yQlFdraGnj64xLnPoVu5ayvvkm8Pv0pkSvQgGGmDFoNJB0j8k/WthBQNlWp1YecFp4dQrRJf9TuhXO4LnZ/38esCbwV6EFx0DKQp6Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlFJM3KskBdBo7tbgqQZbuQA2cwDxb4KXDjSrxmOUBQ=;
 b=Fo/WZVBRD6tJdwR3tjHezdgd8ewJVtvTnxZ6Ewx3qIVgda+N7eYjCrKzJFG4VGRiPXCaFaZ9Ys7HLt2ytDdchif9ivASLuaUIB6E5lgqJ/tV9TcYyRUCbmUTA245/0oG5BUhMV50z3+V3qsmPM8gojL3ue4IOmUiwuJdQUu3Vg9XW08gvujeLSxnuw4O2wlhy5YuvD8PlwH4tEF8vOaxZshLYDt/kt8HYBJCdHFhtiRySmjpNxR2ElkAPfV/YOfEFzNnJzEmY0UG3HLtXBOdKMifDtRzcsyDjXx+ZHhCHvoA+Ny1u+kxBph6DQ3RYxtUn2oDghtB8OUFVNPdonMz9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlFJM3KskBdBo7tbgqQZbuQA2cwDxb4KXDjSrxmOUBQ=;
 b=aExxM0m/zpznegdsRQmSS/udpWiqcB9ey/jlbB2Kk+gysUMoGX6HB8sNJwt3p0R8GTgjfMtzYCvazzuIk/7KygI/DEOa0n/3tX7VzatV8oWjKRyhHzE4Ic4GZGujpN4psukAvqxptNNdD3xSDALZWw/GTZq4KS5BywHKLDacbAY=
Received: from DM6PR06CA0043.namprd06.prod.outlook.com (2603:10b6:5:54::20) by
 DM5PR12MB1417.namprd12.prod.outlook.com (2603:10b6:3:73::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.20; Tue, 7 Apr 2020 07:52:33 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::a4) by DM6PR06CA0043.outlook.office365.com
 (2603:10b6:5:54::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Tue, 7 Apr 2020 07:52:33 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2878.15 via Frontend Transport; Tue, 7 Apr 2020 07:52:33 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 7 Apr 2020
 02:52:32 -0500
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 7 Apr 2020 02:52:31 -0500
From: Jack Zhang <Jack.Zhang1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] Revert "drm/amdgpu/sriov add amdgpu_amdkfd_pre_reset in
 gpu reset"
Date: Tue, 7 Apr 2020 15:52:29 +0800
Message-ID: <1586245949-31138-1-git-send-email-Jack.Zhang1@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(39860400002)(136003)(396003)(376002)(428003)(46966005)(6916009)(4326008)(478600001)(8936002)(5660300002)(36756003)(426003)(81166006)(2906002)(86362001)(82740400003)(8676002)(26005)(2616005)(336012)(70586007)(186003)(316002)(7696005)(356004)(81156014)(70206006)(47076004);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c840dfd5-fc03-4b02-baea-08d7dac8a1b6
X-MS-TrafficTypeDiagnostic: DM5PR12MB1417:
X-Microsoft-Antispam-PRVS: <DM5PR12MB14175EE117AE7929EFFF4837BBC30@DM5PR12MB1417.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:120;
X-Forefront-PRVS: 036614DD9C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8OcjluQ2eiApb9D90Mc2ZkTYV1PsnqN0zXYJagKOVV+g6RI3zYqesn7CoagrJJQ2tX3fVTBFnSOSRpoG6eTqWTaiNcSXuyB2TQzlIIPs99Jv1VnQ1kMyNqTfeirqTk0wgHNyFIhYqz61PHAjHm/ZMeLSirc+cEmZAKHpZ0RyOqh7/fCAQ2pLRdfbEktpkOkz96ncNjQHks3ZTvVaRQsYMIYmUhJIwhPf+fJEOgpxNrF3K1Vand0le33gZHt0UspNE98tE9u1T/JjTlQdP0TmThuXkMocyzD70eUaVDi8CzUQQPI6oerOUulcuAILBeUAZlqSpczvvnRTueKKinC7iT8ZRhYe2X/W+cQFq8QrQwYkXPQmLZympom9Nqh18gqdltfuOjiyYnHGVFPB9N2bgO4ctLcWvi258emN8RJEBL7J+ay0yMPRulKBwUhPjP79JPsbVWmaxrrNjmxZUZ8TO0CtpRBihfvhoEaOIskBjIFsGt0vR13sv2IJ7ex4+pdBH6Yheqb2oXqRp4CJnsDe7g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2020 07:52:33.6726 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c840dfd5-fc03-4b02-baea-08d7dac8a1b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1417
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
Cc: Jack Zhang <Jack.Zhang1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 8a468ab2d75a6b0bacfb5da6a9036642436fc666.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c | 3 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c  | 3 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         | 2 --
 3 files changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index bdc1f5a..4ec6d0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -543,9 +543,6 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd,
 	uint32_t temp;
 	struct v10_compute_mqd *m = get_mqd(mqd);
 
-	if (amdgpu_sriov_vf(adev) && adev->in_gpu_reset)
-		return 0;
-
 #if 0
 	unsigned long flags;
 	int retry;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index c2562d6..df841c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -541,9 +541,6 @@ int kgd_gfx_v9_hqd_destroy(struct kgd_dev *kgd, void *mqd,
 	uint32_t temp;
 	struct v9_mqd *m = get_mqd(mqd);
 
-	if (amdgpu_sriov_vf(adev) && adev->in_gpu_reset)
-		return 0;
-
 	if (adev->in_gpu_reset)
 		return -EIO;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2e1f955..d94eff9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3852,8 +3852,6 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 	if (r)
 		return r;
 
-	amdgpu_amdkfd_pre_reset(adev);
-
 	/* Resume IP prior to SMC */
 	r = amdgpu_device_ip_reinit_early_sriov(adev);
 	if (r)
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=Z8oe=5X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCABC2BABC
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 06:10:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E9352051A
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 06:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sNxBX5AK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E9352051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 132E46E10D;
	Tue,  7 Apr 2020 06:10:43 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DAE36E10D
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2020 06:10:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktzMvt3ZTHM0IGBcJstfyoQc/PpfcjfNX0vMAURrA5U1Mxcq9jB4IhlriA4T5RtcAZxwb8D5COD8bzsT6ZVlLMU8dPWd7vV9aIBSefIwmDe7iG3UAv8cidz5JuHYMRYGIe10kikWZ3leT1PAq0f0QvO/LWBOdakydYzNLLs3Ayzdr1SRJFWCDjZal/lM9KLy5C1kb9yiQ45GuXQNmrxDv8qazTl1SCZDILd21242LQiYvKJtkBWYr6aDQAs6aTiTkMnTD5ny7crt+s7s0zbh5XiBSlwLVbLeVlJrg8z5Wr9e0S7HW5/HA+bjUQpf/kWyMet8lrTVPBGwl0bKUQtpMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlFJM3KskBdBo7tbgqQZbuQA2cwDxb4KXDjSrxmOUBQ=;
 b=nvDSUWFZjkY/l8/m5/vQ3hSu0xgo6ZNDnRalolKHAKRwv8YD4OvvGJGKE35rUNLWbDmC9JS/hzNtRuXPMy2binC0MIC6Ggy3OXW4h/CK+IuQ30/aVYYA2v0lWEsnuMD8tAe5WA53FoVZwWhQuy9w8bWVIpDZk1oWP8hw7TQmeK4yVDqrneJJQd3DClW7PYIY4YkPnNc+kikS0X1cvyfUcY+S8S9uZvYxsq3OdSQVcZf0OAS+WM1lI2JV6S30ZKCdJbKAZ36x54CO52bG/Ebgrhyw+3BgaG2WqFxLdu9O/tH12z57Lt75rdfDgs5zt5MROpKi3tC/J8+hCtPoTLfvOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlFJM3KskBdBo7tbgqQZbuQA2cwDxb4KXDjSrxmOUBQ=;
 b=sNxBX5AKLGnmPhl2/qvXKzN3kHyhEuodUztpXSWmipETBOvFU9PgWQ8NJxyS5Njr4d6vCPXnFImlHj7CNrEas2507ZL0cb3Z9n92MR0p/MXw01AC3r6GDYMDJidmgaUbyZWi0Uexlw/j5rV6EcY7PLQHkyrRUA2MqIKkoDT1Ha0=
Received: from DM5PR04CA0036.namprd04.prod.outlook.com (2603:10b6:3:12b::22)
 by BL0PR12MB2484.namprd12.prod.outlook.com (2603:10b6:207:4e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.19; Tue, 7 Apr
 2020 06:10:39 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:12b:cafe::a) by DM5PR04CA0036.outlook.office365.com
 (2603:10b6:3:12b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Tue, 7 Apr 2020 06:10:39 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2878.15 via Frontend Transport; Tue, 7 Apr 2020 06:10:38 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 7 Apr 2020
 01:10:37 -0500
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 7 Apr 2020 01:10:36 -0500
From: Jack Zhang <Jack.Zhang1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] Revert "drm/amdgpu/sriov add amdgpu_amdkfd_pre_reset in
 gpu reset"
Date: Tue, 7 Apr 2020 14:10:34 +0800
Message-ID: <1586239834-30391-1-git-send-email-Jack.Zhang1@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(136003)(39860400002)(346002)(376002)(428003)(46966005)(82740400003)(426003)(26005)(316002)(186003)(47076004)(356004)(478600001)(7696005)(4326008)(86362001)(2616005)(5660300002)(336012)(81166006)(8676002)(36756003)(6916009)(81156014)(2906002)(70206006)(70586007)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad1a8643-4e76-4ee9-bc7e-08d7daba649c
X-MS-TrafficTypeDiagnostic: BL0PR12MB2484:
X-Microsoft-Antispam-PRVS: <BL0PR12MB2484FABE44794D1944D41FD5BBC30@BL0PR12MB2484.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:120;
X-Forefront-PRVS: 036614DD9C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TH4jfK+0liRxzoCrVBa/mF16uaLSm92kwHip1msR3CtrVe+eKOZ0DK+iaLo169NoFCw4BLqJ4EnSFTxNy75xGDtTReSLGvbTkiI+CxmesCT90mQi6nQeh/6lFIqPtcAZYKrqUW8wOqdS+SeGgcKuqHWa1U1zqnzzvVP9oOq8qbTQiJFySb/PiWziOwWhxUrH4I8fgVuPFeRCan7jGDtNyXsyF69YJAZ5bMZ6yGn/qD1sCgwFiwgc1rgBmTqtlUmZOjLSA8nE+qHBETRDYg0Fh5cPYlZlSzFZBn/KRESyJW7EhQ4LDCq6gOxO3+WiiRTfrRIpyRztd1ZJ85qhRGGSH+7pWrrjH4JZ++yeIY4+XJsnBnHccoHV6S76Aop+0CFYm/aDOQ2c2tF2WRjcci9ORCFj4/iUCQIsactQMINMAa312Elv5eHrvTQn9cVir7vO2YQmSm5obacIlaGz35ncTpTWcG0FH6GVnWEaSJejdqKQM2LxLG0CNvtCibEPcd2H+O60yP8UhJIu6ENtGqX4PA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2020 06:10:38.2080 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1a8643-4e76-4ee9-bc7e-08d7daba649c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2484
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

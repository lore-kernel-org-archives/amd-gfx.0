Return-Path: <SRS0=VH8F=JF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4176BC433ED
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 09:32:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ED8561130
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 09:32:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ED8561130
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B2FE6EA3E;
	Thu,  8 Apr 2021 09:32:27 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D5766EA3E
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Apr 2021 09:32:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYeZNvHJS0djchDJfH19Ldg5ux2vs9gV+zexYi5kY2KyQdrwjaba3XpSh/GxX3AxAP4liFOWReiZT0joAmT+Nf5ohoA19a64vkXqzlZ/jkZ0Zz/J7ReUXINHFVRKr6xR6W1OQ8CyHhx0ZS87r/4JRv7lV9MVCky3LeahXoJAzlKOzjSBwUq+VjGKMVOHtB9rVX+t2AsSe9BdfBcLlXd6b/7CP70EUoTbszJU0vUHwNz1qBmBV2pyJMBrWcGI1hrbQt/kXjpomxl9o7RFIAJupRzoYfRpn4xirqn2i75wnNBFiggBtXyrPxZfhQ8Ap5MhlvyASmvoh6JF5iPkqwdOQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1KnQwjuFfJIZvbcNRTr2nR5bI74xQiTjvkoHRo7Jj8=;
 b=D68JddwmD1+2FD+0st2gmmNiypWfbikrF8kwnpeFRY+5clY71u8/lr/Ved7mkokNDlncik7nVdO5wYUbIpqc6BPY1Rn4f7pHtYeewuZilu/19zF3qGTl54V5t3ip7O0GW86A50z/mQZ0FworkONuMbNBarZ+J5/jy5ej18uq8QFPpYM5QAYuaTu+cbzMNHa/gi1JGf4pI3zNHYPCVojk4sBQojpVJ74yZAmGMh7IRcmau9kE4UsWGCF8AjJ+cyY8/px69R1L+YDqr/JKf7RzwbfX3rU/bYXkEvaUMZ992l2ytlfvbziCnR0PXkOD6osxK6YTaowcnIUqWaIScREXkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1KnQwjuFfJIZvbcNRTr2nR5bI74xQiTjvkoHRo7Jj8=;
 b=bk5qvEFvBn/xm9eyDu0BJ2VbkaIueEGJTHekoafK3XgGY6xGPG97mMq/BDHiupcG+7nxMj8kVDNku0zpRyUfEDfd9ZLXw79DF1rIz+9aI4UbprsXUZZvMfNZ0z49K3pQJIRlqLLtnMl57xwcsY+LRyRddGU0Xlt0V8SkBsZdKpo=
Received: from BN0PR04CA0180.namprd04.prod.outlook.com (2603:10b6:408:eb::35)
 by DM6PR12MB4562.namprd12.prod.outlook.com (2603:10b6:5:2aa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Thu, 8 Apr
 2021 09:32:24 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::b7) by BN0PR04CA0180.outlook.office365.com
 (2603:10b6:408:eb::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Thu, 8 Apr 2021 09:32:24 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=temperror
 action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Thu, 8 Apr 2021 09:32:22 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 8 Apr 2021
 04:32:22 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 8 Apr 2021
 04:32:22 -0500
Received: from kenneth-u1804-kvm.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Thu, 8 Apr 2021 04:32:21 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: enable ASPM on navi1x
Date: Thu, 8 Apr 2021 17:32:56 +0800
Message-ID: <20210408093256.10101-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17f9df02-9f16-44e3-3fa3-08d8fa7136ca
X-MS-TrafficTypeDiagnostic: DM6PR12MB4562:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4562D382F69DBAEBD7BE10A78E749@DM6PR12MB4562.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w62XhghHgc+rswGuvd8U+jvajPlkhL6tM2iiaAq/1u65cZ+GUVF52qQXbeajjrt5Njk2Kwh3kiDFxw9jcRljK6dIUIz7bfj9x+yp4biVpbY/gZTN5zHg470ZBgW/oseS3HgkO0ww70QaZOgtb1WC2gOotOwRIJjGfoBLj3l89BFCv3PxRHxsCZvXwGiIbYE6HwAqCH7qnA+92zkFDk0/3CQ8/Mfit6WR+zzg0mHuRh7fxY4J9aNL5Cg3cp8vmUhH1J3Vr1h3+fH+a3sq2wC36c1HVnOZXjRSXRy5JORMIp7DejExzAfWYFPRFPxpDm0FNd6b9JCkoXW09XXzAFas2y70iqn4HUB4hdQEHJBsUNwq9OW4Ucv3AYY5UaJ07sf/0dSZVwdAMwKijNRus6sXPKi7s9BrR75msdUTXttDmNWqV5rWoFDoAorscZpFFKfAFA9EeJRxaQ/H/hiE1mFxZ9HmdqYu2GQ7i2OzZdwgqeDvXrDuUt3CMcOXi9MrNYkJTPTRewBUB7Vea8ORuDJixUrrRfuO9sMHVFylCu+Ar8X5P2N3W9ILjQ5u2SBZrk2U1A2ZaBfiKGxjU9qwNHcpexS0UnbeFLzbJGl8jWA0/0DNkAwx1U3dJDV/ahSncCIDYhhwQbOU9KuOkGmqki/7Zhk7BfH8CE/dIyzkke1ed3awgVPhGmWRsLC622Ng4epxyBYuwmXdm5+KvF9pBHuZcNwNV37ITnajfUnWFK8OBBg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(36840700001)(46966006)(81166007)(7696005)(5660300002)(336012)(26005)(47076005)(82310400003)(82740400003)(4326008)(186003)(426003)(44832011)(86362001)(478600001)(8676002)(6666004)(70206006)(2906002)(36860700001)(63350400001)(356005)(1076003)(36756003)(63370400001)(8936002)(83380400001)(2616005)(70586007)(316002)(6916009)(32563001)(36900700001)(357404004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 09:32:22.9948 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f9df02-9f16-44e3-3fa3-08d8fa7136ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4562
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
Cc: Kenneth Feng <kenneth.feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ASPM can be verified funtionally on navi1x.
And can be enabled for the benefit of the power consumption
without the performance hurt.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 46d4bbabce75..5edab56c6ab0 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -601,8 +601,7 @@ static void nv_program_aspm(struct amdgpu_device *adev)
 	if (amdgpu_aspm != 1)
 		return;
 
-	if ((adev->asic_type >= CHIP_SIENNA_CICHLID) &&
-	    !(adev->flags & AMD_IS_APU) &&
+	if (!(adev->flags & AMD_IS_APU) &&
 	    (adev->nbio.funcs->program_aspm))
 		adev->nbio.funcs->program_aspm(adev);
 
@@ -938,8 +937,7 @@ static int nv_update_umd_stable_pstate(struct amdgpu_device *adev,
 	 * The ASPM function is not fully enabled and verified on
 	 * Navi yet. Temporarily skip this until ASPM enabled.
 	 */
-	if ((adev->asic_type >= CHIP_SIENNA_CICHLID) &&
-	    !(adev->flags & AMD_IS_APU) &&
+	if (!(adev->flags & AMD_IS_APU) &&
 	    (adev->nbio.funcs->enable_aspm))
 		adev->nbio.funcs->enable_aspm(adev, !enter);
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FE2C07E9B
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 11:03:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6B4561164
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 11:03:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6B4561164
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52FD189C99;
	Tue, 20 Jul 2021 11:03:07 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE66989C99
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 11:03:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JC+fR7zvu1TLkgmzC2G7na/P8CAGxoKXCQXho/tNwAUl04I04KPMZenfzuWrQHCyESbunroS2HPOQjeJjA1mImQE/lE39WxO5MVbUGEFpPwcv6H8fhFQHzSxPip+mVPDl0vlNw8QlTl5Nc1DyVxxyYqsDihNoxPN4sug6iVAaayj2WfBx4/EmJeXiHBRHau8Af2tVwXVk51IcMlBJUlvRJMzhZJE1rUjmQHCj0Qq08ZrXebV7Bxghv3PUhl5WgNZA+0wO0hTQKQQoUlLjTbTyzxOtVMRqzYsrDSVQqxiPBy/wtkQJ1aHXtmHhlI+Z9zMmRWjz3Fi2ujUpRwuZZz/9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwRJmmi1TBBThkDW6ibQrtmu/DQ+v55+smY3u7nnKMY=;
 b=hjEBD2eSeu6VXtWhhVKxNI4hsK86BYvUkrQaPjQMCnSMVQwMrenkDjD4jIbJrgV8sXCi0rMX0HKreWe7qEtlKshNtZ+n0i/11zJDp7G+zKJPxgLtJlgpUGTk/RrNy1duyWUkJDj6mQ1ck60j4MU9bCjQ/F0ETJovnp9LrSZ4DpPuJjaOcng1gvaw8/lzrt1S3U6Ls9Yb71Q92gtNJd5021p9tJ73PVogC5xClkPhhPEnmtSNER8C59PqMyBIK+UnCaqLI4JtlC4ug5D6uvsw+xf4eKGPyA2/7zI6fmbGgJI/Hbc8USt86HPf9v2dqJNSizBpGxDvtp42qxxoqEtgBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwRJmmi1TBBThkDW6ibQrtmu/DQ+v55+smY3u7nnKMY=;
 b=o175xiRZiC+kA2qGb9mJWEHFXQuFnWaGb0f9rdYqy63Ma9KGxvb6nHMfR+Tb1HUVSfLXSdroeQWE2/mkq/XA82AnfO4RhdA5xPHGeBcvjgdnota16ikg9fq9kInBk7Xp0JGjJhlWt2AIzoaP1IdT0g/iTQjLEqgreT5F9+OwzZ4=
Received: from MWHPR10CA0002.namprd10.prod.outlook.com (2603:10b6:301::12) by
 CH0PR12MB5106.namprd12.prod.outlook.com (2603:10b6:610:bd::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.22; Tue, 20 Jul 2021 11:03:05 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:0:cafe::79) by MWHPR10CA0002.outlook.office365.com
 (2603:10b6:301::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Tue, 20 Jul 2021 11:03:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 11:03:04 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 20 Jul
 2021 06:03:03 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 20 Jul
 2021 06:03:03 -0500
Received: from wayne-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Tue, 20 Jul 2021 06:03:02 -0500
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: consider paging job always not guilty
Date: Tue, 20 Jul 2021 19:02:51 +0800
Message-ID: <20210720110250.356504-1-Jingwen.Chen2@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7900a750-55de-48a5-0206-08d94b6df303
X-MS-TrafficTypeDiagnostic: CH0PR12MB5106:
X-Microsoft-Antispam-PRVS: <CH0PR12MB510684D94EB84CF3AF089FA6B7E29@CH0PR12MB5106.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nh89cXkdDwMRsCgHSyXxdmXqnBA7QbJQJr3Bo3opF3Mr81gUJ2/z0ZNzLI5RcPMlkGIj39DrdRnX8hxydYDnPCdXPNaE+NdGP2Uc2v1FIX3CXlKJfK8rf3IwCMLw5VoDVVlNGmDraaYd0sDgVO13AWDy/EaU0ttIXg7Y+koA3Ks4p1E8vdFj0jqBqTv5QF7vKhkH3+53Y8s//YF+xKnd5v0N2fXcb2VJiw2dwLCNwn3jLebCq2MlZg+PkEVwmu77jh6xYO75gDexdGiTwz7PmEmVT/BZps3Y6d9C9JBQOTEyFt2kh5ufau7Kqif9WVOEYZ5C+Za1hqHY59YXhW+DwnmWGgaZ3QypbgI5m1pZ285RryfHErhqLUgVjV/2gsbwUZIMA9FeENFEoskMhgB+se6oYd1/BEfFiUaiebt+0Se7tXbhrZG2MfMShoWepJuC4ti7i1UWy/lG1aZwkd/Htz2WnYTJFPsXws4UTi/i5LiEyeAS63xalmbFVYK96yoq2YP0F+kUiYpxBECiNRC+pmD2MS3izSVByUvm65mKeSFoLjcSF09jCekfuoEotlPKHSDyLJl7rVAsT5Wv9OxCpMI2wsAZF7eufrwQbnJI75mTQWXgz55NwHYSSWaz5eAEN94sq7dwmp3SqC6y1wTQ/bKL49bYBUGNivqfu8frCs1LiycWDhZJ93962vRdhKsg85y1OY524O6XBdF9hbVzBq6v8fd0wlR+aDcBeWsKYVk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(396003)(376002)(36840700001)(46966006)(6916009)(83380400001)(1076003)(8676002)(36860700001)(36756003)(426003)(81166007)(478600001)(186003)(82310400003)(86362001)(47076005)(336012)(26005)(356005)(7696005)(316002)(2906002)(6666004)(8936002)(70586007)(70206006)(2616005)(5660300002)(4326008)(54906003)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 11:03:04.8505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7900a750-55de-48a5-0206-08d94b6df303
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5106
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
Cc: horace.chen@amd.com, Jingwen Chen <Jingwen.Chen2@amd.com>, monk.liu@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Currently all timedout job will be considered to be guilty. In SRIOV
multi-vf use case, the vf flr happens first and then job time out is
found. There can be several jobs timeout during a very small time slice.
And if the innocent sdma job time out is found before the real bad
job, then the innocent sdma job will be set to guilty. This will lead
to a page fault after resubmitting job.

[How]
If the job is a paging job, we will always consider it not guilty

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 37fa199be8b3..40461547701a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4410,7 +4410,7 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 		amdgpu_fence_driver_force_completion(ring);
 	}
 
-	if(job)
+	if (job && job->vm)
 		drm_sched_increase_karma(&job->base);
 
 	r = amdgpu_reset_prepare_hwcontext(adev, reset_context);
@@ -4874,7 +4874,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			DRM_INFO("Bailing on TDR for s_job:%llx, hive: %llx as another already in progress",
 				job ? job->base.id : -1, hive->hive_id);
 			amdgpu_put_xgmi_hive(hive);
-			if (job)
+			if (job && job->vm)
 				drm_sched_increase_karma(&job->base);
 			return 0;
 		}
@@ -4898,7 +4898,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 					job ? job->base.id : -1);
 
 		/* even we skipped this reset, still need to set the job to guilty */
-		if (job)
+		if (job && job->vm)
 			drm_sched_increase_karma(&job->base);
 		goto skip_recovery;
 	}
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C68AC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 06:38:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7342E11BE08;
	Tue, 12 Jul 2022 06:38:51 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5069611BE08
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 06:38:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmMHaV8kpQIhnt2ZreAs+FA6ruv/xaU55kJfCyzU3/V6oWMQnnKS6lRZDRGkl3re7eJyAEYUikvAtVZuY+lz6ALwTtWk5QvuhCBqBoNpw8r7yARwOF3rIEW9wuE0b/8ixyCdz1GEMp4tcK6ZGSpqu7p3Hix4EVZcQS6k0DHN3P9RYN8Mq5AD7Hy7OW0YH2hxlR0O8XitTAhYJh//mqdOgmJdMtGwsA/JuMJPJaEsUG9MeJafVYFtlyOpzn9zyKsA3P7K5n727WFg2ruDllMwHnb3KMyatiPi0/SsUXQEm3Wj3br2nxFkpxrGzsMnyXXJV2gKBID7M/ECEyNkpETkHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/ZverRzATgjg9Yxe6UCzNAOYa8BnMITFeRueoHgZWc=;
 b=HP0o2G2xzUlHGv4EC8GKqrSwzEZ5CqaVAkgBf6z2W8M78A71JjJWvqPlHw6D6tY59xLrABltOzs1fXvB67wbxdymHSaK5YIoR1jgU+vFLeMwe+jFlSb1BylffpsBLyvBkZp4iLECq46NSekc5fFIdMCPDkFxNRPjUDqw+ALrQs4lOb6nP5CScfQsdS2mDp42dWkW01jXelDCXcXtxfLc8xzNq2j1ld24yH2YsjkikmvHZ4+WipeIl4O1KuNm2y4BQN3/rbKXpmgovyq/9mVQQs+w/qwPA2IjaL0M+kKRL8leDa9F7Ffec8zw62PAOx2IJhIgL1ODuVv6JM0p18wU4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/ZverRzATgjg9Yxe6UCzNAOYa8BnMITFeRueoHgZWc=;
 b=XxFaKkwbUKQOpjB5BDNEUWZnrFlS+MtRvFGCoKx/XvQCw27QswGUlSDVQ/IW9c8Pd9EUpmimKRxwpvAGQBqAUNCMNOBRtI5LPLzbKKQOnQmwgiUweGEZN43WLHjmpIXnQxTxyU6GIa3v37ec32iJcLWCLdOPkNGgxqWhulqjfn8=
Received: from MW4PR03CA0310.namprd03.prod.outlook.com (2603:10b6:303:dd::15)
 by MN2PR12MB3024.namprd12.prod.outlook.com (2603:10b6:208:cb::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Tue, 12 Jul
 2022 06:38:44 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::37) by MW4PR03CA0310.outlook.office365.com
 (2603:10b6:303:dd::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.19 via Frontend
 Transport; Tue, 12 Jul 2022 06:38:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Tue, 12 Jul 2022 06:38:44 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 12 Jul 2022 01:38:41 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <lijo.lazar@amd.com>, <evan.quan@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: use cached baco flag as the check in runpm
 (v2)
Date: Tue, 12 Jul 2022 14:38:27 +0800
Message-ID: <20220712063827.28300-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a86c441-8531-43e9-1611-08da63d12add
X-MS-TrafficTypeDiagnostic: MN2PR12MB3024:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8DxmjChazkXociOtvIyh+lvky7EWvIz/MPYwywKpXqe1uydMmdHcKwM6T7M4VgP0Nq67wyv+TZlPIQ4rOoP7d4r3QtrrNtCs7pcgCVDuG36n30+Pcdt9/5R/uxK97VpLyUpetH8U9okaTK0Q945pE26RqSyUKS2mQ7SjFNH2/Qc/fUx36rMoGLqBf0AEx8Q6C50qpHq1iBiX9FS+MwgNuMyf/l4Es0Y4c4P+Yu14HVo1Av5j1yBKDxcPwBnH0GHwn47T5E7q7ZbxNIk0QdCp7Jjut8LlBWNzOaWHif7igkfmXM3AzzKun1rdWvqV5L95zmePpGZbpADtTISf14xRYPXAhFylq573ZjqPWUU1uuw91wsOKWDlYqJE7PWP0Rt05HF2c0406UHStG5skXgz2wAG5lO1mFb3kAFkZeP0lybuj+SuS2horotSGdmMzKRYwT1JaCK7McjXNIjMVefNDSCGMnJR+s7RNkwHrIMbaAj3ZLEjI3dDlBm9aTkjIgEg5/RbzxHhA/m0mErLzoBmovmumLsGFi5PCAVpD7uXbQoI8X8DtnUVfpIoEXOcK6KiSlOrif49NkQIo2wWaOB8e2+M7r6viCxfogebg/frLKYJytUQ9UOzluX90+TbiHgVfxRP77jyWkVkQ3staB9jXOcxg9JcqVBqK0aE8Yx7Ec3cYsT6UE+4ovKAhtGGl2X0H4Tw7vlDo+HjrylAz4vMY1CED76TFgwk2Thq3pMZf89iBhRMlq4u8Y0oiaPbAh+EfQIsY2F6+O723nfItLe8YQNcZQN3cpCUn9au6Ek6Bbh0ncPrklnZZVVH2PY62vr/ZDgX4+kkNcqRXw5LaarPmBNfwwaMSnRTiZoXD3EpxdnGfbKhI4f+ggjgmAZXoOTk
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(136003)(39860400002)(396003)(40470700004)(46966006)(36840700001)(70586007)(8676002)(83380400001)(4326008)(70206006)(2616005)(478600001)(82310400005)(6666004)(41300700001)(26005)(7696005)(110136005)(86362001)(81166007)(6636002)(1076003)(316002)(356005)(186003)(16526019)(47076005)(426003)(82740400003)(36756003)(336012)(2906002)(40480700001)(5660300002)(8936002)(44832011)(40460700003)(36860700001)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 06:38:44.1981 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a86c441-8531-43e9-1611-08da63d12add
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3024
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SMU will perform dpm disablement when entering BACO,
and enable them later on, so talking to SMU to get
enabled features mask in runpm cycle as BACO support
check is not reliable. Hence, use a cached baco flag
to fix it.

v2: cache this flag in load sequence to simplify code (from Evan)

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 845d6054992a..816f813a5df2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1014,6 +1014,7 @@ struct amdgpu_device {
 	bool                            runpm;
 	bool                            in_runpm;
 	bool                            has_pr3;
+	bool				is_baco_supported;
 
 	bool                            pm_sysfs_en;
 	bool                            ucode_sysfs_en;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 1cc9260e75de..c3f870c01c47 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2513,7 +2513,7 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_DYNAMIC_OFF;
 	} else if (amdgpu_device_supports_boco(drm_dev)) {
 		/* nothing to do */
-	} else if (amdgpu_device_supports_baco(drm_dev)) {
+	} else if (adev->is_baco_supported) {
 		amdgpu_device_baco_enter(drm_dev);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 4b663866d33a..532406d32fba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -188,8 +188,10 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 
 		amdgpu_runtime_pm_quirk(adev);
 
-		if (adev->runpm)
+		if (adev->runpm) {
 			dev_info(adev->dev, "Using BACO for runtime pm\n");
+			adev->is_baco_supported = true;
+		}
 	}
 
 	/* Call ACPI methods: require modeset init
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index de59dc051340..f05d7ac03122 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2353,7 +2353,7 @@ static int psp_load_smu_fw(struct psp_context *psp)
 	 */
 	if (adev->in_runpm &&
 	    !amdgpu_device_supports_boco(adev_to_drm(adev)) &&
-	    amdgpu_device_supports_baco(adev_to_drm(adev)))
+	    adev->is_baco_supported)
 		return 0;
 
 	if (!ucode->fw || amdgpu_sriov_vf(psp->adev))
-- 
2.17.1


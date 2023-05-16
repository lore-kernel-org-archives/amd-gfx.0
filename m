Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D709C77B75
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 04:14:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8CAD10E39B;
	Wed, 17 May 2023 04:14:55 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2055.outbound.protection.outlook.com [40.107.102.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D9C110E39B
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 04:14:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OmMOWGYym3HfF4zJmpYNhtpDbkdiSOff0h5S+2970j60qokroAUpBWaYmWDfaVGr8D3tVS3VtqhikMxKzZx88xp24tAoZtYWsKyXoKtwJkRaNHRE09I6RDu8NvMqR4QoHMcnzkqGuwMjqFQsLgPGVGKiQHGRHnYoZnxeZ9NucT7AKNo8nZMftq3a+qvK/Ar72T9n0BJmtMCGyXse6MNIOulmDcDADf+vogtPlpWwJLSTp/xfkyn95KqmCeF8FnTReELPWQRwkemO6o481H9ukt1haYCsxCWNmzKPfBy7oWXlrMR8vWSgCWp6vlC7p3tvlr+kzb9ZyuJUViCw8sRFbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DI8Yy1/A0DJUlj3CirsEEvPL5N4me+ui+VdAFq6pbHI=;
 b=ZHv6PZsbCWFT/uuSNe9K3FIiXNddqm6D8v30AFo/uvOV4fyQ5D54NsgBPjGGdcSFWSC7hLtfACqSGfeRs26PdzRC8wQy22WEwBQKSxUVGgtyY5MsuMQuNUOtPyzUQ9dr+NFyYDyBWz6v/QcNPFBBrHbK6NKAkC01PYwdh0wRTCnVwFMI546I1TkB3UsiiWLd2AGThK2e++kwcH6wS7aZmNjlU2WP3pBn8gMsVMXG3c5yzq+eBMXA6Y5pHFeIjmseOBqsB+LbjDlaCd7Z9iGl8tLeoJ6ZlAGo2e4Cd9f8OxpDF93wI6tH7KrLQWArelfS6O7koxIilr9EqklT9wWTNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DI8Yy1/A0DJUlj3CirsEEvPL5N4me+ui+VdAFq6pbHI=;
 b=Jjxlm1cmPSFhb/hBqUFv2CRpvX+JVb4jbxOH70OoqLOs4cUbGTDcBbCgqFpw7U0XC9brb2CALDkVPrfWl0XuiDzCRvD4km/d4hrkrYW9IkDrjWM5UA69FlIhb/4IMW9M8wkeNN7HohQo12afH7WEyqN37vuNcYO6wpD5gCA9On4=
Received: from BN1PR12CA0022.namprd12.prod.outlook.com (2603:10b6:408:e1::27)
 by DM6PR12MB4547.namprd12.prod.outlook.com (2603:10b6:5:2a9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 04:14:47 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::7e) by BN1PR12CA0022.outlook.office365.com
 (2603:10b6:408:e1::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.34 via Frontend
 Transport; Wed, 17 May 2023 04:14:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.17 via Frontend Transport; Wed, 17 May 2023 04:14:47 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 23:14:46 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/3] drm/amd: Flush any delayed gfxoff on suspend entry
Date: Tue, 16 May 2023 18:34:18 -0500
Message-ID: <20230516233420.2087-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516233420.2087-1-mario.limonciello@amd.com>
References: <20230516233420.2087-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT059:EE_|DM6PR12MB4547:EE_
X-MS-Office365-Filtering-Correlation-Id: 26336702-0356-449b-610b-08db568d4047
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d5fzZ28oOaOnppINruRfGKZbaIhtB5AHstEoF0yQYS/22IiV6rU1pNgu21R75S0ltG4O6NSINi3D3mFEtK0hEKJlY+tv6SsRbwH7OLfiRQfFGL3kH2KUw4fwZxAtKOcvxZ909gqUtwDYNJIqB0p3P6mTo7Y7xRTJ6yYYx9Jio+R6e014IhiQUnCeiNivgKNaWJb68jYUCsG0Xf6Q0lVJTz1dXFVxx9ejP5TXl0U0ZHJ0mzgzMuqj13qYZKR7G+Mtg/67jsQAwRa0ydV6X7mGnsWFPY+LiDWb5T+M9Z7OVq4eAXQiNXnTHA8JlrtoMToSykssUbucwwnM+pAKgGhROqBPExZEASCI9IxwM5qAec39sSqxJNgjwdAKDgR7oBJv2ejcr1JabI4v13XM1Doar25RlyZDp9IqcuQlt9JudmAw3LED7KnkoWy6SNhEnhTqSzc1zzQavmPz7n5HVJ+WTbZTGnB4MrNn4c5ZL1HDRQpzFBXsKkJ/MLUlwIAxTbdDj+gykPtIvml+yBmHpqJ8AizzDAt2OJvN8s2jiUvZBYUoWupcYfRuCjiz8Y+NUvrdrzXkmQ4DMgbemiQIQSzJcbwiThmqAiN1uF1Uu2sW39C13R55uLTEUBi+CJEKPTJV4zJO/rpj4GutgVH6TSKH3KSmUKI+stz/4ak3g0VQ8/XJuXnW9Ltk758qLIDeGxVTH6twzyt7DQxZG+WPeMmnR+Bm+R/VJyknvZ1H57mjiIgzguCIMc+tLWI5pk9rL+RVw1GyaPI3Vu7KdsdQv+m+3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199021)(40470700004)(46966006)(36840700001)(36860700001)(83380400001)(47076005)(426003)(336012)(478600001)(7696005)(6666004)(54906003)(2616005)(1076003)(26005)(16526019)(186003)(44832011)(2906002)(8936002)(8676002)(5660300002)(36756003)(40460700003)(41300700001)(81166007)(356005)(82740400003)(6916009)(4326008)(70206006)(70586007)(40480700001)(82310400005)(316002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 04:14:47.1385 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26336702-0356-449b-610b-08db568d4047
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4547
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
Cc: anson.tsao@amd.com, Tim Huang <tim.huang@amd.com>, Juan.Martinez@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>, richard.gong@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DCN 3.1.4 is reported to hang on s2idle entry if graphics activity
is happening during entry.  This is because GFXOFF was scheduled as
delayed but RLC gets disabled in s2idle entry sequence which will
hang GFX IP if not already in GFXOFF.

To help this problem, flush any delayed work for GFXOFF early in
s2idle entry sequence to ensure that it's off when RLC is changed.

Cc: stable@vger.kernel.org # 6.1+
Suggested-by: Tim Huang <tim.huang@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a9d9bbe8586b..059139f1f973 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4316,6 +4316,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 		drm_fb_helper_set_suspend_unlocked(adev_to_drm(adev)->fb_helper, true);
 
 	cancel_delayed_work_sync(&adev->delayed_init_work);
+	flush_delayed_work(&adev->gfx.gfx_off_delay_work);
 
 	amdgpu_ras_suspend(adev);
 
-- 
2.34.1


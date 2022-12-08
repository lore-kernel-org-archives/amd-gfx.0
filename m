Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17896C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Dec 2022 09:26:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BC4A10E482;
	Thu,  8 Dec 2022 09:26:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8D7010E482
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Dec 2022 09:26:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sr1uQdo0GxYivpEiTY3DM8MTIUsNqhnBY5mhrKAQyvMJavAEihw2zUEVwyC5aL4UrXa4sQaDLtWcOm4jxCHZ1IBgBu2qTPvaOKf4WTgNudQpnLpyg439RYsfdMuywg/Csa4grTpfajf0Jb4LqofBE50MldGvjVP2IymlG0frqid9moZ9UfD2B/SGSErkYJnOYCJ2M4YHKNEAFNtyUHNofK6PmZLD6LnzVRz3DE9M7UgSyCxw7u/dJCaK5btfcx63Mb8BPyEKslSkPGir7SnzeqiR+t945dwqsartSRm45h+J8bnddWZxwqpmMrr/6pKv0+K+c84cbC+QRxPXRLN6aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WFE4vDfXzhQlFXuyw4j9GT2vuf/v2z9+m4QLjAbFwlo=;
 b=FKiSkJzU06+7Zxg4U2+pFLIQyv1b0rVQEN8/z/Z+4XVSREr664f3ZPFvSs3OsvnZAowpFVNBQCrB+qII2o9fnz7xtUYUagKy5eovvWDpCBlS7DCro27vnZ86l7OD/fc5X4i4dUUg6vO5gsPPH6sJj/A7Ts6u9BSxa2aB/iCyeK3+tf9P2xdSrnU7v4yaYl/7t1PJqoBVDvIV7BeII/ycUMtgez4b3WKTnqOcG2c3snO2mUel/QYjip8BzRZ8qt19a5aR9aDyBtp82cMyQf0DN1peL1K2shi/3ZfgW+rTN+uS3WMA23lqlV/utkID4tbhslpDnWuFneoKk7ZEdEXsOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFE4vDfXzhQlFXuyw4j9GT2vuf/v2z9+m4QLjAbFwlo=;
 b=mpjEzFPoB7B8m3bIDUvQt8Dr0ijK3X3uMu+DurSLq+KG0cYFHUna6fMoeiXA5vz3V4lP1qucD3lhujFde9b/HmDvlwDJ05b82gm1v5GJyIUueav4CKPk54v0OAK/nB2R/GXUsX6+dv61/ZoyMPd3BT99q3QfTu3puSMZwcqpm+U=
Received: from DM6PR06CA0087.namprd06.prod.outlook.com (2603:10b6:5:336::20)
 by CY8PR12MB8194.namprd12.prod.outlook.com (2603:10b6:930:76::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 09:26:05 +0000
Received: from DS1PEPF0000E645.namprd02.prod.outlook.com
 (2603:10b6:5:336:cafe::e0) by DM6PR06CA0087.outlook.office365.com
 (2603:10b6:5:336::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Thu, 8 Dec 2022 09:26:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E645.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.8 via Frontend Transport; Thu, 8 Dec 2022 09:26:05 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Dec
 2022 03:26:05 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Dec
 2022 03:25:52 -0600
Received: from shikangserver.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 8 Dec 2022 03:25:52 -0600
From: Shikang Fan <shikang.fan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add an extra evict_resource call during
 device_suspend.
Date: Thu, 8 Dec 2022 17:25:45 +0800
Message-ID: <20221208092545.4792-1-shikang.fan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E645:EE_|CY8PR12MB8194:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c314fb4-1612-4a9f-70fa-08dad8fe3b64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2lwEX0rWqQHLpaZtLrDY22qA6yQWOloklZl80O9TNwi04DAc6WWz3QoAWTyoJo87Vklo6E5S/dncn9l0nu/OgvD9e5j5hX8RGmEom3UXsfE5mnxiXZL9MmkjF1lneVM4DuWC+05OH8p3CB6YZKh3X6KFvFU6+W16WV65/nfxoGBOEAm57Q/kiQsQnHz7BT8Wu7gPDjLO6LzjFnOiBXGVw3U/HUxix80Htjp5RXSZ+gPI+V3Y8c0bMhWpXwSownCPU1sFxz/Q1GXRquCU5p7XGJTZqie0pfrDXl2V9b3LhTEz+npHqSn9FMhaJKS9mRliID3sMDU0GToysL84sNcVb7H7qFjLIjqRS2UEkjntZ5IYsUOuKlIUeX4od2y4IYRz+kKMyG1zjxdtCucm7nJnTbEGtvCmbjv8Yi4dEGW4E3M00mgyJnLSz7IRsjAXiP4+0xiQRkty8nEWKMlQaFsMoui75AvgO8wExIdUIhwYVp8ENjDhs0gSN3maEh0zOOHK9ZogG1fA5/O1che9oVwqs+5bArQds7xE5XgX8t17RNDz3nrhQ/XB3rt6X6QL4m1+3gz+9cjhGJlNq1Qu7319ktd+1c8yMb6fyQL8KBYA+rvgK+DdaWadTcSovJNzT5IZojLaztnJj7oHsvKQFN7tRHVM8VWhvixrn0+3o243agugb2rMKNzP31XCVJBRzuru9Vg2Ymf5sLYtpNoT8g0gYy/RQom3epokICeYXheZsoo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199015)(46966006)(40470700004)(36840700001)(36756003)(8936002)(81166007)(86362001)(356005)(44832011)(40460700003)(41300700001)(82740400003)(4326008)(2906002)(5660300002)(36860700001)(83380400001)(316002)(70586007)(2616005)(8676002)(6916009)(82310400005)(40480700001)(478600001)(70206006)(186003)(6666004)(47076005)(7696005)(26005)(1076003)(426003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 09:26:05.5296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c314fb4-1612-4a9f-70fa-08dad8fe3b64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E645.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8194
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
Cc: Shikang Fan <shikang.fan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

- evict_resource is taking too long causing sriov full access mode timeout.
  So, add an extra evict_resource in the beginning as an early evict.
- Move the original evict_resource after ip_suspend2.

Signed-off-by: Shikang Fan <shikang.fan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 818fa72c670d..8b7db87cffd9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4111,6 +4111,10 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 
 	adev->in_suspend = true;
 
+	r = amdgpu_device_evict_resources(adev);
+	if (r)
+		return r;
+
 	if (amdgpu_sriov_vf(adev)) {
 		amdgpu_virt_fini_data_exchange(adev);
 		r = amdgpu_virt_request_full_gpu(adev, false);
@@ -4135,14 +4139,14 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 	if (!adev->in_s0ix)
 		amdgpu_amdkfd_suspend(adev, adev->in_runpm);
 
-	r = amdgpu_device_evict_resources(adev);
-	if (r)
-		return r;
-
 	amdgpu_fence_driver_hw_fini(adev);
 
 	amdgpu_device_ip_suspend_phase2(adev);
 
+	r = amdgpu_device_evict_resources(adev);
+	if (r)
+		return r;
+
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_release_full_gpu(adev, false);
 
-- 
2.25.1


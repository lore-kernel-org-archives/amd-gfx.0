Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E62FC83F01
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Aug 2023 05:57:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4CB010E0F1;
	Wed, 30 Aug 2023 05:57:24 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE82310E0DE
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Aug 2023 05:57:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZDoQaPBw7lHAJMemYlCqFUVrHtrp5NyLN0qlYx8I9ii3ETQOe4lkLzvoGrRsR47SPiIuPI9roofEPXgH2HaWSzCx0VcCIvgoMzvJ+lTvxfSCIikfje67N7bWpbp/zpVul8H7a5t8CMpxRku5ujaUBdi0k992ABx8AQSXcTD0LseNwdF3gDZ7W/dN+Ck7D3noEpgxA+NfJ7d6Xc4b31jcDkiKQFzQ5Pe95Hd/enelnssvYvEbZ1wAW4XvspHlmOfIokFEA9gNNKUtV/1dYeBGXHqMyVRNa6fensmaDRe6Y+uUYX1OanceJyQIGug8oBJBjGfSwZVN5TGPd5BtdUt3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfNQv9yIB5DpWiooIlAO+dPTpJg0Zo+Viw4Hktqbqqg=;
 b=VBdF/R9IN2FW/MjfbDidB0b7qZW6CmA/Vnwfq9sbvmpLTluLHcmY94DzoEzHec6mSmgm2sziyeYEo26vkNd7E8M5jjNbzwZDJma2ucqdVCwUJlzVULocKmhA0TtQCJjP5s+kI+VGJ8x4utszqvFOysKwPeKBd1JbOUoFQ0wdnaAkyV7gRyoQsp6WbI7rGJNGSQkE69WoDygREr8q9DDPF5EC1QiukCCbb5M6U4T2rRnywbu6AqwW8W6UZFlkdWnR+GBxCnRtel4LCw/V25ucb4LlcMjad64gkjOVuijVoE4Bt7V6zGJqtCFOxO5cES176bXrGfBYM2VnWaDI4H5/6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfNQv9yIB5DpWiooIlAO+dPTpJg0Zo+Viw4Hktqbqqg=;
 b=dCMxko68FqiRDE7oTfDY8IJl9mpdZ1v+tLz/mo6HiAIFvY7iV7mbCLICHmCUWuiZZOt3nMY31og5ceAOlFZiX/i2kZ83uBBFtGL2vmSf0UtfayIvOaFzZkUolKlOUythHFhnUNqY3JAh036oDn+PVhUu/eWGzZZOzWu5NHOAwWU=
Received: from CYXPR02CA0095.namprd02.prod.outlook.com (2603:10b6:930:ce::24)
 by LV8PR12MB9205.namprd12.prod.outlook.com (2603:10b6:408:191::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 05:57:19 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:930:ce:cafe::47) by CYXPR02CA0095.outlook.office365.com
 (2603:10b6:930:ce::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20 via Frontend
 Transport; Wed, 30 Aug 2023 05:57:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Wed, 30 Aug 2023 05:57:19 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 30 Aug
 2023 00:57:04 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [V3 2/7] drm/amdgpu: revise the device initialization sequences
Date: Wed, 30 Aug 2023 13:56:43 +0800
Message-ID: <20230830055648.477908-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230830055648.477908-1-evan.quan@amd.com>
References: <20230830055648.477908-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|LV8PR12MB9205:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f847fa1-f764-474c-5538-08dba91df8a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ts9w1XaV1cYwd6nK0Wl3xIRGgWMZ1dj1mJ9aLqNNmbR2NuG+VOvewJYyDJp3c4oXjZB4amjnAmf+nXjhtIxxJ2AR2GwU8am3UEqOLL3QhXwaK2AISwbQY5yJqJwQBZAH2A3mE26r5WkHCD+ncGotBFHeVQSGZxKJuCzS+L2bnjuR6qXL3z/FyVwf3PLWCdp+3U4lzEh8/mzhU3+W9NvTDbAe28GbKlJNgYuyCc6oX99ZE4F54R7nuBOD5lrASdHtSm4JoCuJonM2HOSjuMtCVCtGteCUbvqIvxztARhnN13V7oqlIeVbU+Ozw1B7RnFrmX52Lva6OfbowlayZ8SfUJRLm/AbZuzL2okBXX713OhfP5aDStKJA+J8oUpX64HtI71b8XW4FHNGQghZmauN5vCDEUv+USujadwpMEXdakfOvF5QwPHhu6sS89DkFGOdbPf7a7kXXhlW44+Dx58EQhvlO/Z012CRPP8ZMc+TGeFUSmd4wHGiiVPjqLgHfq4OibugpHDuRI47zdB7o3/KHz31QKUrPWRwRB6rlzZQF6BShPzj9C0ea2AhOKtFX+40bdV7glALYndpQsMjxDK8cnY1sIWwW4Eumz36jwEk80MBG8fnipDk/dVhmQ2zo22cE+YitNUk4JQ7knCm72MJYM+YvZRarO/aHNpPBGmMEPziCnQMpqv4xo51j4ur++kn+mbaBafxuuh3KMxzHL6svrPYvkKt7TZiZ34Xcb0pC3KqiGWpADGVItWmVyoDUvwS3l0E7b1dpK8qegJctRQskQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(346002)(136003)(39860400002)(82310400011)(451199024)(1800799009)(186009)(36840700001)(46966006)(40470700004)(36756003)(40460700003)(40480700001)(83380400001)(44832011)(86362001)(41300700001)(5660300002)(4326008)(8936002)(8676002)(7696005)(26005)(6666004)(1076003)(2616005)(426003)(16526019)(336012)(36860700001)(47076005)(82740400003)(81166007)(478600001)(2906002)(356005)(54906003)(70586007)(70206006)(316002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 05:57:19.2890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f847fa1-f764-474c-5538-08dba91df8a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9205
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

By placing the sysfs interfaces creation after `.late_int`. Since some
operations performed during `.late_init` may affect how the sysfs
interfaces should be created.

Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 37 ++++++++++++----------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e588cf7a14f6..f324ef5da792 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3862,22 +3862,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	/* Get a log2 for easy divisions. */
 	adev->mm_stats.log2_max_MBps = ilog2(max(1u, max_MBps));
 
-	r = amdgpu_atombios_sysfs_init(adev);
-	if (r)
-		drm_err(&adev->ddev,
-			"registering atombios sysfs failed (%d).\n", r);
-
-	r = amdgpu_pm_sysfs_init(adev);
-	if (r)
-		DRM_ERROR("registering pm sysfs failed (%d).\n", r);
-
-	r = amdgpu_ucode_sysfs_init(adev);
-	if (r) {
-		adev->ucode_sysfs_en = false;
-		DRM_ERROR("Creating firmware sysfs failed (%d).\n", r);
-	} else
-		adev->ucode_sysfs_en = true;
-
 	/*
 	 * Register gpu instance before amdgpu_device_enable_mgpu_fan_boost.
 	 * Otherwise the mgpu fan boost feature will be skipped due to the
@@ -3906,6 +3890,27 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		flush_delayed_work(&adev->delayed_init_work);
 	}
 
+	/*
+	 * Place those sysfs registering after `late_init`. As some of those
+	 * operations performed in `late_init` might affect the sysfs
+	 * interfaces creating.
+	 */
+	r = amdgpu_atombios_sysfs_init(adev);
+	if (r)
+		drm_err(&adev->ddev,
+			"registering atombios sysfs failed (%d).\n", r);
+
+	r = amdgpu_pm_sysfs_init(adev);
+	if (r)
+		DRM_ERROR("registering pm sysfs failed (%d).\n", r);
+
+	r = amdgpu_ucode_sysfs_init(adev);
+	if (r) {
+		adev->ucode_sysfs_en = false;
+		DRM_ERROR("Creating firmware sysfs failed (%d).\n", r);
+	} else
+		adev->ucode_sysfs_en = true;
+
 	r = sysfs_create_files(&adev->dev->kobj, amdgpu_dev_attributes);
 	if (r)
 		dev_err(adev->dev, "Could not create amdgpu device attr\n");
-- 
2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E417CCF2D6
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 06:49:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF4F510E04B;
	Mon, 19 Oct 2026 06:49:06 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013066.outbound.protection.outlook.com
 [40.107.201.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFD9910E79F
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 06:48:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H3NBmKsD1MSI0MafREXf0UMddjINpKrtVTiK+ZkwJacZAVtLl0Fa78zCqA9nEwRVh6qMPXKU+/zzItXKhU3RHQEdi3oqgkdLikj32LWGnDyOrhXjG2rTF1Ouls22MlEVZjUHx9eZQvDIjIblD73qceVe7fm3AnLep/pPNiQiNakGH3NxTuuiMyFEORfO6vb6YDBplsCxK+InOQuNkckpSqe3RDr/sSAHINIffAkPP7HSb8IjjmklMJBTn3iEl8oI2OYBotYq0qxpmnqoJLLS9zWrWe8foplWz5J945HP2kO+1yKL3GhVE8VU+o7A8yMsAeKShTVYXfakqvaso5iDrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19LpSeyxJbl9JNGXl4LWZkEqgUxyb4EdjtRIM77VimE=;
 b=uaNIK/8NeE6gyWeln7x6AyFCqzu+VUB8ZmMLX6BbYs9AxcxOaq2W8OPFz1HMyLG9RxoqutDsmxJE1KLGpKn1ODtDl6lDWmeJjAoWxnv4nat8pN+lfKwotyRSsXRtpCcOHEG8pVPb7wgF3WM2qLDueRKvs9Kz8X67g71wNuxA/y/RnoEYdRkTHU6GeqLhA90wKz8pZx9a0gQFga6zzEaL9bh2NhIAbz8SsbTJlxgeHhLzipE/WtK5Gp+MhCky3S5gPfftnMDmOHzcV/hLFLLw1h4hFjSxQrCRMxvnIS+eUrBszZ2sYtjab4XJeSX1sSq1atEGwH32DrNOpbcmSmHy+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19LpSeyxJbl9JNGXl4LWZkEqgUxyb4EdjtRIM77VimE=;
 b=AXOBPamrtFZxNHMfR9NHGD+X2qO3aEA2HOOjAT05x/qk7WaOtToFoofjmxs/6pxRej5myFfRjWTdt1bklpoB6lLJwb8blH95St45+5erkYmw1RKRFg/7BY5Ygyz0J6MrN3udnVb9Z0ThZ5TksGbWl0lfagtDh+gGI2vzt8qPKQo=
Received: from SJ2PR07CA0021.namprd07.prod.outlook.com (2603:10b6:a03:505::23)
 by SA9PR12MB407125.namprd12.prod.outlook.com (2603:10b6:806:a6::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Mon, 19 Oct
 2026 06:48:54 +0000
Received: from EA8PEPF00000009.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::4c) by SJ2PR07CA0021.outlook.office365.com
 (2603:10b6:a03:505::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon,
 19 Oct 2026 06:48:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 EA8PEPF00000009.mail.protection.outlook.com (10.167.249.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 06:48:53 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 01:48:44 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Vitaly.Prosyak@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 01/10] drm/amdgpu: save VKMS modeset state from the system PM
 path only
Date: Mon, 19 Oct 2026 14:48:29 +0800
Message-ID: <20261019064838.2577746-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF00000009:EE_|SA9PR12MB407125:EE_
X-MS-Office365-Filtering-Correlation-Id: d40f82ac-8710-4215-908b-08df2dad0a84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|56012099006|11063799006|261009223027099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: 9nJ4M3j+qLsTIDLoTZeg59iqfKdWRAQUlwEu7TluQSCmc5QOVZ6PuTjZO/JT+/ogOM+4BGxR4qvkv8m2+97wrb13CjZVaWkeCFu9cRJJnm5CBFt7JUkhP3YSAWBSUbSFuUnL2frsflMbrTmQuZzYpqmkwYYyosz1HKPlLYBVDpX1IQRfM8RBkjWlNAgOsgwom14vx5Aom7duyxCkOJTkWul6NlFL64579LKYOQBuog7DRopHPJyPOWpq5ZHMsYqIuqTTyZtmqE7pjAEGds4rI8b34kroyzkgPXzQmcl1EVVZlOCNZDpVJ6hFKCy2qUTVumjo8vjdQoRMzNQGsem0KMYkaBrjTsSMlgl9/h4O/nXX7wT30+7r+f+T/qBq27K8aje1d4Xqt+Bu/dbz4KT0vyWeKQLf5NQVsDi7rN8ks/helgY4n3xhHz/2eeIfMTg7UvT1A6azYL7amz3MiSMI23QMKCZMrFtA1+6A/gCLapWx1HlaOUmAe/erTOyNDlDL4tamUMj99IJAc1gZPHz4QxV1Z6TcVj6xsiTc7zGOqMzMytiIDVKCNYopUJqVIjzcBFQlPWDKmdWdZ7MKDJ2Tb1y/5kIM0nW3QA13GANV8WuTMAmskhXQOxPUTrxEXWcwfW/WlfsMrjNLbiCxWIlrHeJ9mqEsjNK6WAQ7nqE2R+o+RvgZcf6+/aqSjyWyiDeYdW+F3xgFme8gSsJpAyLiBg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vNG0snCQ4bt/2osgsHpYTMzyd7mVI7M6lSlnp4TbQnoeLcnpEVFLrOa4SabkBA0MR3po3jFQw6TrbPQNlF60xj0d8fRfqp3Sm/Li0yn2nHbk7kVJpkavW3dmZgk+woG+bX25hnVDz+u0YsfdoukK6xSHwNxmUzKdSdvGVtuSlXcOtSL7Jmc4/p2u34JEEqheYZH85M9tApK1UtzdHT3fvlLZW1U/WJkb4C2psMGOUNq5YTe0l4JKJ8Y1fyIhPeK8pUoRbpwatavUz2nKHp06g0RYRw71SomCGOsxgggqQKkbfkTKeO+dLC1/iIO1L9ploxKYjb0upHNhXjfHPmH/1RcNzJUU3WEotuNieNmgfAd4GEd+0ukvWK3fQg4MnUHYXNCE8rqQn7Vqv/Ijh3PQ6bi9QYaNi5ZV2d8Dz+rnEoPVIR0WWBIeIM5IgeuJZaYg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 06:48:53.7602 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d40f82ac-8710-4215-908b-08df2dad0a84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: EA8PEPF00000009.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA9PR12MB407125
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

amdgpu_vkms_suspend()/resume() are IP block callbacks shared by system
suspend/resume and GPU recovery. Calling drm_mode_config_helper_suspend()
and drm_mode_config_helper_resume() from them makes GPU recovery take
clientlist_mutex and the modeset locks and duplicate the atomic state
while holding reset_domain->sem. Lockdep reports:

  Chain exists of:
    &dev->clientlist_mutex --> &userq_mgr->userq_mutex --> &reset_domain->sem

VKMS has no hardware state that a reset can lose, so the reset path never
needs these helpers. Call them from amdgpu_device_suspend()/resume()
instead and leave the IP callbacks with only the hardware init.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c   | 14 +-------------
 2 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b74f9136aa2e..406c5f2fbee1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4568,9 +4568,16 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 
 	amdgpu_ras_suspend(adev);
 
+	/* VKMS modeset state is saved here, never from the reset path */
+	if (adev->enable_virtual_display) {
+		r = drm_mode_config_helper_suspend(dev);
+		if (r)
+			goto unwind_smartshift;
+	}
+
 	r = amdgpu_device_ip_suspend_phase1(adev);
 	if (r)
-		goto unwind_smartshift;
+		goto unwind_vkms;
 
 	amdgpu_amdkfd_suspend(adev, !amdgpu_sriov_vf(adev) && !adev->in_runpm);
 	r = amdgpu_userq_suspend(adev);
@@ -4618,6 +4625,10 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 		return r;
 	}
 
+unwind_vkms:
+	if (adev->enable_virtual_display)
+		drm_mode_config_helper_resume(dev);
+
 unwind_smartshift:
 	rec = amdgpu_acpi_smart_shift_update(adev, AMDGPU_SS_DEV_D0);
 	if (rec) {
@@ -4717,6 +4728,12 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
 		goto exit;
 	}
 
+	if (adev->enable_virtual_display) {
+		r = drm_mode_config_helper_resume(dev);
+		if (r)
+			goto exit;
+	}
+
 	r = amdgpu_amdkfd_resume(adev, !amdgpu_sriov_vf(adev) && !adev->in_runpm);
 	if (r)
 		goto exit;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index d6b51b3f216b..6de33f14d909 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -488,24 +488,12 @@ static int amdgpu_vkms_hw_fini(struct amdgpu_ip_block *ip_block)
 
 static int amdgpu_vkms_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = ip_block->adev;
-	int r;
-
-	r = drm_mode_config_helper_suspend(adev_to_drm(adev));
-	if (r)
-		return r;
-
 	return 0;
 }
 
 static int amdgpu_vkms_resume(struct amdgpu_ip_block *ip_block)
 {
-	int r;
-
-	r = amdgpu_vkms_hw_init(ip_block);
-	if (r)
-		return r;
-	return drm_mode_config_helper_resume(adev_to_drm(ip_block->adev));
+	return amdgpu_vkms_hw_init(ip_block);
 }
 
 static int amdgpu_vkms_set_clockgating_state(struct amdgpu_ip_block *ip_block,
-- 
2.34.1


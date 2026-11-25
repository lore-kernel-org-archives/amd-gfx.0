Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A222606A31E
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 03:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qAh0ENVr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41CAF10E5DB;
	Wed, 25 Nov 2026 03:03:17 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012015.outbound.protection.outlook.com [52.101.48.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1165F10E5DB
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 03:03:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUEivc+s0Knvc4pzIeb4qPbABzIf60B4WFmXaBox18KRQ9CoAAJmuCmSj57BBXgZFNNS/nOG7/DBsUHPLyyQorDZxOCp307zhmfaa1G2wXDdXArGLiZy29xF5DL/tJGdv+l09clK9H6aJahZogqus2XjjFSsgZle9UAQ6cM2ONHJQLRAueC1b51C2ZXkTAzu3NcaY9GR+Ek0/bT03zWgOsvjIc2GQcbuk2DxOJhFFd+VfOwkz1R8uXy/xdOLFO9zau+KKrHxWsW1PjYLQtWDrwNJWCb/YnktVBjKjlYksqjUjftcjE4v1H+1hsmREkP0KHjArq531q3iFuOTxWrBKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5UPV8N1YPHvxrCCl6/2WpQA5oUPiYKL3egLWRAVKYF8=;
 b=bvUi7g3iM4XkriaFqSmuZrhQcntbWn0P00QKGgUdgIKv+1xL55Gn44mFWsSU7unyZn3l/9HwC2emeHbFa0+NP/jJr/MUsrN5rKQNqzeBVK47X6m7Zqzqzwwj/V6SmgA3Y7NMEK4hj1o6mPSqANz2LGoTOcj2Myd50NfkMCyqFVK470imrouyuGtPIykmnL5ZH6/+f9YD7pacDJxugES0HUT5Y2Ovl38Nq49cYShbFjA7+U8RSNcL/OzGnu/aeo1tpR15enKwnuTgy2Li1ml1OhheD4b2ZArljsCCurdEprwi3zUMKPHOVGrGSuiVD/u1eQ1BdOzgB4kVrLR2Tgy34A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UPV8N1YPHvxrCCl6/2WpQA5oUPiYKL3egLWRAVKYF8=;
 b=qAh0ENVrZlHMrKPVUDjxb/TOuP6FWO7H2dgmTfdLFcwcBwzJurRZwDUJdzXwxj8mTYs/uyWscl6aTyQ2gkeZTJxG6wQ+Ynqsd2z1BF/iOec6D8mXbKHayrqvadVf+BZlzX5FkfQgbFB96oB5uxnKCRoNLf875MTfgDMh0W1dt/M=
Received: from CYZPR05CA0005.namprd05.prod.outlook.com (2603:10b6:930:89::21)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Wed, 25 Nov
 2026 03:03:06 +0000
Received: from CY4PEPF000392DB.namprd03.prod.outlook.com
 (2603:10b6:930:89:cafe::27) by CYZPR05CA0005.outlook.office365.com
 (2603:10b6:930:89::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Wed, 25
 Nov 2026 03:03:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF000392DB.mail.protection.outlook.com (10.167.247.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 03:03:06 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 21:03:04 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Sunpeng.Li@amd.com>, <Mario.Limonciello@amd.com>, <Lijo.Lazar@amd.com>,
 Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: only save VKMS modeset state if VKMS is
 initialized
Date: Wed, 25 Nov 2026 11:02:55 +0800
Message-ID: <20261125030255.767185-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF000392DB:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: d574db82-660e-4074-cdfc-08df4aa0a0f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|261009223027099003|18002099003|56012099006|261102123227099003|261026121527099003|261026140227099003|10067099003|261022105027099003|11063799006|261028144727099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: olgllEG7kqKD+xQMCMy5GqUcndBh++CTjpfwbhRB35VGlDjH2YerpeRf6/MgbyRd8Fi5Hq5ppIPkLUrxrkEdFOz/OiGMlyfcqWJ5LQqbJA9CwzqPZftEEH0pclxBj5y3YD7LmPgGAvsNN7yAOJZ3/Gi4VkbXDjhRxOvXzpX1bMvpjYl3RniqNbH64VkFrFAuoGPg/rXmI4015+DYvHUfd0arsur/2vOhcjICtsspgeA60tTaXzmchD1d2QwegvPcT6+tYBthyuTvapPihaA+nky+w80mj07VZ62wg1I7S8Ojgod45JFXKHh5Tn/o0r0uZA8UTaqIDJjHLH33pSDAsNys+mBfrmNddETfNLQpQO8qBnQ2G4oM57CiiH8eZDM5e9l4BAnQmub8MYXHfUmri/dnnrh8Pd0nA0hlzs6jpUKwo1lryzFvLusqA8LFpx7N0Bu1r2Y/6XElCan1IB1dAF5zfPYrEaxxeZZKJfxgSMv1F100lC1OqgWcdAd8UzKLh+1ty/x/GO9wyvvtwOE5n775sSX1D2bYC65fb2ZkgccHlegNEQ9DvHvrS1uXdHigrfi9lamu32p/AotnVhZERkCf2VTXeFOntZVy9+rxoRE93tbxnatWL2dMNnywddcRAZHKO6QZHmkmoB6TGD5MacuwBV2kh90tcsvONwG7gz5ivnfqYPuYHmCALkHdK6zw+y6QahJIOe0GNe6ppLagiw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(261009223027099003)(18002099003)(56012099006)(261102123227099003)(261026121527099003)(261026140227099003)(10067099003)(261022105027099003)(11063799006)(261028144727099003)(261021121427099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bVQfBLTxRyZ9uY96OH/XQvNx7fUoBXXU7K8Q6t1AfmiNR5Sj4hpT6zjusm8yQYL3rXTsKEuSArn0GCuyyMd+LiCRzLqmPVIX71kFUWRPmWfCBPSxkm7EsAMBVr7tFmALviwysJ8/gISUM1QXr8flpyRKxbfYzam+UcOjjOgser4fDuMaBQiR2AEn/iRedIVzT4MUIu7MrcThKbbLF/xd+VX+klaNHa54uFYD19kzj7ucyHegdGZ3IYS0AW86414uf9Wao/ytSYFzyzwzLsgt+3ECOxirWtluWSgHherri3yIriGKkd9WIxhSx9wnwtBnwr1c7MsY0zFdhZkY1p8y2KiYXgYbixnCvhHCsPyi0iuvWpuM33epu+Zm86fV65xk/mmu76u4D4FOZZ5JH13ZBbTq0/aBd5EaYVqiDmK33PvjXUAT6KsR2GKeT4k1AowD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 03:03:06.4632 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d574db82-660e-4074-cdfc-08df4aa0a0f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF000392DB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6551
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit 11a08cd5ab25 ("drm/amdgpu: save VKMS modeset state from the system
PM path only") moved drm_mode_config_helper_suspend()/resume() from the
VKMS IP block callbacks into amdgpu_device_suspend()/resume(), keyed on
adev->enable_virtual_display.

That flag does not mean a VKMS IP block exists. amdgpu_virt_init_setting()
sets it on SR-IOV VFs from the common block's early init, after the IP
blocks were added. A VF without a usable display IP gets no VKMS block,
so its mode config has no funcs, but enable_virtual_display is still true.
The old .suspend callback was never reached on such a device. Now
drm_atomic_helper_suspend() runs and drm_atomic_state_alloc() dereferences
the NULL dev->mode_config.funcs.

amdgpu_pci_shutdown() calls amdgpu_device_suspend(), so the guest oopses
on every shutdown and reboot, after it requested full access for FINI and
before it releases it. On a Navi32 (Radeon PRO V710) VF the host times the
full access out and resets the VF:

  Received Event: VF1, event = 0x3(REQ_GPU_FINI)
  VF1 entered full access mode.
  VF1 full access timed out!
  Issuing FLR on vf: 1.

After repeated timeouts the host ignores the VF's REQ_GPU_INIT_DATA and
REQ_GPU_INIT, and the next boot fails to probe:

  amdgpu 0000:06:00.0: Doesn't get msg:1 from pf, error=-62
  amdgpu 0000:06:00.0: probe with driver amdgpu failed with error -62

Check mode_info.mode_config_initialized too, as amdgpu_device_fini_hw()
does before it shuts the mode config down.

Fixes: 11a08cd5ab25 ("drm/amdgpu: save VKMS modeset state from the system PM path only")
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0254b5531238..700d7517f22e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4603,6 +4603,16 @@ void amdgpu_device_complete(struct drm_device *dev)
 	}
 }
 
+/*
+ * enable_virtual_display is also set on SR-IOV VFs that have no display IP,
+ * where no VKMS IP block was added and the mode config was never set up.
+ */
+static bool amdgpu_device_has_vkms(struct amdgpu_device *adev)
+{
+	return adev->enable_virtual_display &&
+	       adev->mode_info.mode_config_initialized;
+}
+
 /**
  * amdgpu_device_suspend - initiate device suspend
  *
@@ -4644,7 +4654,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 	amdgpu_ras_suspend(adev);
 
 	/* VKMS modeset state is saved here, never from the reset path */
-	if (adev->enable_virtual_display) {
+	if (amdgpu_device_has_vkms(adev)) {
 		r = drm_mode_config_helper_suspend(dev);
 		if (r)
 			goto unwind_smartshift;
@@ -4701,7 +4711,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 	}
 
 unwind_vkms:
-	if (adev->enable_virtual_display)
+	if (amdgpu_device_has_vkms(adev))
 		drm_mode_config_helper_resume(dev);
 
 unwind_smartshift:
@@ -4803,7 +4813,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
 		goto exit;
 	}
 
-	if (adev->enable_virtual_display) {
+	if (amdgpu_device_has_vkms(adev)) {
 		r = drm_mode_config_helper_resume(dev);
 		if (r)
 			goto exit;
-- 
2.34.1


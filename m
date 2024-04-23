Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D89C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 02:33:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40EC010F9D5;
	Tue, 23 Apr 2024 02:33:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tRimD0W+";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A96E10F9D5
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 02:33:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kg/U9+ecK3Yen6mj5HOYazY8WYsr2DojYZvhtye2UrFjDhj7Y/Jd/yBvT6r2kgEQWYfQZr5Yj3S2cjYAtSBMTcFEbCmzuQ4h319/nrV0ubI26+EMXLuTW7TGaplV/5b79GMrJO3nNyTqDVdrD5c49Cqh6NJU6CwNewg/VDPK3GeTNWfHgbSYWhV+4aRCiwExU+f5VCr/xp4Jv37OXKcxNpYkre9yYsMWAnLJpo2Te6XErQovfDD3wmyQIV/YAq6cfZQUsP5u5rCZjjMKxR/ycDzWmVmqb9gOLYXJvw2gEQl1i9AX3YNelNnXYeh/vFhX9xnO5F51XwsTt5GTmGBAcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1Fub+1VQNjKNV2HRY+3acIaPMoBhrCNjK/f0I0FK4Y=;
 b=UHkf4DrGmXYj4KRFYSeChuehQK7SQqDzOcegH3EZ+ONJGGN7FPuBH7+ItFepSv5mfffWdLdi5eVnOFEM5MeKDx38ljGizSGaC1OUskKCrb2l+89s6viU7COOqhwPCAeAVhqAp6F533DAst7CTLblxjXQgU/hXdtMh3obAbI5JtIYlVwyW69OyMumthldsTLEHUhULh23cd9CIr2HQJPdMiL2ZyXveinioBOnqN7isOuM6CDe+vlkJbkUcl/smL1xHEk1qDu48jeg0+q89HyRFueIU/kjiKNCR4bSFvXOXFIa2kw0uHu49WCp5lFu+iVpya4mu0d9QH0n+RmWUc0mig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1Fub+1VQNjKNV2HRY+3acIaPMoBhrCNjK/f0I0FK4Y=;
 b=tRimD0W+OQQ8NNmnyr5C53BMCxXtCxk1ex5WXO3ohmqOtfObk4wT0UOPAvJcuVfy8bbnPeevCHgpHgo0WA1z9cp06bOvJQmg7Okx+/XKvqSVeBSIvH5YQ+vzQZNzVjG2Rhg1RoF/CpRoAxkza62CMeAf+f2gia7L6gCj4wDEZDE=
Received: from SA9PR13CA0143.namprd13.prod.outlook.com (2603:10b6:806:27::28)
 by MN0PR12MB6197.namprd12.prod.outlook.com (2603:10b6:208:3c6::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 02:33:36 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:27:cafe::54) by SA9PR13CA0143.outlook.office365.com
 (2603:10b6:806:27::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20 via Frontend
 Transport; Tue, 23 Apr 2024 02:33:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Tue, 23 Apr 2024 02:33:36 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 21:33:31 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>
CC: Yunxiang Li <Yunxiang.Li@amd.com>
Subject: [PATCH WIP] drm/amdgpu: Fix kfd_locked locking issue
Date: Mon, 22 Apr 2024 22:30:44 -0400
Message-ID: <20240423023044.39613-1-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|MN0PR12MB6197:EE_
X-MS-Office365-Filtering-Correlation-Id: 406237d6-d9fa-4e06-dc3f-08dc633dc701
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DY9+X1qQk/m9bbTy8NsIofW/JvUAZ9Gs/2Hs9kvl2HZpy+0KZ71Adfga1jBD?=
 =?us-ascii?Q?Iv7Lwzh6cAAPpoMwi/2AZIHS2UCpd++w0tHtsbOrA705NPFJC1bXLxURW2+X?=
 =?us-ascii?Q?UJBoNj5YhFq5TgH01bpKC5BWfCzSzlhv5bYnbIl7pJ3myYRwRZg6gcqqrDpq?=
 =?us-ascii?Q?+KEgzD0u6wCA2GOWODzcxEWTBxzyPBmW1Ko/Dw+fxfHn+TZ4SIxwKY8zpCgZ?=
 =?us-ascii?Q?F6NVh0YzODCCO2598mpg5jYDVjGDv334omAOZfUbRtVPo305fsD8U0YHU8p8?=
 =?us-ascii?Q?JmnLLoDdYrEWcVckp9RXyzFohn2UsbiUXZXQa41ge4p7bgOBgKt+ph4/yUR4?=
 =?us-ascii?Q?fwHl49anGek8iEyiFt/RJEDu9zcgqcoUtVKJHQC6INu45F39S6JFbtrNP2uB?=
 =?us-ascii?Q?VuEJY3P9qo9k0Dcp4IetE85+I7U4uGCDZsfvnc93xNLEElwej++Abak/i5lF?=
 =?us-ascii?Q?o8hf3Ju7ZW5+Hbd2JK8ukZFFitf75wkWLStE35M41Fb+DPZ0dKWoU22v+m48?=
 =?us-ascii?Q?LjQrfv1oowcYim+rlNM0e2TLLV2YeaB88Jnk1ZAymgG1oTTfnyaKZJGvu1Mx?=
 =?us-ascii?Q?PMeXMFsX3C5H+vjfFOhjjie3RTw7lrBzI7Z+XY3HXtfJPN/Msk4bvcuEonk9?=
 =?us-ascii?Q?PmOdkFKQb8AdFGNmgYkbPk9Q7PZr5qiZHw91lEVFnBPrlLZtv0qYp18tdAPT?=
 =?us-ascii?Q?i6mhw41LTLXKsxFW5BcQ0pek+/TukH3Xm/Cs5TUAUkx1lWKS0EXCFLFJJ53A?=
 =?us-ascii?Q?+aBiJyy0s8uRZHQipaYRUWon2lOFBQMZqVvCAgRNkgoEME69ilvNBirCgqXk?=
 =?us-ascii?Q?1RKQK/QetuVqAtK5f5NZRCxGS2pzUKohQDzQIQLxXo6sj5LKCLGOiaQvIOJE?=
 =?us-ascii?Q?J+/ZAj8PuYBD78Uazj+RniF24ehanhgviTH8/39ZsPBSCnOoInWa/lAwcHeQ?=
 =?us-ascii?Q?2JMA7jpsr01ESdLNjNAw3pQ8Aj3K9IkMsYzh64uO5oO4TzMQUR7lP3Hc2gZQ?=
 =?us-ascii?Q?8xoU1KZe1Q2nCkSQIv2tkZEXvnCMgDRkPcD2j9sXfLUGT7TfAnVrL+7AVp6Q?=
 =?us-ascii?Q?WGt167rRUV2flPWf7QhPLv1Q+E05BLu8jf38GZ3GAWOBh6Ar9D91CwYZe/o7?=
 =?us-ascii?Q?Qr7vyNYYtiY7b3tNTn/DNUDfF3jkz53t30B7YtdfSDEYk/3xbP+7vGWuI8mZ?=
 =?us-ascii?Q?QQ2RcRANMR6/NaYGfMHtyYo5sD1XYMckwcP9D7sYgHndya24nOdahEN1aAul?=
 =?us-ascii?Q?1y2AKXrGAsmnxxNGU9hLT2OJpGhEmrjkUwpHPaFrJbIqu+ZOPpkaD+cUgDOw?=
 =?us-ascii?Q?Af2gf4CMeyOh1S1oH/KPDTd7Mgw0r0rv3wV8W9CUajE8OwrmNURbXvM7AnQM?=
 =?us-ascii?Q?4+D/8pFpo1iNcXUxM7qu3dfc9lcy?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 02:33:36.2085 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 406237d6-d9fa-4e06-dc3f-08dc633dc701
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6197
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

During SRIOV reset, if a step fails and we retry, it locks kfd_locked
again but later only unlocks it once. This means all future attempts at
opening /dev/kfd will fail.

Fix the locking error and rework the SRIOV path to use the same reset
loop from the caller. Hopefully this makes the code easier to reason about.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 76 +++++++++-------------
 1 file changed, 30 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 67da24e9f0a2..37d65f6db0e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5051,24 +5051,11 @@ static int amdgpu_device_recover_vram(struct amdgpu_device *adev)
  * do VF FLR and reinitialize Asic
  * return 0 means succeeded otherwise failed
  */
-static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
-				     bool from_hypervisor)
+static int amdgpu_device_post_reset_sriov(struct amdgpu_device *adev)
 {
-	int r;
+	int r = 0;
 	struct amdgpu_hive_info *hive = NULL;
-	int retry_limit = 0;
-
-retry:
-	amdgpu_amdkfd_pre_reset(adev);
-
-	amdgpu_device_stop_pending_resets(adev);
 
-	if (from_hypervisor)
-		r = amdgpu_virt_request_full_gpu(adev, true);
-	else
-		r = amdgpu_virt_reset_gpu(adev);
-	if (r)
-		return r;
 	amdgpu_ras_set_fed(adev, false);
 	amdgpu_irq_gpu_reset_resume_helper(adev);
 
@@ -5078,7 +5065,7 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 	/* Resume IP prior to SMC */
 	r = amdgpu_device_ip_reinit_early_sriov(adev);
 	if (r)
-		goto error;
+		return r;
 
 	amdgpu_virt_init_data_exchange(adev);
 
@@ -5089,37 +5076,25 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 	/* now we are okay to resume SMC/CP/SDMA */
 	r = amdgpu_device_ip_reinit_late_sriov(adev);
 	if (r)
-		goto error;
+		return r;
 
 	hive = amdgpu_get_xgmi_hive(adev);
 	/* Update PSP FW topology after reset */
 	if (hive && adev->gmc.xgmi.num_physical_nodes > 1)
 		r = amdgpu_xgmi_update_topology(hive, adev);
-
 	if (hive)
 		amdgpu_put_xgmi_hive(hive);
+	if (r)
+		return r;
 
-	if (!r) {
-		r = amdgpu_ib_ring_tests(adev);
-
-		amdgpu_amdkfd_post_reset(adev);
-	}
+	r = amdgpu_ib_ring_tests(adev);
+	if (r)
+		return r;
 
-error:
-	if (!r && adev->virt.gim_feature & AMDGIM_FEATURE_GIM_FLR_VRAMLOST) {
+	if (adev->virt.gim_feature & AMDGIM_FEATURE_GIM_FLR_VRAMLOST) {
 		amdgpu_inc_vram_lost(adev);
 		r = amdgpu_device_recover_vram(adev);
 	}
-	amdgpu_virt_release_full_gpu(adev, true);
-
-	if (AMDGPU_RETRY_SRIOV_RESET(r)) {
-		if (retry_limit < AMDGPU_MAX_RETRY_LIMIT) {
-			retry_limit++;
-			goto retry;
-		} else
-			DRM_ERROR("GPU reset retry is beyond the retry limit\n");
-	}
-
 	return r;
 }
 
@@ -5678,7 +5653,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	int i, r = 0;
 	bool need_emergency_restart = false;
 	bool audio_suspended = false;
-	bool from_hypervisor = false;
+	int retry_limit = AMDGPU_MAX_RETRY_LIMIT;
 
 	/*
 	 * Special case: RAS triggered and full reset isn't supported
@@ -5760,8 +5735,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
 		cancel_delayed_work_sync(&tmp_adev->delayed_init_work);
 
-		if (!amdgpu_sriov_vf(tmp_adev))
-			amdgpu_amdkfd_pre_reset(tmp_adev);
+		amdgpu_amdkfd_pre_reset(tmp_adev);
 
 		/*
 		 * Mark these ASICs to be reseted as untracked first
@@ -5815,19 +5789,29 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			tmp_adev->asic_reset_res = r;
 		}
 
-		if (!amdgpu_sriov_vf(tmp_adev))
-			/*
-			* Drop all pending non scheduler resets. Scheduler resets
-			* were already dropped during drm_sched_stop
-			*/
-			amdgpu_device_stop_pending_resets(tmp_adev);
+		/*
+		 * Drop all pending non scheduler resets. Scheduler resets
+		 * were already dropped during drm_sched_stop
+		 */
+		amdgpu_device_stop_pending_resets(tmp_adev);
 	}
 
 	/* Actual ASIC resets if needed.*/
 	/* Host driver will handle XGMI hive reset for SRIOV */
 	if (amdgpu_sriov_vf(adev)) {
-		from_hypervisor = test_bit(AMDGPU_HOST_FLR, &reset_context->flags);
-		r = amdgpu_device_reset_sriov(adev, from_hypervisor);
+		if (test_bit(AMDGPU_HOST_FLR, &reset_context->flags))
+			r = amdgpu_virt_request_full_gpu(adev, true);
+		else
+			r = amdgpu_virt_reset_gpu(adev);
+		if (!r)
+			r = amdgpu_device_post_reset_sriov(adev);
+		if (AMDGPU_RETRY_SRIOV_RESET(r) && (retry_limit--) > 0) {
+			amdgpu_virt_release_full_gpu(adev, true);
+			goto retry;
+		} else {
+			amdgpu_amdkfd_post_reset(adev);
+			amdgpu_virt_release_full_gpu(adev, true);
+		}
 		if (r)
 			adev->asic_reset_res = r;
 
-- 
2.34.1


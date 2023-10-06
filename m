Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 183B4E92FE0
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Oct 2023 18:51:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86D7A10E55A;
	Fri,  6 Oct 2023 18:50:59 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51BC610E55A
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Oct 2023 18:50:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=na3on8BDx27F0XKJh1DyUO1t0NK1PtWntn2DVZfCBj3nX4EnOYMCsMEK7KSOO/awGw4VI9BcqPU9whgrS3Pr2lh/+1uzBZ3m5fQLizxby7pmGKmKeQRandsYFsFyHcSFZWSe19Q04sibtNNNsUNQmXmnWF3V3LDjfZhfp4L8cExZ2aGf1ox20bbIkBy+ubSralTbFp/RPdUN+yAw7lFpWlHWCyKLMq6LcJlJ9Es633ejxBhx2tc1jkNU8Mx2rNh3g+1ZeWeg6sy9ZPAk5yhHJmj1uvxFvXwfGHph5F10wzx7lHBKJqCu+t5t0NohqFcWrzILt5tmaDbZcHfb3poeMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9cb3ZEo6OA/wYt5MjhlrKqDRSJZn5ct0mP+2Xakkc+c=;
 b=e4mQurSvNIGJSJxhD17mILCMQdd62oJxhdklRUYpN3oI5vnieXn57IgPVgFozDi3IC4HGcBYmG6kSSDsGeRkRXlV2jKtiGORensirA6lpzdM4oso9srbiiqfp3yZ6lEy91CtvnnXayOYajPMWGeCWPIVi0dDKgMPnR7fOfEdDcfoTgiGbubAnrJOsC97i2Ijyu5oWYycjfjOEKHZWfJ9BrZIJgxdPGxX6Z5ZPVH5DKBQ1kC4Y/UWyKh8IeX9MQNFLeuOCqWrIQigNkUjSoHc00fzHLChNx1q2fU9e/lRemNhiG8W37QNAq5SRGa0S0SYZzYBqbQMBeUtG31O1/xFLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cb3ZEo6OA/wYt5MjhlrKqDRSJZn5ct0mP+2Xakkc+c=;
 b=25LcWnZHfFGh/+Cny7ybatt82lD5MV6OejImtB9GDHyVfTYLRyk5EvxtR14hgNPVF7HvV6lEUpDSrcVFRZXMrKcTAcNw/WW4932C9c42woybOu/h8iipOJMNfPb4VXL+EqIdK1+532Nh/Ac747X78dJjSeSBTzeXTuyrSh8ghVY=
Received: from BL1PR13CA0243.namprd13.prod.outlook.com (2603:10b6:208:2ba::8)
 by BL1PR12MB5080.namprd12.prod.outlook.com (2603:10b6:208:30a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Fri, 6 Oct
 2023 18:50:54 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:2ba:cafe::3a) by BL1PR13CA0243.outlook.office365.com
 (2603:10b6:208:2ba::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.17 via Frontend
 Transport; Fri, 6 Oct 2023 18:50:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 6 Oct 2023 18:50:54 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 6 Oct
 2023 13:50:53 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 1/7] drm/amd: Evict resources during PM ops prepare()
 callback
Date: Fri, 6 Oct 2023 13:50:20 -0500
Message-ID: <20231006185026.5536-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006185026.5536-1-mario.limonciello@amd.com>
References: <20231006185026.5536-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|BL1PR12MB5080:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b3b8a51-6e3c-4d10-d15e-08dbc69d2b3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lQjMdNYeVXQxZ5zJj/FmwuFYLKrhOyCDodzDtlSHwHsT/W7NLwZJDUG3U29Mc//4et3AtoHM8b/BWebtQDkHRhiWpqp2/hq+qhE4AEJAuulgX4oLgrUSNMl8TUh/jJLaHEXKkk5Zpf3nCTkxRs7Uvl88IrDL+nzXdco0dLLFbOe77i1p5TTBqpQuUDwtZQ7idLsAzdVrrWd6psCFltaQdEior4qq6Id46J0b/i+hPQpEd3IMlFqa4iDo0kEGgvOLfouMWuvHGSiusCj+wPqodESVHb65gF6azx4X3K/tRazcaiTzgJfIKqLkX+taDFAVTBgBl9NSU6XRNq+3EGim+1G+v6LkKxPYJstxoqSKWWFc16bimb2/ZcQbwTsAZQHgQuypSncSRWTnbcPM3BHFiEkab3cxJbqv2X4iwyjAvu/i/8T7tBan1mrJl0DwXFXGR81gGs4RH0N8lwg8OS7U8C6BVQiAZvOcvwYUuqZXbAJuRwWKJqoNvbshwFFqsRBJyg0NgQSdMfYqMxE/EDk+PDQQUYKfescWli1I1CE/SFTjn0zB0AX5nl/7j8PewuhY1C039g5R/LQMqB5pBdu7/PtjvAn3iE8BkyKJ6poR6lF0x+VirE7clakfFaRKu+akddF6lL/RrMObNE5XR05Gdn2/FTMpJJHw9HA4hnKrXHopNAG5NhYCH7yAJgI4/8cQ27J1dyFbPBELzgYbjQQhQbBVn+XehaX2aKT+PHdnSOlZ8y+n/U8bt9Jx9PORnIJf
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(64100799003)(451199024)(186009)(82310400011)(1800799009)(46966006)(36840700001)(40470700004)(83380400001)(336012)(40460700003)(40480700001)(6666004)(7696005)(966005)(478600001)(47076005)(86362001)(36860700001)(82740400003)(356005)(81166007)(316002)(41300700001)(2906002)(426003)(2616005)(1076003)(26005)(16526019)(36756003)(54906003)(44832011)(5660300002)(6916009)(70206006)(70586007)(8676002)(4326008)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 18:50:54.0159 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b3b8a51-6e3c-4d10-d15e-08dbc69d2b3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5080
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
Cc: Harry.Wentland@amd.com, Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Linux PM core has a prepare() callback run before suspend.

If the system is under high memory pressure, the resources may need
to be evicted into swap instead.  If the storage backing for swap
is offlined during the suspend() step then such a call may fail.

So move this step into prepare() to move evict majority of
resources and update all non-pmops callers to call the same callback.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2362
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v4->v5:
 * Call amdgpu_device_prepare() from other callers to amdgpu_device_suspend()
 * 3x evict calls -> 2x evict calls
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 31 ++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 10 ++++---
 3 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 4cc78e0e4304..fdb2e9ae13e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1409,6 +1409,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 void amdgpu_driver_release_kms(struct drm_device *dev);
 
 int amdgpu_device_ip_suspend(struct amdgpu_device *adev);
+int amdgpu_device_prepare(struct drm_device *dev);
 int amdgpu_device_suspend(struct drm_device *dev, bool fbcon);
 int amdgpu_device_resume(struct drm_device *dev, bool fbcon);
 u32 amdgpu_get_vblank_counter_kms(struct drm_crtc *crtc);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0cb702c3046a..cb334dc57c59 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1760,6 +1760,7 @@ static void amdgpu_switcheroo_set_state(struct pci_dev *pdev,
 	} else {
 		pr_info("switched off\n");
 		dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
+		amdgpu_device_prepare(dev);
 		amdgpu_device_suspend(dev, true);
 		amdgpu_device_cache_pci_state(pdev);
 		/* Shut down the device */
@@ -4335,6 +4336,31 @@ static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
 /*
  * Suspend & resume.
  */
+/**
+ * amdgpu_device_prepare - prepare for device suspend
+ *
+ * @dev: drm dev pointer
+ *
+ * Prepare to put the hw in the suspend state (all asics).
+ * Returns 0 for success or an error on failure.
+ * Called at driver suspend.
+ */
+int amdgpu_device_prepare(struct drm_device *dev)
+{
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	int r;
+
+	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
+		return 0;
+
+	/* Evict the majority of BOs before starting suspend sequence */
+	r = amdgpu_device_evict_resources(adev);
+	if (r)
+		return r;
+
+	return 0;
+}
+
 /**
  * amdgpu_device_suspend - initiate device suspend
  *
@@ -4355,11 +4381,6 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 
 	adev->in_suspend = true;
 
-	/* Evict the majority of BOs before grabbing the full access */
-	r = amdgpu_device_evict_resources(adev);
-	if (r)
-		return r;
-
 	if (amdgpu_sriov_vf(adev)) {
 		amdgpu_virt_fini_data_exchange(adev);
 		r = amdgpu_virt_request_full_gpu(adev, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 81affdf7c0c3..420196a17e22 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2427,8 +2427,9 @@ static int amdgpu_pmops_prepare(struct device *dev)
 	/* Return a positive number here so
 	 * DPM_FLAG_SMART_SUSPEND works properly
 	 */
-	if (amdgpu_device_supports_boco(drm_dev))
-		return pm_runtime_suspended(dev);
+	if (amdgpu_device_supports_boco(drm_dev) &&
+	    pm_runtime_suspended(dev))
+		return 1;
 
 	/* if we will not support s3 or s2i for the device
 	 *  then skip suspend
@@ -2437,7 +2438,7 @@ static int amdgpu_pmops_prepare(struct device *dev)
 	    !amdgpu_acpi_is_s3_active(adev))
 		return 1;
 
-	return 0;
+	return amdgpu_device_prepare(drm_dev);
 }
 
 static void amdgpu_pmops_complete(struct device *dev)
@@ -2637,6 +2638,9 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 	if (amdgpu_device_supports_boco(drm_dev))
 		adev->mp1_state = PP_MP1_STATE_UNLOAD;
 
+	ret = amdgpu_device_prepare(drm_dev);
+	if (ret)
+		return ret;
 	ret = amdgpu_device_suspend(drm_dev, false);
 	if (ret) {
 		adev->in_runpm = false;
-- 
2.34.1


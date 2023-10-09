Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC24E95A9E
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 15:54:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2817310E140;
	Mon,  9 Oct 2023 15:54:49 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B757B10E106
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Oct 2023 15:54:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJbR24m3Hh5hDijZw30wR5wo5jtXNNKySGE3PPSHi7wk6NaJVbG37DKae0a7ScyVieJSHvfVgx5T+2tdYvJsx88fwijWSyf6umtEbKJgXVbJvbHAV7iHPpL/0sG+tXmXwB71YLLGpe/5JMnrii7MNJSv5n8Dtm2Zw/HIhreHwgEs2BoMQ/S5NjQ8Q8bAgZtQNmr8vY7QWEVb3jh05NOAOk4e8hox+VZlVfxQZu0kl9Uw2iCw0x7WW9E3T6ffLh5jBWW2/7/ApaUOc4LD2Px1rFoGjROYXlrgsEWXfVZEV+eQz495p2mYnDVaSGT0Y3IswV9y4aP/67Y0f9RuNzuk5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4S/Q/Eb9UR2VOGdoVmiOeLef/ANljnpWTV0EY1L1C8=;
 b=UUXNEORxUFPtUwdAiteIgCq/bN8i2nCweZJ40+aSM6o4DwLJtkMSSrYqinaRltA176qSVEQRPnLSWhL+d2sp9xaBzV6HV1qtNqVo749E0w4Wd8Vn6R0/XL1xTAY/L1pvj7iaC5WILylyQ6ykrwS5IwnAcjIxlTLEPBm2qEU4wY5sYn0NIirjupJxPeTWWjVY3WMkRwQHJzWCoLK1PMzwJWV28b/2iGR5H0gKJimneTaYtHnJe5K2q/o4RTrGQrafPIYRDIUp31KLZNtK3487erucAorTJTFxXTO2W4zfIC9z4EIsgu2YUNeoU2axT7jsoLx92MS3t5mLvNe0chukDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4S/Q/Eb9UR2VOGdoVmiOeLef/ANljnpWTV0EY1L1C8=;
 b=pZziUPTNaaT+fR7bEk5TNt6NQgFfihl1vkiAfjFslyJkYclgbCcPzYRjjfPEqrjOELj5+ke1B/0SGBlLBjvc0FaM1yhqN1K+iLR/yCmx6kpjAqcb1+DDOa72XKuannikb1gaNf4BetxlgycTwAF5pHKwBLRuOQB1OPpUhWSjbyE=
Received: from BY5PR17CA0012.namprd17.prod.outlook.com (2603:10b6:a03:1b8::25)
 by CY8PR12MB8411.namprd12.prod.outlook.com (2603:10b6:930:6e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Mon, 9 Oct
 2023 15:54:44 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::8b) by BY5PR17CA0012.outlook.office365.com
 (2603:10b6:a03:1b8::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37 via Frontend
 Transport; Mon, 9 Oct 2023 15:54:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 9 Oct 2023 15:54:44 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 10:54:42 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v6 1/7] drm/amd: Evict resources during PM ops prepare()
 callback
Date: Mon, 9 Oct 2023 10:54:20 -0500
Message-ID: <20231009155426.96232-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009155426.96232-1-mario.limonciello@amd.com>
References: <20231009155426.96232-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|CY8PR12MB8411:EE_
X-MS-Office365-Filtering-Correlation-Id: 83469ae0-8ddb-45ba-20d2-08dbc8e00e63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SHA+ZsLZP8iQiFyM1K00R2lnOj36ASdkMbXjw0opJDckzRZ0CIWyWlZO2Cg0d/Won2zfMr2mk3taQpCIswqgjOa9opV6UJhj2H/v/zMCae8N6ZE8dDujrMe+7GsFzvtCmlNN3+joR3JYLyFztbuH91fOwy+amUkYgIFCnuWzzAnTqtxIER5FcOQnskfbVJBfkDzBagVHcksYBAC0ew1JvbxoZdWZvCconan3PGRf5K+J+sGNh7YeL33yB+jECysKX18bkLrOW4OXVXLFlEPyMzfVvYzcEmKs6DPGrEFh3fxoakhO0VeiFjRJF1aVTIuEjt5B6ovtO93TOL3/s72ecRUWhTBd7UZeVNWw4uSVw8B3nSvknbZYHrLpoyIk92ECkANbmOyG809GYtfag9YIEVxv8Iq1iiJkP+xrp4ATGPeR4v9I14lnsDtRRREyuLJrSaKkvz+v0/yL2OV3taU8mrsE1I8PqSyi+Ke8gcwWuc4ELNTpRxf03P/1O+68yQWR0j8Z03IUjXuc92qMXGmDtONRuKxttcvfYfFB9JDSeensWN5t5HnhkVtygzaknoKkxEv/00GarAKyebeZxIG4HwGssNbmht+Qv9QSM71qX0ki+mKqLa202JzLi13ufmNelGJCTHexoxNC6Kk3R1eP1raEb38ztgiXmum97wWRhU1Yj5Yrrg0tNiHKt0OwZEgYsMmWdwcj+eAkebKW16DrOTtwy4zo6MfW22w1z5M5U+RLIO1Kv9EcecgCdZdVGBCA
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(451199024)(82310400011)(1800799009)(186009)(64100799003)(36840700001)(46966006)(40470700004)(36756003)(86362001)(40480700001)(2616005)(478600001)(5660300002)(2906002)(44832011)(70586007)(70206006)(54906003)(6916009)(41300700001)(316002)(1076003)(7696005)(966005)(6666004)(26005)(336012)(426003)(66574015)(47076005)(16526019)(36860700001)(82740400003)(4326008)(40460700003)(8936002)(8676002)(356005)(83380400001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 15:54:44.1101 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83469ae0-8ddb-45ba-20d2-08dbc8e00e63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8411
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Linux PM core has a prepare() callback run before suspend.

If the system is under high memory pressure, the resources may need
to be evicted into swap instead.  If the storage backing for swap
is offlined during the suspend() step then such a call may fail.

So move this step into prepare() to move evict majority of
resources and update all non-pmops callers to call the same callback.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2362
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
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
index d5b81a086e69..0a7cc9107f07 100644
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


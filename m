Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB3D1C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 11 May 2022 12:25:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6002F10EB8B;
	Wed, 11 May 2022 12:25:39 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D76C710EB8B
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 12:25:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivwSdI16bn1iI3WxwootLwyeilZMnL/pETpoP708Q3IEpImxG9psRk39zoyCQDvqF0X93Ej2M/C4DN1UTmGt+Emi20q8jGn5m1mF5XpfMO2iGu4xHPeMDzZJ49ehuGKNMQYXEh4LixO56yp+7TTuyEHWqdcmEH7ygavHYYQ8LHPLKwMPqceNaxH59kOo0LbuutGEnllSxLQRXRUgN/mAknKZE+BJ+Gdtj6IaKbZyeLNu8WDijCDBN/nJ2ehEOxF35Ayi/vDzGoWGz/ZgjHhIk4PXJ/7LkAt7/c5KRkvRN4ezomzLCvC78uj9E+gnSfJU/Y5xz1DYl650hJiW38S7Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sTLTQ+JOMVveaXEE+UzmLLM5o6rBYxFFM6oGKCMW0U=;
 b=Yfm1KvIt3jUHK71JtIHWAKURnn2bVFPW1Jn4p6OnY5nbpxcvjrh533bylFe9hYu4y16ziEIh1WAKA/+KlcSEwqWlfCZmshukFWB1Cb0bdUlOrUb00vSNwRGUMD0QyeRYzyI0g/SX5bX6ZWPPXc00eK3zbd6qwvdQ8AMip0iW65hR7GamKHwTlLbnaBfKWmWmKcGOOFzPaCI63kEN+zif87Qdmx2UJ9e9qRX0SVtEpR6Rm5GXDf85D9wpJSoW8mvfsDo3+dC9jeVeFe/DKy8MB8WMCGDutRRgxuCQWRdjxYmdN6xoGByJxv+dthfavaKfEYORvXmf2AfYbh2YFoXg/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3sTLTQ+JOMVveaXEE+UzmLLM5o6rBYxFFM6oGKCMW0U=;
 b=Zr2nd/uZuFQy9vJZ7dsyepVdqG6E+7sCtj1TE+dA57Kqgqu+JHRUCSzhJBTx4uQv6KqrA3M0OUArWq+UX91SOcDuwQTCGlbNq7JSMw/iMUVWYZFoApSZ3YUhiCLf4CBhKpc8T1weZ5sVjFbv7pbaK/XSSLyrCQhYMV1ip5LkBrM=
Received: from MW2PR2101CA0002.namprd21.prod.outlook.com (2603:10b6:302:1::15)
 by BY5PR12MB4051.namprd12.prod.outlook.com (2603:10b6:a03:20c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 12:25:34 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::ad) by MW2PR2101CA0002.outlook.office365.com
 (2603:10b6:302:1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.4 via Frontend
 Transport; Wed, 11 May 2022 12:25:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 12:25:33 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 11 May 2022 07:25:30 -0500
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: consistent approach for smartshift
Date: Wed, 11 May 2022 17:55:17 +0530
Message-ID: <20220511122517.2546133-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d91565c1-42a0-4cd0-9c3a-08da334958aa
X-MS-TrafficTypeDiagnostic: BY5PR12MB4051:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4051E000DA86889E4380E83D9DC89@BY5PR12MB4051.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NiG4MFSYA8cp2Mzl8QNAqXcxKvflyWShCrEbYmERi8ueS4hRSQXXokYs0JGlrdkq07USzu9wNDp1aHR5iQCw9NY6ctzYRD87JGoumxiBMOdOks3EnRL4DXdzUmcuoKLTiNtP05waruXq1GmKuiIx400vDzYTEACU4VWQNDx9bbgDl6c+Ec+sZLShQy+otyQTTIwK/Er47BWBG629YZdxtZvXP6CaHEfEYPeSGgeyYkl0B3tGGBJpV3509yikmxnOTYzo+vD9X6u1c5qEh3Wf4IGsaN2DCnrqlARaITvQFPw52XmfXc85jX95I2BI0GoPjz7linNBD8u6XAToiUzkpEXRnvUwMNzmu6jP48vxcrkTMYc8ucJNDMty0xia5UnPfOmDlcTakdkrLcaw+GKqAqmVOaXJHMIa4w4tAF9f14jyYcC9ANFeenAeeoRXNlnod81++6OyPzvd7hAfnCnBmpRw/D9wm1D0mblxDyZJR4GZfzUiBgDPNUI/IMebP8CSJH3iTrSnXvUuhIjWWWqdEJPd0lDipwcC6OiAbGHXORGrrLbh8esQphrNFOhlByyJ1oikui5PT/Zt5bGVluJGadhBAjLRjWg0cIfO4o/1bU8Sudhhu08F5LTgjgmgweZC6K+Cf8rhJBQFiQJbcD4sRre4kPEX3rg4Rgmelv1TFsYpxGc8MFWJPlj4EXf4KVr0Axd8K3LAikBCi4s5Hkz9Jw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(86362001)(2616005)(36756003)(1076003)(7696005)(5660300002)(16526019)(186003)(82310400005)(81166007)(4326008)(70586007)(70206006)(6666004)(356005)(26005)(316002)(6916009)(47076005)(336012)(426003)(54906003)(83380400001)(8676002)(8936002)(508600001)(40460700003)(36860700001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 12:25:33.7676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d91565c1-42a0-4cd0-9c3a-08da334958aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4051
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
 Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 Lazar Lijo <Lijo.Lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

create smartshift sysfs attributes from dGPU device even
on smartshift 1.0 platform to be consistent. Do not populate
the attributes on platforms that have APU only but not dGPU
or vice versa.

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 146 +++++++++++++++++------------
 1 file changed, 86 insertions(+), 60 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index d3228216b2da..c2406baeef93 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1734,22 +1734,11 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
 	return size;
 }
 
-/**
- * DOC: smartshift_apu_power
- *
- * The amdgpu driver provides a sysfs API for reporting APU power
- * share if it supports smartshift. The value is expressed as
- * the proportion of stapm limit where stapm limit is the total APU
- * power limit. The result is in percentage. If APU power is 130% of
- * STAPM, then APU is using 30% of the dGPU's headroom.
- */
-
-static ssize_t amdgpu_get_smartshift_apu_power(struct device *dev, struct device_attribute *attr,
-					       char *buf)
+static int amdgpu_read_powershift_percent(struct amdgpu_device *adev,
+						uint32_t *ss_power, bool dgpu_share)
 {
-	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_to_adev(ddev);
-	uint32_t ss_power, size;
+	struct drm_device *ddev = adev_to_drm(adev);
+	uint32_t size;
 	int r = 0;
 
 	if (amdgpu_in_reset(adev))
@@ -1763,28 +1752,64 @@ static ssize_t amdgpu_get_smartshift_apu_power(struct device *dev, struct device
 		return r;
 	}
 
-	r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_APU_SHARE,
-				   (void *)&ss_power, &size);
-	if (r)
-		goto out;
-
-	r = sysfs_emit(buf, "%u%%\n", ss_power);
+	if (dgpu_share)
+		r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_DGPU_SHARE,
+				   (void *)ss_power, &size);
+	else
+		r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_APU_SHARE,
+				   (void *)ss_power, &size);
 
-out:
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 	return r;
 }
+/**
+ * DOC: smartshift_apu_power
+ *
+ * The amdgpu driver provides a sysfs API for reporting APU power
+ * shift in percentage if platform supports smartshift. Value 0 means that
+ * there is no powershift and values between [1-100] means that the power
+ * is shifted to APU, the percentage of boost is with respect to APU power
+ * limit on the platform.
+ */
+
+static ssize_t amdgpu_get_smartshift_apu_power(struct device *dev, struct device_attribute *attr,
+					       char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	uint32_t ss_power = 0;
+	int r = 0, i;
+
+	r = amdgpu_read_powershift_percent(adev, &ss_power, false);
+	if (!r)
+		r = sysfs_emit(buf, "%u%%\n", ss_power);
+	else if (r == -EOPNOTSUPP) {
+		/* sensor not available on dGPU, try to read from APU */
+		adev = NULL;
+		mutex_lock(&mgpu_info.mutex);
+		for (i = 0; i < mgpu_info.num_gpu; i++) {
+			if (mgpu_info.gpu_ins[i].adev->flags & AMD_IS_APU) {
+				adev = mgpu_info.gpu_ins[i].adev;
+				break;
+			}
+		}
+		mutex_unlock(&mgpu_info.mutex);
+		if (adev && !amdgpu_read_powershift_percent(adev, &ss_power, false))
+			r = sysfs_emit(buf, "%u%%\n", ss_power);
+	}
+
+	return r;
+}
 
 /**
  * DOC: smartshift_dgpu_power
  *
- * The amdgpu driver provides a sysfs API for reporting the dGPU power
- * share if the device is in HG and supports smartshift. The value
- * is expressed as the proportion of stapm limit where stapm limit
- * is the total APU power limit. The value is in percentage. If dGPU
- * power is 20% higher than STAPM power(120%), it's using 20% of the
- * APU's power headroom.
+ * The amdgpu driver provides a sysfs API for reporting dGPU power
+ * shift in percentage if platform supports smartshift. Value 0 means that
+ * there is no powershift and values between [1-100] means that the power is
+ * shifted to dGPU, the percentage of boost is with respect to dGPU power
+ * limit on the platform.
  */
 
 static ssize_t amdgpu_get_smartshift_dgpu_power(struct device *dev, struct device_attribute *attr,
@@ -1792,31 +1817,27 @@ static ssize_t amdgpu_get_smartshift_dgpu_power(struct device *dev, struct devic
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
-	uint32_t ss_power, size;
-	int r = 0;
+	uint32_t ss_power = 0;
+	int r = 0, i;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
-	r = pm_runtime_get_sync(ddev->dev);
-	if (r < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
-		return r;
+	r = amdgpu_read_powershift_percent(adev, &ss_power, true);
+	if (!r)
+		r = sysfs_emit(buf, "%u%%\n", ss_power);
+	else if (r == -EOPNOTSUPP) {
+		/* sensor not available on dGPU, try to read from APU */
+		adev = NULL;
+		mutex_lock(&mgpu_info.mutex);
+		for (i = 0; i < mgpu_info.num_gpu; i++) {
+			if (mgpu_info.gpu_ins[i].adev->flags & AMD_IS_APU) {
+				adev = mgpu_info.gpu_ins[i].adev;
+				break;
+			}
+		}
+		mutex_unlock(&mgpu_info.mutex);
+		if (adev && !amdgpu_read_powershift_percent(adev, &ss_power, true))
+			r = sysfs_emit(buf, "%u%%\n", ss_power);
 	}
 
-	r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_DGPU_SHARE,
-				   (void *)&ss_power, &size);
-
-	if (r)
-		goto out;
-
-	r = sysfs_emit(buf, "%u%%\n", ss_power);
-
-out:
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
 	return r;
 }
 
@@ -1884,18 +1905,23 @@ static ssize_t amdgpu_set_smartshift_bias(struct device *dev,
 static int ss_power_attr_update(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
 				uint32_t mask, enum amdgpu_device_attr_states *states)
 {
-	uint32_t ss_power, size;
+	struct pci_dev *pdev = NULL;
+	unsigned short devices = 0;
 
-	if (!amdgpu_acpi_is_power_shift_control_supported())
-		*states = ATTR_STATE_UNSUPPORTED;
-	else if ((adev->flags & AMD_IS_PX) &&
-		 !amdgpu_device_supports_smart_shift(adev_to_drm(adev)))
-		*states = ATTR_STATE_UNSUPPORTED;
-	else if (amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_APU_SHARE,
-		 (void *)&ss_power, &size))
+	if (!amdgpu_device_supports_smart_shift(adev_to_drm(adev)))
 		*states = ATTR_STATE_UNSUPPORTED;
-	else if (amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_DGPU_SHARE,
-		 (void *)&ss_power, &size))
+
+	while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, pdev)) != NULL) {
+		if (pdev->vendor == 0x1002)
+			devices++;
+	}
+	pdev = NULL;
+	while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_OTHER << 8, pdev)) != NULL) {
+		if (pdev->vendor == 0x1002)
+			devices++;
+	}
+
+	if (devices < 2)
 		*states = ATTR_STATE_UNSUPPORTED;
 
 	return 0;
-- 
2.25.1


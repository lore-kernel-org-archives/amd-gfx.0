Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 515FFC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 13 May 2022 09:59:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD77B10F9D5;
	Fri, 13 May 2022 09:59:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAC9E10F9D5
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 May 2022 09:59:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3xYGgLsKDq9u/WXBEeilLzSUmC0/tPDXeXCC+SsqSc20CuQ15RI/WrdONVYtaqEPSXFx+ls4SfOR+Ra2fktdN59gXcW3si888pnX00TSEN36wq3RNUImdB77D6TFyhpKHDMHk4JO8VlBrMhzF0tfx46MV3EW9Y+QUCxfujxNuDORmw7jC1OrhvxFbmroGenT9qR6mhlhIi4SMbvQL7o3doLU1oUq6m/F11Rqbr90uNo3DC9Mt9tR2V7gIHE2K021xSz8llfIZVd8PlH/xaj6doVZ/ZhzmoLnWv9hVXHADO9Tjy5tNSyH2AUjGMuWV/EWJVYTNF/p9FdV9/A5xSqfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fBMLS+p1OobNF4+b9Z53ZVoJ1Ks7RWhqor1XTfXWmk=;
 b=AvvemdFebYAWzpwamK4wWIVLgxsaFHQ/kUNaDX1L/mM2cAe8mMuU8ADR27R5ZLDS7sUUD5Nz/o6/dhOkSN/x3a6Ps2mEoJAZuL29GPV3yTVVXkU56vvlQpzbaJXpZm48kfP9vYs8cSWSVQ6IgryuUkyuQJzBHmwjVDVaBprEi+CZPvEm66HTRB2oirpENDm3GqYbjUEcv7KCksZWxsxjUp5uXqDlDSMlusND7I+ISTKkIZ+SPGvJiE0JgRFNrjvMi0ZsrCyb4Ye2zWChYWcZtqwEDpeUWTqI4CKg5ZjTUYThsIOCv+mx8d47MWfOsIpovtoH4JQ3om5BZwcqWIgx0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fBMLS+p1OobNF4+b9Z53ZVoJ1Ks7RWhqor1XTfXWmk=;
 b=tY8lWqShtcNW4VasEC9Nmp198YGz4EII0kxXn7xdfmVoKWzG28RCBWiFQrU9NXSHoZnJN1Y61DxSZ5iFHTK2hjNX8koiCSa+jX1UJ5BVVojhOFLWZGzi8zGuFKwnoBSk2fu6Yk6NBIOwVyD8kT2Mm1ocNwoDP3OtyG1HP/sM6IE=
Received: from BN9PR03CA0126.namprd03.prod.outlook.com (2603:10b6:408:fe::11)
 by MN0PR12MB5715.namprd12.prod.outlook.com (2603:10b6:208:372::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Fri, 13 May
 2022 09:59:29 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::96) by BN9PR03CA0126.outlook.office365.com
 (2603:10b6:408:fe::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14 via Frontend
 Transport; Fri, 13 May 2022 09:59:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Fri, 13 May 2022 09:59:29 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 13 May 2022 04:59:27 -0500
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/pm: consistent approach for smartshift
Date: Fri, 13 May 2022 15:29:13 +0530
Message-ID: <20220513095913.512256-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37f7419c-e201-428a-b318-08da34c74579
X-MS-TrafficTypeDiagnostic: MN0PR12MB5715:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB571556F93EEE06CB1183156D9DCA9@MN0PR12MB5715.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UO3VjKH0ERvt0vmNhz5801/gsM5r2oSNXEOHCOqNHxfMlnzQsrmHIZUD3oRnlTZsKbRvGYXf6+wlds6gMtS/iXlMIP8mzQ4JQl3ZJK9SiBlvnzC4B3n9OWZN5sXgNF2EvYBL6NB51oeJlWcdN1FB2Xuigd4p76DDnN6wHUPCItwy1BzsUHgpcc3Ehsn2UZLw67L/KC4MgWvJvlGpgpIr6GbsyhqHzkHTYdsKPyN+yZuZ15utaNIQfnwg4eAl0jbvkZRNAxi+iOUCNRMxd4gRC8HpEdcbnRkeWYMvKq3mLa+noTf16JTHN4AZMEIXhKPmeHrcvJyXXJ/QmqxerIq+MZ14sKK647tJNtKDe9D/0/BE3lP8LwdMriujofsIDB2yW177YjeR2OwSo7pI0RuIRfZSAnipRg4uJt7oBpuGuSXRbUQ0fLZtgQS4t7huWuwVjEsjHJtQeOUSmrWhCtg0n1MPtAB1iF/SdbUiOc9cFAeR0fnuTOGPku4jAiIXD0jVyQGtu3vDJanAhbBpDDdzrhBFZRIiVYmMtL4n7fSX1HWJQ1h4mD0G7kkd6Grisz0vK8RPqnStiN5r+t7nSgDp1QC0C6p058vC0e0h9H9X/zl0btmd2mvO5ei2ZA/yM60npBkfuAkzR4YNz9VwKcofHLOmTYNixixhRteAvjGMSPGlPpwBLZkpd9IoGuAkif1L1Rx7oruqQ2JqZmdEekLp+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36860700001)(356005)(186003)(86362001)(83380400001)(6666004)(16526019)(7696005)(2906002)(2616005)(26005)(1076003)(36756003)(47076005)(336012)(82310400005)(40460700003)(426003)(8936002)(508600001)(5660300002)(6916009)(70206006)(70586007)(54906003)(8676002)(81166007)(4326008)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 09:59:29.4461 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f7419c-e201-428a-b318-08da34c74579
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5715
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

V2:
 avoid checking for the number of VGA/DISPLAY devices (Lijo)
 move code to read from dGPU or APU into a function and reuse (Lijo)

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 130 ++++++++++++++---------------
 1 file changed, 62 insertions(+), 68 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index d3228216b2da..5e318b3f6c0f 100644
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
+static int amdgpu_device_read_powershift(struct amdgpu_device *adev,
+						uint32_t *ss_power, bool dgpu_share)
 {
-	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_to_adev(ddev);
-	uint32_t ss_power, size;
+	struct drm_device *ddev = adev_to_drm(adev);
+	uint32_t size;
 	int r = 0;
 
 	if (amdgpu_in_reset(adev))
@@ -1763,61 +1752,77 @@ static ssize_t amdgpu_get_smartshift_apu_power(struct device *dev, struct device
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
 
-/**
- * DOC: smartshift_dgpu_power
- *
- * The amdgpu driver provides a sysfs API for reporting the dGPU power
- * share if the device is in HG and supports smartshift. The value
- * is expressed as the proportion of stapm limit where stapm limit
- * is the total APU power limit. The value is in percentage. If dGPU
- * power is 20% higher than STAPM power(120%), it's using 20% of the
- * APU's power headroom.
- */
-
-static ssize_t amdgpu_get_smartshift_dgpu_power(struct device *dev, struct device_attribute *attr,
-						char *buf)
+static int amdgpu_show_powershift_percent(struct device *dev,
+					char *buf, bool dgpu_share)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
-	uint32_t ss_power, size;
-	int r = 0;
-
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
-	r = pm_runtime_get_sync(ddev->dev);
-	if (r < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
-		return r;
+	uint32_t ss_power;
+	int r = 0, i;
+
+	r = amdgpu_device_read_powershift(adev, &ss_power, dgpu_share);
+	if (r == -EOPNOTSUPP) {
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
+		if (adev)
+			r = amdgpu_device_read_powershift(adev, &ss_power, dgpu_share);
 	}
 
-	r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_DGPU_SHARE,
-				   (void *)&ss_power, &size);
+	if (!r)
+		r = sysfs_emit(buf, "%u%%\n", ss_power);
 
-	if (r)
-		goto out;
+	return r;
+}
+/**
+ * DOC: smartshift_apu_power
+ *
+ * The amdgpu driver provides a sysfs API for reporting APU power
+ * shift in percentage if platform supports smartshift. Value 0 means that
+ * there is no powershift and values between [1-100] means that the power
+ * is shifted to APU, the percentage of boost is with respect to APU power
+ * limit on the platform.
+ */
 
-	r = sysfs_emit(buf, "%u%%\n", ss_power);
+static ssize_t amdgpu_get_smartshift_apu_power(struct device *dev, struct device_attribute *attr,
+					       char *buf)
+{
+	return amdgpu_show_powershift_percent(dev, buf, false);
+}
 
-out:
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
-	return r;
+/**
+ * DOC: smartshift_dgpu_power
+ *
+ * The amdgpu driver provides a sysfs API for reporting dGPU power
+ * shift in percentage if platform supports smartshift. Value 0 means that
+ * there is no powershift and values between [1-100] means that the power is
+ * shifted to dGPU, the percentage of boost is with respect to dGPU power
+ * limit on the platform.
+ */
+
+static ssize_t amdgpu_get_smartshift_dgpu_power(struct device *dev, struct device_attribute *attr,
+						char *buf)
+{
+	return amdgpu_show_powershift_percent(dev, buf, true);
 }
 
 /**
@@ -1884,18 +1889,7 @@ static ssize_t amdgpu_set_smartshift_bias(struct device *dev,
 static int ss_power_attr_update(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
 				uint32_t mask, enum amdgpu_device_attr_states *states)
 {
-	uint32_t ss_power, size;
-
-	if (!amdgpu_acpi_is_power_shift_control_supported())
-		*states = ATTR_STATE_UNSUPPORTED;
-	else if ((adev->flags & AMD_IS_PX) &&
-		 !amdgpu_device_supports_smart_shift(adev_to_drm(adev)))
-		*states = ATTR_STATE_UNSUPPORTED;
-	else if (amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_APU_SHARE,
-		 (void *)&ss_power, &size))
-		*states = ATTR_STATE_UNSUPPORTED;
-	else if (amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_DGPU_SHARE,
-		 (void *)&ss_power, &size))
+	if (!amdgpu_device_supports_smart_shift(adev_to_drm(adev)))
 		*states = ATTR_STATE_UNSUPPORTED;
 
 	return 0;
-- 
2.25.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E62C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 12 May 2022 10:57:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D87B10FC6D;
	Thu, 12 May 2022 10:57:19 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDCFB10FC6D
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 May 2022 10:57:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XkPusNh67/PVg2FHkkr3MmAj9CjpY+dVtEnEYkYMaH+RLVheRD4Zb4p1QXxhy8IPdi0sdvw0/DQiN7R+iUoen2+Re3szgGPQvuFeDWUuzyTCm0khEpN32MBiRSM/1Sz/YRrxXzey0zlEN8P7cu3gjAX5RMS77AaVTsdVxAvRuWzQvMomvmqeoRBSkdR70+Gra/OeIISJ65KXmVLemb0TsbdkTLRMVHJ3oLz2h+r6Yeo9bG4J2wM6FIvk4Q/13msgWRK5w4dv2RFNJucVNss4aJFidepx3XStO+UxQ5yLEynnGdphmTSm/BeLgGCvouecy2rtTCrVgljy5+tMQ8FqfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3t6B0vMJ0F+bZa7x2GbYoWY0pzxeFkgWjZzvfGo6is=;
 b=F/bi/PXE4tZODREQiwWDcrnct8tDLoEMj9T+rgYvKzluDkSaBUd1gcSaiBS5cWdYwDgaDP7ml0uvKb4/kQLuAUDOovz/fkNE+oaG8W1nRhhb/jesQ1k5v0iGBwvBT5vxlBvho85mDvx8LwsP+qOPZ7Iv//AJGGEtFCTR+eXsVfd01qW+o5XJRMX2C+yCp8v9YOBtpOP7hH4OYjHhga4s7qT5D42wd/MjlKuc2ige7WCkGolAmya6KWphx4AJOvwf+XYLm+s5klXRYk3Pp8UMOY4gLq0j98RaP54wF+tOEeW5TgVoP0Q1aHFbjhT4vqvhxfiLNfgsqXuVMDvrA1SQSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3t6B0vMJ0F+bZa7x2GbYoWY0pzxeFkgWjZzvfGo6is=;
 b=36MgyXky1yhl/vtoXTMFpXkR2Iw505knKAotMX7+bxcupWI40BQXg6VocmveebqoMwbfVBU83K+VDGnxQKQsfT0TpuT125WUUFZJW+2SZUIzqR5uCZi5qn6Qwpxj6iqaFyA5mPsYI1BcdnAZhXUxhcstTdrVaoJF8VFDbVtGK38=
Received: from BN9P223CA0020.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::25)
 by MN2PR12MB4111.namprd12.prod.outlook.com (2603:10b6:208:1de::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 10:57:11 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::eb) by BN9P223CA0020.outlook.office365.com
 (2603:10b6:408:10b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22 via Frontend
 Transport; Thu, 12 May 2022 10:57:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Thu, 12 May 2022 10:57:10 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 12 May 2022 05:57:08 -0500
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/pm: consistent approach for smartshift
Date: Thu, 12 May 2022 16:26:52 +0530
Message-ID: <20220512105652.3520817-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46fc0769-fc4c-4823-b5a2-08da34062a43
X-MS-TrafficTypeDiagnostic: MN2PR12MB4111:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB41116264BB8F598DA704E8B39DCB9@MN2PR12MB4111.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r+6HCmJ3lLgDYilENLtI9kkfnAvXWulKc372Z9xENw5ja8IFhcECqYZL6pXUwBb3LwxpnGnxcTSw2+Bipt8HZMLftZBTAYAC5i6/ZkpoLaGQJq8mnytIV3kVQID+q229dIjx6Et3opdohS2SLNNA/c/17wkEQtv8PupbExWlXBhwCnpoquzZ4z2I5DIYKQ1Jzj6kygeDfc4cNU41G+sNQLvyiGnwYlaEV0SmjH3CpWTD2EOyclpChk+B4omCmO4qn4CUEVJYYBLGWekUTWH0jMH18BwzW35IfsNmaNWeU1HJM814DIOxCkSRiP1fKA2wufvFFOQWKNoMwNrf5NeXPWtT2k3r2ictAFcUtuNSSccDVGXgYFi98V2sk/KRPtHyqOiK5xTaQM1E0csJXeMKZbY/l3i/leV2DGqZ1xvC7b7fBxR13iqx4pXUDw/CG1gzQjV07HU1zWnkyTQ/7aheF6y01t63MBk3JG3Cfj1pDbDQbMLh/HBWrKTwH4IVX5sJ+tQJNts5nj1HjzDzX4lpby3uh/NVzI106FXfTdyNjFkhp3O1VMeF2hLCn7RyDs6PdxjxIHQESmKKIrt1wQ4686eJwxPAnDB/2coa97th6MA4TPVl00lmJmSiB61NIrjEWZAI14oQTBqARN4hwBNtAa3PdZ720aV9VzNfjqv82T1hujXpCSd0K4XHMigDtq+jnIVNzMQyg0JjN7EvWpcefw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(316002)(1076003)(70586007)(36756003)(336012)(70206006)(356005)(426003)(47076005)(16526019)(54906003)(6916009)(83380400001)(186003)(2616005)(26005)(6666004)(7696005)(82310400005)(36860700001)(81166007)(86362001)(8676002)(40460700003)(5660300002)(8936002)(508600001)(4326008)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 10:57:10.9093 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46fc0769-fc4c-4823-b5a2-08da34062a43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4111
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

V2: avoid checking for the number of VGA/DISPLAY devices (Lijo)

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 136 ++++++++++++++++-------------
 1 file changed, 74 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index d3228216b2da..292e8c241597 100644
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
@@ -1763,28 +1752,65 @@ static ssize_t amdgpu_get_smartshift_apu_power(struct device *dev, struct device
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
+			r = amdgpu_read_powershift_percent(adev, &ss_power, false);
+	}
+
+	if (!r)
+		r = sysfs_emit(buf, "%u%%\n", ss_power);
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
@@ -1792,31 +1818,28 @@ static ssize_t amdgpu_get_smartshift_dgpu_power(struct device *dev, struct devic
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
+	uint32_t ss_power = 0;
+	int r = 0, i;
+
+	r = amdgpu_read_powershift_percent(adev, &ss_power, true);
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
+			r = amdgpu_read_powershift_percent(adev, &ss_power, true);
 	}
 
-	r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_DGPU_SHARE,
-				   (void *)&ss_power, &size);
-
-	if (r)
-		goto out;
-
-	r = sysfs_emit(buf, "%u%%\n", ss_power);
+	if (!r)
+		r = sysfs_emit(buf, "%u%%\n", ss_power);
 
-out:
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
 	return r;
 }
 
@@ -1884,18 +1907,7 @@ static ssize_t amdgpu_set_smartshift_bias(struct device *dev,
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


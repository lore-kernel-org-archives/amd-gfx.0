Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39036C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 03:29:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F36922B48
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 03:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1XxUSVYy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F36922B48
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C841B6E84C;
	Thu, 30 Jul 2020 03:29:12 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB1D06E84C
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 03:29:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkEiaL4duCyrA0ExeN2k/DEXU0HCMEAaKiG20qPbdg+3kNHfQi+RvtfENouunkErEnI9sK5cKp8+YbMcYh3+iWxdctVfFX/vDs2fYjXCQzZTo25YZfv/YhTgCGhCGb0yvVfPD7Jz0xu8hGM0eBT/vGYHg9wlcorebTa8XvdtWiO21+CGZRXSTYFyI0ThgFfrptV4HgSQCI60JuI45vXM5Aw9Wn2WXZVKb/cJETf6rUYIjn2fdRleiXY6v6aSmB2Ddf8h07Grz/jLZiKF3xCrLj6tBDPaGMiP5RW4Bjkf8BhCPFap/wbAnlAGwwm4aHChOBSOanHgPJqudglWfms3AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyQORd2UuS7xVYotcHg9FuMz3Eq34oA79GspzBq+M7E=;
 b=gN9YXmRDQVHyUHha2Npdclg/4pzufLBvlA3KG/vJks+9vd+XzGA5jm799sfym3FY3ckOnsekCWDjYiawx78lW3rW+ZqG9D8RNedXrGcGkMeatF1dZvVxFSNmoMWIDZsoidzOiVF7qVSCaQup6jMcHGYrrIQ3HybZPGeXzWtJyd9tVt4KCCq3Uw6R9HNJ3LCGpikl/KZKPXKg82lKzEpFzhdr6rPx+GPDOET8LMuP3w7Y6gc3mqU0iZc3t0gP/OP4xd1CzYyqLlLzcxyQ3540mFRciBor/Jih+Szz42zfHv+W/LbAqRTYa+2MQ6YDcaY0c3kZoa5XsbYJ5FsI4hBm8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyQORd2UuS7xVYotcHg9FuMz3Eq34oA79GspzBq+M7E=;
 b=1XxUSVYyLoCqNW8E8T7VWC7e6i2U50zzJ3hgcoxeFWs0GdwttA76xyh8/v1Rv444lpLOmEuEZQlr1sSzXKjAouszJHQ442dAf7GTFHHgTHbIWLlNZwHOSS10rDIShS0AZ9WU7zdpFcD8U/2ZRXguytnhGUdtb2RNMSMb0nnBjlE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.17; Thu, 30 Jul 2020 03:29:10 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3239.018; Thu, 30 Jul 2020
 03:29:10 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/8] drm/amd/powerplay: add new sysfs interface for retrieving
 gpu metrics(V2)
Date: Thu, 30 Jul 2020 11:28:33 +0800
Message-Id: <20200730032839.2517-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200730032839.2517-1-evan.quan@amd.com>
References: <20200730032839.2517-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR02CA0176.apcprd02.prod.outlook.com
 (2603:1096:201:21::12) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0176.apcprd02.prod.outlook.com (2603:1096:201:21::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.17 via Frontend Transport; Thu, 30 Jul 2020 03:29:08 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 05f51be3-9613-487d-a80e-08d83438b8f3
X-MS-TrafficTypeDiagnostic: DM5PR12MB1355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1355DC4BD198D0C63AEE91DBE4710@DM5PR12MB1355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8hOyujbwkoNMl65PYYZbc0a/09Bxe1QtDYP8GOecUe2U+5nHrVksfqRgq/FWv0xzrDKXRHAzaxtcIrRXQR3vw0+uhpZnFpzDCaHVKz+WyA5oKEy0AY02Ru6mMTuXHmdOqBqIIpPf36cpMqdan+GAgkQgqR82kLNPG3PmVX9TfFL3xZRDnwLWPeSvNcu8IA5SnmGYJ8LvUO7XxXOuvhlr7jzuVi0gt91N2dUdFhXtdJbIVTbyz+uRYkjBKgKSlIe3Nx4UXJvYQs/EW+VM3tT0UeVz4rYLkYjsmLhnP4bviU0U9Xt5M+GYVsMhs5NZSQ3rLB3nmUUQXq9WPtO4iPgneA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(186003)(83380400001)(4326008)(6916009)(36756003)(2906002)(8676002)(8936002)(478600001)(66946007)(44832011)(2616005)(956004)(26005)(66476007)(66556008)(1076003)(6666004)(6486002)(5660300002)(86362001)(52116002)(7696005)(16526019)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: /XatXaS2uP6cnVm1iYILVjos8IsC8ElegC5eGf8S14ff6UZrAR5jjAKsrrPAJsbF3ey3+g9hR/FAt5es2KN5mGaSW+Zq3eOxMLgDN2zBWaCUzBLm8F07swKZVBANlgEFA0t5NOnwtXlMRHo1Ou5722MUZdtYx5B7xJqRW0xADqSJOKlDq4HHubmiuStAgorAIDt34ItD595YMOSBXvKdwEbWpNCFgt24qhguHRIrLY4W9TVvAJuwwIUoPHoWGG14iyHx8d0Szfxi0nLNIA2+9U5PL/n/joZYjLk+oC3SHepQFe89dJlshcdQd0YHwUMgKQNGtaOiboHnZiPsaVFZsC+k3fVt2RQy0u+kYSysBBE/7oBQA2SVy/7o9HfknibZH+9HJpRZ+nObKW727uNjmF71TZ68ZeXv60PDi3ftejf1vegdh6tqbft+SnD52rXLSn4GwfycEvReVxEL1HeRfUBD4vJlnkC8x6znEcCQgX9L1MCu6cOziz/vImEQQY7uJIK410jKkajzIL+f4XGcHO75AdDU0i7QrmoMxZXluIjpa522mOsdPgm7NeVC8UkDFBqJ9EpQjFZieBaY4RJGkkoToKQC7xdLxBTPYhRMNEWV5seWwxYE6TkOyV/LScQsLDYCmgp4MGuqgRW3wGxbLg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f51be3-9613-487d-a80e-08d83438b8f3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 03:29:10.3331 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DHUvs8dKTePrsjBOoxz794fAssjSwLyQeBjsOaAVzw9/Jjx6OBwbuYqHFvjyjqeE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1355
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

A new interface for UMD to retrieve gpu metrics data.

V2: rich the documentation

Change-Id: If7f3523915505c0ece0a56dfd476d2b8473440d4
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 Documentation/gpu/amdgpu.rst                  |  6 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h       |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c        | 57 +++++++++++++++++++
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  1 +
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 20 +++++++
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  3 +
 6 files changed, 90 insertions(+)

diff --git a/Documentation/gpu/amdgpu.rst b/Documentation/gpu/amdgpu.rst
index 17112352f605..0f7679a7cf54 100644
--- a/Documentation/gpu/amdgpu.rst
+++ b/Documentation/gpu/amdgpu.rst
@@ -206,6 +206,12 @@ pp_power_profile_mode
 .. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
    :doc: mem_busy_percent
 
+gpu_metrics
+~~~~~~~~~~~~~~~~~~~~~
+
+.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+   :doc: gpu_metrics
+
 GPU Product Information
 =======================
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
index aa27fe65cdfa..b190c0af7db1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
@@ -369,6 +369,9 @@ enum amdgpu_pcie_gen {
 		((adev)->powerplay.pp_funcs->set_ppfeature_status(\
 			(adev)->powerplay.pp_handle, (ppfeatures)))
 
+#define amdgpu_dpm_get_gpu_metrics(adev, table) \
+		((adev)->powerplay.pp_funcs->get_gpu_metrics((adev)->powerplay.pp_handle, table))
+
 struct amdgpu_dpm {
 	struct amdgpu_ps        *ps;
 	/* number of valid power states */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index 6df405e6221d..0198acd320b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -2122,6 +2122,59 @@ static ssize_t amdgpu_set_thermal_throttling_logging(struct device *dev,
 	return count;
 }
 
+/**
+ * DOC: gpu_metrics
+ *
+ * The amdgpu driver provides a sysfs API for retrieving current gpu
+ * metrics data. The file gpu_metrics is used for this. Reading the
+ * file will dump all the current gpu metrics data.
+ *
+ * These data include temperature, frequency, engines utilization,
+ * power consume, throttler status, fan speed and cpu core statistics(
+ * available for APU only). That's it will give a snapshot of all sensors
+ * at the same time.
+ */
+static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = ddev->dev_private;
+	void *gpu_metrics;
+	ssize_t size = 0;
+	int ret;
+
+	if (amdgpu_in_reset(adev))
+		return -EPERM;
+
+	ret = pm_runtime_get_sync(ddev->dev);
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(ddev->dev);
+		return ret;
+	}
+
+	down_read(&adev->reset_sem);
+	if (is_support_sw_smu(adev))
+		size = smu_sys_get_gpu_metrics(&adev->smu, &gpu_metrics);
+	else if (adev->powerplay.pp_funcs->get_gpu_metrics)
+		size = amdgpu_dpm_get_gpu_metrics(adev, &gpu_metrics);
+	up_read(&adev->reset_sem);
+
+	if (size <= 0)
+		goto out;
+
+	if (size >= PAGE_SIZE)
+		size = PAGE_SIZE - 1;
+
+	memcpy(buf, gpu_metrics, size);
+
+out:
+	pm_runtime_mark_last_busy(ddev->dev);
+	pm_runtime_put_autosuspend(ddev->dev);
+
+	return size;
+}
+
 static struct amdgpu_device_attr amdgpu_device_attrs[] = {
 	AMDGPU_DEVICE_ATTR_RW(power_dpm_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(power_dpm_force_performance_level,	ATTR_FLAG_BASIC),
@@ -2145,6 +2198,7 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
 	AMDGPU_DEVICE_ATTR_RW(pp_features,				ATTR_FLAG_BASIC),
 	AMDGPU_DEVICE_ATTR_RO(unique_id,				ATTR_FLAG_BASIC),
 	AMDGPU_DEVICE_ATTR_RW(thermal_throttling_logging,		ATTR_FLAG_BASIC),
+	AMDGPU_DEVICE_ATTR_RO(gpu_metrics,				ATTR_FLAG_BASIC),
 };
 
 static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
@@ -2194,6 +2248,9 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 	} else if (DEVICE_ATTR_IS(pp_features)) {
 		if (adev->flags & AMD_IS_APU || asic_type < CHIP_VEGA10)
 			*states = ATTR_STATE_UNSUPPORTED;
+	} else if (DEVICE_ATTR_IS(gpu_metrics)) {
+		if (asic_type < CHIP_VEGA12)
+			*states = ATTR_STATE_UNSUPPORTED;
 	}
 
 	if (asic_type == CHIP_ARCTURUS) {
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 5122f8e5436a..1900cfa20601 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -322,6 +322,7 @@ struct amd_pm_funcs {
 	int (*asic_reset_mode_2)(void *handle);
 	int (*set_df_cstate)(void *handle, enum pp_df_cstate state);
 	int (*set_xgmi_pstate)(void *handle, uint32_t pstate);
+	ssize_t (*get_gpu_metrics)(void *handle, void **table);
 };
 
 struct metrics_table_header {
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 55463e7a11e2..cf9c5205ef08 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -2516,3 +2516,23 @@ int smu_get_dpm_clock_table(struct smu_context *smu,
 
 	return ret;
 }
+
+ssize_t smu_sys_get_gpu_metrics(struct smu_context *smu,
+				void **table)
+{
+	ssize_t size;
+
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
+	if (!smu->ppt_funcs->get_gpu_metrics)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&smu->mutex);
+
+	size = smu->ppt_funcs->get_gpu_metrics(smu, table);
+
+	mutex_unlock(&smu->mutex);
+
+	return size;
+}
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index b57b10406390..a08155b83289 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -589,6 +589,7 @@ struct pptable_funcs {
 	void (*log_thermal_throttling_event)(struct smu_context *smu);
 	size_t (*get_pp_feature_mask)(struct smu_context *smu, char *buf);
 	int (*set_pp_feature_mask)(struct smu_context *smu, uint64_t new_mask);
+	ssize_t (*get_gpu_metrics)(struct smu_context *smu, void **table);
 };
 
 typedef enum {
@@ -791,5 +792,7 @@ int smu_get_dpm_clock_table(struct smu_context *smu,
 
 int smu_get_status_gfxoff(struct amdgpu_device *adev, uint32_t *value);
 
+ssize_t smu_sys_get_gpu_metrics(struct smu_context *smu, void **table);
+
 #endif
 #endif
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=+arJ=BK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F5BC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 02:43:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 085F72083E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 02:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="heuBqycx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 085F72083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B4F96E992;
	Fri, 31 Jul 2020 02:43:47 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 064976E992
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2020 02:43:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zgf0WqsgBsC4mQ1gcp4rvv1O+a4eySpnzbQU5h1Oy7LAq1ttmeMUBes7M7PHhEvN9kEWIy78QOwNXTP4DatrDItVt52RGqjy/7XvIMzZqHVeFfzhK7HwnkES/cn3h9B+vr4jXV8e4KUqv7KdmUriCO0dPAj97GK6wuGG/XAmqhFrv4mQpqqUGsPjgVuZcEE+kXsx4bp9XsB3tJwOWVuqurCicWwq8z7divkENRdVlKCWM+helApt8rB4GO6W/IGeYsHXxIC2IAEmCWlbUb/XJB70lKhwpYVgJo11yJygQk53AwtZ5B/DxbEk0IvYtCZQ7qE27obkq/keXuX47yXYUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5DPPglDZxFh0HbmJ1r1+XtoYTSAJgYn7rjX8pcPIcc=;
 b=RJKcBAtEyukiXjYfUnn+OZiLRDhij+/ijiPEBqoUzymiv6SDh86M64xCMonlaniaTZ0E/OIuVpwmkt9qnmnehdGtLNTIe2OVQmZKAN1FXP6O08/5/c3W5hMonqPgau46nTU+yv/LAK68KFjjrQOpNYCZZLqKNBkg+MsalKl3gEFhEyxursOFqfccC0Tb+7Z1O+Ol/fXEknF8hCit8hnW3CJ4k7tFbe1xoHkiSlJNnfAFMBgiHj+ep8ZxLMqASEdHv838iRsDfIfc7bydgExOnXr1KwnaBu1bDFaLKn6t8KI1xltBAlNgCQMFBn1D3cdzusZcVbNPxdWj0gLOHxVW0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5DPPglDZxFh0HbmJ1r1+XtoYTSAJgYn7rjX8pcPIcc=;
 b=heuBqycxmsa/GvcaGayN8U2k4B9vDJFdW2xHS9EAQuPP+9/nnDmeGPrFIrCfdOVh0MZf/PsOtmE0SSQe8qW0HjbL9sat9qUOLO14OlF1BW7+8OZqHLw100AlcIXLQNEq3UEeIcdnU8Wxm0halh2UMOz0FRNc22VWNtyF/U01M4A=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16; Fri, 31 Jul 2020 02:43:44 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3239.018; Fri, 31 Jul 2020
 02:43:44 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/17] drm/amd/powerplay: add new sysfs interface for
 retrieving gpu metrics(V2)
Date: Fri, 31 Jul 2020 10:43:01 +0800
Message-Id: <20200731024316.28324-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200731024316.28324-1-evan.quan@amd.com>
References: <20200731024316.28324-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR02CA0206.apcprd02.prod.outlook.com
 (2603:1096:201:20::18) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0206.apcprd02.prod.outlook.com (2603:1096:201:20::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16 via Frontend Transport; Fri, 31 Jul 2020 02:43:42 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bdb5b022-fba2-4207-e430-08d834fb8ad1
X-MS-TrafficTypeDiagnostic: DM6PR12MB4435:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4435F04B4C408168A7468B7AE44E0@DM6PR12MB4435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SGpWqxxZSc4HHYTY4A0WGcccGnI/Xh7JrUHmfrw6ds/zFIDu6eiI2E56UctdAjClFBou1Di2ExaQNsUIFIzqFeoL7gdA9DIRX5jEAJ/YlbHTil+U9eYdhn4Bur20B/0GaBHBGGGlWH9EdRayomS5kkheChfFnsJVxt02M1v3pA32wuvRml3R4i2CvQ8tqGGSR0vP0WPXw9dw0x4v0FthAQ+GBpwcsoUUsL7H9eDc0WmebJWjLRzjTy/5fSZzPCEX0i0S8i8Dl8ItiOZCrSEx+Li2TyOId5RNnu23P58XkSIXAF1MFT3Lpuvg/Y68rRFz3BVIIXMgZFw52Zt7T4dinQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(16526019)(186003)(6666004)(6486002)(36756003)(6916009)(8676002)(44832011)(83380400001)(956004)(26005)(66946007)(1076003)(5660300002)(66556008)(66476007)(4326008)(7696005)(2616005)(86362001)(2906002)(478600001)(8936002)(52116002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: uXegH8r8HF57sKsnf0hX4cHE6JHAKieE/pOAh3Fh76Okfdj1paTTiGuOyy3d57P6n4baVCDJjsQcbB2H4fDTRvgpKECMIGx3STmPkcHA67R2dHjGpNmO6dFEZzN989ga36n1iO5mcmH7QTMEklhZKiT7lUX2CfTHH9L8X+pPA0fcnEdMF3EXAMT7Y3StOFQuyCXp6FMYfOiIf78D44SD8fG4b49itEGKrOHSbfC9sNDivU+HXBkQNXzxxnCmxvjiKA8dv9JdH9yXhu+5uJSHLEQEWOOLtIkC1eHk9N623pdkWnd0p+O7RUMf0prV/zl+tAa4qj7eh3egUfzY6/lQbfVKK1aERu2swb9STD67RGsfzVpXx+r2EwJg2K2A2+z16V+5LQQ6PEpV/XQkA/tNom28RFHJuKtzeMLQ7HjsmJLUnh9Ewaon7kt9X8GQS0CFfU5uiEsKEU8XRbOSfw1we2jL1pTcmUHbFp9f4E0jHpNRphtYJEP2omHU/KXpy5JSOS93euCB/ggUZCvLzdRbXJp0k1+AfmfWgXp/bJ0FbOT+DHNdwvGjl7kX9CL8LAdbzx3D0BPcey+M+0VanyxdTIuE/8AuvlqOKyHGQfZ5rJVlMAv5e0LjuIJaVola9etkc5vqP1I27hNKjVE1XMmEoQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb5b022-fba2-4207-e430-08d834fb8ad1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 02:43:44.6240 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZlHSaPeaktqWe/SAUXD+BT/+pUwtQP968oXUwC8Qxe+BI550Jjw75HKnfUghL1wF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435
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
Cc: alexander.deucher@amd.com, Felix.Kuehling@amd.com,
 Evan Quan <evan.quan@amd.com>, Harish.Kasiviswanathan@amd.com,
 nirmodas@amd.com
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
index 5f38ee62c103..0aec28fda058 100644
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

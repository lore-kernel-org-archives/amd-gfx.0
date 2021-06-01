Return-Path: <SRS0=H3yO=K3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1340DC4708F
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 16:53:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE73861376
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 16:53:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE73861376
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88F696EAB9;
	Tue,  1 Jun 2021 16:53:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B000A6EAB9
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jun 2021 16:53:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECXK1vc/9VMh2dx3sqiYlxO2CY1Sy9dPcpmKof52TCyT5tKbQJxxkWUoFgreU6815ZVw99tUmTzgVxZgPwxV87y0Mm7K/c050Mua/6VwYKI8qkxIVv/SKAvHQj9njejb4pZhAfEMBfRK2sMa6S6e1v4z7JNb3/OrrOQA4pLTNBGtsTkrYm6ILZiMgzj6xXn4vgqloC7daVJPizLbjAOmoe22x+lN36f5o/gfrClfHz6Vyacyky9YmvbV994w0BDKGEhhr2cRm2muLvhQfbIXtKUVVZ2gpZML3GG9YgI9/2O4bG+C+70UgLRUJSPABM+5xfaiRDfiU/0mcMeAW8e4gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7TwRFGx3yD1WVMMMgUe4sqIO4ENewduJFS5kpoSAVE=;
 b=duYEAz+fAMdLmkWIwWXgxstMj4wkjp/kwUXZrWzbPx/xNwNr/nzfWnBiflrz46n2zdNhHJ2r6fA0ZdABnvvQtxXxiQjjlHaGtp0bUjgHygnzkO1BskpCJrBpomtOpbUGKGffDFmXz65X+eynaPCAfgaYjYjy5nm5lk+GlWltr2CQwNgw4GwjRGSUU0Rn2ga7JJF1XBecTlCjR3A5YF18FhEBIoEUDmg/dtD+gfiYmb8HdN9fhuTSb63fSN+qh6EIqkhpxKxmJjECwI/IFH6+8SB8FqDasZc20QxwIXaZMj0/DFPHQc3fptXh5tblXzS0nDTpQjYoX6tb6ktMNJhdWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7TwRFGx3yD1WVMMMgUe4sqIO4ENewduJFS5kpoSAVE=;
 b=1l1+HHAalSYJPTQuuAIYBzN5h7tyP1Sx3lzVIOp+ivZYfUg6/qptuHV0FLbMv/Io+e24pmtfe/XfYrGZRJUV+/r9qgNWYWuYlGgpNMzutYd3STccpbJl8tV4CHerKWSVcDcH0Xwazd38XFrFMuwSNDWsUKZMbcl0AbC0Ry+X75k=
Received: from CO2PR04CA0086.namprd04.prod.outlook.com (2603:10b6:104:6::12)
 by BN8PR12MB2945.namprd12.prod.outlook.com (2603:10b6:408:96::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Tue, 1 Jun
 2021 16:53:29 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:6:cafe::fe) by CO2PR04CA0086.outlook.office365.com
 (2603:10b6:104:6::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Tue, 1 Jun 2021 16:53:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Tue, 1 Jun 2021 16:53:28 +0000
Received: from amd-Mayan-RMB.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 1 Jun 2021
 11:53:25 -0500
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: attr to control SS2.0 bias level (v2)
Date: Tue, 1 Jun 2021 22:23:11 +0530
Message-ID: <20210601165311.4142-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ccaaf36-146a-49a8-5c83-08d9251dc7a7
X-MS-TrafficTypeDiagnostic: BN8PR12MB2945:
X-Microsoft-Antispam-PRVS: <BN8PR12MB2945FFE77ED4E35E8C7700369D3E9@BN8PR12MB2945.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ncp7scJhgX8SmD0hEcX6XR/FjmgXwbgCfo8tVaQ+jyMvJHJ9T7Ywv+ucvc5cAMKORjOC7iwWBzxRihh1Xz0BsCHR+p7hRxeBeNd6cX9FrPe6ppGLLu/JsKgynFHRZTTmym4hpEJ6HhQppiI8wr8ME/8M4/CVH1cpt5I8cjT4FTZG1Dn3QOd4jCHRb/ixS9jSVJmHEUm/ZDOJ8skjcZLdm4dfhAVmb+SZuYJFfW8cL1Wy/LXEa1q5eMREu/QJjfffQefztUVHAwC4bGEiMbVse9a982low0rq8a7ckoI4UGyHw5JFBoljf/UC3QO9ambZsJB2Co2cbdGxv4RDyfXUyaKLTbF9hqKy7UKiCq3/K+Dpa/JRJNpBlJaOQIanopDeapEAOxMqBLyUYwIR/UhtaNHeJdX//a39XLj03K54BTSKk40MqkRG7F4Zzjq090RUijlT6/xZ1vpnxN4fON26L0HfkrxYDyIkunMbv1fUeJ/ya89hcocIFjqwy1pSxcU4zEJghclHhnipc0z2PPo6vIbGsE7mmtWuhZrLYbC4b9+U2gY0UAy9RYwUs56VqyV0PmbqH9bE+eQ6eQC1GKC5JcyAeqClNNNgflpqBfSXsyirNV+rRgoJjD2ZMHhCyRSfLAgX6iLcP5GJbTeH+nR21bX2c/bahzl57z32fYf6ZUYK1St2d4h6jftBMm+K5Zhp
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(346002)(39860400002)(46966006)(36840700001)(8936002)(1076003)(478600001)(6666004)(26005)(82310400003)(4326008)(86362001)(7696005)(47076005)(70586007)(70206006)(336012)(6916009)(36756003)(8676002)(2906002)(186003)(16526019)(5660300002)(356005)(81166007)(83380400001)(82740400003)(426003)(54906003)(316002)(36860700001)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 16:53:28.2010 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ccaaf36-146a-49a8-5c83-08d9251dc7a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2945
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Shashank Sharma <Shashank.Sharma@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add sysfs attr to read/write smartshift bias level.
document smartshift_bias sysfs attr.

V2: add attr to amdgpu_device_attrs and use attr_update (Lijo)

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 Documentation/gpu/amdgpu.rst            |  6 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  5 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  1 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c      | 80 +++++++++++++++++++++++++
 4 files changed, 92 insertions(+)

diff --git a/Documentation/gpu/amdgpu.rst b/Documentation/gpu/amdgpu.rst
index 6cce26b5621e..364680cdad2e 100644
--- a/Documentation/gpu/amdgpu.rst
+++ b/Documentation/gpu/amdgpu.rst
@@ -316,3 +316,9 @@ smartshift_dgpu_power
 
 .. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
    :doc: smartshift_dgpu_power
+
+smartshift_bias
+---------------
+
+.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
+   :doc: smartshift_bias
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index ea49d0df7998..8a2df1bbe823 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -211,6 +211,7 @@ extern int amdgpu_discovery;
 extern int amdgpu_mes;
 extern int amdgpu_noretry;
 extern int amdgpu_force_asic_type;
+extern int amdgpu_smartshift_bias;
 #ifdef CONFIG_HSA_AMD
 extern int sched_policy;
 extern bool debug_evictions;
@@ -268,6 +269,10 @@ extern int amdgpu_num_kcq;
 #define CIK_CURSOR_WIDTH 128
 #define CIK_CURSOR_HEIGHT 128
 
+/* smasrt shift bias level limits */
+#define AMDGPU_SMARTSHIFT_MAX_BIAS (100)
+#define AMDGPU_SMARTSHIFT_MIN_BIAS (-100)
+
 struct amdgpu_device;
 struct amdgpu_ib;
 struct amdgpu_cs_parser;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index cce7e8e31883..5c13bca2944d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -171,6 +171,7 @@ int amdgpu_tmz = -1; /* auto */
 uint amdgpu_freesync_vid_mode;
 int amdgpu_reset_method = -1; /* auto */
 int amdgpu_num_kcq = -1;
+int amdgpu_smartshift_bias;
 
 static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work);
 
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 22cc27935c34..12bdbddc19ef 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1903,6 +1903,67 @@ static ssize_t amdgpu_get_smartshift_dgpu_power(struct device *dev, struct devic
 	return r;
 }
 
+/**
+ * DOC: smartshift_bias
+ *
+ * The amdgpu driver provides a sysfs API for reporting the
+ * smartshift(SS2.0) bias level. The value ranges from -100 to 100
+ * and the default is 0. -100 sets maximum preference to APU
+ * and 100 sets max perference to dGPU.
+ */
+
+static ssize_t amdgpu_get_smartshift_bias(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	int r = 0;
+
+	r = sysfs_emit(buf, "%d\n", amdgpu_smartshift_bias);
+
+	return r;
+}
+
+static ssize_t amdgpu_set_smartshift_bias(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf, size_t count)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	int r = 0;
+	int bias = 0;
+
+	if (amdgpu_in_reset(adev))
+		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
+
+	r = pm_runtime_get_sync(ddev->dev);
+	if (r < 0) {
+		pm_runtime_put_autosuspend(ddev->dev);
+		return r;
+	}
+
+	r = kstrtoint(buf, 10, &bias);
+	if (r)
+		goto out;
+
+	if (bias > AMDGPU_SMARTSHIFT_MAX_BIAS)
+		bias = AMDGPU_SMARTSHIFT_MAX_BIAS;
+	else if (bias < AMDGPU_SMARTSHIFT_MIN_BIAS)
+		bias = AMDGPU_SMARTSHIFT_MIN_BIAS;
+
+	amdgpu_smartshift_bias = bias;
+	r = count;
+
+	/* TODO: upadte bias level with SMU message */
+
+out:
+	pm_runtime_mark_last_busy(ddev->dev);
+	pm_runtime_put_autosuspend(ddev->dev);
+	return r;
+}
+
+
 static int ss_power_attr_update(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
 				uint32_t mask, enum amdgpu_device_attr_states *states)
 {
@@ -1923,6 +1984,23 @@ static int ss_power_attr_update(struct amdgpu_device *adev, struct amdgpu_device
 	return 0;
 }
 
+static int ss_bias_attr_update(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
+			       uint32_t mask, enum amdgpu_device_attr_states *states)
+{
+	uint32_t ss_power, size;
+
+	if (!amdgpu_device_supports_smart_shift(adev_to_drm(adev)))
+		*states = ATTR_STATE_UNSUPPORTED;
+	else if (amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_APU_SHARE,
+		 (void *)&ss_power, &size))
+		*states = ATTR_STATE_UNSUPPORTED;
+	else if (amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_DGPU_SHARE,
+		 (void *)&ss_power, &size))
+		*states = ATTR_STATE_UNSUPPORTED;
+
+	return 0;
+}
+
 static struct amdgpu_device_attr amdgpu_device_attrs[] = {
 	AMDGPU_DEVICE_ATTR_RW(power_dpm_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(power_dpm_force_performance_level,	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
@@ -1953,6 +2031,8 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
 			      .attr_update = ss_power_attr_update),
 	AMDGPU_DEVICE_ATTR_RO(smartshift_dgpu_power,			ATTR_FLAG_BASIC,
 			      .attr_update = ss_power_attr_update),
+	AMDGPU_DEVICE_ATTR_RW(smartshift_bias,				ATTR_FLAG_BASIC,
+			      .attr_update = ss_bias_attr_update),
 };
 
 static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

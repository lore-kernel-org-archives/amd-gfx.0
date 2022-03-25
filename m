Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB57C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Mar 2022 08:31:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAD0910E739;
	Fri, 25 Mar 2022 08:31:38 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2065.outbound.protection.outlook.com [40.107.95.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3420510E739
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Mar 2022 08:31:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDu+GhGytof8Wz092lBg5VPJxW7hbWmAWrpgn6EAnMAieQBRSAwfpHDshsazgP91x/Jo+Won7asyJuQW573Sv6e2dT7M4q48oIsZznBRNXSyz/lg/HTO4rrufacKVdhGVzdbfh3KwBr5oelMrbm8aY1A/VdN+e+pMZYBXO52Jvm22FJbmNt33PNf/kMywzLorwInRaK2UhQGXbiJMrUl7tsYl8BUNiFi9IQ3cYr7rBnd8INz2SMUyUpaaaXOvWGMIubJ5BVdjH+JdrwiTzxv9RNmtUZ24ChqDsDkBZawMROMupWyl4cJkdLEzmwXUKkbvnbwrysAlZKEGlu3ozWdVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fkZqYGKyInWQrGUZaJgKuj4hzNATdmEzn0+S+SxVlI=;
 b=D9h9W1bTfoD/EHEIqmsre86Qdhwr2vJBxCDm2qLGiig66lY//ROuDllD84O56a1eEZ8BtXN5FXMqDBwmBfwd5jrbuVrxp/0JQaqy+7zubzd9biPAnDM074fuPZx622fMYRQxHBFwXlfpbb8ub14t87sw9BAhlh11NzV1elZWGqtQkoma8A4tcshVpVSQGbuSjoFqvQ61OKpUTe2kJz7G7TTlo6wUbG1LkReTsYSqXJZXS1O42wpuyCH0/kbR+BkWCr6SLFJmS9u5H+QvfGpTrwzwFqUrEngebD/sPPAJHlgAsbsBPz8b9+sT0MQ4Q7tu0U8WUixkAiE7J19WXFtjFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fkZqYGKyInWQrGUZaJgKuj4hzNATdmEzn0+S+SxVlI=;
 b=eQGUwFIk5TDk26VXiLB+owweypO1vnsIgjoBx1wkfWHXe1RD32Ef5Q0oPdQWh1fEGnMw/lN/jEiODEsQGcwzSL+QB79Mf11oebwwwG7sZh5HsnZ4w5mD8p+FehwQoKF2w67oS4GoSU/s6uWXFV79rLN4IyWYt6FybGIs63NFfkQ=
Received: from BN9PR03CA0596.namprd03.prod.outlook.com (2603:10b6:408:10d::31)
 by BN6PR12MB1922.namprd12.prod.outlook.com (2603:10b6:404:106::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Fri, 25 Mar
 2022 08:31:35 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::a0) by BN9PR03CA0596.outlook.office365.com
 (2603:10b6:408:10d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Fri, 25 Mar 2022 08:31:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Fri, 25 Mar 2022 08:31:35 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 25 Mar
 2022 03:31:32 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Check feature support using IP version
Date: Fri, 25 Mar 2022 14:01:15 +0530
Message-ID: <20220325083115.1311275-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22233b20-d51a-4a09-9cab-08da0e39dfa4
X-MS-TrafficTypeDiagnostic: BN6PR12MB1922:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1922D92EED837CBDD57C64A6971A9@BN6PR12MB1922.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xAoh0meiiOKTXsfZrGiPn6ruW9xSMj3MOA5XYdDi6GmWEhzf4wybwlXI6AaEwCza3IxivO9OQgEbtsF1ve+1mN+rslemtZLvYggmEWNI3egov0em2MwE8HAtH2uaoyhb9Bj7CIYQy4byzidBYAtk8xgpgMxK3jIqiQ5Nl/J+WHu6ZvEvTpXuaetm8yRBp4GxzsKWirjCtCWJqCaDA0qU2Yq03fcdB06YlNS5xZGwmAc3lYzey2ESnMSFykt2VBlX6RsosaD9D4wDkvh34oD53sT5jRU94drBeK9By6x2DoGhYwgvlfNhujN72VuwNuXxzQh8z5VEo2X7EZga0f6OTeDClhOA/SluD6vqVFzLcl2YCRQ5Ueae5PGLcGMe/5IU4xLlr5+zBBOpq0lUDXm43ZhqId45yTLFIPxRLrsNbfIsQPCjxJuTGOZ+mT5HptTJUqyPlr6lyMOPWrPH5rnA49ue0IhkyRdrBTJDRd3lxRGqlXDCOMdDREiwmXJjyQzujoUyF1nadN+Z0v8tnT0bNgiMbzuJ9wuSHfUlc7QSRPSkBeQ8gE/WB7cyqd0L4TPiH6S//M3LqnxpU0qsl/RyfCluJr7kyEupvif6ygCbViJhiV3v8o/tfm9+fb4StWE/a9IamEs7URk9AAqeNDJIpag3ULY5GqJIdIpzTucLfdzd65W1G2c2O/eOAB2v3bbaQkjLAZVD3Kcc0f/LjhrW2w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(5660300002)(86362001)(70586007)(82310400004)(508600001)(316002)(6666004)(8676002)(44832011)(4326008)(70206006)(81166007)(8936002)(36756003)(356005)(83380400001)(54906003)(47076005)(6916009)(7696005)(40460700003)(36860700001)(2616005)(336012)(186003)(2906002)(26005)(16526019)(1076003)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 08:31:35.3753 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22233b20-d51a-4a09-9cab-08da0e39dfa4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1922
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
Cc: Alexander.Deucher@amd.com, Evan.Quan@amd.com, KevinYang.Wang@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Instead of ASIC type, use GC and MP1 IP versions for feature support checks.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 72 ++++++++++++++++--------------
 1 file changed, 39 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 5cd67ddf8495..f89e0ff3f5a4 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1954,8 +1954,9 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 			       uint32_t mask, enum amdgpu_device_attr_states *states)
 {
 	struct device_attribute *dev_attr = &attr->dev_attr;
+	uint32_t mp1_ver = adev->ip_versions[MP1_HWIP][0];
+	uint32_t gc_ver = adev->ip_versions[GC_HWIP][0];
 	const char *attr_name = dev_attr->attr.name;
-	enum amd_asic_type asic_type = adev->asic_type;
 
 	if (!(attr->flags & mask)) {
 		*states = ATTR_STATE_UNSUPPORTED;
@@ -1965,53 +1966,55 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 #define DEVICE_ATTR_IS(_name)	(!strcmp(attr_name, #_name))
 
 	if (DEVICE_ATTR_IS(pp_dpm_socclk)) {
-		if (asic_type < CHIP_VEGA10)
+		if (gc_ver < IP_VERSION(9, 0, 0))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_dcefclk)) {
-		if (asic_type < CHIP_VEGA10 ||
-		    asic_type == CHIP_ARCTURUS ||
-		    asic_type == CHIP_ALDEBARAN)
+		if (gc_ver < IP_VERSION(9, 0, 0) ||
+		    gc_ver == IP_VERSION(9, 4, 1) ||
+		    gc_ver == IP_VERSION(9, 4, 2))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
-		if (asic_type < CHIP_VEGA20)
+		if (mp1_ver < IP_VERSION(10, 0, 0))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_od_clk_voltage)) {
 		*states = ATTR_STATE_UNSUPPORTED;
 		if (amdgpu_dpm_is_overdrive_supported(adev))
 			*states = ATTR_STATE_SUPPORTED;
 	} else if (DEVICE_ATTR_IS(mem_busy_percent)) {
-		if (adev->flags & AMD_IS_APU || asic_type == CHIP_VEGA10)
+		if (adev->flags & AMD_IS_APU || gc_ver == IP_VERSION(9, 0, 1))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pcie_bw)) {
 		/* PCIe Perf counters won't work on APU nodes */
 		if (adev->flags & AMD_IS_APU)
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(unique_id)) {
-		if (asic_type != CHIP_VEGA10 &&
-		    asic_type != CHIP_VEGA20 &&
-		    asic_type != CHIP_ARCTURUS &&
-		    asic_type != CHIP_ALDEBARAN)
+		if (gc_ver != IP_VERSION(9, 0, 1) &&
+		    gc_ver != IP_VERSION(9, 4, 0) &&
+		    gc_ver != IP_VERSION(9, 4, 1) &&
+		    gc_ver != IP_VERSION(9, 4, 2))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_features)) {
-		if (adev->flags & AMD_IS_APU || asic_type < CHIP_VEGA10)
+		if (adev->flags & AMD_IS_APU || gc_ver < IP_VERSION(9, 0, 0))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(gpu_metrics)) {
-		if (asic_type < CHIP_VEGA12)
+		if (gc_ver < IP_VERSION(9, 1, 0))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_vclk)) {
-		if (!(asic_type == CHIP_VANGOGH || asic_type == CHIP_SIENNA_CICHLID))
+		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
+		      gc_ver == IP_VERSION(10, 3, 0)))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
-		if (!(asic_type == CHIP_VANGOGH || asic_type == CHIP_SIENNA_CICHLID))
+		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
+		      gc_ver == IP_VERSION(10, 3, 0)))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {
 		if (amdgpu_dpm_get_power_profile_mode(adev, NULL) == -EOPNOTSUPP)
 			*states = ATTR_STATE_UNSUPPORTED;
 	}
 
-	switch (asic_type) {
-	case CHIP_ARCTURUS:
-	case CHIP_ALDEBARAN:
+	switch (gc_ver) {
+	case IP_VERSION(9, 4, 1):
+	case IP_VERSION(9, 4, 2):
 		/* the Mi series card does not support standalone mclk/socclk/fclk level setting */
 		if (DEVICE_ATTR_IS(pp_dpm_mclk) ||
 		    DEVICE_ATTR_IS(pp_dpm_socclk) ||
@@ -2026,7 +2029,7 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 
 	if (DEVICE_ATTR_IS(pp_dpm_dcefclk)) {
 		/* SMU MP1 does not support dcefclk level setting */
-		if (asic_type >= CHIP_NAVI10) {
+		if (gc_ver >= IP_VERSION(10, 0, 0)) {
 			dev_attr->attr.mode &= ~S_IWUGO;
 			dev_attr->store = NULL;
 		}
@@ -2864,8 +2867,9 @@ static ssize_t amdgpu_hwmon_show_power_label(struct device *dev,
 					 char *buf)
 {
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
+	uint32_t gc_ver = adev->ip_versions[GC_HWIP][0];
 
-	if (adev->asic_type == CHIP_VANGOGH)
+	if (gc_ver == IP_VERSION(10, 3, 1))
 		return sysfs_emit(buf, "%s\n",
 				  to_sensor_dev_attr(attr)->index == PP_PWR_TYPE_FAST ?
 				  "fastPPT" : "slowPPT");
@@ -3177,6 +3181,7 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
 	umode_t effective_mode = attr->mode;
+	uint32_t gc_ver = adev->ip_versions[GC_HWIP][0];
 
 	/* under multi-vf mode, the hwmon attributes are all not supported */
 	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
@@ -3245,18 +3250,18 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 	      attr == &sensor_dev_attr_pwm1_enable.dev_attr.attr)) /* can't manage state */
 		effective_mode &= ~S_IWUSR;
 
+	/* not implemented yet for GC 10.3.1 APUs */
 	if (((adev->family == AMDGPU_FAMILY_SI) ||
-		 ((adev->flags & AMD_IS_APU) &&
-	      (adev->asic_type != CHIP_VANGOGH))) &&	/* not implemented yet */
+	     ((adev->flags & AMD_IS_APU) && (gc_ver != IP_VERSION(10, 3, 1)))) &&
 	    (attr == &sensor_dev_attr_power1_cap_max.dev_attr.attr ||
-	     attr == &sensor_dev_attr_power1_cap_min.dev_attr.attr||
+	     attr == &sensor_dev_attr_power1_cap_min.dev_attr.attr ||
 	     attr == &sensor_dev_attr_power1_cap.dev_attr.attr ||
 	     attr == &sensor_dev_attr_power1_cap_default.dev_attr.attr))
 		return 0;
 
+	/* not implemented yet for APUs having <= GC 9.3.0 */
 	if (((adev->family == AMDGPU_FAMILY_SI) ||
-	     ((adev->flags & AMD_IS_APU) &&
-	      (adev->asic_type < CHIP_RENOIR))) &&	/* not implemented yet */
+	     ((adev->flags & AMD_IS_APU) && (gc_ver < IP_VERSION(9, 3, 0)))) &&
 	    (attr == &sensor_dev_attr_power1_average.dev_attr.attr))
 		return 0;
 
@@ -3294,8 +3299,7 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 		return 0;
 
 	/* only SOC15 dGPUs support hotspot and mem temperatures */
-	if (((adev->flags & AMD_IS_APU) ||
-	     adev->asic_type < CHIP_VEGA10) &&
+	if (((adev->flags & AMD_IS_APU) || gc_ver < IP_VERSION(9, 0, 0)) &&
 	    (attr == &sensor_dev_attr_temp2_crit.dev_attr.attr ||
 	     attr == &sensor_dev_attr_temp2_crit_hyst.dev_attr.attr ||
 	     attr == &sensor_dev_attr_temp3_crit.dev_attr.attr ||
@@ -3310,13 +3314,13 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 		return 0;
 
 	/* only Vangogh has fast PPT limit and power labels */
-	if (!(adev->asic_type == CHIP_VANGOGH) &&
+	if (!(gc_ver == IP_VERSION(10, 3, 1)) &&
 	    (attr == &sensor_dev_attr_power2_average.dev_attr.attr ||
-		 attr == &sensor_dev_attr_power2_cap_max.dev_attr.attr ||
+	     attr == &sensor_dev_attr_power2_cap_max.dev_attr.attr ||
 	     attr == &sensor_dev_attr_power2_cap_min.dev_attr.attr ||
-		 attr == &sensor_dev_attr_power2_cap.dev_attr.attr ||
-		 attr == &sensor_dev_attr_power2_cap_default.dev_attr.attr ||
-		 attr == &sensor_dev_attr_power2_label.dev_attr.attr))
+	     attr == &sensor_dev_attr_power2_cap.dev_attr.attr ||
+	     attr == &sensor_dev_attr_power2_cap_default.dev_attr.attr ||
+	     attr == &sensor_dev_attr_power2_label.dev_attr.attr))
 		return 0;
 
 	return effective_mode;
@@ -3421,6 +3425,8 @@ static void amdgpu_debugfs_prints_cpu_info(struct seq_file *m,
 
 static int amdgpu_debugfs_pm_info_pp(struct seq_file *m, struct amdgpu_device *adev)
 {
+	uint32_t mp1_ver = adev->ip_versions[MP1_HWIP][0];
+	uint32_t gc_ver = adev->ip_versions[GC_HWIP][0];
 	uint32_t value;
 	uint64_t value64 = 0;
 	uint32_t query = 0;
@@ -3467,7 +3473,7 @@ static int amdgpu_debugfs_pm_info_pp(struct seq_file *m, struct amdgpu_device *a
 	if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_ENABLED_SMC_FEATURES_MASK, (void *)&value64, &size))
 		seq_printf(m, "SMC Feature Mask: 0x%016llx\n", value64);
 
-	if (adev->asic_type > CHIP_VEGA20) {
+	if (gc_ver != IP_VERSION(9, 4, 0) && mp1_ver > IP_VERSION(9, 0, 0)) {
 		/* VCN clocks */
 		if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_VCN_POWER_STATE, (void *)&value, &size)) {
 			if (!value) {
-- 
2.25.1


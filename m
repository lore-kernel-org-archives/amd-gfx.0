Return-Path: <SRS0=AYlF=LA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47306C48BC2
	for <amd-gfx@archiver.kernel.org>; Sun,  6 Jun 2021 05:00:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB2DB608FC
	for <amd-gfx@archiver.kernel.org>; Sun,  6 Jun 2021 05:00:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB2DB608FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AACBD6E516;
	Sun,  6 Jun 2021 05:00:48 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0F8C6E514
 for <amd-gfx@lists.freedesktop.org>; Sun,  6 Jun 2021 05:00:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0EOHQa2owiyuDWtCHInG9KOuQtT1D3npjEa2/CXqzwU0gnp0SX6l/TEs3RRXGg/T3XVkJ9CcS+QdhBMc2mFE4p+WvCyVtX6oJU0fCLT+XZTLqm73dvkoh6K6tsEiyU4ryAPquB/ieMl5TmiL4muPNKqYcG1ag+bV6wraKIX2z/3qX6vU/+bM7i7CYIjeMtZ8La+sPU/j54ahKE2MG/lfYUKbbIJmkT2yC/seM40kkEWF/vyqQB3dk40tcRpisd1Z+Rwe9cHYZ2BJEEHOeAU5AB3V6t461PkWKE30WWaB30EbJ9yhGt24vvsyy212/FU02Iqy3Kfvnxj/DhQ+4BxFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vpz8IQBjzkp5ypRfX1LHNV7/2lVzsst43cZ3J7hbTE=;
 b=eYQPHNxvqf0XkyPG5js5pYXNDfihh+7bTc6d+HrhIve5cruaVZ037vLAopWtysh4ODRlDOHq504pGPKaKavui4vkbRG6Yp2QMwI8TbjC9q54cBfweUA/gT+gmci1a9XyIIaVQo3Wrzv4bN5nWVqPj1X0SOW7+X+9rC2Jdj3VdzPnavKLgfHgIn7gUokDd3bzggyIvI9LNESGIl0y13Mps2kwG47wpyf2wfNA5/bczhlBN/tMJVVfGAOst8qs3r5C+j/QV8qjB7G8wD9ygNucVPj4i+PlkuIl6RMcU5CnflYVyX43svj2N92JTMPyuN6yg4qcZ2fJdZxJcfr6XVOLPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vpz8IQBjzkp5ypRfX1LHNV7/2lVzsst43cZ3J7hbTE=;
 b=Hoz0ceoUuG6PIqcXnECGgMp3p87/+qR7Z3PXsIXmYoZMDlqlYKRUmzdvF/108cfaoGsu7Ekrqk36Lv1phbfVgRIrFfPTAgsec9KB1wZHvHteVSkj25YP8R1erJwrLC4vnLurQZ91tJioTVg+Jngv1TA5IQqnJayGyG1DUFC+omw=
Received: from MW4PR03CA0324.namprd03.prod.outlook.com (2603:10b6:303:dd::29)
 by DM5PR12MB1882.namprd12.prod.outlook.com (2603:10b6:3:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Sun, 6 Jun
 2021 05:00:46 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::46) by MW4PR03CA0324.outlook.office365.com
 (2603:10b6:303:dd::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20 via Frontend
 Transport; Sun, 6 Jun 2021 05:00:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Sun, 6 Jun 2021 05:00:45 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Sun, 6 Jun 2021 00:00:41 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/6] amdgpu/pm: clean up smu_get_power_limit function signature
Date: Sun, 6 Jun 2021 01:00:19 -0400
Message-ID: <20210606050023.4124-3-darren.powell@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210606050023.4124-1-darren.powell@amd.com>
References: <20210606050023.4124-1-darren.powell@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c75386b-32d2-4955-150d-08d928a80aff
X-MS-TrafficTypeDiagnostic: DM5PR12MB1882:
X-Microsoft-Antispam-PRVS: <DM5PR12MB188290974AF9539CF5A12F9CF0399@DM5PR12MB1882.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:158;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yJvcFO9PGGQ73/W6F9hGaOvoGsdUzzk5f8PU0bBQZUEeVrQo1WX3i+ju/VPorrKmfmz7iKHHLLgFc6jeY5O75zIWmHAFJr1lRRDXjoyI45BepYy0unphcgTSK5e90A02pm+noJizIW33pxZZS58DkEnb0XX/SGk0OHZD3ZJRkHW1cZ58rWsneMSeBSB+BgGpTya8GasEcL5KpthOdKRLo3t5/UhjosSughLmLmY2N+WKZ+FLX9Qr8GD8HA9+RrY7ukLR8IhBNeSkBYJ7kgFp9uA2tzPquVDhxL8vTejUmCf17fjpbeJ6VlP5aovrPYvtI//YTFf/x0Pru9FH3iJphZsvXAvB7lTyvrTLwl9N6+2xxvH8mZ5OX9AAAIUp49G9/KUcPr8kS0j+xGsJAPMrZoxmRngAqGxNZNVSyv0dQEMLhDhcQbH5dHlr6A2K/zXfezA9Xepv9Qf76fIoTEq+Tajfk+mVCWUR/FhssFsfdPb/JlonGdJbBslG+qOBYwfUXKqwiQ+ckvsTFRq81PNTi4DbzfAnvql8fmf5v4Hnh+j/vq4eUYWJqHjx/eg280zBEeIu8U5XVloNpMNUsHiLGGQoiPoD4PvT1qYQMlEVscvZvBT7n6ry8q+ib1EijNJ1o0Hys6z0JEd2LN+bafjJL7ym//TuSrLIg76piEVipkFPa1Gq5tkdED5GpjkIyDYx
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(46966006)(36840700001)(316002)(36860700001)(82310400003)(2906002)(2616005)(6916009)(16526019)(82740400003)(44832011)(70586007)(5660300002)(70206006)(426003)(4326008)(81166007)(26005)(8676002)(356005)(1076003)(8936002)(47076005)(6666004)(7696005)(478600001)(36756003)(186003)(336012)(83380400001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2021 05:00:45.2142 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c75386b-32d2-4955-150d-08d928a80aff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1882
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
Cc: Darren Powell <darren.powell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

 add two new powerplay enums (limit_level, type)
 add enums to smu_get_power_limit signature
 remove input bitfield stuffing of output variable limit
 update calls to smu_get_power_limit

* Test
 AMDGPU_PCI_ADDR=`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
 AMDGPU_HWMON=`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | cut -d " " -f 11`
 HWMON_DIR=/sys/class/hwmon/${AMDGPU_HWMON}

 lspci -nn | grep "VGA\|Display" ; \
 echo "=== power1 cap ===" ; cat $HWMON_DIR/power1_cap ;           \
 echo "=== power1 cap max ===" ; cat $HWMON_DIR/power1_cap_max ;   \
 echo "=== power1 cap def ===" ; cat $HWMON_DIR/power1_cap_default

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    | 14 ++++++++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 18 +++++-----
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  3 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 34 +++++++++++++++++--
 4 files changed, 57 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 7bc7492f37b9..6689164e62f2 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -194,6 +194,20 @@ enum pp_df_cstate {
 	DF_CSTATE_ALLOW,
 };
 
+enum pp_power_limit_level
+{
+	PP_PWR_LIMIT_MIN = -1,
+	PP_PWR_LIMIT_CURRENT,
+	PP_PWR_LIMIT_DEFAULT,
+	PP_PWR_LIMIT_MAX,
+};
+
+enum pp_power_type
+{
+	PP_PWR_TYPE_SUSTAINED,
+	PP_PWR_TYPE_FAST,
+};
+
 #define PP_GROUP_MASK        0xF0000000
 #define PP_GROUP_SHIFT       28
 
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 2e1286f6a2ad..c827f0ae5afa 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2907,8 +2907,8 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
 {
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int limit_type = to_sensor_dev_attr(attr)->index;
-	uint32_t limit = limit_type << 24;
+	enum pp_power_type power_type = to_sensor_dev_attr(attr)->index;
+	uint32_t limit;
 	uint32_t max_limit = 0;
 	ssize_t size;
 	int r;
@@ -2925,7 +2925,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
 	}
 
 	if (is_support_sw_smu(adev)) {
-		smu_get_power_limit(&adev->smu, &limit, SMU_PPT_LIMIT_MAX);
+		smu_get_power_limit(&adev->smu, &limit, PP_PWR_LIMIT_MAX, power_type);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
 	} else if (pp_funcs && pp_funcs->get_power_limit) {
 		pp_funcs->get_power_limit(adev->powerplay.pp_handle,
@@ -2947,8 +2947,8 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
 {
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int limit_type = to_sensor_dev_attr(attr)->index;
-	uint32_t limit = limit_type << 24;
+	enum pp_power_type power_type = to_sensor_dev_attr(attr)->index;
+	uint32_t limit;
 	ssize_t size;
 	int r;
 
@@ -2964,7 +2964,7 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
 	}
 
 	if (is_support_sw_smu(adev)) {
-		smu_get_power_limit(&adev->smu, &limit, SMU_PPT_LIMIT_CURRENT);
+		smu_get_power_limit(&adev->smu, &limit, PP_PWR_LIMIT_CURRENT, power_type);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
 	} else if (pp_funcs && pp_funcs->get_power_limit) {
 		pp_funcs->get_power_limit(adev->powerplay.pp_handle,
@@ -2986,8 +2986,8 @@ static ssize_t amdgpu_hwmon_show_power_cap_default(struct device *dev,
 {
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int limit_type = to_sensor_dev_attr(attr)->index;
-	uint32_t limit = limit_type << 24;
+	enum pp_power_type power_type = to_sensor_dev_attr(attr)->index;
+	uint32_t limit;
 	ssize_t size;
 	int r;
 
@@ -3003,7 +3003,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_default(struct device *dev,
 	}
 
 	if (is_support_sw_smu(adev)) {
-		smu_get_power_limit(&adev->smu, &limit, SMU_PPT_LIMIT_DEFAULT);
+		smu_get_power_limit(&adev->smu, &limit, PP_PWR_LIMIT_DEFAULT, power_type);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
 	} else if (pp_funcs && pp_funcs->get_power_limit) {
 		pp_funcs->get_power_limit(adev->powerplay.pp_handle,
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 71adb9e76a95..026d9b6d5ad3 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1264,7 +1264,8 @@ enum smu_cmn2asic_mapping_type {
 #if !defined(SWSMU_CODE_LAYER_L2) && !defined(SWSMU_CODE_LAYER_L3) && !defined(SWSMU_CODE_LAYER_L4)
 int smu_get_power_limit(struct smu_context *smu,
 			uint32_t *limit,
-			enum smu_ppt_limit_level limit_level);
+			enum pp_power_limit_level pp_limit_level,
+			enum pp_power_type pp_power_type);
 
 bool smu_mode1_reset_is_support(struct smu_context *smu);
 bool smu_mode2_reset_is_support(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 1b8321d12c8a..cfa680850887 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2175,14 +2175,44 @@ static int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
 
 int smu_get_power_limit(struct smu_context *smu,
 			uint32_t *limit,
-			enum smu_ppt_limit_level limit_level)
+			enum pp_power_limit_level pp_limit_level,
+			enum pp_power_type pp_power_type)
 {
-	uint32_t limit_type = *limit >> 24;
+	enum smu_ppt_limit_level limit_level;
+	uint32_t limit_type;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
+	switch(pp_power_type) {
+	case PP_PWR_TYPE_SUSTAINED:
+		limit_type = SMU_DEFAULT_PPT_LIMIT;
+		break;
+	case PP_PWR_TYPE_FAST:
+		limit_type = SMU_FAST_PPT_LIMIT;
+		break;
+	default:
+		return -EOPNOTSUPP;
+		break;
+	}
+
+	switch(pp_limit_level){
+	case PP_PWR_LIMIT_CURRENT:
+		limit_level = SMU_PPT_LIMIT_CURRENT;
+		break;
+	case PP_PWR_LIMIT_DEFAULT:
+		limit_level = SMU_PPT_LIMIT_DEFAULT;
+		break;
+	case PP_PWR_LIMIT_MAX:
+		limit_level = SMU_PPT_LIMIT_MAX;
+		break;
+	case PP_PWR_LIMIT_MIN:
+	default:
+		return -EOPNOTSUPP;
+		break;
+	}
+
 	mutex_lock(&smu->mutex);
 
 	if (limit_type != SMU_DEFAULT_PPT_LIMIT) {
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

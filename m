Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E572FC4708C
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 23:06:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A51F560FF0
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 23:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51F560FF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C3EC6F631;
	Fri, 28 May 2021 23:06:49 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2044.outbound.protection.outlook.com [40.107.96.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38D0A6F587
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 23:06:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHDEn3L/cdwuhsnmB5riNsoy0Td/jVtLUL3oZKAmOoWOpPbSdnEzAKcVzYQ28OxHKDBwGRWC3OBfBfdD0SF/AcKrJLcWtVagjchpBKfxJhgTBgrlbjV34x6d6L8IVzcf1XkYAq2XMYexOyFFgnT04vyej96jRKBbBm4JQpqVCxLj5kBrGQJTMEb/Dg02S8HIpvvn32W3VvetARD4XAgnut3glT6yUhnfxafIPfiLuTo4OX7IWHia9ZQ536hEqmABjJG7si6cX1fqpXkfrU05pMBVkgQp1oUFcSFGjwt9RBcGu9nBDn094iC45BGICjP5GjfxfUitB+E1bFUOeg3xZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwaZhk5E7fjkN/sYscaaDwfhjnDsdSS17IE+bT0muy8=;
 b=HvEeCgdx7o3PfjhCkCuSj5neZ91xDgUTvVrB+z1siIQk9/s+TRz7uK1riO83Ldq/Dy4Y5Pcf/2NcCUl1mXU/svIoAJxyy+j0svvd6mWjRUSF5JIipoLsDCBdyakKb+S74bFTE/XjgywvIuqoni0Veht9qG+fQxwkubpnc1nhzz3lzxsIW6HukOjE5jxo4vdN4+CG/Oq5LUly+Z0e0pQAOOKzGJ79IKuDytBgNSCiFo/ITdfYcjI+B1iaKIgYE2iB5L/9U75Rae6an/842jihCjBeElyfzdo/YFrG5yJc69JGeU3RPLweiK3aLAg5+DmMQsYMOmgDX5AACoErua2mRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwaZhk5E7fjkN/sYscaaDwfhjnDsdSS17IE+bT0muy8=;
 b=X7Az6hK1RCBoh6glrpuZevL3S/hp9S95LPKGRd9/wElX1XC598mQjTvTlVVW57lnN9AmGxZq5C4Xf/GTKXjk0giudTNxJbmXguvp8flkzPFSfvlsHfiy8x08r0/Y1/ax9fU3f5trUa8exb+1xD2beQFFou+urKgpg+H9oKhBumo=
Received: from MWHPR04CA0053.namprd04.prod.outlook.com (2603:10b6:300:6c::15)
 by MN2PR12MB2944.namprd12.prod.outlook.com (2603:10b6:208:ae::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Fri, 28 May
 2021 23:06:39 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:6c:cafe::b0) by MWHPR04CA0053.outlook.office365.com
 (2603:10b6:300:6c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Fri, 28 May 2021 23:06:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Fri, 28 May 2021 23:06:39 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 28 May 2021 18:06:37 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/6] amdgpu/pm: clean up smu_get_power_limit function signature
Date: Fri, 28 May 2021 19:06:17 -0400
Message-ID: <20210528230621.16468-3-darren.powell@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210528230621.16468-1-darren.powell@amd.com>
References: <20210528230621.16468-1-darren.powell@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad708ced-a691-43e2-9730-08d9222d4042
X-MS-TrafficTypeDiagnostic: MN2PR12MB2944:
X-Microsoft-Antispam-PRVS: <MN2PR12MB2944E1FB7C0236EDAA974477F0229@MN2PR12MB2944.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:158;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dW/9MuRHYLR5OepUj4ixvHw5ek9J1W41WkOOlr4hi6QqhSsAt3vvbsULLWcwsJLRzARr9dLNcMJE++9ymrfUjDIMKugM6PXt9INerDlVpwfE+9V+t6mETaORmqHnKYJeXR2KW7oDmzC36RmsI0G/2T1vXOzqw7R+Plouh66RY1h7jJHWt3oPY0CPwi/eXLwcxJc6gJjeqiZ6XxIOd7e9np5KY9pIE9ZUzgJXg4hfqyrIjwtKH/l9rpTVELBbOWYNJI4yOUyIROxUYiIGUd0Z6ri62TpJD9xVSsK2xZ/E/4ySb8Uzp/EJMLB5Ab9KrhywZs875kqtzwf664fw548vblES17qcjtQlbjYAFGtpL6EPiKDPXmpmD99Co/Arz4qNV+oCNyRXbdoUVkVilCeUHAbztXorCXWV2CJg+NImIWNakW76n6zvS+sC2zdkBI959wqq3ampUe0UwML9bD9+dq+dZKkwcaNZWmhm+zDSPBMAqmHdZ4NRikFYX5WGiTZ5Ir7Ap3noNjZzpWhxR5/5M6Go+Kdqq97G8ty99rcOQJ2Rk/XPJh23ZkBp52kHVixjClIgwF3nfOZ8MprtlqZSe/5m1mcIvX4FkNPHhtg1k7YIo0JROtykKtxT/soIpGXoT/NchYZHZPZJ4UZNEcW+jnI7ORA+sozTZtAyDssm81BDB6VKlJ5nH7idlWFWdBre
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(376002)(136003)(36840700001)(46966006)(36860700001)(426003)(6916009)(4326008)(6666004)(478600001)(2906002)(47076005)(8936002)(8676002)(7696005)(316002)(82310400003)(86362001)(356005)(1076003)(82740400003)(16526019)(186003)(81166007)(70206006)(2616005)(70586007)(83380400001)(336012)(5660300002)(36756003)(44832011)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 23:06:39.4965 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad708ced-a691-43e2-9730-08d9222d4042
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2944
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

 add two new powerplay enums (limit_level, sample_window)
 add enums to smu_get_power_limit signature
 remove input bitfield stuffing of output variable limit
 update calls to smu_get_power_limit

* Test
 AMDGPU_PCI_ADDR=`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
 AMDGPU_HWMON=`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | cut -d " " -f 10`
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
index b1cd52a9d684..ddbf802ea8ad 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -192,6 +192,20 @@ enum pp_df_cstate {
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
+ enum pp_power_sample_window
+{
+	PP_PWR_WINDOW_DEFAULT,
+	PP_PWR_WINDOW_FAST,
+};
+
 #define PP_GROUP_MASK        0xF0000000
 #define PP_GROUP_SHIFT       28
 
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 13da377888d2..f7b45803431d 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2717,8 +2717,8 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
 {
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int limit_type = to_sensor_dev_attr(attr)->index;
-	uint32_t limit = limit_type << 24;
+	enum pp_power_sample_window sample_window = to_sensor_dev_attr(attr)->index;
+	uint32_t limit;
 	uint32_t max_limit = 0;
 	ssize_t size;
 	int r;
@@ -2735,7 +2735,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
 	}
 
 	if (is_support_sw_smu(adev)) {
-		smu_get_power_limit(&adev->smu, &limit, SMU_PPT_LIMIT_MAX);
+		smu_get_power_limit(&adev->smu, &limit, PP_PWR_LIMIT_MAX, sample_window);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
 	} else if (pp_funcs && pp_funcs->get_power_limit) {
 		pp_funcs->get_power_limit(adev->powerplay.pp_handle,
@@ -2757,8 +2757,8 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
 {
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int limit_type = to_sensor_dev_attr(attr)->index;
-	uint32_t limit = limit_type << 24;
+	enum pp_power_sample_window sample_window = to_sensor_dev_attr(attr)->index;
+	uint32_t limit;
 	ssize_t size;
 	int r;
 
@@ -2774,7 +2774,7 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
 	}
 
 	if (is_support_sw_smu(adev)) {
-		smu_get_power_limit(&adev->smu, &limit, SMU_PPT_LIMIT_CURRENT);
+		smu_get_power_limit(&adev->smu, &limit, PP_PWR_LIMIT_CURRENT, sample_window);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
 	} else if (pp_funcs && pp_funcs->get_power_limit) {
 		pp_funcs->get_power_limit(adev->powerplay.pp_handle,
@@ -2796,8 +2796,8 @@ static ssize_t amdgpu_hwmon_show_power_cap_default(struct device *dev,
 {
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int limit_type = to_sensor_dev_attr(attr)->index;
-	uint32_t limit = limit_type << 24;
+	enum pp_power_sample_window sample_window = to_sensor_dev_attr(attr)->index;
+	uint32_t limit;
 	ssize_t size;
 	int r;
 
@@ -2813,7 +2813,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_default(struct device *dev,
 	}
 
 	if (is_support_sw_smu(adev)) {
-		smu_get_power_limit(&adev->smu, &limit, SMU_PPT_LIMIT_DEFAULT);
+		smu_get_power_limit(&adev->smu, &limit, PP_PWR_LIMIT_DEFAULT, sample_window);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
 	} else if (pp_funcs && pp_funcs->get_power_limit) {
 		pp_funcs->get_power_limit(adev->powerplay.pp_handle,
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 523f9d2982e9..b97b960c2eac 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1262,7 +1262,8 @@ enum smu_cmn2asic_mapping_type {
 #if !defined(SWSMU_CODE_LAYER_L2) && !defined(SWSMU_CODE_LAYER_L3) && !defined(SWSMU_CODE_LAYER_L4)
 int smu_get_power_limit(struct smu_context *smu,
 			uint32_t *limit,
-			enum smu_ppt_limit_level limit_level);
+			enum pp_power_limit_level pp_limit_level,
+			enum pp_power_sample_window sample_window);
 
 bool smu_mode1_reset_is_support(struct smu_context *smu);
 bool smu_mode2_reset_is_support(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 8aff67a667fa..44c1baa2748d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2168,14 +2168,44 @@ static int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
 
 int smu_get_power_limit(struct smu_context *smu,
 			uint32_t *limit,
-			enum smu_ppt_limit_level limit_level)
+			enum pp_power_limit_level pp_limit_level,
+			enum pp_power_sample_window sample_window)
 {
-	uint32_t limit_type = *limit >> 24;
+	enum smu_ppt_limit_level limit_level;
+	uint32_t limit_type;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
+	switch(sample_window) {
+	case PP_PWR_WINDOW_DEFAULT:
+		limit_type = SMU_DEFAULT_PPT_LIMIT;
+		break;
+	case PP_PWR_WINDOW_FAST:
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
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

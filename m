Return-Path: <SRS0=Yti/=P5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA45C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 06:23:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1F97610CF
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 06:23:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B1F97610CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C8686E424;
	Wed, 10 Nov 2021 06:23:54 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38F486E041
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Nov 2021 06:23:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dL+b6seIHffJnKvFUwpkQjC6rsPGAOppdshGfkFmci8psO2e3SmHbGEWjFwDms7WGSL3fB/bVMDZzWG+gxl4daj20DS2sl9YC08VPEl4SHemMi6+NpjM1jD0noUQmnwv/x6xpVwp2TWcPJFdp0k/DQb5+ugKf35su5qdkVpsvjdiV4EtP0HoFTnyqcFO3MvgxKeSBzG73uhfOFrHjMxoXgJlAktC+ePVkiAN3+kqTHlZruy4RxFtTWsTGqCXUUVE7HgRryu1BTZWyktqCfFdV5g6Oza3XtlOgyEJTQM1NnoFlQh2DdAM24KoTrysC5rho2gGBygXIxaMBWjRlolvnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZ5TNNvm1h6UEYAEqEPGjNRYEdLO9/WsuCihYL19dV0=;
 b=Vi8ejGDlUdrqByAKV2WHxNBnxlEzKptGp/oO9KBsPqlThMapNvQhi2+wq4Qxinzcvc6R7eM+8/+7V6RnVaTlLwVU/TKOW8nvlvAYQHPe2qzxhKeKCxxKdutyz6Tp+W+QKebuiRaAuVSzfdrat9J49fwivjqyOFNxuRu59vofsXVrBD/CxzIXjC41v8seZ49Z4x3jPkzLjhJgFk1OLOy1vWz2Qb07LTWzTQjwaDMg5qV9G0jIppx01DdZ1HwKGLIH9neBirX8EH9oU40DDxBbuCf2rZtjAa18gDErYepbIzzYfjfvf8xL5LpcvqJhgOV5QXM+snbwpRbTT21mJO50Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZ5TNNvm1h6UEYAEqEPGjNRYEdLO9/WsuCihYL19dV0=;
 b=XNLjI+5DLTu8fhmH3uuQxB1JxzjRnplsRSTtqRz4ipnemn9NOYTbF5Gbt196UgFIOmB4mw5oEMX/mhOBeUXgmdOechOEuIKBhowvd4cHY4lKvS5pP55PsHiVyQee8ZiLqS+xLTCwk14Ru5QH/Zod/n2emjIOiKd8Flm8TGYcFPY=
Received: from BN9P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::9)
 by CY4PR12MB1176.namprd12.prod.outlook.com (2603:10b6:903:38::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Wed, 10 Nov
 2021 06:23:49 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::ce) by BN9P222CA0004.outlook.office365.com
 (2603:10b6:408:10c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13 via Frontend
 Transport; Wed, 10 Nov 2021 06:23:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 06:23:49 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 10 Nov
 2021 00:23:48 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [RFC 2/2] drm/amd/pm: Add support for reacting to platform profile
 notification
Date: Wed, 10 Nov 2021 00:23:43 -0600
Message-ID: <20211110062343.10041-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211110062343.10041-1-mario.limonciello@amd.com>
References: <20211110062343.10041-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a3e62df-055f-4346-c2ec-08d9a412a8ad
X-MS-TrafficTypeDiagnostic: CY4PR12MB1176:
X-Microsoft-Antispam-PRVS: <CY4PR12MB11768050E0DD4C6569DEDA23E2939@CY4PR12MB1176.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:475;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r1eIp4eUfNPECDlPnbV2ZK8CsTiDQ/DrPk0xIRTAF6BIHFKTeLj4I51QvT/j1UIy3Jb0W+8146yhmjCp/Wsr4UL8NzxI/XgdiS1+Myj6/rW+1y8Vd68sKp3k0cmlNJ2UzFkJdqYw0kAAmtpp2RmgR29448A4lbR9JhywrXGOsBn6LwChNABFmwcL2emiyvPUAqSExJTu75Q/rgtsdWdk0ENDtsGbjOqvZ3nNZYFWGlO3a5uQ+I23E45vz4bNsHDfznNH7I0wzUsGExexauMXMmMjp1RCQSZUXhHjltEchw2tI5ONDPcux4ExqjPr7nxnT4r3ek0umdKkOHn5mzs3/G1oYQraAHE3EJ66GHDgrlMYnVavR3ALCXwsA5fXMCizili+vwKrTsUpknaTKLLXyC3QgmdkZmQFxH+Bn8oxILmD4UMd0F/QcKnS3i6PL1wMLNw9HI6/6qe/f1kHajxgZGs4VPGw26ZdKSiBkl6J9ma2VaRXYCa91oyjJfTZF2wXMIU24gDMiRSCRV2jXQpOrfgmkVg+OIyhHpxxkCs9JL0yFY9oynO+i/7HLSnTum9v03wCTScYxDcVZNno85fHs2Zmx+8HghQuxGTx5rs5nkNUdLRlJs/UGh/F3osZMXnYHsthWKa/d4eJm5sTlHr3s4wkFzlcqhqhxTDYoLfz9dI4FL83KOmnn2k6l5WJqVs0b2UP3Pp/s2OwKg7+T5q9R4gg0SMDsw+w9YPk5qLi51Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(26005)(186003)(16526019)(47076005)(81166007)(36756003)(70586007)(7696005)(15650500001)(356005)(1076003)(316002)(8936002)(83380400001)(6666004)(82310400003)(86362001)(4326008)(70206006)(8676002)(5660300002)(426003)(6916009)(2616005)(2906002)(336012)(44832011)(508600001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 06:23:49.5532 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3e62df-055f-4346-c2ec-08d9a412a8ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1176
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Various drivers provide platform profile support to let users set a hint
in their GUI whether they want to run in a high performance, low battery
life or balanced configuration.

Drivers that provide this typically work with the firmware on their system
to configure hardware.  In the case of AMDGPU however, the notification
path doesn't come through firmware and can instead be provided directly
to the driver from a notification chain.

Use the information of the newly selected profile to tweak
`dpm_force_performance_level` to that profile IFF the user hasn't manually
selected `manual` or any other `profile_*` options.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h |   3 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c  | 105 +++++++++++++++++++++++-----
 2 files changed, 90 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index b85b67a88a3d..27b0be23b6ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1097,6 +1097,9 @@ struct amdgpu_device {
 
 	struct amdgpu_reset_control     *reset_cntl;
 	uint32_t                        ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE];
+
+	/* platform profile notifications */
+	struct notifier_block		platform_profile_notifier;
 };
 
 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 41472ed99253..33fc52b90d4c 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -32,6 +32,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/nospec.h>
+#include <linux/platform_profile.h>
 #include <linux/pm_runtime.h>
 #include <asm/processor.h>
 #include "hwmgr.h"
@@ -200,6 +201,33 @@ static ssize_t amdgpu_set_power_dpm_state(struct device *dev,
 	return count;
 }
 
+static int amdgpu_get_forced_level(struct device *dev, enum amd_dpm_forced_level *level)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	int ret;
+
+	if (amdgpu_in_reset(adev))
+		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
+
+	ret = pm_runtime_get_sync(ddev->dev);
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(ddev->dev);
+		return ret;
+	}
+
+	if (adev->powerplay.pp_funcs->get_performance_level)
+		*level = amdgpu_dpm_get_performance_level(adev);
+	else
+		*level = adev->pm.dpm.forced_level;
+
+	pm_runtime_mark_last_busy(ddev->dev);
+	pm_runtime_put_autosuspend(ddev->dev);
+
+	return 0;
+}
 
 /**
  * DOC: power_dpm_force_performance_level
@@ -264,29 +292,13 @@ static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
 							    struct device_attribute *attr,
 							    char *buf)
 {
-	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_to_adev(ddev);
 	enum amd_dpm_forced_level level = 0xff;
 	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
+	ret = amdgpu_get_forced_level(dev, &level);
 
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
+	if (ret < 0)
 		return ret;
-	}
-
-	if (adev->powerplay.pp_funcs->get_performance_level)
-		level = amdgpu_dpm_get_performance_level(adev);
-	else
-		level = adev->pm.dpm.forced_level;
-
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
 
 	return sysfs_emit(buf, "%s\n",
 			  (level == AMD_DPM_FORCED_LEVEL_AUTO) ? "auto" :
@@ -405,6 +417,59 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 	return count;
 }
 
+static void amdgpu_update_profile(struct device *dev, enum platform_profile_option *profile)
+{
+	enum amd_dpm_forced_level level;
+	const char *str;
+	int ret;
+
+	ret = amdgpu_get_forced_level(dev, &level);
+	if (ret < 0)
+		return;
+
+	/* only update profile if we're in fixed modes right now that need updating */
+	switch (level) {
+	case AMD_DPM_FORCED_LEVEL_LOW:
+		if (*profile < PLATFORM_PROFILE_BALANCED)
+			return;
+		break;
+	case AMD_DPM_FORCED_LEVEL_HIGH:
+		if (*profile > PLATFORM_PROFILE_BALANCED)
+			return;
+		break;
+	case AMD_DPM_FORCED_LEVEL_AUTO:
+		if (*profile == PLATFORM_PROFILE_BALANCED)
+			return;
+		break;
+	default:
+		dev_dbg(dev, "refusing to update amdgpu profile from %d\n", level);
+		return;
+	}
+	if (*profile > PLATFORM_PROFILE_BALANCED)
+		str = "high";
+	else if (*profile < PLATFORM_PROFILE_BALANCED)
+		str = "low";
+	else
+		str = "auto";
+
+	dev_dbg(dev, "updating platform profile to %s\n", str);
+	amdgpu_set_power_dpm_force_performance_level(dev, NULL, str, 0);
+}
+
+static int amdgpu_platform_profile_notifier_call(struct notifier_block *nb,
+						  unsigned long action, void *data)
+{
+	if (action == PLATFORM_PROFILE_CHANGED) {
+		enum platform_profile_option *profile = data;
+		struct amdgpu_device *adev;
+
+		adev = container_of(nb, struct amdgpu_device, platform_profile_notifier);
+		amdgpu_update_profile(adev->dev, profile);
+	}
+
+	return NOTIFY_OK;
+}
+
 static ssize_t amdgpu_get_pp_num_states(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
@@ -3506,6 +3571,9 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 	if (ret)
 		return ret;
 
+	adev->platform_profile_notifier.notifier_call = amdgpu_platform_profile_notifier_call;
+	platform_profile_register_notifier(&adev->platform_profile_notifier);
+
 	adev->pm.sysfs_initialized = true;
 
 	return 0;
@@ -3519,6 +3587,7 @@ void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev)
 	if (adev->pm.int_hwmon_dev)
 		hwmon_device_unregister(adev->pm.int_hwmon_dev);
 
+	platform_profile_unregister_notifier(&adev->platform_profile_notifier);
 	amdgpu_device_attr_remove_groups(adev, &adev->pm.pm_attr_list);
 }
 
-- 
2.25.1


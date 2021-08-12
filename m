Return-Path: <SRS0=1H3f=ND=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110EBC4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 09:33:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C08DD6056B
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 09:33:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C08DD6056B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FDB86E3BB;
	Thu, 12 Aug 2021 09:33:36 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 138616E3B2
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Aug 2021 09:33:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zf3vxjyHDu+aE6ihinLg4+yyoWGUMPEsnDgAkqjAPK0U3K39iekyfFCSuLUv/b8p24AWQgfkc8u8FFPMfSeBSbrODsNUuhG5p20wZyQGSb8KiFqmNECXsCWDRgi+qBAfgjgiC4HAc4Ke2VSy0DdJllVRIaB6tGOsdaI6kJZQ60+W0RUIRQh0r7WJvKR1sjgojwZZI5onBE5u4F8+3nmREjW+LliUcaFr767A6qzI+e/oB0/zJLnUt2UG3uBR/gvRVT5Esjv4lMIwn80qy1IEvKj8+6rleZvF85dkjVwrQu3w7VG6m/Y6l+ag5K/utrAgYuPwDBv6NiQsJ4k+omG2KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8c4Ia/gPO1b49QgWtMOWtvBTGTXDgyt+8yI0U1yPgZ8=;
 b=DNsQX0AYoRkGJHkWAxZ7ZMOjktxTzqo6fKxVp0wnM232cFkc8EqMHtVfUUFh0jlxdqlHrep2spezaAj/MxDEhSKEQKKfvMS9HMwmUEhpxwei6YCqGOF5/O9XXKD82YCXCoJlD1TFE17K77yAkC8Nx2d+eSdVpP/tlAMEkXTXJrt1/0l+arf71zXAamoz81hzegu/8L/sKEnnksUFYxJcctiqFpMHZip54PTkElPF9GkeEmRIZhhKhTGcKnwxNeBkp7TS3mSnjc3WHmZ3tbp5y5AYTsfBIPIj4q4i2EtOzc5bGCZQSQ6fFdYBRW6vkhbMGgnREqO2ZTEC00rpIfJyQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8c4Ia/gPO1b49QgWtMOWtvBTGTXDgyt+8yI0U1yPgZ8=;
 b=LYMh43dWX5m58wafGmMlDF88+MjAhMxGBkSz1kE5RFbXl/a8Um/YYLJLfi/znLbg8bbrzTjOI8YlFRupW2399DePo+GPGmWuQ94A75JH4otnmQJed65/i9Xh7OYSBdqLdh43kkHwKhkJQ58ns1DXnF/Bgo1R1mdKVzXb0shR8uI=
Received: from MWHPR19CA0090.namprd19.prod.outlook.com (2603:10b6:320:1f::28)
 by SN1PR12MB2415.namprd12.prod.outlook.com (2603:10b6:802:26::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Thu, 12 Aug
 2021 09:33:31 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:320:1f:cafe::e3) by MWHPR19CA0090.outlook.office365.com
 (2603:10b6:320:1f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16 via Frontend
 Transport; Thu, 12 Aug 2021 09:33:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.16 via Frontend Transport; Thu, 12 Aug 2021 09:33:31 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 12 Aug
 2021 04:33:28 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <nils.wallmenius@gmail.com>, <Lijo.Lazar@amd.com>, <Guchun.Chen@amd.com>, 
 Evan Quan <evan.quan@amd.com>
Subject: [PATCH V3 2/7] drm/amd/pm: record the RPM and PWM based fan speed
 settings
Date: Thu, 12 Aug 2021 17:33:03 +0800
Message-ID: <20210812093308.1322342-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210812093308.1322342-1-evan.quan@amd.com>
References: <20210812093308.1322342-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d60f7f58-1895-46d0-53ff-08d95d743f76
X-MS-TrafficTypeDiagnostic: SN1PR12MB2415:
X-Microsoft-Antispam-PRVS: <SN1PR12MB241515197CFB28FC571F1B34E4F99@SN1PR12MB2415.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 11b5pz3Q/DmexPALbb+rxoZsXDiXuiq4OZPnKc71DvYREp4wP193XJgy+by0wMxXdjNr7GmyQ6XkcjrNvQDfiqNPWq7BerYF8yqodtuX99vcFzDy06djbW8+/G2zcAdGtjPSETDfY9yqFcnoDNMA60ROCfdQR2V0+ikoI5Pq7WJdZOYQc8zkp3Ic8XO/RDxs+3O2U0SRDFBykJfQCQkidXFlPRazmjkTAT7iA73R5cX/oast2x4CGXItkGi/Dyt7HKMbBsR5gfN0b4ySwsouflq/K2Tk3y6ieiNPbLGJG/7dbcVi9+WPAH6tDCSpMSnIItBQ6TBBR79jlCZ/fEdtoe1Ulmj8WwVQBclO8yXQOObnWaXAdyiL1iCO6CgJGkoCeB/QS4/4PWOVjgNiv9pk5btb+JM8OFQYgJWqAMAP9B7emJEdMGBMSyU7RApkWw622Wm9UZMJ9grBiCj2Fi4xaCTNW/9IC9DuHmvV6uvisgsXOqO30LTKGVZM68flvIGdM7KSdDETldA5OA8Dsxur4gkq9CbROUFONB0wb15HCMUlLCNozt3WMRlxf4N1wNyAOC2iroOsoXWYsw8SFwi2Z5C0hKdJAjCrtl4ubWKMwAnuY0Xaxu9BRhaw/fsRz+JjR/Eu8MKp+cnrOdSxhTaKTuv5nN9W3N40Sn1E1vu96n0dSPFf3cQoMEx3WwgfF1sw5NG/ZMAHGNGkyEifUQAHQfwH5rbcj/VClo2vT/hqtQNXTdcaWusR6lnpP0KyLCplBaz+08P6qHEhpAI4WpZI3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(7696005)(47076005)(2906002)(36756003)(4326008)(36860700001)(16526019)(6916009)(54906003)(44832011)(2616005)(508600001)(1076003)(186003)(83380400001)(5660300002)(316002)(8936002)(336012)(6666004)(426003)(8676002)(86362001)(70586007)(26005)(70206006)(34020700004)(81166007)(82310400003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 09:33:31.0375 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d60f7f58-1895-46d0-53ff-08d95d743f76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2415
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As the relationship "PWM = RPM / smu->fan_max_rpm" between fan speed
PWM and RPM is not true for SMU11 ASICs. So, both the RPM and PWM
settings need to be saved.

Change-Id: I318c134d442273d518b805339cdf383e151b935d
Signed-off-by: Evan Quan <evan.quan@amd.com>
--
v1->v2:
  - coding style and logging prints optimization (Guchun)
  - reuse existing flags (Lijo)
v2->v3:
  - disallow fan speed setting via PWM and RPM at the same time (Lijo)
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c        |  3 +++
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   |  3 +++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 30 ++++++++++++++++++-----
 3 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 04c7d82f8b89..112ee5f5d855 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3174,6 +3174,9 @@ static ssize_t amdgpu_hwmon_show_mclk_label(struct device *dev,
  *
  * - fan[1-\*]_enable: Enable or disable the sensors.1: Enable 0: Disable
  *
+ * NOTE: DO NOT set the fan speed via "pwm1" and "fan[1-\*]_target" interfaces at the same time.
+ *       That will get the former one overridden.
+ *
  * hwmon interfaces for GPU clocks:
  *
  * - freq1_input: the gfx/compute clock in hertz
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 183654f8b564..29934a5af44e 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -34,6 +34,8 @@
 #define SMU_FW_NAME_LEN			0x24
 
 #define SMU_DPM_USER_PROFILE_RESTORE (1 << 0)
+#define SMU_CUSTOM_FAN_SPEED_RPM     (1 << 1)
+#define SMU_CUSTOM_FAN_SPEED_PWM     (1 << 2)
 
 // Power Throttlers
 #define SMU_THROTTLER_PPT0_BIT			0
@@ -230,6 +232,7 @@ struct smu_user_dpm_profile {
 	uint32_t fan_mode;
 	uint32_t power_limit;
 	uint32_t fan_speed_percent;
+	uint32_t fan_speed_rpm;
 	uint32_t flags;
 	uint32_t user_od;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index e33e67310030..39390bbb79e8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -413,7 +413,13 @@ static void smu_restore_dpm_user_profile(struct smu_context *smu)
 		if (!ret && smu->user_dpm_profile.fan_speed_percent) {
 			ret = smu_set_fan_speed_percent(smu, smu->user_dpm_profile.fan_speed_percent);
 			if (ret)
-				dev_err(smu->adev->dev, "Failed to set manual fan speed\n");
+				dev_err(smu->adev->dev, "Failed to set manual fan speed in percent\n");
+		}
+
+		if (!ret && smu->user_dpm_profile.fan_speed_rpm) {
+			ret = smu_set_fan_speed_rpm(smu, smu->user_dpm_profile.fan_speed_rpm);
+			if (ret)
+				dev_err(smu->adev->dev, "Failed to set manual fan speed in rpm\n");
 		}
 	}
 
@@ -2179,7 +2185,6 @@ static int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled)
 static int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
 {
 	struct smu_context *smu = handle;
-	u32 percent;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -2190,8 +2195,12 @@ static int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
 	if (smu->ppt_funcs->set_fan_speed_rpm) {
 		ret = smu->ppt_funcs->set_fan_speed_rpm(smu, speed);
 		if (!ret && smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE) {
-			percent = speed * 100 / smu->fan_max_rpm;
-			smu->user_dpm_profile.fan_speed_percent = percent;
+			smu->user_dpm_profile.flags |= SMU_CUSTOM_FAN_SPEED_RPM;
+			smu->user_dpm_profile.fan_speed_rpm = speed;
+
+			/* Override custom PWM setting as they cannot co-exist */
+			smu->user_dpm_profile.flags &= ~SMU_CUSTOM_FAN_SPEED_PWM;
+			smu->user_dpm_profile.fan_speed_percent = 0;
 		}
 	}
 
@@ -2552,8 +2561,11 @@ static int smu_set_fan_control_mode(struct smu_context *smu, int value)
 
 	/* reset user dpm fan speed */
 	if (!ret && value != AMD_FAN_CTRL_MANUAL &&
-			!(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE))
+			!(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
 		smu->user_dpm_profile.fan_speed_percent = 0;
+		smu->user_dpm_profile.fan_speed_rpm = 0;
+		smu->user_dpm_profile.flags &= ~(SMU_CUSTOM_FAN_SPEED_RPM | SMU_CUSTOM_FAN_SPEED_PWM);
+	}
 
 	return ret;
 }
@@ -2604,8 +2616,14 @@ static int smu_set_fan_speed_percent(void *handle, u32 speed)
 		if (speed > 100)
 			speed = 100;
 		ret = smu->ppt_funcs->set_fan_speed_percent(smu, speed);
-		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE))
+		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
+			smu->user_dpm_profile.flags |= SMU_CUSTOM_FAN_SPEED_PWM;
 			smu->user_dpm_profile.fan_speed_percent = speed;
+
+			/* Override custom RPM setting as they cannot co-exist */
+			smu->user_dpm_profile.flags &= ~SMU_CUSTOM_FAN_SPEED_RPM;
+			smu->user_dpm_profile.fan_speed_rpm = 0;
+		}
 	}
 
 	mutex_unlock(&smu->mutex);
-- 
2.29.0


Return-Path: <SRS0=1H3f=ND=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6671FC4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 04:01:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 210116101E
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 04:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 210116101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31AD56E23F;
	Thu, 12 Aug 2021 04:01:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DE9F6E23D
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Aug 2021 04:01:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ju44WbTm4CryrIT9C6tVxOlCNV931clseLTC8JlIEYRbOfEHe5QH1qtKMO+4mxD3R+nVfalPGIuK28xlAa0ugqZO9PU94L8oVQsaE+Dm4nFb9UujKDastVUsGVDEmXMh/xoFid/uCUMwgecVJIYpCIxDOSoBHoGezcaTHWn2tI9oZPFyn0Y138qM8WKzjfcpHb50qsBhrhH4/nvgTcU2qTD2m7NFRrgJ5tcQXlFVTBULpia1fejit5EkRoq9BJxK59lvTVqYzfmMN8P8J8fWdfzzwTDSIwNV8CF6YXWTshMoIPcmg+Cv9BjM1hMM0pqz3ykEosbi5w1XegKh3ArgjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7l+jmj3SEMK8qrXz85dZjarySXmc/QUMsgHZxjS/Cpc=;
 b=eeONhInsAr7Xf+GSkMjcLZ0cmSzY2+pJQVksVJEfbpbUJafaP7GQ8yQljNA9hVTQyXkT3OklDyn6o2o3kEpYLjSYZFfDX7Upo+RRtof6+N3kIVkNmLgeYCZL0gTW/3QkK6NMLcFxhU1ZRVrvPNwp1vwdNl7YggL+ReRLp0h/u+TCaGkFgTTNF8/TWFFcucgz6rwta+IBhvHe5QlMhLA5p/IWinFKqWtHr5U/10cqCx7RCxdbXKfSUPhD+wteqkkCGuqg9LA9b7LM13YCLq2uY5a1TbWNfb13lYA5nQrmc878IgJ0nvX3+NZd5aWfie/SL9LOETA4Luo1Pkua4h7kjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7l+jmj3SEMK8qrXz85dZjarySXmc/QUMsgHZxjS/Cpc=;
 b=LbfbsGnxQcI9hHtZSxz77mSAsNe9wlhsxIeykqidxWV/zjno+/PQLe/HiUpWheKgHutXvB0bNYqxwDJPOHtEv9XekVU4zXWmQSwvnbhhIxzQ7T1qulR65LbheabV7zXE4VN8shE9ZVEvq2RmK/rzfWw0UPNH9AqR7XrWsuCR0cc=
Received: from BN6PR19CA0115.namprd19.prod.outlook.com (2603:10b6:404:a0::29)
 by MN2PR12MB3247.namprd12.prod.outlook.com (2603:10b6:208:ad::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Thu, 12 Aug
 2021 04:01:37 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:a0:cafe::d5) by BN6PR19CA0115.outlook.office365.com
 (2603:10b6:404:a0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend
 Transport; Thu, 12 Aug 2021 04:01:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.14 via Frontend Transport; Thu, 12 Aug 2021 04:01:37 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 11 Aug
 2021 23:01:35 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <nils.wallmenius@gmail.com>, <Lijo.Lazar@amd.com>, <Guchun.Chen@amd.com>, 
 Evan Quan <evan.quan@amd.com>
Subject: [PATCH V2 2/7] drm/amd/pm: record the RPM and PWM based fan speed
 settings
Date: Thu, 12 Aug 2021 12:01:05 +0800
Message-ID: <20210812040110.1293682-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210812040110.1293682-1-evan.quan@amd.com>
References: <20210812040110.1293682-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 959681db-d7d6-42ec-099b-08d95d45e212
X-MS-TrafficTypeDiagnostic: MN2PR12MB3247:
X-Microsoft-Antispam-PRVS: <MN2PR12MB32476CFA934CDD0B83C7DE9EE4F99@MN2PR12MB3247.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ceaXOE8LeeEiQooyJv+O92bpL3ZFaWSXqxs2fd/lzlVbJS/orUA0OeUp7+w7H85GtrdViD+usvqU8vTUS5ZNC+38YTUc/oZpwCOTKOvOjn2w/mHW9BAR2qa5HgASHZ1r6MCAFMBJcBaz6yF0cvpC7l5JEPtnBd4ZLE5wZ5YrVtu8t88PAYy1xPY2Sn/KgNp6E25xq/3Ab/B17cNAXIDmJimdTv4zbigYOEzbqxyfv6Wu/73srVvcPNbrbhGDTM0JW36rMwT/y59J/StTt4KAg24kvbjUZoz79V9c8v5JLXVgsN82sCgV/bq90EWuqSvgZ9T6yDzzqnQyi3zvsXhfECDqmZd07ybaKbZhXp+z/ePUKvfk2aC0pIfgGYCO/CgLBcmHO60RRnJi6F3G+BLYCjLLH4VEOh28x+N4RPVuMDdRY3rFiBtNFf92IxaouHcoJsBDK4iOpQLu8ofvKHC+0c4yszW8bjb1wTz2aYs3MOoXbT2nZB/TFOtYy6EohbN+IZWu6tLFmJPlTAvy1xO5VH0lLmUYMP1yEpxWn5w1MvmPNbIAb17JtYol3s4K7ycW5gcgdA63HSgb4SkZYLw2bhb5iTBE+PpmBu1kXVnG2bssiMwNrRpRyJbx4Qi644ySY76paFI4eFlzscoaFFzE9/roA6YHLfaqYMl+vU4z16E/KJa2YDS5qAyP7cStnZX9ygYxw0yX84IAKOSh2iRk2cqeKbLjx2r68uyNQ7IziLy7E1OSMa19AfbZkEpCcxFPgyM+xD7whbXik/rn+BH/sA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(46966006)(36840700001)(2906002)(83380400001)(34020700004)(47076005)(2616005)(478600001)(26005)(8676002)(316002)(6916009)(82740400003)(4326008)(81166007)(5660300002)(54906003)(356005)(36756003)(36860700001)(86362001)(6666004)(336012)(7696005)(8936002)(186003)(82310400003)(1076003)(16526019)(70206006)(44832011)(70586007)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 04:01:37.6145 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 959681db-d7d6-42ec-099b-08d95d45e212
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3247
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
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   |  3 +++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 22 ++++++++++++++++------
 2 files changed, 19 insertions(+), 6 deletions(-)

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
index e33e67310030..131ad0dfefbe 100644
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
@@ -2190,8 +2195,8 @@ static int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
 	if (smu->ppt_funcs->set_fan_speed_rpm) {
 		ret = smu->ppt_funcs->set_fan_speed_rpm(smu, speed);
 		if (!ret && smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE) {
-			percent = speed * 100 / smu->fan_max_rpm;
-			smu->user_dpm_profile.fan_speed_percent = percent;
+			smu->user_dpm_profile.flags |= SMU_CUSTOM_FAN_SPEED_RPM;
+			smu->user_dpm_profile.fan_speed_rpm = speed;
 		}
 	}
 
@@ -2552,8 +2557,11 @@ static int smu_set_fan_control_mode(struct smu_context *smu, int value)
 
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
@@ -2604,8 +2612,10 @@ static int smu_set_fan_speed_percent(void *handle, u32 speed)
 		if (speed > 100)
 			speed = 100;
 		ret = smu->ppt_funcs->set_fan_speed_percent(smu, speed);
-		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE))
+		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
+			smu->user_dpm_profile.flags |= SMU_CUSTOM_FAN_SPEED_PWM;
 			smu->user_dpm_profile.fan_speed_percent = speed;
+		}
 	}
 
 	mutex_unlock(&smu->mutex);
-- 
2.29.0


Return-Path: <SRS0=5bFg=L7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41C5C07E96
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 01:59:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A153D61A3E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 01:59:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A153D61A3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6487C6E7F5;
	Wed,  7 Jul 2021 01:59:25 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 929CB6E7F5
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jul 2021 01:59:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgFVvnYjWc4HOcucB89vIvgBXSpYZdSZ1FbOSXhdrYgM1fFs0NzFxIi3fr8vA6vqlpWKlWaOML1RTH6TxImIfwaKKYc3hqXmHBXIaNs/AgMYyn+6pkmm0kC1ZowdhNAXVPwI0CjrOlU/ngl6SPmythuPzDivciNnx/kh6pnhWsbnmABgUjcdgg4yQeyasxQAHAiEN/12mKii6vXWFL3ZX4MKYIMbKv2fjP/315ScthIui9dMen+NvZ0rfiYjk0N3GptA7pWiguLEasPDpBYS6zIN2mcoGcgeG0kCqEpmrlEc9poIcF51K/gRTrfgvGkarMwG9fMO0vJN0bgdQHMz/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59QUo6wzezF/GMlz/NTuuJ/PldKxTI1Tv7hjRvlhjzk=;
 b=FxE7hpVeZEkugl5snQeMwO51QU14DP9E/x5sdri+VI7FrxO95q4l63prqo59pS9go0FbYq05K5fyAE0xIPtqQJ5ojiAT30TKCT56teCalsxrzF0mXSoopB1ck2cZEi7dlsrqr2I6dM4PhUAc/UYbx6mmKYAdu7LMYkJ6GUA1hkSMlMgE4hUw9/8OhTq8AD4lzh/5cKZ4iE5ertbQyIwUTgd/1y1eO0aqx66b6GDFDZIaUgQnpCggHosAkqyETD0+TDyqhYy08A3089HKxxbJDvpYZl6MNeYgphFAbqyvpxLXfqwjS69XfWH+ht2Zkj0S/yXAJh/1mwmBdYHJeim+Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59QUo6wzezF/GMlz/NTuuJ/PldKxTI1Tv7hjRvlhjzk=;
 b=k7HhiN22YZi3M5W0Q14j/pcVbb4NnoO/RAqlSJcjS34XAmwTHutCViP67txpQLTrKwIUte6cx6ORXzrCRi+ZVZeAXHD/B/PlNXjMr6H8n9tA4yTm3+7m67CkORbHBzEpo4K0snPXJNQ8Nuu6f7c55/3dl8l6iPpVPm47vdvDlFA=
Received: from DM5PR18CA0058.namprd18.prod.outlook.com (2603:10b6:3:22::20) by
 BL1PR12MB5304.namprd12.prod.outlook.com (2603:10b6:208:314::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.30; Wed, 7 Jul
 2021 01:59:21 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:22:cafe::db) by DM5PR18CA0058.outlook.office365.com
 (2603:10b6:3:22::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend
 Transport; Wed, 7 Jul 2021 01:59:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 01:59:21 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 6 Jul 2021
 20:59:19 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/7] drm/amd/pm: record the RPM and PWM based fan speed
 settings
Date: Wed, 7 Jul 2021 09:56:42 +0800
Message-ID: <20210707015647.139127-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210707015647.139127-1-evan.quan@amd.com>
References: <20210707015647.139127-1-evan.quan@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df685020-5525-4a52-5799-08d940ead68a
X-MS-TrafficTypeDiagnostic: BL1PR12MB5304:
X-Microsoft-Antispam-PRVS: <BL1PR12MB530410F4BFFB9095FE58A0E4E41A9@BL1PR12MB5304.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N6Tio0W3E2+RWqTU9TrKOh3kXVJXapZPlwAUG7oZWL3syJbHcMVuYxWzc2q4SwhnHtB6fq4KgRSdD5L211wXmUldZfFw7SwjUvQtIsy7CQwJU6bwDj2RpsBLf+0Rxfbu8RDQhIgkVIe7Lotl6/PlwwylSyyipzc6oRSyzGRQw3JJvQKV4u6nzWezyAtzUcrJGhnyC5bM2XcgQ7DZ0mRGhAyajkhoNtkozIklFdFJ6QwWTuOgXs4E5Ca4MndRHjfpPWDl75BmZ0+s+y9/WzdUoC7n5F48AM63CP7EUeq63935I3gJzNQ2oe/UiXOIHYeggfUc8+WTmQBWZWvrW/O2n5+k5D+v48+zk56f1Z3BExXhIjcx7BlnXYg8fVyUxxpY740afIqsM1Ij6/ygs5EryEmW5mWtlORTMnzblY7UX6O7EzdFQAWh3+PjZGiWZ+VLfBMBVKXvFaEJfepWaXTvn1SodFmdF8ThwwZSti5pGcyFWDNaBnE1SFiPRGvcJJzS8X02aoHgFSbOKPGoszgifrX0I0YOMOT4yIx4E09RKMyLOJQPa8bhoGNPgqsSxD95VaKFqz5wpXLE5A8ZnUqQkOa9Jb19q7+RSmW3ltT36eKnF2kHNcRTxuV26JsVnE8cB+8CVRHzM7ROE65GCS0XCrvr+0/3LsxwpQzHSIYtWGwioqL40Au8vCTRPur28819IQ46g54PIWsV1wCYYif/BS4SCjkT5xCbANXpFhCPPX8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(36840700001)(46966006)(82740400003)(4326008)(426003)(5660300002)(83380400001)(70206006)(26005)(356005)(1076003)(36756003)(8676002)(86362001)(70586007)(36860700001)(16526019)(186003)(54906003)(81166007)(6666004)(82310400003)(44832011)(2616005)(336012)(478600001)(7696005)(316002)(2906002)(47076005)(8936002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 01:59:21.4541 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df685020-5525-4a52-5799-08d940ead68a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5304
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As the relationship "PWM = RPM / smu->fan_max_rpm" between fan speed
PWM and RPM is not true for SMU11 ASICs. So, both the RPM and PWM
settings need to be saved.

Change-Id: I318c134d442273d518b805339cdf383e151b935d
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   |  8 ++++++++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 20 +++++++++++++++-----
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 6301e4cb3c2a..fa585f0be530 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -226,10 +226,18 @@ enum smu_memory_pool_size
     SMU_MEMORY_POOL_SIZE_2_GB   = 0x80000000,
 };
 
+enum custom_fan_speed_mode
+{
+	SMU_CUSTOM_FAN_SPEED_RPM = 1 << 0,
+	SMU_CUSTOM_FAN_SPEED_PWM = 1 << 1,
+};
+
 struct smu_user_dpm_profile {
 	uint32_t fan_mode;
 	uint32_t power_limit;
+	uint32_t custom_fan_speed;
 	uint32_t fan_speed_percent;
+	uint32_t fan_speed_rpm;
 	uint32_t flags;
 
 	/* user clock state information */
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 576e9ea68fd1..9a25443988e3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -414,6 +414,12 @@ static void smu_restore_dpm_user_profile(struct smu_context *smu)
 			if (ret)
 				dev_err(smu->adev->dev, "Failed to set manual fan speed\n");
 		}
+
+		if (!ret && smu->user_dpm_profile.fan_speed_rpm) {
+			ret = smu_set_fan_speed_rpm(smu, smu->user_dpm_profile.fan_speed_rpm);
+			if (ret)
+				dev_err(smu->adev->dev, "Failed to set manual fan speed\n");
+		}
 	}
 
 	/* Disable restore flag */
@@ -2166,7 +2172,6 @@ static int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled)
 static int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
 {
 	struct smu_context *smu = handle;
-	u32 percent;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -2177,8 +2182,8 @@ static int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
 	if (smu->ppt_funcs->set_fan_speed_rpm) {
 		ret = smu->ppt_funcs->set_fan_speed_rpm(smu, speed);
 		if (!ret && smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE) {
-			percent = speed * 100 / smu->fan_max_rpm;
-			smu->user_dpm_profile.fan_speed_percent = percent;
+			smu->user_dpm_profile.custom_fan_speed |= SMU_CUSTOM_FAN_SPEED_RPM;
+			smu->user_dpm_profile.fan_speed_rpm = speed;
 		}
 	}
 
@@ -2539,8 +2544,11 @@ static int smu_set_fan_control_mode(struct smu_context *smu, int value)
 
 	/* reset user dpm fan speed */
 	if (!ret && value != AMD_FAN_CTRL_MANUAL &&
-			!(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE))
+			!(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
 		smu->user_dpm_profile.fan_speed_percent = 0;
+		smu->user_dpm_profile.fan_speed_rpm = 0;
+		smu->user_dpm_profile.custom_fan_speed = 0;
+	}
 
 	return ret;
 }
@@ -2591,8 +2599,10 @@ static int smu_set_fan_speed_percent(void *handle, u32 speed)
 		if (speed > 100)
 			speed = 100;
 		ret = smu->ppt_funcs->set_fan_speed_percent(smu, speed);
-		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE))
+		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
+			smu->user_dpm_profile.custom_fan_speed |= SMU_CUSTOM_FAN_SPEED_PWM;
 			smu->user_dpm_profile.fan_speed_percent = speed;
+		}
 	}
 
 	mutex_unlock(&smu->mutex);
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

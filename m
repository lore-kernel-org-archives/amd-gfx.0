Return-Path: <SRS0=5bFg=L7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680E5C07E9B
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 01:59:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B41261A3E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 01:59:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B41261A3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF6866E7FE;
	Wed,  7 Jul 2021 01:59:32 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 146BF6E7FE
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jul 2021 01:59:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jnulIEKaATy1gDzlSutpxmMpzC5MW0R81353mGpiCJ8yE7QEqox/rZrOh39hKFyLhvMI1TjDSdbFC5xOg7k4ik4nDL5A7q67r1YsjDyt8UwxY/R1VVGd1bea7uSm9NuavOlPAYymUKlGWq8obQ+bUTUIqwgZe86lFDthoxRIbGcgA/U/1SZiKgr0Sn/KgLKzQcZkFz+lp9HIBCentvzkx6moute5zVhUaKwwTbt5WPYOZawRqs9/SWAKY2JtcyLmXs/F7LLIeDPmbYLzHNH27z8/AAoLIhp3aFfP+x/Pejo6QNHnfeCLaHmDmK4i36sieVORAcArT8JVK4qVucRweA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yArVt8QAERN4dXMDgyuDU1TtT8jyPscjP91NaBQ9Lh0=;
 b=fzrITVwp/4ZowZO5tJFTNh85bTLJwrvnk27ZEJkXxlovBOTRNMk15U8h9z/9ZLQZ45WjiIyWk3DeVxbW4vtv9+p1eBFi2nFdz2/ZQimYbo8NTHr3BQc098/xIWJs6drLSaWgYS+YHYnFyYdaq9AMK1pPDbm9mqrTELMDjaQ6iQIHwYe5PggANo4MFJxhRZZWMsyi0C2DfhVxgr2jDcI+Y0j54p8UdYCaLdLU7B3kTLV6stYjvtjMXpauKIV1Y2sh8DHkr5zkOdq7re92SZjZgR7O/u5EIGhHhKg0rd9fgRws9TfJBp82T0ktmUxuvun8CS/gyHBS/b12S/m/nWcpWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yArVt8QAERN4dXMDgyuDU1TtT8jyPscjP91NaBQ9Lh0=;
 b=MJXTjBDx/6pT2cCy1FGNOFHCDgTY7/M3zOPSzQZKAQG9RkZDX1HnS4/1aE994b4Wkl1AeZQo4HCfzjRL9g2sKwfWVBgwTV2A3tRFZxfs7PIu8zbJVS9E7UWdqZYHMTGD8T1OmUD6UekBN+4PWlOZahbz0tPhA4G8GhCUPEfzrrQ=
Received: from DM5PR2201CA0001.namprd22.prod.outlook.com (2603:10b6:4:14::11)
 by CH2PR12MB3782.namprd12.prod.outlook.com (2603:10b6:610:23::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Wed, 7 Jul
 2021 01:59:29 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:14:cafe::13) by DM5PR2201CA0001.outlook.office365.com
 (2603:10b6:4:14::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend
 Transport; Wed, 7 Jul 2021 01:59:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4287.22 via Frontend Transport; Wed, 7 Jul 2021 01:59:29 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 6 Jul 2021
 20:59:27 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/7] drm/amd/pm: drop the unnecessary intermediate
 percent-based transition
Date: Wed, 7 Jul 2021 09:56:45 +0800
Message-ID: <20210707015647.139127-5-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210707015647.139127-1-evan.quan@amd.com>
References: <20210707015647.139127-1-evan.quan@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31599203-7fbc-49b6-468f-08d940eadb41
X-MS-TrafficTypeDiagnostic: CH2PR12MB3782:
X-Microsoft-Antispam-PRVS: <CH2PR12MB37825E03C3F8EE2D06F39E49E41A9@CH2PR12MB3782.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:669;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JkwrKwURN5WQsK9hxnGh1GGc63srwosLxa8ftwQ/CjzoRWEJFC0Z8wlyJDFsIZk2aHi3A/2EB7BEGDnuSONGQABjJz9D1nzbtYmuegKDfjncnocghhf0breCa6aSydphhUPUZweg7vIyhh7JaYX9Aa72Zzpi+iDERyaK0HVl/9hXQbX+42S+HOVpqd7FupaUXDhUcRrIB9zhV8iQjMwcNwfyi0Kkf4mx3RnegJeuLzRd2Py9VzUvQ0amz4JtcahDTqA5YARnBarLg/DmdHG+6ooJ+M2R+fnqFbYNoqgN416AV4Kcp/IhbEf/kUj5Qap6digygGHErA8Qs5+svORFcYoEOEw5q9j5U/QEeHCFVDZPpOV39K16Cdm9YhU2KuMl7DS4w4QjEzy2fqfvUq0YMMmIR/4VGQVkcEKObMyFHd3phT5Q+fbC/H8l1zs8D0NHXYwJExpNM7nX22Vjb1r4noDurjaiwD8JdANCjU3PUDP4+O6O5+3Kpr6uoo8necVTm8jAdLjymK4ixEReD5jCJa+bcDj/yvsk5kWJ6krjK/gx8E182X7S9TyDImEPHZoL+EhZACUyfONbcIugycXcLUFK0svXnVR/ZR9iDdDJJRkAr2oq6DubOpvKEBBwclZ7Gwu50BMzXNqiIPIBF4SbDP+Vx9RAbLHDTiAkXZ45/8cqZaSGq8akpUVEXu9aJFZqAYJTKmHKWVwgjEe8kjjENDcIjwXX0xeapEmPpJfWcgU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(46966006)(36840700001)(478600001)(5660300002)(36756003)(186003)(2616005)(70586007)(16526019)(316002)(426003)(44832011)(86362001)(8676002)(70206006)(26005)(6666004)(2906002)(8936002)(336012)(30864003)(82740400003)(81166007)(4326008)(83380400001)(1076003)(47076005)(54906003)(6916009)(356005)(82310400003)(36860700001)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 01:59:29.3579 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31599203-7fbc-49b6-468f-08d940eadb41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3782
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

Currently, the readout of fan speed pwm is transited into percent-based
and then pwm-based. However, the transition into percent-based is totally
unnecessary and make the final output less accurate.

Change-Id: Ib99e088cda1875b4e2601f7077a178af6fe8a6cb
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |  4 ----
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    |  4 ++--
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c  | 12 ++++++------
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c  |  2 +-
 .../drm/amd/pm/powerplay/hwmgr/vega10_thermal.c    | 10 +++++-----
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c  |  2 +-
 .../drm/amd/pm/powerplay/hwmgr/vega20_thermal.c    | 12 ++++++------
 drivers/gpu/drm/amd/pm/powerplay/si_dpm.c          | 10 +++++-----
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          | 12 ++----------
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     | 14 +++++++-------
 10 files changed, 35 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 769f58d5ae1a..e9c98e3f4cfb 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2469,8 +2469,6 @@ static ssize_t amdgpu_hwmon_set_pwm1(struct device *dev,
 		return err;
 	}
 
-	value = (value * 100) / 255;
-
 	if (adev->powerplay.pp_funcs->set_fan_speed_percent)
 		err = amdgpu_dpm_set_fan_speed_percent(adev, value);
 	else
@@ -2515,8 +2513,6 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device *dev,
 	if (err)
 		return err;
 
-	speed = (speed * 255) / 100;
-
 	return sprintf(buf, "%i\n", speed);
 }
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 0541bfc81c1b..aa353a628c50 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -3212,7 +3212,7 @@ static int smu7_force_dpm_level(struct pp_hwmgr *hwmgr,
 
 	if (!ret) {
 		if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK && hwmgr->dpm_level != AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
-			smu7_fan_ctrl_set_fan_speed_percent(hwmgr, 100);
+			smu7_fan_ctrl_set_fan_speed_percent(hwmgr, 255);
 		else if (level != AMD_DPM_FORCED_LEVEL_PROFILE_PEAK && hwmgr->dpm_level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
 			smu7_fan_ctrl_reset_fan_speed_to_default(hwmgr);
 	}
@@ -4988,7 +4988,7 @@ static void smu7_set_fan_control_mode(struct pp_hwmgr *hwmgr, uint32_t mode)
 {
 	switch (mode) {
 	case AMD_FAN_CTRL_NONE:
-		smu7_fan_ctrl_set_fan_speed_percent(hwmgr, 100);
+		smu7_fan_ctrl_set_fan_speed_percent(hwmgr, 255);
 		break;
 	case AMD_FAN_CTRL_MANUAL:
 		if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
index 6cfe148ed45b..70ccc127e3fd 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
@@ -70,12 +70,12 @@ int smu7_fan_ctrl_get_fan_speed_percent(struct pp_hwmgr *hwmgr,
 		return -EINVAL;
 
 
-	tmp64 = (uint64_t)duty * 100;
+	tmp64 = (uint64_t)duty * 255;
 	do_div(tmp64, duty100);
 	*speed = (uint32_t)tmp64;
 
-	if (*speed > 100)
-		*speed = 100;
+	if (*speed > 255)
+		*speed = 255;
 
 	return 0;
 }
@@ -214,8 +214,8 @@ int smu7_fan_ctrl_set_fan_speed_percent(struct pp_hwmgr *hwmgr,
 	if (hwmgr->thermal_controller.fanInfo.bNoFan)
 		return 0;
 
-	if (speed > 100)
-		speed = 100;
+	if (speed > 255)
+		speed = 255;
 
 	if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl))
 		smu7_fan_ctrl_stop_smc_fan_control(hwmgr);
@@ -227,7 +227,7 @@ int smu7_fan_ctrl_set_fan_speed_percent(struct pp_hwmgr *hwmgr,
 		return -EINVAL;
 
 	tmp64 = (uint64_t)speed * duty100;
-	do_div(tmp64, 100);
+	do_div(tmp64, 255);
 	duty = (uint32_t)tmp64;
 
 	PHM_WRITE_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 25979106fd25..44c5e2588046 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -4199,7 +4199,7 @@ static void vega10_set_fan_control_mode(struct pp_hwmgr *hwmgr, uint32_t mode)
 
 	switch (mode) {
 	case AMD_FAN_CTRL_NONE:
-		vega10_fan_ctrl_set_fan_speed_percent(hwmgr, 100);
+		vega10_fan_ctrl_set_fan_speed_percent(hwmgr, 255);
 		break;
 	case AMD_FAN_CTRL_MANUAL:
 		if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl))
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
index 9b46b27bd30c..6b4c4294afca 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
@@ -78,11 +78,11 @@ int vega10_fan_ctrl_get_fan_speed_percent(struct pp_hwmgr *hwmgr,
 
 	if (hwmgr->thermal_controller.
 			advanceFanControlParameters.usMaxFanRPM != 0)
-		percent = current_rpm * 100 /
+		percent = current_rpm * 255 /
 			hwmgr->thermal_controller.
 			advanceFanControlParameters.usMaxFanRPM;
 
-	*speed = percent > 100 ? 100 : percent;
+	*speed = percent > 255 ? 255 : percent;
 
 	return 0;
 }
@@ -257,8 +257,8 @@ int vega10_fan_ctrl_set_fan_speed_percent(struct pp_hwmgr *hwmgr,
 	if (hwmgr->thermal_controller.fanInfo.bNoFan)
 		return 0;
 
-	if (speed > 100)
-		speed = 100;
+	if (speed > 255)
+		speed = 255;
 
 	if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl))
 		vega10_fan_ctrl_stop_smc_fan_control(hwmgr);
@@ -270,7 +270,7 @@ int vega10_fan_ctrl_set_fan_speed_percent(struct pp_hwmgr *hwmgr,
 		return -EINVAL;
 
 	tmp64 = (uint64_t)speed * duty100;
-	do_div(tmp64, 100);
+	do_div(tmp64, 255);
 	duty = (uint32_t)tmp64;
 
 	WREG32_SOC15(THM, 0, mmCG_FDO_CTRL0,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index 0791309586c5..cbe5f8027ee0 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -2769,7 +2769,7 @@ static void vega20_set_fan_control_mode(struct pp_hwmgr *hwmgr, uint32_t mode)
 {
 	switch (mode) {
 	case AMD_FAN_CTRL_NONE:
-		vega20_fan_ctrl_set_fan_speed_percent(hwmgr, 100);
+		vega20_fan_ctrl_set_fan_speed_percent(hwmgr, 255);
 		break;
 	case AMD_FAN_CTRL_MANUAL:
 		if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl))
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
index 43d754952bd9..eb007c00d7c6 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
@@ -129,12 +129,12 @@ int vega20_fan_ctrl_get_fan_speed_percent(struct pp_hwmgr *hwmgr,
 	if (!duty100)
 		return -EINVAL;
 
-	tmp64 = (uint64_t)duty * 100;
+	tmp64 = (uint64_t)duty * 255;
 	do_div(tmp64, duty100);
 	*speed = (uint32_t)tmp64;
 
-	if (*speed > 100)
-		*speed = 100;
+	if (*speed > 255)
+		*speed = 255;
 
 	return 0;
 }
@@ -147,8 +147,8 @@ int vega20_fan_ctrl_set_fan_speed_percent(struct pp_hwmgr *hwmgr,
 	uint32_t duty;
 	uint64_t tmp64;
 
-	if (speed > 100)
-		speed = 100;
+	if (speed > 255)
+		speed = 255;
 
 	if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl))
 		vega20_fan_ctrl_stop_smc_fan_control(hwmgr);
@@ -160,7 +160,7 @@ int vega20_fan_ctrl_set_fan_speed_percent(struct pp_hwmgr *hwmgr,
 		return -EINVAL;
 
 	tmp64 = (uint64_t)speed * duty100;
-	do_div(tmp64, 100);
+	do_div(tmp64, 255);
 	duty = (uint32_t)tmp64;
 
 	WREG32_SOC15(THM, 0, mmCG_FDO_CTRL0,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
index 15c0b8af376f..96ca359c10a5 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
@@ -6555,12 +6555,12 @@ static int si_dpm_get_fan_speed_percent(void *handle,
 	if (duty100 == 0)
 		return -EINVAL;
 
-	tmp64 = (u64)duty * 100;
+	tmp64 = (u64)duty * 255;
 	do_div(tmp64, duty100);
 	*speed = (u32)tmp64;
 
-	if (*speed > 100)
-		*speed = 100;
+	if (*speed > 255)
+		*speed = 255;
 
 	return 0;
 }
@@ -6580,7 +6580,7 @@ static int si_dpm_set_fan_speed_percent(void *handle,
 	if (si_pi->fan_is_controlled_by_smc)
 		return -EINVAL;
 
-	if (speed > 100)
+	if (speed > 255)
 		return -EINVAL;
 
 	duty100 = (RREG32(CG_FDO_CTRL1) & FMAX_DUTY100_MASK) >> FMAX_DUTY100_SHIFT;
@@ -6589,7 +6589,7 @@ static int si_dpm_set_fan_speed_percent(void *handle,
 		return -EINVAL;
 
 	tmp64 = (u64)speed * duty100;
-	do_div(tmp64, 100);
+	do_div(tmp64, 255);
 	duty = (u32)tmp64;
 
 	tmp = RREG32(CG_FDO_CTRL0) & ~FDO_STATIC_DUTY_MASK;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 54fb3d7d23ee..94c15526ad21 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2565,23 +2565,17 @@ static int smu_get_fan_speed_percent(void *handle, u32 *speed)
 {
 	struct smu_context *smu = handle;
 	int ret = 0;
-	uint32_t percent;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
-	if (smu->ppt_funcs->get_fan_speed_percent) {
-		ret = smu->ppt_funcs->get_fan_speed_percent(smu, &percent);
-		if (!ret) {
-			*speed = percent > 100 ? 100 : percent;
-		}
-	}
+	if (smu->ppt_funcs->get_fan_speed_percent)
+		ret = smu->ppt_funcs->get_fan_speed_percent(smu, speed);
 
 	mutex_unlock(&smu->mutex);
 
-
 	return ret;
 }
 
@@ -2596,8 +2590,6 @@ static int smu_set_fan_speed_percent(void *handle, u32 speed)
 	mutex_lock(&smu->mutex);
 
 	if (smu->ppt_funcs->set_fan_speed_percent) {
-		if (speed > 100)
-			speed = 100;
 		ret = smu->ppt_funcs->set_fan_speed_percent(smu, speed);
 		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
 			smu->user_dpm_profile.custom_fan_speed |= SMU_CUSTOM_FAN_SPEED_PWM;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 0cdf55a0dba2..f0ae0920c07e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1191,8 +1191,8 @@ smu_v11_0_set_fan_speed_percent(struct smu_context *smu, uint32_t speed)
 	uint32_t duty100, duty;
 	uint64_t tmp64;
 
-	if (speed > 100)
-		speed = 100;
+	if (speed > 255)
+		speed = 255;
 
 	if (smu_v11_0_auto_fan_control(smu, 0))
 		return -EINVAL;
@@ -1203,7 +1203,7 @@ smu_v11_0_set_fan_speed_percent(struct smu_context *smu, uint32_t speed)
 		return -EINVAL;
 
 	tmp64 = (uint64_t)speed * duty100;
-	do_div(tmp64, 100);
+	do_div(tmp64, 255);
 	duty = (uint32_t)tmp64;
 
 	WREG32_SOC15(THM, 0, mmCG_FDO_CTRL0,
@@ -1274,12 +1274,12 @@ int smu_v11_0_get_fan_speed_percent(struct smu_context *smu,
 	if (!duty100)
 		return -EINVAL;
 
-	tmp64 = (uint64_t)duty * 100;
+	tmp64 = (uint64_t)duty * 255;
 	do_div(tmp64, duty100);
 	*speed = (uint32_t)tmp64;
 
-	if (*speed > 100)
-		*speed = 100;
+	if (*speed > 255)
+		*speed = 255;
 
 	return 0;
 }
@@ -1320,7 +1320,7 @@ smu_v11_0_set_fan_control_mode(struct smu_context *smu,
 
 	switch (mode) {
 	case AMD_FAN_CTRL_NONE:
-		ret = smu_v11_0_set_fan_speed_percent(smu, 100);
+		ret = smu_v11_0_set_fan_speed_percent(smu, 255);
 		break;
 	case AMD_FAN_CTRL_MANUAL:
 		ret = smu_v11_0_auto_fan_control(smu, 0);
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

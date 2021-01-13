Return-Path: <SRS0=tf5m=GQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87648C433E6
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 03:28:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18F5522EBE
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 03:28:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18F5522EBE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABB5D89BFB;
	Wed, 13 Jan 2021 03:28:07 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB5FB89B22
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 03:28:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Er8f/O3yWd821WLmHMpbMr3OaSVSRGDSUKiG7ST0GqqDlC/giLZ2uyQ73yUmjE8zKIpwaX9tW3QJ1P2aSWYFkgxha6IFUy5ewZY3PCx9LGYkPJQzKxQ0LxEJyvr9M40mQSVtir4z2E5pF3lEifnYsuysyPhTTZFxL5/uZLwF/AfTrvJQGP2O5KNJDw0aY6BIHCrti9qzyx2outxWJxi5loozLhXdqt2jZKkuoYWjNXM56tPwmCKVYo1KEx8et39ouOkBypK/J0QiOGthxut+ELR57kF2ErUpSaCnknlCT0N8SaF7KlyPr0O6vzUAFPTeO0diVnzEwEwWCpNPDRLkhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXl+CtnO6V2dzChURdq1vi3vmAsPCinczsN5TMDG+2o=;
 b=HLdF0uUhFnmDaDjjrT7HehP9TP7Vice6L+OFxK1yOLOe6OaCO1RIo6jaQXE7pCVgHc/LQKBa9rcgztOXbtYph+4r9aKwLpqnWsnEU0pQm5drQbPmhzobfRGzw6+LtJgQO47pyP1auiSc27xcymjTPaQvn6v2M/VKdGBYDc8D2gx5X40E7aRQ85EKhXUrZqDAF4J1rNfkFHKlEKOd/dBne5ikD09nfCmmGDjNETu7KHkQIxK5pzlhVAxCYLOw8fNvMutJad7pXHNkuPX6tZkJne4UacdXV9QR53+CLFDjYMeWGyorqaj6YV5yqdXGTfgQ7m1x8BtdoS4jdQvSIi3C6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXl+CtnO6V2dzChURdq1vi3vmAsPCinczsN5TMDG+2o=;
 b=Solls34bDurqXNJswL16WhbWLLQrf3YhHVarRRZQEQF+UV3tFFQu/3NnfWN4r+ZqraJBFI02rUTyDGrGx4zeXbsNV2B1MgZ1AWucFZIW4fU6q8YpXJ65zzEfBCU1MdGuDev8JqMvpZKpjSAJjJ1CW5uLz5VpzV8P98W/m58UQiw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2954.namprd12.prod.outlook.com (2603:10b6:5:188::22)
 by DM6PR12MB3817.namprd12.prod.outlook.com (2603:10b6:5:1c9::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 13 Jan
 2021 03:28:04 +0000
Received: from DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::19b:66f9:83d9:7cb1]) by DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::19b:66f9:83d9:7cb1%3]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 03:28:04 +0000
From: Darren Powell <darren.powell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/8] amdgpu/pm: Powerplay API for smu ,
 changed 6 pm hwmon fan functions to use API
Date: Tue, 12 Jan 2021 22:27:21 -0500
Message-Id: <20210113032726.2475-4-darren.powell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113032726.2475-1-darren.powell@amd.com>
References: <20210113032726.2475-1-darren.powell@amd.com>
X-Originating-IP: [142.126.168.115]
X-ClientProxiedBy: YT1PR01CA0155.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::34) To DM6PR12MB2954.namprd12.prod.outlook.com
 (2603:10b6:5:188::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (142.126.168.115) by
 YT1PR01CA0155.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.9 via Frontend Transport; Wed, 13 Jan 2021 03:28:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 450ccf1e-5115-44ec-eac9-08d8b7733d14
X-MS-TrafficTypeDiagnostic: DM6PR12MB3817:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3817667FDFED3354588886B2F0A90@DM6PR12MB3817.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:302;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VgPG27xkZsbmFiUzql++s8TMdhEO0wArz93Lqsr4cfGN7Y0JB6Kp5OHgeEM12zXs2iYyAk6e0EipwGK5iAxXKQ9fd0VyumINXZvGfNEOUgytyqDdBy0xZbLd6Rdi0qsIx42mBYcXM/VvqXahQqaku8xdI1vZ92smNm7HnYeD/nKdKfEKdb02s0XzuKfkIWRXMYczAwNe/gbAujsjhfI3Nn0soxBdOwmA90DgBlWKcrzX7O/570MzrVYsfYgpiijAJuW9/hXJptQ+lJNhNNcjLwyu3m4NAk33+Qpf35jhVfuNIk6N6QO4xijAucvR73o0GO1HE5LMxXN9dD1KHYTQFOjgMMITQOKfeuSG2IXJpazj5jeiGQGnk1LsoynrKph1WFHfL7uQSQpbWex9NboM7xfP0FE909kXLyXz3utNbMDp/+i/0FGsmu+kLwsW1i7de2lXsdEZWvGIP8MNNUCSew==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2954.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(5660300002)(69590400011)(66556008)(4326008)(6506007)(8936002)(36756003)(8676002)(6512007)(6486002)(6916009)(66476007)(186003)(44832011)(66946007)(86362001)(1076003)(26005)(956004)(30864003)(52116002)(478600001)(16526019)(316002)(2616005)(6666004)(2906002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Hp1V2MsuNxjgzyKu/ZLvF33opRJjYcdrQRrIu1knWAReaUaJYGc1yxmCJwpd?=
 =?us-ascii?Q?f0/SxKWxrbJY/obRmTfeWC0SnrAgTEhHcyRB3X62yTpNptIjslX5Tse2wnTf?=
 =?us-ascii?Q?VeGTOMZjAe9lqiAFcTkvFnrzUhcmyejNUlTgidrGne7VmA/5uIdm1pguTEdP?=
 =?us-ascii?Q?+PGdocHyctbMs6iT7zAwuPonBW1DEKpUiFT1RgTBbHfMv8RTxp70tV/7uLSh?=
 =?us-ascii?Q?dAmKmfopdLe3hxyTLzEi56n0jCssYuo6egTt9KPp4b5cA2W0AOfLNxbUSl73?=
 =?us-ascii?Q?zCyrrQyw4njG9upT8isdxn1BNkCFSV/hT88ursgAVCvUbuJibs7vS+9n3L6m?=
 =?us-ascii?Q?YcQztWNDQa82yy75IshhsRN3EsiGAvuVn5nhxnYfd4WQCoHShNdUoQoCcZUI?=
 =?us-ascii?Q?Q0R0iPovCbYXeI4GF7SrwWdIgdDaSsNTqDAlLI2o/fTPZgSN3t8vzsvclFPH?=
 =?us-ascii?Q?nou1oiRj6Dx86mmsewV6D3yfV0BXjO8FvkQLTPDNM+F78nJd5utrz2ZWXLpL?=
 =?us-ascii?Q?SX1iReA1j+/mPduAIc+IlbUkQbQxhwDZ792rh8jobELO4cCTWVIJlL35dZs1?=
 =?us-ascii?Q?ylg5ZRX0F6d6UCCwqXD7+PTjuWThWny5gtwquh5womMn5j23mG1A7flYgKOu?=
 =?us-ascii?Q?Ses4ppoXvowlh6yGmsotuUrDpJUkaVToFYMczz5MOvJPm9Qbwk1+alUiGzJ2?=
 =?us-ascii?Q?UVWoEnNMvM7N/uH7Ifi2U4azwQE/ViV2oB3ry96miqVTadwzCa3gcgggG7m9?=
 =?us-ascii?Q?QGnWDwVSEvpH6b+Od3BDM7vy/0+O0HDG3Y76J6bU6L7uiOTNzdAZGlcUV1r3?=
 =?us-ascii?Q?1BunBFlsLo6PvLxEqG12bhLmNC2tfv/MtJB2x/+PbsxeA+9jdVrp3MnQAP/C?=
 =?us-ascii?Q?yZdNcfZiqep6GzVcc8jEA0WMHZrLC3UBoGBNtklKrTaDxNGb6XViP6baevwf?=
 =?us-ascii?Q?wGJ877JXhiGZoiCYaNaHmHUN/3lPiDi2sAXKgFSby62rhUgiVHCY3CEwX4h5?=
 =?us-ascii?Q?fvqE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2021 03:28:04.6498 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 450ccf1e-5115-44ec-eac9-08d8b7733d14
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EW2QE5T2bIWJ0zAPw/VxBEdaHA05JV+/nI8WeXE2rl9KACWmkK5L9z/D0FHxA+G/VzikSTFgcYkBzLR7tOTHSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3817
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

v2: changed error return value of smu_get_fan_control_mode to AMD_FAN_CTRL_NONE
    fixed type in amdgpu_hwmon_get_pwm1_enable() print statement
    fixed indent flagged by checkpatch.pl

Modified Functions
  smu_set_fan_speed_rpm()     - modifed arg0 to match Powerplay API set_fan_speed_rpm
  smu_get_fan_control_mode()  - modifed signature to match Powerplay API get_fan_control_mode
  smu_set_fan_control_mode()  - modifed signature to match Powerplay API set_fan_control_mode
  smu_get_fan_speed_percent() - modifed signature to match Powerplay API get_fan_speed_percent
  smu_set_fan_speed_percent() - modifed signature to match Powerplay API set_fan_speed_percent
  smu_get_fan_speed_rpm()     - modifed arg0 to match Powerplay API get_fan_speed_rpm

Other Changes
  added 6 above smu fan Powerplay functions to swsmu_dpm_funcs
  removed special smu handling of above functions and called through Powerplay API

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c        | 95 ++++++++---------------
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   | 12 +--
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 35 ++++++---
 3 files changed, 60 insertions(+), 82 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 0008bbe971d6..cc32cfb7e41e 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2349,22 +2349,18 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struct device *dev,
 		return ret;
 	}
 
-	if (is_support_sw_smu(adev)) {
-		pwm_mode = smu_get_fan_control_mode(&adev->smu);
-	} else {
-		if (!adev->powerplay.pp_funcs->get_fan_control_mode) {
-			pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
-			pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
-			return -EINVAL;
-		}
-
-		pwm_mode = amdgpu_dpm_get_fan_control_mode(adev);
+	if (!adev->powerplay.pp_funcs->get_fan_control_mode) {
+		pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
+		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+		return -EINVAL;
 	}
 
+	pwm_mode = amdgpu_dpm_get_fan_control_mode(adev);
+
 	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 
-	return sprintf(buf, "%i\n", pwm_mode);
+	return sprintf(buf, "%u\n", pwm_mode);
 }
 
 static ssize_t amdgpu_hwmon_set_pwm1_enable(struct device *dev,
@@ -2389,18 +2385,14 @@ static ssize_t amdgpu_hwmon_set_pwm1_enable(struct device *dev,
 		return ret;
 	}
 
-	if (is_support_sw_smu(adev)) {
-		smu_set_fan_control_mode(&adev->smu, value);
-	} else {
-		if (!adev->powerplay.pp_funcs->set_fan_control_mode) {
-			pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
-			pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
-			return -EINVAL;
-		}
-
-		amdgpu_dpm_set_fan_control_mode(adev, value);
+	if (!adev->powerplay.pp_funcs->set_fan_control_mode) {
+		pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
+		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+		return -EINVAL;
 	}
 
+	amdgpu_dpm_set_fan_control_mode(adev, value);
+
 	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 
@@ -2439,11 +2431,7 @@ static ssize_t amdgpu_hwmon_set_pwm1(struct device *dev,
 		return err;
 	}
 
-	if (is_support_sw_smu(adev))
-		pwm_mode = smu_get_fan_control_mode(&adev->smu);
-	else
-		pwm_mode = amdgpu_dpm_get_fan_control_mode(adev);
-
+	pwm_mode = amdgpu_dpm_get_fan_control_mode(adev);
 	if (pwm_mode != AMD_FAN_CTRL_MANUAL) {
 		pr_info("manual fan speed control should be enabled first\n");
 		pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
@@ -2460,9 +2448,7 @@ static ssize_t amdgpu_hwmon_set_pwm1(struct device *dev,
 
 	value = (value * 100) / 255;
 
-	if (is_support_sw_smu(adev))
-		err = smu_set_fan_speed_percent(&adev->smu, value);
-	else if (adev->powerplay.pp_funcs->set_fan_speed_percent)
+	if (adev->powerplay.pp_funcs->set_fan_speed_percent)
 		err = amdgpu_dpm_set_fan_speed_percent(adev, value);
 	else
 		err = -EINVAL;
@@ -2493,9 +2479,7 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device *dev,
 		return err;
 	}
 
-	if (is_support_sw_smu(adev))
-		err = smu_get_fan_speed_percent(&adev->smu, &speed);
-	else if (adev->powerplay.pp_funcs->get_fan_speed_percent)
+	if (adev->powerplay.pp_funcs->get_fan_speed_percent)
 		err = amdgpu_dpm_get_fan_speed_percent(adev, &speed);
 	else
 		err = -EINVAL;
@@ -2528,9 +2512,7 @@ static ssize_t amdgpu_hwmon_get_fan1_input(struct device *dev,
 		return err;
 	}
 
-	if (is_support_sw_smu(adev))
-		err = smu_get_fan_speed_rpm(&adev->smu, &speed);
-	else if (adev->powerplay.pp_funcs->get_fan_speed_rpm)
+	if (adev->powerplay.pp_funcs->get_fan_speed_rpm)
 		err = amdgpu_dpm_get_fan_speed_rpm(adev, &speed);
 	else
 		err = -EINVAL;
@@ -2621,9 +2603,7 @@ static ssize_t amdgpu_hwmon_get_fan1_target(struct device *dev,
 		return err;
 	}
 
-	if (is_support_sw_smu(adev))
-		err = smu_get_fan_speed_rpm(&adev->smu, &rpm);
-	else if (adev->powerplay.pp_funcs->get_fan_speed_rpm)
+	if (adev->powerplay.pp_funcs->get_fan_speed_rpm)
 		err = amdgpu_dpm_get_fan_speed_rpm(adev, &rpm);
 	else
 		err = -EINVAL;
@@ -2655,10 +2635,7 @@ static ssize_t amdgpu_hwmon_set_fan1_target(struct device *dev,
 		return err;
 	}
 
-	if (is_support_sw_smu(adev))
-		pwm_mode = smu_get_fan_control_mode(&adev->smu);
-	else
-		pwm_mode = amdgpu_dpm_get_fan_control_mode(adev);
+	pwm_mode = amdgpu_dpm_get_fan_control_mode(adev);
 
 	if (pwm_mode != AMD_FAN_CTRL_MANUAL) {
 		pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
@@ -2673,9 +2650,7 @@ static ssize_t amdgpu_hwmon_set_fan1_target(struct device *dev,
 		return err;
 	}
 
-	if (is_support_sw_smu(adev))
-		err = smu_set_fan_speed_rpm(&adev->smu, value);
-	else if (adev->powerplay.pp_funcs->set_fan_speed_rpm)
+	if (adev->powerplay.pp_funcs->set_fan_speed_rpm)
 		err = amdgpu_dpm_set_fan_speed_rpm(adev, value);
 	else
 		err = -EINVAL;
@@ -2706,18 +2681,14 @@ static ssize_t amdgpu_hwmon_get_fan1_enable(struct device *dev,
 		return ret;
 	}
 
-	if (is_support_sw_smu(adev)) {
-		pwm_mode = smu_get_fan_control_mode(&adev->smu);
-	} else {
-		if (!adev->powerplay.pp_funcs->get_fan_control_mode) {
-			pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
-			pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
-			return -EINVAL;
-		}
-
-		pwm_mode = amdgpu_dpm_get_fan_control_mode(adev);
+	if (!adev->powerplay.pp_funcs->get_fan_control_mode) {
+		pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
+		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+		return -EINVAL;
 	}
 
+	pwm_mode = amdgpu_dpm_get_fan_control_mode(adev);
+
 	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 
@@ -2754,16 +2725,12 @@ static ssize_t amdgpu_hwmon_set_fan1_enable(struct device *dev,
 		return err;
 	}
 
-	if (is_support_sw_smu(adev)) {
-		smu_set_fan_control_mode(&adev->smu, pwm_mode);
-	} else {
-		if (!adev->powerplay.pp_funcs->set_fan_control_mode) {
-			pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
-			pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
-			return -EINVAL;
-		}
-		amdgpu_dpm_set_fan_control_mode(adev, pwm_mode);
+	if (!adev->powerplay.pp_funcs->set_fan_control_mode) {
+		pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
+		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+		return -EINVAL;
 	}
+	amdgpu_dpm_set_fan_control_mode(adev, pwm_mode);
 
 	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 6713f28c5fde..9f739d1b18d5 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -657,7 +657,7 @@ int smu_check_fw_status(struct smu_context *smu);
 
 int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled);
 
-int smu_set_fan_speed_rpm(struct smu_context *smu, uint32_t speed);
+int smu_set_fan_speed_rpm(void *handle, uint32_t speed);
 
 int smu_get_power_limit(struct smu_context *smu,
 			uint32_t *limit,
@@ -679,11 +679,11 @@ int smu_set_power_profile_mode(struct smu_context *smu,
 			       long *param,
 			       uint32_t param_size,
 			       bool lock_needed);
-int smu_get_fan_control_mode(struct smu_context *smu);
-int smu_set_fan_control_mode(struct smu_context *smu, int value);
-int smu_get_fan_speed_percent(struct smu_context *smu, uint32_t *speed);
-int smu_set_fan_speed_percent(struct smu_context *smu, uint32_t speed);
-int smu_get_fan_speed_rpm(struct smu_context *smu, uint32_t *speed);
+u32 smu_get_fan_control_mode(void *handle);
+void smu_set_fan_control_mode(void *handle, u32 value);
+int smu_get_fan_speed_percent(void *handle, u32 *speed);
+int smu_set_fan_speed_percent(void *handle, u32 speed);
+int smu_get_fan_speed_rpm(void *handle, uint32_t *speed);
 
 int smu_set_deep_sleep_dcefclk(struct smu_context *smu, int clk);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 41ce7e07d744..155faa589d46 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1896,8 +1896,9 @@ int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled)
 	return ret;
 }
 
-int smu_set_fan_speed_rpm(struct smu_context *smu, uint32_t speed)
+int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
 {
+	struct smu_context *smu = handle;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -2100,12 +2101,13 @@ int smu_set_power_profile_mode(struct smu_context *smu,
 }
 
 
-int smu_get_fan_control_mode(struct smu_context *smu)
+u32 smu_get_fan_control_mode(void *handle)
 {
-	int ret = 0;
+	struct smu_context *smu = handle;
+	u32 ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
+		return AMD_FAN_CTRL_NONE;
 
 	mutex_lock(&smu->mutex);
 
@@ -2117,25 +2119,26 @@ int smu_get_fan_control_mode(struct smu_context *smu)
 	return ret;
 }
 
-int smu_set_fan_control_mode(struct smu_context *smu, int value)
+void smu_set_fan_control_mode(void *handle, u32 value)
 {
-	int ret = 0;
+	struct smu_context *smu = handle;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
+		return;
 
 	mutex_lock(&smu->mutex);
 
 	if (smu->ppt_funcs->set_fan_control_mode)
-		ret = smu->ppt_funcs->set_fan_control_mode(smu, value);
+		smu->ppt_funcs->set_fan_control_mode(smu, value);
 
 	mutex_unlock(&smu->mutex);
 
-	return ret;
+	return;
 }
 
-int smu_get_fan_speed_percent(struct smu_context *smu, uint32_t *speed)
+int smu_get_fan_speed_percent(void *handle, u32 *speed)
 {
+	struct smu_context *smu = handle;
 	int ret = 0;
 	uint32_t percent;
 	uint32_t current_rpm;
@@ -2159,8 +2162,9 @@ int smu_get_fan_speed_percent(struct smu_context *smu, uint32_t *speed)
 	return ret;
 }
 
-int smu_set_fan_speed_percent(struct smu_context *smu, uint32_t speed)
+int smu_set_fan_speed_percent(void *handle, u32 speed)
 {
+	struct smu_context *smu = handle;
 	int ret = 0;
 	uint32_t rpm;
 
@@ -2181,8 +2185,9 @@ int smu_set_fan_speed_percent(struct smu_context *smu, uint32_t speed)
 	return ret;
 }
 
-int smu_get_fan_speed_rpm(struct smu_context *smu, uint32_t *speed)
+int smu_get_fan_speed_rpm(void *handle, uint32_t *speed)
 {
+	struct smu_context *smu = handle;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -2564,7 +2569,13 @@ int smu_gfx_state_change_set(struct smu_context *smu, uint32_t state)
 
 static const struct amd_pm_funcs swsmu_pm_funcs = {
 	/* export for sysfs */
+	.set_fan_control_mode  = smu_set_fan_control_mode,
+	.get_fan_control_mode  = smu_get_fan_control_mode,
+	.set_fan_speed_percent = smu_set_fan_speed_percent,
+	.get_fan_speed_percent = smu_get_fan_speed_percent,
 	.get_performance_level = smu_get_performance_level,
+	.get_fan_speed_rpm     = smu_get_fan_speed_rpm,
+	.set_fan_speed_rpm     = smu_set_fan_speed_rpm,
 	.switch_power_profile  = smu_switch_power_profile,
 	/* export to amdgpu */
 	.set_mp1_state         = smu_set_mp1_state,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

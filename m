Return-Path: <SRS0=GAon=HZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5BAC433E6
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 04:21:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 023D560C41
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 04:21:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 023D560C41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A88356E165;
	Tue, 23 Feb 2021 04:21:47 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFE1689D67
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Feb 2021 04:21:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjVAYcqrstSmOXzambG/4gjlEzA0SnjMUSCWPMQ7PhmgNaumjJx1jw/lb1aKv7i0b9G+oSdjK2gke9yqI+J43th9YpmTc2CNSQFaKUfQAllStCMmSaBdsZ30kdsupO5rpZvM3KRhWm6+6sZ4QmTJh3W49psXcRm4vHS4TBI+SFXbJZCkR/0RDI8oluFSNuZKWvl3kyFDL0kyYWoFgwYD0yc24IPJ/O2gztWZdYqd7YGn7m8hLtgXoIpPPFHBUOLeAtJKy/6Zeo0htwmV1/of5zTz/LlQ67Bppz2QJPrFEzJXNBkQ6lWA4LT5Yjh1PHp85/gqJZ86bXjyzJtoEwQN0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9osJzaxK53H/W3B5FcdTfZ7ObghX8EBPiLaL7S4hoQw=;
 b=HSZnLYjQ4XhFwqaF3foCHtKwvH30bWGOsU8RH1En1OKTrcQI9kHk+pTmS0OopIkyL2cRb2pCBaKq/uc1LUqvAlZAHfwxgIXuzIK6ueEY3AVO9udDWCwswRI6CEGFe5A+5Pq4mhZ8PAOpy+wdicuWxxTXoJbGsX1/nwEBpdIwrusPtjkMoAhaV8gpk4E1p37ABaCNR5tewdW/p+9vySthYHL0xGI/6D9WFNZnzIXuAZsqR3MMvIHXf3YF8HPSH5TGN6zMh+5EYsrr0FQIax3n9+OboEHJHDbV1sq3yLDC+yxdRlYU+nQDKTSaQjqZgD04C1JIvWaxJuZS1mChH4lP0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9osJzaxK53H/W3B5FcdTfZ7ObghX8EBPiLaL7S4hoQw=;
 b=Sgsps5/cI4DcgHWoo1XjT4babRzy1PTbRRFpq3BLvT88BWH2VhGmpjMs1OYKcFkkjTCXkKJ76aQFU8e+26hwFlupkqNNY8xnrnaJNMYg18LF0K4vsezQpby4mi2bIvVjpQEFYc0bgzAo8D8XyymA/8ZxkPz98viKY+EKYW0dYIo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2954.namprd12.prod.outlook.com (2603:10b6:5:188::22)
 by DM6PR12MB4515.namprd12.prod.outlook.com (2603:10b6:5:2a1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Tue, 23 Feb
 2021 04:21:41 +0000
Received: from DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::19b:66f9:83d9:7cb1]) by DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::19b:66f9:83d9:7cb1%3]) with mapi id 15.20.3846.039; Tue, 23 Feb 2021
 04:21:40 +0000
From: Darren Powell <darren.powell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/8] amdgpu/pm: Powerplay API for smu ,
 changed 6 pm hwmon fan functions to use API
Date: Mon, 22 Feb 2021 23:20:27 -0500
Message-Id: <20210223042032.3078-4-darren.powell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210223042032.3078-1-darren.powell@amd.com>
References: <20210223042032.3078-1-darren.powell@amd.com>
X-Originating-IP: [142.126.154.129]
X-ClientProxiedBy: YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::22) To DM6PR12MB2954.namprd12.prod.outlook.com
 (2603:10b6:5:188::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (142.126.154.129) by
 YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.30 via Frontend Transport; Tue, 23 Feb 2021 04:21:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 08e93891-a89c-47c7-85a1-08d8d7b284b0
X-MS-TrafficTypeDiagnostic: DM6PR12MB4515:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB451582492F174FAB218B11DBF0809@DM6PR12MB4515.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:302;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xwDd3ISC3tVkVeLC2HaGceEHU3xmmCpvcThjt580sGSiBM2IsW4eZnVWtyke3UcxbG/hOB8Wh5ahBR5lSAq7tFmxKN5gCaWXE8YTjgBAWnCINaKYTn2+uENgH07nkdfIMO4FcsH/Z1v3u5heybrr+GRfUJ4nvTACKiSAOtDynPdIVUD4zTgmD3SU/njaOOml2/DH9Als6Hl5oq+mBZRXenlwAR1XellEUbtTqLzh2p/N4KsRezIcUFcjhA+dBvqpCo3VauKjfGOJJtWVz2s67+OHdcNv0SEqlE7l98AuTLWyAQMMHjeYJRHwzBuFMnbPepwhmEpkYdQAonsbYFMv5K99g3Y7/svccvySMQ3zfaMy9UmvDEB+FxEJ0sGolRMKfYtS80Hs2K4L+m+dLuYGr3y6+Ib9ZYFzlhGZQ4+1PEp0B4R+KdspW9dFirypckf86l+7RwmXswUqqTNSeKwk1kD6MAkeQRwRSuzGtGefZUsJJfNlYp6QH1F/PURzN/vfqVkLRFwPGcLVZtXURMuBL0A3wzMCLdf5U4PrKOYiZd1mkNnDR4j6IYct4h1NNE/6AVAyk77x3aUiPYTtjlkBTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2954.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(83380400001)(26005)(86362001)(54906003)(52116002)(5660300002)(66476007)(6486002)(66946007)(30864003)(66556008)(69590400012)(478600001)(36756003)(1076003)(16526019)(186003)(6512007)(2906002)(6506007)(6666004)(8936002)(4326008)(316002)(8676002)(44832011)(956004)(6916009)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?B06ih0ri9WUS4d5P/fBH7je6FtcyyBrgDUDYmhNfZ+wwPu04sxDmSbrtb9mo?=
 =?us-ascii?Q?0BtKwT8w4y0jLceqZXqw8bxdi+4v/KYeFsxyiuvTw+GFn0Z9cnYZHMgJQ6ol?=
 =?us-ascii?Q?GRaB3ZKOT3a1gMnPOtLUIAi5lvtrStXOjoQGAZHLd96yLbVZSCOlDL2tPDEo?=
 =?us-ascii?Q?a9VaV5Ca5Mn09UjR0kg2+iguteHmJpnnmVo5TCnqkb2K0Kfopxw4skFtLTdG?=
 =?us-ascii?Q?c2aGqiRcP7oppv76y21GQWnght84Wcdj+KaUnhTkVUqp226JFhnmsELJl8e4?=
 =?us-ascii?Q?uktgwHaYcM32YtADAB56JQzXaWGIhN3JdOc82+D1sOYV0cmVSy9aoCiFd115?=
 =?us-ascii?Q?v2GpaKHeUha+FPJOmEtvK8kp3ivel/YrmykVGFTBPVmtGvKMkIoxASYtaKO+?=
 =?us-ascii?Q?G6W2QPP0jUGRyMIEdvRnuHP0E90cX3uRKinnaKnkDyTc4DsEWUVDMu1XDqLS?=
 =?us-ascii?Q?pnn+WStBsMfO8j4Ck0H+bumneX5Jwtmdk+gdijOt7mBediPGB+n7MuV+O3tY?=
 =?us-ascii?Q?CH5V4jKlV2/KuF4KI1hywpU25wM1B1CL5tmEKIJ+9p80W3M/mdjtcM6EkB0L?=
 =?us-ascii?Q?GECzKJiR6ms6eREsVpJ76FR1ZgVXhejmJl13UkVMC6OX8UOjWP7962GKeO+2?=
 =?us-ascii?Q?w4DPxhDZdWK54u61OtmO4SSTAn2i1fCe0xn2Mw/1gTniI3Z47hhK8tkhyQOj?=
 =?us-ascii?Q?CUAfo8xooQD9871eGplgsro75pKFubTf+m0kc6/h/q+uAFgWeGNVoZKmy1Q1?=
 =?us-ascii?Q?XXwUbesOn3MBBm8cDeFDe/z989DmuBKnrMfnCwYFjjgYnNOKvcTpm98bC782?=
 =?us-ascii?Q?Dr3kcp8oJtOnwTIOj5AZUNiuS65pwxf5WmbAbo/KpqO1V2wUDQzr7jkP+AeW?=
 =?us-ascii?Q?Fop0nBs35G0Uz+K0OJJU6OfWK9tj/hWeuKLLdV7LnZlhcndqP92+dE4xLfzW?=
 =?us-ascii?Q?RPM85MbGwL+igj9G/wi61j0o8RiUoOtnUjHVufANxcTI7K2veJoE2FjrMpfu?=
 =?us-ascii?Q?pPuL/HSxQe4tKbTLyJ3msQloa4VTyDH03pwgZKa5OAWLhmlqHbVtd0/WGrdZ?=
 =?us-ascii?Q?0Lt7NOCSP7CdEuIfp85MbYvXd/wT9zgnlppgedfBYz0/DFMr479l/7/oqlCB?=
 =?us-ascii?Q?wlqsROh1kY7Dssyci8aP73gpgfXoJk+RXCeSIhfofxABoHLSUFYneeZrgOqU?=
 =?us-ascii?Q?czBSNb8T1qWcH7MSJ+xhavpQVebPfS55JOKSKmanW5Q9dFrkrI/Yscd5Ln93?=
 =?us-ascii?Q?jBkiqjJldXNeEJI3QGFfK0ohRu1qyge7sdNcaw7H8Ed4+nwTFPtPh5W9YIwT?=
 =?us-ascii?Q?eFLZeUY67mKAhKzcl4uNX5yp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e93891-a89c-47c7-85a1-08d8d7b284b0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 04:21:40.5275 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Af4rBW3RseWveB2nbFQxaMnx8nnzsCEr0oBf1+o+INS3P+cHSOQcLfCSL2+seON5EXO6FvU3hUhOJqda1emxWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4515
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Darren Powell <darren.powell@amd.com>
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
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c        | 95 ++++++++---------------
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   | 11 +--
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 34 ++++++--
 3 files changed, 63 insertions(+), 77 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index ab26915add47..81ebeff599e2 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2511,22 +2511,18 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struct device *dev,
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
@@ -2551,18 +2547,14 @@ static ssize_t amdgpu_hwmon_set_pwm1_enable(struct device *dev,
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
 
@@ -2601,11 +2593,7 @@ static ssize_t amdgpu_hwmon_set_pwm1(struct device *dev,
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
@@ -2622,9 +2610,7 @@ static ssize_t amdgpu_hwmon_set_pwm1(struct device *dev,
 
 	value = (value * 100) / 255;
 
-	if (is_support_sw_smu(adev))
-		err = smu_set_fan_speed_percent(&adev->smu, value);
-	else if (adev->powerplay.pp_funcs->set_fan_speed_percent)
+	if (adev->powerplay.pp_funcs->set_fan_speed_percent)
 		err = amdgpu_dpm_set_fan_speed_percent(adev, value);
 	else
 		err = -EINVAL;
@@ -2655,9 +2641,7 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device *dev,
 		return err;
 	}
 
-	if (is_support_sw_smu(adev))
-		err = smu_get_fan_speed_percent(&adev->smu, &speed);
-	else if (adev->powerplay.pp_funcs->get_fan_speed_percent)
+	if (adev->powerplay.pp_funcs->get_fan_speed_percent)
 		err = amdgpu_dpm_get_fan_speed_percent(adev, &speed);
 	else
 		err = -EINVAL;
@@ -2690,9 +2674,7 @@ static ssize_t amdgpu_hwmon_get_fan1_input(struct device *dev,
 		return err;
 	}
 
-	if (is_support_sw_smu(adev))
-		err = smu_get_fan_speed_rpm(&adev->smu, &speed);
-	else if (adev->powerplay.pp_funcs->get_fan_speed_rpm)
+	if (adev->powerplay.pp_funcs->get_fan_speed_rpm)
 		err = amdgpu_dpm_get_fan_speed_rpm(adev, &speed);
 	else
 		err = -EINVAL;
@@ -2783,9 +2765,7 @@ static ssize_t amdgpu_hwmon_get_fan1_target(struct device *dev,
 		return err;
 	}
 
-	if (is_support_sw_smu(adev))
-		err = smu_get_fan_speed_rpm(&adev->smu, &rpm);
-	else if (adev->powerplay.pp_funcs->get_fan_speed_rpm)
+	if (adev->powerplay.pp_funcs->get_fan_speed_rpm)
 		err = amdgpu_dpm_get_fan_speed_rpm(adev, &rpm);
 	else
 		err = -EINVAL;
@@ -2817,10 +2797,7 @@ static ssize_t amdgpu_hwmon_set_fan1_target(struct device *dev,
 		return err;
 	}
 
-	if (is_support_sw_smu(adev))
-		pwm_mode = smu_get_fan_control_mode(&adev->smu);
-	else
-		pwm_mode = amdgpu_dpm_get_fan_control_mode(adev);
+	pwm_mode = amdgpu_dpm_get_fan_control_mode(adev);
 
 	if (pwm_mode != AMD_FAN_CTRL_MANUAL) {
 		pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
@@ -2835,9 +2812,7 @@ static ssize_t amdgpu_hwmon_set_fan1_target(struct device *dev,
 		return err;
 	}
 
-	if (is_support_sw_smu(adev))
-		err = smu_set_fan_speed_rpm(&adev->smu, value);
-	else if (adev->powerplay.pp_funcs->set_fan_speed_rpm)
+	if (adev->powerplay.pp_funcs->set_fan_speed_rpm)
 		err = amdgpu_dpm_set_fan_speed_rpm(adev, value);
 	else
 		err = -EINVAL;
@@ -2868,18 +2843,14 @@ static ssize_t amdgpu_hwmon_get_fan1_enable(struct device *dev,
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
 
@@ -2916,16 +2887,12 @@ static ssize_t amdgpu_hwmon_set_fan1_enable(struct device *dev,
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
index d96692d9e794..81ee621df448 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1233,7 +1233,7 @@ int smu_check_fw_status(struct smu_context *smu);
 
 int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled);
 
-int smu_set_fan_speed_rpm(struct smu_context *smu, uint32_t speed);
+int smu_set_fan_speed_rpm(void *handle, uint32_t speed);
 
 int smu_get_power_limit(struct smu_context *smu,
 			uint32_t *limit,
@@ -1255,11 +1255,12 @@ int smu_set_power_profile_mode(struct smu_context *smu,
 			       long *param,
 			       uint32_t param_size,
 			       bool lock_needed);
-int smu_get_fan_control_mode(struct smu_context *smu);
+u32 smu_get_fan_control_mode(void *handle);
 int smu_set_fan_control_mode(struct smu_context *smu, int value);
-int smu_get_fan_speed_percent(struct smu_context *smu, uint32_t *speed);
-int smu_set_fan_speed_percent(struct smu_context *smu, uint32_t speed);
-int smu_get_fan_speed_rpm(struct smu_context *smu, uint32_t *speed);
+void smu_pp_set_fan_control_mode(void *handle, u32 value);
+int smu_get_fan_speed_percent(void *handle, u32 *speed);
+int smu_set_fan_speed_percent(void *handle, u32 speed);
+int smu_get_fan_speed_rpm(void *handle, uint32_t *speed);
 
 int smu_set_deep_sleep_dcefclk(struct smu_context *smu, int clk);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index ef1dfd1bb294..b7fe56b9e33e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2029,8 +2029,9 @@ int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled)
 	return ret;
 }
 
-int smu_set_fan_speed_rpm(struct smu_context *smu, uint32_t speed)
+int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
 {
+	struct smu_context *smu = handle;
 	u32 percent;
 	int ret = 0;
 
@@ -2265,12 +2266,13 @@ int smu_set_power_profile_mode(struct smu_context *smu,
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
 
@@ -2287,7 +2289,7 @@ int smu_set_fan_control_mode(struct smu_context *smu, int value)
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
+		return  -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
@@ -2307,8 +2309,16 @@ int smu_set_fan_control_mode(struct smu_context *smu, int value)
 	return ret;
 }
 
-int smu_get_fan_speed_percent(struct smu_context *smu, uint32_t *speed)
+void smu_pp_set_fan_control_mode(void *handle, u32 value) {
+	struct smu_context *smu = handle;
+
+	smu_set_fan_control_mode(smu, value);
+}
+
+
+int smu_get_fan_speed_percent(void *handle, u32 *speed)
 {
+	struct smu_context *smu = handle;
 	int ret = 0;
 	uint32_t percent;
 
@@ -2330,8 +2340,9 @@ int smu_get_fan_speed_percent(struct smu_context *smu, uint32_t *speed)
 	return ret;
 }
 
-int smu_set_fan_speed_percent(struct smu_context *smu, uint32_t speed)
+int smu_set_fan_speed_percent(void *handle, u32 speed)
 {
+	struct smu_context *smu = handle;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -2352,8 +2363,9 @@ int smu_set_fan_speed_percent(struct smu_context *smu, uint32_t speed)
 	return ret;
 }
 
-int smu_get_fan_speed_rpm(struct smu_context *smu, uint32_t *speed)
+int smu_get_fan_speed_rpm(void *handle, uint32_t *speed)
 {
+	struct smu_context *smu = handle;
 	int ret = 0;
 	u32 percent;
 
@@ -2738,7 +2750,13 @@ int smu_gfx_state_change_set(struct smu_context *smu, uint32_t state)
 
 static const struct amd_pm_funcs swsmu_pm_funcs = {
 	/* export for sysfs */
+	.set_fan_control_mode  = smu_pp_set_fan_control_mode,
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

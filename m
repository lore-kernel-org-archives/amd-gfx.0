Return-Path: <SRS0=C/bZ=FX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E2DC3526C
	for <amd-gfx@archiver.kernel.org>; Sat, 19 Dec 2020 00:49:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A43832343F
	for <amd-gfx@archiver.kernel.org>; Sat, 19 Dec 2020 00:49:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A43832343F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13E2A89CB5;
	Sat, 19 Dec 2020 00:49:09 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A989389C82
 for <amd-gfx@lists.freedesktop.org>; Sat, 19 Dec 2020 00:49:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=myuyhNc9C1+a4tK+OiAlgrwc3rrtfdEK95Gtn+YyXdRMkMuQeOrMG6tOIYVzcCZ4KhuUdyoDfqZeNwV2CY0wbdPGgemW6CKcjOFU4nVY3SRZBlXkcakmQZ6lXrwADiizzoabSK8ddLkpTlbMt7+R3PNnFohL73LfrffrdtgdUsnlj6dgJ8iqn9rMOjrQl7Jz2p1q4UXv80UMfuARX4zXH+zU6r+uGBTugRmfWsG0m5yGbn+NBOc+sQ3HFW8wBNV072fcA63ACB+2qyIyKYOq+ls35ZVP/qYsy0/+7F+dolbxOSPqBkLjdXuJBQJ+E7AOiay5wKFllu7NVKNwFfnEAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QdNvxDD3qNmdyHaTkrowUtu8OPZz1/SDBRZde+4VfE=;
 b=cvoQ3/3HTRF8wxABc5JvYX1zQaGMmTN2cMWIjnZrCDRAEB5PGCxrtiTcu63UBV7aG7nAC6et+Up1kYrPSxOMdCl9LRjdP4RGaxXdhR8BJjvPpkWpoxyrGNM+SEKQRMYFiD/IdtHE/mcwXnY0dLcvUT93bJsH0ZAu8nvTt9MBLjOsGV9zsQI2csmSpn/NxM13Tv+lgKx95/2trIbUu5JfdIQQKy5jHa6qGxfLxo1aO9w79tDVItjLj6dHg0BbOPbHZh8lGwMi99r4ippPDNJ8HBkL1TK74gBVIGUmk8tqgtt7FT8cHJG9CR9Zq2Sbw2wUlCXAX9XV/X8kF3cJZb77lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QdNvxDD3qNmdyHaTkrowUtu8OPZz1/SDBRZde+4VfE=;
 b=jbJOoB0wifiKwDXEybvJ2kB7Z7P/jdbs0xGeqAtR4kdgRXA1Zqvvr/E5/9iRsJ8ntkf6DP6HaKbES3Pk8OqEbaB2jxcL6OXYy9h1a1+Z3goaKZ9fj1Tv4oRIJbmkbxKo5IS2nx4dQBS2/dYNBUz0t5ufWibZ/Idt4VfMIo03Q5w=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2959.namprd12.prod.outlook.com (2603:10b6:208:ae::29)
 by MN2PR12MB3279.namprd12.prod.outlook.com (2603:10b6:208:105::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.15; Sat, 19 Dec
 2020 00:49:06 +0000
Received: from MN2PR12MB2959.namprd12.prod.outlook.com
 ([fe80::dd1e:ce4b:cd7e:2804]) by MN2PR12MB2959.namprd12.prod.outlook.com
 ([fe80::dd1e:ce4b:cd7e:2804%7]) with mapi id 15.20.3654.020; Sat, 19 Dec 2020
 00:49:06 +0000
From: Darren Powell <darren.powell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/8] amdgpu/pm: Powerplay API for smu ,
 changed 6 pm hwmon fan functions to use API
Date: Fri, 18 Dec 2020 19:48:26 -0500
Message-Id: <20201219004831.13527-4-darren.powell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201219004831.13527-1-darren.powell@amd.com>
References: <20201219004831.13527-1-darren.powell@amd.com>
X-Originating-IP: [142.126.168.115]
X-ClientProxiedBy: YT1PR01CA0114.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::23) To MN2PR12MB2959.namprd12.prod.outlook.com
 (2603:10b6:208:ae::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (142.126.168.115) by
 YT1PR01CA0114.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.28 via Frontend Transport; Sat, 19 Dec 2020 00:49:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 406bdd69-6e37-4e84-26d3-08d8a3b7e38e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3279:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3279EA4177600466C0BBD946F0C20@MN2PR12MB3279.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GpQHVllozlrUWGYGsoJstzqxA1QzdXEox8k7FO38QEeIo/HrqYeIe6BeQ6zpkZQhVPZkyfSLscbDO8DEptUDOicf0K1/zRisOQw/tuElwhm2rtxnHmI/Z9JS5cw/xhw1zicvrD/vBFvRZnrvc//+JcZ8X9VXNdN6bze/9jHGjl7UFaDbd9x9aZ6dG7a21aTNa0JR9bhPcPuhNa3a90XqRx8w/ZfdIh5BMXVWYLbkhSC4rCHRH/Jb/To8ztZVw2N7wDubemTPB2cVfSH85qo6EJQweUaFZG4JhAXAk3yIGzTr1dnygnQdIG2qNd4UTJuwBhg0WIT3QbXkfK9VxiBnCGSo3J2+dGT9u+gMjyiUHKc9cpZXu1l6WNVCGR7qji8q
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2959.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(956004)(2616005)(44832011)(26005)(66476007)(66946007)(6506007)(6666004)(86362001)(66556008)(5660300002)(69590400008)(36756003)(1076003)(83380400001)(186003)(30864003)(316002)(16526019)(52116002)(6916009)(2906002)(4326008)(8936002)(6512007)(8676002)(6486002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?O5IHInXBH369CJ8ElK6xzmkZDIySkDgDTKrBMf631XVUL9BgA5RbjxNnNrY0?=
 =?us-ascii?Q?FKcuPvm87FGepigd0MkQRQXoPCw22wmYacqOk8nw+6OUlfw33PTOQQ/sf2aU?=
 =?us-ascii?Q?rhT9JwQQu+DsUfPScMiq5Ia40/y4RSLGNFBisjHZ7tr5Br9beBEoWwXjHkIJ?=
 =?us-ascii?Q?2RAyglBCBwolVeNACct07bRCIfWMjktwR7MV7aCmMVOQIHyYGGY76uu3Z3A8?=
 =?us-ascii?Q?si7e47biZ+hAc/e0nl4IMnMxQa0mCC3sQJbIu4fvCWgXQRsQ9rdTV+AAk1mH?=
 =?us-ascii?Q?AEG5wM+YF7l55aL4HG2oLWLXhQd+7vrvQacmHjdZVN+jJBihpZxVvT4UZgOC?=
 =?us-ascii?Q?a0h86bNRTgqlfqccQszCsrym1iwxSRldjZQglcfkDNwtaiqlEFjFKxtwIoX/?=
 =?us-ascii?Q?ZF3W+ypNVcJm3QXzUWkW7eDL30+HI9P69JTBRZQu8wzY8VP217OKhlDMyBPH?=
 =?us-ascii?Q?uiwPcct4lIUlvDOFDowKnNIUPfbUpEW8If1ImRcjflq5YHoDWsOXFoj1D94d?=
 =?us-ascii?Q?SyxirypqAe0NIsMvORDXIji5TRm3nbY+9WjvqQcLYpZph0t46xVzl6Iodq80?=
 =?us-ascii?Q?zvHCHuHMVOJ090nTVmkNbfPP2ZNC5HBvwtJo2lRuxyK2e8oCGg6AkCxxZNMD?=
 =?us-ascii?Q?fYJPzNuY0QiMfFEh2FRoowp0MkVPDm+QqiGmo/pxqx3r6XhZqXMFws2tLkxX?=
 =?us-ascii?Q?whdAU+xHXDc47p3XYNgfZwAPzf3YNhTy28PUtJdZr70wHykwr0Fwx6+ubIP3?=
 =?us-ascii?Q?n9Ouo41KoeXl0Ge0pDHDoFSRoScu4sQHA+Ztmk6iGjCrdHYoaSgK1zb0Nxee?=
 =?us-ascii?Q?Kt2Zr/ca6gODbl/UEg53hdzl+75xYtFKct958dkxzN0RZTi8Aoh05a84FZzA?=
 =?us-ascii?Q?8hhOqQwH0z2MRECXnejf9tsWxTMqrktQPzl5i6YK2xR5ruT7XgncpT+gbOLG?=
 =?us-ascii?Q?nZYv5f27ZRC+l4mqM03XI/n0CEP7J6bl4iIJBQJihh58j5X6hJ1zoK9Dnve/?=
 =?us-ascii?Q?Ero5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2959.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2020 00:49:06.0994 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 406bdd69-6e37-4e84-26d3-08d8a3b7e38e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LjZiZEoo7d0Tf/P6qx+xG+75bMmxIA1f8dtFtzOFuwEWa0an/WRi2Mx+zz0cKCgYvip8o36fC6rCzxEgtkmdeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3279
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
 drivers/gpu/drm/amd/pm/amdgpu_pm.c        | 87 +++++++----------------
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   | 12 ++--
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 33 ++++++---
 3 files changed, 55 insertions(+), 77 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 0008bbe971d6..b345c29147b9 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2349,18 +2349,14 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struct device *dev,
 		return ret;
 	}
 
-	if (is_support_sw_smu(adev)) {
-		pwm_mode = smu_get_fan_control_mode(&adev->smu);
-	} else {
-		if (!adev->powerplay.pp_funcs->get_fan_control_mode) {
+	if (!adev->powerplay.pp_funcs->get_fan_control_mode) {
 			pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 			pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 			return -EINVAL;
-		}
-
-		pwm_mode = amdgpu_dpm_get_fan_control_mode(adev);
 	}
 
+	pwm_mode = amdgpu_dpm_get_fan_control_mode(adev);
+
 	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 
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
index 5f33439782c4..acde0e831bb8 100644
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
@@ -2100,9 +2101,10 @@ int smu_set_power_profile_mode(struct smu_context *smu,
 }
 
 
-int smu_get_fan_control_mode(struct smu_context *smu)
+u32 smu_get_fan_control_mode(void *handle)
 {
-	int ret = 0;
+	struct smu_context *smu = handle;
+	u32 ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
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
 
 static const struct amd_pm_funcs swsmu_dpm_funcs = {
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

Return-Path: <SRS0=mwd6=IK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AFDC433E6
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 21:03:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6315E64F2A
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 21:03:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6315E64F2A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 250586E03E;
	Fri, 12 Mar 2021 21:03:55 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A04B46E027
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Mar 2021 21:03:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=msk0UOVkm8Jp31F2H6USpw/bDUZHgKxsRFkIUxnGP5Gu/7S6V8jpItr0upLr910NFLG5BQpyTTDMPcee7X/mhNNEnFnQap13SCp0trmEvXFgNh7L3+OEdKLu1oH9w1a//dw4QothgjuGOjKvfr9B4GN5nQSPsI5+SPKLyqPDjSBFJ6nQmKbwT4Jyf1/hk17xHwNnZcAWyMO/1Uqa+IJtGQy2hoTA7mUXI3qLoFxJc8iwmth65TxRMV5KPkmjtGK3CqFproF+gYLKXLixIk/+l8637CAOwlmyL6QzwCLBG3Oh6sMyFL9fWhUgBYX/gdZYQdFJr93YGdlqzkfkuRV8LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKYW4AZag99IDLhjdiSjWv/gFrWhiEQ+yFl21/wTP+w=;
 b=AhZZxTmrTe3R1XCal+BWQI0A8eX2TmKBrO3zV8QDg8xY4aOyqOd5Z0+ao2GYJSh7Lwrvmrv7REZP+3AHhIwzo5/Bwr0HYzxpI2DRq3Ts06A9qr4XkZqPo3Zq32ZK5XRiaV2LN1ta95klYNhWLFsJz3rTHJWVymXNzyTBjoVP71lPdFJqTY11P39kkc7lNy5lg8OtUtJ8Zifeyhl9Fvay7lLFXEpYAK5jk8ywFF4ajcj1Mmbek/C1Yz18lQ1UzFOKEHeXzjTDCqi9aZO2E9QXLZs43py5DZEty3JZD3bweOU2cz0ZPPKAKnE49rah88HPoQEcb0s3UnaYabdHTY8Y1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKYW4AZag99IDLhjdiSjWv/gFrWhiEQ+yFl21/wTP+w=;
 b=SXeFppkke7tuW4bF9SA3HfzSXQfvgibTDfOYXTpw5N+N+FR7AnUzNyOB+rHioZvNQOkfpwEQdKWI5Cye+yK06WtT9E7mqso3KmPmvGCAvQgIqGPycPaxFLsLxiMC8104b327glrt1pHOOyWX90Z+uVqgg2MX6EHCpjGS7q208Mg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0234.namprd12.prod.outlook.com (2603:10b6:4:56::22)
 by DM6PR12MB4713.namprd12.prod.outlook.com (2603:10b6:5:7d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 12 Mar
 2021 21:03:48 +0000
Received: from DM5PR1201MB0234.namprd12.prod.outlook.com
 ([fe80::70d3:105f:f05e:66b8]) by DM5PR1201MB0234.namprd12.prod.outlook.com
 ([fe80::70d3:105f:f05e:66b8%9]) with mapi id 15.20.3912.030; Fri, 12 Mar 2021
 21:03:48 +0000
From: Eric Huang <jinhuieric.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/pm: add a new sysfs entries for default power
 limit
Date: Fri, 12 Mar 2021 16:03:03 -0500
Message-Id: <20210312210304.23049-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [2607:9880:2048:122:94cc:f8dc:e7db:eaee]
X-ClientProxiedBy: YT1PR01CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::21)
 To DM5PR1201MB0234.namprd12.prod.outlook.com
 (2603:10b6:4:56::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from eric-HP-EliteBook-745-G4.amd.com
 (2607:9880:2048:122:94cc:f8dc:e7db:eaee) by
 YT1PR01CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.26 via Frontend Transport; Fri, 12 Mar 2021 21:03:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5077ec6d-9534-4097-b1e9-08d8e59a547a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4713:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4713C36D86228DFCCB225E8C826F9@DM6PR12MB4713.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:321;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bvdO3rYFR1AVrkCKqDFypw2nsnvbRH1LFWOfO9u9jxdMq2bmVv7p0yE2ADU101py+jcADXSZtGxlPl7hnL35yWvV4MMq4WWlzEgRcCM3wHYG+eOVrehGxHJXK0bhS+VkDYCWqVO39E/ryKQeMfjAeDA4eNo1+TziHMvZAatZUr3cbhKG7C/STc9wE1bJFxBfFFJtfmOin+3sh49BkLibyhtkhvmtOFEPT3gUavvIxiojrgA7EJiCY6HAQrFjKmUMXiFLM4nb+dDM7PKyRXCG4iLMLMTTUCpOJRfC/Sljiv4g0yGdQNxz7MpCvbSOTt5DNTlrKA2SiKlusqd3jDK9ULJgDq+MnKgpUzlbsdTLbqoPMSSuoTAQwoL033jmuYuARMnrW2Uantak907UD81wR45VasdpI5AHFDY8C65vVm53DAW2L0sbd1JKBwkDPIhscf+uomuw1ll028v87Bh0jYsl/DaKmRBWRWUdP+9hPuZ81vo/ta/WMuXWLibbYNLeh5Gb19tw3v7XdAqbKjikkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0234.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(478600001)(83380400001)(2906002)(66946007)(52116002)(16526019)(4326008)(316002)(8936002)(66476007)(30864003)(186003)(5660300002)(6486002)(6916009)(7696005)(66556008)(8676002)(6666004)(86362001)(1076003)(36756003)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?l3kD/EVz7FpgnBU+JApckzgHkd8vTJZoKJnxTSCHK+lemr5lcdriWbcV3/J8?=
 =?us-ascii?Q?CgYYXKybWIRQXct7G0EWs2GuIcFWbKxPrUyTJKA4AAxNpMdOWNVJde7wK1tM?=
 =?us-ascii?Q?CBf5jCP6RfLj/T41qLNMYuhIzEFqF0fjCq5kihnv/CdkFI4PrBlKZePRgEyr?=
 =?us-ascii?Q?mj4sTT6i60lEpKWdaDuOhO65LdfCDkb8oQejLsi39WKC/OgyA2iFeRq0S1vP?=
 =?us-ascii?Q?qjzmnWmY0Eyd/9QiTBU0yBe8vShqTLYqVGCpBRgu8jQQN7XD/prjAMIk1n4Z?=
 =?us-ascii?Q?xMp34yr2cCNvca56YZGXWSCSH4hV03CcasmagV3IAPEr69LJnMur5bSYb+9i?=
 =?us-ascii?Q?5YVqHRhej9Jmx7dhyjeu+HP1hv0S+0I6UnK78LXKJW+F/Kjb1JXbKUjLGnns?=
 =?us-ascii?Q?yqbyWhN9ZQV4FABoK6PhEjHmzs933Dp2CUmhUNOwhGNt5l12x0eRGTeEcqLH?=
 =?us-ascii?Q?AyTlD5tHbNqhss2lySLq3wsxzJW9wAM4rN2Z1uMm0C8q720ltdTBAXLGheW+?=
 =?us-ascii?Q?SKiKwt5k8R9RrUa5hnO2cEC8Px+wHo3ufHRbT5HvL5TVQVaHtuAmpK1PW43h?=
 =?us-ascii?Q?bUEPPikl80nGYw0SzDLyTqU0zX1nZsxLBGmE/jnOwpi/ekGpJxx9147S5tfG?=
 =?us-ascii?Q?C5/K3mXH8Y+PrD/rKmBkrMnmsERSx5EpFPmm0bOCT+vU/ylc7wRf1niVujET?=
 =?us-ascii?Q?JC2Lhe17S6AdE/UomNgxzAtXAM8vV6IHmK4UTgqjB/17RRTShQnWTuHUnbvp?=
 =?us-ascii?Q?9YC2BMJytBzjhlP125kyegqGEci06MMgY4kc6zztHIzK+ONo206hJsk1feMU?=
 =?us-ascii?Q?YuEuio/Seo2dgSghW2QJqrfxvy5S8qN/w8ZZ479ws3gRrlTnVyMy/PTOUcBI?=
 =?us-ascii?Q?MO9c0k+k7VQ4ZD4Xz+aL+BCRHXpsb5x9ZvgSi7cY9fA6vWHRnFmxQxRlQtQG?=
 =?us-ascii?Q?yiL8zp01PKcRshf7QWtBhDzR/vp8BUnCoWeQnBzorlBsaeC7V8uabz3kY5h9?=
 =?us-ascii?Q?HSmWbR9/ckBmVUFOYFbkoN8oTgVEGxO6adiInrWJL3yvJQ/i4Jo3DEwhTI/2?=
 =?us-ascii?Q?zXVb373rat9LijLZiUjD9Oqw3AzNkfieV9XohObb+LeG6iSooRrel4OTwntB?=
 =?us-ascii?Q?i+MuJdOURAU3ErqIUUipaLtYFUpyJBmKTyRr5sOpbkOe8l3GK77Yvki6qlyD?=
 =?us-ascii?Q?/AwUXA57rbS4uf6Rvft5+N3I6HDQVKUrMOZC6qnIXngnaBGuCx01jNdQUlTm?=
 =?us-ascii?Q?W/7b0qydzVEOImy99ECbnigIUV+vjdLDmXTxVxRXN8BsOs57hrskyvaRsrEO?=
 =?us-ascii?Q?B1/zye6QbrrHGOuReJbbMJLHivD9oBKTZhpF+RQlMyq0UHNWh7ZgYBN/yr/H?=
 =?us-ascii?Q?EwI8nUqpRD0PwoiWFHYib1rW01I9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5077ec6d-9534-4097-b1e9-08d8e59a547a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0234.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 21:03:48.0695 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nFjzc6dX+t2YjFFLlNHxAkJ7ugT3vseXAf4QCZdXFztCR2TFlY6p5Mbb5ON2GaKkBy4qNaO3k4rtwvxj+eG4ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4713
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
Cc: Eric Huang <jinhuieric.huang@amd.com>, Evan.Quan@amd.com,
 Joseph.Greathouse@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Driver doesn't keep the default bootup power limit and expose it
to user. As requested, we add it in driver.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 43 ++++++++++++++++++-
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  2 +
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |  1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  3 ++
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  2 +-
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  2 +-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  2 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  8 +++-
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  2 +-
 9 files changed, 58 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 2733af2d201b..8ab6e7eaf6a1 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2677,6 +2677,41 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
 	return size;
 }
 
+static ssize_t amdgpu_hwmon_show_power_cap_default(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct amdgpu_device *adev = dev_get_drvdata(dev);
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int limit_type = to_sensor_dev_attr(attr)->index;
+	uint32_t limit = limit_type << 24;
+	ssize_t size;
+	int r;
+
+	if (amdgpu_in_reset(adev))
+		return -EPERM;
+
+	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+		return r;
+	}
+
+	if (is_support_sw_smu(adev)) {
+		smu_get_power_limit(&adev->smu, &limit, SMU_PPT_LIMIT_DEFAULT);
+		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
+	} else if (pp_funcs && pp_funcs->get_power_limit) {
+		pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit, true);
+		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
+	} else {
+		size = snprintf(buf, PAGE_SIZE, "\n");
+	}
+
+	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
+	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+
+	return size;
+}
 static ssize_t amdgpu_hwmon_show_power_label(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
@@ -2919,11 +2954,13 @@ static SENSOR_DEVICE_ATTR(power1_average, S_IRUGO, amdgpu_hwmon_show_power_avg,
 static SENSOR_DEVICE_ATTR(power1_cap_max, S_IRUGO, amdgpu_hwmon_show_power_cap_max, NULL, 0);
 static SENSOR_DEVICE_ATTR(power1_cap_min, S_IRUGO, amdgpu_hwmon_show_power_cap_min, NULL, 0);
 static SENSOR_DEVICE_ATTR(power1_cap, S_IRUGO | S_IWUSR, amdgpu_hwmon_show_power_cap, amdgpu_hwmon_set_power_cap, 0);
+static SENSOR_DEVICE_ATTR(power1_cap_default, S_IRUGO, amdgpu_hwmon_show_power_cap_default, NULL, 0);
 static SENSOR_DEVICE_ATTR(power1_label, S_IRUGO, amdgpu_hwmon_show_power_label, NULL, 0);
 static SENSOR_DEVICE_ATTR(power2_average, S_IRUGO, amdgpu_hwmon_show_power_avg, NULL, 1);
 static SENSOR_DEVICE_ATTR(power2_cap_max, S_IRUGO, amdgpu_hwmon_show_power_cap_max, NULL, 1);
 static SENSOR_DEVICE_ATTR(power2_cap_min, S_IRUGO, amdgpu_hwmon_show_power_cap_min, NULL, 1);
 static SENSOR_DEVICE_ATTR(power2_cap, S_IRUGO | S_IWUSR, amdgpu_hwmon_show_power_cap, amdgpu_hwmon_set_power_cap, 1);
+static SENSOR_DEVICE_ATTR(power2_cap_default, S_IRUGO, amdgpu_hwmon_show_power_cap_default, NULL, 1);
 static SENSOR_DEVICE_ATTR(power2_label, S_IRUGO, amdgpu_hwmon_show_power_label, NULL, 1);
 static SENSOR_DEVICE_ATTR(freq1_input, S_IRUGO, amdgpu_hwmon_show_sclk, NULL, 0);
 static SENSOR_DEVICE_ATTR(freq1_label, S_IRUGO, amdgpu_hwmon_show_sclk_label, NULL, 0);
@@ -2963,11 +3000,13 @@ static struct attribute *hwmon_attributes[] = {
 	&sensor_dev_attr_power1_cap_max.dev_attr.attr,
 	&sensor_dev_attr_power1_cap_min.dev_attr.attr,
 	&sensor_dev_attr_power1_cap.dev_attr.attr,
+	&sensor_dev_attr_power1_cap_default.dev_attr.attr,
 	&sensor_dev_attr_power1_label.dev_attr.attr,
 	&sensor_dev_attr_power2_average.dev_attr.attr,
 	&sensor_dev_attr_power2_cap_max.dev_attr.attr,
 	&sensor_dev_attr_power2_cap_min.dev_attr.attr,
 	&sensor_dev_attr_power2_cap.dev_attr.attr,
+	&sensor_dev_attr_power2_cap_default.dev_attr.attr,
 	&sensor_dev_attr_power2_label.dev_attr.attr,
 	&sensor_dev_attr_freq1_input.dev_attr.attr,
 	&sensor_dev_attr_freq1_label.dev_attr.attr,
@@ -3066,7 +3105,8 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 	      (adev->asic_type != CHIP_VANGOGH))) &&	/* not implemented yet */
 	    (attr == &sensor_dev_attr_power1_cap_max.dev_attr.attr ||
 	     attr == &sensor_dev_attr_power1_cap_min.dev_attr.attr||
-	     attr == &sensor_dev_attr_power1_cap.dev_attr.attr))
+	     attr == &sensor_dev_attr_power1_cap.dev_attr.attr ||
+	     attr == &sensor_dev_attr_power1_cap_default.dev_attr.attr))
 		return 0;
 
 	if (((adev->family == AMDGPU_FAMILY_SI) ||
@@ -3132,6 +3172,7 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 		 attr == &sensor_dev_attr_power2_cap_max.dev_attr.attr ||
 	     attr == &sensor_dev_attr_power2_cap_min.dev_attr.attr ||
 		 attr == &sensor_dev_attr_power2_cap.dev_attr.attr ||
+		 attr == &sensor_dev_attr_power2_cap_default.dev_attr.attr ||
 		 attr == &sensor_dev_attr_power2_label.dev_attr.attr ||
 		 attr == &sensor_dev_attr_power1_label.dev_attr.attr))
 		return 0;
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 5ac683fd0749..25d5f03aaa67 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -171,6 +171,7 @@ enum smu_ppt_limit_level
 {
 	SMU_PPT_LIMIT_MIN = -1,
 	SMU_PPT_LIMIT_CURRENT,
+	SMU_PPT_LIMIT_DEFAULT,
 	SMU_PPT_LIMIT_MAX,
 };
 
@@ -446,6 +447,7 @@ struct smu_context
 
 	bool od_enabled;
 	uint32_t current_power_limit;
+	uint32_t default_power_limit;
 	uint32_t max_power_limit;
 
 	/* soft pptable */
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index 907e0967a9e8..ad4db2edf1fb 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -141,6 +141,7 @@ struct smu_11_5_power_context {
 	enum smu_11_0_power_state power_state;
 
 	uint32_t	current_fast_ppt_limit;
+	uint32_t	default_fast_ppt_limit;
 	uint32_t	max_fast_ppt_limit;
 };
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 1202b9e7d0f9..e722adcf2f53 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2183,6 +2183,9 @@ int smu_get_power_limit(struct smu_context *smu,
 		case SMU_PPT_LIMIT_CURRENT:
 			*limit = smu->current_power_limit;
 			break;
+		case SMU_PPT_LIMIT_DEFAULT:
+			*limit = smu->default_power_limit;
+			break;
 		case SMU_PPT_LIMIT_MAX:
 			*limit = smu->max_power_limit;
 			break;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index f82dd8a5c773..bbc03092b0a9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1129,7 +1129,7 @@ static int arcturus_get_power_limit(struct smu_context *smu)
 		power_limit =
 			pptable->SocketPowerLimitAc[PPT_THROTTLER_PPT0];
 	}
-	smu->current_power_limit = power_limit;
+	smu->current_power_limit = smu->default_power_limit = power_limit;
 
 	if (smu->od_enabled) {
 		od_percent = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 24195b5853fb..3d0de2c958fa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2111,7 +2111,7 @@ static int navi10_get_power_limit(struct smu_context *smu)
 		power_limit =
 			pptable->SocketPowerLimitAc[PPT_THROTTLER_PPT0];
 	}
-	smu->current_power_limit = power_limit;
+	smu->current_power_limit = smu->default_power_limit = power_limit;
 
 	if (smu->od_enabled &&
 	    navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_POWER_LIMIT)) {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 94a4ea38e5f9..3621884c3293 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1736,7 +1736,7 @@ static int sienna_cichlid_get_power_limit(struct smu_context *smu)
 		power_limit =
 			pptable->SocketPowerLimitAc[PPT_THROTTLER_PPT0];
 	}
-	smu->current_power_limit = power_limit;
+	smu->current_power_limit = smu->default_power_limit = power_limit;
 
 	if (smu->od_enabled) {
 		od_percent = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index d9f60dc714bc..c5b387360f01 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1756,7 +1756,7 @@ static int vangogh_get_power_limit(struct smu_context *smu)
 		return ret;
 	}
 	/* convert from milliwatt to watt */
-	smu->current_power_limit = ppt_limit / 1000;
+	smu->current_power_limit = smu->default_power_limit = ppt_limit / 1000;
 	smu->max_power_limit = 29;
 
 	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetFastPPTLimit, &ppt_limit);
@@ -1765,7 +1765,8 @@ static int vangogh_get_power_limit(struct smu_context *smu)
 		return ret;
 	}
 	/* convert from milliwatt to watt */
-	power_context->current_fast_ppt_limit = ppt_limit / 1000;
+	power_context->current_fast_ppt_limit =
+			power_context->default_fast_ppt_limit = ppt_limit / 1000;
 	power_context->max_fast_ppt_limit = 30;
 
 	return ret;
@@ -1790,6 +1791,9 @@ static int vangogh_get_ppt_limit(struct smu_context *smu,
 		case SMU_PPT_LIMIT_CURRENT:
 			*ppt_limit = power_context->current_fast_ppt_limit;
 			break;
+		case SMU_PPT_LIMIT_DEFAULT:
+			*ppt_limit = power_context->default_fast_ppt_limit;
+			break;
 		default:
 			break;
 		}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 740025ee7f78..3c0d6231b891 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1088,7 +1088,7 @@ static int aldebaran_get_power_limit(struct smu_context *smu)
 		power_limit = pptable->PptLimit;
 	}
 
-	smu->current_power_limit = power_limit;
+	smu->current_power_limit = smu->default_power_limit = power_limit;
 	if (pptable)
 		smu->max_power_limit = pptable->PptLimit;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

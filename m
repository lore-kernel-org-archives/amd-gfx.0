Return-Path: <SRS0=BBBq=HF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FBBC433DB
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 08:26:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEE5F64F5F
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 08:26:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEE5F64F5F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 952CC6EA11;
	Wed,  3 Feb 2021 08:26:11 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750053.outbound.protection.outlook.com [40.107.75.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 790B96EA11
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Feb 2021 08:26:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KALEl03it/x0YCNh5sIISzyCWy4J0DacvnQoJJ2EyxNNgBRQcqI5lQ6MZL1k2BIAkZARPOpKmMiR19q3ZjjmsxTCAW9II0sALvVGfRz6Rj4svH3PCQ+mOq7BAGpm1s2/lXLe8+knKJyCfiCDFCNK2FDMQWH4ljbLI1l8jU7tiLHoIQim8eYimeCQhMOx/9L+6X/qJkhjtnM1nveT2GDlUIaOT/5SMGcEsGk6Qpr/HsluRHc4JzQBl+Ki8ChbGFqY+lKsSiZJBSF5dj0u7RAkpunzMFDOLSyk4Z71e9d3QgEFoJZ/okDNgxwlcYjtliec4MnVBQLwKKdkgDEgSLhTCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ni7v2Uhzs4Y0tETqMy0XKfO6C6i6Np0PILT9+oasbI=;
 b=P25edpAFbLtF4YpOZ0JMw8GQkhVZrctf8UkzegC9cv1aIjmpHlr1iKBPtRh1HBnK/UuTBYqNh0z34ny9ksCcic5UMnrTnWzjMtNlvzrWAcT8aCDCEMWQSuUKRGegVvbPJbmt2jFB0peCrRWlu0qXRwGjyPlsZxSz7NgsLT3eLXP5IkmrSs6vEniOenH2QCb5AlZMn541E1x6zLi+lfmpFwsQqtj78c5LQku4HB3ndWbFBW2Wh30ot6SINC8pHiFncDJpEa+PlX16qhM7BEQmFVSsjU89Vwy7HbBNYs5q8abgVP8kwgvN0fOJEJcLpDgT2dUkHmAuk2xhDCDfMnLCjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ni7v2Uhzs4Y0tETqMy0XKfO6C6i6Np0PILT9+oasbI=;
 b=uW4ySGQWYK0r/63KTrhgcsX0AIwMEWqihGrFpkQQ2d4B5chR+T7v3zRdMqHncYXXgS/xyHWvCTFSkTu6dXo+oCmv1vk7qePQ7pQzKYsZSryMVx5BvkBPH9MYe/DHo9Tyi+BIkJI+7ZY55eOfjUVciW7PcHqupt5JkcpWYsP/DQg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3807.namprd12.prod.outlook.com (2603:10b6:208:16c::30)
 by MN2PR12MB4287.namprd12.prod.outlook.com (2603:10b6:208:1dd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19; Wed, 3 Feb
 2021 08:26:08 +0000
Received: from MN2PR12MB3807.namprd12.prod.outlook.com
 ([fe80::7c48:cd3a:5f92:2c47]) by MN2PR12MB3807.namprd12.prod.outlook.com
 ([fe80::7c48:cd3a:5f92:2c47%4]) with mapi id 15.20.3825.017; Wed, 3 Feb 2021
 08:26:08 +0000
From: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/pm: add support for hwmon control of slow and
 fast PPT limit on vangogh
Date: Wed,  3 Feb 2021 16:25:14 +0800
Message-Id: <20210203082514.28303-2-Xiaomeng.Hou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210203082514.28303-1-Xiaomeng.Hou@amd.com>
References: <20210203082514.28303-1-Xiaomeng.Hou@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR0302CA0021.apcprd03.prod.outlook.com
 (2603:1096:202::31) To MN2PR12MB3807.namprd12.prod.outlook.com
 (2603:10b6:208:16c::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from code-machine.amd.com (180.167.199.189) by
 HK2PR0302CA0021.apcprd03.prod.outlook.com (2603:1096:202::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.10 via Frontend Transport; Wed, 3 Feb 2021 08:26:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2663339e-111b-4416-3fb2-08d8c81d5b28
X-MS-TrafficTypeDiagnostic: MN2PR12MB4287:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4287AE793A42EABB91F5329B9FB49@MN2PR12MB4287.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8fvXYH3UDJYtaznh/akzCs/KS8yS2uDMj1QLeiCy0C34r1gRsSczo7gvtbcZPN8PQsMd1p1PBrYyAeOfshXRL0CC9WbUUHEEhP4gLVGcoVSFPsNwCvuPrQAyYqikr2Y/AjjyrW5jWr890QH/JivHFXuQZ/P3/sH/3hIolzcXznUUTFeOEKTRZ+hr+DwL5nFGUK/Ib8byHt8TczaLFkwye43u5Ak76hhyS7fODd2wVQYzLOka06jdVXjHaSLDrFJZ9Dcpp7YLrj9rFjnwXhcVwc/PKiFI50hqDMsv/7x6Hj0O4ESydhZXr1X7ecpwXHvF5wh/pJQtQfleKeRWPlh5fXFKl/mxGhZMU1PY0x7EVOH70KPseTPnZcXEzMJOU78W6jDoQ4tLEarQtfYHW2TUwAl/vY9TnrskHKAJWeSqae+Aif1SBIFoKPi17LnG4uQY19FKzx/0w//YAppU6V+TAaxDN9bn6Ar+e0N3wYn0xkK43pywGmW4G9hSp1nyDrG2zTxbZvz1z3zWfMfnUlPEVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3807.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(956004)(2616005)(16526019)(186003)(36756003)(8936002)(83380400001)(5660300002)(52116002)(7696005)(478600001)(2906002)(6666004)(30864003)(86362001)(1076003)(316002)(8676002)(6486002)(66946007)(6916009)(66556008)(4326008)(66476007)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?laT/pCs51X53S+nfiWgPmINlJiG3csFKa4s17JShJIYbQ5ppRMZvp4rilkPU?=
 =?us-ascii?Q?nO2KMAdap6axok3wZdMiIIV0j148JQge6v94xfcSMib7eQE/EDrV0QqRZ+xD?=
 =?us-ascii?Q?93+YC+1yJLg41qhl+lQt+ZUuJ1C1N2aO5IgaBezzrVWB/CZjYznmgqmGNHUP?=
 =?us-ascii?Q?ffsXI2Or0kx97YctyHD6LrzlqKuaPyooiKoMtPq/PLSDGWxHfgkDN+dRmqTf?=
 =?us-ascii?Q?fN34i14NxHCJMEqSDmqJ3IE58/sZW6N4xIY5BALikmlTi72S4z/NJcBhGHJP?=
 =?us-ascii?Q?19Xw+5FlpnAWlw8f8IwcB/hBUlDlLXw/5bAqJQw8xj2v/2Ag4v7pVDTDTkff?=
 =?us-ascii?Q?ak30Ot5ixPk19qBe4gAfBIb5NZJigGRBxDobKIPMj4ub5sIxBd4eoEb4W3JY?=
 =?us-ascii?Q?o9ONvM7am+8flAKsD5hnZK8NiKDI+FTi57e+Ndp0RTARYL/Wiknv1v4cqyxu?=
 =?us-ascii?Q?4A/Bp4ShwO756BNKXWI8SbrpX1j+hfzC38FnSRzWC9+bx3uzLo2V+qOjiGUm?=
 =?us-ascii?Q?I/TkaxLhfyDoFFrYs1mKTszK/iYADllJIKZrbUpM4hJboznyWm0donAHsSLq?=
 =?us-ascii?Q?AE88DLxR6Ae8eu/luWdrU4ewvc2zCeOX145cZjG9Huqth3n+8bgXLclWeDcU?=
 =?us-ascii?Q?MK7+VVVLRbzVq8MyesIDo7g9/1pIO1KQ7ANwbmAyAShdY+2DevMDbv7u3ezP?=
 =?us-ascii?Q?ZDM5+dyG5RxbpVGtDPNsw+Pnt2nOtQ6BUw/lY6JQxESy1NE6ih6fWF38COJy?=
 =?us-ascii?Q?kwsgP4iert90X4kKxenl9eSY33gmCe6vJ6s6eoDY7osDcfu0OQhxgxdJkBY8?=
 =?us-ascii?Q?hgBlI8i03/XtGwrcHbXLNFYGvrg+H4+AiyHO1JUZXPBnVuFZd4B3eMvf952x?=
 =?us-ascii?Q?HuAhNRYSYsLt3p+dvuT3Ja7STNkhQv4fUejdfUJiYGkOimrmRAlQFae4fKKQ?=
 =?us-ascii?Q?oILOPoRZcrluc+cpG18VQ4edHYIuGDDUb9x0U4By6r90CsGqMsxpsX+bL6ut?=
 =?us-ascii?Q?Bijn5JfuMJZ2+9fpZjA9LOzCGHkZka9WPBAOM7BfilFNAQ8iyKSWIrlVNSgB?=
 =?us-ascii?Q?GoDW6POt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2663339e-111b-4416-3fb2-08d8c81d5b28
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3807.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 08:26:08.7483 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KOYWKPcBECtPTa4d9RtzvL3rUfQFkEAdT0wWht3oQvBVEW17gEz5h/aC5ci7JF3+0rHjvfpakibLjBoGRPIwWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4287
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com, Ray.Huang@amd.com,
 Xiaomeng Hou <Xiaomeng.Hou@amd.com>, Kevin1.Wang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Implement hwmon API for reading/setting slow and fast PPT limit.

APU power is managed to system-level requirements through the PPT
(package power tracking) feature. PPT is intended to limit power to the
requirements of the power source and could be dynamically updated to
maximize APU performance within the system power budget.

Here FAST_PPT_LIMIT manages the ~10 ms moving average of APU power,
while SLOW_PPT_LIMIT manages the configurable, thermally significant
moving average of APU power (default ~5000 ms).

User could read slow/fast ppt limit using command "cat power*_cap" or
"sensors" in the hwmon device directory. User could adjust values of
slow/fast ppt limit as needed depending on workloads through command
"echo ## > power*_cap".

Example:
$ echo 15000000 > power1_cap
$ echo 18000000 > power2_cap
$ sensors
amdgpu-pci-0300
Adapter: PCI adapter
slowPPT:     9.04W (cap = 15.00 W)
fastPPT:     9.04W (cap = 18.00 W)

v2: align with existing interfaces for the getting/setting of PPT
    limits. Encode the upper 8 bits of limit value to distinguish
    slow and fast power limit type.

Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  45 +++++++-
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  13 +++
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |   9 ++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  13 ++-
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |   8 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 103 ++++++++++++++++++
 6 files changed, 182 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index cf475ac01b27..d49f36b01e97 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3059,7 +3059,8 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
 					 char *buf)
 {
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
-	uint32_t limit = 0;
+	int limit_type = to_sensor_dev_attr(attr)->index;
+	uint32_t limit = limit_type << 24;
 	ssize_t size;
 	int r;
 
@@ -3093,7 +3094,8 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
 					 char *buf)
 {
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
-	uint32_t limit = 0;
+	int limit_type = to_sensor_dev_attr(attr)->index;
+	uint32_t limit = limit_type << 24;
 	ssize_t size;
 	int r;
 
@@ -3122,6 +3124,15 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
 	return size;
 }
 
+static ssize_t amdgpu_hwmon_show_power_label(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	int limit_type = to_sensor_dev_attr(attr)->index;
+
+	return snprintf(buf, PAGE_SIZE, "%s\n",
+		limit_type == SMU_POWER_LIMIT_FAST_PPT ? "fastPPT" : "slowPPT");
+}
 
 static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
 		struct device_attribute *attr,
@@ -3129,6 +3140,7 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
 		size_t count)
 {
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
+	int limit_type = to_sensor_dev_attr(attr)->index;
 	int err;
 	u32 value;
 
@@ -3143,7 +3155,7 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
 		return err;
 
 	value = value / 1000000; /* convert to Watt */
-
+	value |= limit_type << 24;
 
 	err = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (err < 0) {
@@ -3355,6 +3367,12 @@ static SENSOR_DEVICE_ATTR(power1_average, S_IRUGO, amdgpu_hwmon_show_power_avg,
 static SENSOR_DEVICE_ATTR(power1_cap_max, S_IRUGO, amdgpu_hwmon_show_power_cap_max, NULL, 0);
 static SENSOR_DEVICE_ATTR(power1_cap_min, S_IRUGO, amdgpu_hwmon_show_power_cap_min, NULL, 0);
 static SENSOR_DEVICE_ATTR(power1_cap, S_IRUGO | S_IWUSR, amdgpu_hwmon_show_power_cap, amdgpu_hwmon_set_power_cap, 0);
+static SENSOR_DEVICE_ATTR(power1_label, S_IRUGO, amdgpu_hwmon_show_power_label, NULL, 0);
+static SENSOR_DEVICE_ATTR(power2_average, S_IRUGO, amdgpu_hwmon_show_power_avg, NULL, 1);
+static SENSOR_DEVICE_ATTR(power2_cap_max, S_IRUGO, amdgpu_hwmon_show_power_cap_max, NULL, 1);
+static SENSOR_DEVICE_ATTR(power2_cap_min, S_IRUGO, amdgpu_hwmon_show_power_cap_min, NULL, 1);
+static SENSOR_DEVICE_ATTR(power2_cap, S_IRUGO | S_IWUSR, amdgpu_hwmon_show_power_cap, amdgpu_hwmon_set_power_cap, 1);
+static SENSOR_DEVICE_ATTR(power2_label, S_IRUGO, amdgpu_hwmon_show_power_label, NULL, 1);
 static SENSOR_DEVICE_ATTR(freq1_input, S_IRUGO, amdgpu_hwmon_show_sclk, NULL, 0);
 static SENSOR_DEVICE_ATTR(freq1_label, S_IRUGO, amdgpu_hwmon_show_sclk_label, NULL, 0);
 static SENSOR_DEVICE_ATTR(freq2_input, S_IRUGO, amdgpu_hwmon_show_mclk, NULL, 0);
@@ -3393,6 +3411,12 @@ static struct attribute *hwmon_attributes[] = {
 	&sensor_dev_attr_power1_cap_max.dev_attr.attr,
 	&sensor_dev_attr_power1_cap_min.dev_attr.attr,
 	&sensor_dev_attr_power1_cap.dev_attr.attr,
+	&sensor_dev_attr_power1_label.dev_attr.attr,
+	&sensor_dev_attr_power2_average.dev_attr.attr,
+	&sensor_dev_attr_power2_cap_max.dev_attr.attr,
+	&sensor_dev_attr_power2_cap_min.dev_attr.attr,
+	&sensor_dev_attr_power2_cap.dev_attr.attr,
+	&sensor_dev_attr_power2_label.dev_attr.attr,
 	&sensor_dev_attr_freq1_input.dev_attr.attr,
 	&sensor_dev_attr_freq1_label.dev_attr.attr,
 	&sensor_dev_attr_freq2_input.dev_attr.attr,
@@ -3485,8 +3509,9 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 			effective_mode &= ~S_IWUSR;
 	}
 
-	if (((adev->flags & AMD_IS_APU) ||
-	     adev->family == AMDGPU_FAMILY_SI) &&	/* not implemented yet */
+	if (((adev->family == AMDGPU_FAMILY_SI) ||
+		 ((adev->flags & AMD_IS_APU) &&
+	      (adev->asic_type != CHIP_VANGOGH))) &&	/* not implemented yet */
 	    (attr == &sensor_dev_attr_power1_cap_max.dev_attr.attr ||
 	     attr == &sensor_dev_attr_power1_cap_min.dev_attr.attr||
 	     attr == &sensor_dev_attr_power1_cap.dev_attr.attr))
@@ -3549,6 +3574,16 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 	     attr == &sensor_dev_attr_temp3_label.dev_attr.attr))
 		return 0;
 
+	/* only Vangogh has fast PPT limit and power labels */
+	if (!(adev->asic_type == CHIP_VANGOGH) &&
+	    (attr == &sensor_dev_attr_power2_average.dev_attr.attr ||
+		 attr == &sensor_dev_attr_power2_cap_max.dev_attr.attr ||
+	     attr == &sensor_dev_attr_power2_cap_min.dev_attr.attr ||
+		 attr == &sensor_dev_attr_power2_cap.dev_attr.attr ||
+		 attr == &sensor_dev_attr_power2_label.dev_attr.attr ||
+		 attr == &sensor_dev_attr_power1_label.dev_attr.attr))
+		return 0;
+
 	return effective_mode;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 44279c2afccb..6390b6155e5a 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -161,6 +161,12 @@ enum smu_power_src_type
 	SMU_POWER_SOURCE_COUNT,
 };
 
+enum smu_power_limit_type
+{
+	SMU_POWER_LIMIT_SLOW_PPT = 0,
+	SMU_POWER_LIMIT_FAST_PPT,
+};
+
 enum smu_memory_pool_size
 {
     SMU_MEMORY_POOL_SIZE_ZERO   = 0,
@@ -701,6 +707,13 @@ struct pptable_funcs {
 	 */
 	int (*get_power_limit)(struct smu_context *smu);
 
+	/**
+	 * @get_fast_ppt_limit: Get the device's fast ppt(package power tracking) limits.
+	 *
+	 * Currently applies to Vangogh asic only.
+	 */
+	int (*get_fast_ppt_limit)(struct smu_context *smu, uint32_t *fppt_limit, bool max_setting);
+
 	/**
 	 * @set_df_cstate: Set data fabric cstate.
 	 */
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index c7d57e9555cc..e6ccd422d518 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -129,6 +129,15 @@ struct smu_11_0_power_context {
 	enum smu_11_0_power_state power_state;
 };
 
+struct smu_11_5_power_context {
+	uint32_t	power_source;
+	uint8_t		in_power_limit_boost_mode;
+	enum smu_11_0_power_state power_state;
+
+	uint32_t	current_fast_ppt_limit;
+	uint32_t	max_fast_ppt_limit;
+};
+
 enum smu_v11_0_baco_seq {
 	BACO_SEQ_BACO = 0,
 	BACO_SEQ_MSR,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index c00f3f531965..69e9e8af3d4b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2046,12 +2046,17 @@ int smu_get_power_limit(struct smu_context *smu,
 			uint32_t *limit,
 			bool max_setting)
 {
+	uint32_t limit_type = *limit >> 24;
+
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
-	*limit = (max_setting ? smu->max_power_limit : smu->current_power_limit);
+	if (limit_type == SMU_POWER_LIMIT_FAST_PPT)
+		smu->ppt_funcs->get_fast_ppt_limit(smu, limit, max_setting);
+	else
+		*limit = (max_setting ? smu->max_power_limit : smu->current_power_limit);
 
 	mutex_unlock(&smu->mutex);
 
@@ -2061,12 +2066,18 @@ int smu_get_power_limit(struct smu_context *smu,
 int smu_set_power_limit(struct smu_context *smu, uint32_t limit)
 {
 	int ret = 0;
+	uint32_t limit_type = limit >> 24;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
+	if (limit_type == SMU_POWER_LIMIT_FAST_PPT) {
+		ret = smu->ppt_funcs->set_power_limit(smu, limit);
+		goto out;
+	}
+
 	if (limit > smu->max_power_limit) {
 		dev_err(smu->adev->dev,
 			"New power limit (%d) is over the max allowed %d\n",
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index cf6176afd4d5..d14b1b832bb7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -474,12 +474,14 @@ int smu_v11_0_fini_smc_tables(struct smu_context *smu)
 int smu_v11_0_init_power(struct smu_context *smu)
 {
 	struct smu_power_context *smu_power = &smu->smu_power;
+	size_t size = smu->adev->asic_type == CHIP_VANGOGH ?
+			sizeof(struct smu_11_5_power_context) :
+			sizeof(struct smu_11_0_power_context);
 
-	smu_power->power_context = kzalloc(sizeof(struct smu_11_0_power_context),
-					   GFP_KERNEL);
+	smu_power->power_context = kzalloc(size, GFP_KERNEL);
 	if (!smu_power->power_context)
 		return -ENOMEM;
-	smu_power->power_context_size = sizeof(struct smu_11_0_power_context);
+	smu_power->power_context_size = size;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index f0f06ef47b9e..b05eaac9808f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -122,6 +122,10 @@ static struct cmn2asic_msg_mapping vangogh_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(SetSoftMinCclk,                     PPSMC_MSG_SetSoftMinCclk,						0),
 	MSG_MAP(SetSoftMaxCclk,                     PPSMC_MSG_SetSoftMaxCclk,						0),
 	MSG_MAP(RequestActiveWgp,                   PPSMC_MSG_RequestActiveWgp,                     0),
+	MSG_MAP(SetFastPPTLimit,                    PPSMC_MSG_SetFastPPTLimit,						0),
+	MSG_MAP(SetSlowPPTLimit,                    PPSMC_MSG_SetSlowPPTLimit,						0),
+	MSG_MAP(GetFastPPTLimit,                    PPSMC_MSG_GetFastPPTLimit,						0),
+	MSG_MAP(GetSlowPPTLimit,                    PPSMC_MSG_GetSlowPPTLimit,						0),
 };
 
 static struct cmn2asic_mapping vangogh_feature_mask_map[SMU_FEATURE_COUNT] = {
@@ -1771,6 +1775,102 @@ static int vangogh_mode2_reset(struct smu_context *smu)
 	return vangogh_mode_reset(smu, SMU_RESET_MODE_2);
 }
 
+static int vangogh_get_power_limit(struct smu_context *smu)
+{
+	struct smu_11_5_power_context *power_context =
+								smu->smu_power.power_context;
+	uint32_t ppt_limit;
+	int ret = 0;
+
+	if (smu->adev->pm.fw_version < 0x43f1d00)
+		return ret;
+
+	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetSlowPPTLimit, &ppt_limit);
+	if (ret) {
+		dev_err(smu->adev->dev, "Get slow PPT limit failed!\n");
+		return ret;
+	}
+	/* convert from milliwatt to watt */
+	smu->current_power_limit = ppt_limit / 1000;
+	smu->max_power_limit = 29;
+
+	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetFastPPTLimit, &ppt_limit);
+	if (ret) {
+		dev_err(smu->adev->dev, "Get fast PPT limit failed!\n");
+		return ret;
+	}
+	/* convert from milliwatt to watt */
+	power_context->current_fast_ppt_limit = ppt_limit / 1000;
+	power_context->max_fast_ppt_limit = 30;
+
+	return ret;
+}
+
+static int vangogh_get_fast_ppt_limit(struct smu_context *smu,
+								uint32_t *fppt_limit,
+								bool max_setting)
+{
+	struct smu_11_5_power_context *power_context =
+							smu->smu_power.power_context;
+
+	if (!power_context)
+		return -EOPNOTSUPP;
+
+	*fppt_limit = (max_setting ?
+				   power_context->max_fast_ppt_limit :
+				   power_context->current_fast_ppt_limit);
+
+	return 0;
+}
+
+static int vangogh_set_power_limit(struct smu_context *smu, uint32_t ppt_limit)
+{
+	struct smu_11_5_power_context *power_context =
+							smu->smu_power.power_context;
+	uint32_t limit_type = ppt_limit >> 24;
+	int ret = 0;
+
+	if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT)) {
+		dev_err(smu->adev->dev, "Setting new power limit is not supported!\n");
+		return -EOPNOTSUPP;
+	}
+
+	switch (limit_type) {
+	case SMU_POWER_LIMIT_SLOW_PPT:
+		ret = smu_cmn_send_smc_msg_with_param(smu,
+				SMU_MSG_SetSlowPPTLimit,
+				ppt_limit * 1000, /* convert from watt to milliwatt */
+				NULL);
+		if (ret)
+			return ret;
+
+		smu->current_power_limit = ppt_limit;
+		break;
+	case SMU_POWER_LIMIT_FAST_PPT:
+		ppt_limit &= ~(SMU_POWER_LIMIT_FAST_PPT << 24);
+		if (ppt_limit > power_context->max_fast_ppt_limit) {
+			dev_err(smu->adev->dev,
+				"New power limit (%d) is over the max allowed %d\n",
+				ppt_limit, power_context->max_fast_ppt_limit);
+			return ret;
+		}
+
+		ret = smu_cmn_send_smc_msg_with_param(smu,
+				SMU_MSG_SetFastPPTLimit,
+				ppt_limit * 1000, /* convert from watt to milliwatt */
+				NULL);
+		if (ret)
+			return ret;
+
+		power_context->current_fast_ppt_limit = ppt_limit;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
 static const struct pptable_funcs vangogh_ppt_funcs = {
 
 	.check_fw_status = smu_v11_0_check_fw_status,
@@ -1807,6 +1907,9 @@ static const struct pptable_funcs vangogh_ppt_funcs = {
 	.post_init = vangogh_post_smu_init,
 	.mode2_reset = vangogh_mode2_reset,
 	.gfx_off_control = smu_v11_0_gfx_off_control,
+	.get_fast_ppt_limit = vangogh_get_fast_ppt_limit,
+	.get_power_limit = vangogh_get_power_limit,
+	.set_power_limit = vangogh_set_power_limit,
 };
 
 void vangogh_set_ppt_funcs(struct smu_context *smu)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

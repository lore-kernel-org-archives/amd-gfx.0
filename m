Return-Path: <SRS0=BBBq=HF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193C2C433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 08:41:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A21C664DD4
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 08:41:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A21C664DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB4E86EA13;
	Wed,  3 Feb 2021 08:41:40 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0901C6EA13
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Feb 2021 08:41:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVAh9zfLfeP0b97ciqhCo9NRaz+SYUiik9CHuEcw2D7T2FnucSmBn+p9moVEKBMu0mCJhR0ikizfu8uXPm3VxtI5f7/z7bKkfs2sUwYHMBBxLXdrsdth2T9zXaCgl9mHjawVNs3aMnaV4npd/jSfnf5NPKJd1SrfXgmOPlU1yPwoJKEaNDFc2e3p+nR6SLPGBXmp9TFW5hcr9XHx7WcMFBbTj/w8SCPIpOipzayuPG0GgcMNFpXewUiKcbHfLPMALIVtx1v2Pdz1U5EbIOtLoB/EJh7Gp1IkfTO+vL1bnKrQqEQSsq2IXC+qOgAtz5BrIlPydeC/Voyn1UM66Zmlhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7OLG9M6y8HTuPDXgQzOsmOI40z0nnJxOomfZ0kqTts=;
 b=MP2op0Fh9tVmpWeJ8qmUYTl7LSODB0ppZ3Kdo/aXdQHs8Dd8lLwUnTUKgtSDjEWtn+K8aOjPP3jCWAmckGDZ7YizjOOoUUqhRTNvJMN1XFCDqufWY5xSTRrc4Ww+7ybwE+CGmxl+48T0HmXwQ0LxqpzvzAs9UFqoqXZoaoQ1S7Mse2C5tfkFHV5vCyElCrDFLpon2yG1LLK6mrVUyhRcYMvau4WY6r7usEA7I9DaISdEcjlpmjPOeImIMX1dl2OWDasy0e8V59Gnsybr6P4bnLInZRy8UkplYKeubBFn+14idkdfvRdV4ut6HV6CUtJqniqtEce1rHtgbZoIIh6JWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7OLG9M6y8HTuPDXgQzOsmOI40z0nnJxOomfZ0kqTts=;
 b=Rzou54usXwtTLgQp+VhfvuU4TFzP6ab+Brx9axaSgQU6JWTHrYyx9ShsCGNXmdUBzkBWD8tZCjE5yqZBeruoVSd00sgZAHk45JvB9mlVcj2k/7AwTcbjWnuQzOqsvOQbcB/XT35ZIjM77NJ4d+DEjlgJT6+jGOCOSREbu00e3Cg=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by MN2PR12MB4126.namprd12.prod.outlook.com (2603:10b6:208:199::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Wed, 3 Feb
 2021 08:41:37 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a%3]) with mapi id 15.20.3805.027; Wed, 3 Feb 2021
 08:41:37 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Hou, Xiaomeng (Matthew)" <Xiaomeng.Hou@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amd/pm: add support for hwmon control of slow and
 fast PPT limit on vangogh
Thread-Topic: [PATCH 2/2] drm/amd/pm: add support for hwmon control of slow
 and fast PPT limit on vangogh
Thread-Index: AQHW+gY59W15tlpzGUG+7fSNrgJUIapGGxqg
Date: Wed, 3 Feb 2021 08:41:37 +0000
Message-ID: <MN2PR12MB454913D174D1FAA77D3512E097B49@MN2PR12MB4549.namprd12.prod.outlook.com>
References: <20210203082514.28303-1-Xiaomeng.Hou@amd.com>
 <20210203082514.28303-2-Xiaomeng.Hou@amd.com>
In-Reply-To: <20210203082514.28303-2-Xiaomeng.Hou@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-02-03T08:41:34Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=db263989-38aa-469e-b4e6-5024623ab075;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.213.69]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4caa92d0-f2f3-4584-c647-08d8c81f8551
x-ms-traffictypediagnostic: MN2PR12MB4126:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB41266D917E7BC41680E353CC97B49@MN2PR12MB4126.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: thIJOyfK4f0q1DJl/F82zk7Vpmz3uNFHZzRKWKX4BZWeLWyJbyq6/xAlZjg0s9ODm8eKfwW0ocIFdpaozhdiYf3bXUgb9zDRhviJ/Kd/H5PbTlD0nSP3hSsRQ1agXaZFoMK93ZHRHtgjCElnRtakKYJGmAzKeQwoU7rHnPIC0pmn1ReyH0pEBNG1QEVEXLO4ksL6+RpAOnUDmdu1qgBhAcQZKSnGaJwTOCmvA5AC8izMBOCFHaZSRDpqD66opJPoCExEdqfMA4MDMLp9HASit0gLat1RWBvwDh0mEfMgBax/Ujjd0Bvrej8IrwoADTbupLxxa63eEDHohatQ4oL65381gIvGcgMB4zCwbIZQFuBuIX8IkCbesKwxBpX4BgikeWdV/9o7PCoASem/K+LwWpFg544eep5dFkYJ2j07UWO5Fsxs/qWYgzL766XvGOC+lg0jvumcrHqhlLgo8mUuu8W+criuolbeMcJrnz85ojG+cR/J1yfOf16HeYSYSSshJl3FgmXEiO5VAjIenId1Aw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(5660300002)(71200400001)(66946007)(478600001)(76116006)(30864003)(7696005)(66476007)(66556008)(8936002)(55016002)(54906003)(316002)(52536014)(86362001)(64756008)(55236004)(8676002)(53546011)(26005)(6506007)(83380400001)(186003)(33656002)(66446008)(2906002)(4326008)(9686003)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?rseI8l32li7G63iFY7cc/QSCZmz3Ks+W9UZZPgK0Sw1lSEgs9lHxoiVGIEUz?=
 =?us-ascii?Q?1kfyy1te6u+C3zXxU7bdVZtG+ImGXhZ/R8nsnCKQovWsUvfh8RLpTwylq26L?=
 =?us-ascii?Q?9Xa8g5RVgtHgjKzhGqtMrVwUN0XsklIplN9avhdBKr+rRitPh5oK5WMyzFDJ?=
 =?us-ascii?Q?wgwBe0Ab+cygbX7FlG6AkrJEc2wtedTlhbP3qEQgIqbre6Bggw3T5AGIuyRe?=
 =?us-ascii?Q?rR1QK+Q5v+zss+cGyumVlz3ahw3Q5a57zTA7wy7T053giEouaIW8aV/VpAIt?=
 =?us-ascii?Q?E/cU/r/VDDaK0Ro1J8upFfSHgrrIlh5zAITviDcLD3pMFFEHHFAp0dzY8Ick?=
 =?us-ascii?Q?5qWnTXrig2L99U92Q5K2RBTVWiEuH1cY3VodOXLJNEhAyUdg13gB2wpC5ubB?=
 =?us-ascii?Q?W56p/1JryVgUw2ANiJVbCH085jySnh1E+ooQHp+DvoR7xhBHg9niNLXJnkxv?=
 =?us-ascii?Q?z8T0Un6ljhT7/v3Y++esru0mtT7my9sQNQzS03qxEq80j/qVIeNLZW4s/0CM?=
 =?us-ascii?Q?76jWvytdS+HwBslIXBVGOZdZgN2/UMzJJBcFwxBxbvfpEpOxPtJQ4FjKn8jB?=
 =?us-ascii?Q?LTQmWiraYE0UACAx5Jqjjpth5wLUrwpziDvUEERxqZNFKgsnCF5037nBQXz5?=
 =?us-ascii?Q?8H3+k5Mt1mt+dz8Dt/5X+sKouDrDB1IVMB23n3IHH4bnFOS/tpoMeNc3Z+Qm?=
 =?us-ascii?Q?7lBDm6xCssD1eoCsvmoSiJtNglt2DnNdjCk0NPCDnivPu7PpMUw1BAw4Qhqg?=
 =?us-ascii?Q?6ChauHce1MlTGlSZBvE59pfK8zoHC4Ms/QZVOR372R2qLuz3LBGp7kRsulOa?=
 =?us-ascii?Q?0BSyGzMkJjHeB9+v+qcBqJ+S7BZ+Y/4/ZuXWkAetByBhCXgNsbqNmtZZzYrs?=
 =?us-ascii?Q?cGbV5by8mmJDXcQtaYYL4YskQM4K+MKU0Ae83eBHTCqxwD2gpGLs/cWhuj0N?=
 =?us-ascii?Q?gsgYl3FATgW4ACGO4uWkaxvZhaZOVtQC3mPQd0a38IWDhRNahTinYL117Qfs?=
 =?us-ascii?Q?NH6RkKJ4ip0pSSqT5p7Lt8hzKbd5Iic1Bjx6x8fAo6d1Q0m93vC1n5uCQ222?=
 =?us-ascii?Q?Ntlk1p10?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4caa92d0-f2f3-4584-c647-08d8c81f8551
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2021 08:41:37.8130 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b31yWXD86b1YwMMTr0XvnjoAQK6i7na3P1B4c590PZzvXTMY+/fm6368fym5m8AI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>, "Wang, Kevin\(Yang\)" <Kevin1.Wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

<> One minor comment below.

-----Original Message-----
From: Hou, Xiaomeng (Matthew) <Xiaomeng.Hou@amd.com> 
Sent: Wednesday, February 3, 2021 1:55 PM
To: amd-gfx@lists.freedesktop.org
Cc: Huang, Ray <Ray.Huang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Hou, Xiaomeng (Matthew) <Xiaomeng.Hou@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: add support for hwmon control of slow and fast PPT limit on vangogh

Implement hwmon API for reading/setting slow and fast PPT limit.

APU power is managed to system-level requirements through the PPT (package power tracking) feature. PPT is intended to limit power to the requirements of the power source and could be dynamically updated to maximize APU performance within the system power budget.

Here FAST_PPT_LIMIT manages the ~10 ms moving average of APU power, while SLOW_PPT_LIMIT manages the configurable, thermally significant moving average of APU power (default ~5000 ms).

User could read slow/fast ppt limit using command "cat power*_cap" or "sensors" in the hwmon device directory. User could adjust values of slow/fast ppt limit as needed depending on workloads through command "echo ## > power*_cap".

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
+		limit_type == SMU_POWER_LIMIT_FAST_PPT ? "fastPPT" : "slowPPT"); }
 
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
@@ -3355,6 +3367,12 @@ static SENSOR_DEVICE_ATTR(power1_average, S_IRUGO, amdgpu_hwmon_show_power_avg,  static SENSOR_DEVICE_ATTR(power1_cap_max, S_IRUGO, amdgpu_hwmon_show_power_cap_max, NULL, 0);  static SENSOR_DEVICE_ATTR(power1_cap_min, S_IRUGO, amdgpu_hwmon_show_power_cap_min, NULL, 0);  static SENSOR_DEVICE_ATTR(power1_cap, S_IRUGO | S_IWUSR, amdgpu_hwmon_show_power_cap, amdgpu_hwmon_set_power_cap, 0);
+static SENSOR_DEVICE_ATTR(power1_label, S_IRUGO, 
+amdgpu_hwmon_show_power_label, NULL, 0); static 
+SENSOR_DEVICE_ATTR(power2_average, S_IRUGO, 
+amdgpu_hwmon_show_power_avg, NULL, 1); static 
+SENSOR_DEVICE_ATTR(power2_cap_max, S_IRUGO, 
+amdgpu_hwmon_show_power_cap_max, NULL, 1); static 
+SENSOR_DEVICE_ATTR(power2_cap_min, S_IRUGO, 
+amdgpu_hwmon_show_power_cap_min, NULL, 1); static 
+SENSOR_DEVICE_ATTR(power2_cap, S_IRUGO | S_IWUSR, 
+amdgpu_hwmon_show_power_cap, amdgpu_hwmon_set_power_cap, 1); static 
+SENSOR_DEVICE_ATTR(power2_label, S_IRUGO, 
+amdgpu_hwmon_show_power_label, NULL, 1);
 static SENSOR_DEVICE_ATTR(freq1_input, S_IRUGO, amdgpu_hwmon_show_sclk, NULL, 0);  static SENSOR_DEVICE_ATTR(freq1_label, S_IRUGO, amdgpu_hwmon_show_sclk_label, NULL, 0);  static SENSOR_DEVICE_ATTR(freq2_input, S_IRUGO, amdgpu_hwmon_show_mclk, NULL, 0); @@ -3393,6 +3411,12 @@ static struct attribute *hwmon_attributes[] = {
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
+	int (*get_fast_ppt_limit)(struct smu_context *smu, uint32_t 
+*fppt_limit, bool max_setting);
+

<> Since this needs a new callback anyway, it's better to define it in a more generic way and make the parameters explicit.

int (*get_ppt_limit)(struct smu_context *smu, uint32_t *ppt_limit,  uint16_t ppt_type, enum cap);

ppt type = PPT limit type - DEFAULT/FAST
cap = MIN /MAX/CURRENT

Thanks,
Lijo

 	/**
 	 * @set_df_cstate: Set data fabric cstate.
 	 */
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index c7d57e9555cc..e6ccd422d518 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -129,6 +129,15 @@ struct smu_11_0_power_context {
 	enum smu_11_0_power_state power_state;  };
 
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
+		*limit = (max_setting ? smu->max_power_limit : 
+smu->current_power_limit);
 
 	mutex_unlock(&smu->mutex);
 
@@ -2061,12 +2066,18 @@ int smu_get_power_limit(struct smu_context *smu,  int smu_set_power_limit(struct smu_context *smu, uint32_t limit)  {
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
 			"New power limit (%d) is over the max allowed %d\n", diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index cf6176afd4d5..d14b1b832bb7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -474,12 +474,14 @@ int smu_v11_0_fini_smc_tables(struct smu_context *smu)  int smu_v11_0_init_power(struct smu_context *smu)  {
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
 
 static struct cmn2asic_mapping vangogh_feature_mask_map[SMU_FEATURE_COUNT] = { @@ -1771,6 +1775,102 @@ static int vangogh_mode2_reset(struct smu_context *smu)
 	return vangogh_mode_reset(smu, SMU_RESET_MODE_2);  }
 
+static int vangogh_get_power_limit(struct smu_context *smu) {
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
+static int vangogh_set_power_limit(struct smu_context *smu, uint32_t 
+ppt_limit) {
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
 
 	.check_fw_status = smu_v11_0_check_fw_status, @@ -1807,6 +1907,9 @@ static const struct pptable_funcs vangogh_ppt_funcs = {
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

Return-Path: <SRS0=LS4N=HH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFCFC433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 13:25:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 255B764F6C
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 13:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 255B764F6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66CC56F41A;
	Fri,  5 Feb 2021 13:25:05 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3385E6F41A
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Feb 2021 13:25:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ET/k0dyPld1UezZKgYI9m76lyMVSCnR/uFv3dO2Yg1/vAIp8yc4J+ZeRK0tweV7IjkmRTZmD1eDbg9btI5jtzyU0u8pQtiuL43s5EZJmq+KzpPiOc4TkiU62oxP25OmElkHACh4XqQb9w2LEzJeiYI37hLdxEp7KPnPhOryppTeGdE2rGJG25ka0Vurncsi8i3BgbqjHbodF/8ddXfLFhinB2PlM7wATSVNRcg6Z8isnXbDtp7OQEEJMfe4m79dq4NVUzsJEkesqc79OUmf9EQph5E7BZ9yS6tG/Btyg/z6iovB/XfrWa1tVnQoFsRvCPESqIoHJZ60OdolSD0udtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sK9ICai7xy1AK+ng2TVnz3V+l0KQh0ycaUkZ/HYxYvA=;
 b=aXfvRTkDBosVDp9NlYL3uhP3WBa3Gghx6LrCmvvVCZAeVoHzRRlbObXtSy/V3GVu/R/LdkBblbI+LfpPomPOESaHGPJQC+3qnMNBXOBpI9J+OY7e028cbs0ETiL3bw3P2ZHZLAo6hNqZBaTQw+VI0Xb8/aau4d1RHcaYYOLCxLp4SV1YpRXRcIzTvDIxQKUbtT4ZG9w/cuP/BTJVbupKbsvMvPxI3MaPI/Z/wo0dcoGke4b50XbNoRaLIWBPTcZPmGYfBEZdMGWMHUoY5Afd9TPtb8s0xsM2b1P8Ak/KfdE16FO9paZBZ5PmuS1PrNGV0TpeDZd+BTFDoXRZ6PaMfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sK9ICai7xy1AK+ng2TVnz3V+l0KQh0ycaUkZ/HYxYvA=;
 b=IBmKw+TDwbH8gHNpzI+q44OlrMMFmbtPKOFmrhtX1ugyItTCPTAl2eZxqYlNSsL2fh3CxqirQbUlzpReWC5mAHlBbKd/idxvp6663ST4KWE5bVqD549uRENcv3Y+VGGfXbwJvtb4lPsvtJpMN9J3xJ5ed1DXHnmayYfiBNxCWgk=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.24; Fri, 5 Feb
 2021 13:24:56 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a%3]) with mapi id 15.20.3805.027; Fri, 5 Feb 2021
 13:24:56 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Hou, Xiaomeng (Matthew)" <Xiaomeng.Hou@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amd/pm: add support for hwmon control of slow and
 fast PPT limit on vangogh
Thread-Topic: [PATCH 2/2] drm/amd/pm: add support for hwmon control of slow
 and fast PPT limit on vangogh
Thread-Index: AQHW+7wKL5Ic0yNC00yI2FyBzHdL96pJjPfA
Date: Fri, 5 Feb 2021 13:24:56 +0000
Message-ID: <MN2PR12MB4549274594FF0E5BC86313A997B29@MN2PR12MB4549.namprd12.prod.outlook.com>
References: <20210205123924.24129-1-Xiaomeng.Hou@amd.com>
 <20210205123924.24129-2-Xiaomeng.Hou@amd.com>
In-Reply-To: <20210205123924.24129-2-Xiaomeng.Hou@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-02-05T13:24:54Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=42c2e6d6-0d92-45c7-be22-06b63e3c1574;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.195.234]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8966d677-62d7-4734-b2d9-08d8c9d96e17
x-ms-traffictypediagnostic: MN2PR12MB4205:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB420539810CBE2930B67E6CB697B29@MN2PR12MB4205.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nW8e2MDesh62B9g9wE8/Kae98pH9fo0El409R/HUrEoYTpUQ21Df73jTrovKAYObk5Y1hVfxT5vH+RtUgVXhffkXgEcgHoQp3f57FWdMQqWHC7tmaJS6eSExBniqYHMwC6StH2QzLoKb03pl9nWFquhwLpoq7fbqdLL2hPzmkVAfWLbKWxO1CID3NviD28GydSYJXQ3ncHtPgFv2+QFOrhjat9oPHtZAicu58kbKtX8MF8m/PZcJbF1p/vBr+r+IwCaOACkxUUKHBt1nRjAxXWT1Dv1f89T8lMdUa/Ihe7dx0RWKu9+YHFOHrSz0Qic3vRI1x4M6Syz4KvGoOraD264ks1/v0Tx0n0KtkKKEpCqtXNTARrl7p1rqyFjSOVDy0somzaDHuuqi8tVXs8eVG/bHTd3WRJb/XMm2wj8EdMna2jEyiom9Ya2LTHTpIQxSBeUuSiq3aLSaPp6ayb3eCrix15DkIrW9rIaUAyoPliA2IRHAkorG7MiLuZPPBZDV0sQX6CLp/SC0FLnQ8+SDXA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(30864003)(86362001)(316002)(4326008)(110136005)(5660300002)(54906003)(83380400001)(478600001)(66556008)(33656002)(7696005)(64756008)(66446008)(66946007)(66476007)(52536014)(8936002)(8676002)(26005)(186003)(55236004)(71200400001)(53546011)(6506007)(2906002)(9686003)(76116006)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?OVR4j0KxyURFEtL1+Pzuzd6oGbJISM6k3nLcOKfHhb5/CV9bqZofkXmePDLi?=
 =?us-ascii?Q?uoMlch+dSZBuaamdOzbLJDr9+TXD5KACGmAjgRZ0TGid8QaVmrWR9L4/f/7B?=
 =?us-ascii?Q?054eKzwnMvBKPSVUfdrYaWcAjwJeFc0m5AIi8IisO916cU7NtpAlF5HYpeds?=
 =?us-ascii?Q?zUrn5vn+Nf3Rvg9fuvwnzADMHh0SFyX577DU65FKPGxwGHbqlxx7IcT32IhK?=
 =?us-ascii?Q?AmNRbL0KECSjlKkyhHE1vQ5xDphlv0btUcoSI8hGLMc/49kfhri+gN5p5rG6?=
 =?us-ascii?Q?JPBUQvMrUW+WQT++D+VaWRDfTkhm8vQd06kgRr0KzkAmv2kOjBMwCiu0j6Xm?=
 =?us-ascii?Q?S7GXvrHUH9C6p9jJ2WIDMzzo2dkn9yxNlRPEzKHw97dBNy99JZVawY3XqUbb?=
 =?us-ascii?Q?zB6MfpFSNCdiv1jNCZmxk3abj0dM2U53JT/FofM27i0xYNeyZe8FkHDfMOkT?=
 =?us-ascii?Q?Vj9L2iY/X1bnSamnXGsV84oblHIsrAwCrma9pITevyJ6Q266tburPXUw7RZo?=
 =?us-ascii?Q?9zkwXcwot8qnhQ4YqFppR7RgEuC7L0ogTicNR2bkaa46ioQ95LYzMsxMenll?=
 =?us-ascii?Q?O5IVkVIVxeu93taL2xiiK02vy/2H61eMjW4cd0Tc90FK9I+tijtE5yUKaSOT?=
 =?us-ascii?Q?rS/mNiH3Na2bKbr2ZUARBUhH571P+J6JbcXt8bqih4lUfRIzebqwRV0F6moK?=
 =?us-ascii?Q?9jqDPDhPbW+funO7VetRpozYQE1QHKKcz5VZspUmMHucWLDlVjBALgz14ghP?=
 =?us-ascii?Q?M0k4QBLTQ4InP9s+SDF8StcBt3N3LqJlGyAeLFFqF5oXSNs1YizZokW/I0WQ?=
 =?us-ascii?Q?NOFXg/W38GRzhxlaswFgqv5qf0AQHtf+u9dS2wfaCQU3SASNXAw7eRdUEBh3?=
 =?us-ascii?Q?/eS3rWblvDEj6IJZQ1toRG3Z7HGhV9bUbHHXqM60+L+GNyXlS4NWQrFRnViZ?=
 =?us-ascii?Q?iulKQoCgG+Rcsx4nRGqrZpp5V7uOt0JSevll0CJmSq+/1THaVWp9G9kEihSV?=
 =?us-ascii?Q?LY+UJwaDJ1BEzghBR0x2zFJZk8YKmGmHUFKbDBXzpUETy2lWjY5qY8gyzhxF?=
 =?us-ascii?Q?A0WmxCx6JM/d5sapwRIQheUUEd0VaRLviU0gZDEgrHy4beeeqRbElnlXM9oL?=
 =?us-ascii?Q?l45ObXxFTtcmh/a5YsnvfnepMY5IDTazla8aK2awqy4o9gcGviXfBIXu2q1w?=
 =?us-ascii?Q?tL1FqO76Tc2TtSGHGs9pz4tCobFYnjgdFTRcZ3KSY/zgkX8c0lVt0gumlC31?=
 =?us-ascii?Q?brsfvpD6usUSEyhOXSjQld5lI90cruzrdBSutrOf3ICMkXGgh1MiRgiLl4zs?=
 =?us-ascii?Q?Sq8JSW8QDo9E5PfQDpX0eDkE?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8966d677-62d7-4734-b2d9-08d8c9d96e17
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2021 13:24:56.3943 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KFeZ7gFzhoeiyURgBJV/PpTUPs89DhKRXBArCgfdciNaMaWTPbRk4wU78jNWnyLq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4205
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
Cc: "Huang, Ray" <Ray.Huang@amd.com>, "Wang,
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Series is Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

-----Original Message-----
From: Hou, Xiaomeng (Matthew) <Xiaomeng.Hou@amd.com> 
Sent: Friday, February 5, 2021 6:09 PM
To: amd-gfx@lists.freedesktop.org
Cc: Huang, Ray <Ray.Huang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Hou, Xiaomeng (Matthew) <Xiaomeng.Hou@amd.com>
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
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  45 ++++++-
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  12 ++
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |   9 ++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  35 ++++--
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |   8 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 113 ++++++++++++++++++
 6 files changed, 204 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 39899e7989a2..5fa65f191a37 100644
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
+		limit_type == SMU_FAST_PPT_LIMIT ? "fastPPT" : "slowPPT"); }
 
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
index 82a5f4a4faf5..10b0624ade65 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -161,6 +161,12 @@ enum smu_power_src_type
 	SMU_POWER_SOURCE_COUNT,
 };
 
+enum smu_ppt_limit_type
+{
+	SMU_DEFAULT_PPT_LIMIT = 0,
+	SMU_FAST_PPT_LIMIT,
+};
+
 enum smu_ppt_limit_level
 {
 	SMU_PPT_LIMIT_MIN = -1,
@@ -708,6 +714,12 @@ struct pptable_funcs {
 	 */
 	int (*get_power_limit)(struct smu_context *smu);
 
+	/**
+	 * @get_ppt_limit: Get the device's ppt limits.
+	 */
+	int (*get_ppt_limit)(struct smu_context *smu, uint32_t *ppt_limit,
+			enum smu_ppt_limit_type limit_type, enum smu_ppt_limit_level 
+limit_level);
+
 	/**
 	 * @set_df_cstate: Set data fabric cstate.
 	 */
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index e49c2d08a983..d4cddd2390a2 100644
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
index 9017024642bb..d143ef1b460b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2046,29 +2046,38 @@ int smu_get_power_limit(struct smu_context *smu,
 			uint32_t *limit,
 			enum smu_ppt_limit_level limit_level)  {
+	uint32_t limit_type = *limit >> 24;
+	int ret = 0;
+
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
-	switch (limit_level) {
-	case SMU_PPT_LIMIT_CURRENT:
-		*limit = smu->current_power_limit;
-		break;
-	case SMU_PPT_LIMIT_MAX:
-		*limit = smu->max_power_limit;
-		break;
-	default:
-		break;
+	if (limit_type != SMU_DEFAULT_PPT_LIMIT) {
+		if (smu->ppt_funcs->get_ppt_limit)
+			ret = smu->ppt_funcs->get_ppt_limit(smu, limit, limit_type, limit_level);
+	} else {
+		switch (limit_level) {
+		case SMU_PPT_LIMIT_CURRENT:
+			*limit = smu->current_power_limit;
+			break;
+		case SMU_PPT_LIMIT_MAX:
+			*limit = smu->max_power_limit;
+			break;
+		default:
+			break;
+		}
 	}
 
 	mutex_unlock(&smu->mutex);
 
-	return 0;
+	return ret;
 }
 
 int smu_set_power_limit(struct smu_context *smu, uint32_t limit)  {
+	uint32_t limit_type = limit >> 24;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled) @@ -2076,6 +2085,12 @@ int smu_set_power_limit(struct smu_context *smu, uint32_t limit)
 
 	mutex_lock(&smu->mutex);
 
+	if (limit_type != SMU_DEFAULT_PPT_LIMIT)
+		if (smu->ppt_funcs->set_power_limit) {
+			ret = smu->ppt_funcs->set_power_limit(smu, limit);
+			goto out;
+		}
+
 	if (limit > smu->max_power_limit) {
 		dev_err(smu->adev->dev,
 			"New power limit (%d) is over the max allowed %d\n", diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 36d651342a76..90585461a56e 100644
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
index 42271e80c0b4..3277014b5881 100644
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
 
 static struct cmn2asic_mapping vangogh_feature_mask_map[SMU_FEATURE_COUNT] = { @@ -1773,6 +1777,112 @@ static int vangogh_mode2_reset(struct smu_context *smu)
 	return vangogh_mode_reset(smu, SMU_RESET_MODE_2);  }
 
+static int vangogh_get_power_limit(struct smu_context *smu) {
+	struct smu_11_5_power_context *power_context =
+								smu->smu_power.power_context;
+	uint32_t ppt_limit;
+	int ret = 0;
+
+	if (smu->adev->pm.fw_version < 0x43f1e00)
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
+static int vangogh_get_ppt_limit(struct smu_context *smu,
+								uint32_t *ppt_limit,
+								enum smu_ppt_limit_type type,
+								enum smu_ppt_limit_level level) {
+	struct smu_11_5_power_context *power_context =
+							smu->smu_power.power_context;
+
+	if (!power_context)
+		return -EOPNOTSUPP;
+
+	if (type == SMU_FAST_PPT_LIMIT) {
+		switch (level) {
+		case SMU_PPT_LIMIT_MAX:
+			*ppt_limit = power_context->max_fast_ppt_limit;
+			break;
+		case SMU_PPT_LIMIT_CURRENT:
+			*ppt_limit = power_context->current_fast_ppt_limit;
+			break;
+		default:
+			break;
+		}
+	}
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
+	case SMU_DEFAULT_PPT_LIMIT:
+		ret = smu_cmn_send_smc_msg_with_param(smu,
+				SMU_MSG_SetSlowPPTLimit,
+				ppt_limit * 1000, /* convert from watt to milliwatt */
+				NULL);
+		if (ret)
+			return ret;
+
+		smu->current_power_limit = ppt_limit;
+		break;
+	case SMU_FAST_PPT_LIMIT:
+		ppt_limit &= ~(SMU_FAST_PPT_LIMIT << 24);
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
 
 	.check_fw_status = smu_v11_0_check_fw_status, @@ -1809,6 +1919,9 @@ static const struct pptable_funcs vangogh_ppt_funcs = {
 	.post_init = vangogh_post_smu_init,
 	.mode2_reset = vangogh_mode2_reset,
 	.gfx_off_control = smu_v11_0_gfx_off_control,
+	.get_ppt_limit = vangogh_get_ppt_limit,
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

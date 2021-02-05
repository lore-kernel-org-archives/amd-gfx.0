Return-Path: <SRS0=LS4N=HH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBA9C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 12:40:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 433A264FD7
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 12:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 433A264FD7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4CE989249;
	Fri,  5 Feb 2021 12:40:11 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CEA36E081
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Feb 2021 12:40:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0wDMMzqacL54/8G+LhDDPEvqsB+eL59Saob07LUhGDlq9Pja/PsNo2Xz5lIPJZqxgJhyv772UJGe4E52+1gXVpxg69YesMrlx1xZBHNQH4y3Fqw0DmxKYOPDsvt8kLwCfcL+attSbxYdQot0Hq5qXo73e1y7nnwWpyOpGSdOAFYEP+TqP1HpoZDMydsCOT3nP2VdHt+qHmbWvVCMUOafGtcskt8No2dCg6qnWcCX0bgYYBr2V+T8xKmtiXeEY9tOk2f6eRZHv0M5fqiIozo+mW0lUEbTwJ+y7crJPBONNXZ53qbtWAAPQROsiUStW/JKDQFYcqjOFkwSJbz1J1AXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2Yx0KrEMK6K39Z7WuIJ/la+4PwgRUuhbQEWTyF+Uzc=;
 b=SCeZ1PNSh9gmI3iq/RhgMn5msAhwqsHO2GP1H1gG0rKqojvnLb/I2bVl+xAUazGWZZ0jXPfNykRaFtMJwlICTA+goI7QTP1PEaJaERd6hO7AhDGGFf0pi5DClG0LQig9GRIpR/8jVT+jDdRWbb3cjWCCHOiwxx7Qo0fzq7J0irmoLBYI0r7uQTA5RBL1KgxuhMvEFV/JzdWULkAjaUliDY+7mtDtz81kQzte1l+TKp+rp8F0WyhzN9N8GGkpEQBc7+JJdJuhAoSQwU4gLaFKLdLm2JurpJs0DRWF7OMwUI0lFLpjRV5pdrtcY3Xzy6PfPIKsKpW6aNGVWhZ4TKHGKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2Yx0KrEMK6K39Z7WuIJ/la+4PwgRUuhbQEWTyF+Uzc=;
 b=fBdbCm1vRy5ry+i2Qc5KKE5bGOEmq3N1QD193p6XNqJurWhSmpcgWGY7RK4/noAMZwTw01xQPUKOcdK4vM8wejO9zCmhQuvish/LOV/4zo+jUT/mOrQPGvxadtj3PV/+/j0gNZr+M2e221vxNoC4qm+i/TpHsXZlTehsaz3MfUM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3807.namprd12.prod.outlook.com (2603:10b6:208:16c::30)
 by MN2PR12MB4376.namprd12.prod.outlook.com (2603:10b6:208:26c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Fri, 5 Feb
 2021 12:40:09 +0000
Received: from MN2PR12MB3807.namprd12.prod.outlook.com
 ([fe80::7c48:cd3a:5f92:2c47]) by MN2PR12MB3807.namprd12.prod.outlook.com
 ([fe80::7c48:cd3a:5f92:2c47%4]) with mapi id 15.20.3825.017; Fri, 5 Feb 2021
 12:40:08 +0000
From: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/pm: add support for hwmon control of slow and
 fast PPT limit on vangogh
Date: Fri,  5 Feb 2021 20:39:24 +0800
Message-Id: <20210205123924.24129-2-Xiaomeng.Hou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210205123924.24129-1-Xiaomeng.Hou@amd.com>
References: <20210205123924.24129-1-Xiaomeng.Hou@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR04CA0071.apcprd04.prod.outlook.com
 (2603:1096:202:15::15) To MN2PR12MB3807.namprd12.prod.outlook.com
 (2603:10b6:208:16c::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from code-machine.amd.com (180.167.199.189) by
 HK2PR04CA0071.apcprd04.prod.outlook.com (2603:1096:202:15::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.19 via Frontend Transport; Fri, 5 Feb 2021 12:40:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8b313e1e-67d9-4108-a37c-08d8c9d32bca
X-MS-TrafficTypeDiagnostic: MN2PR12MB4376:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4376BC4C2A39A6B8888DE5409FB29@MN2PR12MB4376.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bxOk3p46BoGdTsJJo1OGrVMApBca5abrIo9+/BSDRgahYi7YwvtHQ/mawy3h+iZ8i8T/546HKpTaV13I/chPCI7lwq5mkd6M0jNzuyAG0WPHMw4yDzYmbykLsafaBs/ay32wnguFvuIaEOtRWBUA6mzfxJBTLnw1klKYk15CNsERjvm+1ZzLWD0JHQFgC/DTQPufwzS7TZVtrv6VAddJ1gHN0PV10EOAWmsnThAwtPZNNglXMKNxyR9eXts7/59OSWPlWknJiqn/6MagDaLW6G8vcX4SB+4gyrV1NQKh4UJodZdBUvlo0UW+SUtGg6X7+grhlORAEJj32AXSfDJ3RuC37L1B69TEWsNoafNYBNVX+1CZ1zk+8UakPDovaojmbnDRPii7kA8VpqFIjKUn066yu1OENVUq39FRnXAQxqHPK7dgg22+JrmMbnxWmMbwIufm/cFHYi9VXYpgMVvI8kuhRig2ms4O5UemJ3LskKWrCRScgbKQP6BhePvPOlQShg/zSPYDaCp0R4WuU/NXsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3807.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(36756003)(2906002)(478600001)(83380400001)(6666004)(6486002)(1076003)(316002)(86362001)(2616005)(52116002)(5660300002)(956004)(26005)(66946007)(7696005)(66476007)(8676002)(4326008)(8936002)(16526019)(30864003)(186003)(66556008)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ZAp3oZfYg1E0VdxXtbFev6BARReYOl5iUiIEM18kOLR6yAE1yFquY+2SI/2L?=
 =?us-ascii?Q?G2osTnGI8t0wQ28NxgP11WOAL3dv3qdN0BtnyJioibawYAaMJPkyXTMD/p6b?=
 =?us-ascii?Q?wdi2+57klMLPGqhTJhAufOM5g/BLJf3wAZK5m0qCqkMTiB5cdsbsxC3FzQPW?=
 =?us-ascii?Q?Jzoh0gbrTK+SD/O3u4Jr2/m99URSDSHMuZ5MBQ1RdqC4Dn2RQKFFIyWSjN24?=
 =?us-ascii?Q?VfLyQ/BWCwEQra5N2oqKeG19Lp+GYg35DqC11dlYQN2ikxLoqNAF4rb79pkB?=
 =?us-ascii?Q?Vp1rCPs2Shp2ObSdbzdDOCSVrEUfT+rIx/zxzJzSHo6VrBB0EOBHedrAsUf1?=
 =?us-ascii?Q?pG6EXuYUGGttsapPi4eNliLXLnMeIxJDQyLKO5Q1WCGPruc6xo+6ywl/f3XH?=
 =?us-ascii?Q?6fTDyOCmFONqkeDyvJnCu08max0rtcI/tNRPf0tJTAek0D7zJx59JLnoyUq8?=
 =?us-ascii?Q?7LsOk5hFbsyUzgut7sfGDomid6MuwGgr1lbDRwfgwdG/RP3NCveFl5RlooOx?=
 =?us-ascii?Q?IjMJyT2Jf5y+a/7rHsE4JOzfHbBHrkbYTpB2y28zK6oigofEjkw2U06aSRnV?=
 =?us-ascii?Q?Hu+1p7QXyUQbUK385dRd7prbVzCbKDMgWeXmZXKalbnkoXhFI930TesKhle8?=
 =?us-ascii?Q?XtWK7yXssC0NKsIiwrj+TsBfJNBV1foCEwrU6RmFZ2JNi7KMHWCGuHJNJh87?=
 =?us-ascii?Q?ybkCYrRuMsYXBnFIcFVKTmQC4NmvPxyXBeFdsKEO71diPVGvKd+DZrJHUDvJ?=
 =?us-ascii?Q?H0CjOLH38GudIWjfGOlWMtjOpKhYKXMhPbKorUHClH+M168pVwWULw7pXGlB?=
 =?us-ascii?Q?VHK3ekTn0+jcQJfTWuwDTvUXKblAc717I0oNrDFTxadCnVlQxTTH/PSBrrkf?=
 =?us-ascii?Q?rZMrzhpiSHLoWnOreeUC4Wz3NJSnzt5rf8+N6S6FHJfhekbrrflh9zQmXxdQ?=
 =?us-ascii?Q?IOGQJ/ISU/Sq6KghcPrIfsIc392GGpwUuRjL6fVXuifnznabzuFa+g/MOeEV?=
 =?us-ascii?Q?hKr9xS9tTJX1K4NWRke2brlCYCa2C8s0U+AoIpfKdRVMtjQi9SA3GyZ3IHmD?=
 =?us-ascii?Q?+zD4aSlEKMgDBck5DZ1OrnogjyYtwDPGeZwVZvCDaZ6lWc7sYe0j0Y5rNp/z?=
 =?us-ascii?Q?3U2kkn9yAonEylTlNBa/PboEx8M2Voz+Yvvo2auvKSKKBSgNm6iph9p2QtsU?=
 =?us-ascii?Q?+kAbaqlUs4nOHkXR0Glt1iTAfSKVk3uXA9z13XVspWzV6KdmJbH1mVnXBvGM?=
 =?us-ascii?Q?0z1RUzTKrGtkw+vgF3tpJSVZkdwOk7NVzdvgiFHVVYN+GkIh2LkCUp/uLfkI?=
 =?us-ascii?Q?PW5aYrD2UhszYie+BWThY8cT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b313e1e-67d9-4108-a37c-08d8c9d32bca
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3807.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 12:40:08.8914 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BiK1HHnUBaACk25oJ39VigHCq5cLS8ilARNhlDiI+llnkkDcwWEpjgbAUvOTV5mJZmk6F5WjOOQck452Mk1uQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4376
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
Cc: Lijo.Lazar@amd.com, Ray.Huang@amd.com, Xiaomeng Hou <Xiaomeng.Hou@amd.com>,
 Kevin1.Wang@amd.com
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
+		limit_type == SMU_FAST_PPT_LIMIT ? "fastPPT" : "slowPPT");
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
+			enum smu_ppt_limit_type limit_type, enum smu_ppt_limit_level limit_level);
+
 	/**
 	 * @set_df_cstate: Set data fabric cstate.
 	 */
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index e49c2d08a983..d4cddd2390a2 100644
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
index 9017024642bb..d143ef1b460b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2046,29 +2046,38 @@ int smu_get_power_limit(struct smu_context *smu,
 			uint32_t *limit,
 			enum smu_ppt_limit_level limit_level)
 {
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
 
 int smu_set_power_limit(struct smu_context *smu, uint32_t limit)
 {
+	uint32_t limit_type = limit >> 24;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -2076,6 +2085,12 @@ int smu_set_power_limit(struct smu_context *smu, uint32_t limit)
 
 	mutex_lock(&smu->mutex);
 
+	if (limit_type != SMU_DEFAULT_PPT_LIMIT)
+		if (smu->ppt_funcs->set_power_limit) {
+			ret = smu->ppt_funcs->set_power_limit(smu, limit);
+			goto out;
+		}
+
 	if (limit > smu->max_power_limit) {
 		dev_err(smu->adev->dev,
 			"New power limit (%d) is over the max allowed %d\n",
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 36d651342a76..90585461a56e 100644
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
 
 static struct cmn2asic_mapping vangogh_feature_mask_map[SMU_FEATURE_COUNT] = {
@@ -1773,6 +1777,112 @@ static int vangogh_mode2_reset(struct smu_context *smu)
 	return vangogh_mode_reset(smu, SMU_RESET_MODE_2);
 }
 
+static int vangogh_get_power_limit(struct smu_context *smu)
+{
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
+								enum smu_ppt_limit_level level)
+{
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
 
 	.check_fw_status = smu_v11_0_check_fw_status,
@@ -1809,6 +1919,9 @@ static const struct pptable_funcs vangogh_ppt_funcs = {
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

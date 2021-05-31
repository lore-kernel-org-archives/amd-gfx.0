Return-Path: <SRS0=CFk9=K2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B33C4708F
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 06:04:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0905610A6
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 06:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0905610A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CE286E486;
	Mon, 31 May 2021 06:04:29 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 702896E486
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 May 2021 06:04:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMOMUqKcFVDViWlQSIXIDR/TpehiDHQFfDUYZUM7NnMDu/t3Ee86bPhyCLXcmibGTRI8KnF4W1NBeSiZ6C8iQzS/zN2AFTbz4e0oMVkAKJTUC4mzGAYAa74kus1J0eZmi9F84pS3h+f+K4ajxDhvNRVwAgKWU+4AzNbXoHiNc98Z+FX560xzjQOg/CxU2w7yOFAhke1h5E/iaF7T7D0++QwT1G3Tptgkme/SKI8B2SHj3XdEK7n16j2OOzStO0ZkYo2RsZRTDyolI/v5UzJ3ROwtCLvraY3E3M/xTwfd4i+NoEhsML5rfYTHetN46rxbQBdwxYj/9hsPwlcMTZ89pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y28arEWDWwSzwPXY6OIMkQ2NBvC5nc98fAx7rhSOXbY=;
 b=ND66J7uhtNtMq1s6Alfm36YCQcs96TrqrpJN16OzIns6DtSEGEpR/jX2Bxg8zvQxOM9ptDH9pe946jtXPTgPMwrUraZwveNM0naHWVVb/YqXioEPEYqUuayEf3Ojib6i6jL3XabTN17ikVukLVIgrXZ5bV5HFC7fJsOh4kMNn3B14GbOzuZD+7EooyFd1zBNKmLnyGs8ZBclT+ssg4H8z/M3vkVKfoRE4m0N/nxGkbLpiHTHA8ad8b2bgjh13eToBlBisfJV3kOzV4ck6ysMdJhPAhxAPecrbJFT4s8rwX2G4bHncag1/xsEHAqRspDD4TJbcvO0PbF5nN9FTEcveQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y28arEWDWwSzwPXY6OIMkQ2NBvC5nc98fAx7rhSOXbY=;
 b=ldBLqYwjVvnHqspUXY0Tyt5QGDDMfbVQpB3Bm2sP75BjOsd5Q28b00Wf5RcrZZqXFY/wpdJhgWhFzJXE5SAltH+0rVbMT4ZpWlnNlE9Cw+cH1QxCsD80H9bfoAcTQNWfDHNZoE5poXyMsUwVgFn+QsWVoQt3LE2eu840sY75VCQ=
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5105.namprd12.prod.outlook.com (2603:10b6:610:bc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Mon, 31 May
 2021 06:04:27 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd%6]) with mapi id 15.20.4173.030; Mon, 31 May 2021
 06:04:27 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Powell, Darren" <Darren.Powell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/6] amdgpu/pm: clean up smu_get_power_limit function
 signature
Thread-Topic: [PATCH 2/6] amdgpu/pm: clean up smu_get_power_limit function
 signature
Thread-Index: AQHXVBYfNEWgrbBnYkyNpITBdXGwIqr9G+QA
Date: Mon, 31 May 2021 06:04:27 +0000
Message-ID: <CH0PR12MB5348CD424C6F4A5E0A064598973F9@CH0PR12MB5348.namprd12.prod.outlook.com>
References: <20210528230621.16468-1-darren.powell@amd.com>
 <20210528230621.16468-3-darren.powell@amd.com>
In-Reply-To: <20210528230621.16468-3-darren.powell@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-05-31T06:04:21Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=f83cf2df-1d61-4908-86db-9718c1f145e9;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [59.97.59.203]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20552221-765b-440b-35dd-08d923f9f28a
x-ms-traffictypediagnostic: CH0PR12MB5105:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB5105563CE2ED0F7CA8704866973F9@CH0PR12MB5105.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /iR4yG1xWZQZNIxAckahwuA58l+vS2oUcZmMlTg71kNQbrRBJCt1YN5EXrIxJ9RO1liK12MLCyfNvR+f/UMEKQpkXpPS7fDX6eo1+6aGE2YFw/nz3JRnpepxWBZ9RERtI5cOc7dRI1uQ2uky55mOVWwhSLR75KxvFWWpszATDq0gdE9d2KIm9GVYsfEFbO7bLMHlqeYVTlPmKXyY1Bcpw/o+RS6hlBUCF87B+Anm6+ntlIJGMmWHzPBnQc5fPnQD88T1I3j4H4WX0VAk5Agc0VAXK+LkhUz4OZhYMZeKDwDo9oRpMkRXJHmVcxYr9w4ypjI9t7XfWBu6eVqORPyn8ghg4HRwZYRpfg1unw2xecmXBBBcEOYh4d4L+h+w6G/pf5+TM4AVFjrpX4KbGbcRncqFlYugYERch4OKUMQzKgrZ7BXpcRSxCvKLadgLzKOBpR//o8crsGg9k8FVJBjmr5D1Ze7SJCtizDHr6LP2cA3icrKWmqW8xa395XqndmiMrSrfTmyvKsV+U/jQod1FkWhTgvI3gucC3ZBvaMLBjl++QN/xKuXqT5dMkkGFfB0eBWdPg3IPh7W7FTGw5uCQIw228YbIOuiP7rXEDGBitCU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(2906002)(9686003)(55016002)(66556008)(66446008)(26005)(86362001)(38100700002)(110136005)(71200400001)(64756008)(316002)(186003)(6506007)(52536014)(7696005)(5660300002)(76116006)(66476007)(83380400001)(8676002)(478600001)(8936002)(122000001)(66946007)(53546011)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?5+ZGT1kJ12wJ0YSaEW+LrMNOzU4k52F0CozlZhi8hQiL2XS4RBF6F+djyyxF?=
 =?us-ascii?Q?RXrQ3Q+smfUW0UyCn7n12vP3m0Y7U/SxNOHot1kyRg8Xddgcf6ehT2RAvyBn?=
 =?us-ascii?Q?SnSVb+t2g+ScobCesHm6co2g8/O5HJ9t+Bzp6/mAb4/ym65zBkR3qbv9NwGC?=
 =?us-ascii?Q?k4DRNLQawXKTgxq2dFHD46MBQBZLHJu2oJZDP4hyoZgenSPrY8IZ/ZNZ7fp0?=
 =?us-ascii?Q?/n/R7tDhOljMIuan5k6CNamgQF5vJQY2mlJjc1ftppSpwAoxX0bQc/cGelFU?=
 =?us-ascii?Q?PL3vsyZVQeoXNNrVpdkPR+8BWBHa8JkRJnBwt95FN4UrkxOtz83kcFqVfldl?=
 =?us-ascii?Q?5qE3JawSs7kVcUA135OzINjNoMVtPMLL+i/RQ2evx24E/yLC1jYRKOfGu1yF?=
 =?us-ascii?Q?Qlh3CG4eEcFu2tmqw7AwubzTwxt4nWzkBoyebS6RVyiVIjC1FlmrVn7y+AiF?=
 =?us-ascii?Q?5OjixRD0BgDH1YpXbvro+2Putn/RTXmO+FsK1si6DERIpr2UEj6cMxPlxwG8?=
 =?us-ascii?Q?wZqsfeW2BgaE0501JDPBhQid1VL8HWNTB919hC//N4UZm3NJSMYUIVB2UGtx?=
 =?us-ascii?Q?k8H8HK8NLIFimfaH62iVKiATbQ4z+mS9c4XUQ8VL5LXLvyqwvRmuffjdrzgt?=
 =?us-ascii?Q?SCkydwRW+m0ErG9O62J++JRwcEpy4Y1jbg0TlxtRoIC/RjRuOTP2Xzk49YMQ?=
 =?us-ascii?Q?k5UPq6a+2+5x6oVAiXjyEha5HZNCRZ/R00qbpswQRyoyMXprNsI6wabP9Iut?=
 =?us-ascii?Q?wN0a5qrk2RpCWoO1Ky0IYyKoFc875nDA1lf+rdS1CYTn7XHiW+/aHtBlq6C5?=
 =?us-ascii?Q?kfRUuTPmB/Kml2zzU9QfqYyuFv6z7b6YM58fM+TskmYahzqj70es9duhmXLB?=
 =?us-ascii?Q?iPsx7ezWMYoZ1Nj1TtzseGxKXwnMCY9vv+zeCwkg8k0xPwh/Ky8CLUfv+glG?=
 =?us-ascii?Q?njASGpUe5MhMHr7HcaORqpullNy0OVM0pMdOFtXjZ+T/eYSXN1W/AVF71cnR?=
 =?us-ascii?Q?X6luLQbJGku3KTtK7F8o1EbKkKWCheoozTP7moYNMg3kSV4KporscJgfAzbs?=
 =?us-ascii?Q?Ji8OvcaNKyZgyiyuzNy8N60caGrEXvk2s9rNnjoy8N3GTAgRE16wm1X/LxT4?=
 =?us-ascii?Q?7EMmyLYYVmo8gY5lppB12NZdDHGlUGBfIH6hisUsUP4xWJB6T7CHV4bDM7V3?=
 =?us-ascii?Q?qlE3p7ibFSAUnYk/RcNKcN1+GrAUcGemkPYUgAZRDt5ntxUAhhRihVch/me6?=
 =?us-ascii?Q?aR9ImYdyZp9iP/nsAVKRQWbcb/l1FIFaPCBwkJQSomvfDjemCaCNYTi8k47o?=
 =?us-ascii?Q?rqc=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20552221-765b-440b-35dd-08d923f9f28a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2021 06:04:27.0786 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zVjQxTnWK9FnHhaHs9DnYlRzbGTLVvtHjJM2Htw6f56Fn1/U3cOyaYyBeZQpBoIg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5105
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]



-----Original Message-----
From: Powell, Darren <Darren.Powell@amd.com> 
Sent: Saturday, May 29, 2021 4:36 AM
To: amd-gfx@lists.freedesktop.org
Cc: Powell, Darren <Darren.Powell@amd.com>
Subject: [PATCH 2/6] amdgpu/pm: clean up smu_get_power_limit function signature

 add two new powerplay enums (limit_level, sample_window)  add enums to smu_get_power_limit signature  remove input bitfield stuffing of output variable limit  update calls to smu_get_power_limit

* Test
 AMDGPU_PCI_ADDR=`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`  AMDGPU_HWMON=`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | cut -d " " -f 10`  HWMON_DIR=/sys/class/hwmon/${AMDGPU_HWMON}

 lspci -nn | grep "VGA\|Display" ; \
 echo "=== power1 cap ===" ; cat $HWMON_DIR/power1_cap ;           \
 echo "=== power1 cap max ===" ; cat $HWMON_DIR/power1_cap_max ;   \
 echo "=== power1 cap def ===" ; cat $HWMON_DIR/power1_cap_default

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    | 14 ++++++++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 18 +++++-----
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  3 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 34 +++++++++++++++++--
 4 files changed, 57 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index b1cd52a9d684..ddbf802ea8ad 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -192,6 +192,20 @@ enum pp_df_cstate {
 	DF_CSTATE_ALLOW,
 };
 
+enum pp_power_limit_level
+{
+	PP_PWR_LIMIT_MIN = -1,
+	PP_PWR_LIMIT_CURRENT,
+	PP_PWR_LIMIT_DEFAULT,
+	PP_PWR_LIMIT_MAX,
+};
+
+ enum pp_power_sample_window
+{
+	PP_PWR_WINDOW_DEFAULT,
+	PP_PWR_WINDOW_FAST,
+};
+

< > The limits are not limited to sample window. There are limits like APU only limit, platform limit and totally obscure ones like PPT0/PPT1 etc. 
It's better that the new enum takes care of those as well in case there is a need to make them available through sysfs.

Thanks,
Lijo

 #define PP_GROUP_MASK        0xF0000000
 #define PP_GROUP_SHIFT       28
 
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 13da377888d2..f7b45803431d 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2717,8 +2717,8 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,  {
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int limit_type = to_sensor_dev_attr(attr)->index;
-	uint32_t limit = limit_type << 24;
+	enum pp_power_sample_window sample_window = to_sensor_dev_attr(attr)->index;
+	uint32_t limit;
 	uint32_t max_limit = 0;
 	ssize_t size;
 	int r;
@@ -2735,7 +2735,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
 	}
 
 	if (is_support_sw_smu(adev)) {
-		smu_get_power_limit(&adev->smu, &limit, SMU_PPT_LIMIT_MAX);
+		smu_get_power_limit(&adev->smu, &limit, PP_PWR_LIMIT_MAX, 
+sample_window);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
 	} else if (pp_funcs && pp_funcs->get_power_limit) {
 		pp_funcs->get_power_limit(adev->powerplay.pp_handle,
@@ -2757,8 +2757,8 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,  {
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int limit_type = to_sensor_dev_attr(attr)->index;
-	uint32_t limit = limit_type << 24;
+	enum pp_power_sample_window sample_window = to_sensor_dev_attr(attr)->index;
+	uint32_t limit;
 	ssize_t size;
 	int r;
 
@@ -2774,7 +2774,7 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
 	}
 
 	if (is_support_sw_smu(adev)) {
-		smu_get_power_limit(&adev->smu, &limit, SMU_PPT_LIMIT_CURRENT);
+		smu_get_power_limit(&adev->smu, &limit, PP_PWR_LIMIT_CURRENT, 
+sample_window);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
 	} else if (pp_funcs && pp_funcs->get_power_limit) {
 		pp_funcs->get_power_limit(adev->powerplay.pp_handle,
@@ -2796,8 +2796,8 @@ static ssize_t amdgpu_hwmon_show_power_cap_default(struct device *dev,  {
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int limit_type = to_sensor_dev_attr(attr)->index;
-	uint32_t limit = limit_type << 24;
+	enum pp_power_sample_window sample_window = to_sensor_dev_attr(attr)->index;
+	uint32_t limit;
 	ssize_t size;
 	int r;
 
@@ -2813,7 +2813,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_default(struct device *dev,
 	}
 
 	if (is_support_sw_smu(adev)) {
-		smu_get_power_limit(&adev->smu, &limit, SMU_PPT_LIMIT_DEFAULT);
+		smu_get_power_limit(&adev->smu, &limit, PP_PWR_LIMIT_DEFAULT, 
+sample_window);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
 	} else if (pp_funcs && pp_funcs->get_power_limit) {
 		pp_funcs->get_power_limit(adev->powerplay.pp_handle,
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 523f9d2982e9..b97b960c2eac 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1262,7 +1262,8 @@ enum smu_cmn2asic_mapping_type {  #if !defined(SWSMU_CODE_LAYER_L2) && !defined(SWSMU_CODE_LAYER_L3) && !defined(SWSMU_CODE_LAYER_L4)  int smu_get_power_limit(struct smu_context *smu,
 			uint32_t *limit,
-			enum smu_ppt_limit_level limit_level);
+			enum pp_power_limit_level pp_limit_level,
+			enum pp_power_sample_window sample_window);
 
 bool smu_mode1_reset_is_support(struct smu_context *smu);  bool smu_mode2_reset_is_support(struct smu_context *smu); diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 8aff67a667fa..44c1baa2748d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2168,14 +2168,44 @@ static int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
 
 int smu_get_power_limit(struct smu_context *smu,
 			uint32_t *limit,
-			enum smu_ppt_limit_level limit_level)
+			enum pp_power_limit_level pp_limit_level,
+			enum pp_power_sample_window sample_window)
 {
-	uint32_t limit_type = *limit >> 24;
+	enum smu_ppt_limit_level limit_level;
+	uint32_t limit_type;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
+	switch(sample_window) {
+	case PP_PWR_WINDOW_DEFAULT:
+		limit_type = SMU_DEFAULT_PPT_LIMIT;
+		break;
+	case PP_PWR_WINDOW_FAST:
+		limit_type = SMU_FAST_PPT_LIMIT;
+		break;
+	default:
+		return -EOPNOTSUPP;
+		break;
+	}
+
+	switch(pp_limit_level){
+	case PP_PWR_LIMIT_CURRENT:
+		limit_level = SMU_PPT_LIMIT_CURRENT;
+		break;
+	case PP_PWR_LIMIT_DEFAULT:
+		limit_level = SMU_PPT_LIMIT_DEFAULT;
+		break;
+	case PP_PWR_LIMIT_MAX:
+		limit_level = SMU_PPT_LIMIT_MAX;
+		break;
+	case PP_PWR_LIMIT_MIN:
+	default:
+		return -EOPNOTSUPP;
+		break;
+	}
+
 	mutex_lock(&smu->mutex);
 
 	if (limit_type != SMU_DEFAULT_PPT_LIMIT) {
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

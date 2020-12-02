Return-Path: <SRS0=1d7w=FG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC751C64E8A
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Dec 2020 02:09:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44ED521D7E
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Dec 2020 02:09:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44ED521D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8CD16E9A0;
	Wed,  2 Dec 2020 02:09:25 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BE5A6E9A0
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Dec 2020 02:09:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CI4MTjmcRmNccBzGdcb2oFJUI1IOsJ89btddgIJqjrsrCzV7k5pWNzTJumUk0fDQJURWSFbOM9+FSQFELMECcXlNtnvUfPdfyEmYPHb/TBsIK0AoGKZnZle5xPd1NXDtbhmQM8l51Mu0FwRYzBSwEQO1iJWeA0qkj0WrMB8VJbQBUw2Ld2FUZ2/TILnKqiTS8K6tzLwMiuIGwcFOgPAAxl9dVf+wYNsYWJ9YQ9K3JeC+jNodfM2gCbkG+rAQCoYPa5Wh3hssUk9jiVeY5YIJ4E9XH1GZK/8mLKoNVTMDrqEYMwFyuMGE20YhFQIxnU+wfXjo2Lgj0G+iH+rRDV8QPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vh8edyJS/QQSRHKmeGmHBWz66PJq+cfgQdvDU81Iak8=;
 b=OQ23sz9ftAwGw5mQvlT9bXkXHPA4bKPRTW8ciAOq6g02DKGg5V/hSFBa+3sPgapiQ8X61InokYAqmTnys3OaIlIrwn3iCfqHVSHvWaEUQzhJ3eDLr1TvPgk1giooz+462HT+DHrdIeyS6Xj4YaV3JXi/OceIDb3SNeyMk3jyLKoQaQU8wn5TdZOKs5iB0sRiD5rfiPu/4OVi8RAXEesOnx4xOhkZt/29g7MpwrY5X/SORgZOQPaGipIHpvAq2o8xfGit337r4TzXL62Bf5Rbsq6w8FuV+vpLVB6CVneJmkR4RYwASHX6i3kOe9Z01jKXmLlDj27sgjG40p10JxCq5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vh8edyJS/QQSRHKmeGmHBWz66PJq+cfgQdvDU81Iak8=;
 b=tvvq23dMgN4yDScqdB1wB0RhDiF2FxpVtv5VFBpD3J71bsw32YSJBSFnTeuEier+6Vm1cFz5i1Zl9KIO7ziDCMO2nAJr1+V5A/Q4qPV6R+TY/M69C8Y15g4mDO71b2gHY7eUVkAMoYOfL1c/WKGv4WbM2v5X/3y5Qfflb10ZLtM=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3275.namprd12.prod.outlook.com (2603:10b6:5:185::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.25; Wed, 2 Dec 2020 02:09:23 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3589.030; Wed, 2 Dec 2020
 02:09:23 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/5] drm/amdgpu/swsmu/vangogh: simplify sensor handling
Thread-Topic: [PATCH 3/5] drm/amdgpu/swsmu/vangogh: simplify sensor handling
Thread-Index: AQHWyAmefUEtwgbiF0Wd4Q1uRtM2/anjEDMw
Date: Wed, 2 Dec 2020 02:09:23 +0000
Message-ID: <DM6PR12MB2619BAECF0CB33DA7A8AEAD1E4F30@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20201201174413.643254-1-alexander.deucher@amd.com>
 <20201201174413.643254-3-alexander.deucher@amd.com>
In-Reply-To: <20201201174413.643254-3-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=1ea433a3-6197-4a66-9197-12f06ad758aa;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-02T02:09:17Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 798e7ae5-1f06-4ef8-fa25-08d89667498b
x-ms-traffictypediagnostic: DM6PR12MB3275:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB32753B62F265407B4C715951E4F30@DM6PR12MB3275.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1002;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v54u3s1UyV/rao8uh1aiaExM/bpUXnOnkm39uUSsf1UF9BE88tqeJ6gm6CMUVWCyFUD4g8MwMQAuRAOrgVmMYKjMBOxkSEhSnDG67ZukGSfr1AVxrfVMI/N7s9m/TVAvIeNVLaJg97eo9XpUEYd+ceJH3L9RXh+4TRWnW+6Hl3YoLbMUFSbJPkK/7Shd4KbswIYKFOCC4wulTUgoC966tA1cBt07YZw7xFlPoaNDVuIJMzBRPFk7wBvvhk4YE79PlNd6EYa9SbBarL9LMKbgTjCzpSzGj0Ew4yo1C/59mAq3jgvOmqBwFU1IQaCgE5QnVVaA1ZI8seJG2vwXB/oG8ZsX1ePKizVFYQo2JYn33YU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(366004)(39850400004)(396003)(66556008)(66946007)(5660300002)(66476007)(9686003)(966005)(8676002)(8936002)(2906002)(4326008)(83380400001)(6506007)(53546011)(186003)(55016002)(110136005)(64756008)(26005)(76116006)(45080400002)(316002)(478600001)(33656002)(7696005)(52536014)(86362001)(71200400001)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?iVBbksmvq8Sz1TA3ugno+1a7nxN9vnVRoXgY+q9+EBq841bbiXLYGKHXb9D2?=
 =?us-ascii?Q?pk+ukh9RTE9WrHqtGeeo6Z4fEKUcyNdyDhuzf8VSs1uZIEjlaCj1QusPRwoc?=
 =?us-ascii?Q?qRd6RN9OmrH/3n75IuhRCOZgZCtkwqEqqPjrMMkAWQn2yugOg+4WM5YCbZEi?=
 =?us-ascii?Q?yDSFP1k5oq4Rog2fUuD2e7SnGHSN1i6jxfMpGpG8nP7OQIQQ6iRvgrSVIQRD?=
 =?us-ascii?Q?+elRyXHQ55LjxNBH3Q1N0y2IaBxLjM+Q3YCLQVbXxdV4UOhPfdH9whR+LkNX?=
 =?us-ascii?Q?00k2EuAEyppZJG/zWMSI6A28ADsIvTPQc0m2fsbMXh+rWMm4Cy+DCzYdKB2C?=
 =?us-ascii?Q?Yn+lZgV/Dr7mvgzzzQ+88E4Ix0Tx1exQCYKKIzn3j+ur0fsCYFZb8cMyU24w?=
 =?us-ascii?Q?enrP30c+UIT2t1/iK+ZyvQtU8dJ1PMhb0zFLn5MtfWwhYAMX0TyUet41t/xU?=
 =?us-ascii?Q?VVKlATMKu2kETUazD0R91O9nvP1x0+KzApW0OUh6/Fib63fVb3Jrn/ssMCKa?=
 =?us-ascii?Q?KA+GRfB8JP1ANsmvku/JYgd+rWO/ycCa5toSD/B9HA7UmiWdUMapMhTVv/bU?=
 =?us-ascii?Q?e/HZhPog9y1/Sl6hDI27CSnFvle2jz51bo8cdfanFlH1qiynDje7AmZDKBOX?=
 =?us-ascii?Q?42+Ilo+nmio88jUDMajZ3AY/ZiSryOuj7BY4+bvVh0Rp/OaYm32Ih/bGkWfY?=
 =?us-ascii?Q?TUZw95XdV8f4A5m+LywEtMHIHp78vXB593XgvGRs8ai+2FsvtS+rBOjpPrAN?=
 =?us-ascii?Q?yA5gOkANwgb1XfO6/1+fXpg0PwsevKdcaPgqAapPl69wGESE/yaFLGi8GvGp?=
 =?us-ascii?Q?5VkBZfFMoSNVlQ9h3HG3Rr2WM57zgv9JXpZGpuQFcV1XsPIGYj8yJo6oL008?=
 =?us-ascii?Q?+K/82BHYMZVlXc6p/BYDWwytVI1qMCunR/oryMKXw+kZCCJlcE3uj0j3UlZP?=
 =?us-ascii?Q?3GPODhzJiPZOjJH1tCvESftPi9EGEypjeiWB296Q4iA=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 798e7ae5-1f06-4ef8-fa25-08d89667498b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2020 02:09:23.1046 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: onlqb4v2Tm9GsFB9Zc6NhwMH3t82VJ+04xq/cYLAwp5GTRpdtuNEYQuJ3pcEvi8N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3275
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Wednesday, December 2, 2020 1:44 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 3/5] drm/amdgpu/swsmu/vangogh: simplify sensor handling

Just query the metrics table directly rather than going through an extra level of functions.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 114 +++---------------
 1 file changed, 20 insertions(+), 94 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 56704181c5a9..1645509cdab8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -396,95 +396,6 @@ static bool vangogh_is_dpm_running(struct smu_context *smu)
 return !!(feature_enabled & SMC_DPM_FEATURE);  }

-static int vangogh_get_current_activity_percent(struct smu_context *smu,
-       enum amd_pp_sensors sensor,
-       uint32_t *value)
-{
-int ret = 0;
-
-if (!value)
-return -EINVAL;
-
-switch (sensor) {
-case AMDGPU_PP_SENSOR_GPU_LOAD:
-ret = vangogh_get_smu_metrics_data(smu,
-  METRICS_AVERAGE_GFXACTIVITY,
-  value);
-if (ret)
-return ret;
-break;
-default:
-dev_err(smu->adev->dev, "Invalid sensor for retrieving clock activity\n");
-return -EINVAL;
-}
-
-return 0;
-}
-
-static int vangogh_get_gpu_power(struct smu_context *smu, uint32_t *value) -{
-if (!value)
-return -EINVAL;
-
-return vangogh_get_smu_metrics_data(smu,
-   METRICS_AVERAGE_SOCKETPOWER,
-   value);
-}
-
-static int vangogh_thermal_get_temperature(struct smu_context *smu,
-     enum amd_pp_sensors sensor,
-     uint32_t *value)
-{
-int ret = 0;
-
-if (!value)
-return -EINVAL;
-
-switch (sensor) {
-case AMDGPU_PP_SENSOR_HOTSPOT_TEMP:
-ret = vangogh_get_smu_metrics_data(smu,
-  METRICS_TEMPERATURE_HOTSPOT,
-  value);
-break;
-case AMDGPU_PP_SENSOR_EDGE_TEMP:
-ret = vangogh_get_smu_metrics_data(smu,
-  METRICS_TEMPERATURE_EDGE,
-  value);
-break;
-default:
-dev_err(smu->adev->dev, "Invalid sensor for retrieving temp\n");
-return -EINVAL;
-}
-
-return ret;
-}
-
-static int vangogh_get_current_clk_freq_by_table(struct smu_context *smu,
-       enum smu_clk_type clk_type,
-       uint32_t *value)
-{
-MetricsMember_t member_type;
-
-switch (clk_type) {
-case SMU_GFXCLK:
-member_type = METRICS_AVERAGE_GFXCLK;
-break;
-case SMU_MCLK:
-case SMU_UCLK:
-member_type = METRICS_AVERAGE_UCLK;
-break;
-case SMU_SOCCLK:
-member_type = METRICS_AVERAGE_SOCCLK;
-break;
-default:
-return -EINVAL;
-}
-
-return vangogh_get_smu_metrics_data(smu,
-   member_type,
-   value);
-}
-
 static int vangogh_print_fine_grain_clk(struct smu_context *smu,
 enum smu_clk_type clk_type, char *buf)  { @@ -526,25 +437,40 @@ static int vangogh_read_sensor(struct smu_context *smu,
 mutex_lock(&smu->sensor_lock);
 switch (sensor) {
 case AMDGPU_PP_SENSOR_GPU_LOAD:
-ret = vangogh_get_current_activity_percent(smu, sensor, (uint32_t *)data);
+ret = vangogh_get_smu_metrics_data(smu,
+   METRICS_AVERAGE_GFXACTIVITY,
+   (uint32_t *)data);
 *size = 4;
 break;
 case AMDGPU_PP_SENSOR_GPU_POWER:
-ret = vangogh_get_gpu_power(smu, (uint32_t *)data);
+ret = vangogh_get_smu_metrics_data(smu,
+   METRICS_AVERAGE_SOCKETPOWER,
+   (uint32_t *)data);
 *size = 4;
 break;
 case AMDGPU_PP_SENSOR_EDGE_TEMP:
+ret = vangogh_get_smu_metrics_data(smu,
+   METRICS_TEMPERATURE_EDGE,
+   (uint32_t *)data);
+*size = 4;
+break;
 case AMDGPU_PP_SENSOR_HOTSPOT_TEMP:
-ret = vangogh_thermal_get_temperature(smu, sensor, (uint32_t *)data);
+ret = vangogh_get_smu_metrics_data(smu,
+   METRICS_TEMPERATURE_HOTSPOT,
+   (uint32_t *)data);
 *size = 4;
 break;
 case AMDGPU_PP_SENSOR_GFX_MCLK:
-ret = vangogh_get_current_clk_freq_by_table(smu, SMU_UCLK, (uint32_t *)data);
+ret = vangogh_get_smu_metrics_data(smu,
+   METRICS_AVERAGE_UCLK,
+   (uint32_t *)data);
 *(uint32_t *)data *= 100;
 *size = 4;
 break;
 case AMDGPU_PP_SENSOR_GFX_SCLK:
-ret = vangogh_get_current_clk_freq_by_table(smu, SMU_GFXCLK, (uint32_t *)data);
+ret = vangogh_get_smu_metrics_data(smu,
+    METRICS_AVERAGE_GFXCLK,
+    (uint32_t *)data);
 *(uint32_t *)data *= 100;
 *size = 4;
 break;
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C5f115dcc956a4de6e39b08d89620c005%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637424414689469422%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=fCDZnzOSHhcDw4Um2KZ%2ByK%2B8CInYTywSZBLSgYwa8YQ%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

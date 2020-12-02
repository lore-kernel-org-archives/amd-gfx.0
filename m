Return-Path: <SRS0=1d7w=FG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDED6C64E8A
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Dec 2020 02:14:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7377A221E2
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Dec 2020 02:14:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7377A221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F340E6E99B;
	Wed,  2 Dec 2020 02:14:54 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770057.outbound.protection.outlook.com [40.107.77.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8791F6E99B
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Dec 2020 02:14:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkWXxXQvHaV+VYpQddnw3+NwhpP4fEkBw6FTgruXJEYOV6tJcPZs1nCu764uON+V3CKIvjNVLKZx68+zHzVkY29xgeXwRuIGuUrAYsMK0IUd3yF+lS7cjgz9a8ENzCEHXBUVZpI95B5eqh4U2F7GdPZw2Ogr6mTYKemjPZ82AP3jFB5Dgh1e8f5TBVDQQpy1nzUK8KTS0VRjHvRBgxbpl3RojJypMNhikGrT7P3JJI5ifj9mx2ehQy8twwcTlZU54e2Op5q0+wZaMls08T9+efs1HrtdF+f4q/Nq0mb3l/0RtbJoR6t8E0oNMrxwm+N4wersO/WjKnpIspZvgTbq1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcwMGnnKQUEe59x9B5vQdqlnWxUzrTT711A4/+DfVas=;
 b=dd+RZnF5q7ITCGJ/J+DEfxEcFvDjHLqSWliUpUhVCFhGuPTwtFWf2MIck+GGMHJpLk/uZx0C4Mer3mt48M04u4+vFCWOX/6M3j7vDu3p8sP1Yjy5wj5D+06xKf//diHpuQmItqb9E6be6fSMB8fUl+SedNbEsIjEkJTpFA5bu2tXK35/m+fR6p1LKXnwXiIape2AvghtWmiQVSQdzbLbygwf5ivY5KM/tlF9XyiFKmrh/HsuxuP5DzG0/GJV0L6TF81UBL/SCqt+RWfeDIdQwCvPbRDD6HMLdDGqQ7cRpssvIZqeU42ydv7DTW+12VLLLdUMI0yFc0QghLivShITJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcwMGnnKQUEe59x9B5vQdqlnWxUzrTT711A4/+DfVas=;
 b=a7QKWLYi1xRn0UEwpbg5vzG1Hphru4pTBBQwIRSgoSKOOJ/EHKZqvo7UgHddJyjNm3q1ldlHt3HcIEHEfalraoCHZ4r8+eS4tRnFUD/EyMYY19mf5AKhr0i2V3zY65Af+PigVVZfxG5thVZmSeBVVd/w3y05B/gpwr3G+oJyC+s=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4058.namprd12.prod.outlook.com (2603:10b6:5:21d::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17; Wed, 2 Dec 2020 02:14:51 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3589.030; Wed, 2 Dec 2020
 02:14:51 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 5/5] drm/amdgpu/swsmu/renoir: simplify sensor handling
Thread-Topic: [PATCH 5/5] drm/amdgpu/swsmu/renoir: simplify sensor handling
Thread-Index: AQHWyAmgh/AS/GA2LU2+Vufhjjyh86njEU5g
Date: Wed, 2 Dec 2020 02:14:51 +0000
Message-ID: <DM6PR12MB2619F90FC504072883CA6BF9E4F30@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20201201174413.643254-1-alexander.deucher@amd.com>
 <20201201174413.643254-5-alexander.deucher@amd.com>
In-Reply-To: <20201201174413.643254-5-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=57712794-3480-45da-98e7-a2115d16e308;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-02T02:13:15Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d6e301ff-b30b-4f84-a5ed-08d896680d67
x-ms-traffictypediagnostic: DM6PR12MB4058:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4058FEB6CCC2FA5FBEF90A04E4F30@DM6PR12MB4058.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:747;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sFzZRVPHRhqGNRbr0nWEQHczrnuoCYIh6LWoJJTcl3SqcaY0L3itgYf5g1+h5JsEYqFm8qg0BarlwJD5Grfrnrefck3IReCKjRNgqGtVT/wG6BNbE3WMKgFfvYqVDJN5JyjYwpicuni0G4Kt0zJo9sWFqaGiw1FmXAfVDjEwLhsYavvX1Pao1BELL9L24K92sJGEixLMgJ3kiMN7vfWspHL8ix0fHfoQrz/7nNCNmTMFiqOHRjXT7TYY9eXjCmWYmqyqZAMfyTm2G0NgonhXCXhftUxGeyXs3wgJ7YUOkhbDHgT21szNCz8bGIb8AD8FYLak7+yh8OU6093AGfacbRQ8L0sZM8Xcf7dQHnTwpcQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(366004)(396003)(39860400002)(346002)(52536014)(53546011)(966005)(6506007)(4326008)(86362001)(26005)(45080400002)(478600001)(186003)(5660300002)(2906002)(33656002)(8936002)(316002)(110136005)(8676002)(71200400001)(7696005)(76116006)(66476007)(64756008)(66446008)(9686003)(66556008)(66946007)(83380400001)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?vpoibbLml7gv5J7QhtUC7Q7fGJO3XLQPOVwBlq+KwJmwCeWkj9D2iKzCmblt?=
 =?us-ascii?Q?W+Sk8f+EQlqyka3to+Wfqe51TP3NLvZo+2UnHVt9vfQaOIIfV59C2DtDBOdh?=
 =?us-ascii?Q?m+7mayoOreHYEF2S+ic48kIGwETTmly5i8IuhEqRU/aAYGSVxeTMjAajqf/x?=
 =?us-ascii?Q?ts6iZRZfLPmkIMUJtrDQpwrJBtxZqv86bL8qkHjn3WyxywnC9+q/PwoEtDmO?=
 =?us-ascii?Q?Gp4DyHZo+UCvcXq2O6s2hG7ul9APrj86hruYCfwRkMduF5pZQIHsZyzVxQRU?=
 =?us-ascii?Q?HMdQ0tnY/D+SReqvswKuqurZzh7Eqopot753qeWjFy8/MPpdF5fG+L3SzhNm?=
 =?us-ascii?Q?L20ioRFG7rY+rD4Yl6mnvrEGELL6B1lGbQa+78lNDybI4sdfr4vgUIeHrtd3?=
 =?us-ascii?Q?uEuvMO/ibOe0QjIxsonPq7/Nns3u07lfPqMo2jHmxMgGVM3EOJwqoLy0jHBm?=
 =?us-ascii?Q?lIq8QlCKi9V00HQtvum0QNECn9jH132k3th2j15yxNeiqmy3c+al+ApQrZPD?=
 =?us-ascii?Q?Tny5tWH8rNs7JXEFMEJ3B8osVgaiG4NO4Bqcbn17pompKpvKhaLSFDplDSwi?=
 =?us-ascii?Q?Mn/MbIf6p0CH4/IL4/4cEnPrfdXXY6oNwuR1N0pHiGCF1spzSJhePikgJRyq?=
 =?us-ascii?Q?BSHXUau1HjFuaTqfECcu5r8aeDNNRsLGEzsRYVc7QofblISmxmK7R/9rxB7X?=
 =?us-ascii?Q?4JJVjpl0FCa2EpDARXsSA8eVzJkp3veKOmynHnNRgxZf6PnwMnkV6nZqmZVe?=
 =?us-ascii?Q?ldzXv8+dM/O1JnqCS5C5N4kEkbfq33WFzjiO0ArU8e+ZflMWjDxUeQHifv1e?=
 =?us-ascii?Q?kHIFnQHVTVUILzh5BmN5rqLtMjvpp5mFhaQO47KggGWhdXeMRCToiqhTu7jJ?=
 =?us-ascii?Q?f/eLyDia/wGj1YzLw/LHMWGWqRy+G3t2MUV76ZUJBAv9F0g8kWbRwVaEu9+W?=
 =?us-ascii?Q?g1+TCvJrv9UWu4tirmTuU9FTasij0O+tGBSQcdBX/14=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e301ff-b30b-4f84-a5ed-08d896680d67
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2020 02:14:51.7199 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Ws0dFpHmRvYnQxz5z8ZXelW5HcmWaXsPwE9vlHIjq1OOoGd5Jc3mYCKXSlpw6bz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4058
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

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Wednesday, December 2, 2020 1:44 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 5/5] drm/amdgpu/swsmu/renoir: simplify sensor handling

Just query the metrics table directly rather than going through
an extra level of functions.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 205 ++++++++----------
 1 file changed, 93 insertions(+), 112 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index d3641a8ed99c..37e65c0b6136 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -492,28 +492,6 @@ static int renoir_dpm_set_jpeg_enable(struct smu_context *smu, bool enable)
 return ret;
 }

-static int renoir_get_current_clk_freq_by_table(struct smu_context *smu,
-       enum smu_clk_type clk_type,
-       uint32_t *value)
-{
-int ret = 0, clk_id = 0;
-SmuMetrics_t metrics;
-
-ret = smu_cmn_get_metrics_table(smu, &metrics, false);
-if (ret)
-return ret;
-
-clk_id = smu_cmn_to_asic_specific_index(smu,
-CMN2ASIC_MAPPING_CLK,
-clk_type);
-if (clk_id < 0)
-return clk_id;
-
-*value = metrics.ClockFrequency[clk_id];
-
-return ret;
-}
-
 static int renoir_force_dpm_limit_value(struct smu_context *smu, bool highest)
 {
 int ret = 0, i = 0;
@@ -574,88 +552,6 @@ static int renoir_unforce_dpm_levels(struct smu_context *smu) {
 return ret;
 }

-static int renoir_get_gpu_temperature(struct smu_context *smu, uint32_t *value)
-{
-int ret = 0;
-SmuMetrics_t metrics;
-
-if (!value)
-return -EINVAL;
-
-ret = smu_cmn_get_metrics_table(smu, &metrics, false);
-if (ret)
-return ret;
-
-*value = (metrics.GfxTemperature / 100) *
-SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
-
-return 0;
-}
-
-static int renoir_get_current_activity_percent(struct smu_context *smu,
-       enum amd_pp_sensors sensor,
-       uint32_t *value)
-{
-int ret = 0;
-SmuMetrics_t metrics;
-
-if (!value)
-return -EINVAL;
-
-ret = smu_cmn_get_metrics_table(smu, &metrics, false);
-if (ret)
-return ret;
-
-switch (sensor) {
-case AMDGPU_PP_SENSOR_GPU_LOAD:
-*value = metrics.AverageGfxActivity / 100;
-break;
-default:
-dev_err(smu->adev->dev, "Invalid sensor for retrieving clock activity\n");
-return -EINVAL;
-}
-
-return 0;
-}
-
-static int renoir_get_vddc(struct smu_context *smu, uint32_t *value,
-   unsigned int index)
-{
-int ret = 0;
-SmuMetrics_t metrics;
-
-if (index >= 2)
-return -EINVAL;
-
-if (!value)
-return -EINVAL;
-
-ret = smu_cmn_get_metrics_table(smu, &metrics, false);
-if (ret)
-return ret;
-
-*value = metrics.Voltage[index];
-
-return 0;
-}
-
-static int renoir_get_power(struct smu_context *smu, uint32_t *value)
-{
-int ret = 0;
-SmuMetrics_t metrics;
-
-if (!value)
-return -EINVAL;
-
-ret = smu_cmn_get_metrics_table(smu, &metrics, false);
-if (ret)
-return ret;
-
-*value = metrics.CurrentSocketPower << 8;
-
-return 0;
-}
-
 /*
  * This interface get dpm clock table for dc
  */
@@ -1011,6 +907,71 @@ static int renoir_get_power_profile_mode(struct smu_context *smu,
 return size;
 }

+static int renoir_get_smu_metrics_data(struct smu_context *smu,
+       MetricsMember_t member,
+       uint32_t *value)
+{
+struct smu_table_context *smu_table = &smu->smu_table;
+
+SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
+int ret = 0;
+
+mutex_lock(&smu->metrics_lock);
+
+ret = smu_cmn_get_metrics_table_locked(smu,
+       NULL,
+       false);
+if (ret) {
+mutex_unlock(&smu->metrics_lock);
+return ret;
+}
+
+switch (member) {
+case METRICS_AVERAGE_GFXCLK:
+*value = metrics->ClockFrequency[CLOCK_GFXCLK];
+break;
+case METRICS_AVERAGE_SOCCLK:
+*value = metrics->ClockFrequency[CLOCK_SOCCLK];
+break;
+case METRICS_AVERAGE_UCLK:
+*value = metrics->ClockFrequency[CLOCK_FCLK];
+break;
+case METRICS_AVERAGE_GFXACTIVITY:
+*value = metrics->AverageGfxActivity / 100;
+break;
+case METRICS_AVERAGE_VCNACTIVITY:
+*value = metrics->AverageUvdActivity / 100;
+break;
+case METRICS_AVERAGE_SOCKETPOWER:
+*value = metrics->CurrentSocketPower << 8;
+break;
+case METRICS_TEMPERATURE_EDGE:
+*value = (metrics->GfxTemperature / 100) *
+SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+break;
+case METRICS_TEMPERATURE_HOTSPOT:
+*value = (metrics->SocTemperature / 100) *
+SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+break;
+case METRICS_THROTTLER_STATUS:
+*value = metrics->ThrottlerStatus;
+break;
+case METRICS_TEMPERATURE_VRGFX:
+*value = metrics->Voltage[0];
+break;
+case METRICS_TEMPERATURE_VRSOC:
[Quan, Evan] same as patch4. New macros like "METRICS_VDDGFX" , "METRICS_VDDSOC/NB" are recommended.
+*value = metrics->Voltage[1];
+break;
+default:
+*value = UINT_MAX;
+break;
+}
+
+mutex_unlock(&smu->metrics_lock);
+
+return ret;
+}
+
 static int renoir_read_sensor(struct smu_context *smu,
  enum amd_pp_sensors sensor,
  void *data, uint32_t *size)
@@ -1023,33 +984,53 @@ static int renoir_read_sensor(struct smu_context *smu,
 mutex_lock(&smu->sensor_lock);
 switch (sensor) {
 case AMDGPU_PP_SENSOR_GPU_LOAD:
-ret = renoir_get_current_activity_percent(smu, sensor, (uint32_t *)data);
+ret = renoir_get_smu_metrics_data(smu,
+  METRICS_AVERAGE_GFXACTIVITY,
+  (uint32_t *)data);
+*size = 4;
+break;
+case AMDGPU_PP_SENSOR_EDGE_TEMP:
+ret = renoir_get_smu_metrics_data(smu,
+  METRICS_TEMPERATURE_EDGE,
+  (uint32_t *)data);
 *size = 4;
 break;
-case AMDGPU_PP_SENSOR_GPU_TEMP:
-ret = renoir_get_gpu_temperature(smu, (uint32_t *)data);
+case AMDGPU_PP_SENSOR_HOTSPOT_TEMP:
+ret = renoir_get_smu_metrics_data(smu,
+  METRICS_TEMPERATURE_HOTSPOT,
+  (uint32_t *)data);
 *size = 4;
 break;
 case AMDGPU_PP_SENSOR_GFX_MCLK:
-ret = renoir_get_current_clk_freq_by_table(smu, SMU_UCLK, (uint32_t *)data);
+ret = renoir_get_smu_metrics_data(smu,
+  METRICS_AVERAGE_UCLK,
+  (uint32_t *)data);
 *(uint32_t *)data *= 100;
 *size = 4;
 break;
 case AMDGPU_PP_SENSOR_GFX_SCLK:
-ret = renoir_get_current_clk_freq_by_table(smu, SMU_GFXCLK, (uint32_t *)data);
+ret = renoir_get_smu_metrics_data(smu,
+  METRICS_AVERAGE_GFXCLK,
+  (uint32_t *)data);
 *(uint32_t *)data *= 100;
 *size = 4;
 break;
 case AMDGPU_PP_SENSOR_VDDGFX:
-ret = renoir_get_vddc(smu, (uint32_t *)data, 0);
+ret = renoir_get_smu_metrics_data(smu,
+  METRICS_TEMPERATURE_VRGFX,
+  (uint32_t *)data);
 *size = 4;
 break;
 case AMDGPU_PP_SENSOR_VDDNB:
-ret = renoir_get_vddc(smu, (uint32_t *)data, 1);
+ret = renoir_get_smu_metrics_data(smu,
+  METRICS_TEMPERATURE_VRSOC,
+  (uint32_t *)data);
 *size = 4;
 break;
 case AMDGPU_PP_SENSOR_GPU_POWER:
-ret = renoir_get_power(smu, (uint32_t *)data);
+ret = renoir_get_smu_metrics_data(smu,
+  METRICS_AVERAGE_SOCKETPOWER,
+  (uint32_t *)data);
 *size = 4;
 break;
 default:
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C0d39a3402b1f49d4a89408d89620c172%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637424414718000026%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=nXeNXvyiMx2A2ZZOZ9OSUc9lPfpMQ4Ppbr%2FQo5xRa%2FU%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=1d7w=FG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6360FC64E7C
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Dec 2020 03:22:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2214221E2
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Dec 2020 03:22:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2214221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95CB96E9AB;
	Wed,  2 Dec 2020 03:22:40 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C9CB6E9A6
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Dec 2020 03:22:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUjHUzbidDY3XYf6A+keKvDXvkNPe/DrDlTa8F94xILIE1I//0kf+EHpXjz9pAiHsN9LOhL70DabuyndOejwMniEJFaEZYrS9AcsIAbfXcqX9sCtfJ0X2BHlDjtQ31gXqYRO1lDnWhakUVZO/q6Y5t0CkA/JDAtwERCneMadkEQZBlTbp7vH4z3qoHfJmtbFjRQbSF/O+ArumB8P8jqxyNuNXdJRW0s1e8PsKqSMKRpZ4orKnxnpyviQNC1QuO/1ikmL8ndX8GumPjG/ZpbDJVeoE1qMQaKvmDyXx6h6d63cmSCjakxOdVetqhif0R4N005cXMP6nQCgk2wqv91ovA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8yjZGkcRsPhVgsKTP4wlJ9nrXnAFD+WZPrOE71CVvA=;
 b=ab/OTmGNAjCkY3oovdPvwt+6AeI/lDHDgcDZ5DfSKTR139lElAIN6CQllZR2v6sH9syaZYPfjZKYrrvo540V7XIg9JAim/+E6rqdHB8JeIGi2a6YvczCgOgH7k5eY3ZEr69cfdEkD79U49IcvgQG70l4l4DHQbXyOX6HeqiYSJjJXm40+AlPw1SD4ISASQMRnr/NmMteWEH9JsKTi5HXkI+5/fSM4txLO8/uyvogI9XqJB8oT0tcs/Zveh033F/N+dAkmpkEit/MyXfPuPDmVz/0Uo1aQksjYjz1GpV1lZNkdW29f9MtcJzRiOwn8Z/h5nCRiv/JgSLYRvxTsUHb3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8yjZGkcRsPhVgsKTP4wlJ9nrXnAFD+WZPrOE71CVvA=;
 b=mPP/Sg1ihO3nthAN51fe/URhNyf6v9RC0F+MNeyc7grPJEmhNRmcfSn9FKok37dchAknesAz6/OizdafOyZMWhnPV3rP0tYRjNrm1pTYYRqUXSgUbA0LiQtd6pgfRgKWOXBpGv6iPmkoeewbs7YbfsbPzgZkwkqExHNf9OOE/eQ=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3580.namprd12.prod.outlook.com (2603:10b6:5:11e::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.25; Wed, 2 Dec 2020 03:22:37 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3589.030; Wed, 2 Dec 2020
 03:22:37 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/4] drm/amdgpu/swsmu/renoir: simplify sensor handling (v2)
Thread-Topic: [PATCH 4/4] drm/amdgpu/swsmu/renoir: simplify sensor handling
 (v2)
Thread-Index: AQHWyFf5o13AecHmk0KAJUYZHygKGKnjI9+w
Date: Wed, 2 Dec 2020 03:22:36 +0000
Message-ID: <DM6PR12MB2619975D0668EEA1AC663EB7E4F30@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20201202030505.1310154-1-alexander.deucher@amd.com>
 <20201202030505.1310154-4-alexander.deucher@amd.com>
In-Reply-To: <20201202030505.1310154-4-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=4fe7b066-8944-4263-8f18-51520222097e;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-02T03:21:53Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a1c6b087-c281-4978-7a5a-08d896718479
x-ms-traffictypediagnostic: DM6PR12MB3580:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB35805F43B99A065E04408FC8E4F30@DM6PR12MB3580.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:862;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a+6CPak1QxDs8pQAc01MPvCmGH5LoHy1TK2awEr7DYfLHItKTnmUjviMpXjzhZIsGXBq0LSSMl9fvujyR7EqYN16VzyObX8RIdklO8gPaJ9putkpzcBp8LRJ5aGcRYRHe7WtII1FQbb9/OboOTG3KzgjYdRpwBA08sLzmFC1xbM9Qm+kCSubA4A2tkoTgNIytYlCn+q869Wl7DqcWNMqLBScfYo3EAm+Ctkbd/3kgr+QPKlRaHFH16rIMYi7evTeUJc9SSEqbLA23iv8JNRewGlUpLoZ2ZVFR7Lhbh3vOarjfrgGp1WyP0Tmi68DUjyglMirFiCnKZw+UD7s8nMGkTOdXdvMcIsF4vkmIzzQcco=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(2906002)(8936002)(26005)(8676002)(71200400001)(33656002)(76116006)(186003)(7696005)(83380400001)(66476007)(86362001)(66946007)(64756008)(6506007)(66446008)(66556008)(53546011)(4326008)(110136005)(9686003)(52536014)(55016002)(966005)(478600001)(316002)(45080400002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?nK/HBkTaUPJcTYHkZvQJ5H4YGS4sdfOF82JHv0W+TZw9tTGM/mMvNqVpW3wD?=
 =?us-ascii?Q?98YtgIKXaxh+XvE6rVz5COwVGNCLyi/D773/eWrisdNOByGtyjX9dopyrukT?=
 =?us-ascii?Q?ob8Y7itdsVAub8bYmr8R/5NA84Kybyiih815Gdw7eA2+6fCf2U8ypC9xIDCf?=
 =?us-ascii?Q?x7RkXYwCLfx4d+7lMSwcPXAEaAAhcMR9LWPqviiQSrBEt6qJWeY0OdpZEaiT?=
 =?us-ascii?Q?q3H//azVaoMEjnXc2aMqEa0fLrk8nJkvKv1yT4P4BLCQcU+AzostL/AxgJlX?=
 =?us-ascii?Q?AEOXezY+5dy2HveoCeIdofaNCuFzhebnoAZhNCtsl+VKUnB7MIzbND5yV465?=
 =?us-ascii?Q?RvaxA7JzjJUZBEibvm7+U3VoOkKHraFsUSM5E++KsDp3ITG465bc7VjHwUH7?=
 =?us-ascii?Q?3QCC5W/J0oaRhr5021R49MJA/gIstKbtVVbeMJWHKc3n+Q02Bm+zwvtjpzGa?=
 =?us-ascii?Q?dAqMF0nWco0G3ots7pP0vst9yZj0Wgb1cVL4yTWjO+pivLzG7y/rcADOS/z/?=
 =?us-ascii?Q?mTuJGKSswBRoc9qv2jGdfD8UDiEaee5j5cuQ3UfNIeTd54DGIEEE4zB96xa/?=
 =?us-ascii?Q?6V7XDOPRJDcpNVEodz2AYzsA9MSzA+sLnG1zmKYBMHYr7lb774c//A2GXN8O?=
 =?us-ascii?Q?K57mSgrL9EkFX/iQjL+e2SSj3X2EjvwCeLFDbIoyLWHzZYYnZT4x/ZZK+xIQ?=
 =?us-ascii?Q?nHOM/VvpZ0pcgWDwgA1juarkrvdn5fsq7pasNYcuYrDaiEFhd1zLK8JJpQFJ?=
 =?us-ascii?Q?wckox69LNKvko7AepCZjI0YkGsTyn9nutz6mP3hLxS8JI44RkBso4spu8nHy?=
 =?us-ascii?Q?luc2qq6MQgktW+tzu6dvWkFLzHojeI5e5Ol7RTaCTNwUdAnIIwOSH34K0toE?=
 =?us-ascii?Q?V2Qalqlt4B9yg1xF6uyE7dMUNaQuTWzE8kXplz4lOZ3wVwGGxCQqKmLyoDwE?=
 =?us-ascii?Q?PJ/4e4esvB1TKiVPPfmuSltOHou+P7vMGW5iF0ic6jD7i/h7AnXQzey4XrW6?=
 =?us-ascii?Q?NRDD?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c6b087-c281-4978-7a5a-08d896718479
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2020 03:22:36.9307 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AfOMI0NBaU+IW5TVpVnLUFrRSzNNvpLMdEOKfQPTTNoDLjU3GK5Tp3eIqF53llyt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3580
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

Series is reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Wednesday, December 2, 2020 11:05 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 4/4] drm/amdgpu/swsmu/renoir: simplify sensor handling (v2)

Just query the metrics table directly rather than going through an extra level of functions.

v2: use proper enum

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 205 ++++++++----------
 1 file changed, 93 insertions(+), 112 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index d3641a8ed99c..dc75db8af371 100644
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
 static int renoir_force_dpm_limit_value(struct smu_context *smu, bool highest)  {
 int ret = 0, i = 0;
@@ -574,88 +552,6 @@ static int renoir_unforce_dpm_levels(struct smu_context *smu) {
 return ret;
 }

-static int renoir_get_gpu_temperature(struct smu_context *smu, uint32_t *value) -{
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
-static int renoir_get_power(struct smu_context *smu, uint32_t *value) -{
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
+case METRICS_VOLTAGE_VDDGFX:
+*value = metrics->Voltage[0];
+break;
+case METRICS_VOLTAGE_VDDSOC:
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
+  METRICS_VOLTAGE_VDDGFX,
+  (uint32_t *)data);
 *size = 4;
 break;
 case AMDGPU_PP_SENSOR_VDDNB:
-ret = renoir_get_vddc(smu, (uint32_t *)data, 1);
+ret = renoir_get_smu_metrics_data(smu,
+  METRICS_VOLTAGE_VDDSOC,
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
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C096746aedf0c4c44c27308d8966f1afd%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637424751225267833%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=KojdAXTZ9XnM55pOoR8djuoKWMYBY7iDucfFuLp6wGA%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

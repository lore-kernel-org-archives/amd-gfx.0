Return-Path: <SRS0=6/kp=FO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40A8C4167B
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 15:20:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32A3C2310E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 15:20:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A3C2310E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77A846E3F7;
	Thu, 10 Dec 2020 15:20:37 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AF766E3F7
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 15:20:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kmh9L3joo3stKsuZvN87J+2VDjYSZoSlEcqC5Ya/K0J3vKHzPPDNKXiIkmUF3Ut6fSnaE9OxmqqhvjaRN0AZbMwP+xVPMKIEPe7WIkLSDFtiEet2B6UaWTtJvYFoXuI0Je1U2TukfbXeJxkNuTGuT2Kmvn2QLBONqSQuyQK+txqgxuSe9vP2LOs4qbiPOFZyRtkkmTZO4mzztbCHrAkQyX+mfhJDgR6dvkJRq/N+fmwgxSqPH1wijxSPUQBZ7fP6t2bBgeDmHR3JlwkbY/YoBvfZgdnWP7k8bmcXyGP2tIU3G/MA/MAH7/EwnZsYh8dlEvuVKApRH9JsnQa4DExqaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FerrFQUuCM7v5TVMVCe1Y7TJXK7dGKgMe9UXj7WyHMU=;
 b=ZrPRIj/UHcQzOZG9h5Akib0ZjASCaD7TFsYhvrfaximugHpEyGYjR0AJlG5x6KPVl8hJ4GnViHHlANasgc4waqV+ywxdwE/QteUeNaVi4K5Z+WGyLuzgf2uRdfOkmYcb+HPrCDmVbhbX0tIEw6HVzJandvGBeZy63NRfbHJaWE7jBEKH0QUkoAFNUpUzP659LelZuvezIrbYzukDtFJ9IN2OBx9KlWh6YxmHmMxaFcAP2BX8UgmoPx8Rwyz/BTTpcTc7PUUzjl140ndWJFJzdmMrf+BC65GkVcT4GZZQYIJ+j25kUhxkcwSuqQuj5XR0gsbKY0wFLX1HhDa+DtluWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FerrFQUuCM7v5TVMVCe1Y7TJXK7dGKgMe9UXj7WyHMU=;
 b=BpGRq0FwlCWIVDtr8ApGAS2IlcD7m7plfd4qI5Hhfh6p3+WdG+tY8ehJjs4ER2psxS8YRUEwt6TwgyoBBeVX/EpZLtSdu9LC5o5Z+8LuIB8g4fJjlMcNAqr6btHTihaFZGIA2nC0+d1RgNDFBfdaV8oOvgjMVllgBOLZ7Kt2p2c=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2467.namprd12.prod.outlook.com (2603:10b6:207:4c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Thu, 10 Dec
 2020 15:20:34 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::fca3:155c:bf43:94af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::fca3:155c:bf43:94af%5]) with mapi id 15.20.3632.019; Thu, 10 Dec 2020
 15:20:34 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amd/pm: update the data strucutre for SMU metrics
 exchange
Thread-Topic: [PATCH 2/2] drm/amd/pm: update the data strucutre for SMU
 metrics exchange
Thread-Index: AQHWzsOcT4NDKuOsSEe+Yfa/TIpDyqnwclkU
Date: Thu, 10 Dec 2020 15:20:34 +0000
Message-ID: <MN2PR12MB44886A9AF80CE5113738756AF7CB0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20201210071031.198001-1-evan.quan@amd.com>,
 <20201210071031.198001-2-evan.quan@amd.com>
In-Reply-To: <20201210071031.198001-2-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-10T15:20:33.972Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.78.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e258ebcf-6ca1-4f24-1a3e-08d89d1f2416
x-ms-traffictypediagnostic: BL0PR12MB2467:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB24672E0C3EDCE185A4E452D5F7CB0@BL0PR12MB2467.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:923;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P2U0Hrv98ZMtnx88EFSydR2+zKohd5J0r782BCjsnBGRTJEY/dATVOJ9gGAHqrR6Ji6kXOIjdVaq31gSwHUDLp5vQG0SztzvAooBTIoDSX+GB1BTCzcF3dLyvrq5FEJe46FM4SXNbSH8tcUH0PuJgMGqsVyFYTFylP6DCE1ft39mlUEak1qYPsHp3cm9nprJ1A1H7lPfnE0mhBTG4Mly+RBTfgdVj5A0TQv9mO2AAQ1N2abObUp04mAypORUCylwZP4KeKzI8yZHFuTZ/TvFCGX1NRSDQiZuMCEAEHYPa/SkQ6UTrNGxkkfMtuT9AC5p
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(376002)(19627405001)(6506007)(66556008)(83380400001)(15650500001)(76116006)(53546011)(2906002)(8676002)(9686003)(66446008)(508600001)(55016002)(33656002)(7696005)(52536014)(110136005)(71200400001)(66476007)(86362001)(186003)(66946007)(26005)(8936002)(5660300002)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?yJTGZUgcOTrrfdpbvkmscez/4yOrYsK+5f78GNjgFvjbKe1oWM8yZkaPmdNV?=
 =?us-ascii?Q?rnwJsVRFcrrLJx5ufmSKaSySH4KahfV0BW22/N0vN4gZ2pQmjZjQ16kzXwZV?=
 =?us-ascii?Q?oIeS2ozrPU+uNU4FygKx1DuaWAvTKEASDJkcaSJ1+PYgYfhqb/Wf9n9kj1Zh?=
 =?us-ascii?Q?2tcDhU/5x671RGq2tXEAzgEnXnVq01++v70E+3y9sJWWwr9Ap4rlITFEMxCy?=
 =?us-ascii?Q?L1u7tFa6oSmktxlqvRpI8ECLnOURqbYM9flQ+vWw3OBipxb94aMXUzm8y2XX?=
 =?us-ascii?Q?/vcEggxqn94DjRFrZyj26C+IbHp75Cr0FBYiDrHkliCbcsbuZDoBmX00RGty?=
 =?us-ascii?Q?A0xb0xeyKvtKJm3rZ3ZWZQDvOyajrMEPD8J9s3glyq47fhmKCpLE9OBbc6BC?=
 =?us-ascii?Q?Cwu36gWx5NqsOK1HKbxaRK+YtPL2HbLfxKR9yZQktDF9gVw2Pw42qW/SoPOh?=
 =?us-ascii?Q?YHyi0EnjYzt3dkfPemjbBznMuP3dKeGtpPb7vPd2hFerY9x/W9CS5mre89mI?=
 =?us-ascii?Q?6mi/YuvG/PmDUBYuvo9W01EzVgBaWpmauz/doBF5L11LP80RFw69FeCMql+P?=
 =?us-ascii?Q?b86rsgDb9eH9PNVP5HhfIOlXIAs3G628RLh4uXYyMEAoUjfWDnJN699sJGz+?=
 =?us-ascii?Q?91ADUDIW700NrDb0vQYpcw5OMDgIf4VPYiqewz4uFaekKIWantpdUdPyrpPv?=
 =?us-ascii?Q?vKDxbNYsn3i2OAxDCUlc1kgJ2kEEF2cZ3K58GFopVJ6V8WS0vl0uoI6kIZNy?=
 =?us-ascii?Q?OxrEN+5qRcngopp6BEJgkffwqKHJQJlkwonK3bHo8WGxgD5q6S5Atgsct2zO?=
 =?us-ascii?Q?EtAut0lL2zi6KciQn0KFr13sqEnisvIKysOtOeRIa/x/BtGv/Vl+FpVm33vh?=
 =?us-ascii?Q?O+GdJeF2SvbP/mhM2+7JfR4Pj95UPkef9QS652oSeFXyThqcJ2tkXHz9KEY+?=
 =?us-ascii?Q?hmxXmM+kmoWBY+lEwszE44TNsqe6KVo3vW1N1Vu2Wek=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e258ebcf-6ca1-4f24-1a3e-08d89d1f2416
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2020 15:20:34.7173 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bfQToXYDrLM2ISk/FmocsY+UnRCj1FdJ+yr7VP1LNg+cZUcKeOW6YbA6qZxchg+hCTn9YRYE6eU5VJROaTNdkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2467
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
Content-Type: multipart/mixed; boundary="===============1653186294=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1653186294==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44886A9AF80CE5113738756AF7CB0MN2PR12MB4488namp_"

--_000_MN2PR12MB44886A9AF80CE5113738756AF7CB0MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Thursday, December 10, 2020 2:10 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>
Subject: [PATCH 2/2] drm/amd/pm: update the data strucutre for SMU metrics =
exchange

This is needed for Sienna Cichlid.

Change-Id: I57aa099cd1b2020cf0c8b05d8463239ec33790cf
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 75 ++++++++++---------
 1 file changed, 39 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index acbf6e97ffd0..0c4885273291 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -515,7 +515,7 @@ static int sienna_cichlid_tables_init(struct smu_contex=
t *smu)
                        PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
         SMU_TABLE_INIT(tables, SMU_TABLE_WATERMARKS, sizeof(Watermarks_t),
                        PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
-       SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SmuMetrics_t),
+       SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SmuMetricsExte=
rnal_t),
                        PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
         SMU_TABLE_INIT(tables, SMU_TABLE_I2C_COMMANDS, sizeof(SwI2cRequest=
_t),
                        PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
@@ -527,7 +527,7 @@ static int sienna_cichlid_tables_init(struct smu_contex=
t *smu)
                        sizeof(DpmActivityMonitorCoeffIntExternal_t), PAGE_=
SIZE,
                        AMDGPU_GEM_DOMAIN_VRAM);

-       smu_table->metrics_table =3D kzalloc(sizeof(SmuMetrics_t), GFP_KERN=
EL);
+       smu_table->metrics_table =3D kzalloc(sizeof(SmuMetricsExternal_t), =
GFP_KERNEL);
         if (!smu_table->metrics_table)
                 goto err0_out;
         smu_table->metrics_time =3D 0;
@@ -556,7 +556,8 @@ static int sienna_cichlid_get_smu_metrics_data(struct s=
mu_context *smu,
                                                uint32_t *value)
 {
         struct smu_table_context *smu_table=3D &smu->smu_table;
-       SmuMetrics_t *metrics =3D (SmuMetrics_t *)smu_table->metrics_table;
+       SmuMetrics_t *metrics =3D
+               &(((SmuMetricsExternal_t *)(smu_table->metrics_table))->Smu=
Metrics);
         int ret =3D 0;

         mutex_lock(&smu->metrics_lock);
@@ -3152,52 +3153,54 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struc=
t smu_context *smu,
         struct smu_table_context *smu_table =3D &smu->smu_table;
         struct gpu_metrics_v1_0 *gpu_metrics =3D
                 (struct gpu_metrics_v1_0 *)smu_table->gpu_metrics_table;
-       SmuMetrics_t metrics;
+       SmuMetricsExternal_t metrics_external;
+       SmuMetrics_t *metrics =3D
+               &(metrics_external.SmuMetrics);
         int ret =3D 0;

         ret =3D smu_cmn_get_metrics_table(smu,
-                                       &metrics,
+                                       &metrics_external,
                                         true);
         if (ret)
                 return ret;

         smu_v11_0_init_gpu_metrics_v1_0(gpu_metrics);

-       gpu_metrics->temperature_edge =3D metrics.TemperatureEdge;
-       gpu_metrics->temperature_hotspot =3D metrics.TemperatureHotspot;
-       gpu_metrics->temperature_mem =3D metrics.TemperatureMem;
-       gpu_metrics->temperature_vrgfx =3D metrics.TemperatureVrGfx;
-       gpu_metrics->temperature_vrsoc =3D metrics.TemperatureVrSoc;
-       gpu_metrics->temperature_vrmem =3D metrics.TemperatureVrMem0;
+       gpu_metrics->temperature_edge =3D metrics->TemperatureEdge;
+       gpu_metrics->temperature_hotspot =3D metrics->TemperatureHotspot;
+       gpu_metrics->temperature_mem =3D metrics->TemperatureMem;
+       gpu_metrics->temperature_vrgfx =3D metrics->TemperatureVrGfx;
+       gpu_metrics->temperature_vrsoc =3D metrics->TemperatureVrSoc;
+       gpu_metrics->temperature_vrmem =3D metrics->TemperatureVrMem0;

-       gpu_metrics->average_gfx_activity =3D metrics.AverageGfxActivity;
-       gpu_metrics->average_umc_activity =3D metrics.AverageUclkActivity;
-       gpu_metrics->average_mm_activity =3D metrics.VcnActivityPercentage;
+       gpu_metrics->average_gfx_activity =3D metrics->AverageGfxActivity;
+       gpu_metrics->average_umc_activity =3D metrics->AverageUclkActivity;
+       gpu_metrics->average_mm_activity =3D metrics->VcnActivityPercentage=
;

-       gpu_metrics->average_socket_power =3D metrics.AverageSocketPower;
-       gpu_metrics->energy_accumulator =3D metrics.EnergyAccumulator;
+       gpu_metrics->average_socket_power =3D metrics->AverageSocketPower;
+       gpu_metrics->energy_accumulator =3D metrics->EnergyAccumulator;

-       if (metrics.AverageGfxActivity <=3D SMU_11_0_7_GFX_BUSY_THRESHOLD)
-               gpu_metrics->average_gfxclk_frequency =3D metrics.AverageGf=
xclkFrequencyPostDs;
+       if (metrics->AverageGfxActivity <=3D SMU_11_0_7_GFX_BUSY_THRESHOLD)
+               gpu_metrics->average_gfxclk_frequency =3D metrics->AverageG=
fxclkFrequencyPostDs;
         else
-               gpu_metrics->average_gfxclk_frequency =3D metrics.AverageGf=
xclkFrequencyPreDs;
-       gpu_metrics->average_uclk_frequency =3D metrics.AverageUclkFrequenc=
yPostDs;
-       gpu_metrics->average_vclk0_frequency =3D metrics.AverageVclk0Freque=
ncy;
-       gpu_metrics->average_dclk0_frequency =3D metrics.AverageDclk0Freque=
ncy;
-       gpu_metrics->average_vclk1_frequency =3D metrics.AverageVclk1Freque=
ncy;
-       gpu_metrics->average_dclk1_frequency =3D metrics.AverageDclk1Freque=
ncy;
-
-       gpu_metrics->current_gfxclk =3D metrics.CurrClock[PPCLK_GFXCLK];
-       gpu_metrics->current_socclk =3D metrics.CurrClock[PPCLK_SOCCLK];
-       gpu_metrics->current_uclk =3D metrics.CurrClock[PPCLK_UCLK];
-       gpu_metrics->current_vclk0 =3D metrics.CurrClock[PPCLK_VCLK_0];
-       gpu_metrics->current_dclk0 =3D metrics.CurrClock[PPCLK_DCLK_0];
-       gpu_metrics->current_vclk1 =3D metrics.CurrClock[PPCLK_VCLK_1];
-       gpu_metrics->current_dclk1 =3D metrics.CurrClock[PPCLK_DCLK_1];
-
-       gpu_metrics->throttle_status =3D metrics.ThrottlerStatus;
-
-       gpu_metrics->current_fan_speed =3D metrics.CurrFanSpeed;
+               gpu_metrics->average_gfxclk_frequency =3D metrics->AverageG=
fxclkFrequencyPreDs;
+       gpu_metrics->average_uclk_frequency =3D metrics->AverageUclkFrequen=
cyPostDs;
+       gpu_metrics->average_vclk0_frequency =3D metrics->AverageVclk0Frequ=
ency;
+       gpu_metrics->average_dclk0_frequency =3D metrics->AverageDclk0Frequ=
ency;
+       gpu_metrics->average_vclk1_frequency =3D metrics->AverageVclk1Frequ=
ency;
+       gpu_metrics->average_dclk1_frequency =3D metrics->AverageDclk1Frequ=
ency;
+
+       gpu_metrics->current_gfxclk =3D metrics->CurrClock[PPCLK_GFXCLK];
+       gpu_metrics->current_socclk =3D metrics->CurrClock[PPCLK_SOCCLK];
+       gpu_metrics->current_uclk =3D metrics->CurrClock[PPCLK_UCLK];
+       gpu_metrics->current_vclk0 =3D metrics->CurrClock[PPCLK_VCLK_0];
+       gpu_metrics->current_dclk0 =3D metrics->CurrClock[PPCLK_DCLK_0];
+       gpu_metrics->current_vclk1 =3D metrics->CurrClock[PPCLK_VCLK_1];
+       gpu_metrics->current_dclk1 =3D metrics->CurrClock[PPCLK_DCLK_1];
+
+       gpu_metrics->throttle_status =3D metrics->ThrottlerStatus;
+
+       gpu_metrics->current_fan_speed =3D metrics->CurrFanSpeed;

         gpu_metrics->pcie_link_width =3D
                         smu_v11_0_get_current_pcie_link_width(smu);
--
2.29.0


--_000_MN2PR12MB44886A9AF80CE5113738756AF7CB0MN2PR12MB4488namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan@amd.com&gt;<br>
<b>Sent:</b> Thursday, December 10, 2020 2:10 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Quan, Evan=
 &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amd/pm: update the data strucutre for SMU m=
etrics exchange</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This is needed for Sienna Cichlid.<br>
<br>
Change-Id: I57aa099cd1b2020cf0c8b05d8463239ec33790cf<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
---<br>
&nbsp;.../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c&nbsp;&nbsp; | 75 ++++++++=
++---------<br>
&nbsp;1 file changed, 39 insertions(+), 36 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
index acbf6e97ffd0..0c4885273291 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
@@ -515,7 +515,7 @@ static int sienna_cichlid_tables_init(struct smu_contex=
t *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PAGE_SIZE, =
AMDGPU_GEM_DOMAIN_VRAM);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_TABLE_INIT(tables, SMU=
_TABLE_WATERMARKS, sizeof(Watermarks_t),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PAGE_SIZE, =
AMDGPU_GEM_DOMAIN_VRAM);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_TABLE_INIT(tables, SMU_TABLE_SMU_=
METRICS, sizeof(SmuMetrics_t),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_TABLE_INIT(tables, SMU_TABLE_SMU_=
METRICS, sizeof(SmuMetricsExternal_t),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PAGE_SIZE, =
AMDGPU_GEM_DOMAIN_VRAM);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_TABLE_INIT(tables, SMU=
_TABLE_I2C_COMMANDS, sizeof(SwI2cRequest_t),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PAGE_SIZE, =
AMDGPU_GEM_DOMAIN_VRAM);<br>
@@ -527,7 +527,7 @@ static int sienna_cichlid_tables_init(struct smu_contex=
t *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(DpmA=
ctivityMonitorCoeffIntExternal_t), PAGE_SIZE,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_=
DOMAIN_VRAM);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;metrics_table =3D kzall=
oc(sizeof(SmuMetrics_t), GFP_KERNEL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;metrics_table =3D kzall=
oc(sizeof(SmuMetricsExternal_t), GFP_KERNEL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu_table-&gt;metrics=
_table)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto err0_out;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;metrics_time=
 =3D 0;<br>
@@ -556,7 +556,8 @@ static int sienna_cichlid_get_smu_metrics_data(struct s=
mu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *value)<=
br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *=
smu_table=3D &amp;smu-&gt;smu_table;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SmuMetrics_t *metrics =3D (SmuMetrics=
_t *)smu_table-&gt;metrics_table;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SmuMetrics_t *metrics =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; &amp;(((SmuMetricsExternal_t *)(smu_table-&gt;metrics_table))-&g=
t;SmuMetrics);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;me=
trics_lock);<br>
@@ -3152,52 +3153,54 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struc=
t smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *=
smu_table =3D &amp;smu-&gt;smu_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct gpu_metrics_v1_0 *g=
pu_metrics =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; (struct gpu_metrics_v1_0 *)smu_table-&gt;gpu_metrics_=
table;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SmuMetrics_t metrics;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SmuMetricsExternal_t metrics_external=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SmuMetrics_t *metrics =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; &amp;(metrics_external.SmuMetrics);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_get_metric=
s_table(smu,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &amp;metrics,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &amp;metrics_external,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; true);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_v11_0_init_gpu_metrics=
_v1_0(gpu_metrics);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;temperature_edge =3D =
metrics.TemperatureEdge;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;temperature_hotspot =
=3D metrics.TemperatureHotspot;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;temperature_mem =3D m=
etrics.TemperatureMem;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;temperature_vrgfx =3D=
 metrics.TemperatureVrGfx;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;temperature_vrsoc =3D=
 metrics.TemperatureVrSoc;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;temperature_vrmem =3D=
 metrics.TemperatureVrMem0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;temperature_edge =3D =
metrics-&gt;TemperatureEdge;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;temperature_hotspot =
=3D metrics-&gt;TemperatureHotspot;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;temperature_mem =3D m=
etrics-&gt;TemperatureMem;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;temperature_vrgfx =3D=
 metrics-&gt;TemperatureVrGfx;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;temperature_vrsoc =3D=
 metrics-&gt;TemperatureVrSoc;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;temperature_vrmem =3D=
 metrics-&gt;TemperatureVrMem0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;average_gfx_activity =
=3D metrics.AverageGfxActivity;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;average_umc_activity =
=3D metrics.AverageUclkActivity;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;average_mm_activity =
=3D metrics.VcnActivityPercentage;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;average_gfx_activity =
=3D metrics-&gt;AverageGfxActivity;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;average_umc_activity =
=3D metrics-&gt;AverageUclkActivity;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;average_mm_activity =
=3D metrics-&gt;VcnActivityPercentage;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;average_socket_power =
=3D metrics.AverageSocketPower;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;energy_accumulator =
=3D metrics.EnergyAccumulator;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;average_socket_power =
=3D metrics-&gt;AverageSocketPower;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;energy_accumulator =
=3D metrics-&gt;EnergyAccumulator;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (metrics.AverageGfxActivity &lt;=
=3D SMU_11_0_7_GFX_BUSY_THRESHOLD)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; gpu_metrics-&gt;average_gfxclk_frequency =3D metrics.AverageGfxc=
lkFrequencyPostDs;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (metrics-&gt;AverageGfxActivity &l=
t;=3D SMU_11_0_7_GFX_BUSY_THRESHOLD)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; gpu_metrics-&gt;average_gfxclk_frequency =3D metrics-&gt;Average=
GfxclkFrequencyPostDs;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; gpu_metrics-&gt;average_gfxclk_frequency =3D metrics.AverageGfxc=
lkFrequencyPreDs;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;average_uclk_frequenc=
y =3D metrics.AverageUclkFrequencyPostDs;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;average_vclk0_frequen=
cy =3D metrics.AverageVclk0Frequency;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;average_dclk0_frequen=
cy =3D metrics.AverageDclk0Frequency;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;average_vclk1_frequen=
cy =3D metrics.AverageVclk1Frequency;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;average_dclk1_frequen=
cy =3D metrics.AverageDclk1Frequency;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;current_gfxclk =3D me=
trics.CurrClock[PPCLK_GFXCLK];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;current_socclk =3D me=
trics.CurrClock[PPCLK_SOCCLK];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;current_uclk =3D metr=
ics.CurrClock[PPCLK_UCLK];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;current_vclk0 =3D met=
rics.CurrClock[PPCLK_VCLK_0];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;current_dclk0 =3D met=
rics.CurrClock[PPCLK_DCLK_0];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;current_vclk1 =3D met=
rics.CurrClock[PPCLK_VCLK_1];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;current_dclk1 =3D met=
rics.CurrClock[PPCLK_DCLK_1];<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;throttle_status =3D m=
etrics.ThrottlerStatus;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;current_fan_speed =3D=
 metrics.CurrFanSpeed;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; gpu_metrics-&gt;average_gfxclk_frequency =3D metrics-&gt;Average=
GfxclkFrequencyPreDs;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;average_uclk_frequenc=
y =3D metrics-&gt;AverageUclkFrequencyPostDs;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;average_vclk0_frequen=
cy =3D metrics-&gt;AverageVclk0Frequency;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;average_dclk0_frequen=
cy =3D metrics-&gt;AverageDclk0Frequency;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;average_vclk1_frequen=
cy =3D metrics-&gt;AverageVclk1Frequency;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;average_dclk1_frequen=
cy =3D metrics-&gt;AverageDclk1Frequency;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;current_gfxclk =3D me=
trics-&gt;CurrClock[PPCLK_GFXCLK];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;current_socclk =3D me=
trics-&gt;CurrClock[PPCLK_SOCCLK];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;current_uclk =3D metr=
ics-&gt;CurrClock[PPCLK_UCLK];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;current_vclk0 =3D met=
rics-&gt;CurrClock[PPCLK_VCLK_0];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;current_dclk0 =3D met=
rics-&gt;CurrClock[PPCLK_DCLK_0];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;current_vclk1 =3D met=
rics-&gt;CurrClock[PPCLK_VCLK_1];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;current_dclk1 =3D met=
rics-&gt;CurrClock[PPCLK_DCLK_1];<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;throttle_status =3D m=
etrics-&gt;ThrottlerStatus;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;current_fan_speed =3D=
 metrics-&gt;CurrFanSpeed;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;pcie_link_=
width =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_v=
11_0_get_current_pcie_link_width(smu);<br>
-- <br>
2.29.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB44886A9AF80CE5113738756AF7CB0MN2PR12MB4488namp_--

--===============1653186294==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1653186294==--

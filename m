Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B1DDC77B7A
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Jun 2023 05:56:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A4B510E035;
	Fri,  2 Jun 2023 05:56:09 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::606])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C34210E035
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Jun 2023 05:56:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KueAIMneBBCw1uZhmmheCHdOJmg4v90hB9dvlhaSOXsgB++JnBMzqj7iUlc+ggU8P36JIfIpZu4XsBcSJkoLksl0XQH40nfm2A0kqEXvI9nduNZnDKiLupjp+jE4tKAddeGDL+kNEB9KcZF7J2cdPgOdNbECSnp/dXTR29xdszQm0JgMPfLDih4f0dlDS32PdkMq8YNUviUj2ZLURHygMaIuJCFZRtVbtOMqY0o4KJVEo932DU2jIOTcLtJybtbs/ok/vnz4KiiNU7K8+wJJXO6+W+JKCdCF94hmF42ZM6qrLuD6z3kVKZnw6fbIfmViM/RVOF9VwWH7jb+eegbFBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wq0lZ6eWnkegwzK5bLuF22pKQg2QFYOB8ZdkBXx8lVw=;
 b=MhqtNTzqWEcvwo1TlInrPlRiFnIwVGmNzJpblHDiMljMoih21Awscq1o+v9dGm15tS1urpTZBjX6o7OU1RAae4E5HWwWlkI4ZaQzhfVkOzLKc+iN4vzz3GzC/2eyxCE0G+OjT5XCitPV0X7SAoyQ7WdlVtfaHck1EPlwDSFOGkIH8IcCmLpxawudxdtqzWn1DOULEPwA26qoP1lFpMZzsf3g6qCWUVujAqtcOkhqfSwg3LFBzEHmXMklzGoxp1Xk/ZtFXFcp/HVrmOD4N4MG5pNpQhob4gRe6j9iFi0OqKd0AlrgoZRzBL+ji4I/VC0DXH2ua3GlTVdI6OFUnmKGUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wq0lZ6eWnkegwzK5bLuF22pKQg2QFYOB8ZdkBXx8lVw=;
 b=hlEfJuFyjtwrn5CgT26Qoy5kxC6qzaEM9QNy2J8Wh2JI22vPeCaXmPteL4+clw4DbHkFt91pZ26bhJoq1ymqPwDhSPgf6VxK7bjTJGX3tO8gdcDhu/4qUevFQcCRTiDfEvcf7U3jW0Z62OyeL9kYkbOI9RnvO9pWsPxhIUEZHyI=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 MW6PR12MB8900.namprd12.prod.outlook.com (2603:10b6:303:244::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Fri, 2 Jun
 2023 05:56:04 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::43e0:b9fc:552d:5cd5]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::43e0:b9fc:552d:5cd5%4]) with mapi id 15.20.6455.020; Fri, 2 Jun 2023
 05:56:03 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Fill metrics data for SMUv13.0.6
Thread-Topic: [PATCH] drm/amd/pm: Fill metrics data for SMUv13.0.6
Thread-Index: AQHZlQbYUcOSGRD0I0GXg1Kt2Cm4nK93AtGQ
Date: Fri, 2 Jun 2023 05:56:03 +0000
Message-ID: <DM5PR12MB24696BDFC886C94CACF87FDCF14EA@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230602040025.655957-1-lijo.lazar@amd.com>
In-Reply-To: <20230602040025.655957-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=28b57c1f-1f85-473c-abbd-d78e1615e5aa;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-02T05:52:37Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|MW6PR12MB8900:EE_
x-ms-office365-filtering-correlation-id: b70115ab-c581-40fa-5197-08db632e0c91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AoOuRrmxPtN/Lp428gBh9l4W+k16jjZcjg3RIw1h40zNj0v5cHavCg7j9YfGVlfOoCkCLAeq0rnLgk6T2WxUa0Wifw9vAAvNwQeMRCFHpcKwtUfx8HCfCMcD7ly7ASeTSkBWIN5Z5cV6UyuyoFEaXgRA5RnY0Ez4SmdKdcGvimJJXxEG4pEKq0img1JnH9tco8WlCLob2QDkp4d6ZnmA1ZLGikGaw5/j+ZV6ZjIn9L6UOmas9e9fL/g965hq2AVkUW2g56nO4vn9Qb73G+iAgDLTbJl3pwvA1b2+tDlowZwUuRzj421uj1bV2Hy0B+RGkYmPE5NJBr6JZRQEzVW0bMsPt0DoV2iHT0Y9hsxbZ/nH+aCy4A74AecLey1NbTPU7zFvLz3anZJdQk99PgjLYzGgtZZIBYncjce6OXuK9qecGY/zn53tjt+TsRmLl7l1oFegc/3Z/oWyJOGXZ0lmGM06cupUP7K/Jj7edCifM9Ql6u3mlH3VBv5e+IV7KtKHPIzO2YbyDYUtbmNPTveBz7ZQKUrbMYoIxbN9Gwf+EL0e/3zHWT1h4npC8M1uSwnJZDDC/9qAMRhiGfBPG4Xp4N+QpVcf7LvFJCplQgzYph8PRaAnY4vjKTdTbVJ8wGSp
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199021)(186003)(6506007)(2906002)(26005)(8676002)(53546011)(9686003)(5660300002)(52536014)(8936002)(122000001)(38100700002)(83380400001)(54906003)(110136005)(7696005)(38070700005)(86362001)(41300700001)(66556008)(4326008)(71200400001)(66476007)(76116006)(316002)(66446008)(66946007)(64756008)(33656002)(55016003)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?epdh9CAe/enOMRm/S7t8PEBp8n5m+NJ1A7bvDuDT19Cf0k/ozByMVNXeUJIp?=
 =?us-ascii?Q?w2cV0Cx5teYuzOUk4ikbv/r16ZRCr7i6jnBJ9ZCzN9po3MMQrpaUWtOXZSbO?=
 =?us-ascii?Q?81Uo8yEI6120qVDYMEQGN9eMvhCF7sodtqoYdxJ9joU0e4EHFJpE4BHv2N2A?=
 =?us-ascii?Q?Mwsua3H/yg6KW0Jb7Y0xAEk8ERG2phy8CvOcPP7hnylmsT0KIEJyvMLylHOm?=
 =?us-ascii?Q?rKFhOLy35PTkNSMLjoCMa+Dc/LS/h81XRNbw6NFOgALqTSFNIN0n1XB1KAQw?=
 =?us-ascii?Q?joq8O0gw2osUbExmUPbPXTzNM8zMW8+LuAfYHCjDF6EBsP1pEmkmtEFksAYO?=
 =?us-ascii?Q?Ckd6lhcmpjiua/lb0qGk7vPwKQKTcOjf6cMHZzvi8d332+t0YdtXDwUw7w2c?=
 =?us-ascii?Q?8GW8UzzERnUPVCveYrn0PIeVdEJjEYvx/nKql3iENCt0w2aFO6P2xJiknsuW?=
 =?us-ascii?Q?icSpN6F193PsQoA1BU+C280zMXD9mDFuZc5Az7KdWoBHRi8KhEH9CrzENeGw?=
 =?us-ascii?Q?2Z/X2/5NK422+YteRNOQmZMzywdaU2p/uB1Ef8yyPATv+uJLaKkpIn2lJkcR?=
 =?us-ascii?Q?AaoR4xaD9Q5xY5Rkv4RtA6sg0sOeN9tWjmD57SasypcMUP28EFP2bIUKb9jl?=
 =?us-ascii?Q?JUDajpS/+lnu/p+TDeaR/0Kk/0N+KfpoIKPKWFReuaYS7hDmG47d0OmNuxWI?=
 =?us-ascii?Q?+j1zw26hwhIm18gY4v3bCqDK0EQO4+m9KNhReWaCQPo1G2e/XQk3WLo2o5CY?=
 =?us-ascii?Q?uQrmjINO7WRGPl5yN6864wbmWU0hKxM+cC5ZYDNNGtaTsvYMRlzF7dwzc0+O?=
 =?us-ascii?Q?2YAcsMw1v8KpITO7geO0m41sM6p75QIs2dlV4pV1/WoP6E1Vz1eBNowRqvA3?=
 =?us-ascii?Q?eGJ/kLaLeMK4BBMqOkhVYvSzMFfcnpNjsj1+GPg1MHn60enNxd1+EZc/vasz?=
 =?us-ascii?Q?xnf+h+6P5bsjNOK5F0bt0fQrwDc+R52y+TkxWA9hBxA/DIcrrm9P8AnM4QaY?=
 =?us-ascii?Q?aq7hDHN8FtRwS7IkqygWdCyP8HCfxC8nk+YdAiLfinQmvMKQZo4+kmHYbnuC?=
 =?us-ascii?Q?crBfdXwwvb0PimtnDc1WFUYQJif4l4y1VefVJBCqfWe4LbRS6y1acQLSO464?=
 =?us-ascii?Q?ELsS7pX5MZ6QP7V27Myn2WJx+djPJuG4Owt6IDPHKBg3WqtWSkg5IB4/CJ0A?=
 =?us-ascii?Q?vCloENEnCbCMOlXZwL/I+5J74BeDVbqUZ/QExXker3xKBNTkvoVXKwSpvj+/?=
 =?us-ascii?Q?0bCrqSB6t4jlf8bhhDdUfyHhBYuxHcnWb1QrWxAapabUz+GFRGufWVREIm83?=
 =?us-ascii?Q?Y5ZTokHXw/HKRfzoqwoO7AF0hBOuUZcEvl7GqFtBYWudYV03FLf6QAyRrY/d?=
 =?us-ascii?Q?hKpbBBDktcJcOPDE38Gty1oh9ZSsuZxgz8Ou5Woqd5wlvDxtiuB+/bSHUg+O?=
 =?us-ascii?Q?t26zr466fvDPGZTPGf/Wdl9KTYc8pUPXCbm4xStRt9f9H/pa0fMnRI9K0BTl?=
 =?us-ascii?Q?S/dcBC5VOD4cgVQbzph4k2m7ku3Rvlv2UozIXhNQ7gaLNuLIBLZrZRgBesYr?=
 =?us-ascii?Q?b4o+yi5LsKO4A/3d5sA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b70115ab-c581-40fa-5197-08db632e0c91
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2023 05:56:03.2940 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w/d9jK+4qx2g6AI2wU9PCBY3yr0oKKsPEcdzbGbDqL5vTFwFlTpCejaKP8KlsZSzuk7/P2JJS7DPo2zIPhvvOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8900
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo
> Lazar
> Sent: Friday, June 2, 2023 12:00 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amd/pm: Fill metrics data for SMUv13.0.6
>
> Populate metrics data table for SMU v13.0.6. Add PCIe link speed/width
> information also.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 108 +++++++++++---
> ----
>  1 file changed, 67 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 75255e0baf91..4ff5a66d446a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -80,7 +80,10 @@
>  /* possible frequency drift (1Mhz) */
>  #define EPSILON 1
>
> -#define smnPCIE_ESM_CTRL 0x111003D0
> +#define smnPCIE_ESM_CTRL 0x193D0
> +#define smnPCIE_LC_LINK_WIDTH_CNTL 0x1ab40288 #define
> +PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD_MASK 0x00000070L
> #define
> +PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD__SHIFT 0x4

I see in smu_v13_0.c and smu_v11_0.c, the same macro definitions are presen=
t. So is it better to put it into a common place which is scalable for late=
r asics as well?

Regards,
Guchun

>  static const struct cmn2asic_msg_mapping
> smu_v13_0_6_message_map[SMU_MSG_MAX_COUNT] =3D {
>       MSG_MAP(TestMessage,
> PPSMC_MSG_TestMessage,                        0),
> @@ -197,6 +200,7 @@ struct PPTable_t {
>  };
>
>  #define SMUQ10_TO_UINT(x) ((x) >> 10)
> +#define SMUQ16_TO_UINT(x) ((x) >> 16)
>
>  struct smu_v13_0_6_dpm_map {
>       enum smu_clk_type clk_type;
> @@ -1935,6 +1939,16 @@ static void
> smu_v13_0_6_log_thermal_throttling_event(struct smu_context *smu)
>
> smu_v13_0_6_throttler_map));
>  }
>
> +static int
> +smu_v13_0_6_get_current_pcie_link_width_level(struct smu_context *smu)
> +{
> +     struct amdgpu_device *adev =3D smu->adev;
> +
> +     return (RREG32_PCIE(smnPCIE_LC_LINK_WIDTH_CNTL) &
> +             PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD_MASK) >>
> +            PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD__SHIFT;
> +}
> +
>  static int smu_v13_0_6_get_current_pcie_link_speed(struct smu_context
> *smu)  {
>       struct amdgpu_device *adev =3D smu->adev; @@ -1953,8 +1967,12
> @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu,
> void **table
>       struct smu_table_context *smu_table =3D &smu->smu_table;
>       struct gpu_metrics_v1_3 *gpu_metrics =3D
>               (struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
> +     struct amdgpu_device *adev =3D smu->adev;
> +     int ret =3D 0, inst0, xcc0;
>       MetricsTable_t *metrics;
> -     int i, ret =3D 0;
> +
> +     inst0 =3D adev->sdma.instance[0].aid_id;
> +     xcc0 =3D GET_INST(GC, 0);
>
>       metrics =3D kzalloc(sizeof(MetricsTable_t), GFP_KERNEL);
>       ret =3D smu_v13_0_6_get_metrics_table(smu, metrics, true); @@ -
> 1963,51 +1981,59 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct
> smu_context *smu, void **table
>
>       smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
>
> -     /* TODO: Decide on how to fill in zero value fields */
> -     gpu_metrics->temperature_edge =3D 0;
> -     gpu_metrics->temperature_hotspot =3D 0;
> -     gpu_metrics->temperature_mem =3D 0;
> -     gpu_metrics->temperature_vrgfx =3D 0;
> -     gpu_metrics->temperature_vrsoc =3D 0;
> -     gpu_metrics->temperature_vrmem =3D 0;
> -
> -     gpu_metrics->average_gfx_activity =3D 0;
> -     gpu_metrics->average_umc_activity =3D 0;
> -     gpu_metrics->average_mm_activity =3D 0;
> -
> -     gpu_metrics->average_socket_power =3D 0;
> -     gpu_metrics->energy_accumulator =3D 0;
> -
> -     gpu_metrics->average_gfxclk_frequency =3D 0;
> -     gpu_metrics->average_socclk_frequency =3D 0;
> -     gpu_metrics->average_uclk_frequency =3D 0;
> -     gpu_metrics->average_vclk0_frequency =3D 0;
> -     gpu_metrics->average_dclk0_frequency =3D 0;
> -
> -     gpu_metrics->current_gfxclk =3D 0;
> -     gpu_metrics->current_socclk =3D 0;
> -     gpu_metrics->current_uclk =3D 0;
> -     gpu_metrics->current_vclk0 =3D 0;
> -     gpu_metrics->current_dclk0 =3D 0;
> -
> +     gpu_metrics->temperature_hotspot =3D
> +             SMUQ10_TO_UINT(metrics->MaxSocketTemperature);
> +     /* Individual HBM stack temperature is not reported */
> +     gpu_metrics->temperature_mem =3D
> +             SMUQ10_TO_UINT(metrics->MaxHbmTemperature);
> +     /* Reports max temperature of all voltage rails */
> +     gpu_metrics->temperature_vrsoc =3D
> +             SMUQ10_TO_UINT(metrics->MaxVrTemperature);
> +
> +     gpu_metrics->average_gfx_activity =3D
> +             SMUQ10_TO_UINT(metrics->SocketGfxBusy);
> +     gpu_metrics->average_umc_activity =3D
> +             SMUQ10_TO_UINT(metrics->DramBandwidthUtilization);
> +
> +     gpu_metrics->average_socket_power =3D
> +             SMUQ10_TO_UINT(metrics->SocketPower);
> +     gpu_metrics->energy_accumulator =3D
> +             SMUQ16_TO_UINT(metrics->SocketEnergyAcc);
> +
> +     gpu_metrics->current_gfxclk =3D
> +             SMUQ10_TO_UINT(metrics->GfxclkFrequency[xcc0]);
> +     gpu_metrics->current_socclk =3D
> +             SMUQ10_TO_UINT(metrics->SocclkFrequency[inst0]);
> +     gpu_metrics->current_uclk =3D SMUQ10_TO_UINT(metrics-
> >UclkFrequency);
> +     gpu_metrics->current_vclk0 =3D
> +             SMUQ10_TO_UINT(metrics->VclkFrequency[inst0]);
> +     gpu_metrics->current_dclk0 =3D
> +             SMUQ10_TO_UINT(metrics->DclkFrequency[inst0]);
> +
> +     gpu_metrics->average_gfxclk_frequency =3D gpu_metrics-
> >current_gfxclk;
> +     gpu_metrics->average_socclk_frequency =3D gpu_metrics-
> >current_socclk;
> +     gpu_metrics->average_uclk_frequency =3D gpu_metrics->current_uclk;
> +     gpu_metrics->average_vclk0_frequency =3D gpu_metrics-
> >current_vclk0;
> +     gpu_metrics->average_dclk0_frequency =3D gpu_metrics-
> >current_dclk0;
> +
> +     /* Throttle status is not reported through metrics now */
>       gpu_metrics->throttle_status =3D 0;
> -     gpu_metrics->indep_throttle_status =3D
> smu_cmn_get_indep_throttler_status(
> -             gpu_metrics->throttle_status, smu_v13_0_6_throttler_map);
> -
> -     gpu_metrics->current_fan_speed =3D 0;
>
> -     gpu_metrics->pcie_link_width =3D 0;
> -     gpu_metrics->pcie_link_speed =3D
> smu_v13_0_6_get_current_pcie_link_speed(smu);
> +     if (!(adev->flags & AMD_IS_APU)) {
> +             gpu_metrics->pcie_link_width =3D
> +
>       smu_v13_0_6_get_current_pcie_link_width_level(smu);
> +             gpu_metrics->pcie_link_speed =3D
> +                     smu_v13_0_6_get_current_pcie_link_speed(smu);
> +     }
>
>       gpu_metrics->system_clock_counter =3D ktime_get_boottime_ns();
>
> -     gpu_metrics->gfx_activity_acc =3D 0;
> -     gpu_metrics->mem_activity_acc =3D 0;
> -
> -     for (i =3D 0; i < NUM_HBM_INSTANCES; i++)
> -             gpu_metrics->temperature_hbm[i] =3D 0;
> +     gpu_metrics->gfx_activity_acc =3D
> +             SMUQ10_TO_UINT(metrics->SocketGfxBusyAcc);
> +     gpu_metrics->mem_activity_acc =3D
> +             SMUQ10_TO_UINT(metrics->DramBandwidthUtilizationAcc);
>
> -     gpu_metrics->firmware_timestamp =3D 0;
> +     gpu_metrics->firmware_timestamp =3D metrics->Timestamp;
>
>       *table =3D (void *)gpu_metrics;
>       kfree(metrics);
> --
> 2.25.1


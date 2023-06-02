Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F28CC77B7A
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Jun 2023 09:53:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0466B10E03C;
	Fri,  2 Jun 2023 09:53:19 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDC7210E00B
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Jun 2023 09:53:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZzsveKxu0GXbeX/ns2P2THG685A9x0PHZjmmIe6PA43duOnSnu2jCPNjYggDfuwBnW0oc4jQPJF1d/HNNQ2Sr2QRtGVi6xaao3F4JY9lmDVpWJQx39bF70J1SrZZVwIIcBsAs2Bt1JnHbdB1cAoUsWC93jOw6b6iIrIKJ3t/579Hqxj8/qbv8zQsBZKLcoIcphCR6mNISaur6fC9mAuca+FNhbQ6+L/91nfmQQiKEmVoTINCcBrD5fc+FBziz5Jk4hE70a251qE/8Wf8/K+79PA2yWxEl+UZ/uJhj5p1EQ3rG8ATO59kEKWZAaWsMxINdNl1sZOHEdDnXFprf7puGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3UQPTUd1ysaXyO12E1HHUFDHWGkyStAsWWpbGtkUHb4=;
 b=JGZaml/b9vPzcItxHIBQEd+OjP8uvO93tLp3O+8AO1YoDaHjCGDNSDpXJvG/UwSLrdt4CZZGCN0GHGCWzKZHw0Nv3TrZMWVIxmlUZwqcjHapcfhyMUt+6fzbMe43AMbM87sGZIO27sjQW3EslQ4I45afvJniqtidOgrZlkNnDzAMJ4PmU6/WXPi5fVjyWVVDgZj+8QMu3k/ygfjzXaEkpyQGATd0PEjZWtmd0/koF85dKQKdbhtCf64ctzIerSNFw0/GboAXsXkYuQ3TKbjV19LRfHFknoZYoVfY3rBjkUCt0A+bbjr7gV50NXRNljv07Son5CigwKU+ZISgzaCcDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3UQPTUd1ysaXyO12E1HHUFDHWGkyStAsWWpbGtkUHb4=;
 b=KsUVjr6Gs0ybDGCtNBwjCxRf8CR5oOROuWIpxK0555AWhh+Pff0ZmalLx3vl2iF7BUDJ6BjBHSfvFdbNJNdxTJq3wNi+zLyZxhrkeVbqMb1otUzqpY7fF0WKWZ1gDrdv8LOyPr0cGxG1h3mQWW+sibMzJjkebPI4i/uStyanEec=
Received: from PH0PR12MB5404.namprd12.prod.outlook.com (2603:10b6:510:d7::14)
 by MW4PR12MB7013.namprd12.prod.outlook.com (2603:10b6:303:218::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Fri, 2 Jun
 2023 09:53:14 +0000
Received: from PH0PR12MB5404.namprd12.prod.outlook.com
 ([fe80::ed91:e0f1:49d2:1af1]) by PH0PR12MB5404.namprd12.prod.outlook.com
 ([fe80::ed91:e0f1:49d2:1af1%4]) with mapi id 15.20.6455.026; Fri, 2 Jun 2023
 09:53:14 +0000
From: "Ma, Le" <Le.Ma@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Fill metrics data for SMUv13.0.6
Thread-Topic: [PATCH] drm/amd/pm: Fill metrics data for SMUv13.0.6
Thread-Index: AQHZlQbYG19/CYzk9kuuv7qTZnTGcK93QfAQ
Date: Fri, 2 Jun 2023 09:53:14 +0000
Message-ID: <PH0PR12MB5404A4272B3486E2F8CF54EAF64EA@PH0PR12MB5404.namprd12.prod.outlook.com>
References: <20230602040025.655957-1-lijo.lazar@amd.com>
In-Reply-To: <20230602040025.655957-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=85b8eadc-9842-4b92-b04d-678330e3ee50;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-02T09:38:32Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5404:EE_|MW4PR12MB7013:EE_
x-ms-office365-filtering-correlation-id: 8a5e3bf3-0f7a-47c9-a3cc-08db634f2ee6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bHuziluHS69Y3w9HEs0k94iXjqkWP/fvOR4/wFx5qFOIPKGG+A/KRFQ/Y9LjeBJ4UrBeKa8EZKlXCEL7KulcYyTYWHkiPXWOZnLEI9O+4lr0wupOmQnuSCcgjfUW6WSy+NFyEf/VENYrQF+waManbMnSy8XmoSGFUl13h/u0NRIvvuDRGWRg3fbYQYacWkhPIU2wsV5XCwKGSLfGC8Q+Q2PVgxKXzlf2M58KN91sT53eyrW0h+bKWQOI9yN1+ujgVNDrW10D3ChF3v8c0qvKeUBLC5fo6kNszfMAUXJPaiQwdYElcVHFiRVmawNUtJo1sMa7hKtDiyOqPU8W71lrCOVywM0f/ufeLOTN+BzKbBFGqNPbeLENZ8RXt4no5pBiH6CSqAuncUofFVGtU6JF6bOAHuGB6yd+iGtiVCzO93qZbHzNltgmDsR/5y7j4JqibFGAFmebCBO7577LvdFBKrl3anDFB6hAa9jkqB28YhMMKbqSfeXnfNS1oIYGLY2cOZynI8c4RdDKvcBsYwoCEBP3FRApGKlN8XwmDlr8XpSmrAbP+p+nWONIE8Cn+XW3CyZv3LX3aiUzS4nmT+sNdPqjssZNyieiKUB1P8S3FhUg3mFzk26nymHFQ///FgSA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5404.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(451199021)(86362001)(83380400001)(71200400001)(33656002)(66556008)(316002)(66476007)(76116006)(5660300002)(66446008)(66946007)(52536014)(4326008)(8936002)(41300700001)(122000001)(64756008)(8676002)(7696005)(38100700002)(55016003)(110136005)(54906003)(2906002)(53546011)(26005)(6506007)(38070700005)(9686003)(186003)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rihbmDCT1ki6fYARMA2K9c/jDkphtBAh7tRXTYvi3aij4eEhI0ZsmRrNaHCQ?=
 =?us-ascii?Q?DzwIaISGFM4K6hi0DwWt7lHkkopeeZmLXdfnTNvHHWsPohwfjDB0W9fOpe37?=
 =?us-ascii?Q?4Oji64mV89GmSLtNFrrrHTST/jjGUK/h+IiKQFbXd6WjLqOjlRo660lZouw6?=
 =?us-ascii?Q?xj3ERGkQIqOjtfgc9OK9ypyVGmbXnoaq4Bl7C4KADF2uqLsrVnWzlr6QCyKL?=
 =?us-ascii?Q?CdvWbVJwmr7JnJou6v62OsUIF9ngmXKlqutOpU+UM9dSkuz25RuiZ8AdPHOk?=
 =?us-ascii?Q?yllPEJW7ZO3oOphJoOvqjwLlPZr4tJyDODNXTmxSTpjxyXsKt5EwT/9GlU8R?=
 =?us-ascii?Q?09MEZDbaU2xFVVbv+A/leZnaGx7Zk4cqmAvlqqx6nNMb2dcPgvaOsm9FZCTW?=
 =?us-ascii?Q?6CwM1WVyrR/a7dMWT/U/fPIr5z73ng3HnMSZKw6kzoDBu7BsYXt0oLa/WLMB?=
 =?us-ascii?Q?SwozkKhkoOqJedbnWgU0JkhK5edgUrJDvh3TAE4PgyhH2UVSBZ2K4K+LjxtG?=
 =?us-ascii?Q?+2ooMefEbpKdfnAht2MAADbZ2OXkUW611jdsqXMR3y++MnRIeSyZLd9ibiKI?=
 =?us-ascii?Q?lrttnHeWi7zBkgCLwGW9aAHDKRAR3WtAoprZs++1ToNyxuPy49iXCONZe74h?=
 =?us-ascii?Q?uEP+ura6TiUl793h14pKAxhB9ITJ2im7ctBC6WM7hSF1f+ijo72g0WBwcnjs?=
 =?us-ascii?Q?s0NOoWcwUTcK1bLr8JApEOzmBf4uNPpGf5fYsX1GJK/lP26lmNpQ2DiKqMe/?=
 =?us-ascii?Q?fWZzx57GcX/+fIujx6ImzUHSiurLJUWgEbi2pejjZ777gc0tn+H/JynM1eAm?=
 =?us-ascii?Q?jTWUrvHEGWmzpN65zKCfPBaLjn9h8MicxUMFwlGdW6WIx8HxbA76Dx+FhgHg?=
 =?us-ascii?Q?gCrTWiCIGwKpGfniFdxM7pMvx6dVoX105Jg45oYD9M3yytWjTq415fB6MHaF?=
 =?us-ascii?Q?4KZ7rmPskS9zn76mWKQKp2QclJA20x0PT054erTgmCkJ6lJ3SGIqSWwp6Evc?=
 =?us-ascii?Q?ZPB8/+jDN/gjKog0+aLmUxQgM/Q0TPZYD9/IjX0f0veoSp2JJssoQ1cMiuAG?=
 =?us-ascii?Q?R1ApQygINGHA7YyOvg1XJKKwZzIDD9OdzmGIlLDfNAhEO3ZJhLnNLxPKdvqa?=
 =?us-ascii?Q?E1Er9w+/k0IbOexBnM1yE8qCS3nDOt3FciUFE744oyxJYcaIXAJ78hwDUjyv?=
 =?us-ascii?Q?8EMhbeOvv4mps0IDxKlts3tKYfzXAy28WOzeb65gq2196095/yjqiy53WHyJ?=
 =?us-ascii?Q?enrpwMrZ7QpbbMseBEt6Nb88Q4ZQ0arf82CSl6ghs4lm+gzaf/1Okrcsi7G8?=
 =?us-ascii?Q?7H2kaz/KMQKWuy+/DQE7pq1W0AlBcNN3JevbTZ/FYwPVBlCImXZ2Wo1ExXa8?=
 =?us-ascii?Q?fP3LLprcPLjIKnDoF4D2ZI3NxTuFfntW1IydVBhCPuUOo18EoUtmrOrEVBIz?=
 =?us-ascii?Q?iP28u+iFU8dZx1dgohfkF2UVuuCc/2NEhZ4z6OYIUC3AVrrPxf/ntTkvLHQH?=
 =?us-ascii?Q?GF1owjAKdUD3asK025lClA+ZoGfn5IYdbvmTWRCEkq5i+VHFa/0kkec44o9q?=
 =?us-ascii?Q?WGUMMvWT7IlUhmknwFo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5e3bf3-0f7a-47c9-a3cc-08db634f2ee6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2023 09:53:14.3041 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E1Mx13gcudlV6UGwoVPfp49YKZSA8F+tGjtiJAUj0ga5bZ9/nxCCE7ugXjK5jkBU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7013
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
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 108 +++++++++++-------
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
>
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

Here it can be wrapped like REG_GET_FIELD(RREG32_PCIE(smnPCIE_LC_LINK_WIDTH=
_CNTL), PCIE_LC_LINK_WIDTH_CNTL, LC_LINK_WIDTH_RD)

It's optional and patch is Reviewed-by: Le Ma <le.ma@amd.com> either way.

> +
>  static int smu_v13_0_6_get_current_pcie_link_speed(struct smu_context *s=
mu)
> {
>       struct amdgpu_device *adev =3D smu->adev; @@ -1953,8 +1967,12 @@
> static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void
> **table
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
> +     gpu_metrics->average_gfxclk_frequency =3D gpu_metrics->current_gfxc=
lk;
> +     gpu_metrics->average_socclk_frequency =3D gpu_metrics-
> >current_socclk;
> +     gpu_metrics->average_uclk_frequency =3D gpu_metrics->current_uclk;
> +     gpu_metrics->average_vclk0_frequency =3D gpu_metrics->current_vclk0=
;
> +     gpu_metrics->average_dclk0_frequency =3D gpu_metrics->current_dclk0=
;
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
> +                     smu_v13_0_6_get_current_pcie_link_width_level(smu);
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


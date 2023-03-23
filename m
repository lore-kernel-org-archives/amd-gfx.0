Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45320C6FD1C
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Mar 2023 07:22:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92B9D10E44D;
	Thu, 23 Mar 2023 07:22:44 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 449B910E44D
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 07:22:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jf2vL0GuC06IzCCPJp2Da7SwG3rGxE6m8roPxfhZwMiCVgFM9v0ODl0jMZ3tBcNie8If7GeLTM3G17BIUKORDGURQYINM1oNzgQ7+IYSkbBkleXp5591uW+5xqPRqOVYHhi8W8135/t2SnNJgC3LmABE3JF5cQTgwCCrL6F9p2bQqJrMvEzzo7mMyBSSpKy+yb63+acyGvmZvP0LvZbbPpJqc9lLTJ2bIoblPLVQJJmhgXy/V8Z3QlLN72Ms5SXs2rcqkavtzwCWKXwNcJWdiPXwEOP4/Z0TZvVqpPk8IhAT7mB/oM3rBV4BmXa/l2kMN02lYpCxvONHuUoG+pZkLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvAhZuDIAiP/D/IynexzpAHxDWjxbrKDALIGlhkczz0=;
 b=h/PytpNTgX0j+8U8E4B5HFFNmetFueWSAv2imwKwR7cDpQkq+Udc+Qpnx+gZ5EfmT2hJd5ziN0a2tdWgxDkY5ax0dKQoJlpQbp5sMUb6eFtu135J62PNvzwSpEBCFnbvSKXVW0xh0uk2dHfDeHOgY90sjYU2WP4wtw6/5/VPJyHPRI1b233U7wlnruY2ytIJwl1oCfKGvgW1NLnBG2ctLJvtfT3C6p9byyrHPXP/i8NnHwfXTz81cUnkRff7YrqUuuD7ijvOe3HcZUPBNmYwQA/KfY4r58D4MayO/W3Tma8kFIJ559XxwxbtrhF9EnDI0QQ3OGQmR699b4SP92txRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvAhZuDIAiP/D/IynexzpAHxDWjxbrKDALIGlhkczz0=;
 b=Gx6JBrDn7M7RNg6xmVJZn1SLv7u7vJhr3+yBC2SVLfq97WtKwBOMed1yYw9bRIInb3Mvdxdhq7aqwjUoQB1GAH/ZYAMkmwzFzaCzE/8FGnV+xYSXvock9tgCjp9Oxz2AzASTw/eobbqn9LtzRNR5PBWVK1mZYB7SkHkrCQXVCWM=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 CH3PR12MB7642.namprd12.prod.outlook.com (2603:10b6:610:14a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 07:22:37 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3334:46b8:da25:16ad]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3334:46b8:da25:16ad%7]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 07:22:36 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Yang, WenYou" <WenYou.Yang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>
Subject: RE: [Resend PATCH v1 3/3] drm/amd/pm: vangogh: support to send SMT
 enable message
Thread-Topic: [Resend PATCH v1 3/3] drm/amd/pm: vangogh: support to send SMT
 enable message
Thread-Index: AQHZXJ8Aj7QWUgHtnE21CAAXhECkKa8H9jqA
Date: Thu, 23 Mar 2023 07:22:36 +0000
Message-ID: <DM6PR12MB2619F012875625DB0999246FE4879@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20230322091607.1609145-1-WenYou.Yang@amd.com>
 <20230322091607.1609145-4-WenYou.Yang@amd.com>
In-Reply-To: <20230322091607.1609145-4-WenYou.Yang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-23T07:22:34Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ffae08bb-d84e-46c9-8872-ac7c60310c52;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|CH3PR12MB7642:EE_
x-ms-office365-filtering-correlation-id: 6c01596c-45d2-4653-1870-08db2b6f60c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l5iwqINygmJokL/NtQ3eaZ1xVKTZDYTK9HYQ1vVOZ96ercnb7YAlrsx87fpuPB5kR/sGhghoQyNohDTJ+K3O4njP90O2B5kvXfsm4jWIRciiX4GAmgzlfgHx1f7bBUcJURyzNESCMshcYEYj4X6EfR3XjLwVvRZ4cV5f7bY8D62GCeRMz0cB451gLXI2nqaaiaszAtmJ+aGY9++eUBAGYd4PD6uM7yhOIhLFrb2Ej0JO2sAw99QRipToFqwItinfY75a7JG94129pR42zxch9wUkg/bEbR0iRPv0GLb0/s5ac+i+YwJIcTpth9qzYSgk0LlB2gwfP+sdeIBisgglR61WLLKPb6YP+VM8nTpaXiz8CLc0LYXtqHEHc9rZACTParjuQkNq6RCbqiwFz/gGiEaubMBOTDZ4sI+Kj57P3S4lTdqfSFvPO0pLUqhJwVJWU24IO8+zaCmtqhM+Ip9n5e4KOO+ezl7W+Sv97uQpGhGNzH9JLHhV9fha+EfLlzszgoLjfs30glZbDPhSv5oD+Wy3ErtTyFbO3Nt41pOWAaY54NoX4BK2x2oVA9GAj/hOgLfjX5lsOPU0vIqL8zGMeI3suMopn7sC4cJ9il/4818H00zY4d9d73uVuH1EVssTaLrqtJt3mRrpiDUTKjHD0eHitTksmX0Y/SSWEfFSwu0MMb+DbIymJym9tvjYo404RthczBGRh8jx/jn1kSoz3w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199018)(66556008)(64756008)(8676002)(76116006)(4326008)(66476007)(66946007)(66446008)(110136005)(316002)(54906003)(6636002)(122000001)(5660300002)(15650500001)(41300700001)(52536014)(8936002)(26005)(6506007)(53546011)(186003)(9686003)(83380400001)(478600001)(71200400001)(7696005)(33656002)(86362001)(55016003)(38070700005)(38100700002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i+YC4QFsjwVjQ2uaD7vNCyO316k6v5fEo5nwHqGKYGWgnP5Y1UHehO+3MjyO?=
 =?us-ascii?Q?WqHchG6Cx5ipjzbwP8he38TVyLHNXL35KRovnjjdYQkd8mskUwhqVMl1heQN?=
 =?us-ascii?Q?0mZxYsKyPG/Hez7YpR4kwHWkD7JuLoAY+40G4pljNvsHAUvphKjOTvS+/GHS?=
 =?us-ascii?Q?+IyLAZfgsyb36FjJST/dIgosK0GHTq8ZxmMFf2/VYUbGsdwz7Zh5vO+DMSBn?=
 =?us-ascii?Q?g24vJ5M+48SqPNxUiw/dqa3Z9whMjRZZSWwqrfPttP5nOa1LAhKV04SY+0R9?=
 =?us-ascii?Q?Y5I5lcXzC83rhIoeMUMr+kgh3bf02f9B0Z/KcVR9cHj8J92oJRxGjup3baDC?=
 =?us-ascii?Q?XApevfgNjjaA6AihU8qwEO2K9Gp41jOmSXt7CJrhTZBex7iqhkO726qPHF7g?=
 =?us-ascii?Q?BW5+BNtHI0gX5mBuciJsfInCyDP4iYhJNjBNofuks39XyKyrG2Fht0ngWq/z?=
 =?us-ascii?Q?VciKtMPYlDmmsSn7x4tIX/BpQRgjfZWCqFewd2Dxb1K9KUInChpwUrL/DaRN?=
 =?us-ascii?Q?LPfkn2frvN54oni2Em6vWL9SdMzKnHQx/S7IT3TZr2iUQKDp1QCtcdYt5Emn?=
 =?us-ascii?Q?/wAYjnfuZ1PGp65gGPrcFbQv012q54QcFDEoiWhCU+3t01csnwnVab2Iqhqx?=
 =?us-ascii?Q?qseg/eJhuqqp+oBlijWHqZuxaDGpQhB6L9tH5yPBU9SQ3KdoPxOsbjnmWWjY?=
 =?us-ascii?Q?CzFwX/OTF2m5KynzAneL9MqCczSRK/XaNDlQ62x/r6EoQ+TwVTeU1Rt4EMbG?=
 =?us-ascii?Q?qlT/pxucV26Q3j8WpwkSZh7elyROSWYc+xTmKfwajUat6kwhM7vyWuYEgPcj?=
 =?us-ascii?Q?EeL5NYLPuq4+aOZOEaqXixrcAKXLup4ImHlk2YNHfr+/PeUwkib5CGYOlWKr?=
 =?us-ascii?Q?YdUYimY5Gu/uJ7jzXs5qYdq3o0U+qc+UoGkQOqALrmXHrPqBxNig4Okebso+?=
 =?us-ascii?Q?u0jwSwQhmecKJJxX6z+fQSaLM1OUr/xvy7uhFauboqp85f1Ipq6d7hKhLNxR?=
 =?us-ascii?Q?3+zX+3ofu/fyT+plkosLzAQEKz4RK2uq1cjT7jD8xxGCyPer81vuhcJYOjUD?=
 =?us-ascii?Q?uCnxRs/78qOyrP3LS3E6etOjhtu0onek7dOjeWBRUW7VJLzQLr/je7uIDanR?=
 =?us-ascii?Q?MrunuPedfwJFsTiXF8InLvTxHv3BKKmD96Vx5hSaFZXSpMm+ZMM5XcF5LagD?=
 =?us-ascii?Q?Gh9bTZxesDpU4ePW6uhZvDNE8MDOuoAcnj7lULinyEBLoJi1TD3GI4CNJrAU?=
 =?us-ascii?Q?aFQ7j1IIaJHlJsWUBp5y5K7VAHf5guskaqJdiVNPB2T9Xi2daB38kG9Z+u98?=
 =?us-ascii?Q?HAjADmGg/3keJU5F3uMM19fvmVCFqx/ZKpYIuPYWWVm9dVrleyuvtNDej4T5?=
 =?us-ascii?Q?cAL/W6c1sD/hOq1s8PFnpRcOG52fp6ugUfRmE25oAWBKvauE0LPrUqnxndUz?=
 =?us-ascii?Q?azDDkemrNCpuLqSpM7DzjaAOCaez8rWhUJB5FYDgW390UQ09BAiEm6iAJQen?=
 =?us-ascii?Q?tIrr/YoJ+hioLY7fY8tMDvruJP1YIxJHuGtrcqTb2RrejirH5OONG8OkNDBV?=
 =?us-ascii?Q?xQ/+g0GK51Otd2LLtdE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c01596c-45d2-4653-1870-08db2b6f60c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 07:22:36.7900 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WzHgWaWjexgLnGixI8UdRtDik1COseCKME4kqsAqhbC23uILDXtrQz7atUd1hRxj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7642
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
Cc: "Li, Ying" <YING.LI@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Yang, 
 WenYou" <WenYou.Yang@amd.com>, "Yuan, Perry" <Perry.Yuan@amd.com>, "Liang,
 Richard qi" <Richardqi.Liang@amd.com>, "Liu, Kun" <Kun.Liu2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Wenyou Yang
> Sent: Wednesday, March 22, 2023 5:16 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>
> Cc: Yuan, Perry <Perry.Yuan@amd.com>; Li, Ying <YING.LI@amd.com>; amd-
> gfx@lists.freedesktop.org; Yang, WenYou <WenYou.Yang@amd.com>; Liu,
> Kun <Kun.Liu2@amd.com>; Liang, Richard qi <Richardqi.Liang@amd.com>
> Subject: [Resend PATCH v1 3/3] drm/amd/pm: vangogh: support to send
> SMT enable message
>=20
> Add the support to PPSMC_MSG_SetCClkSMTEnable(0x58) message to
> pmfw
> for vangogh.
>=20
> Signed-off-by: Wenyou Yang <WenYou.Yang@amd.com>
> ---
>  .../pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h    |  3 ++-
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  3 ++-
>  .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 19
> +++++++++++++++++++
>  3 files changed, 23 insertions(+), 2 deletions(-)
>=20
> diff --git
> a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
> index 7471e2df2828..2b182dbc6f9c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
> @@ -111,7 +111,8 @@
>  #define PPSMC_MSG_GetGfxOffStatus		       0x50
>  #define PPSMC_MSG_GetGfxOffEntryCount		       0x51
>  #define PPSMC_MSG_LogGfxOffResidency		       0x52
> -#define PPSMC_Message_Count                            0x53
> +#define PPSMC_MSG_SetCClkSMTEnable		       0x58
> +#define PPSMC_Message_Count                            0x54
This seems not right. The message count should be bigger than the index of =
any other message.
That is PPSMC_Message_Count should be 0x59 or bigger.
>=20
>  //Argument for PPSMC_MSG_GfxDeviceDriverReset
>  enum {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> index 297b70b9388f..820812d910bf 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> @@ -245,7 +245,8 @@
>  	__SMU_DUMMY_MAP(AllowGpo),	\
>  	__SMU_DUMMY_MAP(Mode2Reset),	\
>  	__SMU_DUMMY_MAP(RequestI2cTransaction), \
> -	__SMU_DUMMY_MAP(GetMetricsTable),
> +	__SMU_DUMMY_MAP(GetMetricsTable), \
> +	__SMU_DUMMY_MAP(SetCClkSMTEnable),
>=20
>  #undef __SMU_DUMMY_MAP
>  #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 7433dcaa16e0..f0eeb42df96b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -141,6 +141,7 @@ static struct cmn2asic_msg_mapping
> vangogh_message_map[SMU_MSG_MAX_COUNT] =3D {
>  	MSG_MAP(GetGfxOffStatus,
> PPSMC_MSG_GetGfxOffStatus,
> 	0),
>  	MSG_MAP(GetGfxOffEntryCount,
> PPSMC_MSG_GetGfxOffEntryCount,					0),
>  	MSG_MAP(LogGfxOffResidency,
> PPSMC_MSG_LogGfxOffResidency,					0),
> +	MSG_MAP(SetCClkSMTEnable,
> PPSMC_MSG_SetCClkSMTEnable,
> 	0),
>  };
>=20
>  static struct cmn2asic_mapping
> vangogh_feature_mask_map[SMU_FEATURE_COUNT] =3D {
> @@ -2428,6 +2429,23 @@ static u32 vangogh_get_gfxoff_entrycount(struct
> smu_context *smu, uint64_t *entr
>  	return ret;
>  }
>=20
> +static int vangogh_set_cpu_smt_enable(struct smu_context *smu, bool
> enable)
> +{
> +	int ret =3D 0;
> +
> +	if (enable) {
> +		ret =3D smu_cmn_send_smc_msg_with_param(smu,
> +
> SMU_MSG_SetCClkSMTEnable,
> +						      1, NULL);
> +	} else {
> +		ret =3D smu_cmn_send_smc_msg_with_param(smu,
> +
> SMU_MSG_SetCClkSMTEnable,
> +						      0, NULL);
> +	}
> +
> +	return ret;
It seems the whole bunch of chunks can be simplified as=20
"return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetCClkSMTEnable, enab=
le ? 1 : 0, NULL);"

BR
Evan
> +}
> +
>  static const struct pptable_funcs vangogh_ppt_funcs =3D {
>=20
>  	.check_fw_status =3D smu_v11_0_check_fw_status,
> @@ -2474,6 +2492,7 @@ static const struct pptable_funcs
> vangogh_ppt_funcs =3D {
>  	.get_power_limit =3D vangogh_get_power_limit,
>  	.set_power_limit =3D vangogh_set_power_limit,
>  	.get_vbios_bootup_values =3D smu_v11_0_get_vbios_bootup_values,
> +	.set_cpu_smt_enable =3D vangogh_set_cpu_smt_enable,
>  };
>=20
>  void vangogh_set_ppt_funcs(struct smu_context *smu)
> --
> 2.39.2

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 851F5C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 02:55:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06D7411AD9F;
	Fri, 10 Jun 2022 02:55:13 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2042.outbound.protection.outlook.com [40.107.100.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D543711AD9F
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 02:55:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ir2i3dv95ik0bUxfzTzIrGL01k/ZAUrD5dx2AlK875lW3IZ7MA+zsnZEOgH+0YuAXK0wRApWeX5sqyp5jml2cEQ4lJ9czwY8zf55MEB21CKgC1CMaSdzx9jzJ7hc7C3IQgE00OGeOGev78DY6x+AIrGIRPd/r75n+1R4UL0wAuDT2thzN8ct7BIReoXrpAMwQ79p2CI/rXoPoP1pZMjDogUUP11MigaWKf1SmVi2QVB/CUf0PK7LP58Us/OvwisqV+53deD6tfC/eTrtAKR5JpOYmx4vi6mhdQF4iXDj5kdPNU588ymFzjM5WweSMEcxZJGqLRHql2u65qgC6vTQSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hawgRITCuHn1pdyyQZcPCT/hjyVc7I+13ZVX0Onqd6I=;
 b=R7FVgKMncdrlytvzGEZELaudmzkz3/e5pwAKUCaEkriTnqWNKZQO0QXUjnk5ifGNAYnS3515n1uekQRjSR7OUVlq1tXGBM7mqhdVDOLmUf+lGgPYtqjmeHQ1MK8UeAsbJwAyUuoUazDg2baSDvIItRiDlnQfPpmtP7yv7blEnmEiHf/BfNw2y1yVa8/WgZOd3s6ohCti0+INRZ8jO5Xr+gcvta0gjh+5VpELUyHHTyXH2B8aXxmtp0KeISG4a58WxtsQA4g7BYglKysqY0rcThdsmzZyyPmZEDHUUMn7l8w2fUfNhNmyVyzPwa+ikocuovH9IaHJwO++CTXZZY5IZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hawgRITCuHn1pdyyQZcPCT/hjyVc7I+13ZVX0Onqd6I=;
 b=MuT9QjHTjBYuGlfzdF48+N360GxFDytYm6YNF+n9AkoGq1Cqb9M0AxICp4zsQe6WJUVGt08ocLa+ngBNjUdTc9xSIWRXB9z006b3DCgK96X0UNfKghN3vKI1lO8iuknoZdEbFgPe3eGNQQQvvb04nMbb4F6V5q2lRSjhQ5wuMDY=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 LV2PR12MB5797.namprd12.prod.outlook.com (2603:10b6:408:17b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Fri, 10 Jun
 2022 02:55:08 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::8022:6c38:2e9f:6c9b]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::8022:6c38:2e9f:6c9b%6]) with mapi id 15.20.5332.013; Fri, 10 Jun 2022
 02:55:08 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: fix driver reload SMC firmware fail issue for
 smu13
Thread-Topic: [PATCH] drm/amd/pm: fix driver reload SMC firmware fail issue
 for smu13
Thread-Index: AQHYe/TIXnAwaN4QC0WrzwZB5IK4U61H8iIA
Date: Fri, 10 Jun 2022 02:55:08 +0000
Message-ID: <DM6PR12MB26192F91D5F6917C4399C0F4E4A69@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220609113255.2124596-1-KevinYang.Wang@amd.com>
In-Reply-To: <20220609113255.2124596-1-KevinYang.Wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-10T02:55:03Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=3791a235-f33b-484a-944b-aa4fa9e831bf;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1d60549-4417-46fb-0c76-08da4a8ca0da
x-ms-traffictypediagnostic: LV2PR12MB5797:EE_
x-microsoft-antispam-prvs: <LV2PR12MB57977F1C94136F342690FA83E4A69@LV2PR12MB5797.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FNIPY/ncaqqB/t/OZoJyOgyisuoUDqqpmAhN4iLsJmjP5wxYX3p3YiU/I7ZLkDoPNEmA9KbjB2X1RPIDQO2mKGn1gm0wvsne02obk57dNAI4E2N4XkkSLUWDDETJcgeLyYC+qv9qNnsZtwIbuhTZSygtK/fa4dOk9Aevl2HG2D8Rz0XWSed5rH4+qpPh8XiBgmqeInj9bVxDw7Xo18A6kx9ZC1PP/u+6o361mqgPCUMdg8Ush8rnHa7Hrj1LjwKnEPSJVPapNE42dMjhEV/UejOrJfGkGYY/B5MWjALP92wder1/ssASwdi5pTTJXlmI7u4kJNQ1XS3vOG6hbTSNfZMMKzXozJcH+ziJ2t+IDEdOAbREcGUSScKNyNCsHdBm+rKiWGBMO9pe+u4C75sS8Df5oZv8vjMzFwhqgTj3BM8gCxpJNxrQAQa8spKYYmZ9aEN/iXJ43i3yelNtSegaaB/c5k6mYWhK3cYBxC/2JSCZuT9p6hXDYep7n/6KoGn9yghGSUlLVMZlP0nqITr5yN5A5DMAUbs0zHkTbLzGLbu5MUGkl73wrRZfgwQAi84qvTZIGr6EVfjBG9jZr0yEKcF8SslTRJYk8X8Ax4IQ2AaO8QOzej0P6HY/AeWnIaPZnPeQ+WYaTKh7l+I2Ku2Xlr3YsZBiN0qT/gZ9OKLBRYkhlgYdEZAkZlRXNxVbl/4GgTB1LXNREU4H4VXEp3FS2w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(71200400001)(86362001)(508600001)(66476007)(38070700005)(66556008)(64756008)(122000001)(8676002)(66446008)(4326008)(52536014)(316002)(26005)(9686003)(110136005)(54906003)(66946007)(19627235002)(76116006)(38100700002)(5660300002)(8936002)(83380400001)(33656002)(186003)(55016003)(7696005)(53546011)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+5mAPZSSMTqfuYyIElKurbVhtJFnFHW9sdxB22OmtTI6Yp9oVofK3BeVIiJ/?=
 =?us-ascii?Q?JxVz7mxyWUl6rN+PuJq7NUMpjSvQ2YXdISi9s5xrn2TiYw6bkkKYo+o9WYFc?=
 =?us-ascii?Q?5SGq7dF6DGpCMAhv3alcJKDAm9gh/Cd+ODnq6lFlaqUKe4Jxr1S+Uy8xk1pz?=
 =?us-ascii?Q?q8EuX67ljL2b+k9BsEmlABQCYbcIRrWETzE2aWSyolt89X4TeomaP9v32CQf?=
 =?us-ascii?Q?QfJkXv8Sih4id0oWz1q8y8m1d5ukNDj6NY5PLoO+9UqOm58DoDiuvEUROS4j?=
 =?us-ascii?Q?w+n2OoTfNRYkeduaoXRuVlNMrBLJt8vw46NYAleLZOaths1RDugFrIkPWVK6?=
 =?us-ascii?Q?uNTT7dZTn2VpqvE+2U0hZoXl+ntB5DdknbSFZHWcW78RDFkRnpZNP8NeDwAw?=
 =?us-ascii?Q?MJuwsEa+IzQDjNbSR4mbCfOtaz/fScbDIulUhd0h3BPGrUA/l14oZluqMrcn?=
 =?us-ascii?Q?hyZTrEC+K6euWRdRj9C/FW6VSAsp2VwWVTJHY2YQE+ny5WFOpaJbtDukgouR?=
 =?us-ascii?Q?UIQLA1tgDj9NE/VjMiQpAsU90pK1LmKI4nvaOFGW45gTFKf03Nq72tBeYXK0?=
 =?us-ascii?Q?z0hvGJ6r7I1nTnZW/0LAGnWCjOHQWBggAOyKS8J4FfsiyCxq4HKA1Ng4jZEh?=
 =?us-ascii?Q?YhnxPiW+cUhBqqWB9Qa9qpirvL87MRV6qsOAVRB3H8Z3xZm/TJGdE7JoIG3j?=
 =?us-ascii?Q?jEp5GcJNPunWX4txUxJXG1y5TVzCSdsSTxmglAN80C601c5JbTMtpml2RcL0?=
 =?us-ascii?Q?3qyDonDT+roIyXApVPixvqYaglgl035aj1/tRBcXtJ/5zL9OqlS8q4ZQFuaL?=
 =?us-ascii?Q?72Ko6Ly4qsp3TXUXes5oFxxxiuvJydFqSBIO9inBoEFcsB9wkrC62hh9kPeu?=
 =?us-ascii?Q?oh89rxH+Qgvdo8aXREEE61VBKoYTa5Yz0ZcJTPTglxzlKQjKNCH8L0n/0/UB?=
 =?us-ascii?Q?grCjVqHLdo1JOgPnUUiq4xLeX7NGflPFaSHRLPXkVbf5wJYTP+fQvfVjbhtr?=
 =?us-ascii?Q?YvThVGfBRViJW3NEfUnNqUz2TIKM4zqCwaRMa559VCmIa1UqJ4OjaxFT4yml?=
 =?us-ascii?Q?Otny7KMYlo9buc5fIlDKv8l6uQRykYZqogDwCSR9BqRcV/HHj6ax7uFCSskl?=
 =?us-ascii?Q?XIhs0u+dmWaFRG3GYn9AVOfckopDjZ5AOWg7dfC1EpnYuo6mrTrEHFNdyfHX?=
 =?us-ascii?Q?XjN0fE6/SPrdaf7kYtlFuR1W7Nf41g4d/fX7YOrDk7QuGuQ6eVtbN0SbZW+d?=
 =?us-ascii?Q?gbQFsJf5xSYuqbWnZMDXO0bTjn6VGXpsoO3g95H5tPYHnojCxdyM/ugcthyv?=
 =?us-ascii?Q?9kbMSxQAKaiGkycTqfXqHEY7ojEYR1GSRfNrQ4Jud5bZOBTQhB3OUJvrIjfq?=
 =?us-ascii?Q?BQgDBMmeYKsITxD+yPlvMv7pRw3uMyFPNNNS5ZRAX3jexChO+stbePSeAIi1?=
 =?us-ascii?Q?VBeMj3HdZwV3yaJ2SISL3iWkNnyrEMO49CCJwy0ubCiliPFCmu9Cobos5BWk?=
 =?us-ascii?Q?7DbgdShn8QWWRF6ngPdf1Uvrt9iJEo54J5QrtVghvkujd9c9MTjgNldu5Tu2?=
 =?us-ascii?Q?fpVZ5Wi7HNkuNXAseACDEHvllCxLhr2XpjBQGd0/pGnuNnPQhrNk1H+ulz8j?=
 =?us-ascii?Q?bt6sasPY0GRUL5Ejp7kYULaWSQ7fl12gAITZChTvTIWdiWUrW0prSgIYps7Q?=
 =?us-ascii?Q?TXxvUCbvHr/YYQ7RJN+M0qsGpP09uNmLJIXhf5fSy4fluqUT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d60549-4417-46fb-0c76-08da4a8ca0da
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2022 02:55:08.0399 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wnf9z9Mm0/5MToTnsBjQjroHF7kQurqT9IbAgyZwK0dGzLrBKzUrGhzoVLjlOX4B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5797
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Will this break gpu reset? As PPSMC_MSG_PrepareMp1ForUnload may put SMC int=
o out-of-service state. That may make it unable to serve succeeding reset m=
essages.
Can you have a confirm?

BR
Evan
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang
> Wang
> Sent: Thursday, June 9, 2022 7:33 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Feng, Kenneth <Kenneth.Feng@amd.com>; Wang, Yang(Kevin)
> <KevinYang.Wang@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amd/pm: fix driver reload SMC firmware fail issue fo=
r
> smu13
>=20
> issue calltrace:
> [  402.773695] [drm] failed to load ucode SMC(0x2C)
> [  402.773754] [drm] psp gfx command LOAD_IP_FW(0x6) failed and
> response status is (0x0)
> [  402.773762] [drm:psp_load_smu_fw [amdgpu]] *ERROR* PSP load smu
> failed!
> [  402.966758] [drm:psp_v13_0_ring_destroy [amdgpu]] *ERROR* Fail to stop
> psp ring
> [  402.966949] [drm:psp_hw_init [amdgpu]] *ERROR* PSP firmware loading
> failed
> [  402.967116] [drm:amdgpu_device_fw_loading [amdgpu]] *ERROR*
> hw_init of IP block <psp> failed -22
> [  402.967252] amdgpu 0000:03:00.0: amdgpu: amdgpu_device_ip_init failed
> [  402.967255] amdgpu 0000:03:00.0: amdgpu: Fatal error during GPU init
>=20
> if not reset mp1 state during kernel driver unload, it will cause psp
> load pmfw fail at the second time.
>=20
> add PPSMC_MSG_PrepareMp1ForUnload support for
> smu_v13_0_0/smu_v13_0_7
>=20
> Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c            | 8 ++++++++
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 2 ++
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 2 ++
>  3 files changed, 12 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index f57710790b8c..14ebc35d9cf0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -66,6 +66,8 @@ static int smu_set_fan_control_mode(void *handle, u32
> value);
>  static int smu_set_power_limit(void *handle, uint32_t limit);
>  static int smu_set_fan_speed_rpm(void *handle, uint32_t speed);
>  static int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled);
> +static int smu_set_mp1_state(void *handle, enum pp_mp1_state
> mp1_state);
> +
>=20
>  static int smu_sys_get_pp_feature_mask(void *handle,
>  				       char *buf)
> @@ -1414,6 +1416,12 @@ static int smu_disable_dpms(struct smu_context
> *smu)
>  	switch (adev->ip_versions[MP1_HWIP][0]) {
>  	case IP_VERSION(13, 0, 0):
>  	case IP_VERSION(13, 0, 7):
> +		ret =3D smu_set_mp1_state(smu, PP_MP1_STATE_UNLOAD);
> +		if (ret) {
> +			dev_err(adev->dev, "Fail set mp1 state to
> UNLOAD !\n");
> +			return ret;
> +		}
> +
>  		return 0;
>  	default:
>  		break;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 26fb72a588e7..fda89e309b07 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -118,6 +118,7 @@ static struct cmn2asic_msg_mapping
> smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] =3D
>  	MSG_MAP(GetPptLimit,
> 	PPSMC_MSG_GetPptLimit,                 0),
>  	MSG_MAP(NotifyPowerSource,
> 	PPSMC_MSG_NotifyPowerSource,           0),
>  	MSG_MAP(Mode1Reset,
> 	PPSMC_MSG_Mode1Reset,                  0),
> +	MSG_MAP(PrepareMp1ForUnload,
> 	PPSMC_MSG_PrepareMp1ForUnload,         0),
>  };
>=20
>  static struct cmn2asic_mapping smu_v13_0_0_clk_map[SMU_CLK_COUNT]
> =3D {
> @@ -1662,6 +1663,7 @@ static const struct pptable_funcs
> smu_v13_0_0_ppt_funcs =3D {
>  	.baco_exit =3D smu_v13_0_baco_exit,
>  	.mode1_reset_is_support =3D
> smu_v13_0_0_is_mode1_reset_supported,
>  	.mode1_reset =3D smu_v13_0_mode1_reset,
> +	.set_mp1_state =3D smu_cmn_set_mp1_state,
>  };
>=20
>  void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index a92ab3266091..185058637f7d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -116,6 +116,7 @@ static struct cmn2asic_msg_mapping
> smu_v13_0_7_message_map[SMU_MSG_MAX_COUNT] =3D
>  	MSG_MAP(DramLogSetDramSize,
> 	PPSMC_MSG_DramLogSetDramSize,          0),
>  	MSG_MAP(AllowGfxOff,
> 	PPSMC_MSG_AllowGfxOff,                 0),
>  	MSG_MAP(DisallowGfxOff,
> 	PPSMC_MSG_DisallowGfxOff,              0),
> +	MSG_MAP(PrepareMp1ForUnload,
> 	PPSMC_MSG_PrepareMp1ForUnload,         0),
>  };
>=20
>  static struct cmn2asic_mapping smu_v13_0_7_clk_map[SMU_CLK_COUNT]
> =3D {
> @@ -1647,6 +1648,7 @@ static const struct pptable_funcs
> smu_v13_0_7_ppt_funcs =3D {
>  	.baco_set_state =3D smu_v13_0_7_baco_set_state,
>  	.baco_enter =3D smu_v13_0_7_baco_enter,
>  	.baco_exit =3D smu_v13_0_baco_exit,
> +	.set_mp1_state =3D smu_cmn_set_mp1_state,
>  };
>=20
>  void smu_v13_0_7_set_ppt_funcs(struct smu_context *smu)
> --
> 2.25.1

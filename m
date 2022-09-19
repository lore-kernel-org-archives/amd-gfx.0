Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D63FC32771
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Sep 2022 02:06:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3369410E42B;
	Mon, 19 Sep 2022 02:06:20 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BEEE10E42B
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Sep 2022 02:06:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UmZE8UCfaQBNYLpa2uPayD2Wd9nkOHpCQsfdAelzuzhU0aXElF+nqChs8PgVwEc8PqeHnMdDAONmXw7NfG84WnciJ3B9SujaledSiu4FVH/WG10/mDFlnDZT2AsfkG/c/jVTrjhkfA0h0qm9/6myVukjUFntTzYBPWuC+dhoYGh0RzavoOXqOo4YjuLrhxBp6zgPabBqb9J1+JPdl95ru4E/08InSaxcktHoc/1LCmzlsan13nBY6FfGfAeGP6aeDigwyk1s3hRRELtxZYpZjESCAgWwflO2SJV/5xyu0ihJRGKG7j0Mx/qArpBUNEMZ1jvVvS2xjauTF390sF++ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/aeXeFE6bXBQ7Y1uUkq5Huq/Yf4FAKyaLk9s42ECWZo=;
 b=jeb19vTkG6ApkZmAZw7wLz3Rs6FmK0NIsZH8fMIsef1hk35s08Q1DhCjOmItrDwOdoMywCs2wPoxAjI3ruQPx2y/pgs7FlBgdZXRarzaj5wkfSeSbCZf67fxDH4SNp4GotNPxpW5xZsRici3JWuwsxQEsHIFx9895cJPTgTTK2KYx2McRqowZNsJUMOfQQA1hRzqc7js+zUPJckziuDdksvLqm6uLGQE4++mXp4W6Kak0/Jd9GJsrIT93DY3dW3ODQ2sBOitueHqf7VxWrfWKvuvKBg/oRdjaXyzSB9UCAU0cO86lt/ZbMs93PnEzB92F5+KZYRZHDgfFeCf5XPnyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aeXeFE6bXBQ7Y1uUkq5Huq/Yf4FAKyaLk9s42ECWZo=;
 b=E9gJLcKVigbFtjHbG29PQA1wZJ8aWgObueOL1F/RBhW079i42yTNuiveT3f/10pCBQ/Rg4W9p+Q/dMRggF+qsQgeZV9E7gjVgjmkOW+OFS8Az/frJoUtk/wjx5QoV8xluURsruVO+jYfg3XyTWvPt5104p8Kn7qMduFE/eH+1rI=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 CH2PR12MB4232.namprd12.prod.outlook.com (2603:10b6:610:a4::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.21; Mon, 19 Sep 2022 02:06:11 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::64a0:7cc8:5c5f:90fe]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::64a0:7cc8:5c5f:90fe%4]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 02:06:11 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: stalkerg <stalkerg@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: getting fan speed pwm for vega10 properly
Thread-Topic: [PATCH] drm/amdgpu: getting fan speed pwm for vega10 properly
Thread-Index: AQHYyzAHSeSdQ7Vr5kWkyRn4pllEma3mAl+A
Date: Mon, 19 Sep 2022 02:06:11 +0000
Message-ID: <DM6PR12MB261982DE6EACF869254AEDF1E44D9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220918072314.28870-1-stalkerg@gmail.com>
In-Reply-To: <20220918072314.28870-1-stalkerg@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-19T02:06:08Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8b1ee3bf-9b96-4ad7-a368-4f483899deb7;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|CH2PR12MB4232:EE_
x-ms-office365-filtering-correlation-id: 6b45c703-9b82-45f9-1c8b-08da99e38609
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bNkja0MMtnLq8lmzwwDhdgSiKrzNaDxbQ0yPj5Tw1sQvVqicSJ6eRykBFWx+OowzAU0Fug4sAx4K4+stvI+lhO/woCmIdvh8pTBoMbF9ajvecDQZDInuGFJ5PgcGWuOtfQFVnjFqO8wbsV0DFg45a/c2WqZKji50TrNuWMYFsXVxOOPgOcUP2WZXrRwCn9ymMJbacP39csKWnswgFtzt65fqRNnEDgK00UsT9sVZR4UqV8CAtm5kuDFrN7QemYi5dPZwyY7V2DlzoVAtrdYLw/T2kSDfU83aPySWzEGUAiF65GgL4Tm6MjhKkeQTwJBAaXIDYQ3HP0c/xu0rRb5CFA6PjpV9SdNMAmsH2Jm437qSS+6jzXO0NYlG5Bg792PWqQiZBGx+mDzJktWVevYJJEdpz5rm2nlltq1T3ylxIpY4/6evD/kLk9sfgrRr4D8IqvLr4nCHXaIYUfbE4VVJqtLO4J/dkNGNNAGHPZ7lR1YG0rLFRUNYv1Z+2wjQ3V0FE2L6BJZHejto2P0iIJa8gCQvmSTKjEQtQtxcfQfiXiQo/Ze7NFUKVFQZo/6r88GN6WJzh8DegMlxhJem9QbN/qHbUbXLB/fbGIyQUwZveJWYDEOLZ3DST0+8hXMOoQoJyl+dr2S/ALVT572q+tWl2ccqL5BgYxijqWklCOSokJIt2pXwdjn91SUh5Mugsxwxr+nD/XS4tarlvGQ82CzZVtbA+vJOPMlbh0ltzILlJDneaqUsI46/16HWsOCj6D+G4bnsnjEQlj9qOrYficRJ6g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(39860400002)(366004)(136003)(396003)(451199015)(478600001)(41300700001)(53546011)(26005)(71200400001)(186003)(9686003)(7696005)(6506007)(2906002)(8936002)(55016003)(316002)(110136005)(5660300002)(52536014)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(4326008)(8676002)(38100700002)(122000001)(83380400001)(38070700005)(86362001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dIzmjV0HnezcOr79sMNQlCmIrg1//bW60lJjU2PicFevI4QNZqHk/kUrG7Zl?=
 =?us-ascii?Q?z0QnZJjVbjkVAz6Vw49rPjF0298CnuBSnUgHTNBWOUlBSOYFVB9SfBsR2d8b?=
 =?us-ascii?Q?l/tzF0MYAkiY0pyhY/KvQp8UzedPV4wnfNxAD33gdP5QnxLlc6buLaeVVp2p?=
 =?us-ascii?Q?FPiy+Vj5A988B+BDDTBq2+IqqUVP6UDciuCQsk4w0vr/EP0kopn7awO4G5In?=
 =?us-ascii?Q?11LXRiZLDqKeVweG+JIVbjJoExngOIsZDRmClO19K5bi1N3/FEBtXhl1yAy9?=
 =?us-ascii?Q?XxxVVUVUjS42Ahe9PIT/6yySWaWjtrFBe/ht5btMu907WeiVEs0fIwkhyz9L?=
 =?us-ascii?Q?DjcI2G5vZhtKXb0o+yh9ovEnY2YAKB3EnX/0Xj7Ca15eX+y3L+ZpcwxPkbYv?=
 =?us-ascii?Q?oCLu4oL21ItfMf2bgnS28UnTiLhxDdlf0h96ciPf6efVIi/C8BIB8aTsgczs?=
 =?us-ascii?Q?Aj3ieqV/pBItzcJFnV/t5X5nwbu7IgfF/IM82h9mG8xVAznLsc79HQVfW7bl?=
 =?us-ascii?Q?3dIY9MnfFKrBF3HTaUNNuWPuHsuyAmKzOFuIbQrEn5OXZs2P+504vpm+hx35?=
 =?us-ascii?Q?51kgr7TSQ8O52kyj5L6xUWegwIdGaFgEqzLEigXxZSU3iyB2eeBluoZQdgwB?=
 =?us-ascii?Q?0zZATzfyb63du45cZR/iVX5kvXnmakKPxwamvci9GY7g5bc2GCWQ0kjLfPLr?=
 =?us-ascii?Q?eIS/WPVcdBFsH5D1ipZqFd3+UfouXzslPX/PAWIcQKaWB6Azb5fdc74B01M+?=
 =?us-ascii?Q?tOe8S9t27jFK7204VJ9X0MtchockJdCQupcaGDFjHt07+vzKl9gaB5HPHHy1?=
 =?us-ascii?Q?Ed6BpGziQzXEjNBKxT4y8fiunSgU5OFUmHKoynR7LOR9ElTApJF/RVPySIcn?=
 =?us-ascii?Q?u4qK1pcTgL6oJTN9RzptXhyWaIRLW86/MVIiDV6jgAKtyifu9zLJVMp+FZsD?=
 =?us-ascii?Q?VvVAIKzZDRWTvWKPZm7fzPLRNhzk5KHLUwsOjlu0pmlIdy0oYYxegjhUIeIg?=
 =?us-ascii?Q?+5rFT7iR7KLYDmI3xpYhNvgu3gi7bwBG7dMaCDrmU0GeTfsxNE9Ui7RDEywx?=
 =?us-ascii?Q?KypgRR2budwpJYsObP79mQt40is/RDjLXknclY5vE22UlsJoLiSgv+ZOCThr?=
 =?us-ascii?Q?7gdUncB5y7CMRM4+aoW47M85/Pz3ihQEJSUBgi/XYvF83cyMvGOF7tm8vgDt?=
 =?us-ascii?Q?bOePsOyQqLXDzRSuPhvz6ETrbfSQXtUhl42J93opnCjwrKsWuhxOJ89qZHD5?=
 =?us-ascii?Q?cK0H+gJpSHR9xNNaozc084W/e0B8g0zXhiNnABbVlM+K2vp85MW2GsKGbMAU?=
 =?us-ascii?Q?o1weqkDUvQwncXDRBpTIkdjESI0dfWXKjZr91yisbnLjQXtZ87zeZJSKOi7y?=
 =?us-ascii?Q?b6DqEl5ZOdpWe2YLfcmOZTyaQTvmWkb5BXd7Z2XkkMHn0jcjo4yfQl3Iey9C?=
 =?us-ascii?Q?dbnK1bdBRCvXabWP7sJ0X0LAkoz1lN7RvpUDvV2r3kxtrtiAHHJUdNwWsxrt?=
 =?us-ascii?Q?wjJQ9z7dIZUuFZvdPNwt1WHaXsRSg7vvV5LVqwnPuhIrwjjTDRp23rizX8o1?=
 =?us-ascii?Q?IQlAvuI8sXJ5KWkjJIY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b45c703-9b82-45f9-1c8b-08da99e38609
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2022 02:06:11.1091 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IYRhZ75X0rCNTlnISL8YbBgI15rCILfAvzp0Sam1QEcVgAmQ6G6/RBB27nbQMzoN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4232
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> stalkerg
> Sent: Sunday, September 18, 2022 3:23 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; stalkerg
> <stalkerg@gmail.com>
> Subject: [PATCH] drm/amdgpu: getting fan speed pwm for vega10 properly
>=20
> Instead of using RPM speed, we will use a function from vega20 based on
> PWM registers.
>=20
> Signed-off-by: Yury Zhuravlev <stalkerg@gmail.com>
> ---
>  .../amd/pm/powerplay/hwmgr/vega10_thermal.c   | 25 +++++++++----------
>  1 file changed, 12 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
> index dad3e3741a4e..190af79f3236 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
> @@ -67,22 +67,21 @@ int vega10_fan_ctrl_get_fan_speed_info(struct
> pp_hwmgr *hwmgr,
>  int vega10_fan_ctrl_get_fan_speed_pwm(struct pp_hwmgr *hwmgr,
>  		uint32_t *speed)
>  {
> -	uint32_t current_rpm;
> -	uint32_t percent =3D 0;
> -
> -	if (hwmgr->thermal_controller.fanInfo.bNoFan)
> -		return 0;
> +	struct amdgpu_device *adev =3D hwmgr->adev;
> +	uint32_t duty100, duty;
> +	uint64_t tmp64;
>=20
> -	if (vega10_get_current_rpm(hwmgr, &current_rpm))
> -		return -1;
> +	duty100 =3D REG_GET_FIELD(RREG32_SOC15(THM, 0,
> mmCG_FDO_CTRL1),
> +				CG_FDO_CTRL1, FMAX_DUTY100);
> +	duty =3D REG_GET_FIELD(RREG32_SOC15(THM, 0,
> mmCG_THERMAL_STATUS),
> +				CG_THERMAL_STATUS, FDO_PWM_DUTY);
>=20
> -	if (hwmgr->thermal_controller.
> -			advanceFanControlParameters.usMaxFanRPM !=3D 0)
> -		percent =3D current_rpm * 255 /
> -			hwmgr->thermal_controller.
> -			advanceFanControlParameters.usMaxFanRPM;
> +	if (!duty100)
> +		return -EINVAL;
>=20
> -	*speed =3D MIN(percent, 255);
> +	tmp64 =3D (uint64_t)duty * 255;
> +	do_div(tmp64, duty100);
> +	*speed =3D MIN((uint32_t)tmp64, 255);
>=20
>  	return 0;
>  }
> --
> 2.35.1

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C957C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Oct 2022 06:56:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 068A310E634;
	Mon, 10 Oct 2022 06:56:15 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7999210E633
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Oct 2022 06:56:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2qWRmmnmC2+LWRa9oDOftCs/0oZpBaw3dJAKvzuOQOu/3O/uGbGeBIzCKDrJbwSxicMiR/kPVyIdWctxgT+zcjIs1HpTkvGDv91EcHVKMe33DNo2ZiEVgKjraRc/EAZ6uHspJBu92ZMCrOzduFWnIPD7Uo0CPYIHzlWnNdoT7knCzQ7otvOKb8jac35HgXMke86mFgMpk4IdFkLT1824LrcKfqaR6BkuiF2halmyjSRQz0SLMkxCJqSzfC4gSJcDqicaYPrLruETnAHTOT1AeTpjzRmvMpM30uXsHo7JTadbvGrGlxsL5UPI/8Z5i+yF6QwDAtwIp6xRAszCvxg+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2tl8tZHL3G6qdk8cJTddEOOwb6I9jI7jKVNDsZUnfuw=;
 b=Ez7rBkRKyH0FlvMl3zlrpLWrEcDzBga8FfZiReDxu5dJnGvVqj/iXDRA9hp0LcQlWyokTb07rMERfK2oPOPIL601hiqGtsJmKLwqNbMzkv8/s5S7AWDz9yQK37rTMmAkNmkSh+5LZS/gt1w3v1F7pd8YPPeCU1RkiIMIZ9v3Nl4zXCCshsVsap5jMQHFgwO2ClVxObSv+7c/a5hpbmyseSb+1Qr6onKfP6ZFWNgd7/gdga26uO95Ah61XZ9fDI2P4hCzI4iFHd4/l87XlHeo/Lp588L1UCk2glORApwb3gra/OCI7BdkyPQKFqa+0BtiaRD2LpynfjvQZuvbwHBOKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tl8tZHL3G6qdk8cJTddEOOwb6I9jI7jKVNDsZUnfuw=;
 b=kZX5+bs/VjoMGzsQx1xmcRJGvBizFalL7clMFsafEldYOnbCK7W7pwUQDUJndeznVTzY7U4EEj4B/dZuJ4oKlFLACVVit/IhL5lXqnS32yUmcaiRkvdKjULUTaaJXytIPL4h6Ue+GLJfDxQDFzPNw3DwNyNCTHJVYdaSmM3veLg=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by PH8PR12MB7280.namprd12.prod.outlook.com (2603:10b6:510:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Mon, 10 Oct
 2022 06:56:05 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::25f2:ed23:3985:d9f5]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::25f2:ed23:3985:d9f5%5]) with mapi id 15.20.5676.032; Mon, 10 Oct 2022
 06:56:04 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: Add poison mode query for umc v8_10_0
Thread-Topic: [PATCH 2/2] drm/amdgpu: Add poison mode query for umc v8_10_0
Thread-Index: AQHY3HRKkHDux3gyT0+ramQUmElYX64HMNsw
Date: Mon, 10 Oct 2022 06:56:04 +0000
Message-ID: <DM5PR12MB17707934B9EB152AAB6FE9B1B0209@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20221010064707.14459-1-candice.li@amd.com>
In-Reply-To: <20221010064707.14459-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-10T06:56:01Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=905dc27d-16d7-44bc-8146-7cc2dd0203f9;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-10-10T06:56:01Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 22baf6c0-4771-48eb-aaae-303323245b05
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB1770:EE_|PH8PR12MB7280:EE_
x-ms-office365-filtering-correlation-id: 76d0e8e3-eb99-4186-ca0f-08daaa8c8032
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JhPJnV95V59p1OtmkDKl82P9Tf2DIE8sYlvZkyqJm8IADV65xML3WLHM1ZrWTNJo92ilBejkwMEPD8586xxfVrJLBvzLccVDURut84DOLnrgkXxcPqnps3ZfKwHhKyisOuTEjGRZgJeCY9DzJ3CClfzIlbY0XCMiTj1fiqfINr3ICMghvuu+Jjno3nyWYVLsRWSWAWnyUjfFzT/ViPYCqSIwzJqcxjvmiHrhvyIW5XEzRVpsmqc1On8vXIV+OT0/TT4rNXsRvyOSuUcQduvo8HOACmkv9be32Wex0YXwRjfcNY6uuM37KFQptsvOG6LqJmzuRuG09nXmxn2xOvyVgWMeQ0GSXhp79p/bJ/tgYKSdjk4r1gAEj3AcY9V2XNOBBqrLiv+K5w1frdnKcnEBynhVEI/AgXEc3Abmm40VMhaFAHyp5N1scW0854q/iZZPvtPdTiObRCszI9DsE2lWBJGqNRVdmpjJK0X2Jw9HSCYmTWQBhdC8+Ep5SaAC5R+eAQwbPamwZ47EhkAj0h0yB3bh8tL03FUiRy414B8p9HzcihGK6nOEG+cXIGSFvST8IKncpw/g4BoAkWwjZiBGN+nOiMe7Uk4QCnN0mapGsbGbFLyL8nwsyqoapNTsIKJ/Ss0AXaXHNbEBUC8h/27sQlrpkEbNM0B+gSSZopaWCfXI7bodNEbPIj0jUbRdNJHpYHN7RfTjlz+hsmBPswSAVE+kPjlLDXNv9y7iLYChYqWFd9sSR08xKG0UWJw8953VI9tKqhigVabI2N3w0V+HVg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199015)(110136005)(38100700002)(4326008)(83380400001)(86362001)(66446008)(122000001)(66476007)(478600001)(64756008)(55016003)(316002)(76116006)(71200400001)(66556008)(53546011)(26005)(38070700005)(66946007)(52536014)(2906002)(8676002)(8936002)(41300700001)(186003)(6506007)(5660300002)(33656002)(9686003)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?auvoqoTq4BH5LMIjBT4RqHtbVcQVEqmbfRLMt7empZZGBk/FHNIqSbBOBfJf?=
 =?us-ascii?Q?QV3e85lidSM02GehXNnKakb84io3nmeyopGMBsK6cW+LXy1k96bnCC0uFFlg?=
 =?us-ascii?Q?CA72H8/0MqIATiirbkdBE019hUrzCy+xP29QLaCk+ljZ692xVGJVxcmxG5+G?=
 =?us-ascii?Q?18nwr4lQBCSoiATAblgEeCli86alU8CEhneParv/fpKDfF1U4GnjNZoNSQXv?=
 =?us-ascii?Q?3MiNHNDdOakrjMb2J6MHG5yJ6t1u3UhGi8MXRs1YdaSBtN3e6vICnPCSW1dt?=
 =?us-ascii?Q?nMALBvbUjE7O0ySoUZ6BQYJ5aau1Uj5s0d5awCwmyi2Xb+VW/tzzrVcPVGdg?=
 =?us-ascii?Q?UBMqPGPNSY57GlFrHzbZ/tWsotcTiVwGgpJH8tCwgvWmN7tMEq6RQKd+7jax?=
 =?us-ascii?Q?rZdlXq1AigvMfTbcO2gH6Y3KejXZGvF3YJdNEplefF4KBCBQ9ljGFYEKhhTo?=
 =?us-ascii?Q?eDcDuZ2llj5nXTBOULh5R+DlEgt4cX0/SztdQpej4Vw/a62qNF6kbydpJMB/?=
 =?us-ascii?Q?HXQagaqkZsQxHLuoNS89GEHlnL3w205itcT30l64ryd4aLQcsYDobRwCZ6Q1?=
 =?us-ascii?Q?Jp5DquIod1OTUQCFCP8tNMW4OS0mQuyuf/yhzAts/i/y8HS8Nxxi/j9yVnpo?=
 =?us-ascii?Q?rsP42jD5JTj89f8lJq6TGR3C8c6X4vqPgdbZXxZMETbJH34GLeOGylhb8j0S?=
 =?us-ascii?Q?gyjPUvAjkMRkalfaCC4ZpnBMFMncGMVs4qtiDcfWASL+5d0ENeorNrb7cOzi?=
 =?us-ascii?Q?5xCywQU3aU+Bws8ZSQiy72As1NktufOouodT/LEbLPOeQJMV/p/V05jcFsM7?=
 =?us-ascii?Q?eVoVZkk3UDf1mptz7C8rCctYJ2RmQma0n4JdfO1Ngc/jOW7z8tqSmRWdCSTm?=
 =?us-ascii?Q?5CoifrIMf8KZxFLnV1m5SEn4ib5bV0VgfGVzobixMODA5NUz7V1gpKi2pxTa?=
 =?us-ascii?Q?R133Z99ztjcV31jnHEiG/B4zdqSY8+O+rVKA2gG8hItMGJB3DxQD8V+eMNIY?=
 =?us-ascii?Q?H+WYrPmgMr65mRAozloI2qqClTzce7mt+qkVnfz5hA48yjy/8qYjj2Ws9I/U?=
 =?us-ascii?Q?m/N8PRUymajFQ8e4nJKkD8PxtrIm2zFK7rTVYTYhao4ul5wlzgWfvzh10zwl?=
 =?us-ascii?Q?ENo4UpDSdrVe/2MrcjW6MrbZDdRpkOZU3HC1w4W1WOjQazqeJQXBGW6YzdQC?=
 =?us-ascii?Q?q2XtgnEZAIp7Q0Te1M+xkTh+48/YJ9k13Sl8XhTvWpPseZ1YDVQWAxHwEBhK?=
 =?us-ascii?Q?Ncine4AJthyxTlrO33PHdtqmYPQHYDROrwsOGYivIIZQ153K+FUPBWtG1oQz?=
 =?us-ascii?Q?rq/RVe36woRC92XjmSN5744S51LZKIdXZ8W9y7bPOy/q++Y9EEJPOQEOMtPy?=
 =?us-ascii?Q?tMJ6U61EZ+LS3SHv+5AAAMWC6RR0Ce+0CxOMBZLDIMrTt7fc8Ec4jSOFXnzS?=
 =?us-ascii?Q?637Ac0i2DXE4X+ItheFspc2fldd82ucHwGjxKefniNB6n4Y91I9Oe+mdN6Z/?=
 =?us-ascii?Q?vtw3PfmR9KMm7kQnaJBeRKqkytNlXAf+6wcmaCcIhIOeeF1SujJL1EggUhNM?=
 =?us-ascii?Q?ElsSHkEBehfBVeycy9U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d0e8e3-eb99-4186-ca0f-08daaa8c8032
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2022 06:56:04.8989 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 33NTGFMwDogC8fuGEcKiQlZiZTdkvnQ5RpRTE9F8UGWRBKc1LUC7ymEvj67rwAcv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7280
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
Cc: "Li, Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

The series is: Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Candic=
e
> Li
> Sent: Monday, October 10, 2022 2:47 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Li, Candice <Candice.Li@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: Add poison mode query for umc v8_10_0
>=20
> Add poison mode query support on umc v8_10_0.
>=20
> Signed-off-by: Candice Li <candice.li@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/umc_v8_10.c | 26
> ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
> b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
> index 36a2053f2e8b94..0ba10d80c02536 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
> @@ -344,6 +344,31 @@ static void umc_v8_10_err_cnt_init(struct
> amdgpu_device *adev)
>  	}
>  }
>=20
> +static uint32_t umc_v8_10_query_ras_poison_mode_per_channel(
> +						struct amdgpu_device *adev,
> +						uint32_t umc_reg_offset)
> +{
> +	uint32_t ecc_ctrl_addr, ecc_ctrl;
> +
> +	ecc_ctrl_addr =3D
> +		SOC15_REG_OFFSET(UMC, 0, regUMCCH0_0_GeccCtrl);
> +	ecc_ctrl =3D RREG32_PCIE((ecc_ctrl_addr +
> +					umc_reg_offset) * 4);
> +
> +	return REG_GET_FIELD(ecc_ctrl, UMCCH0_0_GeccCtrl, UCFatalEn); }
> +
> +static bool umc_v8_10_query_ras_poison_mode(struct amdgpu_device *adev)
> +{
> +	uint32_t umc_reg_offset  =3D 0;
> +
> +	/* Enabling fatal error in umc node0 instance0 channel0 will be
> +	 * considered as fatal error mode
> +	 */
> +	umc_reg_offset =3D get_umc_v8_10_reg_offset(adev, 0, 0, 0);
> +	return !umc_v8_10_query_ras_poison_mode_per_channel(adev,
> +umc_reg_offset); }
> +
>  const struct amdgpu_ras_block_hw_ops umc_v8_10_ras_hw_ops =3D {
>  	.query_ras_error_count =3D umc_v8_10_query_ras_error_count,
>  	.query_ras_error_address =3D umc_v8_10_query_ras_error_address,
> @@ -354,4 +379,5 @@ struct amdgpu_umc_ras umc_v8_10_ras =3D {
>  		.hw_ops =3D &umc_v8_10_ras_hw_ops,
>  	},
>  	.err_cnt_init =3D umc_v8_10_err_cnt_init,
> +	.query_ras_poison_mode =3D umc_v8_10_query_ras_poison_mode,
>  };
> --
> 2.17.1

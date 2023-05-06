Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 840DFC77B75
	for <amd-gfx@archiver.kernel.org>; Sat,  6 May 2023 01:51:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E495F10E2D6;
	Sat,  6 May 2023 01:51:04 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E054F10E2D6
 for <amd-gfx@lists.freedesktop.org>; Sat,  6 May 2023 01:51:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jGdBoYxrC9uTTiVnTlxXmM5378snNDdKJ2Rn3QankpiaFAqLY66xl9qDuz0MwXwDJ5Qq9DQdIIkltZpqWXwUI7leLGx6HvhzN+En7uilS4mHBPfUjQwI3kx+UkF90Z/xx3GcpZyUdcYANL++8Os2SDgNtdMajRjDqQ1C5ReyL7JhDOkpidn4ilCooewJTnynaBsvzPOKQ2JXFp5Dryde8TeRHSTB3yXJ5cJ8GEbofQG+msv240y4y2wbaNI8V0QtuxiYmE9YNsLhQJ/04/8yWLD4qC9dHCfk4tihRWOX9e8RcryRFPn/Lm8jaQkNL8nTWEaKdlCyx9TmmCB+VQCzqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qwtztr7koN2Rak62yoWevGDzZ4swC189hJKTg3BAbVM=;
 b=Q/67JxEdGAgz4p0heXpYQ3eqc3aSUGLZojXI5wVjs/xeFD6mmUG79Xl/6ez/GKjbnIvXQGf90I/UaBzhfLLzE8Y9Ax43JSSPztDtDe0T2Yf+eitLIQykrOruGdp2MytGJgWxq5hxU9OAs/fEFWBj+/7rc69VGQsVL/BnLKUL/eGHNb3mysuR8lvWEePNHURlk1fDj7e6yI9M+cLLxyWDR+ZonT2JC2w/0PY2L92C9R0iSgIVCQylSqyTmTc7KSNRSjgV8Pa8ATvkkD9rR0vE4Ypa8qYzIybnQybilK34a//4ZGpLJOhiZvp7hgMsxGQP6luHaS4l7PiOxme2ktCUhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qwtztr7koN2Rak62yoWevGDzZ4swC189hJKTg3BAbVM=;
 b=wRaC758FkXTxpVlETENTVtfmgL6DLXjfEyh+hAXyvgRTImAHRC2XoUW2DmjUxfDMC0xa+SYHYgkELy5tRtqZmtyGjncZdQcsnl+3sCzmPA/469Qi0tGnuq/5lPBK4930BH864BRMMC3leQYi9RiSeT/E5iQ1L2ARWqcVbRichVs=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM4PR12MB7719.namprd12.prod.outlook.com (2603:10b6:8:101::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.27; Sat, 6 May 2023 01:50:58 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::6fe7:b96c:789e:3eac]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::6fe7:b96c:789e:3eac%5]) with mapi id 15.20.6363.022; Sat, 6 May 2023
 01:50:58 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>
Subject: RE: [PATCH] drm/amd/pm: parse pp_handle under appropriate conditions
Thread-Topic: [PATCH] drm/amd/pm: parse pp_handle under appropriate conditions
Thread-Index: AQHZfysFcGTLf+44OECBFV0a4nVDe69MejBQ
Date: Sat, 6 May 2023 01:50:58 +0000
Message-ID: <DM6PR12MB26192F8AEC87383455B1841AE4739@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20230505082414.1194477-1-guchun.chen@amd.com>
In-Reply-To: <20230505082414.1194477-1-guchun.chen@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-06T01:50:55Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=fd8920e2-1b9f-43fe-a309-c002469a0c19;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|DM4PR12MB7719:EE_
x-ms-office365-filtering-correlation-id: 0bd3239f-7939-452e-d9a7-08db4dd456b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xG4+t4UKsXNmr6hz8IG/9SutsuUtUWBulnLWQKs/2JcJEu5J9S0EcFy3K6zWKFQmoyNe36RZJdY8DdP9U8++wikx7DU5cv2BZ8G81sLjVZa897jHMNyL0a/zRFS6JP52m8O13E7DMuMPz1vwTxrgv8b4AmW644rsaBNQPySug/mkf5sw1v8WqpLdUf+r2jfUqh9X9w8ogqSVVNrld8jHPh8RUvh2UoRD3mHqmsZb/XV3htYAbINe+uzUNDR8sWaWvWTS34UoHSi2GRIUbbXNV8L0X1nBsbM8y/fx/km27z+ZnrFuHmQ7GazhUjXWRbo2/4yX3ywdyFmu2f3G55pJLI1Uk2CdzDM7JkJ7AWAUQoE9805WImgGpCEn1yf6XezdfIY1cRrnFU4vctNvUm2Nwg+1htzY1cZg6QxPlao8iBbXEnABwYkBvEu+lfzcJzervsJovn/0Ju+lGOOm4K2roLqYElJOmvUBg7ovZJKgdx8mTo0o05DGst1D9cEg7IpUOHGFLym3RqQEJZOiGOo5+YICGzpclr/ObaB6yk8Gd6UUGgBgI12I2C/z73E6lAAXGuPOdYdo+8EnIl3szXeJXQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199021)(6636002)(4326008)(64756008)(66946007)(76116006)(52536014)(71200400001)(66446008)(66476007)(66556008)(8936002)(5660300002)(41300700001)(8676002)(966005)(9686003)(53546011)(26005)(6506007)(110136005)(316002)(478600001)(7696005)(2906002)(186003)(83380400001)(122000001)(921005)(55016003)(86362001)(38070700005)(33656002)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4Di25kaY7PJMxT/VJZZbpLk1i0JKdRXZ+o+8dTXrnZIoTzH33yJli/dcnaFA?=
 =?us-ascii?Q?1uUADsfHK7SYrM96fPtj+FnuU8B6quS73HcnFyva3ESwqmDZq4+qUYMZQ3Hu?=
 =?us-ascii?Q?1soWOvL/C9+fM7DbbNr+8n8arZOD3wt3JlHUMV3HJzfG0CUgyLt+/+yb3zjg?=
 =?us-ascii?Q?rELJe+pmpeSq8D16XF/zMH+eXmTs4ubEwPKwQmpmHVxQbwjAqhPJvWkaPQW0?=
 =?us-ascii?Q?faSK4nOXvMdPafV0cvzGgx38wMswYdGo69WtzHZt7GKQ86c219zsFbyguJE6?=
 =?us-ascii?Q?ByZbkn7OsN4+WQtrPR/8d9OT2SmkvA1ULd/nLtM3hY0aN2767GFQs0rLWTye?=
 =?us-ascii?Q?dncvnDYjNALAjk0T2IjlKH8LRQzjp0rC3DP+BVSMh2WojKzeOkV2hSh0h+3q?=
 =?us-ascii?Q?jYd+/fo9KSHIidEW8HmtSfdKrOUNH0vxTPCyISX37SK7wdfxRPzbDoXv17mn?=
 =?us-ascii?Q?83sV/9m8jKxQZPvTHRkJ7Qskl1Wn4bpRSEy4QZ89iwERfi7+H6dJMh4U0XuQ?=
 =?us-ascii?Q?bkcicxpZtPvS3IGL8/gSyVLEfc6BHZ7vwMBoEZoquH6RXFAf+4B54tKuo3gd?=
 =?us-ascii?Q?NQvY1tMQha5KX5y7ltCrF39Fj8MxOAH8Lsskkoh79yrVG7iSow0FpqguF8vy?=
 =?us-ascii?Q?qzq2Cvcj4DC8zrxhTWnn6eLkWyXEedfbux+HUszMLdMKxidyKD81XgwD1OPP?=
 =?us-ascii?Q?bHWBDomFuypAZcufNMiHIo1SgXX4Rznmb8E2y+VmOEMuZWQufq28hK261Mtm?=
 =?us-ascii?Q?rU/pnQMsq+sVoXNTp3JjgR/Do+KCXW0eeUV+miBmFoCaN/pIaZjwdB/fIklV?=
 =?us-ascii?Q?e+ky0Xjh028ycCAnxv8oxH5aTVve1KagiZmyF5TQmYNMvOd0e+Brr06Ckdwr?=
 =?us-ascii?Q?m5v+0O8wkVBDJA8D1sJBH/q4nLPIlKuw3a+wYAtlyTLyGBkSSUvjvSDoVNAt?=
 =?us-ascii?Q?VOVQWiScN6NJVLN/1RfeOjsWJ1pjsLpAO1bZhTpPENWWsnSkuErGO2Usr9WU?=
 =?us-ascii?Q?oCW7MXUg+soPlKg5aImiPbsjgQ+PKBmLynFnCZYp6Ybir4aVONL06A7nSmmJ?=
 =?us-ascii?Q?8mOIG5Flf3xQWM/k4uBXPKuO3VVWI/I1g6K7tNCizV3/WUdQW2iyA9R6z1T6?=
 =?us-ascii?Q?7y1wk/100ChCcDVLt7Ri4xqNKqWpmtba1Axqi8r6rJbzodyB10pLsjmZH2RC?=
 =?us-ascii?Q?bu0EgBoO7e5Tp+fCDiyrL1U1ZNNbsSt2+9U5bDomdyh47t6/G5ht/640Vwk4?=
 =?us-ascii?Q?KYT3BFnWk4WpTD+EwxkkesWh1Vo0UcaAmQKOiVQ0vgbz79k3go1uolovD9C0?=
 =?us-ascii?Q?7bTBSP/3cXU+73kt2zyT4EnXK/MKaTP5Kg/euPlA4ncuxTrxIriIzZPcSU8u?=
 =?us-ascii?Q?zffmHknct5M4AIpxGNcE/sBDj3zavYPAomEK/1qG3rO8apmvvo5SRlYJVX3Z?=
 =?us-ascii?Q?8Jg6h5lOp2wmZT+U3IB0b2R+vd/DGvXVZ/kXdLgGWK+jsCbzbErn/RiUe7aV?=
 =?us-ascii?Q?3ZfqpDlKKIZh4AcEQM5lapq1BtXEMWk1N6Q38bsjXzshp80p7KoWLfYQvOjt?=
 =?us-ascii?Q?9Nptxu4hnlp5Xzldzl8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd3239f-7939-452e-d9a7-08db4dd456b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2023 01:50:58.5875 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ScUWfJOccowVdt6U1GAQ0IXYWuq/Bh+nfBxf9aM1ThslPyoxutOOgd9Lp9lt+FpI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7719
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
Cc: "Limonciello, Mario" <Mario.Limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

+Mario

I believe the comment below from Mario points the right direction to suppre=
ss the "UBSAN: invalid-load..." warnings.
https://gitlab.freedesktop.org/drm/amd/-/issues/2541#note_1898035
However, it might be not right to simply drop the line below since the adev=
->powerplay.pp_handle pointer is still needed for those APIs like amdgpu_dp=
m_read_sensor().
- adev->powerplay.pp_handle =3D adev;

BR
Evan
> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Friday, May 5, 2023 4:24 PM
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Quan, Evan
> <Evan.Quan@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>;
> Pan, Xinhui <Xinhui.Pan@amd.com>
> Cc: Chen, Guchun <Guchun.Chen@amd.com>
> Subject: [PATCH] drm/amd/pm: parse pp_handle under appropriate
> conditions
>=20
> amdgpu_dpm_is_overdrive_supported is a common API across all
> asics, so we should cast pp_handle into correct structure
> under different power frameworks.
>=20
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2541
> Fixes: ebfc253335af("drm/amd/pm: do not expose the smu_context
> structure used internally in power")
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index f0068df2d073..ae45abeab5b5 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -1455,13 +1455,15 @@ int
> amdgpu_dpm_get_smu_prv_buf_details(struct amdgpu_device *adev,
>=20
>  int amdgpu_dpm_is_overdrive_supported(struct amdgpu_device *adev)
>  {
> -	struct pp_hwmgr *hwmgr =3D adev->powerplay.pp_handle;
> -	struct smu_context *smu =3D adev->powerplay.pp_handle;
> -
> -	if ((is_support_sw_smu(adev) && smu->od_enabled) ||
> -	    (is_support_sw_smu(adev) && smu->is_apu) ||
> -		(!is_support_sw_smu(adev) && hwmgr->od_enabled))
> -		return true;
> +	if (is_support_sw_smu(adev)) {
> +		struct smu_context *smu =3D adev->powerplay.pp_handle;
> +		if (smu->od_enabled || smu->is_apu)
> +			return true;
> +	} else {
> +		struct pp_hwmgr *hwmgr =3D adev->powerplay.pp_handle;
> +		if (hwmgr->od_enabled)
> +			return true;
> +	}
>=20
>  	return false;
>  }
> --
> 2.25.1

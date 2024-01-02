Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 474DAC46CD2
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 08:54:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD19610E160;
	Tue,  2 Jan 2024 08:54:23 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8230910E127
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 08:54:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1jLoUqmw8HKXJuCcOTQAMOiLgx7tNw1Uzfgq8X0yBRF4tNuUFB+VEfOAt//TtVWMeO3/eOVJu9MzFMjiYCJO8TuPhMQG8kURqixFMG/WIfiCD/VGmzUCJPB9XCIu2/+1TsffFhvWWpWMfcLaxFi2f1ORT3orASAnpDonB8yP1ceeHlnHNVFWm7Arv7kvmMRxJ2NQnaNbEXNCSYYATs7pDJn5aGtIxd1mciu2oKMuaCJhvzWFSY+8K0SiOxsqRrGozrMg+3Gktf43AmjO2H/3b+DSs1zkFuy6OCzSI5zrnw+YFnggg1D+SctfqSwHNdc0pNZu6y/b+7vwm4MlqXJCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWTseepgMV3OLR2/+O0OGbJFVArZ585cZtIPl3r3L/w=;
 b=U+xdBZdej6NQ87xdHRo5G5gvfuFGt5P5tjJdjk3qXnwhVx5tPyY+HLFjWRqRFqK7EBkMLc5DuQr04wE2Df7EhrwolSoJ6J7GK/piLAIP9u2hV5lD5aYAvFsuKPl13XQt4yGq/TUKgpjElsY8ydTLk1PX8/Azwec2P0JJy4Wx1tdZYMA3XbzYEWGmCVhJnt5M4AalA/+m/t8zkS46lrY9LjVm5zljKDRZcCRynxVGUDADOX4Hi8wU4dKXexRJGF0TCuZF3n9LOLQFIjR8jjICzww9jz3LOJImCKjkR89aqSYTVyAbpY8RkDaATXLot6Ne5SpgzZZ9a6z0UXUGnEsSJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWTseepgMV3OLR2/+O0OGbJFVArZ585cZtIPl3r3L/w=;
 b=Mgp5euUuvm70H5qUyukH6t3X9oG/re7QWN9F22DtfldX+ozY9PMtzuIhNsRq4ndVMBSP3TKBFDiA1WBBkK/Z+WnESMkRE44TcCh1k1q4P8qF+YiqaZoWsuDkEcenyZ96wvrYbD1J43UPSOBqrOOolGtHYfTa//shR3zVrl0LrRk=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM4PR12MB5120.namprd12.prod.outlook.com (2603:10b6:5:393::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 08:54:17 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::7ee2:4db2:1828:ba83]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::7ee2:4db2:1828:ba83%4]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 08:54:17 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Chai, Thomas" <YiPeng.Chai@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH 2/3] drm/amdgpu: Query ras capablity from psp
Thread-Topic: [PATCH 2/3] drm/amdgpu: Query ras capablity from psp
Thread-Index: AQHaPS4QIi4Qa0f0FUmRRU1KzHjfMrDF++UAgAAEmHCAADY/AIAAARbA
Date: Tue, 2 Jan 2024 08:54:17 +0000
Message-ID: <BN9PR12MB5257945B0B4E39A4635F1CF0FC61A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240102034440.16376-1-Hawking.Zhang@amd.com>
 <20240102034440.16376-3-Hawking.Zhang@amd.com>
 <PH7PR12MB599727B1E79936287A6FD4F38261A@PH7PR12MB5997.namprd12.prod.outlook.com>
 <BN9PR12MB525740D2D819B6626AB2393CFC61A@BN9PR12MB5257.namprd12.prod.outlook.com>
 <PH7PR12MB87967060AC513D9C21E7B8CBB061A@PH7PR12MB8796.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB87967060AC513D9C21E7B8CBB061A@PH7PR12MB8796.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ceb12e59-4c5f-4e48-abfe-0ce66c0726ba;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-02T05:10:03Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM4PR12MB5120:EE_
x-ms-office365-filtering-correlation-id: 72ec02db-c7c2-4c54-f89e-08dc0b706733
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y0S9fjeerDsBSdKgI2XIbd6jpT+GNmqCp5O6rrm0hK1xYsXt8D0/YBUskPQ5Lh+Spsf2t/LNDWTyd/HW2fsFMDMXVpKNayMGWMX/rXMsXUlkznJIrZFZxCmZRzNbFx4zWzlADrOcfimX5E6BUA8NL+m1p8+fJJm3djrxtnFd50D2XuMb3r09rYMP1iymQ94EfPevbfTln2Xm25bP3feElyH/J38Ly1HTwt9sTmkjGhP6k2VFRbv1EuTaOb5B5jwAlUAaYNuUqF27kDy+bn7NpM0LXXRIWxlUw4QUl9q4YJpE+1aup6pS+ZoaPuN1gOJDTmB337nGr79HQ1hCin8glC8kDq6FhW3OqFUUi1ZJ4iGljmtvd3hYoXWBHdMB6w0bxMMsnMsc8WXbck/MDCESsRhRcCOW39DEdmIvFED7/r1Nkwcp3h6J6rbr3jCcPMbNfHHA7xIGFZD5RS6ToSb7i+98FAxsiRC5ypm2MmU/Fw87aThSJ0//zPk88augYHJE+YndYZ4PPzaAlgdcmt46UNobCwktLQUydrgw+0Y126KbF2myXF75702bLsSZ5qbqV894Pd6qExB5LG7w2DJNWCvsfyeNK7gG4uqKU7pIf+BWMVweRJM+DF9v7sUylfNRSqsu4TYi59X+3jOpEQgs/w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(136003)(366004)(39860400002)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(66946007)(64756008)(66476007)(66556008)(66446008)(76116006)(52536014)(4326008)(6636002)(110136005)(316002)(8676002)(8936002)(54906003)(26005)(71200400001)(83380400001)(478600001)(9686003)(53546011)(7696005)(2906002)(41300700001)(5660300002)(6506007)(33656002)(38070700009)(921011)(38100700002)(122000001)(86362001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ARnLlQUde6J9F4Ujvcl/26bya29FgOkqtNnLLE8bgU2ezMxofT08Vl39LQee?=
 =?us-ascii?Q?zJJT7wcJK27eO/ZgSd4GWm2hGsPpKtaThxkz3cBWPZXxLiQIh6Zeqo3WbcVp?=
 =?us-ascii?Q?2EY315CbsXW4ivmhDdA8LZtZITFZn0nrNzUEfKKEtKIl2eu213hNDV/qyXsF?=
 =?us-ascii?Q?OyCr0rCPjPKMTvKX4cNZ1d64BkoIv1dWtZ3DawZsm6DJ5ZxOq/QdEbpEhMoP?=
 =?us-ascii?Q?IwMndb3qKr3xolGucFVrnC6FRsgIadNk7xy2tOFhvoWekCexUuCBf5Q7Szfv?=
 =?us-ascii?Q?/sFyCQ9E/q+SrLRKqm0JCw9Dg3aeJF+Hq9zBtTdTZh8/pUXWvuOryeEImgcQ?=
 =?us-ascii?Q?oDm7m1qGEVPsb4veWHvkmgfr08XIbIfOet4AZgIcgzntPtLvpwpJ03iwVlRj?=
 =?us-ascii?Q?iURsP97g+1NzYoKRNnt+yYFZkR7dYfgUVrfuY4ZSgZx0aW0T9y1kHBs3uPrM?=
 =?us-ascii?Q?d34CkVLy5la9Bd328l8dJb4LH0fNxW6Fhyx2wC3mc3/4Qp5K/fJu0GULj2AA?=
 =?us-ascii?Q?tMmPdzq4K5FCECGRvxHuuCCLookjSOi+xzWvsztG20Fe5vHZX4VagKhXb50l?=
 =?us-ascii?Q?bg0BOcM8Kw/lSZXW62hHbhtu0It7it6szBSlLyVo+j40+Gb8Pe30OjEwjijv?=
 =?us-ascii?Q?9ob+pMjKKM1wSVtal+ck7vL/6JARagyzVppAdXstscPGWHLLhJ/tfmaKtSTk?=
 =?us-ascii?Q?N8xNmvF+KY1b76bNWhetswZhpw7VoP1veLWq/xKU/ZO341tZb1S2DAjQn8go?=
 =?us-ascii?Q?10AYy7mRVf5IYnXvBEUpCGexj/hDvlvnIW7cVMYeo6ETk+ml2bHxMhTYkMIb?=
 =?us-ascii?Q?59c4wtezMvdwo9ZxpTmKZReyldIX+UunurDZoQliDmLnS9D5anL/3SU/V/2r?=
 =?us-ascii?Q?5CwOlb1fSofj/NUqwakbXImgNcJisrTPdQWelYZFD12ZY2np/KFz+sXAZAec?=
 =?us-ascii?Q?paMve9xv8e4fLzCSTA1S9YsqGVE5i9uwHn9uTaVWVUJh2v3+gGVGAUS42HSK?=
 =?us-ascii?Q?6HACi0Cm79nsWyYSTYJ541q2m4chmd43UXW+3AEdVOKCNvqI2luj73Nwykw5?=
 =?us-ascii?Q?jOTthjS7hTJfLOlLP436l15YSomxq+WXaBUOukjEr74o7dUJs+QV3aC1sJCp?=
 =?us-ascii?Q?piSAyQps9+QV9OMaskiXSOFhspzwgrNep/LjFY0hjUnWFgObOPg4XE5NlW5p?=
 =?us-ascii?Q?9gyDslFPJTk4Dxb4/aKOS7+txF7tDcr+PBwzqOOejXslsgw93pCoB4gqbq9R?=
 =?us-ascii?Q?hEj4+8Iu3lSyTdj3caQhS1oj3thP0xbtSQe3LdUKFPU9CbwCqPtATx5ljbeR?=
 =?us-ascii?Q?+6cY+1cVwyakb8N5At54c+0ikmTl0NTvCYIg8Onl3W8IU2Ft9eni5cBRSndY?=
 =?us-ascii?Q?8BV2Dkq3+b2NR5bO6MWy8ov08zizwe+y7q9pvMk43GsBdQSpf7Sn+r68DyjN?=
 =?us-ascii?Q?m33yqWzBYfkdWCa3pXuPpW7Tnv+6lcBMW89TbsJ4pFj4DyFCGitou0f9YosX?=
 =?us-ascii?Q?glX5rtO9t/DvmedoIY4CCX0nBGXUdfx2SRWOG/81bo/Eh8dPQJvVVTp83HUA?=
 =?us-ascii?Q?kE6IvYSIIX38I8t4WZLtximq6FAHZTc7N3S5dqUT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ec02db-c7c2-4c54-f89e-08dc0b706733
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2024 08:54:17.4881 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o24mDZsGWdmFgmREC1r0YGVJfZ/HuyMBCE2wxvuYwvT6tO4KuEwBv8jtH/Af/4NRmrTcUftL9l2MeZLQJ7xVzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5120
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Oh, that's good point. I guess Kevin mentioned the same thing. Yes. Returni=
ng directly is reasonable to me.

Regards,
Hawking

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Tuesday, January 2, 2024 16:49
To: Zhang, Hawking <Hawking.Zhang@amd.com>; Wang, Yang(Kevin) <KevinYang.Wa=
ng@amd.com>; amd-gfx@lists.freedesktop.org; Yang, Stanley <Stanley.Yang@amd=
.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Li, Candice <Candice.Li@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar=
@amd.com>; Ma, Le <Le.Ma@amd.com>
Subject: RE: [PATCH 2/3] drm/amdgpu: Query ras capablity from psp

[AMD Official Use Only - General]

> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Tuesday, January 2, 2024 1:38 PM
> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-
> gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang,
> Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>;
> Li, Candice <Candice.Li@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo
> <Lijo.Lazar@amd.com>; Ma, Le <Le.Ma@amd.com>
> Subject: RE: [PATCH 2/3] drm/amdgpu: Query ras capablity from psp
>
> [AMD Official Use Only - General]
>
> The ret gives us a chance to fallback to legacy query approach (from vbio=
s).
>
>
> You might want to see patch #3 of the series for more details, go to
> the following lines in patch #3
>
> +       /* query ras capability from psp */
> +       if (amdgpu_psp_get_ras_capability(&adev->psp))
> +               goto init_ras_enabled_flag;
>
>
> Regards,
> Hawking
>
> -----Original Message-----
> From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Sent: Tuesday, January 2, 2024 13:19
> To: Zhang, Hawking <Hawking.Zhang@amd.com>;
> amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang,
> Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>;
> Li, Candice <Candice.Li@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Ma, Le
> <Le.Ma@amd.com>
> Subject: RE: [PATCH 2/3] drm/amdgpu: Query ras capablity from psp
>
> [AMD Official Use Only - General]
>
> -----Original Message-----
> From: Hawking Zhang <Hawking.Zhang@amd.com>
> Sent: Tuesday, January 2, 2024 11:45 AM
> To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>;
> Yang, Stanley <Stanley.Yang@amd.com>; Wang, Yang(Kevin)
> <KevinYang.Wang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Li,
> Candice <Candice.Li@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Ma, Le
> <Le.Ma@amd.com>
> Subject: [PATCH 2/3] drm/amdgpu: Query ras capablity from psp
>
> Instead of traditional atomfirmware interfaces for RAS capability,
> host driver can query ras capability from psp starting from psp v13_0_6.
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 13 +++++++++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  2 ++
> drivers/gpu/drm/amd/amdgpu/psp_v13_0.c  | 26 +++++++++++++++++++++++++
>  3 files changed, 41 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 94b536e3cada..8a3847d3041f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -2125,6 +2125,19 @@ int amdgpu_psp_wait_for_bootloader(struct
> amdgpu_device *adev)
>         return ret;
>  }
>
> +bool amdgpu_psp_get_ras_capability(struct psp_context *psp) {
> +       bool ret;
> +
> +       if (psp->funcs &&
> +           psp->funcs->get_ras_capability) {
> +               ret =3D psp->funcs->get_ras_capability(psp);
> +               return ret;

[Tao] I think the code can be simplified as:

return psp->funcs->get_ras_capability(psp);

and drop the ret variable.

> [kevin]:
> This variable 'ret' seems to have no other purpose, can we remove it
> and return directly ?
>
> Best Regards,
> Kevin
> +       } else {
> +               return false;
> +       }
> +}
> +
>  static int psp_hw_start(struct psp_context *psp)  {
>         struct amdgpu_device *adev =3D psp->adev; diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> index 09d1f8f72a9c..652b0a01854a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -134,6 +134,7 @@ struct psp_funcs {
>         int (*update_spirom)(struct psp_context *psp, uint64_t fw_pri_mc_=
addr);
>         int (*vbflash_stat)(struct psp_context *psp);
>         int (*fatal_error_recovery_quirk)(struct psp_context *psp);
> +       bool (*get_ras_capability)(struct psp_context *psp);
>  };
>
>  struct ta_funcs {
> @@ -537,4 +538,5 @@ int psp_spatial_partition(struct psp_context *psp,
> int mode);  int is_psp_fw_valid(struct psp_bin_desc bin);
>
>  int amdgpu_psp_wait_for_bootloader(struct amdgpu_device *adev);
> +bool amdgpu_psp_get_ras_capability(struct psp_context *psp);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> index 676bec2cc157..722b6066ce07 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> @@ -27,6 +27,7 @@
>  #include "amdgpu_ucode.h"
>  #include "soc15_common.h"
>  #include "psp_v13_0.h"
> +#include "amdgpu_ras.h"
>
>  #include "mp/mp_13_0_2_offset.h"
>  #include "mp/mp_13_0_2_sh_mask.h"
> @@ -770,6 +771,30 @@ static int
> psp_v13_0_fatal_error_recovery_quirk(struct
> psp_context *psp)
>         return 0;
>  }
>
> +static bool psp_v13_0_get_ras_capability(struct psp_context *psp) {
> +       struct amdgpu_device *adev =3D psp->adev;
> +       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
> +       u32 reg_data;
> +
> +       /* query ras cap should be done from host side */
> +       if (amdgpu_sriov_vf(adev))
> +               return false;
> +
> +       if (!con)
> +               return false;
> +
> +       if ((amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0=
, 6)) &&
> +           (!(adev->flags & AMD_IS_APU))) {
> +               reg_data =3D RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_127);
> +               adev->ras_hw_enabled =3D (reg_data & GENMASK_ULL(23, 0));
> +               con->poison_supported =3D ((reg_data & GENMASK_ULL(24, 24=
)) >> 24) ?
> true : false;
> +               return true;
> +       } else {
> +               return false;
> +       }
> +}
> +
>  static const struct psp_funcs psp_v13_0_funcs =3D {
>         .init_microcode =3D psp_v13_0_init_microcode,
>         .wait_for_bootloader =3D
> psp_v13_0_wait_for_bootloader_steady_state,
> @@ -792,6 +817,7 @@ static const struct psp_funcs psp_v13_0_funcs =3D {
>         .update_spirom =3D psp_v13_0_update_spirom,
>         .vbflash_stat =3D psp_v13_0_vbflash_status,
>         .fatal_error_recovery_quirk =3D
> psp_v13_0_fatal_error_recovery_quirk,
> +       .get_ras_capability =3D psp_v13_0_get_ras_capability,
>  };
>
>  void psp_v13_0_set_psp_funcs(struct psp_context *psp)
> --
> 2.17.1
>
>



Return-Path: <SRS0=EYW0=OM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92690C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 16:06:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DC1D61090
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 16:06:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4DC1D61090
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 003466EC2B;
	Wed, 22 Sep 2021 16:06:39 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E28E6EC2B
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Sep 2021 16:06:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blOvnWuxjPNkm0K1qCMXN7bdILAbMuIOrsWwgIe1yNVv0UqkLfq7rZ5HfDOfBGSKLcrvQjK5arvfT78GaHW9kVInGQe3dstTgYlXIVlx3GadqfKNLUvzrbsK5ZR2EdGDN+w+XbtK8mZdphQljUyVy39CQH1SgoeybCPiwwkbhrej3dNH7+Wr4tz833KSaATmaG3pO+EGHuSIlAnnjBz/Olnc2CRoVGlSR67QP2223pkrrF2EpfMUyw1daWWKLWqkCVwdI8mF45oggJ05nTzO8EdjkcVAO2r6/07lB1kxVNkDCrkcM79BXP/42MQtH5rR7JzdE0nE5dJpgFKQ7kg3gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=T55tges/TPuffBc2qGwyruweuiXtifGOISDs88hW8pY=;
 b=GuN6TpumCDnZeob1O/DbW1ei15weoGh0HcZuII1uHOg9Hdwwo/ZFbGbkWvrgpIJbu5Ypng5LlFPcbJfRGrLCIY18wYQAuX0/zuISZchbNARtq9pvF88ny1egdAHgxuCnMfnBhd67v62SWKysG9Z4NfzXGx+2XaVZ5BY++VtKaBvOjwWG1zAuECTkky0bFAPXa5WNiNBtkexddAt5vtUUrV9OKZlHoL6FUWOqvxdB7b6CLFMDvpwypkZICHTDiDugKgSIiFDerPfBlbqPnDsNbYCwnVQNtggS1l8l/VyxzbT4TVQLs1WLt4DEz68mxBCU1HykMSR3ylrpJnDbsNswsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T55tges/TPuffBc2qGwyruweuiXtifGOISDs88hW8pY=;
 b=bsA8OyXJeFHiXBV/ngC4au0tpeM/qIC5/aPTF9Z8Ly7JR0+BPC8EfhxbQfnACWN2rg5cPc9Pvi9ALqf9HK+fYvT8kYSw4U653cvYUKXoWz6amFwvQbU/OngjOlkGKiu6mW5Ny4x6Zn7Vj2omS+jgjWFkthxhm7n8KjXqA/OM6Hk=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Wed, 22 Sep
 2021 16:06:37 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::7140:d1a:e4:a16a]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::7140:d1a:e4:a16a%8]) with mapi id 15.20.4544.013; Wed, 22 Sep 2021
 16:06:37 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 46/66] drm/amdgpu/pm/amdgpu_smu: convert more IP version
 checking
Thread-Topic: [PATCH 46/66] drm/amdgpu/pm/amdgpu_smu: convert more IP version
 checking
Thread-Index: AQHXrxOfDiVcUnFAYUKvH/TEg18edquvti0AgACDQxY=
Date: Wed, 22 Sep 2021 16:06:37 +0000
Message-ID: <BL1PR12MB5144D96B76D54B5648935086F7A29@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
 <20210921180725.1985552-47-alexander.deucher@amd.com>
 <7fbaf500-dc08-df63-2483-115be7e543a2@amd.com>
In-Reply-To: <7fbaf500-dc08-df63-2483-115be7e543a2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-09-22T16:06:36.805Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: 0036870b-bc74-7a3f-ea9c-042c14243088
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c7e2127-8dad-4816-cb58-08d97de2f4dc
x-ms-traffictypediagnostic: BL1PR12MB5334:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB53344395CE86163E9F839151F7A29@BL1PR12MB5334.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:551;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VVQimurWElCQxx3xiQSuubtT+EnOOWjgh0oD3vX8cATpO4xwypVcD3viqiYhug3MmX7Fw0FYMPDQlUQ1ZgPKzcqwy0+P8KmWuu4YQC8xPJhoeFygzWLdhVHr94fd9R5aQwnuXAqv3Zowwjy4hEUa/pLmK+whMbEntEnQt13GN99B5d5bUkCe+iPqrq5K5FPp+fTEKwk93N1kzzEZQEfouvze/6Gpn2kYht8hVkzdy/F+PfHpZlc/dz7F/JO2EjtwjhEeY17k5eXeZAZPBATFKjLYMLR8buVVs5PRsdmTkQb8kBmWYpLU6fdXuKaXSP0aa4ZkVswLSg41DVilm4JCsikm8WpLuQCHBhsY3BCXelthzngjDXZhF2ab4xat1Cg2emIgZ9lOVsjf3S9jguSCCwh5MTwSiRHxv0x9GRg46CB7mCSCryFUMqCwJBltNFFsQeHM31GipBERLkscUbOXwF+f3L5xLiGBQ82a8Cc/VLqr4NmuuJczzMYnQQi/IwL9Mi5aJCZEjk/xuV+SkmNzCaVuWghqnMqjugKOrP1OaY35+AWroA8KFFGdY2htQmCmk+QgFbAiLMYdcZ4fIKvW15t4+569RAV8Owps6H7qxzMrkmkM++k+0DzAmqAUKQeq4L9nbiu6QQ6kdG4k3oskbtXgZreWjHawtrEwf8v8r0yY7mkopL5c9uCwlTBRiMHeo8hJ0RoxNqqBdx31RgAKTQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6506007)(53546011)(316002)(76116006)(2906002)(66446008)(66556008)(66946007)(66476007)(33656002)(110136005)(5660300002)(19627405001)(64756008)(8676002)(26005)(55016002)(508600001)(83380400001)(86362001)(38070700005)(52536014)(7696005)(71200400001)(8936002)(9686003)(38100700002)(122000001)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dWaAO76x6r2eO8ypLyr52FGeeQLfYinucIhkOR+VGjEERJiHfdXeYgX2YiGY?=
 =?us-ascii?Q?DrB3NNukyFWCtVl4Ydi0vPbxXhYmiwYuV4Biwk/XreIV4V2NHZx48hU4pM3v?=
 =?us-ascii?Q?mDrxin2tT0z2Ar/j8U4YHximcUcGemp8qUSvw6iunQW6tdFjR8ghQSG3pbMy?=
 =?us-ascii?Q?0TwFTzYs7+3eebnxrDkPZaNyyhS+bdieXdj9egb8FoXufwkeprnNpkjJIlIJ?=
 =?us-ascii?Q?+0ntmNaktKBdipR+Z4JIRuMVJBtXsHZJM3Uowd77I6uFmFl8Ika5izgN1bn+?=
 =?us-ascii?Q?P2rgqy14Q02g9nABBn/n/p0f9g5Xx/zP+djXFTJ/QKSh030yrgs8qVSHY7wb?=
 =?us-ascii?Q?0dLvzQhgtuJLIgeowzMQ70K7PiTZ438gphpYw7ZOBuaQaajzOti70xwgAQDf?=
 =?us-ascii?Q?SOf+Upo78UpjeWn0eiQJXQeRWdBRuZi8Xjf+7CxBXwUkyU0cIwfBdZZ76b6m?=
 =?us-ascii?Q?E0RnAJiBVm3sopCLl7G6y5BBj++GfOKUHkR5iDJVKo/AkDk7EUAfcgVKPJbI?=
 =?us-ascii?Q?wAULYOjoMaC8TbsnxYdFa2RlxbcUr0nMtz17fl6zJrCxb2omqhPt4Z0ZBeO4?=
 =?us-ascii?Q?hr+rFiC39C83ACYfK1749lbdkGzqrml+hxtcWCl5cFBmpiKMFwXM+Zq/NKUK?=
 =?us-ascii?Q?Tg9nPvq5HSjmINRkhOE8r6Y7mvjZqZF6iK3SyQaW+F8/M7SHjUXEiFo8Ue1p?=
 =?us-ascii?Q?MmpjcLjPDckK0c5z/6bEbhXR1At7FXZ02ZOKCJWZtWvw/HQ07oh38r+Og+go?=
 =?us-ascii?Q?MTnGG+baYv8hFadayyVLMRYkr9P2Kau707Y+C2JrEnG+jxRpv3o6VljYlhmr?=
 =?us-ascii?Q?1STjI76dbWnD9Gbm0d/MkBuAb3z9w978GFwoAhcwu8Ppt6JEdeIcjJPvdPZO?=
 =?us-ascii?Q?xkPdUknyB+yBWu4uHPA51IkbDcPZTis0T8WF5sp5Egu73wcSFsEM/NHbmmMB?=
 =?us-ascii?Q?A8R6XXxZuIGtnX6RgNEpo9372cHPFfsFu4GcWsyZZWvhd0sBU6e4OGQ3Ie+s?=
 =?us-ascii?Q?Gdv7igqri96eBFJZfVJy3zBMDcgLILlTzUU6+LcaB0AuD1hE7/HhBxM/p0+f?=
 =?us-ascii?Q?YK9xT6Mx7Qh6zJGVjTmqv3MBU0JXVTgJuMHB1IID1uECuLqJ8eKzg7lxn5SH?=
 =?us-ascii?Q?m4vFRbSvyW04vJU1d/mIkC0gGHj+9HLRYNgTN9Eu5schzLgdqzRgzOs1ve0y?=
 =?us-ascii?Q?Nz0OSBJ0+2UPE5hs2prDGoF8LYLuZ6VcUki5R16a4EgvARTwaPrpL7NpK4A0?=
 =?us-ascii?Q?eoQNbEbQUf5oKfctDtic3ZPqUre16aNB0t33Pl03jJCh+JyzU5mxZmicd9tQ?=
 =?us-ascii?Q?I1Y/acbe1BqDi0Ov7uhW3iQt?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144D96B76D54B5648935086F7A29BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c7e2127-8dad-4816-cb58-08d97de2f4dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 16:06:37.3289 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QOt80N/izI2+XX46J5+CCGzOOmE7cL87/IIOnh221O3SSJ1UNz99ogQYAXgXS6xSPFG1n0q6F1n84s+654849Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5334
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144D96B76D54B5648935086F7A29BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Fixed locally.
________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, September 22, 2021 4:16 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedeskt=
op.org <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 46/66] drm/amdgpu/pm/amdgpu_smu: convert more IP versio=
n checking



On 9/21/2021 11:37 PM, Alex Deucher wrote:
> Use IP versions rather than asic_type to differentiate
> IP version specific features.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 41 ++++++++++-------------
>   1 file changed, 18 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/=
amd/pm/swsmu/amdgpu_smu.c
> index 5f372d353d9d..150cac4ea75c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -455,8 +455,7 @@ static int smu_get_power_num_states(void *handle,
>
>   bool is_support_sw_smu(struct amdgpu_device *adev)
>   {
> -     if ((adev->asic_type >=3D CHIP_ARCTURUS) ||
> -         (adev->ip_versions[MP1_HWIP] >=3D IP_VERSION(11, 0, 0)))
> +     if (adev->ip_versions[MP1_HWIP] >=3D IP_VERSION(11, 0, 0))
>                return true;
>
>        return false;
> @@ -600,23 +599,19 @@ static int smu_set_funcs(struct amdgpu_device *adev=
)
>        case IP_VERSION(11, 0, 8):
>                cyan_skillfish_set_ppt_funcs(smu);
>                break;
> -     default:
> -             switch (adev->asic_type) {
> -             case CHIP_ARCTURUS:
> -                     adev->pm.pp_feature &=3D ~PP_GFXOFF_MASK;
> -                     arcturus_set_ppt_funcs(smu);
> -                     /* OD is not supported on Arcturus */
> -                     smu->od_enabled =3Dfalse;
> -                     break;
> -             case CHIP_ALDEBARAN:
> -                     aldebaran_set_ppt_funcs(smu);
> -                     /* Enable pp_od_clk_voltage node */
> -                     smu->od_enabled =3D true;
> -                     break;
> -             default:
> -                     return -EINVAL;
> -             }
> +     case IP_VERSION(11, 0, 2):
> +             adev->pm.pp_feature &=3D ~PP_GFXOFF_MASK;
> +             arcturus_set_ppt_funcs(smu);
> +             /* OD is not supported on Arcturus */
> +             smu->od_enabled =3Dfalse;
> +             break;
> +     case IP_VERSION(13, 0, 2):
> +             aldebaran_set_ppt_funcs(smu);
> +             /* Enable pp_od_clk_voltage node */
> +             smu->od_enabled =3D true;
>                break;
> +     default:
> +             return -EINVAL;
>        }
>
>        return 0;
> @@ -2288,11 +2283,11 @@ int smu_get_power_limit(void *handle,
>        } else {
>                switch (limit_level) {
>                case SMU_PPT_LIMIT_CURRENT:
> -                     if ((smu->adev->asic_type =3D=3D CHIP_ALDEBARAN) ||
> -                          (adev->ip_versions[MP1_HWIP] =3D=3D IP_VERSION=
(11, 0, 7)) ||
> -                          (adev->ip_versions[MP1_HWIP] =3D=3D IP_VERSION=
(11, 0, 11)) ||
> -                          (adev->ip_versions[MP1_HWIP] =3D=3D IP_VERSION=
(11, 0, 12)) ||
> -                          (adev->ip_versions[MP1_HWIP] =3D=3D IP_VERSION=
(11, 0, 13)))
> +                     if ((adev->ip_versions[MP1_HWIP] =3D=3D IP_VERSION(=
13, 0, 2)) ||
> +                         (adev->ip_versions[MP1_HWIP] =3D=3D IP_VERSION(=
11, 0, 7)) ||
> +                         (adev->ip_versions[MP1_HWIP] =3D=3D IP_VERSION(=
11, 0, 11)) ||
> +                         (adev->ip_versions[MP1_HWIP] =3D=3D IP_VERSION(=
11, 0, 12)) ||
> +                         (adev->ip_versions[MP1_HWIP] =3D=3D IP_VERSION(=
11, 0, 13)))

Maybe seen/commented before, anyway switch...case

Thanks,
Lijo

>                                ret =3D smu_get_asic_power_limits(smu,
>                                                                &smu->curr=
ent_power_limit,
>                                                                NULL,
>

--_000_BL1PR12MB5144D96B76D54B5648935086F7A29BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Fixed locally.<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Wednesday, September 22, 2021 4:16 AM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; amd-gfx@li=
sts.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH 46/66] drm/amdgpu/pm/amdgpu_smu: convert more IP=
 version checking</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
<br>
On 9/21/2021 11:37 PM, Alex Deucher wrote:<br>
&gt; Use IP versions rather than asic_type to differentiate<br>
&gt; IP version specific features.<br>
&gt; <br>
&gt; Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 41 ++++++++++-=
------------<br>
&gt;&nbsp;&nbsp; 1 file changed, 18 insertions(+), 23 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/d=
rm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; index 5f372d353d9d..150cac4ea75c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; @@ -455,8 +455,7 @@ static int smu_get_power_num_states(void *handle,<=
br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; bool is_support_sw_smu(struct amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;asic_type &gt;=3D CHIP_ARCTURU=
S) ||<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_version=
s[MP1_HWIP] &gt;=3D IP_VERSION(11, 0, 0)))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[MP1_HWIP] &gt;=3D I=
P_VERSION(11, 0, 0))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return true;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&gt; @@ -600,23 +599,19 @@ static int smu_set_funcs(struct amdgpu_device *a=
dev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 8):<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; cyan_skillfish_set_ppt_funcs(smu);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; switch (adev-&gt;asic_type) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case CHIP_ARCTURUS:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.pp_feature =
&amp;=3D ~PP_GFXOFF_MASK;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arcturus_set_ppt_funcs(=
smu);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* OD is not supported =
on Arcturus */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;od_enabled =3Df=
alse;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case CHIP_ALDEBARAN:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aldebaran_set_ppt_funcs=
(smu);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Enable pp_od_clk_vol=
tage node */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;od_enabled =3D =
true;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; default:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 2):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;pm.pp_feature &amp;=3D ~PP_GFXOFF_MASK;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; arcturus_set_ppt_funcs(smu);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* OD is not supported on Arcturus */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; smu-&gt;od_enabled =3Dfalse;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 2):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; aldebaran_set_ppt_funcs(smu);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* Enable pp_od_clk_voltage node */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; smu-&gt;od_enabled =3D true;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return -EINVAL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; @@ -2288,11 +2283,11 @@ int smu_get_power_limit(void *handle,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; switch (limit_level) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; case SMU_PPT_LIMIT_CURRENT:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((smu-&gt;adev-&gt;a=
sic_type =3D=3D CHIP_ALDEBARAN) ||<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; (adev-&gt;ip_versions[MP1_HWIP] =3D=3D IP_VERSION(11, 0, 7)) ||<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; (adev-&gt;ip_versions[MP1_HWIP] =3D=3D IP_VERSION(11, 0, 11)) ||<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; (adev-&gt;ip_versions[MP1_HWIP] =3D=3D IP_VERSION(11, 0, 12)) ||<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; (adev-&gt;ip_versions[MP1_HWIP] =3D=3D IP_VERSION(11, 0, 13)))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;ip_versio=
ns[MP1_HWIP] =3D=3D IP_VERSION(13, 0, 2)) ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 (adev-&gt;ip_versions[MP1_HWIP] =3D=3D IP_VERSION(11, 0, 7)) ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 (adev-&gt;ip_versions[MP1_HWIP] =3D=3D IP_VERSION(11, 0, 11)) ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 (adev-&gt;ip_versions[MP1_HWIP] =3D=3D IP_VERSION(11, 0, 12)) ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 (adev-&gt;ip_versions[MP1_HWIP] =3D=3D IP_VERSION(11, 0, 13)))<br>
<br>
Maybe seen/commented before, anyway switch...case<br>
<br>
Thanks,<br>
Lijo<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_get_asic_power_limits(=
smu,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; &amp;smu-&gt;current_power_limit,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; NULL,<br>
&gt; <br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144D96B76D54B5648935086F7A29BL1PR12MB5144namp_--

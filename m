Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC838C4706F
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 03:17:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70E6B10E302;
	Thu,  4 Jan 2024 03:17:11 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 729C910E302
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 03:17:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbG7tvlygQybsgvk5ss7nEVi58AJ5eVS1jtxe08LcIZH+wsG1nIlaqv0KPzC4dZBgMb6cvBvVePmiTmaK858b1xm5PA1at+lBTaqorVPpP0H0G0iXhKq58WkOZt/M8yeySKBqO8YuuJKFcXG0hloVBBWQQ5BKJZ23vqyg6ZEOqNptOZb1ofSjsqsAjuSNM7UTsIg30Rl4KuyjjXOAlbs455aLApuJNZcg/lW6I0LfFCSFbjv03g1hT9HKsJgVHkv6wyy0G46A/AoVHa/So8AymcR+ODmvxpIXIcp5/JJwq1I3E+2A9PReJolx880hvPUE0Ll2Jj1oh42psvPhCGPHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twN5sRo2I32kzbNKTssF/SrzopBrB2K35eNMgJn4CzE=;
 b=EqVnZaqNOQLrn8Fjx+DqszzAL0//uxYRHve+FwyZB5EK8GuBCk0yV5GV6ObK5Iu9lAMA7QxcQ0+Np6JseAVbuceLhBAOQb7QdxfIfyqNH4AsLmlZH88zwVkMRaOgcrB8rzcterFM6CGhIOPdWTcR9W2WTT5k34uzmX5XGUIZ9UUrYNlQPSpQyq00HaYJ7hP910ddN50F/Rz4dwsc6mxihqKkcadZjznGO4ijjcnVfJwSqMdLb/nniuspD0oHBXl0q5i4wKLEPBzHZ+SpujGYkhnXWsIE9W4vhFkzAq9yfNpirEaItP24VT7QG5ttGOA8cec/upOwSmEvLqS/vGwFkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twN5sRo2I32kzbNKTssF/SrzopBrB2K35eNMgJn4CzE=;
 b=BrNdYmQGA//Uw64InfjSeJl/bLiWAqLICkHI+QnPAhKlg3vT9sL9ZqwlaKnxJwKjSRPLnovZsuiJQc0fxK50M/0FBrW4rLBgPon3ueY0H2mZlLIUV4tNlGsloIRAOi5WGOclYiHbSHFCWwc7TzLWtXbcDEhdXKeYQaLeezHEDiY=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by MN6PR12MB8590.namprd12.prod.outlook.com (2603:10b6:208:47c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Thu, 4 Jan
 2024 03:17:04 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::5866:efa0:7f40:cd66]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::5866:efa0:7f40:cd66%3]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 03:17:04 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 05/14] drm/amdgpu: add amdgpu ras aca query interface
Thread-Topic: [PATCH 05/14] drm/amdgpu: add amdgpu ras aca query interface
Thread-Index: AQHaPhtmYXRam56lfUK6f4jF9lfzQbDH/JWAgAD9g/A=
Date: Thu, 4 Jan 2024 03:17:04 +0000
Message-ID: <PH7PR12MB8796E82ED7F286B8A6E0A789B067A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240103080220.2815115-1-kevinyang.wang@amd.com>
 <20240103080220.2815115-6-kevinyang.wang@amd.com>
 <BN9PR12MB5257E7AB112DEF6062FF7769FC60A@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5257E7AB112DEF6062FF7769FC60A@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=fdcc984b-5deb-45cf-8a74-8368334f15fc;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-03T11:56:13Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|MN6PR12MB8590:EE_
x-ms-office365-filtering-correlation-id: 6d19818a-254f-49b7-fa55-08dc0cd3a02c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BEzrLVyyG6gaE9E62D28q5qsTftKLnjyBTgxYWrcCYrAceEvZ/xqxXOzHC1IlSC1sE8AXsPAx7ThDN/Kktm45q3QddxAK3RDt2zmbWCpIJHP58YkNdMiQI6+8v1qA12QssXia8FortRhOt0xmRL8IUbeOlywB1gDgJ5oyaibLQnJF5ahKrVt9etJ4f0KIyhTCSl+XKuAIhQ4KKmuLMLjOJFEjBDZNv5jbmnJAnCZtutPzpYJ+7IPIpQ03WBfkmowJJVrkkqRvmYCdTChso/6n7DdyP452GGD54YWWjgIZkneHo+P24CZNXyYYfA6IFlj8BvKfD/xKpp7d5TBmxevCZIuxFekmT9jVzMlrI1GilR53sGLRHOD9daXCufJFikGul/vIxl1RecTMnX9Ifw0dFIhpuKrTgmympcQl8MEdFozyO8DBmLeWBYRlaNgg0Es/OADR5/L9dxP14ZHGtCHaVtWXi7wFeC21ZFXBqkq2kjjeU/r94lgBo2X6t9S4r6O46vqKb3WuvYTuHfOqzPeSAe4QpzsTllbeqBVYyyTO6QCGykGBFPphcsscuodCejwy6XqHhzYf9OW6CqHk5anUbIyIIlYQeZEnzG4i67d6VEnZ500NheDAYhh2i7eyGa5
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(136003)(376002)(366004)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(6506007)(9686003)(7696005)(86362001)(38070700009)(71200400001)(55016003)(53546011)(478600001)(26005)(66946007)(64756008)(83380400001)(76116006)(66446008)(110136005)(66476007)(66556008)(316002)(4326008)(52536014)(8936002)(8676002)(33656002)(2906002)(38100700002)(41300700001)(5660300002)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ygjce2K4SVlYhk0tLAzpVDSMoIjxRdikWQ53/pdBXDl2Qp9ShLEf6LDwOHVj?=
 =?us-ascii?Q?ucBszuzTnvcCx8NbNt9mG5kdLUeRwgBPnG221eNSOSV9j8HW6fggawXdkMeB?=
 =?us-ascii?Q?yFmrVw8EPGuUxHfDRDSkdTEYqnerkpm1BpbV4z+NClRaotkgWQ7TMuaeLTtU?=
 =?us-ascii?Q?gMIgpP1A0w56WA+R0RkGYuKwxel+URR7t0LO94KyqnExya7Ax1x3Nv1Vdazf?=
 =?us-ascii?Q?mo2RErzZ2L3/LenZyL+eEOUK0cn46ve6BzWyxQSxXhw/2xiyfP3IsE7LqRVA?=
 =?us-ascii?Q?g++aoK7+ug49iyrV0qAYs9ZUYOc3Q8VYjw5Gz6geqt/zCE7UkEpNgi/Da7Iq?=
 =?us-ascii?Q?lpC5pbF5KqYVctrB9YdTBg7MiAXqS5Tr1g1ridAr8bQvjnCXDU2EtXFWCh7+?=
 =?us-ascii?Q?VFMCAahz4mIvGsdUV26eE/KgCvLgxzUm1YqySfP7NX7Hf1yOB8EZs05WnM+r?=
 =?us-ascii?Q?hIYBeCEKuRN4zKgtvjWZEQ39JZqx9Fmf6Flgr2OTy9sT7GE1TCAyjYHvcGiF?=
 =?us-ascii?Q?sR9BCawCgkK363a1K2utL9cj7dSfOYZpKS0MTvFfhnyqjxng+ChJUCfuuA3v?=
 =?us-ascii?Q?vbnZQ+1WJJBS5vb2O16KXW5z852TavgzUrdoN1kJbw1S6D6fwKCjcAKa66lE?=
 =?us-ascii?Q?XTX5H118ON8HqoTuOf6WeOemasLG9+XmyUibY/t26y1Q8uwIc+WN1GsvTywH?=
 =?us-ascii?Q?+6UXHhPftrXsWYcn1+glxlm+ztekstZcHGRBuSDzGzcxKXD/aMx8DoH1NnUH?=
 =?us-ascii?Q?+Dcy0HUTQP7nR1C5pNZ/e9JgYn5dyxz0zNPjaxJL2+VVRyDhFw30H9OKOHaC?=
 =?us-ascii?Q?ODaFUIg/NXoEV0oRHKboSMHEj17d/5sgtYFXqei18u5+uRFlk9yo7DtXgQvi?=
 =?us-ascii?Q?fAvPaNGcSV6oYyqF/ef2nnfeO2Mc7imKDbG3t489zhgQSMoiKJsohq5xr8qp?=
 =?us-ascii?Q?LXpIdmt3rveujTIO15fjdODiEppCaJFvVFvMcYLEzAw8o83WM26/Tjcqzatq?=
 =?us-ascii?Q?OsiteIeOKSkMBckBShZ2TCfpTHYlQeGm2Gf0Wngq2YTrSKM3G3qyAdY7FZD+?=
 =?us-ascii?Q?JnlndNf2T72fbgpq/e7aIP6LCEfk4xeqn2GhZNypbehP9HLsaDk6dpWOTnJq?=
 =?us-ascii?Q?aaWmR1inZX3EvgyDFcOWiO+RuM3ra9euzXzsS1Fapzup6g4hpWMSdEJE3Wbn?=
 =?us-ascii?Q?/zMJjXhW2VkFYKjeRWFv1iIvl5gi9XEjF3hGlyOTIzSI9cVJTzyBFGY0LkFb?=
 =?us-ascii?Q?QuJrS+p5UcEW/+gtKGEladlwo631XZA45IEVJJb4FnG5XbBzTgXc2A8ztWuu?=
 =?us-ascii?Q?qwVG4oQSUU3qoQBKhz56146tLlOoAbLVIUjNiYNMZSYwU1R5dK3ALcfCtt0m?=
 =?us-ascii?Q?651OS9i+vYaWJdvcHVJLHT/XN/2P0btQiAfpLuxRyWP7ILBTwj0605zrleiG?=
 =?us-ascii?Q?EX3DXlLgnijSoBZPJCT9TYcYxdRh7O3yhNNVv3SYrOuJNWKgm6RKzU8I+tKI?=
 =?us-ascii?Q?OllF27OKVFtv1NZKy0aefHzBC5gmvPW8MjHsBkPpIb5OLPQlQ4NBnFkmc5dJ?=
 =?us-ascii?Q?Pa2GZOpnwrUmMlD5XtQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d19818a-254f-49b7-fa55-08dc0cd3a02c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 03:17:04.4463 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iixNJTtttkPh17tPfoWPhlWhMojJWTTppRDH3X6dRCh7MmO2R5GSPsA8NQupOx9x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8590
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
Cc: "Chai, Thomas" <YiPeng.Chai@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

We check debug mode to decide which path is selected currently. The legacy =
path is still needed even ACA framework is supported (if debug mode is enab=
led).

"it should help us to differentiate aca from legacy ras when implementing o=
ther features", is there a scenario where the aca flag is a must?

Regards,
Tao

> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Wednesday, January 3, 2024 8:00 PM
> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: RE: [PATCH 05/14] drm/amdgpu: add amdgpu ras aca query interface
>
> [AMD Official Use Only - General]
>
> I assume we are leveraging error_query_mode to differentiate aca path fro=
m
> legacy ras path, right?
>
> But given in-band error reporting is just the start of transition from le=
gacy ras to
> aca, do we need a flag in amdgpu_aca to indicate whether aca is supported=
 or
> not? Accordingly, we can initialize the flag in amdgpu_ras_check_supporte=
d. it
> should help us to differentiate aca from legacy ras when implementing oth=
er
> features, thoughts?
>
> Regards,
> Hawking
>
> -----Original Message-----
> From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Sent: Wednesday, January 3, 2024 16:02
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Wang,
> Yang(Kevin) <KevinYang.Wang@amd.com>
> Subject: [PATCH 05/14] drm/amdgpu: add amdgpu ras aca query interface
>
> use new ACA error query interface to instead of legacy MCA query.
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 88 ++++++++++++++++++++-----
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 12 +++-
>  2 files changed, 79 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 038bd1b17cef..bbae41f86e00 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1168,6 +1168,53 @@ static void
> amdgpu_rasmgr_error_data_statistic_update(struct ras_manager *obj, s
>         }
>  }
>
> +static struct ras_manager *get_ras_manager(struct amdgpu_device *adev,
> +enum amdgpu_ras_block blk) {
> +       struct ras_common_if head;
> +
> +       memset(&head, 0, sizeof(head));
> +       head.block =3D blk;
> +
> +       return amdgpu_ras_find_obj(adev, &head); }
> +
> +int amdgpu_ras_bind_aca(struct amdgpu_device *adev, enum
> amdgpu_ras_block blk,
> +                       const struct aca_info *aca_info, void *data) {
> +       struct ras_manager *obj;
> +
> +       obj =3D get_ras_manager(adev, blk);
> +       if (!obj)
> +               return -EINVAL;
> +
> +       return amdgpu_aca_add_handle(adev, &obj->aca_handle,
> +ras_block_str(blk), aca_info, data); }
> +
> +int amdgpu_ras_unbind_aca(struct amdgpu_device *adev, enum
> +amdgpu_ras_block blk) {
> +       struct ras_manager *obj;
> +
> +       obj =3D get_ras_manager(adev, blk);
> +       if (!obj)
> +               return -EINVAL;
> +
> +       amdgpu_aca_remove_handle(&obj->aca_handle);
> +
> +       return 0;
> +}
> +
> +static int amdgpu_aca_log_ras_error_data(struct amdgpu_device *adev, enu=
m
> amdgpu_ras_block blk,
> +                                        enum aca_error_type type, struct=
 ras_err_data *err_data)
> {
> +       struct ras_manager *obj;
> +
> +       obj =3D get_ras_manager(adev, blk);
> +       if (!obj)
> +               return -EINVAL;
> +
> +       return amdgpu_aca_get_error_data(adev, &obj->aca_handle, type,
> +err_data); }
> +
>  static int amdgpu_ras_query_error_status_helper(struct amdgpu_device *ad=
ev,
>                                                 struct ras_query_if *info=
,
>                                                 struct ras_err_data *err_=
data, @@ -1175,6 +1222,7
> @@ static int amdgpu_ras_query_error_status_helper(struct amdgpu_device
> *adev,  {
>         enum amdgpu_ras_block blk =3D info ? info->head.block :
> AMDGPU_RAS_BLOCK_COUNT;
>         struct amdgpu_ras_block_object *block_obj =3D NULL;
> +       int ret;
>
>         if (blk =3D=3D AMDGPU_RAS_BLOCK_COUNT)
>                 return -EINVAL;
> @@ -1204,9 +1252,13 @@ static int
> amdgpu_ras_query_error_status_helper(struct amdgpu_device *adev,
>                         }
>                 }
>         } else {
> -               /* FIXME: add code to check return value later */
> -               amdgpu_mca_smu_log_ras_error(adev, blk,
> AMDGPU_MCA_ERROR_TYPE_UE, err_data);
> -               amdgpu_mca_smu_log_ras_error(adev, blk,
> AMDGPU_MCA_ERROR_TYPE_CE, err_data);
> +               ret =3D amdgpu_aca_log_ras_error_data(adev, blk,
> ACA_ERROR_TYPE_UE, err_data);
> +               if (ret)
> +                       return ret;
> +
> +               ret =3D amdgpu_aca_log_ras_error_data(adev, blk,
> ACA_ERROR_TYPE_CE, err_data);
> +               if (ret)
> +                       return ret;
>         }
>
>         return 0;
> @@ -1254,7 +1306,7 @@ int amdgpu_ras_reset_error_count(struct
> amdgpu_device *adev,  {
>         struct amdgpu_ras_block_object *block_obj =3D
> amdgpu_ras_get_ras_block(adev, block, 0);
>         struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
> -       const struct amdgpu_mca_smu_funcs *mca_funcs =3D adev->mca.mca_fu=
ncs;
> +       const struct aca_smu_funcs *smu_funcs =3D adev->aca.smu_funcs;
>         struct amdgpu_hive_info *hive;
>         int hive_ras_recovery =3D 0;
>
> @@ -1265,7 +1317,7 @@ int amdgpu_ras_reset_error_count(struct
> amdgpu_device *adev,
>         }
>
>         if (!amdgpu_ras_is_supported(adev, block) ||
> -           !amdgpu_ras_get_mca_debug_mode(adev))
> +           !amdgpu_ras_get_aca_debug_mode(adev))
>                 return -EOPNOTSUPP;
>
>         hive =3D amdgpu_get_xgmi_hive(adev); @@ -1277,7 +1329,7 @@ int
> amdgpu_ras_reset_error_count(struct amdgpu_device *adev,
>         /* skip ras error reset in gpu reset */
>         if ((amdgpu_in_reset(adev) || atomic_read(&ras->in_recovery) ||
>             hive_ras_recovery) &&
> -           mca_funcs && mca_funcs->mca_set_debug_mode)
> +           smu_funcs && smu_funcs->set_debug_mode)
>                 return -EOPNOTSUPP;
>
>         if (block_obj->hw_ops->reset_ras_error_count)
> @@ -1773,7 +1825,7 @@ void amdgpu_ras_debugfs_create_all(struct
> amdgpu_device *adev)
>                 }
>         }
>
> -       amdgpu_mca_smu_debugfs_init(adev, dir);
> +       amdgpu_aca_smu_debugfs_init(adev, dir);
>  }
>
>  /* debugfs end */
> @@ -3138,8 +3190,8 @@ int amdgpu_ras_late_init(struct amdgpu_device
> *adev)
>         if (amdgpu_sriov_vf(adev))
>                 return 0;
>
> -       /* enable MCA debug on APU device */
> -       amdgpu_ras_set_mca_debug_mode(adev, !!(adev->flags & AMD_IS_APU))=
;
> +       /* enable ACA debug on APU device */
> +       amdgpu_ras_set_aca_debug_mode(adev, !!(adev->flags &
> + AMD_IS_APU));
>
>         list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
>                 if (!node->ras_obj) {
> @@ -3422,7 +3474,7 @@ int amdgpu_ras_set_mca_debug_mode(struct
> amdgpu_device *adev, bool enable)
>         if (con) {
>                 ret =3D amdgpu_mca_smu_set_debug_mode(adev, enable);
>                 if (!ret)
> -                       con->is_mca_debug_mode =3D enable;
> +                       con->is_aca_debug_mode =3D enable;
>         }
>
>         return ret;
> @@ -3436,22 +3488,22 @@ int amdgpu_ras_set_aca_debug_mode(struct
> amdgpu_device *adev, bool enable)
>         if (con) {
>                 ret =3D amdgpu_aca_smu_set_debug_mode(adev, enable);
>                 if (!ret)
> -                       con->is_mca_debug_mode =3D enable;
> +                       con->is_aca_debug_mode =3D enable;
>         }
>
>         return ret;
>  }
>
> -bool amdgpu_ras_get_mca_debug_mode(struct amdgpu_device *adev)
> +bool amdgpu_ras_get_aca_debug_mode(struct amdgpu_device *adev)
>  {
>         struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
> -       const struct amdgpu_mca_smu_funcs *mca_funcs =3D adev->mca.mca_fu=
ncs;
> +       const struct aca_smu_funcs *smu_funcs =3D adev->aca.smu_funcs;
>
>         if (!con)
>                 return false;
>
> -       if (mca_funcs && mca_funcs->mca_set_debug_mode)
> -               return con->is_mca_debug_mode;
> +       if (smu_funcs && smu_funcs->set_debug_mode)
> +               return con->is_aca_debug_mode;
>         else
>                 return true;
>  }
> @@ -3460,16 +3512,16 @@ bool amdgpu_ras_get_error_query_mode(struct
> amdgpu_device *adev,
>                                      unsigned int *error_query_mode)  {
>         struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
> -       const struct amdgpu_mca_smu_funcs *mca_funcs =3D adev->mca.mca_fu=
ncs;
> +       const struct aca_smu_funcs *smu_funcs =3D adev->aca.smu_funcs;
>
>         if (!con) {
>                 *error_query_mode =3D AMDGPU_RAS_INVALID_ERROR_QUERY;
>                 return false;
>         }
>
> -       if (mca_funcs && mca_funcs->mca_set_debug_mode)
> +       if (smu_funcs && smu_funcs->set_debug_mode)
>                 *error_query_mode =3D
> -                       (con->is_mca_debug_mode) ?
> AMDGPU_RAS_DIRECT_ERROR_QUERY :
> AMDGPU_RAS_FIRMWARE_ERROR_QUERY;
> +                       (con->is_aca_debug_mode) ?
> AMDGPU_RAS_DIRECT_ERROR_QUERY :
> +AMDGPU_RAS_FIRMWARE_ERROR_QUERY;
>         else
>                 *error_query_mode =3D AMDGPU_RAS_DIRECT_ERROR_QUERY;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 408e21c3cc88..2afac9aa381a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -442,7 +442,7 @@ struct amdgpu_ras {
>         /* Indicates smu whether need update bad channel info */
>         bool update_channel_flag;
>         /* Record status of smu mca debug mode */
> -       bool is_mca_debug_mode;
> +       bool is_aca_debug_mode;
>
>         /* Record special requirements of gpu reset caller */
>         uint32_t  gpu_reset_flags;
> @@ -530,6 +530,8 @@ struct ras_manager {
>         struct ras_ih_data ih_data;
>
>         struct ras_err_data err_data;
> +
> +       struct aca_handle aca_handle;
>  };
>
>  struct ras_badpage {
> @@ -781,9 +783,9 @@ struct amdgpu_ras* amdgpu_ras_get_context(struct
> amdgpu_device *adev);
>
>  int amdgpu_ras_set_context(struct amdgpu_device *adev, struct amdgpu_ras
> *ras_con);
>
> -int amdgpu_ras_set_aca_debug_mode(struct amdgpu_device *adev, bool
> enable);  int amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev,
> bool enable); -bool amdgpu_ras_get_mca_debug_mode(struct amdgpu_device
> *adev);
> +int amdgpu_ras_set_aca_debug_mode(struct amdgpu_device *adev, bool
> +enable); bool amdgpu_ras_get_aca_debug_mode(struct amdgpu_device
> +*adev);
>  bool amdgpu_ras_get_error_query_mode(struct amdgpu_device *adev,
>                                      unsigned int *mode);
>
> @@ -821,4 +823,8 @@ int amdgpu_ras_error_statistic_ue_count(struct
> ras_err_data *err_data,
>                 struct amdgpu_smuio_mcm_config_info *mcm_info,
>                 struct ras_err_addr *err_addr, u64 count);
>
> +int amdgpu_ras_bind_aca(struct amdgpu_device *adev, enum
> amdgpu_ras_block blk,
> +                              const struct aca_info *aca_info, void
> +*data); int amdgpu_ras_unbind_aca(struct amdgpu_device *adev, enum
> +amdgpu_ras_block blk);
> +
>  #endif
> --
> 2.34.1
>


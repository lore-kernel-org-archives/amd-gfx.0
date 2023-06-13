Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87DBCC77B7A
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jun 2023 07:08:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E579210E329;
	Tue, 13 Jun 2023 07:08:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::611])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76E7A10E329
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jun 2023 07:08:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvQx0q5VUNU8Ndqe0vjteex1Xy+mMZbFbyZ8sh2xKoQ7IDybqQoTfK0FfUt69aNiy+dsws4pjg5+RCTarigAkTeqRvdEqB+nkfESZnk6vi89AD8scqDALC4U5L8XDbDhS7vD9mQy06N2rpMF7ibRJqhAZjOmpwJGXloipIKdUvCyc0o/wi4dVwgz2y6ivVZNCY6ik5KfjTYWaGoTP27YKZc0ftb8Frp4bFhWgQA5K5WinwxhOd9g/bUr8c3XPSCzDv1kK7C1FTdUpFuvInsL2L+CAQB/YK8UTItQ8LMSNcX1AT2dbtSUzHl/3KrB9hTZuILliyyXJIB4dawKwvaDKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhafscYUUeKV52o6uqFCcySeDnDThGDb79UL4qHhiVM=;
 b=bJVtse9jB+84g25xYca7FS6byWEw84586SVwMdDlxml/dCEVN1CiJzSZ1H5/j0enLdoY7qvz7MVaerwMBn0uVzqlY5JObiyA4BVqp8GKYDm8+l9KH+7bN1QIXFEvFzCTJykCwxTNzKjyJFGJ6iTKDFJfGb9jCXV1XnFtb4ZUxzKcHUh7hN/XtCgr/UX7Vd89+3EmWNrDxMTv2tVlGvxFARQhbHW61CtZVjZb3ITQ1ASpxtz0nfnA5GSj0P9pdHNmv60X6d/OBczsUcT589mVEBv8AhZykTEUeFgs3iJIL/uNGqHjdpUADAYqySqjRE0yFX9xqJlmXrLOSKsmhxSUgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhafscYUUeKV52o6uqFCcySeDnDThGDb79UL4qHhiVM=;
 b=nA/eem0Qv6fYRRgKgBrLQkpJRLx6EBrLCGIZwP5x0gWdLiDHb8/xyAFCW+YInuTUlXC7KzglJZL8Ckp05dtgexhxHnYHyxuv/qrHMB9WGBhxkmlD4HQKnhT8CmIVcEZp2wC89X1TflVR3D3fJTXVLvJc72kq4LfEpsBNymu11I8=
Received: from IA0PR12MB8981.namprd12.prod.outlook.com (2603:10b6:208:484::18)
 by IA1PR12MB7686.namprd12.prod.outlook.com (2603:10b6:208:422::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 07:08:18 +0000
Received: from IA0PR12MB8981.namprd12.prod.outlook.com
 ([fe80::9731:385a:f48:ff69]) by IA0PR12MB8981.namprd12.prod.outlook.com
 ([fe80::9731:385a:f48:ff69%7]) with mapi id 15.20.6455.037; Tue, 13 Jun 2023
 07:08:17 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH Review 1/2] drm/amdgpu: Optimze checking ras supported
Thread-Topic: [PATCH Review 1/2] drm/amdgpu: Optimze checking ras supported
Thread-Index: AQHZnaqazcMBKIA4EE+UGLJy4yEdDa+IT1kg
Date: Tue, 13 Jun 2023 07:08:17 +0000
Message-ID: <IA0PR12MB898143BAC695764609219EBDB055A@IA0PR12MB8981.namprd12.prod.outlook.com>
References: <20230613035318.10613-1-Stanley.Yang@amd.com>
In-Reply-To: <20230613035318.10613-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=64f53ff2-ecd6-4083-9d8e-0f2d1bc43d00;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-13T07:04:48Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8981:EE_|IA1PR12MB7686:EE_
x-ms-office365-filtering-correlation-id: 87793119-53b5-40ae-9960-08db6bdcf69a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6z6rQQHJ1k1SHpH2oOZCUiL73NU+Jcqqckgys1IXiQtJBU/RwA9a7GGSRvNb3T8kDp7ntxkkKKV0L7gQsBwrWbRU2a0GWbn43awiQDhCnpuIu5QJYIpwYPg6aTzteh8nFbzngvlr5R83r6LoJiJMkt/GahL/kgATiS2jhEKzR5OZEFmoZBlBfhLLrJC2M0QLEwc3ze2hqhi49CNt85DIaRpqU5HfuFgXEuYi/A3DUB9QFz0+SXyRUgxA0fNNquz4X9EqFwCN6PIR3AI8jTRv3g3IEYsbuUSN82OE0UASZHaOkHAroSbSlg90y0EHjl8Y5HJy7A8dusIzPnn+bG25F3Hbnaf16mrXxtMoK0pEY30eXBc2zdzZh/xoDYJMaS21LJ1sbQCsGYEcOCtpSB7zs29zNmyM0cTU8Yw4H1wg5iOemL4soGJRvB+g1DHjSkBKCSa3bEq03J8H1NlTmWM+z8Hp46E4VhKfAr8CXm1kYtC5+aUwsLxgIenTPgVkjwy23S8ADK1PuU03I7Mb+5PGz6dIzNHR2GuFFo+viqsYNOiu/YvIA6hvmCWgwbTc089CN/6m6BVZn6I593bgoiQv/IMJHetzV3IgDtH99DechtXhs3aIpUNsXtvXaXSiIzFf
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8981.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199021)(71200400001)(478600001)(7696005)(122000001)(33656002)(6506007)(53546011)(83380400001)(186003)(38070700005)(38100700002)(86362001)(9686003)(55016003)(4326008)(76116006)(66946007)(66476007)(64756008)(66446008)(6636002)(66556008)(316002)(8676002)(8936002)(52536014)(5660300002)(41300700001)(2906002)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NrWB6AcaPP5j0M4IFB+E0/Eo+l5cA/LapVJPzWLx4sY2yV4qaqS9q91j/1+l?=
 =?us-ascii?Q?YNVdEgHZd5/+Y6bmbbZVmeOGnmLjBovutXUgwEgRJZz9+o6xggnGPJrCYUMD?=
 =?us-ascii?Q?aMNfDQwmRILwW6gCMe9rbxAyltDXH46UuL1jdxiKEBxQeFIExDJnUJgzN3ct?=
 =?us-ascii?Q?KcBl3Gn9yiIYRjs2nJZeL5FeCFUOd63b/WGXdDPjFofTpB/1REwrDIYGGYra?=
 =?us-ascii?Q?vvJJwyUkXPNGZIoumOjqBj+8qu1C3TvIihCP+OKDAxrFX9CX9Uo8U4ZNI7Cr?=
 =?us-ascii?Q?1bbcGXGgX+HpOTCxytEoSu5koSeCiM+duIg2FoCADpjvrSYSc6xP/t3OIT6c?=
 =?us-ascii?Q?sXgBqITVf4S9n5pdBsCODVrMa6Owr+LzfMl5s/NIUScWrBrzNSIyGT45uRBy?=
 =?us-ascii?Q?/5kePrNCW+SATI4lbMzy9lIlOtjh+egTWycHZ7GV69/uFA5jMI2p2GoXk7qB?=
 =?us-ascii?Q?AsS0bAQr3RMNaJPjc3bt2BqCpOD/LwVIB5bGGi90rHwr/eiozYdi/DtaB0eE?=
 =?us-ascii?Q?ZTOSSA6swoIFC15hO19w/vDHCdgeX/GShoGlXyU6LWsKlELLInzCEaqL5ViW?=
 =?us-ascii?Q?aShvw9l7R6wuL9E5GFPuGndGnj8mbGla9GROKmV80YdEJ6nd+kbSzf60zAL7?=
 =?us-ascii?Q?1xWz43cpqhNpTQqzJXGQVQiYvOQpJ4S7o69L9ZRdZt4h2RNLfCmt494Tt9Jn?=
 =?us-ascii?Q?2KuLbdp5mmQ96WVLSEHjgB9/WzmLXjHh4k/z3QrBrfrPZn+LNB2uzuMuyeLK?=
 =?us-ascii?Q?UaBD3wVwKmYO6rfJcJ5eVL4xzIe+m4uHsraM96zQCkRJZZ7i74XeGwa912Aj?=
 =?us-ascii?Q?o3E0IWCjMhjS2q8kxAkf/5wYys7lQQFJfVh3N65zsTh4/LnrlSnXsVNqNbwF?=
 =?us-ascii?Q?xn975IruOYUpo6iJSiKSvSwVOFaAKYjUZ2cAoMKpfa0BDGA6iOFCq5q9AgRv?=
 =?us-ascii?Q?DLcVJmHOVwD0tIRVmj2Fx6r5E9yqRDrAu19bqmwvuvFydKMPVGfPw2/d83Gr?=
 =?us-ascii?Q?Wv3RWv44bHsvFEjxfQRclU7BirtSLhw1GNFGAaymXpoRVoVI9AVCxMOpZoeD?=
 =?us-ascii?Q?MgSM0YAUW2iVaUa1ACcxDuX3+Ebqe49SWKiixf7wXuRvJf/z9JujRz7Zi0Jx?=
 =?us-ascii?Q?gbx1o4iKG+l8r46wDXJYWqV744G0rKt1eDKZG3WJOR1k0vuiHn6r2STth535?=
 =?us-ascii?Q?MkmUot/5HamNpl0AGgeO0AeasqUkFeodxAlZGrGWfne5atek1lwCMquhoSFj?=
 =?us-ascii?Q?27xL0GwkStiG2iYZ+djFnZee1XwcVkGrCoZB2J5XZyY8mdaG9rxVrz8f8GTm?=
 =?us-ascii?Q?31p6aWV39h5hh5EfUnUBBQ5ufxlASrMBDmywZaMy7/w2RIDZqMcAGvraWnpY?=
 =?us-ascii?Q?JqrDow2At4vGShxKdBbMhn+D/bmyQ7CRJX67KEy7R8VDb+bX+5MnRRdmCc94?=
 =?us-ascii?Q?WEXWReue3bOGtfqmyH+2n1T5mVpSY2grlsadcXquVoYudOw4EzzHvQL/riYo?=
 =?us-ascii?Q?ZEzkx3GlyWb3BF4qgcLhEqh86U7QdyekD028h5mvHfBN4o30LEKARKuzhg?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8981.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87793119-53b5-40ae-9960-08db6bdcf69a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 07:08:17.7234 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: detWMLIjBrzaLsVzeK04JJFlau5v20milHmQIZVOXBjsxzDaZmMruI3hyviKE0f9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7686
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

[Tao] typo in title: Optimze -> Optimize

> -----Original Message-----
> From: Stanley.Yang <Stanley.Yang@amd.com>
> Sent: Tuesday, June 13, 2023 11:53 AM
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>=
;
> Zhou1, Tao <Tao.Zhou1@amd.com>
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH Review 1/2] drm/amdgpu: Optimze checking ras supported
>
> Using "is_app_apu" to identify device in the native APU mode or carveout =
mode.
>
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c |  2 +-
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |  8 +++---
> drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 34 ++++++++++++++-----------
>  3 files changed, 23 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 78bacea951a9..352e958b190a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -1653,7 +1653,7 @@ int psp_ras_initialize(struct psp_context *psp)
>
>       if (amdgpu_ras_is_poison_mode_supported(adev))
>               ras_cmd->ras_in_message.init_flags.poison_mode_en =3D 1;
> -     if (!adev->gmc.xgmi.connected_to_cpu)
> +     if (!adev->gmc.xgmi.connected_to_cpu && !adev->gmc.is_app_apu)
>               ras_cmd->ras_in_message.init_flags.dgpu_mode =3D 1;
>       ras_cmd->ras_in_message.init_flags.xcc_mask =3D
>               adev->gfx.xcc_mask;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 7a0924469e4f..56bb0db207b9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1689,8 +1689,7 @@ static void
> amdgpu_ras_interrupt_poison_consumption_handler(struct ras_manager *
>               }
>       }
>
> -     if (!adev->gmc.xgmi.connected_to_cpu)
> -             amdgpu_umc_poison_handler(adev, false);
> +     amdgpu_umc_poison_handler(adev, false);
>
>       if (block_obj->hw_ops && block_obj->hw_ops-
> >handle_poison_consumption)
>               poison_stat =3D block_obj->hw_ops-
> >handle_poison_consumption(adev);
> @@ -2458,11 +2457,10 @@ static void amdgpu_ras_check_supported(struct
> amdgpu_device *adev)  {
>       adev->ras_hw_enabled =3D adev->ras_enabled =3D 0;
>
> -     if (!adev->is_atom_fw ||
> -         !amdgpu_ras_asic_supported(adev))
> +     if (!amdgpu_ras_asic_supported(adev))
>               return;
>
> -     if (!adev->gmc.xgmi.connected_to_cpu) {
> +     if (!adev->gmc.xgmi.connected_to_cpu && !adev-

[Tao] the tab should be replaced with space.

> >gmc.is_app_apu) {
>               if (amdgpu_atomfirmware_mem_ecc_supported(adev)) {
>                       dev_info(adev->dev, "MEM ECC is active.\n");
>                       adev->ras_hw_enabled |=3D (1 <<
> AMDGPU_RAS_BLOCK__UMC | diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> index 1edf8e6aeb16..db0d94ca4ffc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> @@ -169,27 +169,31 @@ int amdgpu_umc_poison_handler(struct
> amdgpu_device *adev, bool reset)  {
>       int ret =3D AMDGPU_RAS_SUCCESS;
>
> -     if (!amdgpu_sriov_vf(adev)) {
> -             if (!adev->gmc.xgmi.connected_to_cpu) {
> -                     struct ras_err_data err_data =3D {0, 0, 0, NULL};
> -                     struct ras_common_if head =3D {
> -                             .block =3D AMDGPU_RAS_BLOCK__UMC,
> -                     };
> -                     struct ras_manager *obj =3D amdgpu_ras_find_obj(ade=
v,
> &head);
> -
> -                     ret =3D amdgpu_umc_do_page_retirement(adev,
> &err_data, NULL, reset);
> -
> -                     if (ret =3D=3D AMDGPU_RAS_SUCCESS && obj) {
> -                             obj->err_data.ue_count +=3D err_data.ue_cou=
nt;
> -                             obj->err_data.ce_count +=3D err_data.ce_cou=
nt;
> -                     }
> -             } else if (reset) {
> +     if (adev->gmc.xgmi.connected_to_cpu ||
> +             adev->gmc.is_app_apu) {
> +             if (reset) {
>                       /* MCA poison handler is only responsible for GPU r=
eset,
>                        * let MCA notifier do page retirement.
>                        */
>                       kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
>                       amdgpu_ras_reset_gpu(adev);
>               }
> +             return ret;
> +     }
> +
> +     if (!amdgpu_sriov_vf(adev)) {
> +             struct ras_err_data err_data =3D {0, 0, 0, NULL};
> +             struct ras_common_if head =3D {
> +                     .block =3D AMDGPU_RAS_BLOCK__UMC,
> +             };
> +             struct ras_manager *obj =3D amdgpu_ras_find_obj(adev, &head=
);
> +
> +             ret =3D amdgpu_umc_do_page_retirement(adev, &err_data, NULL=
,
> reset);
> +
> +             if (ret =3D=3D AMDGPU_RAS_SUCCESS && obj) {
> +                     obj->err_data.ue_count +=3D err_data.ue_count;
> +                     obj->err_data.ce_count +=3D err_data.ce_count;
> +             }
>       } else {
>               if (adev->virt.ops && adev->virt.ops->ras_poison_handler)
>                       adev->virt.ops->ras_poison_handler(adev);
> --
> 2.17.1


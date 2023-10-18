Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51099CDB47E
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 07:19:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4BC710E3B1;
	Wed, 18 Oct 2023 07:19:01 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B5BD10E3B1
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 07:19:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/vRl7tv+tSemUBxATgYyQHjAqvVMJtmLGLninFurbedf9QdBzMJBWxIRTFiaYHmaJV19rxiRaPo9kb+EIObd2Emp65onvHan9Nk1w4tZLppBltRJqiIHQGP8oh3itCwBBq7zLTdf/VZ9HfF5LKN6POE9spi/gw4dtrgPkoHsRp/3uMeeB31Q3aB6Gm6daqN8yqP51N9mgLcVSnULTAyBGExpCMOGH2PGkU+6qXtUEDQ1jFEF8U0TsDCNe56m1/BgiqgHW5wfTF+RxkVZcjEzWRSNSupiBz6+R0wIbmEkqYGDh6BoHKsURmz6KN/zu+xPngiG+mbQm2ZG8XZ6YS/Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HkmWx0l295cNDbwHhPvE/G0qtqcoDSCq1/BgtKwtXRQ=;
 b=e8ryDGA9CQ4AuUVpSSy90JH7yIUkkpt3Zviachg3q6/omAgbfpZLYumlyauZjHZY6/5ybmFr+rSxAFa6VXGQ+jug5Rf6qMcFR7s78XtwY/mtXqzmtk/5CkdIQXy85sap0Tpb9slSFa/+o2SvQZnXyR9OTVCI0fknRGUGFycHRE4qETzZRtE3Z6fUwreE0aRsz/mEP0QvP2toY6ygaAP4NeckMCSPmhPjZn5cPkNJ/+d9+yNhycEbT2aeYbRh+8kmLR2bTAcUFCt29P2PRHwYP3zSd+Q7AAn6r0hYWxT6LHjAnTd/ERvsnTKlM0kAxU6xFM01MZtmvcYV4j3/aUCGSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HkmWx0l295cNDbwHhPvE/G0qtqcoDSCq1/BgtKwtXRQ=;
 b=0oHya7/BoAjfYaPkgy9FT8bC4j15b2Uq06J3uYXQxlFwGScHxIZEg2jWVUBilcpj4UNA/rCsPholx9rwxuw/ea2ntru+uqir4fTgsE9qK1BT4jbT/kN8jkuR5hrUQggn4RZXfQ1YTzrivPB7c+hCZDf2aAju0iw2Jpjwtip7EDc=
Received: from PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22)
 by DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Wed, 18 Oct
 2023 07:18:58 +0000
Received: from PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::d59b:2efd:b690:583f]) by PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::d59b:2efd:b690:583f%7]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 07:18:57 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Li, Candice" <Candice.Li@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>
Subject: RE: [PATCH 4/6] drm/amdgpu: bypass RAS error reset in some conditions
Thread-Topic: [PATCH 4/6] drm/amdgpu: bypass RAS error reset in some conditions
Thread-Index: AQHaAPfq9B4ZaYEh4kO4EgE2dU2K5rBPI+tw
Date: Wed, 18 Oct 2023 07:18:57 +0000
Message-ID: <PH7PR12MB79881FD52EF58B523D5F48059AD5A@PH7PR12MB7988.namprd12.prod.outlook.com>
References: <20231017124552.27509-1-tao.zhou1@amd.com>
 <20231017124552.27509-4-tao.zhou1@amd.com>
In-Reply-To: <20231017124552.27509-4-tao.zhou1@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=087d064b-5ab3-4e1e-99c1-23be9b7d2581;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-18T07:15:52Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7988:EE_|DM4PR12MB7742:EE_
x-ms-office365-filtering-correlation-id: 531254ca-fd37-4ae5-c938-08dbcfaa7e68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pTusU56TY4dq65dP0nQ8BXhDGhsl/o/AbuvRJtpeqZDmfhCTgMUbGcp3VsDMjXr132GlMY9hEz7XbddoNHaNldxCgHVCMu/VY15cGYwDjyw8W0N8RqVJBvQ6Sgkw84No8EVegOs+XCtKK0/EEC7GdoYezu7y8XNmZAVYBI39ISFumulQbdBomXHOnf3zm7qR0oKbEoCQ1PV9ICAT+x2rhTEY1kNbp7ZzraZCjBUjX7I83DYyC1Bn3yF3/iQiVF+Bybq+d8+D62rwYDqCMrJtiCYDQky3IMQl6ms+5ksLpm9P7JSrqvZ+UudBeOHLml2D81cLLThX+JmzmZdvp3QviO5HEIpNYuQRyLgFaCbibNdDp7Vq7eBf3i8qWliHdPcsNjGceCf8SDW6qTUan8KRMx2/qml1IdfQnk/LC0pVDGN/IvkB+k0joXkjOQQ6FRnd4QLkRoogTDvfHlXcgcQFaqbWVamLylTGLDnx/oSDnFg4ZAxejVGI5Wncd6beua7RxELQTNIMVTFt3nsTyArvN+m2v3EsBlWsmkwFfXp5qahA70kNR9J94yjEIM1TB+T79WzNk6DaQwaDnNsbTDyucXnaaKOKaTPdgstG/yq/FcFyMpOEm5HKTfa4QxM1Joyx3O2qGnBpLNv3+gMAxwgcVQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7988.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(136003)(39860400002)(346002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(55016003)(66446008)(66476007)(66556008)(6636002)(110136005)(76116006)(64756008)(478600001)(66946007)(41300700001)(921005)(83380400001)(38100700002)(86362001)(316002)(9686003)(7696005)(53546011)(6506007)(26005)(38070700005)(33656002)(122000001)(71200400001)(8676002)(2906002)(8936002)(5660300002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oHPTWHeV5emLKv+bjQF2mnQWqNUbzJ9qpeDeakZamt3+N4mf9XfLoExw6oS7?=
 =?us-ascii?Q?NQ7bWrQ5Pe6sTwkleSjw8sLkzhpasDLvLUKAsToyWNa/fHjeRXzJle5YfkH4?=
 =?us-ascii?Q?61rO2buR6TDA/2b2WRjrBztWm2G+f05v+Y2G/JteBn8rT74ulvnmp3/eIyTk?=
 =?us-ascii?Q?ioo6Ob0jKCqCdQ7eZdFM2vH7hnPVoGfl6afDyiAioDEv5Mj4YS3dlTNj0fjs?=
 =?us-ascii?Q?0zWUbj8BGkyqlfXgXvrhoTxTjKZ7wR/J3CQUkKxhr32EjKJibFyfWLThACAS?=
 =?us-ascii?Q?49ON1sQPcRYmV2IWAKZBI5A8WFeJcVxD/KakusFy4+UwhACS6wamMhjTyYQO?=
 =?us-ascii?Q?EJcKw3eg1ybcND1MrQw3PrOpgffE3FzcnOpeU/8fGLyEV5usuM3OELxpsVrE?=
 =?us-ascii?Q?4tZQvRTxt0z73oPwbuVBj2YgnOtABpA0KSd8DeuiUt6AiKDiNWY9l1BAqJLX?=
 =?us-ascii?Q?klOEJ0d3SNeOxBW0MmqWoxOLLuvkyoDqKS7Fe7z1n2ZPfJsKLsr4YqIUtvsU?=
 =?us-ascii?Q?TNHD4QfhRyzdtomHKdYR6cdMxmakmuYg5ZzTcwrgxEthbKtJchkwEwCQH0sR?=
 =?us-ascii?Q?rJh87k+/dKkn4elugizglG/M8Vgz/gRD2xCWlHzoLJQ6q9mMKH9/EpzVmwH4?=
 =?us-ascii?Q?JMLt5lHL9QWPjoO58ssf9QqOa0Ohh17Iplno5Qv8R73vfN7GwTv2aUbaIsKH?=
 =?us-ascii?Q?d5zhXNyGkqISbeWegG620q+ZogGNUsuSKee5EE7GkwSmXA5cRa+ptYAy++3U?=
 =?us-ascii?Q?5I3dHCz1gkb2z88EJBKpCfhFa5usv0OiiTkgaXQ28hptF00ibvRvqrXw89ZL?=
 =?us-ascii?Q?pmgOSaBS2VUSn/cFABksm87VRYxFBV2Umiw1GrVp954zuBnsVfekVT00U/9e?=
 =?us-ascii?Q?wjSihsXdTTAK2rSAuQ/5zWz0hU1IYscZgwAzJdJhwj2BsDQrwoOgfp8c32sG?=
 =?us-ascii?Q?sYGDGAfk9tPVHIKJeLoys2KW0Sedo8dMcdkseC103lHMyGOASajwdLW7d/hm?=
 =?us-ascii?Q?6BpbdEw0eQiEdh+33sWJkcBveczBSnldoSGt+ZOClitPqVAnn3455gtXsJYd?=
 =?us-ascii?Q?GNa66FxeHwXAyGHhOKEz27jij6gfCD6i9jSEy2QYRp9iVSixZP2OtEhoypBa?=
 =?us-ascii?Q?EUwhUGDfef2XcIkZBGTlRGqu8BxyJgJE0uZM8crTjHLaqFyuLxoImLoUw+Rl?=
 =?us-ascii?Q?AIFKF5beJC40SS0stMeRVlH24zId8YPrKEEqikA1225ncCQX6wzIF3YVKybp?=
 =?us-ascii?Q?k5ZQ+XYsHfvZNsqrQEmgXK+B1Y/Lgxb+HBtwdMBoA6+7Nze2p+lytd2dCntF?=
 =?us-ascii?Q?ExFsIgyBe9/EsxZZW60nv1WrLETOHT3VwtZjBjnbMhnUtEDDHrQQwDsef2es?=
 =?us-ascii?Q?0vvRTLfsKcYQnQjtYJc//eKGp2vnRHiB4L/tmzZlEe8/RjUXRuZJYKmAC4cL?=
 =?us-ascii?Q?uktNi/tTxOb7MpyIIVJvOKkti6fwMB/zWx5ZSiPiFwKBie5aLFJPq0QpSSTS?=
 =?us-ascii?Q?b5nE3U5FggpNDkd51IYTm1RwkXFRCG6iXksyAx+lYVX6iVKA9zycQIQ/jcAe?=
 =?us-ascii?Q?V6xccXJNgfg2F6r7//4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7988.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 531254ca-fd37-4ae5-c938-08dbcfaa7e68
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 07:18:57.5275 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5k6VQGzM4UrUmjpDlQfMfyw1YnK7M4B2DKTFOxnf6BZquve+9ba38lBdw3G1vHkH0k1uvY21aS/wC6VZtto7Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7742
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

[AMD Official Use Only - General]

> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Tuesday, October 17, 2023 8:46 PM
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Li,
> Candice <Candice.Li@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>;
> Lazar, Lijo <Lijo.Lazar@amd.com>; Wang, Yang(Kevin)
> <KevinYang.Wang@amd.com>
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: [PATCH 4/6] drm/amdgpu: bypass RAS error reset in some condition=
s
>
> PMFW is responsible for RAS error reset in some conditions, driver can sk=
ip the
> operation.
>
> v2: add check for ras->in_recovery, it's set earlier than amdgpu_in_reset=
.
>
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 95c7ba889e2d..806c6d4deb63 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1178,11 +1178,19 @@ int amdgpu_ras_reset_error_count(struct
> amdgpu_device *adev,
>               enum amdgpu_ras_block block)
>  {
>       struct amdgpu_ras_block_object *block_obj =3D
> amdgpu_ras_get_ras_block(adev, block, 0);
> +     struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
> +     const struct amdgpu_mca_smu_funcs *mca_funcs =3D adev-
> >mca.mca_funcs;
>
>       if (!block_obj || !block_obj->hw_ops)
>               return 0;
>
> -     if (!amdgpu_ras_is_supported(adev, block))
> +     /* skip ras error reset in gpu reset */
> +     if (amdgpu_in_reset(adev) && atomic_read(&ras->in_recovery) &&
> +         mca_funcs && mca_funcs->mca_set_debug_mode)

[Stanley]: The check condition amdgpu_in_reset(adev) && atomic_read(&ras->i=
n_recovery) should be modify to (amdgpu_in_reset(adev) || atomic_read(&ras-=
>in_recovery)),
Can we check ras->is_mca_debug_mode directly since patch#2 and patch#3 set =
it.

Regards,
Stanley
> +             return 0;
> +
> +     if (!amdgpu_ras_is_supported(adev, block) ||
> +         !amdgpu_ras_get_mca_debug_mode(adev))
>               return 0;
>
>       if (block_obj->hw_ops->reset_ras_error_count)
> @@ -1195,6 +1203,8 @@ int amdgpu_ras_reset_error_status(struct
> amdgpu_device *adev,
>               enum amdgpu_ras_block block)
>  {
>       struct amdgpu_ras_block_object *block_obj =3D
> amdgpu_ras_get_ras_block(adev, block, 0);
> +     struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
> +     const struct amdgpu_mca_smu_funcs *mca_funcs =3D adev-
> >mca.mca_funcs;
>
>       if (!block_obj || !block_obj->hw_ops) {
>               dev_dbg_once(adev->dev, "%s doesn't config RAS
> function\n", @@ -1202,7 +1212,13 @@ int
> amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
>               return 0;
>       }
>
> -     if (!amdgpu_ras_is_supported(adev, block))
> +     /* skip ras error reset in gpu reset */
> +     if (amdgpu_in_reset(adev) && atomic_read(&ras->in_recovery) &&
> +         mca_funcs && mca_funcs->mca_set_debug_mode)
[Stanley]: Same as above.

> +             return 0;
> +
> +     if (!amdgpu_ras_is_supported(adev, block) ||
> +         !amdgpu_ras_get_mca_debug_mode(adev))
>               return 0;
>
>       if (block_obj->hw_ops->reset_ras_error_count)
> --
> 2.35.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9242C4332F
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Nov 2023 20:23:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0942310E31F;
	Sun, 12 Nov 2023 20:23:49 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7528C10E0BF
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Nov 2023 20:23:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQezyqIZQVPbfqX2W1Ty8udjstaXzO7Pt/SmCQ4r9nBZuyGJ8XXac8TxJPZwafFWNShDZz/xmTyEXe/4vO6YAaVH2Zmx+l+sAD4D+C6NHJ9WHnmI8vvx1MP6dvC3iGL4CAYUw3S45YX2U9f+niDon/neMUknZZX5a7yomI1YHOq35pyaeuEF1HwARMLEndw6iwLJdw7Z8iBUVUQL/alf9hk+H8L/HJoHa0Sk8XQv0D4Amoqsv+bxPlyaycqRMbomPF+/LxuJJVjEjdwjinE82j4QC57L9zqjN6X/JVxVgFz9GZj8K/zfruW3TSv8NnFfs0B4ZMNUDCE7asWfUoRqRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OX5278s+h82/AVpO+16Wg4440UmWHjqjXMq5itucKv0=;
 b=dPE9KpT2uLw22sc8HXj2CAMdn2d4WduyEgiQYbDgUT4OAYMtLhmArNHh26aVQHXfUqBScWXsWaB6OeBp4qkHF/szYScpmG2MrXgkZJI8NZQg+X3YlrUkeiYKxSyBzkch5tUUvFu3KhdMSinYgQKLlg2TDk9MRdp0GNd0pICaVs2jRCekQmk/bn7e+ZMT3v7i5nLksHVaLdR4Zz8GzbzPPRMl1YatHTxVkaPosIt22/a1gKiR/JaKdoMccr/x7mCaSLrbRMLolCRCAxno/rGCKbcv9j+2ORX4j1uuhNd/E7fc/D+0EmUqxDL5fud7SinUmCZ8QzqpS+xCWBZx6dyyFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OX5278s+h82/AVpO+16Wg4440UmWHjqjXMq5itucKv0=;
 b=ualO20fdtQzfO/viVUZvw6guK24QK3LSkzbx4amX23omQjCPLqD/CeiJ20YK7fIRb+rwAqlUkXLoVihNK7UAohAE4j4IfoU46fLgKPsd9FvBYVBxRG1vcOtLhe4o3wQcexsJIAtpU55jOgo7Kx3XqG77EmreZJvzkof+cqoe/GI=
Received: from IA1PR12MB8189.namprd12.prod.outlook.com (2603:10b6:208:3f0::13)
 by DS0PR12MB8786.namprd12.prod.outlook.com (2603:10b6:8:149::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.28; Sun, 12 Nov
 2023 20:23:42 +0000
Received: from IA1PR12MB8189.namprd12.prod.outlook.com
 ([fe80::1d62:d547:7940:fd41]) by IA1PR12MB8189.namprd12.prod.outlook.com
 ([fe80::1d62:d547:7940:fd41%6]) with mapi id 15.20.6977.028; Sun, 12 Nov 2023
 20:23:41 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Siqueira, Rodrigo"
 <Rodrigo.Siqueira@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Mahfooz, Hamza"
 <Hamza.Mahfooz@amd.com>
Subject: RE: [PATCH] drm/amd/display: Remove redundant DRM device struct in
 amdgpu_dm_, mst_types.c
Thread-Topic: [PATCH] drm/amd/display: Remove redundant DRM device struct in
 amdgpu_dm_, mst_types.c
Thread-Index: AQHaFRzsiWfrlrPNeU+l68uIEZvKN7B3IesQ
Date: Sun, 12 Nov 2023 20:23:40 +0000
Message-ID: <IA1PR12MB81892FF5F2C56340211A28A489ACA@IA1PR12MB8189.namprd12.prod.outlook.com>
References: <20231112040051.1621934-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20231112040051.1621934-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=61a75037-a9c0-4930-ba61-5bcaf946ea89;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-12T20:23:18Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB8189:EE_|DS0PR12MB8786:EE_
x-ms-office365-filtering-correlation-id: 1beb6b66-927f-4087-29e3-08dbe3bd4253
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UF4QpA9V/Qsp138bh9YelfMcsOFQFyFLGRyG3YoKQyi2+V+u3WEniB4RX9elZydTJK7XDPMq6TwmiWpgrjjgDorJeq8jbWRZQMgcueAK1HFAbxOllIzXnMg7o9g+GjF/G7cgStY8cpLbAZi9IKJPOHqY80dDvk0RbAw4p415bzAUi/QMCgimTG/Czm1OAzwqC9a0pOVj4XcR//gog0SgBMWLUvkRYrqYG2WVA9n8Kpec+rJBenm17P/AsczSdfwBKZukXM5H/aklNwz3Xr9k2I1VkbwCfuL4Don0iO7cGKOp/UuVFvt9ajFbnxAYpFfFKyV15jk+ENcOh839iWKNk6mXb0gKDHVyC+0JGApdL9k5udgIbxTz+oLswb4+gyqBJVsPxWHJBNoSXWliKvAeZivefEqRKAYIxf38mMa28Lwgbpc3Ewfl5bER/aRcMn8sZC8/KBvWX35d5C5sGcj9YIiUfLDYSCj+S2BQ8/tMLo1RJhUpx9gdVu7Q2HvySn8ihb36mfzXU0eCVQi0/1FLSSknl1C5PF60kSlfxmLLJVKtQwIqJNwdnLoobToLTSu3OF9nS6mbQjgPJi9riOrqx0wIj+1lz8/eNOW6ONWex5lQZ0hHCBxbA3+aTXV+r/dL95qfIZeWfIs++uexT+O7NQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8189.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(346002)(376002)(39860400002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(6506007)(7696005)(71200400001)(53546011)(9686003)(83380400001)(5660300002)(4326008)(8936002)(8676002)(52536014)(2906002)(41300700001)(478600001)(316002)(6636002)(110136005)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(122000001)(33656002)(86362001)(38100700002)(38070700009)(921008)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RPhQhDU/iKHryaBc4xrzJfwSkXer5tj46aPzZ2sPiD5CPrn5h4mS53fe44VI?=
 =?us-ascii?Q?uxBWqnM9NnxY3LrsiE3G+iJ+09/qrCgp1msA/sbK2PVjvedlLzqbPU+3mm6C?=
 =?us-ascii?Q?9oMd0p0MUzWEnY8vPAB6lwgEWZ0cW+w9+vm6a4/yo7145Y04jN+9rcOjBe/y?=
 =?us-ascii?Q?RrW1FVhsgNWa8+GfNe+7xSqSTdNho9Y6RxnBPuClYo9eyvtvtJZOJI3wmyXP?=
 =?us-ascii?Q?dfK0TzQN5XmWKa/TDpsFrtOsg8UyVUF9BLqmnER4zDVPT+NEQ6nkCEGUbm+S?=
 =?us-ascii?Q?8yjq2jFMy9EVAujr77ocTm/trflRUskqx0Fwhi/bib2/dLP40nq+kYz4YJFH?=
 =?us-ascii?Q?mcLWJvWG1tUPfgWozrRsTrHkqOlPmjukNLju50dMNfqtln3V27iggHrGXdVK?=
 =?us-ascii?Q?MPlrYaKhFlQwPJJ/0gDP7SYvi7FI8LUGJdUQ1yAl02qC9zQYzhgNWZOzkPrm?=
 =?us-ascii?Q?AMzpz2ZT6ahRaN9dYxLxUA2zVn6blU3E3wNqtiqiTJB2ttsMHf8XrAdMW/9I?=
 =?us-ascii?Q?id12eKJeFvZqV3YaGqAr61ZpTBcNvBukUU+Ko7n0SrcUL/Qk4MCzjQPKGmZG?=
 =?us-ascii?Q?ssbJ0gpS9fU04LJfcPvOZkBTQ1Qjl8ikVQCknwL4Qf9hs6AxecNWAtxsC9ws?=
 =?us-ascii?Q?6hQf5XcF8NyPZNHKz0IAubRFgekWMFN5Q10vtJD0h1JvBCm0LXSKSumTkH5k?=
 =?us-ascii?Q?YAdik+kkKXol34A9JW4oweVkXClvu0v54XwjB3Ueb9KUmbtaPvZZcAFb1H3N?=
 =?us-ascii?Q?PgziF4PlcV0epx4j3D+HY/q3GvqvcSu1dAbJdLPI6d7PLDXYiRm98W4D63w6?=
 =?us-ascii?Q?03Qk+/wPRQzQVTDn35fCgmes4DjBHI7KHl1Jzcl+NfKu4g2jLdm/YkiEbSoi?=
 =?us-ascii?Q?zls0R/+zSS21i5vuKTJRI9OnB/KwO3ms3xKwUmyRb7GAR8xz66TJtTMJZCQv?=
 =?us-ascii?Q?T/FpDZI7CLyE3B2vGS9HULvXXO1PhH+2g+OvF02Irr6zXGhv4MBWdGNAsDL2?=
 =?us-ascii?Q?7xASYtLatgjnvqy/lRLUuclTS8Zh8OB/AKEcax9BfK7lWqcVcdYKbwLVY/H0?=
 =?us-ascii?Q?aTl/xqoRvwtt2AfdWJftV3w8xhBoeH6wZXCYxJy3eFRPCUsj/p9IF6ll/uch?=
 =?us-ascii?Q?IuD6w63uuCW83kYPizhVMjlQG2l2G8sq6oy07hAM3/jy66+P7K4Wh4XlD0L8?=
 =?us-ascii?Q?b1VpJwRWTvjmZDiZO1aSCQyGgePiw+dmdhOjRPsZ4FGPc0XByFqxf7vCgN3d?=
 =?us-ascii?Q?ZK6A4ZuqUUess6ZE2hE3uayVrRKHqcEuwg2y/OCvKbUPOlKEhWQ+Yus2IoMC?=
 =?us-ascii?Q?KxhkBOypT0xMlnYInK4GYW6kGIAuCakl5oRtLeN0Uy7Qmz7Tj0i6jJu6jWI3?=
 =?us-ascii?Q?C5zVuTxALGmko6hVsYkruur5n+7GSQCyCxaUxvHAuKuHYAItbWZVF1b/r/Zg?=
 =?us-ascii?Q?mbZOa6rDX0YsuFd97BhA26o5sDO/C3mf4a5lB4XqDXl1lS1TNxiHIM5rbxU5?=
 =?us-ascii?Q?ZIycNtxTXcJhFvGo6dPO1EK4Cyq9MVmdVyEue9apyYKn6CpJxBXZ2OXwIA?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1beb6b66-927f-4087-29e3-08dbe3bd4253
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2023 20:23:40.3615 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mqt80v0MUTMymk3fI5VFkLrL6w5oS0VF0FA9PBR2CZt7oMoPv7hhralEYgWlBoTe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8786
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Roman Li <roman.li@amd.com>

> -----Original Message-----
> From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
> Sent: Saturday, November 11, 2023 11:01 PM
> To: Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Siqueira, Rodrigo
> <Rodrigo.Siqueira@amd.com>; Li, Roman <Roman.Li@amd.com>; Deucher,
> Alexander <Alexander.Deucher@amd.com>; Wentland, Harry
> <Harry.Wentland@amd.com>; Mahfooz, Hamza
> <Hamza.Mahfooz@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; SHANMUGAM, SRINIVASAN
> <SRINIVASAN.SHANMUGAM@amd.com>
> Subject: [PATCH] drm/amd/display: Remove redundant DRM device struct in
> amdgpu_dm_, mst_types.c
>
> Declaration of 'struct drm_device *dev' is redundant, as 'connector->dev'=
 &
> 'dev_get_drvdata(kdev)' can be directly passed to 'drm_to_adev', without
> intermediate DRM device 'dev' variable
>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c        | 9 +++------
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c  | 3 +--
>  2 files changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index adbeb2c897b5..39c73e5321c3 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -893,8 +893,7 @@ static int dm_early_init(void *handle);
>  /* Allocate memory for FBC compressed data  */  static void
> amdgpu_dm_fbc_init(struct drm_connector *connector)  {
> -     struct drm_device *dev =3D connector->dev;
> -     struct amdgpu_device *adev =3D drm_to_adev(dev);
> +     struct amdgpu_device *adev =3D drm_to_adev(connector->dev);
>       struct dm_compressor_info *compressor =3D &adev->dm.compressor;
>       struct amdgpu_dm_connector *aconn =3D
> to_amdgpu_dm_connector(connector);
>       struct drm_display_mode *mode;
> @@ -988,8 +987,7 @@ static int
> amdgpu_dm_audio_component_bind(struct device *kdev,  static void
> amdgpu_dm_audio_component_unbind(struct device *kdev,
>                                         struct device *hda_kdev, void *da=
ta)
> {
> -     struct drm_device *dev =3D dev_get_drvdata(kdev);
> -     struct amdgpu_device *adev =3D drm_to_adev(dev);
> +     struct amdgpu_device *adev =3D drm_to_adev(dev_get_drvdata(kdev));
>       struct drm_audio_component *acomp =3D data;
>
>       acomp->ops =3D NULL;
> @@ -10766,8 +10764,7 @@ void amdgpu_dm_update_freesync_caps(struct
> drm_connector *connector,
>       struct dm_connector_state *dm_con_state =3D NULL;
>       struct dc_sink *sink;
>
> -     struct drm_device *dev =3D connector->dev;
> -     struct amdgpu_device *adev =3D drm_to_adev(dev);
> +     struct amdgpu_device *adev =3D drm_to_adev(connector->dev);
>       struct amdgpu_hdmi_vsdb_info vsdb_info =3D {0};
>       bool freesync_capable =3D false;
>       enum adaptive_sync_type as_type =3D ADAPTIVE_SYNC_TYPE_NONE;
> diff --git
> a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index d3b13d362eda..e4dd0037bcb7 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -424,8 +424,7 @@ dm_mst_atomic_best_encoder(struct
> drm_connector *connector,  {
>       struct drm_connector_state *connector_state =3D
> drm_atomic_get_new_connector_state(state,
>
>                connector);
> -     struct drm_device *dev =3D connector->dev;
> -     struct amdgpu_device *adev =3D drm_to_adev(dev);
> +     struct amdgpu_device *adev =3D drm_to_adev(connector->dev);
>       struct amdgpu_crtc *acrtc =3D to_amdgpu_crtc(connector_state->crtc)=
;
>
>       return &adev->dm.mst_encoders[acrtc->crtc_id].base;
> --
> 2.34.1


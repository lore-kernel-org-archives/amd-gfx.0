Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6271CCA479
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Jul 2022 16:19:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7025610F0A7;
	Mon,  4 Jul 2022 16:15:44 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2059.outbound.protection.outlook.com [40.107.95.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B3B210E00A
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Jul 2022 07:15:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XaLFLlVQ7WJJft3azvxzA+QtPjjgbZ3kKx865Ut9oNn3K7KP9pCsmGOITwCFsHWzwEs46vINx/jpbCzbqbjJhuaIqJqLBJTxVVTS0POhFn0GIaqGBtu3dfkb8dbPniqSaJQi6HwZ9pDrbuGSYVmmd6q+TeZQZYBJrYG1qWYZdRrrs56bTEnWKr9ogrxCkbccfOHs/mDvsNGWBRtCXJPx44sPjmvOOYoEbuzd7hgkEtjd1Uplvt2eU4vvv2A5AT1zquw9GxlIEJUED9BDv/jU93Zz465xFlSMfvPY3IkUc/WK4KXk5kLIKiZnSr9ebjWZ0G0PLgIPyM9502A79/QUIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFi36mFBKCVuwOYkhfsdyFFrVpvKy74Rh56tC5TRFvs=;
 b=cG7nY9dnz+lM2dWOuhz2WdQSz8VfVo+yE7ZTBVromkK9PA30UeQs14nQgM8BW5WTsgv29u4HkSZkvTZfqMG/aWSUlhe+D0GKaI2mmEgZpkMmrfiogTBR5YgmMOH6zQ8K0lI5nrsRFxO4UjkmOdx79F4GAYa0XGk0ykX+qzF0vE7g8ktsCEv2KwYr7uEvjDyraESgJWuiadVpii5SddARb/63iKfiifMMiFPZqKtcOyDQNo9HDCPDdhQLMMT9HzcOtA9DO2qBm3hWtwho9SEoo6LmhaauevdSfydS6g2B++RKWkwamKPB5WHPkDBipoeqZuuye3JWaofzCBYGpAmr4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFi36mFBKCVuwOYkhfsdyFFrVpvKy74Rh56tC5TRFvs=;
 b=Y//nuPdO7pkbszHNCZwVaWo1zLSsqfcRlXbSYr7x8u6Er3X8nrMnECJ5sa4uSG0gwQYsdIM0Fsywz/X9OuQyiEcAZ2tDdG7FAeuhKGsE97qaTmvGod0iGK4cndbRenSoqs81v4Qo85wCJo3loUnG9nRBC+PSG4S6VjAoXulMcTg=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Mon, 4 Jul
 2022 07:15:25 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5ca4:efdd:b7b0:53c6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5ca4:efdd:b7b0:53c6%5]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 07:15:25 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu/display: disable prefer_shadow for generic
 fb helpers
Thread-Topic: [PATCH 2/2] drm/amdgpu/display: disable prefer_shadow for
 generic fb helpers
Thread-Index: AQHYi8LPmkexXXDKGE+MM31w3MarTq1t08OA
Date: Mon, 4 Jul 2022 07:15:25 +0000
Message-ID: <DM6PR12MB261947533596E98BF9043BF6E4BE9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220629141530.2501360-1-alexander.deucher@amd.com>
 <20220629141530.2501360-2-alexander.deucher@amd.com>
In-Reply-To: <20220629141530.2501360-2-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-04T07:15:21Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=73bb3007-87ea-40cc-a275-46ac246991fa;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4daf08d-e8c1-4ea5-210d-08da5d8cf789
x-ms-traffictypediagnostic: MN2PR12MB4406:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oI5EqHUtgGELYjW/t5VHB/bs6r62xXPVxfmL94ayJpyb41yDT61pMH/bST+PFNbPQfpMMPLFiU1CQGpwSUaHJIJtNewUD6w0agOM/ZhyU4hwtlCeLOtVeZHmwkFxlQrzXd+OYhp65pinOD9JjksRg01Ogeol3MCpE8nisjZj4xgWphBwTNFMhRsRHQgJcXif/uBv4VW/jxnid/fB1f2W3r/L0Hkrnyfo4j1p12Liz01A2XeNMVO1mwcDYnTXf2yQtl2EoSur/3Jg5z3S8OJu97kZUIGz87ybY8u9iGFtynoB8RSjI3+Hi2KxVrUTauj6lC2bqwo392OpoUy2G8XrogWJUbzvV9QtX40eF9DVLHeVyn411xd4lQpeJrqC5g49e80Xsy5NEW5a2xeihlBMFhqfpRUvJJMkTNu3ZPrmCfrGTP0/46Dath+14aI/YbSWs4rmoOPLk2OpzUmC/mJEHRu9P8t8YBPojwPFs/t7DwaBCgvvtr1BqM96RysM8RG3KmRRxT5RjnSz58n32l823AIlUs/Ho1l63sjDCcjjukE00LYUMkbrkKuCghvoKLLVeTUeLHG9XwnyRkoB6exq+SQtIlGLH4Otxac3CISLG7ynktn/L2br8Omrq7VZRQ/YoprUIGPlAbNdZG27kaqkb5cJ4UuqYzfucW4FIzonzJd16vP5SvUC5KNtaur/K7OlTgqab3oYnbONLPNYijK6cuUfOMaca3ImU3wFyD5f/YXrOrKB6MK2EYUPJEUqxpWYHk5lSbpg2a6keOOhfH29et12CLtcjuq+yFNCAl1tNpmgbNqpHVEz6YBm9qxAdgDMri53HL6lE3YlrCvtgQT4SmNAE5OTqubX5YtQeAl590OjkWNFdI1ZJmZJplfrsz8e
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(186003)(55016003)(38070700005)(38100700002)(122000001)(45080400002)(8676002)(64756008)(66446008)(66556008)(66946007)(4326008)(66476007)(76116006)(316002)(83380400001)(71200400001)(110136005)(53546011)(9686003)(6506007)(7696005)(33656002)(5660300002)(8936002)(86362001)(966005)(52536014)(478600001)(26005)(2906002)(41300700001)(41533002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DHmV9WFZOH5pTBIewcJDCrRnvyVtpqHY+rVNjP/AjOj0ytAQB9Kb+8bbl9Om?=
 =?us-ascii?Q?XUHSscBT12wNbJ/QsImIvoIxQ8okrNkhWw++MC3Llggz2dJ0XEQYBJTZa0Wd?=
 =?us-ascii?Q?lr+hpPZK+w+QWAnDwvlM4L1pF4WccmI2v8CnyQ2i+8gjU9IEwf015yxzmIFE?=
 =?us-ascii?Q?0CUQQ2i/MhP1i8SHn42lYeY/PcFSatm4gpgPwy2bJf/UK+5BdCtc+Ti577oz?=
 =?us-ascii?Q?HlRl/mgF9zI9up/lU3AIO21UcWRgf98AsDGmdNC0ZvYQr5HEJt1lOdXZ4y/C?=
 =?us-ascii?Q?kDxM30m37NDdu5Mh7vuJz8IWxh5ZBttZRgFc/flnlAmhdVAl6XGEqK/53pvA?=
 =?us-ascii?Q?vQk0aO6OGnAvKkT6PNmjANvZYb4nz5YybGDO6xAYElvM5VAA1DNfE7yOzkon?=
 =?us-ascii?Q?PxTyoJ3lhW82Q268eoTxeaAX8jVnmS9V5sNrBPh6QJduq4IDVr3PTPUPiooa?=
 =?us-ascii?Q?HfUFVbn3+rEFMccIJbOfMdxxzt22YgHGFe9ffxIpM42YmJH5nE0UOu59PZ8S?=
 =?us-ascii?Q?VZlwcVBpt6I1N/sbWTAGl4/slwtKIevAIwDkfk6tu/cfqcF6eBsdheTZk9dr?=
 =?us-ascii?Q?R+NdrejyVALdt3IkEobjtVZrYuMROFt+2hwr96moSckHy87EWtVspXRTJFJL?=
 =?us-ascii?Q?qT6MhMgOMoutgGGPoAl5uYeCm8XVhKHTcLmG+8nHFxeJQaa14A/gyudGLY0T?=
 =?us-ascii?Q?aXK27oMhNMNhLOK8gR5HOy/vO2fFFbdYuA+nPP2LV3H2yA5ku27bevjkdjoE?=
 =?us-ascii?Q?nZ7KVXQjQJND7FPYdzJe5cS9VHyEIOKuIkjfgzOYe8z6FlqUgx805cNewt4Q?=
 =?us-ascii?Q?eHmrB3RBmvtOQ1USoM56BcyKzyBBOY/s6fVZq0piMw1bdy6LCqiJvXMgUfej?=
 =?us-ascii?Q?rzwTYdrEhiv04Qyf7XMbpe0gt+KJrGf5lzfthynkeT0uhwtodZfOD7qa0rVR?=
 =?us-ascii?Q?zKT7nhiSaKHn3gmnTv6PSY/g5VyxvZn+yP/Cbcn2bRbDYvBGhNuvpwQjwAsf?=
 =?us-ascii?Q?Dc10EtWxPh8ci8MSSMZAbqrElCEvhQPczv+p6ak5sewnD/eorcCjBnaDnLuI?=
 =?us-ascii?Q?EDCIZayOe/r64AGm5e5F+41Ghn8TP702lVIAW3hMRwAbp+Rwk5YGlNvqMSaZ?=
 =?us-ascii?Q?ygKjFIjh2rlzoo+4B4JOlO3Q1YaOJp3fROj3pJfmc7MnTbbb6PSksz60OXHq?=
 =?us-ascii?Q?dg9IHMhshTNgLG2JATWjg8mzDOs0RsbCBKyBKtaLaWQy+fvS8BaHh8TYDVUf?=
 =?us-ascii?Q?3VGVFEX8rzVCGH2bqcC+ccRCGw/A+sC8kTo3Vdpc/J45er/tzQHHDB2V4SF4?=
 =?us-ascii?Q?E2m4aqZTAHXjsILxchouQCLjWMlR8IL3FzTyE35O7xn+LvB9hmuCsKhueI+f?=
 =?us-ascii?Q?gYNEXlCXR4VWEWa8nxDtOjMUZ32yw69pKXgcHB0bsrcFL3H7L1i8fK7VcMuR?=
 =?us-ascii?Q?atN29718lz4d0QQRkV/5c6mQRWi1S9hlELaBRNsaKFZEJDrPxustPO+AWxUP?=
 =?us-ascii?Q?j4AfNH8avgl63Dz1eHWra4aFel7dyXhrxBu/TyxC0py894rju4iDjdyMPsjG?=
 =?us-ascii?Q?TSbW2cuatSFNBYTqMDU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4daf08d-e8c1-4ea5-210d-08da5d8cf789
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 07:15:25.5954 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ujSQGxx1JJPGOKffc3YHUH+9mxkbB1AfzF9LiBmyDn9msHI2F26b5klm2kIJJIJ8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406
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

Thanks for the fixes! Series is acked-by: Evan Quan <evan.quan@amd.com>

Evan
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Wednesday, June 29, 2022 10:16 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu/display: disable prefer_shadow for
> generic fb helpers
>=20
> Seems to break hibernation.  Disable for now until we can root cause it.
>=20
> Fixes: 087451f372bf ("drm/amdgpu: use generic fb helpers instead of setti=
ng
> up AMD own's.")
> Bug:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbugz
> illa.kernel.org%2Fshow_bug.cgi%3Fid%3D216119&amp;data=3D05%7C01%7Cev
> an.quan%40amd.com%7C1f2762736c244dadb6ea08da59d9f0e6%7C3dd8961f
> e4884e608e11a82d994e183d%7C0%7C0%7C637921089829876781%7CUnknow
> n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
> WwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DWJLd3ZXE1URnAW
> n3CyX%2BaBdzVB4T66oun7lA7X9KPbw%3D&amp;reserved=3D0
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c          | 3 ++-
>  drivers/gpu/drm/amd/amdgpu/dce_v10_0.c            | 3 ++-
>  drivers/gpu/drm/amd/amdgpu/dce_v11_0.c            | 3 ++-
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c             | 3 ++-
>  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c             | 3 ++-
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
>  6 files changed, 12 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> index 576849e95296..108e8e8a1a36 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> @@ -496,7 +496,8 @@ static int amdgpu_vkms_sw_init(void *handle)
>  	adev_to_drm(adev)->mode_config.max_height =3D YRES_MAX;
>=20
>  	adev_to_drm(adev)->mode_config.preferred_depth =3D 24;
> -	adev_to_drm(adev)->mode_config.prefer_shadow =3D 1;
> +	/* disable prefer shadow for now due to hibernation issues */
> +	adev_to_drm(adev)->mode_config.prefer_shadow =3D 0;
>=20
>  	adev_to_drm(adev)->mode_config.fb_base =3D adev-
> >gmc.aper_base;
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> index 288fce7dc0ed..9c964cd3b5d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> @@ -2796,7 +2796,8 @@ static int dce_v10_0_sw_init(void *handle)
>  	adev_to_drm(adev)->mode_config.max_height =3D 16384;
>=20
>  	adev_to_drm(adev)->mode_config.preferred_depth =3D 24;
> -	adev_to_drm(adev)->mode_config.prefer_shadow =3D 1;
> +	/* disable prefer shadow for now due to hibernation issues */
> +	adev_to_drm(adev)->mode_config.prefer_shadow =3D 0;
>=20
>  	adev_to_drm(adev)->mode_config.fb_modifiers_not_supported =3D
> true;
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> index cbe5250b31cb..e0ad9f27dc3f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> @@ -2914,7 +2914,8 @@ static int dce_v11_0_sw_init(void *handle)
>  	adev_to_drm(adev)->mode_config.max_height =3D 16384;
>=20
>  	adev_to_drm(adev)->mode_config.preferred_depth =3D 24;
> -	adev_to_drm(adev)->mode_config.prefer_shadow =3D 1;
> +	/* disable prefer shadow for now due to hibernation issues */
> +	adev_to_drm(adev)->mode_config.prefer_shadow =3D 0;
>=20
>  	adev_to_drm(adev)->mode_config.fb_modifiers_not_supported =3D
> true;
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> index 982855e6cf52..3caf6f386042 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> @@ -2673,7 +2673,8 @@ static int dce_v6_0_sw_init(void *handle)
>  	adev_to_drm(adev)->mode_config.max_width =3D 16384;
>  	adev_to_drm(adev)->mode_config.max_height =3D 16384;
>  	adev_to_drm(adev)->mode_config.preferred_depth =3D 24;
> -	adev_to_drm(adev)->mode_config.prefer_shadow =3D 1;
> +	/* disable prefer shadow for now due to hibernation issues */
> +	adev_to_drm(adev)->mode_config.prefer_shadow =3D 0;
>  	adev_to_drm(adev)->mode_config.fb_modifiers_not_supported =3D
> true;
>  	adev_to_drm(adev)->mode_config.fb_base =3D adev-
> >gmc.aper_base;
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> index 84440741c60b..7c75df5bffed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> @@ -2693,7 +2693,8 @@ static int dce_v8_0_sw_init(void *handle)
>  	adev_to_drm(adev)->mode_config.max_height =3D 16384;
>=20
>  	adev_to_drm(adev)->mode_config.preferred_depth =3D 24;
> -	adev_to_drm(adev)->mode_config.prefer_shadow =3D 1;
> +	/* disable prefer shadow for now due to hibernation issues */
> +	adev_to_drm(adev)->mode_config.prefer_shadow =3D 0;
>=20
>  	adev_to_drm(adev)->mode_config.fb_modifiers_not_supported =3D
> true;
>=20
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 9195d6a8a51f..fb1e983e0549 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3818,7 +3818,8 @@ static int amdgpu_dm_mode_config_init(struct
> amdgpu_device *adev)
>  	adev_to_drm(adev)->mode_config.max_height =3D 16384;
>=20
>  	adev_to_drm(adev)->mode_config.preferred_depth =3D 24;
> -	adev_to_drm(adev)->mode_config.prefer_shadow =3D 1;
> +	/* disable prefer shadow for now due to hibernation issues */
> +	adev_to_drm(adev)->mode_config.prefer_shadow =3D 0;
>  	/* indicates support for immediate flip */
>  	adev_to_drm(adev)->mode_config.async_page_flip =3D true;
>=20
> --
> 2.35.3

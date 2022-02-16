Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D6CC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Feb 2022 08:27:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAE7610E918;
	Wed, 16 Feb 2022 08:27:04 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 813AE10E919
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 08:27:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ob4PBac9B6zKsGTXlVxzwtnqDCSyEMikyPqJmUYlJDiQkN3ptXy5x2nmvMhCWeSVh0u3X2ISQOCBVCFDfFdUu3+/KJ6jRgWxobO0DiGdaW+pg6bCBRX5lJbteSdGhy/SFwBe1nTvZ8b5fFM2md+fvOTMaqIcupE1u59mGG/q9yW5W/KUCbr7jcRsWydLfMCN9HQO5hlECQWZoO5QYvPmvFVnjj5PM6tQtJTIclYHdFy2VwMjXHmDnhZmstjcYe3Gz0KnFOWZB58SpTabKE9T3BW84BLoDoGzbUj7YE2XiCRnnmhPa1Ov0UcBejJNPIGU7U/OLBdUi0GNAg+jI/G//w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFj6/uF3kk7DT2bFXSCCTzQ4qHkfqScI/GUXyxyHTbk=;
 b=LEWZPTM/Qq54sr0+DOEdFHr4X1eclDopx5r5XSgqk3Szn2c2g5QRheT5P/Zfvu9TDEU5qrPzi9zh0hI1p5CcUgGp2pNkRo5Ti8+hQkoiPeBasY4Q1ttSif2K+uvgxDTcycRtNQj+OoRaqnLeVn4FBtwOPB8S4qJewz9cx7NSvzzo1Q7aEQ+tGjeH4C7rYEktHgMjCT1Qvcgn00GCB6DZJygqGLzzfeZwPuzPXIr+Nw0/Oin8t2R/eyQi6ffUGr85qQxRRSZNLzOwWHcgVKNPA5hNqM3k20L4Ech/62RmuOFNF0wwz7knR9lKk7EHVRenacR8EDQp9xQfxd2H4EyDBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFj6/uF3kk7DT2bFXSCCTzQ4qHkfqScI/GUXyxyHTbk=;
 b=is5KE6wlhH6KVqmw0Gif6N30ex2vRwEClynWjGqWsmesUx05XD56as1njcIxGRaw/Jqp7cx5EWpLxZqOwnPRS8eA5zLGZKrxKa+B6XSceNcCeqbTq+OqbUIwxlyM9N19rslmNcgNDfu4PWXZtlY7ZCWR162rx4FPwVsV0wv3jlY=
Received: from CY4PR12MB1767.namprd12.prod.outlook.com (2603:10b6:903:121::9)
 by BN6PR12MB1842.namprd12.prod.outlook.com (2603:10b6:404:fb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Wed, 16 Feb
 2022 08:27:00 +0000
Received: from CY4PR12MB1767.namprd12.prod.outlook.com
 ([fe80::4998:7ffe:1f45:598e]) by CY4PR12MB1767.namprd12.prod.outlook.com
 ([fe80::4998:7ffe:1f45:598e%7]) with mapi id 15.20.4975.019; Wed, 16 Feb 2022
 08:27:00 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2 6/7] drm/amdgpu: define amdgpu_ras_late_init to call
 all ras blocks' .ras_late_init
Thread-Topic: [PATCH V2 6/7] drm/amdgpu: define amdgpu_ras_late_init to call
 all ras blocks' .ras_late_init
Thread-Index: AQHYIwyAGYtnB6j8DkOJEafqNaXrrKyV10Gw
Date: Wed, 16 Feb 2022 08:27:00 +0000
Message-ID: <CY4PR12MB1767811C711ED0AE34109EE7B0359@CY4PR12MB1767.namprd12.prod.outlook.com>
References: <20220216080804.3560484-1-YiPeng.Chai@amd.com>
 <20220216080804.3560484-6-YiPeng.Chai@amd.com>
In-Reply-To: <20220216080804.3560484-6-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-16T08:26:57Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=5177f79b-71c2-4e67-abf5-d4eb6bf7dca0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-16T08:26:57Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 461a98db-0669-417b-82ad-85da8861260d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 370e36ba-19c7-4431-bc99-08d9f1261a89
x-ms-traffictypediagnostic: BN6PR12MB1842:EE_
x-microsoft-antispam-prvs: <BN6PR12MB1842B9DB3F3F512C85400E3BB0359@BN6PR12MB1842.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WjTCggrZtXoN1Rny4pkgeRveYf1bMgrBhLCM2iUibYN+rh8+lf02lldYPXdVo7fXwpRmlgNTPmbuuj3l3aTyPDWxcdA9toZQuAwFe7DSI8629C/ByvBrAFUbRB8YoqOanJvLT9KsAi6C5PcJM8s1PiAYfczi+adFmJu8nzoyU2VMGbnO+jULKwh5UKNT0508NFE8BkfJmvcPQedxYUipxf7tX3Px0nJvcewNOOsfnGFUZBC8Od9S5T7rZgh8AdcjZD1ophG12oiO+JpWFcEiYI/wxaz4UXcCF1GdAEdDJIomf3sFziusQy5mLuwCP2/3bytHPyyYNRf1tx74FOTQL+rUvBOYtBYphB9hqK8axhpvlwWjjOQhEKQn/8Rs6WJXk2/3W6a05xAqOK1LhVJP9bH4LzCEmCMe1WrImf1aaiZRusKCk6GKSaSWDmmMg9X+bSoJQJujPN5S7OZqLKzlsYnGiPl13CkozbXQS58eSBiX68VqYYcwQjlCjNQ0sSfmMWPY/iSz9jd5SVTJUnyeCB3kmEtMUa/b6oqm+wTOrR7A5r9yfdAIcaoA03Gu1/z+XManAkJyyjFVxtBECJvfy1+WEd8iBbJKjStePQ/T8lne7UDEfCMFGrA1+zMdBGCSwvHCIrJj3zw2cl3IfYmayTWW0oW4qvw/REmKya/u1FZvmifBG8BPWIcGHTmyYGRWMn7tMIDxqjvPuWRIbAv7IA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1767.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(110136005)(508600001)(33656002)(26005)(5660300002)(186003)(8676002)(4326008)(66556008)(76116006)(64756008)(66446008)(71200400001)(66476007)(54906003)(66946007)(2906002)(83380400001)(55016003)(9686003)(38070700005)(7696005)(6506007)(53546011)(86362001)(38100700002)(122000001)(52536014)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?swAFsd6sy3TV1zxAJtP6vLQItPS0CWcsMatd0WZrjw6k7+/T6x/zd9clRN24?=
 =?us-ascii?Q?+wgWydwSitb0ATE5NDsnFACqMKPW4/skN94IsWwUzE01wOFTpwfQ07kqZXXN?=
 =?us-ascii?Q?fstzJMvrA47bpWlhHwsolby1Hezdl4+wNxPULEWr6EMGgJVisq9zg7IRmpV/?=
 =?us-ascii?Q?7Ql/2nUsgYxgDKTwKqxC9eB6rQjhrIUBxN8rJOhJ+1qcc+81fTpqrmh7dnxn?=
 =?us-ascii?Q?0ImOimMrF2jl5sm4lUnGlbW414FLb2yd1UwIJAWw1KLCszX1E8xpZ4v2ky+2?=
 =?us-ascii?Q?vK8FfVq6VxuJTM882ERSD4L0G7uRg9zpxlO4mYNicrfEdCaIy3BWmx+JL4Sk?=
 =?us-ascii?Q?w7fv9jl12QkQnymBFHZhHKNyRE95nZp6sVucgeGedFkE6qIglEaEVAUtr9qQ?=
 =?us-ascii?Q?iT9qqA7mrMVQ5Oa0U+K5A6zYIVEaAgWMgpDZRNMNvOwky32EnZaCsRcWvsfb?=
 =?us-ascii?Q?FeJ4/shpLq3oBkcCgObuVFIU/Gx1gssKc8mgsjOxCCYS2fv5rmdvo/F4Fomw?=
 =?us-ascii?Q?S0UdsXSbhi6hmHmSB5oiS7xzR/IXul2WnT2/tH4XDuMuMHPh7tZs84p2jU8n?=
 =?us-ascii?Q?j5rBoQBA/FwVB4UbeFQiH6CuXxxQHNYYVSBN695vpfz8b89oi+1Z4dv/1Ufg?=
 =?us-ascii?Q?+zbsUKbD903FLi8L5rstVd7yClTHexFqO0k0AuH8nRan/i9SjLkVK6G3FRtH?=
 =?us-ascii?Q?Zy9r0AYklKTWya8SgF7ywSPn18Z/KeT9qSKDSOcWaFm7I+YZP89hBtqTch2E?=
 =?us-ascii?Q?ZCPf7+OPGFO31QGrj017OUvxCT6L8fTGjnsbM80gOkAfVpP5MfV2eXb+eqg2?=
 =?us-ascii?Q?nNJkUZY4YcXLuxBUldU1JcyaoqlsFr0J3s6whjgx0jfC4UzfmtRsHk+3sPjs?=
 =?us-ascii?Q?HExDCaCjiahFMmLkDSGd793TPx04A7NLZA+oZ3xGY63KLMma53p/wdaeNDkf?=
 =?us-ascii?Q?4UOcWtjRdcFY8YvjpJTW6tOVhpivFMH0/UKghMf87JcLTINzy8rdGUd54sC7?=
 =?us-ascii?Q?aEov/MBDMQSVKTzbyHUZJYcG0f6qCmAl+z91CzfrBZKObw9SHJ6VOv6AK1Sr?=
 =?us-ascii?Q?iXGDpNI5NigmGbo9cwzjE6NVintwQ0H2HyxTul+Jvfd9k3gtlHSVlFbS0UkU?=
 =?us-ascii?Q?PjUV+2p77GlfPrUxAJgYB0w9h9h607y8rNmRzrAbWCGJ1oHXMC5dcIYJYrkg?=
 =?us-ascii?Q?OcUAw0aGF5EuCNtt103LN+uJqYpgrLtPWTkK9bRGu5WqJmgJIAJIAWrDurjD?=
 =?us-ascii?Q?bQlr0FGSGeKay4LBWrfaCkzw+vEclxuCyuvf9g6UX4t2zdohFnaOth9BmHAj?=
 =?us-ascii?Q?Ib14SxkA25+alywfA++JhDVEN2TvPCE9KhU9eAK6iMI36h4MVt5Crg6Bhwc+?=
 =?us-ascii?Q?+nFQBA/cFvuUBtx7RmtMjUwdy2To8pzJW394OebkDz6aRf1NDwZ5/8VAR0F5?=
 =?us-ascii?Q?0jOQo/eZ8DVRMga8iGoWDAcBbw11I5HC7qSETaKcu67idspGXvMwRBXyj+E2?=
 =?us-ascii?Q?HpSPuajrRrMgafCWMok10WP7tq5BY4TiA99Fg20yQDp5mcYeom+/CtGb4E/c?=
 =?us-ascii?Q?VoNphkRoIIcTSTO9Lio=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 370e36ba-19c7-4431-bc99-08d9f1261a89
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 08:27:00.4358 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cQu7Z0G+3AQ9r4gDcwKLqpipikDsyPEIwFOesNCsujXwAFznt2P9ezXsmK0fHEra
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1842
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
Cc: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Clements,
 John" <John.Clements@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

With my concern in comment fixed, the series is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of yipech=
ai
> Sent: Wednesday, February 16, 2022 4:08 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Clements, John <John.Clements@amd.com>;
> Chai, Thomas <YiPeng.Chai@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH V2 6/7] drm/amdgpu: define amdgpu_ras_late_init to call a=
ll ras
> blocks' .ras_late_init
>=20
> Define amdgpu_ras_late_init to call all ras blocks' .ras_late_init.
>=20
> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    | 44 ----------------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 25 ++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h    |  1 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      |  6 ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     |  5 +--
>  drivers/gpu/drm/amd/amdgpu/soc15.c         |  6 +--
>  7 files changed, 34 insertions(+), 59 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index a74a1b74a172..d90388dd5362 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2625,6 +2625,12 @@ static int amdgpu_device_ip_late_init(struct
> amdgpu_device *adev)
>  		adev->ip_blocks[i].status.late_initialized =3D true;
>  	}
>=20
> +	r =3D amdgpu_ras_late_init(adev);
> +	if (r) {
> +		DRM_ERROR("amdgpu_ras_late_init failed %d", r);
[Tao]: we already have debug message in amdgpu_ras_late_init, I think the p=
rint here is unnecessary.

> +		return r;
> +	}
> +
>  	amdgpu_ras_set_error_query_ready(adev, true);
>=20
>  	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE); diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index ebf4194b0699..49dd81c0db2d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -449,50 +449,6 @@ int amdgpu_gmc_ras_early_init(struct amdgpu_device
> *adev)
>=20
>  int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)  {
> -	int r;
> -
> -	if (adev->umc.ras && adev->umc.ras->ras_block.ras_late_init) {
> -		r =3D adev->umc.ras->ras_block.ras_late_init(adev, adev-
> >umc.ras_if);
> -		if (r)
> -			return r;
> -	}
> -
> -	if (adev->mmhub.ras && adev->mmhub.ras->ras_block.ras_late_init) {
> -		r =3D adev->mmhub.ras->ras_block.ras_late_init(adev, adev-
> >mmhub.ras_if);
> -		if (r)
> -			return r;
> -	}
> -
> -	if (adev->gmc.xgmi.ras && adev->gmc.xgmi.ras->ras_block.ras_late_init)
> {
> -		r =3D adev->gmc.xgmi.ras->ras_block.ras_late_init(adev, adev-
> >gmc.xgmi.ras_if);
> -		if (r)
> -			return r;
> -	}
> -
> -	if (adev->hdp.ras && adev->hdp.ras->ras_block.ras_late_init) {
> -		r =3D adev->hdp.ras->ras_block.ras_late_init(adev, adev-
> >hdp.ras_if);
> -		if (r)
> -			return r;
> -	}
> -
> -	if (adev->mca.mp0.ras && adev->mca.mp0.ras->ras_block.ras_late_init)
> {
> -		r =3D adev->mca.mp0.ras->ras_block.ras_late_init(adev, adev-
> >mca.mp0.ras_if);
> -		if (r)
> -			return r;
> -	}
> -
> -	if (adev->mca.mp1.ras && adev->mca.mp1.ras->ras_block.ras_late_init)
> {
> -		r =3D adev->mca.mp1.ras->ras_block.ras_late_init(adev, adev-
> >mca.mp1.ras_if);
> -		if (r)
> -			return r;
> -	}
> -
> -	if (adev->mca.mpio.ras && adev->mca.mpio.ras-
> >ras_block.ras_late_init) {
> -		r =3D adev->mca.mpio.ras->ras_block.ras_late_init(adev, adev-
> >mca.mpio.ras_if);
> -		if (r)
> -			return r;
> -	}
> -
>  	return 0;
>  }
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 1aff88fcea76..b5286a0d9c8a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2522,6 +2522,31 @@ void amdgpu_ras_suspend(struct amdgpu_device
> *adev)
>  		amdgpu_ras_disable_all_features(adev, 1);  }
>=20
> +int amdgpu_ras_late_init(struct amdgpu_device *adev) {
> +	struct amdgpu_ras_block_list *node, *tmp;
> +	struct amdgpu_ras_block_object *obj;
> +	int r;
> +
> +	list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
> +		if (!node->ras_obj) {
> +			dev_warn(adev->dev, "Warning: abnormal ras list
> node.\n");
> +			continue;
> +		}
> +		obj =3D node->ras_obj;
> +		if (obj->ras_late_init) {
> +			r =3D obj->ras_late_init(adev, &obj->ras_comm);
> +			if (r) {
> +				dev_err(adev->dev, "%s failed to execute
> ras_late_init! ret:%d\n",
> +					obj->ras_comm.name, r);
> +				return r;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  /* do some fini work before IP fini as dependence */  int
> amdgpu_ras_pre_fini(struct amdgpu_device *adev)  { diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 837d1b79a9cb..143a83043d7c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -595,6 +595,7 @@ amdgpu_ras_error_to_ta(enum
> amdgpu_ras_error_type error) {
>=20
>  /* called in ip_init and ip_fini */
>  int amdgpu_ras_init(struct amdgpu_device *adev);
> +int amdgpu_ras_late_init(struct amdgpu_device *adev);
>  int amdgpu_ras_fini(struct amdgpu_device *adev);  int
> amdgpu_ras_pre_fini(struct amdgpu_device *adev);
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index bb40ab83fc22..1997f129db9c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -4791,12 +4791,6 @@ static int gfx_v9_0_ecc_late_init(void *handle)
>  	if (r)
>  		return r;
>=20
> -	if (adev->gfx.ras && adev->gfx.ras->ras_block.ras_late_init) {
> -		r =3D adev->gfx.ras->ras_block.ras_late_init(adev, adev-
> >gfx.ras_if);
> -		if (r)
> -			return r;
> -	}
> -
>  	if (adev->gfx.ras &&
>  	    adev->gfx.ras->enable_watchdog_timer)
>  		adev->gfx.ras->enable_watchdog_timer(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index af5a1c93861b..e26c39fcd336 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -1894,10 +1894,7 @@ static int sdma_v4_0_late_init(void *handle)
>  			adev->sdma.ras->ras_block.hw_ops-
> >reset_ras_error_count(adev);
>  	}
>=20
> -	if (adev->sdma.ras && adev->sdma.ras->ras_block.ras_late_init)
> -		return adev->sdma.ras->ras_block.ras_late_init(adev, adev-
> >sdma.ras_if);
> -	else
> -		return 0;
> +	return 0;
>  }
>=20
>  static int sdma_v4_0_sw_init(void *handle) diff --git
> a/drivers/gpu/drm/amd/amdgpu/soc15.c
> b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 464d635a0487..ba983398c9d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -1186,15 +1186,11 @@ static int soc15_common_early_init(void *handle)
> static int soc15_common_late_init(void *handle)  {
>  	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> -	int r =3D 0;
>=20
>  	if (amdgpu_sriov_vf(adev))
>  		xgpu_ai_mailbox_get_irq(adev);
>=20
> -	if (adev->nbio.ras && adev->nbio.ras->ras_block.ras_late_init)
> -		r =3D adev->nbio.ras->ras_block.ras_late_init(adev, adev-
> >nbio.ras_if);
> -
> -	return r;
> +	return 0;
>  }
>=20
>  static int soc15_common_sw_init(void *handle)
> --
> 2.25.1

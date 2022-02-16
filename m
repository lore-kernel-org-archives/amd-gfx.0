Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C04B3C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Feb 2022 03:06:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A05610E12B;
	Wed, 16 Feb 2022 03:06:50 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC58810E61C
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 03:06:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/xzwqWWNhYsMonwM+u7Tj9Y9uG1nWmtDa6st7fi9JwV61Q6nHwA5fMNJ0wIE4Z33FRISL7aUzGtzsYPbItdg8UTftFq3Kv9L75aCSRpKWyRBW8a4ksJOOLibgXFpB5styS8xk/WvrXIBk8x+hOLabeuZcSGSaO1SzY18GA1nIx5x9TVLCU3082yTHZYUCaw1FeFJfZ4e1fevwFQLnFpnAYlcg4MCvu4l5qED/z7TU6sLFilz7rn1+fqYxWOb6gUWckZOZ4gZyq0LZVsbMNuFQVXUv5gX2/8DJLP9+c7DjIawNa8uSgz3BjdeR3kKxul4AfoAGIrsIIv6uH6dY3KoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBza3DCsU7VRi3Ge13xN25e+QzbTlFG8sfyuSbyqAdE=;
 b=DUDR1R+2VIf17XaqY92CllvgRcxp602CCCit6qpovTCWWStpkCcr12++YBptnehqIWszzxZeFA+bpk2P/MSs+vOWcBy5Ka8Hpkr8AwygkiSLIeNM4cyBUs1EjCqEGEVXggNuriFHII/XtKm2f056hr9Cc9K3vvHKQY8vBWEFBmfq2EoVl1VdKkLbRt+JWuzd9LsDkVnn+Hnyvgx7e10JUouB8pxEOC4ZhJUB5WTsk2G0ce/DqsElNKAEHBFPu2m1po2rIT4LR8TRpW1oYFdZypuNqNnh32B+m0R50/13NyQSJT4TipzNxmtCPJjCaD/UiLd2ycoJlMO++eEVl2VrkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBza3DCsU7VRi3Ge13xN25e+QzbTlFG8sfyuSbyqAdE=;
 b=Si6OLPK5E4tXjiNCYFK/nWFtLlL/nNqoyWbyEd4HMMH0h9JTWWII3GM2GBGdOlNsholOjCm/pB7VsY/Q/VluTUsqjX9OI9p3DmooCcc8X7zci1Z/LkKswcCoBFjL3ee0RSHS5A4XJR9S7Hk7M83PElJcMm6rEmsqw8ffCZqYhdo=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by MWHPR1201MB0270.namprd12.prod.outlook.com (2603:10b6:301:4f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 03:06:41 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f%3]) with mapi id 15.20.4975.017; Wed, 16 Feb 2022
 03:06:41 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 6/7] drm/amdgpu: define amdgpu_ras_late_init to call all
 ras blocks' .ras_late_init
Thread-Topic: [PATCH 6/7] drm/amdgpu: define amdgpu_ras_late_init to call all
 ras blocks' .ras_late_init
Thread-Index: AQHYIj+PSdcpd+7ygUqvqO0tX0OehKyVf2xA
Date: Wed, 16 Feb 2022 03:06:41 +0000
Message-ID: <DM5PR12MB17705C6357570B0A9BF02CDFB0359@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220215074124.3411761-1-YiPeng.Chai@amd.com>
 <20220215074124.3411761-6-YiPeng.Chai@amd.com>
In-Reply-To: <20220215074124.3411761-6-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-16T03:06:36Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=bf542317-7c25-4877-9a5f-90cefca22e19;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-16T03:06:36Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 73e02ad8-e1e3-4b22-a788-3835743c07c6
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68d0ce36-a695-4611-47ef-08d9f0f95b2f
x-ms-traffictypediagnostic: MWHPR1201MB0270:EE_
x-microsoft-antispam-prvs: <MWHPR1201MB027054BB75DB9D9552FCFFFDB0359@MWHPR1201MB0270.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:124;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: flWFQP0JB3FBIgRpllAzj/yoDHeqE0acahpEUbKL4YwEi+U790eYDjNJ5/no7igBCSXRaF1b4XUzlIZDWGPmv+EYeWHZjvRLz6iwiwsf+jPp37S/Hp4kbq07ka6QaxXcbk1CxoL3QUceqM2wm9MsY2PO8uc5lDbPJMDoHukAZMFGwdfq6REbx/WeQRbpJBklVuJqxq+jTYvDD4bTE6jwQ/OODYVd8g6s9/FZDNQOk2m9pp3cAFxCgUrb9nCKMJKBU2uzrxLNX7RMWgzpRaROMwkDtIUEhovY+VjdZW+Db6eWxEoWbsXU5neOhWRAt0new9wCgTRkM/CusndpThMRgn52fKX1cZziaUZUhN/x2x55IcoX8j5Y7+rzGDYFWmUL5nyS+yppjEpOEq+p5JhItVd5QIgsTVAI6Kl3KjH0jmw8Tuh6nKpF2Irhp1GTgzLcPTyBdSe8e1xbMu6JZVBGpKPZbRxFtrlTgJQKR/dC/xaLmzsY4dxj/+MSGf+Wpgwfq5hXi7j6j8e8LbDSYZs20NRMB28xTMFMnpENbg2ns2Boj7VJ2zlxPdCEt17aQpWfRlrsVH7zMTTg4viheMtw/WnSXuIp8q3zkFQUvPdNR/KQejBlLrJAylzUEMVrr9iQjXIWYtstoWbIIYrmfETlLB0UCpGvVSMIbxhALKWKvyBMtKD7nGKH4kM2Vina/RU82t6+GqrJzzFjhu0IShcaIw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(2906002)(9686003)(316002)(55016003)(508600001)(53546011)(83380400001)(5660300002)(26005)(186003)(6506007)(33656002)(38100700002)(7696005)(54906003)(38070700005)(110136005)(8936002)(71200400001)(66946007)(76116006)(52536014)(64756008)(8676002)(122000001)(66476007)(66556008)(4326008)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F0tfBzYfTmRc4//xLEwdCUdxag4/b1G4Usqg0aw2GVB06aHZfbdwXc359oWK?=
 =?us-ascii?Q?bmbcdL9fxqL4iy5c1ajxs0UWCoZp2wI5u4U5Ygtiy73MA2fowS7hst3aGJHr?=
 =?us-ascii?Q?b5lDwHjC8SM4MLA61Ob+yLcZKsxwnvbuuo0hTZDMPVIOY74j46u44r9cOiMc?=
 =?us-ascii?Q?7twf7REWdF8jFPaVg/3QigUdnAxe0rkSDYsD7YTpoAtfP21VsUy+q4LO6m3l?=
 =?us-ascii?Q?1ATG4RI0/sttYBROcXlmcyce2dzAAMob1nFLhjbCDb3MBNwBExinR0a2008w?=
 =?us-ascii?Q?SCeLkT7m9kzVxA7TMA9n77ZnILFj3Mz9c48QLwT8WoXYT46xCx4wH0N0Lpme?=
 =?us-ascii?Q?dq33SFholudCjuAHBkYNHJuhTFqJYTCq2opLwLoXlsF3rFsZaf7/VtZg/+IR?=
 =?us-ascii?Q?UK1BtIRFIiJL/K+gfOQ56F4yDAG13kcALgMsNSn9FVvvz4+sHK6U7seUiH/v?=
 =?us-ascii?Q?BsC2s8f8o6v8NsSsb3d1FEf0z5OVC85psX8ztb9bazpZWv1EXfv9ZDrjbe3O?=
 =?us-ascii?Q?KaJ7fJpjtn6npDc/2HXC75ULVzMWLm0fs49IjUL4SBSsx2OFbh6Ucw72llXh?=
 =?us-ascii?Q?MqtzvI0EK4jsiPo3cv7dgGOpudt0lbhgFcPkCktMnm5tF15wWGQiZ5Rsf4ao?=
 =?us-ascii?Q?G432K3VeDjbOkWjvjX6HcsqiczkG8S3XvYYFNpolDTM/RxbGzHFq42Yke2uJ?=
 =?us-ascii?Q?T3epqtNDPBPkRSTzningVt6gTuNxsxVu1hLBVlNdK+RTk2rNj0CCkr6ObQbv?=
 =?us-ascii?Q?w90G/MgcExeFkymm2xIPMAb9A9b4b8V4WGWR8gm8wz8XNSEtEBIwZ/1pUtDU?=
 =?us-ascii?Q?XVpiqH2zY6zG1974u59FKLg+qTkLz83sIS2ZlSZu9YMotaH+ZrZCNjyrUbCq?=
 =?us-ascii?Q?QyvGDX3eZm37C6la8UYOU2DHulrjumKRkVdJqMRTWM/J9B78CqXCWFi+yOuv?=
 =?us-ascii?Q?Ntq9UylCMmhvjn4ZgenSaxlV9DdTmRKFS+lJDsZIK0tHy6VNdgS0oiYKWBVN?=
 =?us-ascii?Q?OYJ+2nkHT/k+5hO0IwNE13HEJLcpQ5qMs3K1LoX94hr36EnMRUq+jtpocSK9?=
 =?us-ascii?Q?42VZ6jHlZINfnCmLzHcF/jHfVmHwOzbtyMmaP1MYPV9ZiVr0DoIeugKxI0B1?=
 =?us-ascii?Q?QZFl3IDNaUQmLNP6qye6qSny/sKwb5ysJGyV7YB/xDvrGUKYMeEUgeRqbO1c?=
 =?us-ascii?Q?DsN7IijpHoGNSiQE8lqLkLlwbaGEJpJsYvIKy4TWxAWl6CAydHJ3HPbU205H?=
 =?us-ascii?Q?18jqSR7a9ckeK3d6oY4aNBpEJP7ZxbenB66GQkdoLe06JvlycRYxl7b3a+UY?=
 =?us-ascii?Q?nQYfClu0TR8DuzNjZR/LaQveiV6IwGdcRb1tP14OVGlQ4yIGnz3ZXfDy/cZ1?=
 =?us-ascii?Q?eX6KOpYGMi/43BebsXcZaygC0xnhpMOptm8O8OKOGg5tQtVU/Cw6a47oMmRG?=
 =?us-ascii?Q?PILRADZJwi5G11xvQTUOjEsO037RoHvLS1uKLGbDRvAZjn0SNNisO5gZ0Ykt?=
 =?us-ascii?Q?v5BgP65CdBy8z1nEAcaV8A0ugLlEKNg43j/HNKb/6IV7tvOXdu88+ghW74gG?=
 =?us-ascii?Q?41J05LpgwOPMb2VuMUA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d0ce36-a695-4611-47ef-08d9f0f95b2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 03:06:41.5734 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zm9z1pJrxKBKFPuCPAx6GR+dnzMMZq7wmy4TQ97TxJvrzRIgbzQop2s4++u3Bdi6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0270
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
Cc: "Clements, John" <John.Clements@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]



> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Tuesday, February 15, 2022 3:41 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements,
> John <John.Clements@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH 6/7] drm/amdgpu: define amdgpu_ras_late_init to call all =
ras
> blocks' .ras_late_init
>=20
> Define amdgpu_ras_late_init to call all ras blocks' .ras_late_init.
>=20
> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    | 44 ----------------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 18 +++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h    |  1 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      |  6 ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     |  5 +--
>  drivers/gpu/drm/amd/amdgpu/soc15.c         |  6 +--
>  7 files changed, 23 insertions(+), 59 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index a74a1b74a172..67ea23dbc618 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2625,6 +2625,8 @@ static int amdgpu_device_ip_late_init(struct
> amdgpu_device *adev)
>  		adev->ip_blocks[i].status.late_initialized =3D true;
>  	}
>=20
> +	amdgpu_ras_late_init(adev);
[Tao]: do we need to pass return value here?

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
> index 1aff88fcea76..6cb1e5d126d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2522,6 +2522,24 @@ void amdgpu_ras_suspend(struct amdgpu_device
> *adev)
>  		amdgpu_ras_disable_all_features(adev, 1);  }
>=20
> +int amdgpu_ras_late_init(struct amdgpu_device *adev) {
> +	struct amdgpu_ras_block_list *node, *tmp;
> +	struct amdgpu_ras_block_object *obj;
> +
> +	list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
> +		if (!node->ras_obj) {
> +			dev_warn(adev->dev, "Warning: abnormal ras list
> node.\n");
> +			continue;
> +		}
> +		obj =3D node->ras_obj;
> +		if (obj->ras_late_init)
> +			obj->ras_late_init(adev, &obj->ras_comm);
[Tao]: check return value?

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

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 503A7C43334
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jul 2022 04:03:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9532710E5D6;
	Wed, 13 Jul 2022 04:03:27 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1BC910E380
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 04:03:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PitBUkDInvBTMU7P1DXvKlet63a8oV4M/8DTsqwnfRC1erZti3GZDtnG8M5JKmPRVnVp7Q//AKZZYyU0HczIjzhCwWhTjH6FNsAlrQS6FzJNdl/zlaZCqr3Oy3xOK5V2DGhv9BJE+bP2E8yfmQE9TU++GzlUMPoiAkGVCDjSVwGspCB0uJ8OuaixX/MHYZwoYyY1me5b8PIDlVb/loiuwViDz9SmN7rxu79MJcfFuBfHAbcUPtH82GNi6e7EhmtgrIUA9Lbe78vJtMJjSs2W/DLc8Fg/ZiXRqGBQdpK33FYlki19pRCOUM6Z53hMw7vMLG7cJ829IT1CXuO4b//dwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KocwyReySX+ko7PXn1luibhiLVj8HjoGobHrAQGyRww=;
 b=aX3vB73ucHNUg2oOQE/HrIlmAYmbgo+qKvo2UGptyVz4Gn/yCFdXdcknzJlv60sMx9yLoiuj8qeXvGVEXM7eV9/+UI5agjoOroewAYe4mb7hhHBGY23C7oECGUQLscD83i78xzcQz0GLgvhLvSEq3wUtz/44Lvycoo9SiaVcCbiMeRJOSk1dxOejuhQ7Kef5LImdfeqp0N4RYMO6sjWE34OtntYQK0q6MtsDZCmg+IxplUx757iQ+/EDw3b4MUIoTz8lNXn0OwtUTw5AUpLfm5XmsSnOJ1sIuU9Ys/gVD9kVeqJvRK7t5rZWeLnPHvuOS6sHyBhYmx3jmwPnjIC4Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KocwyReySX+ko7PXn1luibhiLVj8HjoGobHrAQGyRww=;
 b=SOd+a/aIecQWMQPZfSbqLbhdbH0RrjZiyKAPy3T3xEofD3MdGknkhJVPwqEaGMbknYNKiIsn1egzi6vAFVCjLUXrPSmHs0twG6dLEiouSs8pSsVEtvLLVNbQn1S8GeG4y5kj7AQAWSOHMjTVHiVtUF3itQg1fLn4bX/5l11WqxU=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by CH0PR12MB5235.namprd12.prod.outlook.com (2603:10b6:610:d2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Wed, 13 Jul
 2022 04:03:23 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::842e:a003:5277:5dbb]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::842e:a003:5277:5dbb%9]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 04:03:22 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: add umc ras functions for umc v8_10_0
Thread-Topic: [PATCH 2/2] drm/amdgpu: add umc ras functions for umc v8_10_0
Thread-Index: AQHYlmhAsYE7EO3TmEiG9OZluTC0v617rfvA
Date: Wed, 13 Jul 2022 04:03:22 +0000
Message-ID: <DM5PR12MB1770AD7C51A6514CD78D2D48B0899@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220713032509.293402-1-YiPeng.Chai@amd.com>
 <20220713032509.293402-2-YiPeng.Chai@amd.com>
In-Reply-To: <20220713032509.293402-2-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-13T04:03:18Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=cbe71c7a-3e73-43f0-b226-ff7654115ded;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-07-13T04:03:18Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 0272eecb-a409-43b6-b974-d99ba524e85a
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b6b96e9-057d-4b5c-6a2d-08da6484a112
x-ms-traffictypediagnostic: CH0PR12MB5235:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: umTfjeckm5+uq8eVfM9mMCKznGQfdNdMheTl9mhA0yeIyvEt4KtUO9GiIIVWYpGodCmL4zp5sikmkZ8ZKgbz93Q5PokHAOyWTRx1+Jdpk1nxhVvzXpIxW64ce8Ds3eg5JGb1hQwObr0G0Y9JTAk6xfhUIfatSdYQUIMj0jXz6yvW7x2lYDuhRJW0zXldm90tmWXi0IZUMJl4N0//hmApaaVV2OXnPeiIyEndzvoScU72IY2Etk04T02Zq6598thL6NOxvT1lmH0bmcKL3AKcgNGPsIa0m0/mZ1uKWdAdri9yJLcwV6lynTnsKNX12YMyDiHjsQNDxspgt9sE9FmQVVkkOnhnBx2WY7ppJzvsDxsAD9qlhXcjMdVTUVJkfIacLuXXEyu3cpTLEO1np5fCs3nnl1a+AWFf6poEHVF11ibrVMfNXrimOdHDudg7mTPpb4uMoUg7UwrjTtFvc+IBI702YYcFEPg0GYvAUxeLspy8OID3sjUiqVEwCBOAvEGMn3W1q4qYBOLhDIh0gy+mlsHLZKKWbTQ9ApAKTTpXkjr/02Lgz/6su22cpRKkDomTNPEf8ZGmy8xDTbiIo9vVBA39KsZiRztUwfLV7/0ndpu66xMSz6rqearu3h09QiljQz5t0jJaRxe4RAEEn5riyPncJOIXZe23VjcfIAf68/NcfXrzN3xVE/8EiEV3VD1/XmBTjWXNzO5xyXgH3R1qmvKjPQZMqNnRLfYCqYK+elA5m3tu0nygF2QP1qMtjNeQth8r1qNtGtCPev0tOx3DOcwdu7o0NGWgh9hGn1gEzUaBkxNgTG03MQv/pX4+FR0l
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(54906003)(478600001)(110136005)(71200400001)(38100700002)(122000001)(76116006)(7696005)(186003)(64756008)(41300700001)(66476007)(66446008)(33656002)(86362001)(8676002)(4326008)(66556008)(66946007)(316002)(30864003)(26005)(53546011)(5660300002)(52536014)(6506007)(2906002)(55016003)(8936002)(9686003)(83380400001)(38070700005)(559001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e9DlXhnGVyuKuSCVe5CxBOoQlHgkUZM7Bcle9Zzikuk9029DBhWQ5uUmja6f?=
 =?us-ascii?Q?lJg3eM069plhIRnstbmg32yD0nN4Ptch/KaX95bDHUxVlQ4jp0KRztQaH0+m?=
 =?us-ascii?Q?yAd1+NgIwTTBnao5NrE84BW/P3EX6jjSDYEH7AEKjeUeeRKployH8mRBij1L?=
 =?us-ascii?Q?N1VSPvfP4/QnN4Q4hOogxSvEjEVTqstSyQsN9uSptw6AJBXNAhAOswAP6pzT?=
 =?us-ascii?Q?GViOhwTrRx8q57yAFirX51X5u5zl6NsdT+xMhaKOfHiFxT2Ba2HCVmSmbVSh?=
 =?us-ascii?Q?Dkco3GxJB/9XoEtYc1/1fMH0wUGpjwLlLWvGrkP/0AGxabL7hO/+kAWGYKkW?=
 =?us-ascii?Q?Vv3tQlcwWE3t7uXkqeG4WjRGBr9uXMvIZxhGFXoIOa8QyoRXzjunJoAq4Z63?=
 =?us-ascii?Q?X2pzde1UAxZ3ityw1RngDD5Q6MDZ1OhOWHoiQ5qo2CFg2b7kHOxXxZL7z6Sd?=
 =?us-ascii?Q?3W3VtSLWj1fQxliPon2RR8tkE0j7MniQF2OBDES0yK73yyGozefcjasjY7kS?=
 =?us-ascii?Q?Rxnwm7rs/LYIIZ6e5Fsmpl1WvMsNLvL1NJSrrBK96d/m1Vnw0LGgHPDXoWfj?=
 =?us-ascii?Q?OkebyrGDw3mHrGejUicCL9jwqs3oCDconGD1LTXLoc5EoUaLOnwBZ9PssXDz?=
 =?us-ascii?Q?b7yZHF/vCQytI/V+/O7Gkeycq8trGsc3tjzZNrc8rcgLvrFHxiTg+BVxKMYn?=
 =?us-ascii?Q?+Rpm79vPlyvLQ1BHDwsKzYa71L3KSwwkKQD3qBD54RVl1iVEHK4dGbOPiq6u?=
 =?us-ascii?Q?nyAwcHKuc//8lQl2lNmOgd70MToZFDetUqXRNo+TMiXJUb7tPNeCHvmSEnWu?=
 =?us-ascii?Q?EuPHnpHm0jJGXgrvNRLIFWs5dDkoOD+IkeLmRNnGBIMgUqRJEsN2z3GGLQms?=
 =?us-ascii?Q?jdA5CAgNf0zhQbTNBofVLBbidZtBwss2PlTAgJQkv08JiaZpegMSZWK6j2r2?=
 =?us-ascii?Q?RUWMgN1V4uOpaJjCvRNUWqWP70f/En0+jZlsR4X3h1Qk/sacVT2+j31akNC0?=
 =?us-ascii?Q?Ex6uB15cIhA2Shi/qU4xcUuB+AgVIefQ5/L1Uh2PMqmRW94xiBkxGRl+Qu1X?=
 =?us-ascii?Q?LV6Yfao317fRWK8tLv2Vn2EdwC3/jVGo9KMov/8I8Nt0w78Qcidr19KAmUzJ?=
 =?us-ascii?Q?3kmO56GpFWXHhCyJlp+gKwCG5mDktpNq+H1a+JEgihYk+7z1acKb0RIb/P1U?=
 =?us-ascii?Q?8rXPFYuadKiraVenLeUrge3D0w2XMmPlVzG6dZLZ8Zt3S207Dm66eni3SGxl?=
 =?us-ascii?Q?1dRLNcMYt0rTEJekiLoptb4MuIw02POC9wrNISfTZ/y/JF0CYiftq5BLUYdV?=
 =?us-ascii?Q?SRLs5P3uQSUom74mnIXg7qo7+RnCqnyLLYKUeWoo7i/6s60fy/xiCpQ8zREy?=
 =?us-ascii?Q?xnSq/Ca5aL0lBXbthoYLPe6R3nvyK7uGFGn9AryxZDI7sIK5gMJ0xs3+pnCg?=
 =?us-ascii?Q?1gEIT/HoEONlrz3vdPNgvHWSVtEkeQIDS4+ja7nwLWilqurRsI6WJBPZGbJd?=
 =?us-ascii?Q?M5LykXR5+Twe+HnPaj0Ian/HA6Cj63g4t4bOCbonROAQEPTYn8QbRDYxCGGA?=
 =?us-ascii?Q?G37j7umSwLz/VgMPv88=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b6b96e9-057d-4b5c-6a2d-08da6484a112
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 04:03:22.6520 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: je3UJuDaSHQyvFxq23adDChFpysr9plhiW52cuomcgVtw1HlQBPAB8rB855E4rcA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5235
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
Cc: "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 "Clements, John" <John.Clements@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

The series is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Wednesday, July 13, 2022 11:25 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;
> Clements, John <John.Clements@amd.com>; Li, Candice
> <Candice.Li@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Deucher,
> Alexander <Alexander.Deucher@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: add umc ras functions for umc v8_10_0
>=20
> 1. Support query umc ras error counter.
> 2. Support ras umc ue error address remapping.
>=20
> v2:
>   Use adev->gmc.num_umc to replace hardcoded definitions.
>=20
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> Reviewed-by: Alexander Deucher <Alexander.Deucher@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
> Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile     |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  10 +
> drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  |  27 +-
> drivers/gpu/drm/amd/amdgpu/umc_v8_10.c  | 357
> ++++++++++++++++++++++++  drivers/gpu/drm/amd/amdgpu/umc_v8_10.h
> |  70 +++++
>  5 files changed, 464 insertions(+), 2 deletions(-)  create mode 100644
> drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/umc_v8_10.h
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile
> b/drivers/gpu/drm/amd/amdgpu/Makefile
> index a87e42c2c8dc..c7d0cd15b5ef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -93,7 +93,7 @@ amdgpu-y +=3D \
>=20
>  # add UMC block
>  amdgpu-y +=3D \
> -	umc_v6_0.o umc_v6_1.o umc_v6_7.o umc_v8_7.o
> +	umc_v6_0.o umc_v6_1.o umc_v6_7.o umc_v8_7.o umc_v8_10.o
>=20
>  # add IH block
>  amdgpu-y +=3D \
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> index 2ec6698aa1fe..3629d8f292ef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> @@ -41,6 +41,12 @@
>  #define LOOP_UMC_CH_INST(ch_inst) for ((ch_inst) =3D 0; (ch_inst) < adev=
-
> >umc.channel_inst_num; (ch_inst)++)  #define
> LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) LOOP_UMC_INST((umc_inst))
> LOOP_UMC_CH_INST((ch_inst))
>=20
> +#define LOOP_UMC_NODE_INST(node_inst) \
> +		for ((node_inst) =3D 0; (node_inst) < adev-
> >umc.node_inst_num;
> +(node_inst)++)
> +
> +#define LOOP_UMC_EACH_NODE_INST_AND_CH(node_inst, umc_inst,
> ch_inst) \
> +		LOOP_UMC_NODE_INST((node_inst))
> LOOP_UMC_INST_AND_CH((umc_inst),
> +(ch_inst))
> +
>  struct amdgpu_umc_ras {
>  	struct amdgpu_ras_block_object ras_block;
>  	void (*err_cnt_init)(struct amdgpu_device *adev); @@ -62,6 +68,10
> @@ struct amdgpu_umc {
>  	uint32_t channel_inst_num;
>  	/* number of umc instance with memory map register access */
>  	uint32_t umc_inst_num;
> +
> +	/*number of umc node instance with memory map register access*/
> +	uint32_t node_inst_num;
> +
>  	/* UMC regiser per channel offset */
>  	uint32_t channel_offs;
>  	/* channel index table of interleaved memory */ diff --git
> a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index edbdc0b934ea..503e40a90319 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -25,7 +25,7 @@
>  #include "amdgpu.h"
>  #include "amdgpu_atomfirmware.h"
>  #include "gmc_v11_0.h"
> -#include "umc_v8_7.h"
> +#include "umc_v8_10.h"
>  #include "athub/athub_3_0_0_sh_mask.h"
>  #include "athub/athub_3_0_0_offset.h"
>  #include "oss/osssys_6_0_0_offset.h"
> @@ -537,11 +537,36 @@ static void gmc_v11_0_set_umc_funcs(struct
> amdgpu_device *adev)  {
>  	switch (adev->ip_versions[UMC_HWIP][0]) {
>  	case IP_VERSION(8, 10, 0):
> +		adev->umc.channel_inst_num =3D
> UMC_V8_10_CHANNEL_INSTANCE_NUM;
> +		adev->umc.umc_inst_num =3D
> UMC_V8_10_UMC_INSTANCE_NUM;
> +		adev->umc.node_inst_num =3D adev->gmc.num_umc;
> +		adev->umc.max_ras_err_cnt_per_query =3D
> UMC_V8_10_TOTAL_CHANNEL_NUM(adev);
> +		adev->umc.channel_offs =3D
> UMC_V8_10_PER_CHANNEL_OFFSET;
> +		adev->umc.channel_idx_tbl =3D
> &umc_v8_10_channel_idx_tbl[0][0][0];
> +		adev->umc.ras =3D &umc_v8_10_ras;
> +		break;
>  	case IP_VERSION(8, 11, 0):
>  		break;
>  	default:
>  		break;
>  	}
> +
> +	if (adev->umc.ras) {
> +		amdgpu_ras_register_ras_block(adev, &adev->umc.ras-
> >ras_block);
> +
> +		strcpy(adev->umc.ras->ras_block.ras_comm.name, "umc");
> +		adev->umc.ras->ras_block.ras_comm.block =3D
> AMDGPU_RAS_BLOCK__UMC;
> +		adev->umc.ras->ras_block.ras_comm.type =3D
> AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
> +		adev->umc.ras_if =3D &adev->umc.ras->ras_block.ras_comm;
> +
> +		/* If don't define special ras_late_init function, use default
> ras_late_init */
> +		if (!adev->umc.ras->ras_block.ras_late_init)
> +			adev->umc.ras->ras_block.ras_late_init =3D
> amdgpu_umc_ras_late_init;
> +
> +		/* If not define special ras_cb function, use default ras_cb
> */
> +		if (!adev->umc.ras->ras_block.ras_cb)
> +			adev->umc.ras->ras_block.ras_cb =3D
> amdgpu_umc_process_ras_data_cb;
> +	}
>  }
>=20
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
> b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
> new file mode 100644
> index 000000000000..36a2053f2e8b
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
> @@ -0,0 +1,357 @@
> +/*
> + * Copyright 2022 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person
> +obtaining a
> + * copy of this software and associated documentation files (the
> +"Software"),
> + * to deal in the Software without restriction, including without
> +limitation
> + * the rights to use, copy, modify, merge, publish, distribute,
> +sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom
> +the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be
> +included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> +EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> +MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO
> EVENT
> +SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
> +DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> +OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
> THE USE
> +OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +#include "umc_v8_10.h"
> +#include "amdgpu_ras.h"
> +#include "amdgpu_umc.h"
> +#include "amdgpu.h"
> +#include "umc/umc_8_10_0_offset.h"
> +#include "umc/umc_8_10_0_sh_mask.h"
> +
> +#define UMC_8_NODE_DIST   0x800000
> +#define UMC_8_INST_DIST   0x4000
> +
> +struct channelnum_map_colbit {
> +	uint32_t channel_num;
> +	uint32_t col_bit;
> +};
> +
> +const struct channelnum_map_colbit
> umc_v8_10_channelnum_map_colbit_table[] =3D {
> +	{24, 13},
> +	{20, 13},
> +	{16, 12},
> +	{14, 12},
> +	{12, 12},
> +	{10, 12},
> +	{6,  11},
> +};
> +
> +const uint32_t
> +	umc_v8_10_channel_idx_tbl[]
> +				[UMC_V8_10_UMC_INSTANCE_NUM]
> +				[UMC_V8_10_CHANNEL_INSTANCE_NUM] =3D {
> +	   {{16, 18}, {17, 19}},
> +	   {{15, 11}, {3,   7}},
> +	   {{1,   5}, {13,  9}},
> +	   {{23, 21}, {22, 20}},
> +	   {{0,   4}, {12,  8}},
> +	   {{14, 10}, {2,   6}}
> +	};
> +
> +static inline uint32_t get_umc_v8_10_reg_offset(struct amdgpu_device
> *adev,
> +					    uint32_t node_inst,
> +					    uint32_t umc_inst,
> +					    uint32_t ch_inst)
> +{
> +	return adev->umc.channel_offs * ch_inst + UMC_8_INST_DIST *
> umc_inst +
> +		UMC_8_NODE_DIST * node_inst;
> +}
> +
> +static void umc_v8_10_clear_error_count_per_channel(struct
> amdgpu_device *adev,
> +					uint32_t umc_reg_offset)
> +{
> +	uint32_t ecc_err_cnt_addr;
> +
> +	ecc_err_cnt_addr =3D
> +		SOC15_REG_OFFSET(UMC, 0, regUMCCH0_0_GeccErrCnt);
> +
> +	/* clear error count */
> +	WREG32_PCIE((ecc_err_cnt_addr + umc_reg_offset) * 4,
> +			UMC_V8_10_CE_CNT_INIT);
> +}
> +
> +static void umc_v8_10_clear_error_count(struct amdgpu_device *adev) {
> +	uint32_t node_inst       =3D 0;
> +	uint32_t umc_inst        =3D 0;
> +	uint32_t ch_inst         =3D 0;
> +	uint32_t umc_reg_offset  =3D 0;
> +
> +	LOOP_UMC_EACH_NODE_INST_AND_CH(node_inst, umc_inst,
> ch_inst) {
> +		umc_reg_offset =3D get_umc_v8_10_reg_offset(adev,
> +						node_inst,
> +						umc_inst,
> +						ch_inst);
> +
> +		umc_v8_10_clear_error_count_per_channel(adev,
> +						umc_reg_offset);
> +	}
> +}
> +
> +static void umc_v8_10_query_correctable_error_count(struct
> amdgpu_device *adev,
> +						   uint32_t umc_reg_offset,
> +						   unsigned long *error_count)
> +{
> +	uint32_t ecc_err_cnt, ecc_err_cnt_addr;
> +	uint64_t mc_umc_status;
> +	uint32_t mc_umc_status_addr;
> +
> +	/* UMC 8_10 registers */
> +	ecc_err_cnt_addr =3D
> +		SOC15_REG_OFFSET(UMC, 0, regUMCCH0_0_GeccErrCnt);
> +	mc_umc_status_addr =3D
> +		SOC15_REG_OFFSET(UMC, 0,
> regMCA_UMC_UMC0_MCUMC_STATUST0);
> +
> +	ecc_err_cnt =3D RREG32_PCIE((ecc_err_cnt_addr + umc_reg_offset) *
> 4);
> +	*error_count +=3D
> +		(REG_GET_FIELD(ecc_err_cnt, UMCCH0_0_GeccErrCnt,
> GeccErrCnt) -
> +		 UMC_V8_10_CE_CNT_INIT);
> +
> +	/* Check for SRAM correctable error, MCUMC_STATUS is a 64 bit
> register */
> +	mc_umc_status =3D RREG64_PCIE((mc_umc_status_addr +
> umc_reg_offset) * 4);
> +	if (REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, Val) =3D=3D 1 &&
> +	    REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, CECC) =3D=3D 1)
> +		*error_count +=3D 1;
> +}
> +
> +static void umc_v8_10_query_uncorrectable_error_count(struct
> amdgpu_device *adev,
> +						      uint32_t umc_reg_offset,
> +						      unsigned long
> *error_count) {
> +	uint64_t mc_umc_status;
> +	uint32_t mc_umc_status_addr;
> +
> +	mc_umc_status_addr =3D SOC15_REG_OFFSET(UMC, 0,
> +regMCA_UMC_UMC0_MCUMC_STATUST0);
> +
> +	/* Check the MCUMC_STATUS. */
> +	mc_umc_status =3D RREG64_PCIE((mc_umc_status_addr +
> umc_reg_offset) * 4);
> +	if ((REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, Val) =3D=3D 1) &&
> +	    (REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, Deferred) =3D=3D 1 ||
> +	    REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, UECC) =3D=3D 1 ||
> +	    REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, PCC) =3D=3D 1 ||
> +	    REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, UC) =3D=3D 1 ||
> +	    REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, TCC) =3D=3D 1))
> +		*error_count +=3D 1;
> +}
> +
> +static void umc_v8_10_query_ras_error_count(struct amdgpu_device
> *adev,
> +					   void *ras_error_status)
> +{
> +	struct ras_err_data *err_data =3D (struct ras_err_data
> +*)ras_error_status;
> +
> +	uint32_t node_inst       =3D 0;
> +	uint32_t umc_inst        =3D 0;
> +	uint32_t ch_inst         =3D 0;
> +	uint32_t umc_reg_offset  =3D 0;
> +
> +	LOOP_UMC_EACH_NODE_INST_AND_CH(node_inst, umc_inst,
> ch_inst) {
> +		umc_reg_offset =3D get_umc_v8_10_reg_offset(adev,
> +						node_inst,
> +						umc_inst,
> +						ch_inst);
> +
> +		umc_v8_10_query_correctable_error_count(adev,
> +						umc_reg_offset,
> +						&(err_data->ce_count));
> +		umc_v8_10_query_uncorrectable_error_count(adev,
> +						umc_reg_offset,
> +						&(err_data->ue_count));
> +	}
> +
> +	umc_v8_10_clear_error_count(adev);
> +}
> +
> +static uint32_t umc_v8_10_get_col_bit(uint32_t channel_num) {
> +	uint32_t t =3D 0;
> +
> +	for (t =3D 0; t <
> ARRAY_SIZE(umc_v8_10_channelnum_map_colbit_table); t++)
> +		if (channel_num =3D=3D
> umc_v8_10_channelnum_map_colbit_table[t].channel_num)
> +			return
> umc_v8_10_channelnum_map_colbit_table[t].col_bit;
> +
> +	/* Failed to get col_bit. */
> +	return U32_MAX;
> +}
> +
> +/*
> + * Mapping normal address to soc physical address in swizzle mode.
> + */
> +static int umc_v8_10_swizzle_mode_na_to_pa(struct amdgpu_device
> *adev,
> +					uint32_t channel_idx,
> +					uint64_t na, uint64_t *soc_pa)
> +{
> +	uint32_t channel_num =3D UMC_V8_10_TOTAL_CHANNEL_NUM(adev);
> +	uint32_t col_bit =3D umc_v8_10_get_col_bit(channel_num);
> +	uint64_t tmp_addr;
> +
> +	if (col_bit =3D=3D U32_MAX)
> +		return -1;
> +
> +	tmp_addr =3D SWIZZLE_MODE_TMP_ADDR(na, channel_num,
> channel_idx);
> +	*soc_pa =3D SWIZZLE_MODE_ADDR_HI(tmp_addr, col_bit) |
> +		SWIZZLE_MODE_ADDR_MID(na, col_bit) |
> +		SWIZZLE_MODE_ADDR_LOW(tmp_addr, col_bit) |
> +		SWIZZLE_MODE_ADDR_LSB(na);
> +
> +	return 0;
> +}
> +
> +static void umc_v8_10_query_error_address(struct amdgpu_device *adev,
> +					 struct ras_err_data *err_data,
> +					 uint32_t umc_reg_offset,
> +					 uint32_t node_inst,
> +					 uint32_t ch_inst,
> +					 uint32_t umc_inst)
> +{
> +	uint64_t mc_umc_status_addr;
> +	uint64_t mc_umc_status, err_addr;
> +	uint32_t channel_index;
> +
> +	mc_umc_status_addr =3D
> +		SOC15_REG_OFFSET(UMC, 0,
> regMCA_UMC_UMC0_MCUMC_STATUST0);
> +	mc_umc_status =3D RREG64_PCIE((mc_umc_status_addr +
> umc_reg_offset) *
> +4);
> +
> +	if (mc_umc_status =3D=3D 0)
> +		return;
> +
> +	if (!err_data->err_addr) {
> +		/* clear umc status */
> +		WREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4,
> 0x0ULL);
> +		return;
> +	}
> +
> +	channel_index =3D
> +		adev->umc.channel_idx_tbl[node_inst * adev-
> >umc.umc_inst_num *
> +					adev->umc.channel_inst_num +
> +					umc_inst * adev-
> >umc.channel_inst_num +
> +					ch_inst];
> +
> +	/* calculate error address if ue/ce error is detected */
> +	if (REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, Val) =3D=3D 1 &&
> +	    REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, AddrV) =3D=3D 1 &&
> +	    (REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, UECC) =3D=3D 1 ||
> +	     REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, CECC) =3D=3D 1)) {
> +		uint32_t addr_lsb;
> +		uint64_t mc_umc_addrt0;
> +
> +		mc_umc_addrt0 =3D SOC15_REG_OFFSET(UMC, 0,
> regMCA_UMC_UMC0_MCUMC_ADDRT0);
> +		err_addr =3D RREG64_PCIE((mc_umc_addrt0 + umc_reg_offset)
> * 4);
> +		err_addr =3D REG_GET_FIELD(err_addr,
> MCA_UMC_UMC0_MCUMC_ADDRT0,
> +ErrorAddr);
> +
> +		/* the lowest lsb bits should be ignored */
> +		addr_lsb =3D REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0,
> +AddrLsb);
> +
> +		err_addr &=3D ~((0x1ULL << addr_lsb) - 1);
> +
> +		/* we only save ue error information currently, ce is skipped
> */
> +		if (REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, UECC) =3D=3D 1) {
> +			uint64_t na_err_addr_base =3D err_addr & ~(0x3ULL
> << UMC_V8_10_NA_C5_BIT);
> +			uint64_t na_err_addr, retired_page_addr;
> +			uint32_t col =3D 0;
> +			int ret =3D 0;
> +
> +			/* loop for all possibilities of [C6 C5] in normal
> address. */
> +			for (col =3D 0; col <
> UMC_V8_10_NA_COL_2BITS_POWER_OF_2_NUM; col++) {
> +				na_err_addr =3D na_err_addr_base | (col <<
> UMC_V8_10_NA_C5_BIT);
> +
> +				/* Mapping normal error address to retired
> soc physical address. */
> +				ret =3D
> umc_v8_10_swizzle_mode_na_to_pa(adev, channel_index,
> +								na_err_addr,
> &retired_page_addr);
> +				if (ret) {
> +					dev_err(adev->dev, "Failed to map
> pa from umc na.\n");
> +					break;
> +				}
> +				dev_info(adev->dev, "Error Address(PA):
> 0x%llx\n",
> +					retired_page_addr);
> +				amdgpu_umc_fill_error_record(err_data,
> na_err_addr,
> +						retired_page_addr,
> channel_index, umc_inst);
> +			}
> +		}
> +	}
> +
> +	/* clear umc status */
> +	WREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4,
> 0x0ULL); }
> +
> +static void umc_v8_10_query_ras_error_address(struct amdgpu_device
> *adev,
> +					     void *ras_error_status)
> +{
> +	struct ras_err_data *err_data =3D (struct ras_err_data
> *)ras_error_status;
> +	uint32_t node_inst       =3D 0;
> +	uint32_t umc_inst        =3D 0;
> +	uint32_t ch_inst         =3D 0;
> +	uint32_t umc_reg_offset  =3D 0;
> +
> +	LOOP_UMC_EACH_NODE_INST_AND_CH(node_inst, umc_inst,
> ch_inst) {
> +		umc_reg_offset =3D get_umc_v8_10_reg_offset(adev,
> +						node_inst,
> +						umc_inst,
> +						ch_inst);
> +
> +		umc_v8_10_query_error_address(adev,
> +					err_data,
> +					umc_reg_offset,
> +					node_inst,
> +					ch_inst,
> +					umc_inst);
> +	}
> +}
> +
> +static void umc_v8_10_err_cnt_init_per_channel(struct amdgpu_device
> *adev,
> +					      uint32_t umc_reg_offset)
> +{
> +	uint32_t ecc_err_cnt_sel, ecc_err_cnt_sel_addr;
> +	uint32_t ecc_err_cnt_addr;
> +
> +	ecc_err_cnt_sel_addr =3D
> +		SOC15_REG_OFFSET(UMC, 0, regUMCCH0_0_GeccErrCntSel);
> +	ecc_err_cnt_addr =3D
> +		SOC15_REG_OFFSET(UMC, 0, regUMCCH0_0_GeccErrCnt);
> +
> +	ecc_err_cnt_sel =3D RREG32_PCIE((ecc_err_cnt_sel_addr +
> umc_reg_offset)
> +* 4);
> +
> +	/* set ce error interrupt type to APIC based interrupt */
> +	ecc_err_cnt_sel =3D REG_SET_FIELD(ecc_err_cnt_sel,
> UMCCH0_0_GeccErrCntSel,
> +					GeccErrInt, 0x1);
> +	WREG32_PCIE((ecc_err_cnt_sel_addr + umc_reg_offset) * 4,
> ecc_err_cnt_sel);
> +	/* set error count to initial value */
> +	WREG32_PCIE((ecc_err_cnt_addr + umc_reg_offset) * 4,
> +UMC_V8_10_CE_CNT_INIT); }
> +
> +static void umc_v8_10_err_cnt_init(struct amdgpu_device *adev) {
> +	uint32_t node_inst       =3D 0;
> +	uint32_t umc_inst        =3D 0;
> +	uint32_t ch_inst         =3D 0;
> +	uint32_t umc_reg_offset  =3D 0;
> +
> +	LOOP_UMC_EACH_NODE_INST_AND_CH(node_inst, umc_inst,
> ch_inst) {
> +		umc_reg_offset =3D get_umc_v8_10_reg_offset(adev,
> +						node_inst,
> +						umc_inst,
> +						ch_inst);
> +
> +		umc_v8_10_err_cnt_init_per_channel(adev, umc_reg_offset);
> +	}
> +}
> +
> +const struct amdgpu_ras_block_hw_ops umc_v8_10_ras_hw_ops =3D {
> +	.query_ras_error_count =3D umc_v8_10_query_ras_error_count,
> +	.query_ras_error_address =3D umc_v8_10_query_ras_error_address,
> +};
> +
> +struct amdgpu_umc_ras umc_v8_10_ras =3D {
> +	.ras_block =3D {
> +		.hw_ops =3D &umc_v8_10_ras_hw_ops,
> +	},
> +	.err_cnt_init =3D umc_v8_10_err_cnt_init, };
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.h
> b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.h
> new file mode 100644
> index 000000000000..849ede88e111
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.h
> @@ -0,0 +1,70 @@
> +/*
> + * Copyright 2022 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person
> +obtaining a
> + * copy of this software and associated documentation files (the
> +"Software"),
> + * to deal in the Software without restriction, including without
> +limitation
> + * the rights to use, copy, modify, merge, publish, distribute,
> +sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom
> +the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be
> +included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> +EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> +MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO
> EVENT
> +SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
> +DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> +OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
> THE USE
> +OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +#ifndef __UMC_V8_10_H__
> +#define __UMC_V8_10_H__
> +
> +#include "soc15_common.h"
> +#include "amdgpu.h"
> +
> +/* number of umc channel instance with memory map register access */
> +#define UMC_V8_10_CHANNEL_INSTANCE_NUM		2
> +/* number of umc instance with memory map register access */
> +#define UMC_V8_10_UMC_INSTANCE_NUM		2
> +
> +/* Total channel instances for all umc nodes */ #define
> +UMC_V8_10_TOTAL_CHANNEL_NUM(adev) \
> +	(UMC_V8_10_CHANNEL_INSTANCE_NUM *
> UMC_V8_10_UMC_INSTANCE_NUM *
> +(adev)->umc.node_inst_num)
> +
> +/* UMC regiser per channel offset */
> +#define UMC_V8_10_PER_CHANNEL_OFFSET	0x400
> +
> +/* EccErrCnt max value */
> +#define UMC_V8_10_CE_CNT_MAX		0xffff
> +/* umc ce interrupt threshold */
> +#define UUMC_V8_10_CE_INT_THRESHOLD	0xffff
> +/* umc ce count initial value */
> +#define UMC_V8_10_CE_CNT_INIT	(UMC_V8_10_CE_CNT_MAX -
> UUMC_V8_10_CE_INT_THRESHOLD)
> +
> +#define UMC_V8_10_NA_COL_2BITS_POWER_OF_2_NUM	 4
> +
> +/* The C5 bit in NA  address */
> +#define UMC_V8_10_NA_C5_BIT	14
> +
> +/* Map to swizzle mode address */
> +#define SWIZZLE_MODE_TMP_ADDR(na, ch_num, ch_idx) \
> +		((((na) >> 10) * (ch_num) + (ch_idx)) << 10) #define
> +SWIZZLE_MODE_ADDR_HI(addr, col_bit)  \
> +		(((addr) >> ((col_bit) + 2)) << ((col_bit) + 2)) #define
> +SWIZZLE_MODE_ADDR_MID(na, col_bit) ((((na) >> 8) & 0x3) << (col_bit))
> +#define SWIZZLE_MODE_ADDR_LOW(addr, col_bit) \
> +		((((addr) >> 10) & ((0x1ULL << (col_bit - 8)) - 1)) << 8) #define
> +SWIZZLE_MODE_ADDR_LSB(na) ((na) & 0xFF)
> +
> +extern struct amdgpu_umc_ras umc_v8_10_ras; extern const uint32_t
> +	umc_v8_10_channel_idx_tbl[]
> +				[UMC_V8_10_UMC_INSTANCE_NUM]
> +				[UMC_V8_10_CHANNEL_INSTANCE_NUM];
> +
> +#endif
> +
> --
> 2.25.1

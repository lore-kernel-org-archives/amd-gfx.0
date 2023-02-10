Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98752C05027
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Feb 2023 06:44:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC24910E111;
	Fri, 10 Feb 2023 06:44:03 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00A0610E111
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Feb 2023 06:44:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WsTFMiBdaWzMEdIMThF8psJFERUaA83WZwG1ob/YeWFLY/JK37kMMioRWfHXpN4b60QNIST2/J5nwMi47oN05htkUyZ5eEwBDQgmGBQo5ych6WjqLHVBNzvxoLewFWZoaxNmq1XAgJylm1nOFgPr6BWfTKdgJqZMDF4+u4VwcAljPdgapp21zHfGR2ST8cBFdRu6d5f8TZYuOtqoyXn0VR5EWFcUs+39X1RnrIFwDFjF6XWv0pOsAIJu8I+xZq+OXaMvjnKEi9RipV8N9jdvCP2ZdwIe+gYz+fR2gSL7dTeq49cily6O+6lYRBg+bDSaj86IecRWVwCcLFAkS1PkPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLOgfDOQ5BYXwS29VCJ4t+eVh6Z8Mg6an3F3c5OVviA=;
 b=Rvv+bY79hFfbNrqXpRIzKdP9a6DFnWFjxI9OnEFCtLHOKJDX6Sqffk4Jpim8ZTEBwcmR03aggApnVdJeh9XsJyL78yApwxOAoHoKxlEXOY6JUD6p1f3C2EdufotKIn/UqvBUHnMr7TAy9uqvoYmKvU1FT2FlEhFact0QXE1PIrLqwSNOI8IN+piLmk6Sy/nUo6ZJTPFXcX9ethaJpSSaYyk8Btl0Ke0ylA+KOh4D8a9ey5h/Uv0vqyE7URb7IGOVFdYQGRfheB/NjSd5Fg+KOieDNGa7BPy1ILGrMV9ViqJ+mmfbE61ibpDhSz3rdLlqitZLLS8HpMIkWgLfmgiOvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLOgfDOQ5BYXwS29VCJ4t+eVh6Z8Mg6an3F3c5OVviA=;
 b=4iz+jFedbx3rMpKSY2RnBw8UCxXftYeCf1mfdNm3YeIjjhHVyZua8Zx5tvb0lG64ZF1E0irROliiqD1YVhe9J5TyNOH/ldMjDYdeN/YookB5JfXr2WM4MC0ywmGfGNGJsqtt93Km5YwyXkBVZvdqKceEFMdwS7p9LKFbufbscu8=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 CY8PR12MB7363.namprd12.prod.outlook.com (2603:10b6:930:51::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.21; Fri, 10 Feb 2023 06:44:00 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5dc8:98e2:7b6e:a9db]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5dc8:98e2:7b6e:a9db%5]) with mapi id 15.20.6086.017; Fri, 10 Feb 2023
 06:44:00 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: implement mode2 reset on smu_v13_0_10
Thread-Topic: [PATCH] drm/amd/amdgpu: implement mode2 reset on smu_v13_0_10
Thread-Index: AQHZPQ6CmTFYfQ28yEK2geqhhUfYLq7HuxSQ
Date: Fri, 10 Feb 2023 06:43:59 +0000
Message-ID: <DM6PR12MB26196E48B6F1FD0164CAC28DE4DE9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20230210051350.87747-1-kenneth.feng@amd.com>
In-Reply-To: <20230210051350.87747-1-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-10T06:43:56Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=11aeb157-d2c1-4813-a185-568a19b2cf19;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|CY8PR12MB7363:EE_
x-ms-office365-filtering-correlation-id: 701deac5-deff-4bd3-dbcb-08db0b3230dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gJ5xNMv8TeNC8gU6rpRmTpmXyXsir+1Vd/mPPmFiYW9Ls9qNv0gyKD7w2ZhOzKTi+Drih6yNN3BpnzhQMsf41Ly/XwBUhpRaZ7oQy6bfXo3CCOKBmKLafzMOm2k+uxX56tg3Qz6xO2DO0AfmmB0wEtAk6npiuU0WfIlclzGLWf4yGU9z5+vY/Yl49RxThGNoZpmLIuIycrTMymlaeMOPciFBdDA6xMhlyW7Sca07zGYpV2feXhQe0vNJG0ywyveJE8OkFX+uaIzy88ttKh8zBKBhZyShC29EgjAT5gu4pNQDDnE0pFmOHK0j0GjhaNkIxM3SXRg++FyVP+3rnfKMukOqfXhMZ/Dhctrq8lvFgC1C9ZeCuj4r3/V3qwq8mcNhxYDyKp7p7aOMzjuLSkYJNFOMp3WO/98hhF8yepiss2PTpeLA5EN/2WRtA1vcxnBrxuVlS7yb8XxnvjFtSh1dx8tPW6kgb+8/hht1MPUw8DhsU3LhB36gLpEZyC+h0xWogCNyruTSGux94bndrbkME34oCa+nk/VR3B+aBC92xEBWItEuZpUCAyjBXg7roOhNYodW26YR9pvKWBAxSgo7v47p8TYqbo75tNmqAO9oJudnaPU1ZQa6EtofIyN4AEpUAwxSHIO5VTZFx5dTPDAcGl5Df+XVk3+wOsZnl4HRKdU1w+eg8f7GhqznVVw4+WMfZZSw8YwbqC7ylwDmao53ug==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(451199018)(66899018)(2906002)(86362001)(38100700002)(122000001)(71200400001)(7696005)(186003)(6506007)(9686003)(53546011)(26005)(33656002)(38070700005)(55016003)(66556008)(66946007)(76116006)(66476007)(66446008)(83380400001)(64756008)(19627235002)(316002)(110136005)(41300700001)(4326008)(8676002)(478600001)(52536014)(8936002)(5660300002)(579004)(559001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lo6uRadBaw1HmQEOe85S88INYa44eQEbGdZpTIT22g1x/se9YUEoXZeyZT6O?=
 =?us-ascii?Q?a6KVZGsgxrAnNiarn0ZZVyL/SYFsVuIxEhGIfVSo81z+qYjuVP3CsAfXDmxa?=
 =?us-ascii?Q?9GN0k6sv5HI/JqH3FDh4jWcXkLyMgi60A8D9q4AuIe8z7mIfXOZ87E8bTNuu?=
 =?us-ascii?Q?yg8f8mCCgEayxO7/q+8essMPjcuET5y5rJDEBUVWXt1uaU5T3qeFCv8Nz5R/?=
 =?us-ascii?Q?VEsvFhhlNK2ruaERPceZPZcy/BJ9i3zlnGCnScipnH+VLAXteHhtsMH9up46?=
 =?us-ascii?Q?e3E/LccZ9Tps7BGPtBKH2B95cpmU85LTZ9uMMxBjpLzlZ4zVzLLcNbjO6Rx9?=
 =?us-ascii?Q?YWTd9ROJgmSap4dwuq8byt9Oo0VPryvx6j5rIcSbA/+uvsXZ7MgRUnh5sO1e?=
 =?us-ascii?Q?uhdS69Jr5NSBIOGT4B43kkbdYB6pPxKPqYylFZ9XEIGWNwhqZFMvrJ3Wj1WG?=
 =?us-ascii?Q?YKjQ5EUH134YBWn/DrW+0FtxOcV0Kx9yZKQtvc1Bw1kh81c/tTXc9pvW/RWX?=
 =?us-ascii?Q?CHM5u1OQBUT0u5NguUnYNct7Cl7vEcA0T6mIVA9rK4uyLfE/o1U7Ya5NMatQ?=
 =?us-ascii?Q?EofZFAZwinrDm1SXOgclPxq5W1ckic4XXqva8yQENhQ6ysyRsO7M2PWfvSB8?=
 =?us-ascii?Q?5TwlSAAbLD2EIaNVVWQeMfQGBHNC+baVQ+o0MHUHCvNFLZZn1irZGEKxPeH0?=
 =?us-ascii?Q?SwlHyzUHRRW6NLLOMnxi4aXpUOryPFXiZFjSbdKoQKyd30CWPO1YacarNu8e?=
 =?us-ascii?Q?6+yc/bo65/KtEYaIwQwOtw8hBvgyJVhUEvS1slrV4l9ARoiI1nqbM9mjgz+1?=
 =?us-ascii?Q?0Ata/6YYAMFiO45G0gVi3s4Tkrp/M78/5O732TubMxnfhARcq2eUfDjq0nC5?=
 =?us-ascii?Q?UafOX4TpodVxl7YlGScj+Q15E8rG7JRUnGVJwbvG65yLsdqO/x2Jc7K/zKNO?=
 =?us-ascii?Q?9Qcmm2WPbcyUn7ZdJGfCS/lHOno49umtqGQCafGLAAe8cx6zJAmNeGZid3tM?=
 =?us-ascii?Q?ExHvRvjKja4J2w35g5zLab29Lgzq9pdxg8P4n9IEi6Ou8jA5KM5VduVd75kq?=
 =?us-ascii?Q?Y73xmv+f0HhJ6ke+j04lFjhi+e6BnxgAx+prELEnFmBZ3tyOxjziieIDhv5B?=
 =?us-ascii?Q?WEA9gwZ5WsR8oxVQfLVdBwcZL3XRyBDuqw6N99++CLiCaCNaOUSJaoOTomsP?=
 =?us-ascii?Q?97ie98eTa8aCM7fnGxNKZIm+GwR0GE1a3/39D+GhwA8HKwwJsOYq5gRmFvVj?=
 =?us-ascii?Q?rSDpmB1D1gnh4laNCiZGlQoCY5e+6ST5EqPvlaM0MkgPZY6WGnFfU6FZS2Py?=
 =?us-ascii?Q?rl5dd1fTPeAQohFVC0FnwV9k+oqkO0jpAUzeqfv98380Do7r+OT+4Ub3Bs3Q?=
 =?us-ascii?Q?H2YFTrsS/hCtexilOSQZpdsn1on0cVM2iT7JET27S9w1/eecrORCcjGPThOt?=
 =?us-ascii?Q?xkCtyD4kOLhtsbIaVfVCRSkgDsz4hFknkI0q2UH4ERm92WTPXv3m/PqxHUYf?=
 =?us-ascii?Q?y0GfyNkwno0ukwLz6J3G0fcOSP4KhZ4aumalALtH9+Vo1UdoQkd2MhAG6ljC?=
 =?us-ascii?Q?OwC8os6a5wB8qLhUe1M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 701deac5-deff-4bd3-dbcb-08db0b3230dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 06:43:59.8951 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: efcjn0VDxKchIPTcC4NJxwYfJjlCunBIWwynN88zZkcqllK1MUSgpe8iTMM+uB92
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7363
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Kenneth Feng
> Sent: Friday, February 10, 2023 1:14 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
> Subject: [PATCH] drm/amd/amdgpu: implement mode2 reset on
> smu_v13_0_10
>=20
> implement mode2 reset on smu_v13_0_10
>=20
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     |   7 +
>  drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c     | 303
> ++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.h     |  32 ++
>  .../gpu/drm/amd/include/kgd_pp_interface.h    |   1 +
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  18 ++
>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |   1 +
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  18 ++
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |   1 +
>  .../pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h  |   1 +
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   3 +-
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  27 ++
>  12 files changed, 412 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.h
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile
> b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 24d8a03091b9..a7a0e385298d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -80,7 +80,7 @@ amdgpu-y +=3D \
>  	vi.o mxgpu_vi.o nbio_v6_1.o soc15.o emu_soc.o mxgpu_ai.o
> nbio_v7_0.o vega10_reg_init.o \
>  	vega20_reg_init.o nbio_v7_4.o nbio_v2_3.o nv.o arct_reg_init.o
> mxgpu_nv.o \
>  	nbio_v7_2.o hdp_v4_0.o hdp_v5_0.o aldebaran_reg_init.o
> aldebaran.o soc21.o \
> -	sienna_cichlid.o nbio_v4_3.o hdp_v6_0.o nbio_v7_7.o hdp_v5_2.o
> lsdma_v6_0.o
> +	sienna_cichlid.o smu_v13_0_10.o nbio_v4_3.o hdp_v6_0.o
> nbio_v7_7.o hdp_v5_2.o lsdma_v6_0.o
>=20
>  # add DF block
>  amdgpu-y +=3D \
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> index f778466bb9db..6437ead87e5f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> @@ -24,6 +24,7 @@
>  #include "amdgpu_reset.h"
>  #include "aldebaran.h"
>  #include "sienna_cichlid.h"
> +#include "smu_v13_0_10.h"
>=20
>  int amdgpu_reset_add_handler(struct amdgpu_reset_control *reset_ctl,
>  			     struct amdgpu_reset_handler *handler)
> @@ -44,6 +45,9 @@ int amdgpu_reset_init(struct amdgpu_device *adev)
>  	case IP_VERSION(11, 0, 7):
>  		ret =3D sienna_cichlid_reset_init(adev);
>  		break;
> +	case IP_VERSION(13, 0, 10):
> +		ret =3D smu_v13_0_10_reset_init(adev);
> +		break;
>  	default:
>  		break;
>  	}
> @@ -62,6 +66,9 @@ int amdgpu_reset_fini(struct amdgpu_device *adev)
>  	case IP_VERSION(11, 0, 7):
>  		ret =3D sienna_cichlid_reset_fini(adev);
>  		break;
> +	case IP_VERSION(13, 0, 10):
> +		ret =3D smu_v13_0_10_reset_fini(adev);
> +		break;
>  	default:
>  		break;
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
> b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
> new file mode 100644
> index 000000000000..ae29620b1ea4
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
> @@ -0,0 +1,303 @@
> +/*
> + * Copyright 2023 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the
> "Software"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO
> EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
> DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
> THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#include "smu_v13_0_10.h"
> +#include "amdgpu_reset.h"
> +#include "amdgpu_dpm.h"
> +#include "amdgpu_job.h"
> +#include "amdgpu_ring.h"
> +#include "amdgpu_ras.h"
> +#include "amdgpu_psp.h"
> +
> +static bool smu_v13_0_10_is_mode2_default(struct amdgpu_reset_control
> *reset_ctl)
> +{
> +	struct amdgpu_device *adev =3D (struct amdgpu_device *)reset_ctl-
> >handle;
> +	if (adev->pm.fw_version >=3D 0x00502005 && !amdgpu_sriov_vf(adev))
> +		return true;
> +
> +	return false;
> +}
> +
> +static struct amdgpu_reset_handler *
> +smu_v13_0_10_get_reset_handler(struct amdgpu_reset_control
> *reset_ctl,
> +			    struct amdgpu_reset_context *reset_context)
> +{
> +	struct amdgpu_reset_handler *handler;
> +	struct amdgpu_device *adev =3D (struct amdgpu_device *)reset_ctl-
> >handle;
> +
> +	if (reset_context->method !=3D AMD_RESET_METHOD_NONE) {
> +		list_for_each_entry(handler, &reset_ctl->reset_handlers,
> +				     handler_list) {
> +			if (handler->reset_method =3D=3D reset_context-
> >method)
> +				return handler;
> +		}
> +	}
> +
> +	if (smu_v13_0_10_is_mode2_default(reset_ctl) &&
> +		amdgpu_asic_reset_method(adev) =3D=3D
> AMD_RESET_METHOD_MODE2) {
> +		list_for_each_entry (handler, &reset_ctl->reset_handlers,
> +				     handler_list) {
> +			if (handler->reset_method =3D=3D
> AMD_RESET_METHOD_MODE2)
> +				return handler;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +static int smu_v13_0_10_mode2_suspend_ip(struct amdgpu_device *adev)
> +{
> +	int r, i;
> +
> +	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
> +	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
> +
> +	for (i =3D adev->num_ip_blocks - 1; i >=3D 0; i--) {
> +		if (!(adev->ip_blocks[i].version->type =3D=3D
> +			      AMD_IP_BLOCK_TYPE_GFX ||
> +		      adev->ip_blocks[i].version->type =3D=3D
> +			      AMD_IP_BLOCK_TYPE_SDMA ||
> +		      adev->ip_blocks[i].version->type =3D=3D
> +			      AMD_IP_BLOCK_TYPE_MES))
> +			continue;
> +
> +		r =3D adev->ip_blocks[i].version->funcs->suspend(adev);
> +
> +		if (r) {
> +			dev_err(adev->dev,
> +				"suspend of IP block <%s> failed %d\n",
> +				adev->ip_blocks[i].version->funcs->name, r);
> +			return r;
> +		}
> +		adev->ip_blocks[i].status.hw =3D false;
> +	}
> +
> +	return r;
> +}
> +
> +static int
> +smu_v13_0_10_mode2_prepare_hwcontext(struct amdgpu_reset_control
> *reset_ctl,
> +				  struct amdgpu_reset_context
> *reset_context)
> +{
> +	int r =3D 0;
> +	struct amdgpu_device *adev =3D (struct amdgpu_device *)reset_ctl-
> >handle;
> +
> +	if (!amdgpu_sriov_vf(adev))
> +		r =3D smu_v13_0_10_mode2_suspend_ip(adev);
> +
> +	return r;
> +}
> +
> +static int smu_v13_0_10_mode2_reset(struct amdgpu_device *adev)
> +{
> +	return amdgpu_dpm_mode2_reset(adev);
> +}
> +
> +static void smu_v13_0_10_async_reset(struct work_struct *work)
> +{
> +	struct amdgpu_reset_handler *handler;
> +	struct amdgpu_reset_control *reset_ctl =3D
> +		container_of(work, struct amdgpu_reset_control,
> reset_work);
> +	struct amdgpu_device *adev =3D (struct amdgpu_device *)reset_ctl-
> >handle;
> +
> +	list_for_each_entry(handler, &reset_ctl->reset_handlers,
> +			     handler_list) {
> +		if (handler->reset_method =3D=3D reset_ctl->active_reset) {
> +			dev_dbg(adev->dev, "Resetting device\n");
> +			handler->do_reset(adev);
> +			break;
> +		}
> +	}
> +}
> +static int
> +smu_v13_0_10_mode2_perform_reset(struct amdgpu_reset_control
> *reset_ctl,
> +			      struct amdgpu_reset_context *reset_context)
> +{
> +	struct amdgpu_device *adev =3D (struct amdgpu_device *)reset_ctl-
> >handle;
> +	int r;
> +
> +	r =3D smu_v13_0_10_mode2_reset(adev);
> +	if (r) {
> +		dev_err(adev->dev,
> +			"ASIC reset failed with error, %d ", r);
> +	}
> +	return r;
> +}
> +
> +static int smu_v13_0_10_mode2_restore_ip(struct amdgpu_device *adev)
> +{
> +	int i, r;
> +	struct psp_context *psp =3D &adev->psp;
> +	struct amdgpu_firmware_info *ucode;
> +	struct amdgpu_firmware_info *ucode_list[2];
> +	int ucode_count =3D 0;
> +
> +	for (i =3D 0; i < adev->firmware.max_ucodes; i++) {
> +		ucode =3D &adev->firmware.ucode[i];
> +
> +		switch (ucode->ucode_id) {
> +		case AMDGPU_UCODE_ID_IMU_I:
> +		case AMDGPU_UCODE_ID_IMU_D:
> +			ucode_list[ucode_count++] =3D ucode;
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	r =3D psp_load_fw_list(psp, ucode_list, ucode_count);
> +	if (r) {
> +		dev_err(adev->dev, "IMU ucode load failed after mode2
> reset\n");
> +		return r;
> +	}
> +
> +	r =3D psp_rlc_autoload_start(psp);
> +	if (r) {
> +		DRM_ERROR("Failed to start rlc autoload after mode2
> reset\n");
> +		return r;
> +	}
> +
> +	amdgpu_dpm_enable_gfx_features(adev);
> +
> +	for (i =3D 0; i < adev->num_ip_blocks; i++) {
> +		if (!(adev->ip_blocks[i].version->type =3D=3D
> +			      AMD_IP_BLOCK_TYPE_GFX ||
> +		      adev->ip_blocks[i].version->type =3D=3D
> +			      AMD_IP_BLOCK_TYPE_MES ||
> +		      adev->ip_blocks[i].version->type =3D=3D
> +			      AMD_IP_BLOCK_TYPE_SDMA))
> +			continue;
> +		r =3D adev->ip_blocks[i].version->funcs->resume(adev);
> +		if (r) {
> +			dev_err(adev->dev,
> +				"resume of IP block <%s> failed %d\n",
> +				adev->ip_blocks[i].version->funcs->name, r);
> +			return r;
> +		}
> +
> +		adev->ip_blocks[i].status.hw =3D true;
> +	}
> +
> +	for (i =3D 0; i < adev->num_ip_blocks; i++) {
> +		if (!(adev->ip_blocks[i].version->type =3D=3D
> +			      AMD_IP_BLOCK_TYPE_GFX ||
> +		      adev->ip_blocks[i].version->type =3D=3D
> +			      AMD_IP_BLOCK_TYPE_MES ||
> +		      adev->ip_blocks[i].version->type =3D=3D
> +			      AMD_IP_BLOCK_TYPE_SDMA))
> +			continue;
> +
> +		if (adev->ip_blocks[i].version->funcs->late_init) {
> +			r =3D adev->ip_blocks[i].version->funcs->late_init(
> +				(void *)adev);
> +			if (r) {
> +				dev_err(adev->dev,
> +					"late_init of IP block <%s> failed %d
> after reset\n",
> +					adev->ip_blocks[i].version->funcs-
> >name,
> +					r);
> +				return r;
> +			}
> +		}
> +		adev->ip_blocks[i].status.late_initialized =3D true;
> +	}
> +
> +	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
> +	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_GATE);
> +
> +	return r;
> +}
> +
> +static int
> +smu_v13_0_10_mode2_restore_hwcontext(struct amdgpu_reset_control
> *reset_ctl,
> +				  struct amdgpu_reset_context
> *reset_context)
> +{
> +	int r;
> +	struct amdgpu_device *tmp_adev =3D (struct amdgpu_device
> *)reset_ctl->handle;
> +
> +	dev_info(tmp_adev->dev,
> +			"GPU reset succeeded, trying to resume\n");
> +	r =3D smu_v13_0_10_mode2_restore_ip(tmp_adev);
> +	if (r)
> +		goto end;
> +
> +	amdgpu_register_gpu_instance(tmp_adev);
> +
> +	/* Resume RAS */
> +	amdgpu_ras_resume(tmp_adev);
> +
> +	amdgpu_irq_gpu_reset_resume_helper(tmp_adev);
> +
> +	r =3D amdgpu_ib_ring_tests(tmp_adev);
> +	if (r) {
> +		dev_err(tmp_adev->dev,
> +			"ib ring test failed (%d).\n", r);
> +		r =3D -EAGAIN;
> +		goto end;
> +	}
> +
> +end:
> +	if (r)
> +		return -EAGAIN;
> +	else
> +		return r;
> +}
> +
> +static struct amdgpu_reset_handler smu_v13_0_10_mode2_handler =3D {
> +	.reset_method		=3D AMD_RESET_METHOD_MODE2,
> +	.prepare_env		=3D NULL,
> +	.prepare_hwcontext	=3D
> smu_v13_0_10_mode2_prepare_hwcontext,
> +	.perform_reset		=3D
> smu_v13_0_10_mode2_perform_reset,
> +	.restore_hwcontext	=3D
> smu_v13_0_10_mode2_restore_hwcontext,
> +	.restore_env		=3D NULL,
> +	.do_reset		=3D smu_v13_0_10_mode2_reset,
> +};
> +
> +int smu_v13_0_10_reset_init(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_reset_control *reset_ctl;
> +
> +	reset_ctl =3D kzalloc(sizeof(*reset_ctl), GFP_KERNEL);
> +	if (!reset_ctl)
> +		return -ENOMEM;
> +
> +	reset_ctl->handle =3D adev;
> +	reset_ctl->async_reset =3D smu_v13_0_10_async_reset;
> +	reset_ctl->active_reset =3D AMD_RESET_METHOD_NONE;
> +	reset_ctl->get_reset_handler =3D smu_v13_0_10_get_reset_handler;
> +
> +	INIT_LIST_HEAD(&reset_ctl->reset_handlers);
> +	INIT_WORK(&reset_ctl->reset_work, reset_ctl->async_reset);
> +	/* Only mode2 is handled through reset control now */
> +	amdgpu_reset_add_handler(reset_ctl,
> &smu_v13_0_10_mode2_handler);
> +
> +	adev->reset_cntl =3D reset_ctl;
> +
> +	return 0;
> +}
> +
> +int smu_v13_0_10_reset_fini(struct amdgpu_device *adev)
> +{
> +	kfree(adev->reset_cntl);
> +	adev->reset_cntl =3D NULL;
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.h
> b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.h
> new file mode 100644
> index 000000000000..e0cb72a0eec6
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.h
> @@ -0,0 +1,32 @@
> +/*
> + * Copyright 2023 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the
> "Software"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO
> EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
> DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
> THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#ifndef __SMU_V13_0_10_H__
> +#define __SMU_V13_0_10_H__
> +
> +#include "amdgpu.h"
> +
> +int smu_v13_0_10_reset_init(struct amdgpu_device *adev);
> +int smu_v13_0_10_reset_fini(struct amdgpu_device *adev);
> +
> +#endif
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> index d68bd7c1aa04..e485a643bb99 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -398,6 +398,7 @@ struct amd_pm_funcs {
>  	int (*get_ppfeature_status)(void *handle, char *buf);
>  	int (*set_ppfeature_status)(void *handle, uint64_t
> ppfeature_masks);
>  	int (*asic_reset_mode_2)(void *handle);
> +	int (*asic_reset_enable_gfx_features)(void *handle);
>  	int (*set_df_cstate)(void *handle, enum pp_df_cstate state);
>  	int (*set_xgmi_pstate)(void *handle, uint32_t pstate);
>  	ssize_t (*get_gpu_metrics)(void *handle, void **table);
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 751d01495195..f0068df2d073 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -250,6 +250,24 @@ int amdgpu_dpm_mode2_reset(struct
> amdgpu_device *adev)
>  	return ret;
>  }
>=20
> +int amdgpu_dpm_enable_gfx_features(struct amdgpu_device *adev)
> +{
> +	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> +	void *pp_handle =3D adev->powerplay.pp_handle;
> +	int ret =3D 0;
> +
> +	if (!pp_funcs || !pp_funcs->asic_reset_enable_gfx_features)
> +		return -ENOENT;
> +
> +	mutex_lock(&adev->pm.mutex);
> +
> +	ret =3D pp_funcs->asic_reset_enable_gfx_features(pp_handle);
> +
> +	mutex_unlock(&adev->pm.mutex);
> +
> +	return ret;
> +}
> +
>  int amdgpu_dpm_baco_reset(struct amdgpu_device *adev)
>  {
>  	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> index 485522cb0238..ff2ebf786bb0 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -387,6 +387,7 @@ int amdgpu_dpm_switch_power_profile(struct
> amdgpu_device *adev,
>  int amdgpu_dpm_baco_reset(struct amdgpu_device *adev);
>=20
>  int amdgpu_dpm_mode2_reset(struct amdgpu_device *adev);
> +int amdgpu_dpm_enable_gfx_features(struct amdgpu_device *adev);
>=20
>  bool amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev);
>  bool amdgpu_dpm_is_maco_supported(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index f08698493502..0fe926bdc18a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2874,6 +2874,23 @@ static int smu_mode2_reset(void *handle)
>  	return ret;
>  }
>=20
> +static int smu_enable_gfx_features(void *handle)
> +{
> +	struct smu_context *smu =3D handle;
> +	int ret =3D 0;
> +
> +	if (!smu->pm_enabled)
> +		return -EOPNOTSUPP;
> +
> +	if (smu->ppt_funcs->enable_gfx_features)
> +		ret =3D smu->ppt_funcs->enable_gfx_features(smu);
> +
> +	if (ret)
> +		dev_err(smu->adev->dev, "enable gfx features failed!\n");
> +
> +	return ret;
> +}
> +
>  static int smu_get_max_sustainable_clocks_by_dc(void *handle,
>  						struct
> pp_smu_nv_clock_table *max_clocks)
>  {
> @@ -3059,6 +3076,7 @@ static const struct amd_pm_funcs
> swsmu_pm_funcs =3D {
>  	.get_ppfeature_status             =3D smu_sys_get_pp_feature_mask,
>  	.set_ppfeature_status             =3D smu_sys_set_pp_feature_mask,
>  	.asic_reset_mode_2                =3D smu_mode2_reset,
> +	.asic_reset_enable_gfx_features   =3D smu_enable_gfx_features,
>  	.set_df_cstate                    =3D smu_set_df_cstate,
>  	.set_xgmi_pstate                  =3D smu_set_xgmi_pstate,
>  	.get_gpu_metrics                  =3D smu_sys_get_gpu_metrics,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index f5f0b2f3c610..1f65048a5c33 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -1202,6 +1202,7 @@ struct pptable_funcs {
>  	 * IPs reset varies by asic.
>  	 */
>  	int (*mode2_reset)(struct smu_context *smu);
> +	int (*enable_gfx_features)(struct smu_context *smu);
[Quan, Evan] Might better to add some descriptions for the new API as for o=
ther APIs.
Either way the patch is acked-by: Evan Quan <evan.quan@amd.com>
>=20
>  	/**
>  	 * @get_dpm_ultimate_freq: Get the hard frequency range of a
> clock
> diff --git
> a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h
> index 8b8266890a10..10cff75b44d5 100644
> ---
> a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h
> +++
> b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h
> @@ -94,6 +94,7 @@
>  //Resets
>  #define PPSMC_MSG_PrepareMp1ForUnload            0x2E
>  #define PPSMC_MSG_Mode1Reset                     0x2F
> +#define PPSMC_MSG_Mode2Reset					 0x4F
>=20
>  //Set SystemVirtual DramAddrHigh
>  #define PPSMC_MSG_SetSystemVirtualDramAddrHigh   0x30
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> index 4180c71d930f..96f6c2db955b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> @@ -242,7 +242,8 @@
>  	__SMU_DUMMY_MAP(LogGfxOffResidency),			\
>  	__SMU_DUMMY_MAP(SetNumBadMemoryPagesRetired),
> 	\
>=20
> 	__SMU_DUMMY_MAP(SetBadMemoryPagesRetiredFlagsPerChann
> el), \
> -	__SMU_DUMMY_MAP(AllowGpo),
> +	__SMU_DUMMY_MAP(AllowGpo),	\
> +	__SMU_DUMMY_MAP(Mode2Reset),
>=20
>  #undef __SMU_DUMMY_MAP
>  #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 8b06a673e77c..44dd88bb3935 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -138,6 +138,7 @@ static struct cmn2asic_msg_mapping
> smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] =3D
>  	MSG_MAP(GetPptLimit,
> 	PPSMC_MSG_GetPptLimit,                 0),
>  	MSG_MAP(NotifyPowerSource,
> 	PPSMC_MSG_NotifyPowerSource,           0),
>  	MSG_MAP(Mode1Reset,
> 	PPSMC_MSG_Mode1Reset,                  0),
> +	MSG_MAP(Mode2Reset,
> 	PPSMC_MSG_Mode2Reset,	       		   0),
>  	MSG_MAP(PrepareMp1ForUnload,
> 	PPSMC_MSG_PrepareMp1ForUnload,         0),
>  	MSG_MAP(DFCstateControl,
> 	PPSMC_MSG_SetExternalClientDfCstateAllow, 0),
>  	MSG_MAP(ArmD3,				PPSMC_MSG_ArmD3,
> 0),
> @@ -1957,6 +1958,30 @@ static int smu_v13_0_0_mode1_reset(struct
> smu_context *smu)
>  	return ret;
>  }
>=20
> +static int smu_v13_0_0_mode2_reset(struct smu_context *smu)
> +{
> +	int ret;
> +	struct amdgpu_device *adev =3D smu->adev;
> +
> +	if (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 10))
> +		ret =3D smu_cmn_send_smc_msg(smu,
> SMU_MSG_Mode2Reset, NULL);
> +	else
> +		return -EOPNOTSUPP;
> +
> +	return ret;
> +}
> +
> +static int smu_v13_0_0_enable_gfx_features(struct smu_context *smu)
> +{
> +	struct amdgpu_device *adev =3D smu->adev;
> +
> +	if (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 10))
> +		return smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_EnableAllSmuFeatures,
> +
> 	   FEATURE_PWR_GFX, NULL);
> +	else
> +		return -EOPNOTSUPP;
> +}
> +
>  static void smu_v13_0_0_set_smu_mailbox_registers(struct smu_context
> *smu)
>  {
>  	struct amdgpu_device *adev =3D smu->adev;
> @@ -2073,6 +2098,8 @@ static const struct pptable_funcs
> smu_v13_0_0_ppt_funcs =3D {
>  	.baco_exit =3D smu_v13_0_0_baco_exit,
>  	.mode1_reset_is_support =3D
> smu_v13_0_0_is_mode1_reset_supported,
>  	.mode1_reset =3D smu_v13_0_0_mode1_reset,
> +	.mode2_reset =3D smu_v13_0_0_mode2_reset,
> +	.enable_gfx_features =3D smu_v13_0_0_enable_gfx_features,
>  	.set_mp1_state =3D smu_v13_0_0_set_mp1_state,
>  	.set_df_cstate =3D smu_v13_0_0_set_df_cstate,
>  	.send_hbm_bad_pages_num =3D
> smu_v13_0_0_smu_send_bad_mem_page_num,
> --
> 2.25.1

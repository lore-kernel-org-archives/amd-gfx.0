Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B4BC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Dec 2021 04:10:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E97A6F385;
	Tue,  7 Dec 2021 04:10:00 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F4CC6EE95
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Dec 2021 04:09:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=geVdre12/kdiouUmaqAuNgZvB/8FYBAj2LuzSqOrlycVPEfe4V+hkxXRxVYB0F/AYQ/OpIQz9za6OZL18ERSxedYejwBCjoOcBySA0W/Au2blVFmsClZwSnOp+tQ1roADMHyw6F2JF5uCBVP/gqs6JbG+Hd2wJsRvTER3tgki+eyutcy9Gik/YOwbJGBH8qfKCpif5Ys6JUanpMHaFlAz8AOEhpgYgVE+FQdIy6NPvb+/ADo1DtofTObwPTq0bys+drtBrQiSh/vgU33kmJ4X2oKSzldObzSjNrcVFfbCEO9fwaAP+LaTBb9UrNuPlspilyxus0WfF0sJu+ZuQggeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LAgyrFmNIMviUiYbIOqGpkxMh7ykstSe5+IsEDHkXts=;
 b=Bf3JNbTYT0RKOhZoLSguRcPLoM+f+NCvpc+h4qCzYWHSIgXdvNHTLkVaoeygwYoDPk2vVK6fmM4yMoh+Zg/rx3LG5G+zXlk9URIeqmZE7Vko+cE1D8EkP9blHxFPvBKk/V7zopLnsqvOtf4mcHt3HwGJYPgjdMmIbHjL5SZ/LKtcFvHDp6/x2kJbQYnxxY0QKosiwUX/czF1UbQegKJrsrZrlblc+LbUevPFup1TMUvWiC7BkyD4mZ7sJSc0ZQ0MC/P5aEnHlGtUUsoSLffj2DFfKUZlOUbF9luYzRRVUHAKTM+8cyd8LCVrPUL8FWuH50CoGLJ/vyPCVzkvQbQR8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAgyrFmNIMviUiYbIOqGpkxMh7ykstSe5+IsEDHkXts=;
 b=nnkPtdptW4P9YDgf4aED22PIIzllHFhYdWh07uVV3i1ViVha5KAt/lJ4fOGWNQBXkw4wQHG//zZAonwAYxuViPZNzyDqTg5PG+EKthYRKJKcbHJLFK/QBvaSfZUpwptjk2FPRBrJF7PzaulvXmfNUo8GM31+KAF7QUyK5uTX0Ek=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by CH2PR12MB4922.namprd12.prod.outlook.com (2603:10b6:610:65::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Tue, 7 Dec
 2021 03:37:06 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::e9e5:e439:ff62:252a]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::e9e5:e439:ff62:252a%5]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 03:37:06 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2 03/11] drm/amdgpu: Modify gfx block to fit for the
 unified ras block data and ops
Thread-Topic: [PATCH V2 03/11] drm/amdgpu: Modify gfx block to fit for the
 unified ras block data and ops
Thread-Index: AQHX5qGzAMl6NBiq7UqLumwBwC2HgawlD/IAgAFH9NA=
Date: Tue, 7 Dec 2021 03:37:06 +0000
Message-ID: <CH2PR12MB4215017BC0C393FEA8BB694AFC6E9@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20211201105250.298525-1-YiPeng.Chai@amd.com>
 <20211201105250.298525-3-YiPeng.Chai@amd.com>
 <DM6PR12MB46507136C714550B974B682EB06D9@DM6PR12MB4650.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB46507136C714550B974B682EB06D9@DM6PR12MB4650.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-06T06:03:22Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=f91674a0-640b-4147-8237-7e6e1c20c707;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 275df13e-4f27-4bbf-d154-08d9b932d76f
x-ms-traffictypediagnostic: CH2PR12MB4922:EE_
x-microsoft-antispam-prvs: <CH2PR12MB49228DBD7EC4E6558B201898FC6E9@CH2PR12MB4922.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rn74WK10/GejbrX0ULtaw3rvTqb+jNx2PqiT/t/9R4eAAqFeb9xSWrfioMoefR/2EI3woENuxJMwuT8+Y1JwxDob1bDkgaAvxIRVdGXgwUFik6rK81D+gL2ELq9y4LkYUlPGcpL1nszUCj09mcL2yrV4jJqCovNbTGY+EZiJ/FIGZ9zEuIEQcAEQa2wI3toqhPNa48UCUdaqutWuUFZe2N5Fsnq8b4qboLnKgRdj3lJM0qCmjCr9kd+p6mK4mOpqlsp3p39xB/UTkBziVgfwFF8tm+qW/uBx8eVrg8YKPEFYtahhWbTat2bjOARTCQiBpFOfLw8IGehaCx279dFsvTWEqHEQuRg12Kx2XuwxVxB7ZZKS7gyQLZ/A/w1wBuAl1lTu8hK39sFEDOmcRwtKpUU396depfMYxpfEHgYZDMmbx+BdnEii2BcBGyTcxEXMDw9lcitliU8Z7f5le/RZQPk14O/EIuh0c3K94rhHFWPFVJuqADq4iMW4BPmP4AlbdSiD6TE/DGdvE7k0GOq2+QVQ6sezgaTqTZFOBK09rMQ/RBE8GndanKN17Gh3T1d66rXn/QjF/h2T3ReNleYDtRUVOfvX0sR6FKygag4jQ2R80k5gZFm4zC4ewCmcPesNEzqFQc0Yynguzz7dhQnRFPoG9WXc8AqgAXV4qqK5JN25cV03iv+011oYt4EeSohlRPVSybYZP/TGNApBPCPRLQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(7696005)(8936002)(52536014)(6506007)(66946007)(64756008)(66556008)(66476007)(508600001)(71200400001)(2906002)(86362001)(83380400001)(55016003)(66446008)(53546011)(76116006)(30864003)(316002)(26005)(186003)(110136005)(4326008)(8676002)(9686003)(122000001)(38100700002)(33656002)(38070700005)(5660300002)(579004)(559001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uKxPK57+mgaZ/8iXJSOboGll3NBgIbeEs1UtZTrySNZVv7WvByjKmMMTjyQ6?=
 =?us-ascii?Q?nRZczyQz3KCAQNEf6Oan/vBybX/uHKNQT4nBZGCTV6vn94ptWwQTK6TbgLWa?=
 =?us-ascii?Q?VTKaDQKvpTEpkm/Feq9Qxk33PTvuCrD66H0TbotzTf+dpLyoVReRNNIq2td/?=
 =?us-ascii?Q?T/7OzKdchY5R6pCqwPu2xFafKy1e94XrsWLdX4DRcyNTVuptDuFIxUii7faC?=
 =?us-ascii?Q?OYmHewFrBYrGtDMA+pIISJFJ469Z+uawZfzkw8QYaiyf6isCcMYg2OhoslT4?=
 =?us-ascii?Q?annPvXvNFKg1Wf8TsddGRk3JeymD2lgL3tIlQaPB44NbWE2MP4fRvorDmRO3?=
 =?us-ascii?Q?uGP2Pdxn22KGiEw8QlKMg41p4WnzoVLLfZdt2l8uomojBe0vBtpZpmRjGFZe?=
 =?us-ascii?Q?oo+6/qRoVtmtYAXG4IE0AkI6gHbqT1UygPoUfhRau4Kb9t1jC8+0xm5SRCYE?=
 =?us-ascii?Q?oJkiSYhCdTB4rfWmwwK166Z9eFhgdB74CS2iOFMgWsnTeIx17n63tNmaJcrc?=
 =?us-ascii?Q?lPTdoEDeIWEwCPoTLiPcNvURtE7HJWlRYo3ngGh0BGU7VNdg7X+ZAvMkdrSX?=
 =?us-ascii?Q?n/nSFTqorW6afxf/8b3iACwE8qLv+Npanocw0eZHfeM2nWYyZjLraOi9uBbq?=
 =?us-ascii?Q?HxCzTKiyiTLM2BXr+CCgFhfVdIR/zD+CFhl0TA6Ndrv64NzQDBDmGo1BvB7t?=
 =?us-ascii?Q?lVF/x07jPlzCa5IMKMeJaIQx7pjFvXVGtf0v/bcg8ynoc4QMQR6tzTH/0fXd?=
 =?us-ascii?Q?SD59ixeALp8z4P+4pHSShAe84iqbzdw36yhHf7DuSFzvD0JKpwjBxsTElFbK?=
 =?us-ascii?Q?FRRCC/LZsBYhHuVlx0kjLNWk1CAdHhIk0VS9n0qVzigFJQAd9zAqfjTB2sN4?=
 =?us-ascii?Q?g8mW2CZBzU8FHqEw1WdEp/PTatE9cHnFwIJZSsUkGySaUaRiPPBef4ip+aMh?=
 =?us-ascii?Q?LhbuySNwtgi987h7a7kT39tgPlURCNNsib1kv+tHvFI59E4/10LR8JCpkQRG?=
 =?us-ascii?Q?VJqNuPD231cQJSt5eQ3nTC0Ea/PUol0/Tb45ZVYnpnhE1zJ6OhVPfu5Dp3W9?=
 =?us-ascii?Q?uOUXGoHBbLQVCaE9VSOJfCwln9fF4pNcE19hJyVUjUlfmLOmHLOFKy21wrs1?=
 =?us-ascii?Q?UKV5xCAg2lZ38p7oSB9ZM1RCcvqALq4aLPiCLoWs2FMWXI+T8hPTbWtfpu1q?=
 =?us-ascii?Q?BaxfAHc6YBd1fAGuanc9j8mI2Wrwfe2c4Ey+j7R5L4ZTQkmV9KuzEjTMXsq0?=
 =?us-ascii?Q?8r0nhwunZ1PoCFzffvOwwCkwb7cjysZbhHTyBWJInoSqDlOQ0YbyhKnCmTWq?=
 =?us-ascii?Q?di+LmlJqa9OpBM0PbHKnEnQN3kniRHq6VM4Jrov2wGi0wi8rg+JfFMfwUszJ?=
 =?us-ascii?Q?YnQGoRyYJC3GfwpXUxJFk6NsvRz4YkTk3YYyuYZD4w9X0W68clEsHtrQ9niF?=
 =?us-ascii?Q?Id+pG5GtH0918I0iYqMMDXW57Urb2CYZ2HRIBoDEFmO+4/85LIzueJ8Ox9Xo?=
 =?us-ascii?Q?4cc+AGFoHq+Wd3AeNOg/e52+pj6kcP/NLOhu+DVBndFKv+z8IkAlXmU+MqV7?=
 =?us-ascii?Q?ooJNfpU/IQYwpFfOrC7y572jsf+5osX2slodIBeCAtDLaS04im8vxAGWezq8?=
 =?us-ascii?Q?c17J7lHZMv5WFm8YPqQkYA0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 275df13e-4f27-4bbf-d154-08d9b932d76f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2021 03:37:06.1850 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LyqMtxgI3zha6sKBZoShMX1xloAWV5kjKqg2JEFiou+0bMaD01zyOpNxKinarc+hexWZGq+s0x8rtu0z3t/VUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4922
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi tao:
     I add my comments behind your comments. Please review.

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Monday, December 6, 2021 2:58 PM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH V2 03/11] drm/amdgpu: Modify gfx block to fit for the u=
nified ras block data and ops

[AMD Official Use Only]

Please see my comments inline.

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Wednesday, December 1, 2021 6:53 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking=20
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas=20
> <YiPeng.Chai@amd.com>
> Subject: [PATCH V2 03/11] drm/amdgpu: Modify gfx block to fit for the=20
> unified ras block data and ops
>=20
> 1.Modify gfx block to fit for the unified ras block data and ops=20
> 2.Implement .ras_block_match function pointer for gfx block to identify i=
tself.
> 3.Change amdgpu_gfx_ras_funcs to amdgpu_gfx_ras, and the corresponding=20
> variable name remove _funcs suffix.
> 4.Remove the const flag of gfx ras variable so that gfx ras block can=20
> be able to be insertted into amdgpu device ras block link list.
> 5.Invoke amdgpu_ras_register_ras_block function to register gfx ras=20
> block into amdgpu device ras block link list.
> 6.Remove the redundant code about gfx in amdgpu_ras.c after using the=20
> unified ras block.
>=20
> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c |  6 +-=20
> drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 15 ++---=20
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 80 ++++++++++++++++++-------
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 73 +++++++++++++++-------
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c   | 39 ++++++++----
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 42 +++++++++----=20
> drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h |  2 +-
>  8 files changed, 178 insertions(+), 81 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 1795d448c700..da8691259ac1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -696,9 +696,9 @@ int amdgpu_gfx_process_ras_data_cb(struct
> amdgpu_device *adev,
>  	 */
>  	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX)) {
>  		kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
> -		if (adev->gfx.ras_funcs &&
> -		    adev->gfx.ras_funcs->query_ras_error_count)
> -			adev->gfx.ras_funcs->query_ras_error_count(adev,
> err_data);
> +		if (adev->gfx.ras && adev->gfx.ras->ras_block.ops &&
> +		    adev->gfx.ras->ras_block.ops->query_ras_error_count)
> +			adev->gfx.ras->ras_block.ops-
> >query_ras_error_count(adev, err_data);
>  		amdgpu_ras_reset_gpu(adev);
>  	}
>  	return AMDGPU_RAS_SUCCESS;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 6b78b4a0e182..ff4a8428a84b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -31,6 +31,7 @@
>  #include "amdgpu_ring.h"
>  #include "amdgpu_rlc.h"
>  #include "soc15.h"
> +#include "amdgpu_ras.h"
>=20
>  /* GFX current status */
>  #define AMDGPU_GFX_NORMAL_MODE			0x00000000L
> @@ -213,16 +214,8 @@ struct amdgpu_cu_info {
>  	uint32_t bitmap[4][4];
>  };
>=20
> -struct amdgpu_gfx_ras_funcs {
> -	int (*ras_late_init)(struct amdgpu_device *adev);
> -	void (*ras_fini)(struct amdgpu_device *adev);
> -	int (*ras_error_inject)(struct amdgpu_device *adev,
> -				void *inject_if);
> -	int (*query_ras_error_count)(struct amdgpu_device *adev,
> -				     void *ras_error_status);
> -	void (*reset_ras_error_count)(struct amdgpu_device *adev);
> -	void (*query_ras_error_status)(struct amdgpu_device *adev);
> -	void (*reset_ras_error_status)(struct amdgpu_device *adev);
> +struct amdgpu_gfx_ras {
> +	struct amdgpu_ras_block_object  ras_block;
>  	void (*enable_watchdog_timer)(struct amdgpu_device *adev);  };

>[Tao] Can we add " enable_watchdog_timer" function into amdgpu_ras_block_o=
ps structure?
>And I think using ras_block directly is more simple than amdgpu_gfx_ras gf=
x_v9_0_ras structure.

[Thomas] The ' enable_watchdog_timer ' function is not a common function. I=
t is only defined by gfx_v9_4_2.c and called in gfx_v9_0.c.=20
	   I think the function pointers in the amdgpu_ras_block_ops structure sho=
uld be the functions used by most blocks and the final goal of amdgpu_ras_b=
lock_ops structure is to eliminate explicit calls to special blocks in amdg=
pu_ras.c file.=20
                 So, I think it had better that the enable_watchdog_timer f=
unction only use in gfx but not move to amdgpu_ras_block_ops.

>=20
> @@ -348,7 +341,7 @@ struct amdgpu_gfx {
>=20
>  	/*ras */
>  	struct ras_common_if			*ras_if;
> -	const struct amdgpu_gfx_ras_funcs	*ras_funcs;
> +	struct amdgpu_gfx_ras	*ras;
>  };
>=20
>  #define amdgpu_gfx_get_gpu_clock_counter(adev) (adev)->gfx.funcs-
> >get_gpu_clock_counter((adev))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 1cf1f6331db1..190a4a4e9d7a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -862,6 +862,27 @@ static int amdgpu_ras_enable_all_features(struct
> amdgpu_device *adev,  }
>  /* feature ctl end */
>=20
> +static struct amdgpu_ras_block_object*=20
> +amdgpu_ras_get_ras_block(struct
> amdgpu_device *adev,
> +					enum amdgpu_ras_block block,
> uint32_t sub_block_index) {
> +	struct amdgpu_ras_block_object *obj, *tmp;
> +
> +	if (block >=3D AMDGPU_RAS_BLOCK__LAST) {
> +		return NULL;
> +	}
>[Tao] The "{}" can be dropped since only one line under the if.
    [Thomas] OK.

> +
> +	list_for_each_entry_safe(obj, tmp, &adev->ras_list, node) {
> +		if( !obj->ops || !obj->ops->ras_block_match) {
[Tao]  Need a space after "if" and the space before "!obj" can be removed.=
=20

> +			dev_info(adev->dev, "%s don't config ops or
> ras_block_match\n", obj->name);
> +			continue;
> +		}
> +		if (!obj->ops->ras_block_match(obj, block, sub_block_index)) {
> +			return obj;
> +		}
>[Tao] The "{}" can be removed.
      [Thomas] OK.

> +	}
> +
> +	return NULL;
> +}
>[Tao] This is a generic ras function, not gfx specific, the code can be mo=
ved to patch #1.
    [Thomas] OK.
>=20
>  void amdgpu_ras_mca_query_error_status(struct amdgpu_device *adev,
>  				       struct ras_common_if *ras_block, @@ -
> 892,6 +913,7 @@ void amdgpu_ras_mca_query_error_status(struct
> amdgpu_device *adev,  int amdgpu_ras_query_error_status(struct
> amdgpu_device *adev,
>  				  struct ras_query_if *info)
>  {
> +	struct amdgpu_ras_block_object* block_obj =3D NULL;
>  	struct ras_manager *obj =3D amdgpu_ras_find_obj(adev, &info->head);
>  	struct ras_err_data err_data =3D {0, 0, 0, NULL};
>  	int i;
> @@ -899,6 +921,8 @@ int amdgpu_ras_query_error_status(struct
> amdgpu_device *adev,
>  	if (!obj)
>  		return -EINVAL;
>=20
> +	block_obj =3D amdgpu_ras_get_ras_block(adev, info->head.block, 0);
> +
>  	switch (info->head.block) {
>  	case AMDGPU_RAS_BLOCK__UMC:
>  		if (adev->umc.ras_funcs &&
> @@ -919,13 +943,17 @@ int amdgpu_ras_query_error_status(struct
> amdgpu_device *adev,
>  		}
>  		break;
>  	case AMDGPU_RAS_BLOCK__GFX:
> -		if (adev->gfx.ras_funcs &&
> -		    adev->gfx.ras_funcs->query_ras_error_count)
> -			adev->gfx.ras_funcs->query_ras_error_count(adev,
> &err_data);
> +		if (!block_obj || !block_obj->ops)	{
> +			dev_info(adev->dev, "%s don't config ras function \n",
> +				get_ras_block_str(&info->head));
> +			return -EINVAL;
> +		}
>[Tao] Can we put the check behind "block_obj =3D amdgpu_ras_get_ras_block"=
? The same suggestion to all similar code.
       [Thomas] OK.
> +
> +		if (block_obj->ops->query_ras_error_count)
> +			block_obj->ops->query_ras_error_count(adev,
> &err_data);
>=20
> -		if (adev->gfx.ras_funcs &&
> -		    adev->gfx.ras_funcs->query_ras_error_status)
> -			adev->gfx.ras_funcs->query_ras_error_status(adev);
> +		if (block_obj->ops->query_ras_error_status)
> +			block_obj->ops->query_ras_error_status(adev);
>  		break;
>  	case AMDGPU_RAS_BLOCK__MMHUB:
>  		if (adev->mmhub.ras_funcs &&
> @@ -1012,18 +1040,21 @@ int amdgpu_ras_query_error_status(struct
> amdgpu_device *adev,  int amdgpu_ras_reset_error_status(struct
> amdgpu_device *adev,
>  		enum amdgpu_ras_block block)
>  {
> +	struct amdgpu_ras_block_object* block_obj =3D=20
> +amdgpu_ras_get_ras_block(adev, block, 0);
>  	if (!amdgpu_ras_is_supported(adev, block))
>  		return -EINVAL;
>=20
>  	switch (block) {
>  	case AMDGPU_RAS_BLOCK__GFX:
> -		if (adev->gfx.ras_funcs &&
> -		    adev->gfx.ras_funcs->reset_ras_error_count)
> -			adev->gfx.ras_funcs->reset_ras_error_count(adev);
> +		if (!block_obj || !block_obj->ops)	{
> +			dev_info(adev->dev, "%s don't config ras function \n",
> ras_block_str(block));
> +			return -EINVAL;
> +		}
> +		if (block_obj->ops->reset_ras_error_count)
> +			block_obj->ops->reset_ras_error_count(adev);
>=20
> -		if (adev->gfx.ras_funcs &&
> -		    adev->gfx.ras_funcs->reset_ras_error_status)
> -			adev->gfx.ras_funcs->reset_ras_error_status(adev);
> +		if (block_obj->ops->reset_ras_error_status)
> +			block_obj->ops->reset_ras_error_status(adev);
>  		break;
>  	case AMDGPU_RAS_BLOCK__MMHUB:
>  		if (adev->mmhub.ras_funcs &&
> @@ -1088,7 +1119,8 @@ int amdgpu_ras_error_inject(struct amdgpu_device=20
> *adev,
>  		.address =3D info->address,
>  		.value =3D info->value,
>  	};
> -	int ret =3D 0;
> +	int ret =3D -EINVAL;
> +	struct amdgpu_ras_block_object* block_obj =3D=20
> +amdgpu_ras_get_ras_block(adev, info->head.block,
> +info->head.sub_block_index);
>=20
>  	if (!obj)
>  		return -EINVAL;
> @@ -1102,11 +1134,12 @@ int amdgpu_ras_error_inject(struct=20
> amdgpu_device *adev,
>=20
>  	switch (info->head.block) {
>  	case AMDGPU_RAS_BLOCK__GFX:
> -		if (adev->gfx.ras_funcs &&
> -		    adev->gfx.ras_funcs->ras_error_inject)
> -			ret =3D adev->gfx.ras_funcs->ras_error_inject(adev, info);
> -		else
> -			ret =3D -EINVAL;
> +		if (!block_obj || !block_obj->ops)	{
> +			dev_info(adev->dev, "%s don't config ras function \n",
> get_ras_block_str(&info->head));
> +			return -EINVAL;
> +		}
> +		if (block_obj->ops->ras_error_inject)
> +			ret =3D block_obj->ops->ras_error_inject(adev, info);
>  		break;
>  	case AMDGPU_RAS_BLOCK__UMC:
>  	case AMDGPU_RAS_BLOCK__SDMA:
> @@ -1727,15 +1760,20 @@ static void=20
> amdgpu_ras_log_on_err_counter(struct
> amdgpu_device *adev)  static void amdgpu_ras_error_status_query(struct
> amdgpu_device *adev,
>  					  struct ras_query_if *info)
>  {
> +	struct amdgpu_ras_block_object* block_obj =3D=20
> +amdgpu_ras_get_ras_block(adev, info->head.block,
> +info->head.sub_block_index);
>  	/*
>  	 * Only two block need to query read/write
>  	 * RspStatus at current state
>  	 */
>  	switch (info->head.block) {
>  	case AMDGPU_RAS_BLOCK__GFX:
> -		if (adev->gfx.ras_funcs &&
> -		    adev->gfx.ras_funcs->query_ras_error_status)
> -			adev->gfx.ras_funcs->query_ras_error_status(adev);
> +		if (!block_obj || !block_obj->ops)	{
> +			dev_info(adev->dev, "%s don't config ras function \n",
> get_ras_block_str(&info->head));
> +			return ;
> +		}
> +
> +		if (block_obj->ops->query_ras_error_status)
> +			block_obj->ops->query_ras_error_status(adev);
>  		break;
>  	case AMDGPU_RAS_BLOCK__MMHUB:
>  		if (adev->mmhub.ras_funcs &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 08e91e7245df..2ffde223c4f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -817,7 +817,7 @@ static int gfx_v9_0_get_cu_info(struct=20
> amdgpu_device *adev,  static uint64_t=20
> gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev);  static=20
> void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring); static u64=20
> gfx_v9_0_ring_get_rptr_compute(struct amdgpu_ring *ring); -static int=20
> gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
> +static void gfx_v9_0_query_ras_error_count(struct amdgpu_device=20
> +*adev,
>  					  void *ras_error_status);
>  static int gfx_v9_0_ras_error_inject(struct amdgpu_device *adev,
>  				     void *inject_if);
> @@ -2118,6 +2118,18 @@ static void gfx_v9_0_select_me_pipe_q(struct=20
> amdgpu_device *adev,
>  	soc15_grbm_select(adev, me, pipe, q, vm);  }
>=20
> +static int gfx_v9_0_ras_block_match(struct amdgpu_ras_block_object*=20
> +block_obj, enum amdgpu_ras_block block, uint32_t sub_block_index) {
> +	if(!block_obj)
> +		return -EINVAL;
> +
> +	if(block_obj->block =3D=3D block) {
> +		return 0;
> +	}
> +
> +	return -EINVAL;
>[Tao] The return type can be changed to bool and return value is true or f=
alse instead of -EINVAL and 0.
       [Thomas] I think the return type is int maybe have more scalability =
for a unified ops interface.

> +}
>[Tao] It's better to implement a general ras block match function in amdgp=
u_ras.c
       [Thomas] The match method of mca block is different from other block=
s. Others blocks only use block to match, but mac block should use block an=
d sub block index to match.
	          But I can add a default match function in the amdgpu_ras.c, if i=
p block does't define .ras_block_match function, it will use the default ma=
tch function in amdgpu_ras.c.
> +
>  static const struct amdgpu_gfx_funcs gfx_v9_0_gfx_funcs =3D {
>          .get_gpu_clock_counter =3D &gfx_v9_0_get_gpu_clock_counter,
>          .select_se_sh =3D &gfx_v9_0_select_se_sh, @@ -2127,12 +2139,21=20
> @@ static const struct amdgpu_gfx_funcs gfx_v9_0_gfx_funcs =3D {
>          .select_me_pipe_q =3D &gfx_v9_0_select_me_pipe_q,  };
>=20
> -static const struct amdgpu_gfx_ras_funcs gfx_v9_0_ras_funcs =3D {
> -	.ras_late_init =3D amdgpu_gfx_ras_late_init,
> -	.ras_fini =3D amdgpu_gfx_ras_fini,
> -	.ras_error_inject =3D &gfx_v9_0_ras_error_inject,
> -	.query_ras_error_count =3D &gfx_v9_0_query_ras_error_count,
> -	.reset_ras_error_count =3D &gfx_v9_0_reset_ras_error_count,
> +const struct amdgpu_ras_block_ops  gfx_v9_0_ras_ops =3D {

>[Tao]  static const?
    [Thomas] OK.
> +		.ras_block_match =3D gfx_v9_0_ras_block_match,
> +		.ras_late_init =3D amdgpu_gfx_ras_late_init,
> +		.ras_fini =3D amdgpu_gfx_ras_fini,
> +		.ras_error_inject =3D &gfx_v9_0_ras_error_inject,
> +		.query_ras_error_count =3D &gfx_v9_0_query_ras_error_count,
> +		.reset_ras_error_count =3D &gfx_v9_0_reset_ras_error_count, };
> +
> +static struct amdgpu_gfx_ras gfx_v9_0_ras =3D {
> +	.ras_block =3D {
> +		.name =3D "gfx",
> +		.block =3D AMDGPU_RAS_BLOCK__GFX,
> +		.ops =3D &gfx_v9_0_ras_ops,
> +	},
>  };
>=20
>  static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev) @@=20
> -2161,7
> +2182,7 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_device=20
> +*adev)
>  		DRM_INFO("fix gfx.config for vega12\n");
>  		break;
>  	case CHIP_VEGA20:
> -		adev->gfx.ras_funcs =3D &gfx_v9_0_ras_funcs;
> +		adev->gfx.ras =3D &gfx_v9_0_ras;
>  		adev->gfx.config.max_hw_contexts =3D 8;
>  		adev->gfx.config.sc_prim_fifo_size_frontend =3D 0x20;
>  		adev->gfx.config.sc_prim_fifo_size_backend =3D 0x100; @@ -
> 2187,7 +2208,7 @@ static int gfx_v9_0_gpu_early_init(struct=20
> amdgpu_device
> *adev)
>  			gb_addr_config =3D RAVEN_GB_ADDR_CONFIG_GOLDEN;
>  		break;
>  	case CHIP_ARCTURUS:
> -		adev->gfx.ras_funcs =3D &gfx_v9_4_ras_funcs;
> +		adev->gfx.ras =3D &gfx_v9_4_ras;
>  		adev->gfx.config.max_hw_contexts =3D 8;
>  		adev->gfx.config.sc_prim_fifo_size_frontend =3D 0x20;
>  		adev->gfx.config.sc_prim_fifo_size_backend =3D 0x100; @@ -
> 2208,7 +2229,7 @@ static int gfx_v9_0_gpu_early_init(struct=20
> amdgpu_device
> *adev)
>  		gb_addr_config |=3D 0x22010042;
>  		break;
>  	case CHIP_ALDEBARAN:
> -		adev->gfx.ras_funcs =3D &gfx_v9_4_2_ras_funcs;
> +		adev->gfx.ras =3D &gfx_v9_4_2_ras;
>  		adev->gfx.config.max_hw_contexts =3D 8;
>  		adev->gfx.config.sc_prim_fifo_size_frontend =3D 0x20;
>  		adev->gfx.config.sc_prim_fifo_size_backend =3D 0x100; @@ -
> 2227,6 +2248,14 @@ static int gfx_v9_0_gpu_early_init(struct=20
> amdgpu_device
> *adev)
>  		break;
>  	}
>=20
> +	if (adev->gfx.ras) {
> +		err =3D amdgpu_ras_register_ras_block(adev, &adev->gfx.ras-
> >ras_block);
> +		if (err) {
> +			DRM_ERROR("Failed to register gfx ras block!\n");
> +			return err;
> +		}
> +	}
> +
>  	adev->gfx.config.gb_addr_config =3D gb_addr_config;
>=20
>  	adev->gfx.config.gb_addr_config_fields.num_pipes =3D 1 << @@ -2448,9
> +2477,9 @@ static int gfx_v9_0_sw_fini(void *handle)
>  	int i;
>  	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>=20
> -	if (adev->gfx.ras_funcs &&
> -	    adev->gfx.ras_funcs->ras_fini)
> -		adev->gfx.ras_funcs->ras_fini(adev);
> +	if (adev->gfx.ras && adev->gfx.ras->ras_block.ops &&
> +	    adev->gfx.ras->ras_block.ops->ras_fini)
> +		adev->gfx.ras->ras_block.ops->ras_fini(adev);
>=20
>  	for (i =3D 0; i < adev->gfx.num_gfx_rings; i++)
>  		amdgpu_ring_fini(&adev->gfx.gfx_ring[i]);
> @@ -4888,16 +4917,16 @@ static int gfx_v9_0_ecc_late_init(void *handle)
>  	if (r)
>  		return r;
>=20
> -	if (adev->gfx.ras_funcs &&
> -	    adev->gfx.ras_funcs->ras_late_init) {
> -		r =3D adev->gfx.ras_funcs->ras_late_init(adev);
> +	if (adev->gfx.ras && adev->gfx.ras->ras_block.ops &&
> +	    adev->gfx.ras->ras_block.ops->ras_late_init) {
> +		r =3D adev->gfx.ras->ras_block.ops->ras_late_init(adev);
>  		if (r)
>  			return r;
>  	}
>=20
> -	if (adev->gfx.ras_funcs &&
> -	    adev->gfx.ras_funcs->enable_watchdog_timer)
> -		adev->gfx.ras_funcs->enable_watchdog_timer(adev);
> +	if (adev->gfx.ras &&
> +	    adev->gfx.ras->enable_watchdog_timer)
> +		adev->gfx.ras->enable_watchdog_timer(adev);
>=20
>  	return 0;
>  }
> @@ -6841,7 +6870,7 @@ static void=20
> gfx_v9_0_reset_ras_error_count(struct
> amdgpu_device *adev)
>  	WREG32_SOC15(GC, 0, mmATC_L2_CACHE_4K_EDC_INDEX, 255);  }
>=20
> -static int gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
> +static void gfx_v9_0_query_ras_error_count(struct amdgpu_device=20
> +*adev,
>  					  void *ras_error_status)
>  {
>  	struct ras_err_data *err_data =3D (struct ras_err_data=20
> *)ras_error_status; @@ -6850,7 +6879,7 @@ static int=20
> gfx_v9_0_query_ras_error_count(struct
> amdgpu_device *adev,
>  	uint32_t reg_value;
>=20
>  	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
> -		return -EINVAL;
> +		return;
>=20
>  	err_data->ue_count =3D 0;
>  	err_data->ce_count =3D 0;
> @@ -6879,8 +6908,6 @@ static int gfx_v9_0_query_ras_error_count(struct
> amdgpu_device *adev,
>  	mutex_unlock(&adev->grbm_idx_mutex);
>=20
>  	gfx_v9_0_query_utc_edc_status(adev, err_data);
> -
> -	return 0;
>  }
>=20
>  static void gfx_v9_0_emit_mem_sync(struct amdgpu_ring *ring) diff=20
> --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
> index b4789dfc2bb9..2d816addbd4d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
> @@ -863,7 +863,7 @@ static int gfx_v9_4_ras_error_count(struct=20
> amdgpu_device *adev,
>  	return 0;
>  }
>=20
> -static int gfx_v9_4_query_ras_error_count(struct amdgpu_device *adev,
> +static void gfx_v9_4_query_ras_error_count(struct amdgpu_device=20
> +*adev,
>  					  void *ras_error_status)
>  {
>  	struct ras_err_data *err_data =3D (struct ras_err_data=20
> *)ras_error_status; @@ -872,7 +872,7 @@ static int=20
> gfx_v9_4_query_ras_error_count(struct
> amdgpu_device *adev,
>  	uint32_t reg_value;
>=20
>  	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
> -		return -EINVAL;
> +		return;
>=20
>  	err_data->ue_count =3D 0;
>  	err_data->ce_count =3D 0;
> @@ -903,7 +903,6 @@ static int gfx_v9_4_query_ras_error_count(struct
> amdgpu_device *adev,
>=20
>  	gfx_v9_4_query_utc_edc_status(adev, err_data);
>=20
> -	return 0;
>  }
>=20
>  static void gfx_v9_4_reset_ras_error_count(struct amdgpu_device=20
> *adev) @@
> -1029,11 +1028,31 @@ static void=20
> gfx_v9_4_query_ras_error_status(struct
> amdgpu_device *adev)
>  	mutex_unlock(&adev->grbm_idx_mutex);
>  }
>=20
> -const struct amdgpu_gfx_ras_funcs gfx_v9_4_ras_funcs =3D {
> -        .ras_late_init =3D amdgpu_gfx_ras_late_init,
> -        .ras_fini =3D amdgpu_gfx_ras_fini,
> -        .ras_error_inject =3D &gfx_v9_4_ras_error_inject,
> -        .query_ras_error_count =3D &gfx_v9_4_query_ras_error_count,
> -        .reset_ras_error_count =3D &gfx_v9_4_reset_ras_error_count,
> -        .query_ras_error_status =3D &gfx_v9_4_query_ras_error_status,
> +static int gfx_v9_4_ras_block_match(struct amdgpu_ras_block_object*=20
> +block_obj, enum amdgpu_ras_block block, uint32_t sub_block_index) {
> +	if(!block_obj)
> +		return -EINVAL;
> +
> +	if(block_obj->block =3D=3D block) {
> +		return 0;
> +	}
> +	return -EINVAL;
> +}
> +
> +const struct amdgpu_ras_block_ops  gfx_v9_4_ras_ops =3D {
> +	.ras_block_match =3D gfx_v9_4_ras_block_match,
> +	.ras_late_init =3D amdgpu_gfx_ras_late_init,
> +	.ras_fini =3D amdgpu_gfx_ras_fini,
> +	.ras_error_inject =3D &gfx_v9_4_ras_error_inject,
> +	.query_ras_error_count =3D &gfx_v9_4_query_ras_error_count,
> +	.reset_ras_error_count =3D &gfx_v9_4_reset_ras_error_count,
> +	.query_ras_error_status =3D &gfx_v9_4_query_ras_error_status, };
> +
> +struct amdgpu_gfx_ras gfx_v9_4_ras =3D {
> +	.ras_block =3D {
> +		.name =3D "gfx",
> +		.block =3D AMDGPU_RAS_BLOCK__GFX,
> +		.ops =3D &gfx_v9_4_ras_ops,
> +	},
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h
> index bdd16b568021..ca520a767267 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h
> @@ -24,6 +24,6 @@
>  #ifndef __GFX_V9_4_H__
>  #define __GFX_V9_4_H__
>=20
> -extern const struct amdgpu_gfx_ras_funcs gfx_v9_4_ras_funcs;
> +extern struct amdgpu_gfx_ras gfx_v9_4_ras;
>=20
>  #endif /* __GFX_V9_4_H__ */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> index 54306fd45ff1..2744709fa09d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> @@ -1644,14 +1644,14 @@ static int=20
> gfx_v9_4_2_query_utc_edc_count(struct
> amdgpu_device *adev,
>  	return 0;
>  }
>=20
> -static int gfx_v9_4_2_query_ras_error_count(struct amdgpu_device=20
> *adev,
> +static void gfx_v9_4_2_query_ras_error_count(struct amdgpu_device=20
> +*adev,
>  					    void *ras_error_status)
>  {
>  	struct ras_err_data *err_data =3D (struct ras_err_data *)ras_error_stat=
us;
>  	uint32_t sec_count =3D 0, ded_count =3D 0;
>=20
>  	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
> -		return -EINVAL;
> +		return;
>=20
>  	err_data->ue_count =3D 0;
>  	err_data->ce_count =3D 0;
> @@ -1664,7 +1664,6 @@ static int=20
> gfx_v9_4_2_query_ras_error_count(struct
> amdgpu_device *adev,
>  	err_data->ce_count +=3D sec_count;
>  	err_data->ue_count +=3D ded_count;
>=20
> -	return 0;
>  }
>=20
>  static void gfx_v9_4_2_reset_utc_err_status(struct amdgpu_device=20
> *adev) @@
> -1934,13 +1933,34 @@ static void=20
> gfx_v9_4_2_reset_sq_timeout_status(struct
> amdgpu_device *adev)
>  	mutex_unlock(&adev->grbm_idx_mutex);
>  }
>=20
> -const struct amdgpu_gfx_ras_funcs gfx_v9_4_2_ras_funcs =3D {
> -	.ras_late_init =3D amdgpu_gfx_ras_late_init,
> -	.ras_fini =3D amdgpu_gfx_ras_fini,
> -	.ras_error_inject =3D &gfx_v9_4_2_ras_error_inject,
> -	.query_ras_error_count =3D &gfx_v9_4_2_query_ras_error_count,
> -	.reset_ras_error_count =3D &gfx_v9_4_2_reset_ras_error_count,
> -	.query_ras_error_status =3D &gfx_v9_4_2_query_ras_error_status,
> -	.reset_ras_error_status =3D &gfx_v9_4_2_reset_ras_error_status,
> +static int gfx_v9_4_2_ras_block_match(struct amdgpu_ras_block_object*=20
> +block_obj, enum amdgpu_ras_block block, uint32_t sub_block_index) {
> +	if(!block_obj)
> +		return -EINVAL;
> +
> +	if(block_obj->block =3D=3D block) {
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +struct amdgpu_ras_block_ops  gfx_v9_4_2_ras_ops =3D{
> +		.ras_block_match =3D gfx_v9_4_2_ras_block_match,
> +		.ras_late_init =3D amdgpu_gfx_ras_late_init,
> +		.ras_fini =3D amdgpu_gfx_ras_fini,
> +		.ras_error_inject =3D &gfx_v9_4_2_ras_error_inject,
> +		.query_ras_error_count =3D &gfx_v9_4_2_query_ras_error_count,
> +		.reset_ras_error_count =3D &gfx_v9_4_2_reset_ras_error_count,
> +		.query_ras_error_status =3D
> &gfx_v9_4_2_query_ras_error_status,
> +		.reset_ras_error_status =3D &gfx_v9_4_2_reset_ras_error_status,
> +};
> +
> +struct amdgpu_gfx_ras gfx_v9_4_2_ras =3D {
> +	.ras_block =3D {
> +		.name =3D "gfx",
> +		.block =3D AMDGPU_RAS_BLOCK__GFX,
> +		.ops =3D &gfx_v9_4_2_ras_ops,
> +	},
>  	.enable_watchdog_timer =3D &gfx_v9_4_2_enable_watchdog_timer,
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
> index 6db1f88509af..7584624b641c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
> @@ -31,6 +31,6 @@ void gfx_v9_4_2_init_golden_registers(struct
> amdgpu_device *adev,  void gfx_v9_4_2_set_power_brake_sequence(struct
> amdgpu_device *adev);  int gfx_v9_4_2_do_edc_gpr_workarounds(struct
> amdgpu_device *adev);
>=20
> -extern const struct amdgpu_gfx_ras_funcs gfx_v9_4_2_ras_funcs;
> +extern struct amdgpu_gfx_ras gfx_v9_4_2_ras;
>=20
>  #endif /* __GFX_V9_4_2_H__ */
> --
> 2.25.1

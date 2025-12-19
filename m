Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC3FD74964
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Dec 2025 08:38:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 552DE10E1E0;
	Fri, 19 Dec 2025 08:38:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QtXcTjdH";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012058.outbound.protection.outlook.com
 [40.107.200.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EF4C10EC7F
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Dec 2025 08:38:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZqGOfc1zj2uX/JnWh9F0CeHtW6QivQ4rS8NcnoD1fM08OwOOTSGW4+qACVxY5/YPFmO+6ihmCkvSOir9ydRDYPlcrMwaUgCXEXG6sGQCzGyVKSFtaDldCb3j2ej/k412ByFu4Zqb5RCuCYJPFDqOhPFgWikmIDUocp2EdfOE6HjBSDwyrgc9URUj+0rP1CRNoyjgP+HzA3qqL5oK4hf0LU20pQ0mWDbQ7HDPDAgu3OFCDaoZvuUyA0LtI6Aop4BB/bobbeFZdeet5MvC5wSYCJjsqxvTdC8cXsbDa0YTb/dMLUAD5i0ZebXQdDf0aEze9JlvDfpJ43kDge1gl7b1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ImGNqqjL2gXAeWLbTRW7kEjKYmdX4JnqLqmSxSLVfFg=;
 b=nr+CNtsPQgSCh5YJWoKtoHPGxkvosihLbJOUOTp43WAd4shEmzUS93UQBgSbs9arwOS0vlh8y4mdCG2S3+UwXtXZm8HCpOB9Z17z7J3JSLAJGKL8VibUwzNwIfV41LWoLe7NpT6dFWEbcewLpQ3AQgA5VmhcSfHab+h/YZSEvYhhPzDliC5Xq3otGYCqx8e/l46t+7h4xYTx7bgRm5M/kanNeSqLI5r3Y0jMrCv3DqRCp+VBUbQ2oiwsJcznmS9dpnMckkzJjMzh8FswtHP7LxkxqgaGcH71dg8mHa0IE3ypfVH3syHD0w5tJZfVA3nqgEK93A9esdRBt09bSJumEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImGNqqjL2gXAeWLbTRW7kEjKYmdX4JnqLqmSxSLVfFg=;
 b=QtXcTjdHEwnoa9qTyUDABmJcGK4ysjOfK7WxqfajlyQspDQxnX2IMLlz+K81wHrx6cLWz/XW/oTy7JbVQte5bryxscx0IFytehdlhN1o4h7CxAy2w4d322kj8Ngz6xjzk8wi/NDnRJZd9wTzQuwTPpbQLg/UT67/UgCIHbrbkxA=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by IA1PR12MB7639.namprd12.prod.outlook.com (2603:10b6:208:425::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 08:37:57 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%5]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 08:37:57 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [RFC PATCH v3 06/10] drm/amdgpu: Add first level cwsr handler to
 userq
Thread-Topic: [RFC PATCH v3 06/10] drm/amdgpu: Add first level cwsr handler to
 userq
Thread-Index: AQHcZFV4Z+/9wadUJ0uYjZOWztZVFLUou3tw
Date: Fri, 19 Dec 2025 08:37:56 +0000
Message-ID: <DM4PR12MB515221758840AECFAECB9EDFE3A9A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20251203130436.745633-1-lijo.lazar@amd.com>
 <20251203130436.745633-7-lijo.lazar@amd.com>
In-Reply-To: <20251203130436.745633-7-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-12-19T08:32:56.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|IA1PR12MB7639:EE_
x-ms-office365-filtering-correlation-id: 4ba6bd64-18fc-4303-82c3-08de3ed9e8d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?jeb4PyHkAucsjHg3FcMmTMyaIgcLwqsMQXmZps1yZrgWctvBWYZ4EtzChxJL?=
 =?us-ascii?Q?ESPjo9dd7X7kOLzfYukkT0hZybS5p/3kqX4XHqLRCM5D0F81Mauo2sBd7Wh3?=
 =?us-ascii?Q?KjRn2IMqSPaW01rYdXb5tDqeanXY7zI/+yirSwv8U9ywRa4WhEG7Myh+NsZj?=
 =?us-ascii?Q?vralvVouYzvtn6z/8hbGEQhscJGKMutZWKXND7Q81voktbTmvJPq8dXG9f8h?=
 =?us-ascii?Q?uP2kLCXk44EiMVnxAFlRDMX2xqPtGPYv0eIUL2dilEt/+t2unz8Ny+468A1o?=
 =?us-ascii?Q?Dx0K5vk01krpGSNcWut4+EUdVY4+IAi1pMusC3XX/UmOLQoro5kdCo9U0xS/?=
 =?us-ascii?Q?H5demMp5bTZ1AQDFUk8MlTXGrfEPxG3YG+MJboQUMxkczElORl9M/C62ymhy?=
 =?us-ascii?Q?mWnca4LdGMXFEW+7DWhm/Z3/hHVJxIfa7ZXPoWNDHx2SB4sYoYjCBZtozv+m?=
 =?us-ascii?Q?6C8cToq4nsLRVCFXDoaEhHPJ5AmXDReZDT1sgeu8ZZQHSuIcM8cPjSGgl+cO?=
 =?us-ascii?Q?KS3vcTvc/yt59wktR0DjobCpAhcwuFBvQ36rYgKHoZV0V+MiSxCrCkUHM0BU?=
 =?us-ascii?Q?PaTWERXcj0Zbm4cy1C2HaStjuLXUgGc60iJgqDv1pz75aT2VcineZhsNYP3g?=
 =?us-ascii?Q?pan6U44+pgvcRS678qrBf5qyVYKgmULoizDhpEqvEH7WPl96Ui92sA0B4LDE?=
 =?us-ascii?Q?7z+hROlZzut+rljB4Gfmsa4V9lWcw+nOpeFabaxAag/vy26zM2FmXfMO5z4R?=
 =?us-ascii?Q?E+ioIYh2qwwhrzCKsw7KzYEmh19myP7GGsXvOfeigdyl8YAwuPE26ypIIrWc?=
 =?us-ascii?Q?LOItnsV+HS6hT/cH320EU8lvdk62SFwmskA5VugE78XS1UzXPnkOXdj+JQcb?=
 =?us-ascii?Q?u1Nv8wWuvva7v+9smAM+lhZBoCYNF5+oUe7sm1r5/ISeFD5V9Iia0rQxAU5z?=
 =?us-ascii?Q?AzIdGpTWBIrUx3n3VIrnhWvIatX38REHi7TTvfYS1SPljFqef+QIh4diV8Hg?=
 =?us-ascii?Q?RqJ/QRTqeQ9EoFSTrVu/J1FUlLC+fdDXHozIEipWXRiZkP7jRxTEZ2sVAPMh?=
 =?us-ascii?Q?37kQKSsXYB3zvnMz6klidn1PaWxPal05mI3pRjebweWGyPJSw+o2VKmXFewS?=
 =?us-ascii?Q?Smlwyyt7TF8vSXtYObxgilrry/bdW1BhDMJDmvwUg3DspSw9Jcz4RCQAzK87?=
 =?us-ascii?Q?fwhZVHCph/7Pk4BBKqiyFcpPpaecd/wtQ0JJp7nX4QLcF3RXtmAv3JZ9AJJI?=
 =?us-ascii?Q?2pt7WTnWMl/BplHRTEFJ9X+XPPm1yNZ3ORpjrStfVRxX9Pb3kRbXqg/PyqfG?=
 =?us-ascii?Q?Xf94DwmOsQfOEiE+aMtmSSI/rvyvaCQ4/HPqJXceZtgZ8DWQZGaglqaE5ZYH?=
 =?us-ascii?Q?BvJHKZ/Tf+fsggEIkVbOiyFVkc2u1ZNBCaXjb9ZVLduUzRyo2NkxpsgSaF6m?=
 =?us-ascii?Q?pDzjvJ8XBrN8liwanGoD+4F2K8JqHLcqqrzR2C6mGK78L+u89NdPOCDscjNE?=
 =?us-ascii?Q?ohVRi7iJJUj2urG5kKEttNBwTwu4/x3Vrz8q?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lq9Y6pCfnd2AzX0ub6sWfbc1c+7yJrYTt7ya/RvTfeHcH+m61Qm2L4MtEuiZ?=
 =?us-ascii?Q?yKj/VrBxap1DXadipJw8x5F/frsnbdYxa7uSwD44vyFbkDccM0tWN5N49hiH?=
 =?us-ascii?Q?E9izA4PlZi2D1SSU+ua83D6p+WoekWsfCvr8Wse3zNH7ZkQwnP5QbgtGqUJb?=
 =?us-ascii?Q?dtDyz4+gm0CccYG4ekwwM3FL4BywKVckL2jsuepmpCEGc3oSrg9HY83RrDj3?=
 =?us-ascii?Q?12cSXMa3DNJXjmzNLSi8T+kd7M60dRghv9EYt20lgrvkAeIHtg3g2m5G6rbv?=
 =?us-ascii?Q?4OWcVIEQ8Y7cBMpqEnnok1O0iwh95Y7Jjdevruwo6cgcT5l9EQF8QfcZPaLO?=
 =?us-ascii?Q?k/Q/Bnf92UMMujqMTM6sA/kh6U6uP5BoV0i2OiQ0AJLxQIKDoaePVzBNFp2o?=
 =?us-ascii?Q?6pKO+zpMzWhfF60T0UtNbo8PlmRvxtKADsQFIBVIT000DGo0dNz9S4wUge3J?=
 =?us-ascii?Q?9IOVrOt/nbm9MKRGBiX8zO4MvYQkz3NEaMdMAtydWLjc0sIWjwfvVfrKu6Fr?=
 =?us-ascii?Q?xbD7yYOw55KYgzvfTtwYhFiDba5qgMqxx1ey+RkJt+yM4jeWPY27EsVv4lKH?=
 =?us-ascii?Q?YCLzjpbkg+p4pG1S6rdG4xS1HizG/HkJ7Rq5PAMJNwfgismpwnHoIJ4BKKWG?=
 =?us-ascii?Q?rPlca6OaH3JKICYYfgpX2Y7iiWa7WiyOWe8RbIpZHdEW2TH+cw8XdU9mpXwf?=
 =?us-ascii?Q?r+Ac0UF+nmedcTE2UrOsNzMhXqF/LiN+lUU/q7xb4PvRUsBWze0xy5k7hyDN?=
 =?us-ascii?Q?SzZd5dUtaNa3dSWR9TgbIZD60HxbQw570GwnHuJEb91SVFQr/Q3PS7JsFweH?=
 =?us-ascii?Q?a8VVBbi3DOlSwzE2r1hvQTwImNDifLkuXNw4h7zD1pMp7CjA72lkQOkzUsq5?=
 =?us-ascii?Q?kmg4tn9bpQwA6bQmUr0gPtLjC5RcSWvAd/YDPE+v0CBdFXKuc/GIflNXa/9w?=
 =?us-ascii?Q?SncGNHXULo6z6y/8WeQjjspE20BIoaoD153Y8eS5wqK5XvjtTMfwiqiGeBkr?=
 =?us-ascii?Q?o83fmakw6J6e0Ddba4TWheWQJvTmHUksv2DhQVbgfQdHvcyjdYyIQuDWo0Q1?=
 =?us-ascii?Q?KQbigZ8Qi6W0zuiPeCuThxZOUYM670fXwlvLyvFjjPoWFhTvLSwV2VAGGN85?=
 =?us-ascii?Q?oBgCY5AGH9QDMyN1X5cjH5CDPTSir4+shSwBOr5nk9Qha4DV792zbm6fB/7P?=
 =?us-ascii?Q?Bh39H4Hxw9tB0r9QCnNRURxZcY8/MGylacYzzgqzxyBC4c265E7Up1DVonL0?=
 =?us-ascii?Q?JhJIMJCj3dTgjc29iCNQfKg05LAN6G0flXc89hrg4Ad+1R248IL/9CNYhh2G?=
 =?us-ascii?Q?u7D+9Wg3C3MJJFEOFHeIHil6D8btP6kjgHKTOCeYic6mMyaMdyIrhwDU6XBA?=
 =?us-ascii?Q?MlVUv/yr/1haBN7h9pd1ZWsstXT4jn4obJQDcgCFBr14052oWdWulPs7qLNe?=
 =?us-ascii?Q?hZbhEq0sD5fVMN8ZxiX4zeyTU3TFw4+AxJ3cKA3i/leFhI7wKdUq0eOdMvbc?=
 =?us-ascii?Q?UI04nlt4mndrfDcEZIPXt8sQocejugGRqzOxiB0pPSCBs8hf/f1l4ZCm/wgw?=
 =?us-ascii?Q?MEwcZqeqePbi/YxeSwo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ba6bd64-18fc-4303-82c3-08de3ed9e8d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2025 08:37:56.7421 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rptl/cfjJKfvMKRAwd3I8oj896QpWLiZ4cdoveM4mulMsnbV4CLU9k1NT0xsQIIDof9abrJH+Bo3HK0Ti0sqcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7639
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

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Wednesday, December 3, 2025 8:55 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [RFC PATCH v3 06/10] drm/amdgpu: Add first level cwsr handler to=
 userq
>
> Add cwsr_trap_obj to render file handle. It maps the first level cwsr han=
dler to the
> vm with which the file handle is associated. Use cwsr trap object's tba/t=
ma address
> for the userqueue.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 8 ++++++++
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 6 ++++++
>  3 files changed, 16 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index b9920cab5d31..ec2919a9c636 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -332,6 +332,7 @@ struct amdgpu_hive_info;  struct amdgpu_reset_context=
;
> struct amdgpu_reset_control;  struct amdgpu_cwsr_isa;
> +struct amdgpu_cwsr_trap_obj;
>
>  enum amdgpu_cp_irq {
>       AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP =3D 0,
> @@ -505,6 +506,7 @@ struct amdgpu_fpriv {
>       struct idr              bo_list_handles;
>       struct amdgpu_ctx_mgr   ctx_mgr;
>       struct amdgpu_userq_mgr userq_mgr;
> +     struct amdgpu_cwsr_trap_obj *cwsr_trap;
>
>       /* Eviction fence infra */
>       struct amdgpu_eviction_fence_mgr evf_mgr; diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index b3e6b3fcdf2c..398d6c8d343c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -46,6 +46,7 @@
>  #include "amdgpu_reset.h"
>  #include "amd_pcie.h"
>  #include "amdgpu_userq.h"
> +#include "amdgpu_cwsr.h"
>
>  void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)  { @@ -
> 1452,6 +1453,12 @@ int amdgpu_driver_open_kms(struct drm_device *dev, str=
uct
> drm_file *file_priv)
>       if (r)
>               DRM_WARN("Can't setup usermode queues, use legacy workload
> submission only\n");
>
> +     if (amdgpu_cwsr_is_enabled(adev)) {
> +             r =3D amdgpu_cwsr_alloc(adev, &fpriv->vm, &fpriv->cwsr_trap=
);
> +             if (r)
> +                     dev_dbg(adev->dev, "cwsr trap not enabled");
> +     }
> +
>       r =3D amdgpu_eviction_fence_init(&fpriv->evf_mgr);
>       if (r)
>               goto error_vm;
> @@ -1524,6 +1531,7 @@ void amdgpu_driver_postclose_kms(struct drm_device
> *dev,
>       }
>
>       amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
> +     amdgpu_cwsr_free(adev, &fpriv->vm, &fpriv->cwsr_trap);
>       amdgpu_vm_fini(adev, &fpriv->vm);
>
>       if (pasid)
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index 8b0aeb89025a..480f4806e951 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -26,6 +26,7 @@
>  #include "amdgpu_gfx.h"
>  #include "mes_userqueue.h"
>  #include "amdgpu_userq_fence.h"
> +#include "amdgpu_cwsr.h"
>
>  #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE  #define
> AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE @@ -116,6 +117,7 @@ static
> int convert_to_mes_priority(int priority)  static int mes_userq_map(struc=
t
> amdgpu_usermode_queue *queue)  {
>       struct amdgpu_userq_mgr *uq_mgr =3D queue->userq_mgr;
> +     struct amdgpu_fpriv *fpriv =3D uq_mgr_to_fpriv(uq_mgr);
>       struct amdgpu_device *adev =3D uq_mgr->adev;
>       struct amdgpu_userq_obj *ctx =3D &queue->fw_obj;
>       struct amdgpu_mqd_prop *userq_props =3D queue->userq_prop; @@ -145,=
6
> +147,10 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
>       queue_input.doorbell_offset =3D userq_props->doorbell_index;
>       queue_input.page_table_base_addr =3D amdgpu_gmc_pd_addr(queue->vm-
> >root.bo);
>       queue_input.wptr_mc_addr =3D queue->wptr_obj.gpu_addr;
> +     if (fpriv->cwsr_trap) {
> +             queue_input.tba_addr =3D fpriv->cwsr_trap->tba_gpu_va_addr;
> +             queue_input.tma_addr =3D fpriv->cwsr_trap->tma_gpu_va_addr;
[Zhang, Jesse(Jie)]  the  queue_input.trap_en setting   is missing here.

> +     }
>
>       amdgpu_mes_lock(&adev->mes);
>       r =3D adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
> --
> 2.49.0


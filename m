Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E571C30653
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jul 2024 06:51:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D368010E988;
	Thu,  4 Jul 2024 06:51:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H0vBMLuG";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 369ED10E988
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jul 2024 06:51:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1GZCK03GlGS05XYkZNRUL2GMyleacLqTKpPI4t2QNkzgaN6+peJrSnidQVUG4wtL/nqcnQznvAUEqdmqX6S2zAciaqXl+49r3fLQjz6fjiecL04ptfmTkIWKy6d1fBjeUJf0fqlyXjaGpqIIlVu4LUuCU5NDfiKZr83AWVFwwOeKPGnLeloyZT5QeTXjA+o/PTGLta+Uca7UJy9UIYx8r0Wu6nkYj/lRxg3ujdJ/QPcc31SJ1fDaQwazwKcyhItxdgpdxSqBJru9DPD3us32oHVf4DXs0HJnJfdbXQqlc4KOU7oDzAICRu3eYKbQVeY8a6T1qj/+Lepbg8W9P7vDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oeqr7/+yHpzmQlhYMqCsRknpGT2MlV2bPAUQzSihKDQ=;
 b=joqudCbhQxfJhjSwqtMTQT0noSM3zzfnP/YV33Hbi//nJOAiDKyT4FPqPAc31bF0Q4OZfMinVGK/fEiDnk1aNclbmF7IJo6q+g2vM6fQ/4XX6FAs/1rCa89TJXQ4CJ1bBBRLWK23uVB/lD5OwuzdycR9sSRwIdTCIUNImXYhGV+rEwuWOgEk1JnUa9nrY0oGvNyi//6FgFkyEOb7HQCTonicW54sSS6fBXEJGkhoXhzwwahy+G5aHZMYyZpnrxHVP5MaLEV5UDbTXC0O1JUObZbfWG76+c2Hm2ETb+j+qsYDOCfY/TyE2JYHQHbvKDx2TVG/ZVm7C0aa+/rpqI5XHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeqr7/+yHpzmQlhYMqCsRknpGT2MlV2bPAUQzSihKDQ=;
 b=H0vBMLuG+3nVM0qU+83AvkEzhYTDp6HEqHoJQN1Uu3j6WlDK28uqHn/M8VZaoSr/y/8NwMGGvNqtD6zNarDOGgafYbGCtDcKy+el8FrtAIZe386bO/0EeNCUC5EQYksaXeJtttff20DQpqYnlaH/cGO6xhImKhT4GQL9KXF4fPc=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SA1PR12MB6848.namprd12.prod.outlook.com (2603:10b6:806:25f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Thu, 4 Jul
 2024 06:51:27 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%5]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 06:51:26 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: remove redundant semicolons in RAS_EVENT_LOG
Thread-Topic: [PATCH] drm/amdgpu: remove redundant semicolons in RAS_EVENT_LOG
Thread-Index: AQHazdZtKduVOOywpEOSf6BFb+gJ7bHmIXUA
Date: Thu, 4 Jul 2024 06:51:26 +0000
Message-ID: <PH7PR12MB87963C2E27654C6B4A7895FEB0DE2@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240704055240.1722656-1-kevinyang.wang@amd.com>
In-Reply-To: <20240704055240.1722656-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d2c37bbb-b666-4a42-84e9-45915228534e;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-04T06:51:16Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SA1PR12MB6848:EE_
x-ms-office365-filtering-correlation-id: b415e4c5-7fc7-4b83-9037-08dc9bf5b9fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?k0LVRCHRHOs2d/P5PgliIWMVqKWp0/lfXZTc1ZWWyDjigo5XeB+LpEj2chdv?=
 =?us-ascii?Q?OaAZLCsSB3BJPP8m6AR9NTIMXinLqVA0jnBxWL/rFTTqY/pPoGdObfE95R0a?=
 =?us-ascii?Q?EPEVUqNGmIP6NGB2eU5CMXGkNTp6d7xZ5DYRsa2OAhlKUbc0JPnAw1+saOa1?=
 =?us-ascii?Q?PxecJOA1kMER5ZKUv8Q9yFTayGH3LtLqCrdSAIqUEd/IBGjFgdv2zwOYVX+2?=
 =?us-ascii?Q?gDqQ/e6QXhAfGZJuRwcKLgUAh3eR5vxoEs18nuaGq0S2gk9az8LOvm6xMFA2?=
 =?us-ascii?Q?M1yoxeav7VNoBGY2a1im8XEJ8im9eFkQ7ySxWv1A5hZyESRLbSLnVPZu/35m?=
 =?us-ascii?Q?r7B2NnXe/6K3xtNt53PeMMfjBlsj3XU1jZ+g+hyE/irSRR9122ee5tIupQMy?=
 =?us-ascii?Q?wJ4wEQzcQgAQhsrYp1/dfVcvSe8WCoG5VQe9II7tr8i8754HXrriFzETmg5b?=
 =?us-ascii?Q?yvTQrGuB8iveL9jbTgLH4IFmKC9+2EOkFp9qOfH3trxGMH1+7dhMkYiQgnwD?=
 =?us-ascii?Q?9jK8qJ4Kj7R4r7/tvitHKWs7/NMmwKmVrWAf0Rh+vwitbbd9N6PfbR6M2wCk?=
 =?us-ascii?Q?n0zaU501oA05nhkdHsyon4447GQysDLdRV/gkeZGQ3jCLCbnZllWKxpWWaRY?=
 =?us-ascii?Q?k07BRA8NWcqMCNacoBtwTjBxbPq2eNZvK9NLSWYjNqM003Avqa6GBch7TisD?=
 =?us-ascii?Q?4wdVhRvPr91Q+F9ecV+EQ+AU3AUrtoXqL33E6Dz26FNf80k6O72WtEEQHjr2?=
 =?us-ascii?Q?JVZFFDqj2F6ST8r3Sp1mP3QGmGKL0neKzRcuiYsR76A9R1qXXxoB8crPzUzO?=
 =?us-ascii?Q?9pXFHg8qXNQKwtrll4BMBm/aMBUcTHn2XY6yvX1iLL6deimdYTxDAOhG94j0?=
 =?us-ascii?Q?7m2TnmBU5KyT3I+mbObO5b+MQJDE5+k6anQyHUny6xBsD/2NpJ1R2n/RqNP1?=
 =?us-ascii?Q?339H222l86A6knuB3Phze64PXM1CtYSl5oTBXQf/OpgNkVsaSoyMPTDt8aoU?=
 =?us-ascii?Q?a/w2Qghuiu7F2v70k33xS4mW/FLRYteTJ4U1B+ujdZF136tHkGUSDTxcxfqi?=
 =?us-ascii?Q?/M9V+kRCnUsUPCNdkup1b87X0ldzVHFBNyWOQCZ9FG77/L402wevXxSyqvNc?=
 =?us-ascii?Q?yRtWSR1327g1irUoju+F6D+pgNQd2QP4AsXJf8B/aLLshHcjXUiOTzd8VPVO?=
 =?us-ascii?Q?S8VObS9xJEqk45PWOZtIlzS3Zg6GGMRppCUiNVKZUi7G9ms++wg5Yr61q2TY?=
 =?us-ascii?Q?Zf81X0BBz4YLJ59JYddpT7EJKei6MfeJhE7T3N6JJ+HCkreSS1zBuiCdcIoq?=
 =?us-ascii?Q?9YtQy5+GKOETkR3QhyEN5xCwC2NB8sfsJiK4cXANvcUyqcs6YRiC+O6QpOjk?=
 =?us-ascii?Q?opsZHJTRK8CjJgWXets94F/b9YJUbZPbMJLe9+YHxmwm98CEUQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WQ1XUJz9BduuDi3S+E/4kPxLgzeMWHBMufIQ8szGubp87IecUCuydGwN39XI?=
 =?us-ascii?Q?YHksIajWh4sIFAqgQvyrdGfM5v9DTi70mb6lbmP3GMdtxpmYxoEagR+gWpU3?=
 =?us-ascii?Q?Io70Kh7CL8cPFzEDrtYpqnL2fMYropnmwMic7V3qhHXRbGHR0GbW6gzB0MOV?=
 =?us-ascii?Q?qeIPGk3O0JCeSsFtzp0wofq2EgmmUpFVAADCmq8atudmfsorGKp7tMMONSwE?=
 =?us-ascii?Q?vNK8ilVCgsqww3sOc75+RfOwvk3G3JM1uRx1L7Ti/PJNRhufJVAmTrgETekb?=
 =?us-ascii?Q?uYutkfhrulcrGC64aZAJbckUes3TGD1Nvfq408osSEJxhKVfAws2JQ836B8P?=
 =?us-ascii?Q?Z3zCcHnknoC4+fKv0KomSIQw1W47gAcq6RWxyR+/SexLvbbv2SWIEUKepQo4?=
 =?us-ascii?Q?qfX+Zg0ntDJtjI4n1phS6S6D9zrEBw+IEhWh1kvkjT5jOh6Cx9GCMTp6tGRG?=
 =?us-ascii?Q?fHZRd6uUhHR0jDUhGv5NYat0cKuOcB0IX0KnOfaAkFpysze3Q9s3eKLV4Fb9?=
 =?us-ascii?Q?N+I9+sbTE/BQNeMHIH4Cl3lQ3ovZRJDNtwBR2n5JSMazTkZ4FLmaVP0DUBGI?=
 =?us-ascii?Q?r3HiAoD0q1qqseDw8wlgWp+NNWWF4HRicdm4X2yebRn23Gc5KSrrPQZ6Xc0X?=
 =?us-ascii?Q?TFrnX303rrJWeQ6BdlL3UuPXxBIAOhG1Yo6Ot9MG5XiHoKpbyeUhbRIc1BxG?=
 =?us-ascii?Q?0Q9hRvHnYpp3zV9NRNlwmlL1HhlcqRIhOhHSTyDaOp9cxRfef42nidZOEA6l?=
 =?us-ascii?Q?mqwqlqrl1dVOWiHgCsnsuk1CHLYzRODNjUkdLJCEXT3wh7Xk6ZdjQtbrpeur?=
 =?us-ascii?Q?zCMW9zwdAsSl3US0B3kAjgbDtTrDtQ7m9NPf7A5600A1tRXormHjWGN+SvWd?=
 =?us-ascii?Q?uKmbhBEbk6mEzg1t0obusWNfH097BERrE1YQNrknP9MvEeXA082X6QLFI/w+?=
 =?us-ascii?Q?4MYe0QJ87Gve6A7nAaSHDej6Kot9dmSllCRxRhJoHdDyYvChej5bsQ9Yq7iO?=
 =?us-ascii?Q?HYyzYJ5aYYRm1r2plbFYLJPZvAa8NJ4ZWRZqk9oUxn53+Df9xoi2AwCoPqmK?=
 =?us-ascii?Q?M6hT4Nv0Je1/kRjhlAP/gs+EJIPSJv/HpUG3wxcqCKZTdK5Wrwe+CfKXE+O7?=
 =?us-ascii?Q?M19s15U79XU58vZ/Whf9pzU5XWYU64z5sM3TGToBl3z080SMkTLjD2aQfWpC?=
 =?us-ascii?Q?2su/joVGQIGqt2H+DR++n/qMc/3yLl5rtJjoB7+8gnaXyiHd8yax8Q5EoREV?=
 =?us-ascii?Q?kUeXv76pkgXLQbUeDGaGo4ID4wIdrs3MWJXoJubwqR2KJiP1FkRVGMUWbwNW?=
 =?us-ascii?Q?YhYs3znE6SJElinEQcT9aEusQjDz0Ty6hPCv79V1364A+K2m7S8Y1xzDOGJ0?=
 =?us-ascii?Q?pSxrBXzcGZf3aK7fXRaSYH/yALF+4yleXN0Zr9+uNj6DAaCWztiB31n2aItL?=
 =?us-ascii?Q?fG1PxqG7IpLcjkLI32aK4RD+ba3hwWVBv8dLiIWBD2TIm0anzw/IfmZcUd79?=
 =?us-ascii?Q?n1v2XwH2DwrKSlQZkUUGFOY7M2ePVBOsI72A7/olw6grrAhEasUFY2VdQmaf?=
 =?us-ascii?Q?2dK0B1NOoQrXQFBdBik=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b415e4c5-7fc7-4b83-9037-08dc9bf5b9fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 06:51:26.9146 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ywSt3HWfuHSKZka5Ta+2akUDOuM6HF/xB0znHqXLCp3CqzSGF62EqRWJWklmQ2Wc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6848
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

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Sent: Thursday, July 4, 2024 1:53 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>
> Subject: [PATCH] drm/amdgpu: remove redundant semicolons in
> RAS_EVENT_LOG
>
> remove redundant semicolons in RAS_EVENT_LOG to avoid code format check
> warning.
>
> Fixes: 951c09c88fca ("drm/amdgpu: fix compiler 'side-effect' check issue =
for
> RAS_EVENT_LOG()")
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 9224fc6418e4..518b10f190ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -72,7 +72,7 @@ struct amdgpu_iv_entry;
>  #define RAS_EVENT_ID_IS_VALID(x)     (!((x) & BIT_ULL(63)))
>
>  #define RAS_EVENT_LOG(adev, id, fmt, ...)    \
> -     amdgpu_ras_event_log_print((adev), (id), (fmt), ##__VA_ARGS__);
> +     amdgpu_ras_event_log_print((adev), (id), (fmt), ##__VA_ARGS__)
>
>  #define amdgpu_ras_mark_ras_event(adev, type)        \
>       (amdgpu_ras_mark_ras_event_caller((adev), (type),
> __builtin_return_address(0)))
> --
> 2.34.1


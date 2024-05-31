Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D04E7C27C4F
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 14:24:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A36410E0CC;
	Fri, 31 May 2024 14:24:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P6wyqEMa";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 701E010E0CC
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 14:24:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ae1iDc2pwUvoTKV5wvEQvSOgBRCqmJBrGmtkNlJdnGzzmt932NlI1grUdBoLNFd/UexK633Z4sbB98dD0Tj/FG1pIba3YryH88JBOlI6VdFfRk0nhBmVLS7mLq8+FzHllhaCpksUnZ3S2LrqZWSnMxeB3p+FcijuY5zjLX3Kw2yDeziGMNmuvkOe3wPC6gxcrLVm1iAyn6dCnvWxxQOla090b26fVJtBPss4db+2b+JnbMs5SuOfZsunXvk9/dDdVhOfGcNwxLfTEhMxK/sFzggZCuy+wOAs0FWziwMXYNPPoNlzItYfw739rX0gI6MlroPOxvWx7Dpotvg4cvYL2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PpupnerPO9AEAWAi8cf59I/C24PyDe375e6+shepTrM=;
 b=H2uJe4GPePip905cQg3K/O4dDQx/8ihvpLUKa7VvtaxS+A91zNYOC8ForeF2pRd+xGoryP/M4S/2DJ8EP33PA/UlBO8jaCHzrPs5z69RF6nz+cgrpj3Iz91K5/2eIKzoy83C9nHogglUVWh5ZNgujzOML+224y0f3cbHQbP6+xmssls0K1d+mHHb7L+kw+uHPcR83ylYdDKa/cDNmm5J3zoUx2+TaC7Sq0zqe0RIOE5u2jb63NIuvlEruBzbB9yl1IxzxHVFeqN/DD3jyK3UOqOE8AtbKAyNAaouwTexYpr+Bnqf694P71vuPeddwGjWST5LkiAdn+eoXgqXMP1rnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpupnerPO9AEAWAi8cf59I/C24PyDe375e6+shepTrM=;
 b=P6wyqEMaUMNkKPFg2m529t1QsWDmL8rD5ferkCd3vEu7Z3iNhkkigUjeySfB1aIx8zS7hh4GP+r5OS8n70JclSKVJcUEJv+Pr+FwU8rY1zLdLq2mcXANQCNzwxDDy92phLEDxv5VYtH63k89E1K6g6WgSdaiqY01w1IXTe3Zmrs=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MN0PR12MB6149.namprd12.prod.outlook.com (2603:10b6:208:3c7::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Fri, 31 May
 2024 14:24:24 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%7]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 14:24:23 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 04/18] drm/amdgpu: refine mes firmware loading
Thread-Topic: [PATCH 04/18] drm/amdgpu: refine mes firmware loading
Thread-Index: AQHasycxqYpvn39m0Emxwi+fG6DBHLGxZd1Q
Date: Fri, 31 May 2024 14:24:23 +0000
Message-ID: <BL1PR12MB5144C45758A9BA797F55FCB9F7FC2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240531065249.1746350-1-kevinyang.wang@amd.com>
 <20240531065249.1746350-4-kevinyang.wang@amd.com>
In-Reply-To: <20240531065249.1746350-4-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=49a48d0f-1996-44f6-ae83-edb0735bd49d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-31T14:23:19Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|MN0PR12MB6149:EE_
x-ms-office365-filtering-correlation-id: d80b1c7c-c8be-466e-2e69-08dc817d5ea5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?fnDERYSN80mZEedPvN+rC5DstIzkLDKK1O7dDB+H1YUYdt4vFTv4Xisc87BH?=
 =?us-ascii?Q?+N+gXf0akrzBDTg2xy+PcHObKqkB1LW1vASGHiO2bSQbhib/dq7Ono7f0OCO?=
 =?us-ascii?Q?p/yE4OgDBdMxoUwZQHzaDRGhs9NTJCqutuwNsi0p8P2CmFz2J50o21tSgbYK?=
 =?us-ascii?Q?J5Yk0ojyCLdAZsMnRE7Fw4IyzTjWof2MuP/uRjEBjD/jgrBhj1s+fj4hs52Q?=
 =?us-ascii?Q?JkO+Xah3hb1aNcZLwilQwNK6+Q88pCDSb/9lSBqx+wbNqg99Ex941Y4FROPY?=
 =?us-ascii?Q?1qSXRVSaT5GEQwnAWb1r4VJTZJq0g6vLkm1t8up/0BT7DckUjl+c6N2+NuHD?=
 =?us-ascii?Q?hQWdTKQildZHw0lFLivGuoXGqhQ8h2I9z/xMVjcyu6J852aKnXhqx58jiZNs?=
 =?us-ascii?Q?mV9WKhc8rzNx2HfqjOh6maUF4ZBaYin5+p9uprbKTwRXjkvPi9B3KZ0LZMnD?=
 =?us-ascii?Q?XFKvLQjb2t5YNcnbOK4siLZfugmAa7ZAhzruBmyRSwX0xdovOtWwmM89OecV?=
 =?us-ascii?Q?oK9yUpZYPzaMbZHbUE/JcI6XFKCoQJ61QjR7ZzT47948mt342JnlhP004eQl?=
 =?us-ascii?Q?FiQf2RCY+Qvp4evEMQhsiW8eHxKj1YDTWO4CARHQVj37celN34xmbIXvwINu?=
 =?us-ascii?Q?XJhX8NIJ52cfK0d+LZViyPeT8mmAAZeo+aFFGZc96lOTu3zLQKU6ec40Q1rC?=
 =?us-ascii?Q?mtQaLj5wCUYUgD3pMo2EJL30wKPxbMD+7mg/Uv8/pfZiLxAjIE/kEHX25ILn?=
 =?us-ascii?Q?836QfCzC8YJsG+YmY94FOKpCcyA0eVvbcJMfISjWo3WeuQCreLqSV7XqePnt?=
 =?us-ascii?Q?Bz3GL5UpcQUEzhOHR6arZQ9WnbpqRROLW7mtf6RGjIF5rJb+tZdj+96n+TTP?=
 =?us-ascii?Q?4AigcbuYRpr8KR1VF9BdzF5XWK05HvJ9N7BQAl9Et/VGW0WyWH+KjxQUaeZL?=
 =?us-ascii?Q?EdFFkaIqj/LzG1Nfa9jILZd9DjDSBEUVqnVyPd5w4lmIhPtqffHPjN68cb9O?=
 =?us-ascii?Q?LvNHON8cc+c/pxKn7kqv5xvo6KWWXz6kgchF7lZ0d+/S9cQQvuAvompZJwLr?=
 =?us-ascii?Q?vB/X06sN4i0VbGiKiJ7vqCOKnh1emMOwWTnQZ0HHtIMD5XJiourp9DD4aIYG?=
 =?us-ascii?Q?ZlfO1vlXK1dTdLOYE4Ay0mcuHLF/7+Ktah4HD8xsXCVnXm/FSlH/nljVG+LD?=
 =?us-ascii?Q?sIgAgrCUFupNbOD8RwTVYyUfpWaTN8it5WNj/3mMYnvX7aruwAh2SwbGcEDf?=
 =?us-ascii?Q?bcklck/sKhTH+ZKMwLI5DgJD6xbUBahztiC9CIDQRzOgCbIyqRazW56BWX8P?=
 =?us-ascii?Q?GOuknhzmTLBkVK+By+HPhqp/Km1O4IPgkqAT/zM3IHOTUw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5t1iGX4CJcAdsuQ7eZOeRG+8XbBkfv0/5zdnEYNf5PpzCzbm3o21VT02S9s4?=
 =?us-ascii?Q?Z0bl6jPiKTHhKiKZDgXxteO1QQ6kZvh/n5vqigWziJJ7c32DoUX/9TDpVecs?=
 =?us-ascii?Q?Hs6cf1Mqq80s15RjJREuDrJB16AFcsJQZA87/vT5PFNZnKKPN2kAFFdNOqFg?=
 =?us-ascii?Q?F9UxdLNMGcPU+IeqH2xV71EzqIZoVhPSrAWytb6r/qnv2oDTT89i2Xueypew?=
 =?us-ascii?Q?61ufr1EVdyBNPbWWfjsu7wBKikms6gaZsC+5oNKHxiqqFlcuNmVqmCb4n9yD?=
 =?us-ascii?Q?gabHINKzLDCUh1M8ZwFzlboCQLL0EihIoJj7es2N7Bg8yDPFLuEf+Sm0EHcB?=
 =?us-ascii?Q?U36zEDi3IIznojmAl9OU1MJ+p0u3zZu4sasliGk4x7X8En0xPeGchz5Y2F8p?=
 =?us-ascii?Q?pjM59ar4iUIwPbO1xWjkTk/DD6pxVeiJ8IBVJE8k9OIyPKfCEYdjKcJ0majL?=
 =?us-ascii?Q?+6NZnj8/gh+2g11H8P/aiTlawZOysd8m6ckfY9YCo/8s88Pnl6lZH/EMK8bS?=
 =?us-ascii?Q?+s/+ddfALgyRfBAVdv2m8xLmdpqlNrNmvUGwXQYdJCpizyCHBoLae605aBHx?=
 =?us-ascii?Q?tkuIQOF1Y1uqNnbnId0lV442ph2u6HtuJ4mXvOD+e/KKkWrMuGmyhtFibAjY?=
 =?us-ascii?Q?XGgaZIrvjcolc3j6pjfNbe+xoY5OxPW0XHOHFNosPqh3bey7XDQUYtnTG4fU?=
 =?us-ascii?Q?kxm3LZXfUxKrRcqjtJGoSaI+FNy4EpQYKkZa/cwCcAjuUuZ39uRZ1IHre/Xt?=
 =?us-ascii?Q?ZECCqCe2QFX01SuZ0rFNgmaB4EHbgaMSbc7SK0zVq1ZWOysKLUBmk8CaVg/4?=
 =?us-ascii?Q?AmtWFNt1/uPyk8BlBbGKRFvPQzIGVx7ozqps24KrEL045CErY0H7WP++TCSj?=
 =?us-ascii?Q?Bcg5/G3hvUTJL/n6h1KIxba9eOZ03bOpCFmpfJxhcU2fmnHgL5FmiYp+ysxd?=
 =?us-ascii?Q?qW3Y68T4hxBw19onGHJd+Wo35j4vSjfscV2Zv+SJMJ+O8LeyLARRuMFRI0rJ?=
 =?us-ascii?Q?VtgccJ5aGCv9RmDaiw+S82phy6/0HzRKi/U/WOAQM9ZAt05AR/9feX3YvLyd?=
 =?us-ascii?Q?cIS+DHnRCmvbe8Z4HTaoCaDlBP/AGBcIoycuW1xh0rgJ2uqPpyt8xjFFBBWe?=
 =?us-ascii?Q?OUUAcMjbHSS09/YlYDEQ09KbxFdGAaAXYB7gDoJj9aejIj4WfTD/vVS1f1sU?=
 =?us-ascii?Q?n2eaF36sXB9X43zIrAoAlaLvmiUeilHk5l/Z5MSQUEntydyMg5hsxG2s/908?=
 =?us-ascii?Q?g4DrwnZyHolNC5sP9BBj66goUCQ2CFc7t/LdaZAlbgZsFBaVZB2/xHfMMkUf?=
 =?us-ascii?Q?oiugdNSesWJoA7IhWnuLFN7uhwxboVnu9m7RZbVOx9+yHE8IT15849jpujPI?=
 =?us-ascii?Q?OAkFDtSJOjo/NB6edAP7uaU3QNOsFZrIhBJbI1DMibXXfbeqrVFWFK/uQw8b?=
 =?us-ascii?Q?TD06Sdwj11vAk4TdbK8+FJY6ztDH9WFdCey3CpNbENGpXB+HuSxLmg+RQ4Eg?=
 =?us-ascii?Q?vP0OOQ7pNVBdldpwiD7su3FNleuCxwM8hq22+AxT+YSBQABTLzYztj/CWhkg?=
 =?us-ascii?Q?4sME5vbND1fBSYdLius=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d80b1c7c-c8be-466e-2e69-08dc817d5ea5
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2024 14:24:23.7917 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DaGkLDEHbePIcxzHK3pOJ+FJlTcKlsYULOgg6HUtgjce2QbMZJgoeNJP+t/4KWaMep9Z4Gatv5ZOFBeH63vR4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6149
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
> From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Sent: Friday, May 31, 2024 2:53 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>
> Subject: [PATCH 04/18] drm/amdgpu: refine mes firmware loading
>
> refine mes firmware loading
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 62edf6328566..9194a53b7c14 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -1528,11 +1528,9 @@ int amdgpu_mes_init_microcode(struct
> amdgpu_device *adev, int pipe)
>
>       r =3D amdgpu_ucode_request(adev, &adev->mes.fw[pipe], fw_name);
>       if (r && need_retry && pipe =3D=3D AMDGPU_MES_SCHED_PIPE) {
> -             snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes.bin",
> -                      ucode_prefix);
> -             DRM_INFO("try to fall back to %s\n", fw_name);
> +             DRM_INFO("try to fall back to %s_mes.bin\n", ucode_prefix);

While you are here, can you convert the DRM_INFO() macros to dev_info() ins=
tead so we can get better output on multi-GPU systems?

Alex

>               r =3D amdgpu_ucode_request(adev, &adev->mes.fw[pipe],
> -                                      fw_name);
> +                                      "amdgpu/%s_mes.bin",
> ucode_prefix);
>       }
>
>       if (r)
> --
> 2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FEBCD18144
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Oct 2024 20:29:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D1C410E4C2;
	Mon, 14 Oct 2024 20:29:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iQ870YGz";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 185C410E4C2
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Oct 2024 20:29:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R0sy397nNqGSdoba64lZ7QO1bkRuE1bjs0cJLzt+mBti/ukzZ5W4oTZR1Ghm6ZAQFCzOy+PjLayV1qCFglLXMGxhpPmFByNzaZ1Mx1+D53ycAw2tGhx+VwKyvjdWgE06exNWXTD/ewq2gWYqzEvG5M7yvRAWCplQEHFMV+pB+oT6TLmQp2DVJGfVsdtHLoT5pRc1hRzlhBfQP9Lit1KvB1Gdb7l+2TO7kyhX+8yKknffFHwb++HzU9PQeVSfW/7kHYJ+UrdcE+dLWI+hCG8IZMcPfd7n3m+Lz2ZFvFcOCfmFztL2Q1oyToM0OI+cKphqnCpq2SupXbyGPJfxgSlBbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZjBFtyooSTgVhaC7KOtsgi1NQOxBm+2K3E5u8Ja06c=;
 b=zSGCEah8YzLemWI2cUXs8XLrQo2Jk5zm7h220unAQlIRlwvAQ13JIrtfb3imt8V7rwwh6BtR7FnSHCQ7c3rhMz/5K09aTpsCB1xUP1R3EHF8XSv/gk1PVo535aoLEwljBlWQbCZ44ChH2EuaVYvjA78R1/YKHv5+W/Uh3vL7BhdlRnNjAEIDCp+L9Ax551/NEYSnNskStrzaEAFgtfy2pY7XCRwM34xJVmsk6WL3Mlm3aIiNUPaxsQq3OKtALeUOQjPmZdJhplyqppDMRBlC8LAaWaxoIRNAZbsvZ7X7vHEj9cJtUzXhVPXEbsDuwLEZHHD/WkNw4/LJtv2QRQ5MKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZjBFtyooSTgVhaC7KOtsgi1NQOxBm+2K3E5u8Ja06c=;
 b=iQ870YGzKb0AZE1iSo0EYCxO8NymLqlW1rdWM9fH2BTOdTmIgzjsQjmdL9Qz+VDzzGovGpY6WGvXyoybINWPBaq3uvOVC7f9/ZK+mQDO3V58P9XEaIpscuTkkP+v6X/7bQiTx8Ktv+YvsjNqBdMUisLxJofvSTq3fUGq6D6IN+I=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by LV3PR12MB9095.namprd12.prod.outlook.com (2603:10b6:408:1a6::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 20:29:31 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%4]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 20:29:31 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Sharma, Shashank" <Shashank.Sharma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Somalapuram, Amaranath" <Amaranath.Somalapuram@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Yadav, Arvind" <Arvind.Yadav@amd.com>
Subject: RE: [PATCH] drm/amdgpu: enable userqueue support for GFX12
Thread-Topic: [PATCH] drm/amdgpu: enable userqueue support for GFX12
Thread-Index: AQHbGz9vAne8D/06ckWmFXtn2qrytLKGtTJg
Date: Mon, 14 Oct 2024 20:29:30 +0000
Message-ID: <BL1PR12MB5144EC6671DD09A36B0BFD0CF7442@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20241010180806.834-1-shashank.sharma@amd.com>
In-Reply-To: <20241010180806.834-1-shashank.sharma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=a7fec952-7dfb-4515-9187-af6d6bb3222d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-14T20:15:43Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|LV3PR12MB9095:EE_
x-ms-office365-filtering-correlation-id: c13699da-9b97-439d-4a9e-08dcec8ee880
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?3vwo37ArxwZ3AGNMf5/iTa1aiNKApTVHV4bPVPymSL2CBaQx6+zTlftejGGQ?=
 =?us-ascii?Q?0ekQpKviRO+gqcyUZy9jtluXq0PfWwrh7wt7DeUFMIX4MuAq4rf+GiYkQlfm?=
 =?us-ascii?Q?yYmeeUB1g9wN0kUaHf4iTcR2rN04v6zWHl4p+vScLFxA3H7A/wiJqLKNncU2?=
 =?us-ascii?Q?iG2AXVMWVfKlK2gyd7vqv7mBpiOr1++nTOGjFhxmQbsV+vFgeFEmjgSWD49Z?=
 =?us-ascii?Q?R5Bms8m3vQVolsoGOxcZYWMpW2tHVd9CAeaXjTaSO7ElpDqfXoFvQNoEEcLR?=
 =?us-ascii?Q?ZVU+JD1VimjRHt9iritonWIkAon0GbXKk2LuFK9NFAd1xbafQtMFmpeo1Srt?=
 =?us-ascii?Q?g4eioUpTUuyydQ1ifK9VpCnsZKBFAKWAwTkS23jYL9dZLVGILht7YdIu2WD9?=
 =?us-ascii?Q?uJ18kiWotPVf+BJ2kEDmJGI4ni4EaF4azXr2tCGu6O8/iMqFt2SeTl/CxKp5?=
 =?us-ascii?Q?AX9jz6kJwOYxDY8BBLJ/8Zzq2gxuV3DWeRSd5OXhU+WItIBqbbMrhkbIdh4A?=
 =?us-ascii?Q?9OWwBif+To9gOIWYagBjD/9T1O88ySdSM6+/m5GAIuXEfKAKobI1ZLiFbcIF?=
 =?us-ascii?Q?wgrGxH8sEFyUBEb1YW0PKbadHU06Qq5q+VH/CZkQUJrWNuAtxIUWBTINxM0f?=
 =?us-ascii?Q?0fCQ+/Fxqt6sqHKgRaiarfDBmtzEhRRF3JCz6gIUpaV8E8q6+3xvZx24DDHd?=
 =?us-ascii?Q?CnCVySJx30c4GAtyDE+XWfcvcf0VNjRjBMKz3KvB72Wiqy+cSqInAl8S/YcZ?=
 =?us-ascii?Q?iUXd+vJyeoNEDpcy4VwzFCeukldLYbDzsHsebp4ioeJD877LMYSCBB6LRr/D?=
 =?us-ascii?Q?afadfuh6q8pGvCvoC54OBTtsUPn20b+aLCwZlDKNRtm9IClkDQfGRiFWCRMi?=
 =?us-ascii?Q?I0HzoWXJVQ1tO106oKsiPFCOOwyV0Ep+SmphamvXTO4uTagwnAzKKprpBDaq?=
 =?us-ascii?Q?3nQTfEUUl8jMgC9cJjuTPrdeCFYPLxvlBunAwlpbXjwRdArlbvfui6V4B8kn?=
 =?us-ascii?Q?FmrhLLDJHspKXXlRBHHMpkIQ6g0e3QV88rLHXiwQegqMif090AmlG7NAj+uj?=
 =?us-ascii?Q?h4n7uHzi/hrZD78s9lR1Te6JhjgD3WGXr/FKSwClvGJfw9A1YrYbsF3Crf/u?=
 =?us-ascii?Q?ITbZXN3GtDqMWlgcZJzgJT16qZKSrz4fCt73KlhWuEzCL/reTeosdYjoyxMe?=
 =?us-ascii?Q?xwAQkBwzaSLfMGOHaSJ21mSABlr3ww8LBV5j8gHwKUv1UKdingv9jOYqcmvC?=
 =?us-ascii?Q?6w5ILnzvovNOWG2eWPPUIYQ4mxpK+TkqvU0jrMRdEs7oIc/pmQC7Hh/bLzLZ?=
 =?us-ascii?Q?wl1Egm1EJuIhHfOvCe3H2UCSexNUnm3Dr3FqJS7yQZ5OOw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cZMOBByOx5k1Hh4LtLLKDA4tMEEpCdjMH8arR1Ptneg7a7KoHoou/rQnSP5Z?=
 =?us-ascii?Q?BSB2Y8KZJ6EIjTFsE2HNdBCjHMPwyK3HcjQOzsSUQ9ce97+t9+og36YCh92e?=
 =?us-ascii?Q?qsoQwvcymdSjIuyh6fhpyoGJmVC92rEDl2wCiKonGsDp7lnMkY1FyHcDNZGk?=
 =?us-ascii?Q?R9Ee9HjWl8BS4542ouFURllZ6L89ps0GyicTysh1EO/GZo4yKEn8dISSwI5j?=
 =?us-ascii?Q?b396mjSpOF4wUc2GOCrRN1iC0eb2dn9XyshSxOLfFtqagWxiWSYUsaHiyTqx?=
 =?us-ascii?Q?/Ljf/yxqGMrNtHZ+ldPrM6qgvr8TfObpS/1k0emktyviFByiRCONk/rr8dKw?=
 =?us-ascii?Q?Vh8sy5r+nKpcoadGFhLb+b76colKcYsVFwwD4hOGg422wKqRcZAJRy3yKj+4?=
 =?us-ascii?Q?63N7u3OePzYApS5sT2rA27onMcug/NaBVI9PVxQYetV0zHaR3POBIz8OkaM0?=
 =?us-ascii?Q?GLzhbstUAB6y4Y7okHdNAIikcb8iPd6PQNdK+FZGQQrNLtQstTrKu0II4YPt?=
 =?us-ascii?Q?FO6921PmKSZpBA4USttYQMoCFdGigl0euCQ8pEcV/v1CdrWkAE+CI7SbouuX?=
 =?us-ascii?Q?YEKHGkLOpo0pNnvtmVm2bzqwlXHJ+EhHn6dTXE0Ur6uMfKjxiLfCniXRu7Zd?=
 =?us-ascii?Q?6canmBrmGSpvYKtFUa3PTxng9Ig82r7HjIq57tOe441CLZrPXHhDGPyJyoE+?=
 =?us-ascii?Q?Q+2YVhX5eueSA3C1VAbter/PhsVkriJhva9KdhFwNP5/Af5+hDx2y778dV71?=
 =?us-ascii?Q?Ve6c16u2XC3ORm6CyxdHjKsCJADRr97JL3xxQBIIdkVouXJTKiIcg6E7+BPS?=
 =?us-ascii?Q?z8At1gkDyq+tv7RlJV4fZSjSQw9pCMEkkd7IQnw/JrImsZQZQJMUba9i3Eee?=
 =?us-ascii?Q?e3NaZ0ImiMOsIMCpWO2Q2Xe06RCoc+L7bLjdw1ArQK+A8kRM2zAjwfpaNQ5C?=
 =?us-ascii?Q?iNCKWjYSpXlsBwhzmRMEYFXM/tARbfqQHx+cCZ/uSnmKsbZRZztauhzGhqAT?=
 =?us-ascii?Q?0JsKrtAl2hutDwC8F4jN0u2k++QxzV5rsPlRdst8QvQ5+zm2TEfxXWvzPJa2?=
 =?us-ascii?Q?x86Gbr+EpQaXWRtr/W+Ogjyd1DtfHDT9mslzaRbe3X16/dO3Gl3MCdEXNthN?=
 =?us-ascii?Q?+mFlGNHPO1Yx9rjY+WPw9TD1qtyKwH+Oy6RbLxtr+Fhwu7fG6BzxSI9jyUIz?=
 =?us-ascii?Q?4JXdBkKqm2wsMHQpS9iPxZgoeAYkzQPXky7HFh2uqIykh3mU6MuzsySCwLcY?=
 =?us-ascii?Q?VR9wteiBbrmFufFI2FOGhRv63xOJAqYTl4eIX0Gvbf+8FTqwhpIGEIiQHEWj?=
 =?us-ascii?Q?igK9nDUdQ06mjpSzzNhBQYBANK3GPtGcmzLQmqyLsNh3jrKkXjZe0iW8FEDn?=
 =?us-ascii?Q?duURD1ZkI9MwPiBUdexRx7U4i0JrahGz0G55IwDY0McsIaMSWbsv7YTOi7nv?=
 =?us-ascii?Q?U1Vfw02EUkxa4EUoi/+NY+4QcgTI3yI0VeHHVfDakz0KswLWOxyFtxlVThqa?=
 =?us-ascii?Q?XU8pWoSKUhE1oLpEBIzGgMKAg42TQxNObTd1J/a1ML/dOfKRAiJToXMjOL6I?=
 =?us-ascii?Q?09BJwK5FrUAhjYi91CQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c13699da-9b97-439d-4a9e-08dcec8ee880
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 20:29:30.9790 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8E+x2z7SGmRbIzQ2VbYZbaj/xLTudo6UQdQma/l6smBgR+LMT8yKaVkQyk3xTI07pijNzDkKWga10R33+ZNxsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9095
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
> From: Sharma, Shashank <Shashank.Sharma@amd.com>
> Sent: Thursday, October 10, 2024 2:08 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Somalapuram, Amaranath <Amaranath.Somalapuram@amd.com>; Deucher,
> Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Yadav, Arvind <Arvind.Yadav@amd.com>; Sharma,
> Shashank <Shashank.Sharma@amd.com>
> Subject: [PATCH] drm/amdgpu: enable userqueue support for GFX12
>
> From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>
> This patch enables Usermode queue support across GFX, Compute and SDMA IP=
s
> on GFX12/SDMA7. It typically reuses Navi3X userqueue IP functions to crea=
te and
> destroy MQDs.

I would like to make this more explicit.  In mes_v11_0_userqueue.c, I would=
 suggest splitting out any non-gfx11 specific code into some new helpers in=
 mes_userqueue.c.  E.g.,

mes_v11_0_map_gtt_bo_to_gart() -> mes_userq_map_gtt_bo_to_gart()
mes_v11_0_create_wptr_mapping() -> mes_userq_create_wptr_mapping()
mes_v11_0_userq_map() -> mes_userq_map()
mes_v11_0_userq_unmap() -> mes_userq_unmap()
mes_v11_0_userq_mqd_destroy() -> mes_userq_mqd_destroy()

However, mes_v11_userq_create_ctx_space() uses the v11 mqd structures which=
 may not match the v12 structures.  We should add a v12 implementation for =
any functions that use the v12 structures.

Alex

>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Arvind Yadav <arvind.yadav@amd.com>
> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 5 +++++
> drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 6 ++++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 9fec28d8a5fc..d511996c374d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -46,6 +46,7 @@
>  #include "gfx_v12_0.h"
>  #include "nbif_v6_3_1.h"
>  #include "mes_v12_0.h"
> +#include "mes_v11_0_userqueue.h"
>
>  #define GFX12_NUM_GFX_RINGS  1
>  #define GFX12_MEC_HPD_SIZE   2048
> @@ -1335,6 +1336,10 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_bloc=
k
> *ip_block)
>               adev->gfx.mec.num_mec =3D 2;
>               adev->gfx.mec.num_pipe_per_mec =3D 2;
>               adev->gfx.mec.num_queue_per_pipe =3D 4;
> +#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
> +             adev->userq_funcs[AMDGPU_HW_IP_GFX] =3D
> &userq_mes_v11_0_funcs;
> +             adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] =3D
> &userq_mes_v11_0_funcs;
> +#endif
>               break;
>       default:
>               adev->gfx.me.num_me =3D 1;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> index 24f24974ac1d..badcf38bb8b6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -42,6 +42,7 @@
>  #include "sdma_common.h"
>  #include "sdma_v7_0.h"
>  #include "v12_structs.h"
> +#include "mes_v11_0_userqueue.h"
>
>  MODULE_FIRMWARE("amdgpu/sdma_7_0_0.bin");
>  MODULE_FIRMWARE("amdgpu/sdma_7_0_1.bin");
> @@ -1317,6 +1318,11 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_bloc=
k
> *ip_block)
>       else
>               DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
>
> +#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
> +     adev->userq_funcs[AMDGPU_HW_IP_DMA] =3D &userq_mes_v11_0_funcs;
> #endif
> +
> +
>       return r;
>  }
>
> --
> 2.46.2


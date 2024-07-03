Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99AC8C2BD09
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jul 2024 08:45:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CC0210E010;
	Wed,  3 Jul 2024 08:45:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dcZSrfow";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A8D610E010
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jul 2024 08:45:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ietpq0OPbYB14tGiLirEkq3a5e9RqC+p36rB9xaepjyfwKpU8rVLCajTGsSQ4P61tpJOUHCl6+0sFoCnvHYNB8NOPYVitaYlx2d02AAHedPPDLpgMEzK8b9g+HJ63pRqSCFw2dhoxZ/68eeiTexZ+JgcpzWR/MlHw4mwZu11BkI8AaYfBDpOgyrtFDXYkrWfD5EYhOoetiMj03TeklnIO8AzFWNG1zgiOeNpAiFWoOS09+MpSoaAfTxVBnCxsYM3Hnw0d1FcQrtq1Hn3GmMMXXd/lIznAgcxV36wxbu7A0jl0xHsdzht/H+FQRqtGR2G9lP9LUfa04wTsUT5e9knMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oL/pQhlc5SyVLBZQ9eZ1SI1FtJiBJxFFS/+Jpq7Kmlg=;
 b=f+gduOcE9JGOaG2tynuJOAfDlEjJWT+x192Rw67dY8NO7fyiqqUPOwtNgDTlghU0h2AdlweRxEgJrz1P1Uzdtae3AXMfSU3lsN7ULLWpeDHW5hP5oLiwo9VIOL6du284NU2AjlwOygETLD9+/P9zohYhOfSH6QAM3QmcPldMdfHZwqoOuCfoTHlFU4hRFSlEJHJDgYk/Caj3kFJfH426hTjtZ7BzBC9c9PJghHRbxb/+0aPGBour+kD56rQnptA7FhxLmE0XCePdyT9fh0NjTzM2JT4weE6dWw295eXmUhQpQ/qMB8T67Tx/0O58dBzQiEXsv4JM0kuCekEzALvjLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oL/pQhlc5SyVLBZQ9eZ1SI1FtJiBJxFFS/+Jpq7Kmlg=;
 b=dcZSrfow0SLd47i5twQEiVOazONlK/FXiBRnL4a1y4Xd5eXHROH0kf4ZJP+URlinvIuWd7L/mPNEyY7IVZMbBuc/tFRYNpZCZIj26AV8/TPn5hVda+NSkVs08qERr0YyezJc8Wsrvpub7ITwwetmgr4orFhGcJGUimpHnDkonF4=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by CH3PR12MB9172.namprd12.prod.outlook.com (2603:10b6:610:198::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Wed, 3 Jul
 2024 08:45:21 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%6]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 08:45:21 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 3/4] drm/amdgpu: add ras POSION_CONSUMPTION event id
 support
Thread-Topic: [PATCH 3/4] drm/amdgpu: add ras POSION_CONSUMPTION event id
 support
Thread-Index: AQHazQ0ttb4eCTrFVUmlgM/FCCJ8ErHkq9EAgAAD3CA=
Date: Wed, 3 Jul 2024 08:45:21 +0000
Message-ID: <PH7PR12MB599735C2882E9929F8491E3C82DD2@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240703055200.1610956-1-kevinyang.wang@amd.com>
 <20240703055200.1610956-3-kevinyang.wang@amd.com>
 <PH7PR12MB8796042B81B22FEBF0E9634EB0DD2@PH7PR12MB8796.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB8796042B81B22FEBF0E9634EB0DD2@PH7PR12MB8796.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=418ea63f-08fd-49bc-a4df-6152ebcea2a8;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-03T08:23:30Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|CH3PR12MB9172:EE_
x-ms-office365-filtering-correlation-id: 92074289-4fee-4f29-e2da-08dc9b3c7953
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?VPO4wj4fHDLhzUFwjOcS7b9G3b+4Cdd+hzkI3zqnuiE9dMibNA6c8P2s1DXN?=
 =?us-ascii?Q?qq0LEAjZU2QTw31/umJoUWYsQc+Az0eVDgLUwLi+7qIC+s5n0pPs9vgBML4z?=
 =?us-ascii?Q?RAfJhR9xHczOcVkonhFHBo4nqR/Hr70dM5RiiJRvb2kmViWfts9az4lExLDN?=
 =?us-ascii?Q?K+a5ZEjXBA6MX/aUCjLrOaRZk1p4aki5FGyg1t0etmbkgxG6YRPf2ixk9gex?=
 =?us-ascii?Q?AXbo6Q8wRKUqvlyYufmn2z0ACvVSN2IyKPrJ6rVUE/kvXzT3aWtZL7D5aKsZ?=
 =?us-ascii?Q?dqID7/lz6OrC+bFeQiz1MtIQ1uGJMEgUq+ZjPHJHWE1Vp6BzLCcVtzqxnwt0?=
 =?us-ascii?Q?tXMhZmgfnWzPH7vphxlBCQB8+pcaiOLDm+IXvJLE9H2/+3Sr+aTuEazwCE1y?=
 =?us-ascii?Q?gigX2nSUwEFCUOFSeJT+sr5jYNiq6nuhsYo/94iiimM4c0kBKAdMWZSDSEOd?=
 =?us-ascii?Q?0nhrGh+3y63paWZJa02H2q46KNfgfo0Wz2ADPkp3vs0Sw3ItHyMeXodAwGQ0?=
 =?us-ascii?Q?svIRSCSOraskdoLwMb23KrK1PDpVutSsS+diRkfd0ldSBuy8M4/rlAsiwvGK?=
 =?us-ascii?Q?/OnmSi3onKPIjsCE3XbadS5lrih2cjP/55qtIzAwbpojReOkW0ANVlRLdRYd?=
 =?us-ascii?Q?I3/rc3GN/rFg3GLox4LoaCe7NOQBHPrU0t+w5lmzwKvXtUtqF7Zom4ymO7pb?=
 =?us-ascii?Q?iMzZxoXE0myhGH5AFGAb6hXgHhMV0W/mKlMQdDil9ffZlBa0nqhQv3P0ndmQ?=
 =?us-ascii?Q?Gaje/bcUC9FQo2rvgpmn52sWWFL+km4O89JJ2AmoCbYODrtnN1rvKEGIjxPD?=
 =?us-ascii?Q?GBvRnACnCPSMk3l/hlmmAxDetWBu0KGAHu2qUmeUTwvtQkXP04X/ugWsJfx2?=
 =?us-ascii?Q?E8+ZgQ953A7BbFDCb+l+dcS1cBpjGwtmAe/OhFL3iXaovf8Wul+oicJR7/jY?=
 =?us-ascii?Q?HWWR27lSZ+UFKbpLz53NP1PgCwPkQRYKc1MTiFxLIqbmb0Fu41+eNF7zoefF?=
 =?us-ascii?Q?aV6LWRuSUZvgEI7Nb6Qi6gLkS+AYW3nDR5Nd49NYgjAngbePtUUWhmLzcDA2?=
 =?us-ascii?Q?3l+RE1vYI9Ep3CzJZtU/fV5ItX7tqpoF7vIMdrmYREQoYz+3nrkIrNOQqBL+?=
 =?us-ascii?Q?sFQ+DL9CQl07Op7iBdkaC5o+6Gx6+XCsDeo3/rqn2u0W/4w+oxDBuXoilsu+?=
 =?us-ascii?Q?x9U514WL/6T4TqfrozQmUqYhi4X8ewdJWoG1C9vPPfJFTeIvU9ujRy1eGzpl?=
 =?us-ascii?Q?Hh815pFeW0737ncrNpvaDvJoObx+HcVhx5lYLQUy0VonMkIggWi2keiQ2QXC?=
 =?us-ascii?Q?nw78s7Ozp1+Yv/ZmNtj7QA4pqUNn+yB4f36gVaMI0BfczMDXykVLjbfWHBRi?=
 =?us-ascii?Q?brZk3ofIzd3mXLgOY/KVG3APw2HM/yP2dVhpkXBePQgUtL5Drg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?51is5RamSEYXRan62UUoYYU7aVp5bndN7ihK0hmHmQeolQEKcrmf5Ob0bgdr?=
 =?us-ascii?Q?qJ3Ax/5AhsCnhooYMtufxtBWexFpbofxxFGBG9YhYRHbSHlYX0OyVGc3d+/q?=
 =?us-ascii?Q?Ihwy12wFmerOwqJc6lQxjPWKlNLibQ9tO04iLmLDqGIVoliVZsahatF6zV0D?=
 =?us-ascii?Q?dnkvxRhM+KcXeHxAcpuvKzp71q1VqkaCdpVTmmwT4YfqESxo40aBk2yfZ7Kw?=
 =?us-ascii?Q?8TbMRAB2EDQOwAUBFFZuoVEjkYFk1jMZlg4bhj9AQLS65fJ4B9No/ZY0/Hll?=
 =?us-ascii?Q?tZNKwNvQCoUmaOyoxd9jdYH18QDwlYKBByxY3Zbx6vC99ICFN9ivyZ3OrbOl?=
 =?us-ascii?Q?Ha23XK+sMvGKN/vaivstcln8ofaBxvIPluCYipsMxrNtomQ2y/u/Zw/dd9Ez?=
 =?us-ascii?Q?sKE8wrexDJ0Qfzi7UigFeLtpKHOkBNrDPCAJpRFM4YrMy/aliw5B0zRTT+Hz?=
 =?us-ascii?Q?5fhYJNoDxVZzv6DP7Q1FiGauLbDtgWEYZFpTSEuJhuph1LyCCd8aEfIyEz88?=
 =?us-ascii?Q?C3AQMwCSFwSJxvP6UrbuDOSfdFLEQci4VlJ5l6sV3UiKbiCHm73GDxE16kda?=
 =?us-ascii?Q?Rv4d6dUrFk9B0pUC/1KxD4Q3ZTzjZENqapD6KyGTgFznjCDp6jozw35QcWPo?=
 =?us-ascii?Q?PD09SdNhKlStWwXPK1hQad2p9aZcWMs/n9xChiY8zL8a0Vg43cL5ywmCiK0E?=
 =?us-ascii?Q?kc9i8iq9w9tkMPBTG7FbeM5hI6ny8ITah+4OpCAFJ4imzrGcIGy77C8K6fVZ?=
 =?us-ascii?Q?HI8V1i+h23dGfnNIGWe5Q8s4PMGL0eq9DUTTPBXk6PNXooZJ7g5zcpj1d7sO?=
 =?us-ascii?Q?6xwZmZoKcjKs7dkevj9pshFgUcNgUdrzt0Y1Z+IdLElEq8RM0EsI/Imc6N+f?=
 =?us-ascii?Q?D3BA5pzJKqxWqe6ZEvZ08pyhggCFGX8NpzPnNi/HSYUViguBK7iz88rDlW1F?=
 =?us-ascii?Q?5RpuEpW6dvQlMxnt5YnRYNq4zw4MPjnxP5jehhOsIRac4541g8ulVT/jVGda?=
 =?us-ascii?Q?BvbC5KIU4u5RDFN3u220wOFaRHC6WBYApVyjwLwa6PVPeBuFuKKRgFiUnQba?=
 =?us-ascii?Q?TcJWTUPPs/lviD26Qm+ME4yid9OJWfkceHxsb82E9CdMx7iPbljBvq6Ts1ZQ?=
 =?us-ascii?Q?4oS/HlJvJbf929VDOawzdcRj15sfUvfBsVhSCRUR/IfH3VRRLvGg/B0SCjwz?=
 =?us-ascii?Q?NpFkQEq3qfXISOCbcBilx7Ca52hK4AiyFEOsg+mzP3E2M3mR0Lxsi2FMCsY0?=
 =?us-ascii?Q?9Lghgz4PTWiLBbn0CmwNAV5L6yww5p37L7CDL3c2xZoimCfJUMwAszuBfra7?=
 =?us-ascii?Q?vP6YXqBvpwCJO7vr0np+KwKSX0AAhmiA4o3O+dKg7ZB+rNt83rrk34VMlEHi?=
 =?us-ascii?Q?9X/uIFRspY7nz7VO2oOyHdCCJqziZ7CcOnMeFyXa7OkMZ+6ciu/la049k3hs?=
 =?us-ascii?Q?bCWYQPTwU/l79IVOXDR8IeU1v1BNAd/iLN46Zwg/4fEjnnLOIwpZDv9YzxyK?=
 =?us-ascii?Q?puYBhb0wpBikTcSnzOY6KpwystThuTYc9/ihAWF+oTfGbRWg2YZNB0OLGbfc?=
 =?us-ascii?Q?HCQ3DGUoD6w2GWTqbY4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92074289-4fee-4f29-e2da-08dc9b3c7953
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 08:45:21.5545 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oG9Py7tXeunolx+OxyvLeyKlPNUcCBKZTlWGONP+fQGnEftDvhP4rZgVSFZb9FD+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9172
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

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Wednesday, July 3, 2024 4:28 PM
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 3/4] drm/amdgpu: add ras POSION_CONSUMPTION event id su=
pport

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Sent: Wednesday, July 3, 2024 1:52 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>
> Subject: [PATCH 3/4] drm/amdgpu: add ras POSION_CONSUMPTION event id
> support
>
> add amdgpu ras POSION_CONSUMPTION event id support.
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c         | 16 +++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h         |  1 +
>  drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 15 ++++++++++++---
>  3 files changed, 26 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 8a98611d2353..11f8c37a97ef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2076,10 +2076,17 @@ static void
> amdgpu_ras_interrupt_poison_consumption_handler(struct ras_manager *
>       struct amdgpu_ras_block_object *block_obj =3D
>               amdgpu_ras_get_ras_block(adev, obj->head.block, 0);
>       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
> +     enum ras_event_type type =3D
> RAS_EVENT_TYPE_POISON_CONSUMPTION;
> +     u64 event_id;
> +     int ret;
>
>       if (!block_obj || !con)
>               return;
>
> +     ret =3D amdgpu_ras_mark_ras_event(adev, type);
> +     if (ret)

[Tao] add warning? Or you can add it in amdgpu_ras_mark_ras_event.
[Kevin]:

Thanks suggestion, I will update v2 and add a warn log in function internal=
.

Best Regards,
Kevin

> +             return;
> +
>       /* both query_poison_status and handle_poison_consumption are
> optional,
>        * but at least one of them should be implemented if we need poison
>        * consumption handler
> @@ -2104,8 +2111,10 @@ static void
> amdgpu_ras_interrupt_poison_consumption_handler(struct ras_manager *
>        * For RMA case, amdgpu_umc_poison_handler will handle gpu reset.
>        */
>       if (poison_stat && !con->is_rma) {
> -             dev_info(adev->dev, "GPU reset for %s RAS poison consumptio=
n
> is issued!\n",
> -                             block_obj->ras_comm.name);
> +             event_id =3D amdgpu_ras_acquire_event_id(adev, type);
> +             RAS_EVENT_LOG(adev, event_id,
> +                           "GPU reset for %s RAS poison consumption
> + is
> issued!\n",
> +                           block_obj->ras_comm.name);
>               amdgpu_ras_reset_gpu(adev);
>       }
>
> @@ -2498,7 +2507,7 @@ static enum ras_event_type
> amdgpu_ras_get_recovery_event(struct amdgpu_device *a
>       if (amdgpu_ras_intr_triggered())
>               return RAS_EVENT_TYPE_ISR;
>       else
> -             return RAS_EVENT_TYPE_INVALID;
> +             return RAS_EVENT_TYPE_POISON_CONSUMPTION;
>  }
>
>  static void amdgpu_ras_do_recovery(struct work_struct *work) @@
> -3975,6
> +3984,7 @@ u64 amdgpu_ras_acquire_event_id(struct amdgpu_device *adev,
> enum ras_event_type
>       switch (type) {
>       case RAS_EVENT_TYPE_ISR:
>       case RAS_EVENT_TYPE_POISON_CREATION:
> +     case RAS_EVENT_TYPE_POISON_CONSUMPTION:
>               event_mgr =3D __get_ras_event_mgr(adev);
>               if (!event_mgr)
>                       return RAS_EVENT_INVALID_ID; diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 1343cfbc913b..6086da67fa4e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -433,6 +433,7 @@ enum ras_event_type {
>       RAS_EVENT_TYPE_INVALID =3D 0,
>       RAS_EVENT_TYPE_ISR,
>       RAS_EVENT_TYPE_POISON_CREATION,
> +     RAS_EVENT_TYPE_POISON_CONSUMPTION,
>       RAS_EVENT_TYPE_COUNT,
>  };
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index 816800555f7f..8a10a0e42846 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -27,6 +27,7 @@
>  #include "soc15_int.h"
>  #include "kfd_device_queue_manager.h"
>  #include "kfd_smi_events.h"
> +#include "amdgpu_ras.h"
>
>  /*
>   * GFX9 SQ Interrupts
> @@ -144,9 +145,11 @@ static void
> event_interrupt_poison_consumption_v9(struct kfd_node *dev,
>                               uint16_t pasid, uint16_t client_id)  {
>       enum amdgpu_ras_block block =3D 0;
> -     int old_poison;
>       uint32_t reset =3D 0;
>       struct kfd_process *p =3D kfd_lookup_process_by_pasid(pasid);
> +     enum ras_event_type type =3D
> RAS_EVENT_TYPE_POISON_CONSUMPTION;
> +     u64 event_id;
> +     int old_poison, ret;
>
>       if (!p)
>               return;
> @@ -191,10 +194,16 @@ static void
> event_interrupt_poison_consumption_v9(struct kfd_node *dev,
>               return;
>       }
>
> +     ret =3D amdgpu_ras_mark_ras_event(dev->adev, type);

[Tao] I don't think it's necessary to mark it both in amdgpu_ras_interrupt_=
poison_consumption_handler and here.
Another question is, event_interrupt_poison_consumption_v9 is used by sever=
al ASICs, are you sure the event id code doesn't affect old ASICs?

[Kevin]:
The event id is only used for format the RAS event log, and it won't affect=
 the code logic for old Asics.

Best Regards,
Kevin
> +     if (ret)
> +             return;
> +
>       kfd_signal_poison_consumed_event(dev, pasid);
>
> -     dev_warn(dev->adev->dev,
> -              "poison is consumed by client %d, kick off gpu reset flow\=
n",
> client_id);
> +     event_id =3D amdgpu_ras_acquire_event_id(dev->adev, type);
> +
> +     RAS_EVENT_LOG(dev->adev, event_id,
> +                   "poison is consumed by client %d, kick off gpu
> +reset flow\n", client_id);
>
>       amdgpu_amdkfd_ras_pasid_poison_consumption_handler(dev->adev,
>               block, pasid, NULL, NULL, reset);
> --
> 2.34.1



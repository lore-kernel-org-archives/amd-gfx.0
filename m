Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 513B9CD1299
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Apr 2024 02:51:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 730D5112A5A;
	Tue,  9 Apr 2024 02:51:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mx2dXP3Q";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2094.outbound.protection.outlook.com [40.107.220.94])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5151D112A59
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Apr 2024 02:51:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1HM5O4/itg2mn/3umc7ZlF/aXKdJ+AF8TJlvmzSuDAABFzr0IweglSs/Szzm7PfL3TL/xXcKn3sPJauNIQnIL+SgRyK1ZD7TC6g243H7fk7RYUf75jOumzW/u1GUumQo+KEkq0+z3gvnfBEbHnu91r24/cFAfAvGjCTCS8C+Iygxf+36SHlayll1LHGDCFohHSMhmUMraxZidsBp9B9j+lll52OCe7yZTQbhGX6VVDSVxpJ8J+QC1B4+W+4vXhQXeLkKbb5OqIJdcJc7lF1ghg/EpvaUQijYusrVjKdqReTubVPn/XaCYYuA9dMwhINJnT004USon3lr8AFnPFXjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdHNpqUerY1M+TqEb6wQtzhgcQYyQZh3D0dBrTo8PSk=;
 b=IXtKKbqUoq768kv+NHGNa4R0Yoknko6PC88Nu5q3/a+taXjIro1Ccgyty4AmKBn7fT2nNrsfW0K/nGAerchMJUrfzo/AlRxlduobsAICHUtS2uc45N0gXpRejYeeKfu8o3pa0Htva9ouLHRQLMZeIKOlbdUghfowgtm43FP+iHSkX3F6FTdOR0Rv3QIBPkf04dTa6qAXiLOP+ht/itc7lftplNG9P+VXjHWTUPyjIt77h2VGP9MqPdSXnqH+yRTg0dO/ti6Mzx8SnqP0fvkJIbkk02YFbGAwgr7ALT8vQ4vVOMljz5wXD6XPUYyW82bcMPYFNaUjJIpu1Jtu6oHqWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdHNpqUerY1M+TqEb6wQtzhgcQYyQZh3D0dBrTo8PSk=;
 b=mx2dXP3QDIc33b8oJhn32TPe+sJbJgoHygfIO1rbkZkWQJMf7x0LNk6sPfMxNldgNtoyXj5LgCPJzztXz3UrlO2WXd5g1nVeEEJz/n5plDVZYlLMEO3qwLWH3bpNGo4NnUErL+GcYnCtvqIH9OY5Ixe6TkcnkCPLsEfNrcDKWv0=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by BY5PR12MB4291.namprd12.prod.outlook.com (2603:10b6:a03:20c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Tue, 9 Apr
 2024 02:51:48 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::2c3d:b3d4:f995:915b]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::2c3d:b3d4:f995:915b%6]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 02:51:48 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Li, Candice"
 <Candice.Li@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Yang,
 Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix incorrect return value
Thread-Topic: [PATCH] drm/amdgpu: Fix incorrect return value
Thread-Index: AQHahZWTSQEgzb5ie0e8rQ6E+eL0DrFfRK8A
Date: Tue, 9 Apr 2024 02:51:48 +0000
Message-ID: <PH7PR12MB8796CC8493C2784DDE1A53F1B0072@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240403070649.685497-1-YiPeng.Chai@amd.com>
In-Reply-To: <20240403070649.685497-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=3f6acaf8-9c91-4363-a78b-97425260c117;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-09T02:45:05Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|BY5PR12MB4291:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NQ6e5Exdy2vq1l68VkO6q5s1lHt1ZARb2XD71DwE4QZdXe4HBCtlt1R9mgSJDaPhu0+quKOFtePXiM1Fys9q1lgCzm6rtkS93COuhZCrFlwPp3+rqbaeif6J18qRUXudxGbWYgXXsFPzjlmaveCuSYB5nbpaC4dcy8GdqzebeE+0stArgVqfO7WAXVh/PJvZgGg1ggYRjysS13myEVpt5TPqjImJGb7USRMBW89J8t8M0VKTDSEQcHzMjwaqWNRGbQiqmIxVqcESvZlFz1VMP1kefDMc6EdwIqyVAU+ZnwT5cf1eJLY/Qtf+z40WYi5mVuBNEL3fleGX50tKaY199eDvK8O1DWraYcFHT6rDGSc746ATFluglgJr3Q1pgnj5Mh9tD2/y7kMVfkje11xylpe3ltWjvRKybPuZtVEzgQzT3zmeLkj052dcGduyBiCPoj7l55nixxwK2FEG7YudAzGoOF0HCaTu3TV6qBTJYhpKBWlwxiCrebMJZpe/aTojmVqttdU95sDZDgi8HuR8xVzauOtwF2p+v2yv/MWLEfIj9Xu3hdiKaw8d5PkRPGQ+s1eFH5KjKlT67yRkjXI9A5cg5K5XUvR/HRBu5pjtGKtSYz9naVY6xm+ANKdjR1N2bEcrL9IL2zwoleWNvBZYo5yYWZj4IjReedS8oLi3j34=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cFL822YKfMrjqFiTwhwOBYIgxQU7ansbjwCPbmPNM/ZAPehwAzlMFkioCx93?=
 =?us-ascii?Q?QaULWBKyZjBFqC9+6HAcUSWjQDWVgIP5SJNzAv7ZG6jhliuv9IxuXdnsLXbC?=
 =?us-ascii?Q?0oCYfteIFgRzG7BfRH1BSZzvirnrq/Pia/UCFWgYKVo/s0d2ziImNw+PLKmf?=
 =?us-ascii?Q?BrgQrlNzG7AKpBqoH8Kkv6201BNLxQg3HdiQIHSG0m5fQT76SXs6viTWzJKA?=
 =?us-ascii?Q?jmky/c49ooVe2vGm6ohNHrAngSmf3YertdcsFrzj2RvOOHZSJRMRpxx4ZQvE?=
 =?us-ascii?Q?O7/B+AC6mxu9+BUmO5rCSBA/iwQoZOjc8cNg0WbkjdrWwX9ADnq1ItnfWJ16?=
 =?us-ascii?Q?3IY3f4+DxHEj/rQGHTj94qD0gigZiyPlqft4mv8EORexGXTa2+4728lGnxT6?=
 =?us-ascii?Q?gq2RpQ4D5PDLF9T71+aTJfFIkz3pCAp5RwNMcptMeAejC2NMU6wThH03P1If?=
 =?us-ascii?Q?6RlSSPx5EASHqecNMCt5GwchvvKuiDrykGGC6j9KoXgqRm8jPc7d4C7orJtU?=
 =?us-ascii?Q?+RYyFTWyP2Y0NV1qOOr/La2xfybHctGe39ewLpScmZIIXZpGgYDIWHbEVKOf?=
 =?us-ascii?Q?9CGfe8CFQUIccrslmQPOk03qOX8tffMpX1/L/bL6+PT96MpcvP02+fc9P7O7?=
 =?us-ascii?Q?yJUfv7Kzpdos5LDK0G4B6KD1EcmnQkxBhU2SJsrpt98r9Wnla2Xu2tuG8ue+?=
 =?us-ascii?Q?ajr24BiT/9r84RuvNu5lC8YUT79pBRhohtJnUjK6lIR4xBfdoiy69SxcEZrt?=
 =?us-ascii?Q?aJVddCLDptltZzsm8mt29YzCoh0t2CukEWEUlNbkFNo5uFbkYpxj0Bs0mhLM?=
 =?us-ascii?Q?LLr2rNdvMjp3oU6/wtrbKtkC39aPjylM0afeHYNrK8zbnlhhXqp5F4htAjW9?=
 =?us-ascii?Q?6QS8LDOoun8naACTVpN72OxJ2EiStIftwpMcZaGhmCZpINU3EoFMbclIpW8e?=
 =?us-ascii?Q?K+a0CBaC9W/3qFyqJyztuhBPRg/vvGb7/effZOflYsacAF8j48z/0nZ/3Eiw?=
 =?us-ascii?Q?11MYBJFvN39Mc+YOqRPbaW7Kh8ig8kL4zXpy/0QIyrZIPYv/2tATU17ZcJim?=
 =?us-ascii?Q?tbZai8cDZLSqkhKlK6oqX/UBGzfKWYqmNm4Pf2aCa3egUe23iaq2nMTWnJkt?=
 =?us-ascii?Q?lM/iAOBMCYkff6vlqe8eRJxZL9+hktnGJ/QW+21Te4+MkPWWFOjKX+bnLd0K?=
 =?us-ascii?Q?wRB00na6uKBuqSaPPlo3a5ApdG8rKF/xUVBUyEp6R9ihQeKkb5oFzuQ7lpki?=
 =?us-ascii?Q?bIx3gi4bZbzjbo3w7I3uHlsor2/G8LGOWbmWS9PVRvaI5wA0sGNMwfYtK0m0?=
 =?us-ascii?Q?xPWEL+0NyAn/hby2mHxVKVlxHMvijqLb5DpxOZ1VWvFC1ZqTTNjPkaOxqs+0?=
 =?us-ascii?Q?NH9FY1tq+SMJ9D2AQaS7SCVqjRwarkQoj4an+PN+ZjJ4o46FHlwXx7k2sfCJ?=
 =?us-ascii?Q?U8Zu4aks/eMazmGll3eQobbWK0JCmy0lF4p2mQ6SGhZ2eCSVSBBvbTi1LZNC?=
 =?us-ascii?Q?OFYr+SchhK4hIdZRowcfZYVcu8FNBaZbzrSQbI9SL9R90Cktwm1UBIjVR13A?=
 =?us-ascii?Q?RHOGk+V7qENlEY3PwRQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99388eba-8768-4e77-aacf-08dc58400026
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 02:51:48.3012 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /DsIQ+mDUKrk7wpxUdoxCSn6IdiLydCmtAaiEoA+heWuyTNxKfgu28p3B6rWHdyp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4291
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

[AMD Official Use Only - General]

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Wednesday, April 3, 2024 3:07 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice
> <Candice.Li@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Yang,
> Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH] drm/amdgpu: Fix incorrect return value
>
> [Why]
>   After calling amdgpu_vram_mgr_reserve_range multiple times with the sam=
e
> address, calling amdgpu_vram_mgr_query_page_status will always return -
> EBUSY.
>   From the second call to amdgpu_vram_mgr_reserve_range, the same address
> will be added to the reservations_pending list again and is never moved t=
o the
> reserved_pages list because the address had been reserved.
>
> [How]
>   First add the address status check before calling
> amdgpu_vram_mgr_do_reserve, if the address is already reserved, do nothin=
g; If
> the address is already in the reservations_pending list, directly reserve=
 memory;
> only add new nodes for the addresses that are not in the reserved_pages l=
ist and
> reservations_pending list.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 28 +++++++++++++-------
>  1 file changed, 19 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index 1e36c428d254..0bf3f4092900 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -317,7 +317,6 @@ static void amdgpu_vram_mgr_do_reserve(struct
> ttm_resource_manager *man)
>
>               dev_dbg(adev->dev, "Reservation 0x%llx - %lld, Succeeded\n"=
,
>                       rsv->start, rsv->size);
> -
>               vis_usage =3D amdgpu_vram_mgr_vis_size(adev, block);
>               atomic64_add(vis_usage, &mgr->vis_usage);
>               spin_lock(&man->bdev->lru_lock);
> @@ -340,19 +339,30 @@ int amdgpu_vram_mgr_reserve_range(struct
> amdgpu_vram_mgr *mgr,
>                                 uint64_t start, uint64_t size)
>  {
>       struct amdgpu_vram_reservation *rsv;
> +     int ret =3D 0;
>
> -     rsv =3D kzalloc(sizeof(*rsv), GFP_KERNEL);
> -     if (!rsv)
> -             return -ENOMEM;
> +     ret =3D amdgpu_vram_mgr_query_page_status(mgr, start);
> +     if (!ret)
> +             return 0;
> +
> +     if (ret =3D=3D -ENOENT) {
> +             rsv =3D kzalloc(sizeof(*rsv), GFP_KERNEL);
> +             if (!rsv)
> +                     return -ENOMEM;
>
> -     INIT_LIST_HEAD(&rsv->allocated);
> -     INIT_LIST_HEAD(&rsv->blocks);
> +             INIT_LIST_HEAD(&rsv->allocated);
> +             INIT_LIST_HEAD(&rsv->blocks);
>
> -     rsv->start =3D start;
> -     rsv->size =3D size;
> +             rsv->start =3D start;
> +             rsv->size =3D size;
> +
> +             mutex_lock(&mgr->lock);
> +             list_add_tail(&rsv->blocks, &mgr->reservations_pending);
> +             mutex_unlock(&mgr->lock);

[Tao] we can drop the mutex_unlock and add if (ret !=3D -ENOENT) for the se=
cond mutex_lock to avoid unlocking/locking repeatedly.

> +
> +     }
>
>       mutex_lock(&mgr->lock);
> -     list_add_tail(&rsv->blocks, &mgr->reservations_pending);
>       amdgpu_vram_mgr_do_reserve(&mgr->manager);
>       mutex_unlock(&mgr->lock);
>
> --
> 2.34.1


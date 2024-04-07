Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 672E6CD1284
	for <amd-gfx@archiver.kernel.org>; Sun,  7 Apr 2024 02:21:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F1F010F121;
	Sun,  7 Apr 2024 02:21:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MfYXMo70";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2113.outbound.protection.outlook.com [40.107.243.113])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57FF010F121
 for <amd-gfx@lists.freedesktop.org>; Sun,  7 Apr 2024 02:20:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m11tOkcsiJUckueVRUlO1dzW4Ru1/Bg/dvVgN6cOp7qYPuJ7NNefYnVlrpDvoRHk2ETzbw6YA6QPvsfFcPdBUDkVN99On8EU8WJVOpQQV26lVK+m3/ac0rOxsiUuShRICDwZQBVtlrLoSG20e5NMQUwzIlUqrPN91uljCNwetWCsL2+d4Y0FjIS+38m7xl1dfwxy2LhAadZuREj3GQlh2bxWSET1TAMtY0Cl6AH8yJm8MKSU4GKVeWe6yKv6eio8sZhqgICq17BS66SL+76zZO5FJhrgPBUR7tQrZVwh1e/rxylaTSOffVfaykV3kw47KIHX6ZysO6EKSpuYr7lamA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdMlWVVfezJLR9C7IeJb4HGaZRTWX/gKeHpI0k5r1Hw=;
 b=N9vpbBXBkAskbPRK8mA/25IfJqIef15gxJ7xkQ+lO9buHvDfbXt18VNmRLlVLcxgeykM8NCRFwRa8S76CgwcKNwx34GT6lS5WfVIa7gP8ttEl0WNKGurzj/hwVWcQI6rRJJvbc5Itqt/25Ue+rvU0w9AVWB89pMUUobPpbh3gcARS62GXOLDOq9lZWphcbZE0Ig8bMFMI8WKKFsD7VdHGsVNJcw2efSXXNn+l2dwvHSK/fK1+F46dar9/GZf4bo5yTkXyqYuU3gCYd3+dp+nV08M8/YerDLC05zJhhiT8PlbReQbZZInRq5lEQokfrc5XslUcy7Cji/4pUDrnwe7/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdMlWVVfezJLR9C7IeJb4HGaZRTWX/gKeHpI0k5r1Hw=;
 b=MfYXMo70k6md9ydIa/hcjYw9xz9DcTAXDQ6BViY5xP2xg5S2HKGwh3ZGO/FTsytDJbIuf+7Fc6WopkwRSbng/4+beWrlZwPK8rFKKfW16/koOCbhIhKn/ljcs4HFwCSeOoGRUIPbFwxUjh1ZmijBkOhQKTMGQRnWZ2zMc2d2TsA=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by DS7PR12MB5934.namprd12.prod.outlook.com (2603:10b6:8:7d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 7 Apr
 2024 02:20:53 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::9bf1:7cdc:4c83:4da2]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::9bf1:7cdc:4c83:4da2%3]) with mapi id 15.20.7409.053; Sun, 7 Apr 2024
 02:20:53 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Li, Candice"
 <Candice.Li@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Yang,
 Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix incorrect return value
Thread-Topic: [PATCH] drm/amdgpu: Fix incorrect return value
Thread-Index: AQHahZWTzI8oX95f2kWPs2o7WORGDLFWWigAgAW5JsA=
Date: Sun, 7 Apr 2024 02:20:53 +0000
Message-ID: <CH2PR12MB42150FCCCFBB2D4AAFCC01CFFC012@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20240403070649.685497-1-YiPeng.Chai@amd.com>
 <PH7PR12MB8796050C3FF06BCA9485BE06B03D2@PH7PR12MB8796.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB8796050C3FF06BCA9485BE06B03D2@PH7PR12MB8796.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a19a3b2d-bb1b-4ac9-b35e-0c78ab4d6bfe;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-03T08:28:09Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|DS7PR12MB5934:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eFXGtBTbPRr5tVwozIK8HyhhvX0YLgUKAGoDTrHj2q3BbS5bQvQWttihslT/F/OmrYQrVq7H10aTRY9ijGxzE0SKPEdPeE3Q+SIWwnq5ntdwnM+pjFXk8dd7t9LHE2GpgQv6Jz4++1riKtcu9f2FSFQO5mJX7G6j6JKVs+Pn/zkv2J6mkpa8cBC+0QoCdY/KppeF8mUaae7/KfGmXK+/XHuwplD1JjO0WQOuYYRqDwiK4hvjiUBrj7l9bSpOM7vfEgoftYYcQtLf4aq8AYkCfXfnX8SeMJjonnevb1bKU9PSF4z+0KeyNVvuxH7uAuzPtklzOIKo0bdengtOXR4FOUq6EBK8kEe8rEJjaifV70asv3skWX1lWPMdGGmX77VCaaQqHR5/IFOR1GppKgNdVhmimJZIvE4uW24B1v5fdvgS3Az61zmFYX5DbCcRkHlSfi1dy36ZP8X3lMhmOBYgjSpyi1MREiWzTRgX8xFIaxMOY0fvj2SUCOXW7rFUtbL32N7Y4SHc5u+h4BvUKzBps9ZZ6hHq4Y0B6MN9cFRMCbboP28l7QlngGv7FtRtDY/Q0JiMg6DTxNr301PmEqAbIfsQYZ7ViFq72NKJzJ18B/m8+gzgO9jotkyJeAE3uvULn5DTLFFmHzte6T+PelFzcQn83Cy3t/mmkqpGd4ycWQc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aVeTWWQpHpsVAZYRTD3PNPnQGfeI18IA8M+nIHAjfpbW1MfeypyEJSNLbQUM?=
 =?us-ascii?Q?OCwHoPCNbcyYAXRD9albQkORv4LkjSNPq3nWjv8r0dJ+IUSpARPlNg5ypyU0?=
 =?us-ascii?Q?oItb7Oah1iZeGOuHMJtLveaQCB4aYi0p3g4eJJXrvkjLWW+RnZ3gtXEL0Z9x?=
 =?us-ascii?Q?0D/dnGpDB0nBxfUMQyyMEm0h9IT8U13N+1zbD3620kTcnkVJWMDzhL/rlOK1?=
 =?us-ascii?Q?9copAVqVRcqlE7KfxdhtOXbYi0kU8onHGMUKXnLLAY15fPUHrXRQ4LjM13jX?=
 =?us-ascii?Q?3pNzENHwYwRY97GKCXCUZN9W7xMfjIGzt6RnE2YBFxHjs949EADsJ9W0gTGG?=
 =?us-ascii?Q?BxS2hyjOpAcVQs+uAHViW8KbToJPIps3j/5zmrtspBcRNznlCC165Fw+Gooa?=
 =?us-ascii?Q?/l1rsxS0w34h0JjEoywl+4UE6CFsLBSA2BAb2jIMCL9MntYZVZMo+M7JCq3/?=
 =?us-ascii?Q?a9qHMOLoMPz6Rb60G5iDYZlCSHHaJKbRwnCk63ijBm54c8XW87DdlosoB0Mq?=
 =?us-ascii?Q?lBDBMSoJX+uS/4H3EFEbodtvmkxZLIUJDzseELm9rP51b5dcQlYUg0g2nk9M?=
 =?us-ascii?Q?HQ+SR7rXvpRP8DQ7w3mivVIWtgXBaAGdXXDqlxa7neMSYMb8qGeYiqeQ7i2N?=
 =?us-ascii?Q?8txoDUye5VCm+TjQzpc9A+YRSChpbRBRcTRn0spNmXOVe76n/GCcQqghKO8c?=
 =?us-ascii?Q?1KPPHpObzl3kqx4PfsUbGR8rMtczdRmnvakRfBBO0ph7ZD9zCtUUmaSEJIQp?=
 =?us-ascii?Q?RMiZl0Pa+nfQN7GrZ3zVSK+hy24ZjXgJMQyYp24LwdIkyfN+uHS4spc3s7hf?=
 =?us-ascii?Q?yHc+bnmri/O/xvcoL7GtU0V4QJPPiZzIrcK8+8H43PjvFjFwt+QQSYe6tW4x?=
 =?us-ascii?Q?QlsgzpQbIXegeEeV6HDwbJTVyIjaop9LwnYyAmaieaK7E3jvuldrClAkkRyA?=
 =?us-ascii?Q?BaXwT6KIiOSecVIvP5eh9KpU/yz5zo4JYhGaYgHGLyUPr26rgLw2+nk7Du//?=
 =?us-ascii?Q?u3BLKuBix5hJMD2yvaMBSTG9MyurLelSEwh5xRT8YoiZbvClckur9+FHQsTG?=
 =?us-ascii?Q?91iLVCT9SUcm4KR9umo2hONMLwnUfUaX9a86e7NePhS3TqKn6ZM2YthBWEOk?=
 =?us-ascii?Q?G8zeyGA2ae3L0tYnb6KrXeZ35esaB4RK9hvnGMPuUz8+MMT529CgE2DL7V56?=
 =?us-ascii?Q?vTtEnW+s2u11Fvp+a2YgSYQbvdQUUZyaIPvPCo+MUWrLTQiReF3NE/fa2M6k?=
 =?us-ascii?Q?WnOcRSxiAcTRWcswmnnVDRwE3EuDZPNVa5GffCX6HdR2qTX5DHpoDVO3QR+0?=
 =?us-ascii?Q?Vl2N1BFER1N9rUBZkLSsx3bu4dKNSuJvFH6Gx3flKsEeRJWTtaWFs3Q+F8KZ?=
 =?us-ascii?Q?HKL3JXMmgSdNnA361O1dfPfTDAKQ7uQg6bfTxgmwdMEiGl/tj3CwmsxNvTXG?=
 =?us-ascii?Q?XD5pbFF7lH/rH2kjDVvyVZF3pPF+1q8CVIXIGHu9rjwHwSMrtzF/u1KUvC/U?=
 =?us-ascii?Q?bbDZDUv41Pn/kwa5a/4/KC8wCerDtKA3GPcD7AeRpNfpFAjwvCLsG1uoBiTe?=
 =?us-ascii?Q?vMSOSfPQbqMq0S0q3ns=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06cac762-3f86-433f-6ac0-08dc56a959aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2024 02:20:53.3260 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f3GF/SrgjKzEVq4crZNo1ZSnrSLYaJDVHBSDiuExzSzbmyFh02nH1S7y0CY38BQFA5NDOQSiN/WdS5bL1pTFIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5934
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

-----------------
Best Regards,
Thomas

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Wednesday, April 3, 2024 6:36 PM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Candice <Candice.Li@amd.com=
>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@=
amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix incorrect return value

[AMD Official Use Only - General]

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Wednesday, April 3, 2024 3:07 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice
> <Candice.Li@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>;
> Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>
> Subject: [PATCH] drm/amdgpu: Fix incorrect return value
>
> [Why]
>   After calling amdgpu_vram_mgr_reserve_range multiple times with the
> same address, calling amdgpu_vram_mgr_query_page_status will always
> return - EBUSY.

>[Tao] could you explain why we call amdgpu_vram_mgr_reserve_range multiple=
 times with the same  address? IIRC, we skip duplicate address before reser=
ve memory.

[Thomas]
   When poison creation interrupt is received, since some poisoning address=
es may have been allocated by some processes, reserving these memories will=
 fail.
These memory will be tried to reserve again after killing the poisoned proc=
ess in the subsequent poisoning consumption interrupt handler.
so amdgpu_vram_mgr_reserve_range needs to be called multiple times with the=
 same address.

>   From the second call to amdgpu_vram_mgr_reserve_range, the same
> address will be added to the reservations_pending list again and is
> never moved to the reserved_pages list because the address had been reser=
ved.
>
> [How]
>   First add the address status check before calling
> amdgpu_vram_mgr_do_reserve, if the address is already reserved, do
> nothing; If the address is already in the reservations_pending list,
> directly reserve memory; only add new nodes for the addresses that are
> not in the reserved_pages list and reservations_pending list.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 28
> +++++++++++++-------
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
>               spin_lock(&man->bdev->lru_lock); @@ -340,19 +339,30 @@
> int amdgpu_vram_mgr_reserve_range(struct
> amdgpu_vram_mgr *mgr,
>                                 uint64_t start, uint64_t size)  {
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



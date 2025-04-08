Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C9AC36010
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Apr 2025 01:52:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDFE910E1BA;
	Tue,  8 Apr 2025 01:52:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0onpInRA";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E74D710E1BA
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Apr 2025 01:52:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zO9Jt6AACInHAqFnXSwlG09BFGFw1g4kowP72XI5HVkBnxhD+9xtPaRm+oqGDmC3rG2gddld0IgCCRl5izhTdTSX3dAqtn1aUWOHiDwMoY10ihAu9IuqIle9ZFo2N0DOLoUqQZkAecAtqmJny7DAgEun5Sf1GpksvfMhuV0jNtGJRoY6iJCfgZ3vBfZGuQYCV9SSUFRFGn5e8eiHSPoS5+D6ZmQWOToU5zAEQEuGGnyswEk+mQ5asAFyrKesOMUJwA/Lf3ZbffEkqjNNkP60hr3sHY+27esK9STVxiayenIZfeet8H8SSH9z5ofRX35HN4aLJ15lZbWqnkTl0zJWdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4em4c217Vs0dMO8CUfIxVNvb+gYhIqnKejKIncL6uk=;
 b=MGph0fe+BO4GvyPklwNtFZXKvZmjd5IMcSnsdI9ePm/PvBDBBNeYx3Bb0dLS/ox8TkfA2YjrSHK9ZeNpqrRZQR8VeabGB9nlYWk87kGsHjNCWtd8p4BSVsEJGTe9Zf0GWRPKHV41jmQyGhMbA8WkugBXATElDi408lUiQLeDCzrSS8rHafHpcg19DbaAAEEGE0kJwNa8c53obI1wjEJZXNh0QRhuVd58ipc6TNd/+pnJqMScPPV5nIskEq2dOdmS8sOA5jFaiflcRl5Cf+hZydryiuW6ipVCzoIsPavklKs5ZOttHLj6geYClIjdqCjxfqRHHlw4L4lbw1E3rWsYZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4em4c217Vs0dMO8CUfIxVNvb+gYhIqnKejKIncL6uk=;
 b=0onpInRAM+xD4TfqxPIO0HrBHuurVO2O9D9I24gtFw9grhrE2mKI2TEzgz6Mnz488PxkSTp1q7YeCWCD49V+4y7pX5IqHgrIvZUZa8aGr2kfFJYI9Mtm3QOnEMSR72brJnrmnBDytdHC0XoJTxsPBkIBwEc9FPGVY+zu6fV+j7c=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 CH3PR12MB8727.namprd12.prod.outlook.com (2603:10b6:610:173::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.27; Tue, 8 Apr
 2025 01:52:20 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%6]) with mapi id 15.20.8606.029; Tue, 8 Apr 2025
 01:52:20 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: remove the duplicated mes queue active state
 setting
Thread-Topic: [PATCH] drm/amdgpu: remove the duplicated mes queue active state
 setting
Thread-Index: AQHbn9fol7ZCr8Qn00Oh8raSIpTWYbOZEdCQ
Date: Tue, 8 Apr 2025 01:52:19 +0000
Message-ID: <DS7PR12MB6005ECD7C078520DADE94F0DFBB52@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250328115219.1763423-1-Prike.Liang@amd.com>
In-Reply-To: <20250328115219.1763423-1-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=272cc34e-d025-4354-b8a9-e4796597ec56;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-08T01:51:31Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|CH3PR12MB8727:EE_
x-ms-office365-filtering-correlation-id: d88ae5e7-551d-4df2-5c04-08dd763fffa0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?/MhQmF+GIZBblITPOYl+DojYekr0dzOPqAuac0RsylcUsORQdLcyxi2TE20m?=
 =?us-ascii?Q?37z7y72eo/ayu1kRkNJk4U/5KZ2EtyY3wILvL+2euEYMKvFW1h2dIwqOkozK?=
 =?us-ascii?Q?BoMZNiFexh5iS8qaLELV5xBZUdIqslby6N36qYTwSmvtcMuBBwsqkxqSgiXg?=
 =?us-ascii?Q?Ir4mMyXiLUxw6hNJ9Pd3ARpKdfffM1D5yUGNEHoftZ3R8VAx7ltol0qOm2MN?=
 =?us-ascii?Q?lFUUh2bQofDRdJdd93rloBtfBm09HaRga17WGfmJkpHcN8MIrFgmMdOsmEb2?=
 =?us-ascii?Q?DMENeKAWI7F2GDBz2/3HDhsVlSB+lXHJPb2aqaRho5P2y6CEiebZcO7VsiJK?=
 =?us-ascii?Q?XB57iIgGg0yfridav8KqfJMVy9WPLZ9aNZvbmTN4my1xLQifCugnXJSvLxCn?=
 =?us-ascii?Q?ydxHlPQCwhNDzZ5eM/FXm4qa3xplQN8JRI0Saa0k2HBE7cC7Z5x/P3m73KHH?=
 =?us-ascii?Q?WD9/zJRXvnrNw+l0IZyLhenG7n0jtiVeQsT6ZoUDOKma+47RdxfwjeQpTRT3?=
 =?us-ascii?Q?bn5EUluEMFokMmYXcCpfO5qFsQPrVaO2oTqe4cbdPYZ/LuwcLefv379kvVsv?=
 =?us-ascii?Q?pUkMMBzXXFi/3XkmECUrorU4ZYl9leA34IklSYqU3n0+GC8pJW22VV2vJ/ax?=
 =?us-ascii?Q?aSs2QNnQbjKJ4CNXHzXLOirJGqj/4hofauFjPuCLnPjyj7rGPRz8T2fwn1QP?=
 =?us-ascii?Q?20LzzUOtxHoHY5DVj/Wv6bHW8h/8Pn5tPXqH5pl8VBG8KwvcHUQAgzCw9ydt?=
 =?us-ascii?Q?tLOe8UNuZskd3YC4Jv8/AUGsRyJZrnYatGFHbMJLCzbkGMb0X/aNUOJQkBiM?=
 =?us-ascii?Q?+2kJE28plVruEKf3ZvcQBPv1pH86ha15o02K0+Ubc2oH2fV6AZwNa1p+n+2A?=
 =?us-ascii?Q?fK/ALqAwSRFz64c2PUWUmf/vDAs7onM0V+4V8a/JxGd0Hr8y7TO2aaEjsZL6?=
 =?us-ascii?Q?bYm0sG4omk2ERUyFsKEJbg73GOCUakUc7UfFIsJjZHaLKVuDMp3feLX41Hlj?=
 =?us-ascii?Q?JHIazhl6wzEK1c0e0HMZvsKH7rXkfPWHTmuMamPZzw/BiiSIii5WqVPwzd9b?=
 =?us-ascii?Q?3nEdAMpko3nhCW5YlMivGBT5GNl+rhDnrgVeRPeZBTx1Ik6FEbTEpKCp1DEo?=
 =?us-ascii?Q?GRzyYxhPD3InXVGO3FTgX7a+exkRNVCumHFvivcRdQWzJig+VIhkqlxNB0Ss?=
 =?us-ascii?Q?YOi6as3DhZMDEFUjYTCZjjCKqFpFB5//CilyEE21MaUMPzGdBuhH4e7jYCf8?=
 =?us-ascii?Q?9JrxWQCWt84jxs/f27ljEQ4OEYdYtOXPABylwGjPetsiU+8iQOjeAPc8ymXM?=
 =?us-ascii?Q?5MrdKcm05iID/lE5b7bjqOYhS811AZPoKId5p4ioD+SEHE/v99Z6o0XHXQZG?=
 =?us-ascii?Q?Wdc5AGEIO+Jdj9PJVoDc2J8ipaVN0KJGm+bLiTQqCuHzK7TdsK2/hf1eXVgS?=
 =?us-ascii?Q?1YOVpO/Pl0aH7lM3CWc4J97qbht2BpAo?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WJamAYNMOcGiypZj9ZnlM8fLoL4H8aNs8X/PZ6ySgWq5bBwZaNNMbgNUwb2q?=
 =?us-ascii?Q?6udZ8jPZXKA6Q9Hr8YM3PVfC/tEi3yB+F7xQjfU5qw5FEX00/jUPqGht879P?=
 =?us-ascii?Q?/CwhJ/s4i8WQOzr6Yjky25Xxs8iVPQfvabgB+XY4N4Zninc3TjQ3kEypvD9g?=
 =?us-ascii?Q?dyIy7Xu9aolfL8Ax6+7HdaEckXJ5ZBYIKSKAiHHwknB1ZZpmaYpsVxybymJn?=
 =?us-ascii?Q?5kwcujZyRFiM+mRhH0MveSdIPvOTuiTZtFqz/bQoT+qCOKygDskbaCikmxUZ?=
 =?us-ascii?Q?qENj5YAyBu+Jm0MMyWOZY697+k5rJBToPgREU/sQwXtsKgf7R4TFR4I7OR8j?=
 =?us-ascii?Q?mVe1IkBWnuDvGRzYi98TCThQp18+qGSyaPTWQjEwox+Ap76MuEzJzkAXmKY9?=
 =?us-ascii?Q?TCKErbtYGeVgSnadrjKawEJ5k7e648i9jg1Xp1wLLfiNcZGvjjzYCnrlva75?=
 =?us-ascii?Q?nyqAs54JtAEWY4AcDnvYvjDjoXgzSs3dCHyRA9yuzsmLZSCBYQ0DJFkZ672W?=
 =?us-ascii?Q?oWDqgaKrFklQgJRZWT0ricGQ//50xp8rB9i9FlUKdqZTjAWtGrQ2aFoQSOL9?=
 =?us-ascii?Q?Ir/IED7MMl/EO3Qyih4NPCx+da03HIxWUvACfloVE6cseyrFlLSfolDRgkjz?=
 =?us-ascii?Q?n+ByZifWKwzjZypmqYTLCY1lzi54E1heeH+LIlo7KVW78Jdi6VQshmcvD1Nc?=
 =?us-ascii?Q?vINssacwlDr85y0Y1EKhTeAix+cauwY1Xk0LuOHWz6qajcT5Tq0nGsaEG6gY?=
 =?us-ascii?Q?dQ/3cXLGGdyPiv8IC1dv9ecOx0YXu6S4oESf/YQ24h02C9sIcf5f8+p7Mtr5?=
 =?us-ascii?Q?d8K4s/9pDs4T6HByCjMXZR8uZJZ+mIjXYQ8brX5IgbKvLhdhpPEzbAaM8gJq?=
 =?us-ascii?Q?MEFWwYp3kdjusliAre3WL56DCvek0cBy2vosLUrou8wrKTV1FVSnDPyeUWZB?=
 =?us-ascii?Q?3T5jMxvEgzi710o6aTnWBEVOrvbumM96TUF+tYE2NJP2aQRZTTvKK9jW2h6G?=
 =?us-ascii?Q?QAabv3y8zjTtJIFBYHMYOkqcpu4uQ1o8oHohZXZzCUvjMCn0XUu1xLk0muUm?=
 =?us-ascii?Q?8levP20KVs/yeLxXDrBmy7D/qo/rxmrbQDEctYd/nAQ84FWY2TpL8E8f5r3s?=
 =?us-ascii?Q?pQD422oe9fYGb2c6lxxNSZT1qLhIQfS3f3X/LgbusyCLVnez/+k/kO9rtnp1?=
 =?us-ascii?Q?VRTVw/AtUBOAeB18Sv7cFU+P8LTJ4paVMdgfKZcFH9ezeeBENQUDU7eOBZXp?=
 =?us-ascii?Q?XxR85l7G6n/CTb4PRDfd7kg8O7XR5XV34nSZXqxOICy86PYy522MWSGukIse?=
 =?us-ascii?Q?x8s9uzL6uBc9pLn1nwM69gS8/GVOO98JO5wK47X1KRoLKc0s9kyZXoBAJYo7?=
 =?us-ascii?Q?5m31qVQrieMNx1FaJHbBACeStVn5ETmLfIOkMf9xcFfe91sgZpEZ6M3GGaty?=
 =?us-ascii?Q?Kn4pB0STKFSSe77N/DWNA0xswjgTLQFjzt+Tniv7O4Pw+vzO81lNiiF5yUxB?=
 =?us-ascii?Q?BW3CNbp1y7CD1pdVISk93+rUhmnZ/6BmBUiJDmcircOdzkJ8ybDjrKNWLrZl?=
 =?us-ascii?Q?EXRRUw0vjHE6YrxAnf8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d88ae5e7-551d-4df2-5c04-08dd763fffa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 01:52:20.0035 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T3EU5JigaK8XblxSqYiR2n+dRpu0s6tKnfhJCVRQLtCY5mhI2P8ZHQlq0BL+nWss
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8727
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

Ping ..

Regards,
      Prike

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Friday, March 28, 2025 7:52 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liang, Prike
> <Prike.Liang@amd.com>
> Subject: [PATCH] drm/amdgpu: remove the duplicated mes queue active state
> setting
>
> The MES queue deactivation and active status are already set in
> mes_userq_unmap|map(), so the caller needn't set the queue_active bit aga=
in.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index b469b800119f..b9705cbec74d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -358,10 +358,8 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr
> *uq_mgr,  static int mes_userq_suspend(struct amdgpu_userq_mgr *uq_mgr,
>                                  struct amdgpu_usermode_queue *queue)  {
> -     if (queue->queue_active) {
> +     if (queue->queue_active)
>               mes_userq_unmap(uq_mgr, queue);
> -             queue->queue_active =3D false;
> -     }
>
>       return 0;
>  }
> @@ -379,8 +377,6 @@ static int mes_userq_resume(struct amdgpu_userq_mgr
> *uq_mgr,
>               DRM_ERROR("Failed to resume queue\n");
>               return ret;
>       }
> -
> -     queue->queue_active =3D true;
>       return 0;
>  }
>
> --
> 2.34.1


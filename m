Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A4CC5CFEB
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2026 07:03:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1573310E1D7;
	Thu, 13 Aug 2026 07:03:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MmmS1saj";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011034.outbound.protection.outlook.com [52.101.52.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15B1010E1D7
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 07:03:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V6fGbjhVCUvtFt5mHGpl08LN7sTBXgohNu6zwLzFTeB/2RYmxmZN9o6itTqUxfr/+PBESwUpAsNuyAsNzVlJMYDbHu61hbND+XKP3AUUyU3O6JcKb/fPTXABPGqFnT7yWK+JIms+1N/B7o4OZW2ZV0YKC9PzmO6H9RX6z1UlWBGA9U9+MguxsVxGsoPETLvXFbc4tmoBQijvU6juegET33N2mIIBYgG3EcfJM7z3+zGpQ+DfR71eXmutDB+zHTQX6jHhxeWS1K80NFXW0VD+egPMYnLbxb7cbseVZarBAya+ea7OtruipyiLUN/x/OSJlAMab4g1K9hYc9s1UJtThQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rrqgpYe0FRDDeZlyNb+a7XWMyFpDHVtSw3l87pJ2PBk=;
 b=VMQvt83nu4WpGWnlkvulSeIcgvy369X822sVKXCY+idBincRCUUiLGKJeNw/kMQDAPViQiviUsAPGzp2hDhvw1ol8z2lIc75NDtbs7cMuyZrNanMoXUZ7dc8WTFT34Gkrsi0evFETj583FWqDeBVOmt7gRwz1WdKWCMGlZfWbUMffs/0QqNrDWN/m1zVtso2qo6vp//OU6rJrVPxQv43AFZMVelGfpO/RYRNxdQfErkvBJkCexiwzQJWDWKULGR1EddX4gkpABm+eXHq29n1uQ+HFPtVPez6u+2k0xBzCY9w9/9hWusMnwmrg2r04chILHAZtLphoVDbq+7vmC/Eug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrqgpYe0FRDDeZlyNb+a7XWMyFpDHVtSw3l87pJ2PBk=;
 b=MmmS1sajAbmBtVLYTWm0w8Yzv9MP4DcwALx/dqb5NiBH0U7EOtAMph25fZZGlR8IG61L4ywfEnmygXbRRgu3ZmIwEd63EN7IZdMzVt6mXI12P8TEX7N5/lm8v5u0pTCkkT6A/kc1JuYgYDfFxKghOQz5ck8th3zHOgL2U40pL58=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 PH0PR12MB7012.namprd12.prod.outlook.com (2603:10b6:510:21c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Thu, 13 Aug
 2026 07:03:45 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%6]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 07:03:43 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu/userq: fix lock missing for userq fence error
 set
Thread-Topic: [PATCH] drm/amdgpu/userq: fix lock missing for userq fence error
 set
Thread-Index: AQHdJjQH7M7Z2USK00ac+D5D0Up0Cbably3w
Date: Thu, 13 Aug 2026 07:03:43 +0000
Message-ID: <DS7PR12MB6005F201DFCC86FCA0642589FBDB2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260807061422.365929-1-Prike.Liang@amd.com>
In-Reply-To: <20260807061422.365929-1-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-13T07:03:06.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|PH0PR12MB7012:EE_
x-ms-office365-filtering-correlation-id: 57ecbd19-9be5-4dea-0f7b-08def9090351
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|38070700021|10067099003|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: F+2xxolS1DPEYE0FDH2CdsnYJmxQDdrgDbPVx371Tg1m/Awu1a/hFic9xg5jhyLJuwgD3mqt0TdlwhS+qwE/gQwzRt6+det4LMtsxxNrA6VxMcuAp+HAIqcv3QrwkuyiN/0AoERukyK68DLmACXD7kirB23EZYB6eO4VnZ8ZlPaQEAGNNItf5Og83Bf2SMuGV3viipTJ0Aa23i7A1vZZsRWmiI+rwHWMKfZPy4GF3c8bVNSsLtGffk3u2ocnhYKR/55A9aGcazNidYbKjkPqvPoyxqwk+OA8H6/laInSpM5DcARY5FreqdTE7GlXy/ZGDKfcdVjJksQSCqzcPfw65+mP432acezUgoQAweIVSD5D0MUk7SWFnX5xvVGKMy+Cc7JgBjL6FLH5RcyB60zvfgisVZkqrhFVQzpQh1w7/kCGAhQdf/CK2nyCoDbu4x49We14rzw4TLFTZcL+T061E6sOxQryNGi78QopprhN/NVchg6A2g7Rlj8I5ehJUHGGM0cWYWMtiaq22A/EAcLguw9A9vuWSSbdqmkf3H1P3KRysImPvIJLjnmd8gbEFPXi29VRhrf183JhufWq4o/K14YK6jRoFTrdQNOSsgOGqpCcg/zyXrR3C5qaH6jsX773+yAhE6t7vZ/gbVBH/fEDoQMb6jowUGxsz6Lhw3RJE+padYssDHBRBtN1kYvK5pJnKVUhLIzZAS4UJzhL6imEarXmKbGcxDjBeI4Vp2NOmhM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UkHJUNfTXGl82US4fi0kOZinGrTPs8kLPjuqkJOVc0Rw+I/NnKXdcnEV20TP?=
 =?us-ascii?Q?9FSh531rTAABqj01jSCCCy72Qna1UxCDvKj5k2/xsTsBbudBsrtMcNrEJ4ql?=
 =?us-ascii?Q?Od8qFKbVFi+CvNUqhnZGmvoYYTebMFM1iIMkVzOfxVPqylanjomh9kGp3qZb?=
 =?us-ascii?Q?EkYaSS3YV06tyBaaku47Wp+9G2EWDGVX8N84MbnIj5mCd5SL/EngLskTN+tj?=
 =?us-ascii?Q?T8WofEQccEAtBtoM70dMDAC3Znuw1A61IzKCp/eKM1HZnM1fVfNzCFrtMHjG?=
 =?us-ascii?Q?QIU733XixSeIdPHKq4A8hIhkLvCPHcwsbOmeEEcQi4OPoISF+++1miuy8042?=
 =?us-ascii?Q?PykByY9gZujrU9vmIK2rgt8taDoRJ6DS1R0ugQJW7I0LsGV1qlmPb/oVU8X9?=
 =?us-ascii?Q?v7YdKypY77jdiSrlCCGp9STN9izB8xrdpZQ3QTvfGkDf6b2mGD/4WiZHU4N8?=
 =?us-ascii?Q?ZXnx9Oe1QQqlJetbf3iHKc1Y+W83gfQ7DXyrkzQaqRgvu8tbXDysj/XszUok?=
 =?us-ascii?Q?EtClQyzqb4BZWXoaySCOFh2UXFx/tf3fci5Ch3Ccb0SBQu//3W0jRcmOtNoI?=
 =?us-ascii?Q?Uv7ZRdXglUN5aSbjSETDut9suUZPHYTVw5cGxT6/MOKeNwnTYml2QD/fpc4W?=
 =?us-ascii?Q?fcpxOC9KNkMZK77YSUUzH5NVCRAa1oxo4yjA0WwwS85nOBP+FRbOhbU+fE7r?=
 =?us-ascii?Q?wEpUbMtsgNtwjbMyWfpKlTx6BV8ImR2gu3X7cFcrLRTIQapdNL1Nicu7nx1f?=
 =?us-ascii?Q?0DZTTFuPUhY1d6P0Jm3VEFYKL2skQ1Y+oMYEIm7ZnchQRtfP21vSQevR1MeM?=
 =?us-ascii?Q?PpJ39DhWQgRUX8XkiQeQC7OgNXZOKX4QhN9zsf6fwIfSxsLK+RbOW8PrGaGh?=
 =?us-ascii?Q?rIFVj61TOVo/zEd7obTPnrFxFROdvAk687zQ35gA8hkCPBYDf9pv6W0Ml64I?=
 =?us-ascii?Q?Cab5B4EkZjDt6yzaqfvopHaTre4fcerJ2+XFheWUDmjaP0fDJ6HNmaO1sO6C?=
 =?us-ascii?Q?cVL+tEg0hGNFLSAoVyzrh4LZapdC9WqQHlVgvlniYSK7dHY0Xb0tl000tXAo?=
 =?us-ascii?Q?cvh9kF4T+pgSgJMVrYEXTlzou2Wq/AdOABjwUpPQdlfnz5N7au74aEm5saPl?=
 =?us-ascii?Q?VyqiPAfM8GyyhPYkkMaTYY1OdzBu315dvsamjBk4IqGX7ahH8dELSvG39J9R?=
 =?us-ascii?Q?5Vg3z1fWvMjAOOQkf0gT6OR69y/0kFGTL7qy7BG2/YgQgd2s6XmOYcOHhaUG?=
 =?us-ascii?Q?u/yc0XCkBbbAyHGxbs+lBQ6q4ioHAjmPecr7QTXU3ZsW0EVstsEdOzRUM/bF?=
 =?us-ascii?Q?7/O/4uQJSDMmxs9j0CsXCXHxvwBT8M9nyzyyY2zAaWuCUH0SMOrXH7DCgPzL?=
 =?us-ascii?Q?y82doKd2lgZvDbEYszdzE1NzbHqsOsZOyuc/HTA8HvPM067cJ+UrsVl1mdzI?=
 =?us-ascii?Q?RoEy89m30u/TAYNF8oism6OmyDY2iBJlZoD534P/DWduv6dGVjKeoVOp7nC8?=
 =?us-ascii?Q?bS1rrAb8UUmFIN4ZYx5Dz5dbLjK+ejK36A7DirU2dwEH/s95+CQz500R0uhr?=
 =?us-ascii?Q?b+xHNvWohHy67lvvDVaaRr9lu6J6DOZKm0L1w25DDCgi+jiJDtjDTkAlR8IH?=
 =?us-ascii?Q?6t+mxLu0RqoDCdYBfQfZJ24Uv5VFU9Kl7GZswDbrWDT3HCT2XrOiJQr5DCcx?=
 =?us-ascii?Q?Yz0Sc4Q1lp2nZd5E6VGI9GJsLE6RkUQFJti69djvretkUL0V?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57ecbd19-9be5-4dea-0f7b-08def9090351
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 07:03:43.8244 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S78xYydiHKHPd0N60oJHF7CSGHZjiLH5e3JVXwTHhP4jigdfrMkBSXROQjIXxEin
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7012
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

AMD General

Ping

Regards,
      Prike

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Friday, August 7, 2026 2:14 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> Subject: [PATCH] drm/amdgpu/userq: fix lock missing for userq fence error=
 set
>
> amdgpu_userq_fence_driver() and amdgpu_userq_fence_driver_destroy()
> don't acquire the dma_fence spinlock, so locking the dma_fence lock befor=
e test the
> signaled state and set error state.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index e8de64f8357d..db5bfd79ec1f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -193,12 +193,12 @@ void amdgpu_userq_fence_driver_destroy(struct kref
> *ref)
>       spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
>       list_for_each_entry_safe(fence, tmp, &fence_drv->fences, link) {
>               f =3D &fence->base;
> -
> -             if (!dma_fence_is_signaled(f)) {
> +             spin_lock(dma_fence_spinlock(f));
> +             if (!dma_fence_is_signaled_locked(f)) {
>                       dma_fence_set_error(f, -ECANCELED);
>                       dma_fence_signal(f);
>               }
> -
> +             spin_unlock(dma_fence_spinlock(f));
>               list_del(&fence->link);
>               dma_fence_put(f);
>       }
> @@ -428,8 +428,13 @@ amdgpu_userq_fence_driver_set_error(struct
> amdgpu_userq_fence *fence,
>
>       f =3D rcu_dereference_protected(&fence->base,
>                                     lockdep_is_held(&fence_drv->fence_lis=
t_lock));
> -     if (f && !dma_fence_is_signaled_locked(f))
> -             dma_fence_set_error(f, error);
> +     if (f) {
> +             /* nest f->lock inside fence_list_lock */
> +             spin_lock(dma_fence_spinlock(f));
> +             if (!dma_fence_is_signaled_locked(f))
> +                     dma_fence_set_error(f, error);
> +             spin_unlock(dma_fence_spinlock(f));
> +     }
>       spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);  }
>
> --
> 2.34.1


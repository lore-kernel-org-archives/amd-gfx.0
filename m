Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDACC43458
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 16:53:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C775010E4FD;
	Tue,  7 Jul 2026 16:53:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HrUZcfzg";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012006.outbound.protection.outlook.com [52.101.43.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1010F10E4FD
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 16:53:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T4xPGHQR9jNvyi/gE+SKKyJKkxkjTBf1K2QGm7LCebbHkrFe6Pvz4YOS2peso0cl9gUo958wNsl35WqsvclPhomVppqLIcOpQgLYTKU24aBH8GU/XuRx4yUf6gBiQh/QZqRS/hFYmFCg6Lk7Xwfd5i38VDaCaxUmjC/SGxbDQAsU/MNEBVmgK2f92ej6QHmH4px9yQ6SDvkGktynnwXIBmsiBAOrS27hUhpFqwFPQNE7UxDDMDXjcNujhdsZRwvYZLISUt6OyQXqtWhh9lwJR0qp5R3DtO9YQE4jCXc8PtTFFJsVGgcTu+h4UXr3r9GGhUXLV262Xf+zlcW8s+D76A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMKv5FmdneIIjO2XfuHQ+q5lINCf1S7rBwYqBDdetuE=;
 b=HyR6bda1JXUXtsZwLF/+hf6BXtN0XRbn4SnebXukcnkyHC2OSDqCYGuX0eXEm7++o7wAFh0zY5ZTicFFTeBHTvWjr8kxyIv/mSas2ZsHWPQy7OYvfFcraoHnv+/edlkMLfwofnsUOSHDQtdZ48NNCKBztJLolVi9aK5cRx+EvKdy3QSSKv6ABzqlYJOYqN5gRakNN0JY1L4WiCa95NfSKEhx7Z01GLn2IM8+7eX9xYFXMS3zsW+grcfPUTkPqtOH3uXo4+vcmMYAjaTVAjuTDqQpT4S5u70gGqLA+18xGPAbI+xoRCNFbMk2d/slgyE8rXPourmzHOp+GKN+9AvWeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMKv5FmdneIIjO2XfuHQ+q5lINCf1S7rBwYqBDdetuE=;
 b=HrUZcfzgTkfdKS1FJ1g069JDFrJNRRzYRG3ATfyHPViVir0HQM6+YgXok3mmnnMIZ3SLSX90Hhkyk76eGB/mzCGR5KSAN6oLhtxnTcUK8ys7LpBXJipjozz99kRXmC6IRXmVD/zR3K3Bq8GG4RBTG4lS16jMbVHlDP82IyVZ1XY=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by DS2PR12MB9613.namprd12.prod.outlook.com (2603:10b6:8:276::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Tue, 7 Jul
 2026 16:53:45 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0%5]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 16:53:44 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 30/30] drm/amdgpu/gfx12.1: drop all BUG()s
Thread-Topic: [PATCH 30/30] drm/amdgpu/gfx12.1: drop all BUG()s
Thread-Index: AQHdDidReKwcAIXgp0uOpgnm7R1TqrZiRViw
Date: Tue, 7 Jul 2026 16:53:44 +0000
Message-ID: <BL1PR12MB5898AE00C9522F97F87F4A5D85F02@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20260707154203.2603209-1-alexander.deucher@amd.com>
 <20260707154203.2603209-30-alexander.deucher@amd.com>
In-Reply-To: <20260707154203.2603209-30-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-07T16:51:15.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|DS2PR12MB9613:EE_
x-ms-office365-filtering-correlation-id: 549ab402-ec1e-41ff-003b-08dedc484ea3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|56012099006|4143699003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: G5vjKSaMOvVD0nOC9bQ3WlK4ebmv5rvnTkF8eqRCtD3NAJfXLy3tgYH7uzrA5QS5xlLYPQ9OVmqx7npkHDcrTzzF7J5TDGdzkLfi49S/+AZQAbyLk1o9vj5WppdscTmOUGgfctatMlxf/BrzBbepuf1sl0hBZqrA0G2D8jnYvzEQmTg8usi2Ou5/kMUJ+f4XzA2oY1iKirRQgrQOv16MTBvKOXHPv92Dho+T3fZE/ZFcc8YxhM28SpmELaohnCGFSCIRClrbtSQLZUNCSROR/SoVCCdSxzgbiMhRsWuXqILLgPozyMk30c4uTzFdsi06N41WFxgi4KRlyQXuOq1mJBjd5HVMeuP4jyLnmIqSEk/US23XrXrUnwmlDwxflER2IDJI8mjytCDiOq/u9/nDO5GJdCwmwORCSac0/b/h8huqhJ26fvunwTAhvbFLqH9Gg+iupiLhmt/3UXXKOXfxb5o5DNrW4JwIxgTErr3l5+4dKs66xTH3yQYXK4jKJh1Tfti4vJ0MQOamBTKvUzqhGna47tI+LPEJLtklGHnREDjJrKmkLBxJQ26B5bWSyBiDNdvHULk24iZqDQrD9DCHtcrem+o6gZPconaJmBuGHgKpjtBP9Y4ZP8U00pQCd/qgYX0ZvFYq9zG97WzHbMQNgyZGZ7Vwb9d/CEi7yptubo/lxF6gDD3ftd+aN+JK5Usu8JBqB/A+b4L8zWButTDvZ1TGW9+fL2cGBIVBOBtrks0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YdpyS6SkwMgn49k1jqsN6RI59ub3RFEg1rKodPZ5VIO0XhaPOepk7KHDhzIW?=
 =?us-ascii?Q?jEyET0kobdsBPbjvRGDqZ46YWOQjTfwPtm5gBgYiC4SLxuSv0Ohql+jEXkkM?=
 =?us-ascii?Q?VjSdsyKiIedu77gYEY8gQFPGcmIY8orExu7oXB58KRx/+iDas9+4r+8odz88?=
 =?us-ascii?Q?cAepiWQI3zSZUTcNEs7hz1vIATNLi82GUXGs5ADffDq0R1weKeIb7qS0775k?=
 =?us-ascii?Q?l8goN3odjxjaSeoHPXO0564+yRaA0jBpceiBclb5FOq1y6aXHIhbJCMdjZJ4?=
 =?us-ascii?Q?YwQJTTJo2+q0jS0v0xhoqlqwV5GyaItGs1gJwExLa7x7TBbzZnDfE9DU2awd?=
 =?us-ascii?Q?f2QouZ5AGJ/TJ5kdDiwbCMD3W1WCBLtWJIcMTC00a+l2O17S1UNg/UeKD7e8?=
 =?us-ascii?Q?dCiU9oX/iSslpTZGhr5WQOdLAeng/KaZp1gMvjFIsqqo5iU0dJQWiARXU32q?=
 =?us-ascii?Q?zjos0ADMz5U/l+2EfDgyPK9U0jFIQqDbdbSkjDgF4asbXS5GlvgC2rwRH2u9?=
 =?us-ascii?Q?sHHzj720ZhjXPt4UD1rKtOTU+7mlsw9D80FTIGA5OeCz/2rJMxH1g93QYjOS?=
 =?us-ascii?Q?WcMNcXf9d2bm5clZSlIcXFkDf526qEDU+tqxWSJ+lF2btMr1IjVTy6HC+26M?=
 =?us-ascii?Q?39HRpBHOifEnsz4hph29VAcguJGCex4fAwhwq0ArVCs8hRnNKMW5/NvwwvKR?=
 =?us-ascii?Q?DCnppKut7OIeuccTe0fb9WOwL8Ud75pdHqLpUq8Av7Q5l6bChV+OZIOpGOGU?=
 =?us-ascii?Q?ajUWbqlspBYdUckPxcKQXiaM0QCVwOD5V9mUFxPfJfFVeMj4KIgjyx40vMmx?=
 =?us-ascii?Q?W7vuaoljeNPKwiikM4+7zabDjnI5kO+Y8gII7bm8BXNx39C1hfCA5D3WyES1?=
 =?us-ascii?Q?Jwc4ab7DXb1mXBQwRRzOiRLzY7LDNNrZaGuygg829P+GdK+ajEUPjz1An9PI?=
 =?us-ascii?Q?CjLqu6KmX4MEjj/6c6hDL+fOmAA5T+0AbQX49N4yEJfKlGjxFcVUMsJhu5cX?=
 =?us-ascii?Q?ukjOs8odhxdYh2GaxJ7nu72eX0VePaOqPbZRgYiRvWmsiSMnD/AWxmH2XMrM?=
 =?us-ascii?Q?ItfhZYajdZ86MGajNSl4SsvoXMScq+8lawNeVjicjglaJVsz7px6v9AufyXK?=
 =?us-ascii?Q?kyUzuAZ4+WOrI8JIMPuCGRdmAlKKSYZYMoeOmTLJ4GXqD5jChDuLaXV/CdUy?=
 =?us-ascii?Q?aKmXv4Prs4InErAmUY5tTVpvouVv4KRkqU7Sb9r1a1nSFYdVfjrqc4KZplX2?=
 =?us-ascii?Q?WHo7HwOpUrwI+GB7UqoJI2TdqUzYosodw3VA9k4fk5uQSwReJFcqDkQS1M/h?=
 =?us-ascii?Q?hXBRROuELzc861R2rLf3GFV13BljdNjODOAZYI/Nb7BwPapBcGsiPKidClZL?=
 =?us-ascii?Q?6kg78MeZeu1WpdArZHjtCTHFAg2R6RdEhSXuMQxwZ2aaCo31lz6vPPJ+A8Ou?=
 =?us-ascii?Q?U7unWWcukoVhC6VaFIUW/5HtP2AFbZ72FVxsvLNMMWZjT2fnAchhIKFUNSam?=
 =?us-ascii?Q?yREqQshLFIP8GsVEFT3e1WpKOfmNgGollQ0pyX/F43sfYoxhBIxNXgQnIeGU?=
 =?us-ascii?Q?f+7kbDxO9HKvgkZts3/+TGlumKtWBkp2pWt97rJJrBX8vQVLUCdEB/0lPEu1?=
 =?us-ascii?Q?SO3Wx9BRKUU5cZ9aU3X8bOBmFXXR75MDbBr+VYjuiwpx9O7mx6typOZNf7vc?=
 =?us-ascii?Q?okg4Jhb6D6VWFRhXKVURUE7tdH9JjAPa76FcMT1uxkKqGlaf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 549ab402-ec1e-41ff-003b-08dedc484ea3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 16:53:44.8222 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nsjU/tXvGI+PvF4lnTyvfPIp7ZJN7buatVozgMqGwWAAw3qXZT5NTkjpGvuRd5zeRUhrSJGzIW1TM1dSH9i/nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9613
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

Looks good. Series is

Reviewed-by: Kent Russell <kent.russell@amd.com>

Kent

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: July 7, 2026 11:42 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 30/30] drm/amdgpu/gfx12.1: drop all BUG()s
>
> There's no need to crash the kernel for these cases.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> index b73f2c7d88be5..cefc2d03f0c69 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> @@ -891,8 +891,7 @@ static int gfx_v12_1_gpu_early_init(struct
> amdgpu_device *adev)
>               adev->gfx.config.sc_earlyz_tile_fifo_size =3D 0x4C0;
>               break;
>       default:
> -             BUG();
> -             break;
> +             return -EINVAL;
>       }
>
>       return 0;
> @@ -3671,13 +3670,16 @@ static u64 gfx_v12_1_ring_get_rptr_compute(struct
> amdgpu_ring *ring)
>
>  static u64 gfx_v12_1_ring_get_wptr_compute(struct amdgpu_ring *ring)
>  {
> +     struct amdgpu_device *adev =3D ring->adev;
>       u64 wptr;
>
>       /* XXX check if swapping is necessary on BE */
> -     if (ring->use_doorbell)
> +     if (ring->use_doorbell) {
>               wptr =3D atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
> -     else
> -             BUG();
> +     } else {
> +             dev_warn(adev->dev, "gfx_v12_1_ring_get_wptr_compute()
> requires doorbell!\n");
> +             wptr =3D 0;
> +     }
>       return wptr;
>  }
>
> @@ -3691,7 +3693,7 @@ static void gfx_v12_1_ring_set_wptr_compute(struct
> amdgpu_ring *ring)
>                            ring->wptr);
>               WDOORBELL64(ring->doorbell_index, ring->wptr);
>       } else {
> -             BUG(); /* only DOORBELL method supported on gfx12 now */
> +             dev_warn(adev->dev, "gfx_v12_1_ring_set_wptr_compute()
> requires doorbell!\n");
>       }
>  }
>
> --
> 2.55.0


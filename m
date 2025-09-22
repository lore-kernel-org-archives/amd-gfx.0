Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 426EECAC5A7
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Sep 2025 01:59:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB97510E05B;
	Mon, 22 Sep 2025 01:59:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Hf0YTX+3";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012034.outbound.protection.outlook.com [52.101.43.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D981610E05B
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Sep 2025 01:59:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IM9FxkBESJSO0bmPSE17cJ+rwTh3ihbiV1JbSoCZuADV5o94UAjZ+tJNOTrlSBy1prkuI/57exfSYI4/i2iFmpFVkJzc23NmtYozGC6WjSg2kY2NkPTgCbxl6xEtxTAA0r7Plb2u/+mEuz0gzIgmvvoONK70ormiP8QtFId6EoVQfGk/xZunKSo86/NOg475iMM2xe/0UaZCfZtLuTS9shg16GVRQwgHA2GRqoNHjI6dyrC6+L/i8X/RCs8fCxkh7OL0C1fme1pGxWcMT7P4J5LZ8Fl46C3gs639J7RLKidsqRxgRQtwrdfTi6m1Vkvai30pjRLIhDaq7qArTK6hKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLfk5DrFRBw1iSSd+HfgWByqvJ1lTjPWCvTsVTir8I0=;
 b=MWcN6Aki2q6T3J8kbpW4RAwh24IUCSwX6cxp+/KzD9Xaeu2Q55jUhe2UE66bzGBHL3G7SdXKCgRZUqkVBT+6G/T+gFbiY44/BXnskDGn1ZzfqsNuOUAQSeKCq0/2BlsEuiLH10pfJ1BUhJG5AN6BXL0pK+Yts3adZwgTjJWZFeha1H3i88LPOOTHJ7SaW0GoLc0MbRVSjwvNbfD3azwd25iNkF2cdZ7aQ6XejoZazmb9re1LZ37nKhWsE8e2qBj3JcEhw4a8fpo0xPDOP5R+Aj+wWSbTgmVs0XUoLOHA6Edi83ptx4ZWjJDyrFU7nNJjt+q0XLLJe0HE84DLncYaXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLfk5DrFRBw1iSSd+HfgWByqvJ1lTjPWCvTsVTir8I0=;
 b=Hf0YTX+3AmAY0BVLQ9jpUivecj4A413eHaEc/6oGXYv+6ZTw/bUG/z/gAIPxzeOqWXIOMeBeWSqkqHiWU1rZR4h6PiX1dOi/ImGhLMoBEMWUPneMA0gRBgvkn7hGvvKDgDPUvbhqz7W0qU7kvOroCaB1dcWte6Qmu1OqB7H5g5A=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by CH2PR12MB9496.namprd12.prod.outlook.com (2603:10b6:610:27e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 22 Sep
 2025 01:58:59 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%6]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 01:58:59 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH v3] drm/amdgpu: Add fallback to pipe reset if KCQ ring
 reset fails
Thread-Topic: [PATCH v3] drm/amdgpu: Add fallback to pipe reset if KCQ ring
 reset fails
Thread-Index: AQHcJuEQ/oX4DN+JzUCjk2jEANHIyLSeexNw
Date: Mon, 22 Sep 2025 01:58:59 +0000
Message-ID: <DM4PR12MB51526ABC4677BE431DA0ABD1E312A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250916080809.993236-1-Jesse.Zhang@amd.com>
In-Reply-To: <20250916080809.993236-1-Jesse.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-22T01:58:40.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|CH2PR12MB9496:EE_
x-ms-office365-filtering-correlation-id: 7531c8ae-310f-49e8-110c-08ddf97b98a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Wf6zAg2Kt25qG3eMWKbY0Civ5IsLwJvt91y870zNOla5DBe8kG2yKxbp+pkf?=
 =?us-ascii?Q?wS36YZ+Z1sp6a1oNG532O7luDfEbxEuNuTAZSdjIDjqVkie3KMaYaJySvUhq?=
 =?us-ascii?Q?e7G0pwRk0tH4P7Fe02JKE3MygSN6IYD5pbG2sJw8L0CEZhQrqW/jawsfdDcv?=
 =?us-ascii?Q?AYR8PEWH7gbu2tyyx5LS2HahSUmzTaIuJFLd1lC+z15uvbc6Ksa2cq6Pj1j3?=
 =?us-ascii?Q?m0n3TcErIRCW0F1VpDr4pGBRvjyIw8j4WZUJ6ytTuwGqFeqdEyiffLtiPZlU?=
 =?us-ascii?Q?9zwJYgdGDIA8bhAoKz0OOupCszZ8H4rJMM3ypZSVt/niApngC6OvW6R8m5Ig?=
 =?us-ascii?Q?oxkAMXKzmQG4MC+YxM1HmXJzcs5sut7AE+liZKBeSP5HXuIEm+pNcUK0lV/R?=
 =?us-ascii?Q?soadP7/+9pxQPCy0g6gmdZoZHCfxtBxnAZHVsLNHhPiiVK0in670dONeqksM?=
 =?us-ascii?Q?LR1u2AF2E4IxQ8PpvGsUufGAIcouOVWIdaa9zBd5vLsxEh1LosIs/1jgIyGS?=
 =?us-ascii?Q?tXZe9dVDGQ2QB3FwGWHKZXsuaA8oNuv/j2FrLQhV78NUb7Pl0z2rGPc09YmI?=
 =?us-ascii?Q?kG4gsAsEVulqXAuZ+YwJndhnbixpDEYBTsj3jdiyI3qVzMAlQPBzoX/62gMm?=
 =?us-ascii?Q?U9e8cKJGxNjT1aR+FHw0HTFQzjXXRVlOujUoVkFXFVhD3GlLxi65vq8kmIi1?=
 =?us-ascii?Q?Zf3FqkcCoyqs7uqIiRkthVttv5qgf23dXnXcj9w/CEu2TGMZIKsLMvyfeMzJ?=
 =?us-ascii?Q?Foobqa93dFiPwHuj9QxkWc4G05tQjqh2lKnOIA7mEx5BUgKc1bk7ST6itplz?=
 =?us-ascii?Q?P20WegFNg4fLpi2BJlXIGYNljjk1k+zf1RLKjJG9+vXfMSNwHrxU1utzbF1z?=
 =?us-ascii?Q?FSY8rPqY/lHLSNw7Zqy6Ti7CtxluCgZRb2LZ+a+saPDTjkJ7c+wM330JfUZD?=
 =?us-ascii?Q?+XTZ8XEsPNQnq8VC4Sq4HXhlNpqG5YZZqG1tBv0XKMOxc6IGTLX5nukVI1CH?=
 =?us-ascii?Q?p10Swo/xB1hru8E7a0p81UEOYtGN8MLfwU8gMjJbGAmVHkHy5kCWa9HuB6G9?=
 =?us-ascii?Q?ExAes+MmHc5/gQpz8k/HykuaMREfWF09afmOSuJzbA0X+UlvYBLv2VGUym3x?=
 =?us-ascii?Q?SJZ3RIQqubcQ+Tn5u9MLpCqkF0MFYFqX4rmUgLUQxCKHaghv9fqdHSyGQOpl?=
 =?us-ascii?Q?Hyaj3ptIOiDEgEwTW1CKr2/mzNCNtx1a+9xYyca6X8LFcQJZk/E0mhsiVsaS?=
 =?us-ascii?Q?gnOVx0+DMlbg7UMYSKLzeSoDgyAfhkIB7dZu3Aqx4MVSAiaGXURXOc+CqJ7H?=
 =?us-ascii?Q?w9pn3L3aWVAtqleHgd0F0nqoN857GD3SkEkcRFPakSEtTKIXKb7zJgegAnBM?=
 =?us-ascii?Q?ZaSxfvDEFYcugS5iha8rxx6DoALzQNna7HD/ni6LTtV+vlhldsIm6KOKWah8?=
 =?us-ascii?Q?cnTpCxhMHODyPksGAN+iH62jCxLc/j3zbJKTE1S6Ws2XURNNCeKf77hkciYM?=
 =?us-ascii?Q?3cSc9kMq1GmTFV0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uyoQeiK8iM7gaqqgfVB6f0C97GXcpNHmLXnHWb4qUgGqAbQuv6la7J5pkUPC?=
 =?us-ascii?Q?IIvNYsfT9bzCCWsCcy1uhWKBDP+mWJPj9u08dCYpaQMHYjmHZLCpYOARK/id?=
 =?us-ascii?Q?wh2mN245d9L2tZrKUHCp0ouLQYdmuHRRK3x2aKeJSzovn3tflhxscink2Har?=
 =?us-ascii?Q?5gaiB/AxOUDZvx3EsVJTTIP/i87qOW6RXC/qGIglnKA//e9XlcQMg0ajrBnf?=
 =?us-ascii?Q?Pimz6n44vA2itIsC90vzMdUD8QDTwJ7lk2H95RKZQoEszUJRTzavJZRrBZwb?=
 =?us-ascii?Q?CrjVpsiHaa1woAzoJRAg4O+LnQ4TvCpqbuxBudUf0vIICIbqF/Gde8gU4bU8?=
 =?us-ascii?Q?sWcBWhs9frJMZFbfJDu6TCrargNFKbUu8ZkU/UCG9AjYBdf4uJRB1Fh2FcEf?=
 =?us-ascii?Q?ZfJ/yWItXsDWM9W4e8+BotTvrPZPrdOMBACPrphSEF/NZzgiVHvqcBI92bVF?=
 =?us-ascii?Q?ekZUbxCmZIT3ZX7A33zhDB2qxwdZQnm5yvi4M6w6BBP5KUPahJoFO3y7YYKJ?=
 =?us-ascii?Q?okB+zI76AHFLouPT4kcYZEl18c5pxnRudz+hjmxWONse7d4UiS1A2yti9S3x?=
 =?us-ascii?Q?q50haomBiSlhQDOJ2cCkgs6djQv/mIqYWL8hB5QacS8J8TH2R0iA4/Vsd7bz?=
 =?us-ascii?Q?bJIB4GkivncTr1wcIhtmG9OcDHY+i0P83OKyZpnVlg56Y5Z8F4hNiBLCglbH?=
 =?us-ascii?Q?vjoI7wrExIcmrIcxDEdrh8bLm0drNyjxT8otw9gd+w3PYJHXLum+NGwnXU1G?=
 =?us-ascii?Q?dYw8kTA5S2zSTcjsgoZdDVZTE6yBuRFSNO/FmWYPSiSFmeqTE7jARWragsDu?=
 =?us-ascii?Q?Hv0Sjb52sAwRYikXX0bFdRlpDtEl8WKZcUdXZUyzk4OR5D+tv1UpxOfmWtaD?=
 =?us-ascii?Q?8udr1o1VuJ1+dWasLPxfGjDxs8BmNAlC8AWaWLFw3igBCMFJAnvj2sBJxilY?=
 =?us-ascii?Q?CQQaSWDFEIbQozRMEnRKHW/3zp6wfHiAKIFJgJcW+HXmoz7a/qJYM0zMMkG6?=
 =?us-ascii?Q?RWE8733+7E7nOQognyksAxN/IlBeszdq9WZjKsiC3p05qqBYthyLU3kpZ7yA?=
 =?us-ascii?Q?OrsfLhuf9FlKI9MMR7TqXRx3JXfXVYThojwwK/Xhn4k0bJSQQmSkv+TpLW49?=
 =?us-ascii?Q?88q7X1EycjuaVOyS+k61UJ5Uho5o2rn72XucLASUakFE9EegWQ60dQSD8N6z?=
 =?us-ascii?Q?b02yceiEqjI+BQikvJEgtRtmiW1+XHw4gz7lNoIe+7B7gABqcDUYfPaS8Vlf?=
 =?us-ascii?Q?Nolo7q6hOl2CL3J7+Gr+gN9GUdscyHV+N5yJqYWheDHOBG4rlxu9rgB+vR0t?=
 =?us-ascii?Q?fgFTG/bsrYW/EDm/KyQ5elhDrGrpSk7u7iSzI26xN8uPXw5MhRKeGHFBOjNr?=
 =?us-ascii?Q?4BT9DSz7ln1dC6NehknOClH71ywHFdL1bxo4SDjW4RBuG4yehdeInkEEhN57?=
 =?us-ascii?Q?+ho2LvHuKd60SnPQUecQ+zBL5tR+mdjO6nwDTZnk75lp+IACRgT9hSHMJ69B?=
 =?us-ascii?Q?rVtlLVytK0FfKRokbatsaAXcxuBrYdfzdSL1Lz6PyEpcNoWzT/LCo1x87Kln?=
 =?us-ascii?Q?PbpwY/mZfLzvDSrxtiw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7531c8ae-310f-49e8-110c-08ddf97b98a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2025 01:58:59.3691 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dFncq0uzCxIh8VT617BfB21tLIKgv6oFmG1QgDwENuavMNS/qrsbiyrR50vkIMRBBzX7WigaABLTwgb7r0a3yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9496
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

Ping ...

> -----Original Message-----
> From: Jesse.Zhang <Jesse.Zhang@amd.com>
> Sent: Tuesday, September 16, 2025 4:08 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH v3] drm/amdgpu: Add fallback to pipe reset if KCQ ring re=
set fails
>
> From: Lijo Lazar <lijo.lazar@amd.com>
>
> Add a fallback mechanism to attempt pipe reset when KCQ reset fails to re=
cover
> the ring. After performing the KCQ reset and queue remapping, test the ri=
ng
> functionality. If the ring test fails, initiate a pipe reset as an additi=
onal recovery step.
>
> v2: fix the typo (Lijo)
> v3: try pipeline reset when kiq mapping fails (Lijo)
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 8ba66d4dfe86..77f9d5b9a556 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -3560,6 +3560,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring
> *ring,
>       struct amdgpu_device *adev =3D ring->adev;
>       struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[ring->xcc_id];
>       struct amdgpu_ring *kiq_ring =3D &kiq->ring;
> +     int reset_mode =3D AMDGPU_RESET_TYPE_PER_QUEUE;
>       unsigned long flags;
>       int r;
>
> @@ -3597,6 +3598,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring
> *ring,
>               if (!(adev->gfx.compute_supported_reset &
> AMDGPU_RESET_TYPE_PER_PIPE))
>                       return -EOPNOTSUPP;
>               r =3D gfx_v9_4_3_reset_hw_pipe(ring);
> +             reset_mode =3D AMDGPU_RESET_TYPE_PER_PIPE;
>               dev_info(adev->dev, "ring: %s pipe reset :%s\n", ring->name=
,
>                               r ? "failed" : "successfully");
>               if (r)
> @@ -3619,10 +3621,20 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_rin=
g
> *ring,
>       r =3D amdgpu_ring_test_ring(kiq_ring);
>       spin_unlock_irqrestore(&kiq->ring_lock, flags);
>       if (r) {
> +             if (reset_mode =3D=3D AMDGPU_RESET_TYPE_PER_QUEUE)
> +                     goto pipe_reset;
> +
>               dev_err(adev->dev, "fail to remap queue\n");
>               return r;
>       }
>
> +     if (reset_mode =3D=3D AMDGPU_RESET_TYPE_PER_QUEUE) {
> +             r =3D amdgpu_ring_test_ring(ring);
> +             if (r)
> +                     goto pipe_reset;
> +     }
> +
> +
>       return amdgpu_ring_reset_helper_end(ring, timedout_fence);  }
>
> --
> 2.49.0


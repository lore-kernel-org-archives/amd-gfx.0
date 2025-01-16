Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F9D9C02183
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2025 16:35:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C36910E9D1;
	Thu, 16 Jan 2025 16:35:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O4tL7Bkh";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::611])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D08810E9D3
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2025 16:35:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nlg+lkHKL7s40/Eopt02/Ytl44BBHC7XcTIHidA9MJhi9KepPseu+rzc2x9wA+HQconMbHVfKXwEzUUCqOn+XrfoLlknN3vmtlVL++pc/5U0ZQ5AAfKjtsfqoEH/wKpdvuERopYleBG6t969EGa9bZE5vOFYBRH9YWLsgjJr39UhS1s1Io+kVB+BuKIYZbE+T8jN/+r1PP2ovaUq8LDZRFapmp7m0tWpWqB3CHLDWtCFvEBD8mgYJW8n5qebDZIIR1KqZezXE85Hgs0Nf8u+5pL2+z4q4+2KrMTnj9oukCuLdjs8pIfJOiIRgC4UGU+MVhK1u3ekw5do+wkPH3d5sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0a4J8EozQ84kCI7pvWJUt0t5915XPKoNgp5LL8psUU=;
 b=ecQu3tH+duC+xFzgG/Ote6Xun/8FsAIbAwT4t613FHvRRM/C3Iv9V9R++/mQt18hKEuY8OylpHd5RMJdwl4sghjIVTl1KT2MCg7GoixH9jRO6hfHKr+jIWiQ4vXsEORsQ3/Fny9JMmGmiakwE4eYtPY2299mvcDHxWJ9V7UGBSkyeqgd7sFKEedJp64wS9lHihpfzrG+oAMnsEa4mS5f/+lrhurDDu0qMSs2Kwp2QwS2/rzdr9HIRoUx3TTD6qBIYqKjTIXgtnwjlDqFvIeDg9q/2J+32ZkSTPAUgNTrLjxoe90tZF9InUfq2QE8bVLleOpPCKoYQ3F2WIYKy2AxFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0a4J8EozQ84kCI7pvWJUt0t5915XPKoNgp5LL8psUU=;
 b=O4tL7Bkh2LbPuC3dJy/rDt6v0gvGxCUIXWg2qzQRJivPYciPpp2FSJCtmYgdlGc3tBOnRtNxL9xo8V5q2sOt/aAl+BzLI8iZ9Fzm/v3EgAWmdpHNFrqsOxL4vxl5qSJgmII7vOy4ZrGQ/KCpt4sShMJCFDRFZmpA27Ee+bUkfyg=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by MW4PR12MB7383.namprd12.prod.outlook.com (2603:10b6:303:219::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Thu, 16 Jan
 2025 16:35:50 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7%5]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 16:35:50 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Martin, Andrew" <Andrew.Martin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v3] drm/amdkfd: Uninitialized and Unused variables
Thread-Topic: [PATCH v3] drm/amdkfd: Uninitialized and Unused variables
Thread-Index: AQHbYfk+AOVepRG+iU+KPjiRnEZNxbMZod7g
Date: Thu, 16 Jan 2025 16:35:50 +0000
Message-ID: <BL1PR12MB589868A4E88F2C0234A5AD88851A2@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20250108181435.2244038-1-Andrew.Martin@amd.com>
In-Reply-To: <20250108181435.2244038-1-Andrew.Martin@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=fe487654-b811-4f5e-bfea-18e7b7aed5ad;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-01-16T16:34:22Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|MW4PR12MB7383:EE_
x-ms-office365-filtering-correlation-id: 1e2eecce-b745-4c32-07c4-08dd364bd683
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?yEwvkiCTbwqpR2HwIPyZH3BRfrsdntnqgB1u0QubJG4+yoR9/zMHWFcsgxCL?=
 =?us-ascii?Q?pumhUV79F0D+sP43trGvl9+Dkb98Jz9gUsxjr9EJdsPYsqfm5m2+WEfI5dqD?=
 =?us-ascii?Q?48zYqOI3lb6A2gdorITjYyEk4Qo7EB7jOZ6M+7khdqII6y9Epqkvg/23ezc/?=
 =?us-ascii?Q?GON+bZBVHXN6zBYNWjETinshDLH3IYzLdFUzFDfsArlLl09Pbue9GgEMNc7u?=
 =?us-ascii?Q?EAddeRzvMxRbm3g86tarIO6dAXm6gfkUlMm3AX3NCbnVcljNfh8QpVTtlW7s?=
 =?us-ascii?Q?Om+K6gHvvI1t/YNb+JBeEaeyKUdBK93R+TMbPqY5bQ2l7VnYgXvuk/Hx7R0m?=
 =?us-ascii?Q?cqOIt0ljBV53hcQDSa/xVaAhWDT/1COaBZsPFAYEsB06mv3BNRat3e+OhgS6?=
 =?us-ascii?Q?cMpKGOO0rUSpN4L9sX0WgCX64M3zFezwQ/i6QKILaPJXfU862mWgwaSBhVGD?=
 =?us-ascii?Q?4+c3IsJwn+t6CbxndMfaKBkjBR803rxQDvjPbt1kwCBZvMsktGCS64kKj/pV?=
 =?us-ascii?Q?qwZS5zGg1utN9d9B8Sqh3kYBPmogWdsw0NKtROponBUppkJ+2Jhk0KlefbyZ?=
 =?us-ascii?Q?KtbWB0i4oSDOE/DljawASNu6cABd+hz1c5JXi2Qpq7iSzVSmAYplfaQVPCln?=
 =?us-ascii?Q?DeF5eN5Ym6EyoAzJLUEhRlF/1hrHX8XOupCQBAMfbbl7JI7poAWvZUoL/Z76?=
 =?us-ascii?Q?jtlJVp6NEtkEZlcd60mZhYla2xFwShiiPeJ7ssrcQCKVEyUzSjl+H67B3fau?=
 =?us-ascii?Q?HXpRVzQu/wnlwbUSWY6+d30j60raWR5jp1G3aOfkwJD3J8G17Ls9MzE3wW5X?=
 =?us-ascii?Q?PIpoRkqyj9sOQ8KkfLCM1pdseNCcooh+sHfbYhe7aAIe4bQX4SouIEV3T1Jd?=
 =?us-ascii?Q?p9911ET/KTkuwL4g25sb3QSX7J6gvoxTzoUJDs+XhmgdiQnMQCBHR1JFrtZL?=
 =?us-ascii?Q?iWq1l/AoWctdY/Wom5WWH2Bsg4MF8Mx8u3m6L23coNl0erqYn81kXzqzwMm4?=
 =?us-ascii?Q?uSmY4g9pq/LVi5GJvkO89G2FXOI6Gi6BxE2TTlqvOzP1IbA8vCKtoGVrdnFb?=
 =?us-ascii?Q?GUgND1J1g8fEgiR/mBF2A+L7yaSZpP4N0+lIFIg81rQM6NDbYB6lYi0MlZNC?=
 =?us-ascii?Q?FBYjmbceJx7PvLA1zT+O+bBu1sdpVQ0Urs3YuYJ5NTrRNx/cZxxkl60sJy+y?=
 =?us-ascii?Q?aaCCaMHVQupP4uqATOG0dgq+OahRsu5HDXPpv9PJ/gV6otNzHaZOubw1GPyS?=
 =?us-ascii?Q?oQAtIiqO+IrCRQyK9Jl3JMGuDhTDH52VwhOOoCqiLn8zLygIbXBpQCMiGFAg?=
 =?us-ascii?Q?bRfJBqVYat2cuqMh18cXiuX3AlN0aK4hBWzPOMwgCgqbgd2APqvaDuV7ot11?=
 =?us-ascii?Q?UjB4T37mWCuYkrU9+aiWhRPIbJsNWrlHUSpA24WomGrhdkNZkstJvTrwxO9n?=
 =?us-ascii?Q?ZpchvTbVuK4gx3/u5XZNJJ2b1n/nNzbK?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F/Q34/+g13rHjvVwICdIqerbxfrFPYNHyXOpaxRc2T5T5RKDFNkRD8Iinxfp?=
 =?us-ascii?Q?zAiUnBIGja+Tvdzmm6Y8DreKO6B1VNMKF1XAPCSOnxS1zB7IOeiieT59BvIC?=
 =?us-ascii?Q?QhF+aBIzUnhzglVadYhjnZZPMGAU3yBB66TfNGU0bDnj97uzBPpZk+0PXeCy?=
 =?us-ascii?Q?dSadZyV1WnIzAVQxN299k4tVpZhPcc/MOAtvji9lLBi4F8X/VA8604IDDjQX?=
 =?us-ascii?Q?Uqr2Uabe6IjhK5qJpGrvfZuBs87vz5wF9rc4L0EAEX+uD6bfL9Nqul483pxA?=
 =?us-ascii?Q?FqamRbeMTscM8rrdpL2dcFsmxvG5Zy1pdtXTtgut3TwclgIdTVEWoi6BeQ+Y?=
 =?us-ascii?Q?Zw3BqBPcuUImnNQqsHsq3y5GiTMXTm2Mw7ahXpVaR/g4ftwXcih2Po1/uy0D?=
 =?us-ascii?Q?dj3gMXDV0px1pxnyrWmXmxdDDVc2Iq3deAjGB2MEVsnVV0UnIP/l3J5B3zq+?=
 =?us-ascii?Q?Gqrpg3Dmcbsfw2Wj/n3jlm0WJhbCDxO0zOmePlC0UL4gzllmyKmSK0Gi0acx?=
 =?us-ascii?Q?4Dp6qvB3XWHeEjSlJkBSQ1dTOgNW0Prrx637z8GFEktPn7oaJrop0Om8ppPT?=
 =?us-ascii?Q?0EyK/6ffFEdEobTh60WjARTqyF5JYmI3idWeFmL/ps9K4NQnr9A8wsgtDzNE?=
 =?us-ascii?Q?qWQzIs+Y3y1q6RVvFtAjMxvm9h7ppuCIiMcInGcoBZ2ZM0tPFT8FtgeQ8v9/?=
 =?us-ascii?Q?SO/lBoa18mIz3ORRDGyPwHDAb+QHsej8aMs+roMkJJDMtNPGgLIdaTDdW9FZ?=
 =?us-ascii?Q?EKoYd3xCZKx2VmmyuipWgODwgD8DLctdcZV3tWuSnV0Ss0rttoMrFZuPsZiS?=
 =?us-ascii?Q?RIjdzErzEZZU2+Ji/VwIBtxtHVKISbg4U5nJI+xTDc1nJ75JQULoHrFrpdpa?=
 =?us-ascii?Q?d3xDihTBZBh8nQP3l8FWwCkm3Ak5aE3oip36/BWItUThq5ZnBtXOGBCqBBnv?=
 =?us-ascii?Q?2APDmw/EsGOjPsSVrlrQkBDcu11Em4glZ+ceJU8sjnrNQ/ziFIgbZi4iachq?=
 =?us-ascii?Q?uFD+1D1JWsJn743Zk9MIW4waXJEyzufJEmLutR6isV8dNfhav3Yt5nBNSn8d?=
 =?us-ascii?Q?WN5h/jWd0K7azu+ywplDfXQaDy2SSTKmna24gxtPQmOZFVTnU6zhVBInPGC1?=
 =?us-ascii?Q?mMFVOPa9jU2f8Km/4A3PpRwE6sxbc2p+kKv0+IS5wBLTUKc5SQ0bc6QxckRt?=
 =?us-ascii?Q?6+MRzSVluTSoVsV8KK5qzU0aJNP7xnXHwLUtUTukUBzIsI03uLdI/AnOjbtm?=
 =?us-ascii?Q?f2sfiIipRW/sGm/gMqWqvAYVly8WFZnu00dc8pjDnN969X3M6zTKdKDo8yVF?=
 =?us-ascii?Q?i3hpu+ZLbEGx7h6hpsEUuUiOoMtPBmWEZATXMzVo/lWjDjnMtq2hkMk1mSMf?=
 =?us-ascii?Q?WKUR+7l3q30cCFg4IrxNkOyX1ZHy6bhhfSAh/wbpK1HdjsxeNCf+wENULFKz?=
 =?us-ascii?Q?MTvF3W6gOpIgkKEHFYkt5myMFshYy8lEOGcqTlE9Y6BPW+RShb+BIp4+3U+a?=
 =?us-ascii?Q?hZbxGewb1eG4YLRBGEhJdCeKssR3Y1ZW+FIQJlMxP79+ELevpRCGyS2cz+KZ?=
 =?us-ascii?Q?awmdEX/FR1rqEeoV5ao=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e2eecce-b745-4c32-07c4-08dd364bd683
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2025 16:35:50.5361 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o0Za3MmEGDB8PpFByQwk1+10j8W18JCnjp2qIhvwWmiwKeCMW2cYVUuqkPrJoqMVUmApLgp9rH5o6cczcRHCLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7383
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

[Public]

Asking for some advice here.

Coverity throws uninitialized errors (covered below), but at least the firs=
t two (commented below) are explicitly set in the various function calls. S=
hould we be initializing them anyways, or should we only be doing that for =
the variables where there's some possible flow where they can be accessed u=
ninitialized? Thanks!

 Kent

> -----Original Message-----
> From: Martin, Andrew <Andrew.Martin@amd.com>
> Sent: Wednesday, January 8, 2025 1:15 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Russell, Kent <Kent.Russell@amd.com>; Martin, Andrew
> <Andrew.Martin@amd.com>
> Subject: [PATCH v3] drm/amdkfd: Uninitialized and Unused variables
>
> This patch initialized key variables and removed unused ones.
>
> Signed-off-by: Andrew Martin <Andrew.Martin@amd.com>
> ---
>  .../gpu/drm/amd/amdkfd/cik_event_interrupt.c  |  2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 24 +++++------
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  2 +-
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 42 ++++++++-----------
>  .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  8 ++--
>  .../drm/amd/amdkfd/kfd_packet_manager_vi.c    |  1 -
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 14 +++----
>  .../amd/amdkfd/kfd_process_queue_manager.c    |  6 +--
>  8 files changed, 43 insertions(+), 56 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
> b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
> index 795382b55e0a..9767f6483871 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
> +++ b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
> @@ -35,7 +35,7 @@ static bool cik_event_interrupt_isr(struct kfd_node *de=
v,
>                       (const struct cik_ih_ring_entry *)ih_ring_entry;
>       const struct kfd2kgd_calls *f2g =3D dev->kfd2kgd;
>       unsigned int vmid;
> -     uint16_t pasid;
> +     uint16_t pasid =3D 0;

This one isn't needed. It's initialized in one of the get_atc_vmid_pasid_ma=
pping_info calls, or below.

>       bool ret;
>
>       /* This workaround is due to HW/FW limitation on Hawaii that
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 065d87841459..306ea5a8a747 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -923,7 +923,7 @@ static int kfd_ioctl_get_tile_config(struct file *fil=
ep,
>  {
>       struct kfd_ioctl_get_tile_config_args *args =3D data;
>       struct kfd_process_device *pdd;
> -     struct tile_config config;
> +     struct tile_config config =3D {0};

Same with this one, it's set in amdgpu_amdkfd_get_tile_config

>       int err =3D 0;
>
>       mutex_lock(&p->mutex);
> @@ -1042,7 +1042,7 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct fil=
e *filep,
>  {
>       struct kfd_ioctl_alloc_memory_of_gpu_args *args =3D data;
>       struct kfd_process_device *pdd;
> -     void *mem;
> +     void *mem =3D NULL;
>       struct kfd_node *dev;
>       int idr_handle;
>       long err;
> @@ -1496,12 +1496,12 @@ static int kfd_ioctl_get_dmabuf_info(struct file =
*filep,
>  {
>       struct kfd_ioctl_get_dmabuf_info_args *args =3D data;
>       struct kfd_node *dev =3D NULL;
> -     struct amdgpu_device *dmabuf_adev;
> +     struct amdgpu_device *dmabuf_adev =3D NULL;
>       void *metadata_buffer =3D NULL;
> -     uint32_t flags;
> -     int8_t xcp_id;
> +     uint32_t flags =3D 0;
> +     int8_t xcp_id =3D 0;
>       unsigned int i;
> -     int r;
> +     int r =3D 0;
>
>       /* Find a KFD GPU device that supports the get_dmabuf_info query */
>       for (i =3D 0; kfd_topology_enum_kfd_devices(i, &dev) =3D=3D 0; i++)
> @@ -1551,7 +1551,7 @@ static int kfd_ioctl_import_dmabuf(struct file *fil=
ep,
>       struct kfd_process_device *pdd;
>       int idr_handle;
>       uint64_t size;
> -     void *mem;
> +     void *mem =3D NULL;
>       int r;
>
>       mutex_lock(&p->mutex);
> @@ -1837,10 +1837,8 @@ static int criu_get_prime_handle(struct kgd_mem *m=
em,
>                                int flags, u32 *shared_fd,
>                                struct file **file)
>  {
> -     struct dma_buf *dmabuf;
> -     int ret;
> -
> -     ret =3D amdgpu_amdkfd_gpuvm_export_dmabuf(mem, &dmabuf);
> +     struct dma_buf *dmabuf =3D NULL;
> +     int ret =3D amdgpu_amdkfd_gpuvm_export_dmabuf(mem, &dmabuf);
>       if (ret) {
>               pr_err("dmabuf export failed for the BO\n");
>               return ret;
> @@ -2291,7 +2289,7 @@ static int criu_restore_memory_of_gpu(struct
> kfd_process_device *pdd,
>       int idr_handle;
>       int ret;
>       const bool criu_resume =3D true;
> -     u64 offset;
> +     u64 offset =3D 0;
>
>       if (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL)
> {
>               if (bo_bucket->size !=3D
> @@ -2358,7 +2356,7 @@ static int criu_restore_bo(struct kfd_process *p,
>                          struct file **file)
>  {
>       struct kfd_process_device *pdd;
> -     struct kgd_mem *kgd_mem;
> +     struct kgd_mem *kgd_mem =3D NULL;
>       int ret;
>       int j;
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index a29374c86405..5af5b9baa894 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -1038,7 +1038,7 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_=
pm)
>
>  int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
>  {
> -     int ret, i;
> +     int ret =3D 0, i;
>
>       if (!kfd->init_complete)
>               return 0;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 1405e8affd48..d4a346ac1167 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -199,7 +199,7 @@ static int add_queue_mes(struct device_queue_manager
> *dqm, struct queue *q,
>       struct amdgpu_device *adev =3D (struct amdgpu_device *)dqm->dev->ad=
ev;
>       struct kfd_process_device *pdd =3D qpd_to_pdd(qpd);
>       struct mes_add_queue_input queue_input;
> -     int r, queue_type;
> +     int r =3D 0, queue_type;
>       uint64_t wptr_addr_off;
>
>       if (!dqm->sched_running || dqm->sched_halt)
> @@ -284,7 +284,7 @@ static int remove_queue_mes(struct
> device_queue_manager *dqm, struct queue *q,
>                       struct qcm_process_device *qpd)
>  {
>       struct amdgpu_device *adev =3D (struct amdgpu_device *)dqm->dev->ad=
ev;
> -     int r;
> +     int r =3D 0;
>       struct mes_remove_queue_input queue_input;
>
>       if (!dqm->sched_running || dqm->sched_halt)
> @@ -634,7 +634,7 @@ static int create_queue_nocpsch(struct
> device_queue_manager *dqm,
>                               const void *restore_mqd, const void
> *restore_ctl_stack)
>  {
>       struct mqd_manager *mqd_mgr;
> -     int retval;
> +     int retval =3D 0;
>
>       dqm_lock(dqm);
>
> @@ -795,7 +795,7 @@ static int dbgdev_wave_reset_wavefronts(struct kfd_no=
de
> *dev, struct kfd_process
>  {
>       int status =3D 0;
>       unsigned int vmid;
> -     uint16_t queried_pasid;
> +     uint16_t queried_pasid =3D 0;
>       union SQ_CMD_BITS reg_sq_cmd;
>       union GRBM_GFX_INDEX_BITS reg_gfx_index;
>       struct kfd_process_device *pdd;
> @@ -862,11 +862,9 @@ static int destroy_queue_nocpsch_locked(struct
> device_queue_manager *dqm,
>                               struct qcm_process_device *qpd,
>                               struct queue *q)
>  {
> -     int retval;
> -     struct mqd_manager *mqd_mgr;
> -
> -     mqd_mgr =3D dqm->mqd_mgrs[get_mqd_type_from_queue_type(
> -                     q->properties.type)];
> +     int retval =3D 0;
> +     struct mqd_manager *mqd_mgr =3D
> +       dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->properties.type)];
>
>       if (q->properties.type =3D=3D KFD_QUEUE_TYPE_COMPUTE)
>               deallocate_hqd(dqm, q);
> @@ -921,7 +919,7 @@ static int destroy_queue_nocpsch(struct
> device_queue_manager *dqm,
>                               struct qcm_process_device *qpd,
>                               struct queue *q)
>  {
> -     int retval;
> +     int retval =3D 0;
>       uint64_t sdma_val =3D 0;
>       struct device *dev =3D dqm->dev->adev->dev;
>       struct kfd_process_device *pdd =3D qpd_to_pdd(qpd);
> @@ -1150,7 +1148,7 @@ static int evict_process_queues_nocpsch(struct
> device_queue_manager *dqm,
>       struct queue *q;
>       struct mqd_manager *mqd_mgr;
>       struct kfd_process_device *pdd;
> -     int retval, ret =3D 0;
> +     int retval =3D 0, ret =3D 0;
>
>       dqm_lock(dqm);
>       if (qpd->evicted++ > 0) /* already evicted, do nothing */
> @@ -1260,7 +1258,7 @@ static int restore_process_queues_nocpsch(struct
> device_queue_manager *dqm,
>       struct kfd_process_device *pdd;
>       uint64_t pd_base;
>       uint64_t eviction_duration;
> -     int retval, ret =3D 0;
> +     int retval =3D 0, ret =3D 0;
>
>       pdd =3D qpd_to_pdd(qpd);
>       /* Retrieve PD base */
> @@ -1437,13 +1435,12 @@ static int register_process(struct
> device_queue_manager *dqm,
>  static int unregister_process(struct device_queue_manager *dqm,
>                                       struct qcm_process_device *qpd)
>  {
> -     int retval;
> +     int retval =3D 0;
>       struct device_process_node *cur, *next;
>
>       pr_debug("qpd->queues_list is %s\n",
>                       list_empty(&qpd->queues_list) ? "empty" : "not empt=
y");
>
> -     retval =3D 0;
>       dqm_lock(dqm);
>
>       list_for_each_entry_safe(cur, next, &dqm->queues, list) {
> @@ -1473,7 +1470,7 @@ set_pasid_vmid_mapping(struct device_queue_manager
> *dqm, u32 pasid,
>                       unsigned int vmid)
>  {
>       uint32_t xcc_mask =3D dqm->dev->xcc_mask;
> -     int xcc_id, ret;
> +     int xcc_id, ret =3D 0;
>
>       for_each_inst(xcc_id, xcc_mask) {
>               ret =3D dqm->dev->kfd2kgd->set_pasid_vmid_mapping(
> @@ -1827,8 +1824,6 @@ static int start_cpsch(struct device_queue_manager
> *dqm)
>       struct device *dev =3D dqm->dev->adev->dev;
>       int retval, num_hw_queue_slots;
>
> -     retval =3D 0;
> -
>       dqm_lock(dqm);
>
>       if (!dqm->dev->kfd->shared_resources.enable_mes) {
> @@ -1988,7 +1983,7 @@ static int create_queue_cpsch(struct
> device_queue_manager *dqm, struct queue *q,
>                       const struct kfd_criu_queue_priv_data *qd,
>                       const void *restore_mqd, const void *restore_ctl_st=
ack)
>  {
> -     int retval;
> +     int retval =3D 0;
>       struct mqd_manager *mqd_mgr;
>
>       if (dqm->total_queue_count >=3D max_num_of_queues_per_device) {
> @@ -2282,8 +2277,8 @@ static int unmap_queues_cpsch(struct
> device_queue_manager *dqm,
>                               bool reset)
>  {
>       struct device *dev =3D dqm->dev->adev->dev;
> -     struct mqd_manager *mqd_mgr;
> -     int retval;
> +     struct mqd_manager *mqd_mgr =3D NULL;
> +     int retval =3D 0;
>
>       if (!dqm->sched_running)
>               return 0;
> @@ -2705,7 +2700,7 @@ static int checkpoint_mqd(struct device_queue_manag=
er
> *dqm,
>  static int process_termination_cpsch(struct device_queue_manager *dqm,
>               struct qcm_process_device *qpd)
>  {
> -     int retval;
> +     int retval =3D 0;
>       struct queue *q;
>       struct device *dev =3D dqm->dev->adev->dev;
>       struct kernel_queue *kq, *kq_next;
> @@ -2715,8 +2710,6 @@ static int process_termination_cpsch(struct
> device_queue_manager *dqm,
>               KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES;
>       bool found =3D false;
>
> -     retval =3D 0;
> -
>       dqm_lock(dqm);
>
>       /* Clean all kernel queues */
> @@ -3439,7 +3432,6 @@ int suspend_queues(struct kfd_process *p,
>                                       else
>                                               per_device_suspended++;
>                               } else if (err !=3D -EBUSY) {
> -                                     r =3D err;
>                                       queue_ids[q_idx] |=3D
> KFD_DBG_QUEUE_ERROR_MASK;
>                                       break;
>                               }
> @@ -3647,7 +3639,7 @@ int dqm_debugfs_hqds(struct seq_file *m, void *data=
)
>  {
>       struct device_queue_manager *dqm =3D data;
>       uint32_t xcc_mask =3D dqm->dev->xcc_mask;
> -     uint32_t (*dump)[2], n_regs;
> +     uint32_t (*dump)[2] =3D {}, n_regs =3D 0;
>       int pipe, queue;
>       int r =3D 0, xcc_id;
>       uint32_t sdma_engine_start;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index ff417d5361c4..55fc98358999 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -571,7 +571,7 @@ static int hiq_load_mqd_kiq_v9_4_3(struct mqd_manager
> *mm, void *mqd,
>                       struct queue_properties *p, struct mm_struct *mms)
>  {
>       uint32_t xcc_mask =3D mm->dev->xcc_mask;
> -     int xcc_id, err, inst =3D 0;
> +     int xcc_id, err =3D 0, inst =3D 0;
>       void *xcc_mqd;
>       uint64_t hiq_mqd_size =3D kfd_hiq_mqd_stride(mm->dev);
>
> @@ -595,7 +595,7 @@ static int destroy_hiq_mqd_v9_4_3(struct mqd_manager
> *mm, void *mqd,
>                       uint32_t pipe_id, uint32_t queue_id)
>  {
>       uint32_t xcc_mask =3D mm->dev->xcc_mask;
> -     int xcc_id, err, inst =3D 0;
> +     int xcc_id, err =3D 0, inst =3D 0;
>       uint64_t hiq_mqd_size =3D kfd_hiq_mqd_stride(mm->dev);
>       struct v9_mqd *m;
>       u32 doorbell_off;
> @@ -751,7 +751,7 @@ static int destroy_mqd_v9_4_3(struct mqd_manager *mm,
> void *mqd,
>                  uint32_t pipe_id, uint32_t queue_id)
>  {
>       uint32_t xcc_mask =3D mm->dev->xcc_mask;
> -     int xcc_id, err, inst =3D 0;
> +     int xcc_id, err =3D 0, inst =3D 0;
>       void *xcc_mqd;
>       struct v9_mqd *m;
>       uint64_t mqd_offset;
> @@ -781,7 +781,7 @@ static int load_mqd_v9_4_3(struct mqd_manager *mm, vo=
id
> *mqd,
>       /* AQL write pointer counts in 64B packets, PM4/CP counts in dwords=
. */
>       uint32_t wptr_shift =3D (p->format =3D=3D KFD_QUEUE_FORMAT_AQL ? 4 =
: 0);
>       uint32_t xcc_mask =3D mm->dev->xcc_mask;
> -     int xcc_id, err, inst =3D 0;
> +     int xcc_id, err =3D 0, inst =3D 0;
>       void *xcc_mqd;
>       uint64_t mqd_stride_size =3D mm->mqd_stride(mm, p);
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> index c1199d06d131..cf803aed5069 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> @@ -173,7 +173,6 @@ static int pm_map_queues_vi(struct packet_manager *pm=
,
> uint32_t *buffer,
>       case KFD_QUEUE_TYPE_SDMA_XGMI:
>               packet->bitfields2.engine_sel =3D q->properties.sdma_engine=
_id +
>                               engine_sel__mes_map_queues__sdma0_vi;
> -             use_static =3D false; /* no static queues under SDMA */
>               break;
>       default:
>               WARN(1, "queue type %d", q->properties.type);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 083f83c94531..a6188c06c7a1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -272,7 +272,7 @@ static int kfd_get_cu_occupancy(struct attribute *att=
r, char
> *buffer)
>       struct kfd_process_device *pdd =3D NULL;
>       int i;
>       struct kfd_cu_occupancy *cu_occupancy;
> -     u32 queue_format;
> +     u32 queue_format =3D 0;
>
>       pdd =3D container_of(attr, struct kfd_process_device, attr_cu_occup=
ancy);
>       dev =3D pdd->dev;
> @@ -743,9 +743,7 @@ static int kfd_process_alloc_gpuvm(struct
> kfd_process_device *pdd,
>                                  uint32_t flags, struct kgd_mem **mem, vo=
id **kptr)
>  {
>       struct kfd_node *kdev =3D pdd->dev;
> -     int err;
> -
> -     err =3D amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(kdev->adev, gpu_va,
> size,
> +     int err =3D amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(kdev->adev,
> gpu_va, size,
>                                                pdd->drm_priv, mem, NULL,
>                                                flags, false);
>       if (err)
> @@ -798,8 +796,8 @@ static int kfd_process_device_reserve_ib_mem(struct
> kfd_process_device *pdd)
>                       KFD_IOC_ALLOC_MEM_FLAGS_NO_SUBSTITUTE |
>                       KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE |
>                       KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE;
> -     struct kgd_mem *mem;
> -     void *kaddr;
> +     struct kgd_mem *mem =3D NULL;
> +     void *kaddr =3D NULL;
>       int ret;
>
>       if (qpd->ib_kaddr || !qpd->ib_base)
> @@ -1369,8 +1367,8 @@ static int kfd_process_device_init_cwsr_dgpu(struct
> kfd_process_device *pdd)
>       uint32_t flags =3D KFD_IOC_ALLOC_MEM_FLAGS_GTT
>                       | KFD_IOC_ALLOC_MEM_FLAGS_NO_SUBSTITUTE
>                       | KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE;
> -     struct kgd_mem *mem;
> -     void *kaddr;
> +     struct kgd_mem *mem =3D NULL;
> +     void *kaddr =3D NULL;
>       int ret;
>
>       if (!dev->kfd->cwsr_enabled || qpd->cwsr_kaddr || !qpd->cwsr_base)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 9df56f8e09f9..06fbb107f303 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -769,7 +769,7 @@ int kfd_process_get_queue_info(struct kfd_process *p,
>                       if (q->properties.type =3D=3D KFD_QUEUE_TYPE_COMPUT=
E ||
>                               q->properties.type =3D=3D KFD_QUEUE_TYPE_SD=
MA ||
>                               q->properties.type =3D=3D
> KFD_QUEUE_TYPE_SDMA_XGMI) {
> -                             uint32_t mqd_size, ctl_stack_size;
> +                             uint32_t mqd_size =3D 0, ctl_stack_size =3D=
 0;
>
>                               *num_queues =3D *num_queues + 1;
>
> @@ -872,8 +872,8 @@ static int criu_checkpoint_queues_device(struct
> kfd_process_device *pdd,
>       list_for_each_entry(q, &pdd->qpd.queues_list, list) {
>               struct kfd_criu_queue_priv_data *q_data;
>               uint64_t q_data_size;
> -             uint32_t mqd_size;
> -             uint32_t ctl_stack_size;
> +             uint32_t mqd_size =3D 0;
> +             uint32_t ctl_stack_size =3D 0;
>
>               if (q->properties.type !=3D KFD_QUEUE_TYPE_COMPUTE &&
>                       q->properties.type !=3D KFD_QUEUE_TYPE_SDMA &&
> --
> 2.43.0


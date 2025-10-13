Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E9CCCD183
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 08:56:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F76C10E40B;
	Mon, 13 Oct 2025 08:56:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uDz3++wF";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011030.outbound.protection.outlook.com [52.101.52.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DED3710E416
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 08:56:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S97LPNx2nR3iFln8ylRm0NGeWfA1qgc5EcP6ysaVpd5LIEgiQ5uBFjn7T3m3IXIauRxN6sjnz1gYILNhBWIkTKROQZqk6jyLnecYKs68UlbYv9w+kSVXQl6hC7SPGtvmPhciBjDMgENpvDuy4aeeEsXZXMQj6kr7cRVtjGeKvrVrTcaEbddUPaPP5NDlitVi+W0yGoxcPiKG3/FRdeoboeLqAqQR5LsUCgNKxKJbUr6/ny/ri6pB4mLyYhYj1w7ifI3k3g1VdmYN/Vk7lL7THCaKDa/mTMsyeNOO87ZuWphu8vrLnh7k6+iFwJkDwpte6Vjp73MAHbYwGF1npru7Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wD97PF0odnb41s6P4xqIjaqvqZ+ctbAf5DVr1jzBmIU=;
 b=pHmR7z4GlzhJUadGQ++rc5qKLdDEkZqb5wT5KEoNA9wrrunrlutuGl5HqFyKh8W83KnAh5Lcr8YZ41Y6u0ulU7e1d7VQ2eEKH6Am/H4DozILiljNMtY58osRkFoKVtKrD/dY+W52WXUFF3aLeGz3wCjz+HgxmcMUGlFsYYEefHVyk7TPQGlIIUrnXJu+yumxYIrDzAeT01in9kUbGma5R9MiKNO4cEXia6xvB9wwm0bNUaJ8ZYf0b83c0ky/rSBNCPmbo4IoMkhpBMmHNQ5lpnS5wkk9MtIBD/KgjlbkYVO67uDJyvQa2t8pnjFsDZVvn6RtlFew/0uytY9zavG/Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wD97PF0odnb41s6P4xqIjaqvqZ+ctbAf5DVr1jzBmIU=;
 b=uDz3++wFZec0TzjoIob/WSVYxySlSZpNO5i7PMPWu3b74XsKETREmYwPFG7sXZsKzNWBiKXbkMnNiGuT0PARNC3EpapLKtgS+X0H42KVk3aWoPp97q903WNDou+pj+yPJ3oZKnTfmDabqKIMS3DaeFQzBjFRc8pql8S6niITJDw=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 DM4PR12MB8560.namprd12.prod.outlook.com (2603:10b6:8:189::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.13; Mon, 13 Oct 2025 08:56:16 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 08:56:16 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 4/7] drm/amdgpu/sdma: add query for CSA size and alignment
Thread-Topic: [PATCH 4/7] drm/amdgpu/sdma: add query for CSA size and alignment
Thread-Index: AQHcOisXuU8NQz2g9kG2kfCeEd9SrbS/yf9g
Date: Mon, 13 Oct 2025 08:56:16 +0000
Message-ID: <DS7PR12MB6005D6AA84FF614AF0CAE083FBEAA@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20251010211510.1528572-1-alexander.deucher@amd.com>
 <20251010211510.1528572-4-alexander.deucher@amd.com>
In-Reply-To: <20251010211510.1528572-4-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-10-13T08:55:58.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|DM4PR12MB8560:EE_
x-ms-office365-filtering-correlation-id: 13a6a143-eb84-4172-835a-08de0a365e91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?P975GYotIdFPiKX7bsXn+2czuLrFCrMjtbk01MZsjBHXnFE5TkelY8REJwSq?=
 =?us-ascii?Q?3TAH7SZmet/UWwyR2/NvHxVD6Ja8q8wCEGZNTAX3/r/lhmjXAc7UVp7on8lF?=
 =?us-ascii?Q?okOvZTqh+DSdzalrjT39Zb86WKNkZcN9Uj+nJsHL8pyzW6gB0Kl5ICC6XOHf?=
 =?us-ascii?Q?CUHYiOPmGdc86xKFGLcznrRacmXTrfzfOVK1VS5B/wcMUw9Z49NnoDloH+M6?=
 =?us-ascii?Q?4sjhfBJjBN5l0kzzVXzSLl8SCFTBhkLIqRYIlMZL9vcKf3RXyvFlOX6+MYnR?=
 =?us-ascii?Q?zfms6cMy2s+sfB9wa9L0/tjGtch4soza8dT6sgBZUCU6A2oZX4bijUehcDAk?=
 =?us-ascii?Q?ljYY3UNnVwMc/V06wBcwEBS8Ej9rsNI+l96M5vMSLbTdYZG6FarUNBQXRHKu?=
 =?us-ascii?Q?L2cCRz8VUnpcyxMUmpdqNLtD3Svd0xRjA2X91EAaak2d3bg7OiTyKnzCz+WG?=
 =?us-ascii?Q?LrtR3zvyX6PwO7Osn65d3+nKS1yY/GuS+cAfAh7XsqZsf1jdU06/W/uQ+T16?=
 =?us-ascii?Q?RYsk9MBJRKB6gi2azKDSzTuiVCNWfMH9pOBzUerdRCAqAc6Sm0f0aIWPebF4?=
 =?us-ascii?Q?0u5mFeaSTWLjKSynoyJuA282/8ySY/30pAdgYY253bTtj5V2TX4fEFXxAlLl?=
 =?us-ascii?Q?V8L1obXYDyOl0rRC4FhEHv872OTWzYCZUUOr6BHQRiRTzAF3Xqm4r7zCZqqW?=
 =?us-ascii?Q?GUCPxW8X3FdZwgMWLpShEDOYAi8gICXyTXLVhyG8Gyxb7EF20bajyU44+JQZ?=
 =?us-ascii?Q?bV/OdpI5I3pCdtXii5MiiT9ECo8JbM/El3GNusA6/svIX0QG6ze7OhhosyMl?=
 =?us-ascii?Q?NgMJZPoFSGxImP+zGrq+FVZ0tjfB1XHQWOt5m+9PRJ4rydbsRWqaXVU1G+vy?=
 =?us-ascii?Q?dxwn6tN4rauS2dmcwwbeFRzWtefvGAMiW4PRHk1t9cNUGeOdylY9aZuVcozH?=
 =?us-ascii?Q?QJzbHrkTTjp7mHtaQMdoKuRSq7EpXC/jexo+FaIrm5PlYQU9ksA0uTSoQ/kb?=
 =?us-ascii?Q?RIwZoszoMZEk25xEWtnDRuc5hIqiFtZ44BqhL5nlv49UAf/OFEbxmyQIQDot?=
 =?us-ascii?Q?WdZxVa9zh+4VTuwSYtVVr61H4kBfrAUfCMt/C2wM3pWjQcjXWp3d9flmutLQ?=
 =?us-ascii?Q?eqJhGxj48l3vjWE1+FhE50qJdnOfjzbIzoUYrc7budAv638HiKDP1USc9xo4?=
 =?us-ascii?Q?9V5CPlfB6TXXraV40obgw8PWksuACSgtAyQ7VmdtAvppOgYI2pPRAJQusC6/?=
 =?us-ascii?Q?uS65Kd3DYynWUnUWnBOVQu2aBuvRZuYaErsX+do/ud0zs9Sd58+1yUlzSuRR?=
 =?us-ascii?Q?Rw25o+M5h70vm4Vm3D/xILIx1o+nVUkQOWpDYhBlHpDzMgjRQK6no427Kaz3?=
 =?us-ascii?Q?eG7s+Nt9ytwyT4J/7AWROyZofzXU0oWH96q6J5VChoGYhpc1dQ29m6TWpV6W?=
 =?us-ascii?Q?8uTI+IconUnPt0vsnycz03MXHYEWjZHbpTIhJ4S0MeWFhxG+clvk1ZJTsY18?=
 =?us-ascii?Q?wI3+F5BmFSV+Byw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?C17rUi23dsiIAfwvNjYf1nz5xdtiQZQ+rPhIJtru2EPr56Fse8i/RCxn2jID?=
 =?us-ascii?Q?afWF48kAf8tqvvZKV140wTsbG36/pwO1aZ7I+/q7drHziKnH8myNJIsJu7pn?=
 =?us-ascii?Q?/QGpZoYwKdG6pYmuRgASPwjZ9uaMHKhhfULpjHXjxlLzO5egD6nLZvyPBYAy?=
 =?us-ascii?Q?3jt4sjGAB75DaEnJQjYPq0yHF0ig6u/9ObHQzVo2MzL98l1EHfTcLEJ87O60?=
 =?us-ascii?Q?Bb5MVgv64imk5lXECsRzRdcxyzRAfp034t5y6vts88BDtXl1orcH9V2ye9DG?=
 =?us-ascii?Q?nhrgstktHkkC5Paa2rYj3nXMLokUynBcMpt2G7uR7U9qAbhzg2so/LI150sK?=
 =?us-ascii?Q?VbKQZObDCqT/98K5V7SAbqvyFLgV8wi0DQF1YDYbsDzTfSu1dY2WXL3NaZAN?=
 =?us-ascii?Q?crIg+g0aOkO1Gj6YlciyT0RCs5/KlHoeUgtbEFD6GtxEAst/q+OjgZJNQaZ4?=
 =?us-ascii?Q?U4ug5njVTokI0hWzJ3v2jw3rpcDvzK7gXMYsqVosXZjTepgTCG8mpFUZOhpO?=
 =?us-ascii?Q?jMWE/ax5iM6y7XwjNeLi7iW5bUUKTIuIm4RxXC8iDvCWSd/lUKE7rzpgaAdW?=
 =?us-ascii?Q?dqNR0xyw80W9lMUHJmbmT4phHpdf6gI19nZOg209smxgURllhIK8KYkOcPUk?=
 =?us-ascii?Q?INz3uSiC6KrIcBCG9fkmHw7uanTsTMLlvvAckJs9eUWpjqjXppHyxzoYizIF?=
 =?us-ascii?Q?msMpvEQ0W3IEIaS44R4NHPeppKSktNfROzAzGxGTvSnRdUim8BVvcwvjeNyG?=
 =?us-ascii?Q?bBZtfWTw2n0YpvRvoqex0gp/JJ9x03l37VTv9BHoW3Wpkd8kYnT5AYVIofcP?=
 =?us-ascii?Q?u8MM4Y1L7Mep4LKRkFCYnRlNNwkWIJzORKb7LLhnsjjENAFhhOzRO/1S+Wmf?=
 =?us-ascii?Q?t1KpKH9E44rO4F7t5C2FM6e+ESlR+XKhf7xbzeQBHYyAulRjRoPBYXi3Iyr1?=
 =?us-ascii?Q?hk9qUWSPfMSOa1UOnjhl2J320rw7L9gkhH/LGFyhQql2t+y5xrD4VFdF3APh?=
 =?us-ascii?Q?ASmlIqYosdazOy6nIWAtknGZdg5z2nMqZKClLoOibK34siKUHB/Np/5vK9u2?=
 =?us-ascii?Q?cYxGGgRX6d50f383OVYICuYNYgwYxhmDiUfgu1a3dRyyPA8NLctn5/phdr+s?=
 =?us-ascii?Q?akxlvZfKWgb5FyiM6RKsKsRyqNn4kaMLB++4fAA4ZZ5lHF4VxtRbB6i/olbQ?=
 =?us-ascii?Q?URvM5iPl9j3JQ510m/6uqmSPSurecMPENKLnnmY2JEBNVm1p28fHJwI3EBFJ?=
 =?us-ascii?Q?fPCfK+sKRg4SdiQNg2vFte/tJmLDWZiKedJ4mSjCzabKcLwGAcWrYlOwfYwS?=
 =?us-ascii?Q?tsgo0Pl4tnnSmlg/MySLAsH9Ym0pxx8d5znG8GpgGJNqmg9T3tTeSQLJ79Lk?=
 =?us-ascii?Q?ezx8ssuO4nlCunw7VrQeECj/NBVWiH5Yo3EtfRM0q6Y2Aj28oE9klc0cWXXT?=
 =?us-ascii?Q?zN3p51aYT3aPSabgF+FFKjeVBUmqGVlLW9Dy7xa/h25XhquhXYqV803P+aaf?=
 =?us-ascii?Q?MpJd0ecdq7TnMWBvG5RqsNqeotKNJya0tl9hkPfZvoe2ozpb9Ju74LCGTE9c?=
 =?us-ascii?Q?ZIPtrtcyN2UMwpjHgZg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a6a143-eb84-4172-835a-08de0a365e91
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2025 08:56:16.3766 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jArdUbpyJZgBy2nlQrDqq1Izrok0H5JCuP90yNEzaS1gU0iCZlXd2EeXlA06xkqM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8560
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

Reviewed-by: Prike Liang <Prike.Liang@amd.com>

Regards,
      Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Saturday, October 11, 2025 5:15 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 4/7] drm/amdgpu/sdma: add query for CSA size and alignmen=
t
>
> Needed to query the CSA size and alignment for SDMA user queues.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  7 +++++++
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   | 12 ++++++++++++
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   | 12 ++++++++++++
>  3 files changed, 31 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> index 34311f32be4c6..872d81f73244a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -50,6 +50,11 @@ enum amdgpu_sdma_irq {
>
>  #define NUM_SDMA(x) hweight32(x)
>
> +struct amdgpu_sdma_csa_info {
> +     u32 size;
> +     u32 alignment;
> +};
> +
>  struct amdgpu_sdma_funcs {
>       int (*stop_kernel_queue)(struct amdgpu_ring *ring);
>       int (*start_kernel_queue)(struct amdgpu_ring *ring); @@ -133,6 +138=
,8 @@
> struct amdgpu_sdma {
>       struct list_head        reset_callback_list;
>       bool                    no_user_submission;
>       bool                    disable_uq;
> +     void (*get_csa_info)(struct amdgpu_device *adev,
> +                          struct amdgpu_sdma_csa_info *csa_info);
>  };
>
>  /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index aa89d915d3f98..ae1e7eb677749 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -1282,6 +1282,17 @@ static void sdma_v6_0_set_ras_funcs(struct
> amdgpu_device *adev)
>       }
>  }
>
> +/* all sizes are in bytes */
> +#define SDMA6_CSA_SIZE       32
> +#define SDMA6_CSA_ALIGNMENT  4
> +
> +static void sdma_v6_0_get_csa_info(struct amdgpu_device *adev,
> +                                struct amdgpu_sdma_csa_info *csa_info) {
> +     csa_info->size =3D SDMA6_CSA_SIZE;
> +     csa_info->alignment =3D SDMA6_CSA_ALIGNMENT; }
> +
>  static int sdma_v6_0_early_init(struct amdgpu_ip_block *ip_block)  {
>       struct amdgpu_device *adev =3D ip_block->adev; @@ -1314,6 +1325,7 @=
@
> static int sdma_v6_0_early_init(struct amdgpu_ip_block *ip_block)
>       sdma_v6_0_set_irq_funcs(adev);
>       sdma_v6_0_set_mqd_funcs(adev);
>       sdma_v6_0_set_ras_funcs(adev);
> +     adev->sdma.get_csa_info =3D &sdma_v6_0_get_csa_info;
>
>       return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> index 84d0e1aa4d501..3c32b5161739d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -1267,6 +1267,17 @@ static void
> sdma_v7_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
>       amdgpu_ring_emit_reg_wait(ring, reg1, mask, mask);  }
>
> +/* all sizes are in bytes */
> +#define SDMA7_CSA_SIZE       32
> +#define SDMA7_CSA_ALIGNMENT  4
> +
> +static void sdma_v7_0_get_csa_info(struct amdgpu_device *adev,
> +                                struct amdgpu_sdma_csa_info *csa_info) {
> +     csa_info->size =3D SDMA7_CSA_SIZE;
> +     csa_info->alignment =3D SDMA7_CSA_ALIGNMENT; }
> +
>  static int sdma_v7_0_early_init(struct amdgpu_ip_block *ip_block)  {
>       struct amdgpu_device *adev =3D ip_block->adev; @@ -1300,6 +1311,7 @=
@
> static int sdma_v7_0_early_init(struct amdgpu_ip_block *ip_block)
>       sdma_v7_0_set_vm_pte_funcs(adev);
>       sdma_v7_0_set_irq_funcs(adev);
>       sdma_v7_0_set_mqd_funcs(adev);
> +     adev->sdma.get_csa_info =3D &sdma_v7_0_get_csa_info;
>
>       return 0;
>  }
> --
> 2.51.0


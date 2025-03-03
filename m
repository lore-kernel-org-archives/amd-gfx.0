Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E223C282CD
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Mar 2025 20:53:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDD6110E2F5;
	Mon,  3 Mar 2025 20:53:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w+NAiGfM";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1077F10E113
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Mar 2025 20:53:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mhd13KiwxTFJ2cVYC35tDUWkE45ttz8yG/MJGHp+JZPekNqiQ/VKspxspjRDcp9MTAt8+gXpYSGo8hAm/VM1of5BZqlr1AXtaTaO3nJXWDFoQzifOLtOhJWhndN/DX06TaQuGbjbtJE9/OhPC7s2M9WPR5Zs4iP+vyJdZThNLh8/zht4NHhNPAMZZFd1DO/NLvInEYAvtpRN9UijeRLxZ/iTZGnnUKJqvMXRG5LLPdpnSPsyspe96UroCedE7sEzkcVbaSaiMgY+E8NiLhZ6H9QzPwuAgodNsHgwGs++pMb51jLyOYz+Uy/HGaa1IJ2DpGeCJMftHlhTj44A7EugtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfpzZ6NDhFVngrW6Tlbq9zy9799TMOrx6RvIYRK2Te8=;
 b=tjfkgXYGAPogNOLdWbyGlRu+VkaI+4NS2QH17+Z418RbkDTFJlsjArGlWhRedWbGTTXtIHrQP4jxBGSSD7dccf/mM5qNoLY1cIlC1iW9D+S47Dk4vGJVlEgqmEXhGOSoTVSylOHuacZitb89G3OeGNH16w72GwgRzQLThZTi9hMnQtENrnebt/ptQ9Lvydt5HYO1x87FSVlOfsl/A+K3DQEiFhQgC7SIedVL/mqNui98dhXqM4B664sKkuiPsJSaIo5WatkqAn107rtxMtWuwji8iIUFsBJOIHxN0WoKLwmzXk7m8uwF3FEajrAER/mz6uCzOiLy6qYjCPD/9rO5ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfpzZ6NDhFVngrW6Tlbq9zy9799TMOrx6RvIYRK2Te8=;
 b=w+NAiGfMrKRKTOxaQ+UZvecNU6DqJyPbn9DiinyuK/+riiZZ21RKckvcfehCefggqvH1HnKy8CbDb7zJhJ0MA+tGx7rR/q2YuxmK386aKywynaZT5ge2H8uWCAlMFbtC47Cjn8qsourRDY6CQNeJ6oJro70IDyV5Z9uCRU4eloI=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by SA1PR12MB6679.namprd12.prod.outlook.com (2603:10b6:806:252::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Mon, 3 Mar
 2025 20:53:53 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%6]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 20:53:53 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 2/2] drm/amdgpu: Reduce dequeue retry timeout for gfx9
 family
Thread-Topic: [PATCH v2 2/2] drm/amdgpu: Reduce dequeue retry timeout for gfx9
 family
Thread-Index: AQHbjH0fZcvhF9f0Z02A+Sx/ZrK75bNh4oNQ
Date: Mon, 3 Mar 2025 20:53:53 +0000
Message-ID: <CY8PR12MB743538C53BABCFDC92013C8A85C92@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20250303204427.113261-1-Harish.Kasiviswanathan@amd.com>
 <20250303204427.113261-2-Harish.Kasiviswanathan@amd.com>
In-Reply-To: <20250303204427.113261-2-Harish.Kasiviswanathan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=c48227f5-ed51-42c5-8d1e-c6d601315285;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-03-03T20:53:35Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|SA1PR12MB6679:EE_
x-ms-office365-filtering-correlation-id: 60edd0ae-96d0-450b-6dc0-08dd5a958213
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?h27dKeoKoUfJbDH4dRx6RmJbcGMeltSWVvTAaKpZFtZMK/uxYTg5ovHaZ9Hu?=
 =?us-ascii?Q?E9KkTiufu5Jk+st/EtYM7FvN24iCG7jJETzQDIgE6oKeby+j3fV/02cuO89I?=
 =?us-ascii?Q?wNtRUyIvqRwPT9hX0HIN+NyKhztd5WGyHSOB64UhEkXw8sV7NXuBIaJhydPa?=
 =?us-ascii?Q?juJPYmtmLKrP1tq0nhA47yR9NBqhTwTFUMifY4Veund/3d+aAE1L14KITiRh?=
 =?us-ascii?Q?rieDWWBhmrXIgjFpF72io5uVvJXU1Yb1xcSogOk7/1P4fD9wL4iZgSjbQvSZ?=
 =?us-ascii?Q?3bWrwZTbT9Px8UF2VWAa74bXACGNiqYAkWgiT3O19EuqQyZx7HQ2IPUz8ioX?=
 =?us-ascii?Q?3LGaGW15YhFYkFUV5/YeMn/A22OV6RV1IVFvwElnSBn3/YmupCsHyh8qxH3A?=
 =?us-ascii?Q?5ESutjQgM2KjswFHZkkbO0rUR376Ve1RFHyY0XCvBQzaeRl47FkMRgY46sdH?=
 =?us-ascii?Q?7ZMNeIjYe7cy+WRRkli74D5uQV6UqaFbfr4GR3tsidpRk/MWSQFYddyKWHe4?=
 =?us-ascii?Q?iopYgDRY109/nNSSDd82tYRw6VJgUi1RGd3YA1ugtRJkD43gsoG3sQ4fqGIz?=
 =?us-ascii?Q?514BJ+O1q6jQZym0DDDkiDVgm6J9innJe6G+JICDwAu4nSFXjOojDIc9VnTX?=
 =?us-ascii?Q?khjkmyrxWrbw+XIyrfW/B9NJdBnYk2faVEXez+x5mUfoJKqOxsy6g9KV7oHX?=
 =?us-ascii?Q?EJLDG/kDcZM/ddAX4u3VEMTUgWV09+ZxYeCIhdgwJHzaum/7F5z9k7xfIWXE?=
 =?us-ascii?Q?iZqhejIqRDUCT8xd6xB0hsLwk6sr1lh9JCMGONESnP0qL37U3hHjbhfc2/IL?=
 =?us-ascii?Q?iWTWFBvUKDfVP4BiT57d0BEkOWvJjFCkyHs7I01OGBP7TbwV823zyznnnF/F?=
 =?us-ascii?Q?Dvj8dSS4j1QisJyXbOuc4cq/QYexKrUgk/FhzqE+K4/Ife7pbJnNl2YJ0bn2?=
 =?us-ascii?Q?MMze423OwzdGNXR+SBAjjbLv6KYSeNcmQJRUT7cgLvuqBzhdmv9woWVYFScE?=
 =?us-ascii?Q?9na3wLexTgiVVdXU9rBZIYa1KTrkgMXqurdGG3wSvAK43eYYe191gi2Gs6Q/?=
 =?us-ascii?Q?eAJGONXNiYBR6fOFPYGLz3gBdzfVyFuDKkBXFkkQpSbWh5XnjpwNKYcLgucX?=
 =?us-ascii?Q?F4L/pZ5ejltA7662+irQWILRaP2RRFKBFNPfbhMMb7FG6pvd47dqvrl30hJv?=
 =?us-ascii?Q?va+XUvOkBT6lHrNR90XofO+dapeG4ZmBBxtkYf6yaNcBbi29PzLsGjHfPd+o?=
 =?us-ascii?Q?Opq1e8nwbp2OWzWAfboEsJKzi9xlwVNViD4KrZ994WkbtmfrDR3cQrDqqSNM?=
 =?us-ascii?Q?kvWraywqgjs0h0VW/g+Z3QCGzcdaPG4lggUyzEpyz+MlChAS/d+Zh1fs8wX4?=
 =?us-ascii?Q?neyWg8oO8O+bStXwtf0pUhEsaSNsV+kvNPBReGcaFsp1Qu/vlvhp6PQyubcs?=
 =?us-ascii?Q?8y1txu/hWDsREm21ckLs9M817E9TRpC+?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oHnM/u/Ynu20e06ZwEyA2dQPYOp6Af+9qbQh+Qt/ET+9JMJwukgSc6Kj52nm?=
 =?us-ascii?Q?usDNChLfPags55NSg2uid6a3WWtipswZwY4zuhbJ2Bj/4eK1KI6mmrj48UrQ?=
 =?us-ascii?Q?N1CB79i+j4G0O31ey5F4lmv68mih+1vJxiKgnf2xh27CsvC3tRBU7Yw9aiAA?=
 =?us-ascii?Q?h0xUkea64sJef3fs/YqH9mtmWKxUWb/0aVJ5NplmJyawIY99mkwowj0I2kSE?=
 =?us-ascii?Q?8ItKblfS7hMLR4mSTXRqI7AusN0A2x/OZ4XhJVnSlCTjZ+ysUiaFbNefd5Lq?=
 =?us-ascii?Q?Qa35j+w4EzyjcmoKJ4ly8LgowJqhQ62rrPZy63p99PaHMJjRHWUrWDIH7zL5?=
 =?us-ascii?Q?Wzoih+S7C/s9SrAfTCBaxEBNU+8evt6paQqCOHLB347oDbRCkwYSnGiMYDWf?=
 =?us-ascii?Q?bdLxJsmrPZfeJNBoYUjKE+8+TxcTXwSG1tltDsd0NH821OZIxHCpxEOH+KpR?=
 =?us-ascii?Q?YR/a+iXHwgos0liB323KCyei2Gqn8lDIUpvXOrGJO0mRV8I5PfBMBm6fnefS?=
 =?us-ascii?Q?T+VLmht3ZtSr7qzM6PUx8dKD2ZKuY39Ucgu556JXXf/2JFn3vYh1FFjVJP+J?=
 =?us-ascii?Q?4GpEjyh2Trg0dW7tkzSMLLiFxKr84lJUubEbuHmDKSVLub/rTLmmjntu4r0m?=
 =?us-ascii?Q?HEfDJ1HMZVVJ/rCdD3v81+4ChqJCNkdeH1dasJSE2K5KXgoOKXlPLNYTWkCh?=
 =?us-ascii?Q?Pf5T82vT3AcqnoMB4ucxBFsS3BrahirpA9DVJ86OS07MKghrAJmokG4DxHFa?=
 =?us-ascii?Q?BDe9+hq8KlfdIUmhOO9bZ7Y8YS+rf+EAR1d/8CdQs7uNNNV/MGOIk95zq6ZI?=
 =?us-ascii?Q?cggLmxukZSkwvpvOJZQ3cF5uCS6BXRevNyxM39X5EEYGjkJrc78aW7JzeEW1?=
 =?us-ascii?Q?XrMk3FWdh4mRo7IKq8xtbBpqCp9u7OEp5bEz1Falki1cCC8EmHedleGU/voH?=
 =?us-ascii?Q?rrcv3ZCVUqOu/b60MFo8oO2NgSRS87x6DHQ9mUP5x0OJhDsKrNVOhok2KyK8?=
 =?us-ascii?Q?0AnjAeYVqinp6JZ72y175dl50KBJU03LgEttmo+VV9iIY7r527DVYdfj8Ca+?=
 =?us-ascii?Q?CtfGv999AyPCfdaKdrHs4IlcA/3zPzJcq85H2/r2HFvgaMhPNNSRN1RcwsJp?=
 =?us-ascii?Q?Yc+9SrWZcOBtv/nqD1Jy0gYksv71KGdhk4P0/utO8QgFR30A+IhbEtNJQYbA?=
 =?us-ascii?Q?2UJKmromJ5LG0xiNZUVujNSsn2RgptaaB4J+Y1buC4Y+IWf5pIX0umjtPesN?=
 =?us-ascii?Q?mNcZYmXL1a2LPk3ieLYESOL048N9y/niifKqLBvXF8JbPd2Srs0XEvKF4uzj?=
 =?us-ascii?Q?VAnRnJ68RS51U2qDhUCxxs4fPnuDtOzRdn0TDsVM9KQtu27m6XmtmSs+dR9i?=
 =?us-ascii?Q?3gwdqcuVsRmDoz3/X+22VSU+LiSA0CpKPHTJrsmXIqe5Ci+UazH+7b8jVx2u?=
 =?us-ascii?Q?j97y7Dd4xvkC5nKWZUL9u+w5x8nmS2BgFCvlahWEn74uejo4XfNpRyGOtulY?=
 =?us-ascii?Q?3LONh2k3+xxEBu4B1+lF9WJs55W6LEjpyKr/yB6QIw86iRiTaLxbtRSBptPu?=
 =?us-ascii?Q?WQF30EE8xm5Rhfnv4EU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60edd0ae-96d0-450b-6dc0-08dd5a958213
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 20:53:53.5081 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mXnno87PHFjAXQvsGUkbHTA0VL+h3KgB7lJMgIZzBZW4NPlsGSnJF3OFnmgn4GKM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6679
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

> -----Original Message-----
> From: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
> Sent: Monday, March 3, 2025 3:44 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Kim, Jonath=
an
> <Jonathan.Kim@amd.com>
> Subject: [PATCH v2 2/2] drm/amdgpu: Reduce dequeue retry timeout for gfx9=
 family
>
> Dequeue retry timeout controls the interval between checks for unmet
> conditions. On MI series, reduce this from 0x40 to 0x1 (~ 1 uS). The
> cost of additional bandwidth consumed by CP when polling memory
> shouldn't be substantial.
>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> Reviewed-by: : Jonathan Kim <jonathan.kim@amd.com>
> ---
>  .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  |  2 +-
>  .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   |  2 +-
>  .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   |  4 +-
>  .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    | 28 ++++++-------
>  .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h    |  5 ++-
>  .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c  |  2 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 28 ++++++-------
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |  5 ++-
>  .../drm/amd/amdkfd/kfd_packet_manager_v9.c    | 40 +++++++++++++------
>  .../gpu/drm/amd/include/kgd_kfd_interface.h   |  5 ++-
>  10 files changed, 70 insertions(+), 51 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> index 8dfdb18197c4..53f5f1885870 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> @@ -189,7 +189,7 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd =3D {
>       .set_address_watch =3D kgd_gfx_aldebaran_set_address_watch,
>       .clear_address_watch =3D kgd_gfx_v9_clear_address_watch,
>       .get_iq_wait_times =3D kgd_gfx_v9_get_iq_wait_times,
> -     .build_grace_period_packet_info =3D
> kgd_gfx_v9_build_grace_period_packet_info,
> +     .build_dequeue_wait_counts_packet_info =3D
> kgd_gfx_v9_build_dequeue_wait_counts_packet_info,
>       .program_trap_handler_settings =3D
> kgd_gfx_v9_program_trap_handler_settings,
>       .hqd_get_pq_addr =3D kgd_gfx_v9_hqd_get_pq_addr,
>       .hqd_reset =3D kgd_gfx_v9_hqd_reset,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> index 9abf29b58ac7..6fd41aece7e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> @@ -415,7 +415,7 @@ const struct kfd2kgd_calls arcturus_kfd2kgd =3D {
>       .set_address_watch =3D kgd_gfx_v9_set_address_watch,
>       .clear_address_watch =3D kgd_gfx_v9_clear_address_watch,
>       .get_iq_wait_times =3D kgd_gfx_v9_get_iq_wait_times,
> -     .build_grace_period_packet_info =3D
> kgd_gfx_v9_build_grace_period_packet_info,
> +     .build_dequeue_wait_counts_packet_info =3D
> kgd_gfx_v9_build_dequeue_wait_counts_packet_info,
>       .get_cu_occupancy =3D kgd_gfx_v9_get_cu_occupancy,
>       .program_trap_handler_settings =3D
> kgd_gfx_v9_program_trap_handler_settings,
>       .hqd_get_pq_addr =3D kgd_gfx_v9_hqd_get_pq_addr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> index e2ae714a700f..95f249896275 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> @@ -530,8 +530,8 @@ const struct kfd2kgd_calls gc_9_4_3_kfd2kgd =3D {
>       .get_cu_occupancy =3D kgd_gfx_v9_get_cu_occupancy,
>       .program_trap_handler_settings =3D
>                               kgd_gfx_v9_program_trap_handler_settings,
> -     .build_grace_period_packet_info =3D
> -                             kgd_gfx_v9_build_grace_period_packet_info,
> +     .build_dequeue_wait_counts_packet_info =3D
> +                             kgd_gfx_v9_build_dequeue_wait_counts_packet=
_info,
>       .get_iq_wait_times =3D kgd_gfx_v9_get_iq_wait_times,
>       .enable_debug_trap =3D kgd_aldebaran_enable_debug_trap,
>       .disable_debug_trap =3D kgd_gfx_v9_4_3_disable_debug_trap,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> index 62176d607bef..0b03f2e9a858 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> @@ -1021,25 +1021,25 @@ void kgd_gfx_v10_get_iq_wait_times(struct
> amdgpu_device *adev,
>       *wait_times =3D RREG32(SOC15_REG_OFFSET(GC, 0,
> mmCP_IQ_WAIT_TIME2));
>  }
>
> -void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *ad=
ev,
> +void kgd_gfx_v10_build_dequeue_wait_counts_packet_info(struct amdgpu_dev=
ice
> *adev,
>                                               uint32_t wait_times,
> -                                             uint32_t grace_period,
> +                                             uint32_t sch_wave,
> +                                             uint32_t que_sleep,
>                                               uint32_t *reg_offset,
>                                               uint32_t *reg_data)
>  {
>       *reg_data =3D wait_times;
>
> -     /*
> -      * The CP cannont handle a 0 grace period input and will result in
> -      * an infinite grace period being set so set to 1 to prevent this.
> -      */
> -     if (grace_period =3D=3D 0)
> -             grace_period =3D 1;
> -
> -     *reg_data =3D REG_SET_FIELD(*reg_data,
> -                     CP_IQ_WAIT_TIME2,
> -                     SCH_WAVE,
> -                     grace_period);
> +     if (sch_wave)
> +             *reg_data =3D REG_SET_FIELD(*reg_data,
> +                             CP_IQ_WAIT_TIME2,
> +                             SCH_WAVE,
> +                             sch_wave);
> +     if (que_sleep)
> +             *reg_data =3D REG_SET_FIELD(*reg_data,
> +                             CP_IQ_WAIT_TIME2,
> +                             QUE_SLEEP,
> +                             que_sleep);
>
>       *reg_offset =3D SOC15_REG_OFFSET(GC, 0, mmCP_IQ_WAIT_TIME2);
>  }
> @@ -1109,7 +1109,7 @@ const struct kfd2kgd_calls gfx_v10_kfd2kgd =3D {
>       .set_address_watch =3D kgd_gfx_v10_set_address_watch,
>       .clear_address_watch =3D kgd_gfx_v10_clear_address_watch,
>       .get_iq_wait_times =3D kgd_gfx_v10_get_iq_wait_times,
> -     .build_grace_period_packet_info =3D
> kgd_gfx_v10_build_grace_period_packet_info,
> +     .build_dequeue_wait_counts_packet_info =3D
> kgd_gfx_v10_build_dequeue_wait_counts_packet_info,
>       .program_trap_handler_settings =3D program_trap_handler_settings,
>       .hqd_get_pq_addr =3D kgd_gfx_v10_hqd_get_pq_addr,
>       .hqd_reset =3D kgd_gfx_v10_hqd_reset
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> index 9efd2dd4fdd7..89ae07288b10 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> @@ -51,9 +51,10 @@ uint32_t kgd_gfx_v10_clear_address_watch(struct
> amdgpu_device *adev,
>  void kgd_gfx_v10_get_iq_wait_times(struct amdgpu_device *adev,
>                               uint32_t *wait_times,
>                               uint32_t inst);
> -void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *ad=
ev,
> +void kgd_gfx_v10_build_dequeue_wait_counts_packet_info(struct amdgpu_dev=
ice
> *adev,
>                                              uint32_t wait_times,
> -                                            uint32_t grace_period,
> +                                            uint32_t sch_wave,
> +                                            uint32_t que_sleep,
>                                              uint32_t *reg_offset,
>                                              uint32_t *reg_data);
>  uint64_t kgd_gfx_v10_hqd_get_pq_addr(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
> index c718bedda0ca..2c5f22838fe0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
> @@ -673,7 +673,7 @@ const struct kfd2kgd_calls gfx_v10_3_kfd2kgd =3D {
>       .set_vm_context_page_table_base =3D
> set_vm_context_page_table_base_v10_3,
>       .program_trap_handler_settings =3D program_trap_handler_settings_v1=
0_3,
>       .get_iq_wait_times =3D kgd_gfx_v10_get_iq_wait_times,
> -     .build_grace_period_packet_info =3D
> kgd_gfx_v10_build_grace_period_packet_info,
> +     .build_dequeue_wait_counts_packet_info =3D
> kgd_gfx_v10_build_dequeue_wait_counts_packet_info,
>       .enable_debug_trap =3D kgd_gfx_v10_enable_debug_trap,
>       .disable_debug_trap =3D kgd_gfx_v10_disable_debug_trap,
>       .validate_trap_override_request =3D
> kgd_gfx_v10_validate_trap_override_request,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index 441568163e20..d2bbe9973c93 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -1077,25 +1077,25 @@ void kgd_gfx_v9_get_cu_occupancy(struct
> amdgpu_device *adev,
>                               adev->gfx.cu_info.max_waves_per_simd;
>  }
>
> -void kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *ade=
v,
> +void kgd_gfx_v9_build_dequeue_wait_counts_packet_info(struct amdgpu_devi=
ce
> *adev,
>               uint32_t wait_times,
> -             uint32_t grace_period,
> +             uint32_t sch_wave,
> +             uint32_t que_sleep,
>               uint32_t *reg_offset,
>               uint32_t *reg_data)
>  {
>       *reg_data =3D wait_times;
>
> -     /*
> -      * The CP cannot handle a 0 grace period input and will result in
> -      * an infinite grace period being set so set to 1 to prevent this.
> -      */
> -     if (grace_period =3D=3D 0)
> -             grace_period =3D 1;
> -
> -     *reg_data =3D REG_SET_FIELD(*reg_data,
> -                     CP_IQ_WAIT_TIME2,
> -                     SCH_WAVE,
> -                     grace_period);
> +     if (sch_wave)
> +             *reg_data =3D REG_SET_FIELD(*reg_data,
> +                             CP_IQ_WAIT_TIME2,
> +                             SCH_WAVE,
> +                             sch_wave);
> +     if (que_sleep)
> +             *reg_data =3D REG_SET_FIELD(*reg_data,
> +                             CP_IQ_WAIT_TIME2,
> +                             QUE_SLEEP,
> +                             que_sleep);
>
>       *reg_offset =3D SOC15_REG_OFFSET(GC, 0, mmCP_IQ_WAIT_TIME2);
>  }
> @@ -1254,7 +1254,7 @@ const struct kfd2kgd_calls gfx_v9_kfd2kgd =3D {
>       .set_address_watch =3D kgd_gfx_v9_set_address_watch,
>       .clear_address_watch =3D kgd_gfx_v9_clear_address_watch,
>       .get_iq_wait_times =3D kgd_gfx_v9_get_iq_wait_times,
> -     .build_grace_period_packet_info =3D
> kgd_gfx_v9_build_grace_period_packet_info,
> +     .build_dequeue_wait_counts_packet_info =3D
> kgd_gfx_v9_build_dequeue_wait_counts_packet_info,
>       .get_cu_occupancy =3D kgd_gfx_v9_get_cu_occupancy,
>       .program_trap_handler_settings =3D
> kgd_gfx_v9_program_trap_handler_settings,
>       .hqd_get_pq_addr =3D kgd_gfx_v9_hqd_get_pq_addr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> index b6a91a552aa4..54ee8992be5c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> @@ -97,9 +97,10 @@ uint32_t kgd_gfx_v9_clear_address_watch(struct
> amdgpu_device *adev,
>  void kgd_gfx_v9_get_iq_wait_times(struct amdgpu_device *adev,
>                               uint32_t *wait_times,
>                               uint32_t inst);
> -void kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *ade=
v,
> +void kgd_gfx_v9_build_dequeue_wait_counts_packet_info(struct amdgpu_devi=
ce
> *adev,
>                                              uint32_t wait_times,
> -                                            uint32_t grace_period,
> +                                            uint32_t sch_wave,
> +                                            uint32_t que_sleep,
>                                              uint32_t *reg_offset,
>                                              uint32_t *reg_data);
>  uint64_t kgd_gfx_v9_hqd_get_pq_addr(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> index b9c611b249e6..6861e8f7a2f7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> @@ -298,13 +298,14 @@ static int pm_map_queues_v9(struct packet_manager
> *pm, uint32_t *buffer,
>  }
>
>  static inline void pm_build_dequeue_wait_counts_packet_info(struct
> packet_manager *pm,
> -                     uint32_t sch_value, uint32_t *reg_offset,
> +                     uint32_t sch_value, uint32_t que_sleep, uint32_t *r=
eg_offset,
>                       uint32_t *reg_data)
>  {
> -     pm->dqm->dev->kfd2kgd->build_grace_period_packet_info(
> +     pm->dqm->dev->kfd2kgd->build_dequeue_wait_counts_packet_info(
>               pm->dqm->dev->adev,
>               pm->dqm->wait_times,
>               sch_value,
> +             que_sleep,
>               reg_offset,
>               reg_data);
>  }
> @@ -320,26 +321,41 @@ static int pm_config_dequeue_wait_counts_v9(struct
> packet_manager *pm,
>
>       switch (cmd) {
>       case KFD_DEQUEUE_WAIT_INIT:
> -             /* Set CWSR grace period to 1x1000 cycle for GFX9.4.3 APU *=
/
> -             if (amdgpu_emu_mode =3D=3D 0 && pm->dqm->dev->adev-
> >gmc.is_app_apu &&
> -                (KFD_GC_VERSION(pm->dqm->dev) =3D=3D IP_VERSION(9, 4, 3)=
))
> -                     pm_build_dequeue_wait_counts_packet_info(pm, 1,
> &reg_offset, &reg_data);
> -             else
> +             uint32_t sch_wave =3D 0, que_sleep =3D 0;
> +             /* Reduce CP_IQ_WAIT_TIME2.QUE_SLEEP to 0x1 from default
> 0x40.
> +              * On a 1GHz machine this is roughly 1 microsecond, which i=
s
> +              * about how long it takes to load data out of memory durin=
g
> +              * queue connect
> +              * QUE_SLEEP: Wait Count for Dequeue Retry.
> +              */
> +             if (KFD_GC_VERSION(pm->dqm->dev) >=3D IP_VERSION(9, 4, 1) &=
&
> +                 KFD_GC_VERSION(pm->dqm->dev) < IP_VERSION(10, 0, 0)) {
> +                     que_sleep =3D 1;
> +
> +                     /* Set CWSR grace period to 1x1000 cycle for GFX9.4=
.3 APU
> */
> +                     if (amdgpu_emu_mode =3D=3D 0 && pm->dqm->dev->adev-
> >gmc.is_app_apu &&
> +                     (KFD_GC_VERSION(pm->dqm->dev) =3D=3D IP_VERSION(9, =
4,
> 3)))
> +                             sch_wave =3D 1;
> +             } else /* non gfx9 */
>                       return 0;

Please close the else statement braces to balance the if statement braces.
Also the /* non gfx9 */ comment isn't correct and should be removed because=
 you can still have GFX9 devices that are pre v9.4.1 that do not need optim=
ized wait times on dequeue.

Thanks,

Jon

> +
> +             pm_build_dequeue_wait_counts_packet_info(pm, sch_wave,
> que_sleep,
> +                     &reg_offset, &reg_data);
> +
>               break;
>       case KFD_DEQUEUE_WAIT_RESET:
> -             /* function called only to get reg_offset */
> -             pm_build_dequeue_wait_counts_packet_info(pm, 0, &reg_offset=
,
> &reg_data);
> -             reg_data =3D pm->dqm->wait_times;
> +             /* reg_data would be set to dqm->wait_times */
> +             pm_build_dequeue_wait_counts_packet_info(pm, 0, 0, &reg_off=
set,
> &reg_data);
>               break;
>
>       case KFD_DEQUEUE_WAIT_SET_SCH_WAVE:
>               /* The CP cannot handle value 0 and it will result in
> -              * an infinite grace period being set so set to 1 to preven=
t this.
> +              * an infinite grace period being set so set to 1 to preven=
t this. Also
> +              * avoid debugger API breakage as it sets 0 and expects a l=
ow value.
>                */
>               if (!value)
>                       value =3D 1;
> -             pm_build_dequeue_wait_counts_packet_info(pm, value, &reg_of=
fset,
> &reg_data);
> +             pm_build_dequeue_wait_counts_packet_info(pm, value, 0,
> &reg_offset, &reg_data);
>               break;
>       default:
>               pr_err("Invalid dequeue wait cmd\n");
> diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> index e3e635a31b8a..4f79e707bc80 100644
> --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> @@ -313,9 +313,10 @@ struct kfd2kgd_calls {
>       void (*get_iq_wait_times)(struct amdgpu_device *adev,
>                       uint32_t *wait_times,
>                       uint32_t inst);
> -     void (*build_grace_period_packet_info)(struct amdgpu_device *adev,
> +     void (*build_dequeue_wait_counts_packet_info)(struct amdgpu_device
> *adev,
>                       uint32_t wait_times,
> -                     uint32_t grace_period,
> +                     uint32_t sch_wave,
> +                     uint32_t que_sleep,
>                       uint32_t *reg_offset,
>                       uint32_t *reg_data);
>       void (*get_cu_occupancy)(struct amdgpu_device *adev,
> --
> 2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F407FCD6E56
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 09:03:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61238113042;
	Mon,  1 Jun 2026 09:03:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bj1txHk9";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012048.outbound.protection.outlook.com [40.107.209.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B615811303D
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 09:03:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JIlFDQmeMTF0uYVmMj1qJMpTzxUnjdb6lmrDsw3M52dDxXPAIO6DYC+q21TP3rH9Wn1pr/8O5Ho1zBNAS/Rb4/L8F1C7pzXcnUwo3HKgM4e0BMJq2i1NgYaKLafbtddFVgBASgJZdgQhCaNxkc6340OPDDVX6QqPsoRMp8hD2/iEkjbszRYNlKhy+DHnJOPP37BgrC80j5qw5Atcs7uKldYKrvPs3cPmI2x2XvcZnChgCHhquzwTORThdECNsOmwtl0ZS3PCqb0M35xyq8gix7qA/pqSukxJaPIdZzw1tCqaXTzDJXN6xWrAJosRa1B2vvlpig2YhclbO4f3+k85Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjRHc56g6pE5211YC91QTgLuSckERuDGcdu4X5DnZmk=;
 b=PC+g4ghXpxQ03uasY1q/jhL4SsZMSzksiBZ8my82+sLB4G7AkRbNzeVPyD9n3Tc/lIfwUxWRmccHL4tpO9gWAQjgxoMRkddj/Z8bCWGU3w7n0wS6rArT34zgYH/lzctERCK2wM2ZP5RNyNht0WOu8DujpvnRu+n55oI8jJ0ACF3kJkrtfItx1eokyteaaPG1MJ5fMx36dnO6dV3csXzbbewajYDYSaE0jXE54bUQhLj0Ad8bZCFdFLRje7aiA432HfSEcpA5qIpPn+AiygSWBDPOdkkL1HmO16kKQJwlKgJJ/PLm0bYsZAQzHGdCyurWp53AOjFdSuWfQVTz/3xFeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjRHc56g6pE5211YC91QTgLuSckERuDGcdu4X5DnZmk=;
 b=bj1txHk9uUezEHr17iEZ80+535cfx+Dt2nUOVmy7vopaxt2Ts3fVOYyJ7a3VTE/NodxfjrzAclHCtUWssr1E4UL4yYb73EMO7c6D/CETjxMkB8qwo7Jdl8P6Wp+uAJachgfRi0gPin/DW/JW1BpbVvODfaa1BU8vf8Z5PZMc8rg=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 SA1PR12MB6845.namprd12.prod.outlook.com (2603:10b6:806:25c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 09:03:48 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%3]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 09:03:48 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Rastogi, Manu" <Manu.Rastogi@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH v2 14/42] drm/amdgpu/gfx12: Refactor compute pipe reset
 and add HQD cleanup
Thread-Topic: [PATCH v2 14/42] drm/amdgpu/gfx12: Refactor compute pipe reset
 and add HQD cleanup
Thread-Index: AQHc8Yrg/kHquXt4vkaMz7iVvmY9ZLYpZ7Ww
Date: Mon, 1 Jun 2026 09:03:48 +0000
Message-ID: <DS7PR12MB60051F490B4A172F319B752BFB152@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
 <20260601055034.3700921-14-Jesse.Zhang@amd.com>
In-Reply-To: <20260601055034.3700921-14-Jesse.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-01T09:02:39.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|SA1PR12MB6845:EE_
x-ms-office365-filtering-correlation-id: 02b0cfe2-7690-43b1-b2f5-08debfbcb152
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|3023799007|38070700021|56012099006|4143699003|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: 0MZBEdFo9g+MBcdjfTVWe/rSNVdXj7gPbsnqnrg/2wVUpf1/iHEyQSPdfD4tcunC+Pv1CYUTpy4GtqLcN5G9KZptYkjZBIuByfD2NBvjEPCp7bk24oDih7WWE3qJR+n5K9Vx2YQRPhPbkA09B0P0l97nu7rpu0z+8KDfdxCx1ioCxj0YBj+VcvCXWS/xIF8SPvPjE2tvzXRSNQKxd8N+iFrweNf/1e+/IOFK8tsd6APADmjjpbWnpPraXNWv5KpB6d9gmG7KJWNIMyt4Mmw7kc0rzwG24wykbzU1AecLGjATrFGgiwJCqTDewAtdwQmfystoj0httuXD+b+i0ZF/4qwGgESLfsV/2iEt7xJ1a/ykQ5lEFHpmg9kpBU3qYyTZqHy7oNYRUgcKMeSmfSQ8cyP2KHZIuq8Z8N+YH1u8hQPWHU/wEXIvHJMZ4dztzmjkkMlr6Lepw4JevEy7lpsYzdWB1TfsyxfLUVasyDHUVgEyuATXNU0OJ5WoOWLGpng+w9aNylDJqz10nUe/K3IQpaplh2EtKcIAwoHq6PFglvXU0DyY4e1ONlVmJZJEHD4LdDzstwQlcob3nA3qzujbgSTou2LYKNRosa1Hj9cH2Mx5Zj7KpJDMbuDHzje0i7sAlo/AevE/fBzFe8qbD83HNZHHl/22aoo1pk5+239J4DK50NQI4QkcofVQO95KUoQBornswVlZrsSkLELszLnIeuLWNTho8obAGfeMYfvziJ2wMvhtkxLk4S38xhJgF8lG
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(3023799007)(38070700021)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W/1TAfXiBsG08WZHBzXkDFgVOSYuuDDNsfuocudF5gf3sd+SGnCGxfNi5SwL?=
 =?us-ascii?Q?+2raAXsp3vl3+CmlP7IzuvpSdlG/Ep0s+RXoSQGFpFzjc+3//lwA9SLKBzSh?=
 =?us-ascii?Q?6bBgud12WaqEJaRUI37o5da3xGk6BA2Om9jnztxzPuXwuvIdTxQxxhwBFk/P?=
 =?us-ascii?Q?kBOkanKqqbqWPzBzeH4OpFP94bn+UIQsrbJfAOrHuoX16MI+ln+iP9TaJkGQ?=
 =?us-ascii?Q?2vzYtdtMA3x0zRn7eNN8gTyt8Ta7ESl7tCxuV7ftdTwyuYTexIDsWn1ujaJI?=
 =?us-ascii?Q?KfQh31KwDJhGwT37X+awBQr2kL3QV197Eg2d+uR/qfM+7SlCBQXI0tcpjtjK?=
 =?us-ascii?Q?UTIWTWbHKfLl1jnp3KGR2OATMnK9fGvEvzxSeY0EXq2WoJalX4dyjOwHbR/C?=
 =?us-ascii?Q?pTl2+yfKIOWH9fyGr2CKVIJaH4TKIr6dCfjsOPMmmqdytUcXN3FjbYx95LQp?=
 =?us-ascii?Q?nL34IX3TJcZbBBSxC5Ka9SUJUBjxcsk7NVg1xoOOOarc5HkL4hVu+Hb8QdlO?=
 =?us-ascii?Q?+NgwrNO49Eh2cOtULmV5YC8P7NiydWVMmD3al97YZ5cX4eNjmsNUpsu/pmce?=
 =?us-ascii?Q?HhiAwqLwtszDnVnXXaxDOViATsN67NNUtH6ODE0lkp6dGfe25bm/0v4CwXiN?=
 =?us-ascii?Q?M5+TpR0avVhJLX1galok/nb1coAgwMsZITRDt1kmsDR90sUzP0uOWIMsOZOO?=
 =?us-ascii?Q?oILDiRda11ekHWaGL2ZWnahYkJISobpqngYMRQRCS6OurrpxieNHoNu0qvJK?=
 =?us-ascii?Q?ZcS7U0da9GWtk0umx+fBX8qBKf7fgoCvHlWk8WFfdjmbKkNcA4lSnEy4P+B4?=
 =?us-ascii?Q?R4qMzskaqgR9m9t9HZ8sMms7V76U8T6TOm0Ci0+lozgH2xdGJmEdw9X05XJ4?=
 =?us-ascii?Q?eBw0hl8YcIrCuBh0IaOoHr5I8C/IrX2A8JI5BKftgvPVdnXBulZzTuSF/z73?=
 =?us-ascii?Q?I0Vv1GXTiTuSsvZfzrMDJbBvFr9rONr4iubG1vJCfn4HbJmOjiP0pdWjNCYO?=
 =?us-ascii?Q?E+aCXHr3aBe7K2dWV2lzHorgxF0LC1z/XkFoEWJhzJbVlHfBnK609h9mNhW+?=
 =?us-ascii?Q?nGuoOYnJdiZhYYojmQwIo4EdMAAXTM7r0KpzA829TSJBT7S5K10O7g5Rc0U3?=
 =?us-ascii?Q?hv53fKA0jwGrtap/DmChj5WGQE1UgxVcXh2t4usQb/4tLHpjxHLeBhh6mlpE?=
 =?us-ascii?Q?2YT4IOkhQKMKojINQkmxtgiYgpzlwMpc/ipRe4MAm5LEhEWAU3f8WJmqrngP?=
 =?us-ascii?Q?CA2ULw4d6O+7tTDEAJYQltVZVf0QtZLpB3B0NhzMNcrW8EMkWUY3DHKBwbjA?=
 =?us-ascii?Q?GINFoi7JTOZjNhu+A7HtTGnt8BLj6Zp6HXvOA8cuoPfr/T55QLwz1cJLfPD2?=
 =?us-ascii?Q?CBr7lvyJOEUsT9PNqwjxOJ1bFVyUKwFz0tb6xE8P19SZk37KveoTvty6Fv6u?=
 =?us-ascii?Q?NyHWZeKP7i80IvYbc9vZ2Szm9vqvog2fSo/luKRiMu3xuP5+Pns62p0wubtU?=
 =?us-ascii?Q?nWUiTjjJwTcqBpPUxYrHZEBu5jwbTGgsFaKxANFBj1Hz1pMWGgTzPX8kTR+M?=
 =?us-ascii?Q?77WYufRQufXiI+19iLyH5eJlNdt3HLlcXw0FRWmf6F99VEf3NIg06M9Q2bna?=
 =?us-ascii?Q?brzTAB7iziJA1HPfYF/7uEHnE5KVexGtFl0xC5aZcy4NzVA2P6hVTaxbFmu2?=
 =?us-ascii?Q?R4ZhMlvzo9AsHFvH5T8vFCnjvq+4SWPrtAZ6p/KDv4DJdsNo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b0cfe2-7690-43b1-b2f5-08debfbcb152
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 09:03:48.2379 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GZBQsQzW/FrJfJH1wsEPGKNtqA193oVVzsv4B5kexAvZHwadDJ5vYTdcNUMu9Ht9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6845
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

Regards,
      Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jesse
> Zhang
> Sent: Monday, June 1, 2026 1:49 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>;
> Rastogi, Manu <Manu.Rastogi@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH v2 14/42] drm/amdgpu/gfx12: Refactor compute pipe reset a=
nd add
> HQD cleanup
>
> Refactor gfx_v12_0_reset_compute_pipe() to accept explicit me, pipe, and =
queue
> parameters instead of deriving them from the ring structure. This enables=
 the
> function to be used in generic pipe reset flows.
>
> Introduce gfx_v12_0_clear_hqds_on_mec_pipe() to properly clear
> CP_HQD_ACTIVE and CP_HQD_DEQUEUE_REQUEST for all queues on a given
> MEC pipe while the pipe reset is asserted, ensuring the HQDs are torn dow=
n
> correctly before deasserting reset.
>
> Switch the KCQ reset path to use the common MEC pipe reset helper
> amdgpu_gfx_mec_pipe_reset_run(), which coordinates the reset sequence inc=
luding
> KFD suspend/resume to avoid conflicts with user mode queues.
>
> v2: just update the sequence (Alex)
> v3: directly clear ACTIVE and DEQUEUE_REQUEST (Shaoyun Liu)
>
> Suggested-by:  Manu Rastogi <manu.rastogi@amd.com>
> Suggested-by:  Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 115 +++++++++++++++----------
>  1 file changed, 69 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 4be650ce1fba..f7783129ecc8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -5309,10 +5309,30 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring
> *ring,
>       return amdgpu_ring_reset_helper_end(ring, timedout_fence);  }
>
> -static int gfx_v12_0_reset_compute_pipe(struct amdgpu_ring *ring)
> +/*
> + * With MEC pipe reset asserted, clear CP_HQD_ACTIVE /
> +CP_HQD_DEQUEUE_REQUEST for
> + * every queue on (me, pipe). HQDs must be torn down while pipe reset
> +stays
> + * asserted; only then clear the pipe reset bit.
> + * Caller must hold adev->srbm_mutex.
> + */
> +static void gfx_v12_0_clear_hqds_on_mec_pipe(struct amdgpu_device *adev,=
 u32
> me,
> +                                          u32 pipe)
>  {
> -     struct amdgpu_device *adev =3D ring->adev;
> -     uint32_t reset_pipe =3D 0, clean_pipe =3D 0;
> +     unsigned int q;
> +     int j;
> +
> +     for (q =3D 0; q < adev->gfx.mec.num_queue_per_pipe; q++) {
> +             soc24_grbm_select(adev, me, pipe, q, 0);
> +             /* Start from a clean HQD dequeue state before forcing HQD =
inactive.
> */
> +             WREG32_SOC15(GC, 0, regCP_HQD_ACTIVE, 0);
> +             WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 0);
> +     }
> +}
> +
> +static int gfx_v12_0_reset_compute_pipe(struct amdgpu_device *adev,
> +                                        u32 me, u32 pipe, u32 queue)
> +{
> +     uint32_t reset_val, clean_val;
>       int r =3D 0;
>
>       if (!gfx_v12_pipe_reset_support(adev))
> @@ -5320,75 +5340,78 @@ static int gfx_v12_0_reset_compute_pipe(struct
> amdgpu_ring *ring)
>
>       gfx_v12_0_set_safe_mode(adev, 0);
>       mutex_lock(&adev->srbm_mutex);
> -     soc24_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
> -
> -     reset_pipe =3D RREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL);
> -     clean_pipe =3D reset_pipe;
> -
> +     soc24_grbm_select(adev, me, pipe, queue, 0);
>       if (adev->gfx.rs64_enable) {
> -             switch (ring->pipe) {
> +             reset_val =3D RREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL);
> +             clean_val =3D reset_val;
> +
> +             switch (pipe) {
>               case 0:
> -                     reset_pipe =3D REG_SET_FIELD(reset_pipe,
> CP_MEC_RS64_CNTL,
> -                                                MEC_PIPE0_RESET, 1);
> -                     clean_pipe =3D REG_SET_FIELD(clean_pipe,
> CP_MEC_RS64_CNTL,
> -                                                MEC_PIPE0_RESET, 0);
> +                     reset_val =3D REG_SET_FIELD(reset_val,
> CP_MEC_RS64_CNTL,
> +                                               MEC_PIPE0_RESET, 1);
> +                     clean_val =3D REG_SET_FIELD(clean_val,
> CP_MEC_RS64_CNTL,
> +                                               MEC_PIPE0_RESET, 0);
>                       break;
>               case 1:
> -                     reset_pipe =3D REG_SET_FIELD(reset_pipe,
> CP_MEC_RS64_CNTL,
> -                                                MEC_PIPE1_RESET, 1);
> -                     clean_pipe =3D REG_SET_FIELD(clean_pipe,
> CP_MEC_RS64_CNTL,
> -                                                MEC_PIPE1_RESET, 0);
> +                     reset_val =3D REG_SET_FIELD(reset_val,
> CP_MEC_RS64_CNTL,
> +                                               MEC_PIPE1_RESET, 1);
> +                     clean_val =3D REG_SET_FIELD(clean_val,
> CP_MEC_RS64_CNTL,
> +                                               MEC_PIPE1_RESET, 0);
>                       break;
>               case 2:
> -                     reset_pipe =3D REG_SET_FIELD(reset_pipe,
> CP_MEC_RS64_CNTL,
> -                                                MEC_PIPE2_RESET, 1);
> -                     clean_pipe =3D REG_SET_FIELD(clean_pipe,
> CP_MEC_RS64_CNTL,
> -                                                MEC_PIPE2_RESET, 0);
> +                     reset_val =3D REG_SET_FIELD(reset_val,
> CP_MEC_RS64_CNTL,
> +                                               MEC_PIPE2_RESET, 1);
> +                     clean_val =3D REG_SET_FIELD(clean_val,
> CP_MEC_RS64_CNTL,
> +                                               MEC_PIPE2_RESET, 0);
>                       break;
>               case 3:
> -                     reset_pipe =3D REG_SET_FIELD(reset_pipe,
> CP_MEC_RS64_CNTL,
> -                                                MEC_PIPE3_RESET, 1);
> -                     clean_pipe =3D REG_SET_FIELD(clean_pipe,
> CP_MEC_RS64_CNTL,
> -                                                MEC_PIPE3_RESET, 0);
> +                     reset_val =3D REG_SET_FIELD(reset_val,
> CP_MEC_RS64_CNTL,
> +                                               MEC_PIPE3_RESET, 1);
> +                     clean_val =3D REG_SET_FIELD(clean_val,
> CP_MEC_RS64_CNTL,
> +                                               MEC_PIPE3_RESET, 0);
>                       break;
>               default:
>                       break;
>               }
> -             WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, reset_pipe);
> -             WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, clean_pipe);
> +             WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, reset_val);
> +             gfx_v12_0_clear_hqds_on_mec_pipe(adev, me, pipe);

Same as patch#13 which requires removing the queue selecting, other than th=
at the patch is Reviewed-by: Prike Liang <Prike.Liang@amd.com>

> +             soc24_grbm_select(adev, me, pipe, queue, 0);
> +             WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, clean_val);
>               r =3D (RREG32_SOC15(GC, 0, regCP_MEC_RS64_INSTR_PNTR) <<
> 2) -
>                               RS64_FW_UC_START_ADDR_LO;
>       } else {
> -             switch (ring->pipe) {
> +             reset_val =3D RREG32_SOC15(GC, 0, regCP_MEC_CNTL);
> +             clean_val =3D reset_val;
> +
> +             switch (pipe) {
>               case 0:
> -                     reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_MEC_CNT=
L,
> -                                                        MEC_ME1_PIPE0_RE=
SET,
> 1);
> -                     clean_pipe =3D REG_SET_FIELD(clean_pipe, CP_MEC_CNT=
L,
> -                                                        MEC_ME1_PIPE0_RE=
SET,
> 0);
> +                     reset_val =3D REG_SET_FIELD(reset_val, CP_MEC_CNTL,
> +                                               MEC_ME1_PIPE0_RESET, 1);
> +                     clean_val =3D REG_SET_FIELD(clean_val, CP_MEC_CNTL,
> +                                               MEC_ME1_PIPE0_RESET, 0);
>                       break;
>               case 1:
> -                     reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_MEC_CNT=
L,
> -                                                        MEC_ME1_PIPE1_RE=
SET,
> 1);
> -                     clean_pipe =3D REG_SET_FIELD(clean_pipe, CP_MEC_CNT=
L,
> -                                                        MEC_ME1_PIPE1_RE=
SET,
> 0);
> +                     reset_val =3D REG_SET_FIELD(reset_val, CP_MEC_CNTL,
> +                                               MEC_ME1_PIPE1_RESET, 1);
> +                     clean_val =3D REG_SET_FIELD(clean_val, CP_MEC_CNTL,
> +                                               MEC_ME1_PIPE1_RESET, 0);
>                       break;
>               default:
> -             break;
> +                     break;
>               }
> -             WREG32_SOC15(GC, 0, regCP_MEC_CNTL, reset_pipe);
> -             WREG32_SOC15(GC, 0, regCP_MEC_CNTL, clean_pipe);
> -             /* Doesn't find the F32 MEC instruction pointer register, a=
nd suppose
> -              * the driver won't run into the F32 mode.
> -              */
> +
> +             WREG32_SOC15(GC, 0, regCP_MEC_CNTL, reset_val);
> +             gfx_v12_0_clear_hqds_on_mec_pipe(adev, me, pipe);
> +             soc24_grbm_select(adev, me, pipe, queue, 0);
> +             WREG32_SOC15(GC, 0, regCP_MEC_CNTL, clean_val);
>       }
>
>       soc24_grbm_select(adev, 0, 0, 0, 0);
>       mutex_unlock(&adev->srbm_mutex);
>       gfx_v12_0_unset_safe_mode(adev, 0);
>
> -     dev_info(adev->dev, "The ring %s pipe resets: %s\n", ring->name,
> -                     r =3D=3D 0 ? "successfully" : "failed");
> -     /* Need the ring test to verify the pipe reset result.*/
> +     dev_dbg(adev->dev, "MEC pipe me%u pipe%u queue%u resets to MEC FW
> start PC: %s\n",
> +             me, pipe, queue, r =3D=3D 0 ? "successfully" : "failed");
>       return 0;
>  }
>
> @@ -5405,7 +5428,7 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *=
ring,
>       r =3D amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, use_mmi=
o, 0);
>       if (r) {
>               dev_warn(adev->dev, "fail(%d) to reset kcq  and try pipe re=
set\n", r);
> -             r =3D gfx_v12_0_reset_compute_pipe(ring);
> +             r =3D gfx_v12_0_reset_compute_pipe(adev, ring->me, ring->pi=
pe,
> +ring->queue);
>               if (r)
>                       return r;
>       }
> --
> 2.49.0


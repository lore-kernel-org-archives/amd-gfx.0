Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E9A0CD6E56
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 09:00:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92A6C113012;
	Mon,  1 Jun 2026 09:00:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B6W/ByoK";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E7B1113012
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 09:00:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mL7xrMe1ZYNGXgH68BvvFz2dB8p8xC3M03jH9Q27J0JlNrkRHBHSxKifdXc137gPZMbXfAEqzX0ep1gG0KHDIdF4CR5SMagSjAqv0q/JiikoKq+7Q+DOCmBfc2AiyVjVhQp3LC/0bXtuZTc63sdMBYoy4wc64yqwxE9IJuLU7xF0YKt6ABQCpP57MJraP15P+5ejP1sLM1BHj4uVY/DBu5BrwiI1cFay7G3P8UfzRb6Hb/78NGwOa9Rautnk0EqON+VWUMYzkLsGO7VUFO51XM/gAAkMQJjMiELaxsCoWCK9XdZeJVze3NZdAjulsblDferM/vybr/dnxeUZqF91BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFpqM4mXwSVIE9uCIeZx/MdAHpsvcoJ+esLPxLkcW/8=;
 b=mQmqndsGsOa93WA7SsJ4QdECVlZCmChiFjfZ8lRHc/WzLeQkoapMUmTJ6l8mywgT2kCgfLQiUkjDJ+gg3vYVjrRb4L0b4bdMp5JkqsAjcRhzmnOP4Mo5GzhjY9k9GEFbfRYsBtvPmXgCzRjtKeqrx6yD6iHsdYoANT0J08Ka4mTB0yg28vIP0Zjn9YyE17hsno4FBz1Li8+78sAW4HBQ4fVTbdLr/fhhPoClFxhLbfsub5d0x4OmCg6JDZ+JMfy+SjPmGqzRTAr5hwCfKuq8WzPmUJqVFIsjG6vR4UTHCR87ti6n2wxzbf2c8ki9pnCh4difjWrIlE0+XrBiHYeBEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFpqM4mXwSVIE9uCIeZx/MdAHpsvcoJ+esLPxLkcW/8=;
 b=B6W/ByoKzVmMK60tRJN6rE8N5DVEnnSss07DWt1bZfxvxZll3Ru3UhkQB+dOvxZ7NwR/LFeacFrc04NnI/NHIvA3S8ifWYJGCFbimdUEHO8fTVEhj0kUJVrDF4qQCx5e6Lr+WAEaGrcwgrXkQiF9z9mFoKlmEL04YYgHCxJzI1Y=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 SA1PR12MB6845.namprd12.prod.outlook.com (2603:10b6:806:25c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 09:00:31 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%3]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 09:00:31 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Rastogi, Manu" <Manu.Rastogi@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH v2 13/42] drm/amdgpu/gfx11: Refactor compute pipe reset
 and add HQD cleanup
Thread-Topic: [PATCH v2 13/42] drm/amdgpu/gfx11: Refactor compute pipe reset
 and add HQD cleanup
Thread-Index: AQHc8YrZxQnDgchWik2GYPkH4rj3ybYpYnQg
Date: Mon, 1 Jun 2026 09:00:31 +0000
Message-ID: <DS7PR12MB60057908856F411131548995FB152@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
 <20260601055034.3700921-13-Jesse.Zhang@amd.com>
In-Reply-To: <20260601055034.3700921-13-Jesse.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-01T08:43:50.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|SA1PR12MB6845:EE_
x-ms-office365-filtering-correlation-id: ca99568d-3988-4081-9d91-08debfbc3be9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|3023799007|38070700021|56012099006|4143699003|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: aZJCNmKe5NFV0jYdD9gC7GzXj0qrYODhkBQ2xen4l/CsOyseqvV5ugOEoUv3w6bEJH+/gmOztgvDdvo0/LLS+Gk+iMimtWEYRbMY66GhpR38oEHVdQmU1+ErhglmBEMndNxXdTa6buyBzHJdddmKnHsLnACkJeejuY0qlq1Yh0N7by8Wz8lmhexBSs5Cuz5ldBS9GXL0Wd28zBXyEeL096XJ1SnhCYRYyqZ1V5+bdEsq8wseT6W/VxwewqKjW8N8s2yD5ymbJ2vAUqICnO4TazSPLJ4Jwjbz9cJ13BzH3cWHRh+0aOUUQSU2Gma0+TRPfxBCoMBXYj484eAJoVIsdWZlC9vPWb6SNocvpyNLKlMmtlE8rqizTY675Nr6Wxg7yTGLYKZQUmd7Rqs7VxKqI7KNNjNZaxCF3DF/DG6+yjeryKmqiBv1ExKReQSdYgIZvrIXu3vep3leGrLRB4H5FH2/cJH5XO4g1TkNyXkPXLTT+KCC5is5Jun3wuhfAWeYrcwGBOqMAdEGoF45ixlSNQrp1NTQh+cALtF/WEz00c2CWhRs139phNJXc4KE2bwJeHvpuUlKB9h54xp27xRwsqQlM5F3FLvwJrwZ7+ehEX9/N1fkMfABYgAs3PpafeEfYD69A6o9hYIhhzzf5XrqAWYJdT5rVxZg3K6awqqEjEOKDJ3J7NYLtckBELOpOJ/9Uv/Xya/ufKoL3W2SqOvBNtCcJsBCnmmjLLOLeDB79G9h00PACmq1/oR64vr40Z0Z
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(3023799007)(38070700021)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BFd9iJgjQsM8uOVT1LQVrOtI2uH+UqGYJnG+CrekELjqGH8rAO+c29KGXagz?=
 =?us-ascii?Q?cJ7mD8PfzJaPUXPJH6Cdo+OtfwBb6SNxDCDDlVUZ7CwqprNZ4z7jTTCpbwse?=
 =?us-ascii?Q?b5Gme94R5OV1lSeff8c2+6IcsvntHn8NU9GaxLOWOoMbROkA0g2dmwGayz/c?=
 =?us-ascii?Q?sQKXC4AdmnZdcBa9eSKRUyTj6TwrFHsgIv+aLEiXvi+28ANU0rBsYyqZoPCW?=
 =?us-ascii?Q?L27azAQuEu3yZoOscsQGzl/T/slur4HEp4ecZZqRg+hR7dqz+069PoeZKfr+?=
 =?us-ascii?Q?JDbRWCdJ07aOqawo4bKKu9tSf7//kTWXays56vQsGXfBUem+ZteRRkQ4ZqP5?=
 =?us-ascii?Q?SGXwEmFZglQl1mm61tBC149GNLbu8s1MeANsGg7cw40CBR6wTPPO277fJYe/?=
 =?us-ascii?Q?tj+FXUrAEDjyu/6a0BLuhkX6VXKZLzQJiPdN4HHUGu6jIT3gcWhf8vRe8sx/?=
 =?us-ascii?Q?PjmsInuwlp3xwL9kkmcwMiBTQkQubJgVp/l/QamuME78kbNM4BBzQ+dLljQQ?=
 =?us-ascii?Q?KWWZgL/BEQk/Og0ya2fhJSvjLtvlTttj2zaWUGKpfnkiXJrH2RCBt1xBXYIv?=
 =?us-ascii?Q?zScurWt8jXSSbLYKLlC08tMzdUAapVqVKZUr91bwYLdWEsc/0R6vYcwpjMzE?=
 =?us-ascii?Q?6cHTyxv/leU+Xr4Tap0jGJqS/2c2o7TyzYxw4cdITNEA2qBDNQhyumXSgKOc?=
 =?us-ascii?Q?U0lEdJ3KdKD7aS4wpvINP/Hao2igAflf1Z/lKcjjLQ9HWzmuR3YHQF0x99wh?=
 =?us-ascii?Q?e980IPJRIOsGGBl3XhGWgfcA5E6vZ0Ey0w7neFEj8/gDEzxsBRhfSAYbvsuw?=
 =?us-ascii?Q?tYdEiLsipdMUZirfq6sAEcWdRrxV3MEWe+O/Origgfn1xyPjVXjFizD5Ia8L?=
 =?us-ascii?Q?Tmj8vqBAQkgMnnrvSuOcz2p+S5ELIN1+JJfmVaU+IXVxvKBAfxvR1h4cF85K?=
 =?us-ascii?Q?1CEwWgTRM7RDBMGRn5fvUCqMK3GB9B7XJbnWV8XWgAO3sf6zalxsnEiElA4r?=
 =?us-ascii?Q?xURJyH0x8DT9T9xj2org5I+KYHR9bK2BJLfJiTv9AQl+SAR2edwawOlAcU/N?=
 =?us-ascii?Q?cJkqbROK2fdHDCcypMnD5uGWF/vRo62ALOraUELcSyZl4uwVo5NZ/nkZhdA4?=
 =?us-ascii?Q?Qwy1nwmD7VyE2CFgGVQPsKqmrREkh223im2wXv2ehOJsAYEz2K/XvGjB3oC9?=
 =?us-ascii?Q?KbJ3TNfWTICnILDFa8hgpA+8pA4G8CPPMtqoTuda1dt/RYzxYGDwPHfNy3HV?=
 =?us-ascii?Q?bMMDJD0BG1TgbE/XXOvGzA2FaChwNWY2H73xNK95ovE6jAH7XucpunulRBsT?=
 =?us-ascii?Q?HZYTu+wPfjuU0N+1PqTESMKSYj7/vbku5qy/6Fg2ma15lyhWiiv/1RRvwBCS?=
 =?us-ascii?Q?yauFxe4IIE+YjnipSMba9PKQWlZHWcsrlGXtrtVb9yZGl6eJRpRrF9g8kOl9?=
 =?us-ascii?Q?5OjbuP+HrcKhm2252InP6yzWWOitg2cm6x7YUtSBXxTyYWCEAhU5rfxHB5nq?=
 =?us-ascii?Q?VPxUOELrB23BOAD0g9o0711qsiC8lfsJQwwJkr+YbnEJrmLI75w3zm7RFVYk?=
 =?us-ascii?Q?b7IKqtYVs1tjsI5XfsWWKTvhW138hjfPB6m6MQCyTdwQoQirx8XbOSib+GxA?=
 =?us-ascii?Q?BhN4TKluAVM3l27hTNM0CHHPznm1mFd3ebLlrXTIey5knMaiSnoMrc6MufiX?=
 =?us-ascii?Q?q7ikIqqLaM9hXCgem8QzL0+BIcYhFw77Vf9qBBE3N6slmQbf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca99568d-3988-4081-9d91-08debfbc3be9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 09:00:31.2871 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tzYxNkB0JXMILVEoAjR+6WnfYadTxloeYlqee1YiTt+AS9t1W6ka/iEcwvGG8uMr
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
> Subject: [PATCH v2 13/42] drm/amdgpu/gfx11: Refactor compute pipe reset a=
nd add
> HQD cleanup
>
> Refactor gfx_v11_0_reset_compute_pipe() to accept explicit me, pipe, and =
queue
> parameters instead of deriving them from the ring structure. This enables=
 the
> function to be used in generic pipe reset flows.
>
> Introduce gfx_v11_0_clear_hqds_on_mec_pipe() to properly clear
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
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 166 +++++++++++++++----------
>  1 file changed, 100 insertions(+), 66 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index dd4f33d2ce45..1995de5e6999 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6874,11 +6874,39 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring
> *ring,
>       return amdgpu_ring_reset_helper_end(ring, timedout_fence);  }
>
> -static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
> +/*
> + * With MEC pipe reset asserted, clear CP_HQD_ACTIVE /
> +CP_HQD_DEQUEUE_REQUEST for
> + * every queue on (me, pipe). HQDs must be torn down while pipe reset
> +stays
> + * asserted; only then clear the pipe reset bit.
> + * Caller must hold adev->srbm_mutex.
> + */
> +static void gfx_v11_0_clear_hqds_on_mec_pipe(struct amdgpu_device *adev,=
 u32
> me,
> +                                          u32 pipe)
>  {
> +     unsigned int q;
> +     int j;
>
> -     struct amdgpu_device *adev =3D ring->adev;
> -     uint32_t reset_pipe =3D 0, clean_pipe =3D 0;
> +     for (q =3D 0; q < adev->gfx.mec.num_queue_per_pipe; q++) {
> +             soc21_grbm_select(adev, me, pipe, q, 0);
> +             /* Start from a clean HQD dequeue state before forcing HQD =
inactive.
> */
> +             WREG32_SOC15(GC, 0, regCP_HQD_ACTIVE, 0);
> +             if (RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1) {
> +                     WREG32_SOC15(GC, 0,
> regCP_HQD_DEQUEUE_REQUEST, 1);
> +                     for (j =3D 0; j < adev->usec_timeout; j++) {
> +                             if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE)
> & 1))
> +                                     break;
> +                             udelay(1);
> +                     }
> +             }
> +
> +             WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 0);
> +     }
> +}
> +
> +static int gfx_v11_0_reset_compute_pipe(struct amdgpu_device *adev,
> +                                        u32 me, u32 pipe, u32 queue)
> +{
> +     uint32_t reset_val, clean_val;
>       int r;
>
>       if (!gfx_v11_pipe_reset_support(adev))
> @@ -6886,109 +6914,115 @@ static int gfx_v11_0_reset_compute_pipe(struct
> amdgpu_ring *ring)
>
>       gfx_v11_0_set_safe_mode(adev, 0);
>       mutex_lock(&adev->srbm_mutex);
> -     soc21_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
> -
> -     reset_pipe =3D RREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL);
> -     clean_pipe =3D reset_pipe;
> +     soc21_grbm_select(adev, me, pipe, queue, 0);

>       if (adev->gfx.rs64_enable) {
> +             reset_val =3D RREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL);
> +             clean_val =3D reset_val;
>
> -             switch (ring->pipe) {
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
> +             gfx_v11_0_clear_hqds_on_mec_pipe(adev, me, pipe);
> +             soc21_grbm_select(adev, me, pipe, queue, 0);


The regCP_MEC_RS64_CNTL seems to be a global register rather than per-queue=
 register, so here we can remove the
queue select both here and some other similar places. Meanwhile, gfx_v11_0_=
clear_hqds_on_mec_pipe() is necessary to select the
queue first, but need to unselect the queue at the end of queue setting.

With that fix, the patch is Reviewed-by: Prike Liang <Prike.Liang@amd.com>


> +             WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, clean_val);
>               r =3D (RREG32_SOC15(GC, 0, regCP_MEC_RS64_INSTR_PNTR) <<
> 2) -
>                                       RS64_FW_UC_START_ADDR_LO;
>       } else {
> -             if (ring->me =3D=3D 1) {
> -                     switch (ring->pipe) {
> +             reset_val =3D RREG32_SOC15(GC, 0, regCP_MEC_CNTL);
> +             clean_val =3D reset_val;
> +
> +             if (me =3D=3D 1) {
> +                     switch (pipe) {
>                       case 0:
> -                             reset_pipe =3D REG_SET_FIELD(reset_pipe,
> CP_MEC_CNTL,
> -                                                        MEC_ME1_PIPE0_RE=
SET,
> 1);
> -                             clean_pipe =3D REG_SET_FIELD(clean_pipe,
> CP_MEC_CNTL,
> -                                                        MEC_ME1_PIPE0_RE=
SET,
> 0);
> +                             reset_val =3D REG_SET_FIELD(reset_val,
> CP_MEC_CNTL,
> +                                                       MEC_ME1_PIPE0_RES=
ET,
> 1);
> +                             clean_val =3D REG_SET_FIELD(clean_val,
> CP_MEC_CNTL,
> +                                                       MEC_ME1_PIPE0_RES=
ET,
> 0);
>                               break;
>                       case 1:
> -                             reset_pipe =3D REG_SET_FIELD(reset_pipe,
> CP_MEC_CNTL,
> -                                                        MEC_ME1_PIPE1_RE=
SET,
> 1);
> -                             clean_pipe =3D REG_SET_FIELD(clean_pipe,
> CP_MEC_CNTL,
> -                                                        MEC_ME1_PIPE1_RE=
SET,
> 0);
> +                             reset_val =3D REG_SET_FIELD(reset_val,
> CP_MEC_CNTL,
> +                                                       MEC_ME1_PIPE1_RES=
ET,
> 1);
> +                             clean_val =3D REG_SET_FIELD(clean_val,
> CP_MEC_CNTL,
> +                                                       MEC_ME1_PIPE1_RES=
ET,
> 0);
>                               break;
>                       case 2:
> -                             reset_pipe =3D REG_SET_FIELD(reset_pipe,
> CP_MEC_CNTL,
> -                                                        MEC_ME1_PIPE2_RE=
SET,
> 1);
> -                             clean_pipe =3D REG_SET_FIELD(clean_pipe,
> CP_MEC_CNTL,
> -                                                        MEC_ME1_PIPE2_RE=
SET,
> 0);
> +                             reset_val =3D REG_SET_FIELD(reset_val,
> CP_MEC_CNTL,
> +                                                       MEC_ME1_PIPE2_RES=
ET,
> 1);
> +                             clean_val =3D REG_SET_FIELD(clean_val,
> CP_MEC_CNTL,
> +                                                       MEC_ME1_PIPE2_RES=
ET,
> 0);
>                               break;
>                       case 3:
> -                             reset_pipe =3D REG_SET_FIELD(reset_pipe,
> CP_MEC_CNTL,
> -                                                        MEC_ME1_PIPE3_RE=
SET,
> 1);
> -                             clean_pipe =3D REG_SET_FIELD(clean_pipe,
> CP_MEC_CNTL,
> -                                                        MEC_ME1_PIPE3_RE=
SET,
> 0);
> +                             reset_val =3D REG_SET_FIELD(reset_val,
> CP_MEC_CNTL,
> +                                                       MEC_ME1_PIPE3_RES=
ET,
> 1);
> +                             clean_val =3D REG_SET_FIELD(clean_val,
> CP_MEC_CNTL,
> +                                                       MEC_ME1_PIPE3_RES=
ET,
> 0);
>                               break;
>                       default:
>                               break;
>                       }
>                       /* mec1 fw pc: CP_MEC1_INSTR_PNTR */
>               } else {
> -                     switch (ring->pipe) {
> +                     switch (pipe) {
>                       case 0:
> -                             reset_pipe =3D REG_SET_FIELD(reset_pipe,
> CP_MEC_CNTL,
> -                                                        MEC_ME2_PIPE0_RE=
SET,
> 1);
> -                             clean_pipe =3D REG_SET_FIELD(clean_pipe,
> CP_MEC_CNTL,
> -                                                        MEC_ME2_PIPE0_RE=
SET,
> 0);
> +                             reset_val =3D REG_SET_FIELD(reset_val,
> CP_MEC_CNTL,
> +                                                       MEC_ME2_PIPE0_RES=
ET,
> 1);
> +                             clean_val =3D REG_SET_FIELD(clean_val,
> CP_MEC_CNTL,
> +                                                       MEC_ME2_PIPE0_RES=
ET,
> 0);
>                               break;
>                       case 1:
> -                             reset_pipe =3D REG_SET_FIELD(reset_pipe,
> CP_MEC_CNTL,
> -                                                        MEC_ME2_PIPE1_RE=
SET,
> 1);
> -                             clean_pipe =3D REG_SET_FIELD(clean_pipe,
> CP_MEC_CNTL,
> -                                                        MEC_ME2_PIPE1_RE=
SET,
> 0);
> +                             reset_val =3D REG_SET_FIELD(reset_val,
> CP_MEC_CNTL,
> +                                                       MEC_ME2_PIPE1_RES=
ET,
> 1);
> +                             clean_val =3D REG_SET_FIELD(clean_val,
> CP_MEC_CNTL,
> +                                                       MEC_ME2_PIPE1_RES=
ET,
> 0);
>                               break;
>                       case 2:
> -                             reset_pipe =3D REG_SET_FIELD(reset_pipe,
> CP_MEC_CNTL,
> -                                                        MEC_ME2_PIPE2_RE=
SET,
> 1);
> -                             clean_pipe =3D REG_SET_FIELD(clean_pipe,
> CP_MEC_CNTL,
> -                                                        MEC_ME2_PIPE2_RE=
SET,
> 0);
> +                             reset_val =3D REG_SET_FIELD(reset_val,
> CP_MEC_CNTL,
> +                                                       MEC_ME2_PIPE2_RES=
ET,
> 1);
> +                             clean_val =3D REG_SET_FIELD(clean_val,
> CP_MEC_CNTL,
> +                                                       MEC_ME2_PIPE2_RES=
ET,
> 0);
>                               break;
>                       case 3:
> -                             reset_pipe =3D REG_SET_FIELD(reset_pipe,
> CP_MEC_CNTL,
> -                                                        MEC_ME2_PIPE3_RE=
SET,
> 1);
> -                             clean_pipe =3D REG_SET_FIELD(clean_pipe,
> CP_MEC_CNTL,
> -                                                        MEC_ME2_PIPE3_RE=
SET,
> 0);
> +                             reset_val =3D REG_SET_FIELD(reset_val,
> CP_MEC_CNTL,
> +                                                       MEC_ME2_PIPE3_RES=
ET,
> 1);
> +                             clean_val =3D REG_SET_FIELD(clean_val,
> CP_MEC_CNTL,
> +                                                       MEC_ME2_PIPE3_RES=
ET,
> 0);
>                               break;
>                       default:
>                               break;
>                       }
>                       /* mec2 fw pc: CP:CP_MEC2_INSTR_PNTR */
>               }
> -             WREG32_SOC15(GC, 0, regCP_MEC_CNTL, reset_pipe);
> -             WREG32_SOC15(GC, 0, regCP_MEC_CNTL, clean_pipe);
> +             WREG32_SOC15(GC, 0, regCP_MEC_CNTL, reset_val);
> +             gfx_v11_0_clear_hqds_on_mec_pipe(adev, me, pipe);
> +             soc21_grbm_select(adev, me, pipe, queue, 0);
> +             WREG32_SOC15(GC, 0, regCP_MEC_CNTL, clean_val);
>               r =3D RREG32(SOC15_REG_OFFSET(GC, 0,
> regCP_MEC1_INSTR_PNTR));
>       }
>
> @@ -6996,8 +7030,8 @@ static int gfx_v11_0_reset_compute_pipe(struct
> amdgpu_ring *ring)
>       mutex_unlock(&adev->srbm_mutex);
>       gfx_v11_0_unset_safe_mode(adev, 0);
>
> -     dev_info(adev->dev, "The ring %s pipe resets to MEC FW start PC: %s=
\n",
> ring->name,
> -                     r =3D=3D 0 ? "successfully" : "failed");
> +     dev_dbg(adev->dev, "MEC pipe me%u pipe%u queue%u resets to MEC FW
> start PC: %s\n",
> +             me, pipe, queue, r =3D=3D 0 ? "successfully" : "failed");
>       /*FIXME:Sometimes driver can't cache the MEC firmware start PC corr=
ectly,
> so the pipe
>        * reset status relies on the compute ring test result.
>        */
> @@ -7017,7 +7051,7 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *=
ring,
>       r =3D amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, use_mmi=
o, 0);
>       if (r) {
>               dev_warn(adev->dev, "fail(%d) to reset kcq and try pipe res=
et\n", r);
> -             r =3D gfx_v11_0_reset_compute_pipe(ring);
> +             r =3D gfx_v11_0_reset_compute_pipe(adev, ring->me, ring->pi=
pe,
> +ring->queue);
>               if (r)
>                       return r;
>       }
> --
> 2.49.0


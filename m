Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10DB4C7115A
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Jun 2025 13:25:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D33B10EA5F;
	Thu, 19 Jun 2025 13:25:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sScG2ske";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F08CA10EA63
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Jun 2025 13:25:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mWjHInqYse4olyy0qHnqF5GuhbbGLJ/cYIYKNqVwILrbBRHQwQGCrlG6EaTThtsGXlRxY9cTqJJIAA22Qe80RTz8h+68zuUF5qgVrW2KPsnpBsP/HBVTL7SOUfULr6H0XsGHRXDY0URZUfjXTYOgxdqED/vWRDuZzvkZI/ADs8ncF87qYvIKwV9WR1mKOCaOeskUY0Gh1wxiNXuk5V3/P+Vx8D0lPvu0U87ItsiSRwbqUupuNR1F2nTUZ9kVw9wth3KoZan44FBnGZovvVWL1qMeahQ632Ez6DvbQ/cgpb4qbB9LcgtWiIz4dRhT9rqYsU/K1419hOepYyL2HsZf1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGU+GJ66/mBT/EfPBOSkQ0xqJo1NQb/5zc/jtfpcvIk=;
 b=SNUXr40BaFh71iV1bW0GnF+28hwuEl9lKKYwpEgLOlAOTzuO39aHEjzP5zzQDuFA7A0sD/O9y/9xARllLBH8htUtKC+kmjaiuMVyXXM0twfHYk8Ne/jCdoZdy0MvKSUrOLiynuBVbVsIM21P+lqAN6Fu1UG+gaPuftXNFstQSxrYFir/MYlrjzSVTqZ3U4yhXKZ3ggX3lpUpRAc0ZMShfjEnWzZfBC8Dqkc7NFnYtTG0ohh1eyfa6cfPDjGz98HQka0AuaN4vbm8l15YmBPeMp6ZxCr/WgX5o2r3pHQRMZBRS3CM84HB2/O5StXLClVhTiS8qjV1e5zOozlt+zeJQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGU+GJ66/mBT/EfPBOSkQ0xqJo1NQb/5zc/jtfpcvIk=;
 b=sScG2skebDmqEo82L156WQ6V54t15J/Oe9ZYNpr+QW++4HTo4RS6O9o/C36UJTb/dOryFMnpArbIMPxYTRn87knvL6UMwSZTUozRC4n7b4yNnBIXnWGUYKkOapdGwWW1DLDoJL5KAqGV4LuPfLdyapurCoqIJ6hSkXD/ufJxnjw=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 DS4PR12MB9682.namprd12.prod.outlook.com (2603:10b6:8:27f::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.22; Thu, 19 Jun 2025 13:25:48 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 13:25:47 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH v2 09/11] drm/amdgpu: validate userq activity status for
 GEM_VA unmap
Thread-Topic: [PATCH v2 09/11] drm/amdgpu: validate userq activity status for
 GEM_VA unmap
Thread-Index: AQHb314vyy8gIHoeS0eSK8mKGJWRfLQKdacQ
Date: Thu, 19 Jun 2025 13:25:47 +0000
Message-ID: <DS7PR12MB6005063F191456B23928A1ABFB7DA@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250617080151.1093481-1-Prike.Liang@amd.com>
 <20250617080151.1093481-9-Prike.Liang@amd.com>
In-Reply-To: <20250617080151.1093481-9-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Alexander.Deucher@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-06-19T13:01:01.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|DS4PR12MB9682:EE_
x-ms-office365-filtering-correlation-id: d3052a60-d066-4de7-cd30-08ddaf34cd7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?jpa+MH2sg4eU5ncVFIW6PwAX42nNT+G8wNp+KPSFyUVGcfwAhV/R3mToZraW?=
 =?us-ascii?Q?BOXoJfkMgOtRrCiDBi+Ng7mV8jHK24+abDVgAP/42KMLufNzSqRM0NQa7/OF?=
 =?us-ascii?Q?Z5SYT62uRZMaT5QARzmAOkaknukSSlDkGnm1X94rk+OSLYc6SwIAKCzKpJrk?=
 =?us-ascii?Q?r8m+uh2eJipbB3odovoYn58owzyUZyj9+TBkWl9yYfFSDFHYUqjwWVfLtfh0?=
 =?us-ascii?Q?0yF57kMWs8NmktWKLAjLIEeVSAmH7WPIxqOuHdUGsqW9P380AKELaihEQRyC?=
 =?us-ascii?Q?/zF8pv7RDlUiXX2UqzCQXBzbiEXIP2Q3HxmkmJ5DKGxtfwgEHZGC4oBLpygL?=
 =?us-ascii?Q?TUXxDxlYY81pztJgDNwT+gP40zKkBAXDIZWkGkapy60DMl1locpA6C0dcxDo?=
 =?us-ascii?Q?35pHmhBAH7e+zJ3ES0lzPxqpsVAHYZR/2duoaavp6ePIYPYKK/UlQ5egJAVO?=
 =?us-ascii?Q?gnojsF33YzokSEaTCK+x+Lw+6tcHUztkC/yKMerax+HKAcnBteWRdR9diVs8?=
 =?us-ascii?Q?RpFbjPHqH0n3klgXIn5M/silxvnAX9aT1512iQI/T0VEzcCLv1eFCg2IXmBI?=
 =?us-ascii?Q?XgQ/MAH7FF0so3sNHOiSuXE4VZFea2HvPAtlQbxsmnvr5FJyANK8/yb5ATG3?=
 =?us-ascii?Q?795WzOfKLjaeAJslQjUf5ZqZKw2gZg5RGONZ5WndtL4Pa+XniVKIlqqoAkWd?=
 =?us-ascii?Q?+PsXJNNhr8d0S840EaW34BYi9IKWjJp0cG+W5d/isX7jOyxvqA6/kk+t4Qcr?=
 =?us-ascii?Q?3j84FTV0i4krPARcpmuUAUJ24fBLhr2becikWwF7qjruOLlXHsCEsU8+SBY6?=
 =?us-ascii?Q?kTVIa8QLhiEKig4u1oY5aNfG5tVsFQsehY974AomJWUUflmrFNlaQNw2jLDS?=
 =?us-ascii?Q?JgXmCblC+95ur43h3FohxK1TQZmLPyi4ZeM5pGvuyqfmkcME4To9cBo6Jm0N?=
 =?us-ascii?Q?fUBf5lU1/8KHO7I4Nj1y7wooJ4ztp8RYMOIbrY/NnTclvbna7xRnLRtO9x53?=
 =?us-ascii?Q?tfVIJjmxzBvODyNV6wDAd5poIvGE9DXpsHE9oq0YoYx8Bc9teRgt3ggRp4xb?=
 =?us-ascii?Q?YhnpGNn/Ho8RWHbUkGTDQLOjR5JYVBuK0bekCkKINhPHMAgeuAwjFVD4M5Ll?=
 =?us-ascii?Q?BkdqiNJYs3AxzRBs/a+iQ+1e7rN5lFqdhGy4h19Gv4UxL0MJZ3pmNdYk+rs1?=
 =?us-ascii?Q?BSYu5yKCQ8XL2krsxgGd8WvQKsz2WxDOTaraa6+yR9X1F6HQJQsK5c44NbH6?=
 =?us-ascii?Q?sBGT5CQX33vifZoaqu+aG09HAS0dMKRTYBJcvajEG//swDqaPrAEIqnV+jv9?=
 =?us-ascii?Q?6Pbw1nQuimh/oMdZ77UzhD3ndLqp6WoWTqjQmwdZdF3NrvCShctaLDxghauz?=
 =?us-ascii?Q?n1nVHi6bLm5dbOkURtein1gjULvcmKn4vBd/vVRnVPkV5cNmcsy3/N65S2gP?=
 =?us-ascii?Q?cbGR7W5QM5aXuIZ1MdkQ1avfuR2J/FOvR8V1LLQ/LmnwfakKMtvsHE2MugpR?=
 =?us-ascii?Q?iCuBn77/+OeSGTw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/SxUABjBQesLE4E1sxOFGOk6YHEm7c22jbeXCcUc+AiumgtoR0sIY1wXnmZq?=
 =?us-ascii?Q?JHiJgRrhaUzlRUnCKzYUTL1txlUgz+qv7kXhdayrBy3ka2m17HOQH5AEtnOH?=
 =?us-ascii?Q?6tNwzb+TMQrnJ5Q8uGK2PUMENZ5zm815N6P2jducQCok32yZiBFetq3ZSbqX?=
 =?us-ascii?Q?xW3Lxwoc1DEYxpkl39dsyMTTpUvG+sH3ZOKifspIxFu8YXlVasV+tzgYkUs/?=
 =?us-ascii?Q?1lH+yIrbnWgAjX6jRQ0/Hcr85IV8g5P/6PSnOx+2D4d3TWj2icaTDeRcsJvs?=
 =?us-ascii?Q?AnfbRILEvlG3t1tiNslR7Dem1AxeoFaQizOXdWOdJ5RQHhrv7sILL5wQ4dBa?=
 =?us-ascii?Q?TJEi1FPndunkyCdyHooJA9GzeiJyaO5TJPvMG14/I+FT3Wqs17CfASkOOA5d?=
 =?us-ascii?Q?AwDPKqyKZV5nVO4iN3XbG+rD4lHZY9bEyGbtXcYkPPmsRHMZJatK22TnhdH9?=
 =?us-ascii?Q?QjmFUnM69WkUqHPM9HqujDr5gGq/gq0Dj/IDZNi6kk9u41VkQ3IMzCqtyCoP?=
 =?us-ascii?Q?35R2axEYb1BALB8f1OAA+zha6Bsw2x8tLk/dT6rdDK7v8geyPdEefRJe8eZg?=
 =?us-ascii?Q?4tDgElQ3uyPL4hHp96u6HSD8tstdyav0YnLQ0PtLPI2vcNtnSzwyDaXoC92S?=
 =?us-ascii?Q?bu+2adMY4WJElf5xZysjVrr3DMSquzSankVLGlzWOAbbC3UhKvvznwxnbPH5?=
 =?us-ascii?Q?u+mAJmsMhi9OsGKnIHtmIT41ZD7bivRORQQ1WaAYEQkMKZ2IaMWQQ/5fvBue?=
 =?us-ascii?Q?v467kWR25mQExkGO1TECdhQxcTzmVv20M7/7nI37ZdH6jfUefEftAMdjtXwr?=
 =?us-ascii?Q?nPVxmTgotv4EVxK5jF4Z5wXdpkzFFbN6I1AmW4Yea9YF8bnhUB4PkxajctR1?=
 =?us-ascii?Q?Jclp7iDX7C85NvQnJID6+celC+rtWE0rpK9Xt6gNyQGG4fQxSc+22GNY6+8b?=
 =?us-ascii?Q?dRz0NY8Rv03z6mewVmgYEAoHzjQJtJZJ7pxLZoP2puluuQ1k6I3RaPoroyu6?=
 =?us-ascii?Q?t/5vqz0zSNkOo6WrZ9Mlhy4BeNGCiMX8+gMkFxnF4Ca3p4tJnl5NWE50zzHz?=
 =?us-ascii?Q?XTd7ZORUqp7PCNenKtw3DWZjjUKxBzFl9LFQ713apf0lvPr8mdaNV1WfU8NU?=
 =?us-ascii?Q?1dWSCnAThZNS7W5GJL+BDjK8TDvTw+zmv1PYKQM44kS3Zilq4Vwv6iCsvJvx?=
 =?us-ascii?Q?Uwa+aGNMFb/q//PC7qtNC6uvJdLDQfaTHq4rnHRDCmkKtDf4vPp/Nrp2JWHF?=
 =?us-ascii?Q?945A/7jX0ZXLbuqRx9A7vt2QIJ+7F+tST6mk2obUdR5Q6itt2d3BKeOj67jy?=
 =?us-ascii?Q?ohJQO76EfD8EekbbB84Wxq9/exaRTw94/3iJgME2s4iRr2zM+WwKVRAShFBh?=
 =?us-ascii?Q?JxvGYL7N+S7qK6lEQzNfCyCT4Wqh5ErWGI3A2I/M57dMQAxm/TWLSulpNAhQ?=
 =?us-ascii?Q?YbwOTqqiIrjM7A3l0/ZrwVJ43Eemuq7RkIf8tltBZnWsK1+LszVDxVvuxMEn?=
 =?us-ascii?Q?jxab2NIhvIe3zmLgk+XZs1cX4cTv5Wjj/4ZtgD9prnQHBemQTROrBD+Q6hk7?=
 =?us-ascii?Q?/LJShMKYBNdTs2Ex6no=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3052a60-d066-4de7-cd30-08ddaf34cd7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2025 13:25:47.6664 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lnYPoGP84kHIKsYhIXiyxHM2W2LQULzAg17BVwTnqEMyWBDoXaliuIamu2m3BTbC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9682
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

The patch#7 ~patch9 are drafting for validating the unmapped metadata wheth=
er it is idled. If the user force unmaps a busy userq,
then a warning message will be reported here.
Hi, @Deucher, Alexander Could you please help review the patches 7-9 to see=
 whether they can fulfill the userq VA unmap validation design?

Regards,
      Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Prike =
Liang
> Sent: Tuesday, June 17, 2025 4:02 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> Subject: [PATCH v2 09/11] drm/amdgpu: validate userq activity status for =
GEM_VA
> unmap
>
> The userq VA unmap requires validating queue status before unamapping it,=
 if user
> tries to unmap a busy userq by GEM VA IOCTL then the driver should report=
 an error
> for this illegal usage.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 16 +++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  8 ++++++++
>  2 files changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index f04b51ded06f..be3220a973ae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -225,7 +225,7 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr
> *uq_mgr,
>       return r;
>  }
>
> -static void
> +static int
>  amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
>                                struct amdgpu_usermode_queue *queue)  { @@=
 -
> 234,10 +234,14 @@ amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mg=
r
> *uq_mgr,
>
>       if (f && !dma_fence_is_signaled(f)) {
>               ret =3D dma_fence_wait_timeout(f, true, msecs_to_jiffies(10=
0));
> -             if (ret <=3D 0)
> +             if (ret <=3D 0) {
>                       drm_file_err(uq_mgr->file, "Timed out waiting for
> fence=3D%llu:%llu\n",
>                                    f->context, f->seqno);
> +                     return -ETIMEDOUT;
> +             }
>       }
> +
> +     return 0;
>  }
>
>  static void
> @@ -453,7 +457,13 @@ amdgpu_userq_destroy(struct drm_file *filp, int queu=
e_id)
>               mutex_unlock(&uq_mgr->userq_mutex);
>               return -EINVAL;
>       }
> -     amdgpu_userq_wait_for_last_fence(uq_mgr, queue);
> +
> +     if (amdgpu_userq_wait_for_last_fence(uq_mgr, queue)) {
> +             drm_warn(adev_to_drm(uq_mgr->adev), "Don't destroy a busy
> userq\n");
> +             mutex_unlock(&uq_mgr->userq_mutex);
> +             return -EINVAL;
> +     }
> +
>       r =3D amdgpu_bo_reserve(queue->db_obj.obj, true);
>       if (!r) {
>               amdgpu_bo_unpin(queue->db_obj.obj);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 5e075e8f0ca3..afc493f43256 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1929,6 +1929,7 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
>       struct amdgpu_bo_va_mapping *mapping;
>       struct amdgpu_vm *vm =3D bo_va->base.vm;
>       bool valid =3D true;
> +     int r;
>
>       saddr /=3D AMDGPU_GPU_PAGE_SIZE;
>
> @@ -1949,6 +1950,13 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device
> *adev,
>                       return -ENOENT;
>       }
>
> +     /* It's unlike to happen that the mapping userq hasn't been idled
> +      * during user unmap vm except the vm unmaped forcely from user spa=
ce.
> +      */
> +     r =3D amdgpu_userq_gem_va_unmap_validate(vm, saddr);
> +     if (unlikely(r && r !=3D -EBUSY))
> +             dev_warn(adev->dev, "Here should be an improper unmap reque=
st
> from
> +user space\n");
> +
>       list_del(&mapping->list);
>       amdgpu_vm_it_remove(mapping, &vm->va);
>       mapping->bo_va =3D NULL;
> --
> 2.34.1


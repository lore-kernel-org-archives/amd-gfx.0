Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F40EEC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Oct 2022 13:15:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0BB810EF94;
	Thu, 20 Oct 2022 13:15:54 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDB5510EF94
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 13:15:48 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id x188so22820914oig.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 06:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WKKWVbHWkfm2Lqw4QW5a8prM961Npy1CIVgqC7jAYiY=;
 b=ePJFvnjTdfH9NNGXBFmC4fKsmSkXSRmvAgRt+41rPVQ3PpbMGcEISCwBnOuHumvVKF
 zsXttCnc7cAdlCQhpP5+PpXfwt+qCrGJ4bYzNi4kxwIG8t4U7Gd5zyXaQs0x3Y5fkVfd
 +yMH39V1XjkXmviIJwqkJ/SKJ7T+bQ1Y1X307qbCbeIAZbNkytAxnuInZExgLdiDQswm
 1rCmAF6hqSLlfCSyvCxh73aNtMNmizjmrBuoDGnxY9s10Dyfnf+Y/uMnitVB3jnjzlyh
 x09q9IP7JZJGnRMdjRR5SSkO7SF1VNDWmXui3iW3+rG6BrJCQ9GC4X64t2CBLdjKiZzB
 0L6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WKKWVbHWkfm2Lqw4QW5a8prM961Npy1CIVgqC7jAYiY=;
 b=4MuUaJEi/b9z9efwToTkY0vudbfxmdD1Hut4XEywHfOhZdhJcdYR7RGbKcMtE0r8H5
 he5/7lsKrUeohfX4md/8qfU2YfOBzdIIRJlBJ0PFCDQxWKj8N+T5nNjwjbAYwW6srswU
 zhzKm9XV85M5UGQ/BuZiMZ5bxOmgtF4J8lVNvJ2jt/rawhmaA1GNqix40w2pE6RAvNNo
 N8BBHBXASGaHN//+7cc6FbZApT0isRXpbk56V0yKDIzn5NJCUr68cNtNvufBwt/8edoh
 NvlHJnYS7Om39L6kF1ukexsRT+rhwaCGosTqti/DgHIkS5kBhHqxqYPYiGpFrQwjHSaX
 g0sw==
X-Gm-Message-State: ACrzQf38UUcqU5iQXs8ifvksQwbPpzF/e0jFk3fwlyvjaBI7HJLxXkNj
 2nthxSh5CfHItELb0LqCpuGuG8aWyMG2/nFiEPo=
X-Google-Smtp-Source: AMsMyM49qyX7nx/g2+4+bHKgvYvd1A9uTiZN+O9aafPkc3MttHVaSGEIfkWB4R775I0PCibOPa0T+jfnNgdtWTQmz2o=
X-Received: by 2002:aca:ac88:0:b0:355:200f:b5ac with SMTP id
 v130-20020acaac88000000b00355200fb5acmr15331377oie.46.1666271748049; Thu, 20
 Oct 2022 06:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <20221020091515.2758445-1-Prike.Liang@amd.com>
 <20221020091515.2758445-2-Prike.Liang@amd.com>
In-Reply-To: <20221020091515.2758445-2-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 Oct 2022 09:15:36 -0400
Message-ID: <CADnq5_MBs7Cx9jGxBDNt0gv0ioT+N8jzKV3pRf2R2tfWzxZj8g@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdkfd: update gfx1037 Lx cache setting
To: Prike Liang <Prike.Liang@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Alexander.Deucher@amd.com, Yifan1.Zhang@amd.com, ray.huang@amd.com,
 aaron.liu@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, Oct 20, 2022 at 5:15 AM Prike Liang <Prike.Liang@amd.com> wrote:
>
> Update the gfx1037 L1/L2/L3 cache setting.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 53 +++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 960046e43b7a..6e699cb9971f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -795,6 +795,55 @@ static struct kfd_gpu_cache_info yellow_carp_cache_info[] = {
>         },
>  };
>
> +static struct kfd_gpu_cache_info gfx1037_cache_info[] = {
> +       {
> +               /* TCP L1 Cache per CU */
> +               .cache_size = 16,
> +               .cache_level = 1,
> +               .flags = (CRAT_CACHE_FLAGS_ENABLED |
> +                               CRAT_CACHE_FLAGS_DATA_CACHE |
> +                               CRAT_CACHE_FLAGS_SIMD_CACHE),
> +               .num_cu_shared = 1,
> +       },
> +       {
> +               /* Scalar L1 Instruction Cache per SQC */
> +               .cache_size = 32,
> +               .cache_level = 1,
> +               .flags = (CRAT_CACHE_FLAGS_ENABLED |
> +                               CRAT_CACHE_FLAGS_INST_CACHE |
> +                               CRAT_CACHE_FLAGS_SIMD_CACHE),
> +               .num_cu_shared = 2,
> +       },
> +       {
> +               /* Scalar L1 Data Cache per SQC */
> +               .cache_size = 16,
> +               .cache_level = 1,
> +               .flags = (CRAT_CACHE_FLAGS_ENABLED |
> +                               CRAT_CACHE_FLAGS_DATA_CACHE |
> +                               CRAT_CACHE_FLAGS_SIMD_CACHE),
> +               .num_cu_shared = 2,
> +       },
> +       {
> +               /* GL1 Data Cache per SA */
> +               .cache_size = 128,
> +               .cache_level = 1,
> +               .flags = (CRAT_CACHE_FLAGS_ENABLED |
> +                               CRAT_CACHE_FLAGS_DATA_CACHE |
> +                               CRAT_CACHE_FLAGS_SIMD_CACHE),
> +               .num_cu_shared = 2,
> +       },
> +       {
> +               /* L2 Data Cache per GPU (Total Tex Cache) */
> +               .cache_size = 256,
> +               .cache_level = 2,
> +               .flags = (CRAT_CACHE_FLAGS_ENABLED |
> +                               CRAT_CACHE_FLAGS_DATA_CACHE |
> +                               CRAT_CACHE_FLAGS_SIMD_CACHE),
> +               .num_cu_shared = 2,
> +       },
> +};
> +
> +
>  static struct kfd_gpu_cache_info dummy_cache_info[] = {
>         {
>                 /* TCP L1 Cache per CU */
> @@ -1565,6 +1614,10 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
>                         pcache_info = yellow_carp_cache_info;
>                         num_of_cache_types = ARRAY_SIZE(yellow_carp_cache_info);
>                         break;
> +               case IP_VERSION(10, 3, 7):
> +                       pcache_info = gfx1037_cache_info;
> +                       num_of_cache_types = ARRAY_SIZE(gfx1037_cache_info);
> +                       break;
>                 case IP_VERSION(11, 0, 0):
>                 case IP_VERSION(11, 0, 1):
>                 case IP_VERSION(11, 0, 2):
> --
> 2.25.1
>

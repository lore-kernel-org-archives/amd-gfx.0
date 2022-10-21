Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD273C38A2D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Oct 2022 20:22:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70EAA10E009;
	Fri, 21 Oct 2022 20:22:58 +0000 (UTC)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7DB510E009
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Oct 2022 20:22:51 +0000 (UTC)
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-13af2d12469so4924422fac.13
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Oct 2022 13:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c0aFnni6FG6/f/JeHszApvPuh7SthXddDDVASG0Wa8Q=;
 b=XkFZM1QIJW3lCqaGEFt2KbW4lQdY5Dk51hwtbwEuTiiH1a40J5DfJnJsjQOHnibYqW
 TToOV0iSanjkBlkJ43/9SfSjJEuXErRm0Q+SYHOqzgutKh96vmXOFHfu8WxIgKadTqAf
 vWtRx6Au0gBpff5xCLF+0B249B3KwxV/nbfvvUA/k4m6u9YLODDic37G46/6MbSyycZU
 p/9621vs1AOWu+PpqlNMHahVOGbCFsK2vws4T2fIuaGv+asZy2LQM26/pone3tpXCz/p
 FWjDHBijhrz46nahQEuh8R6u2/sslNNJtsBez9FcYLwUnitMlosTKoLeDCulF+m+y8oQ
 eFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c0aFnni6FG6/f/JeHszApvPuh7SthXddDDVASG0Wa8Q=;
 b=kcAXMV+Z7PzKNxQPDUtPmXOZu7wFoUaL0d7nO0X3/ZsKERT7nEVb38Gn6WSKVm8bg0
 lX0A4coroLkZX0+T7saKrL53IWpimRqBiLTy2UZKx9VBFv3HqNkBWaO77bQ1gAUr0VKF
 c7FdfBVrDnRyd2iWkL1NcHa2oxRmToY32Edrj0+yXOKMMcwMI9MbXJIrSkuFJhBY00qB
 C2R3VOrpxHU5WK8VOJE3rbJKQWbdgUStkGiqTFlKtLjFYmyVacrlavG+FMaV8yjQdgaX
 1u8jd/bzgUZBKN/yfMFW+Dg1H88E+9+g4iPaU77UWtr/jCUL00mzN8S4jUwUF7/K0p/n
 /OIQ==
X-Gm-Message-State: ACrzQf19Ptpa0ZUBPJ2jTST6CZJqxbJrFG4oGsMgQaJeCAu+aLN9kf+v
 So9YYNG9NLzZY08spNq7RRJK7munhEg8ERMftfwHOlqT
X-Google-Smtp-Source: AMsMyM5bZ3TB5piW/kAf4fFnU+8tooLVPoQ5eumGA3C50EmU5JrW6nZqVIMcqtHN1rzT5VOklO5FYDUgE4skfXnRoBY=
X-Received: by 2002:a05:6870:a7a4:b0:136:7c39:979e with SMTP id
 x36-20020a056870a7a400b001367c39979emr13541014oao.96.1666383770899; Fri, 21
 Oct 2022 13:22:50 -0700 (PDT)
MIME-Version: 1.0
References: <DM4PR12MB5152E7324B015121A58421D2E3209@DM4PR12MB5152.namprd12.prod.outlook.com>
 <BL1PR12MB51444061064E5A389D8EDB36F7209@BL1PR12MB5144.namprd12.prod.outlook.com>
 <DM4PR12MB5152F3DFF5D93F750662E0B4E3239@DM4PR12MB5152.namprd12.prod.outlook.com>
 <DM4PR12MB51522F1AFF5AF9507C1678E7E3239@DM4PR12MB5152.namprd12.prod.outlook.com>
 <CY5PR12MB6369ACDEF61737FECFF01425C1229@CY5PR12MB6369.namprd12.prod.outlook.com>
In-Reply-To: <CY5PR12MB6369ACDEF61737FECFF01425C1229@CY5PR12MB6369.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 21 Oct 2022 16:22:39 -0400
Message-ID: <CADnq5_N6LAQ==LFHLP9q4JqhkrmrL257VAMYZiWMuRVw6in2vA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: correct the cache info for gfx1036
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Jesse\(Jie\)" <Jesse.Zhang@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It looks like this patch never landed.

Alex

On Tue, Oct 11, 2022 at 9:48 PM Zhang, Yifan <Yifan1.Zhang@amd.com> wrote:
>
> [Public]
>
>
>
> This patch is
>
>
>
> Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
>
>
>
> From: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Sent: Tuesday, October 11, 2022 1:23 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
> Subject: RE: [PATCH] drm/amdkfd: correct the cache info for gfx1036
>
>
>
> [AMD Official Use Only - General]
>
>
>
>
>
>    correct the cache information for gfx1036
>
>
>
>     Signed-off-by: Yifan Zhang yifan1.zhang@amd.com
>
>
>
>     Signed-off-by: jie1zhan jesse.zhang@amd.com
>
>     Change-Id: I60e754737057c144e69a6511ba6ddfca472ca7a1
>
>
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>
> index 477a30981c1b..d25ac9cbe5b2 100644
>
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>
> @@ -795,6 +795,54 @@ static struct kfd_gpu_cache_info yellow_carp_cache_info[] = {
>
>         },
>
> };
>
>
>
> +static struct kfd_gpu_cache_info gc_10_3_6_cache_info[] = {
>
> +       {
>
> +               /* TCP L1 Cache per CU */
>
> +               .cache_size = 16,
>
> +               .cache_level = 1,
>
> +               .flags = (CRAT_CACHE_FLAGS_ENABLED |
>
> +                               CRAT_CACHE_FLAGS_DATA_CACHE |
>
> +                               CRAT_CACHE_FLAGS_SIMD_CACHE),
>
> +               .num_cu_shared = 1,
>
> +       },
>
> +       {
>
> +               /* Scalar L1 Instruction Cache per SQC */
>
> +               .cache_size = 32,
>
> +               .cache_level = 1,
>
> +               .flags = (CRAT_CACHE_FLAGS_ENABLED |
>
> +                               CRAT_CACHE_FLAGS_INST_CACHE |
>
> +                               CRAT_CACHE_FLAGS_SIMD_CACHE),
>
> +               .num_cu_shared = 2,
>
> +       },
>
> +       {
>
> +               /* Scalar L1 Data Cache per SQC */
>
> +               .cache_size = 16,
>
> +               .cache_level = 1,
>
> +               .flags = (CRAT_CACHE_FLAGS_ENABLED |
>
> +                               CRAT_CACHE_FLAGS_DATA_CACHE |
>
> +                               CRAT_CACHE_FLAGS_SIMD_CACHE),
>
> +               .num_cu_shared = 2,
>
> +       },
>
> +       {
>
> +               /* GL1 Data Cache per SA */
>
> +               .cache_size = 128,
>
> +               .cache_level = 1,
>
> +               .flags = (CRAT_CACHE_FLAGS_ENABLED |
>
> +                               CRAT_CACHE_FLAGS_DATA_CACHE |
>
> +                               CRAT_CACHE_FLAGS_SIMD_CACHE),
>
> +               .num_cu_shared = 2,
>
> +       },
>
> +       {
>
> +               /* L2 Data Cache per GPU (Total Tex Cache) */
>
> +               .cache_size = 256,
>
> +               .cache_level = 2,
>
> +               .flags = (CRAT_CACHE_FLAGS_ENABLED |
>
> +                               CRAT_CACHE_FLAGS_DATA_CACHE |
>
> +                               CRAT_CACHE_FLAGS_SIMD_CACHE),
>
> +               .num_cu_shared = 2,
>
> +       },
>
> +};
>
> +
>
> static void kfd_populated_cu_info_cpu(struct kfd_topology_device *dev,
>
>                 struct crat_subtype_computeunit *cu)
>
> {
>
> @@ -1514,11 +1562,14 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
>
>                         num_of_cache_types = ARRAY_SIZE(beige_goby_cache_info);
>
>                         break;
>
>                 case IP_VERSION(10, 3, 3):
>
> -               case IP_VERSION(10, 3, 6): /* TODO: Double check these on production silicon */
>
>                 case IP_VERSION(10, 3, 7): /* TODO: Double check these on production silicon */
>
>                         pcache_info = yellow_carp_cache_info;
>
>                         num_of_cache_types = ARRAY_SIZE(yellow_carp_cache_info);
>
>                         break;
>
> +               case IP_VERSION(10, 3, 6):
>
> +                       pcache_info = gc_10_3_6_cache_info;
>
> +                       num_of_cache_types = ARRAY_SIZE(gc_10_3_6_cache_info);
>
> +                       break;
>
>                 case IP_VERSION(11, 0, 0):

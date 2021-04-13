Return-Path: <SRS0=eSA1=JK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C59C433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 14:58:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A402613B7
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 14:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A402613B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2FFA89B60;
	Tue, 13 Apr 2021 14:58:32 +0000 (UTC)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9983089B60
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 14:58:31 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 v19-20020a0568300913b029028423b78c2dso7737108ott.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 07:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=17QLw2Hr0Q13sxMy3w5JTklzhqQBmFWtQcWHAjlSUV8=;
 b=ioK0IbTAJY9iyntmjmLuXFWh7LxPCnBV2uXPSaWKKZ5mHTvUcxjrR4DbkMzhEII9jw
 Kzu7gjW1Zxv5yHv7nsJg9dE7yukAhiJF1OUAi+goDpfvkQsymhTyuR2zdhLbfM3QAIY2
 k8uHBHCQgTBoUL/uMNhJtzY4lhr2r3/kTqoPjU+GRrXDVFXfU6o2fUoS0wMsv4L05H+O
 ziUUWDYciqDE8c4gn9ybi/aeOCYtf7kxRNKzQz9osPSgnd3i/ice1ZPlh7kc+mvbm9Pi
 M/Wq1FfV6UAu8qhhbgQ9p8V+z9X0Dqzkmdj4KScjOd67JGT6zKYhvJrAywF2CK17tyK3
 Zhlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=17QLw2Hr0Q13sxMy3w5JTklzhqQBmFWtQcWHAjlSUV8=;
 b=oCh3Prg3SGSgpUbmUbn/fiJaJ+ob2sNPR7Iy1/JjTrrCl16chp5grqDZ0XZfxGMXHg
 RbWqmFFRN2pHb2RGQ/R1V3vE/eY57VWi9JLe5886eVX7OWIXm7TNS/DRD/B38PRzVHFp
 r81PQNcrEYTmrFmx6zYA7Nk4xwJOwoI05JX/3vbkgbiZGKCY0S3GT+oJdM6BF9LvrrD/
 5EtkbRS8peDgRRzpWESVUfFsdljWd02qFvH1KvYwal1rYJoElAvHn98m476S4KfSSOPO
 Bq7qWTOzMCepCtcHwvpQBpVx7SkXTviKPcXlRicVEXCYm8wWkSk90ZksSN4nqnUWAl/3
 r4Gw==
X-Gm-Message-State: AOAM532JuOYI5mVuljxRaCfaQUpt5f6Pcyf3SGP3P2qhCWFzec7iIyY0
 rXh718y3PpvkDwT58GQoWecdmG+p11kdw592xMo=
X-Google-Smtp-Source: ABdhPJySEEcHZgtPEK6N2RDUfSYRDcOGfPdjY2npWwLbUhAE4ZwoGPssFN7rHK78ZL5nZrpuZA66gB4aj3vH1CggS20=
X-Received: by 2002:a05:6830:1697:: with SMTP id
 k23mr9219412otr.132.1618325910845; 
 Tue, 13 Apr 2021 07:58:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210412121505.23787-1-Roy.Sun@amd.com>
In-Reply-To: <20210412121505.23787-1-Roy.Sun@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 13 Apr 2021 10:58:19 -0400
Message-ID: <CADnq5_M1mxSdF7KhiNsy35OKfJXJCOP=FdOBRUgQhb=RgXtztQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Expose some power info through AMDGPU_INFO
To: Roy Sun <Roy.Sun@amd.com>, Tom St Denis <tom.stdenis@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Apr 12, 2021 at 8:15 AM Roy Sun <Roy.Sun@amd.com> wrote:
>
> Add interface to get the mm clock, temperature and memory load
>
> Signed-off-by: Roy Sun <Roy.Sun@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 50 +++++++++++++++++++++++++
>  include/uapi/drm/amdgpu_drm.h           | 12 ++++++
>  2 files changed, 62 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index b2e774aeab45..e5b16e0819ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -971,6 +971,56 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>                         }
>                         ui32 /= 100;
>                         break;
> +               case AMDGPU_INFO_SENSOR_UVD_VCLK:
> +                       /* get mm vclk in Mhz */
> +                       if (amdgpu_dpm_read_sensor(adev,
> +                                                  AMDGPU_PP_SENSOR_UVD_VCLK,
> +                                                  (void *)&ui32, &ui32_size)) {
> +                               return -EINVAL;
> +                       }
> +                       ui32 /= 100;
> +                       break;
> +               case AMDGPU_INFO_SENSOR_UVD_DCLK:
> +                       /* get mm dclk in Mhz */
> +                       if (amdgpu_dpm_read_sensor(adev,
> +                                                  AMDGPU_PP_SENSOR_UVD_DCLK,
> +                                                  (void *)&ui32, &ui32_size)) {
> +                               return -EINVAL;
> +                       }
> +                       ui32 /= 100;
> +                       break;
> +               case AMDGPU_INFO_SENSOR_HOTSPOT_TEMP:
> +                       /* get junction temperature */
> +                       if (amdgpu_dpm_read_sensor(adev,
> +                                                  AMDGPU_PP_SENSOR_HOTSPOT_TEMP,
> +                                                  (void *)&ui32, &ui32_size)) {
> +                               return -EINVAL;
> +                       }
> +                       break;
> +               case AMDGPU_INFO_SENSOR_EDGE_TEMP:
> +                       /* get current edge temperature */
> +                       if (amdgpu_dpm_read_sensor(adev,
> +                                                  AMDGPU_PP_SENSOR_EDGE_TEMP,
> +                                                  (void *)&ui32, &ui32_size)) {
> +                               return -EINVAL;
> +                       }
> +                       break;
> +               case AMDGPU_INFO_SENSOR_MEM_TEMP:
> +                       /* get current memory temperature */
> +                       if (amdgpu_dpm_read_sensor(adev,
> +                                                  AMDGPU_PP_SENSOR_MEM_TEMP,
> +                                                  (void *)&ui32, &ui32_size)) {
> +                               return -EINVAL;
> +                       }
> +                       break;
> +               case AMDGPU_INFO_SENSOR_MEM_LOAD:
> +                       /* get memory load */
> +                       if (amdgpu_dpm_read_sensor(adev,
> +                                                  AMDGPU_PP_SENSOR_MEM_LOAD,
> +                                                  (void *)&ui32, &ui32_size)) {
> +                               return -EINVAL;
> +                       }
> +                       break;
>                 default:
>                         DRM_DEBUG_KMS("Invalid request %d\n",
>                                       info->sensor_info.type);
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 8b832f7458f2..484c72e17c72 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -780,6 +780,18 @@ struct drm_amdgpu_cs_chunk_data {
>         #define AMDGPU_INFO_SENSOR_STABLE_PSTATE_GFX_SCLK               0x8
>         /* Subquery id: Query GPU stable pstate memory clock */
>         #define AMDGPU_INFO_SENSOR_STABLE_PSTATE_GFX_MCLK               0x9
> +       /* Subquery id: Query GPU mm vclk */
> +       #define AMDGPU_INFO_SENSOR_UVD_VCLK             0xa
> +       /* Subquery id: Query GPU mm dclk */
> +       #define AMDGPU_INFO_SENSOR_UVD_DCLK             0xb
> +       /* Subquery id: Query junction temperature */
> +       #define AMDGPU_INFO_SENSOR_HOTSPOT_TEMP         0xc
> +       /* Subquery id: Query edge temperature */
> +       #define AMDGPU_INFO_SENSOR_EDGE_TEMP            0xd
> +       /* Subquery id: Query memory temperature */
> +       #define AMDGPU_INFO_SENSOR_MEM_TEMP             0xe
> +       /* Subquery id: Query Memory load */
> +       #define AMDGPU_INFO_SENSOR_MEM_LOAD             0xf

+ Tom

Please provide a link to patches for some userspace tool which uses
these new queries.  Something like umr would be a logical choice.
Once you have that, the patch itself looks good to me.

Alex


>  /* Number of VRAM page faults on CPU access. */
>  #define AMDGPU_INFO_NUM_VRAM_CPU_PAGE_FAULTS   0x1E
>  #define AMDGPU_INFO_VRAM_LOST_COUNTER          0x1F
> --
> 2.31.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

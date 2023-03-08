Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 987DAC6FD1E
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Mar 2023 15:21:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6CFD10E611;
	Wed,  8 Mar 2023 15:21:43 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6706510E602
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Mar 2023 15:21:40 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id bj30so12431166oib.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Mar 2023 07:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1678288899;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mWwmpG3OJq7tFokJHpYRgNZMu9lv5x2wwp+DmVU7BZ8=;
 b=leNr9L+NfcRzz/pALONECMQedFmHiqmHHYMRKFLKbTLssqqoEq931KzSUTY8dT13yB
 Q900mdR+8kkQDKeh9CgHACdtnk+epfIztnJzM3qGVKGoLkFZ2z7y5iRywTaS24yXM3OD
 idghABeJevJ0yANAy3nKkaTDUOYl2SmqOesTvHNNsxsoRQLeOX/JYE08Db5ttCb3XAHg
 hT8vKHATBRGNNs13axON6dTSUPUpdZN/sS1/fvJpZQ4bTq0hmX6Cj1NSkHMZTdl8NlZ3
 7cSBtcVw1znr2aM/IkAHGA62inT0RnsP9+YDzq/0QJNcLeZZn37aub5hSMiQr4EjHBTN
 UEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678288899;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mWwmpG3OJq7tFokJHpYRgNZMu9lv5x2wwp+DmVU7BZ8=;
 b=MwuA1wa5w2GaJpfQ4BblXoNfNtfhoj0xn09cAaKgvsgayLOnRDmKAVBoJARNvheD54
 pGPeLg6akRbOTfWYs6lQBj4ZBntO3x0BEVHnWTGnf3FaWYP1OmlHUUL2ikSbMvMul9Ke
 JcaP+daB6k8rOWGPUC9BhRpyJOIPzbS3GtbBupn3mtWMh+V1B8wV8B6Hg3RkRKfOXXas
 a2aRb4m77aubMlTFLtY+zRmd+uCF6bNgrPpwiJ0q5+0Ghn/g3rKA9svcvzA58YWkxThU
 h1j6O+5/bttH05xcf67BhOpC3LF92VgRnCMd5xr1mFIZhSXFsgNFGREwTD6Km8/EENAV
 6K5w==
X-Gm-Message-State: AO0yUKU3pqf1U9QnBhZmLd9woij2qNwvgXNi2sA6G+pMuGaLHfx76ynj
 c2kqVBqFpnMTS3mgGz8GVdsGMj2jZf4KvxiY6bIPQPbt
X-Google-Smtp-Source: AK7set9P2WgQHCIoeSiO1oS43XOt5hf5AHoFU/sZ1Yze52zVzG/6J/dJA5/J3uqqgejPJkcokiKbKrcXc487VeLDJYg=
X-Received: by 2002:a05:6808:92:b0:384:23ed:1ff6 with SMTP id
 s18-20020a056808009200b0038423ed1ff6mr5430142oic.3.1678288898202; Wed, 08 Mar
 2023 07:21:38 -0800 (PST)
MIME-Version: 1.0
References: <20230308034328.3836244-1-tim.huang@amd.com>
In-Reply-To: <20230308034328.3836244-1-tim.huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Mar 2023 10:21:26 -0500
Message-ID: <CADnq5_NK9Y1zW2E+EFMeM4tU8KZemK0Q7CwKUEJT+NnF5_uekA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: bump SMU 13.0.4 driver_if header version
To: Tim Huang <tim.huang@amd.com>
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, Xiaojian.Du@amd.com,
 li.ma@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Tue, Mar 7, 2023 at 10:44 PM Tim Huang <tim.huang@amd.com> wrote:
>
> Align the SMU driver interface version with PMFW to
> suppress the version mismatch message on driver loading.
>
> Signed-off-by: Tim Huang <tim.huang@amd.com>
> ---
>  .../drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_4.h    | 4 ++--
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h                  | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_4.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_4.h
> index f77401709d83..2162ecd1057d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_4.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_4.h
> @@ -27,7 +27,7 @@
>  // *** IMPORTANT ***
>  // SMU TEAM: Always increment the interface version if
>  // any structure is changed in this file
> -#define PMFW_DRIVER_IF_VERSION 7
> +#define PMFW_DRIVER_IF_VERSION 8
>
>  typedef struct {
>    int32_t value;
> @@ -198,7 +198,7 @@ typedef struct {
>    uint16_t SkinTemp;
>    uint16_t DeviceState;
>    uint16_t CurTemp;                     //[centi-Celsius]
> -  uint16_t spare2;
> +  uint16_t FilterAlphaValue;
>
>    uint16_t AverageGfxclkFrequency;
>    uint16_t AverageFclkFrequency;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> index e7d8b4eb4b56..0ef37837b164 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> @@ -29,7 +29,7 @@
>  #define SMU13_DRIVER_IF_VERSION_YELLOW_CARP 0x04
>  #define SMU13_DRIVER_IF_VERSION_ALDE 0x08
>  #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_0_0 0x37
> -#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_4 0x07
> +#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_4 0x08
>  #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_5 0x04
>  #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_0_10 0x32
>  #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_7 0x37
> --
> 2.25.1
>

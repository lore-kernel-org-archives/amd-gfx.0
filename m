Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2CCC43460
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 14:53:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17D08610A8
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 14:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17D08610A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1B316E897;
	Tue, 18 May 2021 14:53:38 +0000 (UTC)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C17C6E897
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 14:53:37 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 g7-20020a9d12870000b0290328b1342b73so1020679otg.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 07:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Dsimn8Jn1yl5q0VJrovRoI0f4VQPMXMgELOJkEYQ+BE=;
 b=DIPngHmL4+kz6ubpBk7eoO3gVenPrXu16fdepHGRCYaT2RSijByrcW/0GpNLivCnKS
 2o/rRfRGQqy0yglqjQt7yBBTQQxzza4l6bXGeN1Z/UZSrmVQiZAGOflOziWrko+D37QA
 EFnaU2umAP9jn5rXvzKV2hGLHgSMZDtetStLZKpbjAkqug16m/0Yq4X9ONZWz0gFwTVj
 H6fEBMwt+1Yy1oE2fhpXfvFy8+7IUlrSbNFvuPtudT5Z/uS2WhkMUGln28Gnrah96Y+F
 tQAmeNLkzyv5l/5a6pwgL0ZCMHEHRcmuyeOMLhIbSXfiBTvXfUDUYx3ITeqa0JBF4Vfh
 3M+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Dsimn8Jn1yl5q0VJrovRoI0f4VQPMXMgELOJkEYQ+BE=;
 b=nQ5ixaWl18bmjnWjNReQ0HrLz0owGwDQ8wBxZNuZeV+aTpHaBHDDHF6NtTEc9p8ser
 DbxhJKGsshddawXDsrgkvBGpCVcscry+B/DyCxwjrIMgoU9qLNT5q9g+ExfHy/ZcfpYD
 lTytXrBz55rc2B33D/1VTBHEv0ytYEOgAtU84FT1hg/yKGOHa4MB7nF5eh6cn39HXwQF
 LH2G8o0RhLir8jQtgmQjXQ19hUln2/wtPnDrZacV+u4q2X0hPz/rSJFaSyTWYyQ6unl7
 A2GuoN1L89bTWMSu9ipt0+uIYWyih9s3XChgvOHrjP6vTzluXMk+rjZLfhLshG0obchs
 YpEg==
X-Gm-Message-State: AOAM533uLLoR+cfKrBtkDcf/n1KrICCQavUh70uIIrww9rKs0PN1/abz
 FcuPJsfP2NAfV1ke6hosS9Q9epDEeU2iI2TBDxZ2B/Bc
X-Google-Smtp-Source: ABdhPJy50w6xS0d8NAmIwcUUlLYH71HWrMfq3od6l7ayamEAHsb6xy3A29oXbexyqudrCxXjRaNfvLbU+EVyb5paiY4=
X-Received: by 2002:a9d:6548:: with SMTP id q8mr4558216otl.311.1621349616667; 
 Tue, 18 May 2021 07:53:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210518141559.1360041-1-aaron.liu@amd.com>
In-Reply-To: <20210518141559.1360041-1-aaron.liu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 18 May 2021 10:53:25 -0400
Message-ID: <CADnq5_OkhmG29cdcwPFjRjryxVTwetYC4DtoPXc2feGEEPBjew@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: modify system reference clock source for
 navi+ (V2)
To: Aaron Liu <aaron.liu@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Kevin Wang <kevin1.wang@amd.com>, Huang Rui <Ray.Huang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, May 18, 2021 at 10:16 AM Aaron Liu <aaron.liu@amd.com> wrote:
>
> Starting from Navi+, the rlc reference clock is used for system clock
> from vbios gfx_info table. It is incorrect to use core_refclk_10khz of
> vbios smu_info table as system clock.
>
> Signed-off-by: Aaron Liu <aaron.liu@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> index 8c417014ca89..3b5d13189073 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> @@ -546,6 +546,21 @@ int amdgpu_atomfirmware_get_clock_info(struct amdgpu_device *adev)
>                 ret = 0;
>         }
>
> +       /* if asic is Navi+, the rlc reference clock is used for system clock
> +        * from vbios gfx_info table */
> +       if (adev->asic_type >= CHIP_NAVI10) {
> +               index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
> +                                                  gfx_info);
> +               if (amdgpu_atom_parse_data_header(mode_info->atom_context, index, NULL,
> +                                         &frev, &crev, &data_offset)) {
> +                       struct atom_gfx_info_v2_2 *gfx_info = (struct atom_gfx_info_v2_2*)
> +                               (mode_info->atom_context->bios + data_offset);
> +                       if ((frev == 2) && (crev >= 2))
> +                               spll->reference_freq = le32_to_cpu(gfx_info->rlc_gpu_timer_refclk);
> +                       ret = 0;
> +               }
> +       }
> +
>         return ret;
>  }
>
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

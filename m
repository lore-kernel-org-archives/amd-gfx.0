Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E351FC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 03:47:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A68A36108D
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 03:47:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A68A36108D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DF0D6E83A;
	Thu, 20 May 2021 03:47:41 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 777BD6E83A
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 03:47:39 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 n32-20020a9d1ea30000b02902a53d6ad4bdso13701061otn.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 20:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dudmbYtWfCwaj3uZQevOZ96/iI2ctHUxdktAQhN04Rw=;
 b=qj4FxknpvLRX8BFMG6FhgCofj+DR3RDajK2X+xO9DIMwS0QX1YnfzrcfuWH6atkaDY
 GcCu0YIiia23klfgd1s0qmoLPfEYLx0RjbF4eRjuwdpuMhO6X090p1plQG8PEp1MGBf8
 pOS4QwJqrtJK2vntE7WNMuTaHWhIWLPHGogxgGIwe94uOAHlmhonvc+MYPJ5ZoEThYmf
 OnGVTdDy8RUnPc1Ay292zMgsFXphMeXvkZF/qZ8y9YAyRjydPTgEVoLCe6IdwKmcjmCg
 6xudq5TW4+vdCbfsnqEYFRDAcaEYfimS3WoB+zEaLXzoayCCUatbm1YRn187yQfwo42P
 C+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dudmbYtWfCwaj3uZQevOZ96/iI2ctHUxdktAQhN04Rw=;
 b=CmxzeFQVUfPGwoy+puSHAu5NXemvAYJ86j2o+JyXbdxDwKVvf3pdahut9djIRIqmwG
 zMECapB5dT9+c5WuPPX9y8n7CoFULWUspyINTT0mitcBlBIZl5Qn8Ss9tQp/2QuOxYSB
 wxBbmimK5D1KkF7OJ7wPbDKQ8Ypx9Y/0cEAs8G3+x08/Yf1jVPOcX42dp4sKxOrS/LOU
 Pc0/GjL7I9UUruu+vFliVBWjFDNPDnA+nTlvAR4k1cyCgiRxYUk5z/WuOfNIRA9lt/rm
 uy+iZKlU6LHKpeJnxRYm3LnlZDuoRahkf7ZHZZCrKuP+BWKsyvsDTdWNh2IUtMtv+ogl
 KLYw==
X-Gm-Message-State: AOAM531061S1UUg/AY9kveD6hJtNpROV/IaYrHwnojq4xlSlhiCAhcKv
 nB80AVJkdtooDDGF0JCc5jb477+KUaNREji1S3Y=
X-Google-Smtp-Source: ABdhPJxtwbybdTqtdABQ9wZXs3yLODK6ohzFQnileFmS3jfBQdAMzjM7uVytJQ4YvNboHSXvYJ/q2Hb1pYOC4qeXSD8=
X-Received: by 2002:a9d:74c6:: with SMTP id a6mr2346538otl.132.1621482458852; 
 Wed, 19 May 2021 20:47:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210517143910.2125-1-PengJu.Zhou@amd.com>
 <20210517143910.2125-10-PengJu.Zhou@amd.com>
In-Reply-To: <20210517143910.2125-10-PengJu.Zhou@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 19 May 2021 23:47:28 -0400
Message-ID: <CADnq5_NtV-tzvWNGpXu239r805tvu0muQhmUYyG_w-ezBZ_rWQ@mail.gmail.com>
Subject: Re: [PATCH v5 10/10] drm/amdgpu: Skip the program of MMMC_VM_AGP_* in
 SRIOV
To: Peng Ju Zhou <PengJu.Zhou@amd.com>
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

On Mon, May 17, 2021 at 10:39 AM Peng Ju Zhou <PengJu.Zhou@amd.com> wrote:
>
> KMD should not program these registers, the value were
> defined in the host, so skip them in the SRIOV environment.
>
> Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> index e24225b3d42a..422d106a650b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> @@ -197,12 +197,12 @@ static void mmhub_v2_0_init_system_aperture_regs(struct amdgpu_device *adev)
>         uint64_t value;
>         uint32_t tmp;
>
> -       /* Program the AGP BAR */
> -       WREG32_SOC15_RLC(MMHUB, 0, mmMMMC_VM_AGP_BASE, 0);
> -       WREG32_SOC15_RLC(MMHUB, 0, mmMMMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
> -       WREG32_SOC15_RLC(MMHUB, 0, mmMMMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
> -
>         if (!amdgpu_sriov_vf(adev)) {
> +               /* Program the AGP BAR */
> +               WREG32_SOC15_RLC(MMHUB, 0, mmMMMC_VM_AGP_BASE, 0);
> +               WREG32_SOC15_RLC(MMHUB, 0, mmMMMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
> +               WREG32_SOC15_RLC(MMHUB, 0, mmMMMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
> +
>                 /* Program the system aperture low logical page number. */
>                 WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_LOW_ADDR,
>                              min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

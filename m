Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35535C43461
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 18:08:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0009D206EB
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 18:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Djeg94Bb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0009D206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 386CC6E489;
	Wed,  2 Sep 2020 18:08:17 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25F996E489
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 18:08:16 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id z4so386278wrr.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Sep 2020 11:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rq7USMAFfp/Iu2BPnkCbwjgXdX5qvYQFATO+OmADvhs=;
 b=Djeg94BbCxqzDgYFL/yHEU99jd+S623d3saQoG3OqHnQdPWIk2EGbjWZrpnf6Qp5uz
 QbOlfJi2b3mYHaRWMrZGept5g5Z5nuZpedOc6d4rVOybu2ucEHnvQR2swZeXIVX7hqzG
 Cmaz/g2v/nXqr0+V9/LV3UmUwQyYM9jd9lTSTVDSBUg0KiFYGzGFFiu4Ib7BwrpDGru8
 ktCUt/u0R7lorSx2njWn5nskCDCURhPEGcKejeFJjOey2za9O2j2V6aLVruhBMISd2/B
 tJCPTjiVLFUwJZf5bympcNGoUgslt6NjO1BCe2aqbyn7RCpKbXFc0Uww6QG5HR+9Qsbz
 jurw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rq7USMAFfp/Iu2BPnkCbwjgXdX5qvYQFATO+OmADvhs=;
 b=QIkE54tA7rpVI/vq+lB18nh0eRIRw79etWc+2M9MSX3L1qmnCez5ZKeoiP4//mtnQ5
 0d2wDAlPgLttv4+PutKLh8EhE82fTxzckXCw+R6qqy6aa7aszHAn83evBEJ8fkLqtLhi
 Del19R75duAOJekysBkMBjLoBn49D7ECpz/BiamWKlsejc9bxIXpQRtAYlDMJUtnqHOV
 dvyq9IDr1ys2FT9Mo338NId9+5UdodqWtl5tdZbFYv2GbukTnlLnR2VG9BPwUINlNUdN
 7l5TTu5Veso7x2Ak7x/1TtXIZcKviTBfk0mnyMeceKw4q6W4KkpKlgJu3dhdEXAHShaU
 BN/w==
X-Gm-Message-State: AOAM532DD5D9pRF8kDgjWpN9ev/QMAbF4gcdDiamlBoIaOBhfodX2v59
 csq5D8pOZG8ZqD2Em/Bwuh6635npWYUwVoaIwMgzMneU
X-Google-Smtp-Source: ABdhPJztiaieKYUpEpXGRnlrKuHKMkA78qCgSYKEOrfA7GY9j1OZPHJQb+R1/XhSDyVvgSFXunJE4GxHFkQN2GG30+I=
X-Received: by 2002:adf:ef0a:: with SMTP id e10mr8240526wro.362.1599070094846; 
 Wed, 02 Sep 2020 11:08:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200902170118.30751-1-alex.sierra@amd.com>
In-Reply-To: <20200902170118.30751-1-alex.sierra@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 2 Sep 2020 14:08:03 -0400
Message-ID: <CADnq5_NRFr5vYfuwgMHQ5Y+19_UqXPoJYomBkwGMoWkvjpA_Fw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: enable ih1 ih2 for Arcturus only
To: Alex Sierra <alex.sierra@amd.com>
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

On Wed, Sep 2, 2020 at 1:01 PM Alex Sierra <alex.sierra@amd.com> wrote:
>
> Enable multi-ring ih1 and ih2 for Arcturus only.
> For Navi10 family multi-ring has been disabled.
> Apparently, having multi-ring enabled in Navi was causing
> continus page fault interrupts.
> Further investigation is needed to get to the root cause.
> Related issue link:
> https://gitlab.freedesktop.org/drm/amd/-/issues/1279
>

Before committing, let's verify that it fixes that issue.

Alex


> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 30 ++++++++++++++++----------
>  1 file changed, 19 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> index 350f1bf063c6..4d73869870ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> @@ -306,7 +306,8 @@ static int navi10_ih_irq_init(struct amdgpu_device *adev)
>         } else {
>                 WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);
>         }
> -       navi10_ih_reroute_ih(adev);
> +       if (adev->asic_type == CHIP_ARCTURUS)
> +               navi10_ih_reroute_ih(adev);
>
>         if (unlikely(adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT)) {
>                 if (ih->use_bus_addr) {
> @@ -668,19 +669,26 @@ static int navi10_ih_sw_init(void *handle)
>         adev->irq.ih.use_doorbell = true;
>         adev->irq.ih.doorbell_index = adev->doorbell_index.ih << 1;
>
> -       r = amdgpu_ih_ring_init(adev, &adev->irq.ih1, PAGE_SIZE, true);
> -       if (r)
> -               return r;
> +       adev->irq.ih1.ring_size = 0;
> +       adev->irq.ih2.ring_size = 0;
>
> -       adev->irq.ih1.use_doorbell = true;
> -       adev->irq.ih1.doorbell_index = (adev->doorbell_index.ih + 1) << 1;
> +       if (adev->asic_type == CHIP_ARCTURUS) {
> +               r = amdgpu_ih_ring_init(adev, &adev->irq.ih1, PAGE_SIZE, true);
> +               if (r)
> +                       return r;
>
> -       r = amdgpu_ih_ring_init(adev, &adev->irq.ih2, PAGE_SIZE, true);
> -       if (r)
> -               return r;
> +               adev->irq.ih1.use_doorbell = true;
> +               adev->irq.ih1.doorbell_index =
> +                                       (adev->doorbell_index.ih + 1) << 1;
> +
> +               r = amdgpu_ih_ring_init(adev, &adev->irq.ih2, PAGE_SIZE, true);
> +               if (r)
> +                       return r;
>
> -       adev->irq.ih2.use_doorbell = true;
> -       adev->irq.ih2.doorbell_index = (adev->doorbell_index.ih + 2) << 1;
> +               adev->irq.ih2.use_doorbell = true;
> +               adev->irq.ih2.doorbell_index =
> +                                       (adev->doorbell_index.ih + 2) << 1;
> +       }
>
>         r = amdgpu_irq_init(adev);
>
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

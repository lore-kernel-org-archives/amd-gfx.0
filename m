Return-Path: <SRS0=OkES=DI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A68C4727C
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2020 13:53:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CBBD207F7
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2020 13:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dmrv6hLD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CBBD207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBBE089BFD;
	Thu,  1 Oct 2020 13:53:07 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BD1E89BFD
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Oct 2020 13:53:07 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id k15so5851505wrn.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 01 Oct 2020 06:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=CpQL1AF0ks34YdgXv+ejOryQpgmAOs/TdnHmmPuwsSw=;
 b=Dmrv6hLDjxfya+5UmVyoaYQR2q0rDZaSlpCk0eReK/Ncb3TfcMbtGPfzncLXfN0UJ3
 WIYOxjF2iNTfPN9Se93HVtlqFavB4MBsPbO2BHnQfUgDoXkQZy29dPHqbl/26wIQJDPQ
 jTVytCFXUlwAGiT/JaXVP36gDGAjWwFDmduyWr1VDwkMU5mMA3TRbkiEleSy/Q5T36OO
 PPezs/yMNnuJtne9EB+L5BhX9LiM7/o2nJZS3BH5MqB9W8i/OKsqGItDNj51KRoJf4O5
 p7yePogxQY6LNbfuH5rAdYIE2wCTKdmnEJ0YSEspRkmIh+enA/CIhTOSvJbYUVUx/QJz
 VqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=CpQL1AF0ks34YdgXv+ejOryQpgmAOs/TdnHmmPuwsSw=;
 b=PqfuaBy5AMsm5xRh+rOWoxrwfvr5Q2Du+pRFpV7Aa4uEMYrj2jGq38DDzOhI+Rt1Yt
 i/OLwgiQYgvienKPP04pVvpv1dpX+IWik93OLgQOvlvDJmbnq3NZP+2YhrRIlHxijCPF
 J/phAEy3skBjguJbaCRQHniiPtMBck9e0Gu07oYh/z8my7++ipCRMMzntvP6H5/9pdvP
 VfzwRq367ia0QsHALY5v7BB/bKE1xUVhHGNtIaBvICsrcXzUHi/MEtBgRAE50XmxY004
 daHyPJ8+Pq1epdguQPJbE75flfFhPjbLBhx3SMp1qTYSExeGAHUscXY1Ra4+pRn0Bcik
 nGVA==
X-Gm-Message-State: AOAM531eDUk/vlpAi7CJrgHogbr3O2FfkZIbw7I9RcSsBFtMJDqXUv3Y
 xuEqI6hHGtznln9HFk6ASgGvur8Gqa1KAHl3x8s=
X-Google-Smtp-Source: ABdhPJz57k7NfiLIsiFdruUEhfOPra/e4ZcyZSlyPLY/bEKJGILQF8HvQi+Kvt2iV9oE4bc2mXtlYt7joqpqUdaDQsQ=
X-Received: by 2002:adf:f290:: with SMTP id k16mr9777518wro.124.1601560385957; 
 Thu, 01 Oct 2020 06:53:05 -0700 (PDT)
MIME-Version: 1.0
References: <20201001131711.279333-1-alexander.deucher@amd.com>
 <20201001131711.279333-2-alexander.deucher@amd.com>
 <DM6PR12MB407567CB0D83C05E780AA69EFC300@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB407567CB0D83C05E780AA69EFC300@DM6PR12MB4075.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 1 Oct 2020 09:52:54 -0400
Message-ID: <CADnq5_MowCj-v3xvWBpZYTXTq3O_QoXMBUsowq+t69QBrt0auw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu/swsmu: add interrupt work handler for
 smu11 parts
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>
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
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Oct 1, 2020 at 9:35 AM Zhang, Hawking <Hawking.Zhang@amd.com> wrote:
>
> [AMD Public Use]
>
> @@ -2388,6 +2388,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
>         .gfx_ulv_control = smu_v11_0_gfx_ulv_control,
>         .deep_sleep_control = smu_v11_0_deep_sleep_control,
>         .get_fan_parameters = arcturus_get_fan_parameters,
> +       .interrupt_work = smu_v11_0_interrupt_work,
>  };
>
> I doubt Arcturus MP1 really supports ACDC switch and probably even doesn't have smc message to ack the interrupt as well. If so, the interrupt_work function shall not be necessary for Arcturus. Other than that
>

Yeah, I doubt vangogh does either.  I was just trying to keep the
behavior consistent with the current code.  I would guess we would
never get a ctxid of 3 or 4 on those chips in the first place so the
work would never be scheduled.

Alex

> Series is
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
>
> Regards,
> Hawking
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
> Sent: Thursday, October 1, 2020 21:17
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu/swsmu: add interrupt work handler for smu11 parts
>
> We need to schedule the smu AC/DC interrupt ack to avoid potentially sleeping if the smu message mutex is contended.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/inc/smu_v11_0.h                 |  2 ++
>  drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c      |  1 +
>  drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c        |  1 +
>  .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |  1 +
>  drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c         | 10 ++++++++--
>  drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c       |  1 +
>  6 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> index f57dc586649a..8885bde3ea3d 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> @@ -281,5 +281,7 @@ int smu_v11_0_gfx_ulv_control(struct smu_context *smu,  int smu_v11_0_deep_sleep_control(struct smu_context *smu,
>                                  bool enablement);
>
> +void smu_v11_0_interrupt_work(struct smu_context *smu);
> +
>  #endif
>  #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index d298fa65274d..fc376281e629 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -2388,6 +2388,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
>         .gfx_ulv_control = smu_v11_0_gfx_ulv_control,
>         .deep_sleep_control = smu_v11_0_deep_sleep_control,
>         .get_fan_parameters = arcturus_get_fan_parameters,
> +       .interrupt_work = smu_v11_0_interrupt_work,
>  };
>
>  void arcturus_set_ppt_funcs(struct smu_context *smu) diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index be44cb941e73..3f1377f28493 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -2755,6 +2755,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
>         .deep_sleep_control = smu_v11_0_deep_sleep_control,
>         .get_fan_parameters = navi10_get_fan_parameters,
>         .post_init = navi10_post_smu_init,
> +       .interrupt_work = smu_v11_0_interrupt_work,
>  };
>
>  void navi10_set_ppt_funcs(struct smu_context *smu) diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index a2cb831ce8aa..3c8732f34b1f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -2784,6 +2784,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
>         .gfx_ulv_control = smu_v11_0_gfx_ulv_control,
>         .deep_sleep_control = smu_v11_0_deep_sleep_control,
>         .get_fan_parameters = sienna_cichlid_get_fan_parameters,
> +       .interrupt_work = smu_v11_0_interrupt_work,
>  };
>
>  void sienna_cichlid_set_ppt_funcs(struct smu_context *smu) diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index effa4391b577..3e949e53cdc3 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -958,6 +958,12 @@ static int smu_v11_0_process_pending_interrupt(struct smu_context *smu)
>         return ret;
>  }
>
> +void smu_v11_0_interrupt_work(struct smu_context *smu) {
> +       if (smu_v11_0_ack_ac_dc_interrupt(smu))
> +               dev_err(smu->adev->dev, "Ack AC/DC interrupt Failed!\n"); }
> +
>  int smu_v11_0_enable_thermal_alert(struct smu_context *smu)  {
>         int ret = 0;
> @@ -1323,11 +1329,11 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
>                         switch (ctxid) {
>                         case 0x3:
>                                 dev_dbg(adev->dev, "Switched to AC mode!\n");
> -                               smu_v11_0_ack_ac_dc_interrupt(&adev->smu);
> +                               schedule_work(&smu->interrupt_work);
>                                 break;
>                         case 0x4:
>                                 dev_dbg(adev->dev, "Switched to DC mode!\n");
> -                               smu_v11_0_ack_ac_dc_interrupt(&adev->smu);
> +                               schedule_work(&smu->interrupt_work);
>                                 break;
>                         case 0x7:
>                                 /*
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index d6759de40503..145712a24b80 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -341,6 +341,7 @@ static const struct pptable_funcs vangogh_ppt_funcs = {
>         .get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
>         .set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
>         .disable_all_features_with_exception = smu_cmn_disable_all_features_with_exception,
> +       .interrupt_work = smu_v11_0_interrupt_work,
>  };
>
>  void vangogh_set_ppt_funcs(struct smu_context *smu)
> --
> 2.25.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Chawking.zhang%40amd.com%7C83deb1c80e614081cb9a08d8660c56ad%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637371550481303648&amp;sdata=58V1WjAucW4EGNh9PKOoZ%2BqC5bapiWOGR83pnAxLIxk%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

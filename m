Return-Path: <SRS0=Ip3g=OV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B005DC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 13:26:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E13961206
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 13:26:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5E13961206
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C92D76E491;
	Fri,  1 Oct 2021 13:26:41 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F26876E491
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Oct 2021 13:26:39 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 e66-20020a9d2ac8000000b0054da8bdf2aeso9238521otb.12
 for <amd-gfx@lists.freedesktop.org>; Fri, 01 Oct 2021 06:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ii4eMptMR5XUn6nhJHMIbe0f+eVqtcRttiuTjaG9HSQ=;
 b=KbnFu7Hbd5LWKr2R+BoPM6bfX2zTcg+rfe1kUTpR/5cj9NOlBA+JhWoBuverMTf07+
 fxTMgIiWl9JbyA1BuAUFRz2PaofY6Kw/5fUMV35RTr3CQCixkpLFtMRCz/wLcJliXJww
 P991bS5wNE1HP3YuTjWZ3UpdbAbHjXwVoC14e5WP9LqBhjre9NffYVU51KmOqogj2iIT
 zN4QKO4xpYWt9A/IMr8Xi0kkry/Q8J2uJt1bAmBaA28qM6gCrd/8udzLmmf/ojEnkGrD
 f0zMn6/hRpqOV4F3FlxxmRowbfY/1Rp8fj3nNT5cPKjeIvB+MfP/+ismNyd2WDWbh620
 FCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ii4eMptMR5XUn6nhJHMIbe0f+eVqtcRttiuTjaG9HSQ=;
 b=pdsWcCJRKCg8MJo/421LG+u5VKwZwCBzI9fvispYQdQGswXi08eOBikQLGj7zT5GrV
 eUvhgu+KugfZgAMQisI/8qZ5PVlqpPy0Ke5eyVRhtrxT0YaTxmN+pkEhLtMiIroVKWEa
 Fk9eW5Uj+05oDO7Hc0wtwEsJ7uryWPFsiD43rEVNJvcYLXwCNnjrr4s/dJU8hdJQABMN
 mSLyfX95dtr2pZPFMRbz+1pjjjp0bQBsBgU8cr4OYoI4mQCOUFIWAW/sHHUMmw5vY9+x
 6ZcGus4LQXyqdaiwgxgpqDi2xY76ptvZKEwGhb5UCqam3AgAXxjkBjfWknGe7DzKb1QO
 r/HA==
X-Gm-Message-State: AOAM531gfd29wLG9PXn/WbDDULPZyQH5tO039PkTTGFUHqGVx+fOUm4n
 TqnmxUzCJ+ZUQsSJdauVVojFqbg0cIBQSP5h9ZODQOw0
X-Google-Smtp-Source: ABdhPJznFPNzd2DcR1MzdklqTLPnZUrIpblfj8x4gVtIosUZFML2J44OTcixg3NHfPhMRmYvK04GGOuKsFGsWcUFlUg=
X-Received: by 2002:a05:6830:214c:: with SMTP id
 r12mr10247047otd.200.1633094798842; 
 Fri, 01 Oct 2021 06:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <20211001101625.15575-1-lijo.lazar@amd.com>
In-Reply-To: <20211001101625.15575-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 1 Oct 2021 09:26:27 -0400
Message-ID: <CADnq5_PQkPwOWWPK92OUDEA=kFh-RhqB-Qp==DDosZQzP27aEQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: During s0ix don't wait to signal GFXOFF
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>, 
 Kevin Wang <Kevin1.Wang@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Oct 1, 2021 at 6:16 AM Lijo Lazar <lijo.lazar@amd.com> wrote:
>
> In the rare event when GFX IP suspend coincides with a s0ix entry, don't
> schedule a delayed work, instead signal PMFW immediately to allow GFXOFF
> entry. GFXOFF is a prerequisite for s0ix entry. PMFW needs to be
> signaled about GFXOFF status before amd-pmc module passes OS HINT
> to PMFW telling that everything is ready for a safe s0ix entry.
>
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1712
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index e7f06bd0f0cd..1916ec84dd71 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -31,6 +31,8 @@
>  /* delay 0.1 second to enable gfx off feature */
>  #define GFX_OFF_DELAY_ENABLE         msecs_to_jiffies(100)
>
> +#define GFX_OFF_NO_DELAY 0
> +
>  /*
>   * GPU GFX IP block helpers function.
>   */
> @@ -558,6 +560,8 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev)
>
>  void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable)
>  {
> +       unsigned long delay = GFX_OFF_DELAY_ENABLE;
> +
>         if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
>                 return;
>
> @@ -573,8 +577,14 @@ void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable)
>
>                 adev->gfx.gfx_off_req_count--;
>
> -               if (adev->gfx.gfx_off_req_count == 0 && !adev->gfx.gfx_off_state)
> -                       schedule_delayed_work(&adev->gfx.gfx_off_delay_work, GFX_OFF_DELAY_ENABLE);
> +               if (adev->gfx.gfx_off_req_count == 0 &&
> +                   !adev->gfx.gfx_off_state) {
> +                       /* If going to s2idle, no need to wait */
> +                       if (adev->in_s0ix)
> +                               delay = GFX_OFF_NO_DELAY;
> +                       schedule_delayed_work(&adev->gfx.gfx_off_delay_work,
> +                                             delay);
> +               }
>         } else {
>                 if (adev->gfx.gfx_off_req_count == 0) {
>                         cancel_delayed_work_sync(&adev->gfx.gfx_off_delay_work);
> --
> 2.17.1
>

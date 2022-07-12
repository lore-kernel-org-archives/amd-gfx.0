Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE1C0C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 17:01:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 591AC95780;
	Tue, 12 Jul 2022 17:01:04 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5A9995780
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 17:01:02 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id bp15so5153198ejb.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 10:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BPiFMUbYhuUVuAnl8ie0DboDqDTjGsGyBoT9HvmBv1E=;
 b=aTKZ3y7sjyt2GRnYYLBFpR+wz8YymIOaIuxKNy8uhEuq8FyuzIQblPJ/+J7BQuqJqg
 38bQy5ZrFm/uVUlQ2botjn7+VnlZPxyrBs0Visemhlq4VHoOqWuKabo4RgPTtUqpI9RB
 2JNdzr04BkdLJEJN505VeQ7Jmbj1Rs5eSFO2+GHBBKsW/2KYI5ct8+hRCKNv4uheb02s
 9VhDtVSl1/zEBtCROtROJ12ltx2LZZzhXoJ7CgoON/QDNGvQ64ddSE/R6cCf1+SEiIYW
 vhHB9+/Wr8KUfK4ZMqxSlVV65KRJ5M5muAEcKoEs3ASYdGQPEt6gYGgn8HTe7f3Espb/
 WYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BPiFMUbYhuUVuAnl8ie0DboDqDTjGsGyBoT9HvmBv1E=;
 b=6vRBkeLVu22hMqkonC+sRfi5w1IvMiPOlkVnA5CbFL214DIfGMs/XczBIg73R/4DrY
 vC4F/hppYaRCT90z3dPNBLvKnthhpu0Cw4O/ji29eWhWYJjRDpVc/8U/76ErI1FRJVwL
 q2wfV9CcS47sXdksmQxupdlfeVHxSSe/h7HBmjFh3EgenxkbZNL/u+YABw44FcAbL+Ci
 PvxZESFf2NLVwiabmzDROI1W4ydHHYuNbk1A6tpgxwSe4DtvV/reOhqUp8GIFd1P67zg
 /g47eYNTBj6sjjnXK33IL0+P4srI80awkT5lZqUC/YJZJ39ZAe4/VbC196GDrkWMSbTB
 5aAg==
X-Gm-Message-State: AJIora8TTw2qPkg/OHOziwchMGHcMJJGJ7ZRHAg4n3VH0nhBgm8cvQN7
 vJrdJuKTKRW2h2ha4CO40D3vERuPe2yqj6Y/TJs=
X-Google-Smtp-Source: AGRyM1u7JGgSPe4LwHIipRqWp8mhtvSLI/cjjoVqvzH79s6G8S9zgvA+TaBI5C2I4ETbZkNCreqLMSwv7HV1RLrLGTA=
X-Received: by 2002:a17:907:75e1:b0:72a:ebee:5f61 with SMTP id
 jz1-20020a17090775e100b0072aebee5f61mr25602190ejc.171.1657645261316; Tue, 12
 Jul 2022 10:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220711224443.1157747-1-sunpeng.li@amd.com>
 <20220712163029.43581-1-sunpeng.li@amd.com>
In-Reply-To: <20220712163029.43581-1-sunpeng.li@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 12 Jul 2022 13:00:49 -0400
Message-ID: <CADnq5_OAiWeb1H1Jc=ZM=y39UVgER0d5ZoHrw=cM2JzHis-qJw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Check BO's requested pinning domains
 against its preferred_domains
To: "Leo (Sunpeng) Li" <sunpeng.li@amd.com>
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
Cc: Leo Liu <Leo.Liu@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <Marek.Olsak@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jul 12, 2022 at 12:28 PM <sunpeng.li@amd.com> wrote:
>
> From: Leo Li <sunpeng.li@amd.com>
>
> When pinning a buffer, we should check to see if there are any
> additional restrictions imposed by bo->preferred_domains. This will
> prevent the BO from being moved to an invalid domain when pinning.
>
> For example, this can happen if the user requests to create a BO in GTT
> domain for display scanout. amdgpu_dm will allow pinning to either VRAM
> or GTT domains, since DCN can scanout from either or. However, in
> amdgpu_bo_pin_restricted(), pinning to VRAM is preferred if there is
> adequate carveout. This can lead to pinning to VRAM despite the user
> requesting GTT placement for the BO.
>
> v2: Allow the kernel to override the domain, which can happen when
>     exporting a BO to a V4L camera (for example).
>
> Signed-off-by: Leo Li <sunpeng.li@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 8a7b0f6162da..bbd3b8b14cfb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -883,6 +883,10 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
>         if (WARN_ON_ONCE(min_offset > max_offset))
>                 return -EINVAL;
>
> +       /* Check domain to be pinned to against preferred domains */
> +       if (bo->preferred_domains & domain)
> +               domain = bo->preferred_domains & domain;
> +
>         /* A shared bo cannot be migrated to VRAM */
>         if (bo->tbo.base.import_attach) {
>                 if (domain & AMDGPU_GEM_DOMAIN_GTT)
> --
> 2.37.0
>

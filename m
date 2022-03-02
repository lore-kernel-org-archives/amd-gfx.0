Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B1CC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Mar 2022 14:21:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38AC510E39F;
	Wed,  2 Mar 2022 14:21:48 +0000 (UTC)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8EA010E39F
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Mar 2022 14:21:47 +0000 (UTC)
Received: by mail-oo1-xc29.google.com with SMTP id
 s203-20020a4a3bd4000000b003191c2dcbe8so2026155oos.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Mar 2022 06:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=U/yIEjfRtpo4Xai71w9J7TaVlSpluUQ3gIpN1bxiMJA=;
 b=EosKVnlcZDZchCP0YmIvdWVOC4GuiwuNPoK2V7449z4yBluo2dR5qqzEu7WGrtOv1E
 N0r+0VQfYC4ksrWQeevpJX8Mnkrbjf1FnvJn8rNP8ViE4vtxaJQ95YQne7f3Sag5W9/H
 ynSdBmyJa4qHpfD3vJrqsMR9my2P7Qhz2c8H3mYOuNuKfqjsVHKGVgSrqksGMIyVy6aP
 o5k+W9eRogqJhJsMSLV+N97PA9q93Gd/UAVxHAgnNSp34Y824pMXYxETtViaMA8f/C3D
 JXkYwjzkDB2GM5kx5Xpt2BoFRCSazyeOZ+Znh9a82BlqWQwFpriMC7TQT0ChXDZW2eZo
 8d7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=U/yIEjfRtpo4Xai71w9J7TaVlSpluUQ3gIpN1bxiMJA=;
 b=gi7fewKsFvtOONQjJm6wHxPs8Fx9P93FWVZNbiwWCdVXJQa0toMlDxty91Wb4r96Ef
 bmubtW750TW54y1wZGEkGjqzely8PdIJ/WKE1gUa31zjcNvHfAu5ra2HCl0Vssu7dqYJ
 3O+vpP3Pq1QTJX2x4QvzSBuScmVSxCeqQa7mkmbZktAei6yCD2gPpB9rhSZtViwulNdp
 9vmjhFWloK4Z1RGdO5cljiKpZMSrHshIzEvspi/ctJ75SYKaRJcnOW7lOi5FN7GXfNKU
 LComhqCxnv3WMcdr0iYiWZT3f+Ujnr5dX/JMIRIVxpcM13tzYYlxxZsXFvEwB6FSrH0D
 SKcg==
X-Gm-Message-State: AOAM5322npQWRxbS2fn6+Q7doi78u4r4vnrfy/AGMNxpXSKMfxD4HUuE
 tdmcgMh4YBZNjJlIAgTOopzUagmh6NCb6fy6FLRqgpq3
X-Google-Smtp-Source: ABdhPJwxtoPlNTB4Xp8BV42tOP3iS1P2Lh94lsQm89tEIKvbx8SN/SidsqOl3JhODGavqHC2k0jB/sFr0O8WXwTLA8k=
X-Received: by 2002:a05:6870:340e:b0:d9:acbf:f961 with SMTP id
 g14-20020a056870340e00b000d9acbff961mr14607oah.120.1646230907101; Wed, 02 Mar
 2022 06:21:47 -0800 (PST)
MIME-Version: 1.0
References: <tencent_A4D5E94B44BF0EC4B7CE08BA886C0C1B0F06@qq.com>
In-Reply-To: <tencent_A4D5E94B44BF0EC4B7CE08BA886C0C1B0F06@qq.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 2 Mar 2022 09:21:36 -0500
Message-ID: <CADnq5_NOGDTnB+YbN2vLm9mNo1sAn4n=Seowk8vd4wuT5krDow@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix potential null dereference
To: Weiguo Li <liwg06@foxmail.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Wed, Mar 2, 2022 at 3:56 AM Weiguo Li <liwg06@foxmail.com> wrote:
>
> "ctx" is dereferenced but null checked later. Swap their positions
> to avoid potential null dereference.
>
> Found using a Coccinelle script:
> https://coccinelle.gitlabpages.inria.fr/website/rules/mini_null_ref.cocci
>
> Signed-off-by: Weiguo Li <liwg06@foxmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index f522b52725e4..b4f035ce44bc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -258,11 +258,12 @@ static void amdgpu_ctx_fini_entity(struct amdgpu_ctx_entity *entity)
>  static int amdgpu_ctx_get_stable_pstate(struct amdgpu_ctx *ctx,
>                                         u32 *stable_pstate)
>  {
> -       struct amdgpu_device *adev = ctx->adev;
> +       struct amdgpu_device *adev;
>         enum amd_dpm_forced_level current_level;
>
>         if (!ctx)
>                 return -EINVAL;
> +       adev = ctx->adev;
>
>         current_level = amdgpu_dpm_get_performance_level(adev);
>
> @@ -289,12 +290,13 @@ static int amdgpu_ctx_get_stable_pstate(struct amdgpu_ctx *ctx,
>  static int amdgpu_ctx_set_stable_pstate(struct amdgpu_ctx *ctx,
>                                         u32 stable_pstate)
>  {
> -       struct amdgpu_device *adev = ctx->adev;
> +       struct amdgpu_device *adev;
>         enum amd_dpm_forced_level level;
>         int r;
>
>         if (!ctx)
>                 return -EINVAL;
> +       adev = ctx->adev;
>
>         mutex_lock(&adev->pm.stable_pstate_ctx_lock);
>         if (adev->pm.stable_pstate_ctx && adev->pm.stable_pstate_ctx != ctx) {
> --
> 2.25.1
>

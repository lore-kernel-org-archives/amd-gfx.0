Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 174A4C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jan 2022 03:42:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75E7510E621;
	Thu, 27 Jan 2022 03:42:43 +0000 (UTC)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCCC110ED7D
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jan 2022 03:42:41 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id v67so3508726oie.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 19:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BqrKb1rGmBaw4q2qHdOM4BnJ2rFWR1iHd0RlEclVl9k=;
 b=bphT67QrvkAj/TRoM/Da2j1srqJuHGTCLYcglda+BkdgyszdewtS+ZjC5fNhx2Y2iY
 L/AekSJPs3CnKwJpAVhRK01grcGtjfoyiDIsXFrS5JBDRvDtjNWN6W3Sr8DKzHbNWYv8
 K2jliKuxSU+pFrHGIc3cCYntTPHK4qFaiQyZoyYNBpSY+M3VfoJNLZpBoezN79NYtVR6
 0hJkFAZ72HwbAr1ywCscomTcmSJDf4kwfQz7rq+X0OEMuc4ja+keu9Th8FsluvpGRk8q
 16d3F4gX2KQh4xVOIYHL4XE0laKPsU57oJLWIu1xcViLzf30jRJvq8ygQG/p6R6dDs+O
 WK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BqrKb1rGmBaw4q2qHdOM4BnJ2rFWR1iHd0RlEclVl9k=;
 b=TId8Y7a9OnzlU7IYdCWa/lIPvmdObGPoQSckP7HcSOKJfp85EYKjI0IVa/q6f2HC4P
 EL/HOqrtm4HXNZFV/P+9xn5QTzTvVhq+/zFGmnsUYPYFmV5wOUV5NbWwvRysVGZxod/N
 OsVm0OXmi1O+xNwcftiMqJOGc/+y5ttqc5b4k8AgXuG4VIIlOpl4d+OZxufLcCW9UIMk
 Hk8hK651GTm8wUDo32lrqd77Zbz9KfkzT+P3fxCDrqXsSR2ewrXCCiPMZoxJGgN55bZb
 jnjUWPhaOOlQ/hRB6fhjARa80dCrmXVH4vVbr/1Iv4jRdb50jJLlXtI1C3PkD/Y8hbgs
 /QEg==
X-Gm-Message-State: AOAM5318yin52/EF/qiZkRfvJTtZulcx8E0uRjtPp5ool0KZke2zLrMF
 Cs9cOjs9Q0MdhemDVJ5bDDwGcBM2+M9oHBvxn1o=
X-Google-Smtp-Source: ABdhPJydw6+hPyB21VHem24thgxIxVMgQHJAhlmYa6+FJwfHGDRu5tjUngrmoWV/3s8tD+0ESAVOSy+n+T+pKEi79sg=
X-Received: by 2002:a05:6808:2189:: with SMTP id
 be9mr5867622oib.93.1643254960826; 
 Wed, 26 Jan 2022 19:42:40 -0800 (PST)
MIME-Version: 1.0
References: <20220127033350.2550086-1-tim.huang@amd.com>
In-Reply-To: <20220127033350.2550086-1-tim.huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 Jan 2022 22:42:29 -0500
Message-ID: <CADnq5_P15rXpVjv16GB9jWzaPP3s2jT1UbosU2MfaD7+XOaq9A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix unused variable warning
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Huang Rui <Ray.Huang@amd.com>, Aaron Liu <Aaron.Liu@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Wed, Jan 26, 2022 at 10:34 PM Tim Huang <tim.huang@amd.com> wrote:
>
> [Why]
> It will build failed with unused variable 'dc' with
> '-Werror=unused-variable'enabled when CONFIG_DRM_AMD_DC_DCN
> is not defined.
>
> Signed-off-by: Tim Huang <tim.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 1057f976bec7..8f53c9f6b267 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1027,7 +1027,6 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
>         const unsigned char *fw_inst_const, *fw_bss_data;
>         uint32_t i, fw_inst_const_size, fw_bss_data_size;
>         bool has_hw_support;
> -       struct dc *dc = adev->dm.dc;
>
>         if (!dmub_srv)
>                 /* DMUB isn't supported on the ASIC. */
> @@ -1123,7 +1122,7 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
>         case IP_VERSION(3, 1, 3): /* Only for this asic hw internal rev B0 */
>                 hw_params.dpia_supported = true;
>  #if defined(CONFIG_DRM_AMD_DC_DCN)
> -               hw_params.disable_dpia = dc->debug.dpia_debug.bits.disable_dpia;
> +               hw_params.disable_dpia = adev->dm.dc->debug.dpia_debug.bits.disable_dpia;
>  #endif
>                 break;
>         default:
> --
> 2.25.1
>

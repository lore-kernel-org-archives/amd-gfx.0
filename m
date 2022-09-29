Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34DD9C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Sep 2022 13:15:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 678A110E5FE;
	Thu, 29 Sep 2022 13:15:32 +0000 (UTC)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BDDE10E5FE
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Sep 2022 13:15:27 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-131c8ccae75so1752706fac.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Sep 2022 06:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=c9JEP5YlOec8+grksunzWbxWnprETPpBfHGyEbsElGE=;
 b=RIFr6KbVTL+edzQLEfqAyqlZjEo7faPFtBBVtyywwqXgnQjpbxCFZejsi044c6zB1G
 rCSnY0DXLCTfmRiUOHSuYbnhtVVxpmjrv1G9yMegU5UUWIbXuqORgFThBYs+F65SvZIt
 sMy7O+NCnTMPWtgUBM56EAU1YGLIjqV2rx84rLZCEYLv1PS/vTPf49UcbBqYSsrRQEUc
 zWC5nXUwRIOKHxJR2Ox+DgeZegDOY2ZqZVyUqw8fkE5n1uxCDuR1mbcEz8UCXzbH8/Mt
 id+1CPgnkQDcJIh1NXKuE2Bcmk1pRl41bagWbL0FBY+O5/t6Ve4YVxXJXDM69zg1fBDM
 mi3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=c9JEP5YlOec8+grksunzWbxWnprETPpBfHGyEbsElGE=;
 b=O5d/Omx7FPuHMuwZjF8b1EmXAAAN3OjkV13iYpw0MzJ495ehX23BNo9Q6gZL7u1+VA
 t1PpX0ii/+cGxxoaGbuPRNbLedfhq114P1I6GUpJJvhk0T+yHsmmg2sMSrfveH0RMm+A
 jmQInUqvbk28uwzeAEzAZG9ASGgX2uu8e9+wRJCwbdE76jaovra36cuKTMzJMyOfGv7I
 fiEmkSPyL0EOtvES7b8i1fWGQClyaeqtS798p8pnEJp2/eGnthYRu6lsmSJvxkcqfdqi
 arJcn1usX5yKF31kb13S8alNWdvx+JMF5AUrikBVa0M0pEP2SUgadt8Zfcv95WmNL4HA
 v6Lg==
X-Gm-Message-State: ACrzQf2TGbqbuEfxMOnNWfB63NfKJ1khNYOHsIMGkhu/zXz68fXly3wE
 QnFT7/hkGA4vaWvUjj/6CdiAy93EAIlORQkZ91fU6Dyv
X-Google-Smtp-Source: AMsMyM7ar+/8M51qP6cURBAhFsZlL3yKqFK6hB9vk9loNO4WSjZRptSAuMyGx9oZS3/+hO+AFWQoOXkEllls1FpvZn4=
X-Received: by 2002:a05:6870:1783:b0:12a:f442:504d with SMTP id
 r3-20020a056870178300b0012af442504dmr8954815oae.46.1664457326604; Thu, 29 Sep
 2022 06:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220908143808.53981-1-alexander.deucher@amd.com>
In-Reply-To: <20220908143808.53981-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 29 Sep 2022 09:15:15 -0400
Message-ID: <CADnq5_MmTAxqdPWp864JhPWPr57Ad7YFxReJeJ=VRdbY9T0C5g@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/amdgpu: use proper DC check in
 amdgpu_display_supported_domains()
To: Alex Deucher <alexander.deucher@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping on this series?

Alex

On Thu, Sep 8, 2022 at 10:39 AM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> amdgpu_device_asic_has_dc_support() just checks the asic itself.
> amdgpu_device_has_dc_support() is a runtime check which not
> only checks the asic, but also other things in the driver
> like whether virtual display is enabled.  We want the latter
> here.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index c20922a5af9f..b0fa5d065d50 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -514,7 +514,7 @@ uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
>          */
>         if ((bo_flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC) &&
>             amdgpu_bo_support_uswc(bo_flags) &&
> -           amdgpu_device_asic_has_dc_support(adev->asic_type) &&
> +           amdgpu_device_has_dc_support(adev) &&
>             adev->mode_info.gpu_vm_support)
>                 domain |= AMDGPU_GEM_DOMAIN_GTT;
>  #endif
> --
> 2.37.2
>

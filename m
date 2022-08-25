Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90068C28D13
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Aug 2022 14:07:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E41D010E1F6;
	Thu, 25 Aug 2022 14:07:20 +0000 (UTC)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 690B710E1F6
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 14:07:17 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-11d7a859b3aso13802929fac.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 07:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=Ltlua0QLWkEHlew5Hq+MfzWhMNaU5IG9faNbF4T8ihQ=;
 b=JZ3kGZ2ZcZjvxCcXnSxxQa67torMYXPyUvw1NY0EkrXM+h9QGk0AUL8vZNK2co07dX
 60FB4gizfmF1BzHoIB/Qacx6HFUMfXaMR9Oa+7qIL8byLzP3W86qF+xYGytm/svuzMyb
 6j50iwQ5J59GcZdxzYtCWH66IccSvjWil9aqI6E4xIKiXbDh+x0zLeCDQuHFn2BnAvRw
 31+5OM188RANsoyMEMX4Jm864AfR7R9/hRW+NO98IDyHpSwwxjxfnbw7ofo+05+JfLfh
 w6Ut/3LHiGfm7jCjhlmvyuo4YyB5jKioTdw4jWcT8oHnAM4lt1dZ4GfJSExgULHvZuEF
 U/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=Ltlua0QLWkEHlew5Hq+MfzWhMNaU5IG9faNbF4T8ihQ=;
 b=bOctLiDkd+KYxb3wiElo4B3wGpwfIsb2DMeuAkcxHCNHDElm2XclDvVjyvhrxVeIpO
 CT+wfIb+M3yHUhmRZUQw9gqAg/pfCZZTuY+YOXr8XbzxJl1Bliwzv5OQ/yTBq3TgX41L
 UwU1xcMpOlN6+5Qt1gdPN7W/FFkuDz0tqejBhryfNfTv7/VVUeajUoyNh549QZBRr11l
 uKDhdL11bd9CnMwpq4V25QZgeX+j+1hhm3BpP2PyEu9Dw7QV5t3Ra/hKAU5eTD2ybJr4
 S2BucASm3HZCRGcVzPyF9yODpsr03pZRi3lmlHR3qBVv1Sxc5HagMKCDZewCnZjWnKm9
 xVtg==
X-Gm-Message-State: ACgBeo3F4JfAURGzw8gosbisAqSzwMWCHJKQVHp1C4iKhOKdOBMMtivV
 hR1o+a50KcCWuuWaUfDT2zi0qebWJg33am5sbD0=
X-Google-Smtp-Source: AA6agR6l5kCyvQQYf+TKMJpxwK8OZpETSVOb2J7FVzcIewIKf6E1nddYTZSlq11Zt4NOlm+2LlDMF//DaiNh3XV/rEY=
X-Received: by 2002:a05:6870:9a06:b0:11e:3d19:2614 with SMTP id
 fo6-20020a0568709a0600b0011e3d192614mr676730oab.96.1661436436578; Thu, 25 Aug
 2022 07:07:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220825085820.1228641-1-lijo.lazar@amd.com>
In-Reply-To: <20220825085820.1228641-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 25 Aug 2022 10:07:05 -0400
Message-ID: <CADnq5_McOZzSd+FmtKuLxjTpUD5X=_WrhwDyf_at-E6228T+RA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: Move HDP remapping earlier during init
To: Lijo Lazar <lijo.lazar@amd.com>
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
Cc: Felix.Kuehling@amd.com, amd-gfx@lists.freedesktop.org, tseewald@gmail.com,
 helgaas@kernel.org, Alexander.Deucher@amd.com, sr@denx.de,
 Christian.Koenig@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Aug 25, 2022 at 4:58 AM Lijo Lazar <lijo.lazar@amd.com> wrote:
>
> HDP flush is used early in the init sequence as part of memory controller
> block initialization. Hence remapping of HDP registers needed for flush
> needs to happen earlier.
>
> This also fixes the AER error reported as Unsupported Request during
> driver load.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216373
>
> Reported-by: Tom Seewald <tseewald@gmail.com>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++++++
>  drivers/gpu/drm/amd/amdgpu/nv.c            | 6 ------
>  drivers/gpu/drm/amd/amdgpu/soc15.c         | 6 ------
>  drivers/gpu/drm/amd/amdgpu/soc21.c         | 6 ------
>  4 files changed, 9 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index ce7d117efdb5..53d753e94a71 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2376,6 +2376,15 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>                                 DRM_ERROR("amdgpu_vram_scratch_init failed %d\n", r);
>                                 goto init_failed;
>                         }
> +
> +                       /* remap HDP registers to a hole in mmio space,
> +                        * for the purpose of expose those registers
> +                        * to process space. This is needed for any early HDP
> +                        * flush operation during gmc initialization.
> +                        */
> +                       if (adev->nbio.funcs->remap_hdp_registers && !amdgpu_sriov_vf(adev))
> +                               adev->nbio.funcs->remap_hdp_registers(adev);
> +

We probably also need this in ip_resume() as well to handle the
suspend and resume case.  Thinking about this more, maybe it's easier
to just track whether the remap has happened yet and use the old or
new offset based on that.

Alex


>                         r = adev->ip_blocks[i].version->funcs->hw_init((void *)adev);
>                         if (r) {
>                                 DRM_ERROR("hw_init %d failed %d\n", i, r);
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index b3fba8dea63c..3ac7fef74277 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -1032,12 +1032,6 @@ static int nv_common_hw_init(void *handle)
>         nv_program_aspm(adev);
>         /* setup nbio registers */
>         adev->nbio.funcs->init_registers(adev);
> -       /* remap HDP registers to a hole in mmio space,
> -        * for the purpose of expose those registers
> -        * to process space
> -        */
> -       if (adev->nbio.funcs->remap_hdp_registers && !amdgpu_sriov_vf(adev))
> -               adev->nbio.funcs->remap_hdp_registers(adev);
>         /* enable the doorbell aperture */
>         nv_enable_doorbell_aperture(adev, true);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index fde6154f2009..a0481e37d7cf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -1240,12 +1240,6 @@ static int soc15_common_hw_init(void *handle)
>         soc15_program_aspm(adev);
>         /* setup nbio registers */
>         adev->nbio.funcs->init_registers(adev);
> -       /* remap HDP registers to a hole in mmio space,
> -        * for the purpose of expose those registers
> -        * to process space
> -        */
> -       if (adev->nbio.funcs->remap_hdp_registers && !amdgpu_sriov_vf(adev))
> -               adev->nbio.funcs->remap_hdp_registers(adev);
>
>         /* enable the doorbell aperture */
>         soc15_enable_doorbell_aperture(adev, true);
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index 55284b24f113..16b447055102 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -660,12 +660,6 @@ static int soc21_common_hw_init(void *handle)
>         soc21_program_aspm(adev);
>         /* setup nbio registers */
>         adev->nbio.funcs->init_registers(adev);
> -       /* remap HDP registers to a hole in mmio space,
> -        * for the purpose of expose those registers
> -        * to process space
> -        */
> -       if (adev->nbio.funcs->remap_hdp_registers)
> -               adev->nbio.funcs->remap_hdp_registers(adev);
>         /* enable the doorbell aperture */
>         soc21_enable_doorbell_aperture(adev, true);
>
> --
> 2.25.1
>

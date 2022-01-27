Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D99C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jan 2022 03:06:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A169510E897;
	Thu, 27 Jan 2022 03:06:29 +0000 (UTC)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C02FB10E724
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jan 2022 03:06:27 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id m9so3360513oia.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 19:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Sg4PijTFgqT3EXwpZtXnyyxOZlJyBj33roAU2E66xmg=;
 b=aW1RQnRnymsy14jA4tpaG3HkhUD+56rdFdazJ/jnGz+5+6oDc7/4gcZ19appry0s2t
 t2ICMb8LmQjVcvX009DaVZpZ2IdOOWaYXYQ9tg9m7T+jpoCDx+88Oln0KN3R5rRrHToc
 e0mAuWPqZNKwcJlmkfmrb6fQjFvgW5GgvwkIkmhluT5wAKaDOo9/qkxwzICrmv1gJym4
 N6YTNKFrCBJgB4z11KQEAepByXwqHkYl3SubBqTDY0Y1b2IlXBYM/Ev3GoHbN7JF2LtB
 bCnIG6oolJRNj+wWSAjI81+gp3VHKd4hod6qTUy/UFoG43UO5p0xuJ4NtyiCTjBOsoWX
 vP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Sg4PijTFgqT3EXwpZtXnyyxOZlJyBj33roAU2E66xmg=;
 b=rPNpuyGMFHZaGemJYdP6Cg2pupgDrb/Ofw4Hc/rLBlSb2LzdNQqihzrGdnXOD4mJmm
 50hcif7fXPHS40muG0QfKw2rwIqDxN/qe73hyxDd9ZVWEkxklmV8xvt8bNWeG3mQVz+f
 GCea5NQzrpsrse2dPCmumY+lv4kwbtcs3/GbeJcDD5p1rmHKeLZjmNKdg8juhLsRQSf+
 jzDqHWHzRI+WqryveF7pJA2WVjipancqCctX5r56rBXOSX1JwKiGuJUYNUDvcSkDLXvq
 rsTJO9Q/76cwKAjhhjlGZNgFT/JJS+EGdV1lLA/dYETyvwaRAGRrA5/dgFKEWx9hj+UL
 89WA==
X-Gm-Message-State: AOAM533uFZdZnOcKKbt8A/mXyY1hVd3dOjcntnlfcgOYuP1DyJhu7Xw9
 zVQKA5X5bYI90xqBARiBa1EsctvDUxWFzeLOcLc=
X-Google-Smtp-Source: ABdhPJwwCtOoy2zlVsYDm2FwcwOARL7y2efjXlLmvyP+XGsAsmnJtHOgxzWAIGZxSk5OGdVRvUxw+I5pvkmLxKhP2c0=
X-Received: by 2002:a05:6808:2011:: with SMTP id
 q17mr5791035oiw.199.1643252787004; 
 Wed, 26 Jan 2022 19:06:27 -0800 (PST)
MIME-Version: 1.0
References: <20220127014806.2592589-1-aaron.liu@amd.com>
In-Reply-To: <20220127014806.2592589-1-aaron.liu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 Jan 2022 22:06:15 -0500
Message-ID: <CADnq5_NekOpGfti84KBPL1nHSqb_j7zHhEVZ0s5ZHMBR+O0gKg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: convert code name to ip version for athub
To: Aaron Liu <aaron.liu@amd.com>
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
 Huang Rui <Ray.Huang@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Wed, Jan 26, 2022 at 8:49 PM Aaron Liu <aaron.liu@amd.com> wrote:
>
> Use IP version rather than codename for athub.
>
> Signed-off-by: Aaron Liu <aaron.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/athub_v1_0.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/athub_v1_0.c
> index 3ea557864320..88642e7ecdf4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/athub_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/athub_v1_0.c
> @@ -68,12 +68,13 @@ int athub_v1_0_set_clockgating(struct amdgpu_device *adev,
>         if (amdgpu_sriov_vf(adev))
>                 return 0;
>
> -       switch (adev->asic_type) {
> -       case CHIP_VEGA10:
> -       case CHIP_VEGA12:
> -       case CHIP_VEGA20:
> -       case CHIP_RAVEN:
> -       case CHIP_RENOIR:
> +       switch (adev->ip_versions[ATHUB_HWIP][0]) {
> +       case IP_VERSION(9, 0, 0):
> +       case IP_VERSION(9, 1, 0):
> +       case IP_VERSION(9, 2, 0):
> +       case IP_VERSION(9, 3, 0):
> +       case IP_VERSION(9, 4, 0):
> +       case IP_VERSION(1, 5, 0):
>                 athub_update_medium_grain_clock_gating(adev,
>                                 state == AMD_CG_STATE_GATE);
>                 athub_update_medium_grain_light_sleep(adev,
> --
> 2.25.1
>

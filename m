Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A48EB64D9
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jun 2023 14:04:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75B0610E0E7;
	Thu, 29 Jun 2023 14:04:01 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1603610E0E7
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jun 2023 14:03:59 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3a0642e4695so370140b6e.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jun 2023 07:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688047439; x=1690639439;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FxtJSHJM4VcK4L4UT+Tm+W2J3cD54MeBsQBwF/Qgz9g=;
 b=Sz9IVcA7BdCi0iOOg1FEUOgUKRRrGJeZQhGEVFfFcGAXGA/9ndw8APm1CWF6uuj235
 581CjrDs9xtbYTzYz7bYG6FOzqBq850jXJdm0nG3pEmm3B4QPgCFV9aBa0fXM/Ns8Azd
 h/t4vCZNAIUCoJbM3TbcW3c8Beo13OdIZl15BSdMvd0pnVAayByjiCLJf2zw5pDb3vQD
 ca7r0cI/c1OQRwC9BNfME2L9PVKds36g7WNe+Gmo3JX0ScR6XKRkTcHW1CcORvkhvfxI
 ex8aT2lhesFkY4fnf+2Oatx0HisvmLLkiI9GxrKftKzhbnPWoeCkKvQyUq92K4LxSpQ1
 oN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688047439; x=1690639439;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FxtJSHJM4VcK4L4UT+Tm+W2J3cD54MeBsQBwF/Qgz9g=;
 b=RQePmrfk2mjNLaapNC+cXqm6UuAwUDnFmLOhuqDAnOb7tai1SrFpXLHyqBy2lrdPtP
 TG2dXY5OwgmDJff9zMHL5lTFEimUWQxlkqI/UXH1Rau2sfm8hdOYyuQUtFanls422PQ3
 IXvZnhMSd/T7dtiF/Sc+Nxiu7YMi3XgohC+RJJH0T0nxu9zrAlNtsUn9a2CSniWIUSwU
 vO97rfzs/YDqayJekZDwxzesEEn0Neq8nxiEW7MHCRdzadZ4CSNCmG59AIE7DJU927cS
 nxc3+L91rSWmEZZbPjAIhiiu54iMB7D4oQrupqm+FigIxh6QfXw4o5lLwpabINaOJgM/
 KInQ==
X-Gm-Message-State: AC+VfDzM6PK30wNX5xyTmjR3dz3SnBIvx4gMrgAJkmenU8TkVP1IupPM
 yi4CSD3k+6IMLfkvPbqyN7Fw6l4sh+Gtr06RexE=
X-Google-Smtp-Source: ACHHUZ76c39neaoU5KLIK7PlZSadRFBb1a0Aty2OupMPi7xXHMXCDn570X2zulstnfrwYJDQJ1inV5lOCc8pAuTtlSQ=
X-Received: by 2002:a05:6808:309e:b0:3a1:cbea:3bf2 with SMTP id
 bl30-20020a056808309e00b003a1cbea3bf2mr14051321oib.11.1688047438267; Thu, 29
 Jun 2023 07:03:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230629044635.2266729-1-srinivasan.shanmugam@amd.com>
 <20230629044635.2266729-4-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230629044635.2266729-4-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 29 Jun 2023 10:03:47 -0400
Message-ID: <CADnq5_POiCmv2Pwagxwi4av0TN8hAO6YWpiORXVH4SFYX3Vf7A@mail.gmail.com>
Subject: Re: [PATCH 3/6] drm/amd/display: Clean up warnings in
 amdgpu_dm_pp_smu.c
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Harry Wentland <harry.wentland@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, Jun 29, 2023 at 12:47=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Fixes the following category of checkpatch warning:
>
> WARNING: Block comments use a trailing */ on a separate line
> +                                * non-boosted one. */
>
> WARNING: suspect code indent for conditional statements (8, 24)
> +       if ((adev->asic_type >=3D CHIP_POLARIS10) &&
> [...]
> +                       return true;
>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/d=
rivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
> index 75284e2cec74..848c5b4bb301 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
> @@ -334,7 +334,8 @@ bool dm_pp_get_clock_levels_by_type(
>                         if (dc_clks->clocks_in_khz[i] > validation_clks.e=
ngine_max_clock) {
>                                 /* This clock is higher the validation cl=
ock.
>                                  * Than means the previous one is the hig=
hest
> -                                * non-boosted one. */
> +                                * non-boosted one.
> +                                */
>                                 DRM_INFO("DM_PPLIB: reducing engine clock=
 level from %d to %d\n",
>                                                 dc_clks->num_levels, i);
>                                 dc_clks->num_levels =3D i > 0 ? i : 1;
> @@ -406,10 +407,10 @@ bool dm_pp_notify_wm_clock_changes(
>          * TODO: expand this to other ASICs
>          */
>         if ((adev->asic_type >=3D CHIP_POLARIS10) &&
> -            (adev->asic_type <=3D CHIP_VEGAM) &&
> -            !amdgpu_dpm_set_watermarks_for_clocks_ranges(adev,
> -                                               (void *)wm_with_clock_ran=
ges))
> -                       return true;
> +           (adev->asic_type <=3D CHIP_VEGAM) &&
> +           !amdgpu_dpm_set_watermarks_for_clocks_ranges(adev,
> +                                                        (void *)wm_with_=
clock_ranges))
> +               return true;
>
>         return false;
>  }
> --
> 2.25.1
>

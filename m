Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2068EC54E65
	for <amd-gfx@archiver.kernel.org>; Wed, 21 May 2025 20:24:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 928B910E708;
	Wed, 21 May 2025 20:24:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XSEqsp9b";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11F5710E708
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 20:24:07 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-af907e48e00so629396a12.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 13:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747859046; x=1748463846; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tTsbmBHwCcfhUnHXjabBsTA6GUACFOgRJoVyhx4P5LA=;
 b=XSEqsp9bwFBKx50jBpDvF6UhmFV9/HfcULh23SWqbFRl0FPz4FGOofLrpUsoBfyoSr
 s/+jGDnWy3bbGFDsUhIoTncTLktyb7v/Wdbz45D+L+o2ptkcMkp09DjRK2w52lcJSLDX
 M4847F8+bLlOjX8AttEXJ414FuW6QUx3Twxsl8AZwsPAKMnldRdqA9MsG/nfbGe6ONDt
 0elvk9XrNZtKpkt0ezsVFR4Veb14SEvL7uTchPtJ0ZwyyAt+8S/HhX0kDSrKTwqIj50b
 wnlN1IhZrnl/GogwFiK6ToQjl82DYV7+r0Wb+Z0jiTiZBXfvvUqch4/ka9zQwFJKFUj0
 CxLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747859046; x=1748463846;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tTsbmBHwCcfhUnHXjabBsTA6GUACFOgRJoVyhx4P5LA=;
 b=ueiTSMEL2XsK0gUTXMbdVNgytSl3dWIX5UQ3PqXXdkUeA633z8xbx/wR5FnLJiy58w
 2eiF0NzWTX3ektCRoUiPwpmiootAtwsAjKDIOFenrnp/9lu2l6IZZo0fwJJIgtMMzVPE
 nk8QBo8Niaal8PeLnMR4Pb3qGWF0sjUtZ6CP+NEg/2DmcWxhJ1pq0cSJS2iqJsDdjXrm
 X3Cw1bNZo0bmQViAQ2rbnv2K3w7zDwOTOyGzimQIkSbyusFXYQSoyhfFhzPBZIC+TJOH
 etSLfjRkR1A0xPqQeiUwPS2XSC0XsvfBUou8PvPly7QxHCut0KglfLPot/COt1PNgjuq
 bOaQ==
X-Gm-Message-State: AOJu0YzDv6AiF5YU5SexIYA6O1XxlHuGLZJCjtIzHwIFwwjc9XiZzkGg
 3KclFinXNAnosMueueD3AzkWstEEOaCXm7JBgBm/xKlRh+KlwOOGJ2Sl+9Tv1u+qxtpKIjKhez6
 qpcthv3DlrQydPISDghyHqo8yEz7XH8M=
X-Gm-Gg: ASbGncu5DYwoP3VhLmgwcfrRozpaVo35vKdfS0bTPI2tzUrmchCyV8RCJ7LNXJLNqTm
 dBtdkHHI32LY22OLw3iRDMaeVbN+ApLonuZx+/OMgPBKVqVUIM/vPpcbalrRh3mqigqJKXpjyJ8
 GmCK0aSd82WBcoxLoA0DLb4a0eNUEcNoiMEA==
X-Google-Smtp-Source: AGHT+IGH937AccKPSSVnI9NMZsKsmdmDi71EXfJ70m2aLWCfzn8p7yOHKjx7wbu4yczhp5YCK6jbboGbdd5Qnw8uOBQ=
X-Received: by 2002:a17:902:e80c:b0:224:216e:38bd with SMTP id
 d9443c01a7336-231d43b7fb7mr117535015ad.5.1747859046402; Wed, 21 May 2025
 13:24:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250521201057.76093-1-aurabindo.pillai@amd.com>
In-Reply-To: <20250521201057.76093-1-aurabindo.pillai@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 21 May 2025 16:23:54 -0400
X-Gm-Features: AX0GCFuEMELhYiiRe_fjKQwMOrLuv4es6FAs4eS97CyZtR9inTWDFX246DhN8Eo
Message-ID: <CADnq5_Ma7sJZnDniaNhiD0VQW37nDhpNOKfgXipjH3-xDqCdaQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amd/display: more liberal vmin/vmax update
 for freesync"
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, sunpeng.li@amd.com, harry.wentland@amd.com, 
 alex.hung@amd.com, alexander.deucher@amd.com
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, May 21, 2025 at 4:22=E2=80=AFPM Aurabindo Pillai
<aurabindo.pillai@amd.com> wrote:
>
> This reverts commit 219898d29c438d8ec34a5560fac4ea8f6b8d4f20 since it
> causes regressions on certain configs. Revert until the issue can be
> isolated and debugged.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4238
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 2bb347771aa1..acb5a6baabf4 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -676,21 +676,15 @@ static void dm_crtc_high_irq(void *interrupt_params=
)
>         spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
>
>         if (acrtc->dm_irq_params.stream &&
> -               acrtc->dm_irq_params.vrr_params.supported) {
> -               bool replay_en =3D acrtc->dm_irq_params.stream->link->rep=
lay_settings.replay_feature_enabled;
> -               bool psr_en =3D acrtc->dm_irq_params.stream->link->psr_se=
ttings.psr_feature_enabled;
> -               bool fs_active_var_en =3D acrtc->dm_irq_params.freesync_c=
onfig.state =3D=3D VRR_STATE_ACTIVE_VARIABLE;
> -
> +           acrtc->dm_irq_params.vrr_params.supported &&
> +           acrtc->dm_irq_params.freesync_config.state =3D=3D
> +                   VRR_STATE_ACTIVE_VARIABLE) {
>                 mod_freesync_handle_v_update(adev->dm.freesync_module,
>                                              acrtc->dm_irq_params.stream,
>                                              &acrtc->dm_irq_params.vrr_pa=
rams);
>
> -               /* update vmin_vmax only if freesync is enabled, or only =
if PSR and REPLAY are disabled */
> -               if (fs_active_var_en || (!fs_active_var_en && !replay_en =
&& !psr_en)) {
> -                       dc_stream_adjust_vmin_vmax(adev->dm.dc,
> -                                       acrtc->dm_irq_params.stream,
> -                                       &acrtc->dm_irq_params.vrr_params.=
adjust);
> -               }
> +               dc_stream_adjust_vmin_vmax(adev->dm.dc, acrtc->dm_irq_par=
ams.stream,
> +                                          &acrtc->dm_irq_params.vrr_para=
ms.adjust);
>         }
>
>         /*
> --
> 2.49.0
>

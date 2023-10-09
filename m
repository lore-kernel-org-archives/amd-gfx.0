Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28537E95A91
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 14:45:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAD5610E14A;
	Mon,  9 Oct 2023 14:45:31 +0000 (UTC)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ABCA10E14A
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Oct 2023 14:45:29 +0000 (UTC)
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1dd8304b980so3196329fac.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Oct 2023 07:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696862728; x=1697467528; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m2JjU31DJzgVihPeloJ5bs9pS+jhwwR1NIQy7HWnvFg=;
 b=VeX7Nc7KVYCicyFqzJ4wgc99W7cuHs9zlqyezPdUwFmOb7+fpooIur+Pu8WYpSGN94
 1F7/WBm2SMT+kdr1XnFVdpJLfVzq+9qf7WT7coV5kw1V471m/DTOjBubSOkHED+el17S
 Bupb0X4a2x2OZ/hqJQ2BrHXnPwPrNddp3p1BnmICkfK7O3YFvN8f7M5w6uN9/c+VWOGK
 U4bAVL0jm1C5s8dj8oGqPNONyMhXr0vNguGkBknw3iDDPky0yaayAVT+2pj18jAlQ7Md
 Lx0+P2Ns2wyOp0xYsu8XAxbqzK2RcNTEv/qNYV43FzKMiCb6ekgFdSFNMkyu4Eqr+Vbd
 HLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696862728; x=1697467528;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m2JjU31DJzgVihPeloJ5bs9pS+jhwwR1NIQy7HWnvFg=;
 b=oMIQ7sxzVcjOWquP2yKGiKtSvpFeNjx9gBTP30w8QLj98ezysgyEGb15UqJDtbqjP2
 t+OVb4Ppxfq4B4tq0RyEWUzCCKIgNK+kP4832HsfOZAIqFV9pdsBo4U7Na1tPYe3HU4s
 m+wQz3XughOACa8o1DFKQAvbFBHwGJ8YVk3O9m8Bc1wxtvZtIC0Z2EWvWWem+gGQMJkU
 BYtFwNzAqO7rK/ryixqv6zj8tCvm4fJE9bbqKgwxvJOO9Ad8Q6vzAv7Z3/S5jNrzTaWI
 UvDDS0uU9rM8XVMuSY1Ms3bjkuyr37clcFbPSLD7Cp1vIXgU7JUkIJsNcM4VFHFGRU2a
 HaIw==
X-Gm-Message-State: AOJu0YwOFRqcvFAygEmav1kxKW9FzQKS9lNeRCagqHhXywYd7RhyE7uJ
 91tEbyq1+jlwcE2HN4eIUaIWImJ2X55t7dkrudD53+nFBfQ=
X-Google-Smtp-Source: AGHT+IHuOZ/W/WNozhDsop8QuoayKONV4Us0bkraN6I729PxEEZ9mXy0VhzZRcfm0Are1KbyPcyfKv2jz6PTzkmYR28=
X-Received: by 2002:a05:6870:9f84:b0:1e5:6286:e50e with SMTP id
 xm4-20020a0568709f8400b001e56286e50emr12544028oab.17.1696862728313; Mon, 09
 Oct 2023 07:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <20231006185026.5536-1-mario.limonciello@amd.com>
 <20231006185026.5536-7-mario.limonciello@amd.com>
In-Reply-To: <20231006185026.5536-7-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Oct 2023 10:45:17 -0400
Message-ID: <CADnq5_PktDUsPaRuvFhssunh-emFi0KwJ=Xjg0A3_uK8FHCyTw@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] drm/amd/display: Destroy DC context while keeping
 DML and DML2
To: Mario Limonciello <mario.limonciello@amd.com>
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
Cc: Harry.Wentland@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sat, Oct 7, 2023 at 3:47=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> If there is memory pressure at suspend time then dynamically
> allocating a large structure as part of DC suspend code will
> fail.
>
> Instead re-use the same structures and clear all members except
> those that should be maintained.
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2362
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
> v4->v5:
>  * Rebase for DML2
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c      | 37 -------------------
>  .../gpu/drm/amd/display/dc/core/dc_resource.c | 12 ++++++
>  2 files changed, 12 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/a=
md/display/dc/core/dc.c
> index 2436a293931b..55e7b5a8ec8e 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -4704,12 +4704,6 @@ bool dc_set_power_state(
>         struct dc *dc,
>         enum dc_acpi_cm_power_state power_state)
>  {
> -       struct kref refcount;
> -       struct display_mode_lib *dml;
> -#ifdef CONFIG_DRM_AMD_DC_FP
> -       struct dml2_context *dml2 =3D NULL;
> -#endif
> -
>         if (!dc->current_state)
>                 return true;
>
> @@ -4728,40 +4722,9 @@ bool dc_set_power_state(
>
>                 break;
>         default:
> -#ifdef CONFIG_DRM_AMD_DC_FP
> -               if (dc->debug.using_dml2)
> -                       dml2 =3D dc->current_state->bw_ctx.dml2;
> -#endif
>                 ASSERT(dc->current_state->stream_count =3D=3D 0);
> -               /* Zero out the current context so that on resume we star=
t with
> -                * clean state, and dc hw programming optimizations will =
not
> -                * cause any trouble.
> -                */
> -               dml =3D kzalloc(sizeof(struct display_mode_lib),
> -                               GFP_KERNEL);
> -
> -               ASSERT(dml);
> -               if (!dml)
> -                       return false;
> -
> -               /* Preserve refcount */
> -               refcount =3D dc->current_state->refcount;
> -               /* Preserve display mode lib */
> -               memcpy(dml, &dc->current_state->bw_ctx.dml, sizeof(struct=
 display_mode_lib));
>
>                 dc_resource_state_destruct(dc->current_state);
> -               memset(dc->current_state, 0,
> -                               sizeof(*dc->current_state));
> -
> -               dc->current_state->refcount =3D refcount;
> -               dc->current_state->bw_ctx.dml =3D *dml;
> -
> -               kfree(dml);
> -
> -#ifdef CONFIG_DRM_AMD_DC_FP
> -               if (dc->debug.using_dml2)
> -                       dc->current_state->bw_ctx.dml2 =3D dml2;
> -#endif
>
>                 break;
>         }
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/=
gpu/drm/amd/display/dc/core/dc_resource.c
> index c1e2f0e10ab2..e2c7acdff301 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -4357,6 +4357,18 @@ void dc_resource_state_destruct(struct dc_state *c=
ontext)
>                 context->streams[i] =3D NULL;
>         }
>         context->stream_count =3D 0;
> +       context->stream_mask =3D 0;
> +       memset(&context->res_ctx, 0, sizeof(context->res_ctx));
> +       memset(&context->pp_display_cfg, 0, sizeof(context->pp_display_cf=
g));
> +       memset(&context->dcn_bw_vars, 0, sizeof(context->dcn_bw_vars));
> +       context->clk_mgr =3D NULL;
> +       memset(&context->bw_ctx.bw, 0, sizeof(context->bw_ctx.bw));
> +       memset(context->block_sequence, 0, sizeof(context->block_sequence=
));
> +       context->block_sequence_steps =3D 0;
> +       memset(context->dc_dmub_cmd, 0, sizeof(context->dc_dmub_cmd));
> +       context->dmub_cmd_count =3D 0;
> +       memset(&context->perf_params, 0, sizeof(context->perf_params));
> +       memset(&context->scratch, 0, sizeof(context->scratch));
>  }
>
>  void dc_resource_state_copy_construct(
> --
> 2.34.1
>

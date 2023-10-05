Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 067DFE92705
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Oct 2023 14:27:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A049310E3E1;
	Thu,  5 Oct 2023 14:27:56 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E43B010E3E0
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Oct 2023 14:27:54 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-1dcead29b3eso632356fac.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Oct 2023 07:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696516074; x=1697120874; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sf4MPuomKyF3o4nq9CG0rFXGezopddzvy4wnl+9KMTA=;
 b=ZJR3NKkOrA8zCsZzlBkyHIdoWZIdJZqUFvWplyNXwNlGehFNgv7HB+xOS0+twp16sw
 ntocnHnyK4UAmPyHjBj65kBMc4E13/n4oLwNS2GLPsoaUmi4c0I3WzmSHBINmmMkQwpV
 kstPXFtB4/vIzlNcuYXq41nZnkXOWMNP2HT+2cSmlkiWDKq5mAocRjDMl2SnHLEWLMjw
 OddvGXXRtD9BngfguuAQU1Z6eTqOmgzot/BqCj1/28/3Gok5EBJ3Mglhv3QESDBz7dir
 3rRW4lzqlwwp/WmPz5ZuRGlVcfYXqZLtBJ9WnZyicdO0lHPRZC8ARwDAdyy0ILWSbTv4
 /eJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696516074; x=1697120874;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sf4MPuomKyF3o4nq9CG0rFXGezopddzvy4wnl+9KMTA=;
 b=WsNSEL/+mUJyKZ9ZaJyus3Hm8ZiBACJ4y+B1NLWUIflFlIpIDhz/lxIsOvnrQNxLvw
 CIdXiMFRgNspV0nlEDYh6knV21/JYX9xJ0vbb5t1/Jc1VyLHBUL9LgLl/uub6T3Y+aTT
 qDn9YxSKIw0mlyT2hJfCq7k/6oUB6XW8jaDrOiMUF6eDZqzooAfnmgb+N2dVPTov6lDb
 +B3lRR2QddOHrqykAI2Frs+gqoWqfyYiI5ARviyMIOpYPDJdGW4I++N79HxUh1jIiEXi
 kFSogo7l8xwvav1UAKGrokQdhDca/VBa8dSkccTlrMFy2Ym18SnJG1H0I2uQ+KlGbAr3
 3gIw==
X-Gm-Message-State: AOJu0YxoR2KY0zLFS0zpe2SxX+59xmS6j/vJqsne2o3hbmu5OfoOIaJc
 kg7KytPF8sFRdkUQlMqrLA71O0FK1omn3TRc8b0QeT4OJwU=
X-Google-Smtp-Source: AGHT+IEt0kP5YlZeVUBVbfxIvX8t/Lng2yhGM+nebqViKUR9lp3ogxZpaBf+NQ/O1WYbyGuHDjk0z51mubv2X53ov4U=
X-Received: by 2002:a05:6870:71cb:b0:1dc:f539:ad70 with SMTP id
 p11-20020a05687071cb00b001dcf539ad70mr6014391oag.56.1696516074075; Thu, 05
 Oct 2023 07:27:54 -0700 (PDT)
MIME-Version: 1.0
References: <20231004171838.168215-1-mario.limonciello@amd.com>
 <20231004171838.168215-3-mario.limonciello@amd.com>
In-Reply-To: <20231004171838.168215-3-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 5 Oct 2023 10:27:43 -0400
Message-ID: <CADnq5_PU9pzxR4gfVP=-X9YVGYMmqa74qRU-Qm0kxn7BQfivtw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] drm/amd/display: Destroy DC context while keeping
 DML
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

On Wed, Oct 4, 2023 at 1:37=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> If there is memory pressure at suspend time then dynamically
> allocating a large structure as part of DC suspend code will
> fail.
>
> Instead re-use the same structure and clear all members except
> those that should be maintained.
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2362
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c      | 25 -------------------
>  .../gpu/drm/amd/display/dc/core/dc_resource.c | 12 +++++++++
>  2 files changed, 12 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/a=
md/display/dc/core/dc.c
> index 39e291a467e2..cb8c7c5a8807 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -4728,9 +4728,6 @@ bool dc_set_power_state(
>         struct dc *dc,
>         enum dc_acpi_cm_power_state power_state)
>  {
> -       struct kref refcount;
> -       struct display_mode_lib *dml;
> -
>         if (!dc->current_state)
>                 return true;
>
> @@ -4750,30 +4747,8 @@ bool dc_set_power_state(
>                 break;
>         default:
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

The dml dance seems a bit weird.  I guess it's here because
dc_resource_state_destruct() might change it?  Can we safely drop
this?  If we do need it, we could pre-allocate a dml structure and use
that.

Alex

> -
> -               kfree(dml);
>
>                 break;
>         }
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/=
gpu/drm/amd/display/dc/core/dc_resource.c
> index aa7b5db83644..e487c966c118 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -4350,6 +4350,18 @@ void dc_resource_state_destruct(struct dc_state *c=
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

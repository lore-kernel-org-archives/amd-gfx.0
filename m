Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 501EFC25B78
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jun 2024 13:40:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C14D810E48A;
	Tue,  4 Jun 2024 13:40:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R1u0dEG+";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C38CB10E48A
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jun 2024 13:40:24 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-1f44b45d6abso9845005ad.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Jun 2024 06:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717508424; x=1718113224; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NSUDzcMHusMQMJrRkH47S84n0UbcC25q/h4+rNbqt7c=;
 b=R1u0dEG+lj5YwB6+Wtq30jCNBDVF7lqgvro8G7Sn5fiVR+LO0bSdD+yvvGXUyLWx8Y
 haQV6VFILM7KDjQ/DwufmiPm0sSnV2yQQluw2YHgX85BEbDZR9vt4Qf3yomszvSfWmuj
 /+kks8z603hmxUMhvHHupDuIzzChBi5YOGUCDoTFWko/sFr1GlA/Yupza1b4EHMZE7jt
 Lczp/qGlb5gh1amozLIPKZ7Uy5x3a/ljFYv9nfLwT5t6azfdcrD2TV9iw18uYqCZx4wP
 BOjSFmzqY4ORJwbA4xihYwQwTTy5oNwL2CnMBGalpqMPnZWrTyBB+PcssUy/cCfgBxOW
 TO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717508424; x=1718113224;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NSUDzcMHusMQMJrRkH47S84n0UbcC25q/h4+rNbqt7c=;
 b=AuAwX157GS5YGCAl81ch7EsDssOuCgftRQIG8pdL5V5UsmMigNmPW+bFoj5h2Q1WQr
 75swoZEOK1sVMcRX9p3B5sn2KpSc0Knjyb3otRrVPKMP31fNS9VwdcHE3S4Zh452nv48
 4joJ+0D+vtBo1wNpdPSaYp0fQhpjYiEQC17hj2QuLfhxlsTX6BkIZCa8tj5rad1T6OQI
 tOZN/Hl/i+CobCgk6vrEGy531qEuyvhJP8VrNrv1BVw2mQ3oCArV66PEkkVVdoPMjaTF
 6G57jWqXuNwrAg7sqJJDSgMYh6v8c7DMlaS/+Dt3s5l+v5Jj1COD2/XWyQdQPQhBXbiw
 v76Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVG2L4JT9TRn2giwVpeBAOuRUnqd4i8OZwt7VGpSdz2eRKFwqtOMWh60DaRIPzjVUObZk5JBMCs7P40zGaRnU7TEW9v+V+lTuOEDSkH9g==
X-Gm-Message-State: AOJu0YxmNgrZjwxc+76fRgkt7JRv3VxTn0aJnMdsao7ShPd8VemBcZSa
 9F6zV3Jez/LIOmOGJRvr/l6VEvjg7KOn2CyPWd4vkP6porcLFHFxADqwGVcOJYn7CrpNgm6q6R7
 i+i2L7c6TvuEeTYtjHZ/xH256wBxTmcao
X-Google-Smtp-Source: AGHT+IFMbSNC5o+yPEAVb6iT1HlzGreWd787xgknj2fLIq9S/zGgdX6Irx1iB5vH9nWZB8JplYR/+v+EJPXmUL/ogD0=
X-Received: by 2002:a17:90a:fc4b:b0:2b6:227a:50bd with SMTP id
 98e67ed59e1d1-2c1dc5d890fmr10018169a91.46.1717508424060; Tue, 04 Jun 2024
 06:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240603205918.28435-1-george.zhang@amd.com>
In-Reply-To: <20240603205918.28435-1-george.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 4 Jun 2024 09:40:11 -0400
Message-ID: <CADnq5_PuYPuj4Ok_tXRFRFhXydOqFm6XyEmDFQ+W3_0RS0ZN3A@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amd/display: dynamically allocate
 dml2_configuration_options structures"
To: George Zhang <george.zhang@amd.com>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, 
 alexander.deucher@amd.com, arnd@arndb.de, amd-gfx@lists.freedesktop.org
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

On Mon, Jun 3, 2024 at 5:07=E2=80=AFPM George Zhang <george.zhang@amd.com> =
wrote:
>
> This reverts commit 416b5c5eec9e708b31c68f00cb79130f2cfaf7ed.
>
> This patch caused a regression on DCN 3.2 on the IGT test assr-links-susp=
end, with
> the dmesg warning:
>
> BUG: sleeping function called from invalid context at include/linux/sched=
/mm.h:306
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 449, name: kworker=
/u64:8
> preempt_count: 2, expected: 0
> RCU nest depth: 0, expected: 0
> Preemption disabled at:
> ffffffffc0ce1580>] dc_fpu_begin+0x30/0xd0 [amdgpu]
> CPU: 5 PID: 449 Comm: kworker/u64:8 Tainted: G        W          6.8.0+ #=
35
> Hardware name: System manufacturer System Product Name/ROG STRIX X570-E G=
AMING WIFI II, BIOS 4204 02/24/2022
> Workqueue: events_unbound async_run_entry_fn
>
> Reverting this patch will re-introduce stack size warnings.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: George Zhang <george.zhang@amd.com>
> ---
>  .../display/dc/resource/dcn32/dcn32_resource.c   | 16 +++++-----------
>  .../display/dc/resource/dcn321/dcn321_resource.c | 16 +++++-----------
>  2 files changed, 10 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource=
.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> index 0f11d7c8791c..022d320be1d5 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> @@ -2007,27 +2007,21 @@ void dcn32_calculate_wm_and_dlg(struct dc *dc, st=
ruct dc_state *context,
>
>  static void dcn32_update_bw_bounding_box(struct dc *dc, struct clk_bw_pa=
rams *bw_params)
>  {
> -       struct dml2_configuration_options *dml2_opt;
> -
> -       dml2_opt =3D kmemdup(&dc->dml2_options, sizeof(dc->dml2_options),=
 GFP_KERNEL);

Instead of reverting, you could change this from GFP_KERNEL to
GFP_ATOMIC.  This aligns with similar allocations in the other
resource files.  Same comment on the allocation below.

That said, to Arnd's point, I'm not sure about FP in atomic contexts.

Alex

> -       if (!dml2_opt)
> -               return;
> +       struct dml2_configuration_options dml2_opt =3D dc->dml2_options;
>
>         DC_FP_START();
>
>         dcn32_update_bw_bounding_box_fpu(dc, bw_params);
>
> -       dml2_opt->use_clock_dc_limits =3D false;
> +       dml2_opt.use_clock_dc_limits =3D false;
>         if (dc->debug.using_dml2 && dc->current_state && dc->current_stat=
e->bw_ctx.dml2)
> -               dml2_reinit(dc, dml2_opt, &dc->current_state->bw_ctx.dml2=
);
> +               dml2_reinit(dc, &dml2_opt, &dc->current_state->bw_ctx.dml=
2);
>
> -       dml2_opt->use_clock_dc_limits =3D true;
> +       dml2_opt.use_clock_dc_limits =3D true;
>         if (dc->debug.using_dml2 && dc->current_state && dc->current_stat=
e->bw_ctx.dml2_dc_power_source)
> -               dml2_reinit(dc, dml2_opt, &dc->current_state->bw_ctx.dml2=
_dc_power_source);
> +               dml2_reinit(dc, &dml2_opt, &dc->current_state->bw_ctx.dml=
2_dc_power_source);
>
>         DC_FP_END();
> -
> -       kfree(dml2_opt);
>  }
>
>  static struct resource_funcs dcn32_res_pool_funcs =3D {
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resour=
ce.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
> index 07ca6f58447d..e4b360d89b3b 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
> @@ -1581,27 +1581,21 @@ static struct dc_cap_funcs cap_funcs =3D {
>
>  static void dcn321_update_bw_bounding_box(struct dc *dc, struct clk_bw_p=
arams *bw_params)
>  {
> -       struct dml2_configuration_options *dml2_opt;
> -
> -       dml2_opt =3D kmemdup(&dc->dml2_options, sizeof(dc->dml2_options),=
 GFP_KERNEL);
> -       if (!dml2_opt)
> -               return;
> +       struct dml2_configuration_options dml2_opt =3D dc->dml2_options;
>
>         DC_FP_START();
>
>         dcn321_update_bw_bounding_box_fpu(dc, bw_params);
>
> -       dml2_opt->use_clock_dc_limits =3D false;
> +       dml2_opt.use_clock_dc_limits =3D false;
>         if (dc->debug.using_dml2 && dc->current_state && dc->current_stat=
e->bw_ctx.dml2)
> -               dml2_reinit(dc, dml2_opt, &dc->current_state->bw_ctx.dml2=
);
> +               dml2_reinit(dc, &dml2_opt, &dc->current_state->bw_ctx.dml=
2);
>
> -       dml2_opt->use_clock_dc_limits =3D true;
> +       dml2_opt.use_clock_dc_limits =3D true;
>         if (dc->debug.using_dml2 && dc->current_state && dc->current_stat=
e->bw_ctx.dml2_dc_power_source)
> -               dml2_reinit(dc, dml2_opt, &dc->current_state->bw_ctx.dml2=
_dc_power_source);
> +               dml2_reinit(dc, &dml2_opt, &dc->current_state->bw_ctx.dml=
2_dc_power_source);
>
>         DC_FP_END();
> -
> -       kfree(dml2_opt);
>  }
>
>  static struct resource_funcs dcn321_res_pool_funcs =3D {
> --
> 2.34.1
>

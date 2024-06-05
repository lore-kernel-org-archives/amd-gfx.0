Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9493AC27C53
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 12:55:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B04F10E346;
	Wed,  5 Jun 2024 12:55:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lOPFvoT2";
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5DCD10E346
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jun 2024 12:55:53 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-6c4829d7136so1626990a12.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Jun 2024 05:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717592153; x=1718196953; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GUpeC1ruSsyCxTGlFf7qAiZGi40NU4p7TI48sxIyK0I=;
 b=lOPFvoT2Z2/OTw6gT06z269BcZIu34PU46g1N6z1orryijBkfhXTFPUQyBpUDKkTyt
 Wfo3SqIZ8kWQsrtKkjAtCL66h6R5VlBpdnMLnqfSzIN8hmfuTKYv/0MZ078gt0TpnOJf
 Xwv9B6tqxm/O+KRkc8fEMnV5ACZzW2VRCJNQ+s/LYhw7dd/xrUpD17szVdaIxZj9Kpxu
 dPfdWNRPNTP7l/EdNEm98QFwziG3TR6Wko0z3oK7FSNdijAlRkpcUPiHtaxJ/GSwn+eh
 3gD6p1ehu7ltLSeI3nFTxI6vVbdl1G/YaxJ1+SQhVteA3kYOZFTstmamsn6RYdjcJ2sb
 sKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717592153; x=1718196953;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GUpeC1ruSsyCxTGlFf7qAiZGi40NU4p7TI48sxIyK0I=;
 b=lz9QeaeZMjzDbNdjf60uWJzAEp7Vker81cOAM+DrOW+xbDInz1C7ShKZeQQi5rBjHk
 lo3F0uNN9Zccsxhr31V1tmBdSJK8Cxh//DWNa5cVI4RGdMhZX70961Z5CGISelpwUivG
 V02SacaOUiZ3lFaD+YvFUKG+RNJ6Ol1oG2GgK1XFHnXwimxSU2waAI2zdrgLpm7FdvyG
 FufsCgSJM/ITZXH7r0Y664s3ocoIMBhkKBvPnnXtW0Q9X1zFxNNDFFQZvICeGL3FTxT4
 KzFJRwbdfS7RqH9/Hp/jhemHCUUt78skWomfbaSjYREEsWTfuFavm5Go9c2E59qr3n1p
 QjmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlFPIFBymY0tUFoK9Vs0RTdx9YEUhVLvh4uId8q3EZywyuisf+6PkHvsk4kxKsm29QWRw6j6EFVftA+avY+tsD2aVyRsQeQj78SDYpuA==
X-Gm-Message-State: AOJu0YzqQ38xjeLZGSS7itzRcFDkjL/XCVUzgP2u4PMNM9VKJz+46Ymw
 bX3oBfmhEuLbtEeH4fpk6b8NlGY5/qJTT8duclvLL6Xp22heTGRnV/tIsGAWqLrigdxW9L0cOCk
 umo4nMsvnJASQLZbzYe/czZzaORLD0Q==
X-Google-Smtp-Source: AGHT+IEnVzBXIbYn+SDrszrI0ac9diqMEP2aGfN3h5J1hBlw5AICBon4Y62/e+2jKq5H7FSfir5M/OHInyTdaHTLGNo=
X-Received: by 2002:a17:90a:9917:b0:2c1:972b:4910 with SMTP id
 98e67ed59e1d1-2c27daf6644mr2559757a91.2.1717592152807; Wed, 05 Jun 2024
 05:55:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240604155027.542271-1-alexander.deucher@amd.com>
 <CY8PR12MB7415814E1314E87EA7F1D23C94F82@CY8PR12MB7415.namprd12.prod.outlook.com>
 <CH0PR12MB5284AB4DA3FEB753DCBF77F48BF92@CH0PR12MB5284.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB5284AB4DA3FEB753DCBF77F48BF92@CH0PR12MB5284.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 5 Jun 2024 08:55:40 -0400
Message-ID: <CADnq5_PWm9Y4CM840SqGS1mDCtkty+=RroK=UGHxjaY=o77K5Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: use pre-allocated temp structure for
 bounding box
To: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
Cc: "Zhang, George" <George.Zhang@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Mahfooz,
 Hamza" <Hamza.Mahfooz@amd.com>, 
 Arnd Bergmann <arnd@arndb.de>, "Wentland, Harry" <Harry.Wentland@amd.com>, 
 "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>
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

I sent a separate patch for DCN 401.

On Wed, Jun 5, 2024 at 8:37=E2=80=AFAM Pillai, Aurabindo
<Aurabindo.Pillai@amd.com> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>
> Hi Alex,
>
> I'll a hunk for fixing DCN401 as well to this and resend it later today.
>
>
> --
>
> Regards,
> Jay
> ________________________________
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Zhang,=
 George <George.Zhang@amd.com>
> Sent: Tuesday, June 4, 2024 12:49 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedes=
ktop.org <amd-gfx@lists.freedesktop.org>
> Cc: Mahfooz, Hamza <Hamza.Mahfooz@amd.com>; Arnd Bergmann <arnd@arndb.de>=
; Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@=
amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>
> Subject: RE: [PATCH] drm/amd/display: use pre-allocated temp structure fo=
r bounding box
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Tested-by: George Zhang <George.zhang@amd.com>
>
> Thanks,
> George
> -----Original Message-----
> From: Deucher, Alexander <Alexander.Deucher@amd.com>
> Sent: Tuesday, June 4, 2024 11:50 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Mahfooz, Hamza <Hamza=
.Mahfooz@amd.com>; Zhang, George <George.Zhang@amd.com>; Arnd Bergmann <arn=
d@arndb.de>; Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <=
Sunpeng.Li@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>
> Subject: [PATCH] drm/amd/display: use pre-allocated temp structure for bo=
unding box
>
> This mirrors what the driver does for older DCN generations.
>
> Should fix:
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
> Fixes: 88c61827cedc ("drm/amd/display: dynamically allocate dml2_configur=
ation_options structures")
> Suggested-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: George Zhang <george.zhang@amd.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: harry.wentland@amd.com
> Cc: sunpeng.li@amd.com
> Cc: Rodrigo.Siqueira@amd.com
> ---
>  drivers/gpu/drm/amd/display/dc/dc.h                       | 1 +
>  .../drm/amd/display/dc/resource/dcn32/dcn32_resource.c    | 8 +++-----
>  .../drm/amd/display/dc/resource/dcn321/dcn321_resource.c  | 8 +++-----
>  3 files changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/di=
splay/dc/dc.h
> index d0ed01ac460d..d843933ad731 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -1444,6 +1444,7 @@ struct dc {
>         } scratch;
>
>         struct dml2_configuration_options dml2_options;
> +       struct dml2_configuration_options dml2_tmp;
>         enum dc_acpi_cm_power_state power_state;
>
>  };
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource=
.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> index 0f11d7c8791c..7a8aa9396dea 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> @@ -2007,11 +2007,9 @@ void dcn32_calculate_wm_and_dlg(struct dc *dc, str=
uct dc_state *context,
>
>  static void dcn32_update_bw_bounding_box(struct dc *dc, struct clk_bw_pa=
rams *bw_params)
>  {
> -       struct dml2_configuration_options *dml2_opt;
> +       struct dml2_configuration_options *dml2_opt =3D &dc->dml2_tmp;
>
> -       dml2_opt =3D kmemdup(&dc->dml2_options, sizeof(dc->dml2_options),=
 GFP_KERNEL);
> -       if (!dml2_opt)
> -               return;
> +       memcpy(dml2_opt, &dc->dml2_options, sizeof(dc->dml2_options));
>
>         DC_FP_START();
>
> @@ -2027,7 +2025,7 @@ static void dcn32_update_bw_bounding_box(struct dc =
*dc, struct clk_bw_params *bw
>
>         DC_FP_END();
>
> -       kfree(dml2_opt);
> +       memcpy(&dc->dml2_options, dml2_opt, sizeof(dc->dml2_options));
>  }
>
>  static struct resource_funcs dcn32_res_pool_funcs =3D {
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resour=
ce.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
> index 07ca6f58447d..ef30e8632607 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
> @@ -1581,11 +1581,9 @@ static struct dc_cap_funcs cap_funcs =3D {
>
>  static void dcn321_update_bw_bounding_box(struct dc *dc, struct clk_bw_p=
arams *bw_params)
>  {
> -       struct dml2_configuration_options *dml2_opt;
> +       struct dml2_configuration_options *dml2_opt =3D &dc->dml2_tmp;
>
> -       dml2_opt =3D kmemdup(&dc->dml2_options, sizeof(dc->dml2_options),=
 GFP_KERNEL);
> -       if (!dml2_opt)
> -               return;
> +       memcpy(dml2_opt, &dc->dml2_options, sizeof(dc->dml2_options));
>
>         DC_FP_START();
>
> @@ -1601,7 +1599,7 @@ static void dcn321_update_bw_bounding_box(struct dc=
 *dc, struct clk_bw_params *b
>
>         DC_FP_END();
>
> -       kfree(dml2_opt);
> +       memcpy(&dc->dml2_options, dml2_opt, sizeof(dc->dml2_options));
>  }
>
>  static struct resource_funcs dcn321_res_pool_funcs =3D {
> --
> 2.45.1
>

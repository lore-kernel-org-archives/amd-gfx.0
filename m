Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3008BC25B76
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 16:37:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CD3F88130;
	Wed,  5 Jun 2024 16:37:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TNukjLol";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF46F892F6
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jun 2024 16:37:30 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-1f67fa9cd73so8374505ad.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Jun 2024 09:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717605450; x=1718210250; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jdP3T/x26lGECMJx5Cs/VKtwdOnxD5C6t+9qO4X8xXo=;
 b=TNukjLolgayNunqDzrO42zjfI3TD493kxOr+b7Cle9ryJzak1daG5qfxxCDf3PerWk
 cy6sBhbGlA9EOJAzKL6wkFEDkeqKhWOIGnT2cTp6Fhj9PGLaXdsvr/YFsokxrA3BwX4K
 ryrT0ppnGWK5+QXa7UlaXYqQlo4e69VXjFaeh4L3uX9eZk94n14dg+T1wcBvygrI4bDg
 olVUq9oI123LQYTXlY5ifiHIsRaSSLnLoWW3WWrUlLspJeOqVyZU/Ujqp77NGQ9CmLUH
 ff8+2niUArhY5Ryeqy4yxQPnTeciMm4TTUatavZrzS7/9CFw62CyE8jQ6ow7zu7SyOJL
 GH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717605450; x=1718210250;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jdP3T/x26lGECMJx5Cs/VKtwdOnxD5C6t+9qO4X8xXo=;
 b=Y3mLRM+QURcWDil4TgGAVAr4ZeVHAHFrsD4FE1ctNN0UVi7sgs9butoy9XKaP1/L2y
 jzhEXOYeKHpzAmTDTdAcpQCebfEwU0z0+0igW4dzY3IOxWbkMmpD+XwlsyqXhSmx+EFE
 bJgBU8U5paYHPcmtPuKJtdIMq9QT03QgXACrpsuT0OMAzN+xUAT8ckxlb+EMOLIyKoSW
 lD8X2LO/TvhGVgDaYAYULOUqIfqAuHU1Tz9pOrtXZkdoqpwo8d4K2A9/1OdXWR7PUGmY
 krhtq4YE2mH1MZh1UEoFIhmhwGbupj1yM350CveCPtaF1H0T5HO1Xr0PWhqEfJ7S+YBc
 v5ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGKjSrgV0nrml4sqUxEiZLOA2FvfQxcnWe5SvzjhBZikPTVboce5grL6aoVTQBzxVc3vv5m+R4YQMRUEMGFYr4O/pFY+kTfpMXf5y+yw==
X-Gm-Message-State: AOJu0YyDn8RVsCy6RYejJngLVRlJaIBPJXJMsZgd56sA2gdDJaoI45bl
 zPevS/jG1KHULpX1DRiVxuywn/xb/Vq8henAzURmdd/FLfaeRBpapG1I407TItnXh1JtUO6z8tB
 4fT7ePESXmgvmQdmsot5jbuKtkxw=
X-Google-Smtp-Source: AGHT+IHb5uuSiu84PpN6TKnnmwrWyvvnN+W5CqUroyONhd/nt+Td0ncMwbYRj0faDtCxxjElQ5rcfiwGE2nVcrU7GBA=
X-Received: by 2002:a17:903:18e:b0:1f6:83d1:a232 with SMTP id
 d9443c01a7336-1f6b8ea1732mr2444655ad.10.1717605450057; Wed, 05 Jun 2024
 09:37:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240604155027.542271-1-alexander.deucher@amd.com>
 <570fd5ec-1fe1-4d75-b4aa-1ec579a0bcd0@amd.com>
In-Reply-To: <570fd5ec-1fe1-4d75-b4aa-1ec579a0bcd0@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 5 Jun 2024 12:37:17 -0400
Message-ID: <CADnq5_M62BwoPEfitxk-+SRjZbEP-uvUesxuHjw1WX7CSZVHhg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: use pre-allocated temp structure for
 bounding box
To: Harry Wentland <harry.wentland@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 Hamza Mahfooz <hamza.mahfooz@amd.com>, George Zhang <george.zhang@amd.com>,
 Arnd Bergmann <arnd@arndb.de>, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com
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

On Wed, Jun 5, 2024 at 12:07=E2=80=AFPM Harry Wentland <harry.wentland@amd.=
com> wrote:
>
>
>
> On 2024-06-04 11:50, Alex Deucher wrote:
> > This mirrors what the driver does for older DCN generations.
> >
> > Should fix:
> >
> > BUG: sleeping function called from invalid context at include/linux/sch=
ed/mm.h:306
> > in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 449, name: kwork=
er/u64:8
> > preempt_count: 2, expected: 0
> > RCU nest depth: 0, expected: 0
> > Preemption disabled at:
> > ffffffffc0ce1580>] dc_fpu_begin+0x30/0xd0 [amdgpu]
> > CPU: 5 PID: 449 Comm: kworker/u64:8 Tainted: G        W          6.8.0+=
 #35
> > Hardware name: System manufacturer System Product Name/ROG STRIX X570-E=
 GAMING WIFI II, BIOS 4204 02/24/2022
> > Workqueue: events_unbound async_run_entry_fn
> >
> > Fixes: 88c61827cedc ("drm/amd/display: dynamically allocate dml2_config=
uration_options structures")
> > Suggested-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > Cc: George Zhang <george.zhang@amd.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: harry.wentland@amd.com
> > Cc: sunpeng.li@amd.com
> > Cc: Rodrigo.Siqueira@amd.com
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>

Please review v2 of the patches.  There was an extra memcpy in the original=
s.

Alex

> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/dc/dc.h                       | 1 +
> >  .../drm/amd/display/dc/resource/dcn32/dcn32_resource.c    | 8 +++-----
> >  .../drm/amd/display/dc/resource/dcn321/dcn321_resource.c  | 8 +++-----
> >  3 files changed, 7 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/=
display/dc/dc.h
> > index d0ed01ac460d..d843933ad731 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dc.h
> > +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> > @@ -1444,6 +1444,7 @@ struct dc {
> >       } scratch;
> >
> >       struct dml2_configuration_options dml2_options;
> > +     struct dml2_configuration_options dml2_tmp;
> >       enum dc_acpi_cm_power_state power_state;
> >
> >  };
> > diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resour=
ce.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> > index 0f11d7c8791c..7a8aa9396dea 100644
> > --- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> > @@ -2007,11 +2007,9 @@ void dcn32_calculate_wm_and_dlg(struct dc *dc, s=
truct dc_state *context,
> >
> >  static void dcn32_update_bw_bounding_box(struct dc *dc, struct clk_bw_=
params *bw_params)
> >  {
> > -     struct dml2_configuration_options *dml2_opt;
> > +     struct dml2_configuration_options *dml2_opt =3D &dc->dml2_tmp;
> >
> > -     dml2_opt =3D kmemdup(&dc->dml2_options, sizeof(dc->dml2_options),=
 GFP_KERNEL);
> > -     if (!dml2_opt)
> > -             return;
> > +     memcpy(dml2_opt, &dc->dml2_options, sizeof(dc->dml2_options));
> >
> >       DC_FP_START();
> >
> > @@ -2027,7 +2025,7 @@ static void dcn32_update_bw_bounding_box(struct d=
c *dc, struct clk_bw_params *bw
> >
> >       DC_FP_END();
> >
> > -     kfree(dml2_opt);
> > +     memcpy(&dc->dml2_options, dml2_opt, sizeof(dc->dml2_options));
> >  }
> >
> >  static struct resource_funcs dcn32_res_pool_funcs =3D {
> > diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_reso=
urce.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
> > index 07ca6f58447d..ef30e8632607 100644
> > --- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
> > @@ -1581,11 +1581,9 @@ static struct dc_cap_funcs cap_funcs =3D {
> >
> >  static void dcn321_update_bw_bounding_box(struct dc *dc, struct clk_bw=
_params *bw_params)
> >  {
> > -     struct dml2_configuration_options *dml2_opt;
> > +     struct dml2_configuration_options *dml2_opt =3D &dc->dml2_tmp;
> >
> > -     dml2_opt =3D kmemdup(&dc->dml2_options, sizeof(dc->dml2_options),=
 GFP_KERNEL);
> > -     if (!dml2_opt)
> > -             return;
> > +     memcpy(dml2_opt, &dc->dml2_options, sizeof(dc->dml2_options));
> >
> >       DC_FP_START();
> >
> > @@ -1601,7 +1599,7 @@ static void dcn321_update_bw_bounding_box(struct =
dc *dc, struct clk_bw_params *b
> >
> >       DC_FP_END();
> >
> > -     kfree(dml2_opt);
> > +     memcpy(&dc->dml2_options, dml2_opt, sizeof(dc->dml2_options));
> >  }
> >
> >  static struct resource_funcs dcn321_res_pool_funcs =3D {
>

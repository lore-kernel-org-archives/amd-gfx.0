Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC809D116F1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 18:11:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 154A610E450;
	Mon,  1 Dec 2025 18:11:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vd2NavZ1";
	dkim-atps=neutral
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5523610E44D
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 18:11:04 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-7ae1c96ece1so299254b3a.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Dec 2025 10:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764612664; x=1765217464; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pACjIJ5Z98dL1VC/6XHBEnEAfmGPEe/jI8Z9/L5Bn2s=;
 b=Vd2NavZ1yKr0xG9fpYA/anBb3pE7CC1ajHWDQbkxGDMS6M2i6yDK5imucw18oYUd2D
 PfsmMUX2ZTEKl4W8BbhTpNZszZSey9Ez99D5vdbB7MZTF5mkJoeiEa1r7yqOTJGEtMhl
 AIwYCUj16F9DAdO4k71Tr041nBX9rJbdFEo0cJHVKHRKEtjnI1fdE/40CneEpeuES+Wy
 ifZAwC+EF3ekWkguQ9rCzPs/OUNWKRvgP0Z40nQlJEAE7DpzQhLO8sZ106bCHxiti7LA
 QWKyycYrdKxYKEWtegenT71XI77P5M/rgRtqu8+61St4VSomKEUW70sWoG3JoxXasS8o
 2CTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764612664; x=1765217464;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pACjIJ5Z98dL1VC/6XHBEnEAfmGPEe/jI8Z9/L5Bn2s=;
 b=EZ9A4ZwGnpdSLAdIclZE0lb+/hMJrsJw4o08swPs6ENdWBu0YNBx7is4cbC+fVCFk3
 Rd9WJtsdQADM5LN6SAcWRmZBFtiiapWlNdRumrpl1t0kLF/FjDkA3ws/jzJxGVBNTvgD
 UHkqzbhiBt8gKfk76+M5d3AMWG+HrARxu/CEiIhnTiuQp7AN+DRvpItGqcG6ydHeaSSx
 00GWMVickmtN5yardTCVep36CpcMFW7jtz4SMG9OXPe7/ZutTA12RFVxv+Uqb/QS8dm4
 P8sEI7X2jDglM1z9TdjCY3uNFSogAr5GGWELC0a3IbZ8oAWTKnNqnQlwLPRGHirV7T5H
 Drnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXD7hyVR0v/HQ7MWjtY5OmHi4w32c5Fe3Ij0Lc2jXkB/ywR+ou4IqUWBCXe7mEwYT5aEEJrkBa@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyW3aVVFCcLkyoMDZvNb7FAFk9mQZZebOVFOYihTbCLkpZjrBO8
 gu2tOtYSPdEqlpWQI/+45HyKQhFsXJHAqo0gwlbjmkPbshV1QC2psrLKU5dykXUtSGEHjmgo1Ue
 mlTGq6c372heAajsv2WiTk1K85XMPzRM=
X-Gm-Gg: ASbGncup4T0mzfSFyzbTbY0v3+0AsGM51oWGoFDrx6KLBAN8tXURUooz1b6qDZ8KqTI
 DJej9ayypZkpH/o97he3JLzRXKn8W226TuoPW0GfmjgLcyOH2SElboqq11BNa5t8/o1h8LJBSLt
 Ll/JOo1LqIshE5osZQ+kgsSg5IWRn1Rm2UNx4vJ3IAtlXgSH8psVUzx/Y746mkMEkjb/b+RiaRR
 RHAYT21GUXLCNYyq6UT9EZZB98FbFe5Z5kU8O7Elxm7BbOmkFwEv+XGaWA94lSSGREznIQ=
X-Google-Smtp-Source: AGHT+IE71pJafFwUFiPS9h38WORURTVaywA11WteMOZkloki51qtSpW8dr8VyIrZTMlaeGq2FnTBiE1ewdbGlm1RvZM=
X-Received: by 2002:a05:7022:20b:b0:11a:43fb:58dd with SMTP id
 a92af1059eb24-11c9d8851e0mr22415203c88.5.1764612663631; Mon, 01 Dec 2025
 10:11:03 -0800 (PST)
MIME-Version: 1.0
References: <20251129073740.1813659-1-rdunlap@infradead.org>
In-Reply-To: <20251129073740.1813659-1-rdunlap@infradead.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 1 Dec 2025 13:10:52 -0500
X-Gm-Features: AWmQ_bmuZ0JnGfMfHwqT7CqSUNa9bxeI_sau48Vz1Z6fx06hE5loP7Vv_ifbeOc
Message-ID: <CADnq5_OWcjQjNEuUKva1HJE+8ufD6dOecwZdikAuhvaQ_HBMZA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: correct kernel-doc in dml21_wrapper.h
To: Randy Dunlap <rdunlap@infradead.org>
Cc: dri-devel@lists.freedesktop.org, Austin Zheng <austin.zheng@amd.com>, 
 Jun Lei <jun.lei@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
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

Applied.  Thanks!

On Sat, Nov 29, 2025 at 2:37=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Fix all kernel-doc warnings in dml21_wrapper.h:
> - add missing @dml_ctx entries (2 places)
> - fix function prototype typo for dml21_create()
> - change a blank kernel-doc line to " *"
>
> Fixes these warnings:
> Warning: drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.h:30
>  function parameter 'dml_ctx' not described in 'dml21_create'
> Warning: drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.h:30
>  expecting prototype for dml2_create(). Prototype was for dml21_create()
>  instead
> Warning: drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.h:55
>  bad line:
> Warning: drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.h:61
>  function parameter 'dml_ctx' not described in 'dml21_validate'
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Austin Zheng <austin.zheng@amd.com>
> Cc: Jun Lei <jun.lei@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Rodrigo Siqueira <siqueira@igalia.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> ---
>  drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.h |    7 ++++-=
--
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> --- linux-next-20251128.orig/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/=
dml21_wrapper.h
> +++ linux-next-20251128/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21=
_wrapper.h
> @@ -17,9 +17,9 @@ struct dml2_context;
>  enum dc_validate_mode;
>
>  /**
> - * dml2_create - Creates dml21_context.
> + * dml21_create - Creates dml21_context.
>   * @in_dc: dc.
> - * @dml2: Created dml21 context.
> + * @dml_ctx: Created dml21 context.
>   * @config: dml21 configuration options.
>   *
>   * Create of DML21 is done as part of dc_state creation.
> @@ -40,6 +40,7 @@ void dml21_reinit(const struct dc *in_dc
>   * dml21_validate - Determines if a display configuration is supported o=
r not.
>   * @in_dc: dc.
>   * @context: dc_state to be validated.
> + * @dml_ctx: dml21 context.
>   * @validate_mode: DC_VALIDATE_MODE_ONLY and DC_VALIDATE_MODE_AND_STATE_=
INDEX
>   *           will not populate context.res_ctx.
>   *
> @@ -53,7 +54,7 @@ void dml21_reinit(const struct dc *in_dc
>   * -dml21_check_mode_support - for DC_VALIDATE_MODE_ONLY and DC_VALIDATE=
_MODE_AND_STATE_INDEX option
>   * Calculates if dc_state can be supported for the input display
>   * config.
> -
> + *
>   * Context: Two threads may not invoke this function concurrently unless=
 they reference
>   *          separate dc_states for validation.
>   * Return: True if mode is supported, false otherwise.

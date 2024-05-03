Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D1AC4345F
	for <amd-gfx@archiver.kernel.org>; Fri,  3 May 2024 14:46:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AA01112F7A;
	Fri,  3 May 2024 14:46:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MxSrWy8q";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 282B9112F7A
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 May 2024 14:46:03 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-2b2b42b5126so3199637a91.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 May 2024 07:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714747562; x=1715352362; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DRpON4xNcOzvsSHwFS97jHmcUo/DF2YEIUuZiQlI6b4=;
 b=MxSrWy8qdhLkfoAEsXqWUl95+b6fdC4tm73cwIDalco6JZFLZl4omGf68cyMhWv7kY
 /921qFm6wkxhBg2AkhsyoouGlyACHMFXoRORRPP1vfQnnk2jP93knNN7a528UNH7Tfl5
 ULY4b8XWHY6iqfFgHHbSDJTskawUDmh1RDNvdFmW5BHEjiWIUYCcKdSaI+dbp/hFNvsr
 D8ztJo1TXYAzZEZYuknzKRUVv6B15+pDlevC+weho1rOXd16BY5rpoxCCEdQIHphpDP2
 1zxf8EvNCiawO0z9J1PNeJU+LndfScuPUDikxknKqUJSYPhYFZJwbz+vSEYSwMX1InQl
 qpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714747562; x=1715352362;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DRpON4xNcOzvsSHwFS97jHmcUo/DF2YEIUuZiQlI6b4=;
 b=K7xanA322dF1DDv8FeM0QFesbpTlvNdKjY/2JI+DJey+Wg0t4i02RfaI+UDsTOWDnw
 auyKv6fboXnQijwdyBMyNYM0kerY9Fw43tbQOFokb8lih8NGegtleuK98MBlXgrp9sy9
 zRH/5ynYIA652wahTPQ2BJqmvjZbKNS9IGFD2U1PbSkbS2Bj6B7EIkgGW8QjoIPZ1GHk
 kt0swpUdqfg70x0JynBf/VTCvBY6YxQ3saZ7F4tsXGJFcekT7V0Cuhac0uQraIbZTth9
 A+i1MnuurIVKDjYuPgLwPUDYBt5F8DbgS/Cap2ucGNZoN8QFw76Gnl5W7PGSDAJd/NMs
 ppFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKvB5mBR73QtuvBwWbEOfbHrtbdjVoyy3iEJucv3Hxk3M7c2LsDYJBkZeP6nRqZwvjB9U3TsL1lpcP6RB+PwiR69V6cNdlaCJQwcChoQ==
X-Gm-Message-State: AOJu0Yyl8yyEjatx0+0euBCFyxi5Y95zLsrO+mSzYTdbMigAX8YvNZTK
 wCybDmo9TFn6hwO5gQlING/kGXn2Z+wuMLoVZ7e8DDbaIprPfHfegUSdfgv4IyJrMT0tOsmpWQH
 eGmz/P07tvnKSt+3Z42OornUMNcU=
X-Google-Smtp-Source: AGHT+IEUKjOMhivM9lptIfrf8hUr1cyQGLtvT2mgeUfBQL45ZeHLPyFHVe0yupPGSHlb3mn/I/HaDFwD3mKzJL5KEs4=
X-Received: by 2002:a17:90b:4d08:b0:2a2:ba9:ba61 with SMTP id
 mw8-20020a17090b4d0800b002a20ba9ba61mr3396445pjb.34.1714747562397; Fri, 03
 May 2024 07:46:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240503084447.2451529-1-sunil.khatri@amd.com>
 <20240503084447.2451529-2-sunil.khatri@amd.com>
In-Reply-To: <20240503084447.2451529-2-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 3 May 2024 10:45:51 -0400
Message-ID: <CADnq5_Pmmy7K0Hy4bzppgsVkCrEPGfO7sYvUU_bBPqLqHou4GQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] drm/amdgpu: add CP headers registers to gfx10 dump
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
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

On Fri, May 3, 2024 at 4:45=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com> =
wrote:
>
> add registers in the ip dump for CP headers in gfx10
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Patches 1, 2 are:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v10_0.c
> index 3171ed5e5af3..61c1e997f794 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -366,7 +366,14 @@ static const struct amdgpu_hwip_reg_entry gc_reg_lis=
t_10_1[] =3D {
>         SOC15_REG_ENTRY_STR(GC, 0, mmRLC_GPM_DEBUG_INST_A),
>         SOC15_REG_ENTRY_STR(GC, 0, mmRLC_GPM_DEBUG_INST_B),
>         SOC15_REG_ENTRY_STR(GC, 0, mmRLC_GPM_DEBUG_INST_ADDR),
> -       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_LX6_CORE_PDEBUG_INST)
> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_LX6_CORE_PDEBUG_INST),
> +       /* cp header registers */
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME2_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MES_HEADER_DUMP)
>  };
>
>  static const struct soc15_reg_golden golden_settings_gc_10_1[] =3D {
> --
> 2.34.1
>

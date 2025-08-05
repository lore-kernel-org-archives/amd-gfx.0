Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94AC4C87FD1
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Aug 2025 14:47:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 266FC10E6A4;
	Tue,  5 Aug 2025 14:47:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iKeMy0g/";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 186FE10E17C
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Aug 2025 14:47:22 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-31ed2c4cfcbso341454a91.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Aug 2025 07:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754405241; x=1755010041; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s7uekZDQLE4oIdcM8aNX281uSLcr5MsP5Zzcui2Zcwc=;
 b=iKeMy0g/Jasj0VgwgDOP+GmFxeTY5cRulOYJWvV8hX+paJEXYELRFPRAkbe3iezVxg
 HY9UiQFMBoo723GaQIKIYjfUQDXd9KTHLunyR6h88NG1ZHAa0pVPC7YA93rN4KN/SVPl
 9PVaFPkZ+vMON2mwYunQ8yyFn6rP5gMwIGKxqoO97nhITh/AvmTMf8Zh6Vnn7+DYWASa
 0lfNlOLQ/FGnfxkiK1l9gEk+0LzVjCwPdMnjjATMrsWJ0BEcSTeBXR4ka/otAtvMjfJ8
 RYegkfx12T1XNlseUZ7RA2vOM1tY09JJhlE4WUa7d5lF/kIBZuf2xWiGMRXsgS8I+JSr
 6HVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754405241; x=1755010041;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s7uekZDQLE4oIdcM8aNX281uSLcr5MsP5Zzcui2Zcwc=;
 b=TbXNHWNPN9m0UOoM0eAIMSZ8FyKfDJXRx8gxbacI5B6ZRz7N48rr5B2EoZH9dfpGyC
 aTO+BzTgDTvXjyfiFaetRXAik11Xd4U0a5KFp2zvVRPLevyi0yOnSHsVff/3TSrUUmgA
 zteoKg4A2uzIKQDeRTLMYCX4qR3PpOThu3kSh8ukwZQM+1pG0WA/k8D7faxyONk7Jl1R
 iTUAcKC1p8zvupX+MPN2E3O3Elisb4YNrLq3tKN47NmE94laRcDukzXG6db72dqYTRJz
 K1HG3n5VIhwOKVX1fX/4tM6StVi2KDyu42v2l0NRfOcHetbQnhYAWLRnol+okIzsZj8o
 vbRw==
X-Gm-Message-State: AOJu0YxPqjRDBs7grA3eAxhJHFm67Y7ujWuVSBLxJ5B0lLKrM7JjLCer
 XtFU3fu9MIMLLj5QpRqpZV09/BiN5+AiLpNR8YSostS+84Jv9ArNE7VQ84b3bGPDyG9kVlJmi+H
 QJW49x7rusOWBfecr+tJGlZdhKhJFjRYicA==
X-Gm-Gg: ASbGncuaT4iXY7BfrXOwmkqE6turYEtTip47CyPoVLKXNFVRGH3d0l2ClUjb25yinXU
 JVJAg5FQCcillNfwD3vZJYglccgbK87KCSNESf7G8+wENMO4UHL65VSc2U6S6bfUwfvP5hHgZ0I
 Gbhkj700MMmd8W5fXX1NwjsPqY9J6JHVVVlz0SvRsEIw6ZxQf+X3jxjt1WnxvQ1JevzcuA37QnX
 r3RrNGr
X-Google-Smtp-Source: AGHT+IF1LqEWn5YqrvoQSlM+OuOD8Jp0ShuPfCgnt+GpsOwvoDJ1HO/EyhdvP4KHw6qsoZL2IzmRWK6NQ5+zHz4YWtE=
X-Received: by 2002:a17:90b:288e:b0:321:29c4:e7c3 with SMTP id
 98e67ed59e1d1-32129c4e9damr5486278a91.3.1754405241352; Tue, 05 Aug 2025
 07:47:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250805142834.668322-1-asad.kamal@amd.com>
In-Reply-To: <20250805142834.668322-1-asad.kamal@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 5 Aug 2025 10:47:07 -0400
X-Gm-Features: Ac12FXw07OGdJ3hqvb3pV5lvl5tlx59mPW3J0Xw7GKjNOR1d9cc_eDCmXiipfWc
Message-ID: <CADnq5_P=D1E-9QCA0XCX9bLnBe+L9AydpKNLBi4cz1yQ3GK2tA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Increase cache interval time
To: Asad Kamal <asad.kamal@amd.com>
Cc: amd-gfx@lists.freedesktop.org, lijo.lazar@amd.com, hawking.zhang@amd.com, 
 le.ma@amd.com, shiwu.zhang@amd.com, alexander.deucher@amd.com
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

On Tue, Aug 5, 2025 at 10:38=E2=80=AFAM Asad Kamal <asad.kamal@amd.com> wro=
te:
>
> Increase cache interval time to 50 ms while fetching system
> metrics table for smu_v13_0_12
>

Can we move the caching up to the device independent level?  It would
be nice to have this for other GPUs.

Alex

> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> index fca50f6a8ef6..2ee61c7e8bc8 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> @@ -372,7 +372,7 @@ static int smu_v13_0_12_get_system_metrics_table(stru=
ct smu_context *smu, void *
>         if (bypass_cache || !smu_table->tables[SMU_TABLE_TEMP_METRICS].me=
trics_time ||
>             time_after(jiffies,
>                        smu_table->tables[SMU_TABLE_TEMP_METRICS].metrics_=
time +
> -                      msecs_to_jiffies(1))) {
> +                      msecs_to_jiffies(50))) {
>                 ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_GetSystemMetric=
sTable, NULL);
>                 if (ret) {
>                         dev_info(smu->adev->dev,
> --
> 2.46.0
>

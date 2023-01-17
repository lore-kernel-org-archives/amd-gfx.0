Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6DEC63797
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jan 2023 14:22:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51C2310E549;
	Tue, 17 Jan 2023 14:22:41 +0000 (UTC)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 034AE10E549
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jan 2023 14:22:39 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-15ed38a9b04so13442387fac.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jan 2023 06:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3RlhoRZaieEjiz+WaRdj3z/M4QovOErKiUFZd2ESVTk=;
 b=gtQ6VGojWy9x2LVnQsaJ4HOLT1gZHhIjuOo1vPYnXlvIDwiRWhP+BkXcSLtVQENPET
 TmtjMb5Iv28RYGAmQO0Q9KiY8tiKO9Btf/3rymPDBSax2I7EDfcVmPSOYVzp+eEndpfh
 Bw0xtRXvRm0WZQdu1jdMp8yr/Fbkh0SxlNHeqMewP1en1Cn1/2yfwM87CbxQjWlg8NDi
 t5Rt849EEcX7mor6+zlq7tBxiRT6ral17JtcGJ49g/UmyCTJhALf6QImX0Jo6dFptbwQ
 2YE8LzXAHGaqAIR8wuIfi3gb7Zagwx8gQTkNtMrJsUkJ0oYoXaXwwxsbjCYE57Hidjin
 BPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3RlhoRZaieEjiz+WaRdj3z/M4QovOErKiUFZd2ESVTk=;
 b=goRHT4wryZ90I11LtELv3IfnuTojhIGtwIoM7m8TyT2QagjxXBS4Qo78ToPcmh7AcC
 5Z8akLmZhM9ZqYfYFThF68JfqLofxO9+u12/7l+NeC2BecHhKauZcMWkyK543SNwKABH
 qYHPFgb1hqkBr5ZhcQCXQH2LA0iq6haDKGG8A3rV5bMBFGUz8LEe9NiK0caP19x9g0zY
 gZtwJHuBUliuSoKVo5Nd+9fMUBBJwR0ORMaGgwcYGsuRpEHS5gbLc3XjH0ess9gyu9AX
 iFbFwdKf8YSkWybsULaxdw0cAGcfvit0vnysOSz8XvPav0XvgMn6JcDJKBLWv8CecuBO
 Ah9g==
X-Gm-Message-State: AFqh2koBm2Ep/aUG/DoEBdZ47E5dPRAz62vPFGhHOrobrsXirz7hVvQ+
 4Yv6ZBL9v+Jll9qaByR+WlPGYgeaMU0EXVAv5Sg=
X-Google-Smtp-Source: AMrXdXu3WJ8E+mCHZJdkr6Ekw0XIPEkuHcXUctX8Z/3SkOq+jFopDZcdDR+F450lsnq2mFuORLzwPmQWGVc03fASBpQ=
X-Received: by 2002:a05:6870:7a18:b0:15f:5509:9a0d with SMTP id
 hf24-20020a0568707a1800b0015f55099a0dmr310842oab.46.1673965359266; Tue, 17
 Jan 2023 06:22:39 -0800 (PST)
MIME-Version: 1.0
References: <20230117030528.13525-1-Jane.Jian@amd.com>
In-Reply-To: <20230117030528.13525-1-Jane.Jian@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Jan 2023 09:22:28 -0500
Message-ID: <CADnq5_OS9UujAF8E0Nou7UMw5MVUsWJAU98mAR9kCWzYDrFrSw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/smu: skip pptable init under sriov
To: Jane Jian <Jane.Jian@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Horace.Chen@amd.com, amd-gfx@lists.freedesktop.org, HaiJun.Chang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jan 16, 2023 at 10:05 PM Jane Jian <Jane.Jian@amd.com> wrote:
>
> sriov does not need to init pptable from amdgpu driver
> we finish it from PF
>
> Signed-off-by: Jane Jian <Jane.Jian@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index d0cdc578344d..7d711861b90e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -407,6 +407,9 @@ static int smu_v13_0_0_setup_pptable(struct smu_context *smu)
>         struct amdgpu_device *adev = smu->adev;
>         int ret = 0;
>
> +       if (amdgpu_sriov_vf(smu->adev))
> +               return 0;
> +
>         ret = smu_v13_0_0_get_pptable_from_pmfw(smu,
>                                                 &smu_table->power_play_table,
>                                                 &smu_table->power_play_table_size);
> @@ -1257,6 +1260,9 @@ static int smu_v13_0_0_get_thermal_temperature_range(struct smu_context *smu,
>                 table_context->power_play_table;
>         PPTable_t *pptable = smu->smu_table.driver_pptable;
>
> +       if (amdgpu_sriov_vf(smu->adev))
> +               return 0;
> +
>         if (!range)
>                 return -EINVAL;
>
> --
> 2.17.1
>

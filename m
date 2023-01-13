Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46533C54EBD
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jan 2023 14:40:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A379610E9FD;
	Fri, 13 Jan 2023 14:40:17 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAABC10E9FD
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 14:40:15 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-15085b8a2f7so22480597fac.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 06:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=37BCzLOFgx1MtyTjx4+yBbDjqgFUrNMB1QPPO4M0eng=;
 b=NGgm3EqgdfPY42hEIXWvUL5IU/jUi4oUpPrSMZ/ErHdA/L1D1pqfu489UQSsGhPJEs
 8tqiGCps1hcY2Y18zGVdl0NbU0yk7Sm/VUcLD4pFJWmtc1poPIQJuYkjKTHSSgopxh2a
 r5Y329DDq0+iuQhYFIPS2ngvVYUJAyg6ig6C21IkQwgD3pRtuG+l2rt8F6mdnHzD5RBn
 8T55JWsWdSD2r6kQnUgNfhRPWldJTm7TMoXEva86fZtB7ZgbG/ySN2PTaHUhUL7KWOpO
 1VzhySkddCx4Ccd90kXO4cU0C4QGcphj4L6d9/ObVb4S5ma9w7bTLHOzo2zQh7nH0Jwa
 637w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=37BCzLOFgx1MtyTjx4+yBbDjqgFUrNMB1QPPO4M0eng=;
 b=pnG28H2BAYK+V8BefX/DL2eJk2ZNStgiz9njIwiK98p6o3igFP/JswbOlI1WmwiWoB
 x4rPoKcoA9djV4ycla90J0zWXkDCGY0PKLlOt1p289XNM/v4X9ojYS9SWOdd/BSog5CI
 aSkumWKMMJZz2YbxQdsvYqsi4eNZurEyihfou2JzuGfR7gM3KXn3tR9s5DB8nC/F3fzu
 +lI2am7+AHODH8Gl1hZ3Gb4bnjb5BGHX/7mueVWQqlx/uDUhH2Gk1ZnelK5mlb3EGi7t
 kpN4zs7mhJ++PjEy3Kdg5z9EO4P7ZLXVVlEtW7+sKbWmwkKdUel9Q9ADVRzArK/E3q8w
 jVCg==
X-Gm-Message-State: AFqh2krnRgtTaJQOb3VjoqMol3qZTbK4/UzaS9IKEjVBRrnzQJ6O5oYe
 EkBNhIBeRczPmlXydaH79tCmNnr4vsgFxKNfRkUUy9FmubA=
X-Google-Smtp-Source: AMrXdXsq7E9zbtmMWG5h6pafIpd4w6iO6FvxagPVSZHT3cY8wnj069kYxYQNcENozBvGk2q9OvLPtU4F/qDlbqNpbjo=
X-Received: by 2002:a05:6870:c59c:b0:150:d9aa:4011 with SMTP id
 ba28-20020a056870c59c00b00150d9aa4011mr3217345oab.96.1673620814937; Fri, 13
 Jan 2023 06:40:14 -0800 (PST)
MIME-Version: 1.0
References: <20230113105624.3477-1-Jane.Jian@amd.com>
In-Reply-To: <20230113105624.3477-1-Jane.Jian@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 13 Jan 2023 09:40:03 -0500
Message-ID: <CADnq5_Pucard+JDHP6sne_UC+TK0e+32ig+zJA_+T1YmE=MrTA@mail.gmail.com>
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

On Fri, Jan 13, 2023 at 5:56 AM Jane Jian <Jane.Jian@amd.com> wrote:
>
> sriov does not need to init pptable from amdgpu driver
> we finish it from PF
>
> Signed-off-by: Jane Jian <Jane.Jian@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index d0cdc578344d..d07b0cfe23b4 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -407,6 +407,9 @@ static int smu_v13_0_0_setup_pptable(struct smu_context *smu)
>         struct amdgpu_device *adev = smu->adev;
>         int ret = 0;
>
> +       if(amdgpu_sriov_vf(smu->adev))

Space between if and (.

> +               return 0;
> +
>         ret = smu_v13_0_0_get_pptable_from_pmfw(smu,
>                                                 &smu_table->power_play_table,
>                                                 &smu_table->power_play_table_size);
> @@ -1257,6 +1260,9 @@ static int smu_v13_0_0_get_thermal_temperature_range(struct smu_context *smu,
>                 table_context->power_play_table;
>         PPTable_t *pptable = smu->smu_table.driver_pptable;
>
> +       if(amdgpu_sriov_vf(smu->adev))

Space between if and (.

with those fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> +               return 0;
> +
>         if (!range)
>                 return -EINVAL;
>
> --
> 2.17.1
>

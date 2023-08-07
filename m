Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D92DC001DB
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Aug 2023 16:46:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A08E989A60;
	Mon,  7 Aug 2023 16:45:11 +0000 (UTC)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F82910E2E5;
 Mon,  7 Aug 2023 16:45:07 +0000 (UTC)
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-1bbf7f7b000so2647441fac.2; 
 Mon, 07 Aug 2023 09:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691426706; x=1692031506;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bfoqLIba1AF87rihr9bsxZdVGLDPpuKR96GgIsmd5Nk=;
 b=JHhtdfhFof0tkps0WXOG0EXsn3N+0wVgSXX6ubKj37GfkElHT22/ZFOG7xZnjycKHT
 1PYFLR7mT5V5hEPOrYnrc7/nnqWH9TqwGnt492yGxNh70ex0hMSWqypgJ4403NgB4bxA
 QvVEm59JY2qkaj5sGfYqEThuAnxGWXhQocxbvtodaG6/CCe0kRoa67HTKcBoez+INPUj
 WdBoNiAZ/74Cy96ImF4dVM3Y/EajZjoamWKFQdIQNR7sVZKUCg+bi8/a9gsaKBAMA5+C
 APLArB3d4moYvoW3+W/0M6G0MN5klXILgQYek2w7IooSpZT/4/ecXtmX7deqyZnVcf1n
 wVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691426706; x=1692031506;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bfoqLIba1AF87rihr9bsxZdVGLDPpuKR96GgIsmd5Nk=;
 b=HwQsmqaC5Ps17DX7nAVYS6h5oABaBUORRehocEhpCNAtTOIReczhkuYhBeXIPsJeS9
 Z+Flwd/1Xpt+E3zorgK5utijm0eOw2mBuAeRdhcuTNCgSEDeldU7UiYtEziGcpMPu5cs
 pnrHN5DV5o8YA47itNHJ60PEiVQMN4BMivFARXybgxOWmBh8O81ylJP/K6tBRDGFilyO
 dV8pwOSp629ZRUfo93KtieU0SelK8/zTbE1iObqH79VLaWqB1PLqr0VlgcS9FyMqBqrG
 hButKHhQXqaA+3/T9QdenGvES+1157CIzMQuNL+ZG7Sd3UW1Ib9lyuB9GjT3EuxU533e
 gAZw==
X-Gm-Message-State: AOJu0YwAd+tU9Q2omrOAmkJcOxom/zzRCt+n6JgcamfWYVRy2CuNzATb
 RrWzSJkzt/xIgiXOh1PY/I2uu2JcxzvcqqWFwgs9N/aM
X-Google-Smtp-Source: AGHT+IGumAWh6Kpn9QD3TQGrAhy4o0PVAVBatDxw6iAJ0kxQKsy00haaZblpIKVeZF5vbnMEIyKsxgdUgA6uZ4A1txQ=
X-Received: by 2002:a05:6870:1713:b0:1ba:64a5:d2d1 with SMTP id
 h19-20020a056870171300b001ba64a5d2d1mr10025458oae.20.1691426706344; Mon, 07
 Aug 2023 09:45:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230801093023.7584-1-sunran001@208suo.com>
In-Reply-To: <20230801093023.7584-1-sunran001@208suo.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 7 Aug 2023 12:44:55 -0400
Message-ID: <CADnq5_NppWn77SagusVruWd4rEw_1ik0Uq4qY9Cz33VQdnRQQg@mail.gmail.com>
Subject: Re: [PATCH] gpu: amd: Clean up errors in ppatomfwctrl.h
To: Ran Sun <sunran001@208suo.com>
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
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, daniel@ffwll.ch, alexander.deucher@amd.com,
 airlied@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

On Tue, Aug 1, 2023 at 5:30=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: open brace '{' following struct go on the same line
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.h b/driv=
ers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.h
> index 2fc1733bcdcf..e86e05c786d9 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.h
> @@ -147,8 +147,7 @@ struct pp_atomfwctrl_bios_boot_up_values {
>         uint8_t    ucCoolingID;
>  };
>
> -struct pp_atomfwctrl_smc_dpm_parameters
> -{
> +struct pp_atomfwctrl_smc_dpm_parameters {
>    uint8_t  liquid1_i2c_address;
>    uint8_t  liquid2_i2c_address;
>    uint8_t  vr_i2c_address;
> --
> 2.17.1
>

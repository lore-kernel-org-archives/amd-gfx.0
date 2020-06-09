Return-Path: <SRS0=75wA=7W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1D6C433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2020 19:53:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DDAD206D5
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2020 19:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuXJ33Rx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DDAD206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35F3E891F8;
	Tue,  9 Jun 2020 19:53:37 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A801891F8
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jun 2020 19:53:36 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id q11so22700071wrp.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Jun 2020 12:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=T9MW8UBMcbsbclF6j8ZlExuGzwwKcS+tdEX677NjH9U=;
 b=QuXJ33RxO7/Cc77MTFFh4h4gRVWCBuJeOcSgt0htjfZtiXqca+2FFtmmDwo1eFjIxV
 YyibPwVCF/9wtvUgHYjS2hbPWbb7InRl2xP4ddWd+aim9uP6GYDh7Ti18dQ3Vh7w/W8/
 ItIGBmlMhs+m4FJstIn2NK6XU/lmW800oj+d/1h7wfKcHJyj4efY2PGhMB3iD2tOdqmW
 fkfeJeLlmZTuCkg+zDRo6jCBMNYGby3AfAGPi2r4SiOnWOmXWI6dHZ5UfHsKcrZi5F8k
 POwciSbCVrW+r/wMO5H8tjmS6lhtvwhrGr2BXcsQkJGsGRjkbKshDZtXDHItABydy8hi
 avMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=T9MW8UBMcbsbclF6j8ZlExuGzwwKcS+tdEX677NjH9U=;
 b=g/aaHXBxBpT9xAQwMp7TXZEJmcFrbfOygRcEJeRY4ipaS0L+0iKvVeJ5gqJWGD8dq+
 EzyN+jdWqy/xrI5aJAc9rC8sEvxNOOpC5zFUDbAebsiAObNsgXkDu3dlLfV7NAn5+nlw
 R09deQAZP11A+s0QB9aCgO/qUkXvzUKcc6bsYbTguzUaWy1bBOYSrzkTtB6pCs3U82Ff
 /PMebI33LyuJSgRrfUKWR/cO2c21nuwd+CyhED7JiIBSd8q+buGy9gfVg1WrtftUos4w
 dydOlCuKitt+GngHn9R7zEwctn4AyGMBkigj0sH+fooju4EHAsqMooeKuHk95iKMNDIT
 T2Kw==
X-Gm-Message-State: AOAM533nuoOV2et5QVWtE3yMxJ3KkqbO40d8fans3P1okERCU1pAMttS
 25db6VUPCpCBjM/gjGJdL2G/iQTvczJJBYCMTOg=
X-Google-Smtp-Source: ABdhPJyFHgrlTEcx9GDULCKWCah50k9zFtAQPFUXNiFwI1gsHmv+GWeKohQDiCM/Cw0pn1iJWijqCL+7QdgCxHDPxYE=
X-Received: by 2002:a5d:6789:: with SMTP id v9mr6648617wru.124.1591732415225; 
 Tue, 09 Jun 2020 12:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200609102017.12478-1-evan.quan@amd.com>
 <20200609102017.12478-3-evan.quan@amd.com>
In-Reply-To: <20200609102017.12478-3-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 9 Jun 2020 15:53:24 -0400
Message-ID: <CADnq5_NS3tR8ZPirBUaE2Z81Nx1FvYm6zXR1A7=H1_f+7xU2jQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amd/powerplay: maximum code sharing on sensor
 reading
To: Evan Quan <evan.quan@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jun 9, 2020 at 6:21 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Move the common code to amdgpu_smu.c instead of having one
> copy in both smu_v11_0.c and smu_v12_0.c.
>
> Change-Id: Idc59c6f686139d034348a613f1a7b9213198312d
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 4 ++++
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c  | 4 ----
>  drivers/gpu/drm/amd/powerplay/smu_v12_0.c  | 4 ----
>  3 files changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index c032680c52b0..8415b383e7ae 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -2322,6 +2322,10 @@ int smu_read_sensor(struct smu_context *smu,
>                 *(uint32_t *)data = smu->smu_power.power_gate.vcn_gated ? 0 : 1;
>                 *size = 4;
>                 break;
> +       case AMDGPU_PP_SENSOR_MIN_FAN_RPM:
> +               *(uint32_t *)data = 0;
> +               *size = 4;
> +               break;
>         default:
>                 if (smu->ppt_funcs->read_sensor)
>                         ret = smu->ppt_funcs->read_sensor(smu, sensor, data, size);
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index 1a17d853afbd..993976452467 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -1193,10 +1193,6 @@ int smu_v11_0_read_sensor(struct smu_context *smu,
>                 ret = smu_v11_0_get_gfx_vdd(smu, (uint32_t *)data);
>                 *size = 4;
>                 break;
> -       case AMDGPU_PP_SENSOR_MIN_FAN_RPM:
> -               *(uint32_t *)data = 0;
> -               *size = 4;
> -               break;
>         default:
>                 ret = -EOPNOTSUPP;
>                 break;
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
> index ae1035575808..b03127273d56 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
> @@ -221,10 +221,6 @@ int smu_v12_0_read_sensor(struct smu_context *smu,
>                 ret = smu_get_current_clk_freq(smu, SMU_GFXCLK, (uint32_t *)data);
>                 *size = 4;
>                 break;
> -       case AMDGPU_PP_SENSOR_MIN_FAN_RPM:
> -               *(uint32_t *)data = 0;
> -               *size = 4;
> -               break;
>         default:
>                 ret = -EOPNOTSUPP;
>                 break;
> --
> 2.27.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

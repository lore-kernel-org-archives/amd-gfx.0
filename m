Return-Path: <SRS0=eP35=BG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BCCC433E4
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 19:01:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F401320719
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 19:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgmd1/3z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F401320719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 979D489498;
	Mon, 27 Jul 2020 19:01:09 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EFBB89498
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2020 19:01:08 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id f18so15952370wrs.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2020 12:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GWRD6aKtU2dG93H0mLRCtmpFUiWZc0dEN93+3wR1MEE=;
 b=fgmd1/3zIuSYEzYaYQBLkWbJuAkNkJeULpdCXrp+6VYCGj0y/9k6P1GgA0rrHAJdi6
 um24p+y96hkqfH4YAXHmiPsT0nR+IK7wKKUtAH+UIeJoySMd5KAjt8dNK5WwK+7cSZz0
 ZSLP1LqaJWveAnnuSipBZO8fqX9Bbx0j1eT7iZsLbzQ/UoyWbFOmYPs/SDvU1Qnho5CD
 5YqLwNaILCWw3RPFBJDS2gbVJsOVJYJukhNxUZASnrXXX9SMV8ocSIUq03GzeRgXeMHE
 RU5T9XVNALrRrr4/Nv/ZWdxVB8EpHTS0sKwxnBUrM6DT4fIdyQP9pqGi/vmXrvl3AApG
 9xhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GWRD6aKtU2dG93H0mLRCtmpFUiWZc0dEN93+3wR1MEE=;
 b=iPChESk/GGRqRwgiRtQxKhMtn0b19uZA2ioRslr0rTV2sFuiJQ4FkQHI+4ymoYLYtm
 EKw6dGviZ50+f0auOtRhJse/F1W6+/4zzVCRhM52DYI9m1L7u9SCIxQLPiQDC/LBk0vz
 FpozGb/DvBwsGUcCWEnPep3vGfEsKTe2zWGfty2h8UY0QDKYqP6TX74aRRwbZJ5rYDzx
 CTM+rXtIQywU/9c9oof50idbR8JaSYorkY4oL5ySMEpq/wbcCaMy8DiAhJzkG9Bt7+0H
 CMa/XrcJ8BfbbMcHKuxucXSaun/nf501DmAd6yO+BotVsAxt36whbDcjc7EF9UBo0MdQ
 Q7fA==
X-Gm-Message-State: AOAM531pw9cC2psfqNdFHsn3y2L1HuIvVAwiCQchauVIaAOD/N6/70u/
 slffdVVMwnbj6/g4BjnccAE5IpbLNiiTdP6GZ6/8Eg==
X-Google-Smtp-Source: ABdhPJwdbRTzHPdTpTv1KW68K17GZVNbp5Ov17maOv9B9lO82oHXjcOIhJAN9YwUIkkwKJbz6ZU16nYiuUxFxXTcgo8=
X-Received: by 2002:adf:a351:: with SMTP id d17mr21172751wrb.111.1595876466832; 
 Mon, 27 Jul 2020 12:01:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200727133940.GA391897@mwanda>
In-Reply-To: <20200727133940.GA391897@mwanda>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 27 Jul 2020 15:00:55 -0400
Message-ID: <CADnq5_MDcYC08SRMhPPRR0QK70_ZeywtSY4f8ztAP3qCBkwTsA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: off by one bugs in
 smu_cmn_to_asic_specific_index()
To: Dan Carpenter <dan.carpenter@oracle.com>
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
Cc: David Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jul 27, 2020 at 9:42 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> These tables have _COUNT number of elements so the comparisons should be
> >= instead of > to prevent reading one element beyond the end of the
> array.
>
> Fixes: 8264ee69f0d8 ("drm/amd/powerplay: drop unused code")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/powerplay/smu_cmn.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_cmn.c b/drivers/gpu/drm/amd/powerplay/smu_cmn.c
> index be4b678d0e60..5c23c44c33bd 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_cmn.c
> @@ -166,7 +166,7 @@ int smu_cmn_to_asic_specific_index(struct smu_context *smu,
>
>         switch (type) {
>         case CMN2ASIC_MAPPING_MSG:
> -               if (index > SMU_MSG_MAX_COUNT ||
> +               if (index >= SMU_MSG_MAX_COUNT ||
>                     !smu->message_map)
>                         return -EINVAL;
>
> @@ -181,7 +181,7 @@ int smu_cmn_to_asic_specific_index(struct smu_context *smu,
>                 return msg_mapping.map_to;
>
>         case CMN2ASIC_MAPPING_CLK:
> -               if (index > SMU_CLK_COUNT ||
> +               if (index >= SMU_CLK_COUNT ||
>                     !smu->clock_map)
>                         return -EINVAL;
>
> @@ -192,7 +192,7 @@ int smu_cmn_to_asic_specific_index(struct smu_context *smu,
>                 return mapping.map_to;
>
>         case CMN2ASIC_MAPPING_FEATURE:
> -               if (index > SMU_FEATURE_COUNT ||
> +               if (index >= SMU_FEATURE_COUNT ||
>                     !smu->feature_map)
>                         return -EINVAL;
>
> @@ -203,7 +203,7 @@ int smu_cmn_to_asic_specific_index(struct smu_context *smu,
>                 return mapping.map_to;
>
>         case CMN2ASIC_MAPPING_TABLE:
> -               if (index > SMU_TABLE_COUNT ||
> +               if (index >= SMU_TABLE_COUNT ||
>                     !smu->table_map)
>                         return -EINVAL;
>
> @@ -214,7 +214,7 @@ int smu_cmn_to_asic_specific_index(struct smu_context *smu,
>                 return mapping.map_to;
>
>         case CMN2ASIC_MAPPING_PWR:
> -               if (index > SMU_POWER_SOURCE_COUNT ||
> +               if (index >= SMU_POWER_SOURCE_COUNT ||
>                     !smu->pwr_src_map)
>                         return -EINVAL;
>
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

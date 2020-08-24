Return-Path: <SRS0=//M4=CC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F43CC433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 15:58:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 651742071E
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 15:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5HV58HB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 651742071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24A4D6E293;
	Mon, 24 Aug 2020 15:58:34 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 120356E293
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2020 15:58:33 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id c15so9215429wrs.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2020 08:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/FW/FYQCGp/1t1eOrB3z/2NM74FUhvTmtIiJafoB5aM=;
 b=L5HV58HBKxe5mk8D6LeH3tvW/i+IDPJlzO2PixG8XyScp3a3yZjhUNBqlbg7S7Q8Xp
 Lb3WZ3en1gT8C9adb1TKWQqSCenuvXSlT3nBMk9T2JEvkQAt3ZdIXcUB0THc75lJtf8B
 p0UyGNOm7f5ZGncgQ+SAcdwJVy2V2v5QbLbYZikp8ow3skapkalFXyka9/HOMSjSPMAJ
 nB1R2mvyyWi/qJNdomduH1cctnDmR5E7cOnWtQEdLAitKgh0RPMS7kx9rLRDB6VIx0A6
 pyIEar9Tf61FPRvwYilp6wtj5cnbe4FdUSUQKw67iO3rEikS5dgBKPoEvisFvIfZoOBm
 vObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/FW/FYQCGp/1t1eOrB3z/2NM74FUhvTmtIiJafoB5aM=;
 b=kfMkf5oAOtINceoMbcrfO9JqFcLMeQ1BYG3E2w1PnJEDH/tQk8yCONzpcz0AjzSPu+
 8/jm+U6K37bqJ/rD4o/pxqPm9qUJgYaoUomOyMbr4joDAjcwmoK+ugAxNA+iIbVh06YJ
 2WPVpD4K7gp6giaHH/TQjuCENeGydp8Eb4afUElDxN77CIGgyIk32X4QpGQ/2ZqIlgOa
 0oq9MiN5qA+FkgU4NC5cTEu/vQg6IjRSzja7brxZORGOdKLgwKhR/EDDICLQrjtQuugr
 Sr/yerk7iptNpKyGAmO2GdK/Ag37ZMQAh8tbChwQp/pGYb4SfYYypLycfNe9MgJOJgNN
 l5Bg==
X-Gm-Message-State: AOAM530JQxipJHV99gY7FXZhq0klplMceiMB3xEt7GqeAeXzDxcFLpPQ
 9S+llKeH2OrzTnxruvkYBJVGctoNuwxdRyWT+qRTrfUx
X-Google-Smtp-Source: ABdhPJwCbrS5hbVfkxjzDVUfHKh3wkBUQ9wxYOhIjNGLEMv0+Pl+i/PzMVM1KbtksmeOY9WJ+eYCOnO0oGGG8WTEG+M=
X-Received: by 2002:a5d:6085:: with SMTP id w5mr6364240wrt.362.1598284711723; 
 Mon, 24 Aug 2020 08:58:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200824080350.32504-1-evan.quan@amd.com>
In-Reply-To: <20200824080350.32504-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 24 Aug 2020 11:58:20 -0400
Message-ID: <CADnq5_O8gGuF7phpieNFMpj4dsk=cJvMpcJnSh_k=7iGs0ONjA@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/amd/pm: drop unnecessary feature->mutex lock
 protections
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

On Mon, Aug 24, 2020 at 4:04 AM Evan Quan <evan.quan@amd.com> wrote:
>
> As it is confirmed to have no race condition during hw setup.
>

For patches 1,2 please provide details as to why we know it is safe to
drop these.  For patches 3,4:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


> Change-Id: I096d7ab0855ff59b0ecb56fd9d6d9946b3605fc8
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      | 4 ----
>  drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 2 --
>  2 files changed, 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 09dc5303762b..b7cad8ef6153 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -361,20 +361,16 @@ static int smu_get_driver_allowed_feature_mask(struct smu_context *smu)
>         int ret = 0;
>         uint32_t allowed_feature_mask[SMU_FEATURE_MAX/32];
>
> -       mutex_lock(&feature->mutex);
>         bitmap_zero(feature->allowed, SMU_FEATURE_MAX);
> -       mutex_unlock(&feature->mutex);
>
>         ret = smu_get_allowed_feature_mask(smu, allowed_feature_mask,
>                                              SMU_FEATURE_MAX/32);
>         if (ret)
>                 return ret;
>
> -       mutex_lock(&feature->mutex);
>         bitmap_or(feature->allowed, feature->allowed,
>                       (unsigned long *)allowed_feature_mask,
>                       feature->feature_num);
> -       mutex_unlock(&feature->mutex);
>
>         return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 548db1edd352..28a19ffd22a1 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -721,7 +721,6 @@ int smu_v11_0_set_allowed_mask(struct smu_context *smu)
>         int ret = 0;
>         uint32_t feature_mask[2];
>
> -       mutex_lock(&feature->mutex);
>         if (bitmap_empty(feature->allowed, SMU_FEATURE_MAX) || feature->feature_num < 64)
>                 goto failed;
>
> @@ -738,7 +737,6 @@ int smu_v11_0_set_allowed_mask(struct smu_context *smu)
>                 goto failed;
>
>  failed:
> -       mutex_unlock(&feature->mutex);
>         return ret;
>  }
>
> --
> 2.28.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

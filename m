Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D77C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 13:05:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3038761360
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 13:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3038761360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9B186E0D4;
	Tue, 19 Oct 2021 13:05:41 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAA636E0D4
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 13:05:40 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id n63so4781624oif.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 06:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QTJyEdXjsFtBfq5Onfm98VxRYAwQTvpus1xkHP9U6e8=;
 b=qhZk8USb19ep94d5/PBaEUN5cvCoR0JtLMsiNSnbILfaQat7wb+s9juo+qC2vFK+lg
 2sdAecmHUtDBQirCas65ODhPEYVTjqtiy58ZvFu/kCXfaY0TUcuFDH4h3sl2nkOBKM3/
 spsdbnjk1mkhJbcp2o7mA3+l2ZnoeCQq2/WTRTbJ+x77lHZA4q2AYwtd5ds2scOsQguf
 RC7n8ku7cUrd/Ke7tGqsMZVEkss9vWWrW0XRUeHfn1b3RQtvLSVn4mqokObuBP3TYNtv
 RMa2GqEnBvSwV+ZI2qTu9+PePSDlNFD45ALi8DnNislIbAyJJAz5+2SaQ5+F/vUQ9tKb
 4P3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QTJyEdXjsFtBfq5Onfm98VxRYAwQTvpus1xkHP9U6e8=;
 b=2Qg36ZcjM9MJ80h2Oxybol/XS4PUjpAJunyS5SWFBIT6Jab90kMECgbB93DYH10hJ2
 2NOM5vIFqZRCcFDghu0xPxtIbtZ44XSI34MiAI87F3gg7MR9YCi0EI/vh5XyoYftp/n3
 kDMZrINya77ZZuH9pfm1L9tb8c+iC5bzh3IuRDIqF3M5Snm7yy1vAyxHLoXn0C776knP
 uC1aPmJd6omc46nbMsgz0jfdclv6ub0evg2gZxUDMTvz8kI1zCyDoTbQWLuI65bDn58F
 hiEQwPgIh4dDl/yOOzybFwhy0CeiNSaxt+a/P65pCSLdX0WO27qlpkbr8XNZYeRnAgqC
 gIxw==
X-Gm-Message-State: AOAM530nVtbETFFBva6cClYilGvNtp29z4AJcIBl6MLmEbJxXF15smEH
 2D0Ggbw0ebAkesTd91p8VUB7p8f2Gp3yUUmhq94=
X-Google-Smtp-Source: ABdhPJzd29M6p7rgVITHpEHIt2eN6OEPaE5U6sICf0wYDOUV3ZF4op9daiw66WHWczviqB/Wd9rhKLEaZTQrNYcgeuo=
X-Received: by 2002:aca:d6d2:: with SMTP id n201mr3929558oig.120.1634648740195; 
 Tue, 19 Oct 2021 06:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <20211019032232.2202316-1-aaron.liu@amd.com>
In-Reply-To: <20211019032232.2202316-1-aaron.liu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 19 Oct 2021 09:05:29 -0400
Message-ID: <CADnq5_MUEXRbm-gmM7omzFWC-vrenogqQpXXWQvi_=NADWd_zw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: support B0&B1 external revision id for yellow
 carp
To: Aaron Liu <aaron.liu@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, Huang Rui <Ray.Huang@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Oct 18, 2021 at 11:22 PM Aaron Liu <aaron.liu@amd.com> wrote:
>
> B0 internal rev_id is 0x01, B1 internal rev_id is 0x02.
> The external rev_id for B0 and B1 is 0x20.
> The original expression is not suitable for B1.

Are you sure about this?  We'll be losing the difference between B0
and B1.  I think 0x19 is correct.  What will give us 0x1a for B0 and
0x1b for B1.  That aligns with what the display code has as well.

Alex


>
> Signed-off-by: Aaron Liu <aaron.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/nv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 898e688be63c..5166a1573e7e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -1248,7 +1248,7 @@ static int nv_common_early_init(void *handle)
>                         AMD_PG_SUPPORT_VCN_DPG |
>                         AMD_PG_SUPPORT_JPEG;
>                 if (adev->pdev->device == 0x1681)
> -                       adev->external_rev_id = adev->rev_id + 0x19;
> +                       adev->external_rev_id = 0x20;
>                 else
>                         adev->external_rev_id = adev->rev_id + 0x01;
>                 break;
> --
> 2.25.1
>

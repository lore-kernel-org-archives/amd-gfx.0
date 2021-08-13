Return-Path: <SRS0=hpB+=NE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F137C432BE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Aug 2021 13:54:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5407A60F57
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Aug 2021 13:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5407A60F57
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD6B16E7E6;
	Fri, 13 Aug 2021 13:54:50 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BADBC6E7E6
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Aug 2021 13:54:48 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id t35so16007646oiw.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Aug 2021 06:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7o3eeyKcEvoemQh3ECVeio4FoCRGV5Cv/aPu2wo9Yb0=;
 b=CnJeoT2AcypSsyOOU4mm1iXc2f7jRhVSXuZvTu5fOfNryhND7XWqc5S7CxmZv4NKxN
 gvGEOA+vJek0aX0BBZZqePS1GZFGVrrscPgoYq1UZP/U1amb6QacAjDTbMuy9cM3a3KR
 0KmalJ3E3jk8v4tY8qnU5NcEeB9vPlZgO/FJhcUzoEg7em8ojoeecy+PWWlBiV2Frq8M
 eAE6FONIqvxAKh/PMyQVbnxi68pmZHu5zhnVLhoIOWU8W0hCzKP4j3RVEZc+/EvUBTEk
 FmHrnEKjzAcWO7RBgf1M/V41QIkPtnDX1ggN+RthDCHfodiQawNCU6PBlpjH+IduvSDK
 LCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7o3eeyKcEvoemQh3ECVeio4FoCRGV5Cv/aPu2wo9Yb0=;
 b=f5a3K5SA8G8vXKd+a69ouAuLjJB9GsNZYNGitoKK+v3HG46FPt0LNT9nLBWD4L1dW9
 Jq5uESLLq1KT+bBd9S4rR1rY68ug4Nbt3ht1C6CD2Iu6NuT+LQ5fC5IoKhLNDD1xtVgn
 BtWsC1F31AKxepzbLJgZsKlaW8XKtsvRNl66ctfTzzgMbGpntBQRJ+Hj11Z6e2Aimg7o
 yklwAUrBRXMoCe2dnv6pWFbG+Dl/GO+3BC60ZrAIPFLtKOZNnE1gspUAusWPwddnYic7
 M7Uz4CrZTELqWgNtKPS00/Q7IlvPThhJAXNtMV8+rGr9YdgoBCKaYfYoMV8OH2GZhhR7
 rU1w==
X-Gm-Message-State: AOAM532xuCP8Qupl8+5Q/6yL2mSIL6TGO+ksA72jNC/00vdX+YOnVGv8
 766AF64eKFYRYn1uq99+XWJgwpDau5AKEKB5eG8=
X-Google-Smtp-Source: ABdhPJzRpm20HmsZKqqLfXT+hd3zES1rAU0fvf303deGYNmbFDcWrh68g2sfTYaBnbQlOLpIBW+fb4+1hU7HBv0y6RQ=
X-Received: by 2002:a05:6808:1390:: with SMTP id
 c16mr2101593oiw.123.1628862888020; 
 Fri, 13 Aug 2021 06:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210813080933.1348241-1-evan.quan@amd.com>
In-Reply-To: <20210813080933.1348241-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 13 Aug 2021 09:54:36 -0400
Message-ID: <CADnq5_MFk50m_PCys-pkHxbeSfW90rjxCpmhwNe1jEyouB+KRQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: disable BACO support for 699F:C7 polaris12
 SKU temporarily
To: Evan Quan <evan.quan@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Chen,
 Guchun" <Guchun.Chen@amd.com>
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

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Fri, Aug 13, 2021 at 4:09 AM Evan Quan <evan.quan@amd.com> wrote:
>
> We have a S3 issue on that SKU with BACO enabled. Will bring back this
> when that root caused.
>
> Change-Id: I56d4830e6275e20a415808896eecbadfe944070b
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vi.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
> index fe9a7cc8d9eb..7210f80815b8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> @@ -904,7 +904,12 @@ static bool vi_asic_supports_baco(struct amdgpu_device *adev)
>         case CHIP_POLARIS11:
>         case CHIP_POLARIS12:
>         case CHIP_TOPAZ:
> -               return amdgpu_dpm_is_baco_supported(adev);
> +               /* Disable BACO support for the specific polaris12 SKU temporarily */
> +               if ((adev->pdev->device == 0x699F) &&
> +                   (adev->pdev->revision == 0xC7))
> +                       return false;
> +               else
> +                       return amdgpu_dpm_is_baco_supported(adev);
>         default:
>                 return false;
>         }
> --
> 2.29.0
>

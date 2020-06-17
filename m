Return-Path: <SRS0=VPxi=76=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9B2C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 21:15:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38ABE21841
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 21:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpq9uI5N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38ABE21841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDD6C6E0D2;
	Wed, 17 Jun 2020 21:15:36 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28AE06E0D2
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2020 21:15:36 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id l11so3906890wru.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2020 14:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GcDSbIELXFmP7YZ4IpJt0SJZUM28/NUEH/U7BEULIzI=;
 b=cpq9uI5NLhapX5YVr8aOxXTpSNbCfx0eyscz5lAKLaHWPoOIcttNIc/w9FPMH5Kk+z
 253RMpRiQwDpqc3/u4qEemGw51yhdGb3KGoFI5D9zzJXxRvXhar3x0JwkZ9iaXGV0Jyx
 BTUffnts49PpDgyzGWmhwHJBj+Xgf/l29oxiSdFEO6SYINlKywROu/9z/dWxycUzCNkP
 2uTGNbVLcBOeEZrITfkzIJhZd/rtNnsAZsWvObPtTdYNtHdZG1pTyIT218bX0jZlp3Mb
 W/9CxytUOGmQ5mU6GVRI+Xj1c8qJu92YfDV9NExD5k3VHYQqNs8lDgiq4+FXsBX7MqzL
 P/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GcDSbIELXFmP7YZ4IpJt0SJZUM28/NUEH/U7BEULIzI=;
 b=Mcn+CqpuV/7TcfL9bEfjvCEQyjtHgSRJSWzyWxQGS3Tl5GU/Zf/h43QhiS+fZHb5YZ
 Kaz+AIsU0wROwPwtx82eebV6LZG95mwJR0s4VbltfzkW2gjW5yPBPgqlQnAiheAUJDDZ
 dp0saZPCIE952zFz+0EvRyc5CyVfyFyAVWQ2oeTTuG2NRHHKUY7YgVcApsliClb+7U0K
 WdKJOJtuGb/rFkWjobPcy5gTN6qGApW35D9Ll31VpJd6u3pWV89ui8jqWguq/stsrmuQ
 yOd5suV24tEK0ochDZa8eeOKfPAzqwIGvjzICGEP+r8z/m5mpszVa6v1TddtnpPMK+CC
 ZNQA==
X-Gm-Message-State: AOAM5332C7G3ZkkI1qa6jxL9qmUFqJqXdIRAfoy2peIeOd3OqcDmv6iD
 XaP8ZjA+65wadNiDt7WfOlz+OrJYgOuscUw5SrE=
X-Google-Smtp-Source: ABdhPJxuvWo7X2fBFlGWN5BNj/xWedcIRxOQqG8Kf/BEq96UPg6JhQl8ZSxeNW6NTsi0sxpUHIghcRkPjoZcp8eslLQ=
X-Received: by 2002:a5d:400f:: with SMTP id n15mr1154148wrp.419.1592428534598; 
 Wed, 17 Jun 2020 14:15:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200617094431.11411-1-evan.quan@amd.com>
In-Reply-To: <20200617094431.11411-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 Jun 2020 17:15:23 -0400
Message-ID: <CADnq5_OjBoiO9jOcHLccs8wdSvVWz9rWA=tfm_9p3Ctye_6Nhg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: declare driver if version mismatch as
 "warning" explicitly
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, Pramendra.Kumar@amd.com,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jun 17, 2020 at 5:45 AM Evan Quan <evan.quan@amd.com> wrote:
>
> So that user knows it's just a warning and can be safely ignored.

I'm not sure I follow this logic.  I think a warning would cause more
concern than just printing it as info.  Why would you ignore a
warning?

Alex

>
> Change-Id: Ic518ec3eb68c6bd6682e6131e32cfe90843341ff
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index 2bcb8d16f1b7..22eabc10ea8e 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -318,11 +318,11 @@ int smu_v11_0_check_fw_version(struct smu_context *smu)
>          * of halt driver loading.
>          */
>         if (if_version != smu->smc_driver_if_version) {
> -               dev_info(smu->adev->dev, "smu driver if version = 0x%08x, smu fw if version = 0x%08x, "
> +               dev_warn(smu->adev->dev, "warning: smu driver if version = 0x%08x, smu fw if version = 0x%08x, "
>                         "smu fw version = 0x%08x (%d.%d.%d)\n",
>                         smu->smc_driver_if_version, if_version,
>                         smu_version, smu_major, smu_minor, smu_debug);
> -               dev_warn(smu->adev->dev, "SMU driver if version not matched\n");
> +               dev_warn(smu->adev->dev, "warning: SMU driver if version not matched\n");
>         }
>
>         return ret;
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

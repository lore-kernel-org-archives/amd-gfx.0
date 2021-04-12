Return-Path: <SRS0=UsYE=JJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B5FC433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 16:03:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B49E26124C
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 16:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B49E26124C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7563789C0D;
	Mon, 12 Apr 2021 16:03:39 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02F3989C0D
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Apr 2021 16:03:37 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 v19-20020a0568300913b029028423b78c2dso4655677ott.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Apr 2021 09:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=j4ISVK36qz9swohRMmpzrOv5ckEb19YzPGl7GIqUZI4=;
 b=RsuTPOHVeoGZd/CcsbvS1JoZGB6dw8YgGTsCeairFGnsw+TSm7Vvq8Zb5xAUNpMI6e
 mo3+lbXvlInGdBVrl19po7rilG7Z9npZO/xMPHnRLyhmS1ppIsyibIOQ8QchZ3KBUSQ4
 qlWPELzGqBZNmtw20dlznAuk9csp4tl6zyHFgOTw38JiavNPgxxiGFM5Q8IVn0DR2sX8
 TPE2u6zRo6bh+8DYyMCD6kpl1D3dVByujEYLtSKhDZOxXyBCtjBDt+g7X/0lp8VyXYq2
 NN0+bcSBZMJGSS4qRgXdb6YEt95IwM2h9oI9FeGNSGkzKbwZGSTdiPjc6hT6M8Rt+orA
 Ipzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=j4ISVK36qz9swohRMmpzrOv5ckEb19YzPGl7GIqUZI4=;
 b=HMo2FY8GIXlka5Kep433bqs+Aa8nhXx1kicjAgTwKI5yIfrYVyrow/1FYRLnWx54yD
 vLc6/HEj60tf2kGTbQpnyOZz1X5dZ7Yke/CHuaY9v8ot7eSzzHPEBI43QlQuWDtcY2to
 7dFIcLsPNtixaxHWDPSBsoKUG6qmVzqV3yn3LNMC6IGPV3M0baQ+jbOEqoTpw18b7WKJ
 LCva80r0yuL6oahl5Wo5HFcUGOYEvgHpYHx3Gxg9B7jB4zFaxTqRhVEwcdSEq3P0alew
 7LdO6gPgFv+7FTR4r9cHGB5oNl/gOcgr7ZtZH2U9fgj1owGyVbSSkpuQkq6KChAH/ald
 56wg==
X-Gm-Message-State: AOAM533HV4VAGK76Kaq7x6LltLAzUigTOs+KDmD0YMRXNQEx7Qz74rKQ
 L+Fkzl0ri88lkzX/9XyAPxMROL+DYyax+w2/lkCWDkbifRI=
X-Google-Smtp-Source: ABdhPJy90NvaLJjoPmHIxaFCzb95sIkk52t88IoyRHEAqmcUQq2jIEBhRY5GXsjLLlIB/KFUt1i/Z5aaokm3qcGdQ7s=
X-Received: by 2002:a9d:663:: with SMTP id 90mr24672549otn.311.1618243417369; 
 Mon, 12 Apr 2021 09:03:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210412160121.27434-1-kent.russell@amd.com>
In-Reply-To: <20210412160121.27434-1-kent.russell@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 12 Apr 2021 12:03:26 -0400
Message-ID: <CADnq5_O_G5GWbt75ZRoN1YKfLK+9eSnu-XBi4q+kqXzCkt2UoQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Ensure dcefclk isn't created on Aldebaran
To: Kent Russell <kent.russell@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Apr 12, 2021 at 12:01 PM Kent Russell <kent.russell@amd.com> wrote:
>
> Like Arcturus, this isn't available on Aldebaran, so remove it
> accordingly
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 204e34549013..8128603ef495 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -1844,7 +1844,9 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
>                 if (asic_type < CHIP_VEGA10)
>                         *states = ATTR_STATE_UNSUPPORTED;
>         } else if (DEVICE_ATTR_IS(pp_dpm_dcefclk)) {
> -               if (asic_type < CHIP_VEGA10 || asic_type == CHIP_ARCTURUS)
> +               if (asic_type < CHIP_VEGA10 ||
> +                   asic_type == CHIP_ARCTURUS ||
> +                   asic_type == CHIP_ALDEBARAN)
>                         *states = ATTR_STATE_UNSUPPORTED;
>         } else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
>                 if (asic_type < CHIP_VEGA20)
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

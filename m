Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D68DC56201
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 16:39:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11F2C21D7B
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 16:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=basnieuwenhuizen.nl header.i=@basnieuwenhuizen.nl header.b="DEiPUlPR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11F2C21D7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D2B76E103;
	Wed, 21 Oct 2020 16:39:34 +0000 (UTC)
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com
 [IPv6:2607:f8b0:4864:20::d44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CBAC89DB2
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 16:39:33 +0000 (UTC)
Received: by mail-io1-xd44.google.com with SMTP id k6so3873882ior.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 09:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=v1uPqhJZQVVQLRvzzixGQ7tVTsRuVrTv3qKtsDwEqE4=;
 b=DEiPUlPRUXam4/ZFI1wuqDuQFSp6KsCBrVrcZf+ovaRQgX1tESbnsWKPhBJJUpk6II
 DXP/KzZee0PifeLaauVyemkeF0oQXUtOkNU1b6xE2Atjzn4Sk0ryDyCj8WLuGhNG2eGM
 4qsD5Frp2gg60MkQzJ3lZzUlS6qS18IUdI+x3CcbiV0FBzQsmFVvIR64YUXWxWFav9Ca
 Ahr2Ra9bAWx5heqktoY0RYkwb2++PO3xI5FkQnJEAWaozKNvZfxfGXf6Nk1+0cCiz6ko
 3htBndZyh/uRagaQdE2QFeQls9z4QqAzB4kvlGJhcwt5VDOn+dOd9nWo9hCA7Axj/pnP
 xF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=v1uPqhJZQVVQLRvzzixGQ7tVTsRuVrTv3qKtsDwEqE4=;
 b=s2rWbDk5qJFs0v3Zl6xJYtnDLjooJwNw2tPTlGqfp0UcCkY1s2pgYC5xzHLpGVwQOC
 hgjAVVg11gkZvV/s8rxZ1TwaQNO6N0py6lDw0FIcRjY+0tHcLCKenUxsOFRuTXPEG/OO
 Vfv0g8RWe+s7rdq7MiC/RDgCyU5QGR+SlsKMGAlu/SrxCqJI9ndzhhDNQlk0dFah7f63
 rJKp2Rkhy/0qUjZp6dkD9e0B4t2pBJCKVxj/m4cKSxn72dAccFVbbCq6slyFQi/r8r5D
 4qi0IvOxybRVJThgQSLuOv1rXXKZZOutZqg2VrPu1x0FkNdzPUoXVHh9D6ra8xlaWcqj
 it/A==
X-Gm-Message-State: AOAM530nmNrJMRk+edBjpwFmdBx9oAokgNVnOFExDO92go1/zwsEZKtZ
 +BjvAgciJMiW+6bg4vqkodq3v5yNU9BenvvgiDt3PA==
X-Google-Smtp-Source: ABdhPJxVEy4vRpWGgkSmaQovpgihNjvhnDZrqISNBh0liGZxcXIneusEiAR7j52/Tj+CL5sRNNRWWfVoFylvQRu7rrk=
X-Received: by 2002:a05:6638:d0d:: with SMTP id
 q13mr3784831jaj.115.1603298372440; 
 Wed, 21 Oct 2020 09:39:32 -0700 (PDT)
MIME-Version: 1.0
References: <20201020223113.310402-1-bas@basnieuwenhuizen.nl>
 <20201021160922.210403-1-harry.wentland@amd.com>
In-Reply-To: <20201021160922.210403-1-harry.wentland@amd.com>
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Wed, 21 Oct 2020 18:39:22 +0200
Message-ID: <CAP+8YyEqPkA6TPTuZG5+jWYppcuYX9yXyk_RAAw_FCeZEZ6U0A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Interpret log_2(0) as 0
To: Harry Wentland <harry.wentland@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Roman.Li@amd.com,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Oct 21, 2020 at 6:09 PM Harry Wentland <harry.wentland@amd.com> wrote:
>
> Even though log(0) is technically undefined our code assumes that
> log_2(0) is 0. This mirrors the current behavior of our log_2
> implementation on non-Linux platforms.
>
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> ---
>
> What's num_pkrs value is upstream Mesa providing for CHIP_VANGOGH?

So mesa isn't quite providing a num_pkrs value to the HW as the render
HW doesn't require you to set one, it assumes something.

In practice mesa still uses num_pkrs, which is provided by a readback
of the GB_ADDR_CFG(CONFIG?) register info provided by the kernel. This
can be used for e.g. determining texture coordinates (like we do for
the displayable DCC transform) but otherwise isn't really needed,
since the tile size for texture allocation is not dependent on
num_pkrs.

so outside of displayable DCC I think you'd be able to get far in mesa
with a wrong num_pkrs.

>
> I saw that problem at bringup with an internal Mesa and had this fix
> for it.
>
> Harry
>
>  drivers/gpu/drm/amd/display/dc/basics/conversion.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/basics/conversion.h b/drivers/gpu/drm/amd/display/dc/basics/conversion.h
> index ade785c4fdc7..da9883ec7b1c 100644
> --- a/drivers/gpu/drm/amd/display/dc/basics/conversion.h
> +++ b/drivers/gpu/drm/amd/display/dc/basics/conversion.h
> @@ -40,7 +40,11 @@ void convert_float_matrix(
>
>  static inline unsigned int log_2(unsigned int num)
>  {
> -       return ilog2(num);
> +       /*
> +        * Technically log(0) is undefined, but our code is structured
> +        * in a way that assumes log(0) = 0
> +        */
> +       return num ? ilog2(num) : num;
>  }
>
>  #endif
> --
> 2.28.0
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB941C61DA4
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 03:02:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C39A10E2D4;
	Tue,  7 Feb 2023 03:02:16 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3451310E2D4
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Feb 2023 03:02:14 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id bd6so2546031oib.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Feb 2023 19:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c5LsDs9/VcKgTh4odLu0aUeIcklHB5qXyon6dyuurG4=;
 b=j8234hf5edyPZTp6C1etnb/1IKO+awEfLRnCB0FmJN76q9tJWqzEO/3RjoB8T0qesQ
 GX5KjWlmAMn+ECsHZqeR7U98tyqXE610nMgj/oJIsYE+8vprEZcfxyjhCUIrQxXeFBNf
 NPSPrAZ+Ilivrn7+Q2ZnOL+wi3i+TjZV0KFn7y1rGfXppAhTf4lb4rmokgKJ/0JSW9BY
 iFWNJUAW7+lIlFeIBegwSdrPnly6zPkuHKjJLpeLtdzrDGNC+WAxsTTkkD2XuYUzr7Fy
 fC++LFhOohqFvqxCwsX5k+7WJjpQqGh9qil0iom1/MnCspvjTfNaQggmDvXDEhLEmEUl
 9How==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c5LsDs9/VcKgTh4odLu0aUeIcklHB5qXyon6dyuurG4=;
 b=ewVToBWQxqa4aExwB1ESfdchvYTzHuL27TK+qZsiCr+1P/6O1bbJuL7fpA/GHoz1lo
 qlCLFEXnQlio4F6t9Xn7cbkS4P2f4qhNXeGJMhJ7qRbxtUkErsK6WdSSoexv0do5e39h
 AGbV2b9xBIcM35fXSqEwDPlJpb+dr9bIN/k/jYI67ZTMOfxjjh2wP3ocSuoMbMKFydRr
 sij6Y7rzqGfLEujAVKnYELE+9cM7GiQLbjSg7PlJMTVNTWjkhORjToeCUlqjR01tuAqs
 0Ug/a6OlA9r6Z9+F/F3AXBZ9rIXXHnEuaQ4vjLhNOf1kE/KAw3Je8wEKn3CD1o5IS0oB
 q5mg==
X-Gm-Message-State: AO0yUKWJ8CzUfr7CnAMQD7UlKQs4qGVHKPcIMm+Bb+SEyT9m4xaIXzN2
 riTPDXMVfDVv2RLN7YiOqC7wchhsfoMgL3v0dN0=
X-Google-Smtp-Source: AK7set+FVRL5BSRQg8pPmcPSAqNJ/d+MkRbmxsQPVsLdVzwtuNOeoZ/A+AddSY6TvkfkomdbpGSriV4s7yuIHP/m9WY=
X-Received: by 2002:aca:654d:0:b0:35b:d93f:cbc4 with SMTP id
 j13-20020aca654d000000b0035bd93fcbc4mr168101oiw.96.1675738933307; Mon, 06 Feb
 2023 19:02:13 -0800 (PST)
MIME-Version: 1.0
References: <20230207024855.1589467-1-evan.quan@amd.com>
 <20230207024855.1589467-2-evan.quan@amd.com>
In-Reply-To: <20230207024855.1589467-2-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 Feb 2023 22:02:01 -0500
Message-ID: <CADnq5_MgDDi1kMSofR5LrMHkiND4cEJYempPJ5FGE3wno-PNng@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/pm: bump SMU 13.0.7 driver_if header version
To: Evan Quan <evan.quan@amd.com>
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
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Mon, Feb 6, 2023 at 9:49 PM Evan Quan <evan.quan@amd.com> wrote:
>
> This can suppress the warning caused by version mismatch.
>
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: Id3331a329ea9b1dbc45d8a4e773af1cbe8e21a27
> ---
>  .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h | 3 ++-
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h                   | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h
> index d6b13933a98f..3446a569057a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h
> @@ -126,7 +126,8 @@
>                                           (1 << FEATURE_DS_FCLK_BIT) | \
>                                           (1 << FEATURE_DS_LCLK_BIT) | \
>                                           (1 << FEATURE_DS_DCFCLK_BIT) | \
> -                                         (1 << FEATURE_DS_UCLK_BIT)
> +                                         (1 << FEATURE_DS_UCLK_BIT) | \
> +                                         (1ULL << FEATURE_DS_VCN_BIT)
>
>  //For use with feature control messages
>  typedef enum {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> index 40adc4fa808a..1c0ae2cb757b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> @@ -32,7 +32,7 @@
>  #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_4 0x07
>  #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_5 0x04
>  #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_0_10 0x32
> -#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_7 0x35
> +#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_7 0x37
>  #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_10 0x1D
>
>  #define SMU13_MODE1_RESET_WAIT_TIME_IN_MS 500  //500ms
> --
> 2.34.1
>

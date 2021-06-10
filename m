Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52939C48BDF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 20:21:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13CD4613B0
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 20:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13CD4613B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88B466EDCC;
	Thu, 10 Jun 2021 20:21:34 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD38F6EDCC
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 20:21:32 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id t140so3505474oih.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 13:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ekUZCdfzyh1KFCDBffmsViX3CMJbzWxZQOsX1EDEW2s=;
 b=ZymXiSYFBgbwdLnpQR6UkB2sWnTFtt+12XEm5FkIy0ue/1XLRgvFLHxdMFBltAzAR5
 hRYGByHX/wWJq1dWXTn0VUpr/albPf5Ku9ZQne+21Vjdkduq5Cj3Cdqt3oeImFzC4UI/
 a+ft+12Q6nql/mVLvAqo5td8EPWsyzdvVZK8YKM6STFbeKTCJxb7ZUxqGwfjVIzWLRHq
 dZbcCZLzbXdM8r0kv2EZDAuD6irw8ok4cHs42IjZbDh5j1s9Xr1QDwKry4ka1k39Tvqs
 FxOQXBy8cwNiXFm5MuUbzi3uPaUvXJ6OTPaBRNOOs0KtIHeeCtvMBPl/DQ3uEjoBEs0f
 4NRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ekUZCdfzyh1KFCDBffmsViX3CMJbzWxZQOsX1EDEW2s=;
 b=DdBmSQQxEr60GsaRi4EutqEGJSJq8VBW1LU/NgOlQwDQaKUfCgc5Ei9UiWrLxSUlr1
 WWRnkan/uwB3qVaZ/wx18B5b4zYiXZG0vwVAg52+Ot71VXgyirXDFj+ekMnE0dkd/QMT
 xbJHFWP1EIfhcWmg9DneREXMK2dhX83s7WUMCuQI5WsDFW7q4T0vqCEscSuK6KdBnicG
 HSTAbNqFAYJ9BPAeZ4hVJMGz3CUv8yZ3oA68nRIsgb8vl/0xnWFwfYrDCd2XzEf2ooX9
 Yw5Ov4ACpsUc1YTWl3lwA/Wt11o6rCG0T2hfo5OtQ6yZOpaScjlJkHpagtLraLbBpjXl
 XIkg==
X-Gm-Message-State: AOAM5322v28TqZ4If7S9DQPDsj6KoJiT2YijF0sPuJE/thnQ75j52UIa
 V9vUz12IGqq5cM67AOsrHj/yYKtoFifPxHH7wsQ=
X-Google-Smtp-Source: ABdhPJwomqtXt3PMQaA5rGvG7rjZa1Nrb3Nd6sFkZy+hfB+nK4NlbficKvbxH3xmpsg2Gq/x21a5G9J68D5tuOtMkM8=
X-Received: by 2002:a05:6808:c3:: with SMTP id t3mr10753038oic.5.1623356492154; 
 Thu, 10 Jun 2021 13:21:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210608213954.5517-1-luben.tuikov@amd.com>
 <20210608213954.5517-15-luben.tuikov@amd.com>
In-Reply-To: <20210608213954.5517-15-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 10 Jun 2021 16:21:21 -0400
Message-ID: <CADnq5_PJE5_ogdxEDcj8WoSmVFWMnfu-u4x-5vVLdvdrocbkiA@mail.gmail.com>
Subject: Re: [PATCH 14/40] drm/amdgpu: Drop i > 0 restriction for issuing
 RESTART
To: Luben Tuikov <luben.tuikov@amd.com>
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Lijo Lazar <Lijo.Lazar@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Stanley Yang <Stanley.Yang@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>, Jean Delvare <jdelvare@suse.de>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jun 8, 2021 at 5:40 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Needs a commit message.  With that fixed:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> Cc: Jean Delvare <jdelvare@suse.de>
> Cc: Alexander Deucher <Alexander.Deucher@amd.com>
> Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
> Cc: Lijo Lazar <Lijo.Lazar@amd.com>
> Cc: Stanley Yang <Stanley.Yang@amd.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       | 2 +-
>  drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 2 +-
>  drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index 73e261260b76e6..72b02025b07e06 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -1954,7 +1954,7 @@ static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
>                         if ((msg[i].flags & I2C_M_STOP) ||
>                             (!remaining_bytes))
>                                 cmd->CmdConfig |= CMDCONFIG_STOP_MASK;
> -                       if ((i > 0) && (j == 0) && !(msg[i].flags & I2C_M_NOSTART))
> +                       if ((j == 0) && !(msg[i].flags & I2C_M_NOSTART))
>                                 cmd->CmdConfig |= CMDCONFIG_RESTART_BIT;
>                 }
>         }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 5dc48e557c2bad..289d09a5d711b9 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -2749,7 +2749,7 @@ static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
>                         if ((msg[i].flags & I2C_M_STOP) ||
>                             (!remaining_bytes))
>                                 cmd->CmdConfig |= CMDCONFIG_STOP_MASK;
> -                       if ((i > 0) && (j == 0) && !(msg[i].flags & I2C_M_NOSTART))
> +                       if ((j == 0) && !(msg[i].flags & I2C_M_NOSTART))
>                                 cmd->CmdConfig |= CMDCONFIG_RESTART_BIT;
>                 }
>         }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index fdbc54622dbfbf..e8e57462ce9d64 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -3437,7 +3437,7 @@ static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,
>                         if ((msg[i].flags & I2C_M_STOP) ||
>                             (!remaining_bytes))
>                                 cmd->CmdConfig |= CMDCONFIG_STOP_MASK;
> -                       if ((i > 0) && (j == 0) && !(msg[i].flags & I2C_M_NOSTART))
> +                       if ((j == 0) && !(msg[i].flags & I2C_M_NOSTART))
>                                 cmd->CmdConfig |= CMDCONFIG_RESTART_BIT;
>                 }
>         }
> --
> 2.32.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

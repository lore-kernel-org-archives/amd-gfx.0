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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834E1C48BD1
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 20:22:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49C48613B0
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 20:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C48613B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F06376EDD0;
	Thu, 10 Jun 2021 20:22:41 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08B926EDD0
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 20:22:40 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id w127so3447383oig.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 13:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4i/3hPXi28JQS3dK0U0abRDzx2bBXT8YKARol6hXIU4=;
 b=jh23fnmToweDzjZINKySx3yS5M0dfbbSGR9ZArxZmF6tLt1834wE6/XHUlc9zgtYJP
 XNx0sXQbSa+6uSswQmLEvFBoR6pb7vlpwqL1qWKAccWyJk2pIWyn6GjT2EwY2z9yWRD3
 AjMockDDH/oHoab3vqPGhaE/E2jaNMZxG691oYjzjZQE3jzp50TXppkOmPMys+u3UeUp
 6T2e6D9Y+am/J6ILYlPof03YjLmnKtkUZCJ+iQLQck57HOY/h56tr055gmqOLbR6ZTkH
 3WCHgS7z3DrA22nv3t+arhnFLs75DAHliwpunxQQouSrWPyJ3bUCbZAmiyF+nMCvZBq1
 /Csg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4i/3hPXi28JQS3dK0U0abRDzx2bBXT8YKARol6hXIU4=;
 b=sBZ/H9SN74b7vbMhsoHhyKc3g0INDYpSuPP4xpqHsL7P5CBbb2spy4WGctDP5GDuWp
 6nLLh8aveZSPljqU5grN+gvE9qkbHEK1aCmkqHbA+1A2yRhWxkSNzJmO8IebH3jD6FWG
 1j4OHfb0dfOaf5Wu0J1Iw5/5X1y5K3oL7Ck/gdU72c8z34pZyPpwRhZJ4u1JyhUAHIg2
 oc7NMYp4y08B9HLE6iW8PKVg/vsw+l8YY9nigT3Az5m50jtUQNPXCMxS0HDy9/3s1w9Y
 KOVDnImIbFIkQD5Nn0AaoY3nfaae35stgnchh7uAEOZvs+z91+sGtdLcW7Tt0YqWk1fa
 xAuA==
X-Gm-Message-State: AOAM530WE+DZLtTBiHpAfoLoKWpdOmZ2XFgh+mMYrTjT/S9XvNmwV6YQ
 v7Y6xMjR32Xr5AG8ZZ6JSCSs4YFZySoKgJmhXkU=
X-Google-Smtp-Source: ABdhPJxU0SLLaS15111kUuVOLYMZAmUUAvQuTytJtp+LLLT0gpWSNg5zvzU5q9b9HwGfqV4hAQjji4q+skCyFkKmjAU=
X-Received: by 2002:a05:6808:14c9:: with SMTP id
 f9mr186723oiw.120.1623356560397; 
 Thu, 10 Jun 2021 13:22:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210608213954.5517-1-luben.tuikov@amd.com>
 <20210608213954.5517-16-luben.tuikov@amd.com>
In-Reply-To: <20210608213954.5517-16-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 10 Jun 2021 16:22:29 -0400
Message-ID: <CADnq5_OwyjrQf=UOFGiLfKH3tixNpj8z_OsRySBsthn9WQ39ag@mail.gmail.com>
Subject: Re: [PATCH 15/40] drm/amdgpu: Send STOP for the last byte of msg only
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
>
> Let's just ignore the I2C_M_STOP hint from upper
> layer for SMU I2C code as there is no clean
> mapping between single per I2C message STOP flag
> at the kernel I2C layer and the SMU, per each byte
> STOP flag. We will just by default set it at the
> end of the SMU I2C message.
>
> Cc: Jean Delvare <jdelvare@suse.de>
> Cc: Alexander Deucher <Alexander.Deucher@amd.com>
> Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
> Cc: Lijo Lazar <Lijo.Lazar@amd.com>
> Cc: Stanley Yang <Stanley.Yang@amd.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> Suggested-by: Lazar Lijo <Lijo.Lazar@amd.com>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       | 4 ++--
>  drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 4 ++--
>  drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index 72b02025b07e06..235e83e9f0feb7 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -1951,9 +1951,9 @@ static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
>                                 cmd->CmdConfig |= I2C_CMD_WRITE;
>                                 cmd->RegisterAddr = msg->buf[j];
>                         }
> -                       if ((msg[i].flags & I2C_M_STOP) ||
> -                           (!remaining_bytes))
> +                       if (!remaining_bytes)
>                                 cmd->CmdConfig |= CMDCONFIG_STOP_MASK;
> +
>                         if ((j == 0) && !(msg[i].flags & I2C_M_NOSTART))
>                                 cmd->CmdConfig |= CMDCONFIG_RESTART_BIT;
>                 }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 289d09a5d711b9..b94c5a1d3eb756 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -2746,9 +2746,9 @@ static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
>                                 cmd->CmdConfig |= I2C_CMD_WRITE;
>                                 cmd->RegisterAddr = msg->buf[j];
>                         }
> -                       if ((msg[i].flags & I2C_M_STOP) ||
> -                           (!remaining_bytes))
> +                       if (!remaining_bytes)
>                                 cmd->CmdConfig |= CMDCONFIG_STOP_MASK;
> +
>                         if ((j == 0) && !(msg[i].flags & I2C_M_NOSTART))
>                                 cmd->CmdConfig |= CMDCONFIG_RESTART_BIT;
>                 }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index e8e57462ce9d64..2fa667a86c1a54 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -3434,9 +3434,9 @@ static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,
>                                 cmd->CmdConfig |= CMDCONFIG_READWRITE_MASK;
>                                 cmd->ReadWriteData = msg->buf[j];
>                         }
> -                       if ((msg[i].flags & I2C_M_STOP) ||
> -                           (!remaining_bytes))
> +                       if (!remaining_bytes)
>                                 cmd->CmdConfig |= CMDCONFIG_STOP_MASK;
> +
>                         if ((j == 0) && !(msg[i].flags & I2C_M_NOSTART))
>                                 cmd->CmdConfig |= CMDCONFIG_RESTART_BIT;
>                 }
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

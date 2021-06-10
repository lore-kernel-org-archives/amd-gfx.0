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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C1FC48BDF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 21:12:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12A2E61428
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 21:12:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12A2E61428
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0D536EDF9;
	Thu, 10 Jun 2021 21:12:25 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 377076EDF9
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 21:12:25 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 j11-20020a9d738b0000b02903ea3c02ded8so1097483otk.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 14:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eLIVhWaiNeDNII/qZYtKRX0yrSzoFWuhSUzvfSUzmQY=;
 b=ml5pwcXl4xzJSQn/nJj+nDjT7ER+j5J0i2nZQzHWyRdkCyjRafCjEDFq2nUoKpkT75
 Qk+gIxq8ikezzP6EZy6WZ76qefhTTmR21EPMVWfr6YXTyV6CBRHuFkpugX/Z9Rhg3HeN
 Go98EA+BEaULvQDNvfRYi1CjHWGQPSLus11rTXgwZSOmCa7mmwXnLaSrpBzZzjBVp3gv
 jDj4k0xPE/nQQc5fBvkrTR4cHyjylLjMkNb5d02mAQs/a5RN6Spk7trlyL+U+Ffg/dH0
 5yBBaA8nNlzLor/TM3ox7sy5rRX6KDxujrSjtLaMMZmxNMgBN5TorkGHuJ5ugTyEvKhx
 ob+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eLIVhWaiNeDNII/qZYtKRX0yrSzoFWuhSUzvfSUzmQY=;
 b=GlmFXM1EDxnBaefjR5UybE5ivQzSCCDdvoKHTXbLzIWiPPvPLVXoWFyr1THkA1vc0I
 lHO2WtgEGtYDJlMJDaImkDe96XKpKf8DQhDHktDRZBtjR98QxHA4dtY0mSDXfmnaNTCQ
 bFaDhNOgWkNhUz5rGZsHN1PAYm3DzSP1h81d5+k7Q6t9eUwIUGJ71B4k722RvJm37nGL
 8ePFFV2SrlKQnrSm9HLB3WZFPzzFHj0k4TLs7jSgJSEgQJNGDnBSYOH0LbkS4hKhJpia
 EKhzMIvEY1HonIhq33UbB+qE9Ej+r1EtXiiAeo4GeIdzB6wAvDFMuw95XVmfJJYQmYCk
 FGXg==
X-Gm-Message-State: AOAM532+M/nZ3ng7wSJRVxc/4t+CA88GZghtUzZzFJHwjBNdDNwPiARJ
 PxHHYi8iNwqXAmNMZ5Hl57Rq65IQXV9F/Tn+Zpc=
X-Google-Smtp-Source: ABdhPJyf043dxP7TrfbJuY84xiCa7y/R0nik6q3AiZVdAq07u6gaa0bMGk2oMAO62F5fn1le6BDdMpAjeaYPHh8QMrg=
X-Received: by 2002:a05:6830:1e64:: with SMTP id
 m4mr273782otr.23.1623359544629; 
 Thu, 10 Jun 2021 14:12:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210608213954.5517-1-luben.tuikov@amd.com>
 <20210608213954.5517-34-luben.tuikov@amd.com>
In-Reply-To: <20210608213954.5517-34-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 10 Jun 2021 17:12:13 -0400
Message-ID: <CADnq5_OLmoW1QhT-5ztWtbgq0NuvzMK+=rsQfu4YxoMkF2SYZA@mail.gmail.com>
Subject: Re: [PATCH 33/40] drm/amd/pm: Fix a bug in i2c_xfer
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jun 8, 2021 at 5:41 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> "req" is now a pointer , i.e. it is no longer
> allocated on the stack, thus taking its reference
> and passing that is a bug.
>
> This commit fixes this bug.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>

Can we just squash this into the original patch where this was broken?
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       | 2 +-
>  drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 2 +-
>  drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index 0db79a5236e1f1..7d9a2946806f58 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -1957,7 +1957,7 @@ static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
>                 }
>         }
>         mutex_lock(&adev->smu.mutex);
> -       r = smu_cmn_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, 0, &req, true);
> +       r = smu_cmn_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
>         mutex_unlock(&adev->smu.mutex);
>         if (r)
>                 goto fail;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 2acf54967c6ab1..0568cbfb023459 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -2752,7 +2752,7 @@ static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
>                 }
>         }
>         mutex_lock(&adev->smu.mutex);
> -       r = smu_cmn_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, 0, &req, true);
> +       r = smu_cmn_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
>         mutex_unlock(&adev->smu.mutex);
>         if (r)
>                 goto fail;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 44ca3b3f83f4d9..091b3339faadb9 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -3440,7 +3440,7 @@ static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,
>                 }
>         }
>         mutex_lock(&adev->smu.mutex);
> -       r = smu_cmn_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, 0, &req, true);
> +       r = smu_cmn_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
>         mutex_unlock(&adev->smu.mutex);
>         if (r)
>                 goto fail;
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

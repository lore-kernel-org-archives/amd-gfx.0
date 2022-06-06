Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28E6C43334
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jun 2022 17:16:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 381E710EA5F;
	Mon,  6 Jun 2022 17:16:40 +0000 (UTC)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E69610EA5F
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jun 2022 17:16:39 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id h187so7414605oif.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Jun 2022 10:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2jQ5iXFuPh2TesaaWU0BOf05156uqQ4kDUX/aDw6pqk=;
 b=Dd80OVTBieTujiDleAcEmBmaQcTmdcf0wcaVUOmB+ShMxb5z0LUuJ9JX/8TrpgZLG7
 clxKXYpWlvmw3AWx+6drKuU7dTO9F+oee43ekQjakDXsAYKRtG6l/8sYfuPXPDuYK5fA
 9HuVoqwm5N1jgvcD+KO0ESrZoRKnFzmNIvER4F7p4ek/mPn2xGSqTGRJL/zpwRdugy8Z
 QOhPhmhA5pKzm6y1pqURJqh8/xCStIM1ER/XcpF8EI9ACGpz2tiivDi9UUbIEddg7hb1
 2mq5foyaPheJgm78V8G87y115c9/IjVg175CWpA/DyhZ8/Gx3fEizXxppUdWlFJFXlO+
 3MXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2jQ5iXFuPh2TesaaWU0BOf05156uqQ4kDUX/aDw6pqk=;
 b=M6he9MP5XjcgAC1PpOzpuXC5fBhd5zJGl0jhTbzuqk8LANo+I+Q5CR7Y0ZvdCsXYWY
 vDO1EBt9fJcfmUX8PUDJeKYMlQ7QZokltPO71p5n0Xof1ZFhKeabCbK72dTDkLByf1jL
 cTtMZAhOOJq3mdA3z2upV9OYu/PKEZPG09Fvux1Km/YlHEa80zBF7qTm0o9wCBQpHiL+
 M4LK1UvZ3+qo6duUPlcYp3b4HF0rUhAyjHGa3diOk+YyPcznXb6Kt/iDGz30jbisnwtj
 DaIdhJifma9N6vcrmHlo08tt6YAaD7rLrAl7LsrSxbE7qer60b0ONLBw6pouFNUs3yxi
 y11A==
X-Gm-Message-State: AOAM533rfaMqeeQNf2KtKCbWUXQYrd9j4EoFGGdRTMA/H3Mf25iHx6WD
 pOQLFZPKJgreRSkOOmfIpjefL71bgVQR3kfKFDbsBnUF
X-Google-Smtp-Source: ABdhPJzQpZnGxIhSAKFGB+nfMrLQUStSXPIqmoqiTUjcNLCwxwNglLf3s+xbaPf9DV409Fyudx4AWQ79vtoQsrE6NYA=
X-Received: by 2002:a05:6808:114f:b0:32b:1be0:2316 with SMTP id
 u15-20020a056808114f00b0032b1be02316mr28817609oiu.200.1654535798407; Mon, 06
 Jun 2022 10:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220606135054.82326-1-aleksei.kodanev@bell-sw.com>
In-Reply-To: <20220606135054.82326-1-aleksei.kodanev@bell-sw.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 Jun 2022 13:16:27 -0400
Message-ID: <CADnq5_PmEn8PqtfyUtRQpnC7hE=JPFfXPDpOVkhgA5RtkmJgFA@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: fix potential buffer overflow in
 ni_set_mc_special_registers()
To: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Mon, Jun 6, 2022 at 9:51 AM Alexey Kodanev
<aleksei.kodanev@bell-sw.com> wrote:
>
> The last case label can write two buffers 'mc_reg_address[j]' and
> 'mc_data[j]' with 'j' offset equal to SMC_NISLANDS_MC_REGISTER_ARRAY_SIZE
> since there are no checks for this value in both case labels after the
> last 'j++'.
>
> Instead of changing '>' to '>=' there, add the bounds check at the start
> of the second 'case' (the first one already has it).
>
> Also, remove redundant last checks for 'j' index bigger than array size.
> The expression is always false. Moreover, before or after the patch
> 'table->last' can be equal to SMC_NISLANDS_MC_REGISTER_ARRAY_SIZE and it
> seems it can be a valid value.
>
> Detected using the static analysis tool - Svace.
> Fixes: 69e0b57a91ad ("drm/radeon/kms: add dpm support for cayman (v5)")
> Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
> ---
>  drivers/gpu/drm/radeon/ni_dpm.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/ni_dpm.c b/drivers/gpu/drm/radeon/ni_dpm.c
> index 769f666335ac..672d2239293e 100644
> --- a/drivers/gpu/drm/radeon/ni_dpm.c
> +++ b/drivers/gpu/drm/radeon/ni_dpm.c
> @@ -2741,10 +2741,10 @@ static int ni_set_mc_special_registers(struct radeon_device *rdev,
>                                         table->mc_reg_table_entry[k].mc_data[j] |= 0x100;
>                         }
>                         j++;
> -                       if (j > SMC_NISLANDS_MC_REGISTER_ARRAY_SIZE)
> -                               return -EINVAL;
>                         break;
>                 case MC_SEQ_RESERVE_M >> 2:
> +                       if (j >= SMC_NISLANDS_MC_REGISTER_ARRAY_SIZE)
> +                               return -EINVAL;
>                         temp_reg = RREG32(MC_PMG_CMD_MRS1);
>                         table->mc_reg_address[j].s1 = MC_PMG_CMD_MRS1 >> 2;
>                         table->mc_reg_address[j].s0 = MC_SEQ_PMG_CMD_MRS1_LP >> 2;
> @@ -2753,8 +2753,6 @@ static int ni_set_mc_special_registers(struct radeon_device *rdev,
>                                         (temp_reg & 0xffff0000) |
>                                         (table->mc_reg_table_entry[k].mc_data[i] & 0x0000ffff);
>                         j++;
> -                       if (j > SMC_NISLANDS_MC_REGISTER_ARRAY_SIZE)
> -                               return -EINVAL;
>                         break;
>                 default:
>                         break;
> --
> 2.25.1
>

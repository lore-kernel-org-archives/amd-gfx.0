Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF738C55ABD
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 20:23:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 458B520825
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 20:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qCocdSrt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 458B520825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFE3A6E53E;
	Fri, 13 Nov 2020 20:23:12 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DF816E53E
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 20:23:11 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id k2so11533917wrx.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 12:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6coAHUT0HGLXiSSTdT6rIRMh35bn5vT671o/NM3B1qw=;
 b=qCocdSrt+pgigoAF0M/ncI+fslZF6NQ5HQBZ7ixXqwZoWcBbg4qbCAtS8WqeOM33lG
 PnG4ohf6WU3AA87IqOFE+lOyN45z0Wl5//5beszpJ0IYy+HfhX1+vAEqrX5Oc2M8BDXi
 RwyHhWR/qnVQ5r2anArvKYKaxTbmiJAjuKgStmY4nTEGka5aeHnJDLcvVpsl2rpR2r/q
 XFdpTT5bhCH+zRv1nq92J+F+vGBBGk5avX1EE7iPvqtMLNTawnsx9jD/n04YgK00vo8u
 HgVzq5GqXcnU6UJpN1yU3iKJ0rNhdDwJcDL5knhINOpfW7n+mbQpV6TNr9UZeEcoZb26
 UH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6coAHUT0HGLXiSSTdT6rIRMh35bn5vT671o/NM3B1qw=;
 b=PS9DO8VL/90HPcM6aq8ZBGZNLEouEuxzghT7xI2iPbXxiMJD4l9pToyyePq19yW9+/
 LjwoIMmeOK88C/8nX7AbRG3XZ4l/otOg73hjoogczjv+GyPLGiR6j2D989EVv6npZOmG
 txJfuU9GhS8Zekah1kLeZtoNc6wfQphmYZJb5S4dFKaQXfsyQu80Gw1lT34+CemW+PV7
 LqbWOPZ/UkalccFlL8a5BmnwXt684qRnoz9pGb+EGiMgr5hvDFimhRZPaALIm32MVp4l
 nlb6I+V/07z7U7183MEKgPTT7Om5Nsz2sCaRdQz9qt8J4e6847VT7A5N7TvIVLWWoYB0
 CemA==
X-Gm-Message-State: AOAM530lTAmS5ZRsH6JAUTLMW/fHqUhV3VHNOgULMtqtiVh56lDdNMf9
 NDpHQqPRwfKIU60sRIHnMOu6c+r2l2XqL0nM8nHr8ArZ
X-Google-Smtp-Source: ABdhPJykGLXUnuVWnGLjv6GobBwuscOa2arL734Lb5IssVUMzH9QuoQQY9bx55Jlob3eHiNMietcf9SkFiX9xUejWLM=
X-Received: by 2002:adf:e551:: with SMTP id z17mr5680132wrm.374.1605298990210; 
 Fri, 13 Nov 2020 12:23:10 -0800 (PST)
MIME-Version: 1.0
References: <20201112222226.41989-1-Ryan.Taylor@amd.com>
In-Reply-To: <20201112222226.41989-1-Ryan.Taylor@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 13 Nov 2020 15:22:58 -0500
Message-ID: <CADnq5_PS4J_WCOxbMyZ+jsUdTY_96PrR9i3yg1j4ZJBX7NS8uA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: fix smu_v11_0_init_power power_context
 allocation
To: Ryan Taylor <Ryan.Taylor@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Nov 12, 2020 at 5:23 PM Ryan Taylor <Ryan.Taylor@amd.com> wrote:
>
> Allocate smu_power->power_context to size of smu_11_0_power_context instead of
> smu_11_0_dpm_context.
>
> Signed-off-by: Ryan Taylor <Ryan.Taylor@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> Reviewed-by: Evan Quan <evan.quan@amd.com>

Looks good to me.

Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index b880c72c322c..9ec5e30edbee 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -469,11 +469,11 @@ int smu_v11_0_init_power(struct smu_context *smu)
>  {
>         struct smu_power_context *smu_power = &smu->smu_power;
>
> -       smu_power->power_context = kzalloc(sizeof(struct smu_11_0_dpm_context),
> +       smu_power->power_context = kzalloc(sizeof(struct smu_11_0_power_context),
>                                            GFP_KERNEL);
>         if (!smu_power->power_context)
>                 return -ENOMEM;
> -       smu_power->power_context_size = sizeof(struct smu_11_0_dpm_context);
> +       smu_power->power_context_size = sizeof(struct smu_11_0_power_context);
>
>         return 0;
>  }
> --
> 2.29.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

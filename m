Return-Path: <SRS0=mBQi=NO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FABAC4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 20:31:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0760661214
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 20:31:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0760661214
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A444C894EB;
	Mon, 23 Aug 2021 20:31:54 +0000 (UTC)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D602B894EB
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Aug 2021 20:31:53 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 c19-20020a9d6153000000b0051829acbfc7so39727508otk.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Aug 2021 13:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YztTrgwvM/nmj6MMrgNrjzMlI5AYchZazMGR/sdkBds=;
 b=BMyImnscdvSRsb5ejTiZG2NMR0fN+ONhbsHfOHRSF7zffkLBfyD+T0p/hJNUaZdKx5
 ng4yZWA1PQ5RB/dZpK9LiuqpEXBeYc6FbISJ4DF0K2k7IW31SF4jzyyBQ7Zro1Q/tXjH
 tzofHxJ0N1fIngWsfH/upkJagIVkqHnG65nBAg9oi11ytHZCZMWK5HMdbgBE7UYD9l7L
 dDSJLfQV0ZbZZ2tVWfT0vB8lZhaFj1k0mlJ34zQKSwfEr1ynk9CYS9Pf6s96jiWEIne/
 AglcdATRxi0rc+jbTrPfRTLMHgJinUqGKTyAz5aVtAEbvZmqjzwYPg59aMFP9KO3kSLz
 /5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YztTrgwvM/nmj6MMrgNrjzMlI5AYchZazMGR/sdkBds=;
 b=Gji+eAuZUopp7CM1lZb/R0XacCb5DJpDe7FGAiWmY2zvjbgXeiFvJMGkhrv+UKOZmG
 2LAUePp0jDDmWhTQIIu7mS4DJpcld40z0VfGbcQC7pVQCy9c2I1Nf6cQsSDo+2RpgPha
 tFG5FTbLbc1+Yx5XM2IVJzRlfK1oklIkfP0wOLtXbCI2wztrkMgaN5mGTznKsKg+OOm/
 CGy1OcySpNt/3x3+sryUqDkAIDhUv7x3twnWGd5y8nFxwXxY07pPbAJARdZa3tH/+Beg
 I2eVDlBlYP7lqicKPQFA4NFFFTafsvshdchENgd6egqtYVwS2iPaCvotBh9vJRrxfIBc
 +XKA==
X-Gm-Message-State: AOAM533p2Ac5YRUuYa/DWbmeWDmQatNg252FqzXnbIk90QzdpfxWveyd
 qFHbPlyKdA27GpBPREQMNYy3YygNHtdu8Ulh6gI=
X-Google-Smtp-Source: ABdhPJxwVaCFmOhToGFrcJFOSAqw2KkSEEg6DfejiKYf8Ch06ZIbpv3b7VSinrTGBbVS5Deb+BYQ4MLKp5xAcj8k14E=
X-Received: by 2002:a05:6830:4:: with SMTP id c4mr29208288otp.23.1629750713165; 
 Mon, 23 Aug 2021 13:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <YSP6Lv53QV0cOAsd@zn.tnic>
 <CADnq5_O3cg+VtyCBGUDEVxb768jHK6m814W8u-q-kSX9jkHAAw@mail.gmail.com>
 <YSQE6fN9uO0CIWeh@zn.tnic>
In-Reply-To: <YSQE6fN9uO0CIWeh@zn.tnic>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 23 Aug 2021 16:31:42 -0400
Message-ID: <CADnq5_PEOr=bcmLF2x67hx24=EWwH7DAgEsPjYqXgf8i-beEhg@mail.gmail.com>
Subject: Re: ERROR: modpost: "pm_suspend_target_state"
 [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
To: Borislav Petkov <bp@alien8.de>
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <Lijo.Lazar@amd.com>, 
 Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 lkml <linux-kernel@vger.kernel.org>
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

On Mon, Aug 23, 2021 at 4:27 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Aug 23, 2021 at 03:49:39PM -0400, Alex Deucher wrote:
> > Maybe fixed with this patch?
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5706cb3c910cc8283f344bc37a889a8d523a2c6d
>
> Nope, this one is already in:
>
> $ git tag --contains 5706cb3c910cc8283f344bc37a889a8d523a2c6d
> v5.14-rc5
> v5.14-rc6
> v5.14-rc7
>
> also, from only a quick poke so IMHO, the error says:
>
> ERROR: modpost: "pm_suspend_target_state" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
>
> which means you need the
>
> EXPORT_SYMBOL_GPL(pm_suspend_target_state);
>
> which is in kernel/power/suspend.c which gets enabled with
>
> obj-$(CONFIG_SUSPEND)           += suspend.o
>
> and if you look at PM_SLEEP:
>
> config PM_SLEEP
>         def_bool y
>         depends on SUSPEND || HIBERNATE_CALLBACKS
>
> (notice the ||)
>
> and my randconfig has:
>
> $ grep -E "(HIBERNATE_CALLBACKS|SUSPEND)" .config
> # CONFIG_SUSPEND is not set
> CONFIG_HIBERNATE_CALLBACKS=y
>
> which means, you need:
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index 4137e848f6a2..a9ce3b20d371 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -1040,7 +1040,7 @@ void amdgpu_acpi_detect(void)
>   */
>  bool amdgpu_acpi_is_s0ix_supported(struct amdgpu_device *adev)
>  {
> -#if IS_ENABLED(CONFIG_AMD_PMC) && IS_ENABLED(CONFIG_PM_SLEEP)
> +#if IS_ENABLED(CONFIG_AMD_PMC) && IS_ENABLED(CONFIG_SUSPEND)
>         if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) {
>                 if (adev->flags & AMD_IS_APU)
>                         return pm_suspend_target_state == PM_SUSPEND_TO_IDLE;
>
>
> but whether that gives you what you want for amdgpu, you probably need
> to ponder on a bit.
>
> I sincerely hope that helps a little.

Thanks.  I think that should do the trick.  Care to send that as a formal patch?

Alex

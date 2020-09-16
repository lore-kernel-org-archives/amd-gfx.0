Return-Path: <SRS0=J3+H=CZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95219C433E2
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 19:59:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33530208E4
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 19:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsCF83WM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33530208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 996856EB1A;
	Wed, 16 Sep 2020 19:59:21 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DF746EB0B
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 19:59:20 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id a17so8145744wrn.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 12:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lA3jAX9/FgsAYluawFk9jDH+zB0GqpsPWzCScL3YMs8=;
 b=EsCF83WMZwsbWQuJKHLm8sklWc7xVKNUa9L/XAlI0IhvVENGKmbk6uqtpX9+51Zehd
 Tx4lMxNaYyjQ1Vpcq/IhEDdztN11SvGQa9Or7Qm9YjY/C9hN5ZECe6VAzgWm927P3LqO
 h7zanR8Wykn2LOFVQXrhJiLiW6lzGg6lkVdNCtilx2shBZ4CdZZ4AEALxpPhIAM1EKGL
 sf+EAfF97wbneIO8kFeUqOVgfvJi84LbUDovr1z0Za5zWr5hNj7UElauKCBdXfcCiHV6
 tVjDtSOKUO0vRbfeXID5FfrW1jsBxYZE9qg7SkkmwQ1jsboo/rPkgTZkOj4R4FBbpvgJ
 qwxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lA3jAX9/FgsAYluawFk9jDH+zB0GqpsPWzCScL3YMs8=;
 b=h2C9JE4/7NS7za46pCYbYWsojcyOaaFUU5bwMJTSwclFZ7WzPhRoBk/sRlAFzDYA73
 mhtdoiAQvnmXXbZi6iInhUmwe3yEZ7OSRh1uGyq5Q5zR6ZIXi6vHR5emNuVJ/v+wtTSA
 2vBvJXJUmFUfgzK9pKuE+eHYLRd+pMU/1npzqbPkM73FXP0GMBF6PfmubnsqTsvQNktF
 R74ZRAh6iPFOV5piXm30iXSgtIZnDrcZEPrAlsDMJZqvrQrrEIu7JATtO+bOuq6LA/0w
 Gp485AZUNBjj61WAov9wyFO0oCpgX/nXtGuZdyohUUBHbeGgv646A+BTLbJ93EMRlZTg
 BWPg==
X-Gm-Message-State: AOAM532Q0WRQ+D18fBlXmV7oWE7TtcOdJBEG2cg4qX2iqpdmk2EO1oOx
 +b/8bwUWYIILdfLcEQUTyFKSZxqb2dHSDkjIJdiQwFak
X-Google-Smtp-Source: ABdhPJzuGUnZGP5UiCF9U4MQ/tmCXUWTGJPo8R//OqUYQA95tCq/xOUOO9SzZchvb9eQeaer3NZCf3AKxNXYX69MJ8U=
X-Received: by 2002:adf:fc0a:: with SMTP id i10mr28018253wrr.111.1600286358895; 
 Wed, 16 Sep 2020 12:59:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200916170839.452442-1-luben.tuikov@amd.com>
In-Reply-To: <20200916170839.452442-1-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 16 Sep 2020 15:59:08 -0400
Message-ID: <CADnq5_MXhS9588h=hFuYokHqsnGnLvK7XAu5dbyaZhx2L7c+MQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: No sysfs, not an error condition
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Sep 16, 2020 at 1:09 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> Not being able to create amdgpu sysfs attributes
> is not a fatal error warranting not to continue
> to try to bring up the display. Thus, if we get
> an error trying to create amdgpu sysfs attrs,
> report it and continue on to try to bring up
> a display.
>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 5d702f6e77de..62174f5e8311 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3400,10 +3400,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>                 flush_delayed_work(&adev->delayed_init_work);
>
>         r = sysfs_create_files(&adev->dev->kobj, amdgpu_dev_attributes);
> -       if (r) {
> +       if (r)
>                 dev_err(adev->dev, "Could not create amdgpu device attr\n");
> -               return r;
> -       }
>
>         if (IS_ENABLED(CONFIG_PERF_EVENTS))
>                 r = amdgpu_pmu_init(adev);
> --
> 2.28.0.394.ge197136389
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

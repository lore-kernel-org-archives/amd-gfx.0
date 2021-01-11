Return-Path: <SRS0=2jl+=GO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7F8C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 16:19:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9A8222ADF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 16:19:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9A8222ADF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CEF3897E8;
	Mon, 11 Jan 2021 16:19:57 +0000 (UTC)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83FC3897E8;
 Mon, 11 Jan 2021 16:19:56 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id 11so170728oty.9;
 Mon, 11 Jan 2021 08:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kQk/AQM450K6HsYuxG7JpSAzrWu0ODwrljUZHEZN97M=;
 b=dib3q2aYgXhFR9Mf7C8qJfqLetr7N5C9iZNxz+f92ooZvmeeYlb3kE2bmHv4nRrPxE
 t0/Cd/9TWcFLTAfL2uT7zM9d9dbk0YIH0rAPHIIOvyRCaruyj/tCr2k3GNMmbtcmZNxc
 454czti9ohIoixYtZ0PjaPbiwgwkOJXeFHq/iA6PGdinWBxxK4FbdWhBV3fnBqKAflQ5
 t2u4gzdijpxx8XiFKIbTJgwS6hIXUOU4fCUZoEP8a/Pzi7ALxA4Ml3FsLWconULeyeFc
 MCenWkYxvsphNjwz336GKmx1fYOvaIR4dHL1ll35Xbc58KJcfVWGb/GmDfoxY3LpvdiK
 446w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kQk/AQM450K6HsYuxG7JpSAzrWu0ODwrljUZHEZN97M=;
 b=kECmgkAsBYiwdcu903mamub1+9yjBJa5t8AYf+hWM0tbioJxnptpdo5Mfe7beRy0M8
 zlTtAfSuGvbdzRVXG8ufecDZ67VD6iE8n2SWT6qWPO2qCZKyezsCiXTlfiYSejtDQaYv
 3NYq0l2lvfJ36TIPgWQ/gte33sezAlOUhusGGgcZ6sWeHTOKtRiX2qBbKtJ75r74qbfz
 8kpbcgVMnpG0Lc18mCByAVQQ9DOdR4B1gX4lNUXJ2jvQwyr2f5FFLGsk3ZzTbPFZQv7s
 877jB8eL1Jj9TflUcwCxrTdYZQ7b8n7smMI8fw/5ZDprJZbaKfbm5EMl3WRLyHENbEfw
 YVWA==
X-Gm-Message-State: AOAM530VDMMTsEsnk7oC3wut3eOKHjSqMwoV9Mkv2B76wu4xwlgceVB9
 shYhxD+797MLphoNvRzVcvq47PGj1wUOWWIGNOw=
X-Google-Smtp-Source: ABdhPJxjNJBIzHwvnWd7Rrj2OAzVwaOmzGHq9pKe7Im3VwHt0XIVxupVuAcl3wvoGfnI9OUDToAvu9pw2dMY3+pjTfs=
X-Received: by 2002:a05:6830:1d66:: with SMTP id
 l6mr11413214oti.23.1610381995915; 
 Mon, 11 Jan 2021 08:19:55 -0800 (PST)
MIME-Version: 1.0
References: <20210111114638.16530-1-colin.king@canonical.com>
In-Reply-To: <20210111114638.16530-1-colin.king@canonical.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 11 Jan 2021 11:19:45 -0500
Message-ID: <CADnq5_PoOSL3XMrK+ZTwppU0wqV3+uOHptA7=GN=EPDRqMZkSQ@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amdgpu: Add missing BOOTUP_DEFAULT to
 profile_name[]
To: Colin King <colin.king@canonical.com>
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
Cc: Xiaojian Du <Xiaojian.Du@amd.com>, David Airlie <airlied@linux.ie>,
 kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jan 11, 2021 at 6:46 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> A recent change added a new BOOTUP_DEFAULT power profile mode
> to the PP_SMC_POWER_PROFILE enum but omitted updating the
> corresponding profile_name array.  Fix this by adding in the
> missing BOOTUP_DEFAULT to profile_name[].
>
> Addresses-Coverity: ("Out-of-bounds read")
> Fixes: c27c9778a19e ("drm/amd/powerplay: support BOOTUP_DEFAULT power profile mode")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 75ddcadf3802..4763cb095820 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -774,6 +774,7 @@ static int vangogh_get_power_profile_mode(struct smu_context *smu,
>                                            char *buf)
>  {
>         static const char *profile_name[] = {
> +                                       "BOOTUP_DEFAULT",
>                                         "FULL_SCREEN_3D",
>                                         "VIDEO",
>                                         "VR",
> --
> 2.29.2
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

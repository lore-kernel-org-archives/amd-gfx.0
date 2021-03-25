Return-Path: <SRS0=ZMUS=IX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37993C433E2
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Mar 2021 16:20:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3C2961A0D
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Mar 2021 16:20:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3C2961A0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BC476EDAE;
	Thu, 25 Mar 2021 16:20:20 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A91AE6EDB7;
 Thu, 25 Mar 2021 16:20:19 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 h6-20020a0568300346b02901b71a850ab4so2475324ote.6; 
 Thu, 25 Mar 2021 09:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nKSvJqqCSOUWkfe9wp2hDPqZTk4vnfocDfcAMR4Vm+Q=;
 b=PJ+dIGwPBoDt8A8ZBrrIVeJ1YEjzTdCsvTzh9qCm2Er+JYs/6S4fW+prmrmciobLKv
 JODdSTqcuj4NC+Bj3Jh2+DdIr2Ya72cirr7niem9/ZaAHHUuxQJsZIBmfe2XOk4qn10Z
 Nz4lemvKSh4rbEjKfGvOagLFf6H1xTpfHVhRf7rXDYmPUPRcWYLWWTtW/a14CaZdhlw9
 4xVOFNIH06ZI1bl5jM0k7rGElTHs9BvkHbB4GDfuAot9Uod7icNjnpmFgAiJbxPtk0yD
 OHcbcQXVsPXYVvWh2jzM83t6Hih7NhkkF9OAf99TqAgylXh6hjVXJv4RMIAhHQAhP5Zd
 yfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nKSvJqqCSOUWkfe9wp2hDPqZTk4vnfocDfcAMR4Vm+Q=;
 b=T1UdOqMCfbVPfwjy0b2xv1eFU9hfx3fSAloy7xR4nc73Lat+Ga2AvAFfr5dzxJWrGE
 YnxGKcWjqZXXgbCJouVuZV8XSCwJUMD/vsLoTSy7o7ESFUOhsaKP4LludeqXYMX0CjRF
 pYuVXx1adutk0P9kFLCMvODjtFPRsVpgPFJRgOt/i4qdLyCe2iK5leto0HSw+Lsztqz2
 Xx+I65UmAAieiT64PvC9J/0uRqJvbI23/4gVyGBCJLbKg+aYEDBGMnY3mmpTRDhlyW+6
 pGg8ogldZv8t4imzEQ8gGhaGIEXYZt28k2Dbn7sNqy4lQJxKpJVYlVR/FGtcIlqi29vR
 atYA==
X-Gm-Message-State: AOAM530Q0SchUY1oSIWHWbfyLieqISMOH9QVSqyyqBs32ukOPwHiW8R6
 pKnFyJc91t9P9BAMJJKO6tkqhVaa7KpFI+HiIi0=
X-Google-Smtp-Source: ABdhPJyXwhh06sg9aV4xoHnYaSylDmhJiN65tLIbqli12fQ2hDikxnf4JYo1asQjFyT4k/QSfjw3wcvPaZdS1DaQQJY=
X-Received: by 2002:a9d:663:: with SMTP id 90mr6047157otn.311.1616689219092;
 Thu, 25 Mar 2021 09:20:19 -0700 (PDT)
MIME-Version: 1.0
References: <1616577461-18556-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1616577461-18556-1-git-send-email-tiantao6@hisilicon.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 25 Mar 2021 12:20:08 -0400
Message-ID: <CADnq5_Mp-v5nFwABkABOux8M8vO_G+6j9oA_uVG2KQsVNdRFUw@mail.gmail.com>
Subject: Re: [PATCH drm/amdgpu 0/2] Convert sysfs sprintf/snprintf family to
 sysfs_emit
To: Tian Tao <tiantao6@hisilicon.com>
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
Cc: Dave Airlie <airlied@linux.ie>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied the series.  Thanks!

Alex

On Wed, Mar 24, 2021 at 5:17 AM Tian Tao <tiantao6@hisilicon.com> wrote:
>
> Use the generic sysfs_emit() function to take place of
> snprintf/scnprintf, to avoid buffer overrun.
>
> Tian Tao (2):
>   drm/amdgpu: Convert sysfs sprintf/snprintf family to sysfs_emit
>   drm/amd/pm: Convert sysfs sprintf/snprintf family to sysfs_emit
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   |  8 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c  |  6 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c      |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c      |  8 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 32 +++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c     |  4 +-
>  drivers/gpu/drm/amd/amdgpu/df_v3_6.c         |  2 +-
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c           | 88 ++++++++++++++--------------
>  9 files changed, 73 insertions(+), 79 deletions(-)
>
> --
> 2.7.4
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

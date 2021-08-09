Return-Path: <SRS0=nf5+=NA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3355CC4338F
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Aug 2021 18:34:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECC526101D
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Aug 2021 18:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ECC526101D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5929D89944;
	Mon,  9 Aug 2021 18:34:02 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2425B89944
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Aug 2021 18:34:02 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id u25so24886269oiv.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Aug 2021 11:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Di+pO2eCQ+mqlL1a4yxhYjYf+Ay7AQ7snpIroHIQakE=;
 b=GixI/WK5jZv2I4m1p1cPo/2H2W8yCBM9OxZEKtY5p5SW8HC+UJKneegb240DcOhTNM
 4UNhCyCVUbpkk3lVmvSbtmwTCEaeqHtpTfNyJF6FnC+edrLrp6tdX1DhkuQofUYn4OvB
 Qn2TmyTIpGrHCesSenCh9kJtAJ/pSaOAFOgdQ+OrFxedDOpPwlr6fKRnvxwahdc2r0zc
 pu+cHgHJiuUz1DMzvNA4eUNcPxOQ/YJe9+dp4c4puy+vmxHo+EHBvg3ya3PDDFKXGbtO
 dkDXr8OntHBsZBYcAfLTCqIBhIA5wSNCj6Lhv+64rdwc550TCbTY6bFeeZnjNEoawpzv
 eScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Di+pO2eCQ+mqlL1a4yxhYjYf+Ay7AQ7snpIroHIQakE=;
 b=VI/10IkwH2hLOETRGaKB49c43Z5fY/mn+w3AsLVHXZFrQPBoGXBbfN1aAOnS0ynzfm
 jc3P89pkVgd4p/XDS0Lo7R3tIhQdLqJhUr3jiJzQ2iizgV0qSVKeBk5Uxmuz1idXhX/s
 rtJGBBnHKSMIqFpY5ZnwnB8L6nhb9u0FxWlkz2NxBvZ4n1BHlkGLij8W8RlJNq1j5AzG
 5CG/o8p19hlUNTPyIrO4GQCYogswkDfA5OcaPJLjDh6S+6OQXoyd+qOsnFhQad42Ahsn
 3/xmdt2RCLgxRdBlTuLyNoejj5xXnbGVv1PAnV/vOs0fQXxSs6ARVa6r/AV+ajWBiOkV
 ik7Q==
X-Gm-Message-State: AOAM533gYq6Y/JH0Rfyo96b/lAiZB/gPnN3njYyWZmlJBrcC/j3yV8fO
 CRykFdjnewyzgn5+GTfORlFq6DEdAZvivbXkk7Q=
X-Google-Smtp-Source: ABdhPJwmM07a/z1JI1PQFPPYJJUJHNb4yeKkhuwgZuEzYUuQ8Y25WXD+vO3ZIYm4iVhdtEQ5eYUJJdt3bkS521uZZP8=
X-Received: by 2002:aca:1313:: with SMTP id e19mr392380oii.5.1628534041509;
 Mon, 09 Aug 2021 11:34:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210808053019.3310-1-darren.powell@amd.com>
In-Reply-To: <20210808053019.3310-1-darren.powell@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Aug 2021 14:33:50 -0400
Message-ID: <CADnq5_MrRWjmC6YFf8G3hGOm5-SMqTDxwiwu5K2sVtgj3MXibw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Replace usage of sprintf with sysfs_emit in swsmu
 powerplay
To: Darren Powell <darren.powell@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
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

On Sun, Aug 8, 2021 at 1:30 AM Darren Powell <darren.powell@amd.com> wrote:
>
>
> === Description ===
> Replace usage of sprintf with sysfs_emit in swsmu powerplay
>
>   v2: rebased on 2f56b0d631eb
>
> === Test System ===
> * DESKTOP(AMD FX-8350 + NAVI10(731F/ca), BIOS: F2)
>  + ISO(Ubuntu 20.04.2 LTS)
>  + Kernel(5.13.0-gb1d634be9673-fdoagd5f)
>
>
> === Patch Summary ===
>    linux: (git@gitlab.freedesktop.org:agd5f) origin/amd-staging-drm-next @ 2f56b0d631eb
>     + c4a20b3363cd amdgpu/pm: Replace navi10 usage of sprintf with sysfs_emit
>     + cd2e3983959b amdgpu/pm: Replace smu11 usage of sprintf with sysfs_emit
>     + bd82d29a9635 amdgpu/pm: Replace smu12/13 usage of sprintf with sysfs_emit
>
>
> === General Test for each platform ===
> AMDGPU_PCI_ADDR=`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
> AMDGPU_HWMON=`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | awk '{print $9}'`
> HWMON_DIR=/sys/class/hwmon/${AMDGPU_HWMON}
> LOGFILE=pp_printf.test.log
>
> lspci -nn | grep "VGA\|Display"  > $LOGFILE
> FILES="pp_dpm_sclk
> pp_sclk_od
> pp_mclk_od
> pp_dpm_pcie
> pp_od_clk_voltage
> pp_power_profile_mode "
>
> for f in $FILES
> do
>   echo === $f === >> $LOGFILE
>   cat $HWMON_DIR/device/$f >> $LOGFILE
> done
> cat $LOGFILE
>
> Darren Powell (3):
>   amdgpu/pm: Replace navi10 usage of sprintf with sysfs_emit
>   amdgpu/pm: Replace smu11 usage of sprintf with sysfs_emit
>   amdgpu/pm: Replace smu12/13 usage of sprintf with sysfs_emit

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
>  .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 26 ++++----
>  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 61 ++++++++++---------
>  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 34 +++++------
>  .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 46 +++++++-------
>  .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 20 +++---
>  .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 21 +++----
>  .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 14 ++---
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  6 +-
>  8 files changed, 115 insertions(+), 113 deletions(-)
>
>
> base-commit: 2f56b0d631eba0e76cfc789d85cc5632256ad42d
> --
> 2.32.0
>

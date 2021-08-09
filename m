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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DF8C4338F
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Aug 2021 18:36:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D98D60295
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Aug 2021 18:36:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7D98D60295
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EA4D8982C;
	Mon,  9 Aug 2021 18:36:47 +0000 (UTC)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D4B38982C
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Aug 2021 18:36:46 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id
 y14-20020a4acb8e0000b029028595df5518so4040118ooq.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Aug 2021 11:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OaUPrJxDAMW8mwX9tO9rjEvy5Eb4rGGn4dt8FrS8dmk=;
 b=i1JfuLfRcggm6Ag5VZCzT3FltemBn7VBfz5gQ7STr7ZpgGnBCSFQsUyW3Qg3C5Y4TW
 UmQJwXJl+HaU0N2IIKBPnYTuBzg8+t4PUwffk864fJpoUeFWJdjIvGPSWU3ojwgFuL62
 f7o4YFIevrLJz3TZB0HzwhDRUZB20aQ9GFiAM7IUQXgQb1hW5Re19cJ3ua34yvPZZYQr
 s2Ihsk1TkgF8dFXMDW+2OsAWSsXoF/29NFjmOVonHycgk77Acr9+PHRWyabueIo3j9Xu
 T5EFDvzx8Ikr610+/Whz+V3mTACt1Ks8qPBUBfng478DvoxHy0uwFtFtrFR1sC8YBBrA
 qp7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OaUPrJxDAMW8mwX9tO9rjEvy5Eb4rGGn4dt8FrS8dmk=;
 b=b2FGd54L0Ned9TObCzFwiHnL0Imzz34Q4LUyn0jeiODac0IQXZ34zent1k+sdNQmiA
 YCptVnf4PABovdA8BtIE/LB96azNa5mgLag3GrBdmnO/wtYU8S3P5RefD4h4dgZzL6fm
 0vfaiHAE5550+voY1TUa7gact+esJr8JskPYqQmhIVEM5n3seXSfSGG9ZUoTlRWpHkKJ
 obWbUI2dbwcD81fVCbMNGL1vWvy/PGbQKqtSgipdf4lxykKQq+ah59s9U++T34aj/MgL
 RLzs47pJsvI5N5dKsJwlYfjK+4p5hTNUSy4qE0WXIITJZX5+3d8OB61mi5QpPcEersAU
 THrg==
X-Gm-Message-State: AOAM531KW89A3P/1QsGUtjSW0CDCm9KOLaFCqI63hyW2bffLPrJdmEOH
 k2XV9YJGGAfLoxX23IDukyU/cFG9tynea8erm+8=
X-Google-Smtp-Source: ABdhPJzu2YHBoMsrkOrVhktDhhJO0v4/y29Mv6TnIhoCygMFGBRwexrGEkVlGxG44DOxCPDkiSGLuTt4yjykTBDIS1o=
X-Received: by 2002:a4a:918e:: with SMTP id d14mr15842589ooh.90.1628534205705; 
 Mon, 09 Aug 2021 11:36:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210808053312.3423-1-darren.powell@amd.com>
In-Reply-To: <20210808053312.3423-1-darren.powell@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Aug 2021 14:36:34 -0400
Message-ID: <CADnq5_Oe8RA9zYRMiH0QMfbr4Ae6hRpqh1fTbh7pN8CoPmSyug@mail.gmail.com>
Subject: Re: [PATCH 0/4] Replace usage of sprintf with sysfs_emit in hwmgr
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

On Sun, Aug 8, 2021 at 1:33 AM Darren Powell <darren.powell@amd.com> wrote:
>
>
> === Description ===
> Replace usage of sprintf with sysfs_emit in hwmgr powerplay
>
> === Test System ===
> * DESKTOP(AMD FX-8350 + VEGA10(687F/c3), BIOS: F2)
>  + ISO(Ubuntu 20.04.2 LTS)
>  + Kernel(5.13.0-gb1d634be9673-fdoagd5f)
>
>
> === Patch Summary ===
>    linux: (git@gitlab.freedesktop.org:agd5f) origin/amd-staging-drm-next @ 2f56b0d631eb
>     + 0ede8d563c58 amdgpu/pm: Replace vega10 usage of sprintf with sysfs_emit
>     + 1d666a0652a1 amdgpu/pm: Replace vega12,20 usage of sprintf with sysfs_emit
>     + 8bad9ffba08b amdgpu/pm: Replace hwmgr smu usage of sprintf with sysfs_emit
>     + 773733df2f32 amdgpu/pm: Replace amdgpu_pm usage of sprintf with sysfs_emit
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
> pp_features
> pp_power_profile_mode "
>
> for f in $FILES
> do
>   echo === $f === >> $LOGFILE
>   cat $HWMON_DIR/device/$f >> $LOGFILE
> done
> cat $LOGFILE
>
> Darren Powell (4):
>   amdgpu/pm: Replace vega10 usage of sprintf with sysfs_emit
>   amdgpu/pm: Replace vega12,20 usage of sprintf with sysfs_emit
>   amdgpu/pm: Replace hwmgr smu usage of sprintf with sysfs_emit
>   amdgpu/pm: Replace amdgpu_pm usage of sprintf with sysfs_emit

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 16 ++--
>  .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  | 22 +++---
>  .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 38 +++++-----
>  .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   |  7 +-
>  .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 38 +++++-----
>  .../drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c | 14 ++--
>  .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c | 74 +++++++++----------
>  7 files changed, 105 insertions(+), 104 deletions(-)
>
>
> base-commit: 2f56b0d631eba0e76cfc789d85cc5632256ad42d
> --
> 2.32.0
>

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4EB9C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Feb 2022 04:11:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B88710EAB8;
	Thu, 24 Feb 2022 04:11:40 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B93310EAB8
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Feb 2022 04:11:39 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id p15so1285555oip.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Feb 2022 20:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sxClpnnkWjvHwzBl7+27U8CfESDp5e8nPhLTn3fbNxE=;
 b=Vn643qOLqtdJZhDLNaUApIA7Ea7M1nWW6pyEr9yw5FJdFkZx2tE5SxVdIkjD4iGJ0p
 OlmrDpP9XTGqcFBgPU3XWRuczPq0I50NC04EHsAcYDiXocPEs8NR5LkVf4Fjb+MOXD5F
 /643tCrgUpEZOLpS6Ps6s4QR2jfnmwvDLKywXLkdsRuaFej1jPyrHwrETYnPNfTb6IMb
 GthI507+qlnnrXR5gsrkb+9Tw+1DjHNS/iZ0/L8RE8Zzk3tIkHBQ6defhLJDM/G9RJ1F
 Vcv0QU00oiVEwJqmpieR2Mkxfw31fvKb4UyY0OA7ITi44fivDO56NCsfmYKqS9c2XhFP
 GQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sxClpnnkWjvHwzBl7+27U8CfESDp5e8nPhLTn3fbNxE=;
 b=x6nqdceRpOj6g+0S6jqhUCCdzdZefpW3kYaja/1Q+P3kWUVkYXLF/s2QJGlnrpeyj7
 jys8SBhXQMgXnhYuhHfzGJwsbex72/PKJ1ZUlz88XzK6ny8m6wtACpJB5BwbeZUKXSwj
 N26auDbsH9h7ZR+wwHJO2RrzNDQ1DozPjsunbHOY5mJDfEAqtPI5HYNMKPFG4nqrr2S4
 eQbMOA/GYt8PDNyrh4bXqmPlYRjSWU3ZsZJNHcHQPcmE7q7vAQB5sRHj6uxfcBatFGo5
 Bv43X113Hr03ufWopbL13pAkF89onBGRoKjEAzcjqbG7B3JbPVLa89/HCIrYx8V28tXZ
 WTrA==
X-Gm-Message-State: AOAM532AFJ1ckvuwBWWeljUu5YsQd/XZ+7EyJgaw1U2Meu0XgDyMyomm
 Dx8RSQcXO4XTuPJWQzWxQHMIa9eRb4pAMKArlAQ=
X-Google-Smtp-Source: ABdhPJx+BRpll+P+XyFwHjk8dLD06zmEQ0xDthYAQJS4gzr0mvyTEXtuFztMFF6qQdzyi3ZLEc/8ysSHasvhLXy/lls=
X-Received: by 2002:aca:ab4c:0:b0:2d4:7c7d:606e with SMTP id
 u73-20020acaab4c000000b002d47c7d606emr412670oie.132.1645675898396; Wed, 23
 Feb 2022 20:11:38 -0800 (PST)
MIME-Version: 1.0
References: <20220126045441.3891-1-darren.powell@amd.com>
In-Reply-To: <20220126045441.3891-1-darren.powell@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 23 Feb 2022 23:11:27 -0500
Message-ID: <CADnq5_M-4qAc94zdNnJacCWdobeXfub7tga9+Zi4MkL2H2=+KA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] amdgpu/pm: Implement parallel sysfs_emit solution
 for navi10
To: Darren Powell <darren.powell@amd.com>
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

On Tue, Jan 25, 2022 at 11:55 PM Darren Powell <darren.powell@amd.com> wrote:
>
> == Description ==
> Scnprintf use within the kernel is not recommended, but simple sysfs_emit replacement has
> not been successful due to the page alignment requirement of the function. This patch
> set implements a new api "emit_clock_levels" to facilitate passing both the base and
> offset to the device rather than just the write pointer.
> This patch is only implemented for navi10 for some clocks to seek comment on the
> implementation before extending the implementation to other clock values and devices.

Were you planning to extend this to other asics?

Alex

>
> Needs to be verified on a platform that supports the overclocking
>
>    (v3)
>      Rewrote patchset to order patches as (API, hw impl, usecase)
>    (v2)
>       Update to apply on commit 801771de03
>       adjust printing of empty carriage return only if size == 0
>       change return from amdgpu_dpm_emit_clock_levels if emit_clock_levels not found
>
> == Patch Summary ==
>    linux: (git@gitlab.freedesktop.org:agd5f) origin/amd-staging-drm-next @ 28907fd9e048
>     + f3c1d971ea17 amdgpu/pm: Implement new API function "emit" that accepts buffer base and write offset
>     + c67ac3384682 amdgpu/pm: Implemention of emit_clk_levels for navi10 that accepts buffer base and write offset
>     + 734cca28fed3 amdgpu/pm: Linked emit_clock_levels to use cases amdgpu_get_pp_{dpm_clock,od_clk_voltage}
>
> == System Summary ==
>  * DESKTOP(AMD FX-8350 + NAVI10(731F/ca), BIOS: F2)
>   + ISO(Ubuntu 20.04.3 LTS)
>   + Kernel(5.13.0-fdoagd5f-20220112-g28907fd9e0)
>
> == Test ==
> LOGFILE=pp_clk.test.log
> AMDGPU_PCI_ADDR=`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
> AMDGPU_HWMON=`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | awk '{print $9}'`
> HWMON_DIR=/sys/class/hwmon/${AMDGPU_HWMON}
>
> lspci -nn | grep "VGA\|Display"  > $LOGFILE
> FILES="pp_od_clk_voltage
> pp_dpm_sclk
> pp_dpm_mclk
> pp_dpm_pcie
> pp_dpm_socclk
> pp_dpm_fclk
> pp_dpm_dcefclk
> pp_dpm_vclk
> pp_dpm_dclk "
>
> for f in $FILES
> do
>   echo === $f === >> $LOGFILE
>   cat $HWMON_DIR/device/$f >> $LOGFILE
> done
> cat $LOGFILE
>
> Darren Powell (3):
>   amdgpu/pm: Implement new API function "emit" that accepts buffer base
>     and write offset
>   amdgpu/pm: Implemention of emit_clk_levels for navi10 that accepts
>     buffer base and write offset
>   amdgpu/pm: Linked emit_clock_levels to use cases
>     amdgpu_get_pp_{dpm_clock,od_clk_voltage}
>
>  .../gpu/drm/amd/include/kgd_pp_interface.h    |   1 +
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  21 ++
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  49 +++--
>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |   4 +
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  42 +++-
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  14 ++
>  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 188 ++++++++++++++++++
>  7 files changed, 300 insertions(+), 19 deletions(-)
>
>
> base-commit: 28907fd9e04859fab86a143271d29ff0ff043154
> --
> 2.34.1
>

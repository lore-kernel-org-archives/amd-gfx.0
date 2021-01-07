Return-Path: <SRS0=Ke3f=GK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E305FC433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jan 2021 22:15:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83303235FF
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jan 2021 22:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83303235FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F5F96E54C;
	Thu,  7 Jan 2021 22:15:49 +0000 (UTC)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA81B6E54C
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jan 2021 22:15:47 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id 15so9154691oix.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Jan 2021 14:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5SPb7meZfCBz0faF2qgF96HTDq2Uo7ytDGnqj5F4ER4=;
 b=dTD9YtuPBVXDthTJU8f/5mSo+0hHWdnAfn62hiku06vcEt20KhbwLQG+tOvfAa4/O1
 to6wfB3SiLes/Jm91qGH+vg878aRxyUIhT7/XShZcSRsLB31yZOAi7tdfyz/G+1bIYC1
 MOAd5j5FOUIrl4y7LH+h7rkGj0OPa2M7hw7Y2pkY+IaNpjnMHGUQX+vBu6cDjW+QdyC+
 ysgrhdddmFGkUdeyGhZJAyOEvZNNEgekbLGStE5q23vT1AE24YG3Bye+N3O7p8evd0LQ
 uEvRc2NapvWm7DbFNL+c71CWj014cntQLeB3cGiBz+wCLER3gISe8b+dqonSiUGL2StO
 +jKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5SPb7meZfCBz0faF2qgF96HTDq2Uo7ytDGnqj5F4ER4=;
 b=nvAOVNiOwUb71RbSJBocX8Atj9cYHgTlwRzCTjNwWkCx9IAyzs0NpQT7h1lzPK3d9b
 CLHimlrMZc+y5bs6bbUw7myiupYUaZbUKZzPyJW6dfoqT5bIRbk8zUb+/i9UPPwFGo7+
 /w/wLLosZxiQ5RxYI1J/TrhB2qLgFLW9MweXnVPq9PPECwg3eiJI3XPhUs361/iPz9xn
 aKDPNtauhUcLMbP+wS2ButRaK+aCNuKOlQpbZnoJ8sDAE0k8R+m8u64l7XiY6sYaxm5w
 DAP7BCfHX/FG2HW8/WPb9tNW2QGu0zBstG7maszm6zSHGNzJSOrg+OR3TtssutmADhL8
 ZNHg==
X-Gm-Message-State: AOAM531uIsDLs+hv6Uq9MkCPlTGyAQqxkpDuTKI6ImDqdEnFlz8R+0DV
 8FNZtyt6F1Glpns9EFaSSDFIZ7+we8YQD+jR+uwFd/7P
X-Google-Smtp-Source: ABdhPJx6tXzJ9mgrZQLsNBwuSLst+BB7R2nsl9pruBO0pen+V2Sy+U/eU2b+iU5+i/7XAoBNwrUrxTfabnQyDKMLfq4=
X-Received: by 2002:a54:4083:: with SMTP id i3mr480671oii.120.1610057746872;
 Thu, 07 Jan 2021 14:15:46 -0800 (PST)
MIME-Version: 1.0
References: <20210107212336.170054-1-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20210107212336.170054-1-Rodrigo.Siqueira@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 7 Jan 2021 17:15:35 -0500
Message-ID: <CADnq5_O_7RC3CxoVhUqy7uXg5cvL4cd17OnvEptyCu55pH1UiQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amd/display: Fixed Intermittent blue screen
 on OLED panel"
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
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
Cc: Naveed Ashfaq <Naveed.Ashfaq@amd.com>, Roman Li <roman.li@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Hersen Wu <hersenxs.wu@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jan 7, 2021 at 4:23 PM Rodrigo Siqueira
<Rodrigo.Siqueira@amd.com> wrote:
>
> The patch
>
> commit a861736dae64 ("drm/amd/display: Fixed Intermittent blue screen on OLED panel")
>
> causes power regression for many users. It seems that this change causes
> the MCLK to get forced high; this creates a regression for many users
> since their devices were not able to drop to a low state after this
> change. For this reason, this reverts commit
> a861736dae644a0d7abbca0c638ae6aad28feeb8.
>
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1407
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Naveed Ashfaq <Naveed.Ashfaq@amd.com>
> Cc: Hersen Wu <hersenxs.wu@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../amd/display/dc/dml/dcn20/display_mode_vba_20v2.c  | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
> index 860e72a51534..80170f9721ce 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
> @@ -2635,14 +2635,15 @@ static void dml20v2_DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndP
>         }
>
>         if (mode_lib->vba.DRAMClockChangeSupportsVActive &&
> -                       mode_lib->vba.MinActiveDRAMClockChangeMargin > 60 &&
> -                       mode_lib->vba.PrefetchMode[mode_lib->vba.VoltageLevel][mode_lib->vba.maxMpcComb] == 0) {
> +                       mode_lib->vba.MinActiveDRAMClockChangeMargin > 60) {
>                 mode_lib->vba.DRAMClockChangeWatermark += 25;
>
>                 for (k = 0; k < mode_lib->vba.NumberOfActivePlanes; ++k) {
> -                       if (mode_lib->vba.DRAMClockChangeWatermark >
> -                       dml_max(mode_lib->vba.StutterEnterPlusExitWatermark, mode_lib->vba.UrgentWatermark))
> -                               mode_lib->vba.MinTTUVBlank[k] += 25;
> +                       if (mode_lib->vba.PrefetchMode[mode_lib->vba.VoltageLevel][mode_lib->vba.maxMpcComb] == 0) {
> +                               if (mode_lib->vba.DRAMClockChangeWatermark >
> +                               dml_max(mode_lib->vba.StutterEnterPlusExitWatermark, mode_lib->vba.UrgentWatermark))
> +                                       mode_lib->vba.MinTTUVBlank[k] += 25;
> +                       }
>                 }
>
>                 mode_lib->vba.DRAMClockChangeSupport[0][0] = dm_dram_clock_change_vactive;
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

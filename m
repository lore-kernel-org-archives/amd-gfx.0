Return-Path: <SRS0=u850=HL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EF0C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Feb 2021 19:41:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 664F364DAD
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Feb 2021 19:41:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 664F364DAD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAF4E6EBA0;
	Tue,  9 Feb 2021 19:41:18 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72D886E0C5;
 Tue,  9 Feb 2021 19:41:17 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id i3so9818176oif.1;
 Tue, 09 Feb 2021 11:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DXoXX9t+fJ8x0y0o3oj+Ni+Q4UjyYGDDZmio3Vrqotk=;
 b=gC4VvFIYtHmzre1Gnuqb+O2KVzUhmSdr96r/12PS0RHwTh3y/Cl65SGWUwymg1dfSc
 0RILw3MlzO7nC82fJMVvzCTTaq4xATaZgPq81u1azvY6Ko0DD/2G6m4ncjBofq29X/at
 GzJBaxR7qdEJpGe1jG1hjZTbvAYG0DIhOfEnkjFDXhKlCendp9nSIglkzk2tMN1kKAlx
 o6Abxl6lLWSTwtigKbR8ZCdioVXVhLz8hxT/LAmyk6dt3qQnmgFuZwXRYJFfEM74aKxM
 tUilAcY3BPqv4h8a+Ok9O4w+RK6iewPK0epvVgRlgSCSkSwV5XmO59Ud0z5ZS8CJWh05
 tUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DXoXX9t+fJ8x0y0o3oj+Ni+Q4UjyYGDDZmio3Vrqotk=;
 b=MJpfRl5VWeCuOaobPwFQrxzU+5t6YKx/Px8lP0s/7qAyfJXQe/KaP/78dyMpbLYGed
 GpnO5uToLiWuPFBvh+NqSKGx+falxkEyTTVQmnPQCMmPTdRz9WcIhuQ+ReLAnkvkTRam
 e7yNYcWH61DTdJNFo4ZZXs/Kr5Syfcey2iYgGHMXpBvywPQAEEiRTpOmfjkw0SG80LEU
 PsJQ4Pcv3hf+Rk2xp0PQHXrMncgAvn5tofp1PjtDpoIEz36j85fJt75YWP2AvfcJJDS8
 0hScZUKbjp9Dhb6fGVEvI2QXtZFpW4Uc5BXGCMp3gN38RfdUD9sUELaOyBOpE+x9Xllw
 /Bzg==
X-Gm-Message-State: AOAM532lt94vja5312hu45uZUoeUNtILW76NI/X5xX4UFx3xeiZ0w/f4
 C3O0wnd9mYf8qjLp5icuGGp/TYUIyQU0+e2NZZ8=
X-Google-Smtp-Source: ABdhPJyi8YAv3Mr94sjJIKowedWyGeiZtBKiNpp2j7n3eofNp2+Ob1AqBzjl96BXSvyOAQ8g+Ay8MPEWa4Qc0NozfRM=
X-Received: by 2002:aca:c786:: with SMTP id x128mr3540978oif.120.1612899676846; 
 Tue, 09 Feb 2021 11:41:16 -0800 (PST)
MIME-Version: 1.0
References: <1612780168-83989-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1612780168-83989-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 9 Feb 2021 14:41:06 -0500
Message-ID: <CADnq5_PguFm7Qo2i1dqCAwLAWYhq68m-wdSx8B5LGUVmMbS3pw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Simplify bool comparison
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
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
Cc: "Leo \(Sunpeng\) Li" <sunpeng.li@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Dave Airlie <airlied@linux.ie>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <alexander.deucher@amd.com>, "Wentland,
 Harry" <harry.wentland@amd.com>, Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Mon, Feb 8, 2021 at 5:29 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Fix the following coccicheck warning:
>
> ./drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h:319:11-23:
> WARNING: Comparison to bool.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
> index ffd3769..316301f 100644
> --- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
> +++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
> @@ -309,9 +309,9 @@ static inline bool should_set_clock(bool safe_to_lower, int calc_clk, int cur_cl
>  static inline bool should_update_pstate_support(bool safe_to_lower, bool calc_support, bool cur_support)
>  {
>         if (cur_support != calc_support) {
> -               if (calc_support == true && safe_to_lower)
> +               if (calc_support && safe_to_lower)
>                         return true;
> -               else if (calc_support == false && !safe_to_lower)
> +               else if (!calc_support && !safe_to_lower)
>                         return true;
>         }
>
> --
> 1.8.3.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A43B8C25B0F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Aug 2022 16:36:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C93595894;
	Fri, 12 Aug 2022 16:36:02 +0000 (UTC)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65A9495735
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Aug 2022 16:35:56 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-10dc1b16c12so1490666fac.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Aug 2022 09:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=TmmaVF67TdSxwg3EoC+X0VsFUossmYFWWdOWK7R7Hyg=;
 b=ONHXcvEeNjXKT8h4SuGlrKEX0jYwB0uyeE+gZ6NCsS0n5SsNZB16SFGbrHik/sQtcp
 rY7YXsYVtuJlJtrxZdsd3nFbPIWmOjxVElidm8xg5+07qgl2IoI93VoDIwfoTqu2bFRx
 E1X4YRnMq3iPy/pA+F4LITuenH1PzWAQB2um4xM1uJnBgzl9Os3sKTaJP0a25RLk29g3
 X7XvsF3YCUuBO3mjpeg6PI6Wmxqxrp/CPvH3lAJ85QpfdaemPQXbTwNGUalJpWgVdjV/
 qnCn8LQWdIoqdxAHSMqq9AEnv2VYtpshFpDO1pQSaXE4y/VqhvOzSM0PtCqMbNuuZIoH
 yHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=TmmaVF67TdSxwg3EoC+X0VsFUossmYFWWdOWK7R7Hyg=;
 b=VvtwGfvOqamFIig/tPkDn6uxBYzQ1FEED8/kALPSomRE1CfC/5iky+dvBKNOZEb4b5
 mhnK85MZ0yymOrU/99JRmKPKUY/JXIuUyZWIOxU4AfldWG6NmlMV7+W/I1GpDRYK3sFR
 LtyzdzKKWM+Clt4aM308AdZmmuoXUPlCz0QvTowiQlGu0/8Y0BSQ0wN3nu0aJ3vIjjEh
 OiKfne25Ku7Kqipss/ntAQ7jey3ueTGbU7IzSsNPNZgRzsNWZWXcaizrtPBwBZt0U/3e
 lqMr22eSspXcZcQEadYv85VmTDtuMjaDWU2LHAf22qaxDgd1kvdGi2xVebr12xTnY6kF
 WFnA==
X-Gm-Message-State: ACgBeo3JtzRlftp9QxjmCQHpPqVbcvsJatLRz0qnKiWN9pt6WPTilBhi
 wAaItMJXTT3AMHMnmcElKdaCI2yiMWVYEaLAT9c=
X-Google-Smtp-Source: AA6agR5Uzr2AviGK2Ps3utUgoD21nHLYitg/Yy+fRrAypLElJ6dyez7D1tM6Dc6kga9iHYZYZfElNvU/yq8o3+LLC0E=
X-Received: by 2002:a05:6870:3398:b0:113:7f43:d0e9 with SMTP id
 w24-20020a056870339800b001137f43d0e9mr2030756oae.33.1660322155360; Fri, 12
 Aug 2022 09:35:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220812101953.3884354-1-tim.huang@amd.com>
In-Reply-To: <20220812101953.3884354-1-tim.huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 12 Aug 2022 12:35:44 -0400
Message-ID: <CADnq5_Pmi5PCpgdHDhXBY-fcUaKiP7G82-cJw6NZNhRTJH-Lbw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: enable IH Clock Gating for OSS IP v6.0.1
To: Tim Huang <tim.huang@amd.com>
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, Xiaojian.Du@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Fri, Aug 12, 2022 at 6:20 AM Tim Huang <tim.huang@amd.com> wrote:
>
> Enable AMD_CG_SUPPORT_IH_CG support.
>
> Signed-off-by: Tim Huang <tim.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/soc21.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index 6c3440e7ed3f..1ff7fc7bb340 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -602,6 +602,7 @@ static int soc21_common_early_init(void *handle)
>                         AMD_CG_SUPPORT_HDP_LS |
>                         AMD_CG_SUPPORT_ATHUB_MGCG |
>                         AMD_CG_SUPPORT_ATHUB_LS |
> +                       AMD_CG_SUPPORT_IH_CG |
>                         AMD_CG_SUPPORT_VCN_MGCG |
>                         AMD_CG_SUPPORT_JPEG_MGCG;
>                 adev->pg_flags =
> --
> 2.25.1
>

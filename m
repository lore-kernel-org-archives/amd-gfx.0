Return-Path: <SRS0=kf8h=NB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1912C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Aug 2021 19:21:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 857DB60EBB
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Aug 2021 19:21:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 857DB60EBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BEC489EEB;
	Tue, 10 Aug 2021 19:21:10 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E7D689EEB
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Aug 2021 19:21:09 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id h11so734932oie.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Aug 2021 12:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=b+qTGSAokuMQiQFB8yHSJDPHQqzZ0d1zacoBp/f/ZSk=;
 b=Q9twc0I0pfGKcc5ktNXsyCp38/kEq8OsYhqc18tcG74r4UyThwpXyVSU30d7tWIfFi
 x8KZGjNGJp0/4xE+Q+zsEKJ/NlNj4hNps9Mey8Sw28w979z5/HZGw1t2+1ARfX6Bw169
 v1gAt900fjkHnumlMJJelduz9cZ9N69cNriWPnLKgTUjB1yQQugn3fegjIObjf78iSGu
 xe7/60sjfTdBxztaLOWM9VzfohQVaKzTURTzKC/HBxXlVEr4apw2Dy7bFexIWFV0O43U
 fPTMeeYsjNG262awJpSaMqBqcMJdDTzAdTnq/6MBOKN/ATT30MSBmZaDVLwKXnHApf7o
 VMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=b+qTGSAokuMQiQFB8yHSJDPHQqzZ0d1zacoBp/f/ZSk=;
 b=R0jXw78cyM3SWvEQCwnCMldiKIDJ+NzLN5nvITarSl0wmkTrVStX21XVpI0mR8xUs4
 3PrEwnXc08FkbB9NWAxHFHLBfuCYIr2ZYNujT8Y/JfPifQxiEwGbQihyEpoCSBZDOqcv
 2ih/DXBpbADIkK+f/YYthDooWVSeAx+bUTOeThW+LZVgioKFn++9cs3oLB2FUVsyvFjD
 TXbJLEg9xF3+0EkWUC/gaRX/aXWRhEoeroZfR+XrOoyxnB0Ip8er//gEnO8vc7B1X/XE
 FfgnWLCrG10eB1yj7HnMH371g/bEMmMNsWwANnCtepCUbtilTf5m1+8KiArH6ZabmBig
 TXpg==
X-Gm-Message-State: AOAM532DFYEKLTen/ALPpWeO5iu+uO4o9lZkzfL+/Y0wWl5984TEoTaB
 QkBSeJH7z92zjLqppRUjj3Ovef1umf9uN3OPzqA=
X-Google-Smtp-Source: ABdhPJwwbCcAarYlTlMKwJ9mihDEkHzF5eUyFrQk4kwdrKN4YPBMq+AZd0lqSDEeJbndGvX/CaqOFAy5TkIUUg6pCHQ=
X-Received: by 2002:a05:6808:6d2:: with SMTP id
 m18mr21374947oih.120.1628623268589; 
 Tue, 10 Aug 2021 12:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210810191528.23430-1-Ryan.Taylor@amd.com>
 <20210810191528.23430-2-Ryan.Taylor@amd.com>
In-Reply-To: <20210810191528.23430-2-Ryan.Taylor@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 10 Aug 2021 15:20:57 -0400
Message-ID: <CADnq5_NX+63_r=cVoUB1Ws982c0F8N6UCga5m+W47wkt2Xo=tg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/pm: graceful exit on restore fan mode failure
 (v2)
To: Ryan Taylor <Ryan.Taylor@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Lijo Lazar <lijo.lazar@amd.com>
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

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Tue, Aug 10, 2021 at 3:15 PM Ryan Taylor <Ryan.Taylor@amd.com> wrote:
>
> Attempt od settings restore and disable restore flag on restore fan mode
> failure.
>
> v2: Update fan mode to auto and fan speed to zero (Lijo)
>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Ryan Taylor <Ryan.Taylor@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index b4b4d615bcbc..00d594e6dd85 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -407,11 +407,12 @@ static void smu_restore_dpm_user_profile(struct smu_context *smu)
>             smu->user_dpm_profile.fan_mode == AMD_FAN_CTRL_NONE) {
>                 ret = smu_set_fan_control_mode(smu, smu->user_dpm_profile.fan_mode);
>                 if (ret) {
> +                       smu->user_dpm_profile.fan_speed_percent = 0;
> +                       smu->user_dpm_profile.fan_mode = AMD_FAN_CTRL_AUTO;
>                         dev_err(smu->adev->dev, "Failed to set manual fan control mode\n");
> -                       return;
>                 }
>
> -               if (!ret && smu->user_dpm_profile.fan_speed_percent) {
> +               if (smu->user_dpm_profile.fan_speed_percent) {
>                         ret = smu_set_fan_speed_percent(smu, smu->user_dpm_profile.fan_speed_percent);
>                         if (ret)
>                                 dev_err(smu->adev->dev, "Failed to set manual fan speed\n");
> --
> 2.32.0
>

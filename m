Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D791C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Feb 2022 14:28:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EF8010E2DC;
	Mon, 21 Feb 2022 14:28:07 +0000 (UTC)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0009E10E2DC
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 14:28:05 +0000 (UTC)
Received: by mail-oo1-xc2c.google.com with SMTP id
 d134-20020a4a528c000000b00319244f4b04so13374383oob.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 06:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=afpb65+hHpvRMmSi6jZiQFe9Vy9mr4LC8W/dILMEMuo=;
 b=hF0vhNJ/IOdt5bNCLrVERaGael2YV0Kf9ONxS5kH1K9ejjnKT4zj3EHQf/FjoA7vTQ
 tz2VZJZtXvkqqRYhgsFA18ssgLlXIXOU1WiHFKYVyDWFwP0khKBwxWoyR8MGog0CCHzp
 x7JwgFPLtLZLheLZyxwytCnBjCeKl1ymLMoo/1rshQZyoxkCDZ6/4tAznZZwoZMakDMg
 HBGGVbZQkjfsr17FEk7wsrMMFOtvYOROnx4oXt/19AT+2KGxKwPkbS22wP0vFUjmQmnB
 UClsaRcgmk6MbBJGRNAlXbALDI52fCrYYe/COWqGFryjGT9Ah+KdTacFDufavHaB8ECo
 SUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=afpb65+hHpvRMmSi6jZiQFe9Vy9mr4LC8W/dILMEMuo=;
 b=aRmbiEI6ZDgqB6b25hQCpsfDxpM+tqjcoL+zR9M0v/QD9s9TpRcF9DRRSgOgkdgM0X
 cmKntV5hcHICs8ziEZR9sH6qSBkg9/GOBDoyUgackC4u86FjKMBEYzx0DF6Ps5VUkNw4
 OUhyAWB2VC9CqbaZflOW7aZAFODiidBiE7uPEWudM9LL1T3+YKSXuuB3s4TkuNm/tehB
 m/Zsiq1GL1elAR9pARXhZCn0/NJ5ARgzUUVw4XggUCOMxq1eW1xS7WwRUSh+PwC3Kffz
 lHnRC7B5xKhHijRru1mcdDEV20rhjXIDS4WBu2Zj0QlO59b8yLA3V0X0e2/r2WEAoThO
 nPHA==
X-Gm-Message-State: AOAM531f1B2/2inFysWHhWgygGnklUfVfDMj17BQg6kGsMV2AbV5Tre3
 nXmklZupfJxMrVXsT7K046NXmhdLhXXXfVtPLSM=
X-Google-Smtp-Source: ABdhPJwkVrzj5IQ1qEPT8+4t3qTg8YZ/xiheHlLj38xeiXx4ZyPyzxxhdv+7J3Ko4vIhHN3+iXuojxS6qkU3+YWF8Fs=
X-Received: by 2002:a4a:db64:0:b0:2ea:37f4:d798 with SMTP id
 o4-20020a4adb64000000b002ea37f4d798mr6031682ood.23.1645453685216; Mon, 21 Feb
 2022 06:28:05 -0800 (PST)
MIME-Version: 1.0
References: <20220221101451.809067-1-yifan1.zhang@amd.com>
In-Reply-To: <20220221101451.809067-1-yifan1.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 21 Feb 2022 09:27:54 -0500
Message-ID: <CADnq5_N9cAnrcJLN57BA0q2_=Mcr4bDCynkmNyYWPMGpy7kieQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: add GTT domain support for dcn 3.1.5
To: Yifan Zhang <yifan1.zhang@amd.com>
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
Cc: "Leo \(Sunpeng\) Li" <sunpeng.li@amd.com>,
 "Tianci.Yin" <tianci.yin@amd.com>, "Wentland, Harry" <harry.wentland@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Feb 21, 2022 at 5:15 AM Yifan Zhang <yifan1.zhang@amd.com> wrote:
>
> From: "Tianci.Yin" <tianci.yin@amd.com>
>
> this patch adds GTT domain support for dcn 3.1.5
>
> Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index 9709368b4915..88ee1224541c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -523,6 +523,7 @@ uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
>                         case IP_VERSION(3, 0, 1):
>                         case IP_VERSION(3, 1, 2):
>                         case IP_VERSION(3, 1, 3):
> +                       case IP_VERSION(3, 1, 5):

Should also add 3.1.6 as well?

Alex


>                                 domain |= AMDGPU_GEM_DOMAIN_GTT;
>                                 break;
>                         default:
> --
> 2.25.1
>

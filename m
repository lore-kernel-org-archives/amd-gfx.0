Return-Path: <SRS0=u850=HL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AA7C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Feb 2021 19:33:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6BDF64DE8
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Feb 2021 19:33:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6BDF64DE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A0536EB70;
	Tue,  9 Feb 2021 19:33:17 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E35F96EB70;
 Tue,  9 Feb 2021 19:33:16 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id l19so8176796oih.6;
 Tue, 09 Feb 2021 11:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jGXU9qtn1siVrBxQIZDImfVV5UyVbc4/ofHvvxvja2c=;
 b=UIsaSjRFcAQ9HKCEV6qRRUwsY7RO08OFRFtYlE+PAJQmVKsPi6ap0+S8nfjInpgKRB
 QLy30S43W4y+c0yNhsg5f9OwZKB+up40QL96WiCNDC82F7r/I2orUpQKflCrSsj6Rxyh
 qvx0PyNYwNsdtU4AWWuboppBT3nI/bw1NaRNYUEuarBfuJJB/8XW9LSkSYVfL+Esx6BL
 sLCDgZgq1kQ/KWuTEK4WdwyX/ExoPAlpjTYxCVp4jnobtZgMP9I1dADa9hT4dDjsI1A2
 yfW1TiqUURm50owZcm4aSeBTnEf8LLuctnAiaLq79yEyr9fvdZCjsNprq+PtXbP7Wctm
 2Zmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jGXU9qtn1siVrBxQIZDImfVV5UyVbc4/ofHvvxvja2c=;
 b=VpahqG5pejaerZREJMmqlzDDMPcF7/GeRkX0Sao8p0OhEpW6BVr9nmrQu4USeK1T9Z
 77YfG76TEKum+DhDFXxGsOflR1JIH+12UUM/D62n+sVmDzaLD8ly38pLb73vBuXlZSUG
 JouFdMGfDR58eB5RJPdhYMA5Dqq15vdRIXT2NUzW/jJ2BW79SoWgY+y7rQCZ8RdB+QVu
 0quKqywwBl2TKAXRxj5kq3P137n0yxMGVn7fWCbdR8fFcI1XpLzwW2DL44Ipj84HP6zQ
 XwthLnhfn4YErGD/Mm8JEdN4loHTGH/B25RmNTmJAhV9nC9rzsOj4Njr1q5FLOSXaQSr
 Uquw==
X-Gm-Message-State: AOAM532pjOvjaYrBrGQatMiE/5SbgxIQDzN1P5Hvk9F4ZJV3uOAbtw2B
 pXSRP+kpURGbn41cls9OzXIOP3nqXQZCBEhx91M=
X-Google-Smtp-Source: ABdhPJzt5IRKR5kMKR3YXi1nNX3zwp1qG/SU+ozaKZAMs6oHyGZg1DdyK12JqKnzmLhFTwfB32fx+h+9wNgIbtTElm0=
X-Received: by 2002:aca:c786:: with SMTP id x128mr3523317oif.120.1612899196320; 
 Tue, 09 Feb 2021 11:33:16 -0800 (PST)
MIME-Version: 1.0
References: <1612859363-49070-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1612859363-49070-1-git-send-email-tiantao6@hisilicon.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 9 Feb 2021 14:33:05 -0500
Message-ID: <CADnq5_NBv6mJPFJ-hqDtyOtn3-L-X8qJ6sEM6=8U7i5C=s6=uw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix unnecessary NULL check warnings
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
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Feb 9, 2021 at 3:44 AM Tian Tao <tiantao6@hisilicon.com> wrote:
>
> Remove NULL checks before vfree() to fix these warnings:
> drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c:102:2-8: WARNING: NULL
> check before some freeing functions is not needed.
>
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

Applied.  Thanks!

Alex


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 594a010..3e240b9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -98,8 +98,7 @@ static int amdgpu_cs_bo_handles_chunk(struct amdgpu_cs_parser *p,
>         return 0;
>
>  error_free:
> -       if (info)
> -               kvfree(info);
> +       kvfree(info);
>
>         return r;
>  }
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

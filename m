Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03DF5C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Apr 2022 16:15:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90D1C10E23E;
	Fri, 15 Apr 2022 16:15:52 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D598610E23E
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Apr 2022 16:15:51 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-de3ca1efbaso8438975fac.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Apr 2022 09:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iJ+l4UxjQwSdbc6ENuz5STykr/+y1jaeCGSz1ArOv6s=;
 b=gxBb6MH1UtxNdKZJmNZ2shPCby2afMCqGRf3sM6WkGAWI10bTE17oFk3xu4A6bvi86
 O8bXlvluu7yw8m8+UCMrREMuc0NcISieIshIi5pfBjBuRrZhfa7JzmYsQvBkKuHXEo41
 ybMczVa2DnF8J/jn6ZIgi6ekF0/h3tU3ZLO2L76nO//EeZZ7E66YB9Wj3SC6sUCfTVg9
 lKawo20CS4fWYlXuR1msBlWBTWIW5ctwx0kzXLV39Fyj4xk11Rk6Kn6EWI7fQIC3da6t
 /9UmQOSY52PWzyVxQ9UE1++8S9HX4lfl3wWIUpgehMvtgBke4MFquAsyIWib9+8bvT6U
 TugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iJ+l4UxjQwSdbc6ENuz5STykr/+y1jaeCGSz1ArOv6s=;
 b=UbmcEQqd6eW9ilS4rciGRg9xMA/a2n1pIpzQV26+NdWywRJEyHu4nMONJoBUhGqkd5
 Nmr5YRRXKKiid1JdA2SrOqwiVkVLl7cL4zaf/8JgXPlJj4Vc3FLYsX2ZRSDz8iobQ2qc
 5sBfK1wYEx27f8JA090dO6ND9iUrCMILGVsrWju2cc5nkbEwCbLK1fw39xgGs9Q6LFsQ
 WEKd58qcCoMb/2LPVI5MoX2DIKsCe6aLzGR5lQckorEp4+CB4UAYT8NpHg4bd5z7T/J2
 Yr9MgF1BgX5d0CRibdI+GpchoUb9a6fAaTvKr+HzNLQvvcU/RnQKrFbRMnDehzrgCV1/
 9ViA==
X-Gm-Message-State: AOAM533OT4owv/0kiUIccuUI4EFfo/c5l4Q4UdyWQhG8uAnTUDtfxziF
 /bnANFejVFgEwzRXkq40jdQxJRhr9Gt9EOsSvzLid3pGn1E=
X-Google-Smtp-Source: ABdhPJxCMbR2r4/J5vdaDPJiYEaIvCqcUi/bA1AXRUVXawcxxYp9w4NiGLLz8jCgdqYvG/qau/65I3RwgLmWKKkJEWE=
X-Received: by 2002:a05:6870:311d:b0:de:9b6c:362b with SMTP id
 v29-20020a056870311d00b000de9b6c362bmr1594398oaa.200.1650039351071; Fri, 15
 Apr 2022 09:15:51 -0700 (PDT)
MIME-Version: 1.0
References: <5eef642a-d7d2-9f59-7f63-b6e89c52bdba@blazebox.homeip.net>
In-Reply-To: <5eef642a-d7d2-9f59-7f63-b6e89c52bdba@blazebox.homeip.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 15 Apr 2022 12:15:40 -0400
Message-ID: <CADnq5_NOc4Q=3ZO8MUxGFyNfFU7mgrHFwEd+5O+9zQoYYUmepw@mail.gmail.com>
Subject: Re: Unable to boot 5.18-rc kernel on amdgpu legacy (si) hardware.
To: Paul Blazejowski <paulb@blazebox.homeip.net>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Apr 15, 2022 at 12:00 PM Paul Blazejowski
<paulb@blazebox.homeip.net> wrote:
>
> Hello,
>
> I am unable to boot 5.18-rc1(2) kernel with my rather old (si) XFX card,
> which works fine under 5.17.3 and previous kernels.
>
> The card is identified as:
>
> 1:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI]
> Cape Verde PRO [Radeon HD 7750/8740 / R7 250E]
>
> Running on a Asus M5A99FX PRO R2.0 mainboard.
>
> The boot process stops at "fb0: EFI VGA frame buffer device" step and
> the hdmi connected monitor just shuts off, there's not oops or any other
> debug output captured by serial console.
>
> I was able to bisect the kernel tracing this to a bad commit:
>
> git bisect bad 3712e7a494596b26861f4dc9b81676d1d0272eaf
> # first bad commit: [3712e7a494596b26861f4dc9b81676d1d0272eaf]
> drm/amd/pm: unified lock protections in amdgpu_dpm.c
>
> And reverting this commit on 5.18-rc2 kernel makes my system bootable again.
>
> Please let me know if there's anything else i could provide to help fix
> this issue. I have access to serial console if needed.

Fixed with this patch:
https://patchwork.freedesktop.org/patch/481477/

Alex

>
> Thank you.

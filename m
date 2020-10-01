Return-Path: <SRS0=OkES=DI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1FBC4727E
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2020 20:48:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20DFC20738
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2020 20:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJn2+F5+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20DFC20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E3FA6E06D;
	Thu,  1 Oct 2020 20:48:08 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4CAF6E06D
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Oct 2020 20:48:07 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id m6so238601wrn.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 01 Oct 2020 13:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pWKX1vkQAtu4hoexOnxMFtWuUI/DIu3/+WqsN0eWvnQ=;
 b=LJn2+F5+GJuD9zKdAHEHlPEhk3Cp3zDiNcNUDjd6bL6VYj8JNE7Hgp8PAS7KBTmY1v
 LRWOFSRRtETaRV5isjhLjvnPQLu2zXH7lP860CiFgQf5dWXRmjpQB+stSi+0X6bZ5xUc
 p0xnUc9D5BILOelNLFogLx38FsNoF8EuMZ09n/Xt1cx8ncG4yF8JOHqol5ZUEPsN1uBH
 kGOq+X8a/NAAsx+GdRfr2ZT6zhxUHDl0hZrJABWa3EJsEjUG4n7dASv9NVFTKvNiGoEM
 hC7jfJqMHIRoQpnwmW9Uut+lRAONkOHlFRemhnY5icsOJ7TEhYW1sDrSltcdMHYU75e6
 W3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pWKX1vkQAtu4hoexOnxMFtWuUI/DIu3/+WqsN0eWvnQ=;
 b=YlM1uP88lJ0YeYQbTAaquAt27XLuhfpRc3DGJN/Vx+tqtNdZDdQxJVxNYwQiNjf94/
 kWa/PN1s/xwIjiLQoXmJH+GEyt71sZkqhsvl1Li5CVDO8Up2FdrEu/PKD+kFuouQld7f
 ZUoRMkePiQCKvGom4WVu0Oq8wq/xddw9LHFvEKz/eznEMoZlvBkxneC97SjyuUorYNPj
 QC+mo/AQqGb218lcJk2PvdmA0W/dY85l/nzsyHayqdmn4z7691khTK0NvM+AIiJXRzWy
 9Bz7P5PbJJNAjKzXMbokn3bMEn96WCugmvgoQ9LCxeD98AUP0a3nesSMLEegtpy1Z2mW
 YbsA==
X-Gm-Message-State: AOAM5331bUgSPkqClZA+yDr40GHiHGR9fpy9NRh+seBSt972GQVwb4Wi
 4O/XMAjgq4cuifQwKi1zVXOZJk62HGClQFz65/U=
X-Google-Smtp-Source: ABdhPJwHa+MjqUMnY7p1Buv4fdAEdX6XVRxeBeIp0Rbkxs7rFc4ShHlAQfw4PTaCZhqwJMIOMk4pGvqnetBXi1TXfEk=
X-Received: by 2002:adf:dd82:: with SMTP id x2mr11634856wrl.419.1601585286333; 
 Thu, 01 Oct 2020 13:48:06 -0700 (PDT)
MIME-Version: 1.0
References: <CADnq5_OOL3UZXKXEKU8VzkZAkOnk9HM8m=nEwywoQPm4GXs0rw@mail.gmail.com>
 <20201001195525.3477-2-dirk@gouders.net> <ghh7rdy9hg.fsf@gouders.net>
In-Reply-To: <ghh7rdy9hg.fsf@gouders.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 1 Oct 2020 16:47:55 -0400
Message-ID: <CADnq5_OUYWCceZm=sNpFZ7cquyxmz5GO5JPznyFhZDSu+pjj=Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/amdgpu: fix NULL pointer dereference for Renoir
To: Dirk Gouders <dirk@gouders.net>
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
Cc: LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Oct 1, 2020 at 4:33 PM Dirk Gouders <dirk@gouders.net> wrote:
>
> Dirk Gouders <dirk@gouders.net> writes:
>
> > Commit c1cf79ca5ced46 (drm/amdgpu: use IP discovery table for renoir)
> > introduced a NULL pointer dereference when booting with
> > amdgpu.discovery=0, because it removed the call of vega10_reg_base_init()
> > for that case.
> >
> > Fix this by calling that funcion if amdgpu_discovery == 0 in addition to
> > the case that amdgpu_discovery_reg_base_init() failed.
> >
> > Fixes: c1cf79ca5ced46 (drm/amdgpu: use IP discovery table for renoir)
> > Signed-off-by: Dirk Gouders <dirk@gouders.net>
> > Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> > Cc: Evan Quan <evan.quan@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/soc15.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> > index 84d811b6e48b..f8cb62b326d6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> > @@ -694,12 +694,12 @@ static void soc15_reg_base_init(struct amdgpu_device *adev)
> >                * it doesn't support SRIOV. */
> >               if (amdgpu_discovery) {
> >                       r = amdgpu_discovery_reg_base_init(adev);
> > -                     if (r) {
> > -                             DRM_WARN("failed to init reg base from ip discovery table, "
> > -                                      "fallback to legacy init method\n");
> > -                             vega10_reg_base_init(adev);
> > -                     }
> > +                     if (r == 0)
> > +                       break;
>
> Grrr, wrong indentation here.
> But I will wait for your review before v1.

Fixed up locally and applied.  Thanks!

Alex


>
> Dirk
>
>
> > +                     DRM_WARN("failed to init reg base from ip discovery table, "
> > +                              "fallback to legacy init method\n");
> >               }
> > +             vega10_reg_base_init(adev);
> >               break;
> >       case CHIP_VEGA20:
> >               vega20_reg_base_init(adev);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

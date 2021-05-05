Return-Path: <SRS0=nRto=KA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95951C433ED
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 18:20:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 081A4613B4
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 18:20:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 081A4613B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 876B86E4F8;
	Wed,  5 May 2021 18:20:51 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B43B6E4F8
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 May 2021 18:20:50 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id z3so1817865oib.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 May 2021 11:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OlFNydRU9v6OwaMOkWqf/K4Q8AgZUQvckH+cLs7pqRI=;
 b=RSwKIV57krrNfzD9gXZGZCgZjy5RV3t8xID629rKkjQ3WmErcwWabwgHpdJ9WowKKs
 HaG7GYxvlrSGclQDIexkCCgx2hMhRToSGJG600+qyjG2LW0IdHvaRA0MQbSa90Mh8a3p
 V9CkSkO107OtcHNdJA6NrVMnJViqrt5S7LmxKa/QUInTAmM1Jx0e4W5ECyPrie5p12pz
 9t8Ze6w6SqZ5RqsxElLm+/kmd/eKGoFzUpBnSGjsIxtgSWTqKjCbIyg1YTnNRlF0liKo
 QIgqJkU/7FeN9+7om3/+omOnbdM4UAcrRSQJujw+c+BxEvUswZaD21ik98q89sQ0w5Ee
 mbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OlFNydRU9v6OwaMOkWqf/K4Q8AgZUQvckH+cLs7pqRI=;
 b=WNMtg+a4Ri2bloHOqyzj4zUFCpuUo2MWmBMSoMgQawopFNb5BrLpxwLP6dHXVm5Svd
 T55Ew1Pr683MXu3fCowiRetZSWmW/1ci/XL6eQJDDMTxxFImwHVacnGhh0UoP554binw
 dC/NJafTnwKgfP3vfFLvzn+cK+34YVPl6AhVw09xBxClLDDo8oafvMt9g4/HZ39i+YOF
 avAwr/FwdMJYp4Gy41cfDc7G9zRejfdNCGWwauj67h6o3GKiXqcgPFD3MomYjHe+LKEp
 aAUnPZGvNRdpGaipoc/8qXBPWKwV0tbHiXB4e+lP8g3ix3rx7Sd9mq6HO/ocmQfyM5nI
 jZ8w==
X-Gm-Message-State: AOAM531eJ0qDy07EGGYxCpvG1FRSd2faZmEreWsTSjHFPH0iHwZZomiu
 RJ/M9ggqw3Sb03mM91j19SPOorV/Il0H9OOtoIM=
X-Google-Smtp-Source: ABdhPJxfQbTTMB0opP8miRRFxL5tKFzIYIfASUa1/U7xY5rQjuviP2lOaowAQJ36tYCB6hmdOYPdiV+XXiE5/r5p4hk=
X-Received: by 2002:a05:6808:68a:: with SMTP id
 k10mr181724oig.120.1620238849660; 
 Wed, 05 May 2021 11:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210504094334.1162856-1-bas@basnieuwenhuizen.nl>
 <J9MJA2kk2-TH5Ko6PeZ7Zy5M05IgxGfrLKkKLmpR2Wx2g82c2nO32aycv-Cr-VEKXmCyT-0W5WLcXqCDHRLZ4W8pS3gcY0qH_rfMuN2SoPA=@emersion.fr>
In-Reply-To: <J9MJA2kk2-TH5Ko6PeZ7Zy5M05IgxGfrLKkKLmpR2Wx2g82c2nO32aycv-Cr-VEKXmCyT-0W5WLcXqCDHRLZ4W8pS3gcY0qH_rfMuN2SoPA=@emersion.fr>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 5 May 2021 14:20:38 -0400
Message-ID: <CADnq5_OBeSCP_7NmyhZZn_-ycef2t2rA-XX-TC1rjg_vgJf5qA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Use device specific BO size & stride check.
To: Simon Ser <contact@emersion.fr>
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
Cc: Mark Yacoub <markyacoub@chromium.org>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Tue, May 4, 2021 at 11:30 AM Simon Ser <contact@emersion.fr> wrote:
>
> On Tuesday, May 4th, 2021 at 11:43 AM, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl> wrote:
>
> > The builtin size check isn't really the right thing for AMD
> > modifiers due to a couple of reasons:
> >
> > 1) In the format structs we don't do set any of the tilesize / blocks
> > etc. to avoid having format arrays per modifier/GPU
> > 2) The pitch on the main plane is pixel_pitch * bytes_per_pixel even
> > for tiled ...
> > 3) The pitch for the DCC planes is really the pixel pitch of the main
> > surface that would be covered by it ...
> >
> > Note that we only handle GFX9+ case but we do this after converting
> > the implicit modifier to an explicit modifier, so on GFX9+ all
> > framebuffers should be checked here.
>
> Thanks for the updated patch! It fixes the regressions I've got with
> my modifier-aware user-space compositors.
>
> Tested-by: Simon Ser <contact@emersion.fr>
>
> > There is a TODO about DCC alignment, but it isn't worse than before
> > and I'd need to dig a bunch into the specifics. Getting this out in
> > a reasonable timeframe to make sure it gets the appropriate testing
> > seemed more important.
> >
> > Finally as I've found that debugging addfb2 failures is a pita I was
> > generous adding explicit error messages to every failure case.
>
> Very good idea!
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

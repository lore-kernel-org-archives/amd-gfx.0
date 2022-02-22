Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7031BC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 14:17:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE48B10E88C;
	Tue, 22 Feb 2022 14:17:15 +0000 (UTC)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10F8210E88C
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 14:17:15 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 u17-20020a056830231100b005ad13358af9so9694848ote.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 06:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UReD8fP/NTVyqZTrLm4e9qOV+Qvrx9XTMycqziYpmm8=;
 b=ERQTRYhaKMlFW9fLhTcPB22IMNEoGOQPC/2gCEY9rN6RVTrOTJUTne5cVpMKjc4JK+
 PUgTs7E+qyg2+4vMNwo8Je1ZZlldxHU+u25d2a4q3zu5HYnQHfD/1hRUrmPgTgv/gRSD
 z/GRfaftfveYo/LV244Fge/0dyYjANYuS2wEG8Y+aDJyIwPf0qubdAnoaPNITXVftcBv
 1o2vUzbxQx81qdzWbRrW9etJQwzWWPoWmfuDv3r2D75ZzM2nNOBpC4LiiPMo7+lOQPrC
 cLBZFjGAYzuLk0f5l/jaSpX0DI2RFVMNEU0cJmbP4WfM5qLZBou3xucHaWLWmUs7/bqH
 HuSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UReD8fP/NTVyqZTrLm4e9qOV+Qvrx9XTMycqziYpmm8=;
 b=HQcfMD8IhyPUAMlytGMQWNuCebgQUG7xM7iF14bOTxvMGUfG9hkho6UkM1UPifL43Z
 yiJxYlUEFdnNBttTVTvwNczQ2yZVZ5trh3OHNc/l8/icEaf8nTVHb8X4STlx96oB4lP5
 odEc+zHRKWb1B7W93KKXfPDcCADs87Z4QZVPnRxzOoQVOpZLza1kt8qFS8JtkvnsKYgx
 0jKmNRlUBK+qmBIO3x8O6SJOKYkb+wp4Xho8jpJhuHdvmpWeyTMiyZk9bvJ0JTGBX/eC
 EvjjWPmVaxY6osqCzHnmbIsXhweed1h2cDudK4dkP6YxJRzdmBRB/YnjJ9M3FtKCXyyS
 9ZYg==
X-Gm-Message-State: AOAM530nIPYVw2dtxYqpS/pALf1u9P0mS4NOftIUfBNmMaoe/5huzt5o
 fwGXK5C11PqQNSZZ9S6FeU4BugI4uaq+Grpf4+E=
X-Google-Smtp-Source: ABdhPJwtOmmnvxTUdGAK1PPPfKgCJY8Ah1TumaJqn6yvCjnCR2cet+bc5yUQ4VMJYImtsK0W3ItN93a09EjpC1kE9tg=
X-Received: by 2002:a05:6830:573:b0:5ad:5207:41d6 with SMTP id
 f19-20020a056830057300b005ad520741d6mr5936940otc.357.1645539434015; Tue, 22
 Feb 2022 06:17:14 -0800 (PST)
MIME-Version: 1.0
References: <20220222060313.856546-1-yifan1.zhang@amd.com>
 <ecbaee85-b44a-85df-accc-fad4d3029b10@amd.com>
In-Reply-To: <ecbaee85-b44a-85df-accc-fad4d3029b10@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 22 Feb 2022 09:17:02 -0500
Message-ID: <CADnq5_PFKKW-=ghAPHoVDE5aPZ4kYM+_ZXKgDVZ=MTHV1ZjJNg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: add GTT domain support for dcn 3.1.5
 and 3.1.6
To: Harry Wentland <harry.wentland@amd.com>
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
Cc: Yifan Zhang <yifan1.zhang@amd.com>,
 "Leo \(Sunpeng\) Li" <sunpeng.li@amd.com>, "Tianci.Yin" <tianci.yin@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Prike Liang <prike.liang@amd.com>, "Deucher,
 Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

How about this series instead?
https://patchwork.freedesktop.org/series/100519/

Alex

On Tue, Feb 22, 2022 at 8:53 AM Harry Wentland <harry.wentland@amd.com> wrote:
>
> On 2022-02-22 01:03, Yifan Zhang wrote:
> > From: "Tianci.Yin" <tianci.yin@amd.com>
> >
> > this patch adds GTT domain support for dcn 3.1.5 and 3.1.6
> >
> > Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
> > Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
>
> Acked-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > index 9709368b4915..37f4da219a5f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > @@ -523,6 +523,8 @@ uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
> >                       case IP_VERSION(3, 0, 1):
> >                       case IP_VERSION(3, 1, 2):
> >                       case IP_VERSION(3, 1, 3):
> > +                     case IP_VERSION(3, 1, 5):
> > +                     case IP_VERSION(3, 1, 6):
> >                               domain |= AMDGPU_GEM_DOMAIN_GTT;
> >                               break;
> >                       default:
>

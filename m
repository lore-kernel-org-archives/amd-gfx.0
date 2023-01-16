Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C4D8C54EBE
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jan 2023 18:04:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E21010E481;
	Mon, 16 Jan 2023 18:04:40 +0000 (UTC)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52B4B10E483
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jan 2023 18:04:38 +0000 (UTC)
Received: by mail-oo1-xc2a.google.com with SMTP id
 c145-20020a4a4f97000000b004f505540a20so726599oob.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jan 2023 10:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ImKZvRmoZQgZlDC4GMXGYoOd91lOS/E1Hd6WgsQpT0M=;
 b=hfdf6V7QQeobbyqnMXn0Wh8gWNnYBNzSOX2Y+hi8in6+W/bPXmRaNZ9lWTbRMnIez4
 MqEnB0Y9k+3MAs2SatMbL+7tOvd6dpdnWnG3sr7yhoUS8GVPgbq5xAurRQDUPpvXDpbm
 9oH6sYYXyGuqKQchWagnzJfZLpkx8RKz8P6Sm74WBSSUJal49KqoefqoqOwKSGolkWHE
 V0fek7AGOCd5fedaA4//dZQLO6RvelUkRQwDofcRma8nlkerdx+yw4tU5PfZPVimyprR
 dkwrNMdsu+aWhYm+9bi1H/SwJiJ2GwB8P0zPwI3Qiw6HASvmzBZyP+9BoTs/UavHyct2
 f9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ImKZvRmoZQgZlDC4GMXGYoOd91lOS/E1Hd6WgsQpT0M=;
 b=ix96jRnnaLXOnBoMKALNCuripd++ID6RpllzF+tHMezwOLWWUUxRxt8vL9CJqsfBYK
 31nqR4sq+bgQ/jzoCMNSeTFY1TU//7EwylvdEaBqJDlfFZZKBN0qjEfIHnZ/9hDnWIq5
 y1EBWPRXh2NXkGBEJRR5Bp+InsKaWOKz4UBJne8JX/OGiPMy+AXk8XoM5rU7dQ4ysv6P
 azbAEIonShOdGYVgc/6ECDor6bzLSWS5/Mou2QPc0eMDP3KTYKPrIvWZsRVvCcmBep3w
 YhwudU35PWbxCxh42dTu6sYdkNJxMiFmGe+ezBx3RCFkJeupxd6PfVGNp45UqDRvY3Jp
 8IOQ==
X-Gm-Message-State: AFqh2kpUJS+/1h+QQvrXVZI/SM3nUqZoFqXWru/sGlzobu3XEVwnh48C
 4QESu0s3HhVfwcSL0MHlksF0hXw7JXvQtZ5GWt2qxRhB
X-Google-Smtp-Source: AMrXdXs+lOk+z3jL6SG4Q23uvxrEy3iiu35eTm7qhCY+rAsxRC5kWpO7WjAz9kLmGnG5EHnoO6zq6SDClr+nQ17UwT0=
X-Received: by 2002:a4a:e712:0:b0:4f5:2859:f146 with SMTP id
 y18-20020a4ae712000000b004f52859f146mr13995oou.97.1673892277592; Mon, 16 Jan
 2023 10:04:37 -0800 (PST)
MIME-Version: 1.0
References: <20230110225042.6710-1-joshua@froggi.es>
 <d9d534bc-938c-c112-c779-4bc95360cf45@igalia.com>
In-Reply-To: <d9d534bc-938c-c112-c779-4bc95360cf45@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Jan 2023 13:04:26 -0500
Message-ID: <CADnq5_MGLoyaev++K8C_QKAZSb3v00YK9asjH1Ou5UPU4_8bfQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix COLOR_SPACE_YCBCR2020_TYPE matrix
To: Melissa Wen <mwen@igalia.com>
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
Cc: amd-gfx@lists.freedesktop.org, Joshua Ashton <joshua@froggi.es>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied with the fixes tag.

Thanks,

Alex

On Mon, Jan 16, 2023 at 9:50 AM Melissa Wen <mwen@igalia.com> wrote:
>
> On 01/10, Joshua Ashton wrote:
> > The YCC conversion matrix for RGB -> COLOR_SPACE_YCBCR2020_TYPE is
> > missing the values for the fourth column of the matrix.
> >
> > The fourth column of the matrix is essentially just a value that is
> > added given that the color is 3 components in size.
> > These values are needed to bias the chroma from the [-1, 1] -> [0, 1]
> > range.
> >
> > This fixes color being very green when using Gamescope HDR on HDMI
> > output which prefers YCC 4:4:4.
> >
> > Signed-off-by: Joshua Ashton <joshua@froggi.es>
> > ---
> >  drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
> > index 471078fc3900..652270a0b498 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
> > @@ -90,8 +90,8 @@ static const struct out_csc_color_matrix_type output_csc_matrix[] = {
> >               { 0xE00, 0xF349, 0xFEB7, 0x1000, 0x6CE, 0x16E3,
> >                               0x24F, 0x200, 0xFCCB, 0xF535, 0xE00, 0x1000} },
> >       { COLOR_SPACE_YCBCR2020_TYPE,
> > -             { 0x1000, 0xF149, 0xFEB7, 0x0000, 0x0868, 0x15B2,
> > -                             0x01E6, 0x0000, 0xFB88, 0xF478, 0x1000, 0x0000} },
> > +             { 0x1000, 0xF149, 0xFEB7, 0x1004, 0x0868, 0x15B2,
> > +                             0x01E6, 0x201, 0xFB88, 0xF478, 0x1000, 0x1004} },
>
> LGTM.
>
> I'd also add a fixes tag here to:
>
> Fixes: 40df2f809e8f ("drm/amd/display: color space ycbcr709 support")
>
> Thanks,
>
> Reviewed-by: Melissa Wen <mwen@igalia.com>
>
> >       { COLOR_SPACE_YCBCR709_BLACK_TYPE,
> >               { 0x0000, 0x0000, 0x0000, 0x1000, 0x0000, 0x0000,
> >                               0x0000, 0x0200, 0x0000, 0x0000, 0x0000, 0x1000} },
> > --
> > 2.39.0
> >
>

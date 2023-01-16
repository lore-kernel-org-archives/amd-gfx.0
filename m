Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 761C0C46467
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jan 2023 18:02:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E940F10E040;
	Mon, 16 Jan 2023 18:02:57 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DBCD10E040
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jan 2023 18:02:56 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id d127so23943284oif.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jan 2023 10:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=X7wwBc2/hjoNa2z6QfzpwrZCG262VF7pAy3F1KFdzS8=;
 b=OyEsTBO9w9witcq3R/EvL8dbhb+TdJKRjqtFK/WRJEVbG1+HgGipqGtq3zbtjNKCjR
 42CSDiMpAhko4gayjWfa9wWbkj0LTZDON+96WoEjZGf9E8b2QKGgvB5fcWCIdkqhvLms
 hR5MiTn9Bqy+5gkNOF75P+F4qSQ9hcMTuqxmoVNs2vhLaLYaa9izeuAnloOrHEAZyF6r
 5wB7aBJ7kdsxTTL6dUMXMPO8OMY9KXc74fqJsnmMXl0Ngu0qLReF0t2wdmbXF9lqWJ+t
 fv0MxxLCTJrwIYILe56EBCjQFyuT2gW3kLs7s8kXpLeftVPDRLxervSA2QfHgICVJnnH
 Iy/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X7wwBc2/hjoNa2z6QfzpwrZCG262VF7pAy3F1KFdzS8=;
 b=35pOCs9ciba1TUbXLcR0YgshLMXv29/6lI2eU/DY14viTXV+abcBo9V15E6hJJSThu
 1i9yS+thMCOqWze5diB+bR9es/MBeLuCEvGDIL53NpWsIUaqQuxv7LqVjE3kxnwspG2B
 5lXL45zUzOuVbs5K9rXtILnqQdQsH+u6DHVZ2mqFmtQtQZuOEwA3+cEiDH0WGIHSKQd1
 MWKXT+lApnS/RYM11U7SlEvVm4B89WhhQ9FCS+er0G9OxzAukBt2scp8hqUQmI4zH5BO
 J5qKlbWM3YExKfBGABjZ3rW2vb36voyqsEGeb1CQVVuJhwyaQVrfgUF2M/wDPxEBe40a
 4bqQ==
X-Gm-Message-State: AFqh2kpt+BnHZqUGmdhOcxnUi4xqRmwkA58EnWg/CsP3g7u7aKpKOVeL
 B1DNgtxnG2Y6v0WBK1I6uqyW2hnIGS0yrdarL64Oqy8J
X-Google-Smtp-Source: AMrXdXuTJPGBM2hwODi3uzrENuf/C5P+2+ETxbZU9h7woVjiNCoOqhCI5HWhH5lwShCUSEXUKg8z9RKVe+cOy4wf4mc=
X-Received: by 2002:aca:2807:0:b0:35b:f5f7:3ed0 with SMTP id
 7-20020aca2807000000b0035bf5f73ed0mr9971oix.46.1673892175259; Mon, 16 Jan
 2023 10:02:55 -0800 (PST)
MIME-Version: 1.0
References: <20230110194338.281829-1-joshua@froggi.es>
 <20230110201221.671544-1-joshua@froggi.es>
 <20230116143517.lcckjls3eaxvc7r6@mail.igalia.com>
 <20230116144109.y4dyhlkfjw2bpxzk@mail.igalia.com>
In-Reply-To: <20230116144109.y4dyhlkfjw2bpxzk@mail.igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Jan 2023 13:02:43 -0500
Message-ID: <CADnq5_PhETqB=J=aG9+4GvgK=P5WD8R6cbRykiXZ_Ssf-yzbTw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: Calculate output_color_space after
 pixel encoding adjustment
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

Applied with the fixes tag.  Thanks!

Alex

On Mon, Jan 16, 2023 at 9:41 AM Melissa Wen <mwen@igalia.com> wrote:
>
> On 01/16, Melissa Wen wrote:
> > On 01/10, Joshua Ashton wrote:
> > > Code in get_output_color_space depends on knowing the pixel encoding to
> > > determine whether to pick between eg. COLOR_SPACE_SRGB or
> > > COLOR_SPACE_YCBCR709 for transparent RGB -> YCbCr 4:4:4 in the driver.
> > >
> > > v2: Fixed patch being accidentally based on a personal feature branch, oops!
> > >
> > > Signed-off-by: Joshua Ashton <joshua@froggi.es>
> > > ---
> > >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > index b4d60eedbcbf..9da71ee8fcc4 100644
> > > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > @@ -5341,8 +5341,6 @@ static void fill_stream_properties_from_drm_display_mode(
> > >
> > >     timing_out->aspect_ratio = get_aspect_ratio(mode_in);
> > >
> > > -   stream->output_color_space = get_output_color_space(timing_out);
> > > -
> > >     stream->out_transfer_func->type = TF_TYPE_PREDEFINED;
> > >     stream->out_transfer_func->tf = TRANSFER_FUNCTION_SRGB;
> > >     if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A) {
> > > @@ -5353,6 +5351,8 @@ static void fill_stream_properties_from_drm_display_mode(
> > >                     adjust_colour_depth_from_display_info(timing_out, info);
> > >             }
> > >     }
> > > +
> > > +   stream->output_color_space = get_output_color_space(timing_out);
> >
> > LGTM.
> >
> > I see that we were ignoring the updated value of pixel_encoding in the
> > previous point. Nice catch!
> >
> > Reviewed-by: Melissa Wen <mwen@igalia.com>
>
> BTW, I think it deserves a fixes tag to:
>
> Fixes: ea117312ea9f ("drm/amd/display: Reduce HDMI pixel encoding if max clock is exceeded")
>
> >
> > >  }
> > >
> > >  static void fill_audio_info(struct audio_info *audio_info,
> > > --
> > > 2.39.0
> > >
>
>

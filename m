Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD98C433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 18:41:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9775664F60
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 18:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9775664F60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3889C89BF0;
	Thu,  4 Mar 2021 18:41:59 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68D3189ADC
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Mar 2021 18:41:58 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id l133so31203797oib.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Mar 2021 10:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zXHMY+HaVflahTRdvW4Fok/M7tIbjff7JCVjWmzmvZ0=;
 b=mwdf5VnNbjfi0CsLjMnsj1wxcDzUbzj4/DhX+2cgGZ+ZSXVkVu/Smpip5iwFyFvrtf
 /fXjHQmMiteADwou+9S9k3+UPwVoNCF5EKCIns28QaX7Jl/FTxR7HFutBATNcIgQ2i8C
 py8Sm2v7w8DriZuG+j3eBp+ycl6kTL6TOXqk2bcLAnQfPGLFeOmGWAs9hjUI7n2YLlWr
 /insneEDVDc5ZmDi2coDjiS3nUW1IoyWOmUOifk/xY1f6Dr/8+ccTLdhuPztGFALpLo4
 aPT09vFU37snhO4OooWVn5D9GJlOn/R1vNtpz+H5iCq/vF3+J88L6/Cpi1/3IIxHqDbL
 Rqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zXHMY+HaVflahTRdvW4Fok/M7tIbjff7JCVjWmzmvZ0=;
 b=Tc9+JEvaqMRfckaRwGn3SvWI9ZIwDT96417OZ4GLy3BJWUN6HgGH/WMJdoui7hqn41
 yl7/dFljTfFkmpZ6W6fsOzNvRQx4ylCC7kkKDTmU1LIuCK3hOxJw8Bb8vKKjmNc2Gul2
 L0leUqv0bIq/4iOwr7X6mavcPlTluWuop4nAteZLQ43nS1vz8l+VaZ7GijrHt2ksOidr
 orgDQpYx/jxy6G7PcftAZ+kuBL4Rw1zsUPdbzMfkKk5RiozEgR01OblJAkxjEGcHEKz0
 zhQFc9ohlAb4LxflxNyBbRyGQHOS4GSc+w5rtUjHRu9qfFpmxr+6igqTHs39LhOJdGwe
 Za3A==
X-Gm-Message-State: AOAM532CKng4ce74eP3jI2qziGVFuSs6JbLKWVpjild44S3ViWlvPtf6
 aBOEigx1oPirxf5JLvfilWg7WEVQM2D+UREKbCI=
X-Google-Smtp-Source: ABdhPJwWHU9M8IgXClq893NhqpZYwZtzXr4bz3ta9CVnpgPa0P/EjCpdh1TeL0hscv5FSmp9O69V/RrFuI+tmyYJ/zM=
X-Received: by 2002:a05:6808:f15:: with SMTP id
 m21mr3867044oiw.123.1614883317699; 
 Thu, 04 Mar 2021 10:41:57 -0800 (PST)
MIME-Version: 1.0
References: <20210304174103.202272-1-alexander.deucher@amd.com>
 <20210304174103.202272-3-alexander.deucher@amd.com>
 <eeb3b2e8-affe-ffa9-b538-d0da4a34c877@amd.com>
In-Reply-To: <eeb3b2e8-affe-ffa9-b538-d0da4a34c877@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 4 Mar 2021 13:41:46 -0500
Message-ID: <CADnq5_NRF4N+85Rf-3xOq0nmOFjkwRbdj7znHsL9J2vN=Ufg5w@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm/amdgpu/display: don't assert in set backlight
 function
To: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Takashi Iwai <tiwai@suse.de>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Mar 4, 2021 at 1:33 PM Kazlauskas, Nicholas
<nicholas.kazlauskas@amd.com> wrote:
>
> On 2021-03-04 12:41 p.m., Alex Deucher wrote:
> > It just spams the logs.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>
> This series in general looks reasonable to me:
> Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
>
> > ---
> >   drivers/gpu/drm/amd/display/dc/core/dc_link.c | 1 -
> >   1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> > index fa9a62dc174b..974b70f21837 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> > @@ -2614,7 +2614,6 @@ bool dc_link_set_backlight_level(const struct dc_link *link,
> >                       if (pipe_ctx->plane_state == NULL)
> >                               frame_ramp = 0;
> >               } else {
> > -                     ASSERT(false);
>
> Just a comment on what's actually going on here with this warning:
>
> Technically we can't apply the backlight level without a plane_state in
> the context but the panel is also off anyway.
>
> I think there might be a bug here when the panel turns on and we're not
> applying values set when it was off but I don't think anyone's reported
> this as an issue.
>
> I'm not entirely sure if the value gets cached and reapplied with the
> correct value later, but it's something to keep in mind.

It doesn't.  I have additional patches here to cache it:
https://cgit.freedesktop.org/~agd5f/linux/log/?h=backlight_wip

Alex

>
> Regards,
> Nicholas Kazlauskas
>
> >                       return false;
> >               }
> >
> >
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

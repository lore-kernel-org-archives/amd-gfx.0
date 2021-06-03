Return-Path: <SRS0=4Sal=K5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D84C47096
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 19:29:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 231296124B
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 19:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 231296124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7ECF6F4FF;
	Thu,  3 Jun 2021 19:29:33 +0000 (UTC)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C4AF6F4FB
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Jun 2021 19:29:33 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 t10-20020a05683022eab0290304ed8bc759so6794299otc.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Jun 2021 12:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4v1EsAN4qH2OFMwX+3vD1tHMpl4XVuDXpoBcEWFrYg0=;
 b=uQvrjCNgx0ryIVq0CY7rEGmd8kxrPDVlXYUbqVRqbzZMLoFThJKkYQxsMT1i6EX6Rl
 pOs4EQSRuMNzbJH3tf0VdwZ/kdM7KJ8efRXRsShOcwAvsrRltqHhi7o8qV4fEARUkfw0
 IyPheDfJfuyOhYm0Ix0fWkRV5T/b4a5iWNFueambb/UW6lMONtFOZXOwjzD44eAtaFgu
 rCZMmtLiAe0SZvurUTfS0BAQw3EXNsjZx6JW/XFJytD3rB0FiMvstuXnN9WgodJUj6OC
 jelAGp3CLW5lnNuP+whmO7WStis2RQmyxhonH4My23QVb1c3UjrV1k9NOs6ck7CoMMlR
 E84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4v1EsAN4qH2OFMwX+3vD1tHMpl4XVuDXpoBcEWFrYg0=;
 b=tp5EpgNm4A98NALT9QNpaWjzLYhgKSfkLn91yX91fipOhRyJm3DjXlaqtkSWmLiOSr
 W2+k9NBYc7YmtnrMK7Di7JqtpCdyDleKwoLShGGGLP0BsGxkxkC2sqFJzRkbbdAX3/C1
 ZHX2QHwvmES+9JGHGZbAnj9Cx/BJaiAtQa/5oEybnU4HDt+y+kylXQHnZ60tJjRSJ5wr
 sdcqEk16ZbmyxFxIHesBGUxd4UFJN2TTzcCR0ykYp8gol9n9uxdQgbxSSPuQbeH/OvOG
 PIq+jRrdbMpyceOJIZO10U1shC4FZ64k/1qOsRxkqANxpvMfb/3b2IYaM+8+z5djpHO3
 qpgw==
X-Gm-Message-State: AOAM530QOEzwO/dOyXeOf4KyMM9d41eyxI0sgxRhIAyZXqH+HaqXOBg+
 KjMDIyKufttEqoA7XowJz5BXpjdxbmi/z85cWx6sk8mV
X-Google-Smtp-Source: ABdhPJzIsM1QmhTrBlwBMYxozM00bm1vguNYSomyLAf41AjiFsAD+zJd0dxnZa1Lr8+2UAxWr/+ilRx9BXUdu4KKot4=
X-Received: by 2002:a9d:74c6:: with SMTP id a6mr768946otl.132.1622748572593;
 Thu, 03 Jun 2021 12:29:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210602204556.17324-1-mario.kleiner.de@gmail.com>
 <887b4f3a-e609-e288-4c61-e9b12527fe4c@amd.com>
In-Reply-To: <887b4f3a-e609-e288-4c61-e9b12527fe4c@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 3 Jun 2021 15:29:21 -0400
Message-ID: <CADnq5_Nox9gYoJvg6AvszsuE+V6+ko+xBgeGScgRWM2xQ=krAA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Keep linebuffer pixel depth at 30bpp for
 DCE-11.0.
To: Harry Wentland <harry.wentland@amd.com>
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
Cc: Tom St Denis <Tom.StDenis@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Mario Kleiner <mario.kleiner.de@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Wed, Jun 2, 2021 at 4:58 PM Harry Wentland <harry.wentland@amd.com> wrote:
>
> On 2021-06-02 4:45 p.m., Mario Kleiner wrote:
> > Testing on AMD Carizzo with DCE-11.0 display engine showed that
> > it doesn't like a 36 bpp linebuffer very much. The display just
> > showed a solid green.
> >
> > Testing on RavenRidge DCN-1.0, Polaris11 with DCE-11.2 and Kabini
> > with DCE-8.3 did not expose any problems, so for now only revert
> > to 30 bpp linebuffer depth on asics with DCE-11.0 display engine.
> >
> > Reported-by: Tom StDenis <Tom.StDenis@amd.com>
> > Signed-off-by: Mario Kleiner <mario.kleiner.de@gmail.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
>
> Curious now why Carrizo doesn't like a LB depth of 36bpp but
> this should fix the issue.
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> > index b2ee3cd77b4e..a4f1ae8930a4 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> > @@ -1213,9 +1213,16 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
> >        * on certain displays, such as the Sharp 4k. 36bpp is needed
> >        * to support SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616 and
> >        * SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616 with actual > 10 bpc
> > -      * precision on at least DCN display engines.
> > +      * precision on at least DCN display engines. However, at least
> > +      * Carrizo with DCE_VERSION_11_0 does not like 36 bpp lb depth,
> > +      * so use only 30 bpp on DCE_VERSION_11_0. Testing with DCE 11.2 and 8.3
> > +      * did not show such problems, so this seems to be the exception.
> >        */
> > -     pipe_ctx->plane_res.scl_data.lb_params.depth = LB_PIXEL_DEPTH_36BPP;
> > +     if (plane_state->ctx->dce_version != DCE_VERSION_11_0)
> > +             pipe_ctx->plane_res.scl_data.lb_params.depth = LB_PIXEL_DEPTH_36BPP;
> > +     else
> > +             pipe_ctx->plane_res.scl_data.lb_params.depth = LB_PIXEL_DEPTH_30BPP;
> > +
> >       pipe_ctx->plane_res.scl_data.lb_params.alpha_en = plane_state->per_pixel_alpha;
> >
> >       pipe_ctx->plane_res.scl_data.recout.x += timing->h_border_left;
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

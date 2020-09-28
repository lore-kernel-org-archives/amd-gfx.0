Return-Path: <SRS0=mGSI=DF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77234C2D0A8
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 21:36:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8EAD2083B
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 21:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P378HXF8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8EAD2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A5D26E027;
	Mon, 28 Sep 2020 21:36:28 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3671E89FC0;
 Mon, 28 Sep 2020 21:36:27 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id x14so2878614wrl.12;
 Mon, 28 Sep 2020 14:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lg72f/ki+Nr/iZNXbnkCfawq5tgBbM/zP6P3XRek5bg=;
 b=P378HXF8lDQS15gYGSLKSK80Y2uySP5PIw1JhB1k3ywpT78V2lGnOZNM+FntrAoJTP
 q1K3iqjy+d+Pz5HjT15hifLr52+giqnftZBvjrokCxJpbjoDON/spwyISLtENR2SQNjG
 Z96lHWf/l2UxZyuFT91ma/pB9/gBwECeCUGZ+qcPQOV+YWg5+VLeWGSq/9W4Ik2JI4Im
 63rf+zjUxcQg8h0+mARits8SWknLXnE9O40/3B5j8NDp5sYbefQlrsiD2mtKoEqQlgOb
 FatMnPTVXozDhmO7h2C8mafyrMSAVYnkEvjM4JsfbDHjpEGJhQYJduv/DFULWKH6JfLX
 qCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lg72f/ki+Nr/iZNXbnkCfawq5tgBbM/zP6P3XRek5bg=;
 b=PUJr0XT5xncTrRoFiI4U3xq/Xn4VERe+e5ZHYm97DrdNxIcbRHeYu6bhCnHGeTLpqY
 gihSJM0jpFH02E0+1rpMGGbzPhbKwrEXO+cNtZQ+8ojJah0hiEnTkTrCWnkeqL6zC5Eg
 eiVjVDQW/z+1VcmeINMbEJ9yLPqPwf2UBBiR74GEuAl1wmHisMPcS7OmGNCjYsMPgwpr
 YXnWHX8K3K5D3pvhkl5FVTSJp0pyMHZqwZqmMnzk+v9OX0DPDgpJSgwbzUmVLwOvTYY6
 7+bWofyhksv7vRB/wMvzy59rl8F5G0HnwPHmm7ccN1Ja1maxgNGcZSDf/rNuf6UCArF6
 yN1A==
X-Gm-Message-State: AOAM533kZpwip32L45f9BzeO+aWQU5OtrMH6QitTBpxjGhjVPQqHLdYJ
 xJOfRFohnyD9ChN0hubg7KokwLfCYz7xGDfcDWQ=
X-Google-Smtp-Source: ABdhPJyov/LNWn2r64zvaANAL7jq9X82SSPRIytFv1tkUvAbqLbFcVIec5V8Vw9JS4x5Eoxh51/mMoJOV7plLmrsgw8=
X-Received: by 2002:adf:fc0a:: with SMTP id i10mr454434wrr.111.1601328985910; 
 Mon, 28 Sep 2020 14:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200928023543.70093-1-yanaijie@huawei.com>
 <bd4d89ca-a9e1-e49d-c9f0-fe5cd07daec3@amd.com>
In-Reply-To: <bd4d89ca-a9e1-e49d-c9f0-fe5cd07daec3@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Sep 2020 17:36:14 -0400
Message-ID: <CADnq5_MHwYpYnBh1KQDomy9dhSbBr7+XdnmjA3bznFE4z-kUjQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: make two symbols static
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
Cc: Jason Yan <yanaijie@huawei.com>, "Leo \(Sunpeng\) Li" <sunpeng.li@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Dave Airlie <airlied@linux.ie>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, Anthony Koo <Anthony.Koo@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Mon, Sep 28, 2020 at 10:06 AM Harry Wentland <harry.wentland@amd.com> wrote:
>
> On 2020-09-27 10:35 p.m., Jason Yan wrote:
> > This addresses the following sparse warning:
> >
> > drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_hw_sequencer.c:2740:6:
> > warning: symbol 'dce110_set_cursor_position' was not declared. Should it
> > be static?
> > drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_hw_sequencer.c:2785:6:
> > warning: symbol 'dce110_set_cursor_attribute' was not declared. Should
> > it be static?
> >
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Jason Yan <yanaijie@huawei.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> > index 1002ce9979dc..31a8d3452e83 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> > @@ -2737,7 +2737,7 @@ static void program_output_csc(struct dc *dc,
> >       }
> >  }
> >
> > -void dce110_set_cursor_position(struct pipe_ctx *pipe_ctx)
> > +static void dce110_set_cursor_position(struct pipe_ctx *pipe_ctx)
> >  {
> >       struct dc_cursor_position pos_cpy = pipe_ctx->stream->cursor_position;
> >       struct input_pixel_processor *ipp = pipe_ctx->plane_res.ipp;
> > @@ -2782,7 +2782,7 @@ void dce110_set_cursor_position(struct pipe_ctx *pipe_ctx)
> >               mi->funcs->set_cursor_position(mi, &pos_cpy, &param);
> >  }
> >
> > -void dce110_set_cursor_attribute(struct pipe_ctx *pipe_ctx)
> > +static void dce110_set_cursor_attribute(struct pipe_ctx *pipe_ctx)
> >  {
> >       struct dc_cursor_attributes *attributes = &pipe_ctx->stream->cursor_attributes;
> >
> >
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

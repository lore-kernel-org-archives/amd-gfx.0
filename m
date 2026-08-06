Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 067A6C55ABF
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2026 09:18:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6499510E2CD;
	Thu,  6 Aug 2026 09:18:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=nuetzel-hh.de header.i=@nuetzel-hh.de header.b="tCdEq6P9";
	dkim-atps=neutral
X-Greylist: delayed 400 seconds by postgrey-1.36 at gabe;
 Thu, 06 Aug 2026 09:18:32 UTC
Received: from mail.ud03.udmedia.de (ud03.udmedia.de [194.117.254.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D232F10E2E2
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2026 09:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuetzel-hh.de;
 h=mime-version:date:from:to:cc:subject:message-id:content-type
 :content-transfer-encoding; s=k1; bh=GpxvBtFmuGmDgYcmedZKQYzacqD
 xjViopX4x+IrjBZg=; b=tCdEq6P9aV8TqbKac0Gt6O0Zaca8d5YWgfvfhT2+ue6
 6pd9Af+CELcw3PcqoA0GuSbdmJFr9Ke/xLN7S+aJjLO7vEA81h9/97SyiGlEVvGl
 ZdybC9Yw0K8r6EGu0NegXwn+sk5cYrguPRxT/ONOLB4HHOBaT62sxcSOaVlqfgz7
 /g/acV3m3svr4DPoF/OqsrjwJ7qob6AXz2LxJ6c3hX7rQwUJ9jX5KhEPtCuYKlwc
 /gnk7cLfBqrxIDkV1D2jskuDwIw4JHtLhkSTo2I9jQP8g0bNMRUVlsxkEYuJ6sSh
 tAWhvVl9zMgslK641NOe2/I/TxBYM/nvvYN8PVRYsjA==
Received: (qmail 1821829 invoked from network); 6 Aug 2026 11:11:50 +0200
Received: by mail.ud03.udmedia.de with ESMTPA; 6 Aug 2026 11:11:50 +0200
X-UD-Smtp-Session: ud03?335p7@B6Y5R11YFNDCdf4e
MIME-Version: 1.0
Date: Thu, 06 Aug 2026 11:11:50 +0200
From: =?UTF-8?Q?Dieter_N=C3=BCtzel?= <Dieter@nuetzel-hh.de>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-devel <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/display: Fix crash in
 hwss_set_output_transfer_func()
Message-ID: <855de4d0b479bc35bbb906b7306aa359@nuetzel-hh.de>
X-Sender: Dieter@nuetzel-hh.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello Alex,

where did you commited, this?
Can't find it your trees.

By the way:

Tested-by: Dieter Nützel <Dieter@nuetzel-hh.de>

https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/41557#note_3602165

Greetings,
   Dieter

PS Please CC me. I'm currently not on 'amd-devel'.


> Applied.  Thanks!
> 
> On Mon, Aug 3, 2026 at 8:58 AM Timur Kristóf <timur.kristof at 
> gmail.com> wrote:
> >
> > The pipe_ctx->plane_res.hubp pointer is NULL on all DCE
> > hardware, which causes a kernel NULL pointer dereference
> > on all Vega and older GPUs.
> >
> > Let's add a simple NULL check.
> >
> > Fixes: f879f53407f0 ("drm/amd/display: Refactor DPP_SET_OUTPUT_TRANSFER_FUNC to drop pipe_ctx")
> > Signed-off-by: Timur Kristóf <timur.kristof at gmail.com>
> > Cc: Tomasz Siemek <tomasz.siemek at amd.com>
> > ---
> >  drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
> > index 11411fa94665..5495e493b2eb 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
> > @@ -1900,7 +1900,8 @@ void hwss_set_output_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx)
> >                                 .xfm = pipe_ctx->plane_res.xfm,
> >                                 .dpp = pipe_ctx->plane_res.dpp,
> >                                 .mpc = dc->res_pool->mpc,
> > -                               .mpcc_id = pipe_ctx->plane_res.hubp->inst,
> > +                               .mpcc_id = pipe_ctx->plane_res.hubp ?
> > +                                               pipe_ctx->plane_res.hubp->inst : 0,
> >                                 .is_top_pipe = resource_is_pipe_type(pipe_ctx, OPP_HEAD),
> >                                 .stream = pipe_ctx->stream,
> >                         }
> > --
> > 2.55.0
> >

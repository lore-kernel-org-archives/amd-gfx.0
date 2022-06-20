Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C50C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jun 2022 19:04:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85C6010E08B;
	Mon, 20 Jun 2022 19:04:13 +0000 (UTC)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF41310E105
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jun 2022 19:04:12 +0000 (UTC)
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-317710edb9dso109820917b3.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jun 2022 12:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FxQIzsezBBU5WOU/5RHOOXmsN9UcVkxzkQDKLDgtUQE=;
 b=lNM+bxHANEqQHP7i7XjWuh4rrhglSaGwked3id9GqITMtfMIyg9S2CDezHgEmqilUH
 hrOEpZbTv1DecwK0IMcsQGL+2+EnhJE+cZ8ZRCHk3gp7Wa0F+DUv0bj4+twaAtt1w2vy
 Kz8SWL84moGLMleMXYWf5gi91iA1nA/xiS7SoAczRVo/khNvTgBGH1aH6wbBNWb0+VeI
 cYClB1GG2PIXK5XNmhOFjm3WjrEj465YBYfXpvxLgQPOZn/TTg+HV6AcIMQHKzUFYD+l
 EyWpoK4vafraDymnreOEQTQ6iUP11IXFE56TCdaWOxeX3SgTjCFPi9SQ3pyZ1bdCBfL6
 I+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FxQIzsezBBU5WOU/5RHOOXmsN9UcVkxzkQDKLDgtUQE=;
 b=xnUhSFkLRCzhuXY1RZzAu5iB8XIwX+l+XLhgIsru7PiTeobq4T/qVhWIDsL87bcVBP
 h/KFmfAnTftrZNt/W4zv7YBoZRa8PB9g/nK+H/OCHmikiD3Xck8E42xSr68YYEcJyUIy
 l8RnD5x44+Xabsgvcj67r6YaDiCRr75BcbZa77X2RtTcZkf58FVvNk9YQ7QFzU5/ORMc
 t9zzBnsa8/34+FMJCCR9NOv3Lmc/3Vv7vBOjIihJQEzDvIbOYu2x99Ct778rRM8oPXUq
 78UiTut66SQDRrWrtYpZV8KkMMF5yaBVC5+wbiVvIZSW3LtViXS0IylFGNREqS7S2ywc
 VMGw==
X-Gm-Message-State: AJIora8FxelRlL5q6mYL2qI63bSzVbbvhPomBSgCh9lYlCqyBga0unnx
 9QWoq1zAdG7outb3uBHIjEgFnbotjF5g/nW4lqg=
X-Google-Smtp-Source: AGRyM1u+k9WXAErwxUA3igcrqIWAnnhUJ15GVb71U76WwMJ16Y2NkbaHnUR3FB9q8ixPJuDmxQ9mxzgYFpJMAGj2RXY=
X-Received: by 2002:a0d:df8d:0:b0:317:c206:2e7c with SMTP id
 i135-20020a0ddf8d000000b00317c2062e7cmr9020902ywe.97.1655751851889; Mon, 20
 Jun 2022 12:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220615223005.11667-1-mario.limonciello@amd.com>
 <MN0PR12MB6101466F795F1D1CFB9C1321E2AC9@MN0PR12MB6101.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB6101466F795F1D1CFB9C1321E2AC9@MN0PR12MB6101.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 20 Jun 2022 15:04:00 -0400
Message-ID: <CADnq5_Or8SWfvFWyv5ne81iMP952FVPsy5tLP7aKdCtDa8EDeg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Revert "drm/amd/display: keep eDP Vdd on when
 eDP stream is already enabled"
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>
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
Cc: "Liu, Charlene" <Charlene.Liu@amd.com>, "Liu, Zhan" <Zhan.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Wheeler,
 Daniel" <Daniel.Wheeler@amd.com>, Aaron Ma <aaron.ma@canonical.com>, "Dhillon,
 Jasdeep" <Jasdeep.Dhillon@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, Jun 16, 2022 at 11:48 AM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> [Public]
>
> + people associated with original patch being reverted for comments
>
> > -----Original Message-----
> > From: Limonciello, Mario <Mario.Limonciello@amd.com>
> > Sent: Wednesday, June 15, 2022 17:30
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; Aaron Ma
> > <aaron.ma@canonical.com>
> > Subject: [PATCH] drm/amd: Revert "drm/amd/display: keep eDP Vdd on
> > when eDP stream is already enabled"
> >
> > A variety of Lenovo machines with Rembrandt APUs and OLED panels have
> > stopped showing the display at login.  This behavior clears up after
> > leaving it idle and moving the mouse or touching keyboard.
> >
> > It was bisected to be caused by commit 559e2655220d ("drm/amd/display:
> > keep eDP Vdd on when eDP stream is already enabled").  Revert this commit
> > to fix the issue.
> >
> > Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2047
> > Reported-by: Aaron Ma <aaron.ma@canonical.com>
> > Fixes: 559e2655220d ("drm/amd/display: keep eDP Vdd on when eDP stream
> > is already enabled")
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> >  .../display/dc/dce110/dce110_hw_sequencer.c   | 24 ++-----------------
> >  1 file changed, 2 insertions(+), 22 deletions(-)
> >
> > diff --git
> > a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> > b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> > index 7eff7811769d..5f2afa5b4814 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> > @@ -1766,29 +1766,9 @@ void dce110_enable_accelerated_mode(struct dc
> > *dc, struct dc_state *context)
> >                               break;
> >                       }
> >               }
> > -
> > -             /*
> > -              * TO-DO: So far the code logic below only addresses single
> > eDP case.
> > -              * For dual eDP case, there are a few things that need to be
> > -              * implemented first:
> > -              *
> > -              * 1. Change the fastboot logic above, so eDP link[0 or 1]'s
> > -              * stream[0 or 1] will all be checked.
> > -              *
> > -              * 2. Change keep_edp_vdd_on to an array, and maintain
> > keep_edp_vdd_on
> > -              * for each eDP.
> > -              *
> > -              * Once above 2 things are completed, we can then change
> > the logic below
> > -              * correspondingly, so dual eDP case will be fully covered.
> > -              */
> > -
> > -             // We are trying to enable eDP, don't power down VDD if
> > eDP stream is existing
> > -             if ((edp_stream_num == 1 && edp_streams[0] != NULL) ||
> > can_apply_edp_fast_boot) {
> > +             // We are trying to enable eDP, don't power down VDD
> > +             if (can_apply_edp_fast_boot)
> >                       keep_edp_vdd_on = true;
> > -                     DC_LOG_EVENT_LINK_TRAINING("Keep eDP Vdd
> > on\n");
> > -             } else {
> > -                     DC_LOG_EVENT_LINK_TRAINING("No eDP stream
> > enabled, turn eDP Vdd off\n");
> > -             }
> >       }
> >
> >       // Check seamless boot support
> > --
> > 2.34.1

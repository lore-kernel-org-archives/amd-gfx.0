Return-Path: <SRS0=gUFK=E2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A427C2D0E4
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 20:51:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D4822223F
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 20:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTuhl56g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D4822223F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8D396E928;
	Fri, 20 Nov 2020 20:51:55 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EB596E928
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2020 20:51:54 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id c17so11498689wrc.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2020 12:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+EW1Xb7lOzFelOBdgmNbLzbgoAxCKz35CoXIKu/aeII=;
 b=VTuhl56gWz33nB/sUUwXCxNO3Wy0GYPmY8UqVNe0U2jlCpaJiO8K+NTFAIm/n40i5e
 Z87wlmC4SIwI6mtYB433yqpVTaCFs3lYmcr9f3ljcHmnVq6CEbvuta4VNWCB7Vw2y1R1
 LtihwveVFhvdmwYj5lXBSDFaCuDScEFe/JJtwP+qPPdmT93/mGzY6s+4UJjjWnEaYMLW
 rrHT/S53O1sqCjbUY0vlLa8r9nTupCo5KV/rtdEy3fjruxEo8AihAQgMiBrWZ58Crb/u
 zcatvkkKKJpLIfOes1YKW0KfSS259prN47Pb14fzlRn9rvDGQ2MOLjY5Hdf/vSOUE4BA
 c6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+EW1Xb7lOzFelOBdgmNbLzbgoAxCKz35CoXIKu/aeII=;
 b=tH7H2mdDATmUuy7ErY+iygQ6rpjkeB9VP5w4mtSgpoNmjuJdNKzGBINw/SEUvicyxC
 q/C3wYWTHNAuaEBmSzjlD+0qJK7rCYhpnLJdQCnbA1porJ7SPAdRmOFzapRycy7FWwRV
 PCyTD7g1qPBckvrsGYAGjwwGDQAspvesQOxoc8QFLovrlE9synPLf3WBYlvs2uUStkC4
 DHS4hf9DxuXXoU7omPYrEsRcCvqh5/X8dQtEGUN7EzRxbFOxcKlcqns0+Ovn+a64dHGR
 cqVIPRmYE57BqeOFfzVv3vDinwKZ0lPly2ZH0WEfPInd//+k/tB2XkWijdB2b4tx8BG+
 J8Ng==
X-Gm-Message-State: AOAM530U1VR5iaY6uyWAO0CZhVvEI6PgQyhNDLKn4dzW7HQNSjuPnFzl
 1RF8TxvJiI9ztkdTZU6CMYMjymVgbpNFsprNvr8=
X-Google-Smtp-Source: ABdhPJzR//LP3TR4Fvsn4trhVqGg7PbujtLyoAh5L5vQ4MdeE6W682fhB3spnnpeUbhgCax037L7sCuNe78D+YGkI6k=
X-Received: by 2002:adf:9144:: with SMTP id j62mr18986500wrj.419.1605905513163; 
 Fri, 20 Nov 2020 12:51:53 -0800 (PST)
MIME-Version: 1.0
References: <P5iZhKB1vEj9b6kWD41KhDPb7BvvEr72fMg2Kke4PI@cp7-web-039.plabs.ch>
 <CADnq5_NjZB=1t_MpYN7mx39UFiFaM2gDVmfZy0gNKDm-+TyGHw@mail.gmail.com>
In-Reply-To: <CADnq5_NjZB=1t_MpYN7mx39UFiFaM2gDVmfZy0gNKDm-+TyGHw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 20 Nov 2020 15:51:42 -0500
Message-ID: <CADnq5_PskYJ8pXGkC=1JfM+7cXLY5NZbfpNpPUGyHPFNHwNKaA@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/amd/display: add cursor FB size check
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
 Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Nov 20, 2020 at 3:50 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Fri, Nov 20, 2020 at 3:19 PM Simon Ser <contact@emersion.fr> wrote:
> >
> > This patch expands the cursor checks added in "drm/amd/display: add basic
> > atomic check for cursor plane" to also include a FB size check. Without
> > this patch, setting a FB smaller than max_cursor_size with an invalid
> > width would result in amdgpu error messages and a fallback to a 64-byte
> > width:
> >
> >     [drm:hubp1_cursor_set_attributes [amdgpu]] *ERROR* Invalid cursor pitch of 100. Only 64/128/256 is supported on DCN.
> >
> > Note that DC uses the word "pitch" when actually checking the FB width.
> > Indeed, the function handle_cursor_update does this:
> >
> >     attributes.pitch = attributes.width;
> >
> > In my tests, the cursor FB actually had a pitch of 512 bytes.
> >
> > Signed-off-by: Simon Ser <contact@emersion.fr>
> > Reported-by: Pierre-Loup A. Griffais <pgriffais@valvesoftware.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Harry Wentland <hwentlan@amd.com>
> > Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> > ---
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 22 +++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 2855bb918535..bd63f1c4ae79 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -8902,6 +8902,28 @@ static int dm_update_plane_state(struct dc *dc,
> >                         return -EINVAL;
> >                 }
> >
> > +               if (new_plane_state->fb) {
> > +                       if (new_plane_state->fb->width > new_acrtc->max_cursor_width ||
> > +                           new_plane_state->fb->height > new_acrtc->max_cursor_height) {
> > +                               DRM_DEBUG_ATOMIC("Bad cursor FB size %dx%d\n",
> > +                                                new_plane_state->fb->width,
> > +                                                new_plane_state->fb->height);
> > +                               return -EINVAL;
> > +                       }
> > +
> > +                       switch (new_plane_state->fb->width) {
> > +                       case 64:
> > +                       case 128:
> > +                       case 256:
> > +                               /* FB width is supported by cursor plane */
>
> I'm pretty sure DCE6.x only supports 64 and DCE8-12 only supports 128.
> I think only DCN supports 256.

Nevermind, the check above handles this.

Thanks,

>
> Alex
>
>
> > +                               break;
> > +                       default:
> > +                               DRM_DEBUG_ATOMIC("Bad cursor FB width %d\n",
> > +                                                new_plane_state->fb->width);
> > +                               return -EINVAL;
> > +                       }
> > +               }
> > +
> >                 return 0;
> >         }
> >
> > --
> > 2.29.2
> >
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

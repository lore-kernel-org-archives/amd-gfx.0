Return-Path: <SRS0=1d7w=FG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B225DC6369E
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Dec 2020 22:24:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DB6A20709
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Dec 2020 22:24:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DB6A20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4528F89939;
	Wed,  2 Dec 2020 22:24:43 +0000 (UTC)
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F9E9899E8
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Dec 2020 22:24:42 +0000 (UTC)
Received: by mail-ot1-x342.google.com with SMTP id z23so3163631oti.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Dec 2020 14:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HGH50Od23oD+82RnOg7eDFsri8ra+Qf2J6wAcp47LFA=;
 b=ZGTp3EOr72ym7d74baFAxFSt+Om6jyL7khKokbYxuvxPAFIVSQErPHmhEMJ0wDqXAH
 35Me3f4wp9J/4K0kjHrCh4WbMaFPPUKSaS6JFTCC94gDVJFsHSRpj6stQDbBmIojjd2M
 NIUDIysuIsdSPy1+RgoN0IDLkzkpddSl/pbosKTIfxFmP+D5CM/qPon6AEd1B5Hu+N0P
 ojet0fo9yUbjIp9I2xvTeNxzQn4SbQcLkllDNTqJtmhKUqivgAx0RHh15eE8j8sjsHqs
 B1LefimRT65BTLM66N+/v7ybK0tYbaLDgqijUYQvl/qDQE+yz/q3t5/39FmgjqkTiAXK
 S2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HGH50Od23oD+82RnOg7eDFsri8ra+Qf2J6wAcp47LFA=;
 b=iK3SnWVvoxQPCjuHnJ4qlHFzRSyqTkv/eI50OmZmDQ2mLK/Eot/tr+aBYKk4eDZIun
 ggCfLxBXWC3hGM6WqqCy4ZQ7KV7GUzTKnfdGg6HWhn0qxOkW7sGPB27pv3en8dMnQeQC
 YqYaEB0JltgIHv2YB9BDhP5NakklRAhNT/L5aW9EsddMkp482NW6bHLemcJHVTydyUVv
 RHGNngZXnenpwh+b3GqVdHZ2MSB0RcM9bdaglzG/COJWP6HvYt2FJ4PaAVFj6p3J9Aj+
 ZKIrRWR7g2kZW+eJ+WZ5u9cWL1/dtFg28Grj7yoYjkG/y2mUhpk1c0ZBHh+oQMFsYT0b
 iMow==
X-Gm-Message-State: AOAM530UM0mExtAzYmqN+/TXUtwW1IO3TFSSc93bPC53lCyzcbXWRV1g
 f7uR1MgLyPc76tHwdu81e8lMkLmiimg2uINoJ+s=
X-Google-Smtp-Source: ABdhPJxcjI/Kd4kC+hp/vAdZmIwp8dqeeQOQVYARIwrzWkh/hM2PhpgF28gCn2dQHwVJb9l4p6TPdHHPP4NYZUnVl8U=
X-Received: by 2002:a9d:5388:: with SMTP id w8mr11689otg.311.1606947881626;
 Wed, 02 Dec 2020 14:24:41 -0800 (PST)
MIME-Version: 1.0
References: <7UvPE5okTSEaIRnrg3TJcnkyIBhPPRXCCuMa5wwC18@cp3-web-029.plabs.ch>
 <e1f8e29f-138f-9e1d-0ba7-ce10059f87d0@amd.com>
In-Reply-To: <e1f8e29f-138f-9e1d-0ba7-ce10059f87d0@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 2 Dec 2020 17:24:30 -0500
Message-ID: <CADnq5_NmrL7=BsUZ-CGiA=0e7W83Sf5Dek9iOYCX7ji8aRJmQg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/display: add cursor pitch check
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Simon Ser <contact@emersion.fr>,
 Harry Wentland <hwentlan@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Dec 2, 2020 at 4:33 PM Kazlauskas, Nicholas
<nicholas.kazlauskas@amd.com> wrote:
>
> On 2020-12-02 4:09 p.m., Simon Ser wrote:
> > Replace the width check with a pitch check, which matches DM internals.
> > Add a new check to make sure the pitch (in pixels) matches the width.
> >
> > Signed-off-by: Simon Ser <contact@emersion.fr>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Harry Wentland <hwentlan@amd.com>
> > Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
>
> Series is:
>
> Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Applied.  Thanks!

Alex

>
> Regards,
> Nicholas Kazlauskas
>
> > ---
> >   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 19 +++++++++++++++----
> >   1 file changed, 15 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 9e328101187e..862a59703060 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -8988,6 +8988,7 @@ static int dm_update_plane_state(struct dc *dc,
> >       struct amdgpu_crtc *new_acrtc;
> >       bool needs_reset;
> >       int ret = 0;
> > +     unsigned int pitch;
> >
> >
> >       new_plane_crtc = new_plane_state->crtc;
> > @@ -9021,15 +9022,25 @@ static int dm_update_plane_state(struct dc *dc,
> >                               return -EINVAL;
> >                       }
> >
> > -                     switch (new_plane_state->fb->width) {
> > +                     /* Pitch in pixels */
> > +                     pitch = new_plane_state->fb->pitches[0] / new_plane_state->fb->format->cpp[0];
> > +
> > +                     if (new_plane_state->fb->width != pitch) {
> > +                             DRM_DEBUG_ATOMIC("Cursor FB width %d doesn't match pitch %d",
> > +                                              new_plane_state->fb->width,
> > +                                              pitch);
> > +                             return -EINVAL;
> > +                     }
> > +
> > +                     switch (pitch) {
> >                       case 64:
> >                       case 128:
> >                       case 256:
> > -                             /* FB width is supported by cursor plane */
> > +                             /* FB pitch is supported by cursor plane */
> >                               break;
> >                       default:
> > -                             DRM_DEBUG_ATOMIC("Bad cursor FB width %d\n",
> > -                                              new_plane_state->fb->width);
> > +                             DRM_DEBUG_ATOMIC("Bad cursor FB pitch %d px\n",
> > +                                              pitch);
> >                               return -EINVAL;
> >                       }
> >               }
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

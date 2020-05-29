Return-Path: <SRS0=sMqH=7L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FD1C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2020 18:04:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEFE02073B
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2020 18:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNsGlDfi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEFE02073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B56906E959;
	Fri, 29 May 2020 18:04:26 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2FC06E969
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2020 18:04:25 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id q11so4826762wrp.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2020 11:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=r0YIEcvriwDuA6ZQ6iJ79bwRLgdIuiUtRvjIy007aS0=;
 b=YNsGlDfiDfCmL/zBfHwGHR7FOqJmf6nNF5bfAsbaAGV1gMDBl9TLV+bAPKWg/1sIXO
 btZPvjfCgQNpvksP0Qjlhq+Obh9DWAOuLvRtTzo2KcRtkV53YdUUKhV6PjS/uoBEiSU+
 9bLrbGxYpO81ftjMOFkWuopLWgbFhIdyPXjMGIXjwLS5flz3B6a0Z/QV39AfNvO+fcSX
 Y6TGBirpiHpkWkACi9AGMVx2f+hcLjg80rYHbQ8tJIIsfmAe+IgS+e/G0ljMGlnzgZMj
 GzXerm1vt9IcpRe8jYVbWmhWAMPs9xsaZuTNdMyWJy44NjIaWWaS9IpzE4epwJt4henu
 g3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=r0YIEcvriwDuA6ZQ6iJ79bwRLgdIuiUtRvjIy007aS0=;
 b=e8yKwqnfQqE2pPkGrHFOTJfLfPBG2x/G16bamesrDoJ/T/0mRWu7ifV9syDQqNZybw
 0CHEf+kUoXJJDgggMZk6iqb5DpN+7AUstRGiaUJg43ZSCNtZJbnYDPXBfqUeY93OTzE1
 r6QIU9MUD08KbJ2qm6bzHxn8JTAFNIOi7/pOVq7W2JqZEat/g0VAtt5sltuUGOm6H+uw
 hOBrRKI8dVYggg4me6CCQu9GHBd1IGq93oUWAlhDv2UEwv6QvzO+BAwwf1ltE/5usABq
 FOUOJRjr+oFqbbp6VZUGGO1indLCtL/9eOfavuUeIb2V6yBtwW4hnuJ/x+2EjN4PcHsC
 FWSA==
X-Gm-Message-State: AOAM532JZTR58MYX9lZumdXZ3fI+6oOv6XfqmG97f+FmimMRyClB4rxJ
 BYgLhdQ2Lanjz2ID+JB0+KdhmvS9QztGzTwJENF8Xg==
X-Google-Smtp-Source: ABdhPJxYKCrhw7Vnb9tYQpZwnE3nArmWuvDB50MEL793n/PwDGMuJU8wTsP+OWnPEOdLqWYkJ7wXcewR3+jF6KEKSGk=
X-Received: by 2002:adf:f5c2:: with SMTP id k2mr9601511wrp.111.1590775464574; 
 Fri, 29 May 2020 11:04:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200528140613.282473-1-alexander.deucher@amd.com>
 <da249d2c-1102-ad4b-1acb-1a62242ec22c@amd.com>
In-Reply-To: <da249d2c-1102-ad4b-1acb-1a62242ec22c@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 29 May 2020 14:04:13 -0400
Message-ID: <CADnq5_Mu_nuv2dXnwz2ctOHHoizwcFczKNESFE_nsYzE8g3pog@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/display: drop the reduction loop when setting
 the sync groups
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, May 29, 2020 at 9:56 AM Kazlauskas, Nicholas
<nicholas.kazlauskas@amd.com> wrote:
>
> On 2020-05-28 10:06 a.m., Alex Deucher wrote:
> > The logic for blanked is not the same as having a plane_state. Technically
> > you can drive an OTG without anything connected in the front end and it'll
> > just draw out the back color which is distinct from having the OTG be blanked.
> > If we add planes or unblank the OTG later then we'll still want the
> > synchronization.
> >
> > Bug: https://gitlab.freedesktop.org/drm/amd/issues/781
> > Fixes: 5fc0cbfad45648 ("drm/amd/display: determine if a pipe is synced by plane state")
> > Cc: nicholas.kazlauskas@amd.com
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com> > ---
> >   drivers/gpu/drm/amd/display/dc/core/dc.c | 8 --------
> >   1 file changed, 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> > index 04c3d9f7e323..6279520f7873 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> > @@ -1040,14 +1040,6 @@ static void program_timing_sync(
> >                               status->timing_sync_info.master = false;
> >
> >               }
> > -             /* remove any other pipes with plane as they have already been synced */
> > -             for (j = j + 1; j < group_size; j++) {
> > -                     if (pipe_set[j]->plane_state) {
> > -                             group_size--;
> > -                             pipe_set[j] = pipe_set[group_size];
> > -                             j--;
> > -                     }
> > -             }
>
>
> Looking at this again, I think I may understand the issue this was
> trying to work around.
>
> If we try to force timing synchronization on displays that are currently
> active then this is going to force reset the vertical position,
> resulting in screen corruption.
>
> So what this logic was attempting to do was ensure that timing
> synchronization only happens when committing two streams at a time
> without any image on the screen.
>
> Maybe it'd be best to just blank these streams out first, but for now,
> let's actually go back to fixing this by applying the actual dpg/tg
> check that Wenjing suggests, something like:
>
>     if (pool->opps[i]->funcs->dpg_is_blanked)
>                  s.blank_enabled =
> pool->opps[i]->funcs->dpg_is_blanked(pool->opps[i]);
>             else
>                  s.blank_enabled = tg->funcs->is_blanked(tg);
>

Hmm, it's not clear to me where this code needs to go.  Can you point
me in the right direction or provide a quick patch?

Thanks,

Alex

>
>
> The reason why we have this issue in the first place is because
> amdgpu_dm usually commits a dc_state with the planes already in it
> instead of committing them later, so plane_state not being NULL is
> typically true.
>
> Regards,
> Nicholas Kazlauskas
>
> >
> >               if (group_size > 1) {
> >                       dc->hwss.enable_timing_synchronization(
> >
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

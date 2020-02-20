Return-Path: <SRS0=opbO=4I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BCCC11D04
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2020 13:27:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE7B6206E2
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2020 13:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2F20hZ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE7B6206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F9AA6ED7C;
	Thu, 20 Feb 2020 13:27:52 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9067E6ED7C
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2020 13:27:51 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id w15so4629219wru.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2020 05:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LuI6ki+/3ueRYpIMzIwSflgdKa/Tk/eg6DxiQ3KliRA=;
 b=f2F20hZ4AFeIgSjTlg6P50xGF/TyE2WKe06UtWrh+N63xxC9jfcIG7Iw9pLEOUDLLd
 dotnKVyzeSbDD5VwCw8wcI69aVlRyMyYJHpqVCKm8D14Io21S3K7wxUJ2CFAqR+8iDgG
 aBgCS0lT8kq2Xy6CQ9GSvr2EcUy/sJms1ubFgsfJGIyA+Fg2naoXagYZTYV3xaiIPxUb
 KjXusQUtSJfjpqR5q4Z73nB4D6Nwuf4GNwzx3BgyRdmbMQZW9/mPNqvb1ULKJGJcoPd9
 CUdU4Q5ZAqhyS8Vl/h8ogwAkpEKjQTgRQUGZAfkOZo/ULlUvP/aRMSYpNhLxmWpxX3xa
 BONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LuI6ki+/3ueRYpIMzIwSflgdKa/Tk/eg6DxiQ3KliRA=;
 b=JB7iYRYKL/EYpTai6In8j3tVdYXrb9u++NWrf5NI74n8/ytmlaoeWfDb1Aco+Jg84G
 k3H+Mb5rrECctxHwhCL3NF4gXgk2Fl/EAgvk1eBgjTBNfDz7F2Ak8XJbK2ev9pDiO2o8
 Shjw2lU0N+Ez4p6QUVBQOKC70Uw7lQepgf4uq74fnFL3WKChf27xwPUABsVlLbFaL8xc
 n3Aye/WEz5m8p7ezNJbAAWcHt4X13B116R89MgfZTtzMoHnOSS0xyr/tds2u2wLEtnPC
 vio2WD11euyoaqOZ6at77XfEgfL4pNAoekIfjbH2uOZUXSRBRVWlF5kR+4DL5I81d6J5
 0OAw==
X-Gm-Message-State: APjAAAVJ9qi1L98djbZ6nXzgPEBbVkMxvhlxs1Hywc6ubf12qZOdyXFa
 80hRVkJNDkjWRvNik7mRZksv/epD9iT6l4CAp7Yjxg==
X-Google-Smtp-Source: APXvYqyCb36jSTjfuZOv4mgYn5nFw9y91Tke7uOVHmKTV9mWDfUPHzsJX/iKmMpwnWbFnhU6i9ascLjrk5lpZjida2A=
X-Received: by 2002:adf:82c7:: with SMTP id 65mr15824139wrc.374.1582205270148; 
 Thu, 20 Feb 2020 05:27:50 -0800 (PST)
MIME-Version: 1.0
References: <20200110201110.117166-1-alexander.deucher@amd.com>
 <CADnq5_PqWGUjn06jvxXfr=qQa45WJCK1aKgJ-b+VJRkVj9z4Yg@mail.gmail.com>
 <07041392-d18f-821e-4271-c94008818399@amd.com>
In-Reply-To: <07041392-d18f-821e-4271-c94008818399@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 Feb 2020 08:27:39 -0500
Message-ID: <CADnq5_PZTSqWfctAjXwveMwj+5zGwvsPptx+oWUvtjJ3aWRe=Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/display: fix logic inversion in
 program_timing_sync()
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Wenjing Liu <Wenjing.Liu@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Laktyushkin,
 Dmytro" <Dmytro.Laktyushkin@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <hwentlan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Feb 4, 2020 at 9:06 AM Kazlauskas, Nicholas
<nicholas.kazlauskas@amd.com> wrote:
>
> Comments inline.
>
> On 2020-02-03 4:07 p.m., Alex Deucher wrote:
> > Ping?
> >
> > On Fri, Jan 10, 2020 at 3:11 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> >>
> >> It looks like we should be reducing the group size when we don't
> >> have a plane rather than when we do.
> >>
> >> Bug: https://gitlab.freedesktop.org/drm/amd/issues/781
> >> Fixes: 5fc0cbfad45648 ("drm/amd/display: determine if a pipe is synced by plane state")
> >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/display/dc/core/dc.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> >> index 3d89904003f0..01b27726d9c5 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> >> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> >> @@ -1003,9 +1003,9 @@ static void program_timing_sync(
> >>                                  status->timing_sync_info.master = false;
> >>
> >>                  }
> >> -               /* remove any other pipes with plane as they have already been synced */
> >> +               /* remove any other pipes without plane as they have already been synced */
>
> This took a while to wrap my head around but I think I understand what
> this was originally trying to do.
>
> The original logic seems to have been checking for blanked streams and
> trying to remove anything that was blanked from the group to try and
> avoid having to enable timing synchronization.
>
> However, the logic for blanked is *not* the same as having a
> plane_state. Technically you can drive an OTG without anything connected
> in the front end and it'll just draw out the back color - which is
> distinct from having the OTG be blanked.
>
> The problem is really this iteration below:
>
> >>                  for (j = j + 1; j < group_size; j++) {
>
> There could still be pipes in here (depending on the ordering) that have
> planes and could be synchronized with the master OTG. I think starting
> at j + 1 is a mistake for this logic as well.
>
> I wonder if we can just drop this loop altogether. If we add planes or
> unblank the OTG later then we'll still want the synchronization.
>
> Dymtro, Wenjing - feel free to correct my understanding if I'm mistaken
> about this.

Ping?  Any thoughts on this?  It would be nice to get this fixed.

Alex


>
> Regards,
> Nicholas Kazlauskas
>
> >> -                       if (pipe_set[j]->plane_state) {
> >> +                       if (!pipe_set[j]->plane_state) {
> >>                                  group_size--;
> >>                                  pipe_set[j] = pipe_set[group_size];
> >>                                  j--;
> >> --
> >> 2.24.1
> >>
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> >
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

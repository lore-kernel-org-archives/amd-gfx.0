Return-Path: <SRS0=L96E=6S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5073EC3A5A9
	for <amd-gfx@archiver.kernel.org>; Mon,  4 May 2020 07:57:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C4EF206D7
	for <amd-gfx@archiver.kernel.org>; Mon,  4 May 2020 07:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=emersion.fr header.i=@emersion.fr header.b="cVA8gaA0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C4EF206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5CDB892E5;
	Mon,  4 May 2020 07:57:08 +0000 (UTC)
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch
 [185.70.40.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B64E892E5
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 May 2020 07:57:07 +0000 (UTC)
Date: Mon, 04 May 2020 07:57:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1588579025;
 bh=EFmZ4c4r1F/Pk1BmcQTL+yi+TCK37Gom1YNY23jTZ/Q=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=cVA8gaA00WasDsG/v2ev3LyJfzbHq3Pia1Hos7fttS3tsri8rr6hdzoYvJT25qIy4
 QDGmMp+scF7A1/Tx2pTTs8GChxMJvFnGA1i32rpM+oTWJOTFgibV61kKD3P61OIMip
 q3z387ssx8jJjX7aW9H2EB1xrVosYoRshtoUF0MU=
To: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
From: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH] drm/amd/display: add basic atomic check for cursor plane
Message-ID: <hFJlRIqcwDzdxJNP7mVy4w3onBd-gnYtDTKAfyW_F8vv5gj3ZuaQrd7d_2s28dFf0-2mtqceoHCjWnOKiLkniVya9kD2SDwCdkiTvx29PWQ=@emersion.fr>
In-Reply-To: <sH98Y7wEvM1nRrXdNsbASU7_TlNowslY4IBgUL__XkHcsm7Qaqzchb7WQTYotrlQ6JhI1J2jU0iACDF4RLCPdbOTDW-0-uJvjVzp9nbKukU=@emersion.fr>
References: <67AgM0yylniATabNxt8ct_5KATDTAwvscoDJBJxA3cm0vb0LJvyUM9VAX4r6Ib5Vxykoy9AN0G1uyZO8q00_RvTwmaimmGNQ3hZYoWKXZAo=@emersion.fr>
 <83db678a-a5d2-cf64-65f0-8fece62b2fbd@amd.com>
 <7EkixViMkOWZ8AEOpjSPCtfus4Fq2LWBmsk71_0nAC00BVKDIg7iao_0I2PIQp9Z3_jrQ5cglhuYKkq5CQnuLRunzg4pirlkY6hH3At1gww=@emersion.fr>
 <8d67af72-a3c0-65a7-2115-5f068ccbfc23@amd.com>
 <B9sWqLzmtdeSGNQnGEhg8RkGpHRGD0eRxKboCjMgkhR5ZVtLdlEIzoKBWfFnnX0p4Dvl8Chdd68eKpXTtccnAA4a2xeHq2cnHHqg0sv6zGc=@emersion.fr>
 <c35a8999-f46d-f410-729f-249646d1e36c@amd.com>
 <sH98Y7wEvM1nRrXdNsbASU7_TlNowslY4IBgUL__XkHcsm7Qaqzchb7WQTYotrlQ6JhI1J2jU0iACDF4RLCPdbOTDW-0-uJvjVzp9nbKukU=@emersion.fr>
MIME-Version: 1.0
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
Reply-To: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>,
 Roman Gilg <subdiff@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

On Monday, March 30, 2020 5:23 PM, Simon Ser <contact@emersion.fr> wrote:

> On Monday, March 30, 2020 5:18 PM, Kazlauskas, Nicholas nicholas.kazlauskas@amd.com wrote:
>
> > On 2020-03-30 9:13 a.m., Simon Ser wrote:
> >
> > > On Monday, March 30, 2020 3:11 PM, Kazlauskas, Nicholas nicholas.kazlauskas@amd.com wrote:
> > >
> > > > On 2020-03-30 9:02 a.m., Simon Ser wrote:
> > > >
> > > > > On Monday, March 30, 2020 2:59 PM, Kazlauskas, Nicholas nicholas.kazlauskas@amd.com wrote:
> > > > >
> > > > > > We've been doing these checks for position before but I don't think we
> > > > > > really need them. DC should be disabling the cursor when we ask for a
> > > > > > position completely off the screen.
> > > > > > I think that's better than rejecting the commit entirely at least.
> > > > >
> > > > > I agree DC should be disabling the cursor in this case, however that's
> > > > > not yet implemented right? I think implementing this feature is
> > > > > orthogonal and should be done in a separate patch.
> > > > > This patch simply copies over the cursor checks in the atomic check
> > > > > function.
> > > >
> > > > It's implemented on DCN but I don't remember if we're doing it on DCE.
> > > > I guess the drop can be in a separate patch.
> > > >
> > > > Reviewed-by: Nicholas Kazlauskas nicholas.kazlauskas@amd.com
> > >
> > > Thanks for the review. I'll try to figure out whether we can drop this
> > > check (from both the atomic check and the other existing check).
> >
> > Oh, this was actually the checks for crtc_w/crtc_h. Not the x/y, my bad.
> > We probably can't drop this from here, but we can drop it from
> > get_cursor_position after this patch - since it's now in the atomic check.
>
> Hmm, sorry I think I missed something. This patch does copy over the
> x/y checks. We need to keep the w/h checks right?
>
> Yeah, we can probably drop get_cursor_position checks indeed.

Gentle ping: any chance to get this patch merged?

Thanks,

Simon
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

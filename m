Return-Path: <SRS0=N3S+=3L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB7DC2D0DB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 16:23:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E73EB217F4
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 16:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJeo1rWT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E73EB217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABF3C6F5D8;
	Wed, 22 Jan 2020 16:23:20 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 227D76F5D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2020 16:23:20 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id c9so7947286wrw.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2020 08:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SBFUlPMSEW3UWXaS26ANamyMGefkQqJrVgo6zzK+IEY=;
 b=TJeo1rWTCwdCz8AHCdePXt+zXnje6oyh7LARrOA12syyJoo3/Uno3m2xAfqp8fZiDG
 gE+Agx3cUO4lb13kiSMdbqZCWyN1v3UvZjilNM8MiSrrx1NWNRotgJDKoDhuWAEIGz5x
 C1mzLSAa3oUGD7JPn/Z2s1R3XDKErCiW9v+lUqvI6ogMGuk2h8JOu/x8BFDeFzSwHkPx
 +CCm+IO9Oy7CJtmI/DMOnlWA4ymP4+UQ0UGOLm7mOMlInMTrVaeG1BiPS27CyQxvXjz4
 uhDLn5BzIDPmEV73r8IuewV14P1tE/atpDoEo87CiTetTN0wkgki+Dj46iM1ORUMhmP7
 jKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SBFUlPMSEW3UWXaS26ANamyMGefkQqJrVgo6zzK+IEY=;
 b=fL/gQulmmoPhSCM0a6ID3Fd73Xtc4fHM9W96VszYBk36SW7Y+Vq0Ka0EuJf0LzVb7l
 ITFPSP9xvILg/EZGk0i7pLuUzCllRcQlK30sOezaHdECH9+Jfq3Hy9qHMM6kmQa8OIMT
 +QN3PfYQKtFOxg3SMONDct5QNWW2t+BHZOZL8MkkId2rz1n3siLIcjPw5QHLFNoWTmyG
 g7m0olJC9B5stv87wKcTnLsz5D+nhxtksng1D9T3oDcrt4LCmtETO/s4vcAlaNV3F2nu
 9UTc+HiqihnmMVCIDUh8IZsRnP04vzP6Ps3hNvPvgU8L2Cy7doHM8IMSlJ68mdk1ngSD
 rQTg==
X-Gm-Message-State: APjAAAXcboGE0WknQ7JnziUwvR+MDIxJEj+dbZIfj1w97jNnS/kHAT0M
 Gd9vzx0wX94zWQC/xiiBApGBD36qVmGsBPpxNTY=
X-Google-Smtp-Source: APXvYqwx177C+g8H3WYwYXdAkAcmZeOgb+oPj5Lfl6/IXe1QkN0BOpZTMabAlY2jgejTqFhQF2zfrSTHpLkZv+sqXkY=
X-Received: by 2002:adf:ec4c:: with SMTP id w12mr12630572wrn.124.1579710198709; 
 Wed, 22 Jan 2020 08:23:18 -0800 (PST)
MIME-Version: 1.0
References: <20200116202945.21801-1-Bhawanpreet.Lakha@amd.com>
 <55a3fd2d-c2ed-4af0-543e-9850118b722a@amd.com>
In-Reply-To: <55a3fd2d-c2ed-4af0-543e-9850118b722a@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 22 Jan 2020 11:23:07 -0500
Message-ID: <CADnq5_NO49aT6eSDywE20h6XZSF_D4WvCyQo30cXwRMvU1YmoA@mail.gmail.com>
Subject: Re: [PATCH 0/5] HDCP SRM interface
To: Harry Wentland <hwentlan@amd.com>
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
Cc: "Wentland, Harry" <harry.wentland@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 22, 2020 at 11:12 AM Harry Wentland <hwentlan@amd.com> wrote:
>
> On 2020-01-16 3:29 p.m., Bhawanpreet Lakha wrote:
> > These patches adds support for SRM loading. By providing an interface to the
> > usermode
> >
> > SRM has to be persistent and since the kernel cannot directly write to system
> > storage we need to provide an interface so that the usermode can do it for us
> >
>
> We'll want to elaborate a bit more on why and how this is done. As
> mentioned on my patch 2 comments I recommend to do this there as the
> cover letter is lost after merge.
>

You might also want to cc dri-devel if you resend to get more reviews.
I'm also not crazy about having to update the file in chunks, but I
don't have any better ideas off hand.  Maybe an ioctl would be
cleaner?

Alex

> Harry
>
> >
> > Bhawanpreet Lakha (5):
> >   drm/amd/display: Pass amdgpu_device instead of psp_context
> >   drm/amd/display: update psp interface header
> >   drm/amd/display: Add sysfs interface for set/get srm
> >   drm/amd/display: Load srm before enabling HDCP
> >   drm/amd/display: call psp set/get interfaces
> >
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   2 +-
> >  .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    | 182 +++++++++++++++++-
> >  .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.h    |   9 +-
> >  .../drm/amd/display/modules/hdcp/hdcp_psp.h   |  26 ++-
> >  4 files changed, 212 insertions(+), 7 deletions(-)
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

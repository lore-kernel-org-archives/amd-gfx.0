Return-Path: <SRS0=QzDn=C2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C070C433E2
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 11:36:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 312B120663
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 11:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="BSZuP13J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 312B120663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFAB36E13B;
	Thu, 17 Sep 2020 11:36:56 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4ED36EA61
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2020 11:36:55 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id l15so4254626wmh.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2020 04:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:in-reply-to;
 bh=s7q5YyahCsObhi1zWedFvl1JKG52ECokbcXLRCoQrnU=;
 b=BSZuP13J+0n/zOaiLWS+1EpxuK5QgJRgMWqNV7UAsp+rWkUNS/+anNgHvQ0MFvNquD
 aU+XG9mfjBVfTpF+eOh8bdrnogFq0s1yoFXWfhVZtEiv3m9aiGnQY3AxWqu9mrW+ygi3
 2SziRqVBpZLj0IUwsZgb5wbvBb/7+Fb+hL6K8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=s7q5YyahCsObhi1zWedFvl1JKG52ECokbcXLRCoQrnU=;
 b=GmZ3UxvUfDIJ75OvjjK6ciVQ4lQ7kpj6x2uGRBR3JE2JcvSMnL5IzhTizCucitNqlD
 UBzd/+ob0kQpLJGczosjC1eaBqK1GeHre0xVtKDTCYRHlUauR2SnZiozNbe/+CT7heEn
 uHTWgFkU0mJkELTevqouPfNvmpbIs8TcvJnZ5gGx+1ft0t0Udg3FfSnzljTdjivFNPcM
 iSMAukGLSn/DPRF7SILCg/ScfRWTksqGY4YvBQlmHljPEghRuS2hoWugMgcoEnq27RYa
 PqPXnnBen80lpVWedD5MVkAqIri30Ve95ahyqE//5V2BBD8QB7t/ibO3tOvucMTQNg/y
 FPrw==
X-Gm-Message-State: AOAM531T/glXJwOJakAF1VgRpps6kkHiR6+nbYw7FcJ6mNYRxRPQb3As
 ELqK3kiog3h2Kb4Vgar5aH9m1g==
X-Google-Smtp-Source: ABdhPJzio+ECTKt+6EiLIp8tan8dQZTPez2BTgYYJ9I1xWYcE+zdkW/f/TxSUpd8ooY7OlqcAdOLJQ==
X-Received: by 2002:a1c:2441:: with SMTP id k62mr9508146wmk.178.1600342614380; 
 Thu, 17 Sep 2020 04:36:54 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id l19sm10482326wmi.8.2020.09.17.04.36.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 04:36:53 -0700 (PDT)
Date: Thu, 17 Sep 2020 13:36:51 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Subject: Re: [PATCH v2 0/4] Enlarge tracepoints in the display component
Message-ID: <20200917113651.GT438822@phenom.ffwll.local>
Mail-Followup-To: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, hersenxs.wu@amd.com
References: <20200911145927.401322-1-Rodrigo.Siqueira@amd.com>
 <20200916091214.GY438822@phenom.ffwll.local>
 <e05be8ec-e73b-7fd6-efca-4a360e9ebb57@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e05be8ec-e73b-7fd6-efca-4a360e9ebb57@amd.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
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
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 David Airlie <airlied@linux.ie>, hersenxs.wu@amd.com,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Sep 16, 2020 at 11:27:27AM -0400, Kazlauskas, Nicholas wrote:
> On 2020-09-16 5:12 a.m., Daniel Vetter wrote:
> > On Fri, Sep 11, 2020 at 10:59:23AM -0400, Rodrigo Siqueira wrote:
> > > Debug issues related to display can be a challenge due to the complexity
> > > around this topic and different source of information might help in this
> > > process. We already have support for tracepoints inside the display
> > > component, i.e., we have the basic functionalities available and we just
> > > need to expand it in order to make it more valuable for debugging. For
> > > this reason, this patchset reworks part of the current tracepoint
> > > options and add different sets of tracing inside amdgpu_dm, display
> > > core, and DCN10. The first patch of this series just rework part of the
> > > current tracepoints and the last set of patches introduces new
> > > tracepoints.
> > > 
> > > This first patchset version is functional. Please, let me know what I
> > > can improve in the current version but also let me know what kind of
> > > tracepoint I can add for the next version.
> > > 
> > > Finally, I want to highlight that this work is based on a set of patches
> > > originally made by Nicholas Kazlauskas.
> > > 
> > > Change in V2:
> > > - I added another patch for capturing the clock state for different display
> > >    architecture.
> > 
> > Hm I'm not super sure tracepoints for state dumping are the right thing
> > here. We kinda have the atomic state dumping code with all the various
> > callbacks, and you can extend that pretty easily. Gives you full state
> > dump in debugfs, plus a few function to dump into dmesg.
> > 
> > Maybe what we need is a function to dump this also into printk tracepoint
> > (otoh with Sean Paul's tracepoint work we'd get that through the dmesg
> > stuff already), and then you could do it there?
> > 
> > Upside is that for customers they'd get a much more consistent way to
> > debug display issues across different drivers.
> > 
> > For low-level hw debug what we do is give the hw guys an mmio trace, and
> > they replay it on the fancy boxes :-) So for that I think this here is
> > again too high level, but maybe what you have is a bit different.
> > -Daniel
> 
> We have raw register traces, but what I find most useful is to be able to
> see are the incoming DRM IOCTLs, objects and properties per commit.
> 
> Many of the bugs we see in display code is in the conversion from DRM -> DM
> -> DC state. The current HW state is kind of useless in most cases, but the
> sequence helps track down intermittent problems and understand state
> transitions.
> 
> Tracepoints provide everything I really need to be able to track down these
> problems without falling back to a full debugger. The existing DRM prints
> (even at high logging levels) aren't enough to understand what's going on in
> most cases in our driver so funneling those into tracepoints to improve perf
> doesn't really help that much.
> 
> I think this kind of idea was rejected for DRM core last year with Sean's
> patch series but if we can't get them into core then I'd like to get them
> into our driver at least. These are a cleaned up version of Sean's work + my
> work that I end up applying locally whenever I debug something.

Nah, Sean's series wasn't rejected. It's simply stuck waiting for review.
So if your goal is to get better dumping going on, I think combining this
with Sean's work (and getting that reviewed), plus then tapping into the
atomic state dumping code. Then you know what was requested, plus what your
atomic_check code computed should be the hw state, and you can compare
that with the register dumps you already grab.

Feels at least like a more complete and flexible solution than ad-hoc
tracepoints for debuggin in each driver. The idea behind Sean's work is
also that we'd have a blackbox recorder for any drm issues which distros
in the field could use. So driver doing their own debug output doesn't
sound super great.

I think Siqueira already chatted a bit with Sean.
-Daniel

> 

> Regards,
> Nicholas Kazlauskas
> 
> > 
> > > 
> > > Rodrigo Siqueira (4):
> > >    drm/amd/display: Rework registers tracepoint
> > >    drm/amd/display: Add tracepoint for amdgpu_dm
> > >    drm/amd/display: Add pipe_state tracepoint
> > >    drm/amd/display: Add tracepoint for capturing clocks state
> > > 
> > >   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  17 +
> > >   .../amd/display/amdgpu_dm/amdgpu_dm_trace.h   | 712 +++++++++++++++++-
> > >   .../dc/clk_mgr/dce112/dce112_clk_mgr.c        |   5 +
> > >   .../display/dc/clk_mgr/dcn10/rv1_clk_mgr.c    |   4 +
> > >   .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |   4 +
> > >   .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |   4 +
> > >   .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |   4 +
> > >   drivers/gpu/drm/amd/display/dc/core/dc.c      |  11 +
> > >   .../gpu/drm/amd/display/dc/dce/dce_clk_mgr.c  |   5 +
> > >   .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  17 +-
> > >   10 files changed, 747 insertions(+), 36 deletions(-)
> > > 
> > > -- 
> > > 2.28.0
> > > 
> > 
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

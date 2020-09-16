Return-Path: <SRS0=J3+H=CZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E801C43461
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 09:12:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F02512087D
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 09:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="PkhW6vEw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F02512087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C3A46E049;
	Wed, 16 Sep 2020 09:12:19 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 796AD6E049
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 09:12:18 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id e16so6107545wrm.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 02:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:in-reply-to;
 bh=f19XFVFhs+2jghuOyfimjgCuw4YzF9zPieCgRuEe8b8=;
 b=PkhW6vEwle8dhNbpmv1kW2QjiP61XHg9Idh+eMJddLaNuAOf3RVE+ioKr7StU2fcCC
 45ssKzJ/9DZCdCCXh5zTPN+5fCxuSSuFTAfQK7moUy/DHGfZ+s6gslor6cPl3Ik4m7tT
 4Mjhr/ucczSrZv73PtIVK7Ny7uVlTlr8DdpVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=f19XFVFhs+2jghuOyfimjgCuw4YzF9zPieCgRuEe8b8=;
 b=o2Aog74jpMilNYH67qrOkZKFGc/ccC+5WrhTmYIEmEHKiIBc23qmntfrtZnpH4R649
 BcJhlkQPHAoTofD08/UTUa0kPC7U4pvxFoTrHKYOuQd3ROElV6wL/9hMtAzMkJ+3ekUA
 DCbR9oPGoQUn1WdUQn6iG2VpjJkqjz98ThjU0XvmsFrc+mKtPTLEoo7K2xDpjalJxR9B
 SnmJGwUrZsQd+hbQcooQ2YMgfe4VN9C8e7VLmKPD5P7W1xWk0MYwHJtBGAmIyoiFoF4S
 cANThyfsa82y4ZVn8rPzuw6UGA85ljZyt9Wq1b7qQluk9VFnxlLmvF12vWVxwBtnZkSH
 s1FQ==
X-Gm-Message-State: AOAM533ADN80r9QZfzRH+VqLLGhzHIyRXBoNhqku2mCw8yCiECWpTETQ
 cf2XOBM4M/Onn7lR9SbeIQx9FA==
X-Google-Smtp-Source: ABdhPJwYoeHhQRyZtS+oxtMM4dznniKImx/L732tMFcxNrkUkBK0PwZcwnU2qPqi3QiQ/p2MSI8OzQ==
X-Received: by 2002:adf:ef45:: with SMTP id c5mr24819646wrp.37.1600247537116; 
 Wed, 16 Sep 2020 02:12:17 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id n4sm31207972wrp.61.2020.09.16.02.12.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 02:12:16 -0700 (PDT)
Date: Wed, 16 Sep 2020 11:12:14 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Subject: Re: [PATCH v2 0/4] Enlarge tracepoints in the display component
Message-ID: <20200916091214.GY438822@phenom.ffwll.local>
Mail-Followup-To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 hersenxs.wu@amd.com
References: <20200911145927.401322-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200911145927.401322-1-Rodrigo.Siqueira@amd.com>
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
Cc: Leo Li <sunpeng.li@amd.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 David Airlie <airlied@linux.ie>, hersenxs.wu@amd.com,
 amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Sep 11, 2020 at 10:59:23AM -0400, Rodrigo Siqueira wrote:
> Debug issues related to display can be a challenge due to the complexity
> around this topic and different source of information might help in this
> process. We already have support for tracepoints inside the display
> component, i.e., we have the basic functionalities available and we just
> need to expand it in order to make it more valuable for debugging. For
> this reason, this patchset reworks part of the current tracepoint
> options and add different sets of tracing inside amdgpu_dm, display
> core, and DCN10. The first patch of this series just rework part of the
> current tracepoints and the last set of patches introduces new
> tracepoints.
> 
> This first patchset version is functional. Please, let me know what I
> can improve in the current version but also let me know what kind of
> tracepoint I can add for the next version. 
> 
> Finally, I want to highlight that this work is based on a set of patches
> originally made by Nicholas Kazlauskas.
> 
> Change in V2:
> - I added another patch for capturing the clock state for different display
>   architecture.

Hm I'm not super sure tracepoints for state dumping are the right thing
here. We kinda have the atomic state dumping code with all the various
callbacks, and you can extend that pretty easily. Gives you full state
dump in debugfs, plus a few function to dump into dmesg.

Maybe what we need is a function to dump this also into printk tracepoint
(otoh with Sean Paul's tracepoint work we'd get that through the dmesg
stuff already), and then you could do it there?

Upside is that for customers they'd get a much more consistent way to
debug display issues across different drivers.

For low-level hw debug what we do is give the hw guys an mmio trace, and
they replay it on the fancy boxes :-) So for that I think this here is
again too high level, but maybe what you have is a bit different.
-Daniel

> 
> Rodrigo Siqueira (4):
>   drm/amd/display: Rework registers tracepoint
>   drm/amd/display: Add tracepoint for amdgpu_dm
>   drm/amd/display: Add pipe_state tracepoint
>   drm/amd/display: Add tracepoint for capturing clocks state
> 
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  17 +
>  .../amd/display/amdgpu_dm/amdgpu_dm_trace.h   | 712 +++++++++++++++++-
>  .../dc/clk_mgr/dce112/dce112_clk_mgr.c        |   5 +
>  .../display/dc/clk_mgr/dcn10/rv1_clk_mgr.c    |   4 +
>  .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |   4 +
>  .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |   4 +
>  .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |   4 +
>  drivers/gpu/drm/amd/display/dc/core/dc.c      |  11 +
>  .../gpu/drm/amd/display/dc/dce/dce_clk_mgr.c  |   5 +
>  .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  17 +-
>  10 files changed, 747 insertions(+), 36 deletions(-)
> 
> -- 
> 2.28.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

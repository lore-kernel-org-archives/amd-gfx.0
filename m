Return-Path: <SRS0=Gn/P=56=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C34BC2BBC7
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 12:20:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A4FC20768
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 12:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="C5ErIHkC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A4FC20768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDDED6E053;
	Tue, 14 Apr 2020 12:20:19 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85F796E053
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2020 12:20:19 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id g12so5852309wmh.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2020 05:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=AVWsXI3MqWUjHSFF7fJc9dwzNvhf7xe+RbgEyfrAzNQ=;
 b=C5ErIHkCVZ6bwX/7a4Q98OMFyyzYOVUtlEGm/S86pHsNjUxpLifmMl0gwrR9FVv/eg
 DBy+1TWPtHW1UjmLp8i/0VBZqa61Ni68+/dmh6VPBNHlS0sr9ckMI+AXPa6Orp5wBgNR
 iuLNwnQ+2b6+dhu+W1zMJqdXAMgvSKHGlrWzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=AVWsXI3MqWUjHSFF7fJc9dwzNvhf7xe+RbgEyfrAzNQ=;
 b=k4CUS/Y5jycDvAG0kR+IqiArYABKbIEHVXkUXZINiLrrIiZJCD0JnPj+6MwPFYcjL8
 DyoUeGmm7/zqVCAznOrNpBu2SmVujgwFC69j7HgFqNdkukVMMIMy/KaoYBPcLuH32Xy3
 QWFKk8r3W61dV85ultID9qSBJEpTP6fqJBDVNdFSKpYCRRvZMb3t3Jods2DA6jXFvP7z
 fRpKbdNmsBCFUwztByHO0bDYWTQSjHmpxTFhZfW3jI2CqcVk6frLcxaebs5pcJo/U+Ax
 m3QxyHpQ0vlPsYMCar3I83XXPMQ75QpH6K+IHCJEfo5yDReO7xdKEwPZMwawD/+5eNkH
 LRbw==
X-Gm-Message-State: AGi0PuYJDxnjU7wyggjOEgHkHw/ijrdge1WlrsrFfme2HIBXtGIAn4zy
 xq8sT8w8IOr540gWzgIIG2WIjQ==
X-Google-Smtp-Source: APiQypLZMCXaWWcTpMokkYNn95QhGP8sokJ6ulB8VlThRzbMX0X+dbheLMI86kMWkSLw/6e6Ru2zvQ==
X-Received: by 2002:a1c:3985:: with SMTP id
 g127mr23823629wma.102.1586866818129; 
 Tue, 14 Apr 2020 05:20:18 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id w11sm18000879wmi.32.2020.04.14.05.20.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 05:20:17 -0700 (PDT)
Date: Tue, 14 Apr 2020 14:20:15 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 00/11] new cgroup controller for gpu/drm subsystem
Message-ID: <20200414122015.GR3456981@phenom.ffwll.local>
References: <20200226190152.16131-1-Kenny.Ho@amd.com>
 <CAOWid-eyMGZfOyfEQikwCmPnKxx6MnTm17pBvPeNpgKWi0xN-w@mail.gmail.com>
 <20200324184633.GH162390@mtj.duckdns.org>
 <CAOWid-cS-5YkFBLACotkZZCH0RSjHH94_r3VFH8vEPOubzSpPA@mail.gmail.com>
 <20200413191136.GI60335@mtj.duckdns.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200413191136.GI60335@mtj.duckdns.org>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
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
Cc: Kenny Ho <Kenny.Ho@amd.com>, "Kuehling, Felix" <felix.kuehling@amd.com>,
 jsparks@cray.com, dri-devel <dri-devel@lists.freedesktop.org>,
 Kenny Ho <y2kenny@gmail.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "Greathouse, Joseph" <joseph.greathouse@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, cgroups@vger.kernel.org,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Apr 13, 2020 at 03:11:36PM -0400, Tejun Heo wrote:
> Hello, Kenny.
> 
> On Tue, Mar 24, 2020 at 02:49:27PM -0400, Kenny Ho wrote:
> > Can you elaborate more on what are the missing pieces?
> 
> Sorry about the long delay, but I think we've been going in circles for quite
> a while now. Let's try to make it really simple as the first step. How about
> something like the following?
> 
> * gpu.weight (should it be gpu.compute.weight? idk) - A single number
>   per-device weight similar to io.weight, which distributes computation
>   resources in work-conserving way.
> 
> * gpu.memory.high - A single number per-device on-device memory limit.
> 
> The above two, if works well, should already be plenty useful. And my guess is
> that getting the above working well will be plenty challenging already even
> though it's already excluding work-conserving memory distribution. So, let's
> please do that as the first step and see what more would be needed from there.

This agrees with my understanding of the consensus here and what's
reasonable possible across different gpus. And in case this isn't clear:
This is very much me talking with my drm co-maintainer hat on, not with a
gpu vendor hat on (since that's implied somewhere further down the
discussion). My understanding from talking with a few other folks is that
the cpumask-style CU-weight thing is not something any other gpu can
reasonably support (and we have about 6+ of those in-tree), whereas some
work-preserving computation resource thing should be doable for anyone
with a scheduler. +/- more or less the same issues as io devices, there
might be quite bit latencies involved from going from one client to the
other because gpu pipelines are deed and pre-emption for gpus rather slow.
And ofc not all gpu "requests" use equal amounts of resources (different
engines and stuff just to begin with), same way not all io requests are
made equal. Plus since we do have a shared scheduler used by at least most
drivers, this shouldn't be too hard to get done somewhat consistently
across drivers

tldr; Acked by me.

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

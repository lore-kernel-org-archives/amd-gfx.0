Return-Path: <SRS0=chDG=IV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB23C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 13:15:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76FDF61990
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 13:15:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76FDF61990
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D77E6E8F7;
	Tue, 23 Mar 2021 13:15:10 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A80E06E857
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Mar 2021 13:15:08 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id j7so20747136wrd.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Mar 2021 06:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to; bh=8lz3lDk13H1M2ymaJV1txo9yAd3G66LPnXWxpBCwGC8=;
 b=aqwQ8INpvvw/8hSSkL2yFRZQ/5FKsb6N4k2DX49lCIQ7IkwfhQ7opbL1FYgSNm4a8B
 S7YvGusAzEdOzzRp3SmT8OZOlMWx4SL/1wVo3TtykDDS++Hlrjq1Mx0aaJAvVL9RDLM9
 kLL/vnRw36iDcw7oNf1ZsIY0Bso+i0dOBhhtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to;
 bh=8lz3lDk13H1M2ymaJV1txo9yAd3G66LPnXWxpBCwGC8=;
 b=o58XFHIhcAmd5VCakCf3ZbXzrXrXPIwoOq2ykCQpfZ2eAFPaJCUdNoyeSfd+wkwdxq
 +RLMyx7Pq2/Y+cuTv0xJjMb4+IaEuZ8QAeMDbfily7JLoU2S2kW32NKlxOCZQkUTMtIS
 9ZGRqF8clAQ5mfW6nCRiU+UQVOEAX+R1A1PupTHpj/Mj3CfyEEuxqgj/yoGN6tJWTGws
 YoLscXTvYeJgsTBB3Mp1vDno4GynBox32qLHVFvAkGdUbJmmyrwlPEnM4KpOd189WXx5
 vFJ3uf5zC8l7QbCpgNtI50mPyeifQGdXp2jZV1WZZlTrrMQGWe0H5KZbWT+RQ+8dJ6RW
 KIfw==
X-Gm-Message-State: AOAM530QIl+rPBkHD7CpTdE+V3cgyH8y71GuGgE3gqmqPM25yigSs8aA
 egOL9bMqpPbCo52gAA5fE+ur9Q==
X-Google-Smtp-Source: ABdhPJywDfPOd6wXKDUxUiwLpU18IcUiEdVHqY4oHohRVLm0NQywzWa+WVQFgaVsa9S9fs5+ie+RYQ==
X-Received: by 2002:adf:ec46:: with SMTP id w6mr3894009wrn.213.1616505307255; 
 Tue, 23 Mar 2021 06:15:07 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id s83sm2704385wms.16.2021.03.23.06.15.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Mar 2021 06:15:06 -0700 (PDT)
Date: Tue, 23 Mar 2021 14:15:05 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] drm/ttm: stop warning on TT shrinker failure
Message-ID: <YFnp2e2jGrtM7iGx@phenom.ffwll.local>
Mail-Followup-To: Michal Hocko <mhocko@suse.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Matthew Wilcox <willy@infradead.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Linux MM <linux-mm@kvack.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Dave Chinner <dchinner@redhat.com>, Leo Liu <Leo.Liu@amd.com>
References: <e6e9df3e-cd2b-d80f-205d-6ca1865819b2@gmail.com>
 <YFigZ5+H95c/GI/S@phenom.ffwll.local>
 <20210322140548.GN1719932@casper.infradead.org>
 <YFi+UROYbQERYEEr@dhcp22.suse.cz>
 <CAKMK7uGM6EJvzktrANyeeemRPoW7O0ka-ZyKi==wL1zt3yM=5w@mail.gmail.com>
 <c78457bb-d93a-ff84-1cce-0fb3fa9f0cec@gmail.com>
 <YFma+ZxncvfBd++o@dhcp22.suse.cz>
 <YFnQ1Lk6BTo8L7pr@phenom.ffwll.local>
 <cd17d2ca-140e-1e69-37ac-c2726cc1ef9f@gmail.com>
 <YFnZMzs2wYGWqowi@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YFnZMzs2wYGWqowi@dhcp22.suse.cz>
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
Cc: Matthew Wilcox <willy@infradead.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 dri-devel <dri-devel@lists.freedesktop.org>, Linux MM <linux-mm@kvack.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Dave Chinner <dchinner@redhat.com>, Leo Liu <Leo.Liu@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Mar 23, 2021 at 01:04:03PM +0100, Michal Hocko wrote:
> On Tue 23-03-21 12:48:58, Christian K=F6nig wrote:
> > Am 23.03.21 um 12:28 schrieb Daniel Vetter:
> > > On Tue, Mar 23, 2021 at 08:38:33AM +0100, Michal Hocko wrote:
> > > > I think this is where I don't get yet what Christian tries to do: We
> > > > really shouldn't do different tricks and calling contexts between d=
irect
> > > > reclaim and kswapd reclaim. Otherwise very hard to track down bugs =
are
> > > > pretty much guaranteed. So whether we use explicit gfp flags or the
> > > > context apis, result is exactly the same.
> > =

> > Ok let us recap what TTMs TT shrinker does here:
> > =

> > 1. We got memory which is not swapable because it might be accessed by =
the
> > GPU at any time.
> > 2. Make sure the memory is not accessed by the GPU and driver need to g=
rab a
> > lock before they can make it accessible again.
> > 3. Allocate a shmem file and copy over the not swapable pages.
> =

> This is quite tricky because the shrinker operates in the PF_MEMALLOC
> context so such an allocation would be allowed to completely deplete
> memory unless you explicitly mark that context as __GFP_NOMEMALLOC. Also
> note that if the allocation cannot succeed it will not trigger reclaim
> again because you are already called from the reclaim context.

[Limiting to that discussion]

Yes it's not emulating real (direct) reclaim correctly, but ime the
biggest issue with direct reclaim is when you do mutex_lock instead of
mutex_trylock or in general block on stuff that you cant. And lockdep +
fs_reclaim annotations gets us that, so pretty good to make sure our
shrinker is correct.

Actual tuning of it and making sure it's not doing silly things is ofc a
different thing, and for that we can't test it in isolation. But it's good
to know that before you tune it, you have rather high confidence it's
at least correct. And for that not running with PF_MEMALLOC is actually
good, since it means more allocation failures, so more testing of those
error/backoff paths in the code.
-Daniel
-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

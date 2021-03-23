Return-Path: <SRS0=chDG=IV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52892C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 15:16:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F94E619B2
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 15:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F94E619B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6C826E946;
	Tue, 23 Mar 2021 15:16:14 +0000 (UTC)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 460E86E8DC;
 Tue, 23 Mar 2021 15:13:19 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1616512398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bzkya0dHCxiB5h1H9zH+lPfJ4WKvuf8IG2LAwE/cVeI=;
 b=shZ/fjMC266O/92AWCMJ+Gn6FWU17pZY+cqZVDU1jENzh+S33tC0xvpy9jV8NvzGQeDG2V
 wFykMuansupGsfyuF0vCtUuKzr34+ybgWQGqmWEUt/2DUUDc+wJVuNBSTXwlRr87MV4CTN
 /LAlN7wbXD6FSzqPxccOrV3F/9wJBw8=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id D8125ACBF;
 Tue, 23 Mar 2021 15:13:17 +0000 (UTC)
Date: Tue, 23 Mar 2021 16:13:12 +0100
From: Michal Hocko <mhocko@suse.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH] drm/ttm: stop warning on TT shrinker failure
Message-ID: <YFoFdOtYDAezpSLv@dhcp22.suse.cz>
References: <c78457bb-d93a-ff84-1cce-0fb3fa9f0cec@gmail.com>
 <YFma+ZxncvfBd++o@dhcp22.suse.cz>
 <YFnQ1Lk6BTo8L7pr@phenom.ffwll.local>
 <cd17d2ca-140e-1e69-37ac-c2726cc1ef9f@gmail.com>
 <YFnZMzs2wYGWqowi@dhcp22.suse.cz>
 <75ff80c5-a054-d13d-85c1-0040addb45d2@gmail.com>
 <YFng9qXM3NdrGHTx@dhcp22.suse.cz>
 <20808d08-b66c-13c3-f672-ebce216b2fa2@gmail.com>
 <YFnwBTF0YntCXFeG@dhcp22.suse.cz>
 <e5659cd0-61b2-82bd-64c3-76bd631b4522@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e5659cd0-61b2-82bd-64c3-76bd631b4522@amd.com>
X-Mailman-Approved-At: Tue, 23 Mar 2021 15:16:14 +0000
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
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Linux MM <linux-mm@kvack.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Dave Chinner <dchinner@redhat.com>, Leo Liu <Leo.Liu@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue 23-03-21 14:56:54, Christian K=F6nig wrote:
> Am 23.03.21 um 14:41 schrieb Michal Hocko:
[...]
> > Anyway, I am wondering whether the overall approach is sound. Why don't
> > you simply use shmem as your backing storage from the beginning and pin
> > those pages if they are used by the device?
> =

> Yeah, that is exactly what the Intel guys are doing for their integrated
> GPUs :)
> =

> Problem is for TTM I need to be able to handle dGPUs and those have all
> kinds of funny allocation restrictions. In other words I need to guarantee
> that the allocated memory is coherent accessible to the GPU without using
> SWIOTLB.
> =

> The simple case is that the device can only do DMA32, but you also got
> device which can only do 40bits or 48bits.
> =

> On top of that you also got AGP, CMA and stuff like CPU cache behavior
> changes (write back vs. write through, vs. uncached).

OK, so the underlying problem seems to be that gfp mask (thus
mapping_gfp_mask) cannot really reflect your requirements, right?  Would
it help if shmem would allow to provide an allocation callback to
override alloc_page_vma which is used currently? I am pretty sure there
will be more to handle but going through shmem for the whole life time
is just so much easier to reason about than some tricks to abuse shmem
just for the swapout path.
-- =

Michal Hocko
SUSE Labs
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

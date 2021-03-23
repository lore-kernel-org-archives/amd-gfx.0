Return-Path: <SRS0=chDG=IV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F4CC433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 14:19:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AF6C61984
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 14:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AF6C61984
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA98A6E8F4;
	Tue, 23 Mar 2021 14:19:20 +0000 (UTC)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA4E96E89E;
 Tue, 23 Mar 2021 13:41:27 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1616506886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jLqUV/x83VgJArwy57QD4v3/kYs9jmrwN2mTyLJZqGU=;
 b=nK8OvYnkNJTxj+8Qed1aBjuRTw7oxkGF/a9W4tklR3nBzO+9uQ7ACIGumAnZ1OV6mbeUdN
 OH+Y5KuO67XlyW7yff4mHHgn2xLlOyNC8gQWP2mR4zsnV6Rgf7LlQ++7mXDG0YQg2RHvs3
 qEI/Zktl7AaYtlds9quiO+DSDpreJp8=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 764F9ACBF;
 Tue, 23 Mar 2021 13:41:26 +0000 (UTC)
Date: Tue, 23 Mar 2021 14:41:25 +0100
From: Michal Hocko <mhocko@suse.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH] drm/ttm: stop warning on TT shrinker failure
Message-ID: <YFnwBTF0YntCXFeG@dhcp22.suse.cz>
References: <YFi+UROYbQERYEEr@dhcp22.suse.cz>
 <CAKMK7uGM6EJvzktrANyeeemRPoW7O0ka-ZyKi==wL1zt3yM=5w@mail.gmail.com>
 <c78457bb-d93a-ff84-1cce-0fb3fa9f0cec@gmail.com>
 <YFma+ZxncvfBd++o@dhcp22.suse.cz>
 <YFnQ1Lk6BTo8L7pr@phenom.ffwll.local>
 <cd17d2ca-140e-1e69-37ac-c2726cc1ef9f@gmail.com>
 <YFnZMzs2wYGWqowi@dhcp22.suse.cz>
 <75ff80c5-a054-d13d-85c1-0040addb45d2@gmail.com>
 <YFng9qXM3NdrGHTx@dhcp22.suse.cz>
 <20808d08-b66c-13c3-f672-ebce216b2fa2@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20808d08-b66c-13c3-f672-ebce216b2fa2@gmail.com>
X-Mailman-Approved-At: Tue, 23 Mar 2021 14:19:19 +0000
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

On Tue 23-03-21 14:06:25, Christian K=F6nig wrote:
> Am 23.03.21 um 13:37 schrieb Michal Hocko:
> > On Tue 23-03-21 13:21:32, Christian K=F6nig wrote:
[...]
> > > Ideally I would like to be able to trigger swapping out the shmem pag=
e I
> > > allocated immediately after doing the copy.
> > So let me try to rephrase to make sure I understand. You would like to
> > swap out the existing content from the shrinker and you use shmem as a
> > way to achieve that. The swapout should happen at the time of copying
> > (shrinker context) or shortly afterwards?
> > =

> > So effectively to call pageout() on the shmem page after the copy?
> =

> Yes, exactly that.

OK, good. I see what you are trying to achieve now. I do not think we
would want to allow pageout from the shrinker's context but what you can
do is to instantiate the shmem page into the tail of the inactive list
so the next reclaim attempt will swap it out (assuming swap is available
of course).

This is not really something that our existing infrastructure gives you
though, I am afraid. There is no way to tell a newly allocated shmem
page should be in fact cold and the first one to swap out. But there are
people more familiar with shmem and its pecularities so I might be wrong
here.

Anyway, I am wondering whether the overall approach is sound. Why don't
you simply use shmem as your backing storage from the beginning and pin
those pages if they are used by the device?

-- =

Michal Hocko
SUSE Labs
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

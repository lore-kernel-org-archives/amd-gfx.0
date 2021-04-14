Return-Path: <SRS0=h6PS=JL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B40BC433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 10:26:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 988CB613C3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 10:26:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 988CB613C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E20926E918;
	Wed, 14 Apr 2021 10:26:14 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C6EB6E918
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Apr 2021 10:26:13 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id x7so19319933wrw.10
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Apr 2021 03:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=3Ao5WZ3vwsN7kCb3fIOQbu8eip9MnaKi4smYqZLOdVU=;
 b=HpzvzErt/IA3QiMhRngpcGc806V+tvHqSLTGxDdFzrjiuauCEBfItBbhzahgmC+8LV
 hra21En+pOjA47qwB9e96l9HkFr1fo/esj3WiBtcYsdKIZEs+hc1Por4naCzYMirBoUL
 8N1ahespUFYCarA7U4WyT+0I1fkcsU38/yQSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=3Ao5WZ3vwsN7kCb3fIOQbu8eip9MnaKi4smYqZLOdVU=;
 b=Ezc395jc6WJc7d/hnAO/ONWep1uhDdcgcNiHjfv6bHBvqKPrsHKoOpOMUEQu6LeLP2
 sc4mUCuaEkscGLTSDbg4opg2KeNMuvqcb5xB+/+8e12BLBZ6wg8Dx09WwHe2p/q6kzmG
 Wh/rcFO6Fl/rRmIC9cLrBsOTG14DIWk/CiXBNPqUcEsZAZbF0AFm/jP6k1+IlxtJ6pyX
 GxX8dHFs/WFqag/yBr8//PZu+e48WbpH540tZApgai32JMvHO4fBbEPeL5LU+ksOnK0N
 dnF/W1oc1gFZ+tTVsAAMao4RPxA8WjEVHBFtH7ivy/Ff1GVMryG2ilQZ6KLWlwLDvji9
 eDPw==
X-Gm-Message-State: AOAM531WS/NhjYZ45nVqM8OJR3RtSwERbBAivt/8HB+vaPaTKrCScpSO
 L/5FAS31Nz5ZoY7B6jg5aHaQBg==
X-Google-Smtp-Source: ABdhPJxfXWCAvCa/HTshJKOoB5O/Cy5Aow+yIkVFu5jTF1Tbf2lhqAgmAMZW2TvKCQdhWmOA7PiGpA==
X-Received: by 2002:adf:d219:: with SMTP id j25mr27260860wrh.187.1618395972026; 
 Wed, 14 Apr 2021 03:26:12 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id x15sm4845424wmi.41.2021.04.14.03.26.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Apr 2021 03:26:11 -0700 (PDT)
Date: Wed, 14 Apr 2021 12:26:09 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 8/9] drm/ttm: Don't count pages in SG BOs against
 pages_limit
Message-ID: <YHbDQcr6Yl1Lljep@phenom.ffwll.local>
References: <20210414064804.29356-1-Felix.Kuehling@amd.com>
 <20210414064804.29356-9-Felix.Kuehling@amd.com>
 <60d08770-e4f5-4e8f-0a93-2270ae02aa26@gmail.com>
 <YHayqD3IbupkY7b+@phenom.ffwll.local>
 <18a18e85-7b0d-649f-64a3-028376d8de15@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <18a18e85-7b0d-649f-64a3-028376d8de15@amd.com>
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
Cc: dri-devel@lists.freedesktop.org,
 Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Apr 14, 2021 at 11:19:41AM +0200, Christian K=F6nig wrote:
> Am 14.04.21 um 11:15 schrieb Daniel Vetter:
> > On Wed, Apr 14, 2021 at 08:51:51AM +0200, Christian K=F6nig wrote:
> > > Am 14.04.21 um 08:48 schrieb Felix Kuehling:
> > > > Pages in SG BOs were not allocated by TTM. So don't count them agai=
nst
> > > > TTM's pages limit.
> > > > =

> > > > Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> > > Reviewed-by: Christian K=F6nig <christian.koenig@amd.com>
> > > =

> > > Going to pick that one up for inclusion in drm-misc-next.
> > See my other email, but why do we need this? A bit more explanation is =
imo
> > needed here at least, since we still need to guarantee that allocations
> > don't over the limit in total for all gpu buffers together. At least un=
til
> > the shrinker has landed.
> > =

> > And this here just opens up the barn door without any explanation why i=
t's
> > ok.
> =

> The SG based BOs might not even be backed by pages. E.g. exported VRAM.
> =

> So either they are exported by a driver which should have accounted for t=
he
> allocation, exported by TTM which already did the accounting or doesn't e=
ven
> point to pages at all.
> =

> This is really a bug fix to recreate the behavior we had before moving the
> accounting to this place.

Throw that into the commit message and a-b: me. Ideally with a Fixes: line
or so pointing at the offending commit that broke stuff. Commit messages
should really go into more detail when there's an entire story behind a
small change like this one.
-Daniel

> =

> Christian.
> =

> > -Daniel
> > =

> > > Regards,
> > > Christian.
> > > =

> > > > ---
> > > >    drivers/gpu/drm/ttm/ttm_tt.c | 27 ++++++++++++++++++---------
> > > >    1 file changed, 18 insertions(+), 9 deletions(-)
> > > > =

> > > > diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm=
_tt.c
> > > > index 5d8820725b75..e8b8c3257392 100644
> > > > --- a/drivers/gpu/drm/ttm/ttm_tt.c
> > > > +++ b/drivers/gpu/drm/ttm/ttm_tt.c
> > > > @@ -317,9 +317,12 @@ int ttm_tt_populate(struct ttm_device *bdev,
> > > >    	if (ttm_tt_is_populated(ttm))
> > > >    		return 0;
> > > > -	atomic_long_add(ttm->num_pages, &ttm_pages_allocated);
> > > > -	if (bdev->pool.use_dma32)
> > > > -		atomic_long_add(ttm->num_pages, &ttm_dma32_pages_allocated);
> > > > +	if (!(ttm->page_flags & TTM_PAGE_FLAG_SG)) {
> > > > +		atomic_long_add(ttm->num_pages, &ttm_pages_allocated);
> > > > +		if (bdev->pool.use_dma32)
> > > > +			atomic_long_add(ttm->num_pages,
> > > > +					&ttm_dma32_pages_allocated);
> > > > +	}
> > > >    	while (atomic_long_read(&ttm_pages_allocated) > ttm_pages_limit=
 ||
> > > >    	       atomic_long_read(&ttm_dma32_pages_allocated) >
> > > > @@ -350,9 +353,12 @@ int ttm_tt_populate(struct ttm_device *bdev,
> > > >    	return 0;
> > > >    error:
> > > > -	atomic_long_sub(ttm->num_pages, &ttm_pages_allocated);
> > > > -	if (bdev->pool.use_dma32)
> > > > -		atomic_long_sub(ttm->num_pages, &ttm_dma32_pages_allocated);
> > > > +	if (!(ttm->page_flags & TTM_PAGE_FLAG_SG)) {
> > > > +		atomic_long_sub(ttm->num_pages, &ttm_pages_allocated);
> > > > +		if (bdev->pool.use_dma32)
> > > > +			atomic_long_sub(ttm->num_pages,
> > > > +					&ttm_dma32_pages_allocated);
> > > > +	}
> > > >    	return ret;
> > > >    }
> > > >    EXPORT_SYMBOL(ttm_tt_populate);
> > > > @@ -382,9 +388,12 @@ void ttm_tt_unpopulate(struct ttm_device *bdev=
, struct ttm_tt *ttm)
> > > >    	else
> > > >    		ttm_pool_free(&bdev->pool, ttm);
> > > > -	atomic_long_sub(ttm->num_pages, &ttm_pages_allocated);
> > > > -	if (bdev->pool.use_dma32)
> > > > -		atomic_long_sub(ttm->num_pages, &ttm_dma32_pages_allocated);
> > > > +	if (!(ttm->page_flags & TTM_PAGE_FLAG_SG)) {
> > > > +		atomic_long_sub(ttm->num_pages, &ttm_pages_allocated);
> > > > +		if (bdev->pool.use_dma32)
> > > > +			atomic_long_sub(ttm->num_pages,
> > > > +					&ttm_dma32_pages_allocated);
> > > > +	}
> > > >    	ttm->page_flags &=3D ~TTM_PAGE_FLAG_PRIV_POPULATED;
> > > >    }
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fl=
ists.freedesktop.org%2Fmailman%2Flistinfo%2Fdri-devel&amp;data=3D04%7C01%7C=
christian.koenig%40amd.com%7C3075d7fd16644322a13608d8ff25d59b%7C3dd8961fe48=
84e608e11a82d994e183d%7C0%7C0%7C637539885255795187%7CUnknown%7CTWFpbGZsb3d8=
eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&a=
mp;sdata=3DKOnHA1CbNFjjMZR2rgHmGkH%2B7C84YCtA6u9V1wBAay4%3D&amp;reserved=3D0
> =


-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

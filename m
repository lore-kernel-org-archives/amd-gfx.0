Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B98C5AD49
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 12:30:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2421D10E607;
	Wed, 28 May 2025 12:30:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=ffwll.ch header.i=@ffwll.ch header.b="eGxLW3r+";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B85C489954
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 12:30:14 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-3a4c9024117so671034f8f.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 05:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1748435412; x=1749040212; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LO5QPkQmxFsJzRiflztN9ZszXrtSheo7IjN1O6/YEeo=;
 b=eGxLW3r+BpaJSWbugOL17Q9nCN5UefE4IchHMfnz21wToxWadGW5RuKNWUz8hpIfTu
 tfixBw/8UjJmrVX+wpu/PDDVhiVVDEFl1/8Vt3O4OAe8B6iQZ1bboUxoOZNCZpM4VfgP
 qw4Nz89WvwbsNrtUnffAueZy4GTmiFuwQXKAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748435412; x=1749040212;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LO5QPkQmxFsJzRiflztN9ZszXrtSheo7IjN1O6/YEeo=;
 b=vTXMECQeNjoPxF5F9TL8N+RlR7habzfSy7eZZWZanTBfH7ILZtw2L7MGPYt/XSoYnM
 L0AJqdsqhl8ZVWLIx+AgcSrz0niGJL2sucGnkkxg71icuUXHK+gCSjxlEsrvowf7yCX/
 Y8VIHi4BZCndA0snaEjZtarukvS9KNN4Kfu2jL/dZrp3uB3ucPCfkHvb8x0Kxo2Mrcfg
 NExw6a4OV08+46xZG/dh9eBhy2mdGPvlgng7vUgNn48FybJKAsi/zZoL8t7ctOcTqEJv
 J/uAmprJs7tMu45HpOzkyAx0EF8gKoef72+lM3qxg4Z8bUaZIGMvgZe8arUos+xUxm0h
 pxNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMlnCq5yEDn36AzIuRLwiUOjJpYXijf/VAFsGSFKrUx3GOBquQh/PHpEJdOZQ98ufJPPPnTCnk@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw3MLRQWegCdGfG1i1h8cbLofGzQ/tsNO7kSyvQVj3nMbjERwUO
 YKkjg8fMNQSC3q5Tq9xJuBefVoIQIs8iZSV0zV0xJ5WGyeZu+wa6bMlZCNv9rsfVEV4=
X-Gm-Gg: ASbGnctwPSc56dbH29eKFUQWjjSQ1rh9pIpXoxZh6Ekz/8n1fbzFn1APjep2i1o3YIA
 TpDpFdLGzm7yrgY83FMwfEBjSBZTmhhcjmnX/QHgWAqo9uEtEYFdSoT0hcHsxL4try0slJ10fmn
 fZwVtjdiyZrBlFF4qH1TtLoH2oyN2hHzKgP4sVJicSVd5SD7AwzkvWjA80xI5ay9DKIrFotOSgY
 OkovAG13I1HGNZCkau31uYiEqifW6v9yX35b9ZPKtC5aRqwj7zhDA8tczJhqeNdV6JbSBw7+4U7
 SWArmEyCUhXUwxw/wMwBnYawOIZ42FVdGJ31/XaIfl/sTNCHavX+ZNrEZmQh7yQ=
X-Google-Smtp-Source: AGHT+IGCEGa4HFoW82MLiMfWrD3ZVlK3iLJn3N9oPQfimCcAn7wKldob0OS1QP44dsnfkoK9P1GoeA==
X-Received: by 2002:a05:6000:bc7:b0:3a4:e63d:2f2d with SMTP id
 ffacd0b85a97d-3a4e63d2fc1mr2965757f8f.6.1748435411861; 
 Wed, 28 May 2025 05:30:11 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4eac89daesm1326718f8f.44.2025.05.28.05.30.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 05:30:11 -0700 (PDT)
Date: Wed, 28 May 2025 14:30:08 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: phasta@kernel.org
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>, tursulin@ursulin.net,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/4] drm/sched: optimize drm_sched_job_add_dependency
Message-ID: <aDcB0AbQiHOVUyAU@phenom.ffwll.local>
References: <20250523125643.7540-1-christian.koenig@amd.com>
 <20250523125643.7540-2-christian.koenig@amd.com>
 <aDCCF0JFhO7lR2VJ@cassiopeiae> <aDCDJ-sK9rRI6wse@cassiopeiae>
 <cd64af4d-f5b3-4f18-9be6-636624833075@amd.com>
 <08bb986281fefb5cbdb35c63a56e1bbd923d9297.camel@mailbox.org>
 <74c4b9d8-5e25-438e-97c5-5aa2035fb9bd@amd.com>
 <cbd3eaa4c228c0d0688745e8a539103eb2278a0b.camel@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cbd3eaa4c228c0d0688745e8a539103eb2278a0b.camel@mailbox.org>
X-Operating-System: Linux phenom 6.12.25-amd64 
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, May 26, 2025 at 01:27:28PM +0200, Philipp Stanner wrote:
> On Mon, 2025-05-26 at 13:16 +0200, Christian König wrote:
> > On 5/26/25 11:34, Philipp Stanner wrote:
> > > On Mon, 2025-05-26 at 11:25 +0200, Christian König wrote:
> > > > On 5/23/25 16:16, Danilo Krummrich wrote:
> > > > > On Fri, May 23, 2025 at 04:11:39PM +0200, Danilo Krummrich
> > > > > wrote:
> > > > > > On Fri, May 23, 2025 at 02:56:40PM +0200, Christian König
> > > > > > wrote:
> > > > > > > It turned out that we can actually massively optimize here.
> > > > > > > 
> > > > > > > The previous code was horrible inefficient since it
> > > > > > > constantly
> > > > > > > released
> > > > > > > and re-acquired the lock of the xarray and started each
> > > > > > > iteration from the
> > > > > > > base of the array to avoid concurrent modification which in
> > > > > > > our
> > > > > > > case
> > > > > > > doesn't exist.
> > > > > > > 
> > > > > > > Additional to that the xas_find() and xas_store() functions
> > > > > > > are
> > > > > > > explicitly
> > > > > > > made in a way so that you can efficiently check entries and
> > > > > > > if
> > > > > > > you don't
> > > > > > > find a match store a new one at the end or replace existing
> > > > > > > ones.
> > > > > > > 
> > > > > > > So use xas_for_each()/xa_store() instead of
> > > > > > > xa_for_each()/xa_alloc().
> > > > > > > It's a bit more code, but should be much faster in the end.
> > > > > > 
> > > > > > This commit message does neither explain the motivation of
> > > > > > the
> > > > > > commit nor what it
> > > > > > does. It describes what instead belongs into the changelog
> > > > > > between versions.
> > > > > 
> > > > > Sorry, this is wrong. I got confused, the commit message is
> > > > > perfectly fine. :)
> > > > > 
> > > > > The rest still applies though.
> > > > > 
> > > > > > Speaking of versioning of the patch series, AFAIK there were
> > > > > > previous versions,
> > > > > > but this series was sent as a whole new series -- why?
> > > > > > 
> > > > > > Please resend with a proper commit message, version and
> > > > > > changelog. Thanks!
> > > > 
> > > > 
> > > > Well Philip asked to remove the changelog. I'm happy to bring it
> > > > back, but yeah...
> > > 
> > > No no no no :D
> > > 
> > > Philipp asked for the changelog to be removed *from the git commit
> > > message*; because it doesn't belong / isn't useful there.
> > > 
> > > If there's a cover letter, the changelog should be in the cover
> > > letter.
> > > If there's no cover letter, it should be between the ---
> > > separators:
> > 
> > I can live with that, just clearly state what you want.
> 
> Sure thing:
> 
>  * Patches and patch series's should contain their version identifier
>    within the square brackets [PATCH v3]. git format-patch -v3 does
>    that automatically.
>  * Changelog should be as described above
>  * Ideally, cover letters always contain the full changelog, v2, v3 and
>    so on, so that new readers get a sense of the evolution of the
>    series.
> 
> > 
> > For DRM the ask is often to keep the changelog in the commit message
> > or remove it entirely.
> 
> Yup, I've seen that a few times. I think we, the DRM community, should
> stop that. It's just not useful and makes the commit messages larger,
> both for the human reader while scrolling, as for the hard drive
> regarding storage size

I do occasionally find it useful as a record of different approaches
considered, which sometimes people fail to adequately cover in their
commit messages. Also useful indicator of how cursed a patch is :-)

But as long as anything relevant does end up in the commit message and
people don't just delete stuff I don't care how it's done at all. It's
just that the cost of deleting something that should have been there can
be really nasty sometimes, and storage is cheap.
-Sima

> 
> 
> Thx
> P.
> 
> 
> > 
> > Regards,
> > Christian.
> > 
> > > 
> > > 
> > > Signed-off-by: Gordon Freeman <freeman@blackmesa.org>
> > > Reviewed-by: Alyx Vance <alyx@vance.edu>
> > > ---
> > > Changes in v2:
> > >   - Provide more docu for crowbar-alloc-function.
> > >   - Use NULL pointers for reserved xarray entries
> > > ---
> > > <DIFF>
> > > 
> > > 
> > > P.
> > > 
> > > 
> > > > 
> > > > Regards,
> > > > Christian.
> > > > 
> > > > > > 
> > > > > > > Signed-off-by: Christian König <christian.koenig@amd.com>
> > > > > > > ---
> > > > > > >  drivers/gpu/drm/scheduler/sched_main.c | 29
> > > > > > > ++++++++++++++++++--------
> > > > > > >  1 file changed, 20 insertions(+), 9 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/gpu/drm/scheduler/sched_main.c
> > > > > > > b/drivers/gpu/drm/scheduler/sched_main.c
> > > > > > > index f7118497e47a..cf200b1b643e 100644
> > > > > > > --- a/drivers/gpu/drm/scheduler/sched_main.c
> > > > > > > +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > > > > > > @@ -871,10 +871,8 @@ EXPORT_SYMBOL(drm_sched_job_arm);
> > > > > > >  int drm_sched_job_add_dependency(struct drm_sched_job
> > > > > > > *job,
> > > > > > >   struct dma_fence *fence)
> > > > > > >  {
> > > > > > > + XA_STATE(xas, &job->dependencies, 0);
> > > > > > >   struct dma_fence *entry;
> > > > > > > - unsigned long index;
> > > > > > > - u32 id = 0;
> > > > > > > - int ret;
> > > > > > >  
> > > > > > >   if (!fence)
> > > > > > >   return 0;
> > > > > > > @@ -883,24 +881,37 @@ int
> > > > > > > drm_sched_job_add_dependency(struct
> > > > > > > drm_sched_job *job,
> > > > > > >   * This lets the size of the array of deps scale with
> > > > > > > the number of
> > > > > > >   * engines involved, rather than the number of BOs.
> > > > > > >   */
> > > > > > > - xa_for_each(&job->dependencies, index, entry) {
> > > > > > > + xa_lock(&job->dependencies);
> > > > > > > + xas_for_each(&xas, entry, ULONG_MAX) {
> > > > > > >   if (entry->context != fence->context)
> > > > > > >   continue;
> > > > > > >  
> > > > > > >   if (dma_fence_is_later(fence, entry)) {
> > > > > > >   dma_fence_put(entry);
> > > > > > > - xa_store(&job->dependencies, index,
> > > > > > > fence, GFP_KERNEL);
> > > > > > > + xas_store(&xas, fence);
> > > > > > >   } else {
> > > > > > >   dma_fence_put(fence);
> > > > > > >   }
> > > > > > > - return 0;
> > > > > > > + xa_unlock(&job->dependencies);
> > > > > > > + return xas_error(&xas);
> > > > > > >   }
> > > > > > >  
> > > > > > > - ret = xa_alloc(&job->dependencies, &id, fence,
> > > > > > > xa_limit_32b, GFP_KERNEL);
> > > > > > > - if (ret != 0)
> > > > > > > +retry:
> > > > > > > + entry = xas_store(&xas, fence);
> > > > > > > + xa_unlock(&job->dependencies);
> > > > > > > +
> > > > > > > + /* There shouldn't be any concurrent add, so no need
> > > > > > > to loop again */
> > > > > > 
> > > > > > Concurrency shouldn't matter, xas_nomem() stores the pre-
> > > > > > allocated memory in the
> > > > > > XA_STATE not the xarray. Hence, I think we should remove the
> > > > > > comment.
> > > > > > 
> > > > > > > + if (xas_nomem(&xas, GFP_KERNEL)) {
> > > > > > > + xa_lock(&job->dependencies);
> > > > > > > + goto retry;
> > > > > > 
> > > > > > Please don't use a goto here, if we would have failed to
> > > > > > allocate
> > > > > > memory here,
> > > > > > this would be an endless loop until we succeed eventually. It
> > > > > > would be equal to:
> > > > > > 
> > > > > > while (!ptr) {
> > > > > > ptr = kmalloc();
> > > > > > }
> > > > > > 
> > > > > > Instead just take the lock and call xas_store() again.
> > > > > > 
> > > > > > > + }
> > > > > > > +
> > > > > > > + if (xas_error(&xas))
> > > > > > >   dma_fence_put(fence);
> > > > > > > + else
> > > > > > > + WARN_ON(entry);
> > > > > > 
> > > > > > Please don't call WARN_ON() here, this isn't fatal, we only
> > > > > > need
> > > > > > to return the
> > > > > > error code.
> > > > 
> > > 
> > 
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

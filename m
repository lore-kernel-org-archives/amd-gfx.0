Return-Path: <SRS0=n+xW=KC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAA6C43461
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 16:29:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 276F76144F
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 16:29:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 276F76144F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18EE56EE8B;
	Fri,  7 May 2021 16:29:28 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5AFD6EE72
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 May 2021 16:29:26 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id h4so9859075wrt.12
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 May 2021 09:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=i5gqYyRVGDKtMiP6DIRn730yK875UZBGjViO2hUlN30=;
 b=Molaaqd6GohdZzV9tXCoFdj5VFvUKpx2iyGB4kcHJdTr+OEQiDfvl92exGLek2BBd7
 FCZ9BPcPK6HgpVPGhS4wTnfnZxnhO7ytsiqBxcOgB7rdBPsyRa0jr3H9NJ33nrGdRui+
 7Tdq3nrRLN/BBLOh6dsQIPo35q5Ht+1z86F8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=i5gqYyRVGDKtMiP6DIRn730yK875UZBGjViO2hUlN30=;
 b=sGYGampv0ipFXVjydBiq7sxdfX2y25zg2ci1IUrK34HE9I3LB7PIpAgKShO/3rAtEY
 /MEbys2WTg99TXVNItO2gx6mYR62oQRvvbtvjCxU9PBA2HDG5tjBNAty4xV940CNfoFv
 v7+TnNcPpmTAGYb+uH24z1wG5oYEQ1jLzu3HqdrTPXGVEmZOF8fxy46p9RsDlh899MDc
 SB3LVmsxWsOEq+rwifBGyIkc9DUtBL1GLYoSQlCL0Tch6RuB8sWqlqZXt8jJTy15IqlX
 V6jg6FBgy5g2ek+AyJh4rqE+Opzw+J7o164fzfEey85Svlfzw51TWVuSNLXDNOpAp8hr
 aBsA==
X-Gm-Message-State: AOAM532gMsuH0rcfs26MnH/VVKj6oVlJBcvlAtwE7AZqNAuIcujtK8aq
 kzjV6HLhJXT3b8V7iAI+G9CEkg==
X-Google-Smtp-Source: ABdhPJzCoXyg/sKzN6Z3xNGDfY7Ya6xJX07aCIOt/3IDjdUxBfaeQ6kZEe2+EaftMEIX797yslaGbA==
X-Received: by 2002:a5d:4e0b:: with SMTP id p11mr13246262wrt.220.1620404965628; 
 Fri, 07 May 2021 09:29:25 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id x65sm16531820wmg.36.2021.05.07.09.29.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 May 2021 09:29:25 -0700 (PDT)
Date: Fri, 7 May 2021 18:29:23 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Subject: Re: [PATCH v5 15/27] drm/scheduler: Fix hang when sched_entity
 released
Message-ID: <YJVq4x4d81rY2GHB@phenom.ffwll.local>
References: <20210428151207.1212258-1-andrey.grodzovsky@amd.com>
 <20210428151207.1212258-16-andrey.grodzovsky@amd.com>
 <a8314d77-578f-e0df-5c49-77d5f10c76c7@amd.com>
 <9cb771f2-d52f-f14e-f3d4-b9488b353ae3@amd.com>
 <0c598888-d7d4-451a-3d4a-01c46ddda397@gmail.com>
 <a704880d-8e27-3cca-f42b-1320d39ac503@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a704880d-8e27-3cca-f42b-1320d39ac503@amd.com>
X-Operating-System: Linux phenom 5.10.32scarlett+ 
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
Cc: gregkh@linuxfoundation.org, daniel.vetter@ffwll.ch, Felix.Kuehling@amd.com,
 linux-pci@vger.kernel.org, amd-gfx@lists.freedesktop.org, ppaalanen@gmail.com,
 helgaas@kernel.org, dri-devel@lists.freedesktop.org,
 Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alexander.Deucher@amd.com, Harry.Wentland@amd.com,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Apr 30, 2021 at 12:10:57PM -0400, Andrey Grodzovsky wrote:
> =

> =

> On 2021-04-30 2:47 a.m., Christian K=F6nig wrote:
> > =

> > =

> > Am 29.04.21 um 19:06 schrieb Andrey Grodzovsky:
> > > =

> > > =

> > > On 2021-04-29 3:18 a.m., Christian K=F6nig wrote:
> > > > I need to take another look at this part when I don't have a
> > > > massive headache any more.
> > > > =

> > > > Maybe split the patch set up into different parts, something like:
> > > > 1. Adding general infrastructure.
> > > > 2. Making sure all memory is unpolated.
> > > > 3. Job and fence handling
> > > =

> > > I am not sure you mean this patch here, maybe another one ?
> > > Also note you already RBed it.
> > =

> > No what I meant was to send out the patches before this one as #1 and #=
2.
> > =

> > That is the easier stuff which can easily go into the drm-misc-next or
> > amd-staging-drm-next branch.
> > =

> > The scheduler stuff certainly need to go into drm-misc-next.
> > =

> > Christian.
> =

> Got you. I am fine with it. What we have here is a working hot-unplug
> code but, one with potential use after free MMIO ranges frpom the zombie
> device. The followup patches after this patch are all about preventing
> this and so the patch-set up until this patch including, is functional
> on it's own. While it's necessary to solve the above issue, it's has
> complications as can be seen from the discussion with Daniel on later
> patch in this series. Still, in my opinion it's better to rollout some
> initial support to hot-unplug without use after free protection then
> having no support for hot-unplug at all. It will also make the merge
> work easier as I need to constantly rebase the patches on top latest
> kernel and solve new regressions.
> =

> Daniel - given the arguments above can you sound your opinion on this
> approach ?

I'm all for incrementally landing this, because it's really hard and
tricky. We might need to go back to some of the decisions, or clarify
things more, or more headaches and pondering how to fix all the parts
that works best to make sure there's no nasty races right across hotunplug
if you're unlucky enough.

But yeah better aim for something and then readjust than bikeshed forever
out of tree.

Cheers, Daniel

> =

> Andrey
> > =

> > > =

> > > Andrey
> > > =

> > > > =

> > > > Christian.
> > > > =

> > > > Am 28.04.21 um 17:11 schrieb Andrey Grodzovsky:
> > > > > Problem: If scheduler is already stopped by the time sched_entity
> > > > > is released and entity's job_queue not empty I encountred
> > > > > a hang in drm_sched_entity_flush. This is because
> > > > > drm_sched_entity_is_idle
> > > > > never becomes false.
> > > > > =

> > > > > Fix: In drm_sched_fini detach all sched_entities from the
> > > > > scheduler's run queues. This will satisfy drm_sched_entity_is_idl=
e.
> > > > > Also wakeup all those processes stuck in sched_entity flushing
> > > > > as the scheduler main thread which wakes them up is stopped by no=
w.
> > > > > =

> > > > > v2:
> > > > > Reverse order of drm_sched_rq_remove_entity and marking
> > > > > s_entity as stopped to prevent reinserion back to rq due
> > > > > to race.
> > > > > =

> > > > > v3:
> > > > > Drop drm_sched_rq_remove_entity, only modify entity->stopped
> > > > > and check for it in drm_sched_entity_is_idle
> > > > > =

> > > > > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> > > > > Reviewed-by: Christian K=F6nig <christian.koenig@amd.com>
> > > > > ---
> > > > > =A0 drivers/gpu/drm/scheduler/sched_entity.c |=A0 3 ++-
> > > > > =A0 drivers/gpu/drm/scheduler/sched_main.c=A0=A0 | 24
> > > > > ++++++++++++++++++++++++
> > > > > =A0 2 files changed, 26 insertions(+), 1 deletion(-)
> > > > > =

> > > > > diff --git a/drivers/gpu/drm/scheduler/sched_entity.c
> > > > > b/drivers/gpu/drm/scheduler/sched_entity.c
> > > > > index f0790e9471d1..cb58f692dad9 100644
> > > > > --- a/drivers/gpu/drm/scheduler/sched_entity.c
> > > > > +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> > > > > @@ -116,7 +116,8 @@ static bool
> > > > > drm_sched_entity_is_idle(struct drm_sched_entity *entity)
> > > > > =A0=A0=A0=A0=A0 rmb(); /* for list_empty to work without lock */
> > > > > =A0=A0=A0=A0=A0 if (list_empty(&entity->list) ||
> > > > > -=A0=A0=A0=A0=A0=A0=A0 spsc_queue_count(&entity->job_queue) =3D=
=3D 0)
> > > > > +=A0=A0=A0=A0=A0=A0=A0 spsc_queue_count(&entity->job_queue) =3D=
=3D 0 ||
> > > > > +=A0=A0=A0=A0=A0=A0=A0 entity->stopped)
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 return true;
> > > > > =A0=A0=A0=A0=A0 return false;
> > > > > diff --git a/drivers/gpu/drm/scheduler/sched_main.c
> > > > > b/drivers/gpu/drm/scheduler/sched_main.c
> > > > > index 908b0b56032d..ba087354d0a8 100644
> > > > > --- a/drivers/gpu/drm/scheduler/sched_main.c
> > > > > +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > > > > @@ -897,9 +897,33 @@ EXPORT_SYMBOL(drm_sched_init);
> > > > > =A0=A0 */
> > > > > =A0 void drm_sched_fini(struct drm_gpu_scheduler *sched)
> > > > > =A0 {
> > > > > +=A0=A0=A0 struct drm_sched_entity *s_entity;
> > > > > +=A0=A0=A0 int i;
> > > > > +
> > > > > =A0=A0=A0=A0=A0 if (sched->thread)
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 kthread_stop(sched->thread);
> > > > > +=A0=A0=A0 for (i =3D DRM_SCHED_PRIORITY_COUNT - 1; i >=3D
> > > > > DRM_SCHED_PRIORITY_MIN; i--) {
> > > > > +=A0=A0=A0=A0=A0=A0=A0 struct drm_sched_rq *rq =3D &sched->sched_=
rq[i];
> > > > > +
> > > > > +=A0=A0=A0=A0=A0=A0=A0 if (!rq)
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 continue;
> > > > > +
> > > > > +=A0=A0=A0=A0=A0=A0=A0 spin_lock(&rq->lock);
> > > > > +=A0=A0=A0=A0=A0=A0=A0 list_for_each_entry(s_entity, &rq->entitie=
s, list)
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * Prevents reinsertion and =
marks job_queue as idle,
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * it will removed from rq i=
n drm_sched_entity_fini
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * eventually
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 s_entity->stopped =3D true;
> > > > > +=A0=A0=A0=A0=A0=A0=A0 spin_unlock(&rq->lock);
> > > > > +
> > > > > +=A0=A0=A0 }
> > > > > +
> > > > > +=A0=A0=A0 /* Wakeup everyone stuck in drm_sched_entity_flush for
> > > > > this scheduler */
> > > > > +=A0=A0=A0 wake_up_all(&sched->job_scheduled);
> > > > > +
> > > > > =A0=A0=A0=A0=A0 /* Confirm no work left behind accessing device s=
tructures */
> > > > > =A0=A0=A0=A0=A0 cancel_delayed_work_sync(&sched->work_tdr);
> > > > =

> > =


-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A8FEC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 20:36:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCBBC10E309;
	Fri, 10 Dec 2021 20:36:35 +0000 (UTC)
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 930F310E309
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 20:36:34 +0000 (UTC)
Received: from zimbra39-e7.priv.proxad.net (unknown [172.20.243.189])
 by smtp4-g21.free.fr (Postfix) with ESMTP id 5FFE419F5A7;
 Fri, 10 Dec 2021 21:36:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1639168592;
 bh=0QeGxuXFUjj0mSznhmz2vrRuySo7MwBO34XzW3OZBRg=;
 h=Date:From:To:Cc:In-Reply-To:Subject:From;
 b=UF+HD28NqcUM3VXn/JX5N0RCqLcQfdm/vtiiX1EqiDvmXwBYQFb4fWpClUMU9IkCF
 lNg76YgIZ3yHBunpLwXi9rIAUN+eHXQ6MdUOgsu84WIgCepcjRpA44Q7DxVjBfnxNK
 xG3FYaJxE4MoJt3ttdDCpqoqKKmrJXLJH2Qs3P81EhXqZnp2swBtYbWYQIfuus8PE/
 73ZAQ6HWaawiNqeJBCQ/wqYCyURpSLB+DWwZR3M0/T8GcvI2OBX65coQnTJoeYv1bl
 OrmkNhf6J4TG3S3+kiR1baxgbUdGxVk+2zHlwrRbzJQ5IiNGZzZKaSVoaqSuOfERHU
 eEHMYql2usTfw==
Date: Fri, 10 Dec 2021 21:36:32 +0100 (CET)
From: Yann Dirson <ydirson@free.fr>
To: Alex Deucher <alexdeucher@gmail.com>
Message-ID: <200087766.51712636.1639168592351.JavaMail.root@zimbra39-e7>
In-Reply-To: <CADnq5_MQnX6dRJ4-YHjWaSS5PYb1f6BQ4FXNkw9wzDmwQarkrA@mail.gmail.com>
Subject: Re: Looking for clarifications around gfx/kcq/kiq
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [88.120.44.86]
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - FF3.0 (Linux)/7.2.0-GA2598)
X-Authenticated-User: ydirson@free.fr
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
Cc: Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

> > amdgpu_ring_alloc() itself is unconditionally setting count_dw,
> > which looked
> > suspicious to me -- so I added the check shown below, and it does
> > look like
> > ring_alloc() gets called again too soon.  Am I right in thinking
> > this could be
> > the cause of amdgpu_ring_test_helper() failing in timeout ?
> >
> 
> Not likely.  The PSP failing to load firmware is most likely the
> problem.  You need to have a functional PSP for any of the other
> engines to be usable.  If we can't load the firmware for the
> microcontrollers, the driver can't interact with them.

Even if it has no effect on my primary issue, I'm still having doubt
on this: if we call amdgpu_ring_alloc() twice without ensuring the
allocated space has been padded with nop's (ie. 0xFFFFFFFF, right ?)
what happens when the GFX IP (or should we rather say "GC"?) will
parse those ?

My reading of gfx_enable_kcq() is that it is in this case.  Isn't
it missing a call to ring_commit() before ring_test() ?

> 
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > @@ -70,6 +70,9 @@ int amdgpu_ring_alloc(struct amdgpu_ring *ring,
> > unsigned ndw)
> >         if (WARN_ON_ONCE(ndw > ring->max_dw))
> >                 return -ENOMEM;
> >
> > +       /* check we're not allocating too fast */
> > +       WARN_ON_ONCE(ring->count_dw);
> > +
> >         ring->count_dw = ndw;
> >         ring->wptr_old = ring->wptr;
> >
> >
> > About gfx_v9_0_sw_fini():
> > - the 2 calls to bo_free are called here without condition, whereas
> > they are
> >   allocated from rlc_init, not directly from sw_init.  Is this
> >   asymmetry wanted ?
> >
> >
> > Maybe such info should join the documentation at some point?
> 
> Yeah, would be useful.
> 
> Alex
> 
> >
> > [0]
> > https://lists.freedesktop.org/archives/amd-gfx/2021-November/071855.html
> 

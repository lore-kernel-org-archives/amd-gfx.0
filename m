Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4473AC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Mar 2022 17:27:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF36E10E6CA;
	Thu, 17 Mar 2022 17:27:02 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E56D410E6CC
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 17:27:01 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id r6so8340385wrr.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 10:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=lOa+QRnoOsA4pzJa3atRx7kwZnzbt9HWzJ/pBnPiTi8=;
 b=jrTOhMVEtk+eP54/2uOyRAEPApEjQFrVQLITvQ2RE/5uAxo10wHFDbvq/2m1L59fAg
 BrHS6oN0YrnNWM05y1AulWvg289ays9wiZ76cloxJjsoBVc5Cdm+OWJMfF6uNT6Y2MAd
 FsbmoY6DlsBy4ChpcmpcyiDyx3zYvzRSGcCDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=lOa+QRnoOsA4pzJa3atRx7kwZnzbt9HWzJ/pBnPiTi8=;
 b=gMmzAaC/t5jWzgNVf4ERKYnRCka6RSmDGCPmimBNeHrGm6XjnHMmO7Gn3lV/0YqUSt
 qt5ssSqp7I6AYPdrjpE0C2/j2FjkJgDJ0eYKpjL5EQA24ZBT94onKZR1ZUjOskmwdwa0
 LXsSTkpPeGZdlMzfNI+rG10iSMXQK7gH/i9I6VO3fmLxGs41W9NKWsdawzJvtbPcvs9m
 J3DX5s+kYWSrr4F6CjDv9BBhwclstnNJkTNZ8E+S7k7A3q6P03itIvYYxlbS0EaACZXS
 0tLRpOrjUu4DJXnHtwfeZdFgc5Fm5x0owJ7SqWzgsG7ZBSmaBIMmt0JfaHQq4ZNpoDQh
 hxHg==
X-Gm-Message-State: AOAM533XNNRwUpBkYdTigk1qClxXS1Efy1+JGq6ZKaHgvvh/Fi118PYQ
 qMw9kAUZoecVOizc4GrdNwJ1pg==
X-Google-Smtp-Source: ABdhPJwEMPUjSH0jE4q7W0fbREu464WEL7O2O44FxpZzT5EU+0gtfCdDslb0D/l0y3HYVjuk3H9Lcw==
X-Received: by 2002:a05:6000:18a7:b0:203:72d1:9be5 with SMTP id
 b7-20020a05600018a700b0020372d19be5mr4888757wri.325.1647538020342; 
 Thu, 17 Mar 2022 10:27:00 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a5d6648000000b00203e64e3637sm2596849wrw.89.2022.03.17.10.26.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Mar 2022 10:26:59 -0700 (PDT)
Date: Thu, 17 Mar 2022 18:26:58 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH v2 1/2] drm: Add GPU reset sysfs event
Message-ID: <YjNvYmcuDKiIneDx@phenom.ffwll.local>
References: <20220311102709.225616cf@eldfell>
 <CADnq5_O1Qktec3kC_rcPZUQPbraBYmdhDwmj=jgp_QsaBFGUZw@mail.gmail.com>
 <20220314172647.223658d2@eldfell>
 <CADnq5_NsxipfFFXfRSXvVQin3e1gj0Q_p9p-shi3VZ2pSCwwfw@mail.gmail.com>
 <20220316104815.11ec2e6c@eldfell>
 <CADnq5_MbOLaZGaQ8fYW_ZL3+gssu3cq7QbzByOWdLuvbdfSAAg@mail.gmail.com>
 <CAF6AEGvoqJmXs0KxXGN4qKD4U6Yeo4gDq6sVxm=noY-TwFoj4w@mail.gmail.com>
 <5e246eb8-0256-c40e-40ea-d865bf99c003@gmail.com>
 <YjL/k6kh+5RihGIV@phenom.ffwll.local>
 <CAF6AEGu79jDW1xqJOaNCB=jAxhKiCRFJwoCNiC9ye97KvpWEtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF6AEGu79jDW1xqJOaNCB=jAxhKiCRFJwoCNiC9ye97KvpWEtQ@mail.gmail.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
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
Cc: Rob Clark <robdclark@chromium.org>, "Sharma,
 Shashank" <shashank.sharma@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Amaranath Somalapuram <amaranath.somalapuram@amd.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Alexandar Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexdeucher@gmail.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Mar 17, 2022 at 08:40:51AM -0700, Rob Clark wrote:
> On Thu, Mar 17, 2022 at 2:29 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Thu, Mar 17, 2022 at 08:03:27AM +0100, Christian König wrote:
> > > Am 16.03.22 um 16:36 schrieb Rob Clark:
> > > > [SNIP]
> > > > just one point of clarification.. in the msm and i915 case it is
> > > > purely for debugging and telemetry (ie. sending crash logs back to
> > > > distro for analysis if user has crash reporting enabled).. it isn't
> > > > used for triggering any action like killing app or compositor.
> > >
> > > By the way, how does msm it's memory management for the devcoredumps?
> >
> > GFP_NORECLAIM all the way. It's purely best effort.
> >
> > Note that the fancy new plan for i915 discrete gpu is to only support gpu
> > crash dumps on non-recoverable gpu contexts, i.e. those that do not
> > continue to the next batch when something bad happens. This is what vk
> > wants and also what iris now uses (we do context recovery in userspace in
> > all cases), and non-recoverable contexts greatly simplify the crash dump
> > gather: Only thing you need to gather is the register state from hw
> > (before you reset it), all the batchbuffer bo and indirect state bo (in
> > i915 you can mark which bo to capture in the CS ioctl) can be captured in
> > a worker later on. Which for non-recoverable context is no issue, since
> > subsequent batchbuffers won't trample over any of these things.
> 
> fwiw, we snapshot everything (cmdstream and bo's marked with dump
> flag, in addition to hw state) before resuming the GPU, so there is no
> danger of things being trampled.  After state is captured and GPU
> reset, we "replay" the submits that were written into the ringbuffer
> after the faulting submit.  GPU crashes should be a thing you don't
> need to try to optimize.

Not sure why you think we optimize anything here?

> (At some point, I'd like to use scheduler for the replay, and actually
> use drm_sched_stop()/etc.. but last time I looked there were still
> some sched bugs in that area which prevented me from deleting a bunch
> of code ;-))

Not sure about your hw, but at least on intel replaying tends to just
result in follow-on fun. And that holds even more so the more complex a
workload is. This is why vk just dies immediately and does not try to
replay anything, offloading it to the app. Same with arb robusteness.
Afaik it's really only media and classic gl which insist that the driver
stack somehow recover.

And recovering from a mess in userspace is a lot simpler than trying to
pull of the same magic in the kernel. Plus it also helps with a few of the
dma_fence rules, which is a nice bonus.
-Daniel

> 
> BR,
> -R
> 
> >
> > And that way you can record the crashdump (or at least the big pieces like
> > all the indirect state stuff) with GFP_KERNEL.
> >
> > msm probably gets it wrong since embedded drivers have much less shrinker
> > and generally no mmu notifiers going on :-)
> >
> > > I mean it is strictly forbidden to allocate any memory in the GPU reset
> > > path.
> > >
> > > > I would however *strongly* recommend devcoredump support in other GPU
> > > > drivers (i915's thing pre-dates devcoredump by a lot).. I've used it
> > > > to debug and fix a couple obscure issues that I was not able to
> > > > reproduce by myself.
> > >
> > > Yes, completely agree as well.
> >
> > +1
> >
> > Cheers, Daniel
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

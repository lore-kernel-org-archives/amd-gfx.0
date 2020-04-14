Return-Path: <SRS0=Gn/P=56=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23F9C2BA19
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 13:14:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87D7B2063A
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 13:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isQPS0YR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87D7B2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08C536E4DE;
	Tue, 14 Apr 2020 13:14:41 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C37C76E4D2;
 Tue, 14 Apr 2020 13:14:39 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id d27so5059629wra.1;
 Tue, 14 Apr 2020 06:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ll4eqAKYtjTVgiWa+EM/tj8opR8soYnFbaqkSa8MX0w=;
 b=isQPS0YRieB7ch7fx9vRbFH6vVJ4/QFAfFtOxs7dl7WJwGeHCeTQS+qrGd9s7WRif5
 JqpVOBi2Cqe2E6ez62qE4/a7Sji/QthpWmK44OsPX7WYNXpcdiI2oOhmjb+4yRlXO5QK
 l23pyo3SDKhsQmdSNfmOZFuVUtenQdOdPK50FCKUU5z8N82ZFzdmWe+gVIcmuCw0h3Zn
 ArG3qdgBx2OhGRZcmg9uBy/DC+NSzJXr4coBZOznjpbpcYXf5kvVjA5L6qfe93w03on6
 O8wsBlWmpEmcZMWVG7vUxga9csu/DS5M8ieHTQ+WFXB78toa2EvqDVzMqTE5flLxLus+
 dqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ll4eqAKYtjTVgiWa+EM/tj8opR8soYnFbaqkSa8MX0w=;
 b=mCoYkk2xGpQnRBbM3g7SxKqAErx8G6VNj+lV5hBJmsHfuv04LxD3RCR4GqUS1Pihop
 AWHJm1wJv8GjnWRYxgIiAn5vRFNzNSP/abbVbqUJd9eb63O22RgDE+i1DMu2LvWvnkrQ
 vB/ywKVqZ1/JRZHihKG82wFdILJhR2et//GZ5fWbY4zxBu5QLdRF16yHeni6DLwBGGDV
 IBibIm6Q7XAgLUVQZAmaHKDr5EBEcFAvz1b2ENuN39/gdDjTYckqxU9ntOUHxyMXViWG
 noli2i3sg4Kn4j9cpRzzibNHqCesV5TMVno+3jTLbq5qkdFH+hgppsSuQcctrVmxymVI
 EevQ==
X-Gm-Message-State: AGi0PubaLCP0D8sqY2aBqauj9nNbRYds3gTbMBIaF8oZEXrju4b9/971
 CFPmX4/zfXr+uklLk0n4zOtJPd7QfMjvMjTyQC0=
X-Google-Smtp-Source: APiQypKDWYE7ro/xZ4gZ+BUY0l4LRMksuXmT+3J4sb0z0oWxfdy2Qap6WOfuUwiVUau7i+EWwS9jFojCnbujMqGjuj0=
X-Received: by 2002:a5d:65cb:: with SMTP id e11mr23399657wrw.402.1586870078292; 
 Tue, 14 Apr 2020 06:14:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200226190152.16131-1-Kenny.Ho@amd.com>
 <CAOWid-eyMGZfOyfEQikwCmPnKxx6MnTm17pBvPeNpgKWi0xN-w@mail.gmail.com>
 <20200324184633.GH162390@mtj.duckdns.org>
 <CAOWid-cS-5YkFBLACotkZZCH0RSjHH94_r3VFH8vEPOubzSpPA@mail.gmail.com>
 <20200413191136.GI60335@mtj.duckdns.org>
 <20200414122015.GR3456981@phenom.ffwll.local>
 <CAOWid-f-XWyg0o3znH28xYndZ0OMzWfv3OOuWw08iJDKjrqFGA@mail.gmail.com>
 <CAKMK7uEs5QvUrxKcTFksO30D+x=XJnV+_TA-ebawcihtLqDG0Q@mail.gmail.com>
In-Reply-To: <CAKMK7uEs5QvUrxKcTFksO30D+x=XJnV+_TA-ebawcihtLqDG0Q@mail.gmail.com>
From: Kenny Ho <y2kenny@gmail.com>
Date: Tue, 14 Apr 2020 09:14:27 -0400
Message-ID: <CAOWid-fwEOk+4CvUAumo=byWpq4vVUoCiwW1N6F-0aEd6G7d4A@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] new cgroup controller for gpu/drm subsystem
To: Daniel Vetter <daniel@ffwll.ch>
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
 lkaplan@cray.com, Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Greathouse,
 Joseph" <joseph.greathouse@amd.com>, Tejun Heo <tj@kernel.org>,
 cgroups@vger.kernel.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ok.  I was hoping you can clarify the contradiction between the
existance of the spec below and your "not something any other gpu can
reasonably support" statement.  I mean, OneAPI is Intel's spec and
doesn't that at least make SubDevice support "reasonable" for one more
vendor?

Partisanship aside, as a drm co-maintainer, do you really not see the
need for non-work-conserving way of distributing GPU as a resource?
You recognized the latencies involved (although that's really just
part of the story... time sharing is never going to be good enough
even if your switching cost is zero.)  As a drm co-maintainer, are you
suggesting GPU has no place in the HPC use case?

Regards,
Kenny

On Tue, Apr 14, 2020 at 8:52 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Tue, Apr 14, 2020 at 2:47 PM Kenny Ho <y2kenny@gmail.com> wrote:
> > On Tue, Apr 14, 2020 at 8:20 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > > My understanding from talking with a few other folks is that
> > > the cpumask-style CU-weight thing is not something any other gpu can
> > > reasonably support (and we have about 6+ of those in-tree)
> >
> > How does Intel plan to support the SubDevice API as described in your
> > own spec here:
> > https://spec.oneapi.com/versions/0.7/oneL0/core/INTRO.html#subdevice-support
>
> I can't talk about whether future products might or might not support
> stuff and in what form exactly they might support stuff or not support
> stuff. Or why exactly that's even in the spec there or not.
>
> Geez
> -Daniel
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

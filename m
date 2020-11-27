Return-Path: <SRS0=Guv+=FB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300D5C63798
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 15:09:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 714AA22240
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 15:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="FazESORP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 714AA22240
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C79A6EE45;
	Fri, 27 Nov 2020 15:09:48 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF83B6EE3F
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2020 15:09:46 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id m6so5904666wrg.7
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2020 07:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=9VmoUHkcSYuVMI/yJkCFQIr4oYdNbC60zl32PtTl5m8=;
 b=FazESORPPR9vIRpsNKCJHfZWP0EsIA0Yja/bMoSSPbj43G6l6jBQjeFKt3C2YUCgWO
 dC368jMu9o1mAwGoJrCJyljUPqqbmJvRlTgaJ9I42dXBmMvhlUl2z1dYKKzizpwUFmeV
 hTqwhnWJY4fjlLHfUmPRhMXToQSWlgKxacU+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=9VmoUHkcSYuVMI/yJkCFQIr4oYdNbC60zl32PtTl5m8=;
 b=SiqWR4Pe+RzLxyb13lwo2QwSkjTB+V1GllBRAVw8JZIEmVzOYMDtRiagssmlonMMoc
 0fCV87BoA9arFHO3FvHgPQgdvcOdvxngsO245eZ3aPy+SRFWvZDdrXOsQQIHB9smaHun
 NrUmTNKmn0WL/reSAEqFVWNQO30N/GJEHmANlvrfCyO3QK6Cw5RYFjjt5jp0RMvsiVAv
 IagSMunq51O0NA4ICHcXXlsRFPbEE+KagvdQ9VjjShkyfPrTGWjRcPybHBNMwokYqZbJ
 ZxxkFlFOqxT4e+W/T8qD/Pk0FKje7bgqjfQzxCJLcS4J4fCkOPgIlM70Vlzy76Ev05Y/
 begQ==
X-Gm-Message-State: AOAM531hP5mBwJZd9eJyzvgxag8X7+uEFW2/1CRdaR2gqkJbqu8P8xf4
 a6bSRFph6EP/yh+RVz6Me1VNsSUxg5nG4Q==
X-Google-Smtp-Source: ABdhPJxSN8cmDhEw3ED/+sLUy8P0F4+YnpzAZBFMdqpctDeMhAwl3qm3NGZSDRHW+5YsQupA+erqcA==
X-Received: by 2002:adf:f88c:: with SMTP id u12mr11423465wrp.209.1606489785609; 
 Fri, 27 Nov 2020 07:09:45 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id b73sm22011233wmb.0.2020.11.27.07.09.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2020 07:09:44 -0800 (PST)
Date: Fri, 27 Nov 2020 16:09:42 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH] drm/radeon: fix check order in radeon_bo_move
Message-ID: <20201127150942.GF401619@phenom.ffwll.local>
References: <20201125143424.1434-1-christian.koenig@amd.com>
 <CAKMK7uF7SZ_ihX+s6Rxg8Ws96vViu8Ab2vN+6VysWeDRkQMbNg@mail.gmail.com>
 <CAPM=9txqSCUcCoYKXxC6bX5Qx1SEBG4MPNTdKRybogwyOsZg5w@mail.gmail.com>
 <66a8a6f5-af8b-a46f-0dfa-417dd699b58f@gmail.com>
 <CAKMK7uEurRUDsK58xAiJ98xQckCeL6p+hFvbkx8AP6HAW-EsDw@mail.gmail.com>
 <5a88c54c-3731-856a-da3c-b084c9b33187@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5a88c54c-3731-856a-da3c-b084c9b33187@amd.com>
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
Cc: Dave Airlie <airlied@linux.ie>, dri-devel <dri-devel@lists.freedesktop.org>,
 Dave Airlie <airlied@gmail.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Nov 27, 2020 at 03:49:31PM +0100, Christian K=F6nig wrote:
> Am 27.11.20 um 15:46 schrieb Daniel Vetter:
> > On Fri, Nov 27, 2020 at 3:10 PM Christian K=F6nig
> > <ckoenig.leichtzumerken@gmail.com> wrote:
> > > Am 27.11.20 um 09:31 schrieb Dave Airlie:
> > > > Oops sorry for delay LGTM
> > > > =

> > > > Reviewed-by: Dave Airlie <airlied@redhat.com>
> > > Thanks.
> > > =

> > > > On Fri, 27 Nov 2020 at 02:34, Daniel Vetter <daniel@ffwll.ch> wrote:
> > > > > On Wed, Nov 25, 2020 at 3:34 PM Christian K=F6nig
> > > > > <ckoenig.leichtzumerken@gmail.com> wrote:
> > > > > > Reorder the code to fix checking if blitting is available.
> > > > > Might be good to explain why blitting might not be available, e.g.
> > > > > suspend/resume and or chip death and stuff like that.
> > > > > =

> > > > > > Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>
> > > > > Needs Fixes: 28a68f828266 ("drm/radeon/ttm: use multihop")
> > > Why does the subject of the patch needs to be in "()" ? I was already
> > > wondering why dim sometimes complains about my Fixes tag.
> > Hm I thought that's the official style. I kinda hacked around on it
> > until linux-next stopped complaining about our Fixes: tags. Maybe it's
> > not quite accurately reflecting the current bikeshed. Iirc checkpatch
> > even complains when you leave out the commit before the sha1, at least
> > in free-form text in the commit message.
> =

> Well "git log -1 --oneline 28a68f828266" gives me:
> =

> 28a68f828266 drm/radeon/ttm: use multihop
> =

> Which is what I would naturally expect here, but no idea what the official
> format should be.

dim cite $sha1 is our attempt at modelling it. And yeah it's just
bikeshedded differently for no good reason. And I just noticed that dim
cite doesn't include the commit before the sha1.
-Daniel

> =

> Christian.
> =

> > -Daniel
> > =

> > > > > Btw
> > > > > =

> > > > > $ dim fixes [sha1]
> > > > > =

> > > > > generates that for you plus nice cc list of offenders. With the F=
ixes
> > > > > line added:
> > > > > =

> > > > > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > > Thanks,
> > > Christian.
> > > =

> =


-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

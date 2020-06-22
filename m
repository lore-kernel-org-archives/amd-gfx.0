Return-Path: <SRS0=8rPh=AD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA39C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 14:24:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F5FE20720
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 14:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="i0IOWNGG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5FE20720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C05C86E819;
	Mon, 22 Jun 2020 14:24:50 +0000 (UTC)
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4586E6E819
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2020 14:24:50 +0000 (UTC)
Received: by mail-oi1-x243.google.com with SMTP id k4so15784755oik.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2020 07:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Pq0o845q+TFQnWFAED4xcPE0QdHR/oMejdmFT1x2Uzs=;
 b=i0IOWNGGdNTWcqQLuW+vUKnjl4aKC1xOUiF70Mp2zvzwru/EEg0bXrrXPmy3GeMiCn
 IU1HdQYfoeJZFsm8ACrVC6IMustvrxDtVvaP4+WDTrSNcF/dhMevovEJxw+P1MqTb7GT
 tg9eszkYj/qY5Qtmv8RuOsDCGlHXy0hbkcrvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Pq0o845q+TFQnWFAED4xcPE0QdHR/oMejdmFT1x2Uzs=;
 b=HIeOcnE25DxVUuHeiJVO596O/3RnUUEQysnSc5Rtj7pyCjif8DeTh6+EsJbbe07gug
 RfkPmiZLLZe0qBbB65wgoy+CzIpKeqFifBPQJCE+trzo2qB9gUhtdb7sveRKoB6co/jz
 SMCQHoXWC84VBbpKUfq7ficH4J8wrEb90AAYip0QQZy4Einfi2z6tuWBaX6DlAViDrkZ
 zZWISrUTccEvyOVSJlD6MtQupQ3UQwCpN5a8kGySud5PY5n8kDO9vxbtl/9aozLfXjMB
 svL9Xe0tpqNW5nTY1W1CZ4bxMMK7GzT9JIhVcIoYaW4mGuBXx6KZYep23exKmXO3Pz0y
 JhKw==
X-Gm-Message-State: AOAM531GlF05TcDIkF847A8PJhvxfbU4KblaXOQ3xY+Ss1Say9ZSd3th
 IH3T4gi5khyO8XScAdR2a74LddBJhfaDJqEaF/ZYYw==
X-Google-Smtp-Source: ABdhPJxynmWvG+o/4EbTUhESpNF8T0bjh0oo/UhhSp2gK3yu79zD1BCCEtPMCyC+Sd6x2stT7jV4+WgNcwRpv720yEI=
X-Received: by 2002:aca:ad97:: with SMTP id
 w145mr12706039oie.128.1592835889599; 
 Mon, 22 Jun 2020 07:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <1592719388-13819-1-git-send-email-andrey.grodzovsky@amd.com>
 <1592719388-13819-2-git-send-email-andrey.grodzovsky@amd.com>
 <20200622093501.GZ20149@phenom.ffwll.local> <20200622172157.49b835ca@eldfell>
In-Reply-To: <20200622172157.49b835ca@eldfell>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Mon, 22 Jun 2020 16:24:38 +0200
Message-ID: <CAKMK7uG+RTRZ39na3GO7OWiUASokEhe0Ndkex9vNOMj7R34Dwg@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] drm: Add dummy page per device or GEM object
To: Pekka Paalanen <ppaalanen@gmail.com>
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexdeucher@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jun 22, 2020 at 4:22 PM Pekka Paalanen <ppaalanen@gmail.com> wrote:
>
> On Mon, 22 Jun 2020 11:35:01 +0200
> Daniel Vetter <daniel@ffwll.ch> wrote:
>
> > On Sun, Jun 21, 2020 at 02:03:01AM -0400, Andrey Grodzovsky wrote:
> > > Will be used to reroute CPU mapped BO's page faults once
> > > device is removed.
> > >
> > > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> > > ---
> > >  drivers/gpu/drm/drm_file.c  |  8 ++++++++
> > >  drivers/gpu/drm/drm_prime.c | 10 ++++++++++
> > >  include/drm/drm_file.h      |  2 ++
> > >  include/drm/drm_gem.h       |  2 ++
> > >  4 files changed, 22 insertions(+)
>
> ...
>
> > > diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> > > index 0b37506..47460d1 100644
> > > --- a/include/drm/drm_gem.h
> > > +++ b/include/drm/drm_gem.h
> > > @@ -310,6 +310,8 @@ struct drm_gem_object {
> > >      *
> > >      */
> > >     const struct drm_gem_object_funcs *funcs;
> > > +
> > > +   struct page *dummy_page;
> > >  };
> >
> > I think amdgpu doesn't care, but everyone else still might care somewhat
> > about flink. That also shares buffers, so also needs to allocate the
> > per-bo dummy page.
>
> Do you really care about making flink not explode on device
> hot-unplug? Why not just leave flink users die in a fire?
> It's not a regression.

It's not about exploding, they won't. With flink you can pass a buffer
from one address space to the other, so imo we should avoid false
sharing. E.g. if you happen to write something $secret into a private
buffer, but only $non-secret stuff into shared buffers. Then if you
unplug, your well-kept $secret might suddenly be visible by lots of
other processes you never intended to share it with.

Just feels safer to plug that hole completely.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

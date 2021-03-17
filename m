Return-Path: <SRS0=2fSF=IP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C254FC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 20:32:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6133C64D79
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 20:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6133C64D79
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A73E66E847;
	Wed, 17 Mar 2021 20:32:51 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D2846E846
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 20:32:50 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 m21-20020a9d7ad50000b02901b83efc84a0so3062554otn.10
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 13:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IHCnunVxEHDcq+HTDx4ulePq7olKHfoa4KrEracuGEE=;
 b=F3jWDKeZzOEZZV+TtU/QAqYOuYjLzlwHXLJOUphmL/VTnC00lws/xyjCQFL1MFzEIq
 cOmU8WIgXcWr8H47lTCo4CJ6guTqcA2xR8IVXUiA4RT0KOFJNwKrTI7IziG13bdXuDmh
 1mV45jQA3sCOkiQ18AaiLVLPMdYLhTJRLR/3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IHCnunVxEHDcq+HTDx4ulePq7olKHfoa4KrEracuGEE=;
 b=iWfWZX/FB3j4PNRutkwCwFtfa0liUmsJe3hXvRUpJT8LWIX8Fr2PEI5cBB+Q7Rll5o
 JgEHA7zzVtat2Bjz//2UPvm/VJS5EBlgMIr8/ML7FxceVWUrSs4xn0nIGdWCPNkkFcka
 W9W27nkUlxSh/vzRWY/Chn+cVrfG8voGzOX9OfGYk6FQsPuQpya4bb2fxVXBTOvg7m/M
 XXukNLrG0eA8285otbxz9rusNIvVy5QrYr6K+MPPMzOgYb3aOBFhg9QeU6L7QrYS8uC+
 AYYlibuUurG0RwCXwHZZlyaESEr7nGWF5vq48dk7W+CuZ8u6FTiyFupxo/wXAoytibo1
 K5+w==
X-Gm-Message-State: AOAM532cfzhyGH6oj+PMjU0FWV+AqAgZuKhmH5k0BHvmAn4aj4znhzzS
 dG+SPZ4Cc3uFZQCalQGvk+Rwnuft8tIzi0lpaLWnDA==
X-Google-Smtp-Source: ABdhPJwpaKtWZD5ndm43ILhNLn5AjG91euFm+8cd3zhFc4Jg9VKRXCNzX5CQhv6Shjqegj6++qTq+qWnq/5dHW2jDuI=
X-Received: by 2002:a9d:6481:: with SMTP id g1mr4590503otl.303.1616013169521; 
 Wed, 17 Mar 2021 13:32:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210303134319.3160762-1-lee.jones@linaro.org>
 <16d4300e-bf29-1e85-317b-53d257890cb9@vmware.com> <20210308091932.GB4931@dell>
 <YEobySvG0zPs9xhc@phenom.ffwll.local> <20210311135152.GT701493@dell>
 <20210317081729.GH701493@dell>
In-Reply-To: <20210317081729.GH701493@dell>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 17 Mar 2021 21:32:38 +0100
Message-ID: <CAKMK7uEibsgXXTEM1d2CGSswp-koouPSouseP_rwLHTdpxfRpw@mail.gmail.com>
Subject: Re: [RESEND 00/53] Rid GPU from W=1 warnings
To: Lee Jones <lee.jones@linaro.org>
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
Cc: David Airlie <airlied@linux.ie>,
 Nouveau Dev <nouveau@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Qinglang Miao <miaoqinglang@huawei.com>, Anthony Koo <Anthony.Koo@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, Jeremy Kolb <jkolb@brandeis.edu>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Rob Clark <rob.clark@linaro.org>,
 VMware Graphics <linux-graphics-maintainer@vmware.com>,
 Ben Skeggs <bskeggs@redhat.com>, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Dave Airlie <airlied@redhat.com>, Harry Wentland <harry.wentland@amd.com>,
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>,
 Leo Li <sunpeng.li@amd.com>, Roland Scheidegger <sroland@vmware.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Sean Paul <sean@poorly.run>, Kuogee Hsieh <khsieh@codeaurora.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Clark <robdclark@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Alex Deucher <alexander.deucher@amd.com>,
 Colin Ian King <colin.king@canonical.com>,
 freedreno <freedreno@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Zack Rusin <zackr@vmware.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 17, 2021 at 9:17 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Thu, 11 Mar 2021, Lee Jones wrote:
>
> > On Thu, 11 Mar 2021, Daniel Vetter wrote:
> >
> > > On Mon, Mar 08, 2021 at 09:19:32AM +0000, Lee Jones wrote:
> > > > On Fri, 05 Mar 2021, Roland Scheidegger wrote:
> > > >
> > > > > The vmwgfx ones look all good to me, so for
> > > > > 23-53: Reviewed-by: Roland Scheidegger <sroland@vmware.com>
> > > > > That said, they were already signed off by Zack, so not sure what
> > > > > happened here.
> > > >
> > > > Yes, they were accepted at one point, then dropped without a reason.
> > > >
> > > > Since I rebased onto the latest -next, I had to pluck them back out of
> > > > a previous one.
> > >
> > > They should show up in linux-next again. We merge patches for next merge
> > > window even during the current merge window, but need to make sure they
> > > don't pollute linux-next. Occasionally the cut off is wrong so patches
> > > show up, and then get pulled again.
> > >
> > > Unfortunately especially the 5.12 merge cycle was very wobbly due to some
> > > confusion here. But your patches should all be in linux-next again (they
> > > are queued up for 5.13 in drm-misc-next, I checked that).
> > >
> > > Sorry for the confusion here.
> >
> > Oh, I see.  Well so long as they don't get dropped, I'll be happy.
> >
> > Thanks for the explanation Daniel
>
> After rebasing today, all of my GPU patches have remained.  Would
> someone be kind enough to check that everything is still in order
> please?

It's still broken somehow. I've kiced Maxime and Maarten again,
they're also on this thread.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

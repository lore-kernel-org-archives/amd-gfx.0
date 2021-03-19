Return-Path: <SRS0=mZ+C=IR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D151C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 17:55:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CABE16197E
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 17:55:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CABE16197E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 572FB6EA6C;
	Fri, 19 Mar 2021 17:55:24 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BDCA6EA61
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 17:55:22 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 y124-20020a1c32820000b029010c93864955so7759733wmy.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 10:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:in-reply-to;
 bh=H4E5zo6M+sGFb9jJfPuBMekAUt72xfRBAZEVdNXvosI=;
 b=HkWCKtqano6hr83mTvHPNb1mTJD7j++xG4i3V1pZc+fMnH//eWACXOeqWIMYDAyiqD
 CWBkqUiJ1zmtZ3OlxFIY9DcUS/euNcLz8nxn4AxgvZ1rE5qJAgMaRKnutzlS1iCHVLZf
 S1ATj65HkMPVN9VP3K+xuo111cO9NYWhg1scM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=H4E5zo6M+sGFb9jJfPuBMekAUt72xfRBAZEVdNXvosI=;
 b=kRnSrv0Wmc3Rm3H5oKSkjJJwTI79xS6DxS+Q/7OWrpMM4UEoHZoYI9kvRupLck+xji
 9byV3rkvKi3xPFxkbY6fWOo7SbC325jlLCTQyve+qlySXRo1RpHm761/Ll0J6UNXIOnT
 +QcnuyHtQ0nWBklZWTLwR7GL6e1yca/Ilqvbo2PuWa3bhQ8z+8LdZ3zFTrUBQOhlC9sd
 EQh9sI9hMsx60VZon/+jDC9J/hTseGMn6pEr4JmNwI3bp12WcnIh2K1a53RSZMqFvQL4
 zSDEwSnNhQDBVn7YvFKBYznscK8wc5rtqAVBRUqi0T7w7fFmUY9Dg3IOFmTH3BU2CLSL
 PJpQ==
X-Gm-Message-State: AOAM530ZCRBHnt/ktRMEafTcPFI9KCJrsN+5YNNDFQnINsCWo4a4mftr
 hDmjX9/A1QKM5nOfkt1qdFBG8A==
X-Google-Smtp-Source: ABdhPJznH8/2o31By7revAgfT3dpRwhrdpC+rY/yFumwMUBtQGtz1iOu7IVxYDezg1HGlBR9UX23fg==
X-Received: by 2002:a7b:c0c3:: with SMTP id s3mr4743813wmh.11.1616176521069;
 Fri, 19 Mar 2021 10:55:21 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id s3sm7109143wmd.21.2021.03.19.10.55.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Mar 2021 10:55:20 -0700 (PDT)
Date: Fri, 19 Mar 2021 18:55:18 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RESEND 00/53] Rid GPU from W=1 warnings
Message-ID: <YFTlhh1ZSFffO+Nr@phenom.ffwll.local>
Mail-Followup-To: Lee Jones <lee.jones@linaro.org>,
 Roland Scheidegger <sroland@vmware.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Anthony Koo <Anthony.Koo@amd.com>, Ben Skeggs <bskeggs@redhat.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Colin Ian King <colin.king@canonical.com>,
 Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 freedreno <freedreno@lists.freedesktop.org>,
 Harry Wentland <harry.wentland@amd.com>,
 Jeremy Kolb <jkolb@brandeis.edu>,
 Kuogee Hsieh <khsieh@codeaurora.org>, Leo Li <sunpeng.li@amd.com>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>,
 Lyude Paul <lyude@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Nouveau Dev <nouveau@lists.freedesktop.org>,
 Qinglang Miao <miaoqinglang@huawei.com>,
 Rob Clark <rob.clark@linaro.org>, Rob Clark <robdclark@gmail.com>,
 Sean Paul <sean@poorly.run>, Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 VMware Graphics <linux-graphics-maintainer@vmware.com>,
 Zack Rusin <zackr@vmware.com>
References: <20210303134319.3160762-1-lee.jones@linaro.org>
 <16d4300e-bf29-1e85-317b-53d257890cb9@vmware.com>
 <20210308091932.GB4931@dell> <YEobySvG0zPs9xhc@phenom.ffwll.local>
 <20210311135152.GT701493@dell> <20210317081729.GH701493@dell>
 <CAKMK7uEibsgXXTEM1d2CGSswp-koouPSouseP_rwLHTdpxfRpw@mail.gmail.com>
 <CAKMK7uHkJGDL8k3FfAqAM78honZR0euMcacW8UpdPZfS1J-7cA@mail.gmail.com>
 <20210319082407.GG2916463@dell>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210319082407.GG2916463@dell>
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
 Thomas Zimmermann <tzimmermann@suse.de>, Leo Li <sunpeng.li@amd.com>,
 Roland Scheidegger <sroland@vmware.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Sean Paul <sean@poorly.run>, Kuogee Hsieh <khsieh@codeaurora.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Clark <robdclark@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Colin Ian King <colin.king@canonical.com>,
 freedreno <freedreno@lists.freedesktop.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Zack Rusin <zackr@vmware.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Mar 19, 2021 at 08:24:07AM +0000, Lee Jones wrote:
> On Thu, 18 Mar 2021, Daniel Vetter wrote:
> 
> > On Wed, Mar 17, 2021 at 9:32 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> > >
> > > On Wed, Mar 17, 2021 at 9:17 AM Lee Jones <lee.jones@linaro.org> wrote:
> > > >
> > > > On Thu, 11 Mar 2021, Lee Jones wrote:
> > > >
> > > > > On Thu, 11 Mar 2021, Daniel Vetter wrote:
> > > > >
> > > > > > On Mon, Mar 08, 2021 at 09:19:32AM +0000, Lee Jones wrote:
> > > > > > > On Fri, 05 Mar 2021, Roland Scheidegger wrote:
> > > > > > >
> > > > > > > > The vmwgfx ones look all good to me, so for
> > > > > > > > 23-53: Reviewed-by: Roland Scheidegger <sroland@vmware.com>
> > > > > > > > That said, they were already signed off by Zack, so not sure what
> > > > > > > > happened here.
> > > > > > >
> > > > > > > Yes, they were accepted at one point, then dropped without a reason.
> > > > > > >
> > > > > > > Since I rebased onto the latest -next, I had to pluck them back out of
> > > > > > > a previous one.
> > > > > >
> > > > > > They should show up in linux-next again. We merge patches for next merge
> > > > > > window even during the current merge window, but need to make sure they
> > > > > > don't pollute linux-next. Occasionally the cut off is wrong so patches
> > > > > > show up, and then get pulled again.
> > > > > >
> > > > > > Unfortunately especially the 5.12 merge cycle was very wobbly due to some
> > > > > > confusion here. But your patches should all be in linux-next again (they
> > > > > > are queued up for 5.13 in drm-misc-next, I checked that).
> > > > > >
> > > > > > Sorry for the confusion here.
> > > > >
> > > > > Oh, I see.  Well so long as they don't get dropped, I'll be happy.
> > > > >
> > > > > Thanks for the explanation Daniel
> > > >
> > > > After rebasing today, all of my GPU patches have remained.  Would
> > > > someone be kind enough to check that everything is still in order
> > > > please?
> > >
> > > It's still broken somehow. I've kiced Maxime and Maarten again,
> > > they're also on this thread.
> > 
> > You're patches have made it into drm-next meanwhile, so they should
> > show up in linux-next through that tree at least. Except if that one
> > also has some trouble.
> 
> Thanks for letting me know.
> 
> I see some patches made it back in, others didn't.
> 
> I'll resend the stragglers - bear with.

The vmwgfx ones should all be back, the others I guess just werent ever
applied. I'll vacuum them all up if you resend. Apologies for the wobbly
ride.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B26CC3F2CD
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 17:51:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 500352469F
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 17:51:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 500352469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A4F66F4A5;
	Fri, 28 Feb 2020 17:51:35 +0000 (UTC)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 881976EF39;
 Fri, 28 Feb 2020 11:02:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kusma) with ESMTPSA id 8117329695C
Message-ID: <6761e107fda6af2f70f0a11784e182dfbc61cb0e.camel@collabora.com>
Subject: Re: [Mesa-dev] [Intel-gfx] gitlab.fd.o financial situation and
 impact on services
From: Erik Faye-Lund <erik.faye-lund@collabora.com>
To: Daniel Stone <daniel@fooishbar.org>
Date: Fri, 28 Feb 2020 12:02:34 +0100
In-Reply-To: <CAPj87rO7BuKQj2Kei3T7RdkFq5=TiuShBvtrPU2sn0iqMfXSTg@mail.gmail.com>
References: <CAKMK7uHHK2SsCfpmZwEUyTJJHsoccKoadoko3cEBOoYDFkmeAw@mail.gmail.com>
 <CAPM=9txcGPvFdSzMtYZXyqLKnWyacSMuHdoXdV63M53fLFVFpw@mail.gmail.com>
 <b398161ff7d0268454413058dc6c194cf93f5990.camel@collabora.com>
 <ece8ebe3-40ec-2457-02da-4fef19cbe8f6@intel.com>
 <6d2ec570f957b4504fb70e0b1f0632712a99dc0c.camel@collabora.com>
 <CAPj87rO7BuKQj2Kei3T7RdkFq5=TiuShBvtrPU2sn0iqMfXSTg@mail.gmail.com>
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 28 Feb 2020 17:51:34 +0000
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 intel-gfx <intel-gfx@lists.freedesktop.org>,
 "X.Org development" <xorg-devel@lists.x.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 wayland <wayland-devel@lists.freedesktop.org>,
 "X.Org Foundation Board" <board@foundation.x.org>,
 Xorg Members List <members@x.org>,
 Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
 Mesa Dev <mesa-dev@lists.freedesktop.org>, Dave Airlie <airlied@gmail.com>,
 gstreamer-devel@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, 2020-02-28 at 10:43 +0000, Daniel Stone wrote:
> On Fri, 28 Feb 2020 at 10:06, Erik Faye-Lund
> <erik.faye-lund@collabora.com> wrote:
> > On Fri, 2020-02-28 at 11:40 +0200, Lionel Landwerlin wrote:
> > > Yeah, changes on vulkan drivers or backend compilers should be
> > > fairly
> > > sandboxed.
> > > 
> > > We also have tools that only work for intel stuff, that should
> > > never
> > > trigger anything on other people's HW.
> > > 
> > > Could something be worked out using the tags?
> > 
> > I think so! We have the pre-defined environment variable
> > CI_MERGE_REQUEST_LABELS, and we can do variable conditions:
> > 
> > https://docs.gitlab.com/ee/ci/yaml/#onlyvariablesexceptvariables
> > 
> > That sounds like a pretty neat middle-ground to me. I just hope
> > that
> > new pipelines are triggered if new labels are added, because not
> > everyone is allowed to set labels, and sometimes people forget...
> 
> There's also this which is somewhat more robust:
> https://gitlab.freedesktop.org/mesa/mesa/merge_requests/2569
> 
> 

I'm not sure it's more robust, but yeah that a useful tool too.

The reason I'm skeptical about the robustness is that we'll miss
testing if this misses a path. That can of course be fixed by testing
everything once things are in master, and fixing up that list when
something breaks on master.

The person who wrote a change knows more about the intricacies of the
changes than a computer will ever do. But humans are also good at
making mistakes, so I'm not sure which one is better. Maybe the union
of both?

As long as we have both rigorous testing after something landed in
master (doesn't nessecarily need to happen right after, but for now
that's probably fine), as well as a reasonable heuristic for what
testing is needed pre-merge, I think we're good.

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

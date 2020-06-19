Return-Path: <SRS0=a8HN=AA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BDDC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 09:14:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A597207FC
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 09:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A597207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chris-wilson.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3B5C6EC4C;
	Fri, 19 Jun 2020 09:14:08 +0000 (UTC)
Received: from fireflyinternet.com (mail.fireflyinternet.com [109.228.58.192])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 895676EC4C;
 Fri, 19 Jun 2020 09:14:07 +0000 (UTC)
X-Default-Received-SPF: pass (skip=forwardok (res=PASS))
 x-ip-name=78.156.65.138; 
Received: from localhost (unverified [78.156.65.138]) 
 by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id
 21546831-1500050 for multiple; Fri, 19 Jun 2020 10:13:39 +0100
MIME-Version: 1.0
In-Reply-To: <CAKMK7uHEwj6jiZkRZ5PaCUNWcuU9oE4KYm4XHZwHnFzEuChZ7w@mail.gmail.com>
References: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
 <20200604081224.863494-4-daniel.vetter@ffwll.ch>
 <159186243606.1506.4437341616828968890@build.alporthouse.com>
 <CAPM=9ty6r1LuXAH_rf98GH0R9yN3x8xzKPjZG3QyvokpQBR-Hg@mail.gmail.com>
 <CAPj87rM0S2OPssf+WA+pjanT-0Om3yuUM1zUJCv4qTx5VYE=Fw@mail.gmail.com>
 <159255511144.7737.12635440776531222029@build.alporthouse.com>
 <CAKMK7uHEwj6jiZkRZ5PaCUNWcuU9oE4KYm4XHZwHnFzEuChZ7w@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH 03/18] dma-fence: basic lockdep annotations
From: Chris Wilson <chris@chris-wilson.co.uk>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Message-ID: <159255801588.7737.4425728073225310839@build.alporthouse.com>
User-Agent: alot/0.8.1
Date: Fri, 19 Jun 2020 10:13:35 +0100
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
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, linux-rdma <linux-rdma@vger.kernel.org>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>, Thomas Hellstrom <thomas.hellstrom@intel.com>, Daniel Stone <daniel@fooishbar.org>, Daniel Vetter <daniel.vetter@intel.com>, Mika Kuoppala <mika.kuoppala@intel.com>, Dave Airlie <airlied@gmail.com>, Christian König <christian.koenig@amd.com>, Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Quoting Daniel Vetter (2020-06-19 09:51:59)
> On Fri, Jun 19, 2020 at 10:25 AM Chris Wilson <chris@chris-wilson.co.uk> wrote:
> > Forcing a generic primitive to always be part of the same global map is
> > horrible.
> 
> And  no concrete example or reason for why that's not possible.
> Because frankly it's not horrible, this is what upstream is all about:
> Shared concepts, shared contracts, shared code.
> 
> The proposed patches might very well encode the wrong contract, that's
> all up for discussion. But fundamentally questioning that we need one
> is missing what upstream is all about.

Then I have not clearly communicated, as my opinion is not that
validation is worthless, but that the implementation is enshrining a
global property on a low level primitive that prevents it from being
used elsewhere. And I want to replace completion [chains] with fences, and
bio with fences, and closures with fences, and what other equivalencies
there are in the kernel. The fence is as central a locking construct as
struct completion and deserves to be a foundational primitive provided
by kernel/ used throughout all drivers for discrete problem domains.

This is narrowing dma_fence whereby adding
	struct lockdep_map *dma_fence::wait_map
and annotating linkage, allows you to continue to specify that all
dma_fence used for a particular purpose must follow common rules,
without restricting the primitive for uses outside of this scope.
-Chris
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

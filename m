Return-Path: <SRS0=7JJ9=7Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13B0C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2020 14:21:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C18B52065C
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2020 14:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PR0gi9LB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C18B52065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7320E6E910;
	Thu, 11 Jun 2020 14:21:28 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BC4D6E91D
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2020 14:15:18 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id c185so5669221qke.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2020 07:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=KdY4CqOeXBwEiWOcFlqbqG5is4zfH8IsaBHV/GBHIHQ=;
 b=PR0gi9LBQQMt96kk5vRqeFR+V5WYHc55goGq7/IDrxkd9Rh9/YG4b34BFLq0d+yZak
 BzFk4zfLtE+kjSjyF7+exbUyisWbPZy/yiLvO6PtXdNGgJHOY8zf+OZ+iAubr5+Tx4Lg
 D4HeiosK8RaYH70wLLBoyGznPMMuJUn0V+ocWO9N930QQt7fPPBvGVsW8vOLNjXPWLRJ
 HkUS7exwuBnCFIc1OZ028wKpj25WTPUot6ReBMtdHn/iN8mcZwnlTrlzELhcNeGkhWGY
 TFje4r50V7bjdc94j0MAgMsh5GCFD+me2eO4hQx0IUtZreCgJFCWBiuSwLKGsBDoHK5K
 Bujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KdY4CqOeXBwEiWOcFlqbqG5is4zfH8IsaBHV/GBHIHQ=;
 b=SMrxBDkpRtIWamot706WHO2PomH+B0fQI8EJbYeO08RYoodgsD1vhxMvVYg32WpnuL
 1U1ovVECbTIhvuzsgL9xgl2clj7dLCs7cETIj+3Hx2Tuhv3JRm6CvB5G4Y1z67iiYchx
 nOIXFyd+tG5jLbChx9pE0kU9BPE1RPFOvb9B829yGQC7gcC7K0a6TkPWcucYnG0KdWHu
 EwK7AmcMPG+JMqiIdbbQKy3gBo7vA7EFSbagFAUDo1jSYLOk1E3S1qMrsm8GmtSlTYTm
 EKvrO3mqT8EvF05FxiMunQi5CXBrAQaSZhZwPnYsGAhu0gopGipCfwxKQr8gYfXRRlIy
 lIdg==
X-Gm-Message-State: AOAM530fULQJmmtMsbn/J7b5XRF7C0l9nHcc9/IUNmLWWXKh5e415gX8
 KEj1xVlNpK6KzNRbV8xpj6AoqA==
X-Google-Smtp-Source: ABdhPJwayNj1HFNzuKaP5QQLXWWEv6Z+gHXsBE1qPL3LYHDQquNuTclWXHUZlWr93wqBBawpSND6wg==
X-Received: by 2002:ae9:efc2:: with SMTP id d185mr8655279qkg.177.1591884917518; 
 Thu, 11 Jun 2020 07:15:17 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [156.34.48.30])
 by smtp.gmail.com with ESMTPSA id d16sm2634050qte.49.2020.06.11.07.15.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 07:15:16 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93) (envelope-from <jgg@ziepe.ca>)
 id 1jjNz9-005wvW-Ge; Thu, 11 Jun 2020 11:15:15 -0300
Date: Thu, 11 Jun 2020 11:15:15 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Thomas =?utf-8?B?SGVsbHN0csO2bSAoSW50ZWwp?= <thomas_os@shipmail.org>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 linux-rdma@vger.kernel.org,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org,
 Thomas Hellstrom <thomas.hellstrom@intel.com>,
 Daniel Vetter <daniel.vetter@intel.com>, linux-media@vger.kernel.org,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Mika Kuoppala <mika.kuoppala@intel.com>
Subject: Re: [Linaro-mm-sig] [PATCH 04/18] dma-fence: prime lockdep annotations
Message-ID: <20200611141515.GW6578@ziepe.ca>
References: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
 <20200604081224.863494-5-daniel.vetter@ffwll.ch>
 <b11c2140-1b9c-9013-d9bb-9eb2c1906710@shipmail.org>
 <20200611083430.GD20149@phenom.ffwll.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200611083430.GD20149@phenom.ffwll.local>
X-Mailman-Approved-At: Thu, 11 Jun 2020 14:21:27 +0000
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jun 11, 2020 at 10:34:30AM +0200, Daniel Vetter wrote:
> > I still have my doubts about allowing fence waiting from within shrinkers.
> > IMO ideally they should use a trywait approach, in order to allow memory
> > allocation during command submission for drivers that
> > publish fences before command submission. (Since early reservation object
> > release requires that).
> 
> Yeah it is a bit annoying, e.g. for drm/scheduler I think we'll end up
> with a mempool to make sure it can handle it's allocations.
> 
> > But since drivers are already waiting from within shrinkers and I take your
> > word for HMM requiring this,
> 
> Yeah the big trouble is HMM and mmu notifiers. That's the really awkward
> one, the shrinker one is a lot less established.

I really question if HW that needs something like DMA fence should
even be using mmu notifiers - the best use is HW that can fence the
DMA directly without having to get involved with some command stream
processing.

Or at the very least it should not be a generic DMA fence but a
narrowed completion tied only into the same GPU driver's command
completion processing which should be able to progress without
blocking.

The intent of notifiers was never to endlessly block while vast
amounts of SW does work.

Going around and switching everything in a GPU to GFP_ATOMIC seems
like bad idea.

> I've pinged a bunch of armsoc gpu driver people and ask them how much this
> hurts, so that we have a clear answer. On x86 I don't think we have much
> of a choice on this, with userptr in amd and i915 and hmm work in nouveau
> (but nouveau I think doesn't use dma_fence in there). 

Right, nor will RDMA ODP. 

Jason
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

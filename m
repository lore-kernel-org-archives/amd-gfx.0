Return-Path: <SRS0=a8HN=AA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83770C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 17:23:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56C92208D5
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 17:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jQ8P3pnI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56C92208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E1C96E0ED;
	Fri, 19 Jun 2020 17:23:50 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90DF76E3E7
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2020 17:23:10 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id q198so1832254qka.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2020 10:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=rta7XgSy0ckbOhf+G5R08zHN2raoo0kZf2xw2Sh0l/k=;
 b=jQ8P3pnIGa3vZkblMbXH41QZ61fe/Sb9vA5uPOR3SMNdZKsu0blkPtrxpS3aWVoNKr
 DxLMI5S5juOldxRe7+RlT3GajySSEpNFCHak6ENUR11aQ3nJENjJ+AjGwVIg3GcU1gtL
 AFg4tJnhN/LzdKUCOPE+zScs2pSCySWCm6gLf1r8dvVDgTF8uLAu4b0cSB8SVQcBr9IO
 hvo365OipT4dztwxdexoBi2dZXF91j/xcy5DKKz/ErbusQM/iZVWPTDKzHQRUnZ5G+PQ
 1Vw552gg3QCopo/fc6PBC9ArUokmC/IBfhMuddzwZFS3/FrWylp92kucX6mn/XCcEkQF
 2/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rta7XgSy0ckbOhf+G5R08zHN2raoo0kZf2xw2Sh0l/k=;
 b=DdJx98CXuGTqMq4a8WBzZqu9WwYvRDiR41sR+EGYtF/3BRwOhGHNplVTE3spyehvTu
 QbSwwiQ0GbgbvfeaKxEUNy1CNu0cWJXi3yGK5G9a0IHdHahwuQyGfd0VJ/URaii4P6P3
 WIGHnBs+4PiOKJncVKbrTnMchHhbeqYp4MAUAhPbkr9PRWrqE/IpSrJ5wHCEhzBXFD4E
 WC7b6VRps3RpWGWhcSsS5adtWxUIo9GZ5i528IITDmbMvfYdrFPWVVjeArxGmnAMGWaF
 QKxPUjaHrSfnii85vh2V/1NWRqMXP1U2pCFKznDAH2DccFaXWWbwKtxlJ+ZZadYU9cgr
 /gHw==
X-Gm-Message-State: AOAM532cg7d+rivcrWZ4f2KCmtfNPpde19eLzzzESn70wHnyxCl2zmf3
 d0+IGRFWeQrN4Yji2WuwMIV3OQ==
X-Google-Smtp-Source: ABdhPJzDMW9WT5FfWlenUCjhHpgpjiA2TJ2PiIGS5w9RkI8RANL7HnmArRn+HLKwhDBh+PaKr6DrLw==
X-Received: by 2002:ae9:ed0d:: with SMTP id c13mr4076677qkg.181.1592587389664; 
 Fri, 19 Jun 2020 10:23:09 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [156.34.48.30])
 by smtp.gmail.com with ESMTPSA id z77sm7263705qka.59.2020.06.19.10.23.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2020 10:23:08 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93) (envelope-from <jgg@ziepe.ca>)
 id 1jmKjM-00ArZ4-2Z; Fri, 19 Jun 2020 14:23:08 -0300
Date: Fri, 19 Jun 2020 14:23:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [Linaro-mm-sig] [PATCH 04/18] dma-fence: prime lockdep annotations
Message-ID: <20200619172308.GQ6578@ziepe.ca>
References: <20200616120719.GL20149@phenom.ffwll.local>
 <CAKMK7uE7DKUo9Z+yCpY+mW5gmKet8ugbF3yZNyHGqsJ=e-g_hA@mail.gmail.com>
 <20200617152835.GF6578@ziepe.ca>
 <20200618150051.GS20149@phenom.ffwll.local>
 <20200618172338.GM6578@ziepe.ca>
 <CAKMK7uEbqTu4q-amkLXyd1i8KNtLaoO2ZFoGqYiG6D0m0FKpOg@mail.gmail.com>
 <20200619113934.GN6578@ziepe.ca>
 <CAKMK7uE-kWA==Cko5uenMrcnopEjq42HxoDTDywzBAbHqsN13g@mail.gmail.com>
 <20200619151551.GP6578@ziepe.ca>
 <CAKMK7uEvkshAM6KUYZu8_OCpF4+1Y_SM7cQ9nJWpagfke8s8LA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKMK7uEvkshAM6KUYZu8_OCpF4+1Y_SM7cQ9nJWpagfke8s8LA@mail.gmail.com>
X-Mailman-Approved-At: Fri, 19 Jun 2020 17:23:49 +0000
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
Cc: linux-rdma <linux-rdma@vger.kernel.org>,
 Thomas =?utf-8?B?SGVsbHN0csO2bSAoSW50ZWwp?= <thomas_os@shipmail.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Thomas Hellstrom <thomas.hellstrom@intel.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Daniel Vetter <daniel.vetter@intel.com>,
 Mika Kuoppala <mika.kuoppala@intel.com>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jun 19, 2020 at 06:19:41PM +0200, Daniel Vetter wrote:

> The madness is only that device B's mmu notifier might need to wait
> for fence_B so that the dma operation finishes. Which in turn has to
> wait for device A to finish first.

So, it sound, fundamentally you've got this graph of operations across
an unknown set of drivers and the kernel cannot insert itself in
dma_fence hand offs to re-validate any of the buffers involved?
Buffers which by definition cannot be touched by the hardware yet.

That really is a pretty horrible place to end up..

Pinning really is right answer for this kind of work flow. I think
converting pinning to notifers should not be done unless notifier
invalidation is relatively bounded. 

I know people like notifiers because they give a bit nicer performance
in some happy cases, but this cripples all the bad cases..

If pinning doesn't work for some reason maybe we should address that?

> Full disclosure: We are aware that we've designed ourselves into an
> impressive corner here, and there's lots of talks going on about
> untangling the dma synchronization from the memory management
> completely. But

I think the documenting is really important: only GPU should be using
this stuff and driving notifiers this way. Complete NO for any
totally-not-a-GPU things in drivers/accel for sure.

Jason
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

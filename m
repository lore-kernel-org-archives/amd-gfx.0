Return-Path: <SRS0=iwxs=L6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75857C07E96
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 16:32:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4541861C29
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 16:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4541861C29
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DB146E525;
	Tue,  6 Jul 2021 16:32:47 +0000 (UTC)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E66D6E4F4
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jul 2021 14:56:20 +0000 (UTC)
Received: by mail-il1-x129.google.com with SMTP id o10so21025725ils.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Jul 2021 07:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=a8/qLLqO6eL91stH3wL0KRpl9T08Ic+NpnQGQ6x06VA=;
 b=j2sPe5/YeFhkbk8Ao1wBoSJI3mHjTKeYtGS/ylikxffAh4pjlXAic9iDxRv5Mv0c88
 o5b7lMNG7FTsdoBh7D7HFqLBpXx4OWDvWQolA2AYbIKyYGFb/BJCIZ86BrUQNsb/C3Zk
 XsAk6eIa1iX7IreWpvN3CU6N8yZIaUepsXSqCVxrBMKOSQwVo+4QlVdlIX3ICQnCZ+RN
 LgJrLxii8/f54h0waeGuOrMJGYXgQlD5kGp/v5vw+plNVj3amj0GPy79B+VVJnzMwf0X
 slP6aAspIJPeReLpfjtTCTHLR7t2wU8m1oRA1naFZ3fVxAxznodtagNFx7SXVX3ixwEZ
 eBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=a8/qLLqO6eL91stH3wL0KRpl9T08Ic+NpnQGQ6x06VA=;
 b=e/MFhB/RXGc5K8K9XEmfpyFNf67GviWEsNf6hnw4RpejP7MtRaoR3BupnIKTq28X4T
 TUcZdO2SJxVlALilHHLk4BSHu3LDRzFFr9Cyh5xrxg/8HFB7JlgKreF19oAwH96k/24H
 mZudJnyCs5Wc26K4Z0MG4namC4+3pjQZhk7hQGM/04Op2GfXkeiREqAHY+1RcQ9j+fCi
 TrvoA4CDWz/u+izihk/0p5lkN8cr0GahNqN2HfdyWyW1fEFaGJWQ6TdncKvxUl3aL4X0
 s6yNO8sm5oY4D7K6QrNqn4dVcz3OJ4xceWkZKAotEv3WGdi2OWU3ghkrgQK4YDVqRC28
 bAzw==
X-Gm-Message-State: AOAM531/R3QvN22ksOsZDwD8eluejapj/xHeL+/nKLn0Jg2l3QmC79Gi
 RJ/iwl2gRrF/jNMMDBkpcnKTtw==
X-Google-Smtp-Source: ABdhPJwog3epP3zDyPdL9Dn1Mv3QQbO1xKAP/j5dh3/z+a/bJ15P6+dhr9KB3Du7HHV3+Ab4fMGLOg==
X-Received: by 2002:a92:dd05:: with SMTP id n5mr14308230ilm.72.1625583379441; 
 Tue, 06 Jul 2021 07:56:19 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id l18sm8626632ilo.64.2021.07.06.07.56.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jul 2021 07:56:19 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1m0mUj-004Rth-V9; Tue, 06 Jul 2021 11:56:17 -0300
Date: Tue, 6 Jul 2021 11:56:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH v4 0/2] Add p2p via dmabuf to habanalabs
Message-ID: <20210706145617.GO4604@ziepe.ca>
References: <20210705130314.11519-1-ogabbay@kernel.org>
 <YOQXBWpo3whVjOyh@phenom.ffwll.local>
 <CAFCwf10_rTYL2Fy6tCRVAUCf4-6_TtcWCv5gEEkGnQ0KxqMUBg@mail.gmail.com>
 <CAKMK7uEAJZUHNLreBB839BZOfnTGNU4rCx-0k55+67Nbxtdx3A@mail.gmail.com>
 <CAKMK7uHpKFVm55O_NB=WYCsv0iUt92ZUn6eCzifH=unbhe3J8g@mail.gmail.com>
 <CAKMK7uFGr=ugyKj0H3ctbh28Jnr25vAgXPBaDBMmfErCxYVo3w@mail.gmail.com>
 <20210706134430.GL4604@ziepe.ca>
 <CAKMK7uFEZjp2_WBhtkVxSNQ-1WcBSr3NDotY0fjz0iLRw8Barw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKMK7uFEZjp2_WBhtkVxSNQ-1WcBSr3NDotY0fjz0iLRw8Barw@mail.gmail.com>
X-Mailman-Approved-At: Tue, 06 Jul 2021 16:32:45 +0000
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
Cc: Oded Gabbay <oded.gabbay@gmail.com>, Gal Pressman <galpress@amazon.com>,
 sleybo@amazon.com, linux-rdma <linux-rdma@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Oded Gabbay <ogabbay@kernel.org>,
 "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Doug Ledford <dledford@redhat.com>, Christoph Hellwig <hch@lst.de>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@gmail.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Leon Romanovsky <leonro@nvidia.com>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jul 06, 2021 at 04:09:25PM +0200, Daniel Vetter wrote:
> Anyway, for anything that works like a gpu accelerator, like 3d accel,
> or parallel compute accel (aka gpgpu) or spatial compute accel (aka
> NN/AI) or maybe even fpga accel most of the magic to use the hardware
> is in this backend compiler, which translates from an IR into whatever
> your accelerator consumes. That's the part we really care about for
> modern accelerators because without that defacto the hardware is
> useless. Generally these chips have full-blown, if special purpose
> ISA, with register files, spilling, branches, loops and other control
> flow (sometimes only execution masks on simpler hw).

I don't know if I see it so clearly as you do - at the end of the day
the user keys in the program in some proprietary (or open!) language
and and wack of propritary magic transforms it to "make it work".

There are many barriers that prevent someone without the secret
knowledge from duplicating the end result of a working program. An
accelerator ISA is certainly one example, but I wouldn't overly focus
on it as the only blocker.

Like you said below the NVIDIA GPU ISA seems known but the HW is still
not really useful for other reasons.

Habana seems to have gone the other way, the HW is fully useful but we
don't have the ISA transformation and other details.

Both cases seem to have ended up with something useless, and I have a
hard time saying nouveau has more right to be in the kernel tree than
Habana does.

> > Honestly, I think GPU is approaching this backwards. Wayland should
> > have been designed to prevent proprietary userspace stacks.
> 
> That's not possible without some serious cans of worms though. Wayland
> is a protocol, and you can't forbid people from implementing it.
> Otherwise all the compatible open implementations of closed protocols
> wouldn't be possible either.

Well, in many ways so is Linux, but nobody would seriously
re-implement Linux just to produce a driver.

> So I'm not clear what you're suggesting here we should do different.

Not enabling proprietary stacks as above would be a good start.

Jason
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

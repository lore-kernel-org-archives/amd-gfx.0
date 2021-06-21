Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139E6C4743C
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 14:27:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A78B4600D4
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 14:27:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A78B4600D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AE4D6E195;
	Mon, 21 Jun 2021 14:27:46 +0000 (UTC)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31EDD6E182
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 14:17:59 +0000 (UTC)
Received: by mail-qt1-x833.google.com with SMTP id g12so13500006qtb.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 07:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=f5JgZDeoCfa2i8b2+lJPyccTDGeyU3UeQJEKpYqzmGw=;
 b=iW/qNwvjUN60qOdsm7Tc/2UgFmrbPL7i3tcOoqV4K4nAE5p++VtMzaD7tQUmZY5aS/
 08eVJcFISGR01jyo6CIqviQAi8/x8nwo8NCY7YrYTVakAPQRX4ny9mcq8xMudYSJADOQ
 h+yKiUXxtEnGjWiqtTAEO+fkAVZBXqOEiFWJnEcxmy2hkR14/qsVhyet4cLlhORAQjbS
 5b3b0Ub6MVs3bJel4J0zd7N6pAGiflA4WAmb2m/748JAvI/uviYVvmmbpTnenWCmngzg
 /0zm6jCnZ052zu8m26gQyrxVJtmvIX29vAGvfAg8myajT6QOMOcUsreOn1mLyatblaTF
 2yQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=f5JgZDeoCfa2i8b2+lJPyccTDGeyU3UeQJEKpYqzmGw=;
 b=Rg8uyBRhbGv63xw0JpfgL7QxjV9w09jnH0WmP+VujGrmTiLM2cX3j1kFwc5Z8iefqn
 5p7j2iIlLwOJzeIZ2kQF2tAPPvS/DB5VigKqF4TfN6Rfrt5crIF3SWs2ahoLV0v+vh0l
 LfR+129IuCM+jdLF9qQtQJ0YOWDTzgW+W+HzU19KubD1uOjFTOHPBixBP5wM/bQChKDj
 lIMK77XEzDygqEhxovm+sQVN9gtHxhCUPUhh7iMwktBdkEWD2xJebzJe8knQUlmmlopg
 9OErf2+VY/BeH3tB99C4Se3Wqto3XSLZpIHeX8HVHITkMuVXZ/Qbs51/2fOzZUZdQ+0V
 sKLw==
X-Gm-Message-State: AOAM530VnDculvHiOyd/VS8UZUa2X2h08OpOIB8GKNGmySDo0H+vdbin
 l53dkkvUI4/e5k5zsCHLiA3RhA==
X-Google-Smtp-Source: ABdhPJwxuJR5FNaFOeQuuTYdtMofIT5+18r8iXh+MV7YhfMRJf27n/x+7ThZDE3kkaBxOtliYq23Aw==
X-Received: by 2002:ac8:44ca:: with SMTP id b10mr24067709qto.224.1624285077981; 
 Mon, 21 Jun 2021 07:17:57 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [47.55.113.94])
 by smtp.gmail.com with ESMTPSA id y15sm10797034qto.90.2021.06.21.07.17.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jun 2021 07:17:57 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1lvKkO-009WjS-US; Mon, 21 Jun 2021 11:17:56 -0300
Date: Mon, 21 Jun 2021 11:17:56 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH v3 1/2] habanalabs: define uAPI to export FD for DMA-BUF
Message-ID: <20210621141756.GF1096940@ziepe.ca>
References: <20210618123615.11456-1-ogabbay@kernel.org>
 <CAKMK7uFOfoxbD2Z5mb-qHFnUe5rObGKQ6Ygh--HSH9M=9bziGg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKMK7uFOfoxbD2Z5mb-qHFnUe5rObGKQ6Ygh--HSH9M=9bziGg@mail.gmail.com>
X-Mailman-Approved-At: Mon, 21 Jun 2021 14:27:45 +0000
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
Cc: sleybo@amazon.com, Gal Pressman <galpress@amazon.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 linux-rdma <linux-rdma@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
 Oded Gabbay <ogabbay@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Doug Ledford <dledford@redhat.com>, Tomer Tayar <ttayar@habana.ai>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 "airlied@gmail.com" <airlied@gmail.com>, Christoph Hellwig <hch@lst.de>,
 Leon Romanovsky <leonro@nvidia.com>,
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jun 21, 2021 at 02:28:48PM +0200, Daniel Vetter wrote:

> Mission acomplished, we've gone full circle, and the totally-not-a-gpu
> driver is now trying to use gpu infrastructure. And seems to have
> gained vram meanwhile too. Next up is going to be synchronization
> using dma_fence so you can pass buffers back&forth without stalls
> among drivers.

Well, we can't even see the other side of this so who knows

This is a new uAPI, where is the userspace? In RDMA at least I require
to see the new userspace and test suite before changes to
include/uapi/rdma can go ahead.

> Doug/Jason from infiniband: Should we add linux-rdma to the dma-buf
> wildcard match so that you can catch these next time around too? At
> least when people use scripts/get_maintainers.pl correctly. All the
> other subsystems using dma-buf are on there already (dri-devel,
> linux-media and linaro-mm-sig for android/arm embedded stuff).

My bigger concern is this doesn't seem to be implementing PCI P2P DMA
correctly. This is following the same hacky NULL page approach that
Christoph Hellwig already NAK'd for AMD.

This should not be allowed to proliferate.

I would be much happier seeing this be done using the approach of
Logan's series here:

https://lore.kernel.org/linux-block/20210513223203.5542-1-logang@deltatee.com/

Jason
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

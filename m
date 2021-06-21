Return-Path: <SRS0=0Dgm=LQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C75BC4743C
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 01:32:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C99E561040
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 01:32:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C99E561040
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CD4F88304;
	Tue, 22 Jun 2021 01:32:35 +0000 (UTC)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C80116E448
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 23:29:14 +0000 (UTC)
Received: by mail-qv1-xf2c.google.com with SMTP id 5so8375740qvf.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 16:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=WGIQy0LtKLkIE/rK0/0LmxIf0Yhw3y7s+bpYX0ZTb4E=;
 b=XkURmaeBNxY2KNIu+e3I7r7c8Mw2wNE/2QAVf2JLvg6H3Ao6a1CHuNZ3vZ9RBTFdKx
 H3HDY9NRafLjynlaVkG4PxqZXZk/v2PZSf4FNAtjAaDZ+6ONvHcsFIGONwVDeOf17HrF
 h4Z5tocnUYIAKpC3IQtgBEC1vGg2T8esb9cF9sxkRyXpR+nn2OjKipQdc2qiNBCYtMp5
 8yt3ntQEIkDMB6fEEsB9d5jku+rDz/qbvQ2tZqk6+/0aRqBqq05Onc+pKKb0R8HJo8Ai
 55y54osBIrECu/xwViWlwG2EaBg82LCP+kuA9VXzH9FS9l7AMz909JQzyaOkpt0gKptG
 0naA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WGIQy0LtKLkIE/rK0/0LmxIf0Yhw3y7s+bpYX0ZTb4E=;
 b=bPDdWytcw3C5rmM5phdmDEbH9ow+pFNK01FQpHqZyIr57X3JisUJpGqOFK+mWlExrM
 4swo4MYZt4OtTBvTYEHTMYrDX9N1JaZmtdSORRwRu7Si3TSiml6DF48yS5m1N3o+LZ7i
 dE99MPaF7GwJD6luHdH5K0odRnkGXN0W1XMGoneVwTbl7dDUMecfl+Rosu55NOPV8C5U
 JyWNpfoOugwxEEOU2gCHYhCLkH/UuSFO6/X2D59UQ3q7gU/Ds6y8/CFbOwXNvTX5kG86
 9QDO6akMPZX4CLx+LFA2vLrgtEY91zumWpyPmMcetDEReKjPJmyzdq4xqjeGxXHp2ftX
 NEYg==
X-Gm-Message-State: AOAM532kSIXy3A+/iWfGwuDxcjllIwN3CNif/nXjQoZpE/0UovRAvuIe
 G81AkeD+LtKOZO24+v/5wuEayQ==
X-Google-Smtp-Source: ABdhPJzRTPsxAjXcsN31fYToN1kshtwgii2JxLBC8O2dnJ4kI8UL0Km8hvy0yekYsKCtQzKfourLAQ==
X-Received: by 2002:a0c:fd44:: with SMTP id j4mr22797061qvs.12.1624318153681; 
 Mon, 21 Jun 2021 16:29:13 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [47.55.113.94])
 by smtp.gmail.com with ESMTPSA id t30sm10969084qkm.11.2021.06.21.16.29.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jun 2021 16:29:13 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1lvTLs-009tun-DJ; Mon, 21 Jun 2021 20:29:12 -0300
Date: Mon, 21 Jun 2021 20:29:12 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Oded Gabbay <oded.gabbay@gmail.com>
Subject: Re: [PATCH v3 1/2] habanalabs: define uAPI to export FD for DMA-BUF
Message-ID: <20210621232912.GK1096940@ziepe.ca>
References: <20210618123615.11456-1-ogabbay@kernel.org>
 <CAKMK7uFOfoxbD2Z5mb-qHFnUe5rObGKQ6Ygh--HSH9M=9bziGg@mail.gmail.com>
 <YNCN0ulL6DQiRJaB@kroah.com> <20210621141217.GE1096940@ziepe.ca>
 <CAFCwf10KvCh0zfHEHqYR-Na6KJh4j+9i-6+==QaMdHHpLH1yEA@mail.gmail.com>
 <20210621175511.GI1096940@ziepe.ca>
 <CAKMK7uEO1_B59DtM7N2g7kkH7pYtLM_WAkn+0f3FU3ps=XEjZQ@mail.gmail.com>
 <CAFCwf11jOnewkbLuxUESswCJpyo7C0ovZj80UrnwUOZkPv2JYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFCwf11jOnewkbLuxUESswCJpyo7C0ovZj80UrnwUOZkPv2JYQ@mail.gmail.com>
X-Mailman-Approved-At: Tue, 22 Jun 2021 01:32:35 +0000
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
Cc: Gal Pressman <galpress@amazon.com>, sleybo@amazon.com,
 linux-rdma <linux-rdma@vger.kernel.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Oded Gabbay <ogabbay@kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Doug Ledford <dledford@redhat.com>, Tomer Tayar <ttayar@habana.ai>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Greg KH <gregkh@linuxfoundation.org>, Alex Deucher <alexander.deucher@amd.com>,
 "airlied@gmail.com" <airlied@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, Leon Romanovsky <leonro@nvidia.com>,
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jun 21, 2021 at 10:24:16PM +0300, Oded Gabbay wrote:

> Another thing I want to emphasize is that we are doing p2p only
> through the export/import of the FD. We do *not* allow the user to
> mmap the dma-buf as we do not support direct IO. So there is no access
> to these pages through the userspace.

Arguably mmaping the memory is a better choice, and is the direction
that Logan's series goes in. Here the use of DMABUF was specifically
designed to allow hitless revokation of the memory, which this isn't
even using.

So you are taking the hit of very limited hardware support and reduced
performance just to squeeze into DMABUF..

Jason
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

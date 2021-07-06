Return-Path: <SRS0=iwxs=L6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882D3C07E96
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 13:57:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3356161C83
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 13:57:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3356161C83
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D395C6E49A;
	Tue,  6 Jul 2021 13:57:54 +0000 (UTC)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E28436E484
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jul 2021 13:54:54 +0000 (UTC)
Received: by mail-qt1-x833.google.com with SMTP id z12so9352917qtj.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Jul 2021 06:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=F7pVFly65mtrw4yvfSLy/OKy9AWKG24c85UMsxt0WZw=;
 b=gYf94+BMIGsQpJS3uV3ohuMRMLOEFz0kdysTKDKnloRFgs0LhgoRcqPW98PUrU+dx6
 E3OOKrVJV1BTd2elUyjb8G6xfJzPFdvehJAilfpTM9RS4gfQVAvkYNKGiyCJGug87J6k
 YPq+yFMHPSe1tFJNbPKeZAhUsLvOhG/JZZZww+IcGnL/e9f9w8Z2RP4h4m2+YNHDT4Xi
 aRg/PM4bau3ZfwjJIhVR625Zv1Lq+m19yfd3/4kopcBskBTAcwccdEdO9LAmSJrnc844
 kpItX9Ulfg4csgBtST5Xn7ZpOiEeWyWeCZZL/jYKlVlhcziFr98+RBkzrzJm3IFtppAf
 vOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=F7pVFly65mtrw4yvfSLy/OKy9AWKG24c85UMsxt0WZw=;
 b=Scmu2h99Z8PPZy6mnQu2zCM42JS33Y6ZMW3wbCroff/3Pn2LukNnC/zn+qlsE66F42
 JOIrRtip0HSn2h8VYARewyLlxDrd6A70zM1Zb0GjJA55tde0bISrl3E0HZrQof4ilPUF
 Atdm1WEHHHdfEJXqVrLGNdURGnK9ZGbAV7S4DnQjlJgMk2FdiFuUz/BCzu4aiCUtWjuv
 GnahSgraE5RvvD9zcZDWgwdttuGQqnfWJCQ6L/bQpgJL77MKfp5Xz8K4TDaWxcM63T57
 TBJi9z1TE691PZKGs8DlIRANQApEb3A3m/KBGPE0AmH4yS3FGdkn6Y12b2L9qjFh3xWg
 lUAg==
X-Gm-Message-State: AOAM532OtYQnE9BzSh6Kx1jx+TKpY9oKSZ7a96WnlkbJCIQAglnYFoE3
 PqWAhVBnqL/vUNzXFP8LVcD3gg==
X-Google-Smtp-Source: ABdhPJz13olZ+JJKFkbBuIPKQTyNwX1MXRn+mR8LaT47LKm2ZWHADKQroBueZGYoVGCTJKDq+xeMwA==
X-Received: by 2002:ac8:5045:: with SMTP id h5mr17280817qtm.178.1625579693287; 
 Tue, 06 Jul 2021 06:54:53 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id t20sm1900660qtx.48.2021.07.06.06.54.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jul 2021 06:54:52 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1m0lXH-004QmP-Kc; Tue, 06 Jul 2021 10:54:51 -0300
Date: Tue, 6 Jul 2021 10:54:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Oded Gabbay <oded.gabbay@gmail.com>
Subject: Re: [PATCH v4 2/2] habanalabs: add support for dma-buf exporter
Message-ID: <20210706135451.GM4604@ziepe.ca>
References: <20210705130314.11519-1-ogabbay@kernel.org>
 <20210705130314.11519-3-ogabbay@kernel.org>
 <20210705165226.GJ4604@ziepe.ca>
 <CAFCwf100mkROMw9+2LgW7d3jKnaeZ4nmfWm7HtXuUE7NF4B8pg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFCwf100mkROMw9+2LgW7d3jKnaeZ4nmfWm7HtXuUE7NF4B8pg@mail.gmail.com>
X-Mailman-Approved-At: Tue, 06 Jul 2021 13:57:53 +0000
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
 "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Doug Ledford <dledford@redhat.com>, Christoph Hellwig <hch@lst.de>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alex Deucher <alexander.deucher@amd.com>, Tomer Tayar <ttayar@habana.ai>,
 Dave Airlie <airlied@gmail.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Leon Romanovsky <leonro@nvidia.com>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jul 06, 2021 at 12:44:49PM +0300, Oded Gabbay wrote:

> > > +     /* In case we got a large memory area to export, we need to divide it
> > > +      * to smaller areas because each entry in the dmabuf sgt can only
> > > +      * describe unsigned int.
> > > +      */
> >
> > Huh? This is forming a SGL, it should follow the SGL rules which means
> > you have to fragment based on the dma_get_max_seg_size() of the
> > importer device.
> >
> hmm
> I don't see anyone in drm checking this value (and using it) when
> creating the SGL when exporting dmabuf. (e.g.
> amdgpu_vram_mgr_alloc_sgt)

For dmabuf the only importer is RDMA and it doesn't care, but you
certainly should not introduce a hardwired constant instead of using
the correct function.

Jason
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

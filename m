Return-Path: <SRS0=iwxs=L6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFB1C07E96
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 08:40:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A5206052B
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 08:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A5206052B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1388A899B5;
	Tue,  6 Jul 2021 08:40:43 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B223A899B5
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jul 2021 08:40:41 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id q17so4681610wrv.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Jul 2021 01:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:in-reply-to;
 bh=JLlTuAeFJ55bKl70feqPAdDJNogiM+fpe/R9P7DcSms=;
 b=LRnsqjRbV1SjBgROJlBIakdBOYICsTI8ulzfPsgIQuMlSJ8mh2dRGC7U1wsehHvWvI
 IyKsCEPEE7aj2cDyk/ASRk28e+xTY39qV9bf/70BQD/NFfB3eA0zVAekYrESOuCPHLQL
 fqnRDhDxHDjGgI1GsURpOfaynvOOqUO2t/nUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=JLlTuAeFJ55bKl70feqPAdDJNogiM+fpe/R9P7DcSms=;
 b=Ct2chCgEY4CbhXJW2iK1NgAbODAhJFLSoxVT17EHeiPwfGwDI+wyoi2gDnesY9raip
 UYbK/mxv4+mMe9SRDFIlmE5OOmBeyU/2vgQ0bCKzYCxwJitDEGrNSvrhuxPU8XvSXNUw
 rHTOsettA8FuEAaQjlY+hKusqNsmasBpggLlH8/NMcTF/vYlP/6wJTQKflm0gLOqNmCB
 sydTWiF24r+0O6u4g7M7WWXnAaEptcT8Y6IpZ08CgE2A6/ooiWL5UCqqDM0dRfVaoYxN
 v/gs8mC4nO69XpSq6j+zEXW+oxAbBkm8kPExX2kIRECJBc4983HHwOfafjXAG2n2SZG9
 zOPA==
X-Gm-Message-State: AOAM533V53+dOo9d+aGDi//ea9yT3Nwc2ExBFlP2abg02g/l6qVTu+Tf
 6TwfmyCtdnHiWxbDKR64VeP6eg==
X-Google-Smtp-Source: ABdhPJw0uQEuhFtLZ/yp2rlntAi8MREzCiqyFoKyRYiByd6f3gcRZqvzyCKHQD5Nm2De5YPjEiQssQ==
X-Received: by 2002:a05:6000:18c8:: with SMTP id
 w8mr12110209wrq.90.1625560840330; 
 Tue, 06 Jul 2021 01:40:40 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id b8sm2176254wmb.20.2021.07.06.01.40.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jul 2021 01:40:39 -0700 (PDT)
Date: Tue, 6 Jul 2021 10:40:37 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Oded Gabbay <ogabbay@kernel.org>
Subject: Re: [PATCH v4 0/2] Add p2p via dmabuf to habanalabs
Message-ID: <YOQXBWpo3whVjOyh@phenom.ffwll.local>
Mail-Followup-To: Oded Gabbay <ogabbay@kernel.org>,
 linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
 sumit.semwal@linaro.org, christian.koenig@amd.com,
 galpress@amazon.com, sleybo@amazon.com,
 dri-devel@lists.freedesktop.org, jgg@ziepe.ca,
 linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
 dledford@redhat.com, airlied@gmail.com, alexander.deucher@amd.com,
 leonro@nvidia.com, hch@lst.de, amd-gfx@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
References: <20210705130314.11519-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210705130314.11519-1-ogabbay@kernel.org>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
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
Cc: linux-rdma@vger.kernel.org, daniel.vetter@ffwll.ch, sleybo@amazon.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 galpress@amazon.com, linaro-mm-sig@lists.linaro.org, jgg@ziepe.ca,
 dledford@redhat.com, hch@lst.de, amd-gfx@lists.freedesktop.org,
 gregkh@linuxfoundation.org, alexander.deucher@amd.com, airlied@gmail.com,
 sumit.semwal@linaro.org, christian.koenig@amd.com, leonro@nvidia.com,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jul 05, 2021 at 04:03:12PM +0300, Oded Gabbay wrote:
> Hi,
> I'm sending v4 of this patch-set following the long email thread.
> I want to thank Jason for reviewing v3 and pointing out the errors, saving
> us time later to debug it :)
> 
> I consulted with Christian on how to fix patch 2 (the implementation) and
> at the end of the day I shamelessly copied the relevant content from
> amdgpu_vram_mgr_alloc_sgt() and amdgpu_dma_buf_attach(), regarding the
> usage of dma_map_resource() and pci_p2pdma_distance_many(), respectively.
> 
> I also made a few improvements after looking at the relevant code in amdgpu.
> The details are in the changelog of patch 2.
> 
> I took the time to write an import code into the driver, allowing me to
> check real P2P with two Gaudi devices, one as exporter and the other as
> importer. I'm not going to include the import code in the product, it was
> just for testing purposes (although I can share it if anyone wants).
> 
> I run it on a bare-metal environment with IOMMU enabled, on a sky-lake CPU
> with a white-listed PCIe bridge (to make the pci_p2pdma_distance_many happy).
> 
> Greg, I hope this will be good enough for you to merge this code.

So we're officially going to use dri-devel for technical details review
and then Greg for merging so we don't have to deal with other merge
criteria dri-devel folks have?

I don't expect anything less by now, but it does make the original claim
that drivers/misc will not step all over accelerators folks a complete
farce under the totally-not-a-gpu banner.

This essentially means that for any other accelerator stack that doesn't
fit the dri-devel merge criteria, even if it's acting like a gpu and uses
other gpu driver stuff, you can just send it to Greg and it's good to go.

There's quite a lot of these floating around actually (and many do have
semi-open runtimes, like habanalabs have now too, just not open enough to
be actually useful). It's going to be absolutely lovely having to explain
to these companies in background chats why habanalabs gets away with their
stack and they don't.

Or maybe we should just merge them all and give up on the idea of having
open cross-vendor driver stacks for these accelerators.

Thanks, Daniel

> 
> Thanks,
> Oded
> 
> Oded Gabbay (1):
>   habanalabs: define uAPI to export FD for DMA-BUF
> 
> Tomer Tayar (1):
>   habanalabs: add support for dma-buf exporter
> 
>  drivers/misc/habanalabs/Kconfig             |   1 +
>  drivers/misc/habanalabs/common/habanalabs.h |  26 ++
>  drivers/misc/habanalabs/common/memory.c     | 480 +++++++++++++++++++-
>  drivers/misc/habanalabs/gaudi/gaudi.c       |   1 +
>  drivers/misc/habanalabs/goya/goya.c         |   1 +
>  include/uapi/misc/habanalabs.h              |  28 +-
>  6 files changed, 532 insertions(+), 5 deletions(-)
> 
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

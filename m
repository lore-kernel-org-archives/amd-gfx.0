Return-Path: <SRS0=i1uT=OE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D780FC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Sep 2021 14:18:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78F2060EE3
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Sep 2021 14:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 78F2060EE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F6C86E4A5;
	Tue, 14 Sep 2021 14:18:37 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B90FF6E4A5
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Sep 2021 14:18:35 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id w29so19732444wra.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Sep 2021 07:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:in-reply-to;
 bh=kpn+M1bqQCPZctbXT2rMFocOAVoHTOH/YHoMT77kaXA=;
 b=KB4MNAxhrmlbX59MwAQZ6hLhzSFEWzYdMbFTOohpBg3/xVF58nlidY6zi0qGimEhqm
 Jl6OCNnnQMIFIqi85bkucA2jwEyap/QQOUngnGS5sFkRXOcZpJV0qG67XAOWE7gBHPBL
 dZ2GY6mBv3tc5NBbWhoYZ9ImG68TbT4LJGvgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=kpn+M1bqQCPZctbXT2rMFocOAVoHTOH/YHoMT77kaXA=;
 b=1JrM0TKKBtVtI9rcxBjmirKOr56JktusaGh4MOD5Cs9oQTvnFh70TPUNO8/cL0VTDY
 zVVm/Jm0EuGTqZTLfjWduAf5UiGvjrZWGlA1Pl3Yy6JEoqh/2WmnKL4t7iCguVJ9A4PQ
 wyG30SVYf8v3zGNT23CARnMusFL/VkT63a/1kRN/Mf1HujVigVYP6tmiVR3EtnYXn7wu
 wXErvnE00npJIRmk20Ejv2ZzFmblDDeUsS7JJ36fZp4OuQg0qHoXnm9AC/2N59Gbo7dd
 sy2cZMBrI8tXYqw0xdOWYNdWCYS+6F7jNCLiQYgmwc75jiQCZNrzkzLJdO65Jhj+Jq3z
 aFKw==
X-Gm-Message-State: AOAM530TlWGHMQhxlxkO3w7kbOZNIb4XgZ7wcIjRKSM92oWw0i4uLAyn
 neKdE3nl34rMSLkMzN7e6fqlBQ==
X-Google-Smtp-Source: ABdhPJwKQcZFGHqC1jw8lf4RoQcxifPnrx41rU4gRLMHuOSauY9GY+Cp86a0hl31Z0tdwkoEknt34g==
X-Received: by 2002:adf:f183:: with SMTP id h3mr13825816wro.32.1631629114235; 
 Tue, 14 Sep 2021 07:18:34 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id l15sm1251759wme.42.2021.09.14.07.18.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Sep 2021 07:18:33 -0700 (PDT)
Date: Tue, 14 Sep 2021 16:18:31 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Oded Gabbay <ogabbay@kernel.org>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, jgg@ziepe.ca,
 christian.koenig@amd.com, daniel.vetter@ffwll.ch,
 galpress@amazon.com, sleybo@amazon.com,
 dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 linux-media@vger.kernel.org, dledford@redhat.com, airlied@gmail.com,
 alexander.deucher@amd.com, leonro@nvidia.com, hch@lst.de,
 amd-gfx@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v6 0/2] Add p2p via dmabuf to habanalabs
Message-ID: <YUCvNzpyC091KeaJ@phenom.ffwll.local>
Mail-Followup-To: Oded Gabbay <ogabbay@kernel.org>,
 linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
 jgg@ziepe.ca, christian.koenig@amd.com, galpress@amazon.com,
 sleybo@amazon.com, dri-devel@lists.freedesktop.org,
 linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
 dledford@redhat.com, airlied@gmail.com, alexander.deucher@amd.com,
 leonro@nvidia.com, hch@lst.de, amd-gfx@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
References: <20210912165309.98695-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210912165309.98695-1-ogabbay@kernel.org>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sun, Sep 12, 2021 at 07:53:07PM +0300, Oded Gabbay wrote:
> Hi,
> Re-sending this patch-set following the release of our user-space TPC
> compiler and runtime library.
> 
> I would appreciate a review on this.

I think the big open we have is the entire revoke discussions. Having the
option to let dma-buf hang around which map to random local memory ranges,
without clear ownership link and a way to kill it sounds bad to me.

I think there's a few options:
- We require revoke support. But I've heard rdma really doesn't like that,
  I guess because taking out an MR while holding the dma_resv_lock would
  be an inversion, so can't be done. Jason, can you recap what exactly the
  hold-up was again that makes this a no-go?

- The other option I discussed is a bit more the exlusive device ownership
  model we've had for gpus in drm of the really old kind. Roughly this
  would work like this, in terms of drm_device:
  - Only the current owner (drm_master in current drm code, but should
    probably rename that to drm_owner) is allowed to use the accel driver.
    So all ioctl would fail if you're not drm_master.
  - On dropmaster/file close we'd revoke as much as possible, e.g.
    in-flight commands, mmaps, anything really that can be revoked.
  - For non-revokable things like these dma-buf we'd keep a drm_master
    reference around. This would prevent the next open to acquire
    ownership rights, which at least prevents all the nasty potential
    problems.
  - admin (or well container orchestrator) then has responsibility to
    shoot down all process until the problem goes away (i.e. until you hit
    the one with the rdma MR which keeps the dma-buf alive)

- Not sure there's another reasonable way to do this without inviting some
  problems once we get outside of the "single kernel instance per tenant"
  use-case.

Wrt implementation there's the trouble of this reinventing a bunch of drm
stuff and concepts, but that's maybe for after we've figured out
semantics.

Also would be great if you have a pull request for the userspace runtime
that shows a bit how this all gets used and tied together. Or maybe some
pointers, since I guess retconning a PR in github is maybe a bit much.

Cheers, Daniel

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
>  drivers/misc/habanalabs/common/habanalabs.h |  22 +
>  drivers/misc/habanalabs/common/memory.c     | 522 +++++++++++++++++++-
>  drivers/misc/habanalabs/gaudi/gaudi.c       |   1 +
>  drivers/misc/habanalabs/goya/goya.c         |   1 +
>  include/uapi/misc/habanalabs.h              |  28 +-
>  6 files changed, 570 insertions(+), 5 deletions(-)
> 
> -- 
> 2.17.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

Return-Path: <SRS0=i1uT=OE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151E2C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Sep 2021 16:14:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D352660F9F
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Sep 2021 16:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D352660F9F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 864056E4E3;
	Tue, 14 Sep 2021 16:14:40 +0000 (UTC)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83FB289FDE
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Sep 2021 16:12:20 +0000 (UTC)
Received: by mail-qk1-x72b.google.com with SMTP id f22so15441584qkm.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Sep 2021 09:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=I7DiJbd0cxUCLQIOVYzn8bpAGXC1DpRRoThWyrXU5us=;
 b=VLAPpylLAYTeobmTkVR3mMWEApbSzQVCY6y9NZmlGqOYAYmCLqLovz+JRKOW4zbFQO
 SsICmqARfpElDi01jfGPfhfGp+XbjOWG5j7xhqkXBcfxNTtfN0Q2EHL2YIPXJAmE5lqq
 9fO4vT4ebWpM51oXh2PN3UzJN/nZE167NxFttlYk9zDneLRVxgg54Ms6stPw+IfwS8fE
 BcU8DH0Wkz0TT/2TEuDT6T2VOxScMtYxzNvvbGLNasoE4MraqR/e/O1maoUvya4XQnt5
 8ZqntLHL5K06ZWcY7hFsB6CkWDvb6eMwUQMOMC/DyK5zV21pUx/5Wgk/nJhjm274HIe8
 i/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=I7DiJbd0cxUCLQIOVYzn8bpAGXC1DpRRoThWyrXU5us=;
 b=LjRgsqfxKLdqanjcKq8+OX9vUikrQqjau4gonoeZhv0wPStpB9s5FJDW2tJ3lCT17u
 f/DxqZ2DrZAtgF2a7/iVcwdTCwlqixoaM+CJi4I26kxaa/RF1vAPJoJmvDclFlMmUfZq
 QXQ+U4dOwVpLF9h0xF00iGom34C3/NUAf3vlZXNLnzXrfm4JfFWgZorWWiGAXt/trLVO
 3vkPnRC8dR11kzsabCm04CXXs+QnR1SjTglwSHfgYc9uybitNxgVy2W3c+rT8exv0tJT
 RqcBj9sTLswZub/jx/Kb6ujaPPNIv9x/yN/cg6dTwpljZdVxTEXOw5FKaAOF47gEwBhx
 LVxw==
X-Gm-Message-State: AOAM532pwt3D7qzslze55fZYlzGNsCtPNa4pjJas3faCUsK1CAVh2EU7
 x5oDdwo6xM+mmTo3T6waRZU+nA==
X-Google-Smtp-Source: ABdhPJx4jViYSyei0WdKfCFMJbXr109wAbeh5pMtA2HJlrp+YG8SrdRPcGb67UHsXDEjE3Pl7PPDDA==
X-Received: by 2002:a05:620a:4541:: with SMTP id
 u1mr5785047qkp.106.1631635939466; 
 Tue, 14 Sep 2021 09:12:19 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129])
 by smtp.gmail.com with ESMTPSA id s18sm7826361qkj.87.2021.09.14.09.12.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Sep 2021 09:12:18 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mQB2g-000UiF-8O; Tue, 14 Sep 2021 13:12:18 -0300
Date: Tue, 14 Sep 2021 13:12:18 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Oded Gabbay <ogabbay@kernel.org>, linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org, christian.koenig@amd.com,
 galpress@amazon.com, sleybo@amazon.com,
 dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 linux-media@vger.kernel.org, dledford@redhat.com, airlied@gmail.com,
 alexander.deucher@amd.com, leonro@nvidia.com, hch@lst.de,
 amd-gfx@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v6 0/2] Add p2p via dmabuf to habanalabs
Message-ID: <20210914161218.GF3544071@ziepe.ca>
References: <20210912165309.98695-1-ogabbay@kernel.org>
 <YUCvNzpyC091KeaJ@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUCvNzpyC091KeaJ@phenom.ffwll.local>
X-Mailman-Approved-At: Tue, 14 Sep 2021 16:14:39 +0000
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

On Tue, Sep 14, 2021 at 04:18:31PM +0200, Daniel Vetter wrote:
> On Sun, Sep 12, 2021 at 07:53:07PM +0300, Oded Gabbay wrote:
> > Hi,
> > Re-sending this patch-set following the release of our user-space TPC
> > compiler and runtime library.
> > 
> > I would appreciate a review on this.
> 
> I think the big open we have is the entire revoke discussions. Having the
> option to let dma-buf hang around which map to random local memory ranges,
> without clear ownership link and a way to kill it sounds bad to me.
> 
> I think there's a few options:
> - We require revoke support. But I've heard rdma really doesn't like that,
>   I guess because taking out an MR while holding the dma_resv_lock would
>   be an inversion, so can't be done. Jason, can you recap what exactly the
>   hold-up was again that makes this a no-go?

RDMA HW can't do revoke.

So we have to exclude almost all the HW and several interesting use
cases to enable a revoke operation.

>   - For non-revokable things like these dma-buf we'd keep a drm_master
>     reference around. This would prevent the next open to acquire
>     ownership rights, which at least prevents all the nasty potential
>     problems.

This is what I generally would expect, the DMABUF FD and its DMA
memory just floats about until the unrevokable user releases it, which
happens when the FD that is driving the import eventually gets closed.

I still don't think any of the complexity is needed, pinnable memory
is a thing in Linux, just account for it in mlocked and that is
enough.

Jason

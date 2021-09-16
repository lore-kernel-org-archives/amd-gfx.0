Return-Path: <SRS0=YYL8=OG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB84EC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Sep 2021 13:11:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8788F611C4
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Sep 2021 13:11:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8788F611C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 140006EDB3;
	Thu, 16 Sep 2021 13:11:04 +0000 (UTC)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A10646EDB2
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Sep 2021 13:10:17 +0000 (UTC)
Received: by mail-qt1-x82a.google.com with SMTP id r21so5381222qtw.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Sep 2021 06:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=J1aPRVnPtvaDDmo3fez14oc8rYGiEsDWBCXDH/Wat7k=;
 b=SCLGmpBOIX1LyEWjCtTQu5NsbhW1Y4X5/DmQl1XQ9jzusvOLM7zvEkOwz6LOAv+Yok
 sIWQ6uZy+RXJ3cFeYjVefKkQH0Bt0fEt6Hxm02pQYIdfhNmnfHNX2wDQS3f9HxEUckLT
 uEUNakxQ26CbdQlN/sagwI+fXugp4FI45KUk2U0+TghLUrgqPs4hSAaLgC+UJKOxxT4E
 Mc+H12o6j9K7ZldUlePbIj3QazJSlLYL+zG9bxUEh82jSSu4c3hLfm8TlsPXKZBK8Vfn
 QyTQKfWMizwsKJYk7EULgbEvpNxSTjzFuIhJlbPIm2aqRKQQZUDbcvQh309a66LJBzjd
 rwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=J1aPRVnPtvaDDmo3fez14oc8rYGiEsDWBCXDH/Wat7k=;
 b=oUFzVwnNkv43TTxLRS/sBkon+EuzYgDFwt/UiJbd1mI+fl1yk1KipvtWWjQ/0joGr6
 V+ReSBfwBDfzdWWAdobqU63VGVS/AgHEwMoHwWufVMfiAoKy5YjEAAcDYy7e/iFIwVQw
 TjU9Gf0Vh3Et9s0aHNfTDJEzPGCaeX8zrv7hUaRHDlb6XXfrhcCl1EoSD/tFzHA4KCbY
 Rn9dFb3defgFh+0qz+4SqBnjgea+IW7kaA1HFAtaxjDy0kvIiOJ1E6HpDeB6xujgSdIf
 HbsGNHsHG9F1VPB5h5WdvubLIy8cd0nF8IVe0TBjWXN8yvJr3VmbA+fZH2qB7gVE9pXu
 ahkQ==
X-Gm-Message-State: AOAM533q9DyxCVnf80wuiFO6iXtBS+ozDtXF8PpmBhbi7vHKfOn5VcKb
 HTTM3bD7vCkLeBSp/omAxPWWLw==
X-Google-Smtp-Source: ABdhPJwoUHOat0GVnmJtcI3QwOrvQdDqw4k+r1J+CwosMJhqmF7+hz2G8rRCHLhPrxcT6+12hGdkXg==
X-Received: by 2002:ac8:7d42:: with SMTP id h2mr4861309qtb.220.1631797816616; 
 Thu, 16 Sep 2021 06:10:16 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id r23sm1992140qtp.60.2021.09.16.06.10.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Sep 2021 06:10:15 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mQr9a-001MiL-Tq; Thu, 16 Sep 2021 10:10:14 -0300
Date: Thu, 16 Sep 2021 10:10:14 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Oded Gabbay <ogabbay@kernel.org>,
 "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Gal Pressman <galpress@amazon.com>, Yossi Leybovich <sleybo@amazon.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 linux-rdma <linux-rdma@vger.kernel.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Doug Ledford <dledford@redhat.com>, Dave Airlie <airlied@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Leon Romanovsky <leonro@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>
Subject: Re: [PATCH v6 0/2] Add p2p via dmabuf to habanalabs
Message-ID: <20210916131014.GK3544071@ziepe.ca>
References: <20210912165309.98695-1-ogabbay@kernel.org>
 <YUCvNzpyC091KeaJ@phenom.ffwll.local>
 <20210914161218.GF3544071@ziepe.ca>
 <CAFCwf13322953Txr3Afa_MomuD148vnfpEog0xzW7FPWH9=6fg@mail.gmail.com>
 <YUM5JoMMK7gceuKZ@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUM5JoMMK7gceuKZ@phenom.ffwll.local>
X-Mailman-Approved-At: Thu, 16 Sep 2021 13:11:02 +0000
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

On Thu, Sep 16, 2021 at 02:31:34PM +0200, Daniel Vetter wrote:
> On Wed, Sep 15, 2021 at 10:45:36AM +0300, Oded Gabbay wrote:
> > On Tue, Sep 14, 2021 at 7:12 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Tue, Sep 14, 2021 at 04:18:31PM +0200, Daniel Vetter wrote:
> > > > On Sun, Sep 12, 2021 at 07:53:07PM +0300, Oded Gabbay wrote:
> > > > > Hi,
> > > > > Re-sending this patch-set following the release of our user-space TPC
> > > > > compiler and runtime library.
> > > > >
> > > > > I would appreciate a review on this.
> > > >
> > > > I think the big open we have is the entire revoke discussions. Having the
> > > > option to let dma-buf hang around which map to random local memory ranges,
> > > > without clear ownership link and a way to kill it sounds bad to me.
> > > >
> > > > I think there's a few options:
> > > > - We require revoke support. But I've heard rdma really doesn't like that,
> > > >   I guess because taking out an MR while holding the dma_resv_lock would
> > > >   be an inversion, so can't be done. Jason, can you recap what exactly the
> > > >   hold-up was again that makes this a no-go?
> > >
> > > RDMA HW can't do revoke.
> 
> Like why? I'm assuming when the final open handle or whatever for that MR
> is closed, you do clean up everything? Or does that MR still stick around
> forever too?

It is a combination of uAPI and HW specification.

revoke here means you take a MR object and tell it to stop doing DMA
without causing the MR object to be destructed.

All the drivers can of course destruct the MR, but doing such a
destruction without explicit synchronization with user space opens
things up to a serious use-after potential that could be a security
issue.

When the open handle closes the userspace is synchronized with the
kernel and we can destruct the HW objects safely.

So, the special HW feature required is 'stop doing DMA but keep the
object in an error state' which isn't really implemented, and doesn't
extend very well to other object types beyond simple MRs.

> 1. User A opens gaudi device, sets up dma-buf export
> 
> 2. User A registers that with RDMA, or anything else that doesn't support
> revoke.
> 
> 3. User A closes gaudi device
> 
> 4. User B opens gaudi device, assumes that it has full control over the
> device and uploads some secrets, which happen to end up in the dma-buf
> region user A set up

I would expect this is blocked so long as the DMABUF exists - eg the
DMABUF will hold a fget on the FD of #1 until the DMABUF is closed, so
that #3 can't actually happen.

> It's not mlocked memory, it's mlocked memory and I can exfiltrate
> it.

That's just bug, don't make buggy drivers :)

Jason

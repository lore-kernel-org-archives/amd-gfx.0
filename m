Return-Path: <SRS0=Ip3g=OV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FB5C433FE
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 14:52:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64CE7619E7
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 14:52:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 64CE7619E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D46066EE0B;
	Fri,  1 Oct 2021 14:52:38 +0000 (UTC)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D12E96EDE4
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Oct 2021 14:50:54 +0000 (UTC)
Received: by mail-qt1-x82e.google.com with SMTP id c20so9172855qtb.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 01 Oct 2021 07:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=oMNtHpa9fOC6yHUao3VzpuzxSz0y+O1ZI66YcUTNbDE=;
 b=nPwDUL9pffjM/L5QBu2UuSP1A0QIAziR9mEhIiS0bbykKDNwFwDOCdZZPQRjytSfOl
 9664AO5c95SsAo845UWJ4llFoeGA34AMkf8JM8Jvz4IkmXmAVxiKZPf8ueKyZDj2nnhD
 7UMSgYwkQcaDxSswDKUHvCys3TK5Y5wkz2BXHjVliu2eyg29AZhT/OjKvCBrw1uscGKD
 3z+t3x/PORSTQiMEajcEoJWDN8W44+RDWzJ3OAr4hPg7SAnPZ5GisI2uKci8/QKl7Dj2
 HOKVC2LuGCjbjYvGuNPd82eSxLSRf0G3YcULGIl6j0TQwgvkOpcvnHfxonQ1DnaiELwg
 iLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=oMNtHpa9fOC6yHUao3VzpuzxSz0y+O1ZI66YcUTNbDE=;
 b=M6+1x9/izjIcycgSSKUFtHXkvb+KfVx1xpQRFFJyCD2C8aCLl+/uVznOANHwE6sziK
 jpyzAGealcrs8azpkyClfJKpdhutW5J5LQpSgrYBfijAFjgEdcuXoFTuPF37pURernCM
 uWlMThJFji0an/Mx8eFTcss08Nj/X5nqoQx2QIbviieQDOfbNsM4rdlRLulhLxxux5bs
 CfXO9aXJD+esbts6C65CPv6FcFRZPC8bcZ6U01/glidm6BMpnhV24ltRjpiEluXJJ/jL
 50BPaI+LO14BRSOhl9ciTR2g5BDqn6ppDwsyG0H/n9Db5ZTh+G0Lh4i+PwJNRiLMSPw/
 V9WA==
X-Gm-Message-State: AOAM530Bc/Tc6aAmznc26heuwQ7SPNSdXKBWnt/wdNll+Tkh+6bmfag7
 vEsGA9pV2JFe5YoMnABQQ+FKbA==
X-Google-Smtp-Source: ABdhPJzIs8hTLztUjiDoh78mr4hOo7pek1hrPgd5bVCfeiCLQexgpwtMxfq7+czidzCd0A+vIMG+mg==
X-Received: by 2002:a05:622a:1a1c:: with SMTP id
 f28mr13416941qtb.346.1633099853922; 
 Fri, 01 Oct 2021 07:50:53 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129])
 by smtp.gmail.com with ESMTPSA id i20sm3149803qke.102.2021.10.01.07.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Oct 2021 07:50:53 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mWJsC-008ctY-Nj; Fri, 01 Oct 2021 11:50:52 -0300
Date: Fri, 1 Oct 2021 11:50:52 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Oded Gabbay <ogabbay@kernel.org>
Cc: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Gal Pressman <galpress@amazon.com>,
 Yossi Leybovich <sleybo@amazon.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 linux-rdma <linux-rdma@vger.kernel.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Doug Ledford <dledford@redhat.com>, Dave Airlie <airlied@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Leon Romanovsky <leonro@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Tomer Tayar <ttayar@habana.ai>
Subject: Re: [PATCH v6 2/2] habanalabs: add support for dma-buf exporter
Message-ID: <20211001145052.GO3544071@ziepe.ca>
References: <20210912165309.98695-1-ogabbay@kernel.org>
 <20210912165309.98695-3-ogabbay@kernel.org>
 <20210928173621.GG3544071@ziepe.ca>
 <CAFCwf10z-baRm8c-UD_=jcZYD0VAGrMiNo7Q5Fm-2txYmVWGcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf10z-baRm8c-UD_=jcZYD0VAGrMiNo7Q5Fm-2txYmVWGcQ@mail.gmail.com>
X-Mailman-Approved-At: Fri, 01 Oct 2021 14:52:37 +0000
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

On Wed, Sep 29, 2021 at 12:17:35AM +0300, Oded Gabbay wrote:
> On Tue, Sep 28, 2021 at 8:36 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Sun, Sep 12, 2021 at 07:53:09PM +0300, Oded Gabbay wrote:
> > > From: Tomer Tayar <ttayar@habana.ai>
> > >
> > > Implement the calls to the dma-buf kernel api to create a dma-buf
> > > object backed by FD.
> > >
> > > We block the option to mmap the DMA-BUF object because we don't support
> > > DIRECT_IO and implicit P2P.
> >
> > This statement doesn't make sense, you can mmap your dmabuf if you
> > like. All dmabuf mmaps are supposed to set the special bit/etc to
> > exclude them from get_user_pages() anyhow - and since this is BAR
> > memory not struct page memory this driver would be doing it anyhow.
> >
> But we block mmap the dmabuf fd from user-space.
> If you try to do it, you will get MAP_FAILED.

You do, I'm saying the above paragraph explaining *why* that was done
is not correct.

> > > We check the p2p distance using pci_p2pdma_distance_many() and refusing
> > > to map dmabuf in case the distance doesn't allow p2p.
> >
> > Does this actually allow the p2p transfer for your intended use cases?
>
> It depends on the system. If we are working bare-metal, then yes, it allows.
> If inside a VM, then no. The virtualized root complex is not
> white-listed and the kernel can't know the distance.
> But I remember you asked me to add this check, in v3 of the review IIRC.
> I don't mind removing this check if you don't object.

Yes, i tis the right code, I was curious how far along things have
gotten

> > Don't write to the kernel log from user space triggered actions
> at all ?

At all.

> It's the first time I hear about this limitation...

Oh? It is a security issue, we don't want to allow userspace to DOS
the kerne logging.

> How do you tell the user it has done something wrong ?

dev_dbg is the usual way and then users doing debugging can opt in to
the logging.


> > Why doesn't this return a sg_table * and an ERR_PTR?
> Basically I modeled this function after amdgpu_vram_mgr_alloc_sgt()
> And in that function they also return int and pass the sg_table as **
> 
> If it's critical I can change.

Please follow the normal kernel style

Jason

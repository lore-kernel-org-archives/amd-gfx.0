Return-Path: <SRS0=0Dgm=LQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B8CC48BE5
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 17:14:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0838060C41
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 17:14:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0838060C41
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 770AE6E83E;
	Tue, 22 Jun 2021 17:14:00 +0000 (UTC)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31B926E1D3
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jun 2021 15:11:45 +0000 (UTC)
Received: by mail-qt1-x835.google.com with SMTP id c22so8699025qtn.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jun 2021 08:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=GfBcan5Oq/+F6rqd3wteDDUo+4mA0t9y3pSH6r/kVdI=;
 b=oQKSqDMY5ui7ysN6RXa17KyJ2Wzpm89WOS/VTDpLsBMmjFt0xKup1/rN3Iu2Ysn7kj
 0o4QpiviU+XCzwAjOmd3ASe2G50DR4wQM1cxJ/IcnSoJE+UREjasIpFci4SAI/zjLeO4
 BaVYbbQSqm0nAX/Y00oQm+1Fl/s1cHNEiBtnrRSnwG+/c0ZPfPFGw36xuMKNGuUPMk6/
 S9czK9NLULrCof4fVnQi6scmnRJl9iMhmlDxM2xpQloNB9qi5QwwBnyh0jFdiD4S4nEx
 BNdzQik55X4yiVc76B5/N6HeFax4G1G02Yo0H2X2M1eLLt5C2jCamVulCHYNUMYd6Nkl
 GXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GfBcan5Oq/+F6rqd3wteDDUo+4mA0t9y3pSH6r/kVdI=;
 b=AthMBv+jb+hfpvsd5Rmb0R3E8BxwbjorJuInMIsEZ7F5LFY60Tt3LmZGvfl70lucHV
 uakdL0X71iiP3M3Pb13TceCict7kRrsI7E8JAUVhTa+ln0ulgToUqvwUY1QuHoeNc0uc
 FNHxBCo/froC+a2tm1JW3NybN29C4fJ3iF/C/r+iJmOYrKl89TXP6aU7a1oQ75ikisdE
 Wa7mCop3qH0KK34wMdRPsYopvFd1HZ7lx3AMHj2s9rTzAldD7ALOfUj+NX4lLBx+lPkZ
 VpVGWb6GPDKHDwcOIXTyLLAt57j5jFnk89TOO6mDWdU+6KIDQFy/fd9XflGdbcejf+Rr
 yLZA==
X-Gm-Message-State: AOAM530z8HEADYvLBK6tCsugVazsRwMhOtdvnJpPYWMwW9b4u3ygaMZb
 QDLGbrtQ6C2Q9cdRsypxvKEBtA==
X-Google-Smtp-Source: ABdhPJyIvo3ZVkwIuidF8Fxvcg1uTF/rMIUzGf5xwZlLSDUGqkiRqy7l/P12S4XnoNrAjy14Ik1xNg==
X-Received: by 2002:ac8:5dd2:: with SMTP id e18mr3979783qtx.263.1624374704154; 
 Tue, 22 Jun 2021 08:11:44 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [47.55.113.94])
 by smtp.gmail.com with ESMTPSA id m3sm10504480qkk.27.2021.06.22.08.11.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jun 2021 08:11:43 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1lvi3y-00AD4o-Si; Tue, 22 Jun 2021 12:11:42 -0300
Date: Tue, 22 Jun 2021 12:11:42 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Oded Gabbay <oded.gabbay@gmail.com>
Subject: Re: [Linaro-mm-sig] [PATCH v3 1/2] habanalabs: define uAPI to export
 FD for DMA-BUF
Message-ID: <20210622151142.GA2431880@ziepe.ca>
References: <20210621175511.GI1096940@ziepe.ca>
 <CAKMK7uEO1_B59DtM7N2g7kkH7pYtLM_WAkn+0f3FU3ps=XEjZQ@mail.gmail.com>
 <CAFCwf11jOnewkbLuxUESswCJpyo7C0ovZj80UrnwUOZkPv2JYQ@mail.gmail.com>
 <20210621232912.GK1096940@ziepe.ca>
 <d358c740-fd3a-9ecd-7001-676e2cb44ec9@gmail.com>
 <CAFCwf11h_Nj_GEdCdeTzO5jgr-Y9em+W-v_pYUfz64i5Ac25yg@mail.gmail.com>
 <20210622120142.GL1096940@ziepe.ca>
 <CAFCwf10GmBjeJAFp0uJsMLiv-8HWAR==RqV9ZdMQz+iW9XWdTA@mail.gmail.com>
 <20210622121546.GN1096940@ziepe.ca>
 <CAFCwf13BuS+U3Pko_62hFPuvZPG26HQXuu-cxPmcADNPO22g9g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFCwf13BuS+U3Pko_62hFPuvZPG26HQXuu-cxPmcADNPO22g9g@mail.gmail.com>
X-Mailman-Approved-At: Tue, 22 Jun 2021 17:13:59 +0000
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
Cc: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 linux-rdma <linux-rdma@vger.kernel.org>,
 Christian =?utf-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>,
 sleybo@amazon.com, Gal Pressman <galpress@amazon.com>,
 dri-devel <dri-devel@lists.freedesktop.org>, Christoph Hellwig <hch@lst.de>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Doug Ledford <dledford@redhat.com>, Tomer Tayar <ttayar@habana.ai>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Greg KH <gregkh@linuxfoundation.org>, Alex Deucher <alexander.deucher@amd.com>,
 Leon Romanovsky <leonro@nvidia.com>, Oded Gabbay <ogabbay@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jun 22, 2021 at 04:12:26PM +0300, Oded Gabbay wrote:

> > 1) Setting sg_page to NULL
> > 2) 'mapping' pages for P2P DMA without going through the iommu
> > 3) Allowing P2P DMA without using the p2p dma API to validate that it
> >    can work at all in the first place.
> >
> > All of these result in functional bugs in certain system
> > configurations.
> >
> > Jason
> 
> Hi Jason,
> Thanks for the feedback.
> Regarding point 1, why is that a problem if we disable the option to
> mmap the dma-buf from user-space ? 

Userspace has nothing to do with needing struct pages or not

Point 1 and 2 mostly go together, you supporting the iommu is not nice
if you dont have struct pages.

You should study Logan's patches I pointed you at as they are solving
exactly this problem.

> In addition, I didn't see any problem with sg_page being NULL in the
> RDMA p2p dma-buf code. Did I miss something here ?

No, the design of the dmabuf requires the exporter to do the dma maps
and so it is only the exporter that is wrong to omit all the iommu and
p2p logic.

RDMA is OK today only because nobody has implemented dma buf support
in rxe/si - mainly because the only implementations of exporters don't
set the struct page and are thus buggy.

> I will take two GAUDI devices and use one as an exporter and one as an
> importer. I want to see that the solution works end-to-end, with real
> device DMA from importer to exporter.

I can tell you it doesn't. Stuffing physical addresses directly into
the sg list doesn't involve any of the IOMMU code so any configuration
that requires IOMMU page table setup will not work.

Jason
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

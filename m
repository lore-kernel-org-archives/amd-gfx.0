Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D930C4743C
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 15:27:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C407861042
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 15:27:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C407861042
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 871066E1DE;
	Mon, 21 Jun 2021 15:27:10 +0000 (UTC)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5DEF6E198
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 14:49:50 +0000 (UTC)
Received: by mail-qt1-x832.google.com with SMTP id x21so4407326qtq.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 07:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=7EhCVDJi9/mtNith6sHIuVtzdsDVwMIUM7u21aSrhMw=;
 b=pMj9icezCyVPhAoUcyIC4hXg8iF9vNR6ki/LwTLTUx9T50dBy/aY+JIQc2BM9Hz1/z
 JkL9Jm7F3sTwTj1cBu4VqQ0lfWp+QeZb+UHm3PoPx1trXAkMT1LHeTAZ6a272Hh7Cypf
 IolYhYiuvw6yY/3OnYlCLxHAyGeUoFVQKeTwptIxn6w6eA5jjABocMAs4na9+zV2VW5T
 rz9L38LXMzbPG5+9/L86DpSMJOUqS31ppQLS8vlTPUn6gfpb9oKUdfcwayMnbRDQquI9
 O2qE291+F/7jfBsLM1X67J41Z4Pn6F3VqTRzoFIhrsTP3dOflNs6XlBQ7VQiN7wGxWNO
 b1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7EhCVDJi9/mtNith6sHIuVtzdsDVwMIUM7u21aSrhMw=;
 b=hGvtvXIQCL9pAflHn7AvNlotCajS8YcQ8AsVRay9ei92rnWj/ic81/6yOvq1CT/y6o
 Zv7+pfF1LsyK/nVq5JfDpDY6P9N2/xNm7pSeD1VLGpawXkmsQ/CsFz0w1+EMWVcfUy9l
 H7uYe6Wu4VynoxLLmmLYU/0o3iRj8S3GTDvcSJQc6rIj9ULi0bSgTY5ggJXBJIkW0m/O
 WBT2XocnszvYmA3OoCKLqHS4TTO550G7uV02fcx3TsKmNZSnajoGmCk6ETVP0ziPPQLQ
 ErC575Viksm03h/eX+3RabbKNnwMoHo5u3j1hJ3rKgHbrp2QaczUG8UbgcQ5XvJNiQ3x
 KDfQ==
X-Gm-Message-State: AOAM530UI5N4ELKZJO4fDay/cNsiguCShS9SW6mqcRygxIkgumS5BRHh
 BTjiJBGZa2EOPdKWTlrB7uXJTg==
X-Google-Smtp-Source: ABdhPJyQ783oDw7ztSH9iUqFrEniMfq/XeByphnoK7SGzg/3oOO5hx+wfM7vN3NxmC0psXJAIBTnIQ==
X-Received: by 2002:ac8:4d84:: with SMTP id a4mr24377635qtw.319.1624286989919; 
 Mon, 21 Jun 2021 07:49:49 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [47.55.113.94])
 by smtp.gmail.com with ESMTPSA id 186sm4426217qkf.29.2021.06.21.07.49.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jun 2021 07:49:49 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1lvLFE-009XIx-Pt; Mon, 21 Jun 2021 11:49:48 -0300
Date: Mon, 21 Jun 2021 11:49:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Greg KH <gregkh@linuxfoundation.org>, Oded Gabbay <ogabbay@kernel.org>,
 linux-rdma <linux-rdma@vger.kernel.org>,
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>,
 Doug Ledford <dledford@redhat.com>,
 "airlied@gmail.com" <airlied@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Gal Pressman <galpress@amazon.com>, sleybo@amazon.com,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Tomer Tayar <ttayar@habana.ai>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Leon Romanovsky <leonro@nvidia.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 1/2] habanalabs: define uAPI to export FD for DMA-BUF
Message-ID: <20210621144948.GG1096940@ziepe.ca>
References: <20210618123615.11456-1-ogabbay@kernel.org>
 <CAKMK7uFOfoxbD2Z5mb-qHFnUe5rObGKQ6Ygh--HSH9M=9bziGg@mail.gmail.com>
 <YNCN0ulL6DQiRJaB@kroah.com> <YNCgM1svqKGUhcFY@phenom.ffwll.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YNCgM1svqKGUhcFY@phenom.ffwll.local>
X-Mailman-Approved-At: Mon, 21 Jun 2021 15:27:10 +0000
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jun 21, 2021 at 04:20:35PM +0200, Daniel Vetter wrote:

> Also unless we're actually doing this properly there's zero incentive for
> me to review the kernel code and check whether it follows the rules
> correctly, so you have excellent chances that you just break the rules.
> And dma_buf/fence are tricky enough that you pretty much guaranteed to
> break the rules if you're not involved in the discussions. Just now we
> have a big one where everyone involved (who's been doing this for 10+
> years all at least) realizes we've fucked up big time.

This is where I come from on dmabuf, it is fiendishly
complicated. Don't use it unless you absoultely have to, are in DRM,
and have people like Daniel helping to make sure you use it right.

It's whole premise and design is compromised by specialty historical
implementation choices on the GPU side.

Jason
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

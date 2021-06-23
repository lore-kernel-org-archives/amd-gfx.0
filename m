Return-Path: <SRS0=QFXE=LS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA40C49EA5
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Jun 2021 07:06:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8C00613E0
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Jun 2021 07:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8C00613E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4F3B6E9F6;
	Thu, 24 Jun 2021 07:06:12 +0000 (UTC)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37A006E977
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jun 2021 18:50:47 +0000 (UTC)
Received: by mail-qk1-x72b.google.com with SMTP id w21so7734590qkb.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jun 2021 11:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=A9I072mZJre1TS+IQKbZNgSu5AaMK7P2E0lmk7a57z4=;
 b=b5e3Vs0J8hbfUScY+Wtfo2QnoFw5zQRvSxFua4X+zv6sZmqniXxjtckK2oI0DJ0jKp
 +FpDq4XgR5FvYz5KhFDvESo6/vvn5bGvgGZWSgiYdS8/PfbLxpaqI3o9lhVUAZxmPK5T
 nDlzhXlXLqlvJVTPQVPebRcUOY8aDMfSl2n44EWIYFP7pJbCLgzg7CgH7naHE97q6TC2
 fZXUfMee0Dfy9rvfoVtazaR6R+Q7ESYAYIdPD2TcTnMWbmqWi3fqt48BxyEAqBINSR6Y
 /GKjFQQmTzpnkbtvp/1Ez+q16SM92SVKit9WzRj/wJHNz3K/lD3bYob3W0EWe1zfdvXM
 mlxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=A9I072mZJre1TS+IQKbZNgSu5AaMK7P2E0lmk7a57z4=;
 b=e0CEJyE5Xw+GmZnrh1lawrszS8x0XHb1ly6DzuKVD2Cq2NC7bnIcHb6LKRIHrcCOMs
 iBHS4VA/ZiYBZ28TCriY2tORHJes0gVA+V6Dlf8fiyckORi+vFmVxzYHi9l3Mbwb4gcg
 0DWlx6XT5qLysr6uwjXvHe3YcrBz4DgUr6RYvH21jNc7tUYR4ypK4BG3ddDojKJEA0Pg
 Yf/WJ/ZymTCs7CbB4jgNXhcB5ysQ0fQO2Gu4G6CQvLAQLwLCT2FUN2EteDA8MfhZkNPw
 5emOFXnHg5c2MCR38xMUR+UHpnWEBK6jHhQGMS6ABMXHStnSMxsaFO9QhiVDSXGyvoTX
 X9mg==
X-Gm-Message-State: AOAM533ZH1aFFZjEzt7GXhlqyBNvNsDA9UyyLyVugspMDdOoEo0PPu3i
 EpVSSBLq4NHPCe/pGWphFKU4ug==
X-Google-Smtp-Source: ABdhPJy26aLIQNDGYzv9yUWJkE1S7Ng46xlnu9FBhglctMci0BMRl57bB82kjnJJ4TuniXpuKS76ig==
X-Received: by 2002:a37:5cc6:: with SMTP id q189mr1519218qkb.305.1624474246361; 
 Wed, 23 Jun 2021 11:50:46 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [47.55.113.94])
 by smtp.gmail.com with ESMTPSA id y18sm503840qtx.6.2021.06.23.11.50.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jun 2021 11:50:45 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1lw7xV-00Blq0-8k; Wed, 23 Jun 2021 15:50:45 -0300
Date: Wed, 23 Jun 2021 15:50:45 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Oded Gabbay <oded.gabbay@gmail.com>
Subject: Re: [Linaro-mm-sig] [PATCH v3 1/2] habanalabs: define uAPI to export
 FD for DMA-BUF
Message-ID: <20210623185045.GY1096940@ziepe.ca>
References: <20210622120142.GL1096940@ziepe.ca>
 <d497b0a2-897e-adff-295c-cf0f4ff93cb4@amd.com>
 <20210622152343.GO1096940@ziepe.ca>
 <3fabe8b7-7174-bf49-5ffe-26db30968a27@amd.com>
 <20210622154027.GS1096940@ziepe.ca>
 <09df4a03-d99c-3949-05b2-8b49c71a109e@amd.com>
 <20210622160538.GT1096940@ziepe.ca>
 <d600a638-9e55-6249-b574-0986cd5cea1e@gmail.com>
 <20210623182435.GX1096940@ziepe.ca>
 <CAFCwf111O0_YB_tixzEUmaKpGAHMNvMaOes2AfMD4x68Am4Yyg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFCwf111O0_YB_tixzEUmaKpGAHMNvMaOes2AfMD4x68Am4Yyg@mail.gmail.com>
X-Mailman-Approved-At: Thu, 24 Jun 2021 07:06:12 +0000
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
Cc: linux-rdma <linux-rdma@vger.kernel.org>,
 Christian =?utf-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>,
 sleybo@amazon.com, Leon Romanovsky <leonro@nvidia.com>,
 Gal Pressman <galpress@amazon.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Doug Ledford <dledford@redhat.com>, Tomer Tayar <ttayar@habana.ai>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Greg KH <gregkh@linuxfoundation.org>, Alex Deucher <alexander.deucher@amd.com>,
 Christoph Hellwig <hch@lst.de>, Oded Gabbay <ogabbay@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jun 23, 2021 at 09:43:04PM +0300, Oded Gabbay wrote:

> Can you please explain why it is so important to (allow) access them
> through the CPU ?

It is not so much important, as it reflects significant design choices
that are already tightly baked into alot of our stacks. 

A SGL is CPU accessible by design - that is baked into this thing and
places all over the place assume it. Even in RDMA we have
RXE/SWI/HFI1/qib that might want to use the CPU side (grep for sg_page
to see)

So, the thing at the top of the stack - in this case the gaudi driver
- simply can't assume what the rest of the stack is going to do and
omit the CPU side. It breaks everything.

Logan's patch series is the most fully developed way out of this
predicament so far.

> The whole purpose is that the other device accesses my device,
> bypassing the CPU.

Sure, but you don't know that will happen, or if it is even possible
in any given system configuration. The purpose is to allow for that
optimization when possible, not exclude CPU based approaches.

Jason
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
